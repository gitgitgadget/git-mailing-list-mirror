Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912BF1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeKGVw0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 16:52:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKGVw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 16:52:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so17175128wru.9
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxZCofZKcUxR5x+45ZTa76e3y9VQBs8iz0mddweAEl4=;
        b=XLhEWXHTJDuGxA0KcWHIOY5fUkgZe5u6RCd4JuNorXudSMpzi2En88C26gT0rToJzb
         t+mOjmR1kTtWUlJsOQfujShDkBr1jMjvpk/ir1htlG4CfA9vuDB45DNCrDMcs3tPtuB8
         zZ2OldS1ErWQfv7qD0zeAZk3XpkJH9QlgPCFs4OEhZQZIHRNqwKB1NkdqOGqcRjFQ0An
         genmsDqJOfI8m9/rgmYFtgUQmq9jEoKrJ6xjJ6/AJx703VXcljIVUOr1ANzI1aWaR42W
         Trf383EfmE929MZXrGp5MpCAdZZIwtlSFF1T6xObPV/H2FbkzsoXIAwzFKShOVTu+8ri
         lg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxZCofZKcUxR5x+45ZTa76e3y9VQBs8iz0mddweAEl4=;
        b=TgCfpUyBkD7ldYqXkNQlI9rVuG1HyfLB9XFNXb5G5lujUbi3juSZ5w/7BQiLizOokX
         h9vlPiW71hA7uEPl38bh3P2GDjaddoZQ0ZVqimVPvQwkQ6bKkFNqBTdj8Db/Qd53oqRC
         Kw2egijrrpmit2irVn1o/H2weTrKyiX/xgqZTKAbAmX1xmhejBrTAZu7Vc/A+UP7gsJd
         kxkT4CD8ysDK20ZBHQfHr/UHIj5kgJ+oFLhvAoOZ3EGPD/QEvKqCOMcv7VbUImDo5V7d
         +uC2ygQvli+aNcZ6YtFemtNWkfBGFPHhA67PVAQCROZu+zIF105PDiCwCz8v/kctVmyq
         JPNw==
X-Gm-Message-State: AGRZ1gLuYGC4wbJ9LinKtf0IeeLsFmEgZfuTJkS871hAs7qBJmTgGRY6
        W8mnhN2mIPKnuMHN8zoX2bt4ZzPguZE=
X-Google-Smtp-Source: AJdET5eD2UWzQfgxmbm8SCnszG9wADtAX7P56DXWthXQCNCjGXMfcfIVPwNKzjPtLhRL5D4DA+ogpw==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7-v6mr16086wrw.48.1541593335113;
        Wed, 07 Nov 2018 04:22:15 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y21-v6sm550936wma.36.2018.11.07.04.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:22:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] range-diff: fix regression in passing along diff options
Date:   Wed,  7 Nov 2018 12:22:02 +0000
Message-Id: <20181107122202.1813-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 73a834e9e2 ("range-diff: relieve callers of low-level configuration
burden", 2018-07-22) we broke passing down options like --no-patch,
--stat etc. Fix that regression, and add a test for some of these
options being passed down.

As noted in a change leading up to this ("range-diff doc: add a
section about output stability", 2018-11-07) the output is not meant
to be stable. So this regression test will likely need to be tweaked
once we get a "proper" --stat option.

See
https://public-inbox.org/git/nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet/
for a further explanation of the regression.

The quoting of "EOF" here mirrors that of an earlier test. Perhaps
that should be fixed, but let's leave that up to a later cleanup
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c          |  3 ++-
 t/t3206-range-diff.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index bd8083f2d1..488844c0af 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format = DIFF_FORMAT_PATCH;
+		if (!opts.output_format)
+			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6aae364171..e497c1358f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -122,6 +122,36 @@ test_expect_success 'changed commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit with --no-patch diff option' '
+	git range-diff --no-color --no-patch topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'changed commit with --stat diff option' '
+	git range-diff --no-color --stat topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	3:  147e64e ! 3:  0559556 s/11/B/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expected <<-EOF &&
-- 
2.19.1.930.g4563a0d9d0

