Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F13EBF02
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449603; cv=none; b=Y3MrgU2mYaWfGWz+sV4iGzvPFw/GpMIu30a3U/UPQjFSj6upR3j5zmrPXaMlnA8uzVDPGWlKdvpMpHKQ/7Bee0apUnNiC13qOvovMfODd2SjXw04WmA6hXI3o3m3JmHDTiG85SVRmuPiBSBqf5yzkBj8dSeJvu8/WbsGAYkz4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449603; c=relaxed/simple;
	bh=6WP2/wAnioUy3lGsYBLjwBAhn/XWs98hqpAm4BukuZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ut/KCIhBp7V+fQfMvm6grjpo6Qt1TFQeDb6rn6fiHOSmMwF25XPB2TCN52503jJu3fNjN7LQaixnCEN6ErBIdL55kIihSm+qQG0loJNzgM34Cq6YR9smo4EgOHwUqDHSzg0AI8ZPu1H+gztJIhjABteFfS10n7udIpaw/wkn9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeUlIYmr; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeUlIYmr"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948a076d6ecso94749241.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449600; x=1772054400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+rQ2NraRxzDD7CVTf98RHYEQ8UwGcQpmiXy4iyWViM=;
        b=IeUlIYmro2gTn/YlqvqOxXiEZwMU4cCCFjXXwBG1zHmlJ9C4gDUjoORMK4cITFZgrn
         nbd55oc3UfSsRZURF87a5SnRZzkEf4O5/CBsQKiZvD1ZaDCvOn7xIjzHdZkjpWCbVN4k
         qMUDtBdCb+FoOBoxzj7LjcCjQUfK7vkXPyiNObG7+EOQnWDvr2XOuXVIf7ogjrwGPQlo
         232hqeClqu0wmZWFScFvtSTFusnttgUqViFrnwZm4DpvDC32i40bs7tK/LsW2UO4E7RS
         psTXZVr2q8BQA/zdm54iBEAdJ02UwwSx4tvftPACt+qMwl1m8ExkQCJdg1cYcatxflpL
         sQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449600; x=1772054400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+rQ2NraRxzDD7CVTf98RHYEQ8UwGcQpmiXy4iyWViM=;
        b=gXj+1k5Jw89nBFB/pIdCMYj8CT18tY9IIMjV218C+p5oNirWTaod4TkB3OkiojwuBt
         zeUzMYQ6hstyFXbQfF6ShnlaBZC3sg3Vy3PJlD08tZvQ6GihSDbzOF99qhkktvHFuGxq
         0NzzTkLMGs6VlKJU1wc7B3OdQAgJEmUXENtYjvsi8KxaAyQApp7KwzI/xdIaewyuVoFV
         At9g1RChe8sfMYlnvmPdeY4GEAEKt0P3A2J6CyGa/v0vd72eRDnsSZ2Ok0fRW0ktB2Pz
         vvbSnv93+4NWWqTWVIABjn/Qgvk/p4HY2RdrYkLk/3YRagUS4YL5t5hv3tqmwFDo0Zs+
         1Tlw==
X-Gm-Message-State: AOJu0Yz31J++w52U5WhMxVckrFr7L8ZxU0MTVNdHqAVjWPR5i2vGRBMP
	q139n23pbAvlJoKKfvQ66zHY20MthuE89Yz4FwO9RtLIrKXJ5iaiC3EkNOiv6Q==
X-Gm-Gg: AZuq6aJ0UxJLxHdGkpg5uYOSMc5ixj1APAfTSZpYC2u3XK69ZG5OsWvNcJLTtGCZ4f7
	nL4BBXkGIM2bs9SYeyvDEc+YmP0ruQihyawr8AFJMffCA/MYbqrh3rGOeKb5LfzeEbiWfgSMFyM
	nSuHoKlS6LOD9acW2fMbR0Jh5IgH9BXHzWYynURHQSvh36is4h/1XaS0fLvXzhfnYiG9i7XtYLw
	+v/T+g1uGbRzoPmNAcZ1jzt9l5GkH6Tpl8H3w0L2xOZOpmAwZu4CzWty6asdF3tKS/0uPHQD9D9
	KowLv3GmzciC3nxSWPJ/4nFe3xoQf54ZgcaptLhcaXMB5Llx39GkYEY0FfEXRWmVuDn7lM8lebF
	h8DQZW3fHjnTuDkL31JsYtG1QLTw3ClLlP0gHZGawKLoIqcpwGT9Zwf5zbJqgQn46P68bx/Rhlq
	FMzWwaDH8bMhVjC2fDnpWSBcw+EPZ0bq7jY5x2DFZKEC27GEOaULO8ZabeS6V28FTC9A==
X-Received: by 2002:a05:6102:6ca:b0:5f5:4837:8a36 with SMTP id ada2fe7eead31-5fe2aa2ad3fmr4879055137.0.1771449600342;
        Wed, 18 Feb 2026 13:20:00 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.19.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:19:59 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 2/8] repo: rename repo_info_fields to repo_info_field
Date: Wed, 18 Feb 2026 18:08:38 -0300
Message-ID: <20260218211845.96009-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename repo_info_fields as repo_info_field, following the CodingGuidelines rule
for naming arrays in singular. Rename all the references to that array
accordingly.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 6a62a6020a..aa9a154cd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -62,15 +62,15 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
-/* repo_info_fields keys must be in lexicographical order */
-static const struct field repo_info_fields[] = {
+/* repo_info_field keys must be in lexicographical order */
+static const struct field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
 	{ "references.format", get_references_format },
 };
 
-static int repo_info_fields_cmp(const void *va, const void *vb)
+static int repo_info_field_cmp(const void *va, const void *vb)
 {
 	const struct field *a = va;
 	const struct field *b = vb;
@@ -81,10 +81,10 @@ static int repo_info_fields_cmp(const void *va, const void *vb)
 static get_value_fn *get_value_fn_for_key(const char *key)
 {
 	const struct field search_key = { key, NULL };
-	const struct field *found = bsearch(&search_key, repo_info_fields,
-					    ARRAY_SIZE(repo_info_fields),
+	const struct field *found = bsearch(&search_key, repo_info_field,
+					    ARRAY_SIZE(repo_info_field),
 					    sizeof(*found),
-					    repo_info_fields_cmp);
+					    repo_info_field_cmp);
 	return found ? found->get_value : NULL;
 }
 
@@ -137,8 +137,8 @@ static int print_all_fields(struct repository *repo,
 {
 	struct strbuf valbuf = STRBUF_INIT;
 
-	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
-		const struct field *field = &repo_info_fields[i];
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_field); i++) {
+		const struct field *field = &repo_info_field[i];
 
 		strbuf_reset(&valbuf);
 		field->get_value(repo, &valbuf);
@@ -164,8 +164,8 @@ static int print_keys(enum output_format format)
 		die(_("--keys can only be used with --format=lines or --format=nul"));
 	}
 
-	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
-		const struct field *field = &repo_info_fields[i];
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_field); i++) {
+		const struct field *field = &repo_info_field[i];
 		printf("%s%c", field->key, sep);
 	}
 
-- 
2.50.1 (Apple Git-155)

