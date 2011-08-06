From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 00/40] test whitespace - perform trivial whitespace clean ups of test scripts.
Date: Sat,  6 Aug 2011 18:41:59 +1000
Message-ID: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcTu-0004CD-9T
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab1HFImL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:42:11 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:35570 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1HFImK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:42:10 -0400
Received: by iye16 with SMTP id 16so5179377iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6v/YNZ7/q4/Eb8SKwruDpR9aZ2VoPJ5Am9HoRHqo9+g=;
        b=vUmozdIGLj4tVrtsJJIrsOgwXhV3xuRc8xt7OuZtPA9cB/xZcgi2bP4QuU8wn3iC+V
         fRQDb41CfojFVd/39iQ1W+4jq1wUEyZM9A173n/Xu/yDCEDlJD/h1aC6BmgQfg9bsu/8
         Rqsl9YW3katj+Sa7UuSzQyGIeVe68EVL5I0qU=
Received: by 10.42.140.200 with SMTP id l8mr3020861icu.371.1312620129659;
        Sat, 06 Aug 2011 01:42:09 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id fr11sm2665626ibb.12.2011.08.06.01.42.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:42:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178831>

The series applies cleanly to both master and pu.

The first patch contains a script, t/test-cleaner.sh, that can automate whitespace cleanup of tests.
The remaining patches are the result of running the example.

For example:
	cd t
	./test-cleaner.sh fix-whitespace-auto t[0-9]*.sh

will:
	* identify test scripts with trivial white space errors
	* edit the test to remove the trivial white space errors
	* verify that edited test produces same outputs, errors and exit code
	* creates a single commit for the edited test

fix-whitespace-manual will do the same for tests that are broken by the edit. 

In this case, the commit message is prefixed with FAILED:

These scripts rely on the existence of expand and unexpand on the PATH.

Jon Seymour (40):
  test-cleaner: automate whitespace cleaning of test scripts
  whitespace: remediate t1001-read-tree-m-2way.sh
  whitespace: remediate t1006-cat-file.sh
  whitespace: remediate t1300-repo-config.sh
  whitespace: remediate t1503-rev-parse-verify.sh
  whitespace: remediate t3040-subprojects-basic.sh
  whitespace: remediate t3200-branch.sh
  whitespace: remediate t3406-rebase-message.sh
  whitespace: remediate t4002-diff-basic.sh
  whitespace: remediate t4010-diff-pathspec.sh
  whitespace: remediate t5300-pack-object.sh
  whitespace: remediate t5301-sliding-window.sh
  whitespace: remediate t5302-pack-index.sh
  whitespace: remediate t5303-pack-corruption-resilience.sh
  whitespace: remediate t5400-send-pack.sh
  whitespace: remediate t5402-post-merge-hook.sh
  whitespace: remediate t5403-post-checkout-hook.sh
  whitespace: remediate t5510-fetch.sh
  whitespace: remediate t6002-rev-list-bisect.sh
  whitespace: remediate t6005-rev-list-count.sh
  whitespace: remediate t6030-bisect-porcelain.sh
  whitespace: remediate t7003-filter-branch.sh
  whitespace: remediate t7004-tag.sh
  whitespace: remediate t7403-submodule-sync.sh
  whitespace: remediate t7500-commit.sh
  whitespace: remediate t7810-grep.sh
  whitespace: remediate t9100-git-svn-basic.sh
  whitespace: remediate t9104-git-svn-follow-parent.sh
  whitespace: remediate t9107-git-svn-migrate.sh
  whitespace: remediate t9108-git-svn-glob.sh
  whitespace: remediate t9109-git-svn-multi-glob.sh
  whitespace: remediate t9110-git-svn-use-svm-props.sh
  whitespace: remediate t9118-git-svn-funky-branch-names.sh
  whitespace: remediate t9125-git-svn-multi-glob-branch-names.sh
  whitespace: remediate t9400-git-cvsserver-server.sh
  whitespace: remediate t9401-git-cvsserver-crlf.sh
  whitespace: remediate t9500-gitweb-standalone-no-errors.sh
  whitespace: remediate t9603-cvsimport-patchsets.sh
  whitespace: remediate t1000-read-tree-m-3way.sh
  whitespace: remediate t6120-describe.sh

 t/t1000-read-tree-m-3way.sh                |   12 +-
 t/t1001-read-tree-m-2way.sh                |   10 +-
 t/t1006-cat-file.sh                        |   26 ++--
 t/t1300-repo-config.sh                     |    2 +-
 t/t1503-rev-parse-verify.sh                |   10 +-
 t/t3040-subprojects-basic.sh               |    2 +-
 t/t3200-branch.sh                          |   30 +++---
 t/t3406-rebase-message.sh                  |   16 ++--
 t/t4002-diff-basic.sh                      |    4 +-
 t/t4010-diff-pathspec.sh                   |    4 +-
 t/t5300-pack-object.sh                     |    6 +-
 t/t5301-sliding-window.sh                  |    6 +-
 t/t5302-pack-index.sh                      |   34 +++---
 t/t5303-pack-corruption-resilience.sh      |    4 +-
 t/t5400-send-pack.sh                       |    8 +-
 t/t5402-post-merge-hook.sh                 |   12 +-
 t/t5403-post-checkout-hook.sh              |   46 ++++----
 t/t5510-fetch.sh                           |   16 ++--
 t/t6002-rev-list-bisect.sh                 |    2 +-
 t/t6005-rev-list-count.sh                  |    6 +-
 t/t6030-bisect-porcelain.sh                |   14 +-
 t/t6120-describe.sh                        |    8 +-
 t/t7003-filter-branch.sh                   |    2 +-
 t/t7004-tag.sh                             |    4 +-
 t/t7403-submodule-sync.sh                  |    2 +-
 t/t7500-commit.sh                          |    2 +-
 t/t7810-grep.sh                            |    2 +-
 t/t9100-git-svn-basic.sh                   |   26 ++--
 t/t9104-git-svn-follow-parent.sh           |   88 +++++++-------
 t/t9107-git-svn-migrate.sh                 |   14 +-
 t/t9108-git-svn-glob.sh                    |   16 ++--
 t/t9109-git-svn-multi-glob.sh              |   20 ++--
 t/t9110-git-svn-use-svm-props.sh           |    4 +-
 t/t9118-git-svn-funky-branch-names.sh      |    6 +-
 t/t9125-git-svn-multi-glob-branch-names.sh |    6 +-
 t/t9400-git-cvsserver-server.sh            |    6 +-
 t/t9401-git-cvsserver-crlf.sh              |   12 +-
 t/t9500-gitweb-standalone-no-errors.sh     |    4 +-
 t/t9603-cvsimport-patchsets.sh             |    6 +-
 t/test-cleaner.sh                          |  185 ++++++++++++++++++++++++++++
 40 files changed, 434 insertions(+), 249 deletions(-)
 create mode 100755 t/test-cleaner.sh

-- 
1.7.6.362.gf0e6
