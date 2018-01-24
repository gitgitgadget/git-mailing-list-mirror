Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E5C1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeAXJyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:36 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45929 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeAXJyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:33 -0500
Received: by mail-pf0-f195.google.com with SMTP id a88so2627414pfe.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKNb75AlYMBCSiaFUnogN/8YQ88M+TTBrAvCqIFNOJs=;
        b=Y7NhSuptmlOmhLIorwwFgHaQXgqyq7jZJqfsyIghVz0SfF912sERef3ummOLicoaPW
         FXabhO6jM/VfJzjM9IVbt8aRyTp5rXKOeSqWJn5GOgNtEti+Tt/h4yNCe8S7EoO6A4g0
         oIOhcIeSfOJkOtCWQPMIyddx4bc/23+qZuA/Fc31wooUnNFjP6M/LxXp0uwLY/HB7oqN
         F8ogSQ02SZqc9mwJ26bFo8APO+FOJ4qnRRmDtRGlqHoodqfIuvOcHHAjU4VwonHSXpUF
         vpIfWNB4ioo2C50RQmP1jQexjt89RsxaHbHPla+/KW54J470E75UZ/w2i0iEZDnjb6MI
         gc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKNb75AlYMBCSiaFUnogN/8YQ88M+TTBrAvCqIFNOJs=;
        b=UthKBcMkc65CXotR8Mgnat2xjC34lX3QALZbkS3nO/re1YkpOERCDdnitIAUcgUzoE
         vUmx607QQFXnqksmTmexkqU6XKH64MSI8cGTJejZxZrPtuEtKtldeHj5UdLG83/Ju1Vf
         U/uDbEhUXhH2KWxrQVu1K9xXODiWUyNlNs0Wthv8KNfwLlVIogE41tkGThPPoimxgTSY
         9h4b4IkNnSxxLm4D8oxx6c2tC6ov0DP350txi/CSeqE18o1illNq+6dZ/F3ElHIEZHk8
         DRz+uBUtoV/FW1FPS3VRwPDc4BUMv7nzYYyVKqm+Lcb3eqR2fh6k4dei2s5WUJ6ueSM9
         0rfw==
X-Gm-Message-State: AKwxytfbZMcNBPrhPa6wSSf/e3lDwgIZl1rIxAD4rrpkkEkXl5vLcLc4
        eGRqu3wGlX8nMLQzkUaimWskGw==
X-Google-Smtp-Source: AH8x224ad3cXb7qUuUzBEKyVrzdU9wsGcZ5M7U4MZvMkhtntc0m3EPlkNl/xN3yvPm+QfLhMGd+dSg==
X-Received: by 10.99.97.202 with SMTP id v193mr10071618pgb.84.1516787672238;
        Wed, 24 Jan 2018 01:54:32 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id w27sm36130755pge.54.2018.01.24.01.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/7] worktree move: accept destination as directory
Date:   Wed, 24 Jan 2018 16:53:54 +0700
Message-Id: <20180124095357.19645-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2faa95430a..89398e67e4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -624,8 +624,6 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	path = prefix_filename(prefix, av[1]);
 	strbuf_addstr(&dst, path);
 	free(path);
-	if (file_exists(dst.buf))
-		die(_("target '%s' already exists"), av[1]);
 
 	worktrees = get_worktrees(0);
 	wt = find_worktree(worktrees, prefix, av[0]);
@@ -633,6 +631,20 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
+
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	} else if (file_exists(dst.buf)) {
+		die(_("target '%s' already exists"), av[1]);
+	}
+
 	reason = is_worktree_locked(wt);
 	if (reason) {
 		if (*reason)
-- 
2.16.0.47.g3d9b0fac3a

