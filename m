X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-explain
Date: Tue, 05 Dec 2006 15:57:00 -0800
Message-ID: <7vu009dhgz.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
	<7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
	<7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
	<el3ibq$9kn$2@sea.gmane.org>
	<46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
	<7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612060033540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 23:57:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612060033540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 6 Dec 2006 00:37:52 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33390>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grk9r-0001n8-O9 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 00:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758148AbWLEX5E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 18:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758067AbWLEX5E
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 18:57:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64919 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758148AbWLEX5B (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 18:57:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205235701.YBWL20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 18:57:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vBxA1V00f1kojtg0000000; Tue, 05 Dec 2006
 18:57:11 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 5 Dec 2006, Junio C Hamano wrote:
>...
>> The current use of "git status" inside "git commit" needs to be revamped 
>> if we pursue this further, though.  Because one of the points the "what 
>> state is this repository in" check "explain" does is to define what 
>> operations are sensible in each state, and most likely in many state it 
>> would not make _any_ sense to run "git commit" (say, in the middle of 
>> "bisect").
>
> That is right, but it is only a matter of having a command line switch to 
> suppress what you do not need for the commit message. After all, "status" 
> really should tell you about the status of the working directory. The fact 
> that we have the _same_ script for "commit" and "status" is no excuse!

Sure.  The way I envisioned it was that we would have a moral
equivalent of current git-status output for explanation of the
base state.

I originally wanted to do "git oops" which would have been a
universal "undo" command, and "explain" was only the first
smaller step toward that goal.  But the more I think about it, I
feel that "undo" is less important.

