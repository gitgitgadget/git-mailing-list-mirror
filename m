Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DC3E9F7B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044625; cv=none; b=jtcYptVTJojkpWvn34rP3BGcOue3cnEDtPywilM4yuGJ926ZCyFn2wRt1D6+uR+NZ77N2Tb469D4TlrQ0tpOZZfmMWS+eFr3HSTv6bXvMrndnSlueI7P2pbAP7hOcjS1BtmT1zwQFZYtmt58Z1GHi67O6OhgjTKvWYtj3qCGixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044625; c=relaxed/simple;
	bh=6WP2/wAnioUy3lGsYBLjwBAhn/XWs98hqpAm4BukuZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i90Fg/KOzvz4MCwjta66N3Jbbl1cqqoJMn8duumqSEU1INHBxA+b+0X577xLm3Rl0o7rFEDoefp3Pm1sVPt9S2eTKwa5TBPxKrC1aTNbeGZ0sN9+470tTZeeUlZK7P+QPT7CTGGzIgQFJJE6FYw+8QH1bxShPvQ/29WkXgpr7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQbhGn0j; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQbhGn0j"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94de63dea9aso16243241.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044623; x=1772649423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+rQ2NraRxzDD7CVTf98RHYEQ8UwGcQpmiXy4iyWViM=;
        b=BQbhGn0j6Y0/dseW3zentkqZR1oprocsCs9n2l32DjHtIuQHqx6dw5yXjufXf3Y7Xq
         ijSRgqzyGLioCd7Aozjt9TfPygV4pgcNm0xEKiJudT/CBZeY0GRaK0LhfQAzi2tFQsWJ
         b3cq7MMVN8WAhAWUxMh6+S82725MZjo2WbbBqGIcJBC+azew5BIZm/6exqx1tkRyqbkK
         raTnvaG/Wdq6pXYoZAgz9KdwRCa09/OFD2Sxwl9PEL9Z5xACAcohDGd5aqkLwOgEc0+1
         0hc0/YqOK8oloRvyr0y52qIe+SOZC9d07JwcDDV3o9cvEvyqOv18kWFW+d6baMrOAj85
         2LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044623; x=1772649423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+rQ2NraRxzDD7CVTf98RHYEQ8UwGcQpmiXy4iyWViM=;
        b=LWOFdcmcrjdny3Kkr8zFCAI3ND+IRND/5A+WA91w8+h2xBwedghAC9sPxSOQgVH41P
         uw6BiVG6PYv3AMOsmfgV0kDNNW/u7uxRXgS/DRpoEnQz6dGUKHFP0nOuJh4TRrQUFkz3
         Q61sSSi8p5QjaiI5Haq7MYJvVY8eapVieNIL80O5pOt5Hl8wbv8oFJL5fHvSAjrAOtfa
         s9Wr2N1gyCbHNqBRobho5z3smhuVEBTxr3do4SBKp2p6+Bh3Cv84FiLj1ZGNy1wE17c1
         thcrlYOh1L0Rw6zCoXevb/Vih5UjTaHrU0Q6llDHNd8Y4idh+C6VNCXc7hkptCAMZ5RU
         XsWw==
X-Gm-Message-State: AOJu0Yy292Uc3bUfXL+v8URHVvdofge0xNlAuyFd6Boj0FRzFWJjbYps
	sxLigzdORXjyL0aVpt5J0OMeZDG8QTBbwzyzymGfU5Uh8Nn2G1qlED9TXRGUoA==
X-Gm-Gg: ATEYQzxWAf2M2T3nkeo370pQuVk01bjvlXB1dQfs9hmb3Ky88PxHP5DL07ARzQ+ydEV
	GJnaPRafPMDjmottXL4JBtMG1aEROzvkKbRhtT43/EflhenR4VJ7KfIDLbNLwekAtsDA4OM4iTF
	oN9/BsF0S4Xrmvbp64llGo4MuNUbZ8SL6jLoGtYwahuqDec2R3vGgCs3uUJFZwP11D36gG52c7y
	X2tqyDlkfUEa4xc1pxdLe2fXPr5nNnOPMvco6z8CfFy3Qx+rwQ6bp5UBs2fNNk37qsH5umgQXe9
	DCe6FYuVVVAXp/UxQ/iBMWMelNWpznUsxJayMMTqtnWc9f+sUDZyyGRXB9zCOzDuPkcgd6miUer
	j2r09DgQdzxatCtr1HXAvqWoxu7eEiGhQbyqk0Z0thlGWLKkn1jRKJuHieJwhrUJyLzW3S8S5uc
	v6eQLCUUKTIu+gN7N7QnXGTACtWJHh8eagE+2JhXxUmakY4S9kQnr6O6999p2t
X-Received: by 2002:a05:6102:3048:b0:5f9:3ac6:2015 with SMTP id ada2fe7eead31-5feb2f167f8mr7864857137.14.1772044622604;
        Wed, 25 Feb 2026 10:37:02 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.36.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:02 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 2/8] repo: rename repo_info_fields to repo_info_field
Date: Wed, 25 Feb 2026 13:32:11 -0300
Message-ID: <20260225183559.79303-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
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

