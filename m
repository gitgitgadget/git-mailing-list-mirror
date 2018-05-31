Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A545D1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeEaTx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43704 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeEaTxX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so18669126wrm.10
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VCpR7MpKjvy46yxAMs2JvxNEskW8pNO41TCsooRYH9M=;
        b=Pywqfe6wTxfaKQgm+UxlpXqYJVL4LlJuv0UI5G16ay65fEmnZFdduEm3dUMSqA7I75
         6D7K/bNc787rV1jbmoSKijDt/BH8/6ivHAYY70Qcc1j7ZJwzodgJUPcFMGFNU54rs9eA
         DlJX3mj595x/3rs6V5eLSuAssus/5O1gO2mlAnWb+JG3fhR9a2qipkcJU5LQhL0kH1y2
         AU7CXK2V1tTHjdwSxwHAqwOC98qPduwEU+qq1teIZlAWfPJNiEBv1Eo/r0X4jdSwP0KT
         taQpvWTn4sAwWd/Ex9KQ/vvYWI6Zw3UjHYpz9h/dLgM5XqbP/g8UIcIajUonCES9gqpc
         lP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VCpR7MpKjvy46yxAMs2JvxNEskW8pNO41TCsooRYH9M=;
        b=Xs45+l77YqJQI3MvXNXanjQX1vZg8VYv4wNuIf//PncHacJsxCZEIEZe1rZryPZl4i
         gxFpnEqvsj7M1KZueS1iXgNQpDXIrg8pfVEPkd2CZhTx5zGfCT87K9yobEccQQhhWRXm
         MaTEiJPOEil6knPSnFopsAYbdNlwgQFUi+hm/IpG5mtl+8kyiXrl5dCd4ilo9WJdzkxb
         UcFJ1GxOdb1wBuvLIuI3atRrap3awmAYwumCjJCWD0WvL9dXd575lEw9Y2m6pw09oWUi
         dDgwtOYIV50N3lrSJGeuO6xfuXBItKDbI7j6pSBvV1XtYp3nWm0bRbhkP35H/ltN5Orm
         MR5g==
X-Gm-Message-State: ALKqPweGXwMx2UyAmxeZ0PFzH4mXjcM7e6HYm/k7MPES8Jq1wDNgOiUK
        BuRH+v2kxequZTjVC1UoMnM+ZUhM
X-Google-Smtp-Source: ADUXVKL6/PN8uGwko3VxoYjA7dx++kARbGDbOmntdiITYdjCrJgiQpHgSFUL482WIwsJ+O3SN4EZTA==
X-Received: by 2002:adf:ee0e:: with SMTP id y14-v6mr6506973wrn.63.1527796401466;
        Thu, 31 May 2018 12:53:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:20 -0700 (PDT)
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
Subject: [PATCH v4 1/9] checkout tests: index should be clean after dwim checkout
Date:   Thu, 31 May 2018 19:52:44 +0000
Message-Id: <20180531195252.29173-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
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

Then if we ever run into this sort of regression, either in the
existing code or with a new feature, we'll know.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2024-checkout-dwim.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 3e5ac81bd2..29c1eada17 100755
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
@@ -64,8 +71,10 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_might_fail git branch -D foo &&
 
 	test_must_fail git checkout foo &&
+	status_uno_is_clean &&
 	test_must_fail git rev-parse --verify refs/heads/foo &&
-	test_branch master
+	test_branch master &&
+	status_uno_is_clean
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
@@ -73,6 +82,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #1' '
 	test_might_fail git branch -D bar &&
 
 	git checkout bar &&
+	status_uno_is_clean &&
 	test_branch bar &&
 	test_cmp_rev remotes/repo_a/bar HEAD &&
 	test_branch_upstream bar repo_a bar
@@ -83,6 +93,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_might_fail git branch -D baz &&
 
 	git checkout baz &&
+	status_uno_is_clean &&
 	test_branch baz &&
 	test_cmp_rev remotes/other_b/baz HEAD &&
 	test_branch_upstream baz repo_b baz
@@ -90,6 +101,7 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D bar &&
 
 	test_must_fail git checkout --no-guess bar &&
@@ -99,6 +111,7 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
 
 test_expect_success 'setup more remotes with unconventional refspecs' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	git init repo_c &&
 	(
 		cd repo_c &&
@@ -128,27 +141,33 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 
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
@@ -156,9 +175,11 @@ test_expect_success 'checkout of branch from a single remote succeeds #3' '
 
 test_expect_success 'checkout of branch from a single remote succeeds #4' '
 	git checkout -B master &&
+	status_uno_is_clean &&
 	test_might_fail git branch -D eggs &&
 
 	git checkout eggs &&
+	status_uno_is_clean &&
 	test_branch eggs &&
 	test_cmp_rev refs/repo_d/eggs HEAD &&
 	test_branch_upstream eggs repo_d eggs
@@ -166,32 +187,38 @@ test_expect_success 'checkout of branch from a single remote succeeds #4' '
 
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
@@ -200,6 +227,7 @@ test_expect_success 'checkout <branch> -- succeeds, even if a file with the same
 test_expect_success 'loosely defined local base branch is reported correctly' '
 
 	git checkout master &&
+	status_uno_is_clean &&
 	git branch strict &&
 	git branch loose &&
 	git commit --allow-empty -m "a bit more" &&
@@ -210,7 +238,9 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_config branch.loose.merge master &&
 
 	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
+	status_uno_is_clean &&
 	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
+	status_uno_is_clean &&
 
 	test_cmp expect actual
 '
-- 
2.17.0.290.gded63e768a

