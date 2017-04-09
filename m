Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5681FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbdDITLi (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:38 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35072 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdDITLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:34 -0400
Received: by mail-wm0-f43.google.com with SMTP id w64so24333045wma.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/Aqys+NnidrZBBppdvXL8MZviTn+eXnMlmXw/KXVyw=;
        b=GEG5Fi5W10cUrNikvJCQd1tPrU/Sq3Qb7O5zHeoGaIt01DMbzWwM+31S+pja+JJj6i
         SwJ/ha73SeUpdqngTszdXvMZ1gLQcRWeL0xvwWDrpTuEdrRUDqcYCr504ZnCdaJIpsOa
         r1dvDVHR524AE4rwGliC274dUZAwzTmwFWn1pikv6ly8LkXd+DxzPmmwnhhp/RCfuJya
         UYTivlwEVFR0zF4ktPNs3hs99jFDEgggrhp0ZQ6jW5D1jxxQnKfY5mYx/GDUNRLhpcXL
         JlWSB0j/RTUVIlMIbjpn/5nvduwPeHz6Sp7beV8AIqml8KWW0PXhhPUsA6UDnTpK/02f
         nRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/Aqys+NnidrZBBppdvXL8MZviTn+eXnMlmXw/KXVyw=;
        b=dPqcd3xTxRsWmPGCy2/ONiEKFYwQZHgCF/lqn1Qqi4lW5guBMysLtKeiReQpv0H9K2
         qQJ3Bdy1LAXtG16EcSkY4ICjSHAI2vsoVbVDT4lH6uoSymX1/DaY5WGh4CUXgWW1tqDk
         cjG6G0sDSBAuok8dcyJtrthY1XS1FJJrM34qrMRoQnwXO5swGqAzyVlkHadgrlIY5HFd
         jH8lB7C8gUhoObf0ilR5eQuDPvkE0zDm21P74xcsaPOtmr47mDgwx7dELGYnSZhk/SHn
         1JCSnVjZp5lqByeJmYT2WoPLZfUmMbXhGeKuncWNeIuDHNZoGMq8wfDs5kt/vtswYleM
         ZK1A==
X-Gm-Message-State: AN3rC/7pCMfDCsZNyYOfmWtNTjKtt3o05oxDJOhgP4yX0uf0T83KAjbz
        t/Q+ENpUQrSE9Q==
X-Received: by 10.28.125.137 with SMTP id y131mr4234068wmc.141.1491765090140;
        Sun, 09 Apr 2017 12:11:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b82sm7363895wmh.4.2017.04.09.12.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Apr 2017 12:11:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] tests: mark tests that fail when the TEST_DIRECTORY is unusual
Date:   Sun,  9 Apr 2017 19:11:16 +0000
Message-Id: <20170409191117.25175-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170409191117.25175-1-avarab@gmail.com>
References: <20170409191117.25175-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark tests that fail when the TEST_DIRECTORY has a name that's
unusual, i.e. contains control characters, various punctuation etc.

This change is followed by a change that adds the code that picks up
test_fails_on_unusual_directory_names to test-lib.sh, but comes before
that change to not break most of the test suite during bisecting.

This change is the result of:

    for f in $(grep -B3 last_fail_time .prove |grep sh | perl -pe 's/^  (.*?):/$1/');
        do perl -0666 -pi -e 's/^(test_description)/test_fails_on_unusual_directory_names=1\n$1/m' $f
    done

After running the test suite with the aforementioned change to
test-lib.sh. The only exception is t0000-basic.sh, since its testing
the test suite itself its failing 'test --verbose' test needs a change
to the test suite wrapper code to be excluded.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh                                 | 2 ++
 t/t0003-attributes.sh                            | 1 +
 t/t0021-conversion.sh                            | 1 +
 t/t0060-path-utils.sh                            | 1 +
 t/t0300-credentials.sh                           | 1 +
 t/t0302-credential-store.sh                      | 1 +
 t/t1006-cat-file.sh                              | 1 +
 t/t1013-read-tree-submodule.sh                   | 1 +
 t/t1020-subdirectory.sh                          | 1 +
 t/t1050-large.sh                                 | 1 +
 t/t1060-object-corruption.sh                     | 1 +
 t/t1300-repo-config.sh                           | 1 +
 t/t1305-config-include.sh                        | 1 +
 t/t1308-config-set.sh                            | 1 +
 t/t1309-early-config.sh                          | 1 +
 t/t1500-rev-parse.sh                             | 1 +
 t/t1504-ceiling-dirs.sh                          | 1 +
 t/t1507-rev-parse-upstream.sh                    | 1 +
 t/t1510-repo-setup.sh                            | 1 +
 t/t1515-rev-parse-outside-repo.sh                | 1 +
 t/t2013-checkout-submodule.sh                    | 1 +
 t/t2025-worktree-add.sh                          | 1 +
 t/t2027-worktree-list.sh                         | 1 +
 t/t2028-worktree-move.sh                         | 1 +
 t/t3040-subprojects-basic.sh                     | 1 +
 t/t3050-subprojects-fetch.sh                     | 1 +
 t/t3409-rebase-preserve-merges.sh                | 1 +
 t/t3426-rebase-submodule.sh                      | 1 +
 t/t3501-revert-cherry-pick.sh                    | 1 +
 t/t3512-cherry-pick-submodule.sh                 | 1 +
 t/t3513-revert-submodule.sh                      | 1 +
 t/t3600-rm.sh                                    | 1 +
 t/t3900-i18n-commit.sh                           | 1 +
 t/t3906-stash-submodule.sh                       | 1 +
 t/t4027-diff-submodule.sh                        | 1 +
 t/t4030-diff-textconv.sh                         | 1 +
 t/t4031-diff-rewrite-binary.sh                   | 1 +
 t/t4035-diff-quiet.sh                            | 1 +
 t/t4041-diff-submodule-option.sh                 | 1 +
 t/t4059-diff-submodule-not-initialized.sh        | 1 +
 t/t4060-diff-submodule-option-diff-format.sh     | 1 +
 t/t4137-apply-submodule.sh                       | 1 +
 t/t4203-mailmap.sh                               | 1 +
 t/t4207-log-decoration-colors.sh                 | 1 +
 t/t4255-am-submodule.sh                          | 1 +
 t/t5000-tar-tree.sh                              | 1 +
 t/t5001-archive-attr.sh                          | 1 +
 t/t5002-archive-attr-pattern.sh                  | 1 +
 t/t5003-archive-zip.sh                           | 1 +
 t/t5150-request-pull.sh                          | 1 +
 t/t5300-pack-object.sh                           | 1 +
 t/t5304-prune.sh                                 | 1 +
 t/t5305-include-tag.sh                           | 1 +
 t/t5306-pack-nobase.sh                           | 1 +
 t/t5310-pack-bitmaps.sh                          | 1 +
 t/t5311-pack-bitmaps-shallow.sh                  | 1 +
 t/t5400-send-pack.sh                             | 1 +
 t/t5401-update-hooks.sh                          | 1 +
 t/t5402-post-merge-hook.sh                       | 1 +
 t/t5403-post-checkout-hook.sh                    | 1 +
 t/t5404-tracking-branches.sh                     | 1 +
 t/t5406-remote-rejects.sh                        | 1 +
 t/t5407-post-rewrite-hook.sh                     | 1 +
 t/t5500-fetch-pack.sh                            | 1 +
 t/t5501-fetch-push-alternates.sh                 | 1 +
 t/t5502-quickfetch.sh                            | 1 +
 t/t5505-remote.sh                                | 1 +
 t/t5509-fetch-push-namespaces.sh                 | 1 +
 t/t5510-fetch.sh                                 | 1 +
 t/t5512-ls-remote.sh                             | 1 +
 t/t5514-fetch-multiple.sh                        | 1 +
 t/t5515-fetch-merge-logic.sh                     | 1 +
 t/t5516-fetch-push.sh                            | 1 +
 t/t5519-push-alternates.sh                       | 1 +
 t/t5520-pull.sh                                  | 1 +
 t/t5521-pull-options.sh                          | 1 +
 t/t5522-pull-symlink.sh                          | 1 +
 t/t5524-pull-msg.sh                              | 1 +
 t/t5525-fetch-tagopt.sh                          | 1 +
 t/t5526-fetch-submodules.sh                      | 1 +
 t/t5527-fetch-odd-refs.sh                        | 1 +
 t/t5531-deep-submodule-push.sh                   | 1 +
 t/t5533-push-cas.sh                              | 1 +
 t/t5535-fetch-push-symref.sh                     | 1 +
 t/t5536-fetch-conflicts.sh                       | 1 +
 t/t5537-fetch-shallow.sh                         | 1 +
 t/t5538-push-shallow.sh                          | 1 +
 t/t5539-fetch-http-shallow.sh                    | 1 +
 t/t5540-http-push-webdav.sh                      | 1 +
 t/t5541-http-push-smart.sh                       | 1 +
 t/t5542-push-http-shallow.sh                     | 1 +
 t/t5544-pack-objects-hook.sh                     | 1 +
 t/t5545-push-options.sh                          | 1 +
 t/t5547-push-quarantine.sh                       | 1 +
 t/t5550-http-fetch-dumb.sh                       | 1 +
 t/t5551-http-fetch-smart.sh                      | 1 +
 t/t5560-http-backend-noserver.sh                 | 1 +
 t/t5561-http-backend.sh                          | 1 +
 t/t5570-git-daemon.sh                            | 1 +
 t/t5572-pull-submodule.sh                        | 1 +
 t/t5600-clone-fail-cleanup.sh                    | 1 +
 t/t5601-clone.sh                                 | 1 +
 t/t5604-clone-reference.sh                       | 1 +
 t/t5605-clone-local.sh                           | 1 +
 t/t5606-clone-options.sh                         | 1 +
 t/t5609-clone-branch.sh                          | 1 +
 t/t5610-clone-detached.sh                        | 1 +
 t/t5611-clone-config.sh                          | 1 +
 t/t5612-clone-refspec.sh                         | 1 +
 t/t5613-info-alternate.sh                        | 1 +
 t/t5614-clone-submodules.sh                      | 1 +
 t/t5615-alternate-env.sh                         | 1 +
 t/t5801-remote-helpers.sh                        | 1 +
 t/t5802-connect-helper.sh                        | 1 +
 t/t5810-proto-disable-local.sh                   | 1 +
 t/t5812-proto-disable-http.sh                    | 1 +
 t/t5813-proto-disable-ssh.sh                     | 1 +
 t/t5814-proto-disable-ext.sh                     | 1 +
 t/t5815-submodule-protos.sh                      | 1 +
 t/t5900-repo-selection.sh                        | 1 +
 t/t6008-rev-list-submodule.sh                    | 1 +
 t/t6030-bisect-porcelain.sh                      | 1 +
 t/t6040-tracking-info.sh                         | 1 +
 t/t6041-bisect-submodule.sh                      | 1 +
 t/t6050-replace.sh                               | 1 +
 t/t6060-merge-index.sh                           | 1 +
 t/t6134-pathspec-in-submodule.sh                 | 1 +
 t/t6200-fmt-merge-msg.sh                         | 1 +
 t/t6500-gc.sh                                    | 1 +
 t/t7001-mv.sh                                    | 1 +
 t/t7003-filter-branch.sh                         | 1 +
 t/t7005-editor.sh                                | 1 +
 t/t7006-pager.sh                                 | 1 +
 t/t7008-grep-binary.sh                           | 1 +
 t/t7010-setup.sh                                 | 1 +
 t/t7064-wtstatus-pv2.sh                          | 1 +
 t/t7103-reset-bare.sh                            | 1 +
 t/t7112-reset-submodule.sh                       | 1 +
 t/t7300-clean.sh                                 | 1 +
 t/t7400-submodule-basic.sh                       | 1 +
 t/t7402-submodule-rebase.sh                      | 1 +
 t/t7403-submodule-sync.sh                        | 1 +
 t/t7405-submodule-merge.sh                       | 1 +
 t/t7406-submodule-update.sh                      | 1 +
 t/t7407-submodule-foreach.sh                     | 1 +
 t/t7408-submodule-reference.sh                   | 1 +
 t/t7409-submodule-detached-work-tree.sh          | 1 +
 t/t7410-submodule-checkout-to.sh                 | 1 +
 t/t7411-submodule-config.sh                      | 1 +
 t/t7413-submodule-is-active.sh                   | 1 +
 t/t7504-commit-msg-hook.sh                       | 1 +
 t/t7506-status-submodule.sh                      | 1 +
 t/t7507-commit-verbose.sh                        | 1 +
 t/t7517-per-repo-email.sh                        | 1 +
 t/t7613-merge-submodule.sh                       | 1 +
 t/t7700-repack.sh                                | 1 +
 t/t7800-difftool.sh                              | 1 +
 t/t7810-grep.sh                                  | 1 +
 t/t7814-grep-recurse-submodules.sh               | 1 +
 t/t9001-send-email.sh                            | 1 +
 t/t9020-remote-svn.sh                            | 1 +
 t/t9100-git-svn-basic.sh                         | 1 +
 t/t9101-git-svn-props.sh                         | 1 +
 t/t9102-git-svn-deep-rmdir.sh                    | 1 +
 t/t9103-git-svn-tracked-directory-removed.sh     | 1 +
 t/t9104-git-svn-follow-parent.sh                 | 1 +
 t/t9105-git-svn-commit-diff.sh                   | 1 +
 t/t9106-git-svn-commit-diff-clobber.sh           | 1 +
 t/t9107-git-svn-migrate.sh                       | 1 +
 t/t9108-git-svn-glob.sh                          | 1 +
 t/t9109-git-svn-multi-glob.sh                    | 1 +
 t/t9110-git-svn-use-svm-props.sh                 | 1 +
 t/t9114-git-svn-dcommit-merge.sh                 | 1 +
 t/t9115-git-svn-dcommit-funky-renames.sh         | 1 +
 t/t9116-git-svn-log.sh                           | 1 +
 t/t9117-git-svn-init-clone.sh                    | 1 +
 t/t9118-git-svn-funky-branch-names.sh            | 1 +
 t/t9120-git-svn-clone-with-percent-escapes.sh    | 1 +
 t/t9122-git-svn-author.sh                        | 1 +
 t/t9123-git-svn-rebuild-with-rewriteroot.sh      | 1 +
 t/t9124-git-svn-dcommit-auto-props.sh            | 1 +
 t/t9125-git-svn-multi-glob-branch-names.sh       | 1 +
 t/t9127-git-svn-partial-rebuild.sh               | 1 +
 t/t9128-git-svn-cmd-branch.sh                    | 1 +
 t/t9129-git-svn-i18n-commitencoding.sh           | 1 +
 t/t9131-git-svn-empty-symlink.sh                 | 1 +
 t/t9132-git-svn-broken-symlink.sh                | 1 +
 t/t9133-git-svn-nested-git-repo.sh               | 1 +
 t/t9134-git-svn-ignore-paths.sh                  | 1 +
 t/t9137-git-svn-dcommit-clobber-series.sh        | 1 +
 t/t9138-git-svn-authors-prog.sh                  | 1 +
 t/t9140-git-svn-reset.sh                         | 1 +
 t/t9141-git-svn-multiple-branches.sh             | 1 +
 t/t9142-git-svn-shallow-clone.sh                 | 1 +
 t/t9143-git-svn-gc.sh                            | 1 +
 t/t9144-git-svn-old-rev_map.sh                   | 1 +
 t/t9145-git-svn-master-branch.sh                 | 1 +
 t/t9146-git-svn-empty-dirs.sh                    | 1 +
 t/t9147-git-svn-include-paths.sh                 | 1 +
 t/t9148-git-svn-propset.sh                       | 1 +
 t/t9150-svk-mergetickets.sh                      | 1 +
 t/t9151-svn-mergeinfo.sh                         | 1 +
 t/t9153-git-svn-rewrite-uuid.sh                  | 1 +
 t/t9154-git-svn-fancy-glob.sh                    | 1 +
 t/t9155-git-svn-fetch-deleted-tag.sh             | 1 +
 t/t9156-git-svn-fetch-deleted-tag-2.sh           | 1 +
 t/t9157-git-svn-fetch-merge.sh                   | 1 +
 t/t9158-git-svn-mergeinfo.sh                     | 1 +
 t/t9159-git-svn-no-parent-mergeinfo.sh           | 1 +
 t/t9160-git-svn-preserve-empty-dirs.sh           | 1 +
 t/t9161-git-svn-mergeinfo-push.sh                | 1 +
 t/t9162-git-svn-dcommit-interactive.sh           | 1 +
 t/t9163-git-svn-reset-clears-caches.sh           | 1 +
 t/t9164-git-svn-dcommit-concurrent.sh            | 1 +
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  | 1 +
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh | 1 +
 t/t9167-git-svn-cmd-branch-subproject.sh         | 1 +
 t/t9168-git-svn-partially-globbed-names.sh       | 1 +
 t/t9200-git-cvsexportcommit.sh                   | 1 +
 t/t9300-fast-import.sh                           | 1 +
 t/t9350-fast-export.sh                           | 1 +
 t/t9400-git-cvsserver-server.sh                  | 1 +
 t/t9401-git-cvsserver-crlf.sh                    | 1 +
 t/t9402-git-cvsserver-refs.sh                    | 1 +
 t/t9500-gitweb-standalone-no-errors.sh           | 1 +
 t/t9502-gitweb-standalone-parse-output.sh        | 1 +
 t/t9600-cvsimport.sh                             | 1 +
 t/t9601-cvsimport-vendor-branch.sh               | 1 +
 t/t9602-cvsimport-branches-tags.sh               | 1 +
 t/t9604-cvsimport-timestamps.sh                  | 1 +
 t/t9700-perl-git.sh                              | 1 +
 t/t9902-completion.sh                            | 1 +
 232 files changed, 233 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 1aa5093f36..8afda030a5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test the very basics part #1.
 
 The rest of the test suite does not check the basic operation of git
@@ -56,6 +57,7 @@ _run_sub_test_lib_test_common () {
 		cat >"$name.sh" <<-EOF &&
 		#!$SHELL_PATH
 
+		test_fails_on_unusual_directory_names=1
 		test_description='$descr (run in sub test-lib)
 
 		This is run in a sub test-lib so that we do not get incorrect
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f19ae4f8cc..812f25f8e9 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description=gitattributes
 
 . ./test-lib.sh
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f560446..c1db6d6136 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 444b5a4df8..a53195102f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 David Reiss
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test various path utilities'
 
 . ./test-lib.sh
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 03bd31e9f2..f4814096a5 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='basic credential helper tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 1d8d1f210b..d066f4cb1a 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='credential-store tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b19f332694..2e7bb356ac 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git cat-file'
 
 . ./test-lib.sh
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index de1ba02dc5..8228c05775 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='read-tree can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index df3183ea1a..b9c5513f8a 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Try various core-level commands in subdirectory.
 '
 
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 6fd264cff0..7b058a3941 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2011, Google Inc.
 
+test_fails_on_unusual_directory_names=1
 test_description='adding and checking out large blobs'
 
 . ./test-lib.sh
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 3f8705139d..ab53e96d5c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='see how we handle various forms of corruption'
 . ./test-lib.sh
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index afcca0d52c..2a4ca101a9 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Johannes Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test git config in different settings'
 
 . ./test-lib.sh
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index e833939320..f03fda78f0 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test config file include directives'
 . ./test-lib.sh
 
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ff50960cca..449a0e3440 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test git config-set API in different settings'
 
 . ./test-lib.sh
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index b97357b8ab..99267db020 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test read_early_config()'
 
 . ./test-lib.sh
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 03d3c7f6d6..50c4a6edf5 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git rev-parse'
 . ./test-lib.sh
 
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 3d51615e42..fc20a947ed 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test GIT_CEILING_DIRECTORIES'
 . ./test-lib.sh
 
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index b23c4e3fab..dd08e4d251 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test <branch>@{upstream} syntax'
 
 . ./test-lib.sh
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 13ae12dfa7..192bd3d822 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description="Tests of cwd/prefix/worktree/gitdir setup in all cases
 
 A few rules for repo setup:
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index 3ec2971ee5..0641651612 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='check that certain rev-parse options work outside repo'
 . ./test-lib.sh
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index e8f70b806f..94d7033009 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='checkout can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b618d6be21..bd0d4633cc 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git worktree add'
 
 . ./test-lib.sh
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f368..7b5e802f71 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git worktree list'
 
 . ./test-lib.sh
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 8298aaf97f..4577add799 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git worktree move, remove, lock and unlock'
 
 . ./test-lib.sh
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d824..0acf434539 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Basic subproject functionality'
 . ./test-lib.sh
 
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 2f5f41a012..452c5fb615 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetching and pushing project with subproject'
 
 . ./test-lib.sh
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8c251c57a6..9ce4749fe6 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -2,6 +2,7 @@
 #
 # Copyright(C) 2008 Stephen Habermann & Andreas Ericsson
 #
+test_fails_on_unusual_directory_names=1
 test_description='git rebase -p should preserve merges
 
 Run "git rebase -p" and check that merges are properly carried along
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index ebf4f5e4b2..3c39d4cdf0 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='rebase can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 4f2a263b63..b8547afe5e 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test cherry-pick and revert with renames
 
   --
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 6863b7bb6f..37929530a9 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='cherry-pick can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index db9378142a..980ce5233d 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='revert can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 3c63455729..1df9b1b5f5 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Carl D. Worth
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test of the various options to git rm.'
 
 . ./test-lib.sh
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 3b94283e35..f3af7bd2db 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='commit and log output encodings'
 
 . ./test-lib.sh
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index d7219d6f8f..4d4d386342 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='stash apply can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 518bf9524e..f7c146b125 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='difference in submodules'
 
 . ./test-lib.sh
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index aad6c7f78d..74ba69efe4 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='diff.*.textconv tests'
 . ./test-lib.sh
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index eacc6694f7..01f37948ae 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='rewrite diff on binary file'
 
 . ./test-lib.sh
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 2f1737fcef..8353b05934 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Return value of diffs'
 
 . ./test-lib.sh
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 2d9731b52d..48163e8736 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -4,6 +4,7 @@
 # Copyright (c) 2011 Alexey Shumkin (+ non-UTF-8 commit encoding tests)
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Support for verbose submodule differences in git diff
 
 This test tries to verify the sanity of the --submodule option of git diff.
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index cd70fd5192..42d846a40f 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2016 Jacob Keller, based on t4041 by Jens Lehmann
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test for submodule diff on non-checked out submodule
 
 This test tries to verify that add_submodule_odb works when the submodule was
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 7e23b55ea4..dd3a932816 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -5,6 +5,7 @@
 # Copyright (c) 2016 Jacob Keller (copy + convert to --submodule=diff)
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Support for diff format verbose submodule difference in git diff
 
 This test tries to verify the sanity of --submodule=diff option of git diff.
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index a9bd40a6d0..f9943ff9a9 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git apply handling submodules'
 
 . ./test-lib.sh
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0dd8b65d7c..7a7ee7127c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='.mailmap configurations'
 
 . ./test-lib.sh
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index b972296f06..fb504b2c72 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Nazri Ramliy
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test for "git log --decorate" colors'
 
 . ./test-lib.sh
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 0ba8194403..da8c9a7ae5 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git am handling submodules'
 
 . ./test-lib.sh
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 886b6953e4..abe58c54f8 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -3,6 +3,7 @@
 # Copyright (C) 2005 Rene Scharfe
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git archive and git get-tar-commit-id test
 
 This test covers the topics of file contents, commit date handling and
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index b04d955bfa..ba7de4e9b0 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git archive attribute tests'
 
 . ./test-lib.sh
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 6667d159ab..acf6937e0f 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git archive attribute pattern tests'
 
 . ./test-lib.sh
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 55c7870997..19d58df57e 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git archive --format=zip test'
 
 . ./test-lib.sh
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 82c33b88e7..581c65dc95 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test workflows involving pull request.'
 
 . ./test-lib.sh
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 43a672c345..9e473489b7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git pack-object
 
 '
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 133b5842b1..5b5242977b 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Johannes E. Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='prune'
 . ./test-lib.sh
 
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index a5eca210b8..d4ada345ee 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git pack-object --include-tag'
 . ./test-lib.sh
 
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index f4931c0c2a..6fcb7ab75d 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Google Inc.
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-pack-object with missing base
 
 '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 424bec7d77..dca58299e1 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='exercise basic bitmap functionality'
 . ./test-lib.sh
 
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow.sh
index 872a95df33..33d724fd52 100755
--- a/t/t5311-pack-bitmaps-shallow.sh
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='check bitmap operation with shallow repositories'
 . ./test-lib.sh
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3331e0f534..12cb482300 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='See why rewinding head breaks send-pack
 
 '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 7f278d8ce9..eba223cbfe 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Shawn O. Pearce
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test the update hook infrastructure.'
 . ./test-lib.sh
 
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 6eb2ffd6ec..993db78d1f 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Josh England
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test the post-merge hook.'
 . ./test-lib.sh
 
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fc898c9eac..e925973651 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Josh England
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test the post-checkout hook.'
 . ./test-lib.sh
 
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 2b8c0bac7d..4174d6d5a3 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='tracking branch update checks for git push'
 
 . ./test-lib.sh
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 59e80a5ea2..1ac17e8dad 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='remote push rejects are reported by client'
 
 . ./test-lib.sh
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 7a48236e87..9458295279 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Thomas Rast
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test the post-rewrite hook.'
 . ./test-lib.sh
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index b5865b385d..29233cae2a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2005 Johannes Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Testing multi_ack pack fetching'
 
 . ./test-lib.sh
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 1bc57ac03f..01d121b8d7 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch/push involving alternates'
 . ./test-lib.sh
 
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 7a46cbdbe6..44ec47cc4a 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test quickfetch from local'
 
 . ./test-lib.sh
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a6c0178f3a..3019f37519 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git remote porcelain-ish'
 
 . ./test-lib.sh
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 75c570adca..556d3f3dc9 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch/push involving ref namespaces'
 . ./test-lib.sh
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 668c54be41..c0d632361e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2006, Junio C Hamano.
 
+test_fails_on_unusual_directory_names=1
 test_description='Per branch config variables affects "git fetch".
 
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 94fc9be9ce..b69c0314c5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git ls-remote'
 
 . ./test-lib.sh
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 4b4b6673b8..6e14245225 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch --all works correctly'
 
 . ./test-lib.sh
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 36b0dbc01c..c388a08312 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -4,6 +4,7 @@
 #
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Merge logic in fetch'
 
 . ./test-lib.sh
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 177897ea0b..0c251b8f86 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Basic fetch/push functionality.
 
 This test checks the following functionality:
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 11fcd37700..6ff22e245b 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='push to a repository that borrows from elsewhere'
 
 . ./test-lib.sh
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 17f4d0fe4e..04b7c5281d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='pulling into void'
 
 . ./test-lib.sh
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ded8f98dbe..dd6b7675b8 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='pull options'
 
 . ./test-lib.sh
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index bcff460d0a..d84115b081 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='pulling from symlinked subdir'
 
 . ./test-lib.sh
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index c278adaa5a..b86b431205 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git pull message generation'
 
 . ./test-lib.sh
diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
index 45815f7378..85d387a9e5 100755
--- a/t/t5525-fetch-tagopt.sh
+++ b/t/t5525-fetch-tagopt.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
 
 . ./test-lib.sh
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index f3b0a8d30a..fe48eee142 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2010, Jens Lehmann
 
+test_fails_on_unusual_directory_names=1
 test_description='Recursive "git fetch" for submodules'
 
 . ./test-lib.sh
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 207899a99f..cc61c6e66a 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test fetching of oddly-named refs'
 . ./test-lib.sh
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index f55137f76f..8a9f17ce6f 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='unpack-objects'
 
 . ./test-lib.sh
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index a2c9e7439f..9490b77c7d 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='compare & swap push force/delete safety'
 
 . ./test-lib.sh
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index 8ed58d27f2..2542b20cfd 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='avoiding conflicting update thru symref aliasing'
 
 . ./test-lib.sh
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf3316..806dce27a0 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch handles conflicting refspecs correctly'
 
 . ./test-lib.sh
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index df8d2f095a..d7c7110dab 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch/clone from a shallow clone'
 
 . ./test-lib.sh
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index ecbf84d21c..452be015b6 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='push from/to a shallow clone'
 
 . ./test-lib.sh
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 5fbf67c446..5d325c1cd9 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='fetch/clone from a shallow clone over http'
 
 . ./test-lib.sh
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 88ff5a49e4..3815ce69d6 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test WebDAV http-push
 
 This test runs various sanity checks on http-push.'
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d38bf32470..6420c7aacb 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
 
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index 5165833157..9aa0935f2b 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='push from/to a shallow clone over http'
 
 . ./test-lib.sh
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 4357af1525..f18b35a15d 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test custom script in place of pack-objects'
 . ./test-lib.sh
 
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 97065e62b8..cd6786b6a8 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='pushing to a repository using push options'
 
 . ./test-lib.sh
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index af9fcd833a..6acbcac2dc 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='check quarantine of objects during push'
 . ./test-lib.sh
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 87308cdced..94e7ca60bc 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test dumb fetching over http via static file'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a51b7e20d3..205aa47852 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test smart fetching over http via http-backend'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9fafcf1945..8b7f814aa9 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git-http-backend-noserver'
 . ./test-lib.sh
 
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 90e0d6f0fe..756ccd604b 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test git-http-backend'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 225a022e8a..1827225e93 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test fetching over git protocol'
 . ./test-lib.sh
 
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index accfa5cc0c..c7fdce9666 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='pull can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 4435693bb2..e280c1e6bf 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -3,6 +3,7 @@
 # Copyright (C) 2006 Carl D. Worth <cworth@cworth.org>
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test git clone to cleanup after failure
 
 This test covers the fact that if git clone fails, it should remove
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b52b8acf98..964cb16a5a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description=clone
 
 . ./test-lib.sh
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4320082b1b..46703dea21 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -3,6 +3,7 @@
 # Copyright (C) 2006 Martin Waitz <tali@admingilde.org>
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test clone --reference'
 . ./test-lib.sh
 
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 3c087e907c..be9a3e7116 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test local clone'
 . ./test-lib.sh
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 9e24ec88e6..f282998797 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='basic clone options'
 . ./test-lib.sh
 
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be052..34401ad97e 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='clone --branch option'
 . ./test-lib.sh
 
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 8b0d607df1..b5a5013375 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test cloning a repository with detached HEAD'
 . ./test-lib.sh
 
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778c..d6a1e34a9a 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='tests for git clone -c key=value'
 . ./test-lib.sh
 
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 7ace2535c8..ab65f48f72 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test refspec written by clone-command'
 . ./test-lib.sh
 
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 895f46bb91..a2beae244c 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -3,6 +3,7 @@
 # Copyright (C) 2006 Martin Waitz <tali@admingilde.org>
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test transitive info/alternate entries'
 . ./test-lib.sh
 
diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index a87d329656..2255124518 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test shallow cloning of repos with submodules'
 
 . ./test-lib.sh
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index d2d883f3a1..16d5ae8058 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='handling of alternates in environment variables'
 . ./test-lib.sh
 
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b1581e0..a13e116325 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Sverre Rabbelier
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index c6c2661878..9987253240 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='ext::cmd remote "connect" helper'
 . ./test-lib.sh
 
diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local.sh
index 563592d8a8..7bd038bf1e 100755
--- a/t/t5810-proto-disable-local.sh
+++ b/t/t5810-proto-disable-local.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test disabling of local paths in clone/fetch'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index d911afd24c..83e854627c 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test disabling of git-over-http in clone/fetch'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index a954ead8af..f54d817a64 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test disabling of git-over-ssh in clone/fetch'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
diff --git a/t/t5814-proto-disable-ext.sh b/t/t5814-proto-disable-ext.sh
index 9d6f7dfa2c..bf3c61a9b4 100755
--- a/t/t5814-proto-disable-ext.sh
+++ b/t/t5814-proto-disable-ext.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test disabling of remote-helper paths in clone/fetch'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1b8a..b0429d0141 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test protocol whitelisting with submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
index 14e59c5b3e..84bdbdf469 100755
--- a/t/t5900-repo-selection.sh
+++ b/t/t5900-repo-selection.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='selecting remote repo in ambiguous cases'
 . ./test-lib.sh
 
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index c4af9ca0a7..ebf5c70f14 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Johannes E. Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git rev-list involving submodules that this repo has'
 
 . ./test-lib.sh
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 8c2c6eaef8..8d43131265 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2007 Christian Couder
 #
+test_fails_on_unusual_directory_names=1
 test_description='Tests git bisect functionality'
 
 exec </dev/null
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 97a07655a0..54919d1920 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='remote tracking stats'
 
 . ./test-lib.sh
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 62b8a2e7bb..bb3c04bd25 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='bisect can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657..561d021080 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2008 Christian Couder
 #
+test_fails_on_unusual_directory_names=1
 test_description='Tests replace refs functionality'
 
 exec </dev/null
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index debadbd299..12a646e848 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='basic git merge-index / git-merge-one-file tests'
 . ./test-lib.sh
 
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index fd401ca605..4ee5520a31 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test case exclude pathspec'
 
 . ./test-lib.sh
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2e2fb0e957..5735cdbf3d 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006, Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='fmt-merge-msg test'
 
 . ./test-lib.sh
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 08de2e8ab0..56d3c42bac 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='basic git gc tests
 '
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e365d1ff77..64a08d9966 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git mv in subdirs'
 . ./test-lib.sh
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799be..a1722c3239 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git filter-branch'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 1b530b5022..75e2f4d0ce 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='GIT_EDITOR, core.editor, and stuff'
 
 . ./test-lib.sh
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f3794d415..69ff4884ef 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test automatic use of a pager.'
 
 . ./test-lib.sh
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 9c9c378119..c49966f1f1 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git grep in binary files'
 
 . ./test-lib.sh
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index 0335a9a158..2e7bae4667 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='setup taking and sanitizing funny paths'
 
 . ./test-lib.sh
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index e319fa2e84..195bfbb519 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git status --porcelain=v2
 
 This test exercises porcelain V2 output for git status.'
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index afe36a533c..091c88a572 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git reset in a bare repository'
 . ./test-lib.sh
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 2eda6adeb1..478ff8550b 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='reset can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6ad..9d662c857d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Michael Spang
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git clean basic tests'
 
 . ./test-lib.sh
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cf77a3a357..1164142b11 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Lars Hjemli
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Basic porcelain support for submodules
 
 This test tries to verify basic sanity of the init, update and status
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 8e32f19007..ca289daf05 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Johannes Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test rebasing, stashing, etc. with submodules'
 
 . ./test-lib.sh
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 0726799e74..be64ff14c3 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 David Aguilar
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git submodule sync
 
 These tests exercise the "git submodule sync" subcommand.
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 0d5b42a25b..4b136950f4 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='merging with submodules'
 
 . ./test-lib.sh
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4ac386d98b..511d2d9c8b 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Red Hat, Inc.
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test updating submodules
 
 This test verifies that "git submodule update" detaches the HEAD of the
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42e..d60f4d6078 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Johan Herland
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test "git submodule foreach"
 
 This test verifies that "git submodule foreach" correctly visits all submodules
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index e159fc5035..f8105ebda1 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009, Red Hat Inc, Author: Michael S. Tsirkin (mst@redhat.com)
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test clone --reference'
 . ./test-lib.sh
 
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index c20717181e..df6fc441ce 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Daniel Graña
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test submodules on detached working tree
 
 This test verifies that "git submodule" initialization, update and addition works
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 1acef32647..d0f8362477 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Combination of submodules and multiple workdirs'
 
 . ./test-lib.sh
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index eea36f1dbe..7befe7748b 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2014 Heiko Voigt
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='Test submodules config cache infrastructure
 
 This test verifies that parsing .gitmodules configurations directly
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9c785b07ec..e441f5de3c 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test submodule--helper is-active
 
 This test verifies that `git submodue--helper is-active` correclty identifies
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 88d4cda299..2f820804e1 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='commit-msg hook'
 
 . ./test-lib.sh
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34da83..e8ef49f1ec 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git status for submodule'
 
 . ./test-lib.sh
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index ed2653d46f..35a31a71fe 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='verbose commit template'
 . ./test-lib.sh
 
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 2a22fa7588..5306df95d6 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -4,6 +4,7 @@
 # Copyright (c) 2016 Jeff King
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='per-repo forced setting of email address'
 
 . ./test-lib.sh
diff --git a/t/t7613-merge-submodule.sh b/t/t7613-merge-submodule.sh
index d1e9fcc781..35ca51108c 100755
--- a/t/t7613-merge-submodule.sh
+++ b/t/t7613-merge-submodule.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='merge can handle submodules'
 
 . ./test-lib.sh
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6061a04147..b4b55d9f3b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git repack works correctly'
 
 . ./test-lib.sh
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 0e7f30db2d..4c07fb8692 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009, 2010, 2012, 2013 David Aguilar
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-difftool
 
 Testing basic diff tool invocation
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cee42097b0..7e6c16ea8c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git grep various.
 '
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 5b6eb3a65e..af092b345e 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='Test grep recurse-submodules feature
 
 This test verifies the recurse-submodules feature correctly greps across
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 60a80f60b2..c1d262bd2f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git send-email'
 . ./test-lib.sh
 
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 4d81ba1c2c..b853b99ff5 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='tests remote-svn'
 
 . ./test-lib.sh
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 8a8ba65a2a..7682c0dc65 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn basic tests'
 GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 07bfb63777..9f469b67fd 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn property tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 66cd51102c..c665b32005 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+test_fails_on_unusual_directory_names=1
 test_description='git svn rmdir'
 . ./lib-git-svn.sh
 
diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index b28271345c..15d7174226 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn tracking removed top-level path'
 . ./lib-git-svn.sh
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index cd480edf16..d7eb9c4c5c 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn fetching'
 . ./lib-git-svn.sh
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 6ed5f74e25..6e1e4e463c 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2006 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn commit-diff'
 . ./lib-git-svn.sh
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index dbe8deac0d..c72f70119f 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2006 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn commit-diff clobber'
 . ./lib-git-svn.sh
 
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 9f3ef8f2ef..c911dea1a7 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2006 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index a94286c8ec..190f5c4767 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2007 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn globbing refspecs'
 . ./lib-git-svn.sh
 
diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index 8d99e848d4..2a3106739b 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2007 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn globbing refspecs'
 . ./lib-git-svn.sh
 
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index dde0a3c222..86e570289f 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn useSvmProps test'
 
 . ./lib-git-svn.sh
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index a3d388228a..68f70b70f3 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 # Based on a script by Joakim Tjernlund <joakim.tjernlund@transmode.se>
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn dcommit handles merges'
 
 . ./lib-git-svn.sh
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 64bb495834..bd6c519e3e 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn dcommit can commit renames of files with ugly names'
 
 . ./lib-git-svn.sh
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 45773ee560..d04c9b05d0 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn log tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 044f65e916..f476f04e0e 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn init/clone tests'
 
 . ./lib-git-svn.sh
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 41a026637f..1c43a15c67 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn funky branch names'
 . ./lib-git-svn.sh
 
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index b28a1741e3..307c4d8811 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Kevin Ballard
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn clone with percent escapes'
 . ./lib-git-svn.sh
 
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 30013b7bb9..260b245cc2 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn authorship'
 . ./lib-git-svn.sh
 
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index ead404589e..d2c21a8d78 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Jan Krüger
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn respects rewriteRoot during rebuild'
 
 . ./lib-git-svn.sh
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
index 9f7231d5b7..3109c579b7 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2008 Brad King
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn dcommit honors auto-props'
 
 . ./lib-git-svn.sh
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
index 0d53fc9014..51bc8f0e6b 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2008 Marcus Griep
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn multi-glob branch names'
 . ./lib-git-svn.sh
 
diff --git a/t/t9127-git-svn-partial-rebuild.sh b/t/t9127-git-svn-partial-rebuild.sh
index 2e4789d061..00edd18c06 100755
--- a/t/t9127-git-svn-partial-rebuild.sh
+++ b/t/t9127-git-svn-partial-rebuild.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Deskin Miller
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn partial-rebuild tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 4e95f791db..c887dae35d 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Deskin Miller
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn partial-rebuild tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 8dbd6476fa..8a093590cb 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2008 Eric Wong
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn honors i18n.commitEncoding in config'
 
 . ./lib-git-svn.sh
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index f762038f0e..adce5d2adf 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test that git handles an svn repository with empty symlinks'
 
 . ./lib-git-svn.sh
diff --git a/t/t9132-git-svn-broken-symlink.sh b/t/t9132-git-svn-broken-symlink.sh
index aeceffaf7b..9d74572cd3 100755
--- a/t/t9132-git-svn-broken-symlink.sh
+++ b/t/t9132-git-svn-broken-symlink.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='test that git handles an svn repository with empty symlinks'
 
 . ./lib-git-svn.sh
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
index f3c30e63b7..bbdf011514 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn property tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index 09ff10cd9b..cf4240f366 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -4,6 +4,7 @@
 # Copyright (c) 2009 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn property tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index 5fa07a369f..cc5814b85f 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2007 Eric Wong
+test_fails_on_unusual_directory_names=1
 test_description='git svn dcommit clobber series'
 . ./lib-git-svn.sh
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 7d7e9d46bc..72377845e2 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Eric Wong, Mark Lodato
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn authors prog tests'
 
 . ./lib-git-svn.sh
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index e855904629..11dad1fa84 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Ben Jackson
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn reset'
 . ./lib-git-svn.sh
 
diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index 8e7f7d68b7..76ed3475aa 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Marc Branchaud
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn multiple branch and tag paths in the svn repo'
 . ./lib-git-svn.sh
 
diff --git a/t/t9142-git-svn-shallow-clone.sh b/t/t9142-git-svn-shallow-clone.sh
index 9ee23be640..d116d0a9e8 100755
--- a/t/t9142-git-svn-shallow-clone.sh
+++ b/t/t9142-git-svn-shallow-clone.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Eric Wong
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn shallow clone'
 . ./lib-git-svn.sh
 
diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
index 4594e1ae2f..452c73ba5f 100755
--- a/t/t9143-git-svn-gc.sh
+++ b/t/t9143-git-svn-gc.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2009 Robert Allan Zeh
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn gc basic tests'
 
 . ./lib-git-svn.sh
diff --git a/t/t9144-git-svn-old-rev_map.sh b/t/t9144-git-svn-old-rev_map.sh
index 7600a35cd4..12351951d6 100755
--- a/t/t9144-git-svn-old-rev_map.sh
+++ b/t/t9144-git-svn-old-rev_map.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2009 Eric Wong
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn old rev_map preservd'
 . ./lib-git-svn.sh
 
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
index 3bbf341f6a..44f40db9bd 100755
--- a/t/t9145-git-svn-master-branch.sh
+++ b/t/t9145-git-svn-master-branch.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2009 Eric Wong
 #
+test_fails_on_unusual_directory_names=1
 test_description='git svn initial master branch is "trunk" if possible'
 . ./lib-git-svn.sh
 
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 6d3130e618..25aadc3986 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2009 Eric Wong
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn creates empty directories'
 . ./lib-git-svn.sh
 
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index a90ff58629..8233aca9cd 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2013 Paul Walmsley - based on t9134 by Vitaly Shukela
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn property tests'
 . ./lib-git-svn.sh
 
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index 102639090c..92aa6e2427 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2014 Alfred Perlstein
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn propset tests'
 
 . ./lib-git-svn.sh
diff --git a/t/t9150-svk-mergetickets.sh b/t/t9150-svk-mergetickets.sh
index 1bb676bede..ac6678e92c 100755
--- a/t/t9150-svk-mergetickets.sh
+++ b/t/t9150-svk-mergetickets.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Sam Vilain
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-svn svk merge tickets'
 
 . ./lib-git-svn.sh
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 4f6c06ecb2..4028619246 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007, 2009 Sam Vilain
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-svn svn mergeinfo properties'
 
 . ./lib-git-svn.sh
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
index 372ef15685..5895175ce6 100755
--- a/t/t9153-git-svn-rewrite-uuid.sh
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Jay Soffian
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn --rewrite-uuid test'
 
 . ./lib-git-svn.sh
diff --git a/t/t9154-git-svn-fancy-glob.sh b/t/t9154-git-svn-fancy-glob.sh
index a0150f057d..1318b9a865 100755
--- a/t/t9154-git-svn-fancy-glob.sh
+++ b/t/t9154-git-svn-fancy-glob.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Jay Soffian
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn fancy glob test'
 
 . ./lib-git-svn.sh
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index 184336f346..b36f10f818 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn fetch deleted tag'
 
 . ./lib-git-svn.sh
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
index 7a6e33ba3c..9a7b721809 100755
--- a/t/t9156-git-svn-fetch-deleted-tag-2.sh
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn fetch deleted tag 2'
 
 . ./lib-git-svn.sh
diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index 991d2aa1be..cd0d534deb 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Steven Walter
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn merge detection'
 . ./lib-git-svn.sh
 
diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
index a875b45102..5feb615447 100755
--- a/t/t9158-git-svn-mergeinfo.sh
+++ b/t/t9158-git-svn-mergeinfo.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2010 Steven Walter
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn mergeinfo propagation'
 
 . ./lib-git-svn.sh
diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
index 69e4815781..ac8a201ff4 100755
--- a/t/t9159-git-svn-no-parent-mergeinfo.sh
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+test_fails_on_unusual_directory_names=1
 test_description='git svn handling of root commits in merge ranges'
 . ./lib-git-svn.sh
 
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 0ede3cfedb..7db7ac485d 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2011 Ray Chen
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn test (option --preserve-empty-dirs)
 
 This test uses git to clone a Subversion repository that contains empty
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index f113acaa6c..c216273eb3 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -4,6 +4,7 @@
 # Portions copyright (c) 2011 Bryan Jacobs
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-svn svn mergeinfo propagation'
 
 . ./lib-git-svn.sh
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
index e38d9fa37b..5ab85c210a 100755
--- a/t/t9162-git-svn-dcommit-interactive.sh
+++ b/t/t9162-git-svn-dcommit-interactive.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) 2011 Frédéric Heitzmann
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn dcommit --interactive series'
 . ./lib-git-svn.sh
 
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
index d6245cee08..54111aa873 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Peter Baumann
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn reset clears memoized caches'
 . ./lib-git-svn.sh
 
diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
index d8464d4218..af33c9ab92 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Robert Luberda
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='concurrent git svn dcommit'
 . ./lib-git-svn.sh
 
diff --git a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
index fa3ef3b1f7..eae3144c37 100755
--- a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
+++ b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Steven Walter
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn merge detection'
 . ./lib-git-svn.sh
 
diff --git a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
index 52f2e46a5b..a48d18ce94 100755
--- a/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
+++ b/t/t9166-git-svn-fetch-merge-branch-of-branch2.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Steven Walter
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn merge detection'
 . ./lib-git-svn.sh
 
diff --git a/t/t9167-git-svn-cmd-branch-subproject.sh b/t/t9167-git-svn-cmd-branch-subproject.sh
index ba35fc06fc..112a8bf51f 100755
--- a/t/t9167-git-svn-cmd-branch-subproject.sh
+++ b/t/t9167-git-svn-cmd-branch-subproject.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2013 Tobias Schulte
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git svn branch for subproject clones'
 . ./lib-git-svn.sh
 
diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
index 8b22f2272c..7283cb282a 100755
--- a/t/t9168-git-svn-partially-globbed-names.sh
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+test_fails_on_unusual_directory_names=1
 test_description='git svn globbing refspecs with prefixed globs'
 . ./lib-git-svn.sh
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 1319415ba8..7efd2c48c9 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -2,6 +2,7 @@
 #
 # Copyright (c) Robin Rosenberg
 #
+test_fails_on_unusual_directory_names=1
 test_description='Test export of commits to CVS'
 
 . ./test-lib.sh
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2e0ba3ebd8..c596269e0e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Shawn Pearce
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b5149fde6e..805fecf89d 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Johannes E. Schindelin
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git fast-export'
 . ./test-lib.sh
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 432c61d246..3a8109d42d 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Frank Lichtenheld
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-cvsserver access
 
 tests read access to a git repository with the
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 84787eee9a..2771407f74 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -4,6 +4,7 @@
 # Parts adapted from other tests.
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='git-cvsserver -kb modes
 
 tests -kb mode for binary files when accessing a git
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 6d2d3c8739..643fcfbad0 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git-cvsserver and git refspecs
 
 tests ability for git-cvsserver to switch between and compare
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6d06ed96cb..0845149409 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Jakub Narebski
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='gitweb as standalone script (basic tests).
 
 This test runs gitweb (git web interface) as CGI script from
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 0796a438bc..bf6352b084 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2009 Mark Rada
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='gitweb as standalone script (parsing script output).
 
 This test runs gitweb (git web interface) as a CGI script from the
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 804ce3850f..678dd8236a 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git cvsimport basic tests'
 . ./lib-cvs.sh
 
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 827d39f5bf..25f971c7b2 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -31,6 +31,7 @@
 #       Like imported-twice.txt, but with a vendor branch whose branch
 #       tag has been removed.
 
+test_fails_on_unusual_directory_names=1
 test_description='git cvsimport handling of vendor branches'
 . ./lib-cvs.sh
 
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index e1db323f54..6ffcb139e4 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -3,6 +3,7 @@
 # A description of the repository used for this test can be found in
 # t9602/README.
 
+test_fails_on_unusual_directory_names=1
 test_description='git cvsimport handling of branches and tags'
 . ./lib-cvs.sh
 
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index a4b3db24bd..32119a5294 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+test_fails_on_unusual_directory_names=1
 test_description='git cvsimport timestamps'
 . ./lib-cvs.sh
 
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 102c133112..54ea4990c2 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2008 Lea Wiemann
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5ed28135be..0231e9692a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2012 Felipe Contreras
 #
 
+test_fails_on_unusual_directory_names=1
 test_description='test bash completion'
 
 . ./lib-bash.sh
-- 
2.11.0

