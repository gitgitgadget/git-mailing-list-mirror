X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 14:32:45 -0700
Message-ID: <7vslhcm682.fsf@assigned-by-dhcp.cox.net>
References: <45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<vpq4ptz2uh8.fsf@ecrins.imag.fr>
	<453DAC87.8050203@research.canon.com.au>
	<Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
	<Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
	<Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
	<20061025084810.GA26618@coredump.intra.peff.net>
	<7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
	<20061025211618.GA30121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 21:32:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061025211618.GA30121@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Oct 2006 17:16:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30103>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcqMm-0005LC-6T for gcvg-git@gmane.org; Wed, 25 Oct
 2006 23:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932295AbWJYVcs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWJYVcs
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 17:32:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22730 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S932295AbWJYVcr
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 17:32:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025213246.TBGX6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 17:32:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id elYV1V00L1kojtg0000000 Wed, 25 Oct 2006
 17:32:29 -0400
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Housing historical implementations seems like it would just lead to
> out-of-date and non-functional examples.

I agree.  Although that ought to be rare in principle, given
that one advertised feature of git is that the plumbing is
supposed to be stable, we occasionally had to have to subtly
break things to improve plumbing and at the same time run around
to make sure that all the script users (both in-tree and
out-of-tree like Cogito, gitweb and StGIT) are updated.

>>  - Learn the itches David and other people have, that the
>>    current git Porcelain-ish does not scratch well, and enrich
>>    Documentation/technical with real-world working scripts built
>>    around plumbing.
>
> I think this is a better approach. I think it also makes sense to
> let people know that it's an acceptable approach to start new features
> as shell and then have them mature to C (looking at the current
> codebase, and some of Dscho's rantings, one might get the impression
> that git isn't accepting new shell scripts).

New commands like pickaxe and for-each-ref were easier to code
in C, and cherry rewrite in C was really about how crufty the
shell script version was from the beginning (and there weren't
in-tree users of it left so it was not maintained at all but
thanks to plumbing being stable it just kept working perhaps
correctly but still horribly).
