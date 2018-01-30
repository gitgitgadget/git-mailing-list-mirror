Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C7B1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 14:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeA3OZ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 09:25:27 -0500
Received: from smtpq1.mnd.mail.iss.as9143.net ([212.54.34.164]:48846 "EHLO
        smtpq1.mnd.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751660AbeA3OZ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Jan 2018 09:25:26 -0500
Received: from [212.54.34.116] (helo=smtp8.mnd.mail.iss.as9143.net)
        by smtpq1.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1egWqh-0001jQ-Tw
        for git@vger.kernel.org; Tue, 30 Jan 2018 15:25:23 +0100
Received: from 53544873.cm-6-5b.dynamic.ziggo.nl ([83.84.72.115] helo=jessiehernandez.com)
        by smtp8.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1egWqh-00078W-Sb
        for git@vger.kernel.org; Tue, 30 Jan 2018 15:25:23 +0100
Received: by jessiehernandez.com (Postfix, from userid 112)
        id B9C9A223F3; Tue, 30 Jan 2018 15:25:23 +0100 (CET)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 98E48223DE;
        Tue, 30 Jan 2018 15:25:04 +0100 (CET)
Received: from 217.150.190.17
        (SquirrelMail authenticated user pi)
        by mail.jessiehernandez.com with HTTP;
        Tue, 30 Jan 2018 15:25:04 +0100
Message-ID: <615c04025165d0dff9d6e6b66bf11a41.squirrel@mail.jessiehernandez.com>
Date:   Tue, 30 Jan 2018 15:25:04 +0100
Subject: Re: Creating sparse checkout in a new linked git worktree
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     git@jessiehernandez.com, "Git List" <git@vger.kernel.org>
Reply-To: git@jessiehernandez.co
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.72.115
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=HeM6sBM8 c=1 sm=1 tr=0 a=n+ob1Bm1t1G9OO4azozuvA==:17 a=8nJEP1OIZ-IA:10 a=RgaUWeydRksA:10 a=CdBCPKDxAAAA:8 a=M66tnWKMBTLaxiG1AIQA:9 a=wPNLvfGTeEIA:10 a=lDjxF1AZmdN7bNtopFhl:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jan 24, 2018 at 11:11 AM, Jessie Hernandez
> <git@jessiehernandez.com> wrote:
>> I am trying to get a sparse checkout in a linked worktree but cannot
get
>> it working. I have tried the following
>> * git worktree add /some/new/path/new-branch --no-checkout
>> * git config core.sparseCheckout true
>> * <add the directory I would like to checkout out to
>> $GIT_DIR/info/sparse-checkout>
>> * cd  /some/new/path/new-branch
>> * git read-tree -mu sparse-checkout
>> But I still end up with a fully populated worktree.
>> Is there something I am missing or doing wrong?
> The sparse-checkout file is specific to each worktree, which allows you
to control "sparsity" on a worktree by worktree basis. Therefore, you
should create $GIT_DIR/worktrees/<id>/info/sparse-checkout instead
(where <id> is "new-branch" in your example).

Right this seems to work indeed.
Thank you.

Would it help if this was added to the documentation of git-read-tree

Regards,
Jessie




