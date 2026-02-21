Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053630DD03
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691077; cv=none; b=KqKtPSi1NfUtf4U2AOkofVnwd3U2lgXKIwboTWJiQR3/OXK5y3LMh2Dq8r7GgEf4aZewwviQPsgp4RLN9wJiu4+/3JqJZuPxmAQJjO7hwEAsyrZ6jEVYfCAvjp50q70IyuvCNvd1Hs7MQwPfC4povtyl5GcW76lVtkeXl7GYpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691077; c=relaxed/simple;
	bh=zjXQmYV7kK0xhUWE8zXuTv6HEP6sY04D+Vsguswfo/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmQfAeFjeQ97lzuZm1xfA/u68LLvuhZ2e2xzONGHu014LsW+1Xczba7Hi45NLb4DV63XIc2FmmWKeOBdN41ZLtLtacI2WxCbLp2kxI0Uvij0HDvHTOOIeivlVU4qfCAReby54dDtG3KGzGClfloTRR2v5dcNN3G0GnDTEo0RJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6GgFCsI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6GgFCsI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so2468214a91.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691075; x=1772295875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf7KqgXM9Qkpyt2DwVTCLaSFgWEUvx9+7ZKK/VzftJ8=;
        b=e6GgFCsIif0S/T9oXbEGuur/10YixN1s+3zEa86VIVOfq/QFQNU8Xh8211reqAbaVP
         p/SjvDRbOIKnN3Soq9RnA+9v1o08Nu3RyIXB+a1ZQ4iRnSOqSn7Itwu9DAsXPA7cawqv
         b1Rq2uxOgZt7zmHwX2DhPAqRm/hF1TYO0pn0xIYd7xgb1aPkF4afBy6uH3wFAQRJVwFa
         Yw0PESKZE0UUMUkpG58N566lEuDBUXXNTx7CBjvmRsafK33rga6uF40CRnCGH+zFUhbM
         IE25fS90C/MXE/YK0e7s4uAspKQJV2PPd6/JyZrwerqy9qdcTKN3NXwIEl85pXqVGJGE
         iWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691075; x=1772295875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xf7KqgXM9Qkpyt2DwVTCLaSFgWEUvx9+7ZKK/VzftJ8=;
        b=m1TGXGb+GUbMPbrMVavmhLj5/dzQGSwbn64xIidNMVQV9FipK/ER5UXlnEdSQMzjb3
         t+uJelW8D0toqOxy+kt+EzNPgEiDD+AdAUhAn4WbNIpt6JibcmatJ70MMGpN7IOeacvJ
         w83oCFTuTZGRjGqlduQ35l/OrL6vUHIQMOuBCAiI9/C6RdbwLuW+R/WY+gmRayPT9RJC
         1rFzVTuHx4uqMLYJZWW97GG5PR0PkAid7No6Pgv6LO+hHzhn5ofKklEsDs1+mSmGxG/C
         eTNAf9o2sZj6kI2eqH+wN83gMLfWM/OI/SoLIXNYjbUUrf30EoDQZuQ/xhnbuUWn/HLz
         qiIQ==
X-Gm-Message-State: AOJu0YwV0Jsbya3o/MntQRuUHJlCfWlLdOtbSc8R4N7MkIVb0SAGwvUj
	Ut3D6C+MXj/ItLBWPWND7wHmLQdCnqe9+rDppi/DcVNENUO0qz7V+aYrTM2jpA==
X-Gm-Gg: AZuq6aKBrrNzRoAlKFVuMsT8zoBqQbzMTdEHRGK1p1wj9NZvuKxfSAW1aZnTHDZ6Ap7
	ecge5KQMLrucg4YDuBhYca7uBbkYORAPGaQXEsyZz3bnhTNMIk70VXLzsU3/w+vOZx2ynQ6ALT4
	PT20kesI0AHN6Ap/q4NRJHZ3IzNVuLWoOYyO8uNfJSvwHGu2Yqqc1OJLnEEOaZwclWdWER34hXp
	dhpov7zu0Z4yn0K5pu3x8qes/mPh2kR2wxCK48U3coOy4JHPOUp6QzUPROSxGyIDKLIExbs8FYd
	Tbf5paFV1sEsKNABscZ5wmMK4XAgiOFpG5QHl9XV/4sf7dVK8zPmlODger02CUSHOcuOBRbvOxh
	VxwEhBmbQIxFCgqTOnnCPwJb9MzNGzrewCVwQNKnafcY5909hjLAjyLnQnjc4u6eVBga6P1XLEH
	71fK1niEqWE6/XPfM5UtyIwxa9nA7gQtNHBqWZfltCiKmf7f+Y/KDmTEeruefIHCPBG2wt1+p1D
	RsLY2mqSNqhsKsf
X-Received: by 2002:a17:903:3b83:b0:2aa:f0d6:bf59 with SMTP id d9443c01a7336-2ad744ec559mr35325255ad.35.1771691075187;
        Sat, 21 Feb 2026 08:24:35 -0800 (PST)
Received: from localhost.localdomain ([60.254.0.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75090177sm25345905ad.47.2026.02.21.08.24.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Feb 2026 08:24:34 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	avarab@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v3 2/2] help: cleanup the contruction of keys_uniq
Date: Sat, 21 Feb 2026 21:53:59 +0530
Message-ID: <20260221162359.43336-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260221162359.43336-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
 <20260221162359.43336-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

uniqueness property of keys_uniq depends on the sort operation executed
for keys, sorted property of keys does not gurantee sorted property of
keys_uniq due to processing keys, this might also introduce regressions
in future when the logic of forming keys_uniq from keys is changed.

add string_list_sort_u operation for keys_uniq and refactor the
processing code to simplify it.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/help.c | 134 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 44 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..b70de09864 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -111,6 +111,84 @@ struct slot_expansion {
 	int found;
 };
 
+static void show_config_human(struct string_list *keys)
+{
+	string_list_sort(keys);
+	for (size_t i = 0; i < keys->nr; i++) {
+		const char *var = keys->items[i].string;
+		puts(var);
+	}
+}
+
+static void show_config_sections(struct string_list *keys)
+{
+	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
+	struct strbuf sb = STRBUF_INIT;
+	struct string_list_item *item;
+
+	for (size_t i = 0; i < keys->nr; i++) {
+		const char *var = keys->items[i].string;
+		const char *dot = strchr(var, '.');
+		const char *wildcard = strchr(var, '*');
+		const char *tag = strchr(var, '<');
+		const char *cut;
+
+		if (dot)
+			cut = dot;
+		else if (wildcard && tag)
+			cut = wildcard < tag ? wildcard : tag;
+		else if (wildcard)
+			cut = wildcard;
+		else if (tag)
+			cut = tag;
+		else {
+			string_list_append(&keys_uniq, var);
+			continue;
+		}
+
+		strbuf_add(&sb, var, cut - var);
+		string_list_append(&keys_uniq, sb.buf);
+		strbuf_release(&sb);
+	}
+	string_list_sort_u(&keys_uniq, 0);
+	for_each_string_list_item(item, &keys_uniq)
+		puts(item->string);
+	string_list_clear(&keys_uniq, 0);
+}
+
+static void show_config_vars(struct string_list *keys)
+{
+	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
+	struct strbuf sb = STRBUF_INIT;
+	struct string_list_item *item;
+
+	for (size_t i = 0; i < keys->nr; i++) {
+		const char *var = keys->items[i].string;
+		const char *wildcard = strchr(var, '*');
+		const char *tag = strchr(var, '<');
+		const char *cut;
+
+		if (wildcard && tag)
+			cut = wildcard < tag ? wildcard : tag;
+		else if (wildcard)
+			cut = wildcard;
+		else if (tag)
+			cut = tag;
+		else {
+			string_list_append(&keys_uniq, var);
+			continue;
+		}
+
+		strbuf_add(&sb, var, cut - var);
+		string_list_append(&keys_uniq, sb.buf);
+		strbuf_release(&sb);
+	}
+	string_list_sort_u(&keys_uniq, 0);
+	for_each_string_list_item(item, &keys_uniq)
+		puts(item->string);
+	string_list_clear(&keys_uniq, 0);
+}
+
 static void list_config_help(enum show_config_type type)
 {
 	struct slot_expansion slot_expansions[] = {
@@ -129,8 +207,6 @@ static void list_config_help(enum show_config_type type)
 	const char **p;
 	struct slot_expansion *e;
 	struct string_list keys = STRING_LIST_INIT_DUP;
-	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
@@ -156,50 +232,20 @@ static void list_config_help(enum show_config_type type)
 			BUG("slot_expansion %s.%s is not used",
 			    e->prefix, e->placeholder);
 
-	string_list_sort(&keys);
-	for (size_t i = 0; i < keys.nr; i++) {
-		const char *var = keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
-
-		switch (type) {
-		case SHOW_CONFIG_HUMAN:
-			puts(var);
-			continue;
-		case SHOW_CONFIG_SECTIONS:
-			dot = strchr(var, '.');
-			break;
-		case SHOW_CONFIG_VARS:
-			break;
-		}
-		wildcard = strchr(var, '*');
-		tag = strchr(var, '<');
-
-		if (!dot && !wildcard && !tag) {
-			string_list_append(&keys_uniq, var);
-			continue;
-		}
-
-		if (dot)
-			cut = dot;
-		else if (wildcard && !tag)
-			cut = wildcard;
-		else if (!wildcard && tag)
-			cut = tag;
-		else
-			cut = wildcard < tag ? wildcard : tag;
-
-		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
-
+	switch (type) {
+	case SHOW_CONFIG_HUMAN:
+		show_config_human(&keys);
+		break;
+	case SHOW_CONFIG_SECTIONS:
+		show_config_sections(&keys);
+		break;
+	case SHOW_CONFIG_VARS:
+		show_config_vars(&keys);
+		break;
+	default:
+		BUG("%d: unexpected type", type);
 	}
 	string_list_clear(&keys, 0);
-	string_list_remove_duplicates(&keys_uniq, 0);
-	for_each_string_list_item(item, &keys_uniq)
-		puts(item->string);
-	string_list_clear(&keys_uniq, 0);
 }
 
 static enum help_format parse_help_format(const char *format)
-- 
2.52.0

