Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743251F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBILFP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:15 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:40961 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeBILFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:13 -0500
Received: by mail-io0-f196.google.com with SMTP id f4so9209020ioh.8
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EeBnrW6e/po/2JcUhIwlVUITR6Ofg/baUPMuAxyizY=;
        b=aK/0wod4AIm67EsPNJZet/7fK9Dz0kUVUIMA1GvjkyYyU/1ztCC2z7VmB8qw5vJR7L
         o0/FqhxEpWfcOgEzO+rIGmWeopw17Tlm3P6lHsIWhhqtFlUQDOKKlhj+XtCibOf7Qx3W
         NpAhZg88gghqE8z98wQ85tTHzZ864byyDOEpGAXcEJgj2kqK5aUTSNuq37ZDbyaZdZQ6
         38YnzDSe74JVjrrIpabBr6eIs4W/icJjGloReRMAsUHxvet4/0QwCqa/cEkh9YxVKzV9
         gHIyS6Q660x56KJipQHfajPWWes4jqu3ctUQ2Sm7c9rooWMAZkPCia9qCD1VpfW595e3
         ZwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EeBnrW6e/po/2JcUhIwlVUITR6Ofg/baUPMuAxyizY=;
        b=okRLLPH9oYJd0dntE8pbWVgeZx1SuCMbQSZX4R2K7bswvqxnu51TrxcTrC4QfxJMup
         lMvaTfE4RGJT/5atCovQ5AdCYj2yYiUid179OE9h7y/kHk2q81XA6AFh6HEXJmvGR7Q6
         CoO20yQ2J/f0Xfudo45jp416lgTp6N7cgLyrfpAbdgOjpscneauRfWwwECpIOtWVfl0O
         wgR3koLRdOqBoosMAtO61eNortj7y8el35t1cU9NRvl9lRM8LEq3jqwFaUcGn28Te/Of
         uicWqbWrQkOIlM0ESPq/mywZ97mJjes8/R9j+gR0DFzIJbfVVR2OGhHlQhYeOKWePxjS
         QSug==
X-Gm-Message-State: APf1xPDXXS7q6ETlGpjkhPxKQ56Zu7yyMQLfdvbdj2Fz8hwnOHI1MsVK
        f0TC3jsCyxeQYQF80sjDii0ChA==
X-Google-Smtp-Source: AH8x225fBEQ68Qg1O19D388Fv09HrAk5DmTPGSERiwcmmu0hUvw/ZjJVfJlPgWXcpvLfYC6/DCFRRA==
X-Received: by 10.107.151.72 with SMTP id z69mr2579221iod.185.1518174313127;
        Fri, 09 Feb 2018 03:05:13 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e1sm2477642ioe.13.2018.02.09.03.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
Date:   Fri,  9 Feb 2018 18:02:08 +0700
Message-Id: <20180209110221.27224-30-pclouds@gmail.com>
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

--allow-empty (notes add and notes append)
--for-rewrite= (notes copy)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/notes.c                        |  4 ++--
 contrib/completion/git-completion.bash | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index b52e71c73e..6990683bd4 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -413,7 +413,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg},
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
-		OPT__FORCE(&force, N_("replace existing notes"), 0),
+		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
@@ -484,7 +484,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
-		OPT__FORCE(&force, N_("replace existing notes"), 0),
+		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read objects from stdin")),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, N_("command"),
 			   N_("load rewriting config for <command> (implies "
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7b8b37f19..60127daebf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1835,7 +1835,7 @@ _git_notes ()
 
 	case "$subcommand,$cur" in
 	,--*)
-		__gitcomp '--ref'
+		__gitcomp_builtin notes
 		;;
 	,*)
 		case "$prev" in
@@ -1851,15 +1851,17 @@ _git_notes ()
 	add,--reedit-message=*|append,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
-	add,--*|append,--*)
-		__gitcomp '--file= --message= --reedit-message=
-				--reuse-message='
+	add,--*)
+		__gitcomp_builtin notes_add
+		;;
+	append,--*)
+		__gitcomp_builtin notes_append
 		;;
 	copy,--*)
-		__gitcomp '--stdin'
+		__gitcomp_builtin notes_copy
 		;;
 	prune,--*)
-		__gitcomp '--dry-run --verbose'
+		__gitcomp_builtin notes_prune
 		;;
 	prune,*)
 		;;
-- 
2.16.1.207.gedba492059

