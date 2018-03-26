Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042D81F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCZQ4J (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:56:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45135 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeCZQ4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:56:08 -0400
Received: by mail-lf0-f67.google.com with SMTP id q5-v6so3944270lff.12
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Urv6IkRe2p7jCs5oxVHqwsURvYQy/PwBrHRTEzpa/3E=;
        b=lyl+SJbUiKaTZvFl32HvSwrT8hHQUWthwA1jdppctAWpobZDn1OxrquGuIpPK7os36
         syI26G1j3w6N6aMLgKRq6KzmsgQ2ecw1EhJ6NKgWl6r/LokemJ4scAEIr17Ehsh0EHQ7
         YE8PFLI5RfwEvc+iwRzm5TOkRO3Bar754Cs9jj2c6vpk09atbfS54m+DFwee+c/tFXCM
         SvCG3Wv4mk5igIcazzgSAS0UN5Fdb8orFfKzktjcPbgWjNpaJTkmhR9XFZ6irRaxuUJl
         6GeNCBxd1JphbixHq2qhVWKuo5yW2mn1poVnTLPVE3CgUZg+9HDZ3510Vn0gsXuSJnZI
         SkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Urv6IkRe2p7jCs5oxVHqwsURvYQy/PwBrHRTEzpa/3E=;
        b=PWmU29n3O6RYFhjj8V46utxL7jQiWOlclo1DLIMt7K2QoRlxdzULss+S0xom20mX8H
         v9XAk0z/5+m7Zch4Kr+YLFjnn4fiz6uSLDjc34NOL1a9IFMnVeit5QbSl/DVFg4rV8fy
         yxDvGzm18/QxAXDzh0JHYg2bVGqHnW84pMsecK2oTqhrni4U1iiJsmuWJ5jGKzsv3k0M
         LY/6rLGyGJC/a68gOI8mGmkSuU4EJ8ypdbVDlb+FFk/43hyZhCjJNq9mdTcQdqI8MAmV
         3ulCT9XxuWmJkQC89ou+soDM7DEvuwedLBk0XKRn5ABUGR6oLQAn/hyubY8/7vbmc14h
         Gyxg==
X-Gm-Message-State: AElRT7Fl9j3IOqGOX7oisgZJFiFWIQ3RECFixYSfW7Sas9HU7awLb0FI
        VpVKgRbBPcQ4IuLBIK+pPA64HQ==
X-Google-Smtp-Source: AIpwx4/t4QxlSGoWe70sWxZKh0Fcp+pnzI2Gn1Vcbh9LPW7uTvFsqFQX8xq+xQSh+ABzle0Bskz/qg==
X-Received: by 2002:a19:5745:: with SMTP id l66-v6mr14179875lfb.135.1522083366283;
        Mon, 26 Mar 2018 09:56:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j8sm814451lje.83.2018.03.26.09.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 09:56:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 1/5] git.c: convert --list-builtins to --list-cmds=builtins
Date:   Mon, 26 Mar 2018 18:55:16 +0200
Message-Id: <20180326165520.802-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if this is a hidden option, let's make it a bit more generic
since we're introducing more listing types.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c           | 7 +++++--
 t/t0012-help.sh | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index ceaa58ef40..f350002260 100644
--- a/git.c
+++ b/git.c
@@ -205,8 +205,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
-		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins();
+		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			if (!strcmp(cmd, "builtins"))
+				list_builtins();
+			else
+				die("unsupported command listing type '%s'", cmd);
 			exit(0);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 487b92a5de..fd2a7f27dc 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -50,7 +50,7 @@ test_expect_success "--help does not work for guides" "
 "
 
 test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
+	git --list-cmds=builtins >builtins
 '
 
 while read builtin
-- 
2.17.0.rc0.348.gd5a49e0b6f

