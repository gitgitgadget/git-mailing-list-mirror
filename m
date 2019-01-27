Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DF91F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfA0AgT (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37232 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AgS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so5686758pgb.4
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4YmLLjRKHCuoqTwvZt5Yp7fPKAB27+ZtPsKARqO0vs=;
        b=paVID5k+N20blHX3+zVAQC44gxMCMA0WouySM7Vb/Wy5EjpCcxltcAc8Thkno7hu8w
         YRGodaJaJ6tb9O2kvC7vJTn+J/Y1Kr6nh+9ZjlgB8yGIjKROt3kW5UIaL9hAJOVYzIBq
         pb2ZPrC1wfNq89LT4oN1QurZYEAnhznfVwH+DFNXeAFClSESJikNqAiFe/TJzX+xArmX
         s9JmQ9C9AbQuKrJk9Ibzhp9Ih2iscizAU1RG6VFa+i+8xyZGcGEqfBFGL9VHAplD3P4t
         QrRtxbPYf5JSbxXZQYj+iisEVMZeehYCWPKGLX31TFU1JOweedYJmF6vmgvCho9YkscG
         68Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4YmLLjRKHCuoqTwvZt5Yp7fPKAB27+ZtPsKARqO0vs=;
        b=aNrS9rhNZdNneZvWBpgtzGkn7PquP6I3dCXRoXoRH1feVMZAt9eMwafCN/v5aorN64
         p2OxWTAt0BD2/NeFexcjah30fuL4aLc6zsoib5hgGnUDpTwTbLRDHduSH42pPcllxLjX
         fvdfT+0NXINk9xr5Bz/mWN0DM3SKtXA3d9JB0HWJZ5JGQE3ZGV6ATmFg7EhHQzw7GsKp
         1v2CH+ohCR20+gPkN11/hPsq27P5THBB0BSvtDGrYGzGapId2b5A/hB13Mj0+CnZEu6t
         j3+UON0e/oromNsG6UeIIMVEsBAZpJMe84zCdJmWaQfz8Ai609XMDkf44/BYBZpOFvKA
         smQQ==
X-Gm-Message-State: AJcUukebECHm9lXZCwZSHzrMWRPY1tutb+zeNSme9k0Vl6LlsPoSOkgt
        Zg7f2g0PCIeyof77EUzSsDwwvaoA
X-Google-Smtp-Source: ALg8bN5QOyiyB81xWTXrC5dq1apqdCdUWT/Nxf9fRpaUXyTNwMq9Q1mphJ6sW50BZCGuEliL/2LRew==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr16318846pfm.63.1548549377790;
        Sat, 26 Jan 2019 16:36:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l11sm36963728pff.65.2019.01.26.16.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/14] parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
Date:   Sun, 27 Jan 2019 07:35:24 +0700
Message-Id: <20190127003535.28341-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options can unambiguously find an abbreviation only if it sees
all available options. This is usually the case when you use
parse_options(). But there are other callers like blame or shortlog
which uses parse_options_start() in combination with a custom option
parser, like rev-list. parse-options cannot see all options in this
case and will get abbrev detection wrong. Disable it.

t7800 needs update because --symlink no longer expands to --symlinks
and will be passed down to git-diff, which will not recognize it. I
still think this is the correct thing to do. But if --symlink has been
actually used in the wild, we would just add an option alias for it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c     | 3 ++-
 t/t7800-difftool.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 740ae5438f..779034e1fd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -266,7 +266,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 		}
 		if (!rest) {
 			/* abbreviated? */
-			if (!strncmp(long_name, arg, arg_end - arg)) {
+			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
+			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option) {
 					/*
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 22b9199d59..bb9a7f4ff9 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -546,7 +546,7 @@ do
 done >actual
 EOF
 
-test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged changes' '
 	cat >expect <<-EOF &&
 	file
 	$PWD/file
@@ -555,7 +555,7 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlink without unstaged cha
 	sub/sub
 	$PWD/sub/sub
 	EOF
-	git difftool --dir-diff --symlink \
+	git difftool --dir-diff --symlinks \
 		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
 	test_cmp expect actual
 '
-- 
2.20.1.560.g70ca8b83ee

