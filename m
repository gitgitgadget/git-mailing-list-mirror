Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44E81F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBILE2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39100 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:26 -0500
Received: by mail-pg0-f68.google.com with SMTP id w17so3395777pgv.6
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CYF/I00ENUS2EYFzZDeCl6WqItBwqopTNpHlqoq7Ys=;
        b=LjHpZ+b8EroWwDgU1er+vodqTs31tTsK0RAUTIBcOdDuguh7LLS4D9oUkUQZ/wdxeQ
         MBchy/ueMOPwJn0A5HAiJg+xjeNkJls12RndC1DM+S5p+JfbJAfECq9rU8FK3nGvCAMT
         Y3B8Mlp8dLoajoxoVV7GZ0OV2Q+QkkN5gXr6v9ZA/RKhetEselrFnUhk2Mob75GhWG+J
         HBQpsIHGx9fIYLvuPB0n825TElv5RAd2BlaXZQm3sROfWaTp5p+erUF2f+F0wI/IBVye
         xO9qDE9eSSaKkxqz3YpNWCn/o8oQxBUCO2cpstsasonOQa/S9jfkH1BT18fJSm9KyHrn
         07xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CYF/I00ENUS2EYFzZDeCl6WqItBwqopTNpHlqoq7Ys=;
        b=cM177jUxWIbI4V1VCj0X0DlIetjgjc+kWqLmq9SaTenaAC8dFwtq8WCoNj0QDq+ne3
         PG48035dg6yj29sWC18pvcX1HQp0z8CCGzFdKs9tCekxmV5ahh4VGcPMKVP3mlGUDamL
         EviYgZE8HIKDV1ciRRxEjsxy4Xj08ihfY/6+a/29yg5pHBFcEXG2+6nsV8PA0ERnbUmm
         6/YYPbnSQuGBCPF8tWSj2RYVez7po8Ai39oq/2qvSmzE16MMNk6DxgRqTYuBEGZcL8Vf
         8JxTuFi6cencKeZEKGxOOMmC+qEQaYDCi/lG/nBxiHiNgG5ccENnvAvflZNsN5ze2Qdx
         /K8Q==
X-Gm-Message-State: APf1xPBBzYaInHde2Cnyf7xt4Tkx6Il5a037HdpIOmu7q81Wpal4PgIQ
        HnG7HN3OlHk+HWutLaJ2574IMg==
X-Google-Smtp-Source: AH8x22538BoMqJhVP446Gr/1cZL/yOlQh4VMrhMuIT66TJjnG5UDXi3eoJrLhWBRomIN6NKAvB7x5g==
X-Received: by 10.99.47.132 with SMTP id v126mr2072703pgv.129.1518174266355;
        Fri, 09 Feb 2018 03:04:26 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w9sm5069342pfl.74.2018.02.09.03.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 20/42] completion: use __gitcomp_builtin in _git_grep
Date:   Fri,  9 Feb 2018 18:01:59 +0700
Message-Id: <20180209110221.27224-21-pclouds@gmail.com>
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

The new completable options are:

--after-context=
--before-context=
--color
--context
--exclude-standard
--quiet
--recurse-submodules
--textconv

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c                         | 13 ++++++++-----
 contrib/completion/git-completion.bash | 16 +---------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..496f33336e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -832,8 +832,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('L', "files-without-match",
 			&opt.unmatch_name_only,
 			N_("show only the names of files without match")),
-		OPT_BOOL('z', "null", &opt.null_following_name,
-			N_("print NUL after filenames")),
+		OPT_BOOL_F('z', "null", &opt.null_following_name,
+			   N_("print NUL after filenames"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('c', "count", &opt.count,
 			N_("show the number of matches instead of matching lines")),
 		OPT__COLOR(&opt.color, N_("highlight matches")),
@@ -884,9 +885,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
-		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
-			 N_("allow calling of grep(1) (ignored by this build)")),
+			PARSE_OPT_OPTARG | PARSE_OPT_NOCOMPLETE,
+			NULL, (intptr_t)default_pager },
+		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
+			   N_("allow calling of grep(1) (ignored by this build)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 79e9f69d52..60d27253ee 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1565,21 +1565,7 @@ _git_grep ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--cached
-			--text --ignore-case --word-regexp --invert-match
-			--full-name --line-number
-			--extended-regexp --basic-regexp --fixed-strings
-			--perl-regexp
-			--threads
-			--files-with-matches --name-only
-			--files-without-match
-			--max-depth
-			--count
-			--and --or --not --all-match
-			--break --heading --show-function --function-context
-			--untracked --no-index
-			"
+		__gitcomp_builtin grep
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

