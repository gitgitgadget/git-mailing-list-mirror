From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: kha/safe and kha/experimental updated
Date: Tue, 18 Dec 2007 06:21:15 +0100
Message-ID: <20071218052115.GA13422@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 06:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Utq-0000eK-Oz
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 06:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbXLRFV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 00:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbXLRFV0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 00:21:26 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1149 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbXLRFVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 00:21:25 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4UtI-0003WY-00; Tue, 18 Dec 2007 05:21:16 +0000
Content-Disposition: inline
In-Reply-To: <20071217224812.GA6342@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68699>

On 2007-12-17 23:48:12 +0100, Karl Hasselstr=F6m wrote:

> If you like, I can advance "safe" to include as many patches as I
> think you should merge right now.

And here it is:

The following changes since commit 5be69cd8d89bd89be31364e9c0fd9e947b6e=
f644:
  Karl Hasselstr=F6m (1):
        Name the exit codes to improve legibility

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (17):
      Add an StGit mode for emacs
      Emacs mode: Improve the output buffer state
      Emacs mode: Bind n and p
      Emacs mode: add stgit-repair
      Emacs mode: added stgit-commit and stgit-uncommit
      Emacs mode: Add stgit-edit command
      Emacs mode: added fontification
      Emacs mode: Added stgit-new
      Check bottom and invariants
      Remove the 'bottom' field
      Remove the 'top' field
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files

Karl Hasselstr=F6m (24):
      Emacs mode: Show keybindings when user presses "h" or "?"
      Emacs mode: Add an explanatory header
      Emacs mode: Makefile for building stgit.el
      Emacs mode: push/pop next patch, not patch at point
      Emacs mode: Let "P" push or pop patch at point
      Emacs mode: Bind "G" to "stg goto"
      Emacs mode: show patches' short description
      Write removed fields for backwards compatibility
      Nicer conflict markers
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      "stg status --reset" is not needed anymore
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"
      Remove "stg resolved"
      New StGit core infrastructure: repository operations
      Write metadata files used by the old infrastructure
      Upgrade older stacks to newest version
      Let "stg clean" use the new infrastructure
      Add "stg coalesce"
      Let "stg applied" and "stg unapplied" use the new infrastructure

 Documentation/stg-cp.txt      |   63 --------
 Documentation/stg.txt         |    2 -
 Documentation/tutorial.txt    |   31 +++--
 contrib/Makefile              |   19 +++
 contrib/stgit-completion.bash |    4 +-
 contrib/stgit.el              |  318 +++++++++++++++++++++++++++++++++=
++++++++
 examples/gitconfig            |   19 +---
 setup.py                      |    2 +-
 stgit/commands/add.py         |   44 ------
 stgit/commands/applied.py     |   27 ++--
 stgit/commands/clean.py       |   68 +++++-----
 stgit/commands/coalesce.py    |   84 +++++++++++
 stgit/commands/common.py      |   39 +++---
 stgit/commands/copy.py        |   45 ------
 stgit/commands/pick.py        |    2 +-
 stgit/commands/resolved.py    |   94 ------------
 stgit/commands/rm.py          |   48 ------
 stgit/commands/status.py      |   31 ++---
 stgit/commands/sync.py        |    1 -
 stgit/commands/unapplied.py   |   23 ++--
 stgit/config.py               |    1 -
 stgit/git.py                  |   75 ++++++----
 stgit/gitmergeonefile.py      |   97 +------------
 stgit/lib/__init__.py         |   18 +++
 stgit/lib/git.py              |  260 +++++++++++++++++++++++++++++++++
 stgit/lib/stack.py            |  172 ++++++++++++++++++++++
 stgit/lib/stackupgrade.py     |   96 ++++++++++++
 stgit/lib/transaction.py      |   79 ++++++++++
 stgit/main.py                 |   10 +-
 stgit/run.py                  |    3 +
 stgit/stack.py                |  156 ++++----------------
 stgit/utils.py                |   24 +++
 t/t0002-status.sh             |   15 +-
 t/t1200-push-modified.sh      |    2 +-
 t/t1202-push-undo.sh          |    6 +-
 t/t1203-push-conflict.sh      |   70 +++++++++
 t/t1204-pop-keep.sh           |    2 +-
 t/t1205-push-subdir.sh        |    8 +-
 t/t1300-uncommit.sh           |    4 +-
 t/t1301-repair.sh             |    2 +-
 t/t1400-patch-history.sh      |    4 +-
 t/t1500-float.sh              |   14 +-
 t/t1600-delete-one.sh         |   12 +-
 t/t1601-delete-many.sh        |    2 +-
 t/t1700-goto-top.sh           |    2 +-
 t/t2000-sync.sh               |   12 +-
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |    4 +-
 t/t2300-refresh-subdir.sh     |    2 +-
 t/t2600-coalesce.sh           |   31 ++++
 51 files changed, 1420 insertions(+), 735 deletions(-)
 delete mode 100644 Documentation/stg-cp.txt
 create mode 100644 contrib/Makefile
 create mode 100644 contrib/stgit.el
 delete mode 100644 stgit/commands/add.py
 create mode 100644 stgit/commands/coalesce.py
 delete mode 100644 stgit/commands/copy.py
 delete mode 100644 stgit/commands/resolved.py
 delete mode 100644 stgit/commands/rm.py
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/stackupgrade.py
 create mode 100644 stgit/lib/transaction.py
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t2600-coalesce.sh

                                 -+-

The following changes since commit 1189271615e7157ca3da3288a9ce3c9bcaeb=
2d5f:
  Karl Hasselstr=F6m (1):
        Let "stg applied" and "stg unapplied" use the new infrastructur=
e

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

David K=E5gedal (2):
      Emacs mode: Add mark command
      Emacs mode: coalesce command

Karl Hasselstr=F6m (10):
      Teach the new infrastructure about the index and worktree
      Let "stg clean" use the new transaction primitives
      Let "stg goto" use the new infrastructure
      Convert "stg uncommit" to the new infrastructure
      New infrastructure: Make sure that the branch is initialized
      Expose transaction abort function
      stg coalesce: Support --file and --save-template
      Set exit code to 3 on merge conflict
      Convert "stg commit" to new infrastructure
      Make "stg commit" fancier

 contrib/stgit.el           |   97 +++++++++++++++++++-----
 stgit/commands/clean.py    |   35 ++-------
 stgit/commands/coalesce.py |  118 +++++++++++++++++++----------
 stgit/commands/commit.py   |  111 +++++++++++++++++----------
 stgit/commands/goto.py     |   52 +++++---------
 stgit/commands/uncommit.py |   81 +++++++++-----------
 stgit/lib/git.py           |  127 +++++++++++++++++++++++++++++++
 stgit/lib/stack.py         |   10 ++-
 stgit/lib/stackupgrade.py  |    6 +-
 stgit/lib/transaction.py   |  178 ++++++++++++++++++++++++++++++++++++=
++------
 stgit/main.py              |    4 +-
 stgit/utils.py             |    1 +
 t/t1300-uncommit.sh        |   12 ++--
 13 files changed, 588 insertions(+), 244 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
