Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B4620248
	for <e@80x24.org>; Sun,  3 Mar 2019 12:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCCM3h (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 07:29:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37631 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCM3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 07:29:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so1127124pfh.4
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 04:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K/kklngtzWBK/VlheQkTH13F+n31y7EwSo9Hqz8fCVM=;
        b=u//J2Op84QQGd7ihBv5YvscZwlvLSuHySc1/umMZE8mhkQ2mtkBzSe++90Ld358dg8
         U3b9EKXER7FDE34b7tAsk2xrfkrHF7AMFfpjVmAM4kF4DBAQqEWVTsv/VfxmrD2XVNn9
         gqLcVVHZkgdNQLdkRDikKGVeyCXd/KaDJW7INajBboMQzaQQ/cX4BB0O9Wt8vIqfHhLX
         +6mpKL+aTHkKrOsKFsfNTahglIS0yyimr1YkvfdUZek5glK1nZdz3n+UZlQUT2YbLQ3T
         2YKOGwAPwreBTHC2ygqBBdAAKOwQM88/pXSx7IvJw7rFZcbnk0/Lh63mR5llWPvSa+KM
         LDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K/kklngtzWBK/VlheQkTH13F+n31y7EwSo9Hqz8fCVM=;
        b=WQi8JCVpVXiwZru+NpuKrhhUPr/iU3D20oZ8SeQQBLVKH8Hm4+AabZPwYZ24FjKsWT
         coRnHgt2JjszplfNSXh/IWWfkVW3eNz0024ZRzgNlDvlSzp4Xn9M7ikdlQvGc5FXNF/L
         oPXJWwLLAj2mlncrNDXCNGP67kiT3VGYpsp9Sr9M4QI4orsLUOB4lLX2xtcQavFebNcc
         OnWBOCK3SvdqoGIylJDJRytt5HEK67/XtIo9iDS679Nm+d9lIcERrtiTcCoBoeSTyklp
         5NKv7i00iQIVAQmjvFDvZivdb22ScyWw+j5Ps7j/dRH5U1luEXCYGzAOfOFv7QqGphkP
         4haw==
X-Gm-Message-State: APjAAAXLGCSJpZtbk7gx14Bunau5zhoHmqiA7RK85a5y07r1ErdtAmFT
        B8JWsIhmHIzPEApXwncVNB/S6H3H8ng=
X-Google-Smtp-Source: APXvYqwbTo1FRsvpnMIrNHxWcqWQzr8hJyfAIL2jn8TeUIEWhN11047dUbTWQipyBMYkjSoFRZDTvg==
X-Received: by 2002:a62:1b92:: with SMTP id b140mr15178418pfb.159.1551616175584;
        Sun, 03 Mar 2019 04:29:35 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id l5sm6861093pfi.97.2019.03.03.04.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:29:34 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        t.gummerer@gmail.com, christian.couder@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [PATCH 3/3] t3600: use helper functions from test-lib-functions
Date:   Sun,  3 Mar 2019 17:58:42 +0530
Message-Id: <20190303122842.30380-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace `test -(d|f|e|s)` calls in `t3600-rm.sh`.

Previously we were using `test -(d|f|e|s)` to verify the presence of a
directory/file, but we already have helper functions, viz,
`test_path_is_dir`, `test_path_is_file`, `test_path_is_missing` and
`test_file_not_empty` with better functionality.

These helper functions make code more readable and informative to someone
new, also these functions have better error messages.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 166 ++++++++++++++++++++++++++------------------------
 1 file changed, 87 insertions(+), 79 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index ec4877bfec..c2391b7d56 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -29,8 +29,10 @@ embedded' &&
 "
 
 test_expect_success \
-	'Pre-check that foo exists and is in index before git rm foo' \
-	'[ -f foo ] && git ls-files --error-unmatch foo'
+	'Pre-check that foo exists and is in index before git rm foo' '
+	test_path_is_file foo &&
+	git ls-files --error-unmatch foo
+'
 
 test_expect_success \
 	'Test that git rm foo succeeds' \
@@ -75,20 +77,26 @@ test_expect_success \
 '
 
 test_expect_success \
-	'Post-check that foo exists but is not in index after git rm foo' \
-	'[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
+	'Post-check that foo exists but is not in index after git rm foo' '
+	test_path_is_file foo &&
+	test_must_fail git ls-files --error-unmatch foo
+'
 
 test_expect_success \
-	'Pre-check that bar exists and is in index before "git rm bar"' \
-	'[ -f bar ] && git ls-files --error-unmatch bar'
+	'Pre-check that bar exists and is in index before "git rm bar"' '
+	test_path_is_file bar &&
+	git ls-files --error-unmatch bar
+'
 
 test_expect_success \
 	'Test that "git rm bar" succeeds' \
 	'git rm bar'
 
 test_expect_success \
-	'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-	'! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
+	'Post-check that bar does not exist and is not in index after "git rm -f bar"' '
+	test_path_is_missing bar &&
+	test_must_fail git ls-files --error-unmatch bar
+'
 
 test_expect_success \
 	'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
@@ -142,15 +150,15 @@ test_expect_success 'Re-add foo and baz' '
 test_expect_success 'Modify foo -- rm should refuse' '
 	echo >>foo &&
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'Modified foo -- rm -f should work' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch bar
 '
@@ -164,15 +172,15 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 
 test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
@@ -199,21 +207,21 @@ test_expect_success 'Recursive test setup' '
 
 test_expect_success 'Recursive without -r fails' '
 	test_must_fail git rm frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r but dirty' '
 	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r -f' '
 	git rm -f -r frotz &&
-	! test -f frotz/nitfol &&
-	! test -d frotz
+	test_path_is_missing frotz/nitfol &&
+	test_path_is_missing frotz
 '
 
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
@@ -238,7 +246,7 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
-	test ! -f frotz/nitfol
+	test_path_is_missing frotz/nitfol
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
@@ -259,7 +267,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 	echo content >dir/subdir/subsubdir/file &&
 	git add dir/subdir/subsubdir/file &&
 	git rm -f dir/subdir/subsubdir/file &&
-	! test -d dir
+	test_path_is_missing dir
 '
 
 cat >expect <<EOF
@@ -297,7 +305,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git add .gitmodules &&
 	git commit -m "add submodule" &&
 	git rm submod &&
-	test ! -e submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -319,7 +327,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -330,7 +338,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod/ &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -348,12 +356,12 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	git submodule update &&
 	git -C submod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -364,8 +372,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
 	git reset --hard &&
 	git submodule update &&
 	git rm --cached submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.cached actual &&
 	git config -f .gitmodules submodule.sub.url &&
@@ -376,7 +384,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm -n submod &&
-	test -f submod/.git &&
+	test_path_is_file submod/.git &&
 	git diff-index --exit-code HEAD
 '
 
@@ -386,8 +394,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
 	git rm .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.both_deleted actual
 '
@@ -397,15 +405,15 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
 	git submodule update &&
 	git config -f .gitmodules foo.bar true &&
 	test_must_fail git rm submod >actual 2>actual.err &&
-	test -s actual.err &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_file_not_empty actual.err &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git diff-files --quiet -- submod &&
 	git add .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -418,8 +426,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
 	git rm submod >actual 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -429,12 +437,12 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
 	git submodule update &&
 	echo X >submod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -444,12 +452,12 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
 	git submodule update &&
 	echo X >submod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -486,7 +494,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	git submodule update &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -498,12 +506,12 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git -C submod checkout HEAD^ &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -517,12 +525,12 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	echo X >submod/empty &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -536,12 +544,12 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
 	echo X >submod/untracked &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -557,13 +565,13 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	) &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	test_must_fail git rm -f submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git merge --abort &&
@@ -575,7 +583,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	git reset --hard &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -591,10 +599,10 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
 		rm -r ../.git/modules/sub
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test -s actual &&
+	test_file_not_empty actual &&
 	test_i18ngrep Migrating output.err
 '
 
@@ -619,7 +627,7 @@ test_expect_success 'setup subsubmodule' '
 
 test_expect_success 'rm recursively removes work tree of unmodified submodules' '
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -629,12 +637,12 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
 	git submodule update --recursive &&
 	git -C submod/subsubmod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -644,12 +652,12 @@ test_expect_success 'rm of a populated nested submodule with nested modification
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -659,12 +667,12 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -678,10 +686,10 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/subsubmod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test -s actual &&
+	test_file_not_empty actual &&
 	test_i18ngrep Migrating output.err
 '
 
-- 

