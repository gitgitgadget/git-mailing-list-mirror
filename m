X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 13:55:08 -0800
Message-ID: <7vmz5oomdf.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612142255.33564.andyparkins@gmail.com>
	<7vk60uyrau.fsf@assigned-by-dhcp.cox.net>
	<200612150858.25988.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:56:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34564>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL2Q-0006er-0P for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965197AbWLOVzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWLOVzO
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52773 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965195AbWLOVzM (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215509.YKXP7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vL1V01A1kojtg0000000; Fri, 15 Dec 2006
 16:55:21 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2006 December 14 23:46, Junio C Hamano wrote:
> ...
>> I said "commit -b <newbranch>" and deliberately avoided saying
>> "commit -b <anybranch>", because I did not want to open another
>> can of worms while we are discussing so many good things
>> already, and my head can hold only a handful topics at once.
>
> Absolutely.  I'd agree that only <newbranch> is worth even considering.

Just for the record, I do not necessarily agree.  Committing a
small and obvious change out of context to an existing branch
makes just as much sense.

After all, with the example workflow in my message you responded
to, after running the "commit -b typofix" (which creates a new
branch) to record the first typo fix, I am sure that I would
want to record the second typofix I would find while on my topic
to go to the same typofix branch I previously created.

The 'can of worms' is that switching to an existing branch could
fail with conflicts.  Although "git checkout -m" can help
sometimes, that is not something we would want to do in the
middle of doing something else on a topic.  That's why I do not
think "commit -b <anybranch>" is a good idea.

Allowing the form for only a new branch makes an inconsistency
that is hard to explain to new people, and that is why I am not
in favor of having "commit -b <newbranch>" either.


