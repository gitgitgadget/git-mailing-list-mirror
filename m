From: Sven Joachim <svenjoac@gmx.de>
Subject: ambiguous argument '...': unknown revision or path not in the working tree
Date: Sun, 17 Jan 2010 10:46:15 +0100
Message-ID: <87ska5vzbs.fsf@turtle.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:47:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRio-0005gA-N1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab0AQJqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781Ab0AQJqS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:46:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:33737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753778Ab0AQJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:46:16 -0500
Received: (qmail invoked by alias); 17 Jan 2010 09:46:14 -0000
Received: from p548652F3.dip.t-dialin.net (EHLO turtle.gmx.de) [84.134.82.243]
  by mail.gmx.net (mp006) with SMTP; 17 Jan 2010 10:46:14 +0100
X-Authenticated: #28250155
X-Provags-ID: V01U2FsdGVkX19C5Ddl/eNCYBAunwxNLPcTUoBaJXIyzvzEjGrT9v
	PZ1eE+7XgihSl8
Received: by turtle.gmx.de (Postfix, from userid 1000)
	id 26A3F35545; Sun, 17 Jan 2010 10:46:15 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137290>

I've got a strange error message in 'git push':

,----
| % git push
| Counting objects: 47, done.
| Delta compression using up to 2 threads.
| Compressing objects: 100% (24/24), done.
| Writing objects: 100% (24/24), 4.37 KiB, done.
| Total 24 (delta 22), reused 0 (delta 0)
| fatal: ambiguous argument '3bbc6def8a06e4411bee130b811ff9507e90503d:debian/changelog': unknown revision or path not in the working tree.
| Use '--' to separate paths from revisions
| To git+ssh://git.debian.org/git/collab-maint/ncurses.git
|    2fec7db..3bbc6de  HEAD -> upstream
`----

Indeed debian/changelog is not in the working tree, it is not in the
current branch (upstream) at all, although it exists in the master
branch.  Default is to push the current branch:

,----
| % git config --get push.default 
| current
| % git --version
| git version 1.6.6
`----

Despite the error message, the push was apparently successful; the
repository I push to can be found at
http://git.debian.org/?p=collab-maint/ncurses.git.

Sven
