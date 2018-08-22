Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACAB1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 05:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeHVJFs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 05:05:48 -0400
Received: from fed1rmwml113.cox.net ([68.230.241.20]:55192 "EHLO
        fed1rmwml113.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeHVJFs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 05:05:48 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 05:05:47 EDT
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180822053310.RUDV4167.fed1rmfepo201.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Wed, 22 Aug 2018 01:33:10 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id S5Z91y00J59yGBo015Z9hy; Wed, 22 Aug 2018 01:33:09 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090202.5B7CF596.0002,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=BN3DlBYG c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=WDhBSedXqNQA:10
 a=Wwin1D8M7IqKHWQcsKUA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 72EBC29A0091;
        Tue, 21 Aug 2018 22:33:09 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date:   Tue, 21 Aug 2018 22:33:09 -0700
Message-ID: <28440975.G22uFktzHy@thunderbird>
Organization: Personal
References: <72756249.nAoBccgOj7@thunderbird> <1455590305-30923-1-git-send-email-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, February 16, 2016 8:33:54 PM MST Junio C Hamano wrote:
> In fact, "commit --dry-run" is already broken without this "a merge
> ends up in a no-op" corner case.  The management of s->commitable
> flag and dry_run_commit() that uses it are unfortunately more broken
> than I originally thought.
> 
<snip>
> This function is only called from wt_status_print(), which in turn
> is only called from run_status() in commit.c when the status format
> is unspecified or set to STATUS_FORMAT_LONG.
> 
> So if you do this:
> 
>     $ git reset --hard HEAD
>     $ >a-new-file && git add a-new-file
>     $ git commit --dry-run --short; echo $?
> 
> you'd get "No, there is nothing interesting to commit", which is
> clearly bogus.

I was about to start working on working on this and ran the test you suggested 
back in 2016.   I don't get the error message from that time period.  I 
believe that this was fixed.   



