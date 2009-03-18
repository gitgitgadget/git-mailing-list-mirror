From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 00/11] Test on Windows - prequel
Date: Wed, 18 Mar 2009 22:27:02 +0100
Message-ID: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Kt-000574-KQ
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbZCRV1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZCRV1p
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46769 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbZCRV1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6D51DCDF8B;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3AB47426B4;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113677>

I'm preparing a series of patches that adjust the test suite so that it
passes on Windows (MinGW port). This is the initial part of it. Another
dozen or more are to follow. By splitting the series I hope to get
earlier feedback.

The series is also available from

 git://repo.or.cz/git/mingw/j6t.git for-junio

 http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=refs/heads/for-junio

-- Hannes

Johannes Schindelin (1):
  t7300: fix clean up on Windows

Johannes Sixt (9):
  t9400, t9401: Do not force hard-linked clone
  test suite: Use 'say' to say something instead of
    'test_expect_success'
  Call 'say' outside test_expect_success
  test-lib: Replace uses of $(expr ...) by POSIX shell features.
  test-lib: Simplify test counting.
  test-lib: Introduce test_chmod and use it instead of update-index
    --chmod
  t2200, t7004: Avoid glob pattern that also matches files
  t5300, t5302, t5303: Do not use /dev/zero
  t5602: Work around path mangling on MSYS

 t/lib-git-svn.sh                       |    6 +++---
 t/t0024-crlf-archive.sh                |    2 +-
 t/t0050-filesystem.sh                  |    9 +++++++--
 t/t1410-reflog.sh                      |    4 +---
 t/t2200-add-update.sh                  |    2 +-
 t/t3400-rebase.sh                      |    4 ++--
 t/t3600-rm.sh                          |    5 +++--
 t/t4006-diff-mode.sh                   |   19 ++++---------------
 t/t4013-diff-various.sh                |    2 +-
 t/t4014-format-patch.sh                |    4 +---
 t/t5000-tar-tree.sh                    |    2 +-
 t/t5300-pack-object.sh                 |   17 ++++++++---------
 t/t5302-pack-index.sh                  |    2 +-
 t/t5303-pack-corruption-resilience.sh  |   12 +++++++-----
 t/t5515-fetch-merge-logic.sh           |    2 +-
 t/t5602-clone-remote-exec.sh           |    4 ++--
 t/t6031-merge-recursive.sh             |    9 ++-------
 t/t7004-tag.sh                         |    9 +++++----
 t/t7005-editor.sh                      |   29 +++++++++++++----------------
 t/t7300-clean.sh                       |    6 +++---
 t/t9200-git-cvsexportcommit.sh         |    2 +-
 t/t9400-git-cvsserver-server.sh        |    8 ++++----
 t/t9401-git-cvsserver-crlf.sh          |    6 +++---
 t/t9500-gitweb-standalone-no-errors.sh |   20 ++++++--------------
 t/t9700-perl-git.sh                    |    2 +-
 t/test-lib.sh                          |   28 ++++++++++++++++------------
 26 files changed, 98 insertions(+), 117 deletions(-)
