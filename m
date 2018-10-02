Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775951F453
	for <e@80x24.org>; Tue,  2 Oct 2018 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeJBWvV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 18:51:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33787 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbeJBWvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 18:51:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id o21-v6so1860467lfe.0
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koAjkyClp3a3xUVNx3VBIS7wGeEOiTgWPYK020g5Vvo=;
        b=dhtc4KBfHzX52Wylo3+oF1KNKVUY/lHTEZvX9UqVfHGJcjTp/UYwLDgZfrv3VTnOR1
         hMMpb4RThAkYkGxfZLXQRQVEbl+QhM/SabBSKTFxKKClvt5LbfZsvM/coUntZ5isK8w7
         xgCAXogWZCrm4O/pVhnFJpwd6N92AAbx+QM2rD/l3LB2Ep7+Amf6f0XHSLIqgv4UfwF3
         qLsxHiFfM2h0XJ6hhhGAXos1ZUEvsGcgryk+V04lF7lTLx105Wm+2q307MsXvksLjKVN
         aSAP4ZN1cuSq+NUwFRnf1SkCDJ8ZlW7LHIlk6vNeTRQCWQQWJvMH6adgIQyWiPGbYMWH
         aj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koAjkyClp3a3xUVNx3VBIS7wGeEOiTgWPYK020g5Vvo=;
        b=YeNmvABd1UW1G3V0WT36SfExCCI4GiabO0O06gUfBkhc43DraTh+TkDuYwvYrL8yzm
         5wwfYMzr+dQROgYGpBvWCA7i6NL30UgHcTmQTAKXpjLOK7LdKgNk3IsFSE9F/WxGdiw7
         6Pnj6Y0X3fhpTlmSB01fdw7X2gxtBv3x/cZU/NzULcB62nO9VyiHDoP7DxZ/nqeFp3lS
         KeCfU8BGfV1dbZJ5aZbQ8b+v4MRJbPbzWWfBmOqkkxc6DmEasCPpddo7ts7KJOG92PLA
         4zGlD4z5xXPSmWDGVcE5oe/t+XPqm4uKm/yJT3zINcZHJ02yV3CK0/RjULGTJtkOjqJL
         nGaQ==
X-Gm-Message-State: ABuFfohm3ef4ziFzr3hq44wax5Y0gjqUL1WHxtRuf87Xiiu6FPLxXXYG
        tFuji4E/U9It9xDkrRx/s0ZSTRnK
X-Google-Smtp-Source: ACcGV61EL9T5df/cT7WNUIvdEfiG7HA5ITBjSGyCzGZyxBO/Fe2ezf8WwDJy/qdFhiaPbUH1joBWVg==
X-Received: by 2002:a19:541d:: with SMTP id i29-v6mr9370497lfb.30.1538496431867;
        Tue, 02 Oct 2018 09:07:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1771194lji.87.2018.10.02.09.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:07:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/2] t1300: extract and use test_cmp_config()
Date:   Tue,  2 Oct 2018 18:06:57 +0200
Message-Id: <20181002160658.15891-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.342.gc057aaf40a.dirty
In-Reply-To: <20181002160658.15891-1-pclouds@gmail.com>
References: <20180929153005.10599-1-pclouds@gmail.com>
 <20181002160658.15891-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many config-related tests it's common to check if a config variable
has expected value and we want to print the differences when the test
fails. Doing it the normal way is three lines of shell code. Let's add
a function do to all this (and a little more).

This function has uses outside t1300 as well but I'm not going to
convert them all. And it will be used in the next commit where
per-worktree config feature is introduced.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t1300-config.sh       | 79 ++++++++++-------------------------------
 t/test-lib-functions.sh | 23 ++++++++++++
 2 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index cdf1fed5d1..00c2b0f0eb 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -76,15 +76,11 @@ EOF
 test_expect_success 'non-match result' 'test_cmp expect .git/config'
 
 test_expect_success 'find mixed-case key by canonical name' '
-	echo Second >expect &&
-	git config cores.whatever >actual &&
-	test_cmp expect actual
+	test_cmp_config Second cores.whatever
 '
 
 test_expect_success 'find mixed-case key by non-canonical name' '
-	echo Second >expect &&
-	git config CoReS.WhAtEvEr >actual &&
-	test_cmp expect actual
+	test_cmp_config Second CoReS.WhAtEvEr
 '
 
 test_expect_success 'subsections are not canonicalized by git-config' '
@@ -94,12 +90,8 @@ test_expect_success 'subsections are not canonicalized by git-config' '
 	[section "SubSection"]
 	key = two
 	EOF
-	echo one >expect &&
-	git config section.subsection.key >actual &&
-	test_cmp expect actual &&
-	echo two >expect &&
-	git config section.SubSection.key >actual &&
-	test_cmp expect actual
+	test_cmp_config one section.subsection.key &&
+	test_cmp_config two section.SubSection.key
 '
 
 cat > .git/config <<\EOF
@@ -212,9 +204,7 @@ test_expect_success 'really really mean test' '
 '
 
 test_expect_success 'get value' '
-	echo alpha >expect &&
-	git config beta.haha >actual &&
-	test_cmp expect actual
+	test_cmp_config alpha beta.haha
 '
 
 cat > expect << EOF
@@ -251,15 +241,11 @@ test_expect_success 'non-match' '
 '
 
 test_expect_success 'non-match value' '
-	echo wow >expect &&
-	git config --get nextsection.nonewline !for >actual &&
-	test_cmp expect actual
+	test_cmp_config wow --get nextsection.nonewline !for
 '
 
 test_expect_success 'multi-valued get returns final one' '
-	echo "wow2 for me" >expect &&
-	git config --get nextsection.nonewline >actual &&
-	test_cmp expect actual
+	test_cmp_config "wow2 for me" --get nextsection.nonewline
 '
 
 test_expect_success 'multi-valued get-all returns all' '
@@ -520,21 +506,11 @@ test_expect_success 'editing stdin is an error' '
 
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
-	(
-		cd x &&
-		echo strasse >expect &&
-		git config --get --file ../other-config ein.bahn >actual &&
-		test_cmp expect actual
-	)
-
+	test_cmp_config -C x strasse --get --file ../other-config ein.bahn
 '
 
 test_expect_success 'refer config from subdirectory via --file' '
-	(
-		cd x &&
-		git config --file=../other-config --get ein.bahn >actual &&
-		test_cmp expect actual
-	)
+	test_cmp_config -C x strasse --file=../other-config --get ein.bahn
 '
 
 cat > expect << EOF
@@ -688,16 +664,13 @@ test_expect_success numbers '
 
 test_expect_success '--int is at least 64 bits' '
 	git config giga.watts 121g &&
-	echo 129922760704 >expect &&
-	git config --int --get giga.watts >actual &&
-	test_cmp expect actual
+	echo  >expect &&
+	test_cmp_config 129922760704 --int --get giga.watts
 '
 
 test_expect_success 'invalid unit' '
 	git config aninvalid.unit "1auto" &&
-	echo 1auto >expect &&
-	git config aninvalid.unit >actual &&
-	test_cmp expect actual &&
+	test_cmp_config 1auto aninvalid.unit &&
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
@@ -1039,9 +1012,7 @@ test_expect_success '--null --get-regexp' '
 
 test_expect_success 'inner whitespace kept verbatim' '
 	git config section.val "foo 	  bar" &&
-	echo "foo 	  bar" >expect &&
-	git config section.val >actual &&
-	test_cmp expect actual
+	test_cmp_config "foo 	  bar" section.val
 '
 
 test_expect_success SYMLINKS 'symlinked configuration' '
@@ -1808,21 +1779,15 @@ big = 1M
 EOF
 
 test_expect_success 'identical modern --type specifiers are allowed' '
-	git config --type=int --type=int core.big >actual &&
-	echo 1048576 >expect &&
-	test_cmp expect actual
+	test_cmp_config 1048576 --type=int --type=int core.big
 '
 
 test_expect_success 'identical legacy --type specifiers are allowed' '
-	git config --int --int core.big >actual &&
-	echo 1048576 >expect &&
-	test_cmp expect actual
+	test_cmp_config 1048576 --int --int core.big
 '
 
 test_expect_success 'identical mixed --type specifiers are allowed' '
-	git config --int --type=int core.big >actual &&
-	echo 1048576 >expect &&
-	test_cmp expect actual
+	test_cmp_config 1048576 --int --type=int core.big
 '
 
 test_expect_success 'non-identical modern --type specifiers are not allowed' '
@@ -1841,21 +1806,15 @@ test_expect_success 'non-identical mixed --type specifiers are not allowed' '
 '
 
 test_expect_success '--type allows valid type specifiers' '
-	echo "true" >expect &&
-	git config --type=bool core.foo >actual &&
-	test_cmp expect actual
+	test_cmp_config true  --type=bool core.foo
 '
 
 test_expect_success '--no-type unsets type specifiers' '
-	echo "10" >expect &&
-	git config --type=bool --no-type core.number >actual &&
-	test_cmp expect actual
+	test_cmp_config 10 --type=bool --no-type core.number
 '
 
 test_expect_success 'unset type specifiers may be reset to conflicting ones' '
-	echo 1048576 >expect &&
-	git config --type=bool --no-type --type=int core.big >actual &&
-	test_cmp expect actual
+	test_cmp_config 1048576 --type=bool --no-type --type=int core.big
 '
 
 test_expect_success '--type rejects unknown specifiers' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d82fac9d79..2149b88392 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -747,6 +747,29 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# Check that the given config key has the expected value.
+#
+#    test_cmp_config [-C <dir>] <expected-value>
+#                    [<git-config-options>...] <config-key>
+#
+# for example to check that the value of core.bar is foo
+#
+#    test_cmp_config foo core.bar
+#
+test_cmp_config() {
+	local GD
+	if test "$1" = "-C"
+	then
+		shift &&
+		GD="-C $1" &&
+		shift
+	fi &&
+	printf "%s\n" "$1" >expect.config &&
+	shift &&
+	git $GD config "$@" >actual.config &&
+	test_cmp expect.config actual.config
+}
+
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin() {
-- 
2.19.0.342.gc057aaf40a.dirty

