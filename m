From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] A few small fixes
Date: Sun, 11 Nov 2007 20:43:24 +0100
Message-ID: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIij-0001KX-Pm
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbXKKTne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXKKTnd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:43:33 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3877 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbXKKTnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:43:33 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIiN-0004b3-00; Sun, 11 Nov 2007 19:43:28 +0000
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64500>

These are available from

  git://repo.or.cz/stgit/kha.git safe

The clean test and the assimilare/repair stuff are new, the rest have
been sitting in kha/safe for a while now.

David: I believe the repair patch should fix the situation you
encountered.

---

Note how the actual patch that renames assimilate to repair looks fine
-- I gave stg mail --diff-opts=3D'-M -C -C'. But the diffstats
apparently don't get those flags, neither the aggregate one below nor
the one just for that patch. We ought to fix that ...

Karl Hasselstr=C3=B6m (5):
      stg repair: Patchify non-patch commits between patches
      Rename "stg assimilate" to "stg repair"
      Let some commands work with detached HEAD
      Cogito is deprecated, so don't point to it
      Simple test for "stg clean"


 Documentation/stg.txt         |    4 -
 README                        |    4 -
 contrib/stgit-completion.bash |    2=20
 stgit/commands/add.py         |    2=20
 stgit/commands/assimilate.py  |  198 ---------------------------------=
--------
 stgit/commands/common.py      |    2=20
 stgit/commands/repair.py      |  192 +++++++++++++++++++++++++++++++++=
+++++++
 stgit/commands/resolved.py    |    2=20
 stgit/commands/status.py      |    2=20
 stgit/main.py                 |    4 -
 t/t1301-assimilate.sh         |   84 -----------------
 t/t1301-repair.sh             |   80 +++++++++++++++++
 t/t1302-assimilate-interop.sh |   59 ------------
 t/t1302-repair-interop.sh     |   59 ++++++++++++
 t/t2500-clean.sh              |   27 ++++++
 15 files changed, 368 insertions(+), 353 deletions(-)
 delete mode 100644 stgit/commands/assimilate.py
 create mode 100644 stgit/commands/repair.py
 delete mode 100755 t/t1301-assimilate.sh
 create mode 100755 t/t1301-repair.sh
 delete mode 100755 t/t1302-assimilate-interop.sh
 create mode 100755 t/t1302-repair-interop.sh
 create mode 100755 t/t2500-clean.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
