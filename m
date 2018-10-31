Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3162F1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeJaVkR (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:40:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaVkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:40:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n5-v6so16289984wrw.12
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/rA7GYRFl7v8+GSfr3Bj/L+jIDcObvv3XSZhwV3fUM=;
        b=fZTxYffdU6vGkqjM3YwAjb8r68b55/DDtVQu4ZamGaGN8/n6NtM9AwsvBegbfRiw77
         1OJq8UOEQzo6OnLzwGv/Eh/f/RRdQ6AY8iZYu33zQnZXBi4w7qT1I6HkLF5wh3a3Wqit
         ZAaEKPtU4oR13y+jIMTEHM/ew6uu1vNZ4R57BVan/IEmHYnb6etUC1DcgUwwXCGIZOIJ
         Bw/GmL8IeP0oM5TOm1oT3mC8yjUVx+dh1cajPrVSY31a0yELShkSvHOLE26BEfrZH/DQ
         Hqua1y9MOYGke0N12ZSxUr8dWHBlhelFJP+DpiaCu5HGZeD0yadv1O5M8VCQ2XliRUJy
         T52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/rA7GYRFl7v8+GSfr3Bj/L+jIDcObvv3XSZhwV3fUM=;
        b=GnJQm4ePFFfT1n1YsTdHd1vL1rnnZfh07YM8Ktnqq2G1Y53STtGT1XxtkKrE9W5nPH
         lNKbpNyitjxpZfHPinL/FQR1In6mb3q11ePof9ERZZMA1mV9gzD7wOu3HlbniYvRVF0B
         7KbWcpxB/GAYYyI5/nQhVCBDfW2kE+waZ59WPKDjTqW7us+5ky06+im9FKPCBzIJJoH/
         /mVKr90pEQ0lYlJUQvjjW/SQeLjuk9MBlCYhMERu/VMhMVa5bwQs/IfZ1CmRBSvhIwhD
         Oj6VTHj5A9yTsk/3KVJ8yPyLTvGvGgz1Mu8NuSSQSl/mtgfIcWjwJFpbl0Qo5DxnvZJk
         0EGg==
X-Gm-Message-State: AGRZ1gLfT5CBqxoQY8cX8Fev5w6XISGKVP26ugC5CleUZ31EORl0HNkk
        Pr9jerOLItCTUOaOcwIPZgIEesBdLwQ=
X-Google-Smtp-Source: AJdET5dxjbIQ+Kg5epl5zNDP3Vbhba9Ekxmda9aje4W4ig6WHwepCWne9p4aulITGrz/A62ePDHMhg==
X-Received: by 2002:adf:fdc8:: with SMTP id i8-v6mr2842261wrs.276.1540989742852;
        Wed, 31 Oct 2018 05:42:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l42-v6sm2336705wre.37.2018.10.31.05.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:42:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] tests: mark those tests where "git fsck" fails at the end
Date:   Wed, 31 Oct 2018 12:42:07 +0000
Message-Id: <20181031124208.29451-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
References: <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the tests where "git fsck" fails at the end with extra test code
to check the fsck output. There fsck.{err,out} has been created for
us.

A later change will add the support for GIT_TEST_FSCK_TESTS. They're
being added first to ensure the test suite will never fail with
GIT_TEST_FSCK=true during bisect.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh                     | 5 +++++
 t/t1305-config-include.sh               | 4 ++++
 t/t1404-update-ref-errors.sh            | 4 ++++
 t/t1410-reflog.sh                       | 4 ++++
 t/t1515-rev-parse-outside-repo.sh       | 4 ++++
 t/t3008-ls-files-lazy-init-name-hash.sh | 4 ++++
 t/t3103-ls-tree-misc.sh                 | 6 ++++++
 t/t3430-rebase-merges.sh                | 6 ++++++
 t/t4046-diff-unmerged.sh                | 4 ++++
 t/t4058-diff-duplicates.sh              | 5 +++++
 t/t4212-log-corrupt.sh                  | 6 ++++++
 t/t5000-tar-tree.sh                     | 5 +++++
 t/t5300-pack-object.sh                  | 5 +++++
 t/t5303-pack-corruption-resilience.sh   | 8 ++++++++
 t/t5307-pack-missing-commit.sh          | 7 +++++++
 t/t5312-prune-corruption.sh             | 4 ++++
 t/t5504-fetch-receive-strict.sh         | 4 ++++
 t/t5601-clone.sh                        | 8 ++++++++
 t/t6007-rev-list-cherry-pick-file.sh    | 4 ++++
 t/t6011-rev-list-with-bad-commit.sh     | 7 +++++++
 t/t6030-bisect-porcelain.sh             | 6 ++++++
 t/t7007-show.sh                         | 6 ++++++
 t/t7106-reset-unborn-branch.sh          | 4 ++++
 t/t7415-submodule-names.sh              | 4 ++++
 t/t7416-submodule-dash-url.sh           | 4 ++++
 t/t7417-submodule-path-url.sh           | 4 ++++
 t/t7509-commit-authorship.sh            | 4 ++++
 t/t8003-blame-corner-cases.sh           | 4 ++++
 t/t9130-git-svn-authors-file.sh         | 7 +++++++
 29 files changed, 147 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 43c4be1e5e..12b69e6fbe 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -588,4 +588,9 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "unable to unpack header of" fsck.err &&
+	test_i18ngrep "object corrupt or missing" fsck.err
+'
+
 test_done
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 635918505d..890d307d4e 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -313,4 +313,8 @@ test_expect_success 'include cycles are detected' '
 	test_i18ngrep "exceeded maximum include depth" stderr
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "exceeded maximum include depth" fsck.err
+'
+
 test_done
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 51a4f4c0ac..6095b2d4b9 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -618,4 +618,8 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_cmp unchanged actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid sha1 pointer" fsck.err
+'
+
 test_done
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388b0611d8..43b8e0c9c5 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -368,4 +368,8 @@ test_expect_success 'continue walking past root commits' '
 	)
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid reflog entry" fsck.err
+'
+
 test_done
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index 3ec2971ee5..1d8fc3ad70 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -42,4 +42,8 @@ test_expect_success 'rev-parse --resolve-git-dir' '
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "not a git repository" fsck.err
+'
+
 test_done
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 64f047332b..7fb2e5c177 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -24,4 +24,8 @@ test_expect_success 'no buffer overflow in lazy_init_name_hash' '
 	test-tool lazy-init-name-hash -m
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "notice: No default references" fsck.err
+'
+
 test_done
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 14520913af..b7d8ae2e81 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -22,4 +22,10 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid sha1 pointer in cache-tree" fsck.err &&
+	test_i18ngrep "broken link from.*tree" fsck.out &&
+	test_i18ngrep "missing tree" fsck.out
+'
+
 test_done
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index aa7bfc88ec..efac3a792b 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -396,4 +396,10 @@ test_expect_success 'with --autosquash and --exec' '
 	grep "G: +G" actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "broken link from.*commit" fsck.out &&
+	test_i18ngrep "to.*tree" fsck.out &&
+	test_i18ngrep "missing tree" fsck.out
+'
+
 test_done
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ff7cfd884a..d868bc44a9 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -84,4 +84,8 @@ test_expect_success 'diff-files -3' '
 	test_cmp diff-files-3.expect diff-files-3.actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "notice: No default references" fsck.err
+'
+
 test_done
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index c24ee175ef..9c79410dc0 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -76,4 +76,9 @@ test_expect_success 'diff-tree with renames' '
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "zeroPaddedFilemode" fsck.err &&
+	test_i18ngrep "duplicateEntries" fsck.err
+'
+
 test_done
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 03b952c90d..5f36c58a61 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -85,4 +85,10 @@ test_expect_success 'absurdly far-in-future date' '
 	git log -1 --format=%ad $commit
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "badDate" fsck.err &&
+	test_i18ngrep "badDateOverflow" fsck.err &&
+	test_i18ngrep "missingSpaceBeforeDate" fsck.err
+'
+
 test_done
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2a97b27b0a..88c768f232 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -408,4 +408,9 @@ test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "corrupt loose object" fsck.err &&
+	test_i18ngrep "object corrupt or missing" fsck.err
+'
+
 test_done
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 6c620cd540..b4ef9a447a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -493,4 +493,9 @@ test_expect_success \
     'test_must_fail git -c core.bigfilethreshold=1 index-pack -o bad.idx test-3.pack 2>msg &&
      test_i18ngrep "SHA1 COLLISION FOUND" msg'
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "sha1 mismatch for" fsck.err &&
+	test_i18ngrep "object corrupt or missing" fsck.err
+'
+
 test_done
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 41e6dc4dcf..79c9b307d0 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -400,4 +400,12 @@ test_expect_success \
     'printf "\0\1\1X\0" > tail_garbage_opcode &&
      test_must_fail test-tool delta -p /dev/null tail_garbage_opcode /dev/null'
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "pack checksum mismatch" fsck.err &&
+	test_i18ngrep "index CRC mismatch.*at offset 12" fsck.err &&
+	test_i18ngrep "cannot unpack.*at offset 12" fsck.err &&
+	test_i18ngrep "failed to read delta base object.*at offset 12" fsck.err &&
+	test_i18ngrep "failed to read delta base object.*at offset 2032" fsck.err
+'
+
 test_done
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index dacb440b27..2780f4ceeb 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -36,4 +36,11 @@ test_expect_success 'pack-objects notices corruption' '
 	test_must_fail git pack-objects --revs pack
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid sha1 pointer" fsck.err &&
+	test_i18ngrep "broken link from.*commit" fsck.out &&
+	test_i18ngrep "to.*commit" fsck.out &&
+	test_i18ngrep "missing commit" fsck.out
+'
+
 test_done
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index da9d59940d..898d8906bc 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -111,4 +111,8 @@ test_expect_success 'pack-refs does not drop broken refs during deletion' '
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid sha1 pointer" fsck.err
+'
+
 test_done
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7bc706873c..945a060992 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -348,4 +348,8 @@ test_expect_success \
 	grep "Cannot demote unterminatedheader" act
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "missingEmail" fsck.err
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f1a49e94f5..35eca5881b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -726,6 +726,14 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
 '
 
+# We might have "test_done" through lib-httpd.sh. Need to tes
+# GIT_TEST_FSCK_TESTS here.
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "object.*is a tree, not a blob" fsck.err &&
+	test_i18ngrep "object.*is a commit, not a blob" fsck.err &&
+	test_i18ngrep "error in tree.*: broken links" fsck.err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index f0268372d2..a86ba0900b 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -266,4 +266,8 @@ test_expect_success '--cherry-pick avoids looking at full diffs' '
 	git rev-list --cherry-pick ...shy-diff
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "missing blob" fsck.out
+'
+
 test_done
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index 545b461e51..30d39ce925 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -55,5 +55,12 @@ test_expect_success 'first commit is still available' \
    git log $first_commit
    '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "pack checksum mismatch" fsck.err &&
+	test_i18ngrep "index CRC mismatch for object.*at offset 487" fsck.err &&
+	test_i18ngrep "inflate: data stream error.*incorrect data check" fsck.err &&
+	test_i18ngrep "cannot unpack.*at offset 487" fsck.err
+'
+
 test_done
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f84ff941c3..5da668ed06 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -911,4 +911,10 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing "$GIT_DIR/BISECT_START"
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "broken link from.*tree" fsck.out &&
+	test_i18ngrep "to.*tree" fsck.out &&
+	test_i18ngrep "missing tree" fsck.out
+'
+
 test_done
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db6246..d25cee8a72 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -128,4 +128,10 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "broken link from.*tag" fsck.out &&
+	test_i18ngrep "to.*blob" fsck.out &&
+	test_i18ngrep "missing blob" fsck.out
+'
+
 test_done
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index ecb85c3b82..0719261fe7 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -64,4 +64,8 @@ test_expect_success 'reset --hard' '
 	test_path_is_missing a
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "missing tree" fsck.out
+'
+
 test_done
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index 293e2e1963..3d8fa7831f 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -191,4 +191,8 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 	)
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "gitmodulesName" fsck.err
+'
+
 test_done
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 1cd2c1c1ea..e6c885784e 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -46,4 +46,8 @@ test_expect_success 'fsck rejects unprotected dash' '
 	grep gitmodulesUrl err
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "gitmodulesUrl" fsck.err
+'
+
 test_done
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index 756af8c4d6..8362442908 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -25,4 +25,8 @@ test_expect_success 'fsck rejects unprotected dash' '
 	grep gitmodulesPath err
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "gitmodulesPath" fsck.err
+'
+
 test_done
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 500ab2fe72..cdcbfed61a 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -174,4 +174,8 @@ test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
 	test_cmp expect actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "invalid reflog entry" fsck.err
+'
+
 test_done
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index c92a47b6d5..3a8affc3e7 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -275,4 +275,8 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
 	grep "A U Thor" actual
 '
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "missingNameBeforeEmail" fsck.err
+'
+
 test_done
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index cb764bcadc..0c0c42c72c 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -128,4 +128,11 @@ test_expect_success 'authors-file imported user without email' '
 
 test_debug 'GIT_DIR=gitconfig.clone/.git git log'
 
+GIT_TEST_FSCK_TESTS='
+	test_i18ngrep "object.*is a tree, not a blob" fsck.err &&
+	test_i18ngrep "object.*is a commit, not a blob" fsck.err &&
+	test_i18ngrep "tree.*: broken links" fsck.err &&
+	test_i18ngrep "missingTaggerEntry" fsck.err
+'
+
 test_done
-- 
2.19.1.899.g0250525e69

