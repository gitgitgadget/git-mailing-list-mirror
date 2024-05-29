Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C671CB33A
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023344; cv=none; b=Kbq2llZa9iNf1yhT3KJ8yx2lnfMOpfm7ew/hEYthUuaKmw5+q2PJNDPc625GvIkLf/wPTSVYrKV2+LDssurwIo9vlZo4/t8Sq41BjH1ejWPNvP+03CY3RwwZf/wACfJOCuzu+TbY3L5IwC/BQf3uVuMEvx+X2+gE6w1Unog4MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023344; c=relaxed/simple;
	bh=vAS1q+82/ZYTptq1S/8znx/mkne8PQm2BQv+RJZt10o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+g+IZTMcMG21vJyED/ocMmPVyal/xgk3eNxCcm6kg7MgzHswjWFtCOhnGal2UZKlKvKTdHNNc8mIHnakKFcrtbj0wQc0vQ/uqBxvKBgBazlRhw0G9lHLwsMkqt7WMQbPyZF8frKMb40LhJ6kn2sVRot/p8ApJ95JOY2tVfXteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=g9DjVbTQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="g9DjVbTQ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfa48f505a3so246401276.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023341; x=1717628141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qcWRfwRHol7Acenxsrnyfd+BOEBQe5/tlzf2MKi+KM=;
        b=g9DjVbTQFHgS0LPHN9RNk93jW7JVeYpaO/bMdyWgyxzXaQFhN0FTkwJXTZb0j0HcIv
         6sYGItORqfH0mjTzusNBorSVIQQVkyDcv5Yxnunmfu0HDBAZsMlVUYuWTrmdGS5pjRjF
         DwCeCf/g9M6uoaVxnf2zj/5qfhfCUzSHkWo1Cb+TfwfJsulRWyjSTdi0Zh2iEpjjJQWr
         FbhijC/GAB+kmrX2yeZ5H6pmoaIJFjD3/eqaLCCSiXxbPAgpAWkW2te/NgcWLFrl66wV
         +rqtXjXIWaWUArwrgQyl3Ducg8z29gUsZ9c1s4KibvdnVZ8W6c6oVMoQA5M09Tyt5qxi
         PcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023341; x=1717628141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qcWRfwRHol7Acenxsrnyfd+BOEBQe5/tlzf2MKi+KM=;
        b=Tz7cadp6Qrl2IY4siOUCfiTEwqDFkUPWW6SDIh8Ca5G/S+nk+Bzkk14ANR/4q3LqZO
         VTexeRJ8a77l3WCPGMSzeJT9HI5U2uDQxk1oa01qZ0Y26oAPCkAF3ejgQTBTvFg4futj
         qtGJyEFXoNiEo3OksEyliTDwYdz+DeNN0J5jgSDugCwE9VvFG5WPpAPjHTBNAVAkE0Rp
         zwGQCTv/qO6GaWVimvDWmN4T0mEHIt+JPJk9bmYPvVh/msdFbhC1yW9mXAV5KxUW+VVv
         yvUfPDyUA5IND2IRVji85G4G9nfUyH449LNRXp9k2UxuicOKcnbCt8I9wAVmhgf9AwqS
         szZQ==
X-Gm-Message-State: AOJu0YzNa1QHkpW39ENv0j5gNSt2GbnrEL5wqSgsPTuNoMgdsyyW8Z/4
	pfxNBhmRP6zeY9gyqSKpqvCM8M2opsjbZlL15caLRovB/pQnjHOF3MkpxuC6XpaWQ8n59Ig+ZV8
	EH6Y=
X-Google-Smtp-Source: AGHT+IHWfjq9hT5PyNgrGfl3DScLPGR9mjcPBVwEEPMYk/CdlFW4RgmZnGcNVwxZCjdRH3Z01gAMRg==
X-Received: by 2002:a25:d6d6:0:b0:df4:e882:2808 with SMTP id 3f1490d57ef6-dfa5a7bab7fmr590731276.56.1717023341020;
        Wed, 29 May 2024 15:55:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd30371sm510875085a.104.2024.05.29.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:40 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] midx-write.c: support reading an existing MIDX with
 `packs_to_include`
Message-ID: <fe187b1939d9c74782306cd3e4fcd2f25451ad69.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

Avoid unconditionally copying all packs from an existing MIDX into a new
MIDX by checking that packs added via `fill_packs_from_midx()` don't
appear in the `to_include` set, if one was provided.

Do so by calling `should_include_pack()` from both `add_pack_to_midx()`
and `fill_packs_from_midx()`.

In order to make this work, teach `should_include_pack()` a new
"exclude_from_midx" parameter, which allows skipping the first check.
This is done so that the caller in `fill_packs_from_midx()` doesn't
reject all of the packs it provided since they appear in an existing
MIDX by definition.

The sum total of this change is that we are now able to read and
reference objects in an existing MIDX even when given a non-NULL
`packs_to_include`. This is a prerequisite step for incremental MIDXs,
which need to load any existing MIDX (if one is present) in order to
determine whether or not an object already appears in an earlier portion
of the MIDX to avoid duplicating it across multiple portions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c93e1ae305..8b96c566e7 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -101,27 +101,13 @@ struct write_midx_context {
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
-			       const char *file_name)
+			       const char *file_name,
+			       int exclude_from_midx)
 {
-	/*
-	 * Note that at most one of ctx->m and ctx->to_include are set,
-	 * so we are testing midx_contains_pack() and
-	 * string_list_has_string() independently (guarded by the
-	 * appropriate NULL checks).
-	 *
-	 * We could support passing to_include while reusing an existing
-	 * MIDX, but don't currently since the reuse process drags
-	 * forward all packs from an existing MIDX (without checking
-	 * whether or not they appear in the to_include list).
-	 *
-	 * If we added support for that, these next two conditional
-	 * should be performed independently (likely checking
-	 * to_include before the existing MIDX).
-	 */
-	if (ctx->m && midx_contains_pack(ctx->m, file_name))
+	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
 		return 0;
-	else if (ctx->to_include &&
-		 !string_list_has_string(ctx->to_include, file_name))
+	if (ctx->to_include && !string_list_has_string(ctx->to_include,
+						       file_name))
 		return 0;
 	return 1;
 }
@@ -135,7 +121,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
 
-		if (!should_include_pack(ctx, file_name))
+		if (!should_include_pack(ctx, file_name, 1))
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
@@ -894,6 +880,9 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 	uint32_t i;
 
 	for (i = 0; i < ctx->m->num_packs; i++) {
+		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
+			continue;
+
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
 		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
@@ -948,15 +937,7 @@ static int write_midx_internal(const char *object_dir,
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	if (!packs_to_include) {
-		/*
-		 * Only reference an existing MIDX when not filtering which
-		 * packs to include, since all packs and objects are copied
-		 * blindly from an existing MIDX if one is present.
-		 */
-		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
-	}
-
+	ctx.m = lookup_multi_pack_index(the_repository, object_dir);
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 		ctx.m = NULL;
@@ -965,6 +946,7 @@ static int write_midx_internal(const char *object_dir,
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
+	ctx.to_include = packs_to_include;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
 	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
@@ -981,8 +963,6 @@ static int write_midx_internal(const char *object_dir,
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = packs_to_include;
-
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-- 
2.45.1.321.gbcadaf92783

