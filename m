Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1F18C2C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507995; cv=none; b=oOoUPEMB3O5rlbtdKs9L935PGDFxvqQ9hjK6bEWb1xdbeOpehvWOwk7SV8FKkaBFMqhwQ5klNabW+Mv20sLI9o0jkqRAMc4s8tXngLaGq8B5pS3J9+0Nemwwgc3M5XLrc1zqN4oL6p8y2m28cRYJ1PKGUxt/96U7vDRV1G+ckDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507995; c=relaxed/simple;
	bh=5BmVB9I+0A5j0CdIjrFyHxcEfgfjq8BF2c0+JpkggtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdhcF/92JZTX5QkuWIqYV1+1KybaM0a3Wbft1ZeXavuDLG2hGNLVWTLeJ6JfFwBPk49XMQ9zsam0GQ30jR0bJPEZL/5rXM9HpglJc9qdmn3mjB5LnDfOQUKsNfEQvVhuIjB3mqvlKFQ/sDaflDzs96cVBKjLAc6CfpwasQ+o1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NdO6vOiq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NdO6vOiq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a74765703so2995017b3.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777507992; x=1778112792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdr7a8EYH9Rw4niUfVGGtpMvmt4FKRvhoEBRCR/TXv0=;
        b=NdO6vOiqRIqljen1bQmjPvxe3MkKxHzD/YuoYXX/njdjCbsHvxRyLpvJZnAk9tM4Ln
         8eaz+BlZaxQmw5Hr9jJfmZsWGR2DIhjUEm9pPVleeYarWgUBPPnu0FZjizcNAGtiUEeX
         G6Rmez1qIyLup7YpWZ6tgjvIybtI7mUpNxz8520sGGd4sQbkoWp4DdPP0Rk5dHU9Baob
         vzKAhZ5hwIjzSYIC3hia4vGJMk3JqiPjmBpcIZzj6YXmuI+FFGzskB1oSHpnWIQ+1MPj
         AQ8LmSRMtc0wpJTjpPpbKnDGw2SoSPh8m+ikEj5jMfgiiizJX4zkJDBh5CZRvgdveGx5
         DzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507992; x=1778112792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wdr7a8EYH9Rw4niUfVGGtpMvmt4FKRvhoEBRCR/TXv0=;
        b=PwewIBVunK+j5MZHlikqyhDb8ott2jxYVrUkfMCTRjZ0s1OBVFRvi02LvjvN4Q/ZCI
         ZcDDzzSyfD6UrIJsQW1uOaXyePVNADGGTy+8NBa6q/gVxjJFFMddpnA0DgNEBAxwKpdI
         WIo9dOtQy7yqBHC7D6MpRvqXrkJwsDdxwbR2ab1qYAJsgT+YmyITgGKbrrIawC0cGE68
         CSKaNh4vnBiffiB7F4ePc1fYFnb/U8JwJ0TGfQvg8Qf863D0mdh8t07/z7syoVuUQ22n
         HNH+yxGRFtM4WbyZXZVU6s/Oi4Yno1yxrum+XfjSizHbqGcAn7alFeYjDX0tHbLGOQNm
         7rHQ==
X-Gm-Message-State: AOJu0YwJyiWEEw9O899vglMAuIjAbq3NNf41q7pa+rRSxlmLFiQrB/NH
	tqhLb0/Qj/6ZrOJf1lZCjO27yLvYRrgiJLU8K1USa07x+M2HMEZ3LR7AoJh/bvu3Immn+ZZUUBa
	Ytq4+RqBP4w==
X-Gm-Gg: AeBDietvBY+L87FGiHZ2QY2MbXkElWWz940ikFfanSkoLtdL+KfH+RxPOZCGKam3YGG
	ARQ04XFPaKjWyIF6vrXC0fBnXJgo4E/lMN9yTZaV/BILlLcMXNVYfc3XJUnladZAoBNVftD+Ian
	kOjTKc7An/pkZ6zFn5prIZZ8eJJcwmFGkIkevXNS1PhpynrsQtJh38yT+JK1ToywOdf+XzH3dDK
	1qAyivXN/P+31VQHP5aj446Vfn8J2J9GKPfnw3dibG5M04zfVTk99GCXdAWu0Bz0ZjytA5y5993
	2vpudKhrgDaUFvyal5lgH+7oznXO+KVpmVfYm7MXutCuNUAGN56U59bvy1EkHmPWgTQLGjMeBOx
	PIy/HVFH1dKL6okY36KGpu3fL4GKec0d4ek6nqSykkmUMtScd3OEweD4mdOhlTNzkSuFhYR74DL
	H7LvxlIQYdBpM7atXzNmcgHnxHCdQcqkctic019CwVwbiRxFnmEMbs+l9KRUbhkAKcTyxr0jBhG
	rUgRFvkfpisuLjhlcVIvbxAzPCcGEYqA/DSFPDhKEoVkQ8phMCcpngz8mN72IvEZ00meRFLciFn
	dS208Mu+v8ApCo6FDO2pAUKDBHg=
X-Received: by 2002:a05:690c:e3cf:b0:7b6:f4f:f06a with SMTP id 00721157ae682-7bd52833bbdmr10359347b3.6.1777507992534;
        Wed, 29 Apr 2026 17:13:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5500d83fsm1452677b3.30.2026.04.29.17.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 02/16] midx: use `strset` for retained MIDX files
Message-ID: <629c8d2311647fdde69cc56d946cdd957fa8c16e.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

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
2.54.0.16.g1c05dfce579

