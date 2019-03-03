Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B454D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 12:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCCM3e (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 07:29:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40768 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCM3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 07:29:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so1121543pfo.7
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Cy1a+ax9LvWeI/Xx9ZvttjvYyT2IiYkyNY6HSfsXM4=;
        b=QCtllbP2H4W5KCJ8S3skjjs3lfxmtfR5cujm5C9G3k5Aih/GoR1A6arBPF7BcmLeCm
         r3OUNlukvFCnXXi+EwEPFU7wQSmJ2OllWvNZ9nPz16c2x9PJ/ozJXomJZuUX8H/kny+K
         YlOTXXbKtoF456BvWypR3L/Nt5uLt/kpWFSyrucXEHRND4PCtPkkX7d833V7ozNqPZtz
         jduwjifGktmXNLHWvYHMMec7GqQKCVmqZ0hsL3Ic2sY23cxkOK4AxnyeOifKIZKKKoz2
         0zbOUDOaVt60z5UClY0jdUay//5a2IQHNl/IdDmB0waWLshv3Cy96FocEr7mRFaEzDle
         oOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Cy1a+ax9LvWeI/Xx9ZvttjvYyT2IiYkyNY6HSfsXM4=;
        b=BCAIn8U5kmvtXoCQgi9yHM1DjBddfcEc2A2Q0H9R8s0Xg6vpt4noDdW2EwzSwQgGzK
         uRAlfw9qQtxO5+7qgzTbjnSGylPx7soUt3ktj84lyXm5gNth8ZSxUQ6PdCw1KGUNAA0n
         wnDctP5AXlr3KKTwgoQwUtIWJeRjr48RPriwrJ1xtvJ3zrf6n//X8BemlegGDdDf4jdO
         8/sd561Y+nOL8hnXHSYJOBvjyoiVqd47L11hQLrNYmxBWCU6LbEF0JJGucyvIiNc8XzS
         sgBPWAnDV+3HU/hhF+O7AcdRjA80YBxtGR/7NTQNSsMBmtFemNH9KxpRmHQx2feeJASQ
         kfkA==
X-Gm-Message-State: APjAAAVGXC+7siwToroVxNiJDMhCxy6EB4uh4CEG1KwjgxxwTZxgud5n
        zh9L2j1e7cgulM4eoG5HH4n1c1Ekat8=
X-Google-Smtp-Source: APXvYqw5eHHoX44Gp7teuDaF8F1ARm6KdAE2vI9EImJscTfoYK+9HS5c6OdtC/TqwrYA6N3C87RJ7Q==
X-Received: by 2002:aa7:90c1:: with SMTP id k1mr14800954pfk.202.1551616172503;
        Sun, 03 Mar 2019 04:29:32 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id l5sm6861093pfi.97.2019.03.03.04.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 04:29:31 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        t.gummerer@gmail.com, christian.couder@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [PATCH 2/3] t3600: refactor code according to contemporary guidelines
Date:   Sun,  3 Mar 2019 17:58:41 +0530
Message-Id: <20190303122842.30380-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace leading spaces with tabs

The previous code of `t3600-rm.sh` had a mix use of tabs and spaces with
instance of `not-so-recommended` way of writing `if-then` statement,
replace them so that the current version agrees with the coding guidelines

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 131 ++++++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..ec4877bfec 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -9,89 +9,94 @@ test_description='Test of the various options to git rm.'
 
 # Setup some files to be removed, some with funny characters
 test_expect_success \
-    'Initialize test directory' \
-    "touch -- foo bar baz 'space embedded' -q &&
-     git add -- foo bar baz 'space embedded' -q &&
-     git commit -m 'add normal files'"
+	'Initialize test directory' "
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
 
 test_expect_success \
-    'Pre-check that foo exists and is in index before git rm foo' \
-    '[ -f foo ] && git ls-files --error-unmatch foo'
+	'Pre-check that foo exists and is in index before git rm foo' \
+	'[ -f foo ] && git ls-files --error-unmatch foo'
 
 test_expect_success \
-    'Test that git rm foo succeeds' \
-    'git rm --cached foo'
+	'Test that git rm foo succeeds' \
+	'git rm --cached foo'
 
 test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git rm --cached foo'
+	'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git rm --cached foo
+'
 
 test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo &&
-     echo "other content" >foo &&
-     git rm --cached foo'
+	'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo &&
+	echo "other content" >foo &&
+	git rm --cached foo
+'
 
 test_expect_success \
-    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     test_must_fail git rm --cached foo
+	'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	test_must_fail git rm --cached foo
 '
 
 test_expect_success \
-    'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     git rm --cached -f foo'
+	'Test that git rm --cached -f foo works in case where --cached only did not' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	git rm --cached -f foo
+'
 
 test_expect_success \
-    'Post-check that foo exists but is not in index after git rm foo' \
-    '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
+	'Post-check that foo exists but is not in index after git rm foo' \
+	'[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
 
 test_expect_success \
-    'Pre-check that bar exists and is in index before "git rm bar"' \
-    '[ -f bar ] && git ls-files --error-unmatch bar'
+	'Pre-check that bar exists and is in index before "git rm bar"' \
+	'[ -f bar ] && git ls-files --error-unmatch bar'
 
 test_expect_success \
-    'Test that "git rm bar" succeeds' \
-    'git rm bar'
+	'Test that "git rm bar" succeeds' \
+	'git rm bar'
 
 test_expect_success \
-    'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
+	'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
+	'! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
 
 test_expect_success \
-    'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
-    'git rm -- -q'
+	'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
+	'git rm -- -q'
 
 test_expect_success FUNNYNAMES \
-    "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
-    "git rm -f 'space embedded' 'tab	embedded' 'newline
+	"Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
+	"git rm -f 'space embedded' 'tab	embedded' 'newline
 embedded'"
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
@@ -101,8 +106,8 @@ test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 '
 
 test_expect_success \
-    'When the rm in "git rm -f" fails, it should not remove the file from the index' \
-    'git ls-files --error-unmatch baz'
+	'When the rm in "git rm -f" fails, it should not remove the file from the index' \
+	'git ls-files --error-unmatch baz'
 
 test_expect_success 'Remove nonexistent file with --ignore-unmatch' '
 	git rm --ignore-unmatch nonexistent
@@ -218,22 +223,22 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
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
@@ -242,8 +247,8 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
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

