Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9E91F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeKJPal (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:30:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40045 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbeKJPak (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so2829211lfe.7
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4qltdDkEvB6bUWJNdeMhKeANsnQkkMsjtlj3DafGDBo=;
        b=V1AvvmLC69Z6ENplLgrp8wnxekiQwzJVpLN5R9rGqgYgXjnMox+TYZjAQ1YFWroLal
         tjWDJ8ThwAKEOB/IqZDRvJzvPLQ+fgQfcVNzBxqffIi9pkZaWRY9/ummtpkhQRSiALFy
         dk060E84UVTGyyTcorhyX4VSZj+6OCqdUA1rr/tCV1wqXHknrBT8MDU4LzkZb9lwB3gy
         NjFYnYy/72NjzugFDTD32hRA8E/cog/7uG07rMvd2USSuLbDuOrG6VQT4m331JfZ5XzI
         SOagcZXHu6PI+A/7EUARGTvWF/zfotS4f25tXuwmxiLXpQGF3N0E0tz01DSwmhvVrgeP
         hzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qltdDkEvB6bUWJNdeMhKeANsnQkkMsjtlj3DafGDBo=;
        b=ZnqJj0tGzxE1Jjp1HcL6d1wd2TlUG29Q/IoJo8Jfie98EeI+bXpTyUhGfHfiIpeM29
         ggE7tjHT9XYSzKAX8VDUc9nwjQoq9GaZYdrEHWxsqli6QmhkJom0/Sxru2bDS2KzUlBB
         MY6JZxK/L7ATqCLpDZz4qnOJVonsp7kCSKo5SNi6ZD3Ftv3ZueoBHKN5/3vwdINk6Xvc
         i3h5UilHU4uDKyeC89qnp38TnHNUzc3eO5wNhjNNHb6Kvnoo6hfP1xXxAUJ5l+OyiEMo
         eOstvUxUirpMSyu7x190J7n4sxwRNxic18/PeCm4DeIEtwUcWPbFd+5MTkrJUv8VvQ9Y
         G9uA==
X-Gm-Message-State: AGRZ1gI3MTHyOepp3+Bam3buo0Ur29Dep2VjNkckqJrUlpml6G16tl0O
        b4oumYfoemdk8sJ7/N8IOgHkUPzh
X-Google-Smtp-Source: AJdET5fFxoQ/j0SYp7OMUoI1swV6FqAsh0GHZgS5lyUqkBhLh8ur0Nv2dC6+6skGydkG9HhsLXZrTg==
X-Received: by 2002:a19:5402:: with SMTP id i2mr6728700lfb.128.1541828813339;
        Fri, 09 Nov 2018 21:46:53 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2441597ljg.9.2018.11.09.21.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:46:52 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif.lindholm@linaro.org>
Subject: [PATCH v2] format-patch: respect --stat in cover letter's diffstat
Date:   Sat, 10 Nov 2018 06:46:24 +0100
Message-Id: <20181110054646.10149-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054646.10149-1-pclouds@gmail.com>
References: <20181110054646.10149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 43662b23ab (format-patch: keep cover-letter diffstat wrapped in
72 columns - 2018-01-24) uncondtionally sets stat width to 72 when
generating diffstat for the cover letter, ignoring --stat from command
line. But it should only do so when stat width is still default
(i.e. stat_width == 0).

In order to fix this, we should only set stat_width if stat_width is
zero. But it will never be. Commit 071dd0ba43 (format-patch: reduce
patch diffstat width to 72 - 2018-02-01) makes sure that default stat
width will be 72 (ignoring $COLUMNS, but could still be overriden by
--stat). So all we need to do here is drop the assignment.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Helped-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c          |  2 --
 t/t4052-stat-output.sh | 48 +++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..1a39c6e52a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1009,8 +1009,6 @@ static void show_diffstat(struct rev_info *rev,
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
-	opts.stat_width = MAIL_DEFAULT_WRAP;
-
 	diff_setup_done(&opts);
 
 	diff_tree_oid(get_commit_tree_oid(origin),
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 6e2cf933f7..28c053849a 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -44,42 +44,50 @@ show --stat
 log -1 --stat
 EOF
 
-while read cmd args
+cat >expect.60 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect.6030 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect2.60 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+cat >expect2.6030 <<-'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
+EOF
+while read expect cmd args
 do
-	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
-	EOF
 	test_expect_success "$cmd --stat=width: a long name is given more room when the bar is short" '
 		git $cmd $args --stat=40 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.60 actual
 	'
 
 	test_expect_success "$cmd --stat-width=width with long name" '
 		git $cmd $args --stat-width=40 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.60 actual
 	'
 
-	cat >expect <<-'EOF'
-	 ...aaaaaaaaaaaaaaaaaaaaaaaaaaa | 1 +
-	EOF
 	test_expect_success "$cmd --stat=...,name-width with long name" '
 		git $cmd $args --stat=60,30 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.6030 actual
 	'
 
 	test_expect_success "$cmd --stat-name-width with long name" '
 		git $cmd $args --stat-name-width=30 >output &&
 		grep " | " output >actual &&
-		test_cmp expect actual
+		test_cmp $expect.6030 actual
 	'
 done <<\EOF
-format-patch -1 --stdout
-diff HEAD^ HEAD --stat
-show --stat
-log -1 --stat
+expect2 format-patch --cover-letter -1 --stdout
+expect diff HEAD^ HEAD --stat
+expect show --stat
+expect log -1 --stat
 EOF
 
 
@@ -95,6 +103,16 @@ test_expect_success 'preparation for big change tests' '
 	git commit -m message abcd
 '
 
+cat >expect72 <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
+test_expect_success "format-patch --cover-letter ignores COLUMNS (big change)" '
+	COLUMNS=200 git format-patch -1 --stdout --cover-letter >output &&
+	grep " | " output >actual &&
+	test_cmp expect72 actual
+'
+
 cat >expect72 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
2.19.1.1005.gac84295441

