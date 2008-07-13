From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 0/4] Proposed patches
Date: Sun, 13 Jul 2008 12:40:17 +0100
Message-ID: <20080713113853.18845.37686.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 13:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzxB-00069f-DG
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYGMLkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYGMLkX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:40:23 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:34811 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653AbYGMLkW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 07:40:22 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080713114637.CZOL16629.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sun, 13 Jul 2008 12:46:37 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080713114026.IDHZ18637.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>;
          Sun, 13 Jul 2008 12:40:26 +0100
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88300>

A new post of the proposed patches after implementing Karl's comments.

---

Catalin Marinas (4):
      Remove the applied/unapplied commands
      Convert git_id() to the new id format
      Implement a new patch identification scheme and id command
      Allow e-mails to be sent with the Unix sendmail tool


 examples/gitconfig          |    1 
 stgit/commands/applied.py   |   51 --------------------
 stgit/commands/common.py    |  109 +++++++++++++++----------------------------
 stgit/commands/diff.py      |   23 ++++-----
 stgit/commands/files.py     |   10 ++--
 stgit/commands/id.py        |   28 +++++------
 stgit/commands/mail.py      |   54 +++++++++++++++------
 stgit/commands/pick.py      |   10 ++--
 stgit/commands/refresh.py   |    4 +-
 stgit/commands/series.py    |   29 ++++++++---
 stgit/commands/unapplied.py |   50 --------------------
 stgit/lib/git.py            |    4 +-
 stgit/main.py               |    4 --
 t/t0001-subdir-branches.sh  |   24 ++++-----
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
 t/t1501-sink.sh             |    2 -
 t/t1600-delete-one.sh       |   28 ++++++-----
 t/t1601-delete-many.sh      |   24 +++++----
 t/t2000-sync.sh             |   50 ++++++++++----------
 t/t2200-rebase.sh           |    6 +-
 t/t2500-clean.sh            |   12 ++---
 t/t2600-coalesce.sh         |   12 ++---
 t/t3000-dirty-merge.sh      |    8 ++-
 t/t4000-upgrade.sh          |    4 +-
 33 files changed, 265 insertions(+), 382 deletions(-)
 delete mode 100644 stgit/commands/applied.py
 delete mode 100644 stgit/commands/unapplied.py

-- 
Catalin
