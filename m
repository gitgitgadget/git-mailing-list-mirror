Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34A33890B
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906761; cv=none; b=bCkxl1rBrJ5NEBNqmpAdj8vFHMrb/N0csTYzs8NaelxZManoFfO1QYyTybFI14pdOns6P+i8B+Pnu5fEhQ76fsMvzHcj8k1DVGOCWGWVsXUkvktSRQStHWOQOSJYcaGXDzpEoDt0lZI6P0e5s6r7vqvnq9MSxyDJ44ygVrUBzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906761; c=relaxed/simple;
	bh=pWf0TR+8DVovkwqw+Ku/lcDxGE/apt4eJjk83s8Ygb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc2x5F70enebfOZsuDk4yyE1QJ0b1FDFN84C4aXFwyUv/cs1lE4xoeymBrH7S0iXDzy37jnbyc2a2qSZ0480aq+qJ1r4c9a9TgkGJekGdMOXCTo+PrxmAwwUimvNBZEI8TA/TbvOwOsrJh56F/Au/uqmuuc56V5Ib4cfMw3fvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN61hRRr; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN61hRRr"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso3495575fac.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906758; x=1766511558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIkmrO3C5gj1uP/vi+rN9HbqxwDGviAGtmvV1opisnY=;
        b=LN61hRRrZkgTPFmEA/MbCnlGd9GpXZ7XLTL1eFYhrSCnDG5zK2aifJqwJy0AHO3FQ+
         RQDVO9xOd947yhL6KToI6lFBHtedJu7DL3AgruJjce/MmNqZsmsicc8NZ5kB/lRNuiNe
         r+3q4hWJrY7PFS8dbOs8asiQWGMdReEiNElHclrQo30fiV56o50zbrfU/4duZ9DWA6Vn
         ms4YNRmTBOHF/1UinlHW+d00dhzaQHFkn5u1ulAC8jYnatXlJT6+gnKmYnmqIjKDDnGp
         TbEQa99Mqw8cuZBqaRrtqk1bYRLR28lxBrAckYClN7RI6Y8wkD3KwVccBfQxTsFQ1Az8
         57KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906758; x=1766511558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yIkmrO3C5gj1uP/vi+rN9HbqxwDGviAGtmvV1opisnY=;
        b=Eq/6qzrsVAh3IEPBmsquyJ9AXNGlqS15KlWokWgzrcSZztnUWLnoo037WlhYujmlYr
         OH6U/AtpEP102K4Qi2da2bexFqKwWKayR3ncYpH8oBkToPG/BRRa6+JceU3+qJGDjKhr
         VQctdErJLjv81AtQk8KGrGxVNAkBnkiNkQ5dUx6bJD7mshS8QpYweN5OrDB0zoQF6fXw
         S8MUIkxFnRBOER8ADKAB5LdXz51SiYNR8hGa8FE4Od/nf9vksGRU6IUtQ6GVazKrTF7/
         1K0OzGhbGj34wVP2eYzRV6vWBAxdGc4DXSxwS8Dmc8jcyhihExGiIS6If3pD/jBErQOv
         sN/g==
X-Gm-Message-State: AOJu0YxbRcaC2Z48BiokmGm+0JftG0vbAers8OOXljddF6CT94YfkOB5
	Cpebta3S9ZJAqE8zNl1ZsH86lrzRqA8wTj8r4f7woitCN51dF9jCckgwYvPdbA==
X-Gm-Gg: AY/fxX7rJhgYw6P9QQqSS9DtNuMfzqhbCoqMt5IQNAOgPL1EuWtX57cY4lsWz7//sh1
	vkUXL0mSyHY12R14yGNK7Bk6nDLoXGgRpQbHnEiC9X0luie5vGIhTWyDMk6P7bcD948/fr5OPbn
	Dd8S0Y0ZR5sLcC34iMhc33TWF9tpyCIhRvxy3swtZ2D4yRMfSPHjhdmKyGHYyZ2onSBAxm58u6c
	y9ZlpGXSkulpUmVzyCVBn0jUN/m6DP+DRIzayyZNctocw1VJo9vwXsFW6nbq7i3WH3PSVbUsCXa
	7jUOWQfArYFrpAu0fHFprL5eHdFf0iBbQL+gZurO323R3SahiTU1wx5GULs7OcluA1XtbqClj6B
	PGv4liBSvLm6t1y4jhRHPFVYXnlz8/ABrRTyCxCzOyB6/myGzUAQhI4MWDTP7FarzTP/XOyxuxR
	e54HOyMRPzIpocK5SZEEo=
X-Google-Smtp-Source: AGHT+IHA5nGu6fdIx+CXGFcWrgUtbu9Ncfu8Hr9Utou/Pmc71WX0ku/ntnVbXWB5U6pTjDnuYGxAMg==
X-Received: by 2002:a05:6871:5b08:b0:3f5:ae31:f06e with SMTP id 586e51a60fabf-3f5f8d5fb70mr7795554fac.36.1765906756748;
        Tue, 16 Dec 2025 09:39:16 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:16 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/7] builtin/repo: humanise count values in structure output
Date: Tue, 16 Dec 2025 11:38:38 -0600
Message-ID: <20251216173842.3357832-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
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
 strbuf.c                  | 26 ++++++++++++++++
 strbuf.h                  |  6 ++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++--------------------
 4 files changed, 91 insertions(+), 41 deletions(-)

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
index 3fbd375ad6..9beebad5b9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,6 +836,32 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
+void humanise_count(size_t count, char **value, const char **unit)
+{
+	if (count >= 1000000000) {
+		size_t x = count + 5000000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
+				 (unsigned)(x % 1000000000 / 10000000));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^9 */
+		*unit = _("G");
+	} else if (count >= 1000000) {
+		size_t x = count + 5000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
+				 (unsigned)(x % 1000000 / 10000));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^6 */
+		*unit = _("M");
+	} else if (count >= 1000) {
+		size_t x = count + 5; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
+				 (unsigned)(x % 1000 / 10));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^3 */
+		*unit = _("k");
+	} else {
+		*value = xstrfmt("%u", (unsigned)count);
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

