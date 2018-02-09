Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B5B1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeBILDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43388 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBILDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:34 -0500
Received: by mail-pl0-f66.google.com with SMTP id f4so1309604plr.10
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okrXxvoUOkQKL9dWaVbJzsRfsp/mWD0qeMTfdENa6Wg=;
        b=vBUKspYLmJ1RGRYanajl6s1a+MCNXdhqb7lDBwnsRiCuQmXk12S5EDfeAqPFpJGx/i
         ZxF5mS/JfK2KwTF+ZqWI3hzXTMMt3W5zQNTfqIZGWJl5RLL4F3ePqNW6M8H6FN39Bh0S
         W/ZQvzuWw4TWMzD3byLSeZrKaHNXm1WLqni0COmOqMw6/MwE0+xNvkg1lC3d87148cOR
         OpWqdAqrYFn3mUoegQwdzz9BocbZcZHbf6+8lZ138yJ719phoM8QjTKqT15Gvj2noHUd
         ZcH4meVu78H0FxSQgtxC3D6/qXYGu/kv6dP6swtkbCFgKo9TFq7GC7ptmsUL8id1+5wg
         1Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okrXxvoUOkQKL9dWaVbJzsRfsp/mWD0qeMTfdENa6Wg=;
        b=Xaa6Y1hUEzykN5yHySJnDp4whpCAqb+1anDzZqjGNjVaBBL20cyUY0nycIT+7rMIMn
         EjG37Luv/0zh/71V54Ws31XqopA9OKfpsL3Uzf1uMx7D6ZBqzvx3th+S2ijcg+G1BS8Y
         /s/mY2O5T7BTzJKdl1m4zPuHcTHAYlGo7/VWO8fYUlzq1X1fFbMycWM6YfYDti1iacgJ
         Mmqv99792w4c9/WnNoxu4Plyq5O0yQ3NMZzBxvE+O9mhTZ4mkB3Ju+m3Q3wvXnKEtrtb
         /lpzAVbVBElNa/9W4IZeOne9oL2FCjcm1SXViQg+hBe4CrB6R5IbQ8czIXu0YscV8TH+
         GYow==
X-Gm-Message-State: APf1xPAsZPR7MCnWaQe67mDmLzRwm9cPlvx2jt249vRAN29X0KSEmk73
        fr9SuAq25q/Tq2syjfRVMDA0JA==
X-Google-Smtp-Source: AH8x225D5941dBVpTuuX6WyS+nLJ6QRbpqSWMPjDqp/xDxgFGtiVoRuLfzwdwvoak+u6Q/p4IHcIPA==
X-Received: by 2002:a17:902:57d8:: with SMTP id g24-v6mr2174948plj.27.1518174214390;
        Fri, 09 Feb 2018 03:03:34 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d62sm63449pfj.66.2018.02.09.03.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 11/42] completion: use __gitcomp_builtin in _git_clean
Date:   Fri,  9 Feb 2018 18:01:50 +0700
Message-Id: <20180209110221.27224-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are --exclude and --interactive

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clean.c                        | 2 +-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3c4ca9a2ff..fad533a0a7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -909,7 +909,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
-		OPT__FORCE(&force, N_("force"), 0),
+		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 068def9f6b..b7de381876 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1307,7 +1307,7 @@ _git_clean ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run --quiet"
+		__gitcomp_builtin clean
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

