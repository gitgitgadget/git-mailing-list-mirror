From: Peter Baumann <waste.manager@gmx.de>
Subject: git fetch inside a bare repo does nothing
Date: Fri, 13 Jul 2007 12:33:03 +0200
Message-ID: <20070713103303.GD18199@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 12:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9IRF-00066o-Um
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 12:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbXGMKbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 06:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbXGMKbu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 06:31:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:37920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753650AbXGMKbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 06:31:49 -0400
Received: (qmail invoked by alias); 13 Jul 2007 10:31:48 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp034) with SMTP; 13 Jul 2007 12:31:48 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19j2skKg6Rj/vNv8gD8MTA/d5tnPjmYTDW3ql5FlO
	K2YV7BQyxB5chX
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52382>

kblin on IRC wanted to know how to update a bare repo with fetching.
He wants to have a bare repo of samba as a mirror and clone from this
mirror to avoid network traffic and to have several git repos which
could all have a different branch checked out. For a better description
see [1].

I suggested to use "git fetch --bare" inside the bare repo, but this
doesn't work. So what I'm asking now if this is intenional behaviour or
a bug, so please could someone  shed some light on it?  Or how is the
prefered method to update a bare repo *without* pushing to it?

-Peter

[1]: http://wiki.samba.org/index.php/Using_Git_for_Samba_Development

IRC log (unneccessary comments removed):

11:30 < kblin> how do I update a branch I cloned with --bare?
11:31 < madduck> GIT_DIR=/path/to/dir git pull >
11:31 < madduck> ?
11:31 < madduck> without the >
11:32 < kblin> and for remote repositories, I'd use a URL?
11:37 < madduck> uh, you can't reallly "update" remote repositories in that sense
11:37 < madduck> what are you trying to do?
11:37 < madduck> let's have more info!
11:51 < kblin> madduck: I'm trying to follow http://wiki.samba.org/index.php/Using_Git_for_Samba_Development
11:52 < kblin> madduck: basically, I want to have a --bare repository that mirrors the remote repository
               and have a couple of working repositories for the different branches
11:57 < siprbaum> kblin: I think "git --bare fetch" inside your bare repo will solve your problem
[...]
12:01 < kblin> siprbaum: git --bare fetch doesn't seem to fetch anything new either
12:01 < siprbaum> perhaps there isn't anything new to fetch?
12:02 < siprbaum> but i'm just guessing here and reading the manpage (git) suggested that git --bare fetch _could_ work
12:02 < kblin> siprbaum: that'd surpise me. I've got a clone without the --bare, and that has a new commit
[...]
12:14 < siprbaum> kblin: and you are right. i just tried to fetch inside a bare repo and it doesn't work
