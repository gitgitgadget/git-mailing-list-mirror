From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 0/8] Python 3 support for git_remote_helpers
Date: Sun, 20 Jan 2013 13:15:30 +0000
Message-ID: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twul3-0002zQ-Lt
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab3ATNQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:00 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:39967 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:15:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 0672722F0B;
	Sun, 20 Jan 2013 13:15:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fEJDML5S8PBp; Sun, 20 Jan 2013 13:15:58 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id F423B22BF4;
	Sun, 20 Jan 2013 13:15:57 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E1597161E56B;
	Sun, 20 Jan 2013 13:15:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNAsjvF-WaHw; Sun, 20 Jan 2013 13:15:57 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 02428161E480;
	Sun, 20 Jan 2013 13:15:51 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214010>

This series does enough so that everything except git-p4 runs under
Python 3.
                                                                                 
As discussed with Pete, it may not make sense to change git-p4 to
support Python 3 until Perforce's Python output mode is changed.  So
does it make sense to merge this now and say "use Python 2 if you want
git-p4"?
                                                                                 
Changes since v2:

 - Change reference URL in commit message of patch 4
   (git_remote_helpers: Use 2to3 if building with Python 3) to point at
   Python documentation instead of the Python wiki.

 - Add a comment in patch 7 (git-remote-testpy: don't do unbuffered text
   I/O), as suggested by Sverre.


John Keeping (8):
  git_remote_helpers: Allow building with Python 3
  git_remote_helpers: fix input when running under Python 3
  git_remote_helpers: Force rebuild if python version changes
  git_remote_helpers: Use 2to3 if building with Python 3
  svn-fe: allow svnrdump_sim.py to run with Python 3
  git-remote-testpy: hash bytes explicitly
  git-remote-testpy: don't do unbuffered text I/O
  git-remote-testpy: call print as a function

 contrib/svn-fe/svnrdump_sim.py     |  4 ++--
 git-remote-testpy.py               | 46 +++++++++++++++++++++-----------------
 git_remote_helpers/.gitignore      |  1 +
 git_remote_helpers/Makefile        | 10 +++++++--
 git_remote_helpers/git/importer.py |  9 +++++---
 git_remote_helpers/setup.py        | 10 +++++++++
 6 files changed, 52 insertions(+), 28 deletions(-)

-- 
1.8.1.353.gc992d5a.dirty
