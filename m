Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA5F1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeBILFk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34209 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeBILFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so3402404pgc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6HHcDSyyHz0fzIAUqM3bFI+P/XrXh6m4kkRJM1ctfgo=;
        b=HQlZBZEIJn1dI07hx1D8Uk2+QhkTMkxZNfe5r2PBASfgi7ydGg4LsQMOSqQ1yBjwg8
         N0eo8n4eFgRSkDgJirGcO+1kDoOTcdBz/nxkULa7DBVIx4r+IRh/Xxw9P3jQKX6Oheri
         FdIqgyJXYazRkHrtIjXi3uclL0LPc3w8PJiLlQhHBU8fW0KinydqJcZqyGAbnGSdXYz/
         Wkx31L/PP06He/2wVCZAK7eLIFVThIIBFJe7oyWkd31GQp2vPvWXITLgTNyI1A0QKMwj
         AOm5y2o3AHlz1od14aUZRq5+iLO/849yIqblZo38Bq0lhtZVMcu/lCzuE/yXJp1wPxbP
         BtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HHcDSyyHz0fzIAUqM3bFI+P/XrXh6m4kkRJM1ctfgo=;
        b=bKVszr5uWOtk5dhgFmFuvjp0a6+RgHJ5Ivb3uAKXhlcEM6nW4rD84ykPMU+ashKRQb
         iS1wthwVw+O8I1CXlV8LKsikTMCgXIH5CYAK52EayIqdxalo07SIzydyhfk5MgSYCJxW
         lM2KbRvcotr1hmTAnpQMfLjdArlF4uC2UVZ+aJaHc+/5OITs37gzGO1nlwiqkAH/aTjF
         Dc+qXCssT5FT/AWCmau6HKCFyQJ9E3uOrRwIVk6uhVR5VmVrpaxJZci2hL+H9hVjT5pR
         CMUSf6cCcvYHYHUely5pgneRJgaPldVPpIxIiuJyPGTf838b1+m2ajqYXOcVWTpzyua0
         vBVA==
X-Gm-Message-State: APf1xPAHA/7k0oJnpL47TxB9gjJ3GL+prBry79Jae9wIKLm+OBp6Ii/T
        hBLWJKW0d6PlkJ7JF2FAxAdoZw==
X-Google-Smtp-Source: AH8x225GP8O+jwOut93S+nnwRsKQ5vlzKgM0bS8g4u1IwgtkePRxMU7wbzpMIZQFlosUy+Ez5tYS8A==
X-Received: by 10.98.66.86 with SMTP id p83mr2471476pfa.229.1518174338299;
        Fri, 09 Feb 2018 03:05:38 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d8sm5455137pfh.93.2018.02.09.03.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 34/42] completion: use __gitcomp_builtin in _git_replace
Date:   Fri,  9 Feb 2018 18:02:13 +0700
Message-Id: <20180209110221.27224-35-pclouds@gmail.com>
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

The new completable option is --raw.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/replace.c                      | 3 ++-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae371..0c1d8e1b08 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -439,7 +439,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
-		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
+		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e600b7aa3..18c2ccece9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2661,7 +2661,7 @@ _git_replace ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --graft --format= --list --delete"
+		__gitcomp_builtin replace
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

