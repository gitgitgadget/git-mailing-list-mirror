Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CA720248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfCQKQG (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so9412873pgq.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wWJvqSE2oCViRRDJdK6IxbYXV6iq07YlKKMMctk4/OU=;
        b=DnpIzIQ09UKCl7FC3qob8gNnElrSQqu7iyrBZfppypq+JFFOAkvqY4V+5IlffKFKDA
         MOg7QahKUh8AL8G455BNJ3rZ2HPd37FYLesCaeaypFp2NzVgkUH7cVFP2Xj60Mt0FhHb
         RNW5K8frzcxnv0H1fIDekT2V6d4UZNGa6gFS22SDS3k4S86vMhSo6HQUumWibvkyA01Z
         qXEXPY0le5N/0HvJmdxZwdi6IvoIvowwiq9uqmv0gSAav4hQ3livznV60giVdtUXytyS
         eg6ixOn9XsyAT21/6nkSrV1EHAspnpFJG2T6mulEjw3Vd29VCM2ojXU0qXC+iH8zHsly
         nYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wWJvqSE2oCViRRDJdK6IxbYXV6iq07YlKKMMctk4/OU=;
        b=bRi7LsF90r/y1xQAtFI8/oDIBhw+jZkJ4Stx2WUA3OBsegyX8/2GOyLx0Wz9NA7zoz
         ayBzaYgnBZ+mJ4Xbn7ofcy8P70/eJwkfffLZ8tjY0RunVTdFyLYuNd/ZyH4H/kyiBR5I
         WyFClMEDObt3dc3Dmx7yzHLJQWp1nCZPIVXVmfUTPovO1sTumuHMnR8wzNC1Q/FcMm1P
         gRNm77KkDYxgdnzcVBLXqfXh0hjG7sbC3aLBiGFqBzaxmR4EUuhCUCFiNWZETUaGjHrq
         YLXU2Vwb56gKIX19knfhAG96/kbde9d12ZjNKW9HA/pL1NB27wRu+yl0NAopdhhRxwM/
         16+A==
X-Gm-Message-State: APjAAAVCsKJgrc2lBlDy20LDlQwP4TqIqHLtt9PtWgRwFJt9Ye0WJsSf
        88rS8jr8fIkqscBMpd6N/UaYSfdM
X-Google-Smtp-Source: APXvYqxlnkW8PVbThQ4hoL6Id6tv/30KzJ7PYsPQWLOloqmjNHvib4nGLvKV4WxnSmjbZQWpJbz+Mw==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr13494567plr.278.1552817764856;
        Sun, 17 Mar 2019 03:16:04 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 138sm10343285pfx.93.2019.03.17.03.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:04 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:16:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 04/11] t7502: clean up test style
Message-ID: <0759de616eb57825852a2a1b5e27f6e884d68fc2.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out git commands that were upstream of a pipe. Also, as a style
cleanup, remove spaces after "> ". Next, indent here-docs. Finally,
convert echo chains to use the test_write_lines function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7502-commit-porcelain.sh | 100 ++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index ca4a740da0..f035e4a507 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -16,7 +16,9 @@ commit_msg_is () {
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit ${3+"$3"} -m "$2" | head -1 > act &&
+	git commit ${3+"$3"} -m "$2" >act &&
+	head -1 <act >tmp &&
+	mv tmp act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -68,7 +70,7 @@ test_expect_success 'output summary format for merges' '
 	git checkout recursive-a &&
 	test_must_fail git merge recursive-b &&
 	# resolve the conflict
-	echo commit-a > file1 &&
+	echo commit-a >file1 &&
 	git add file1 &&
 	check_summary_oneline "" "Merge"
 '
@@ -142,8 +144,8 @@ test_expect_success 'sign off' '
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
-	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
+	actual=$(git cat-file commit HEAD >tmp && sed -ne "s/Signed-off-by: //p" <tmp && rm tmp) &&
+	expected=$(git var GIT_COMMITTER_IDENT >tmp && sed -e "s/>.*/>/" <tmp && rm tmp) &&
 	test "z$actual" = "z$expected"
 
 '
@@ -153,8 +155,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
-	expected=$(echo one; echo; echo two; echo; echo three) &&
+	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" <tmp && rm tmp) &&
+	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
 '
@@ -163,7 +165,9 @@ test_expect_success 'verbose' '
 
 	echo minus >negative &&
 	git add negative &&
-	git status -v | sed -ne "/^diff --git /p" >actual &&
+	git status -v >actual &&
+	sed -ne "/^diff --git /p" <actual >tmp &&
+	mv tmp actual &&
 	echo "diff --git a/negative b/negative" >expect &&
 	test_cmp expect actual
 
@@ -189,7 +193,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -198,7 +204,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -207,7 +215,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -215,10 +225,12 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >text &&
+	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -226,48 +238,54 @@ test_expect_success 'cleanup commit messages (whitespace option,-F)' '
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
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
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
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo sample;echo; } >text &&
+	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -275,7 +293,7 @@ test_expect_success 'cleanup commit messages (strip option,-F)' '
 test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
-	{ echo;echo sample;echo; } >text &&
+	test_write_lines "" "sample" "" >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual
 '
@@ -387,7 +405,7 @@ test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 '
 
 write_script .git/FAKE_EDITOR <<EOF
-echo editor started > "$(pwd)/.git/result"
+echo editor started >"$(pwd)/.git/result"
 exit 0
 EOF
 
@@ -455,7 +473,7 @@ EOF
 test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	echo >>negative &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git commit -a'\'' &&
@@ -471,7 +489,9 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 	test_must_fail git merge second master &&
 	git checkout master g &&
 	EDITOR=: git commit -a &&
-	git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -n -e "s/^parent //p" -e "/^$/q" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -480,7 +500,9 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_line_count = 3 actual
 
 '
-- 
2.21.0.512.g57bf1b23e1

