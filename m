Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4468F1F97E
	for <e@80x24.org>; Thu, 22 Nov 2018 02:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeKVMp3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 07:45:29 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:34060 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeKVMp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 07:45:29 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181122020821.RKGX4101.fed1rmfepo101.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 21 Nov 2018 21:08:21 -0500
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id 2q8M1z00C59yGBo01q8MG0; Wed, 21 Nov 2018 21:08:21 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5BF60F95.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=d81BNirE c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=JHtHm7312UAA:10 a=kviXuzpPAAAA:8 a=uW1bbcl1R1420tC0X4MA:9
 a=CjuIK1q_8ugA:10 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 22F55860067;
        Wed, 21 Nov 2018 19:08:21 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
Date:   Wed, 21 Nov 2018 19:08:21 -0700
Message-ID: <2775489.rJSdpldxyu@thunderbird>
In-Reply-To: <xmqq8t1l6hve.fsf@gitster-ct.c.googlers.com>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com> <1965413.u7ZHvrJggb@thunderbird> <xmqq8t1l6hve.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, November 21, 2018 6:06:13 PM MST Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> > On Wednesday, November 21, 2018 2:00:16 AM MST Junio C Hamano wrote:
> >> [Stalled]
> >> 
> >> * lt/date-human (2018-07-09) 1 commit
> >> 
> >>  - Add 'human' date format
> >>  
> >>  A new date format "--date=human" that morphs its output depending
> >>  on how far the time is from the current time has been introduced.
> >>  "--date=auto" can be used to use this new format when the output is
> >>  goint to the pager or to the terminal and otherwise the default
> >>  format.
> > 
> > What needs to be done with this patch to move it along?
> 
> In a random order as they come to my mind:
> 
>  - Support by people other than the original author;

I was trying to decide if you were wanting someone besides Linus to carry this 
through (knowing that he was unlikely to do so).   The idea seems reasonable 
to me.   I don't mind doing so if neither of you object.

> 
>  - Deciding what to call this (i.e. Linus's personal preference
>    would not be the only 'human' style, but we may declare it is
>    good enough as "a" human format, not "the" human format);
> 
>  - Some mechanism (either technical or documentation) to prevent
>    endless stream of "I like human output, but I'd tweak it slightly
>    this way" updates in the future;
> 
>  - Doc;
> 
>  - Command line completion;
> 
>  - Tests;
> 
>  - Waiting for the end of feature freeze before the upcoming
>    release.
> 
> There may be others, but without all of the above, I'd feel a bit
> uncomfortable.
> 
I wouldn't think this would go in now since the patch has been stalled for 
months.  It is also on the pu branch.  

> > I see that both Linus and Junio have signed the patch.
> 
> That does not assert that the code is desirable thing to add.  It
> just says we made sure that we legally have rights to include it, if
> we want to.

Picking up someones stalled patch is one thing, picking up Linus' patch is in 
a different league.



