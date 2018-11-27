Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D53A1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 04:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeK0PGp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 10:06:45 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:58656 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeK0PGp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 10:06:45 -0500
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181127041012.FLRA4108.fed1rmfepo201.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Mon, 26 Nov 2018 23:10:12 -0500
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo305.cox.net with cox
        id 4sAB1z00a59yGBo01sAC1y; Mon, 26 Nov 2018 23:10:12 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090202.5BFCC3A4.0014,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=OPGTIhSB c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=JHtHm7312UAA:10 a=Z4Rwk6OoAAAA:8 a=5rxgeBVgAAAA:8
 a=vZxbLtyPAAAA:8 a=UFfKi-UbVXJV0W0Fx3cA:9 a=CjuIK1q_8ugA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 83528860065;
        Mon, 26 Nov 2018 21:10:11 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
Date:   Mon, 26 Nov 2018 21:10:10 -0700
Message-ID: <5263255.SQOp2klSmx@thunderbird>
In-Reply-To: <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan> <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday, July 7, 2018 3:02:35 PM MST Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> This adds --date=human, which skips the timezone if it matches the
> current time-zone, and doesn't print the whole date if that matches (ie
> skip printing year for dates that are "this year", but also skip the
> whole date itself if it's in the last few days and we can just say what
> weekday it was).

In the "What's cooking...." email response [1] there was some 
concern about what to call this format.

While the format is more useful to humans by dropping inferred information, 
there is nothing that makes it actually human.  Additionally, what 
one human considers a good format another may not like.  

In part of the V2 patch email[2], Linus notes that the patch reports 
relative dates based on information inferred from the date 
on the machine running the git command at the time the 
command is executed.   

If relative wasn't already taken that would be a reasonable 
choice instead of human.

Therefore keeping 'human' and documenting how the patch formats 
the date to suppress future "infinite" tweaks to the format seems 
like a a reasonable way to approach your concerns. [1]

I will start working the Doc's and test updates.   

On Wednesday, November 21, 2018 6:06:13 PM MST Junio C Hamano wrote:
> Command line completion;

I'm not quite sure what you want for this item.   Could you please describe?

sps

[1] https://public-inbox.org/git/xmqq8t1l6hve.fsf@gitster-ct.c.googlers.com/
[2] https://public-inbox.org/git/alpine.LFD.2.21.999.1807071502260.18818@i7.lan/


