From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit kha safe branch updated
Date: Mon, 8 Oct 2007 01:29:43 +0200
Message-ID: <20071007232943.GA1262@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefZW-0004wq-15
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbXJGX34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbXJGX34
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:29:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1234 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052AbXJGX3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:29:55 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IefZ9-0000UV-00; Mon, 08 Oct 2007 00:29:43 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60258>

These are the assimilate patches, plus the two new series I just
mailed out.

The following changes since commit 764d110156e4951ca5671a700ee2402fa359=
7734:
  Yann Dirson (1):
        Better diagnostic for wrong branch configuration.

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=F6m (16):
      Teach "stg assimilate" to repair patch reachability
      Test the new powers of "stg assimilate"
      Let "stg assimilate" handle missing patches
      Add --ack/--sign options to "stg new"
      New test: "stg pop --keep"
      Fix up the help text for "stg edit"
      Don't split long and short description in "stg edit"
      Make a common superclass for all StGit exceptions
      Simplify debug level error checking
      Discard stderr output from git-rev-parse
      Remove the --force flag to "stg rebase" and "stg pull"
      Infrastructure for current directory handling
      New test: Try "stg push" in a subdirectory
      Make "stg push" subdirectory safe
      New test: try "stg refresh" in a subdirectory
      Make "stg refresh" subdirectory safe

 stgit/commands/add.py         |    1 +
 stgit/commands/applied.py     |    1 +
 stgit/commands/assimilate.py  |  199 +++++++++++++++++++++++++++++++--=
--------
 stgit/commands/branch.py      |    1 +
 stgit/commands/clean.py       |    1 +
 stgit/commands/clone.py       |    1 +
 stgit/commands/commit.py      |    1 +
 stgit/commands/common.py      |   88 +++++++++++++++---
 stgit/commands/copy.py        |    1 +
 stgit/commands/delete.py      |    1 +
 stgit/commands/diff.py        |    1 +
 stgit/commands/edit.py        |   34 ++++----
 stgit/commands/export.py      |    1 +
 stgit/commands/files.py       |    1 +
 stgit/commands/float.py       |    1 +
 stgit/commands/fold.py        |    1 +
 stgit/commands/goto.py        |    1 +
 stgit/commands/hide.py        |    1 +
 stgit/commands/id.py          |    1 +
 stgit/commands/imprt.py       |    1 +
 stgit/commands/init.py        |    1 +
 stgit/commands/log.py         |    1 +
 stgit/commands/mail.py        |    1 +
 stgit/commands/new.py         |    7 +-
 stgit/commands/patches.py     |    1 +
 stgit/commands/pick.py        |    1 +
 stgit/commands/pop.py         |    1 +
 stgit/commands/pull.py        |    6 +-
 stgit/commands/push.py        |    1 +
 stgit/commands/rebase.py      |    6 +-
 stgit/commands/refresh.py     |    1 +
 stgit/commands/rename.py      |    1 +
 stgit/commands/resolved.py    |    1 +
 stgit/commands/rm.py          |    1 +
 stgit/commands/series.py      |    1 +
 stgit/commands/show.py        |    1 +
 stgit/commands/sink.py        |    1 +
 stgit/commands/status.py      |    1 +
 stgit/commands/sync.py        |    1 +
 stgit/commands/top.py         |    1 +
 stgit/commands/unapplied.py   |    1 +
 stgit/commands/uncommit.py    |    1 +
 stgit/commands/unhide.py      |    1 +
 stgit/config.py               |    3 +-
 stgit/exception.py            |    3 +
 stgit/git.py                  |    6 +-
 stgit/gitmergeonefile.py      |    3 +-
 stgit/main.py                 |   17 ++---
 stgit/run.py                  |    5 +-
 stgit/stack.py                |   20 +++-
 stgit/utils.py                |    3 +-
 t/t1204-pop-keep.sh           |   42 +++++++++
 t/t1205-push-subdir.sh        |   55 +++++++++++
 t/t1301-assimilate.sh         |   12 +--
 t/t1302-assimilate-interop.sh |   59 ++++++++++++
 t/t2100-pull-policy-fetch.sh  |   14 ---
 t/t2102-pull-policy-rebase.sh |   24 -----
 t/t2300-refresh-subdir.sh     |   27 ++++++
 58 files changed, 514 insertions(+), 156 deletions(-)
 create mode 100644 stgit/exception.py
 create mode 100755 t/t1204-pop-keep.sh
 create mode 100755 t/t1205-push-subdir.sh
 create mode 100755 t/t1302-assimilate-interop.sh
 create mode 100755 t/t2300-refresh-subdir.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
