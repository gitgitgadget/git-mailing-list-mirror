From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGIT experimental branches updated
Date: Mon, 3 Sep 2007 02:20:29 +0200
Message-ID: <20070903002029.GA31957@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzgH-0002y5-9u
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXICAUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 20:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbXICAUe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:20:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2068 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbXICAUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:20:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IRzg5-00007G-00; Mon, 03 Sep 2007 01:20:29 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57415>

I've added the three patches I just sent out. That's all, since no one
else seems to be working. :-)

Plus, I've renamed the branches to "safe" and "experimental", since
that's what they're all about.

                                 -+-

The following changes since commit 18669b744dbc40df9ce025f3db44a28f7aba=
29ff:
  Catalin Marinas (1):
        Add the '--exclusive' option to 'uncommit'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (2):
      Add basic test for stg status
      Cleanup tree_status and use -z

Karl Hasselstr=F6m (5):
      Write warnings and errors to stderr if not on a terminal
      Don't fail just because a subprocess wrote stuff to stderr
      Let "stg status" ignore empty directories
      Allow "stg add" when we have no stack
      Test "stg status" more thoroughly

Pavel Roskin (2):
      Use --force to overwrite python files
      Fix refresh -es

 Makefile                  |    2 +-
 stgit/commands/add.py     |    3 -
 stgit/commands/patches.py |    2 +-
 stgit/commands/refresh.py |    2 +-
 stgit/git.py              |   25 +++++----
 stgit/out.py              |   11 +++-
 stgit/run.py              |    5 ++-
 stgit/stack.py            |    3 +-
 t/t0002-status.sh         |  125 +++++++++++++++++++++++++++++++++++++=
++++++++
 9 files changed, 156 insertions(+), 22 deletions(-)
 create mode 100755 t/t0002-status.sh

                                 -+-

The following changes since commit eda4068ff351143504a416393514b9fc57fb=
7fae:
  Karl Hasselstr=F6m (1):
        Test "stg status" more thoroughly

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

David K=E5gedal (6):
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files

Karl Hasselstr=F6m (12):
      Compute patch appliedness from commit DAG
      Test the new DAG appliedness machinery
      Fix bash completion after the DAG appliedness patch
      Speed up the appliedness test
      Speed up the discovery of uninteresting commits
      Speed up appliedness check during patch creation
      Don't traverse the whole DAG when looking for uninteresting commi=
ts
      Find uninteresting commits faster for special cases
      Optimize uninterestingness checks for rebase
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Merge branch 'conflict'

 contrib/stgit-completion.bash |   15 +-
 stgit/commands/commit.py      |    8 +-
 stgit/commands/common.py      |   24 +--
 stgit/commands/float.py       |    2 +-
 stgit/commands/imprt.py       |    2 +-
 stgit/commands/pick.py        |    2 +-
 stgit/commands/refresh.py     |    2 +-
 stgit/commands/resolved.py    |   19 +-
 stgit/commands/sync.py        |    2 +-
 stgit/git.py                  |   74 ++++--
 stgit/gitmergeonefile.py      |   99 ++++----
 stgit/stack.py                |  574 +++++++++++++++++++++++++++++++++=
--------
 t/t0002-status.sh             |    3 -
 t/t1203-push-conflict.sh      |   70 +++++
 t/t3000-git-interop.sh        |   60 +++++
 t/t4000-upgrade.sh            |    6 +
 16 files changed, 730 insertions(+), 232 deletions(-)
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t3000-git-interop.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
