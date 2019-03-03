Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C5D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 23:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfCCXic (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 18:38:32 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45150 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCCXic (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 18:38:32 -0500
Received: by mail-pg1-f177.google.com with SMTP id 125so1440096pgc.12
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 15:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SsLcwaTtz8hvPi2XttwcByt/RU8Hwe8DqSexRQ5kvRk=;
        b=AQjjjTxdtqHjAHcxnM+WEcSUvQrzYkIRH2n0p+O+aSYrNOaTENtxjH+wCpEMhzwd0/
         YoGvp/deXI4osGGeBn/C0DUoWe3B35A/3mctbAaX61dAdDFiP/M64k6CzdI5+2JpRwu0
         nGsJcJWoXYeR5Eyh+Hw4rmqxyNgvrXugtaw6fRIJp0L6L1wnAUcjsyANil6fafKvIUlR
         03LZIgCGYlD7UGkOH589iewPO9uI+v4THvo2RVMUFr+jWGCJDmKatMOWFu9cdhxUwKJg
         Lqdb05p5Bhe76K2w3DheouKqmPK9hk1RxxDIfXSq3w2IBFNJEsXUsDXS33EnIaUNSm85
         YmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SsLcwaTtz8hvPi2XttwcByt/RU8Hwe8DqSexRQ5kvRk=;
        b=X5yQJwbtG6GYmNifqytZofVSq/PFgq4PPbjs0SvsSe4VNw25yP6Swi4zUNC+ZDdUS9
         TTGHA1wzTkeuwSo4DZ5TL7naIulogRU4jX+iAykZf0eKzbpU8xULQjtGzE62Z5w45iBV
         s2tAYBdbtAUPYOIvNrf1iniiUFns+5pOeTZuo29MOMmu856CKNzBO6DsNijrdsu9rJBP
         FEUOkH5BrcAWiWxo3LdkAVx5rqQqv9vydiZvXmmkbTZTp9faIBK3RSJMoi8WvqSLuqFo
         l4WFDJSHxMfGmgBfevvmB+tiGy5cSum+57lV9ywtTGoPQ5KwyX0bgcmWYjFdjrEutDKu
         nyVA==
X-Gm-Message-State: APjAAAXik0F/l9Q973SRW6xNii6NjX6cGcY09tF6kz0KtIuWbQK7qXWi
        AlXWEai0G6zRwpF1eDAJukQ=
X-Google-Smtp-Source: APXvYqxy6F7A8/AHhTlCw1xynFNzVieD8eCUC0v4T6mYO5H2PLPB8KFQWAGLGgTIc3tjkAgtnVBMKg==
X-Received: by 2002:a63:1a25:: with SMTP id a37mr16292729pga.428.1551656311109;
        Sun, 03 Mar 2019 15:38:31 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id y6sm7284579pfy.87.2019.03.03.15.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 15:38:30 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 2/3] t3600: restructure code according to contemporary guidelines
Date:   Mon,  4 Mar 2019 05:07:49 +0530
Message-Id: <20190303233750.6500-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace leading spaces with tabs
Place title on the same line as function

The previous code of `t3600-rm.sh` had a mixed use of tabs and spaces with
instance of `not-so-recommended` way of writing `if-then` statement, also
`titles` were not on the same line as the function `test_expect_success`,
replace them so that the current version agrees with the coding guidelines

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 184 ++++++++++++++++++++++++++------------------------
 1 file changed, 94 insertions(+), 90 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..f1afda21e9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,91 +8,95 @@ test_description='Test of the various options to git rm.'
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
-test_expect_success \
-    'Initialize test directory' \
-    "touch -- foo bar baz 'space embedded' -q &&
-     git add -- foo bar baz 'space embedded' -q &&
-     git commit -m 'add normal files'"
+test_expect_success 'Initialize test directory' "
+	touch -- foo bar baz 'space embedded' -q &&
+	git add -- foo bar baz 'space embedded' -q &&
+	git commit -m 'add normal files'
+"
 
-if test_have_prereq !FUNNYNAMES; then
+if test_have_prereq !FUNNYNAMES
+then
 	say 'Your filesystem does not allow tabs in filenames.'
 fi
 
 test_expect_success FUNNYNAMES 'add files with funny names' "
-     touch -- 'tab	embedded' 'newline
+	touch -- 'tab	embedded' 'newline
 embedded' &&
-     git add -- 'tab	embedded' 'newline
+	git add -- 'tab	embedded' 'newline
 embedded' &&
-     git commit -m 'add files with tabs and newlines'
+	git commit -m 'add files with tabs and newlines'
 "
 
-test_expect_success \
-    'Pre-check that foo exists and is in index before git rm foo' \
-    '[ -f foo ] && git ls-files --error-unmatch foo'
-
-test_expect_success \
-    'Test that git rm foo succeeds' \
-    'git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo &&
-     echo "other content" >foo &&
-     git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     test_must_fail git rm --cached foo
-'
-
-test_expect_success \
-    'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     git rm --cached -f foo'
-
-test_expect_success \
-    'Post-check that foo exists but is not in index after git rm foo' \
-    '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
-
-test_expect_success \
-    'Pre-check that bar exists and is in index before "git rm bar"' \
-    '[ -f bar ] && git ls-files --error-unmatch bar'
-
-test_expect_success \
-    'Test that "git rm bar" succeeds' \
-    'git rm bar'
-
-test_expect_success \
-    'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
-
-test_expect_success \
-    'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
-    'git rm -- -q'
-
-test_expect_success FUNNYNAMES \
-    "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
-    "git rm -f 'space embedded' 'tab	embedded' 'newline
-embedded'"
+test_expect_success 'Pre-check that foo exists and is in index before git rm foo' '
+	test_path_is_file foo &&
+	git ls-files --error-unmatch foo
+'
+
+test_expect_success 'Test that git rm foo succeeds' '
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo &&
+	echo "other content" >foo &&
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	test_must_fail git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached -f foo works in case where --cached only did not' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	git rm --cached -f foo
+'
+
+test_expect_success 'Post-check that foo exists but is not in index after git rm foo' '
+	test_path_is_file foo &&
+	test_must_fail git ls-files --error-unmatch foo
+'
+
+test_expect_success 'Pre-check that bar exists and is in index before "git rm bar"' '
+	test_path_is_file bar &&
+	git ls-files --error-unmatch bar
+'
+
+test_expect_success 'Test that "git rm bar" succeeds' '
+	git rm bar
+'
+
+test_expect_success 'Post-check that bar does not exist and is not in index after "git rm -f bar"' '
+	test_path_is_missing bar &&
+	test_must_fail git ls-files --error-unmatch bar
+'
+
+test_expect_success 'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' '
+	git rm -- -q
+'
+
+test_expect_success FUNNYNAMES "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." "
+	git rm -f 'space embedded' 'tab	embedded' 'newline
+embedded'
+"
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	test_when_finished "chmod 775 ." &&
@@ -100,9 +104,9 @@ test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	test_must_fail git rm -f baz
 '
 
-test_expect_success \
-    'When the rm in "git rm -f" fails, it should not remove the file from the index' \
-    'git ls-files --error-unmatch baz'
+test_expect_success 'When the rm in "git rm -f" fails, it should not remove the file from the index' '
+	git ls-files --error-unmatch baz
+'
 
 test_expect_success 'Remove nonexistent file with --ignore-unmatch' '
 	git rm --ignore-unmatch nonexistent
@@ -218,22 +222,22 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 test_expect_success 'Call "rm" from outside the work tree' '
 	mkdir repo &&
 	(cd repo &&
-	 git init &&
-	 echo something >somefile &&
-	 git add somefile &&
-	 git commit -m "add a file" &&
-	 (cd .. &&
-	  git --git-dir=repo/.git --work-tree=repo rm somefile) &&
-	test_must_fail git ls-files --error-unmatch somefile)
+		git init &&
+		echo something >somefile &&
+		git add somefile &&
+		git commit -m "add a file" &&
+		(cd .. &&
+			git --git-dir=repo/.git --work-tree=repo rm somefile
+		) &&
+		test_must_fail git ls-files --error-unmatch somefile
+	)
 '
 
 test_expect_success 'refresh index before checking if it is up-to-date' '
-
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
 	test ! -f frotz/nitfol
-
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
@@ -242,8 +246,8 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	i=0 &&
 	while test $i -lt 12000
 	do
-	    echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
-	    i=$(( $i + 1 ))
+		echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
+		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
-- 
2.17.1

