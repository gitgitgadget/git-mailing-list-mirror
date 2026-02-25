Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83025198A17
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978861; cv=none; b=O1raI9D9ER2eec5Lq8wmEA4PtxTUJef1HBpJUopi7Zniu23H8Gf5zCyec1eAciMzSsAjxV41iXB5gNRpx7DVKete5TmkiHKFbXg36r301qAlCvIJeARajiykJ9C8NnoUZHxbUqDppisJYJQZDMEPb3s08rmqGU/p/jakDorcy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978861; c=relaxed/simple;
	bh=WTDp2v3PGV4EL0POoURvul3hjpcVMBvPpR1wqq13e/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejK7j38dBi13yXV6A6WXuSLAWExsCmi1dW4x0uUH3on+kC5NsnWLl+DAPErGxo6s0EAufp9iahpJCOilTqw85E9dPvKP5jS9RcJrwvv8FIkRGDWwniE5UU6ysW3mSkOXIxd4FYMAVAzKeT91RxJ882tJ9/11naOo07xjzAowruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=h6e+ZQ/f; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="h6e+ZQ/f"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50334dd44d2so72743931cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978859; x=1772583659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4j4y0ceQAlpQjGKy2p1uUs71NwIwAY2sgqbt/3FGj0=;
        b=h6e+ZQ/fIDjDm9Ze1XTUMCI587x46NNg0nsUdW2rJFwv7m5YKQdsvJ+k/6C7cwOZT+
         J/wYU5kpg93swYUA/GHqwJv1SVI8eWlH4P0DraKtGYUDOz0mA0dbDjDOsJtOhvIz1Q0y
         2pMZhxVckG78wCgWdcwSQji86jeHZIKfnHB+tKPF4l7H1aKnmgs/n7zCRIGWsBWjQyJN
         1iLdvkKVOungsyo0BfDPBwG8MSFRE6n3/ntssVKAG/0CGsVtT3tv89Suxh64uR1IjtId
         ChRgctcH979V0Qe1s98ZPQZtnqAfAFk+E0FFP1n/9BBwIGO70E2aU7RLFuJbBo+GhIK6
         auZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978859; x=1772583659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4j4y0ceQAlpQjGKy2p1uUs71NwIwAY2sgqbt/3FGj0=;
        b=koaQNmeM3OAQLDZY/j8A+8nHUF44/cX3SN7v36TSnnjn20H2Jv1Z74HI+xbc14HbHb
         lFRwJAqnv1vcoI2TeIhUIkIOViCGGFeT+dldIgDM5cHUzBWk73Mr/IHONR9usD1jwxTJ
         D4vf17zOzN9nFIgI40FLhTGt3Mfsqsd5FTyDryaeRPF2w+PQ6dLztaYl0uPphLtUt/gB
         FuWN+IzFQfp10Fnk4G2/CLiwkumNZax3Zzb2NOW9FYqqewbb6GxEHL/3NYTvLdr9s08O
         /cDCXLrh12Cr5zV1GpdOhSIpqfGTlEMumXbky4Q3l52DGbZDrgznLb1nIfsslwjzUAaC
         U1dw==
X-Gm-Message-State: AOJu0Yw/GimwrXTj31xx853Lo1gfZZlK0F/PcMZF3fwErFAWwL4BWJWW
	mrd+UHODNwdZPFRo4fEAjTgNrvFG02no7gXmlJx9UTC54I0RXth5dpmIvYE0jb33zFJY8Rrz97W
	P8XJmJIZbsw==
X-Gm-Gg: ATEYQzzvp1/pwXDBVvisKfZk7RM7Fn3L2wy9vp90vxbe/zOEJqWs4pQ1oTi1Wb+bvGc
	Rt/v0r7FNlMzzOQbw3gDJZEw/SHEKTRA+lO4ob9FI4iJRJP80Ix/mwbNqknbaq4IJ1jNNRm3KDH
	inSbgiwlvbhVhMufLZgM38th5uwB5r9ysJuyBpv26uR6Zr9uADkYT0Qbj18HnLjsf3Anec5U3Dm
	rMr4iO6vmGAY/1F2dykc9FnEqDtunDR5FFIlL3bFxGGpz1APNPFi79tMLaSt1sk2VrqO8YsxgQA
	0V4vsWRWLcDu1vaIzQ2Puzw3CBOgAI8ppqjkvN7hupmA3zZH2ACpY1ldo/9eiZvVSe3aDRycgCK
	OqbAzFUxFtcKR4dcvn75zgjUvGrMne1mI02DCRkHwbVnWpe048ZDrBGB4c0j1v9zE43u+xFvgKQ
	71/Ss1ojWlLyohd25BYA54z+hbeWvihD9+XyLre0fYx27BlmZFWoL/2wTSDpGQFr9cxc6/olEDr
	K+8JbZqTm7I9MgSXtdlY534BtZ1TQ==
X-Received: by 2002:a05:622a:1191:b0:4ee:24e8:c9ae with SMTP id d75a77b69052e-5073a324679mr7770971cf.53.1771978859218;
        Tue, 24 Feb 2026 16:20:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50cdcasm112575081cf.6.2026.02.24.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:20:58 -0800 (PST)
Date: Tue, 24 Feb 2026 19:20:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 01/14] midx: use `string_list` for retained MIDX files
Message-ID: <d64a799afd620363c1940d7c2e634e78ea553cb6.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
build a list of filenames to keep while pruning stale MIDX files. Today
they hand-roll an array instead of using a `string_list`, thus requiring
us to pass an additional length parameter, and makes lookups linear.

Replace the bare array with a `string_list` which can be passed around
as a single parameter. Though it improves lookup performance, the
difference is likely immeasurable given how small the keep_hashes array
typically is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 56 ++++++++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/midx.c b/midx.c
index c1b9658240d..c5e3553e2bb 100644
--- a/midx.c
+++ b/midx.c
@@ -755,8 +755,7 @@ int midx_checksum_valid(struct multi_pack_index *m)
 }
 
 struct clear_midx_data {
-	char **keep;
-	uint32_t keep_nr;
+	struct string_list keep;
 	const char *ext;
 };
 
@@ -764,15 +763,12 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 				const char *file_name, void *_data)
 {
 	struct clear_midx_data *data = _data;
-	uint32_t i;
 
 	if (!(starts_with(file_name, "multi-pack-index-") &&
 	      ends_with(file_name, data->ext)))
 		return;
-	for (i = 0; i < data->keep_nr; i++) {
-		if (!strcmp(data->keep[i], file_name))
-			return;
-	}
+	if (string_list_has_string(&data->keep, file_name))
+		return;
 	if (unlink(full_path))
 		die_errno(_("failed to remove %s"), full_path);
 }
@@ -780,48 +776,40 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash)
 {
-	struct clear_midx_data data;
-	memset(&data, 0, sizeof(struct clear_midx_data));
-
-	if (keep_hash) {
-		ALLOC_ARRAY(data.keep, 1);
-
-		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
-		data.keep_nr = 1;
-	}
-	data.ext = ext;
-
-	for_each_file_in_pack_dir(source->path,
-				  clear_midx_file_ext,
-				  &data);
+	struct clear_midx_data data = {
+		.keep = STRING_LIST_INIT_NODUP,
+		.ext = ext,
+	};
 
 	if (keep_hash)
-		free(data.keep[0]);
-	free(data.keep);
+		string_list_insert(&data.keep, xstrfmt("multi-pack-index-%s.%s",
+						       keep_hash, ext));
+
+	for_each_file_in_pack_dir(source->path, clear_midx_file_ext, &data);
+
+	string_list_clear(&data.keep, 0);
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
 				      char **keep_hashes,
 				      uint32_t hashes_nr)
 {
-	struct clear_midx_data data;
+	struct clear_midx_data data = {
+		.keep = STRING_LIST_INIT_NODUP,
+		.ext = ext,
+	};
 	uint32_t i;
 
-	memset(&data, 0, sizeof(struct clear_midx_data));
-
-	ALLOC_ARRAY(data.keep, hashes_nr);
 	for (i = 0; i < hashes_nr; i++)
-		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
-				       ext);
-	data.keep_nr = hashes_nr;
-	data.ext = ext;
+		string_list_append(&data.keep,
+				   xstrfmt("multi-pack-index-%s.%s",
+					   keep_hashes[i], ext));
+	string_list_sort(&data.keep);
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
 
-	for (i = 0; i < hashes_nr; i++)
-		free(data.keep[i]);
-	free(data.keep);
+	string_list_clear(&data.keep, 0);
 }
 
 void clear_midx_file(struct repository *r)
-- 
2.53.0.185.g29bc4dff628

