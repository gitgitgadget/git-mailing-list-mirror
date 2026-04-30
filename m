Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B518C2C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507997; cv=none; b=d7Q+lxoyN0CnyS4iMtUvoxvz1fLX6KDMGN6ngjltAoFbRq4lNI6Iou00vgv5h7OmzOgvxSwRKCJ7pfNwlK9rxA7S/4M+WkOJtpyvBx7GXh/1KQAVW/ZqHxkPN0yd1GLg0T791gvpq2RspKnEUayi5BdgIC4JvSe0Yb/npUepiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507997; c=relaxed/simple;
	bh=lbr536JdP7m3/NYAC5geX5Z76+/1rVAFvs3ywGweNRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbYR8b+qephXOlmlGmdacATGhQ0rmLcVXP+mYJUp9VI9yQjhqyMkjJP5OhHDzhjyj34EOVQ5UQfHGz6Ni5ciGxNwG+dzvB4dFZvi8Z4dir2M5QYpmjnTvd6t7TkjOFcajBT9yr8UJcP40/YAlQxifjzYDGMJdW2eZwNGU1Jnyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OFrjdfPT; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OFrjdfPT"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501d242e2fso318133d50.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777507995; x=1778112795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XrrkdBi0TNi5QGvkoRxrkudBDdL/6WJpdadQw5wKnw=;
        b=OFrjdfPThkoU/qotMeM+V5W1ywiQzKwC0FKffJK0ijfKaBShZyZ474mvGxMl+O61TW
         5k4/PVZQ0upWjZSEwcnOH+HE6T0G4OWG+WCfhyPOrWSc4QZuJewC+HSYF/VNtUbpu31b
         4ussKKSA+C9PD13jMa1YZ0LvBRSApSLCWpqZ4l+Xx8/kaVHQFYnE2VwDpaWpN/avQ6uV
         0L2vdBsMMmC0qQLAYocCsHsGxZKVvdwiKqHl5kzb5Rd3BWKUPtaPQnO2abWOh+o4n4MA
         CyElurGV5PwGOrD+afyVs7fd6ai6cZJmSeaA6IpE7EyDxtEe0XzIIlLrOM4QFwEbglgy
         F6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507995; x=1778112795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XrrkdBi0TNi5QGvkoRxrkudBDdL/6WJpdadQw5wKnw=;
        b=Mp4ukYmprI3F3w40q7KfNkahp30I0u5nr4sNX7OAj+hEqQugBsV9SoZyQOeuwk7MMP
         D/q2FxrC3A+lUjbXo0TtC6GWt82OwNC40tE1fvx6Ao5zewc8VzuGlwI6d5NlIoGfsH1T
         SVOQEK7/dWC4KGhkmLhqF3QB3GbWIMDYs8ncBi70soyVdiScb/pXrTrssNBOmqwK9cIV
         0s5tL116UinsK9TCoZ74kHRkfarL/0a76JFHuHzqvmhgCF7UNxhaplqOrzw0HKX9Lmec
         OkFX6Qe/UN5z66oodg2MBhw3eDROPlv10qHWjZbCShBEIh+UlKyHlHCfNl87qHV0Qk3k
         YplQ==
X-Gm-Message-State: AOJu0YxRA4ukBOHbX+II6s94qevWiiqKh9T069aaC0u9DKr1y5RjZEq7
	5DMEjMFV5MsIZyGF+ohhUXyMUaNbpYP1FjsoIMgzP3vpeV184F5zPzqMTogl9smFfi5+KGacdAa
	+2Oz9LVVLNw==
X-Gm-Gg: AeBDies4GOHhWa1iMbAHUNejD5+tlcUtZ8L6IZpBNUGHfoX4RZfu640+r8SKOxdW2hL
	NMiJ8MNpSKM/FBDcdGtcipHB7eY3mgRo85BdT9o50CpIqULbHe08UE7Ti4L9wnYHGhm7VUqpj4J
	b8L9cIlqbmZq1QVLZCJylXa6NYQb+j+LQmkARKN8bUrMA5m+2GvHrL297r/DBvCodOwaxIri8S/
	M3sRXrFAm6Bqtk6sWbpENPS8JTorfhFG7DCnhKxbufh7104fbSxHSrtbxNZ+zyr/5ww1GUPIeoN
	kQcUYE3sydoW2tOkULIm1P1lCAJL6lS0VpV4QMzGGqg8TZKUtwkNj2WbXtzaS5JPf1GWjHHxEx5
	GJzCVv55JEtab9EPMFe9mBDHfGAp+7KQ5IuJAu31s6SjJtC8i8ZKPPqPdghZ14vCmCVvQDJIB+d
	I876D2jMrwlnIpRWdZjaBCleZhmutTC/4MFiIZQkmPkeyJJ8Mk5l6EeX4BJjt1B4v5JHvHU+Gfw
	npJSMejyh1a61IAwmi2IS9ADimG8teQ7Azz8BSAJLmTuEx6R7ZChKUZ8ukY+ce8XkIRz8o/k0rz
	81namJvjV76P74AWZ5fwfLCgEpQ=
X-Received: by 2002:a05:690e:b86:b0:651:bf93:d701 with SMTP id 956f58d0204a3-65c18fcac0dmr387787d50.57.1777507995363;
        Wed, 29 Apr 2026 17:13:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff7ce720sm1935124d50.21.2026.04.29.17.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:14 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 03/16] midx: build `keep_hashes` array in order
Message-ID: <e303bf6a4ace587259f09755b257b2f5df793af9.1777507303.git.me@ttaylorr.com>
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
2.54.0.16.g1c05dfce579

