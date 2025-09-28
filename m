Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48719C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097381; cv=none; b=dPs8J4+rAuM+TDUXKbgkoBs/+Bk7Hm8UptEva0cdzTi7N2qPZrO+VJLeVf31yAbrI/SZArLxaKxnNVIa8za47ihVOGdHYHLdCbj1mI93KgZ/e9k6Aj7hzHm1sf/armYwlCqAW1dv3FVr6WBeEm+0+f1YwFR5zJePXxEgdQngZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097381; c=relaxed/simple;
	bh=mvlgyYm0wl2ssO8BXHcMbsrGfHUPHWb6OJd8ulffW5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Odhdq6/hTLXdkV1w0aDjeiWEwhP89k4J0+j0Zo6pXwFJZf0p8e3cYqt5waRxQygDsV5GDlTUa2KzPaNpPjWDikDyA5ytUgO+LdZ8YE+02hrkhJ536I8yLbrtnewYK4XLIFZ52BoAm8oZEwVX0k/wN0kDrQXSD06SQyavzDk7DeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=l+S0L+0N; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="l+S0L+0N"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-635380a4a67so3798511d50.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097378; x=1759702178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hO1o2/U9iqfJc6NBkEe2orzUboScyJtO0mJt42i8vEw=;
        b=l+S0L+0NK+yrgfQz91PlpqZz0Faaj0RJYmAqbRjxw0BRuiOvNL4sS12REm/jks0+3w
         epu4ciYFrEsl3FNtwNyIBObtOu0RAKo2PvZp0FgFQ4o6+QsJDQwFN1cF6BjEj8dNE5tY
         unJpGbFeGPIG/AnsdEEDYT/TAsQ+lX1PJsX2xBj35JxUpiXN8DGBP90MOxkbh2Rbkmwu
         LeDbceNSd8PL2zaa+3At6Se1NDqMlFxbYStAlNyU98lIIORp/z2rcdhL24EQBDfFqL3D
         ZUpfnYtsA2SKxfEvJeraboPCRZunOoeJ0v7UThag0FGW44jVAUCw2Qd3MV6W8cwkgolq
         cd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097378; x=1759702178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO1o2/U9iqfJc6NBkEe2orzUboScyJtO0mJt42i8vEw=;
        b=ax4Syhj8b3T2sYGM88TX9nX0dXwrll6rfeipCbeMv9PZTcVdW7LU36GPVXQ0Qyr8Dp
         tG4UWt4WNi6cB36mKUjTxfcNVdH8bMmw7aCB+v9jIgwSfMUBQwNocU7njKxs3QLRwAEP
         1ca0mj3/SiUkB3P1emMeQaL5NJRzSPnOibIelRvXWqeheKeqKOUsxahtdY7UZVgU1ibm
         uO7rBc3oGs2vAkrEOnVRAVb0unVPx/vZ2n8IXwCXcX/R9T8AmjaUlqJUdKa6OD1O9q5q
         pwWGKyR49SRivaNQWtBx8xHlMOr89pHXeZy8/uz/A9j7lDV2h4R2LlxLMXTLUL5c/MT5
         C+Ag==
X-Gm-Message-State: AOJu0YxiTMbCTzAMQwpyf5DWh6pq3k2O/20SC8ycMpUOd+AacoBp5+a1
	L1nP4zgIW+v6cJEZZLcK2sok5qwCjTioZRJ4zzitcdp15EGDKPI6Qk+/40i274DAMNtrm7xvrp4
	tju83xbs=
X-Gm-Gg: ASbGncuJNPqR1ySQavLDJGgVNQ269vcRpkgZ3pcd+rChxz0pyJPPXob7jF2QEhzRU4E
	qIWcp0YvbwLwbYZDsoD2mQrQGBYcE944UafWpG6MFY6ziBOUYokH/Qo3qVW1gKGYaT09NsBPv4F
	77dOk2vVNVKakAp687pGQ/EJ9Y5TLL/Oz7iU/l3aEQWeMpMP/32zqCDm1fFsJ1k2K4AGDEYPqyN
	yFfif6bovLbP4IHU7kR6FvDJp6Oh8dCMYse/AMUwrRn8r0l3tcQYX9L7awWbuF+jfBnGa1kW7G/
	wi7lgyU3qZuLHPJBXCf4RTv4HRAcpyy0FACS0kBGaaiFX1bBc1CXfaPA2WWZOvgB2FNRShKmM4L
	sdR5gLoy6Cy0Uy7ipF4HRf7oMfUozsdGc1YnM5nXnOEgRYe9NGx5JxD8uOnkK9BLWuevgh58dXz
	lYamYfe5LWqOIcC8VVuOd0iLboOwhh0HF1EQlN53dxzpyFrOY=
X-Google-Smtp-Source: AGHT+IHrEosUmNXoExHh0ICyFUUAEnPriAbrDuGIRfsnVNNSpYBIYNFzZs53jEggYe/TJuCaq3m91w==
X-Received: by 2002:a05:690e:4290:20b0:636:d12c:502e with SMTP id 956f58d0204a3-636d12c5292mr13188707d50.25.1759097378634;
        Sun, 28 Sep 2025 15:09:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb3e96db2f8sm2538045276.23.2025.09.28.15.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:38 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 37/49] builtin/repack.c: pass `repack_write_midx_opts` to
 `midx_included_packs`
Message-ID: <60659a7549fd0dd416f9e04f191666b24a422374.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Instead of passing individual parameters (in this case, "existing",
"names", and "geometry") to `midx_included_packs()`, pass a pointer to a
`repack_write_midx_opts` structure instead.

Besides reducing the number of parameters necessary to call the
`midx_included_packs` function, this refactoring sets us up nicely to
inline the call to `midx_included_packs()` into
`write_midx_included_packs()`, thus making the caller (in this case,
`cmd_repack()`) oblivious to the set of packs being written into the
MIDX.

In order to do this, `repack_write_midx_opts` has to keep track of the
set of existing packs, so add an additional field to point to that set.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b55c8934e8..bd3034a4f0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -108,6 +108,7 @@ static int repack_config(const char *var, const char *value,
 }
 
 struct repack_write_midx_opts {
+	struct existing_packs *existing;
 	struct string_list *include;
 	struct pack_geometry *geometry;
 	struct string_list *names;
@@ -188,10 +189,11 @@ static int midx_has_unknown_packs(struct string_list *include,
 }
 
 static void midx_included_packs(struct string_list *include,
-				struct existing_packs *existing,
-				struct string_list *names,
-				struct pack_geometry *geometry)
+				struct repack_write_midx_opts *opts)
 {
+	struct existing_packs *existing = opts->existing;
+	struct pack_geometry *geometry = opts->geometry;
+	struct string_list *names = opts->names;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -242,7 +244,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	}
 
-	if (midx_must_contain_cruft ||
+	if (opts->midx_must_contain_cruft ||
 	    midx_has_unknown_packs(include, geometry, existing)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
@@ -994,6 +996,7 @@ int cmd_repack(int argc,
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
 		struct repack_write_midx_opts opts = {
+			.existing = &existing,
 			.include = &include,
 			.geometry = &geometry,
 			.names = &names,
@@ -1003,7 +1006,7 @@ int cmd_repack(int argc,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft
 		};
-		midx_included_packs(&include, &existing, &names, &geometry);
+		midx_included_packs(&include, &opts);
 
 		ret = write_midx_included_packs(&opts);
 
-- 
2.51.0.243.g16eca91f2c0

