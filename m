From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 00/19] Let Git's tests pass on Windows
Date: Sun, 24 Jan 2016 16:43:06 +0100 (CET)
Message-ID: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-55574342-1453650189=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpY-0000Wn-70
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbcAXPnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:43:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:50779 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcAXPnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:16 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M243n-1a8b5S0Bhr-00u2IV; Sun, 24 Jan 2016 16:43:09
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/AwjOpwA8CBoeBfrFfL7olbFeXjJ/Yh7rvyuguZ2LvOTaWmn+o5
 3BW4qXstW4YUWG1m20H7qUfjnYBeD8/G7uDTDPFc2xHU8Q+RW3GgI5sbeO0sI9ut5StHXhI
 FMxmyscpfOnJvvdwW58dfKcz24ZGC3APfQEJdXX/abm0dUmxrIRcziuEZDEQIM34XYM9FsG
 tTRyHryyW9ZRagREwsq+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w6U62sVjgY8=:HGf81EmOvG3rTo9dM/nD2v
 Wttin7J1ruTO9gZjyfM5PsskOPhhLOfaV4K6nCjii2wkGJ7xgJBKxGy8+Q39oaalfOJwuoIax
 PQ2mpx2+LW6ayD2/aILyXq2M/R2seEfdl1xxVDxxL0K5kD6mKAOr8zR/7VYdnRl6t1gg++uJG
 Vihh/kuDsHZPK8lvt3QXYFV0Cutvd6MOyjAZrH/GVNjw8ML5tSjLidbAxWVsvtnbKNJdT3bGh
 Cjew2smrMDTSYf7pB071BUe1IF8gZ70T+ht5vubNYhF2Ipdr8U8J7BNPk1ZmeLwJoCh7/VsT+
 MuJrfmSApanRaJ0wvhYgq2zmQJYnmC8S91XaajgH38cPYw4o3VjdRDQ9DQC/RDBOryM/Lego1
 jp/6ShZABd2WLJaj1tePgARjS8oRG+biJyF3EPTsSkHygEYxRJaJSTE0oTaFxaWXXkaN/pr4V
 pdcvdJk2o4a/ZNYOSN38tCN1+Oo37QsHrq65gJnjAYR5f0ESWEFAcJEvMPzOIkwZQMwBAADGP
 +1sguJQoKMk04UlOapFyDCPl/Td7+YWzybBkpaVlmhZ0E71f7/jMAUHG+WxKEV2udgf/7AWBH
 TKLrvK23UQ4Dnt/uMUu9oN6xDzEvOAY9OrVbVB+bVIjhXJ7jmwbvebRgVqAFqaZydwe2XfPZE
 AFjHovvCV3LuXVSTa6bivu4e0Zi8LII4olniyzEbcptRfO/1o7+d/uhdMr5PkH/an4XOoezBa
 mCJ0jBeX4gMZEVJDSjCbAnsaeodQFR/ih4spdtkuU3UQ+omaq6iccFvK5bHImx0LVRgSwc8q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284664>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-55574342-1453650189=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

This is a big milestone. With these modifications, Git's source code
does not only build without warnings in Git for Windows' SDK, but
passes the entire regression test suite.

The patch series contains three different types of patches. First,
there are a couple of real fixes that were triggered by failures in
the regression tests. Then there are a couple of fixes to the
regression tests themselves. And finally, we have to disable a couple
of tests because we simply cannot make them work on Windows.


Johannes Schindelin (13):
  mingw: let's use gettext with MSYS2
  mingw: do not trust MSYS2's MinGW gettext.sh
  Git.pm: stop assuming that absolute paths start with a slash
  mingw: prepare the TMPDIR environment variable for shell scripts
  mingw: let lstat() fail with errno =3D=3D ENOTDIR when appropriate
  mingw: fix t5601-clone.sh
  mingw: accomodate t0060-path-utils for MSYS2
  mingw: disable mkfifo-based tests
  tests: turn off git-daemon tests if FIFOs are not available
  mingw: fix t9700's assumption about directory separators
  mingw: work around pwd issues in the tests
  mingw: skip a couple of git-svn tests that cannot pass on Windows
  mingw: do not bother to test funny file names

Karsten Blees (2):
  mingw: factor out Windows specific environment setup
  mingw: do not use symlinks with SVN in t9100

Pat Thoyts (1):
  mingw: avoid absolute path in t0008

Thomas Braun (1):
  mingw: outsmart MSYS2's path substitution in t1508

=B8=B6=B4=A9=BF=A4 (2):
  mingw: try to delete target directory before renaming
  mingw: fix git-svn tests that expect chmod to work

 Makefile                              |  1 +
 compat/mingw.c                        | 91 +++++++++++++++++++++++++++++--=
----
 config.mak.uname                      |  3 +-
 perl/Git.pm                           |  3 +-
 t/lib-git-daemon.sh                   |  5 ++
 t/t0008-ignores.sh                    |  8 ++-
 t/t0060-path-utils.sh                 | 37 ++++++++------
 t/t1508-at-combinations.sh            | 13 ++++-
 t/t3300-funny-names.sh                |  1 +
 t/t3600-rm.sh                         |  3 +-
 t/t3703-add-magic-pathspec.sh         |  2 +-
 t/t3902-quoted.sh                     |  1 +
 t/t4016-diff-quote.sh                 |  1 +
 t/t4135-apply-weird-filenames.sh      |  3 +-
 t/t5601-clone.sh                      | 18 +++----
 t/t7800-difftool.sh                   | 14 +++---
 t/t9100-git-svn-basic.sh              | 29 +++++++----
 t/t9118-git-svn-funky-branch-names.sh | 12 +++--
 t/t9124-git-svn-dcommit-auto-props.sh | 20 ++++++--
 t/t9130-git-svn-authors-file.sh       |  2 +-
 t/t9200-git-cvsexportcommit.sh        |  2 +-
 t/t9400-git-cvsserver-server.sh       |  6 +--
 t/t9401-git-cvsserver-crlf.sh         |  6 +--
 t/t9402-git-cvsserver-refs.sh         |  6 +--
 t/t9700/test.pl                       |  2 +-
 t/t9903-bash-prompt.sh                |  2 +-
 t/test-lib.sh                         |  2 +-
 test-fake-ssh.c                       | 30 ++++++++++++
 28 files changed, 238 insertions(+), 85 deletions(-)
 create mode 100644 test-fake-ssh.c

--=20
2.7.0.windows.1.7.g55a05c8

--8323329-55574342-1453650189=:2964--
