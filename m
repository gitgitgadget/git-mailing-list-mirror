From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGIT experimental branch updated
Date: Thu, 23 Aug 2007 04:29:58 +0200
Message-ID: <20070823022958.GA9323@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 04:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO2Se-0001y2-F1
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 04:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbXHWCaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 22:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXHWCaI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 22:30:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3906 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXHWCaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 22:30:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IO2SM-0002Rv-00; Thu, 23 Aug 2007 03:29:58 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56449>

I've rebased my experimental branch against the stuff Catalin pushed
out recently. The remaining diff is mostly the DAG series and David's
push conflict improvements. I haven't had time to test drive it
thoroughly, but it passes the test suite.

The following changes since commit 7e97cc0590f29482af022340df84a43b98c6=
57ce:
  Yann Dirson (1):
        Include contrib scripts in the release tarball.

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git master

David K=E5gedal (5):
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts

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
      Don't touch ref files manually
      Merge branch 'refs'
      Merge branch 'conflict'

 contrib/stgit-completion.bash |   15 +-
 stgit/commands/branch.py      |    5 +-
 stgit/commands/commit.py      |    8 +-
 stgit/commands/common.py      |    4 +-
 stgit/commands/float.py       |    2 +-
 stgit/commands/imprt.py       |    2 +-
 stgit/commands/pick.py        |    2 +-
 stgit/commands/refresh.py     |    2 +-
 stgit/commands/sync.py        |    2 +-
 stgit/git.py                  |  140 ++++++----
 stgit/stack.py                |  642 ++++++++++++++++++++++++++++++++-=
--------
 t/t0001-subdir-branches.sh    |    7 +-
 t/t1000-branch-create.sh      |   30 +--
 t/t1001-branch-rename.sh      |    2 +-
 t/t1203-push-conflict.sh      |   64 ++++
 t/t3000-git-interop.sh        |   60 ++++
 t/t4000-upgrade.sh            |    6 +
 17 files changed, 741 insertions(+), 252 deletions(-)
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t3000-git-interop.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
