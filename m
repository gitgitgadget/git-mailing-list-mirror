From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/5] Builtin "git remote"
Date: Fri, 29 Feb 2008 01:44:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290144130.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 29 02:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuJs-00010U-Ev
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbYB2BpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYB2BpJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:45:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:53874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbYB2BpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:45:08 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:45:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 29 Feb 2008 02:45:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CXswYaZFCeo+UKVZpA+6D36e8K5oMbj7pj8RLyx
	kE5ZLO0FCi35Cq
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75486>


This patch series puts a few building blocks in place (the first three
patches), builds in "git remote", and fixes the current behaviour of
"git remote prune" when the remote was initialized with --mirror.

It incorporates Hannes Sixt's comments about checking remote_nr.

Oh, and in contrast to the earlier series, I removed the DWIM "git add
remote" patch.

It also demonstrates that format-patch --cover-letter should default to -M
for the diffstat (search for "git-remote.perl"...).

Johannes Schindelin (5):
      path-list: add functions to work with unsorted lists
      parseopt: add flag to stop on first non option
      Test "git remote show" and "git remote prune"
      Make git-remote a builtin
      builtin-remote: prune remotes correctly that were added with --mirror

 Makefile                         |    3 +-
 builtin-remote.c                 |  557 ++++++++++++++++++++++++++++++++++++++
 builtin.h                        |    1 +
 contrib/examples/git-remote.perl |  477 ++++++++++++++++++++++++++++++++
 git-remote.perl                  |  477 --------------------------------
 git.c                            |    1 +
 parse-options.c                  |    2 +
 parse-options.h                  |    1 +
 path-list.c                      |   30 ++
 path-list.h                      |    8 +-
 remote.c                         |    3 +-
 remote.h                         |    1 +
 t/t5505-remote.sh                |   50 ++++
 13 files changed, 1131 insertions(+), 480 deletions(-)
 create mode 100644 builtin-remote.c
 create mode 100755 contrib/examples/git-remote.perl
 delete mode 100755 git-remote.perl

