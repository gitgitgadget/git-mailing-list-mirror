From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/{safe,experimental} updated
Date: Wed, 14 May 2008 03:43:09 +0200
Message-ID: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw62U-0003jg-Ci
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbYENBn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYENBn2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:43:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2533 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYENBn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:43:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jw61N-0004hX-00; Wed, 14 May 2008 02:43:09 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82060>

kha/safe has improved version handling: "stg --version" will now
present a detailed version number just like git does:

  $ stg --version
  Stacked GIT 0.14.2.152.g77bd

kha/safe also has an improvement/bugfix to the emacs mode: it will
automatically cd up to the root of your worktree, just like git's
emacs mode has done since forever.

kha/experimental has a new command, stg redo. The combination undo +
redo makes it easy to move back and forth in the patch stack history.

                                 -+-

The following changes since commit d9b2f20a72706d6b4f553a8a8e25bd67f87e=
d616:
  Karl Hasselstr=F6m (1):
        Use test_cmp instead of diff -u in the test suite

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (4):
      Remove "stg" from start of log messages
      Import version to a separate namespace
      Better StGit version tracking
      Emacs mode: automatically cd up to root of worktree

 contrib/stgit.el           |   13 ++++++++++-
 setup.py                   |   14 ++++++-----
 stgit/.gitignore           |    1 +
 stgit/commands/clean.py    |    2 +-
 stgit/commands/coalesce.py |    2 +-
 stgit/commands/commit.py   |    2 +-
 stgit/commands/edit.py     |    2 +-
 stgit/commands/goto.py     |    2 +-
 stgit/commands/uncommit.py |    2 +-
 stgit/version.py           |   52 ++++++++++++++++++++++++++++++++++++=
+++++++-
 10 files changed, 78 insertions(+), 14 deletions(-)


                                 -+-


The following changes since commit 52144ce5f2bfb1268aee4a9999821987f889=
2dbf:
  Karl Hasselstr=F6m (1):
        Emacs mode: automatically cd up to root of worktree

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (20):
      Disable patchlog test for "stg new"
      Convert "stg new" to the new infrastructure
      Refactor --author/--committer options
      Let "stg new" support more message options
      Emacs mode: use "stg new --file"
      Convert "stg delete" to the new infrastructure
      Emacs mode: delete patches
      Prevent most commands from running when there are conflicts
      Add property with a list of all patch names
      Library functions for tree and blob manipulation
      Write to a stack log when stack is modified
      Add utility function for reordering patches
      New command: stg reset
      Log conflicts separately
      Log conflicts separately for all commands
      Add a --hard flag to stg reset
      Don't write a log entry if there were no changes
      Move stack reset function to a shared location
      New command: stg undo
      New command: stg redo

 contrib/stgit.el           |   33 ++++--
 stgit/commands/branch.py   |   19 ++-
 stgit/commands/clean.py    |    2 +-
 stgit/commands/coalesce.py |    6 +-
 stgit/commands/commit.py   |   13 ++-
 stgit/commands/common.py   |   41 +++----
 stgit/commands/delete.py   |   76 +++++--------
 stgit/commands/diff.py     |    2 +-
 stgit/commands/edit.py     |   28 +----
 stgit/commands/export.py   |    2 +-
 stgit/commands/files.py    |    2 +-
 stgit/commands/id.py       |    2 +-
 stgit/commands/log.py      |    2 +-
 stgit/commands/mail.py     |    2 +-
 stgit/commands/new.py      |   97 +++++++++-------
 stgit/commands/patches.py  |    2 +-
 stgit/commands/redo.py     |   52 +++++++++
 stgit/commands/reset.py    |   61 ++++++++++
 stgit/commands/series.py   |    2 +-
 stgit/commands/show.py     |    2 +-
 stgit/commands/status.py   |    3 +-
 stgit/commands/top.py      |    2 +-
 stgit/commands/uncommit.py |    5 +-
 stgit/commands/undo.py     |   49 ++++++++
 stgit/lib/git.py           |  154 +++++++++++++++++++++-----
 stgit/lib/log.py           |  265 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py         |    8 ++
 stgit/lib/transaction.py   |   93 ++++++++++++---
 stgit/main.py              |    8 ++
 stgit/utils.py             |   50 ++++++++
 t/t1400-patch-history.sh   |    2 -
 t/t1600-delete-one.sh      |    8 +-
 t/t3100-reset.sh           |  151 +++++++++++++++++++++++++
 t/t3101-reset-hard.sh      |   56 +++++++++
 t/t3102-undo.sh            |   86 ++++++++++++++
 t/t3103-undo-hard.sh       |   56 +++++++++
 t/t3104-redo.sh            |  122 ++++++++++++++++++++
 37 files changed, 1339 insertions(+), 225 deletions(-)
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/lib/log.py
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
