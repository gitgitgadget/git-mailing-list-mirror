Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46EF71F404
	for <e@80x24.org>; Fri,  7 Sep 2018 23:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeIHEjG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 00:39:06 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:33381 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHEjG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 00:39:06 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180907235543.GHOJ4101.fed1rmfepo101.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Fri, 7 Sep 2018 19:55:43 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id Ynvh1y00U59yGBo01nviWP; Fri, 07 Sep 2018 19:55:42 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5B930FFE.0056,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=J77a1EvS c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=ybZZDoGAAAAA:8 a=l6RwnnzsU7YB_JzhaMUA:9 a=a5-f_RoHxf0LhE8d:21
 a=1QICE4kwK7W7j7Q1:21 a=CjuIK1q_8ugA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 9A20629A0115;
        Fri,  7 Sep 2018 16:55:41 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
Date:   Fri, 07 Sep 2018 16:55:41 -0700
Message-ID: <1827990.xjSgEIESZI@thunderbird>
Organization: Personal
References: <20180906005329.11277-1-ischis2@cox.net> <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, September 7, 2018 3:31:55 PM MST you wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> The patch is mostly for illustration of the idea.
> 
> The result seems to compile and pass the test suite, but I haven't
> carefully thought about what else I may be breaking with this
> mechanical change.  For example, I noticed that both of the old
> callsites of wt_status_get_state() have free() of a few fiedls in
> the structure, and I kept the code as close to the original, but I
> suspect they should not be freed there in the functions in the
> "print" phase, but rather the caller of the "collect" and "print"
> should be made responsible for deciding when to dispose the entire
> wt_status (and wt_status_state as part of it).  This illustration
> patch does not address that kind of details (yet).

If we use this as a basis of a follow on patch, how do I handle credit.   You 
obviously wrote this patch and I did not.

So how is the mechanics of that normally done?   Thanks for the patch I will 
work with it.

sps


