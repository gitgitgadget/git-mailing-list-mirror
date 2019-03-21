Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC0420248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCUGxt (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40217 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUGxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3689382pfc.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=75TH6zfU3ftXoZ+0EvQdGm0O4Z9rYSkyS4KMdcMba0o=;
        b=S4qlhpjnU1nlOHrSba0ucYeXLCMEemeJ1Le6meBkQ/bxXbBmaUvefpT9mDAj/0MZAW
         S5zXNrtCuxyfNG15JS6X3vZMSFKTMWXfpAoaXFB5jwMMMJXINXjcJ9jLN/6ayHNniZIb
         h3JtUKvdAavpUd6qM0x0cVzzQSyfsPrTexAxyHErS9vlMzhwRqt8QYHh7eoOVbVWJ7up
         1GT01gjL4lPV3MPTpI6eicKlO9DZEiiNjXQsGdRYvy94Aln/Hv7yxsvPAhrsvSzPJpgd
         Q4qgStph3vkJ6CjC4nRJlEvXGeNl0l0BlB3MM6nVsckpA2oQWsCHiN7Cjvv+cMlujjYG
         P8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=75TH6zfU3ftXoZ+0EvQdGm0O4Z9rYSkyS4KMdcMba0o=;
        b=kEN1ifW2Bz5MUZU4p2sk3Kklqaag+RY8nPD9g9pcS9a9BVrk5dqSusILe6cs5x5WVa
         Gj+o1EvcI+eXbYHIIt7Mp2ASWwur++E81wEFHFqWT9VlKoQkkGSvHgz4ryvymKcBoRXo
         ZNO5voCdvaJ/UKR/KVp/5qbOnSZ7ewe5T7dbaQAjNh4QZ8GiPQnE0SaPTVQf/X2kX8QH
         fcUsJSsKW79g8kYO7pUzmiGgPA29w/m/8122yXTQZc/UArl52rQkFUpJRw+KuFllkOT4
         6U64qskBpPP1tGtUNT1fobMLu31iXhTdXEBWuwx15Rtp9b1EnSLugEcvmEIAqWFNJ8zH
         x+hQ==
X-Gm-Message-State: APjAAAWJOyZy4k9MNdCP9ZQ6nnsGnguiK3NZvEMn/9EuSWsMP4c5e1SH
        VCwz2gIcG3UhVKlR3IiSptePtbQPLZA=
X-Google-Smtp-Source: APXvYqwU3etQHQo6CxS9/k1AfrjBcuBdzEcFIt0qMw7kUc4OKaccHHWlyM1nTBAuxo/AF7ffo0Pg+Q==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr1937628pgi.387.1553151228564;
        Wed, 20 Mar 2019 23:53:48 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id a20sm6621764pfj.5.2019.03.20.23.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:47 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:46 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 04/11] t7502: clean up style
Message-ID: <845a32295467706d9ce029ba1282851577fa51ac.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out Git commands that were upstream of a pipe. Remove spaces
after "> ". Indent here-docs appropriately. Convert echo chains to use
the test_write_lines function. Refactor 'sign off' test to use test_cmp
instead of comparing variables.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7502-commit-porcelain.sh | 93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index ca4a740da0..5733d9cd34 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -16,7 +16,8 @@ commit_msg_is () {
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit ${3+"$3"} -m "$2" | head -1 > act &&
+	git commit ${3+"$3"} -m "$2" >raw &&
+	head -n 1 raw >act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -68,7 +69,7 @@ test_expect_success 'output summary format for merges' '
 	git checkout recursive-a &&
 	test_must_fail git merge recursive-b &&
 	# resolve the conflict
-	echo commit-a > file1 &&
+	echo commit-a >file1 &&
 	git add file1 &&
 	check_summary_oneline "" "Merge"
 '
@@ -142,9 +143,11 @@ test_expect_success 'sign off' '
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
-	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
-	test "z$actual" = "z$expected"
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	test_cmp expected actual
 
 '
 
@@ -153,8 +156,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
-	expected=$(echo one; echo; echo two; echo; echo three) &&
+	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" tmp && rm tmp) &&
+	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
 '
@@ -163,7 +166,8 @@ test_expect_success 'verbose' '
 
 	echo minus >negative &&
 	git add negative &&
-	git status -v | sed -ne "/^diff --git /p" >actual &&
+	git status -v >raw &&
+	sed -ne "/^diff --git /p" raw >actual &&
 	echo "diff --git a/negative b/negative" >expect &&
 	test_cmp expect actual
 
@@ -189,7 +193,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -198,7 +203,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -207,7 +213,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -215,10 +222,11 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >text &&
+	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -226,48 +234,51 @@ test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 test_expect_success 'cleanup commit messages (scissors option,-F,-e)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
+	cat >text <<-\EOF &&
 
-# to be kept
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-# ------------------------ >8 ------------------------
-to be removed
-# ------------------------ >8 ------------------------
-to be removed, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	# ------------------------ >8 ------------------------
+	to be removed
+	# ------------------------ >8 ------------------------
+	to be removed, too
+	EOF
 
-	cat >expect <<EOF &&
-# to be kept
+	cat >expect <<-\EOF &&
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	EOF
 	git commit --cleanup=scissors -e -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit messages (scissors option,-F,-e, scissors on first line)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
-# ------------------------ >8 ------------------------
-to be removed
-EOF
+	cat >text <<-\EOF &&
+	# ------------------------ >8 ------------------------
+	to be removed
+	EOF
 	git commit --cleanup=scissors -e -F text -a --allow-empty-message &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo sample;echo; } >text &&
+	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -275,7 +286,7 @@ test_expect_success 'cleanup commit messages (strip option,-F)' '
 test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
-	{ echo;echo sample;echo; } >text &&
+	test_write_lines "" "sample" "" >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual
 '
@@ -387,7 +398,7 @@ test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 '
 
 write_script .git/FAKE_EDITOR <<EOF
-echo editor started > "$(pwd)/.git/result"
+echo editor started >"$(pwd)/.git/result"
 exit 0
 EOF
 
@@ -455,7 +466,7 @@ EOF
 test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	echo >>negative &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git commit -a'\'' &&
@@ -471,7 +482,8 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 	test_must_fail git merge second master &&
 	git checkout master g &&
 	EDITOR=: git commit -a &&
-	git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -n -e "s/^parent //p" -e "/^$/q" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -480,7 +492,8 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_line_count = 3 actual
 
 '
-- 
2.21.0.512.g57bf1b23e1

