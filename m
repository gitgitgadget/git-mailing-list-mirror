Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B731CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023337; cv=none; b=BPHAAwGt3so1zT/EWkjbaG1P5BP3mGABoPnk4dwh+qvGF2T/YMtlIqBq3/J+BY+lZ2uTVvJ3zpDDQTSwfwfdKgxbOvfW71awG058K0+GJy4oSZ2wdMxvPYVxTlS3wM6sqjFz8ts+8SnRVGzrXaj6N2eBLzepVF0D6H3Ipt4DiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023337; c=relaxed/simple;
	bh=9fVKigdbb/OOVXYdUeZZ7nJyoZoHb+i+tRG8ZCbLnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpRpDEOUMtn97+8FhrYVxro3pyikV0I9gRIGrc9qF3SGsls5UAyLIwR3NQ89YQ6oa/5mFbvIz6n5jJ84b64QPPRLYIA/kMoIZ4n+LI/j3kDGSrR1FO1jprv8vkzw62ipXit9+bCveDQEOjDWzoXwHOE3OF1nawqgEE/mwJkMsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2IALDrdw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2IALDrdw"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794b1052194so21205185a.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023334; x=1717628134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ByDU/0X+OFSmFqI3+rjM1YjOApGJwluw7Oy18PYU8=;
        b=2IALDrdwZQkkF6nB75ZdCNVM/1ZWzoZoP6lRIWKjVRpxQuP3Gqom6EqHrbFumxJ5z+
         brFzCwb938dEFWQsBYLwpLvVRL0g3jSpkAPVAktH4YAtfseeR/g0gStLaI7zCT8lDj+q
         SldZft0JR3//j4X4J/j/7jAN8OwyR1FbipLqOcZ6uQMYlygQbqlJFIEPk9uyTzs3Y/KH
         9RNTfItQbLdYz+Kfr8UJE5ayKwIibz9v7ZnqpsxMUN/XEopaiw84yKHViwGyGKCxS81f
         AxeYCYHW2FGUH/ahcC8U08xP84UhoIJBHiOxyOD4mP1JzORC50yJFK1wrz6ETK/Opouw
         7eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023334; x=1717628134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1ByDU/0X+OFSmFqI3+rjM1YjOApGJwluw7Oy18PYU8=;
        b=OooxpsqSl4hJBg3Pa+9pq6Zw4JRfiUBRnPcGwrIWqhUvanYbWIR7Y7vrmJnFEWpQBf
         V1ztdeQVNVP8tGYrMhWDhtPlIuurZ6gGd0Ga0mluLjsnl1XSZC6osY130PxGiDXYIORp
         7L2wuN+6b9snLuIPEDcOXsghyUJFMoeJzKnhdhaaud44P2pMtFerIt9lX3bjrWPjNacW
         d2sgMYeTviOp3agtybczVWYhCCh5YsVO+iORxOtkwzyLsYEb2388ND6t8laKSsNGP0cV
         Kwz0EU6t1vnEVHl+OiM12qSClLeP1dUZo8PxXl3MaM34pcsLgcBvtuGGptE8DWMHSTW3
         UlFg==
X-Gm-Message-State: AOJu0YzJIZpyHQF5TupFbz9f84yV0+KSaws8M14theC5AIg25WWVpts1
	r5AOv4BtEZbEs1x5I4bdWfyaHhD04+HpkHLEIVY/9UUc7hKAUVpLySW/e654aA7238EPbq/rCEO
	DP1Y=
X-Google-Smtp-Source: AGHT+IFWgORROs0zvCVuF7wnrV9aIx5hpix0M6ECxR02xk1zYcY08pY7YK9LrB5+/GuqIQXgDmMtxg==
X-Received: by 2002:a05:620a:9:b0:794:b4e0:a29a with SMTP id af79cd13be357-794e9e33bdbmr59453485a.63.1717023334362;
        Wed, 29 May 2024 15:55:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd06397sm508864185a.96.2024.05.29.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:33 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] midx-write.c: extract `should_include_pack()`
Message-ID: <9cd92574659d49b5365b97cc2352b4cc8c09959d.1717023301.git.me@ttaylorr.com>
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

The add_pack_to_midx() callback used via for_each_file_in_pack_dir() is
used to add packs with .idx files to the MIDX being written.

Within this function, we have a pair of checks that discards packs
which:

  - appear in an existing MIDX, if we successfully read an existing MIDX
    from disk

  - or, appear in the "to_include" list, if invoking the MIDX write
    machinery with the `--stdin-packs` command-line argument.

A future commit will want to call a slight variant of these checks from
the code that reuses all packs from an existing MIDX, as well as the
current location via add_pack_to_midx(). The latter will be modified in
subsequent commits to only reuse packs which appear in the to_include
list, if one was given.

Prepare for that step by extracting these checks as a subroutine that
may be called from both places.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 949a66e973..a80709726a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -100,6 +100,32 @@ struct write_midx_context {
 	struct string_list *to_include;
 };
 
+static int should_include_pack(const struct write_midx_context *ctx,
+			       const char *file_name)
+{
+	/*
+	 * Note that at most one of ctx->m and ctx->to_include are set,
+	 * so we are testing midx_contains_pack() and
+	 * string_list_has_string() independently (guarded by the
+	 * appropriate NULL checks).
+	 *
+	 * We could support passing to_include while reusing an existing
+	 * MIDX, but don't currently since the reuse process drags
+	 * forward all packs from an existing MIDX (without checking
+	 * whether or not they appear in the to_include list).
+	 *
+	 * If we added support for that, these next two conditional
+	 * should be performed independently (likely checking
+	 * to_include before the existing MIDX).
+	 */
+	if (ctx->m && midx_contains_pack(ctx->m, file_name))
+		return 0;
+	else if (ctx->to_include &&
+		 !string_list_has_string(ctx->to_include, file_name))
+		return 0;
+	return 1;
+}
+
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			     const char *file_name, void *data)
 {
@@ -108,29 +134,11 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
-		/*
-		 * Note that at most one of ctx->m and ctx->to_include are set,
-		 * so we are testing midx_contains_pack() and
-		 * string_list_has_string() independently (guarded by the
-		 * appropriate NULL checks).
-		 *
-		 * We could support passing to_include while reusing an existing
-		 * MIDX, but don't currently since the reuse process drags
-		 * forward all packs from an existing MIDX (without checking
-		 * whether or not they appear in the to_include list).
-		 *
-		 * If we added support for that, these next two conditional
-		 * should be performed independently (likely checking
-		 * to_include before the existing MIDX).
-		 */
-		if (ctx->m && midx_contains_pack(ctx->m, file_name))
-			return;
-		else if (ctx->to_include &&
-			 !string_list_has_string(ctx->to_include, file_name))
+
+		if (!should_include_pack(ctx, file_name))
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
 		p = add_packed_git(full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
-- 
2.45.1.321.gbcadaf92783

