From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 0/4] Proposed patches
Date: Thu, 19 Jun 2008 22:41:53 +0100
Message-ID: <20080619214023.27794.97039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ruh-0005eT-7j
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYFSVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYFSVl6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:41:58 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:51129 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751259AbYFSVl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 17:41:57 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080619214630.KMZR7070.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Thu, 19 Jun 2008 22:46:30 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080619215130.ESIW8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Thu, 19 Jun 2008 22:51:30 +0100
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85541>

A short series of proposed patches for merging into the StGIT master
branch. The most important is the new patch identification scheme.

---

Catalin Marinas (4):
      Remove the applied/unapplied commands
      Convert git_id() to the new id format
      Implement a new patch identification scheme and id command
      Allow e-mails to be sent with the Unix sendmail tool


 examples/gitconfig          |    1 
 stgit/commands/applied.py   |   51 --------------------
 stgit/commands/common.py    |  107 +++++++++++++++----------------------------
 stgit/commands/diff.py      |   21 ++++----
 stgit/commands/files.py     |   10 ++--
 stgit/commands/id.py        |   28 +++++------
 stgit/commands/mail.py      |   54 +++++++++++++++-------
 stgit/commands/pick.py      |   10 ++--
 stgit/commands/refresh.py   |    4 +-
 stgit/commands/series.py    |   17 +++++--
 stgit/commands/unapplied.py |   50 --------------------
 stgit/config.py             |    2 -
 stgit/lib/git.py            |    4 +-
 stgit/main.py               |    4 --
 t/t0001-subdir-branches.sh  |   24 ++++------
 t/t1002-branch-clone.sh     |    6 +-
 t/t1003-new.sh              |    4 +-
 t/t1200-push-modified.sh    |   14 +++---
 t/t1201-pull-trailing.sh    |    2 -
 t/t1203-pop.sh              |   12 ++---
 t/t1204-pop-keep.sh         |   12 ++---
 t/t1205-push-subdir.sh      |    4 +-
 t/t1301-repair.sh           |   12 ++---
 t/t1302-repair-interop.sh   |   20 ++++----
 t/t1500-float.sh            |   14 +++---
 t/t1600-delete-one.sh       |   28 ++++++-----
 t/t1601-delete-many.sh      |   24 +++++-----
 t/t2000-sync.sh             |   50 ++++++++++----------
 t/t2200-rebase.sh           |    6 +-
 t/t2500-clean.sh            |   12 ++---
 t/t2600-coalesce.sh         |   12 ++---
 t/t3000-dirty-merge.sh      |    8 ++-
 t/t4000-upgrade.sh          |    4 +-
 33 files changed, 256 insertions(+), 375 deletions(-)
 delete mode 100644 stgit/commands/applied.py
 delete mode 100644 stgit/commands/unapplied.py

-- 
Catalin
