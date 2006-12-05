X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Diffs from CVS keyword expansion
Date: Tue, 05 Dec 2006 11:55:21 -0800
Message-ID: <7v64cqglsm.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
	<20061205121443.GB2428@cepheus> <86k616m8i9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 19:55:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86k616m8i9.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "05 Dec 2006 11:45:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33370>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrgOO-0000Ux-V1 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 20:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030815AbWLETz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 14:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbWLETz0
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 14:55:26 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46328 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030815AbWLETzY (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 14:55:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205195521.OUIH4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 14:55:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id v7vX1V00S1kojtg0000000; Tue, 05 Dec 2006
 14:55:32 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Uwe" == Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de> writes:
>
> Uwe> 	#! /bin/sh
> Uwe> 	exec perl -i -p -e 's/\$(Id|Revision):.*?\$/\$$1: \$/' "$@";
>
> Ow.  My eyes hurt from that.  How about we rewrite that as a native Perl
> script:
>
>     #!/usr/bin/perl
>     $^I = ""; # this is -i
>     while (<>) {
>       s/\$(Id|Revision):.*?\$/\$$1: \$/;
>       print;
>     }

That's kinda surprising coming from the resident Perl guru.

I am so used to the command line "-i -p" that I did not even
know what $^I does, and I would have lost without your "# this
is -i" comment.  That alone makes the Uwe's one more readable
for me ;-).
