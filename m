X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Mon, 04 Dec 2006 17:08:27 -0800
Message-ID: <7v3b7vm9o4.fsf@assigned-by-dhcp.cox.net>
References: <200612040001.13640.jnareb@gmail.com>
	<200612041133.44816.jnareb@gmail.com>
	<7vmz64ortu.fsf@assigned-by-dhcp.cox.net>
	<200612041233.19377.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:08:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33275>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOnX-00058l-Qf for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967945AbWLEBIa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967946AbWLEBI3
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:08:29 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54970 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967945AbWLEBI2 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:08:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205010827.NLPT4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:08:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id up8d1V00B1kojtg0000000; Mon, 04 Dec 2006
 20:08:37 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> You might have sha1 ids in commit message which no longer point to valid 
> (existing) object, for example commit which is result of 
> "git cherry-pick -x" from no longer existing temporary branch, or commit 
> which is result of "git revert" on a branch which got rebased (but not 
> reorganized), or shortened sha1 which is no longer unique. This should 
> not cause errors to be written to webserver log.

True.

> By the way, is it better to use anonymous subroutines for committags 
> subs, or use explicit subroutines?

I vaguely recall a thread that discussed pros and cons of using
anonymous subroutines in certain parts of gitweb some time ago
in which even Merlyn had some comments in, but I do not recall
the technical details, sorry.  My gut feeling is that the way
you illustrated your example "our %committags" definition is
fine, but it _might_ turn out that it is easier for sites or for
projects to customize their own set of rewrite rules if you had
explicitly named subroutines available.  I dunno.
