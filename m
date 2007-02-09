From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] log --reflog: use dwim_log
Date: Thu, 08 Feb 2007 19:43:30 -0800
Message-ID: <7vtzxwuhb1.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
	<Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<eqfu36$lb3$1@sea.gmane.org>
	<Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vveicw850.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702090127510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 04:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFMfg-0007DH-Pp
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 04:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946054AbXBIDnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 22:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946075AbXBIDnc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 22:43:32 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35446 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946054AbXBIDnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 22:43:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209034331.HNHL21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 22:43:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MFjW1W00E1kojtg0000000; Thu, 08 Feb 2007 22:43:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702090127510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 9 Feb 2007 01:28:23 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39152>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since "git log origin/master" uses dwim_log() to match
> "refs/remotes/origin/master", it makes sense to do that for
> "git log --reflog", too.

This is a bit sad.

When there is remotes/origin/HEAD symref that points at
remotes/origin/master (and usually there is, in a repository
initialized with the current git-clone), you can say "git log
origin".  Even with this patch, I do not think dwim_log would
allow you to say "git log -g origin" to mean "git log -g
origin/master".
