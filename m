From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/{stable,safe,experimental} updated
Date: Sun, 13 Apr 2008 21:11:40 +0200
Message-ID: <20080413191140.GA1912@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 21:12:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl7cy-0007Ab-Oe
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 21:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYDMTLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYDMTLw
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 15:11:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3574 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbYDMTLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 15:11:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jl7c5-0000W9-00; Sun, 13 Apr 2008 20:11:41 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79416>

I've rebased my branches on top of Catalin's latest master and stable.
They include all the patches I've sent to the list recently.

I've added a "stable" branch, for patches intended for Catalin's
"stable".

In the experimental branch, I've updated the reset command a bit -- it
should now be quite usable. Bug reports and feature requests and
general comments welcome. (Note to those who already run my
experimental branch: I've changed the stack log format, so you'll have
to nuke your <branchname>.stgit branches. StGit will remind you if you
forget.)


                                 -+-


The following changes since commit bd3f01319a03fc883d391f24639176f0f657=
27e5:
  Catalin Marinas (1):
        Release 0.14.2

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git stable

Karl Hasselstr=F6m (1):
      Fix problems in t1000-branch-create

 t/t1000-branch-create.sh |   56 +++++++++++++++++++++++++++++---------=
-------
 1 files changed, 36 insertions(+), 20 deletions(-)


                                 -+-


The following changes since commit 719309aa54c8fa43bd8700f09b1e293923ed=
4e0a:
  Catalin Marinas (1):
        Merge branch 'stable'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (5):
      Fix problems in t1000-branch-create
      Merge branch 'stable' into stable-master-merge
      Don't both change directory and set GIT_WORK_TREE
      Log environment and cwd as well as the actual command
      emacs mode: handle "stg status" output with #

 contrib/stgit.el         |    2 +-
 stgit/lib/git.py         |   14 +++++++----
 stgit/run.py             |    6 +++++
 t/t1000-branch-create.sh |   56 +++++++++++++++++++++++++++++---------=
-------
 4 files changed, 52 insertions(+), 26 deletions(-)


                                 -+-


The following changes since commit 999dcbc241e377f8b39f0064dd8cc1670e66=
7f18:
  Karl Hasselstr=F6m (1):
        emacs mode: handle "stg status" output with #

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (12):
      Disable patchlog test for "stg new"
      Convert "stg new" to the new infrastructure
      Refactor --author/--committer options
      Let "stg new" support more message options
      Emacs mode: use "stg new --file"
      Convert "stg delete" to the new infrastructure
      Emacs mode: delete patches
      Add property with a list of all patch names
      Library functions for tree and blob manipulation
      Write to a stack log when stack is modified
      Add utility function for reordering patches
      New command: stg reset

 contrib/stgit.el           |   33 +++++++---
 stgit/commands/branch.py   |   18 ++++--
 stgit/commands/clone.py    |    3 +-
 stgit/commands/coalesce.py |    3 +-
 stgit/commands/commit.py   |    6 +-
 stgit/commands/common.py   |   33 +++-------
 stgit/commands/delete.py   |   70 ++++++---------------
 stgit/commands/edit.py     |   26 +-------
 stgit/commands/float.py    |    3 +
 stgit/commands/fold.py     |    3 +-
 stgit/commands/imprt.py    |    3 +-
 stgit/commands/init.py     |    3 +-
 stgit/commands/new.py      |   97 ++++++++++++++++-------------
 stgit/commands/pick.py     |    4 +-
 stgit/commands/pop.py      |    3 +-
 stgit/commands/pull.py     |    3 +-
 stgit/commands/push.py     |    6 +-
 stgit/commands/rebase.py   |    4 +-
 stgit/commands/refresh.py  |    4 +-
 stgit/commands/rename.py   |    4 +-
 stgit/commands/reset.py    |   67 ++++++++++++++++++++
 stgit/commands/resolved.py |    4 +-
 stgit/commands/sink.py     |    3 +-
 stgit/commands/sync.py     |    5 +-
 stgit/commands/uncommit.py |    2 +-
 stgit/lib/git.py           |  147 ++++++++++++++++++++++++++++++++++++=
--------
 stgit/lib/log.py           |  130 ++++++++++++++++++++++++++++++++++++=
++
 stgit/lib/stack.py         |    1 +
 stgit/lib/transaction.py   |   17 +++++-
 stgit/main.py              |    2 +
 stgit/utils.py             |   50 +++++++++++++++
 t/t1400-patch-history.sh   |    2 -
 t/t1600-delete-one.sh      |    8 +-
 33 files changed, 559 insertions(+), 208 deletions(-)
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/lib/log.py

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
