From: linux@horizon.com
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: 25 Jun 2006 13:53:16 -0400
Message-ID: <20060625175316.26403.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Sun Jun 25 19:53:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuYnY-0000N3-8P
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 19:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWFYRxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWFYRxV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 13:53:21 -0400
Received: from science.horizon.com ([192.35.100.1]:8492 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751340AbWFYRxV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 13:53:21 -0400
Received: (qmail 26404 invoked by uid 1000); 25 Jun 2006 13:53:16 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22642>

How about a post-fetch hook script that can do this?  With an example
of either printing a message or repacking in the background?

procmail includes a lockfile(1) utility useful for shell scripts, but
it also wouldn't be hard to add a "git-lock-file <file> <command>..."
utility that would create the given lock file, fork the command, and
clean up again when it exited, relaying its exit status.
(I can write one if there's interest.)

I agree with Linus that *defaulting* to background repack has problems,
but it does seem useful to provide enough hooks to easily implement
the option.  Even printing the warning in a script seems like it would
simplify internationalization, and different sites (e.g. reiserfs
developers) might have different policies about what constitutes
"a boatload".
