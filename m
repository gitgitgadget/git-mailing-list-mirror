Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C7307AEB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567245; cv=none; b=pN9f21QybM301TlWbrFvy0V5jJI9MDHBGKA3YKMF9FFWT0KunzO1E52nWtIZeER+I8jaJT7ayuLaoIMaLsxoZhGQI7OOzGPPp2QF3z+UxzqAISvEnEwCIkX2sKPqoakcgSmAmzirb3CsANAQSKhxWfmM2x7bZaKU9FbGbU1GkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567245; c=relaxed/simple;
	bh=pVyeYb8CyCnJfw7oxBDv3uMHa9rHiX0aiLR+LRYRxo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=degdb4K8qVW0Ip0auyyjxbzzLi1mlooSX35vx2DO8hJUVjjkpVQGocU4hCv5EdPm1b2TVRFowMsoYInZH2cfUBfId1dwtviAKhEb/8x3Ag0pi8/B2ogmKGc1wqG0BHqflj+uk8Otnc7dX+jHplvU+hBHiu3If/c1pv/tJwQjaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=T6fG0ws3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="T6fG0ws3"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6014810fso1001187b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567243; x=1761172043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xG1bACiD8ShQlLghUU+bmYKZZCaFpuF6ehVwahWRhas=;
        b=T6fG0ws3lhvAf7hNtdAzW2OTGUTl/xbG33PIseOpr0v/IIZnhLUrmIqcUl58bwsrvt
         iPDAOfbA7wrjKiQ86fV3QHGpHZnw2enXihTVeLqzUp+/Qyexz9FgXBu7ExAMW3wNtH6E
         OHo0/vED5/MUIQf4KkdDeCCADGCA6RnLRQkJJ9TBHZkdSCwpu13BGpdlJrB8DXzqkj8m
         lAQSJoTPVAfmHdjRlhRzxUzXfAo/JBkWk9o78tWqSldDjqLoJ+sHDHLQJZSPkYf5TcTd
         ojlu4RSReSVuojs5fEXSh6J6Hq8KcRO0KvagbKgJ0mDQ1Bs/S2PbUg+IMZbcZxcTZltd
         VPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567243; x=1761172043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG1bACiD8ShQlLghUU+bmYKZZCaFpuF6ehVwahWRhas=;
        b=JWUF2ulowb2NZN8hkdX6IZLbU3KzBy35UJFb764HDXxC/qV8q3i3tefzjJge9rzZpx
         CATvitndtfsASBiTH7h9Wjc4UXmSSLZg0xXJtusw2mfKhuIk6LlcsDE1QstGKD4UYgKI
         31XGe4qJBVD6wN1wqU5/ZfERGYXMebpzjVgcqrKmbAQlWRe28TiyR9pMwBCj9oAhUhw2
         cextKui66xkYm7+Sgo4kPhcKcHoTP3O1XnYZAGqHzfop/iDmiFYdGub0JejSbAgfwgzj
         bzauCFkIQT1nL5zD/XvXOrVrOXLtr+U2A79IKUaLiRzt98ii4OM7macuW7N76AlTv+t6
         yj9g==
X-Gm-Message-State: AOJu0YzcO7I7PNWi+rEAC7vTE4kUpzQbe0C1PeL2W6hoynL5VAhMPlUB
	qWgzv/8HNGVSpMxhpzyPXpp0ikLmfDCaR6h1wk/7oDFzIl2MhUkHS3Kkhs7P58k8d6nfq4G8SJS
	qcni0vk+w+Q==
X-Gm-Gg: ASbGncuztJ/mG0wtMv229Yy/uE6xDd2D10ab+OEgVK2mZ8Vw+A4yiR3Li6B/VwlBwgS
	L1S38NnmG6ld6lkhIw+Hmy08/hJIZV/mRyWsjknS8HVhIh+MaU6LFmJ03Uqke3HRC/1GXnvxOUY
	McptIrCgxH/Ypq30JJ0WclyFVGri9dxdZNFZRfl5Imf4T7z3dO2IcLAT550Vwboc8J2R6Sst2Fq
	mNXia37Qg0gMZc93Q4Wc6jLbZFKWEXKar1Bdveuw7fryJDc4hyVtJ5hoGQSpWf21w8TOS6LcPT4
	N+iBSAB3B1qFNzJyV8NroufDvLb78mISk095TvblPQi79j1mRIJaPIutcwDSb/ht7U3LJBBGxov
	v+TrCDlvZJfQapBVNN2bbC86N6VTtv4idDzXuP8X6pgzqIBfYTN8H8+5ldSEXuxt7E1gKAVeKti
	7wnV7Lhhh4Crr6MhPGObNYzDoCEIu60e7kzFWeXzstN8NSRyRkly0CEok5r1NQmreJ6Wol3Nyya
	JHWGzw=
X-Google-Smtp-Source: AGHT+IGJpQs09u+oC9KIFGOLHrwtFxvJVsmQatn2py5cPAWhUeXt1QHMesmh8JTsalputMRlA+F3wA==
X-Received: by 2002:a05:690c:63c7:b0:781:64f:2b4d with SMTP id 00721157ae682-781064f3847mr216512337b3.60.1760567242735;
        Wed, 15 Oct 2025 15:27:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c12888sm2602077b3.31.2025.10.15.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/49] builtin/repack.c: avoid "the_repository" in
 existing packs API
Message-ID: <14a65d7c6dfde222c66eadc7af626456e428c249.1760567210.git.me@ttaylorr.com>
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

There are a number of spots within builtin/repack.c which refer to
"the_repository", and either make use of the "existing packs" API
or otherwise have a 'struct existing_packs *' in scope.

Add a "repo" member to "struct existing_packs" and use that instead of
"the_repository" in such locations.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 305782b2c9..7223553bed 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -126,6 +126,7 @@ static void pack_objects_args_release(struct pack_objects_args *args)
 }
 
 struct existing_packs {
+	struct repository *repo;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
@@ -265,7 +266,7 @@ static void existing_packs_release(struct existing_packs *existing)
 static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -498,7 +499,7 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -1139,7 +1140,7 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 				      struct existing_packs *existing)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
@@ -1405,6 +1406,7 @@ int cmd_repack(int argc,
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
+	existing.repo = repo;
 	collect_pack_filenames(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
-- 
2.51.0.540.ga7423965ad8

