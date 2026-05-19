Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1633BBAD
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206266; cv=none; b=M8Uimvnq3/fzkf7gXw7AOMqyRdow3HFXwLMNN44D/xEEPbsbIjk9kRX+kRlb5qyOXFvkPGTSyoEMkrJAgWioHZxnDyq9g+fOw9Yg0v2YHllMdUR68YPdkleL+S97du7bK93/LaX01Uj07Y4/T4nrLWy13DuSB6hNjoqEPGZRR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206266; c=relaxed/simple;
	bh=/uf9vfQ5YRE1X9VhzQs0RaDaIgByW4KZTU2t8pNrGUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZbXQarqTJ1LT6J8RTxlT4m74roo8d8Cmp3eL8e+Pj32+qJ3pinN1amEqIRNZOgn25ZNh6kBR7zI98AEy9ICDPJ+Lo6VCqA5dQI6Ey/rgX3ozcNeEWlZUqqEYqW//taUrakYcNAIgUXJohIXqIqvoXKJKsxrGNX43T8W7MsXX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=opQva8fj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="opQva8fj"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bf1eaba464so32202927b3.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206264; x=1779811064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEywRDRY1mzm+aI1AgFb07CJSWZMv/pbdDgSKcM/SPs=;
        b=opQva8fjJkVWvCHtGjVkcFanyGCiUFtqVKYKlTkdiGBg/oUvVA3N5vfZRQtR2jt/ZG
         J7+ZpMMRtCgimKztzIp52QQZJcLhCadAr4osw/HQcHgtS2R0LcUAWl8EqNqBRCoEQBUo
         eExnsCcbxqfvSZI01ij/+84VdHLYA1xIQGbjej+eECsFebF9X6lDWOXTSK8SuZbGmOKv
         KO4Ppd2uI2wFF6v5efeVDIPDmiZsOyA64FG4kzRzoHOOFw0831K0Di6y0SpbqSa1tA34
         aqEsQxdosiHv38zcQxrZv0q7lhCn0iT53XoBHf26Pl46OAaPbpiWdAajcIQ2/DXT6pIb
         M0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206264; x=1779811064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEywRDRY1mzm+aI1AgFb07CJSWZMv/pbdDgSKcM/SPs=;
        b=EB9zB4PWzMq/3h316slgQBZdMUsQH/Qhljh30LcnFXkNaUIwPCRad7CbOETU8TO41B
         Ahex0R6krS2kQtTng5ohLhhmsatyG0Hyk41hAgvl8DmY9EErzdXwkU41u2XH+0Q7IVzJ
         KkcagRR9TTYUvVRwLhTKA6BIvZURswLPnfyNi6xaVoOwB9bPtjjRMXFkvfQhCj9h+4Z0
         EqshrXo5DOi5Y3gnlzSB70d3LrhYAckKVBh6IeukLpr0n89MMJ3eJjF5kJyiZ7Vyn8qT
         uctBjG4hSIfmcabdDlopL52bn0ot445BLWfaHqSL18qZZBNLaF85uxVABr47zryJPNMD
         HzSA==
X-Gm-Message-State: AOJu0YygaBDMiulPVLb/EtYWsFgxlX3ncBaRAzo6rcUaaZXbDkiWTDA0
	F1unj5XDTVW3PkhiwIRCyPUs3a2Y5PHFAq4a4xWr4TZbGDXPnAp4Gtglc+hJcCenyvLamMxZbuD
	dhpBtsu7s1w==
X-Gm-Gg: Acq92OH94UZEWpv5Mt9NPhBS3cIFeeQtuftF4IIOBSsk5XD1hpZvdLmV432MaPkuHfA
	J2MXEG0PzZBgvPGcDWR/45vB813iMzPJgPEDI+KOQYyz5pGEJbBqojv/2GNXj/fUq6Ji2qYXtOY
	54tPzdlRqXz5O9AOxpTefEDcdTFi6dQxsC14WSmmVjr+X5tfB9Uw+SsXo8UF2cZryfBgZS4/Lwq
	VR2UiS67xkDuidaaX2BZeSmOrAdsYCwbY256Rsv9Kvnh/Jd+KnscwVnp37fpsmjYD1KtUQxy3K+
	AZGyAADlQMDc1w0GsNsrW5tJ3C78jZIRwsm9sJchCwdVgAp1hE3FSLgVz7cFTPGdBMx2b+MT+vH
	YIS1vBZeijlUTNw68FWKGePEtiuHXLJwa+pFVA/7xpzA1DxbQ9I9QM/m2WYZiWw4Tmsp0qMT8Vq
	EUojeh3AoXXwqndDcHK73d/Kmed54gr6wYZ5rQpLDd9MUEGWHhaxnAvJAeWaurtuYLQ3OzA+KZy
	xRr8R2wiRW+mxta4npFjelpQVkHmNpsM7sXIDsHFolj+XVSH8qmO6qDQX6l9cthQBjHMgvheyPv
	EkjEo8GYqe7yzFOS
X-Received: by 2002:a05:690e:169d:b0:65e:42b5:fe22 with SMTP id 956f58d0204a3-65e42b601f3mr12488576d50.55.1779206263999;
        Tue, 19 May 2026 08:57:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991ca758sm38856097b3.5.2026.05.19.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:43 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 02/16] midx: use `strset` for retained MIDX files
Message-ID: <ece55bf29579cddd5a245ce01c142d7ad49768a3.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
build a list of filenames to keep while pruning stale MIDX files. Today
they hand-roll an array instead of using a `strset`, thus requiring us
to pass an additional length parameter, and makes lookups linear.

Replace the bare array with a `strset` which can be passed around as a
single parameter. Though it improves lookup performance, the difference
is likely immeasurable given how small the keep_hashes array typically
is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 57 +++++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/midx.c b/midx.c
index 81d6ab11e6e..f75e3c9fa6d 100644
--- a/midx.c
+++ b/midx.c
@@ -758,8 +758,7 @@ int midx_checksum_valid(struct multi_pack_index *m)
 }
 
 struct clear_midx_data {
-	char **keep;
-	uint32_t keep_nr;
+	struct strset keep;
 	const char *ext;
 };
 
@@ -767,15 +766,12 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
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
+	if (strset_contains(&data->keep, file_name))
+		return;
 	if (unlink(full_path))
 		die_errno(_("failed to remove %s"), full_path);
 }
@@ -783,48 +779,49 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash)
 {
-	struct clear_midx_data data;
-	memset(&data, 0, sizeof(struct clear_midx_data));
+	struct clear_midx_data data = {
+		.keep = STRSET_INIT,
+		.ext = ext,
+	};
 
 	if (keep_hash) {
-		ALLOC_ARRAY(data.keep, 1);
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hash, ext);
 
-		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
-		data.keep_nr = 1;
+		strset_add(&data.keep, buf.buf);
+
+		strbuf_release(&buf);
 	}
-	data.ext = ext;
 
-	for_each_file_in_pack_dir(source->path,
-				  clear_midx_file_ext,
-				  &data);
+	for_each_file_in_pack_dir(source->path, clear_midx_file_ext, &data);
 
-	if (keep_hash)
-		free(data.keep[0]);
-	free(data.keep);
+	strset_clear(&data.keep);
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
 				      char **keep_hashes,
 				      uint32_t hashes_nr)
 {
-	struct clear_midx_data data;
+	struct clear_midx_data data = {
+		.keep = STRSET_INIT,
+		.ext = ext,
+	};
+	struct strbuf buf = STRBUF_INIT;
 	uint32_t i;
 
-	memset(&data, 0, sizeof(struct clear_midx_data));
+	for (i = 0; i < hashes_nr; i++) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
+			    ext);
 
-	ALLOC_ARRAY(data.keep, hashes_nr);
-	for (i = 0; i < hashes_nr; i++)
-		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
-				       ext);
-	data.keep_nr = hashes_nr;
-	data.ext = ext;
+		strset_add(&data.keep, buf.buf);
+	}
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
 
-	for (i = 0; i < hashes_nr; i++)
-		free(data.keep[i]);
-	free(data.keep);
+	strbuf_release(&buf);
+	strset_clear(&data.keep);
 }
 
 void clear_midx_file(struct repository *r)
-- 
2.54.0.175.g8bd0ec98dc3

