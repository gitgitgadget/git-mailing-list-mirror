Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F101F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeFBLu6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:50:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38230 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFBLuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:50:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so38613132wrf.5
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8TjUMKpPdfFF93U1IxQ1u8UdADEqUf1WeoD9cLPsziU=;
        b=fRjAOUg3IWGMrp4Lcgs9J2AT+ngIG7XphbW6uW3LusjjRuffdfCflcMtNrYb+wba06
         KULdBeckFDdKwqBObrEgQZyQ05SOG1lOgZPCEVf5ppMfTE5s84BLgbpzDZ2rur0N8Dzl
         jZfo/QXiIHPKMK8Zcjah/c4O/277c9StOAGLG59N3yMHuvGiLT4rqhssyeZ1b5Z8dxkm
         qIzAicbnpM7O9bE7TynUc4/D6rwppfeqkkoSdS3u+qYuYZcJlQpBW6WkyBqobjyGLWdd
         rh7jo8DmJWwOg1w1zxquGYGVlO/Uzf2IJ0OZKfs1RWYjTREJvZfxxaLjfxJ9blx/xsfq
         9SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8TjUMKpPdfFF93U1IxQ1u8UdADEqUf1WeoD9cLPsziU=;
        b=b2FUDZbP8CQTnAJ4rfwDxZ0sbXXAZjJoSHPOkRBXyAWLNf8nV3ZpzRlNpt0LJwq+NR
         TIPWc9Jo+KYUpdO/IRCLICwurJ79fZVhKwtWaaw0qJHSlROFXLFK7XajDbk8y6dPbDNh
         NSkZwwieve55XRvqQnTqbBXFtUXUW42MFP6QhjAmU9+pvCQLzozA1m2Li0S1rXWE/eB/
         evps+7HzHZ3FLdDax4Q5ql1xno7zL2uNAJcFM1BwKLNnlCZ2C74QzPeH25cIl1cEPgPm
         Eg8jMu2VBKcdU9OQHsKD6S893MrUm7E4iR2DLhpdMtWP+IkJjHVnMzKte8eV7gRxjlVp
         +mpQ==
X-Gm-Message-State: ALKqPwcgYrWfk6gDjcM8DMgHBD6ZbFKgIA9FF+oWP49LZsF2xz7oyYT5
        9Q3qATTAkpJpDEcdDxh/fpn5bZtG
X-Google-Smtp-Source: ADUXVKL24QQURKUS9Xg7Zc+LgegiLhTntVduPFPmMeX3Cpq6yOpcNQmzBZlUN6Eevtiv89/2xPHvTA==
X-Received: by 2002:adf:d10a:: with SMTP id a10-v6mr10662545wri.18.1527940253394;
        Sat, 02 Jun 2018 04:50:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/8] checkout tests: index should be clean after dwim checkout
Date:   Sat,  2 Jun 2018 11:50:35 +0000
Message-Id: <20180602115042.18167-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert that whenever there's a DWIM checkout that the index should be
clean afterwards, in addition to the correct branch being checked-out.

The way the DWIM checkout code in checkout.[ch] works is by looping
over all remotes, and for each remote trying to find if a given
reference name only exists on that remote, or if it exists anywhere
else.

This is done by starting out with a `unique = 1` tracking variable in
a struct shared by the entire loop, which will get set to `0` if the
data reference is not unique.

Thus if we find a match we know the dst_oid member of
tracking_name_data must be correct, since it's associated with the
only reference on the only remote that could have matched our query.

But if there was ever a mismatch there for some reason we might end up
with the correct branch checked out, but at the wrong oid, which would
show whatever the difference between the two staged in the
index (checkout branch A, stage changes from the state of branch B).

So let's amend the tests (mostly added in) 399e4a1c56 ("t2024: Add
tests verifying current DWIM behavior of 'git checkout <branch>'",
2013-04-21) to always assert that "status" is clean after we run
"checkout", that's being done with "-uno" because there's going to be
some untracked files related to the test itself which we don't care
about.

In all these tests (DWIM or otherwise) we start with a clean index, so
these tests are asserting that that's still the case after the
"checkout", failed or otherwise.

Then if we ever run into this sort of regression, either in the
existing code or with a new feature, we'll know.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2024-checkout-dwim.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 3e5ac81bd2..ed32828105 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -23,6 +23,12 @@ test_branch_upstream () {
 	test_cmp expect.upstream actual.upstream
 }
 
+status_uno_is_clean() {
+	>status.expect &&
+	git status -uno --porcelain >status.actual &&
+	test_cmp status.expect status.actual
+}
+
 test_expect_success 'setup' '
 	test_commit my_master &&
 	git init repo_a &&
@@ -55,6 +61,7 @@ test_expect_success 'checkout of non-existing branch fails' '
 	test_might_fail git branch -D xyzzy &&
 
 	test_must_fail git checkout xyzzy &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
 	test_branch master
 '
@@ -64,6 +71,7 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_might_fail git branch -D foo &&
 
 	test_must_fail git checkout foo &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/foo &&
 	test_branch master
 '
@@ -73,6 +81,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #1' '
 	test_might_fail git branch -D bar &&
 
 	git checkout bar &&
+	status_uno_is_clean &&
 	test_branch bar &&
 	test_cmp_rev remotes/repo_a/bar HEAD &&
 	test_branch_upstream bar repo_a bar
@@ -83,6 +92,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_might_fail git branch -D baz &&
 
 	git checkout baz &&
+	status_uno_is_clean &&
 	test_branch baz &&
 	test_cmp_rev remotes/other_b/baz HEAD &&
 	test_branch_upstream baz repo_b baz
@@ -90,6 +100,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_must_fail git checkout --no-guess bar &&
@@ -99,6 +110,7 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
 
 test_expect_success 'setup more remotes with unconventional refspecs' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	git init repo_c &&
 	(
 		cd repo_c &&
@@ -128,27 +140,33 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 
 test_expect_success 'checkout of branch from multiple remotes fails #2' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_must_fail git checkout bar &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/bar &&
 	test_branch master
 '
 
 test_expect_success 'checkout of branch from multiple remotes fails #3' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D baz &&
 
 	test_must_fail git checkout baz &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/baz &&
 	test_branch master
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #3' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
 	git checkout spam &&
+	status_uno_is_clean &&
 	test_branch spam &&
 	test_cmp_rev refs/remotes/extra_dir/repo_c/extra_dir/spam HEAD &&
 	test_branch_upstream spam repo_c spam
@@ -156,9 +174,11 @@ test_expect_success 'checkout of branch from a single remote succeeds #3' '
 
 test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D eggs &&
 
 	git checkout eggs &&
+	status_uno_is_clean &&
 	test_branch eggs &&
 	test_cmp_rev refs/repo_d/eggs HEAD &&
 	test_branch_upstream eggs repo_d eggs
@@ -166,32 +186,38 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
 
 test_expect_success 'checkout of branch with a file having the same name fails' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
 	>spam &&
 	test_must_fail git checkout spam &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/spam &&
 	test_branch master
 '
 
 test_expect_success 'checkout of branch with a file in subdir having the same name fails' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
 	>spam &&
 	mkdir sub &&
 	mv spam sub/spam &&
 	test_must_fail git -C sub checkout spam &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/spam &&
 	test_branch master
 '
 
 test_expect_success 'checkout <branch> -- succeeds, even if a file with the same name exists' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D spam &&
 
 	>spam &&
 	git checkout spam -- &&
+	status_uno_is_clean &&
 	test_branch spam &&
 	test_cmp_rev refs/remotes/extra_dir/repo_c/extra_dir/spam HEAD &&
 	test_branch_upstream spam repo_c spam
@@ -200,6 +226,7 @@ test_expect_success 'checkout <branch> -- succeeds, even if a file with the same
 test_expect_success 'loosely defined local base branch is reported correctly' '
 
 	git checkout master &&
+	status_uno_is_clean &&
 	git branch strict &&
 	git branch loose &&
 	git commit --allow-empty -m "a bit more" &&
@@ -210,7 +237,9 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_config branch.loose.merge master &&
 
 	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
+	status_uno_is_clean &&
 	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
+	status_uno_is_clean &&
 
 	test_cmp expect actual
 '
-- 
2.17.0.290.gded63e768a

