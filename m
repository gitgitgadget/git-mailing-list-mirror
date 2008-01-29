From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: kha/safe and kha/experimental updated
Date: Tue, 29 Jan 2008 03:58:21 +0100
Message-ID: <20080129025821.GA1373@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgh6-00039z-Bh
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYA2C6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 21:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbYA2C6j
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:58:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4708 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYA2C6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:58:38 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JJgg1-0000TE-00; Tue, 29 Jan 2008 02:58:21 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71924>

I'll follow up with the three patch series in here that are new.

The following changes since commit cd885e085a697d5377956d5beb30e6030f22=
4ccd:
  Peter Oberndorfer (1):
        replace "git repo-config" usage by "git config"

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (10):
      Don't keep old committer when rewriting a commit
      Homogenize buffer names
      Remove unused default values
      Refactor --diff-opts handling
      Create index and worktree objects just once
      Wrap excessively long line
      Eliminate temp variable that's used just once
      Simplify editor selection logic
      Let the caller supply the diff text to diffstat()
      Don't clean away patches with conflicts

Pavel Roskin (1):
      Add test to ensure that "stg clean" preserves conflicting patches

 contrib/stgit.el           |    6 +++---
 stgit/commands/clean.py    |    7 +++++++
 stgit/commands/coalesce.py |    2 +-
 stgit/commands/commit.py   |    2 +-
 stgit/commands/common.py   |    3 ++-
 stgit/commands/diff.py     |   19 ++++++-------------
 stgit/commands/edit.py     |   16 ++++------------
 stgit/commands/export.py   |   20 +++++++-------------
 stgit/commands/files.py    |   15 +++++----------
 stgit/commands/goto.py     |    2 +-
 stgit/commands/mail.py     |   26 +++++++++-----------------
 stgit/commands/status.py   |   17 +++++------------
 stgit/git.py               |    9 +++------
 stgit/lib/git.py           |   42 ++++++++++++++++++++++++++++++++----=
------
 stgit/lib/transaction.py   |    4 ++--
 stgit/utils.py             |   20 ++++++++++++++------
 t/t2500-clean.sh           |   17 +++++++++++++++++
 17 files changed, 119 insertions(+), 108 deletions(-)

                                 -+-

The following changes since commit 149ad73c6b1639981b1064a9e8f3699b0892=
8621:
  Karl Hasselstr=F6m (1):
        Don't clean away patches with conflicts

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (6):
      Let "stg show" use the unified --diff-opts handling
      Read default diff options from the user's config
      Teach new infrastructure about the default author and committer
      Teach new infrastructure to apply patches
      Teach new infrastructure to diff two trees
      Convert "stg edit" to the new infrastructure

Peter Oberndorfer (1):
      Add an --index option to "stg refresh"

 examples/gitconfig        |    4 +
 stgit/commands/edit.py    |  309 +++++++++++++++++++++----------------=
--------
 stgit/commands/refresh.py |   25 +++-
 stgit/commands/show.py    |   13 +--
 stgit/lib/git.py          |   54 ++++++++
 stgit/utils.py            |    3 +-
 t/t2700-refresh.sh        |   57 ++++++++-
 7 files changed, 283 insertions(+), 182 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
