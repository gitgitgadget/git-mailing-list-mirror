Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156EA200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeEGPFr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 7 May 2018 11:05:47 -0400
Received: from mail.1eanda.com ([50.241.99.154]:48381 "EHLO mail.1eanda.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbeEGPFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:05:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.1eanda.com (Postfix) with ESMTP id AA64540242;
        Mon,  7 May 2018 11:05:43 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at mail.1eanda.com
Received: from mail.1eanda.com ([127.0.0.1])
        by localhost (mail.1eanda.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IlRICDOEjCHu; Mon,  7 May 2018 11:05:42 -0400 (EDT)
Received: from [10.134.3.27] (50-241-99-157-static.hfc.comcastbusiness.net [50.241.99.157])
        (Authenticated sender: matt@1eanda.com)
        by mail.1eanda.com (Postfix) with ESMTPSA id AB66340213;
        Mon,  7 May 2018 11:05:42 -0400 (EDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached
 --options
From:   Matthew Coleman <matt@1eanda.com>
In-Reply-To: <xmqqh8o9l7n4.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 7 May 2018 11:05:41 -0400
Cc:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
X-Mao-Original-Outgoing-Id: 547398341.227332-f85ad001747d528f255d857e2209423c
Content-Transfer-Encoding: 8BIT
Message-Id: <21289682-5B46-4131-B7D7-57CE9F391B9D@1eanda.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
 <xmqqh8o9l7n4.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't seen any discussion about this recently. What are the chances of getting it merged? I'd like to see this included in 2.18.

>> To get the names of all '$__git_builtin_*' variables caching --options
>> of builtin commands in order to unset them, 8b0eaa41f2 (completion:
>> clear cached --options when sourcing the completion script,
>> 2018-03-22) runs a 'set |sed s///' pipeline.  This works both in Bash
>> and in ZSH, but has a higher than necessary overhead with the extra
>> processes.
>> 
>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>> builtin command, which lists the same variables, but without a
>> pipeline and 'sed' it can do so with lower overhead.
>> ZSH will still continue to run that pipeline.
>> 
>> This change also happens to work around an issue in the default Bash
>> ...
>> Updated the commit message to explicitly mention that ZSH is
>> unaffected.  The patch is the same.
> 
> Thanks.

