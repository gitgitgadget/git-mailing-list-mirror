Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB5B672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690984; cv=none; b=mzW8KU4RYFdZfekWM9way/46sGcZ4MzxG33msMIxnFBqp8hhfaJ0BUNBpuypkz1j3LLz+zEHOgSqBZuL5xpDiQTmBDCRjAzmeYY+8cXkRpCJIwgxYock66YH2B453SIcZyFiM5FQb8643SKYfOLJyw2St/TT0UHQsFrHaxLEcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690984; c=relaxed/simple;
	bh=TN0ojrp51zqW8J7rcXXPeqm6uE/5AYYbdqolMrCvvkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrPtJst0LeLUcKsE+t1GrOvDM/8PoiQvWYF3pI/KS/zULDUS+3C3/AUhLdKkxKasbQ2XY7JqJNj2QVEUMrBwnb2WPjmKM3NWFjW1NGymeybSkQAB6gU5yM0pTLVnlGNDP5OEqkISFkVrk6SC4MKPOfscRbDeb+PLxqL0WmcuZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkBn8Sw9; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkBn8Sw9"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso5218742a91.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690982; x=1740295782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBMa0nrONzmcDM9DptX3HzWPQVgDnRV/Ho2DYLmhzzs=;
        b=ZkBn8Sw9QAO7diKw4waqiRud5X3FVroPDjB6gcX6ayOj6bQjIzUt+haZ48ENRQFxOr
         nz0Jolb1qtPyik+gKBe+/W6tLNFUaexmP+mSBmeubBSY4H4Pf3z4VVAsqkamtMwMu/Qz
         dVSKG9rMqzgvL8VgLKsLA2fpzMR83NWqGeD6e/MevqRVfpNIkda0w/MbPwHL+vOjizA1
         ODVxTWG8YLVF9EyeQ8v3U26l2QpgvQMpnDrnQg7dfmfkmy9+sw4ZkTIaHmIhFwsH39ZZ
         2kyJ84so8Psopva7s1EX1JyfyYoIHX5ZDReCm50NGEccxXDypIuFErLb0UWhEjOs4plB
         8/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690982; x=1740295782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBMa0nrONzmcDM9DptX3HzWPQVgDnRV/Ho2DYLmhzzs=;
        b=K6l6RHuGFTkm4S7EslCIhrOil8fez44rHKeLKhG6JtQDaLJKUQ+JP53uZcJ2fphTmv
         M3X+7OY40BfBTrizq9G2VFxI2JJptmFXPwdemO0YkWx5xjGhunuU5dqP9Bv+xfE2wlTu
         E219tZRTgyF0cFBI+1Pre32lxDVuBIMzVHPd/rC4BdPweKtANGgtWf1cxQlAPC10kRJb
         Vc79BPgkVpXzK2jPd8creK5I0+/AZeCv2PXTqzt47Dozn+iB6PgnMW3wCg5VWJ87V5pZ
         2id3Sgs19HBxkJt3qUBmigzJLJQ261Pg61yOIyYTJSF91WIXbmq4izjtD/L8P6SoeRso
         4Fow==
X-Gm-Message-State: AOJu0YxXed5VOhfwPhgpgVNdvjcIh8mIS/YIRYrFhO/Wzsokri9uA42L
	kD++2CwsE8wf0mF5IgWdOuIzNPa59Axk1zfktbKANGWFfZicBgnv
X-Gm-Gg: ASbGncsmUuCKbYDN2A8BUWv2k0aFTSG1Ad/gi4qBjIbQksWK4ovnOmcsWS5vXaN2KSK
	00jzWb4wGNXyzWYsNAofioyaqO4uoNRSTDH25U0zV8hxyOmOsBoDDZIUkpb5At8gBYqH7YPRcD5
	FiNW0bVJe/gp2nfDRjbuZyRayRofQ6aoIvOnQ1ebNgZIb8mgWYwO2HCWimzBb987SInfTzYiXxi
	dtui6PDZG9F+Ro7qCp/Hk3frIrw5Mqvy8EwIDA9c98QKzqVUZtL/zpf0VGddsZC70RQJol5Uxvu
	PDrMVWE2wZNgtu9mDX8aLSwrgHTZckyevxhy1Vz2JrPPnqifJyxNXTJhYVBxQqZPlUvj9DFQzpe
	ZbkbJx+5BK0zWgd85nkBlt+I11uYI0/JsqQ==
X-Google-Smtp-Source: AGHT+IF9l6jxDC1Hw1uYA9LAFw4gysHgPAI0FFGCnYvNADlwzuvdyhSuCeknhWI2jB3XbVq3l7mFEg==
X-Received: by 2002:a17:90b:1e4e:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2fc0f97535cmr23712962a91.8.1739690981986;
        Sat, 15 Feb 2025 23:29:41 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:41 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 5/6] apply: use `size_t` loop counters
Date: Sun, 16 Feb 2025 07:28:42 +0000
Message-ID: <20250216072843.72385-6-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some `int` loop counters trigger -Wsign-comparison warnings.

Use `size_t` loop counters.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/apply.c b/apply.c
index c554a52f28..4c26f608ee 100644
--- a/apply.c
+++ b/apply.c
@@ -1371,12 +1371,11 @@ int parse_git_diff_header(struct strbuf *root,
 			{ "index ", gitdiff_index },
 			{ "", gitdiff_unrecognized },
 		};
-		int i;
 
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			break;
-		for (i = 0; i < ARRAY_SIZE(optable); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
 			int oplen = strlen(p->str);
 			int res;
@@ -2097,7 +2096,6 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2107,7 +2105,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < state->limit_by_name.nr; i++) {
+	for (size_t i = 0; i < state->limit_by_name.nr; i++) {
 		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0))
 			return (it->util != NULL);
@@ -2183,8 +2181,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
-			for (i = 0; binhdr[i]; i++) {
+			for (size_t i = 0; binhdr[i]; i++) {
 				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
@@ -2320,7 +2317,7 @@ static void update_pre_post_images(struct image *preimage,
 {
 	struct image fixed_preimage = IMAGE_INIT;
 	size_t insert_pos = 0;
-	int i, reduced;
+	int reduced;
 	size_t ctx;
 	const char *fixed;
 
@@ -2330,7 +2327,7 @@ static void update_pre_post_images(struct image *preimage,
 	 * free "oldlines".
 	 */
 	image_prepare(&fixed_preimage, buf, len, 1);
-	for (i = 0; i < fixed_preimage.line_nr; i++)
+	for (size_t i = 0; i < fixed_preimage.line_nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
 	image_clear(preimage);
 	*preimage = fixed_preimage;
@@ -2339,7 +2336,7 @@ static void update_pre_post_images(struct image *preimage,
 	/*
 	 * Adjust the common context lines in postimage.
 	 */
-	for (i = reduced = ctx = 0; i < postimage->line_nr; i++) {
+	for (size_t i = reduced = ctx = 0; i < postimage->line_nr; i++) {
 		size_t l_len = postimage->line[i].len;
 
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
@@ -2421,7 +2418,7 @@ static int line_by_line_fuzzy_match(struct image *img,
 				    int current_lno,
 				    size_t preimage_limit)
 {
-	int i;
+	size_t i;
 	size_t imgoff = 0;
 	size_t preoff = 0;
 	size_t extra_chars;
@@ -2488,7 +2485,7 @@ static int match_fragment(struct apply_state *state,
 			  unsigned ws_rule,
 			  int match_beginning, int match_end)
 {
-	int i;
+	size_t i;
 	const char *orig, *target;
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
@@ -2665,12 +2662,11 @@ static int match_fragment(struct apply_state *state,
 	for ( ; i < preimage->line_nr; i++) {
 		size_t fixstart = fixed.len; /* start of the fixed preimage */
 		size_t oldlen = preimage->line[i].len;
-		int j;
 
 		/* Try fixing the line in the preimage */
 		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
 
-		for (j = fixstart; j < fixed.len; j++) {
+		for (size_t j = fixstart; j < fixed.len; j++) {
 			if (!isspace(fixed.buf[j])) {
 				ret = 0;
 				goto out;
@@ -2800,7 +2796,7 @@ static void update_image(struct apply_state *state,
 	 * remove the copy of preimage at offset in img
 	 * and replace it with postimage
 	 */
-	int i, nr;
+	int nr;
 	size_t remove_count, insert_count, applied_at = 0;
 	size_t result_alloc;
 	char *result;
@@ -2819,11 +2815,11 @@ static void update_image(struct apply_state *state,
 	if (preimage_limit > img->line_nr - applied_pos)
 		preimage_limit = img->line_nr - applied_pos;
 
-	for (i = 0; i < applied_pos; i++)
+	for (size_t i = 0; i < applied_pos; i++)
 		applied_at += img->line[i].len;
 
 	remove_count = 0;
-	for (i = 0; i < preimage_limit; i++)
+	for (size_t i = 0; i < preimage_limit; i++)
 		remove_count += img->line[applied_pos + i].len;
 	insert_count = postimage->buf.len;
 
@@ -2852,7 +2848,7 @@ static void update_image(struct apply_state *state,
 			   img->line_nr - (applied_pos + preimage_limit));
 	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->line_nr);
 	if (!state->allow_overlap)
-		for (i = 0; i < postimage->line_nr; i++)
+		for (size_t i = 0; i < postimage->line_nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->line_nr = nr;
 }
-- 
2.43.0

