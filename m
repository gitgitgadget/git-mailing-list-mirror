Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFC284B50
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097339; cv=none; b=BUGie074ILGf6B9q+i491gxyB4zemA5eEwuFqzBO1i/55aB7B6JLTKmUem4qtjl6peSfwFuRwFl4e2u0iIAMMdIwFbGjybn/OgeV4ENRlta2wC8Kkb1zz/HJk6zRq8H+FqOSP+wQ/alPUH6bkXZ/BsS61BdiFFCbV9t0VEZz588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097339; c=relaxed/simple;
	bh=vf1gNrRjgV0HDSCwhtENojD6BcbYIBxm7r2VQe9r0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG6Lrn5V+2GhkEc7BZnWtIMJN5Xiroew6Yf1xZWW6XNYt0A9kmRE4ocFs9/1X+2Ma+ZrejRLnOZFjwpRx3IhyFRtR4q7KJR/qJ8X8ynntxbnqpqVeo5XdhSghAEGPEYrB/7NBeRXV7t2FDAq2D7LUGMmluRemgtvpPjKDR2C6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=h09WG0iL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="h09WG0iL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60501806so42591797b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097337; x=1759702137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vz3dem4GQ2q/jlEvRBqXfpT512LtjrLInCRAEZKdbyM=;
        b=h09WG0iL7w3cjsZ1Bs9Usb3BDRFTwr5HvLrLlDtEQcBYsZxZfSE32MuGn2b1sd1kaO
         bclDw5ZEvK3w3HJC6RcNEy8nO5DK9v2TYDv23KmV9nDusgMwefuWfIhfPiq5p871vI/7
         8LIsJtvea7N2dccheP+9hUk1yiTaJQ6Ynb+XRrRXbrnnTTZ3cO2OYkC1XrMaQpMgPTqF
         UResmd/oMkZjtfdo0SLS/7pYP0Jx3WF2x6UqBpY6trzMjPJ7P/omJzS9hn2DwhqW/Ts9
         lELIOTeqCr2lUgSVKFcaxG5gjKn56KFr0Jp9oGED9CaNZ3yJ2HM4eBgS9Z2VoCyjhH/D
         w5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097337; x=1759702137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz3dem4GQ2q/jlEvRBqXfpT512LtjrLInCRAEZKdbyM=;
        b=e53F2A7UA277HLbE7r9RCkUt5/kVnUfuNGMG7vT2Xczo9pKReS8IuOpjdLj9W6zgDV
         ubCMEffRZrJgTPqtx/eYL6/Kq7xY4IPy4pjizrttp/O3EJfEfIFRx8jGjfi3rlOYajfc
         NtwOHpWWBli9pJ2IRpDBpRhxIHX4m8ePyN6TG0wRkcd8x1B0rxPW+uGPqz5584VlT8o+
         d46bgB2QAaCGkCaZFxhOdSdirMeFrTTN0ssCqB64tRqpRgnwjulbK7aGHXAcf6FdprwK
         w4KlR9HmSPDwnF2m9QnVL3dAC8uwBYCZzb/W8qiUYyhqANmxJjKkXCiuEbAl54rlnLZw
         LTSw==
X-Gm-Message-State: AOJu0YyDjlijHoqnF+Blx797sXvcBHZ1POxgJC35JzMDw9339VQJdSfx
	PPqIZA0EuUEVQWXvZPIztSN9eWJPEzXCBeJH2YGXSVLzKpb1I6qFBpYsLOtGNqu2iPeuhcQxMqd
	dVr8ZIdRWWw==
X-Gm-Gg: ASbGncu4I+w9Wuo3VODjfPoYZUDbag4kVB8+b11Zdmn7NQA6ZQodegh8JJU5NGd2MLJ
	HJpC+yiHYi5/AsRWrAcGKt3D4qlm6wXxLgUtxo0IIwKjbuReza5m8xmQmCzjmJpPApK6Jh4VhDD
	/hLBu0EjWE7jZJcXSMyMpXQExmHAXnWf9e0HdpbskBox0hMNjoskCbEbGHrT/O5pbUxoRgFLMX8
	YPxkZEFVaAjFHIhemunvyFNg1e+pw0GdNhF+TEUgp3fVW9ag4tweFHUjFurWhi8oI82+Oj0U+ol
	L+8A9jTyizhgWyzJ45gClDeifsveaJ1JWc7NR50kFVyDFLys/3R9hBOPMk/vdNRUFToaaSU1x+s
	bscTJNtRMRuEn8wlNY07IPT32h7w1k9JasvDP9Cpdk9ycOdAT4fSLHj2ikcl8aiQWVpD4nq+ioo
	J0pKOrldCZBpBII+sdcSC6kdfR2Q==
X-Google-Smtp-Source: AGHT+IHznXomeVekqv1zu/c8/SH/wNQ01jRKnq0WO2WA/2Y/A6GhZTLICQ2YS6wcc8Nv9GQStIdwDg==
X-Received: by 2002:a05:690c:9992:b0:77c:afc9:9d40 with SMTP id 00721157ae682-77cafc9bb3bmr19635337b3.4.1759097337158;
        Sun, 28 Sep 2025 15:08:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765c60b7a41sm22687677b3.35.2025.09.28.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:56 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Rename functions which work with 'struct pack_geometry' to begin with
"pack_geometry_".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 52 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 18c3df7200..2ce1ae3364 100644
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
2.51.0.243.g16eca91f2c0

