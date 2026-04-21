Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E023DDDA1
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803844; cv=none; b=UcC43C8Qn8PQ88oCxaD4faGTlsqQCEhE5jqYFtq6fh3sKXsw34/Ks93u5pxSOwebvmATw3ZH/NmWGXpP/pAdmHWdk+BLhMVpw9eErPXV2ftAYsTIC5w2Iq/n2POMcl0Dyz77D4FrH5n5vxoIpGIvqL3b2OaBwazf6CisN4TFAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803844; c=relaxed/simple;
	bh=vYombD2/9kC/am0KFj7T1Jlx5zA/5a4Pv21HEmHPWlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqHaGbGBSucgnThorqzDi09NegU9tfTwXmqAVO5C9xbgOvJYx7zyfQ+jBeqYLPzfmVfXzrHpYQSkK6eLF/zR1AgnkQ018Ya9qrLqc2GOVjEokDzCR92kkXdQQryEi4GdAWJ7lp3GCR+gC9AmvrvTTRTv+HrkNuhZ2Mqsc8KXJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=n2qhDQdj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="n2qhDQdj"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd689829eso1209517a34.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803841; x=1777408641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NjBsWaeZgNzOofXHG1Ya9Hf1tLcK9lYbzjEDgN+qos=;
        b=n2qhDQdjHmzreHQf0R7gfoYm8abea2j/LM7JAttu2xbQEALYgvvzeMw72s5BpqMtaN
         v5rio16pYGZAh2+Y5GUA++xRF9Ow7yE23JgDVAN5FZUDv5uavga1ivIrAzL3OuW98h52
         6HgfkqnnPebto59HkajLaaCOg+7G/GpFyBDZ+UGRakTtPhUT5MsJYmvH3jm3ReaaNnEE
         nSR2WZ8y/rmVh3j5v5ndo/PYoHMsb9lsnUvk2kfH+t6kJoBC9wjGknFTLJewlfBGRWBt
         3xGNONhKpMKUXFRT4WFDLFB0elgvA8M6VsM71dNkqsHJz+uu2u5NCw6VDe6mfoZuUHFH
         X/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803841; x=1777408641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NjBsWaeZgNzOofXHG1Ya9Hf1tLcK9lYbzjEDgN+qos=;
        b=kAV0/mU/x1V8SgGoiNYfsaYY48hbTTCEPOlaW/rnYAryyNHMUTdgO84cyoHuzbKya4
         iyzw0wSag1KsnGm7pz5U97KOASVozrzMcbpjMKctQO0xuPKvVf4yL7tkcjbeoTIkkkM4
         dz4nAIaby74bKkLBcsJ2+ZkcjWcl78QdTVT1hJFTtDpOcJke2MvSQ4Idrlg/x7cesJqH
         wsH3JNTT1eNdnemK16NhTLQvCLmYESTirsL4WEExUOlHvYQ/AKUKslQ1ALRmYrxo48Sm
         pUnHUXdTM4zuRvdOS3cXxNExjNAwU+W7CPqHPd3uDER5IxmoRi6XCLjBVFnGAPCCW1WS
         OgbQ==
X-Gm-Message-State: AOJu0YxW9NghD5t+Eu6jvAo+WT3WLb703Rb2StlwGdJhG3mRJwH5nyrK
	Mie7TubnUAExz/91Sd8E6EFeMfiQC8/Dig6qjAS7OQoJKf0sVImvKoolrgsMBPxrwaIcACp+cAY
	yd+5dsS4=
X-Gm-Gg: AeBDievT7/g0d9YanWkCC22N7afWxQiUbof1pID/+ltmkffewljxotJEkjpjuFngBk/
	jiZ2UH/z7+0M8UYCL5VtaSS0Sgr0418mygFNzTDSdJ1V7gjWVtIcy+bZjQLnmsWattoPDoZpHK6
	r+zwwPVRNb2HaZLsLLqcaFcc+V3t4+AsEU3fGgNK1fVUHPOTScVqgROUVornSKB0HI3AmnxYNDt
	f3IFQoMY4/xobGzvQt9ZJtt2J7JsKRfTC9opzQdWcbf6kqgqaoJ2RtFyG4CVo5Q7pva/sUdhSE8
	SQvW7jnZBRN42yEI1igR94bEhyQBI2Vv+rZ8lHoE8Jj1K/f3DtTHhBYcpsvyWrw1JORybXJ02et
	h09C6PcRPnmXvfRe2Mx2ckeCEC+30lIEU84YC0kDgDvEp97fXnq54GN1BMFIICS0PNNGmv0AwsW
	cLW1syA9J3oMdxlIvKBW2P9HGsiJ8VAhEryNyRXaTJfy2FS+f0T2vLnmmmtZW3j8TczGMCrqpmN
	U1NK12djImzUAQrgdk3yHsCe0tB8eEKsArmeJd+2H5uePBrf7e2mFZ2yVhykUsDXYO8NNGbaqJL
	ywM7IjNMl4JVq8HoM7/7HFeppkw=
X-Received: by 2002:a05:6830:661a:b0:7d7:ecfc:76d6 with SMTP id 46e09a7af769-7dc951c298cmr11400405a34.17.1776803841517;
        Tue, 21 Apr 2026 13:37:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm3825959a34.24.2026.04.21.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 03/16] midx: build `keep_hashes` array in order
Message-ID: <e303bf6a4ace587259f09755b257b2f5df793af9.1776803827.git.me@ttaylorr.com>
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

Instead of filling the keep_hashes array using reverse indexing (e.g.,
`keep_hashes[count - i - 1]`) while traversing linked lists forward,
collect linked list nodes into a temporary `layers` array and then
iterate it backwards to fill `keep_hashes` sequentially.

This makes the filling logic easier to follow, since each segment of the
array is filled with a simple forward-marching index. Moreover, this
change prepares us for a subsequent commit that will switch to using a
`strvec`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 66 ++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 9328f65a201..55c778a97cb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1731,6 +1731,9 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
+		struct multi_pack_index **layers = NULL;
+		size_t layers_nr = 0, layers_alloc = 0;
+		size_t j = 0;
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
@@ -1751,46 +1754,49 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		strbuf_release(&final_midx_name);
 
 		if (ctx.compact) {
-			struct multi_pack_index *m;
-			uint32_t num_layers_before_from = 0;
-			uint32_t i;
+			struct multi_pack_index *mp;
 
-			for (m = ctx.base_midx; m; m = m->base_midx)
-				num_layers_before_from++;
-
-			m = ctx.base_midx;
-			for (i = 0; i < num_layers_before_from; i++) {
-				uint32_t j = num_layers_before_from - i - 1;
-
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
-				m = m->base_midx;
+			for (mp = ctx.base_midx; mp; mp = mp->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = mp;
 			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
-								   r->hash_algo));
+			keep_hashes[j++] =
+				xstrdup(hash_to_hex_algop(midx_hash,
+							  r->hash_algo));
 
-			i = 0;
-			for (m = ctx.m;
-			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
-			     m = m->base_midx) {
-				keep_hashes[keep_hashes_nr - i - 1] =
-					xstrdup(midx_get_checksum_hex(m));
-				i++;
+			for (mp = ctx.m;
+			     mp && midx_hashcmp(mp, ctx.compact_to,
+						r->hash_algo);
+			     mp = mp->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = mp;
 			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
 		} else {
-			keep_hashes[ctx.num_multi_pack_indexes_before] =
+			for (; m; m = m->base_midx) {
+				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
+				layers[layers_nr++] = m;
+			}
+			while (layers_nr)
+				keep_hashes[j++] =
+					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+
+			keep_hashes[j++] =
 				xstrdup(hash_to_hex_algop(midx_hash,
 							  r->hash_algo));
-
-			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
-				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
-
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
-				m = m->base_midx;
-			}
 		}
 
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
+		ASSERT(j == keep_hashes_nr);
+
+		free(layers);
+
+		for (uint32_t i = 0; i < j; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-- 
2.54.0.9.gb905fd5d0ae

