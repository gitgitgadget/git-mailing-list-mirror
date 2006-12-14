X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 12:41:37 -0800
Message-ID: <7vejr22ose.fsf@assigned-by-dhcp.cox.net>
References: <200612141519.44294.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:41:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34396>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxOh-0004EA-LR for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932903AbWLNUlk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWLNUlk
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:41:40 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61100 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932902AbWLNUlj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:41:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214204138.NYVF29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 15:41:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ykhp1V00w1kojtg0000000; Thu, 14 Dec 2006
 15:41:50 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> "master" shouldn't get special treatment

In principle yes.

However, the fmt-merge-message was designed so for a very
practical reason --- to keep Merge commit log messages Linus
makes in the kernel repository short and readable.

When your workflow is heavily based on merges from topics to
more than one maintenance tracks (say, 'maint' and 'master') and
the policy is to keep older maintenance tracks to be subsets of
newer maintenance tracks (e.g. changes applicable to an older
maintenance track are first merged into 'maint' and then 'maint'
is merged into 'master'), being able to see the patchflow is
sometimes handy [*1*].

I do not have issues against making git-status to always note
which branch the commit is going to be made, though.


[Footnote]

*1* Right now we do not have --only-merges option to log family,
so I use "show-branch maint master | grep '^ *-'" instead to get
this information.

