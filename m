From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 00/16] Add missing &&'s in the testsuite
Date: Sun,  3 Oct 2010 13:59:58 -0600
Message-ID: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uhy-0002r3-2m
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0JCT6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45640 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0JCT6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:42 -0400
Received: by pvg2 with SMTP id 2so1157782pvg.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=+BiPKYGH86QPq+UPOUia3R7/D0zUZiKQ07Lk6HSL1aQ=;
        b=Bv6wRYpY4m0jgrb8Nm6pCniD16T7rdiyEFfNB4qHYZEMNiEICvV9DFpg9dSAe/pHzb
         /Ijd/MLaafuptMazfxYINJIuKx6L+UyKZKGq8qp5xGB2NfykHqE1xveF3i1tSNYD8o59
         l8bJZsNaFP3jYfmretPShbp3RotXivNX/i6lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=l7BESLfmoP+RbF2l7PYU6VwxEPoQufoIh1MD2t7aTYZm9Z7S8ScYBnxpr8oyK6QkLn
         PrDxS48JpY/Btxd7Frn44Rd/aGrscVYxhc+6a6PZU+O4CM5/dx3nD8PbOCd/2o1OorEx
         wt9YXherri44FG7Z4lxEYQAkIP9JL3gmfEcmM=
Received: by 10.114.12.15 with SMTP id 15mr595641wal.13.1286135922032;
        Sun, 03 Oct 2010 12:58:42 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157903>

This patch series fixes many of the missing &&s in the testsuite.
Thanks to Junio, Jonathan, and =C3=86var for lots of time reviewing and
making suggestions so far.

Changes since v5:
  * Made changes suggested by Jonathan on v4.  Notable items remaining:
    * In patch 1, I made two of the changes suggested by Jonathan, but
      this was =C3=86var's patch so he may want to comment on those.  A=
lso,
      Jonathan had a few extra questions in the last round that
      perhaps =C3=86var may want to comment on.
    * In patch 7 (t3600), there's still an outstanding question about
      what and how to change it.
    * In patch 15, (the t1509 test), Jonathan pointed out a potential
      problem, and I'm unsure whether the change I made is what is
      wanted.

Elijah Newren (15):
  t3020 (ls-files-error-unmatch): remove stray '1' from end of file
  t4017 (diff-retval): replace manual exit code check with
    test_expect_code
  t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
  t4002 (diff-basic): use test_might_fail for commands that might fail
  t4202 (log): Replace '<git-command> || :' with test_might_fail
  t3600 (rm): add lots of missing &&
  t4019 (diff-wserror): add lots of missing &&
  t4026 (color): remove unneeded and unchained command
  t5602 (clone-remote-exec): add missing &&
  t6016 (rev-list-graph-simplify-history): add missing &&
  t7001 (mv): add missing &&
  t7601 (merge-pull-config): add missing &&
  t7800 (difftool): add missing &&
  Add missing &&'s throughout the testsuite
  Introduce portable_unset and use it to ensure proper && chaining

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  test-lib: make test_expect_code a test command

 t/README                                    |   29 +++++------
 t/t0000-basic.sh                            |   55 +++++++++++++++++--=
--
 t/t0001-init.sh                             |   30 ++++++------
 t/t0003-attributes.sh                       |   45 ++++++++---------
 t/t0020-crlf.sh                             |    2 +-
 t/t0024-crlf-archive.sh                     |    4 +-
 t/t0026-eol-config.sh                       |    2 +-
 t/t0050-filesystem.sh                       |    6 +-
 t/t1000-read-tree-m-3way.sh                 |    2 +-
 t/t1001-read-tree-m-2way.sh                 |   18 ++++----
 t/t1002-read-tree-m-u-2way.sh               |   10 ++--
 t/t1302-repo-version.sh                     |    2 +-
 t/t1401-symbolic-ref.sh                     |    2 +-
 t/t1402-check-ref-format.sh                 |    4 +-
 t/t1410-reflog.sh                           |    8 ++--
 t/t1501-worktree.sh                         |    2 +-
 t/t1504-ceiling-dirs.sh                     |    5 +-
 t/t1509-root-worktree.sh                    |    5 +-
 t/t2007-checkout-symlink.sh                 |    2 +-
 t/t2016-checkout-patch.sh                   |    2 +-
 t/t2050-git-dir-relative.sh                 |    4 +-
 t/t2103-update-index-ignore-missing.sh      |    2 +-
 t/t2200-add-update.sh                       |    2 +-
 t/t3001-ls-files-others-exclude.sh          |    2 +-
 t/t3020-ls-files-error-unmatch.sh           |    1 -
 t/t3050-subprojects-fetch.sh                |    4 +-
 t/t3203-branch-output.sh                    |    6 +-
 t/t3307-notes-man.sh                        |    2 +-
 t/t3406-rebase-message.sh                   |    6 +-
 t/t3408-rebase-multi-line.sh                |    2 +-
 t/t3504-cherry-pick-rerere.sh               |    4 +-
 t/t3600-rm.sh                               |   38 +++++++--------
 t/t3903-stash.sh                            |    4 +-
 t/t3904-stash-patch.sh                      |    2 +-
 t/t4002-diff-basic.sh                       |   12 ++--
 t/t4017-diff-retval.sh                      |   69 ++++++++-----------=
--------
 t/t4019-diff-wserror.sh                     |   53 ++++++++++---------=
-
 t/t4021-format-patch-numbered.sh            |    2 +-
 t/t4026-color.sh                            |    1 -
 t/t4027-diff-submodule.sh                   |    2 +-
 t/t4103-apply-binary.sh                     |    8 ++--
 t/t4104-apply-boundary.sh                   |    4 +-
 t/t4111-apply-subdir.sh                     |    4 +-
 t/t4119-apply-config.sh                     |    2 +-
 t/t4124-apply-ws-rule.sh                    |    4 +-
 t/t4127-apply-same-fn.sh                    |   18 ++++----
 t/t4130-apply-criss-cross-rename.sh         |    2 +-
 t/t4133-apply-filenames.sh                  |    6 +-
 t/t4150-am.sh                               |    2 +-
 t/t4202-log.sh                              |    2 +-
 t/t5300-pack-object.sh                      |    4 +-
 t/t5301-sliding-window.sh                   |    2 +-
 t/t5302-pack-index.sh                       |    2 +-
 t/t5500-fetch-pack.sh                       |    2 +-
 t/t5502-quickfetch.sh                       |    2 +-
 t/t5503-tagfollow.sh                        |    4 +-
 t/t5510-fetch.sh                            |    2 +-
 t/t5516-fetch-push.sh                       |   20 ++++----
 t/t5517-push-mirror.sh                      |   10 ++--
 t/t5519-push-alternates.sh                  |    2 +-
 t/t5531-deep-submodule-push.sh              |    2 +-
 t/t5541-http-push.sh                        |    2 +-
 t/t5550-http-fetch.sh                       |    6 +--
 t/t5601-clone.sh                            |    6 +-
 t/t5602-clone-remote-exec.sh                |   22 ++++++---
 t/t5701-clone-local.sh                      |    8 ++--
 t/t5705-clone-2gb.sh                        |    2 +-
 t/t6009-rev-list-parent.sh                  |    2 +-
 t/t6010-merge-base.sh                       |    2 +-
 t/t6016-rev-list-graph-simplify-history.sh  |   29 ++++-------
 t/t6020-merge-df.sh                         |    4 +-
 t/t6022-merge-rename.sh                     |    2 +-
 t/t6024-recursive-merge.sh                  |    2 +-
 t/t6030-bisect-porcelain.sh                 |    8 ++--
 t/t6040-tracking-info.sh                    |    2 +-
 t/t7001-mv.sh                               |    2 +-
 t/t7004-tag.sh                              |   14 +++---
 t/t7006-pager.sh                            |   10 ++--
 t/t7105-reset-patch.sh                      |    6 +-
 t/t7300-clean.sh                            |    8 ++--
 t/t7501-commit.sh                           |    2 +-
 t/t7502-commit.sh                           |    6 +-
 t/t7506-status-submodule.sh                 |    2 +-
 t/t7600-merge.sh                            |    2 +-
 t/t7601-merge-pull-config.sh                |   12 ++--
 t/t7610-mergetool.sh                        |    2 +-
 t/t7700-repack.sh                           |    2 +-
 t/t7800-difftool.sh                         |   12 ++--
 t/t8003-blame.sh                            |    6 +-
 t/t9122-git-svn-author.sh                   |    4 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9134-git-svn-ignore-paths.sh             |    6 +-
 t/t9137-git-svn-dcommit-clobber-series.sh   |    2 +-
 t/t9138-git-svn-authors-prog.sh             |    6 +-
 t/t9146-git-svn-empty-dirs.sh               |    6 +-
 t/t9151-svn-mergeinfo.sh                    |   22 ++++----
 t/t9200-git-cvsexportcommit.sh              |    4 +-
 t/t9401-git-cvsserver-crlf.sh               |    2 +-
 t/t9600-cvsimport.sh                        |    2 +-
 t/test-lib.sh                               |   51 +++++++++++++------=
-
 100 files changed, 429 insertions(+), 418 deletions(-)

--=20
1.7.3.1.66.gab790
