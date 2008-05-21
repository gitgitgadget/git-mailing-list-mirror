From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/{safe,experimental} updated
Date: Wed, 21 May 2008 07:19:45 +0200
Message-ID: <20080521051945.GA25278@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 07:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jygko-00054j-9C
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 07:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbYEUFT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 01:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754316AbYEUFTz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 01:19:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1167 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbYEUFTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 01:19:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jygjp-0006aV-00; Wed, 21 May 2008 06:19:45 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82526>

I've promoted a bunch of stuff from "experimental" to "safe", so that
"experimental" currently only consists of the stack log stuff.

The stack log stuff in experimental now sports a rewrite of "stg log",
so that you can see what's in your log. This work is nearing
completion, or at least nearing the point where I'll be considering
moving it to "safe".


                                 -+-


The following changes since commit 9564af74822b276d435319fc271eda591e51=
25a6:
  Catalin Marinas (1):
        Merge branch 'stable'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (10):
      Try the built-in version string before git-describe
      Disable patchlog test for "stg new"
      Convert "stg new" to the new infrastructure
      Refactor --author/--committer options
      Let "stg new" support more message options
      Emacs mode: use "stg new --file"
      Convert "stg delete" to the new infrastructure
      Emacs mode: delete patches
      Prevent most commands from running when there are conflicts
      Add property with a list of all patch names

 contrib/stgit.el           |   33 +++++++++++----
 setup.py                   |   45 +++++++++++---------
 stgit/.gitignore           |    1 -
 stgit/commands/clean.py    |    2 +-
 stgit/commands/coalesce.py |    6 +-
 stgit/commands/commit.py   |   13 ++++--
 stgit/commands/common.py   |   33 +++++----------
 stgit/commands/delete.py   |   76 +++++++++++++----------------------
 stgit/commands/edit.py     |   28 ++----------
 stgit/commands/new.py      |   97 ++++++++++++++++++++++++------------=
-------
 stgit/commands/uncommit.py |    5 +-
 stgit/lib/git.py           |    8 ++--
 stgit/lib/stack.py         |    1 +
 stgit/lib/transaction.py   |   27 ++++++++++--
 stgit/utils.py             |   50 ++++++++++++++++++++++
 stgit/version.py           |   15 +++++-
 t/t1400-patch-history.sh   |    2 -
 t/t1600-delete-one.sh      |    8 ++--
 18 files changed, 255 insertions(+), 195 deletions(-)


                                 -+-


The following changes since commit a5920051ee4326489c4b43e85d93f71d4c4c=
e34a:
  Karl Hasselstr=F6m (1):
        Add property with a list of all patch names

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (13):
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
      Log and undo external modifications
      Make "stg log" show stack log instead of patch log

 stgit/commands/branch.py     |   19 ++-
 stgit/commands/common.py     |    9 +-
 stgit/commands/diff.py       |    2 +-
 stgit/commands/export.py     |    2 +-
 stgit/commands/files.py      |    2 +-
 stgit/commands/id.py         |    2 +-
 stgit/commands/log.py        |  164 +++++++----------------
 stgit/commands/mail.py       |    2 +-
 stgit/commands/patches.py    |    2 +-
 stgit/commands/redo.py       |   52 +++++++
 stgit/commands/reset.py      |   56 ++++++++
 stgit/commands/series.py     |    2 +-
 stgit/commands/show.py       |    2 +-
 stgit/commands/status.py     |    3 +-
 stgit/commands/top.py        |    2 +-
 stgit/commands/undo.py       |   49 +++++++
 stgit/lib/git.py             |  146 +++++++++++++++++---
 stgit/lib/log.py             |  304 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py           |   16 +++
 stgit/lib/transaction.py     |  115 +++++++++++-----
 stgit/main.py                |    8 +
 t/t1400-patch-history.sh     |  103 --------------
 t/t3100-reset.sh             |  151 +++++++++++++++++++++
 t/t3101-reset-hard.sh        |   56 ++++++++
 t/t3102-undo.sh              |   86 ++++++++++++
 t/t3103-undo-hard.sh         |   56 ++++++++
 t/t3104-redo.sh              |  122 +++++++++++++++++
 t/t3105-undo-external-mod.sh |   68 ++++++++++
 28 files changed, 1310 insertions(+), 291 deletions(-)
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/lib/log.py
 delete mode 100755 t/t1400-patch-history.sh
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh
 create mode 100755 t/t3105-undo-external-mod.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
