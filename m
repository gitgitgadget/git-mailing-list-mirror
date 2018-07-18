Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464C81F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbeGRQvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44260 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731853AbeGRQvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so3851571lfb.11
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJ5ql7nSj52nKRnENwxV0j2kWupS+HndXS9ZRJ3T6+4=;
        b=hTVKD9eoo7QnUzerc00xgitgmtvB9dru9SWh25V4NlnvAX23hdu0Uew+RGzQi8OdLY
         q6EQDEePITCxTME385ann9fiRoVCT17l8T1sdvIUfO3xVOOY8zklILJj053SPkp0YyEJ
         E2xxWhcAMEjmcaxcssYSeiuX1yWrM8f2f50n7sJYv97yHehP5lXCe/zGh3oxoPBGtbnv
         xVG5SH9IdRIK7icVgsMTOzsDbSY4PRtFLB6PyXcSKKHiEh2o9ORapDDdtLRSfJhLxevS
         b6AxCZM0yK0CkCKL/EfXZfYiSJROYcRxD67xukqJWvC8fCrmwc3JskqwdLBbmes2JSLW
         ZhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ5ql7nSj52nKRnENwxV0j2kWupS+HndXS9ZRJ3T6+4=;
        b=h8nnJKxR7zUV/ODJ0DP+hmXGpnmMagoIaEJ590FvvRTNCKjWqDxp8cCo40F6xfAWf2
         4SJxpCUA+GYw5fQ4RtQPF/0JldCUF/0BJizKu9b/LPgPmSZxL77OaKFrwHpHtTtGT8+I
         e+4MSz4xJRXgPpvrDAWqeQVKFimjnWhJ/v3WeZ5+T7s+HBNGrqgPZHmXiztHilko3LSb
         Uqdjf2vR2TM8cnwOzRZjBxjASqAe/4RTaQdt4qQLm48lGCfc3+kwAulNx/oqaNPucSM7
         nVUWtIh/Z870ubWRXmWb9iiQ0Lt3e5N1BJypDB9H52NG0BW2V+wYFt3ObejdHywVsLPe
         b+Ng==
X-Gm-Message-State: AOUpUlF6AJQLuccNd39TgSFhN4jjWxQrboWdItTw7IQ27gvZ2WZMtv3g
        XJvj005U+qCbEuqJEnQhhfGPNw==
X-Google-Smtp-Source: AAOMgpddCloBl7nhlyLYu9CSMQ40MR+60T8IoTURGZ2tCoAIKs18+2I4AmpMOeh9JFY/5HE6nc+B4g==
X-Received: by 2002:a19:a04c:: with SMTP id j73-v6mr4630495lfe.123.1531930389725;
        Wed, 18 Jul 2018 09:13:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 20/23] sequencer.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:58 +0200
Message-Id: <20180718161101.19765-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
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

