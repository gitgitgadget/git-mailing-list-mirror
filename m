From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: query for recent changes that could lead to problems with gits
	index?
Date: Tue, 2 Mar 2010 22:15:19 +0100
Message-ID: <20100302211518.GB37152@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 22:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmZR7-00074y-Nr
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0CBVPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 16:15:20 -0500
Received: from darksea.de ([83.133.111.250]:38453 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752151Ab0CBVPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 16:15:20 -0500
Received: (qmail 14167 invoked from network); 2 Mar 2010 22:15:17 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 Mar 2010 22:15:17 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141415>

Hi,

some of my users have recently experienced strange problems with the
index since 1.7.0. It is msysgit on windows but seems to be more generic
to me. Unfortunately we were not able to reproduce the failures.

Problem 1: User experiences strange behavior with staging files. I was
puzzled until I found out that there was a double file entry in some
recent trees. git ls-tree showed something like this:

... fileA
... fileB
... treeA
... treeA
... treeB
..

and git gc complained about it. There where non-ascii filenames involved
in the changes.

Problem 2: Today a user asked me why a change he was only seeing in git
blame marked as "working tree" does not show up in git gui nor gitk.  A
restart of both tools did not help. I took a brief look was puzzled and
a 'git reset' resolved the issue. Unfortunately I did not take a look at
the output of git status.

My question: Does anyone know recent changes (or situations) that could
lead to such behavior?

cheers Heiko
