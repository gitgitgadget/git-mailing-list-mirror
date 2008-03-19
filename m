From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/safe and kha/experimental updated
Date: Wed, 19 Mar 2008 02:28:04 +0100
Message-ID: <20080319012804.GA28781@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	Angus Salkeld <ahsalkeld@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5py-0005me-7X
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765914AbYCSVX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 17:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbYCSVXZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:23:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3458 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966204AbYCSVXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:23:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jbn64-0007VG-00; Wed, 19 Mar 2008 01:28:04 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77555>

kha/safe contains two patches that were posted to the list quite some
time ago. Sorry for the delay! kha/experimental still has the
new/delete rewrites from way back when, plus a new and shiny "stg
reset" prototype!

                                 -+-

The following changes since commit 0a03ab4518fca921a8f427d283f29c0fe362=
5cb2:
  Onno Kortmann (1):
        Test the 'stg rename' command

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Alex Chiang (1):
      Better "stg rebase" help text

Angus Salkeld (1):
      stg mail crashes when there is no patch description

 stgit/commands/mail.py   |    9 +++++++--
 stgit/commands/rebase.py |   14 +++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

                                 -+-

The following changes since commit 70bbc1a3d57cfe0e5eb6839a7889201fdeaa=
3cd6:
  Angus Salkeld (1):
        stg mail crashes when there is no patch description

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
 stgit/commands/pick.py     |    3 +-
 stgit/commands/pop.py      |    3 +-
 stgit/commands/pull.py     |    3 +-
 stgit/commands/push.py     |    6 +-
 stgit/commands/rebase.py   |    4 +-
 stgit/commands/refresh.py  |    4 +-
 stgit/commands/rename.py   |    4 +-
 stgit/commands/reset.py    |   56 +++++++++++++++++
 stgit/commands/resolved.py |    4 +-
 stgit/commands/sink.py     |    3 +-
 stgit/commands/sync.py     |    5 +-
 stgit/commands/uncommit.py |    2 +-
 stgit/lib/git.py           |  147 ++++++++++++++++++++++++++++++++++++=
--------
 stgit/lib/log.py           |  105 +++++++++++++++++++++++++++++++
 stgit/lib/stack.py         |    1 +
 stgit/lib/transaction.py   |   17 +++++-
 stgit/main.py              |    2 +
 stgit/utils.py             |   50 +++++++++++++++
 t/t1400-patch-history.sh   |    2 -
 t/t1600-delete-one.sh      |    8 +-
 33 files changed, 523 insertions(+), 207 deletions(-)
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/lib/log.py

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
