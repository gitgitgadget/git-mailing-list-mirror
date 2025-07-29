Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AC221F01
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806025; cv=none; b=E3IRkONskTb3XuAHgn61ee/vmP9vICbXLtA8ReCLkf3QoKn7xPdGcivGw5vot13XpGQNnX2a8uwCOpCPSdnTCOR8IAaxURr9/umT50086K4tn5R1wCbKHrcLI453YJevwtz29TLwtIWUKIocmrpOF1Die8muwsNKrud/Z9va9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806025; c=relaxed/simple;
	bh=wWx2m/Zc6FzssRkTmts2ezqUm/3QNMRECPdMyGlno7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym7tk65aEEcL99JaCfd5aFdJcXVaKid63egdhxCKHVWF6crrEYTITCTYYpynZZs4UkUw4iYPVxW87uChOgly+0acE50Q8GncgPjPbYaknLKx9oKdQfkjQpH6mJZBoTQZBE8k1S4ajH9nfNKwCw26m/NpESx2BuBQJgS/5NzNa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UouN/nr1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UouN/nr1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b350704f506so53132a12.0
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806023; x=1754410823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgJiPINdgXqYpCRra88drQL++uYuIfdsSTYYAXeI8SM=;
        b=UouN/nr145Ok/4WDwUFJEz4duxdxguIfRErJ6GmQIrLEZW8cmNMmbnAiZpsq2NZ6D3
         Ts9+TfkjESo8cJO9x17bIcqfNwmsKpJbv4+rxobKXtoyI9BNaeOPD4jDvtEYVebL2+ab
         fqgUh5KVsyWDEzGY4nyyyr5CK+WH8vq5QmYaKT+vCog7qsvrDl4+l8+F2uDByMB2uFic
         SghnXutgMNpMNP/Uh73gwvckR2vG/4mIrSaGCeNaMbWqFzxIK5VALK0srpTBDTPbWG0u
         j15lvsIAOozhN2DvGhFHlgVbHbj9uVkTNNn7+Q1kSi00Eep9LIzLDOhXJI//hm66tb3/
         k16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806023; x=1754410823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgJiPINdgXqYpCRra88drQL++uYuIfdsSTYYAXeI8SM=;
        b=fKWAmctZTajI0XKiU87q7g1yogTyx8WLaOEbPeFLjJtGXO6dWoZsmC9ssRcxKm7Skg
         pcY73EqUnMdvBpCbyxOBRSYohUd67HPAJfFLMn4n3ksyQEjodi4Jeu+5V+L6/YCITJq7
         g7MeyXpMvt//VGADYfyiUX5cHXO8URr8Unt1gRnqg4RnHIALimywgw/LKomMki394Dy+
         sWlo5DAnpOb7Yu2UwiFb9oqlGxNr9X6FytRvMnR69OTC05KXusqWqa/z29moVVmCHuak
         6pgKPVqw5jqDzHJclM838nBZxRWF94DqGAgTzzkI62uNURloRUxSE/OWqwgH8LkXXLjV
         sH0A==
X-Gm-Message-State: AOJu0YxgH/+2yUV0zyZ7QaWTuhfbWf6MaO/gqfnAsbro7rWa4QmmgVoQ
	hg77DMmTXlOPRzC6MsXY4FC7pLMYx+6R3STdliJP2FmKEAE85np5WDAO4HeQneTt
X-Gm-Gg: ASbGncuVcA1PV38n1rx7KgCnPUN2Y5sAeLBsm1/oMkCWkrINU2ZqXOpk918KNEQdcNJ
	nlGvrztISHy3yQJea+Uutr3gS7kbC3hMJNErHub66DHyqAbfbiM+KnH7JGaQyyZUSbhOsqpC1Mr
	wnovRe8VRBlXkQHMozlFDE7YIJl/qFr65ALmCpqX+x5WVcC0+q70o99cDPoEKXxbc5/OcXopn6q
	SpQjGqGnFP1dylc+5HKMWQDvj8GbF6nofccXxTBeNJ72nFEqVF4tomCT5ZSPHc58r+dOrh8B6sy
	z4LjsNeUqXbTtgO5LcV8OBOn5EEFGWR2ulrJIAv+e7KURGduc9lipMH+QzO22nXwSeJ+OBWm6dD
	P9h9/eyRCHAV+3+xVcSX4ACtgYlbYSEusUDhhrc1qqxIYwHBTbtgYLyQ=
X-Google-Smtp-Source: AGHT+IHDc1Vg9EBN0SkRuXsFrN8h2EFj+mGQhrxrQ5Gp/WuzXVKQtyX1nuGBjId+7x3EYK0Dbtztgw==
X-Received: by 2002:a17:90b:3d85:b0:31e:a48c:25ef with SMTP id 98e67ed59e1d1-31f5dd1f527mr235564a91.10.1753806022569;
        Tue, 29 Jul 2025 09:20:22 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.201.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f2efd8b36sm1400032a91.1.2025.07.29.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:20:22 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 1/2] environment: remove the global variable 'merge_log_config'
Date: Tue, 29 Jul 2025 21:49:34 +0530
Message-ID: <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753804956.git.ayu.chandekar@gmail.com>
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'merge_log_config', set via the "merge.log" or
"merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
'cmd_merge()' to adjust the 'shortlog_len' variable.

Remove 'merge_log_config' and introduce a function
'adjust_shortlog_len()' in fmt-merge-msg.c to handle the 'shortlog_len'
variable.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/fmt-merge-msg.c |  4 ++--
 builtin/merge.c         |  4 ++--
 environment.c           |  2 --
 fmt-merge-msg.c         | 30 ++++++++++++++++++++++--------
 fmt-merge-msg.h         |  3 ++-
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3b6aac2cf7..fed8163825 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -58,8 +58,8 @@ int cmd_fmt_merge_msg(int argc,
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (shortlog_len < 0)
-		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
+
+	adjust_shortlog_len(the_repository, &shortlog_len);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/builtin/merge.c b/builtin/merge.c
index 18b22c0a26..e1cf2a6d63 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1403,8 +1403,8 @@ int cmd_merge(int argc,
 		parse_branch_merge_options(branch_mergeoptions);
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
-	if (shortlog_len < 0)
-		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
+
+	adjust_shortlog_len(the_repository, &shortlog_len);
 
 	if (verbosity < 0 && show_progress == -1)
 		show_progress = 0;
diff --git a/environment.c b/environment.c
index 7c2480b22e..74c9838b31 100644
--- a/environment.c
+++ b/environment.c
@@ -20,7 +20,6 @@
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
-#include "fmt-merge-msg.h"
 #include "commit.h"
 #include "strvec.h"
 #include "path.h"
@@ -66,7 +65,6 @@ int grafts_keep_true_parents;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
-int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 int max_allowed_tree_depth =
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 40174efa3d..2ceaebb0ce 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -26,14 +26,7 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 int fmt_merge_msg_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
-	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
-		int is_bool;
-		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
-		if (!is_bool && merge_log_config < 0)
-			return error("%s: negative length %s", key, value);
-		if (is_bool && merge_log_config)
-			merge_log_config = DEFAULT_MERGE_LOG_LEN;
-	} else if (!strcmp(key, "merge.branchdesc")) {
+	if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
 	} else if (!strcmp(key, "merge.suppressdest")) {
 		if (!value)
@@ -645,6 +638,27 @@ static void find_merge_parents(struct merge_parents *result,
 	result->nr = j;
 }
 
+void adjust_shortlog_len(struct repository *r, int *shortlog_len)
+{
+	const char *keys[] = { "merge.log", "merge.summary", NULL};
+	
+	if (*shortlog_len >= 0)
+		return;
+
+	for (const char **key = keys; *key; ++key) {
+		int is_bool, value;
+		if (!repo_config_get_bool_or_int(r, *key, &is_bool, &value)) {
+			if (!is_bool && value < 0) {
+				error("%s: negative length %d", *key, value);
+				return;
+			}
+			*shortlog_len = (is_bool && value) ? DEFAULT_MERGE_LOG_LEN : value;
+			return;
+		}
+	}
+
+	*shortlog_len = 0;
+}
 
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index 73ca3e4465..f54f00d26f 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -2,6 +2,7 @@
 #define FMT_MERGE_MSG_H
 
 #include "strbuf.h"
+#include "repository.h"
 
 #define DEFAULT_MERGE_LOG_LEN 20
 
@@ -12,9 +13,9 @@ struct fmt_merge_msg_opts {
 	const char *into_name;
 };
 
-extern int merge_log_config;
 int fmt_merge_msg_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb);
+void adjust_shortlog_len(struct repository *r, int *shortlog_len);
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *);
 
-- 
2.49.0

