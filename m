Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120201F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935949AbeF3JJh (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34686 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934871AbeF3JIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so8462877lfi.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJ5ql7nSj52nKRnENwxV0j2kWupS+HndXS9ZRJ3T6+4=;
        b=BoKSMyfX831nhfQeMJDystJ5913hLk+KuAUAdN4vnVytXM6Cl35gnDBy83AwZ78bMo
         mWStNM7XnOb6ebr3kZj/2EBCbKI5MQQCFoWah0I6GUBzpzEe7ZC+i0SVXAL+crvNC0Ur
         nYju6zJ+ZcLiK/An+6gmlg5G2phJqxne7AD8HGXE9asSGEBMxlZc/+fJJsDkcxjnBanQ
         49ltMmLUkWvJ7BT5Ia2mY03h6ng5WaH33sOr8OgFnzXMDu+H4zIUTuq+3uUJh46l/RRC
         AD9gzNt+63QiewpRlWPw9AljRqbUU+UEn8v5QcCudLzvfIEe7aalim5casX+96Iwg+Qp
         Ln6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ5ql7nSj52nKRnENwxV0j2kWupS+HndXS9ZRJ3T6+4=;
        b=laHC9lRzM1wsPDQjq80pAiBSlp4g4nHUgUdUenIm8A3qp9H7l4KAARkLQp23FhhPR4
         99bYSi85SJIiFZKxvx60bd101BxXdxwpN+7w1m1YIXhO/MgyIeIw3q50FPp8O3BakTS4
         RE3S/MHNpreS5/Ux8fzGX5U9uIM1NzUf2bKeVWcj2F0uTNr82tfN+WBvcBBnPZSoYNJJ
         vfN7bBqibZm84vqA2qXiy88A1PvhWafk4vIw2Zf54BTxAG2nNpxEjMM4+sR4rwBsQAqZ
         4wp4Pai4Fka1EvqJu6g2gooPTIjhJa2iITi/03+yOm4h/kT1pQ+DkSdaiVQ/co5tSP/y
         RVTg==
X-Gm-Message-State: APt69E2ywKzuqK27Il/KFVOwTcyCov08J10C4uiMniSyHJsnOMmxyotx
        1r2g+N7sXODII5yPebZ3IVnbAQ==
X-Google-Smtp-Source: AAOMgpeTOzTCJ1ia7Myi2YkTsV8s5BsRwuD/1HSqBi6UzU9DV8ZijxvYCQ6uxMuEol4Jd2EsVThPtA==
X-Received: by 2002:a19:dbc3:: with SMTP id t64-v6mr11391440lfi.123.1530349727516;
        Sat, 30 Jun 2018 02:08:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/23] sequencer.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:15 +0200
Message-Id: <20180630090818.28937-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6b6162d194..f7c2f2422d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -716,7 +716,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	/* dequote values and construct ident line in-place */
 	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning("could not parse '%s' (looking for '%s'",
+			warning(_("could not parse '%s' (looking for '%s'"),
 				rebase_path_author_script(), keys[i]);
 			return NULL;
 		}
@@ -738,7 +738,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	if (i < 3) {
-		warning("could not parse '%s' (looking for '%s')",
+		warning(_("could not parse '%s' (looking for '%s')"),
 			rebase_path_author_script(), keys[i]);
 		return NULL;
 	}
@@ -1444,7 +1444,7 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
-	die("unknown command: %d", command);
+	die(_("unknown command: %d"), command);
 }
 
 static char command_to_char(const enum todo_command command)
@@ -2600,15 +2600,17 @@ static int error_with_patch(struct commit *commit,
 		if (intend_to_amend())
 			return -1;
 
-		fprintf(stderr, "You can amend the commit now, with\n"
-			"\n"
-			"  git commit --amend %s\n"
-			"\n"
-			"Once you are satisfied with your changes, run\n"
-			"\n"
-			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
+		fprintf(stderr,
+			_("You can amend the commit now, with\n"
+			  "\n"
+			  "  git commit --amend %s\n"
+			  "\n"
+			  "Once you are satisfied with your changes, run\n"
+			  "\n"
+			  "  git rebase --continue\n"),
+			gpg_sign_opt_quoted(opts));
 	} else if (exit_code)
-		fprintf_ln(stderr, "Could not apply %s... %.*s",
+		fprintf_ln(stderr, _("Could not apply %s... %.*s"),
 			short_commit_name(commit), subject_len, subject);
 
 	return exit_code;
@@ -2719,7 +2721,7 @@ static int do_label(const char *name, int len)
 	struct object_id head_oid;
 
 	if (len == 1 && *name == '#')
-		return error("illegal label name: '%.*s'", len, name);
+		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
-- 
2.18.0.rc2.476.g39500d3211

