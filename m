Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A73446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803841; cv=none; b=JUB4jVp7CFfIjVIcNzT0x7c/GBxCGPJvX2l1RXMkaTrkmj9HmyAB4dfaSjdujY0240M7sdoXfxu81NjSyAUruqZ8DGOskMYQ6/4gkTAM6XWgEUt2O7q3P3y9IbjdGsIU+cv9JigLgxkRQibkp8xg8bk0N/0S6iLv5nhN4hDKe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803841; c=relaxed/simple;
	bh=Zdpn+q8bn/7BbK175S6bppHr0V1lVppVoxbp/5nyMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZib74CIcPzuaF+Swz9UzDfq957b9yBq86GBAO+URZrRxbCiToHFycFK8PFHqJpzaaqjU3d3e/8a1ZL9cvqfSxg95Ny78PA32dAnYldKiH57POYdTVamGkVV1iqjdPQZYk6UKfNHvgxok69AIW3d9WOOvs9HJecraUNo9kbrjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OHzQRnck; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OHzQRnck"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45f053b7b90so2678771b6e.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803839; x=1777408639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2SnN3n/yNMhnBrHrfZHl+zYeg9X8pH8QsSYMifEjbQ=;
        b=OHzQRnckejGtv/Yl59UQlMWK3ta7UGoon93fz0o3A5uq7NEw2nCFyF7hFtXym0Wj4/
         UqNBP8CFwqck0R8NEoNcZY7SyzFfgYfnyXs0+rV6B9Wuy+PyXYzjYryXpbGes17ZMDZ0
         +56WfjZr7mp5PpdhwAJRz4Ue2gwBWvP6ejbBBp8yE2jd8OnZU/qoWJdR8Evm9I+N+yZW
         qjMikoYoZTAdei+NhhbD/lF0+CLH9YOvCqmsuvy/e6ZR0Hs7d60wCkq7WipVJDLAJXIm
         zrgIgf7yAA7+lv2itRFNla1z0szdGW4orPuk2PMfcayAT6lc5wE5Zd6gzDkh+7PU8yqj
         uzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803839; x=1777408639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2SnN3n/yNMhnBrHrfZHl+zYeg9X8pH8QsSYMifEjbQ=;
        b=TK12K8zI//TIv+Ov9wGWisSs7z88qisZ4BD75kyD4zuUH3fKvyO03OuT3Jw9Vrjs/N
         BpNCriovuQvO8N+C1s/VemDFdbsH8UBaZ3k5/g9WfEKCZwyoznf3m+fK/Hbu5rc8cijr
         qZjIoVZT58ZQsVpK7UNCIqz1lAMN8hsNpNQMy077OQL2Zp9EnjYKtHabH/e6PWmo883i
         t39emrCpIkvmJzmbVduMM71/XMb9+tY+Pce0tEE6NwKI5UBaKgc6F5yGDgWNZ8OduVaf
         /953+mjVrw/6CkUkHknJ+fLpc2Ezm2MlWn5oq1snIh579YbCmqVS0UEEt9R4/vMy1Jcn
         fzkA==
X-Gm-Message-State: AOJu0YzF93pdc7utuQpbVXNk8ttqOv8B5sHVDylppGbjkbB0leDAsw40
	HjPxMuTr6H9YSZQbwGVpkbcKPOOX5XcvuzYQohVeej8ssm6nsNuV2Ue2zk4hf49Ee3ypUjfrhnw
	yDGdQMtY=
X-Gm-Gg: AeBDieu5CCpmChNh39+xUYv7BwQaAxn32fWNiUsFKg9v5gjeQdeLf9FIypL6Nzyv9hM
	dW1vr+mYb3BqUNfNJvEP6+ySE8iStzd2uxS+DDqHj+OKGJSbwOe2zd83sshXM1ypVVxvrbdJJQg
	jfYga3T7NJHFOKYPg0sbYqrbSLRhBgZuOcIUz3T3KBILODVd1ba227FgDLBT7NwNWowsAbBdFWT
	M2MwuEUgNTMCj2x45IFIkqS9ecOmG9oVuWYRKsuXiUBztjilr517AXjQBToiwxMhxrNKNibHdjt
	WkzGvQSDbTSwqh7mKARaF/oEvByDVV89fNNwoX62q1/eixK41io63DmFNyCFerGRDq3zXAmZlCa
	1TzxHKmZ5wWhMNTOcRx3iXtvRvWFFFGQpSvG77DhpV14FPcHtV89JsARJt+yCLZpnEqqGDM3AfE
	T1BKXsXAoQN5AlgxmGbdqL91y1RE70HqFLiRN4Lylcr8u3Q9nUT+UxrRr6sDM+qouYUfUppHr/C
	+ZAYzK12kzjEO7BQeSktYEGWCmwRb8OzhsHg9CJl/8S22R6/50M6F+mxL8uBsw99qFUhgwwxa/p
	7S4OpezRfUTsR1Rm3qBfGAb0yoc=
X-Received: by 2002:a05:6808:50a9:b0:463:faa3:8dda with SMTP id 5614622812f47-4799c958f2fmr13020341b6e.13.1776803838750;
        Tue, 21 Apr 2026 13:37:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaabf2sm9489330b6e.4.2026.04.21.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 02/16] midx: use `strset` for retained MIDX files
Message-ID: <629c8d2311647fdde69cc56d946cdd957fa8c16e.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

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
2.54.0.9.gb905fd5d0ae

