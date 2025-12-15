Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DC328243
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832218; cv=none; b=eLHJBie65Niux6i3KfH2gtDL97p0HWJ0RZwnWvM3e5HK7AL7ZoceenGT6cU8HYxb5mfktP4XbnFQler6d9EuYlOTj29tKTcfbzlribo1UW6F0nmfiKnXRRuPSDtwP3lZXPVT0K5o8mAzGfpnEt77iUafhrGoB1a0AzzT0JKEG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832218; c=relaxed/simple;
	bh=uszpbeFwT5KqODoB0DarhDtuXCYAwNF0x+iwMZDyunk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i33Y05EUJr3wD6hMgPwcmNaJnMzKa2dNxLbbRCuxhh4c11yhzcePgvuBJqx2Vbk/BoFEkkBRKlw3ItCuiFx0YGgPEFs7lQDNFNbgvljQoS3e0XD4AwFZh+FpEvumOCkncB7ZTBCHyz0SJq1jUyQDyjYBhcZxCEA/KeDn6KUXI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUNPF6kx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUNPF6kx"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c7503c73b4so2248711a34.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832215; x=1766437015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id1uHXlqTXPOvNG/VLbcSaZtR1KSp+b7V9PXTyz7KHA=;
        b=FUNPF6kxDoEAfo8eeE7AYQDy9ffDbvUWtql7tlfcwH4X8cql7lI+Wqc1CZPMnyLTd+
         3EOXG8tiQmeDXeMzJFmxEtQVLAGqKdEy0gLD3WAnzwSCzc+5hAENduVtV8bHsnEzXJ6a
         V6wAqbBI09ov3ucwuocMfLDmGkj8u+hcV/MgkFFS1K1lE4llYrzQrdHk1+mp/BFKvHvP
         x8Lk62kdlL58BGQJyKSUPilrDK3/N2R8Dt5c0mrf6Dpy2pf7DrVP+o16XgaEvsjvKcBx
         Z4nMCp2HAmTG5mIk3Dkh2sHtt+P29i2/uOiv3cORaGjAlujP9uZDAdYHKW/PkJRAL84l
         l1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832215; x=1766437015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=id1uHXlqTXPOvNG/VLbcSaZtR1KSp+b7V9PXTyz7KHA=;
        b=ULN/djnXigZ43n4Ct8gv0eUo9S7mejT3zAJTJk+xApQiV8h4xuBQ0QbJXR+naPT6DD
         PQ95PjSMyuxDRF488gL5+ks0NHb2Fn33mftYcduhOz3kGHa1R4DLnAS307W95Xj4tY3S
         YV0mckVj4zbd4EtCWu+zqqVXz47Gw6L5LMs27tlqJWg2k4bUhLEUxq6sJEeO8HeubuiH
         1wqrpL91dDGy3wgm7ApegcwV2zu2r0HE/9UOXrLxZY9fomwG5eaj+XT1/dec3b2TMqkn
         QFCECu/3Vjxq65hz5qQBEwLVdmLRiVE9mggtE1CEFTehYUz0mQ4rvJEIDeA+jLrIp0v3
         KnZw==
X-Gm-Message-State: AOJu0Yw14ceNknAphN2yoS7Pj+j2iMK6QLP/u3R3XgZUfgGn9GkQMayl
	jS/7R4aEd/fNiNHghkVS7t06pPFuueFLrMf1Ie1CmCnRvPm/SdY0pWLE0jAgdw==
X-Gm-Gg: AY/fxX7SEeoNLKSmEYp6Tp2i9lWGUbgV2q3QZ8BZX3GgCOgSq/TcIP2ZYRgGPAhx3k/
	5NryeRMDSRaQDi5quDmjCTINIbADQkhol+l0t659xYxTYVDBLEubU2ZrS7P+UhvRuLSHeG8ncsk
	f7DzvuhL0hjIJ6fh/zFLS5N2MsDP18q8LyO3u5/kMMFGrypesf8UWVEljDRtXaTwqo+BmOn+wyZ
	yw9geAcnoq1AVgyIGXjr5Sn7O+TONycf1hTz124nqJ1Svm69IdetmThd9KEIGOPuTzgNwVOu3ff
	KGyiqwhiO6sNcEqmYUZPgNHy6xFoehOVnKxE6g+OuC/GDImRjlN7bXi+OpIGiwxVmdsO2kSEGzv
	tJWElOreUNtc61zr2uhqg53ju8vfuF8o/zSWoTS2kjweOivqnXPDkpSHirRcy0rSeL3zOOwwWQx
	50SpK5AjjG6idV61ivlHA=
X-Google-Smtp-Source: AGHT+IFuo2FNjPuwpX2uzRMsqyW2JkPZ1Opjs1yL/1t/Oz2mRB0kHgjm+O4jU6aKKxUkeAJLo3Q/aw==
X-Received: by 2002:a05:6820:1891:b0:65b:33ec:1bb3 with SMTP id 006d021491bc7-65b452c8e62mr5808326eaf.80.1765832215457;
        Mon, 15 Dec 2025 12:56:55 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:54 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/7] builtin/repo: humanise count values in structure output
Date: Mon, 15 Dec 2025 14:56:35 -0600
Message-ID: <20251215205639.2700270-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table output format for the git-repo(1) structure subcommand is used
by default and intended to provide output to users in a human-friendly
manner. When the reference/object count values in a repository are
large, it becomes more cumbersome for users to read the values.

For larger values, update the table output format to instead produce
more human-friendly count values that are scaled down with the
appropriate unit prefix. Output for the keyvalue and nul formats remains
unchanged.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 38 +++++++++++++++++-------
 strbuf.c                  | 23 +++++++++++++++
 strbuf.h                  |  6 ++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++--------------------
 4 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a69699857a..9c61bc3e17 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -223,6 +223,7 @@ struct stats_table {
 
 	int name_col_width;
 	int value_col_width;
+	int unit_col_width;
 };
 
 /*
@@ -230,6 +231,7 @@ struct stats_table {
  */
 struct stats_table_entry {
 	char *value;
+	const char *unit;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -250,11 +252,18 @@ static void stats_table_vaddf(struct stats_table *table,
 
 	if (name_width > table->name_col_width)
 		table->name_col_width = name_width;
-	if (entry) {
+	if (!entry)
+		return;
+	if (entry->value) {
 		int value_width = utf8_strwidth(entry->value);
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
+	if (entry->unit) {
+		int unit_width = utf8_strwidth(entry->unit);
+		if (unit_width > table->unit_col_width)
+			table->unit_col_width = unit_width;
+	}
 }
 
 static void stats_table_addf(struct stats_table *table, const char *format, ...)
@@ -273,7 +282,7 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
-	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+	humanise_count(value, &entry->value, &entry->unit);
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -324,20 +333,24 @@ static void stats_table_print_structure(const struct stats_table *table)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
-	int name_col_width = utf8_strwidth(name_col_title);
-	int value_col_width = utf8_strwidth(value_col_title);
+	int title_name_width = utf8_strwidth(name_col_title);
+	int title_value_width = utf8_strwidth(value_col_title);
+	int name_col_width = table->name_col_width;
+	int value_col_width = table->value_col_width;
+	int unit_col_width = table->unit_col_width;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (table->name_col_width > name_col_width)
-		name_col_width = table->name_col_width;
-	if (table->value_col_width > value_col_width)
-		value_col_width = table->value_col_width;
+	if (title_name_width > name_col_width)
+		name_col_width = title_name_width;
+	if (title_value_width > value_col_width + unit_col_width + 1)
+		value_col_width = title_value_width - unit_col_width;
 
 	strbuf_addstr(&buf, "| ");
 	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
 	strbuf_addstr(&buf, " | ");
-	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
+	strbuf_utf8_align(&buf, ALIGN_LEFT,
+			  value_col_width + unit_col_width + 1, value_col_title);
 	strbuf_addstr(&buf, " |");
 	printf("%s\n", buf.buf);
 
@@ -345,17 +358,20 @@ static void stats_table_print_structure(const struct stats_table *table)
 	for (int i = 0; i < name_col_width; i++)
 		putchar('-');
 	printf(" | ");
-	for (int i = 0; i < value_col_width; i++)
+	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
 		putchar('-');
 	printf(" |\n");
 
 	for_each_string_list_item(item, &table->rows) {
 		struct stats_table_entry *entry = item->util;
 		const char *value = "";
+		const char *unit = "";
 
 		if (entry) {
 			struct stats_table_entry *entry = item->util;
 			value = entry->value;
+			if (entry->unit)
+				unit = entry->unit;
 		}
 
 		strbuf_reset(&buf);
@@ -363,6 +379,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
 		strbuf_addstr(&buf, " | ");
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addch(&buf, ' ');
+		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
 		strbuf_addstr(&buf, " |");
 		printf("%s\n", buf.buf);
 	}
diff --git a/strbuf.c b/strbuf.c
index bb8e98872f..662edd4d19 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,6 +836,29 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
+void humanise_count(size_t count, char **value, const char **unit)
+{
+	if (count >= 1000000000) {
+		size_t x = count + 5000000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
+				 (unsigned)(x % 1000000000 / 10000000));
+		*unit = _("G");
+	} else if (count >= 1000000) {
+		size_t x = count + 5000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
+				 (unsigned)(x % 1000000 / 10000));
+		*unit = _("M");
+	} else if (count >= 1000) {
+		size_t x = count + 5; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
+				 (unsigned)(x % 1000 / 10));
+		*unit = _("k");
+	} else {
+		*value = xstrfmt(_("%u"), (unsigned)count);
+		*unit = NULL;
+	}
+}
+
 void humanise_bytes(off_t bytes, char **value, const char **unit,
 		    unsigned flags)
 {
diff --git a/strbuf.h b/strbuf.h
index 4426163e7e..571bd889df 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -381,6 +381,12 @@ enum humanise_flags {
 void humanise_bytes(off_t bytes, char **value, const char **unit,
 		    unsigned flags);
 
+/**
+ * Converts the given count into a downscaled human-readable value and
+ * corresponding unit prefix as two separate strings.
+ */
+void humanise_count(size_t count, char **value, const char **unit);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..55fd13ad1b 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -10,21 +10,21 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository structure | Value |
-		| -------------------- | ----- |
-		| * References         |       |
-		|   * Count            |     0 |
-		|     * Branches       |     0 |
-		|     * Tags           |     0 |
-		|     * Remotes        |     0 |
-		|     * Others         |     0 |
-		|                      |       |
-		| * Reachable objects  |       |
-		|   * Count            |     0 |
-		|     * Commits        |     0 |
-		|     * Trees          |     0 |
-		|     * Blobs          |     0 |
-		|     * Tags           |     0 |
+		| Repository structure | Value  |
+		| -------------------- | ------ |
+		| * References         |        |
+		|   * Count            |     0  |
+		|     * Branches       |     0  |
+		|     * Tags           |     0  |
+		|     * Remotes        |     0  |
+		|     * Others         |     0  |
+		|                      |        |
+		| * Reachable objects  |        |
+		|   * Count            |     0  |
+		|     * Commits        |     0  |
+		|     * Trees          |     0  |
+		|     * Blobs          |     0  |
+		|     * Tags           |     0  |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -39,7 +39,7 @@ test_expect_success 'repository with references and objects' '
 	git init repo &&
 	(
 		cd repo &&
-		test_commit_bulk 42 &&
+		test_commit_bulk 1005 &&
 		git tag -a foo -m bar &&
 
 		oid="$(git rev-parse HEAD)" &&
@@ -49,21 +49,21 @@ test_expect_success 'repository with references and objects' '
 		git notes add -m foo &&
 
 		cat >expect <<-\EOF &&
-		| Repository structure | Value |
-		| -------------------- | ----- |
-		| * References         |       |
-		|   * Count            |     4 |
-		|     * Branches       |     1 |
-		|     * Tags           |     1 |
-		|     * Remotes        |     1 |
-		|     * Others         |     1 |
-		|                      |       |
-		| * Reachable objects  |       |
-		|   * Count            |   130 |
-		|     * Commits        |    43 |
-		|     * Trees          |    43 |
-		|     * Blobs          |    43 |
-		|     * Tags           |     1 |
+		| Repository structure | Value  |
+		| -------------------- | ------ |
+		| * References         |        |
+		|   * Count            |    4   |
+		|     * Branches       |    1   |
+		|     * Tags           |    1   |
+		|     * Remotes        |    1   |
+		|     * Others         |    1   |
+		|                      |        |
+		| * Reachable objects  |        |
+		|   * Count            | 3.02 k |
+		|     * Commits        | 1.01 k |
+		|     * Trees          | 1.01 k |
+		|     * Blobs          | 1.01 k |
+		|     * Tags           |    1   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

