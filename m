Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314E21F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfKMSzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38430 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKMSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so3787934ljh.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itIbNbcPbXjIy4vURPK2pJHVCGhNOByKpHzFgPbWvTI=;
        b=WzqrjE0MorwPb0he5QubIcnU/FXIyed2Q4bhmm+9mrGycCQon/g6pgJKf4IO0rCp3I
         3c8T1ey6k8XjIHQh/e7jWz8kxete0VlJPwVVH1Nz74H4hj9wXP66GAH9oHWS0tyOPX3i
         LYdCrdsrz+UposJOhD4r51hM4sCEMlr1WX66htIlrWEc19LlZMNQ5CbRkve9f2n1885A
         wfuFu6PaxnM9SrHbk46ru4n3oW9XIt0RmEO1Tszci+bVL2sv7TtE4bITjcF6U8Z0tGUp
         XF3Wtk7FFgG3qSCsFS8vEKPjZJBfsW1ddtyKkNS9MjBnkXZriGbfIuiAPUyQCyOwB6GK
         AZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itIbNbcPbXjIy4vURPK2pJHVCGhNOByKpHzFgPbWvTI=;
        b=V+pY1NBw325nIg5WAMMjYh9yOvbGp3ffFNr+cW9CzzFMRQ0T9e+N0FqD/kNbDYEEC6
         BNFCzAkl2wkEy/lHO2ZgprGCNptM8Q1hcubwVq6M/2oDtvmUzg/xQ1vEzOUbL93tXc++
         xcGbNSEhNb0eyXYtkmpb4Ko/195Ysdo+eqi+0XtpmeyuxW568DdY7hY30Ui4plLv38dn
         m1RgPXo8cpkZ0dCA8LLtbzLDCQJlyLtg8dfJMGjvruBoQeynu5W6cbryzJyJPgAQjA+m
         3peJK9OG0K4oZV1zrDZyGAb9hL+k06pN+nCChGhHxpPRoeDZ136oXWyUsUUCGBhtqyJx
         ZCpg==
X-Gm-Message-State: APjAAAWYOUZE2hxUdieexSWUZDwUOqkO6j4B+TYFkMOhqUZcNKBh2csj
        qT/+fY6jeWxt0nvx6cB4EdgDIUpC
X-Google-Smtp-Source: APXvYqxgFRjlUM7xAj9Q/T4pZFw8QG22aK5d7sp8S9qvbvmq++rTcRE3l587JC3fMg2FlsVoMt8hIw==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr3721680ljc.227.1573671337564;
        Wed, 13 Nov 2019 10:55:37 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] t1300: modernize part of script
Date:   Wed, 13 Nov 2019 19:55:01 +0100
Message-Id: <37e2b121d5946cfacb3fc4d2721770e496f7b752.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create `.git/config` and `expect` files inside `test_expect_success`,
either inside the one existing test that uses the file, or in a new
"setup" step before several tests that use it.

Redirect using `>output` rather than `> output`. Use `<<-\EOF" with
heredocs rather than just `<< EOF` and use `q_to_tab` to create properly
indented input and output files.

This commit does not modernize the whole script, but just some of it,
around the point where a later commit will add new content.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1300-config.sh | 138 ++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 73 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 983a0a1583..a38cc143a1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -321,15 +321,14 @@ test_expect_success 'hierarchical section value' '
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
-beta.noindent=sillyValue
-nextsection.nonewline=wow2 for me
-123456.a123=987
-version.1.2.3eX.alpha=beta
-EOF
-
 test_expect_success 'working --list' '
-	git config --list > output &&
+	cat >expect <<-\EOF &&
+	beta.noindent=sillyValue
+	nextsection.nonewline=wow2 for me
+	123456.a123=987
+	version.1.2.3eX.alpha=beta
+	EOF
+	git config --list >output &&
 	test_cmp expect output
 '
 test_expect_success '--list without repo produces empty output' '
@@ -337,55 +336,53 @@ test_expect_success '--list without repo produces empty output' '
 	test_must_be_empty output
 '
 
-cat > expect << EOF
-beta.noindent
-nextsection.nonewline
-123456.a123
-version.1.2.3eX.alpha
-EOF
-
 test_expect_success '--name-only --list' '
+	cat >expect <<-\EOF &&
+	beta.noindent
+	nextsection.nonewline
+	123456.a123
+	version.1.2.3eX.alpha
+	EOF
 	git config --name-only --list >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-beta.noindent sillyValue
-nextsection.nonewline wow2 for me
-EOF
-
 test_expect_success '--get-regexp' '
+	cat >expect <<-\EOF &&
+	beta.noindent sillyValue
+	nextsection.nonewline wow2 for me
+	EOF
 	git config --get-regexp in >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-beta.noindent
-nextsection.nonewline
-EOF
-
 test_expect_success '--name-only --get-regexp' '
+	cat >expect <<-\EOF &&
+	beta.noindent
+	nextsection.nonewline
+	EOF
 	git config --name-only --get-regexp in >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-wow2 for me
-wow4 for you
-EOF
-
 test_expect_success '--add' '
+	cat >expect <<-\EOF &&
+	wow2 for me
+	wow4 for you
+	EOF
 	git config --add nextsection.nonewline "wow4 for you" &&
-	git config --get-all nextsection.nonewline > output &&
+	git config --get-all nextsection.nonewline >output &&
 	test_cmp expect output
 '
 
-cat > .git/config << EOF
-[novalue]
-	variable
-[emptyvalue]
-	variable =
-EOF
+test_expect_success 'setup config file with no/empty values' '
+	q_to_tab >.git/config <<-\EOF
+	[novalue]
+		Qvariable
+	[emptyvalue]
+		Qvariable =
+	EOF
+'
 
 test_expect_success 'get variable with no value' '
 	git config --get novalue.variable ^$
@@ -395,38 +392,33 @@ test_expect_success 'get variable with empty value' '
 	git config --get emptyvalue.variable ^$
 '
 
-echo novalue.variable > expect
-
 test_expect_success 'get-regexp variable with no value' '
-	git config --get-regexp novalue > output &&
+	echo novalue.variable >expect &&
+	git config --get-regexp novalue >output &&
 	test_cmp expect output
 '
 
-echo 'novalue.variable true' > expect
-
 test_expect_success 'get-regexp --bool variable with no value' '
-	git config --bool --get-regexp novalue > output &&
+	echo "novalue.variable true" >expect &&
+	git config --bool --get-regexp novalue >output &&
 	test_cmp expect output
 '
 
-echo 'emptyvalue.variable ' > expect
-
 test_expect_success 'get-regexp variable with empty value' '
-	git config --get-regexp emptyvalue > output &&
+	echo "emptyvalue.variable " >expect &&
+	git config --get-regexp emptyvalue >output &&
 	test_cmp expect output
 '
 
-echo true > expect
-
 test_expect_success 'get bool variable with no value' '
-	git config --bool novalue.variable > output &&
+	echo true >expect &&
+	git config --bool novalue.variable >output &&
 	test_cmp expect output
 '
 
-echo false > expect
-
 test_expect_success 'get bool variable with empty value' '
-	git config --bool emptyvalue.variable > output &&
+	echo false >expect &&
+	git config --bool emptyvalue.variable >output &&
 	test_cmp expect output
 '
 
@@ -435,34 +427,34 @@ test_expect_success 'no arguments, but no crash' '
 	test_i18ngrep usage output
 '
 
-cat > .git/config << EOF
-[a.b]
-	c = d
-EOF
-
-cat > expect << EOF
-[a.b]
-	c = d
-[a]
-	x = y
-EOF
+test_expect_success 'setup simple config file' '
+	q_to_tab >.git/config <<-\EOF
+	[a.b]
+		Qc = d
+	EOF
+'
 
 test_expect_success 'new section is partial match of another' '
+	q_to_tab >expect <<-\EOF &&
+	[a.b]
+		Qc = d
+	[a]
+		Qx = y
+	EOF
 	git config a.x y &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
-[a.b]
-	c = d
-[a]
-	x = y
-	b = c
-[b]
-	x = y
-EOF
-
 test_expect_success 'new variable inserts into proper section' '
+	q_to_tab >expect <<-\EOF &&
+	[a.b]
+		Qc = d
+	[a]
+		Qx = y
+		Qb = c
+	[b]
+		Qx = y
+	EOF
 	git config b.x y &&
 	git config a.b c &&
 	test_cmp expect .git/config
-- 
2.24.0

