Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01491F51C
	for <e@80x24.org>; Fri, 18 May 2018 14:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeEROSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 10:18:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42539 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeEROSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 10:18:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id t16-v6so6209876wrm.9
        for <git@vger.kernel.org>; Fri, 18 May 2018 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJi4+SUpjj7DrJRDmhvq2q4ynH2CtIc3qw/1bKpJDoU=;
        b=vJi43ZWWLqODVkxjKH8I7oySpvTrkF+hHB9KEnQR0dR0FK9Gb+VVTXrU9MXBXiPJSq
         BxBgMtaFyvSdr/eONjLgSvytDCFiAY8rCgvmL0WybTcpATwUj14O157dFCrueQPZkkjf
         IOB/g9gFN5UKTfeaamyP2Acr0L7l6w39ytDHD3wWS3F7jD9Tqqe+M9oExv4g73TpQqqO
         ynZuXie2zbtndaaJb84Ur7aw6bmUms2jDI+hnbaZOzv1grk99vX2NCGn6VhWpav7ZnQ6
         hMdWuheUseDADEnW0Ao8MyHhtfULoKmyDzPtYAyYcMk9w8vJ/m3SNGdz50HEKf769Sbt
         8kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJi4+SUpjj7DrJRDmhvq2q4ynH2CtIc3qw/1bKpJDoU=;
        b=ZVkq91aN14MFGfRsJU4tlC6yE7MVn7MhMP4zDfiGedA83PK12brTrDqHT1kS2LIWna
         RAU6LF4YWILJE/cdwEMFqxw7bkaLD4T+zqNT2Q9c/Z8gYMHLiXvE7WA0tR3EF7JJSfxq
         VdIWbN9NyihKlH9Rnz1KuyakL8dIzBLMT45xMZO4HZaehsZdWXLEkDrNgY1pPpEdgrZk
         l7nuZRyXce0LJ+HSnTzSqJMZG2OYrSsI0qTiSLGz+uEj1vjmZw+5UFOnHh8WPSi7NhbN
         JuCJ7AtHkgGNstl9Et53K45ghNoRLNxNFgi9dOWCJhlk/Llyq/svkdnE8Ho2oq9oyHEM
         udTA==
X-Gm-Message-State: ALKqPwfGDnVrvaFYa3Z7qwOowzQ+1nBZHGPX71kF9OR6JTpLscZoOdh+
        3l4fqNin64Wps4Lum1A7Wo4=
X-Google-Smtp-Source: AB8JxZoOvZdapTNmNgMn/WXDCjkmygUoOCgKE1quUdpoxYNKTj6ZzFD5d3/OZbUoUiBO5fZvtKivyg==
X-Received: by 2002:adf:9814:: with SMTP id v20-v6mr8196905wrb.93.1526653088816;
        Fri, 18 May 2018 07:18:08 -0700 (PDT)
Received: from localhost.localdomain (x4db17294.dyn.telefonica.de. [77.177.114.148])
        by smtp.gmail.com with ESMTPSA id u37-v6sm7606937wrb.53.2018.05.18.07.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 07:18:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t9902-completion: exercise __git_complete_index_file() directly
Date:   Fri, 18 May 2018 16:17:51 +0200
Message-Id: <20180518141751.16350-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180518141751.16350-1-szeder.dev@gmail.com>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com>
 <20180518141751.16350-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 2f271cd9cf (t9902-completion: add tests
demonstrating issues with quoted pathnames, 2018-05-08) and in
2ab6eab4fe (completion: improve handling quoted paths in 'git
ls-files's output, 2018-03-28) have a few shortcomings:

  - All these test use the 'test_completion' helper function, thus
    they are exercising the whole completion machinery, although they
    are only interested in how git-aware path completion, specifically
    the __git_complete_index_file() function deals with unusual
    characters in pathnames and on the command line.

  - These tests can't satisfactorily test the case of pathnames
    containing spaces, because 'test_completion' gets the words on the
    command line as a single argument and it uses space as word
    separator.

  - Some of the tests are protected by different FUNNYNAMES_* prereqs
    depending on whether they put backslashes and double quotes or
    separator characters (FS, GS, RS, US) in pathnames, although a
    filesystem not allowing one likely doesn't allow the others
    either.

  - One of the tests operates on paths containing '|' and '&'
    characters without being protected by a FUNNYNAMES prereq, but
    some filesystems (notably on Windows) don't allow these characters
    in pathnames, either.

Replace these tests with basically equivalent, more focused tests that
call __git_complete_index_file() directly.  Since this function only
looks at the current word to be completed, i.e. the $cur variable, we
can easily include pathnames containing spaces in the tests, so use
such pathnames instead of pathnames containing '|' and '&'.  Finally,
use only a single FUNNYNAMES prereq for all kinds of special
characters.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 225 ++++++++++++++++++++++--------------------
 1 file changed, 118 insertions(+), 107 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 955932174c..1b6d275254 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1209,6 +1209,124 @@ test_expect_success 'teardown after ref completion' '
 	git remote remove other
 '
 
+
+test_path_completion ()
+{
+	test $# = 2 || error "bug in the test script: not 2 parameters to test_path_completion"
+
+	local cur="$1" expected="$2"
+	echo "$expected" >expected &&
+	(
+		# In the following tests calling this function we only
+		# care about how __git_complete_index_file() deals with
+		# unusual characters in path names.  By requesting only
+		# untracked files we dont have to bother adding any
+		# paths to the index in those tests.
+		__git_complete_index_file --others &&
+		print_comp
+	) &&
+	test_cmp expected out
+}
+
+test_expect_success 'setup for path completion tests' '
+	mkdir simple-dir \
+	      "spaces in dir" \
+	      árvíztűrő &&
+	touch simple-dir/simple-file \
+	      "spaces in dir/spaces in file" \
+	      "árvíztűrő/Сайн яваарай" &&
+	if test_have_prereq !MINGW &&
+	   mkdir BS\\dir \
+		 '$'separators\034in\035dir'' &&
+	   touch BS\\dir/DQ\"file \
+		 '$'separators\034in\035dir/sep\036in\037file''
+	then
+		test_set_prereq FUNNYNAMES
+	else
+		rm -rf BS\\dir '$'separators\034in\035dir''
+	fi
+'
+
+test_expect_success '__git_complete_index_file - simple' '
+	test_path_completion simple simple-dir &&  # Bash is supposed to
+						   # add the trailing /.
+	test_path_completion simple-dir/simple simple-dir/simple-file
+'
+
+test_expect_success \
+    '__git_complete_index_file - escaped characters on cmdline' '
+	test_path_completion spac "spaces in dir" &&  # Bash will turn this
+						      # into "spaces\ in\ dir"
+	test_path_completion "spaces\\ i" \
+			     "spaces in dir" &&
+	test_path_completion "spaces\\ in\\ dir/s" \
+			     "spaces in dir/spaces in file" &&
+	test_path_completion "spaces\\ in\\ dir/spaces\\ i" \
+			     "spaces in dir/spaces in file"
+'
+
+test_expect_success \
+    '__git_complete_index_file - quoted characters on cmdline' '
+	# Testing with an opening but without a corresponding closing
+	# double quote is important.
+	test_path_completion \"spac "spaces in dir" &&
+	test_path_completion "\"spaces i" \
+			     "spaces in dir" &&
+	test_path_completion "\"spaces in dir/s" \
+			     "spaces in dir/spaces in file" &&
+	test_path_completion "\"spaces in dir/spaces i" \
+			     "spaces in dir/spaces in file"
+'
+
+test_expect_success '__git_complete_index_file - UTF-8 in ls-files output' '
+	test_path_completion á árvíztűrő &&
+	test_path_completion árvíztűrő/С "árvíztűrő/Сайн яваарай"
+'
+
+test_expect_success FUNNYNAMES \
+    '__git_complete_index_file - C-style escapes in ls-files output' '
+	test_path_completion BS \
+			     BS\\dir &&
+	test_path_completion BS\\\\d \
+			     BS\\dir &&
+	test_path_completion BS\\\\dir/DQ \
+			     BS\\dir/DQ\"file &&
+	test_path_completion BS\\\\dir/DQ\\\"f \
+			     BS\\dir/DQ\"file
+'
+
+test_expect_success FUNNYNAMES \
+    '__git_complete_index_file - \nnn-escaped characters in ls-files output' '
+	test_path_completion sep '$'separators\034in\035dir'' &&
+	test_path_completion '$'separators\034i'' \
+			     '$'separators\034in\035dir'' &&
+	test_path_completion '$'separators\034in\035dir/sep'' \
+			     '$'separators\034in\035dir/sep\036in\037file'' &&
+	test_path_completion '$'separators\034in\035dir/sep\036i'' \
+			     '$'separators\034in\035dir/sep\036in\037file''
+'
+
+test_expect_success FUNNYNAMES \
+    '__git_complete_index_file - removing repeated quoted path components' '
+	test_when_finished rm -r repeated-quoted &&
+	mkdir repeated-quoted &&      # A directory whose name in itself
+				      # would not be quoted ...
+	>repeated-quoted/0-file &&
+	>repeated-quoted/1\"file &&   # ... but here the file makes the
+				      # dirname quoted ...
+	>repeated-quoted/2-file &&
+	>repeated-quoted/3\"file &&   # ... and here, too.
+
+	# Still, we shold only list the directory name only once.
+	test_path_completion repeated repeated-quoted
+'
+
+test_expect_success 'teardown after path completion tests' '
+	rm -rf simple-dir "spaces in dir" árvíztűrő \
+	       BS\\dir '$'separators\034in\035dir''
+'
+
+
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
 	name-1
@@ -1469,113 +1587,6 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
-# The next tests only care about how the completion script deals with
-# unusual characters in path names.  By defining a custom completion
-# function to list untracked files they won't be influenced by future
-# changes of the completion functions of real git commands, and we
-# don't have to bother with adding files to the index in these tests.
-_git_test_path_comp ()
-{
-	__git_complete_index_file --others
-}
-
-test_expect_success 'complete files - escaped characters on cmdline' '
-	test_when_finished "rm -rf \"New|Dir\"" &&
-	mkdir "New|Dir" &&
-	>"New|Dir/New&File.c" &&
-
-	test_completion "git test-path-comp N" \
-			"New|Dir" &&	# Bash will turn this into "New\|Dir/"
-	test_completion "git test-path-comp New\\|D" \
-			"New|Dir" &&
-	test_completion "git test-path-comp New\\|Dir/N" \
-			"New|Dir/New&File.c" &&	# Bash will turn this into
-						# "New\|Dir/New\&File.c "
-	test_completion "git test-path-comp New\\|Dir/New\\&F" \
-			"New|Dir/New&File.c"
-'
-
-test_expect_success 'complete files - quoted characters on cmdline' '
-	test_when_finished "rm -r \"New(Dir\"" &&
-	mkdir "New(Dir" &&
-	>"New(Dir/New)File.c" &&
-
-	# Testing with an opening but without a corresponding closing
-	# double quote is important.
-	test_completion "git test-path-comp \"New(D" "New(Dir" &&
-	test_completion "git test-path-comp \"New(Dir/New)F" \
-			"New(Dir/New)File.c"
-'
-
-test_expect_success 'complete files - UTF-8 in ls-files output' '
-	test_when_finished "rm -r árvíztűrő" &&
-	mkdir árvíztűrő &&
-	>"árvíztűrő/Сайн яваарай" &&
-
-	test_completion "git test-path-comp á" "árvíztűrő" &&
-	test_completion "git test-path-comp árvíztűrő/С" \
-			"árvíztűrő/Сайн яваарай"
-'
-
-# Testing with a path containing a backslash is important.
-if test_have_prereq !MINGW &&
-   mkdir 'New\Dir' 2>/dev/null &&
-   touch 'New\Dir/New"File.c' 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES_BS_DQ
-else
-	say "Your filesystem does not allow \\ and \" in filenames."
-	rm -rf 'New\Dir'
-fi
-test_expect_success FUNNYNAMES_BS_DQ \
-    'complete files - C-style escapes in ls-files output' '
-	test_when_finished "rm -r \"New\\\\Dir\"" &&
-
-	test_completion "git test-path-comp N" "New\\Dir" &&
-	test_completion "git test-path-comp New\\\\D" "New\\Dir" &&
-	test_completion "git test-path-comp New\\\\Dir/N" \
-			"New\\Dir/New\"File.c" &&
-	test_completion "git test-path-comp New\\\\Dir/New\\\"F" \
-			"New\\Dir/New\"File.c"
-'
-
-if test_have_prereq !MINGW &&
-   mkdir $'New\034Special\035Dir' 2>/dev/null &&
-   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES_SEPARATORS
-else
-	say 'Your filesystem does not allow special separator characters (FS, GS, RS, US) in filenames.'
-	rm -rf $'New\034Special\035Dir'
-fi
-test_expect_success FUNNYNAMES_SEPARATORS \
-    'complete files - \nnn-escaped control characters in ls-files output' '
-	test_when_finished "rm -r '$'New\034Special\035Dir''" &&
-
-	# Note: these will be literal separator characters on the cmdline.
-	test_completion "git test-path-comp N" "'$'New\034Special\035Dir''" &&
-	test_completion "git test-path-comp '$'New\034S''" \
-			"'$'New\034Special\035Dir''" &&
-	test_completion "git test-path-comp '$'New\034Special\035Dir/''" \
-			"'$'New\034Special\035Dir/New\036Special\037File''" &&
-	test_completion "git test-path-comp '$'New\034Special\035Dir/New\036S''" \
-			"'$'New\034Special\035Dir/New\036Special\037File''"
-'
-
-test_expect_success FUNNYNAMES_BS_DQ \
-    'complete files - removing repeated quoted path components' '
-	test_when_finished rm -rf NewDir &&
-	mkdir NewDir &&    # A dirname which in itself would not be quoted ...
-	>NewDir/0-file &&
-	>NewDir/1\"file && # ... but here the file makes the dirname quoted ...
-	>NewDir/2-file &&
-	>NewDir/3\"file && # ... and here, too.
-
-	# Still, we should only list it once.
-	test_completion "git test-path-comp New" "NewDir"
-'
-
-
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
 	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
-- 
2.17.0.799.gd371044c7c

