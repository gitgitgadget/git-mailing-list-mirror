Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13D620248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfDQOdE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbfDQOdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so27578277wrx.10
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=NqNn/Gamrf1WZe/5ECTWZjfA/fzvYU+ccnZ68FTcD04=;
        b=sbpvK0302qM7UbEdo3+kKNfjp3VykuvTB72DVc+l8KqBiYZ3YDz616usyDvk4yGaqw
         JJAC7tw9rQy4A4HXJL7QeIe3SJjrSSt778h1pEyCo8aUdaYWMbYPMvAn5bg7BvcjR2PI
         tphK/W4JPwCLcELbKj9XVs2JTLijf2jI1fYEqOrXBS7S1dUx5yxP9PQl2BNPIAmBC+Ps
         1zoWRsCyPUibDHfdjdpNrrT2VmeodpP664Lw6KPxltYGuQiwEQ6WMvbwSukv8uJFpI1Z
         JmYHqFcXcYqpTnoVi3dbNJLkkAfv5aU/kIFZ250KvLegCveW++lP1DvT79X8RQRZEvYy
         4Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=NqNn/Gamrf1WZe/5ECTWZjfA/fzvYU+ccnZ68FTcD04=;
        b=XPNhjnO/HqS5kYZlxYmhwtrGQ8ppvXOqBcjSkbkGkpxh6AnpsCYucvBIACKMRWGtWv
         3ZANZSQQeahAGeh9oUhHowHWdgkCob7f35pwX+Y19T4ti0zbnXJIAjwfJ3u9ViPG0Nr5
         KhQukVTjkbI2J4CKvU8JrQ1Tykpr1dzdbeV4W6hSo1dwjpTZQ/VVnGfeSShr4h5KYK0H
         h3D02KKqVdgtZ/InPJ/C4HUm2NOHVJybflBPH5BjwK8TWc/SBVyCepUnzEPzSrDOb9i/
         4o9QGjed2SQaHit9EBsIx76gX8fPfxCGt3LZ7lBo/NHl66H72Y6i9mfcPw3yIrBG8/9r
         eCGQ==
X-Gm-Message-State: APjAAAU/f4yBZUQl43ZyxIfBXDYsG/0RMYzrcREjxS/W1PGZCtTNKNDT
        UY/YLFCUgd21y1/8x2eM69CKTErAIiA=
X-Google-Smtp-Source: APXvYqzKatHaM0879/SckPcAJ4vXPoXgFbZYekviIaV0Kg01ztL1l6AZgw0AROy46GqS2HlOcjJqtA==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr8082566wrd.284.1555511581441;
        Wed, 17 Apr 2019 07:33:01 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:33:01 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 04/12] rebase: use OPT_RERERE_AUTOUPDATE()
Date:   Wed, 17 Apr 2019 15:30:36 +0100
Message-Id: <20190417143044.17655-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As we have a macro for this it makes sense to use it. Having
cmd_rebase() and cmd_rebase__interactive() use the same values for
this option will be helpful when we start running interactive rebases
without forking rebase--interactive.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0b1a193a8e..e7b8122003 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -206,14 +206,13 @@ static int read_basic_state(struct rebase_options *opts)
 			    &buf))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
-			opts->allow_rerere_autoupdate = 1;
+			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
 		else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
-			opts->allow_rerere_autoupdate = 0;
+			opts->allow_rerere_autoupdate = RERERE_NOAUTOUPDATE;
 		else
 			warning(_("ignoring invalid allow_rerere_autoupdate: "
 				  "'%s'"), buf.buf);
-	} else
-		opts->allow_rerere_autoupdate = -1;
+	}
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
 		strbuf_reset(&buf);
@@ -263,10 +262,11 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	if (opts->strategy_opts)
 		write_file(state_dir_path("strategy_opts", opts), "%s",
 			   opts->strategy_opts);
-	if (opts->allow_rerere_autoupdate >= 0)
+	if (opts->allow_rerere_autoupdate > 0)
 		write_file(state_dir_path("allow_rerere_autoupdate", opts),
 			   "-%s-rerere-autoupdate",
-			   opts->allow_rerere_autoupdate ? "" : "-no");
+			   opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
+				"" : "-no");
 	if (opts->gpg_sign_opt)
 		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
 			   opts->gpg_sign_opt);
@@ -625,9 +625,9 @@ static int run_am(struct rebase_options *opts)
 	argv_array_push(&am.args, "--rebasing");
 	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 	argv_array_push(&am.args, "--patch-format=mboxrd");
-	if (opts->allow_rerere_autoupdate > 0)
+	if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
 		argv_array_push(&am.args, "--rerere-autoupdate");
-	else if (opts->allow_rerere_autoupdate == 0)
+	else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
 		argv_array_push(&am.args, "--no-rerere-autoupdate");
 	if (opts->gpg_sign_opt)
 		argv_array_push(&am.args, opts->gpg_sign_opt);
@@ -713,9 +713,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
 		if (opts->allow_empty_message)
 			argv_array_push(&child.args, "--allow-empty-message");
-		if (opts->allow_rerere_autoupdate > 0)
+		if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
 			argv_array_push(&child.args, "--rerere-autoupdate");
-		else if (opts->allow_rerere_autoupdate == 0)
+		else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
 			argv_array_push(&child.args, "--no-rerere-autoupdate");
 		if (opts->gpg_sign_opt)
 			argv_array_push(&child.args, opts->gpg_sign_opt);
@@ -764,9 +764,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
 	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
 	add_var(&script_snippet, "allow_rerere_autoupdate",
-		opts->allow_rerere_autoupdate < 0 ? "" :
 		opts->allow_rerere_autoupdate ?
-		"--rerere-autoupdate" : "--no-rerere-autoupdate");
+			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
+			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
@@ -1007,7 +1007,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.type = REBASE_UNSPECIFIED,
 		.flags = REBASE_NO_QUIET,
 		.git_am_opts = ARGV_ARRAY_INIT,
-		.allow_rerere_autoupdate  = -1,
 		.allow_empty_message = 1,
 		.git_format_patch_opt = STRBUF_INIT,
 	};
@@ -1101,10 +1100,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', "preserve-merges", &options.type,
 			    N_("try to recreate merges instead of ignoring "
 			       "them"), REBASE_PRESERVE_MERGES),
-		OPT_BOOL(0, "rerere-autoupdate",
-			 &options.allow_rerere_autoupdate,
-			 N_("allow rerere to update index with resolved "
-			    "conflict")),
+		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
-- 
2.21.0

