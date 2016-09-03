Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585F11FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbcICDbi (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 23:31:38 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33006 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbcICDbf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 23:31:35 -0400
Received: by mail-pa0-f52.google.com with SMTP id cy9so45655431pac.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=am0BoJBizRsbphZd+MijBxhGUeVqQrho99YTvxywrk8=;
        b=dEJeW4Dkn65XEDVsSaWXakVpsRTTFafP22+SAuikyW3Nig3ebHpxzF7hdDivN0zwAX
         Uz0G65R5fgMWdSoXbbBmFabliLHvkSPSd70FeJ341fQkWJ64DkuhEllJoDAaZiYxCJWW
         2skSBAquYiTQV23YkIR+9qv1LKTZVcU+69sZdnmK37QbnUl/V66LvWiIcUNxs21KSGr0
         lSAgnOOIifAHuYGlAnOfeD286C2WQuFy7S58m4JddHOkG2bnj/4djeCm1mGvY6P2Qc6I
         vz16oSkrz4fA8V/r99ME1ejO8utwrhTUmp7rXyL1d6OB0RojM2elfF41WaEDpO1KENiN
         4clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=am0BoJBizRsbphZd+MijBxhGUeVqQrho99YTvxywrk8=;
        b=g938Jpd4DJUABR1jVvqc18E7S/A13ORrlj9d0RylJeLwQ5sYAFgPyQc8YqHoyufeEA
         jfvf0M83X+apQZvGzyAmqZx6avj5QlT9j0SmGakslY+6NSIFBfcw+fbyouGnxJVZqKIO
         lQvciKHAmQmlQj66Uoow1HAbvb2L6rG/3X5EOuDxb6Kv5cq5Zpz2NeUWP3NM2fA/PjCQ
         7jSDyhnsgTLQnZcgaquXxgT4M+H5KybxlvcE0XU8E2LO3DC1quJPnEM7GYq/iKPZp20Z
         0hH2muNeMWInevC+EzfhWsXYiOYuyVoRhPT4URn2G6EsF89DKbiJ+eAE/Cq0PWL7Z4kT
         Qx7w==
X-Gm-Message-State: AE9vXwN331CUjH1LGD7dP2QNG5g9R6Erd227ad6TqHw6oTfqSp85jx2LhdOi/caQyRnFuOkH
X-Received: by 10.66.189.104 with SMTP id gh8mr41908737pac.125.1472873494450;
        Fri, 02 Sep 2016 20:31:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29f6:f946:ae72:afdc])
        by smtp.gmail.com with ESMTPSA id d9sm17859738pan.7.2016.09.02.20.31.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 20:31:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] diff.c: emit duplicate lines with a different color
Date:   Fri,  2 Sep 2016 20:31:19 -0700
Message-Id: <20160903033120.20511-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc2.23.gf336a1a.dirty
In-Reply-To: <20160903033120.20511-1-sbeller@google.com>
References: <20160903033120.20511-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Color is WIP, I just make space for a different case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 26 ++++++++++++++++++++++++++
 diff.h |  4 +++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 534c12e..57d435c 100644
--- a/diff.c
+++ b/diff.c
@@ -52,6 +52,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_YELLOW,	/* COMMIT */
 	GIT_COLOR_BG_RED,	/* WHITESPACE */
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
+	GIT_COLOR_BLUE,		/* NEW DUPLICATE */
+	GIT_COLOR_CYAN,		/* OLD DUPLICATE */
 };
 
 static int parse_diff_color_slot(const char *var)
@@ -541,6 +543,14 @@ static void emit_add_line(const char *reset,
 			  DIFF_FILE_NEW, WSEH_NEW, '+');
 }
 
+static void emit_add_line_dup(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	emit_line_checked(reset, ecbdata, line, len,
+			  DIFF_FILE_DUPLICATE_NEW, WSEH_NEW, '+');
+}
+
 static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
@@ -549,6 +559,14 @@ static void emit_del_line(const char *reset,
 			  DIFF_FILE_OLD, WSEH_OLD, '-');
 }
 
+static void emit_del_line_dup(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	emit_line_checked(reset, ecbdata, line, len,
+			  DIFF_FILE_DUPLICATE_OLD, WSEH_OLD, '-');
+}
+
 static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
@@ -1300,6 +1318,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	switch (line[0]) {
+	case '*':
+		ecbdata->lno_in_postimage++;
+		emit_add_line_dup(reset, ecbdata, line + 1, len - 1);
+		break;
 	case '+':
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
@@ -1308,6 +1330,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		emit_del_line(reset, ecbdata, line + 1, len - 1);
 		break;
+	case '~':
+		ecbdata->lno_in_preimage++;
+		emit_del_line_dup(reset, ecbdata, line + 1, len - 1);
+		break;
 	case ' ':
 		ecbdata->lno_in_postimage++;
 		ecbdata->lno_in_preimage++;
diff --git a/diff.h b/diff.h
index 7883729..d500f0e 100644
--- a/diff.h
+++ b/diff.h
@@ -189,7 +189,9 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8
+	DIFF_FUNCINFO = 8,
+	DIFF_FILE_DUPLICATE_NEW = 9,
+	DIFF_FILE_DUPLICATE_OLD = 10
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
-- 
2.10.0.rc2.23.gf336a1a.dirty

