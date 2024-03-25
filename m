Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5964CB37
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387491; cv=none; b=KE24spA4XudEPMmmXxBFzUEfXEa+Mm8FIbOftIX6jdU50o2zxLRNrxAeS1AFhJfrsOERJL8Iw7FjoICjTwXy/pFkh4pOaKqMoM41X/cT0HKTGt1XedPX16iESYo254WqUs06k1vT++y9wiPAI2Ngc3FHtXKNuG0R7QIc0CeRByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387491; c=relaxed/simple;
	bh=xg0PruKaEaEqkQjmTcDFrpBPTXLAiwvV+oS5nTC5gOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTmPxGFW+RjdN37lZfEFQxWZ/TiywabO8kBJVieX0jz2EIx6v9M5HPFMvlhaPBQRO6ZUPFiqRhBXtR3PjNqylJVswJQuHhEz7banb1RjcO6dvhrk6leVxdkBobzK4LD5Jp+r3yAYZbU7q3/A7OOjh9JPN3CeooLvc9wTYgKKzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gt/LMilv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gt/LMilv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6918781a913so39627216d6.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387489; x=1711992289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0zHbQ26JjkQbqKgeGn4MZMpeIOwh8ponXQG3Zeqq/Y=;
        b=gt/LMilv82Jv+ee2xTp8jKYSnLDiEppAxFnO9uI1Gpc3mIt5pnixJ12zQmNIEoitEP
         0NlbRhLfbH+lOkzhFF70ss9HIRW/pklIrJDQv54WK+V7B647EScklUGbLL0h5WbyuybE
         HphbE5sw54jlcW/LStOOqc403Aq9aa7QepNZjFwPF5h4mWmjsybGYyGo4DFGwJd46YJT
         cHO8RmvT9H6OAuCBYoQJ+b1rFD2H+xvN4SR+3hYS5oi6IhFEsaBlOusPkQwuNU3ehmNs
         8a6k0lVRnaJYAAJBtGDuykrFhgd3r10RSe3q/4szSyERkyXQIcH8ypdfXIsuBhYHULCC
         h7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387489; x=1711992289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0zHbQ26JjkQbqKgeGn4MZMpeIOwh8ponXQG3Zeqq/Y=;
        b=PdSfvRTgaPqPsu4h7Ij2fGR1eavgH5CzjyrdQ12Ah7v3Kx/e1dFu5bEQH8qonSFPm7
         Nq2IcVVXUVZa72xrbUZ3+hXK5dVCYt3sI0ZezaN9QAccXfe9NfFMFBGzNSqg5VDu0h1P
         P8tuaYJLtxr9X3ZwOMQo3FTiJoBn2RRezdG5v9WrloZX7iAkx3o27yQknntMZ8rS+XJG
         3mB/KATpLMwDnew6+wwUfGSylKuVMxXWE5kO4y5Dxnd8wXmJUTCgziwaiE9mdXjBI7z8
         OlStnKOz+b1Ri7q1XINsgo/GkvMz6OtZOhhAmncoJV6xbTEzcCbP3um0emg6iWJ8hgmn
         pmQA==
X-Gm-Message-State: AOJu0YxfkD70G5n6zH8QCVoHxooIhqGYHn1X/i8zcuUaglVoVjcfTT4Z
	Rv1QeNkBgNs/zxNjROyrKLbGzfYozxUAkpBMEL+GN0kO3dWw/U+RckItYsg2oIi7N6WX3o4ZC5d
	xkTA=
X-Google-Smtp-Source: AGHT+IG8nRqVmTICnyaAA/UJK0IJWHmsbAEoQQQmlPKwxooFxY8wFidcdAnCOl1WrpLuXOzw7kTZzg==
X-Received: by 2002:a05:6214:400a:b0:696:8b32:63f with SMTP id kd10-20020a056214400a00b006968b32063fmr4985058qvb.37.1711387488831;
        Mon, 25 Mar 2024 10:24:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id jl7-20020ad45e87000000b0068f35e9e9a2sm4303331qvb.8.2024.03.25.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:48 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/11] midx-write.c: check count of packs to repack after
 grouping
Message-ID: <f77e3167aad4b60c381cf1def2ee1eeb26218d06.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

In both fill_included_packs_all() and fill_included_packs_batch(), we
accumulate a list of packs whose contents we want to repack together,
and then use that information to feed a list of objects as input to
pack-objects.

In both cases, the `fill_included_packs_` functions keep track of how
many packs they want to repack together, and only execute pack-objects
if there are at least two packs that need repacking.

Having both of these functions keep track of this information themselves
is not strictly necessary, since they also log which packs to repack via
the `include_pack` array, so we can simply count the non-zero entries in
that array after either function is done executing, reducing the overall
amount of code necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 2f0f5d133f..4f1d649aa6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1367,11 +1367,11 @@ static int want_included_pack(struct repository *r,
 	return 1;
 }
 
-static int fill_included_packs_all(struct repository *r,
-				   struct multi_pack_index *m,
-				   unsigned char *include_pack)
+static void fill_included_packs_all(struct repository *r,
+				    struct multi_pack_index *m,
+				    unsigned char *include_pack)
 {
-	uint32_t i, count = 0;
+	uint32_t i;
 	int pack_kept_objects = 0;
 
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
@@ -1381,18 +1381,15 @@ static int fill_included_packs_all(struct repository *r,
 			continue;
 
 		include_pack[i] = 1;
-		count++;
 	}
-
-	return count < 2;
 }
 
-static int fill_included_packs_batch(struct repository *r,
-				     struct multi_pack_index *m,
-				     unsigned char *include_pack,
-				     size_t batch_size)
+static void fill_included_packs_batch(struct repository *r,
+				      struct multi_pack_index *m,
+				      unsigned char *include_pack,
+				      size_t batch_size)
 {
-	uint32_t i, packs_to_repack;
+	uint32_t i;
 	size_t total_size;
 	struct repack_info *pack_info;
 	int pack_kept_objects = 0;
@@ -1418,7 +1415,6 @@ static int fill_included_packs_batch(struct repository *r,
 	QSORT(pack_info, m->num_packs, compare_by_mtime);
 
 	total_size = 0;
-	packs_to_repack = 0;
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
 		int pack_int_id = pack_info[i].pack_int_id;
 		struct packed_git *p = m->packs[pack_int_id];
@@ -1434,23 +1430,17 @@ static int fill_included_packs_batch(struct repository *r,
 		if (expected_size >= batch_size)
 			continue;
 
-		packs_to_repack++;
 		total_size += expected_size;
 		include_pack[pack_int_id] = 1;
 	}
 
 	free(pack_info);
-
-	if (packs_to_repack < 2)
-		return 1;
-
-	return 0;
 }
 
 int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
-	uint32_t i;
+	uint32_t i, packs_to_repack = 0;
 	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
@@ -1469,10 +1459,16 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	CALLOC_ARRAY(include_pack, m->num_packs);
 
-	if (batch_size) {
-		if (fill_included_packs_batch(r, m, include_pack, batch_size))
-			goto cleanup;
-	} else if (fill_included_packs_all(r, m, include_pack))
+	if (batch_size)
+		fill_included_packs_batch(r, m, include_pack, batch_size);
+	else
+		fill_included_packs_all(r, m, include_pack);
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (include_pack[i])
+			packs_to_repack++;
+	}
+	if (packs_to_repack <= 1)
 		goto cleanup;
 
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
-- 
2.44.0.290.g736be63234b

