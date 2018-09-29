Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C57A1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeI2V7R (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:59:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36694 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeI2V7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:59:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id p89-v6so8471440ljb.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoRYjSjtgnZ04ZxHYp7vh49DtDy6UCrEnvNi/iv5ewY=;
        b=fs+S5XELB6vnn1JwHvPaSoPt98/x0UDEf99VXEkQC+cKmYDdhRsbCZM/3BZV02WGFD
         KD5UKUVyfqS1hRMV4bVU8+2+UdkbjRQO+PB/SS7DGRnFxTfW8EEs/08kebk2Qeq7K6RD
         Uk5PeH9v1jlofkF/yMnASKwMfKWgztosw5ayuiKL4IR3V6SZkzCk3iIgSyXeB6qKJFjp
         Lpck766sn13b4nrIaNIAxXfSWZB860HsPgwbv2eOJeJZmYxnP6JWoDv9eTjPv1i3u8oE
         t0R9F2BIdit7/9Xq4Ox1o9zYkuEm16ciRdQQLrUi++3JiP73H8jdZntlh9+yQLAe6mQ+
         Cxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoRYjSjtgnZ04ZxHYp7vh49DtDy6UCrEnvNi/iv5ewY=;
        b=P8KMOaCUI85PgdOUAd3pGK1Xx+agXYKbv7Moc7fQaJ9R1pKfZJ8knl1JQiuWNfkkMw
         S5ohx34LUgDaR59i2hzCD1QqAGj8U5o9tFBR92pHtckG8wKpuywaMUWCEBo0t8hUcYgo
         0i+EkOzp1Y7YJAaryWbA806LN8U2txZYFRtwNPOjkePRlXnD7v7Mv4Epw3peBUzUVODW
         jAGqs34TvH09uvtISHd3P2T+GNg3XWUC33Lo8GaIhqlaTsvxtGVi1cb2ychIBsvDos64
         kBtXV3pGJBC0KA7ds9LK4eDhYd9P9ipNWHQWxZfBowng+fFDSL5VMn0LNgnaFGX/QyBR
         yy/Q==
X-Gm-Message-State: ABuFfohArROD0ZRYiAPDzGneX/VX0fKwjUJAt9BYFLvHVR1wrhSyKqUZ
        tP5Yn30qKMWlNC5on2xE3iM=
X-Google-Smtp-Source: ACcGV63KjLo1Zl4tvuLiR84/vssr+cVYfbFpn8axgQPO7cAkqRjurOvCUjsUzArLMS1qQsW+RAtwFw==
X-Received: by 2002:a2e:3211:: with SMTP id y17-v6mr1752965ljy.39.1538235024424;
        Sat, 29 Sep 2018 08:30:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1600899lfj.39.2018.09.29.08.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:30:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 1/2] t1300: extract and use test_cmp_config()
Date:   Sat, 29 Sep 2018 17:30:04 +0200
Message-Id: <20180929153005.10599-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929153005.10599-1-pclouds@gmail.com>
References: <20180923170438.23610-1-pclouds@gmail.com>
 <20180929153005.10599-1-pclouds@gmail.com>
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
 t/test-lib-functions.sh | 24 +++++++++++++
 2 files changed, 43 insertions(+), 60 deletions(-)

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
index d82fac9d79..4cd7fb8fdf 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -747,6 +747,30 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# similar to test_cmp but $2 is a config key instead of actual value
+# it can also accept -C to read from a different repo, e.g.
+#
+#     test_cmp_config -C xyz foo core.bar
+#
+# is sort of equivalent of
+#
+#     test "foo" = "$(git -C xyz core.bar)"
+
+test_cmp_config() {
+	if [ "$1" = "-C" ]
+	then
+		shift &&
+		GD="-C $1" &&
+		shift
+	else
+		GD=
+	fi &&
+	echo "$1" >expected &&
+	shift &&
+	git $GD config "$@" >actual &&
+	test_cmp expected actual
+}
+
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin() {
-- 
2.19.0.341.g3acb95d729

