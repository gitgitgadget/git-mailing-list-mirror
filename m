Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A5520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 15:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeLKPfH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 10:35:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42777 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKPfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 10:35:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so11091815lfh.9
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuW/7HLa34pZkx+QvUI4ozOIs65eAxGV9/Rpehm+nU8=;
        b=AkKaEoY2hUB9+GcFpcNe2Ev5SeiduhfbjRMBTwadXPlQ7dfPygPu+cmtTBeJxbbnyQ
         Rxrppnat1fiAIaFwo3PuqkRRPdUEYace808niVb70H9B89oY4QBC/txX6l+Et2B2gnDq
         c2y5fSJjy4YW6+C/hk08stgpzd95PXl0mk0rUDppDRsKB6k3nUtEtYlwT5HF5UokMsAQ
         qaOA3WLjUHCB2JT2ooSV4yXnsSRjgoSC1Gy8gw3DmCCSnK83NY1iSZwXoMrOJacmjHhw
         3PWiSLNITrFfiweyzeaKxOQmMoFYDfHtRvX+AZKXIWPhsgexD3fr4ZaCLAD+EfAzYCyE
         oVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuW/7HLa34pZkx+QvUI4ozOIs65eAxGV9/Rpehm+nU8=;
        b=oYoaORTjo/XLRU5TJurwopAVNYej3NBgwGC8mBWA26QC8TOI6A1PwKFOXUFw/rOOvi
         Iw2lCAzgam3DbsH+ZLwboA0iZOShwZlsHxyqRZji6PbVsh8+1AtvaiUnTs67smWxX/TG
         oS6iiZzPi6yA9LJnjc54hboCdmyhzPRaEVVvZmVaxkrVqzVbFkLozInwDHzyp/rABLBX
         6zRgJOyWi7R+asc0lf97HnI56zoVvr/OuExICc9Kzam9rxiEfFdIh5YgvQdb3piA5H3m
         GgU9z32bTl17+r1N5JSx1CAHqFqLtFKUD4nEm5JTi//BizQL5hgXP5HsZ2mu4FoM2D30
         tVQQ==
X-Gm-Message-State: AA+aEWZWB6JYpus8NLCH9oIwyToWHHQBUqQ6cD9s8TqB/NqJzuBGaICw
        3L5dZ3IXyibPHdt5cnF5yFk=
X-Google-Smtp-Source: AFSGD/UuuAoNbXNoKdIa2nMo5KFtuKDFsjrl+4SQbnGrPlX2B5mwO6zYz4ntENNN41X6q4kXBEjRsQ==
X-Received: by 2002:a19:7399:: with SMTP id h25mr10177382lfk.85.1544542505114;
        Tue, 11 Dec 2018 07:35:05 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2723352ljg.21.2018.12.11.07.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:35:04 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2] parse-options: fix SunCC compiler warning
Date:   Tue, 11 Dec 2018 16:35:01 +0100
Message-Id: <20181211153501.2169-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.481.gca8ed29094
In-Reply-To: <20181209102724.8707-1-pclouds@gmail.com>
References: <20181209102724.8707-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The compiler reports this because show_gitcomp() never actually
returns a value:

    "parse-options.c", line 520: warning: Function has no return
    statement : show_gitcomp

We could shut the compiler up. But instead let's not bury exit() too
deep. Do the same as internal -h handling, return a special error code
and handle the exit() in parse_options() (and other
parse_options_step() callers) instead.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/blame.c        | 2 ++
 builtin/shortlog.c     | 2 ++
 builtin/update-index.c | 2 ++
 parse-options.c        | 4 +++-
 parse-options.h        | 1 +
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06a7163ffe..6d798f9939 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -850,6 +850,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
 			exit(129);
+		case PARSE_OPT_COMPLETE:
+			exit(0);
 		case PARSE_OPT_DONE:
 			if (ctx.argv[0])
 				dashdash_pos = ctx.cpidx;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 88f88e97b2..65cd41392c 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -287,6 +287,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
 			exit(129);
+		case PARSE_OPT_COMPLETE:
+			exit(0);
 		case PARSE_OPT_DONE:
 			goto parse_done;
 		}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 31e7cce301..e19da77edc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1086,6 +1086,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
 			exit(129);
+		case PARSE_OPT_COMPLETE:
+			exit(0);
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_DONE:
 		{
diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..6932eaff61 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -516,7 +516,7 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 	show_negated_gitcomp(original_opts, -1);
 	show_negated_gitcomp(original_opts, nr_noopts);
 	fputc('\n', stdout);
-	exit(0);
+	return PARSE_OPT_COMPLETE;
 }
 
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
@@ -638,6 +638,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	case PARSE_OPT_HELP:
 	case PARSE_OPT_ERROR:
 		exit(129);
+	case PARSE_OPT_COMPLETE:
+		exit(0);
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
diff --git a/parse-options.h b/parse-options.h
index 6c4fe2016d..a650a7d220 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -208,6 +208,7 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 /*----- incremental advanced APIs -----*/
 
 enum {
+	PARSE_OPT_COMPLETE = -2,
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
 	PARSE_OPT_NON_OPTION,
-- 
2.20.0.481.gca8ed29094

