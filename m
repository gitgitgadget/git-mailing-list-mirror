Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430B30F7F9
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567323; cv=none; b=XTCkyEtajUZrKKbSvkdHZz4l7MVmfxYu7ErN4mV5Z5htYuvv2LI+yYuvtUQOLFHae/PLYa9tZ3iAUfckTH/f6pucoK1zdW2K+yoHsVa6dKPNjn3f8o7faQrkNSuSjS83Nw+4YMp8dV6piO8c+dOg15PZLu9mqqCHkSe61UN3VdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567323; c=relaxed/simple;
	bh=dqNHhkjh1PdOFB/xTLwwJ9U4LYA9aC7sWM+St1UAfL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR6K9mPocDCa+mtjymH7yYR+V7J6+hrN763cCE1j1VtQEEfKUDfC5irzzHZ+yhfb7QTcz5ZAVcvh/AkT3LxUFXJxBfodZhnSw0Ru803HtSrL3sGfUwXrb07MisYQv0okIXH0A88Ypy2BZwQR1k//dQaFfUlbbe3j7QSI9NjHxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Nu+/qqii; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Nu+/qqii"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7815092cd22so846487b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567320; x=1761172120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycIv1tLhKqw87oI0f7ZMAjpnHzuFWiW+ZAj2VCA1nGQ=;
        b=Nu+/qqiigChDv25Coa4DEGftP7GGNq7Iwct6NtEpBZ6DhM3SiB+LXV1g3MIMbkBdVI
         A5AIVu2yJFIIvVHvVxb67087mNc7fgpM1WxmeoPz28FiQ8ix1QQkhkZUaSrfoZpBrT0R
         pOgHhthXj4+6zmCuNMUr3tchKGXokQtZFwCNo5K7VnfeMnucSLpQ91ArmejB7TPixFOF
         VSCpPr0Lu5O9ZLnoe/0NdLoKNp/YhIYhE8JYSiuxZ4tP1VVTPQ4qXOvn9jGi0b/Y7hBo
         iRHnpEcPHWaL9JmtabhmHT2RiVG5rKakAu5O9yvI5W9ZtpbYzCx8UEhEEY8pLHk12LR3
         c2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567320; x=1761172120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycIv1tLhKqw87oI0f7ZMAjpnHzuFWiW+ZAj2VCA1nGQ=;
        b=wOlS8M1AgA70ACXV0gYjagP53Tp6BPFd+SsgZbqFFlEB55lchWFygiaVhgQdvx5tHI
         WkI6h4x+AK3YiAzAcgSYdjppdI0pggOrX2amrS0Xx6LlcQVMmAj0j4zIsDju9xIh2D4V
         60VkFJiOAAQ05yIFjcKPJXg2sL5ujUYSrAMQtfjvibrFIWp8EFZ1HtlUciQe7tBN33hG
         G7wuKx+xk7T0Hl34vL8XwWwqESNjKKqHVxHygBbcmBCcJCQexLsD531E45Fxb61nHZM3
         csCBg5SYrw7Vw3207Ca+WGhwAGCdkeJ75eaOLE+S0/iah4dvslOh1RECiXKSxb/g+p1o
         BXuA==
X-Gm-Message-State: AOJu0YwbDSY1wY3v8nqNb9pFeupOhWZV4vsGHqSDbb+sFNj13L/WzS0H
	zUoB28cWFNIDMvhW1nCMZKRk3MUwa6eyKn6nyakaVdSsKkz0LY+uZDZtu3+bgirIO5VkqP4ughE
	NOa/2LfE/xg==
X-Gm-Gg: ASbGncvbzkqym7xMzdStcUBxkCwJFet8cwbMrab8UpF5ubBs6yXZVmBlNDWz8sM4AJn
	sGJ7BWHICPH0t46snZPQ45E4sm6xF69/e0AsHAZMhK+mBqkmkbw+ckfoYQP3XcvJhRH4elsVmX1
	EvxHa7aHy4R59n1Ye4xKxzv2b+opB3yv8lfZHRHWQVj+KzzZFAH/t/eY6G089syN4CBSAUSgIHY
	RcY0aOM4fojiWPsWxIr5yhxjRa1ZUvSNUttH3YKA1C6YcXpNeYr3Pnz0c5TdjzyARp2L0KBqfXb
	nzIMFWHb8ByfwZIYQDkUZ3C8qG+6FPIjjMkhEByj0Iwn4iZfQKlhcW0nyoySO5UqOr4TOEAwbUd
	pWo2uyK8a1AVssKY0S02P2ZETvKtaGdZaaHyStAL4dn3MfeuyylypY4C/D/ruBP4pIjVWM/vouv
	iFAjQZw0GbZ+xK9bNoEbt8Hqaed33jwVK5FZjbuU0lqALGWFnNAnQQz6UHl+Q5XGxC7NHtemnJx
	TnjVXeG2Sf8lU+ABw==
X-Google-Smtp-Source: AGHT+IHNXPMN4WVSfODOv6W6Kcq8OztI0vpWRi14yjU7k831hDcLO0W4NC4JuHaon+VNb5Q5Bjd4Iw==
X-Received: by 2002:a05:690c:998c:b0:731:76db:a5e0 with SMTP id 00721157ae682-780e15346dfmr354902807b3.25.1760567320006;
        Wed, 15 Oct 2025 15:28:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d2c2adesm2762697b3.14.2025.10.15.15.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <0b2fa0cf625caa3a31857295dfb237ca0c5192b7.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Rename functions which work with 'struct pack_geometry' to begin with
"pack_geometry_". While we're at it, change `free_pack_geometry()` to
instead be named `pack_geometry_release()` to match our conventions, and
make clear that that function frees the contents of the struct, not the
memory allocated to hold the struct itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 52 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 24b5e5049b..42f05d2ebf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -115,17 +115,17 @@ struct pack_geometry {
 	int split_factor;
 };
 
-static uint32_t geometry_pack_weight(struct packed_git *p)
+static uint32_t pack_geometry_weight(struct packed_git *p)
 {
 	if (open_pack_index(p))
 		die(_("cannot open index for %s"), p->pack_name);
 	return p->num_objects;
 }
 
-static int geometry_cmp(const void *va, const void *vb)
+static int pack_geometry_cmp(const void *va, const void *vb)
 {
-	uint32_t aw = geometry_pack_weight(*(struct packed_git **)va),
-		 bw = geometry_pack_weight(*(struct packed_git **)vb);
+	uint32_t aw = pack_geometry_weight(*(struct packed_git **)va),
+		 bw = pack_geometry_weight(*(struct packed_git **)vb);
 
 	if (aw < bw)
 		return -1;
@@ -134,7 +134,7 @@ static int geometry_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-static void init_pack_geometry(struct pack_geometry *geometry,
+static void pack_geometry_init(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
@@ -184,11 +184,11 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 		geometry->pack_nr++;
 	}
 
-	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
+	QSORT(geometry->pack, geometry->pack_nr, pack_geometry_cmp);
 	strbuf_release(&buf);
 }
 
-static void split_pack_geometry(struct pack_geometry *geometry)
+static void pack_geometry_split(struct pack_geometry *geometry)
 {
 	uint32_t i;
 	uint32_t split;
@@ -208,13 +208,13 @@ static void split_pack_geometry(struct pack_geometry *geometry)
 		struct packed_git *prev = geometry->pack[i - 1];
 
 		if (unsigned_mult_overflows(geometry->split_factor,
-					    geometry_pack_weight(prev)))
+					    pack_geometry_weight(prev)))
 			die(_("pack %s too large to consider in geometric "
 			      "progression"),
 			    prev->pack_name);
 
-		if (geometry_pack_weight(ours) <
-		    geometry->split_factor * geometry_pack_weight(prev))
+		if (pack_geometry_weight(ours) <
+		    geometry->split_factor * pack_geometry_weight(prev))
 			break;
 	}
 
@@ -242,9 +242,9 @@ static void split_pack_geometry(struct pack_geometry *geometry)
 	for (i = 0; i < split; i++) {
 		struct packed_git *p = geometry->pack[i];
 
-		if (unsigned_add_overflows(total_size, geometry_pack_weight(p)))
+		if (unsigned_add_overflows(total_size, pack_geometry_weight(p)))
 			die(_("pack %s too large to roll up"), p->pack_name);
-		total_size += geometry_pack_weight(p);
+		total_size += pack_geometry_weight(p);
 	}
 	for (i = split; i < geometry->pack_nr; i++) {
 		struct packed_git *ours = geometry->pack[i];
@@ -253,15 +253,15 @@ static void split_pack_geometry(struct pack_geometry *geometry)
 					    total_size))
 			die(_("pack %s too large to roll up"), ours->pack_name);
 
-		if (geometry_pack_weight(ours) <
+		if (pack_geometry_weight(ours) <
 		    geometry->split_factor * total_size) {
 			if (unsigned_add_overflows(total_size,
-						   geometry_pack_weight(ours)))
+						   pack_geometry_weight(ours)))
 				die(_("pack %s too large to roll up"),
 				    ours->pack_name);
 
 			split++;
-			total_size += geometry_pack_weight(ours);
+			total_size += pack_geometry_weight(ours);
 		} else
 			break;
 	}
@@ -269,7 +269,7 @@ static void split_pack_geometry(struct pack_geometry *geometry)
 	geometry->split = split;
 }
 
-static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
+static struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
 {
 	uint32_t i;
 
@@ -304,9 +304,9 @@ static struct packed_git *get_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
-static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
-					    struct string_list *names,
-					    struct existing_packs *existing)
+static void pack_geometry_remove_redundant(struct pack_geometry *geometry,
+					   struct string_list *names,
+					   struct existing_packs *existing)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
@@ -332,7 +332,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 	strbuf_release(&buf);
 }
 
-static void free_pack_geometry(struct pack_geometry *geometry)
+static void pack_geometry_release(struct pack_geometry *geometry)
 {
 	if (!geometry)
 		return;
@@ -599,7 +599,7 @@ static int write_midx_included_packs(struct string_list *include,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct packed_git *preferred = get_preferred_pack(geometry);
+	struct packed_git *preferred = pack_geometry_preferred_pack(geometry);
 	FILE *in;
 	int ret;
 
@@ -1063,8 +1063,8 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		init_pack_geometry(&geometry, &existing, &po_args);
-		split_pack_geometry(&geometry);
+		pack_geometry_init(&geometry, &existing, &po_args);
+		pack_geometry_split(&geometry);
 	}
 
 	prepare_pack_objects(&cmd, &po_args, packtmp);
@@ -1324,8 +1324,8 @@ int cmd_repack(int argc,
 		existing_packs_remove_redundant(&existing, packdir);
 
 		if (geometry.split_factor)
-			geometry_remove_redundant_packs(&geometry, &names,
-							&existing);
+			pack_geometry_remove_redundant(&geometry, &names,
+						       &existing);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
@@ -1352,7 +1352,7 @@ int cmd_repack(int argc,
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
-	free_pack_geometry(&geometry);
+	pack_geometry_release(&geometry);
 	for (size_t i = 0; i < midx_pack_names_nr; i++)
 		free(midx_pack_names[i]);
 	free(midx_pack_names);
-- 
2.51.0.540.ga7423965ad8

