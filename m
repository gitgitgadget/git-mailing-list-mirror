From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 000/144] Use the $( ... ) construct for command substitution instead of using the back-quotes
Date: Mon, 24 Mar 2014 09:56:17 -0700
Message-ID: <1395680321-32427-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 17:58:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS8D9-00087w-4v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 17:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbaCXQ6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 12:58:50 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47934 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaCXQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 12:58:49 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so5709598pbc.38
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2Yt4hr3bfKdue8wlYrJNYVjY5Q5kz2woI2OkGwjWwnI=;
        b=ULbsi2yJF3Li/yl/uRXNRvavjn30JLX04pzLeg237pIWz4cELy739hIqGMad8KmL28
         nC4XUcD4AFBEJQ8e0or7HRHf4trXnqO72UYYCqAgejxo0fvJmUlgZqP7lTX0VdiWMnxz
         HZIwF2yq3MGXCTFoo6DVTQi/5hqGqAPXDisBF86PmXE5P4I4PLxsi+F0Fdo3Cf5oCOOQ
         DXsU4d41ydDx3am0Xz19ZOYY7PWOpU0uLviVRiF94Q3c8inSy16QelTBI+ZtDHT5k9Ah
         A/lJ9msT5SKXMPFE79AKigPjDnPdPawacXhaGZOSTYrjVSEVdHfaHDsAskxP8g5A21oE
         h0Iw==
X-Received: by 10.66.232.68 with SMTP id tm4mr72354399pac.114.1395680327645;
        Mon, 24 Mar 2014 09:58:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id lh13sm62392896pab.4.2014.03.24.09.58.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 09:58:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244824>

This patch series changes everywhere the back-quotes construct for comm=
and
substitution with the $( ... ).  The Git CodingGuidelines prefer=20
the $( ... ) construct for command substitution instead of using the ba=
ck-quotes
, or grave accents (`..`).
   =20
The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell. Because this construct uses distinct
opening and closing delimiters, it is much easier to follow.=20
Also now the embedded double quotes no longer need escaping.

The patch is simple but involves a large number of files with different=
 authors.=20
Being simple I think it is wasteful to cc a large number of different p=
eople
for doing a review.=20

Elia Pinto (144):
  check-builtins.sh: use the $( ... ) construct for command
    substitution
  git-am.sh: use the $( ... ) construct for command substitution
  git-pull.sh: use the $( ... ) construct for command substitution
  git-rebase--merge.sh: use the $( ... ) construct for command
    substitution
  git-rebase.sh: use the $( ... ) construct for command substitution
  git-stash.sh: use the $( ... ) construct for command substitution
  git-web--browse.sh: use the $( ... ) construct for command
    substitution
  unimplemented.sh: use the $( ... ) construct for command substitution
  t0001-init.sh: use the $( ... ) construct for command substitution
  t0010-racy-git.sh: use the $( ... ) construct for command
    substitution
  t0020-crlf.sh: use the $( ... ) construct for command substitution
  t0025-crlf-auto.sh: use the $( ... ) construct for command
    substitution
  t0026-eol-config.sh: use the $( ... ) construct for command
    substitution
  t0030-stripspace.sh: use the $( ... ) construct for command
    substitution
  t0204-gettext-reencode-sanity.sh: use the $( ... ) construct for
    command substitution
  t0300-credentials.sh: use the $( ... ) construct for command
    substitution
  t1000-read-tree-m-3way.sh: use the $( ... ) construct for command
    substitution
  t1001-read-tree-m-2way.sh: use the $( ... ) construct for command
    substitution
  t1002-read-tree-m-u-2way.sh: use the $( ... ) construct for command
    substitution
  t1003-read-tree-prefix.sh: use the $( ... ) construct for command
    substitution
  t1004-read-tree-m-u-wf.sh: use the $( ... ) construct for command
    substitution
  t1020-subdirectory.sh: use the $( ... ) construct for command
    substitution
  t1050-large.sh: use the $( ... ) construct for command substitution
  t1100-commit-tree-options.sh: use the $( ... ) construct for command
    substitution
  t1401-symbolic-ref.sh: use the $( ... ) construct for command
    substitution
  t1410-reflog.sh: use the $( ... ) construct for command substitution
  t1511-rev-parse-caret.sh: use the $( ... ) construct for command
    substitution
  t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for
    command substitution
  t2102-update-index-symlinks.sh: use the $( ... ) construct for
    command substitution
  t3030-merge-recursive.sh: use the $( ... ) construct for command
    substitution
  t3100-ls-tree-restrict.sh: use the $( ... ) construct for command
    substitution
  t3101-ls-tree-dirname.sh: use the $( ... ) construct for command
    substitution
  t3210-pack-refs.sh: use the $( ... ) construct for command
    substitution
  t3403-rebase-skip.sh: use the $( ... ) construct for command
    substitution
  t3511-cherry-pick-x.sh: use the $( ... ) construct for command
    substitution
  t3600-rm.sh: use the $( ... ) construct for command substitution
  t3700-add.sh: use the $( ... ) construct for command substitution
  t3905-stash-include-untracked.sh: use the $( ... ) construct for
    command substitution
  t3910-mac-os-precompose.sh: use the $( ... ) construct for command
    substitution
  t4006-diff-mode.sh: use the $( ... ) construct for command
    substitution
  t4010-diff-pathspec.sh: use the $( ... ) construct for command
    substitution
  t4012-diff-binary.sh: use the $( ... ) construct for command
    substitution
  t4013-diff-various.sh: use the $( ... ) construct for command
    substitution
  t4014-format-patch.sh: use the $( ... ) construct for command
    substitution
  t4036-format-patch-signer-mime.sh: use the $( ... ) construct for
    command substitution
  t4038-diff-combined.sh: use the $( ... ) construct for command
    substitution
  t4057-diff-combined-paths.sh: use the $( ... ) construct for command
    substitution
  t4116-apply-reverse.sh: use the $( ... ) construct for command
    substitution
  t4119-apply-config.sh: use the $( ... ) construct for command
    substitution
  t4204-patch-id.sh: use the $( ... ) construct for command
    substitution
  t5000-tar-tree.sh: use the $( ... ) construct for command
    substitution
  t5003-archive-zip.sh: use the $( ... ) construct for command
    substitution
  t5100-mailinfo.sh: use the $( ... ) construct for command
    substitution
  t5300-pack-object.sh: use the $( ... ) construct for command
    substitution
  t5301-sliding-window.sh: use the $( ... ) construct for command
    substitution
  t5302-pack-index.sh: use the $( ... ) construct for command
    substitution
  t5303-pack-corruption-resilience.sh: use the $( ... ) construct for
    command substitution
  t5304-prune.sh: use the $( ... ) construct for command substitution
  t5305-include-tag.sh: use the $( ... ) construct for command
    substitution
  t5500-fetch-pack.sh: use the $( ... ) construct for command
    substitution
  t5505-remote.sh: use the $( ... ) construct for command substitution
  t5506-remote-groups.sh: use the $( ... ) construct for command
    substitution
  t5510-fetch.sh: use the $( ... ) construct for command substitution
  t5515-fetch-merge-logic.sh: use the $( ... ) construct for command
    substitution
  t5516-fetch-push.sh: use the $( ... ) construct for command
    substitution
  t5517-push-mirror.sh: use the $( ... ) construct for command
    substitution
  t5520-pull.sh: use the $( ... ) construct for command substitution
  t5522-pull-symlink.sh: use the $( ... ) construct for command
    substitution
  t5530-upload-pack-error.sh: use the $( ... ) construct for command
    substitution
  t5537-fetch-shallow.sh: use the $( ... ) construct for command
    substitution
  t5538-push-shallow.sh: use the $( ... ) construct for command
    substitution
  t5550-http-fetch-dumb.sh: use the $( ... ) construct for command
    substitution
  t5551-http-fetch-smart.sh: use the $( ... ) construct for command
    substitution
  t5570-git-daemon.sh: use the $( ... ) construct for command
    substitution
  t5601-clone.sh: use the $( ... ) construct for command substitution
  t5700-clone-reference.sh: use the $( ... ) construct for command
    substitution
  t5710-info-alternate.sh: use the $( ... ) construct for command
    substitution
  t5900-repo-selection.sh: use the $( ... ) construct for command
    substitution
  t6001-rev-list-graft.sh: use the $( ... ) construct for command
    substitution
  t6002-rev-list-bisect.sh: use the $( ... ) construct for command
    substitution
  t6015-rev-list-show-all-parents.sh: use the $( ... ) construct for
    command substitution
  t6032-merge-large-rename.sh: use the $( ... ) construct for command
    substitution
  t6034-merge-rename-nocruft.sh: use the $( ... ) construct for command
    substitution
  t6111-rev-list-treesame.sh: use the $( ... ) construct for command
    substitution
  t6132-pathspec-exclude.sh: use the $( ... ) construct for command
    substitution
  t7001-mv.sh: use the $( ... ) construct for command substitution
  t7003-filter-branch.sh: use the $( ... ) construct for command
    substitution
  t7004-tag.sh: use the $( ... ) construct for command substitution
  t7006-pager.sh: use the $( ... ) construct for command substitution
  t7103-reset-bare.sh: use the $( ... ) construct for command
    substitution
  t7406-submodule-update.sh: use the $( ... ) construct for command
    substitution
  t7408-submodule-reference.sh: use the $( ... ) construct for command
    substitution
  t7504-commit-msg-hook.sh: use the $( ... ) construct for command
    substitution
  t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for
    command substitution
  t7602-merge-octopus-many.sh: use the $( ... ) construct for command
    substitution
  t7700-repack.sh: use the $( ... ) construct for command substitution
  t8003-blame-corner-cases.sh: use the $( ... ) construct for command
    substitution
  t9001-send-email.sh: use the $( ... ) construct for command
    substitution
  t9101-git-svn-props.sh: use the $( ... ) construct for command
    substitution
  t9104-git-svn-follow-parent.sh: use the $( ... ) construct for
    command substitution
  t9105-git-svn-commit-diff.sh: use the $( ... ) construct for command
    substitution
  t9107-git-svn-migrate.sh: use the $( ... ) construct for command
    substitution
  t9108-git-svn-glob.sh: use the $( ... ) construct for command
    substitution
  t9109-git-svn-multi-glob.sh: use the $( ... ) construct for command
    substitution
  t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for
    command substitution
  t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for
    command substitution
  t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct for
    command substitution
  t9119-git-svn-info.sh: use the $( ... ) construct for command
    substitution
  t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct for
    command substitution
  t9130-git-svn-authors-file.sh: use the $( ... ) construct for command
    substitution
  t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for
    command substitution
  t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct
    for command substitution
  t9138-git-svn-authors-prog.sh: use the $( ... ) construct for command
    substitution
  t9145-git-svn-master-branch.sh: use the $( ... ) construct for
    command substitution
  t9150-svk-mergetickets.sh: use the $( ... ) construct for command
    substitution
  t9300-fast-import.sh: use the $( ... ) construct for command
    substitution
  t9350-fast-export.sh: use the $( ... ) construct for command
    substitution
  t9501-gitweb-standalone-http-status.sh: use the $( ... ) construct
    for command substitution
  t9901-git-web--browse.sh: use the $( ... ) construct for command
    substitution
  test-lib-functions.sh: use the $( ... ) construct for command
    substitution
  lib-credential.sh: use the $( ... ) construct for command
    substitution
  lib-cvs.sh: use the $( ... ) construct for command substitution
  lib-gpg.sh: use the $( ... ) construct for command substitution
  p5302-pack-index.sh: use the $( ... ) construct for command
    substitution
  howto-index.sh: use the $( ... ) construct for command substitution
  install-webdoc.sh: use the $( ... ) construct for command
    substitution
  git-checkout.sh: use the $( ... ) construct for command substitution
  git-clone.sh: use the $( ... ) construct for command substitution
  git-commit.sh: use the $( ... ) construct for command substitution
  git-fetch.sh: use the $( ... ) construct for command substitution
  git-ls-remote.sh: use the $( ... ) construct for command substitution
  git-merge.sh: use the $( ... ) construct for command substitution
  git-repack.sh: use the $( ... ) construct for command substitution
  git-resolve.sh: use the $( ... ) construct for command substitution
  git-revert.sh: use the $( ... ) construct for command substitution
  git-tag.sh: use the $( ... ) construct for command substitution
  t9360-mw-to-git-clone.sh: use the $( ... ) construct for command
    substitution
  t9362-mw-to-git-utf8.sh: use the $( ... ) construct for command
    substitution
  t9365-continuing-queries.sh: use the $( ... ) construct for command
    substitution
  test-gitmw-lib.sh: use the $( ... ) construct for command
    substitution
  t7900-subtree.sh: use the $( ... ) construct for command substitution
  appp.sh: use the $( ... ) construct for command substitution
  txt-to-pot.sh: use the $( ... ) construct for command substitution
  t9100-git-svn-basic.sh: use the $( ... ) construct for command
    substitution

 Documentation/howto-index.sh                    |   12 ++--
 Documentation/install-webdoc.sh                 |    6 +-
 check-builtins.sh                               |    4 +-
 contrib/examples/git-checkout.sh                |    8 +--
 contrib/examples/git-clone.sh                   |   20 +++----
 contrib/examples/git-commit.sh                  |   10 ++--
 contrib/examples/git-fetch.sh                   |    6 +-
 contrib/examples/git-ls-remote.sh               |    4 +-
 contrib/examples/git-merge.sh                   |    4 +-
 contrib/examples/git-repack.sh                  |    2 +-
 contrib/examples/git-resolve.sh                 |    2 +-
 contrib/examples/git-revert.sh                  |    2 +-
 contrib/examples/git-tag.sh                     |    2 +-
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh    |   14 ++---
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh     |    4 +-
 contrib/mw-to-git/t/t9365-continuing-queries.sh |    2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh           |    6 +-
 contrib/subtree/t/t7900-subtree.sh              |    2 +-
 contrib/thunderbird-patch-inline/appp.sh        |   14 ++---
 git-am.sh                                       |   30 +++++-----
 git-gui/po/glossary/txt-to-pot.sh               |    4 +-
 git-pull.sh                                     |    2 +-
 git-rebase--merge.sh                            |    4 +-
 git-rebase.sh                                   |    8 +--
 git-stash.sh                                    |    2 +-
 git-web--browse.sh                              |    6 +-
 t/lib-credential.sh                             |    2 +-
 t/lib-cvs.sh                                    |    2 +-
 t/lib-gpg.sh                                    |    2 +-
 t/perf/p5302-pack-index.sh                      |    2 +-
 t/t0001-init.sh                                 |   12 ++--
 t/t0010-racy-git.sh                             |    4 +-
 t/t0020-crlf.sh                                 |   42 +++++++-------
 t/t0025-crlf-auto.sh                            |   38 ++++++-------
 t/t0026-eol-config.sh                           |   20 +++----
 t/t0030-stripspace.sh                           |   20 +++----
 t/t0204-gettext-reencode-sanity.sh              |    2 +-
 t/t0300-credentials.sh                          |    2 +-
 t/t1000-read-tree-m-3way.sh                     |    4 +-
 t/t1001-read-tree-m-2way.sh                     |   18 +++---
 t/t1002-read-tree-m-u-2way.sh                   |   10 ++--
 t/t1003-read-tree-prefix.sh                     |    2 +-
 t/t1004-read-tree-m-u-wf.sh                     |    8 +--
 t/t1020-subdirectory.sh                         |   22 ++++----
 t/t1050-large.sh                                |    4 +-
 t/t1100-commit-tree-options.sh                  |    4 +-
 t/t1401-symbolic-ref.sh                         |    2 +-
 t/t1410-reflog.sh                               |   24 ++++----
 t/t1511-rev-parse-caret.sh                      |    4 +-
 t/t1512-rev-parse-disambiguation.sh             |    8 +--
 t/t2102-update-index-symlinks.sh                |    2 +-
 t/t3030-merge-recursive.sh                      |    2 +-
 t/t3100-ls-tree-restrict.sh                     |    2 +-
 t/t3101-ls-tree-dirname.sh                      |    2 +-
 t/t3210-pack-refs.sh                            |    2 +-
 t/t3403-rebase-skip.sh                          |    2 +-
 t/t3511-cherry-pick-x.sh                        |   14 ++---
 t/t3600-rm.sh                                   |    4 +-
 t/t3700-add.sh                                  |   16 +++---
 t/t3905-stash-include-untracked.sh              |    4 +-
 t/t3910-mac-os-precompose.sh                    |   16 +++---
 t/t4006-diff-mode.sh                            |    2 +-
 t/t4010-diff-pathspec.sh                        |    4 +-
 t/t4012-diff-binary.sh                          |   16 +++---
 t/t4013-diff-various.sh                         |    6 +-
 t/t4014-format-patch.sh                         |   10 ++--
 t/t4036-format-patch-signer-mime.sh             |    2 +-
 t/t4038-diff-combined.sh                        |    2 +-
 t/t4057-diff-combined-paths.sh                  |    2 +-
 t/t4116-apply-reverse.sh                        |   12 ++--
 t/t4119-apply-config.sh                         |    2 +-
 t/t4204-patch-id.sh                             |    4 +-
 t/t5000-tar-tree.sh                             |    6 +-
 t/t5003-archive-zip.sh                          |    2 +-
 t/t5100-mailinfo.sh                             |   12 ++--
 t/t5300-pack-object.sh                          |   18 +++---
 t/t5301-sliding-window.sh                       |   14 ++---
 t/t5302-pack-index.sh                           |   34 ++++++------
 t/t5303-pack-corruption-resilience.sh           |    8 +--
 t/t5304-prune.sh                                |    2 +-
 t/t5305-include-tag.sh                          |    8 +--
 t/t5500-fetch-pack.sh                           |   16 +++---
 t/t5505-remote.sh                               |    2 +-
 t/t5506-remote-groups.sh                        |    2 +-
 t/t5510-fetch.sh                                |   10 ++--
 t/t5515-fetch-merge-logic.sh                    |    4 +-
 t/t5516-fetch-push.sh                           |    4 +-
 t/t5517-push-mirror.sh                          |    2 +-
 t/t5520-pull.sh                                 |   10 ++--
 t/t5522-pull-symlink.sh                         |    2 +-
 t/t5530-upload-pack-error.sh                    |    2 +-
 t/t5537-fetch-shallow.sh                        |    4 +-
 t/t5538-push-shallow.sh                         |    4 +-
 t/t5550-http-fetch-dumb.sh                      |    8 +--
 t/t5551-http-fetch-smart.sh                     |    2 +-
 t/t5570-git-daemon.sh                           |    8 +--
 t/t5601-clone.sh                                |    2 +-
 t/t5700-clone-reference.sh                      |    2 +-
 t/t5710-info-alternate.sh                       |    2 +-
 t/t5900-repo-selection.sh                       |    2 +-
 t/t6001-rev-list-graft.sh                       |   12 ++--
 t/t6002-rev-list-bisect.sh                      |    6 +-
 t/t6015-rev-list-show-all-parents.sh            |    6 +-
 t/t6032-merge-large-rename.sh                   |    2 +-
 t/t6034-merge-rename-nocruft.sh                 |    2 +-
 t/t6111-rev-list-treesame.sh                    |    2 +-
 t/t6132-pathspec-exclude.sh                     |    2 +-
 t/t7001-mv.sh                                   |    4 +-
 t/t7003-filter-branch.sh                        |    6 +-
 t/t7004-tag.sh                                  |   16 +++---
 t/t7006-pager.sh                                |    2 +-
 t/t7103-reset-bare.sh                           |    2 +-
 t/t7406-submodule-update.sh                     |    4 +-
 t/t7408-submodule-reference.sh                  |    2 +-
 t/t7504-commit-msg-hook.sh                      |    2 +-
 t/t7505-prepare-commit-msg-hook.sh              |   32 +++++------
 t/t7602-merge-octopus-many.sh                   |    8 +--
 t/t7700-repack.sh                               |    4 +-
 t/t8003-blame-corner-cases.sh                   |    4 +-
 t/t9001-send-email.sh                           |   10 ++--
 t/t9100-git-svn-basic.sh                        |   24 ++++----
 t/t9101-git-svn-props.sh                        |   30 +++++-----
 t/t9104-git-svn-follow-parent.sh                |   48 ++++++++-------=
-
 t/t9105-git-svn-commit-diff.sh                  |    4 +-
 t/t9107-git-svn-migrate.sh                      |   16 +++---
 t/t9108-git-svn-glob.sh                         |   20 +++----
 t/t9109-git-svn-multi-glob.sh                   |   32 +++++------
 t/t9110-git-svn-use-svm-props.sh                |    2 +-
 t/t9114-git-svn-dcommit-merge.sh                |   12 ++--
 t/t9118-git-svn-funky-branch-names.sh           |    2 +-
 t/t9119-git-svn-info.sh                         |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh          |    4 +-
 t/t9130-git-svn-authors-file.sh                 |   12 ++--
 t/t9132-git-svn-broken-symlink.sh               |    4 +-
 t/t9137-git-svn-dcommit-clobber-series.sh       |   24 ++++----
 t/t9138-git-svn-authors-prog.sh                 |    2 +-
 t/t9145-git-svn-master-branch.sh                |    4 +-
 t/t9150-svk-mergetickets.sh                     |    2 +-
 t/t9300-fast-import.sh                          |   68 +++++++++++----=
--------
 t/t9350-fast-export.sh                          |    6 +-
 t/t9501-gitweb-standalone-http-status.sh        |    6 +-
 t/t9901-git-web--browse.sh                      |    2 +-
 t/test-lib-functions.sh                         |    8 +--
 unimplemented.sh                                |    2 +-
 144 files changed, 611 insertions(+), 611 deletions(-)

--=20
1.7.10.4
