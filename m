Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6291F404
	for <e@80x24.org>; Fri, 13 Apr 2018 03:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeDMDAl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 12 Apr 2018 23:00:41 -0400
Received: from mail.1eanda.com ([50.241.99.154]:35082 "EHLO mail.1eanda.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeDMDAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 23:00:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.1eanda.com (Postfix) with ESMTP id E05FD40242;
        Thu, 12 Apr 2018 23:00:38 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at mail.1eanda.com
Received: from mail.1eanda.com ([127.0.0.1])
        by localhost (mail.1eanda.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tCJwWfy_8faf; Thu, 12 Apr 2018 23:00:29 -0400 (EDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net [50.241.99.157])
        (Authenticated sender: matt@1eanda.com)
        by mail.1eanda.com (Postfix) with ESMTPSA id 1167740213;
        Thu, 12 Apr 2018 23:00:26 -0400 (EDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] specify encoding for sed command
From:   Matthew Coleman <matt@1eanda.com>
In-Reply-To: <20180413000105.21708-1-szeder.dev@gmail.com>
Date:   Thu, 12 Apr 2018 23:00:24 -0400
Cc:     Stephon Harris <theonestep4@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
X-Mao-Original-Outgoing-Id: 545281223.7657959-0dc7c40706bff669d2f045920024a10f
Content-Transfer-Encoding: 8BIT
Message-Id: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
 <DB5A1CE2-7844-4CB6-A03E-6AAC4EC13D66@gmail.com>
 <3FE7BFB6-769A-4F11-9C3B-86D681B3502F@gmail.com>
 <CBA1FB4A-C586-48E0-A64E-371CCD2F6AC4@1eanda.com>
 <20180413000105.21708-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I think the best way to move forward with this is a new patch that uses
>> `awk` instead of `sed`: I tested several `awk` variants and the command
>> was portable without requiring any changes to LANG or LC_ALL.
>> 
>> Does that sound like a good plan?
> 
> No ;)
> Could you please give the patch below a try?
Your patch works great and is clearly a way better approach than parsing the output of `set`.

> I'm just not sure whether we should burden this otherwise nice and short
> commit message with the details of this Powerline-macOS-Bash-sed issue...
It might be worth mentioning it briefly, in order to reduce the chances of a regression in the future. Maybe something like...
"In Bash we can do better: run the 'compgen -v __gitcomp_builtin_' builtin command, which lists the same variables, but without the risk of errors caused by poor Unicode handling in some shells' 'set' builtin command or the overhead of executing 'sed'."
