From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit fixes and experimental branches updated
Date: Fri, 31 Aug 2007 21:12:10 +0200
Message-ID: <20070831191210.GA2151@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRBvA-0001cX-Tu
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXHaTM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 31 Aug 2007 15:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbXHaTM0
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:12:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4306 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbXHaTMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 15:12:25 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IRBuc-0000fZ-00; Fri, 31 Aug 2007 20:12:10 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57197>

The "master" (experimental) branch is for test driving by interested
parties; the "fixes" branch is stuff that Catalin might want to pull.

                                 -+-

The following changes since commit 18669b744dbc40df9ce025f3db44a28f7aba=
29ff:
  Catalin Marinas (1):
        Add the '--exclusive' option to 'uncommit'

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git fixes

David K=E5gedal (2):
      Add basic test for stg status
      Cleanup tree_status and use -z

Karl Hasselstr=F6m (2):
      Write warnings and errors to stderr if not on a terminal
      Don't fail just because a subprocess wrote stuff to stderr

Pavel Roskin (2):
      Use --force to overwrite python files
      Fix refresh -es

 Makefile                  |    2 +-
 stgit/commands/patches.py |    2 +-
 stgit/commands/refresh.py |    2 +-
 stgit/git.py              |   22 +++++++++++-----------
 stgit/out.py              |   11 +++++++++--
 stgit/run.py              |    5 ++++-
 stgit/stack.py            |    3 ++-
 t/t0002-status.sh         |   15 +++++++++++++++
 8 files changed, 44 insertions(+), 18 deletions(-)
 create mode 100755 t/t0002-status.sh

                                 -+-

The following changes since commit f1c5519a186e6ed20a4206be093cc1b14e75=
5984:
  Pavel Roskin (1):
        Fix refresh -es

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git master

David K=E5gedal (6):
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files

Karl Hasselstr=F6m (11):
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
      Merge branch 'conflict'

 contrib/stgit-completion.bash |   15 +-
 stgit/commands/commit.py      |    8 +-
 stgit/commands/common.py      |    8 +-
 stgit/commands/float.py       |    2 +-
 stgit/commands/imprt.py       |    2 +-
 stgit/commands/pick.py        |    2 +-
 stgit/commands/refresh.py     |    2 +-
 stgit/commands/sync.py        |    2 +-
 stgit/git.py                  |   74 ++++--
 stgit/stack.py                |  574 +++++++++++++++++++++++++++++++++=
--------
 t/t1203-push-conflict.sh      |   70 +++++
 t/t3000-git-interop.sh        |   60 +++++
 t/t4000-upgrade.sh            |    6 +
 13 files changed, 668 insertions(+), 157 deletions(-)
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t3000-git-interop.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
