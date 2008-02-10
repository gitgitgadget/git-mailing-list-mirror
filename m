From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit: kha/safe and kha/experimental updated
Date: Sun, 10 Feb 2008 21:36:40 +0100
Message-ID: <20080210203640.GA19688@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Oberndorfer <kumbayo84@arcor.de>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:37:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIvt-0003CN-U0
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbYBJUhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbYBJUhO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:37:14 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3242 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbYBJUhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:37:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JOIum-00059Z-00; Sun, 10 Feb 2008 20:36:40 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73403>

Both branches updated. I've promoted some experimental patches to
safe, and done some work on new and delete (will post the patches in
reply to this mail).

                                 -+-

The following changes since commit a639e7bbf3a6396254af76062ee88c22e437=
3340:
  Karl Hasselstr=F6m (1):
        Don't clean away patches with conflicts

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (11):
      Don't check out files if we don't have index+workdir
      Make documentation less confusing
      Reduce number of backslashes by using raw strings
      Let "stg show" use the unified --diff-opts handling
      Read default diff options from the user's config
      Teach new infrastructure about the default author and committer
      Teach new infrastructure to apply patches
      Teach new infrastructure to diff two trees
      Parse the date instead of treating it as an opaque string
      Convert "stg edit" to the new infrastructure
      Emacs mode: It's possible to edit unapplied patches now

Peter Oberndorfer (1):
      Add an --index option to "stg refresh"

 contrib/stgit.el          |    4 +-
 examples/gitconfig        |    4 +
 stgit/commands/common.py  |    4 +-
 stgit/commands/edit.py    |  309 +++++++++++++++++++++----------------=
--------
 stgit/commands/mail.py    |    4 +-
 stgit/commands/new.py     |    6 +-
 stgit/commands/refresh.py |   25 +++-
 stgit/commands/show.py    |   13 +--
 stgit/lib/git.py          |  126 ++++++++++++++++++-
 stgit/lib/transaction.py  |   13 +-
 stgit/utils.py            |    3 +-
 t/t2700-refresh.sh        |   57 ++++++++-
 12 files changed, 368 insertions(+), 200 deletions(-)

                                 -+-

The following changes since commit 8ae7dc9d485fe5f3fee02ead7f25133be732=
1614:
  Karl Hasselstr=F6m (1):
        Emacs mode: It's possible to edit unapplied patches now

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (7):
      Disable patchlog test for "stg new"
      Convert "stg new" to the new infrastructure
      Refactor --author/--committer options
      Let "stg new" support more message options
      Emacs mode: use "stg new --file"
      Convert "stg delete" to the new infrastructure
      Emacs mode: delete patches

 contrib/stgit.el         |   20 +++++----
 stgit/commands/common.py |   33 +++++----------
 stgit/commands/delete.py |   72 +++++++++++-----------------------
 stgit/commands/edit.py   |   25 +----------
 stgit/commands/new.py    |   97 +++++++++++++++++++++++++-------------=
-------
 stgit/lib/git.py         |    8 ++--
 stgit/utils.py           |   50 +++++++++++++++++++++++
 t/t1400-patch-history.sh |    2 -
 t/t1600-delete-one.sh    |    8 ++--
 9 files changed, 160 insertions(+), 155 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
