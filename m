X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Mon, 06 Nov 2006 23:07:40 -0800
Message-ID: <7vlkmn7n0j.fsf@assigned-by-dhcp.cox.net>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
	<7vd580azbb.fsf@assigned-by-dhcp.cox.net>
	<200611070225.24956.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 07:07:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611070225.24956.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 7 Nov 2006 02:25:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31049>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhL3h-00075o-AC for gcvg-git@gmane.org; Tue, 07 Nov
 2006 08:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753393AbWKGHHm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 02:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbWKGHHm
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 02:07:42 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29332 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1753393AbWKGHHl
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 02:07:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107070741.IPD13632.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 02:07:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jj7H1V00e1kojtg0000000; Tue, 07 Nov 2006
 02:07:18 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> Then "git checkout origin/next" would always mean "I want to
>> switch to the branch I use to hack on the branch 'next' Junio
>> has".  Do it once and you will get exactly my tip, hack on it,
>> switch out of it and then do it again and you won't lose your
>> previous work but just switch to that branch.
>
> Ah, now I understand your thinking.
> I admit it has a compelling elegance.
>
> However.
> Would it not be confusing for newbies (and not only for them) to
> first reference the remote branch with "origin/next", and afterwards, you
> get your own development branch by using the exactly same name?

In that example, the user types "git checkout origin/next".  I
do not think there is any confusion.

You come from git background from the era git checkout did _not_
have this magic (in other words, "today"), so you implicitly see
remotes/ prefixed in front of the "origin/next" string there.

But new people do not see remotes/ prefixed there.  To them, the
example command line says "Now I want to be on my 'origin/next'
branch", and there is nothing 'remote' about it.

The magic under discussion happens to create your 'origin/next'
branch automagically from 'remotes/origin/next' when it exists,
but that can be transparent to the user [*1*].

Well, your original magic did not propose it that way, but I
twisted it.

[Footnote]

*1* This is in line with what I wanted to say in my earlier "if
    I were redoing git from scratch" message when I talked about
    making "remotes" less visible.




