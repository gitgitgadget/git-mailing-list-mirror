From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/5] Make push and refresh subdirectory safe
Date: Mon, 08 Oct 2007 01:24:35 +0200
Message-ID: <20071007231949.13070.49517.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefUT-0004Jq-4m
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbXJGXYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbXJGXYl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:24:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4882 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbXJGXYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:24:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUC-0000Pr-00; Mon, 08 Oct 2007 00:24:36 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60250>

This series makes push and refresh safe to use from subdirectories, by
using the infrastructure of the first patch to cd to the top of the
worktree.

As stated in the commit messages, this may not be an optimal long-term
solution, but we need to fix this quick. And the infrastructure isn't
good only for cd'ing to the top of the worktree.

This series is also available from

  git://repo.or.cz/stgit/kha.git safe

---

Karl Hasselstr=C3=B6m (5):
      Make "stg refresh" subdirectory safe
      New test: try "stg refresh" in a subdirectory
      Make "stg push" subdirectory safe
      New test: Try "stg push" in a subdirectory
      Infrastructure for current directory handling


 stgit/commands/add.py        |    1 +
 stgit/commands/applied.py    |    1 +
 stgit/commands/assimilate.py |    1 +
 stgit/commands/branch.py     |    1 +
 stgit/commands/clean.py      |    1 +
 stgit/commands/clone.py      |    1 +
 stgit/commands/commit.py     |    1 +
 stgit/commands/common.py     |   68 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/commands/copy.py       |    1 +
 stgit/commands/delete.py     |    1 +
 stgit/commands/diff.py       |    1 +
 stgit/commands/edit.py       |    1 +
 stgit/commands/export.py     |    1 +
 stgit/commands/files.py      |    1 +
 stgit/commands/float.py      |    1 +
 stgit/commands/fold.py       |    1 +
 stgit/commands/goto.py       |    1 +
 stgit/commands/hide.py       |    1 +
 stgit/commands/id.py         |    1 +
 stgit/commands/imprt.py      |    1 +
 stgit/commands/init.py       |    1 +
 stgit/commands/log.py        |    1 +
 stgit/commands/mail.py       |    1 +
 stgit/commands/new.py        |    1 +
 stgit/commands/patches.py    |    1 +
 stgit/commands/pick.py       |    1 +
 stgit/commands/pop.py        |    1 +
 stgit/commands/pull.py       |    1 +
 stgit/commands/push.py       |    1 +
 stgit/commands/rebase.py     |    1 +
 stgit/commands/refresh.py    |    1 +
 stgit/commands/rename.py     |    1 +
 stgit/commands/resolved.py   |    1 +
 stgit/commands/rm.py         |    1 +
 stgit/commands/series.py     |    1 +
 stgit/commands/show.py       |    1 +
 stgit/commands/sink.py       |    1 +
 stgit/commands/status.py     |    1 +
 stgit/commands/sync.py       |    1 +
 stgit/commands/top.py        |    1 +
 stgit/commands/unapplied.py  |    1 +
 stgit/commands/uncommit.py   |    1 +
 stgit/commands/unhide.py     |    1 +
 stgit/main.py                |    2 +
 t/t1205-push-subdir.sh       |   55 ++++++++++++++++++++++++++++++++++
 t/t2300-refresh-subdir.sh    |   27 +++++++++++++++++
 46 files changed, 194 insertions(+), 0 deletions(-)
 create mode 100755 t/t1205-push-subdir.sh
 create mode 100755 t/t2300-refresh-subdir.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
