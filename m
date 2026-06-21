Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC660258CD9
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082991; cv=none; b=gvKwSqckORHsqvZqzRVTAs42mwSBDqqyBJux+w2/kGVR//BSNBNFiSIoJ9ookI+ksPMYlEt31TMfHHVQDneGyaguQUeF+bpeSSYNZK7WBc6P/fkdor/hgIE85JKVz4U0NCMrYE71smeDu+eTekVnEnFtCIHa/LVLrJnyyjg+x/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082991; c=relaxed/simple;
	bh=EUuGJJj1OKcaIkE+JjC4KL8CulBm8Svs49XzzexJXUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJAOqTHL9x2lbAdYJdcLjqwNBBkVsym0qDnfHNvzqXZ1tBVv+V83FKyhMR4rwJZrVBC7Q/DTZmbfXjMOyfaweZ85Ph1WuYxCYi2SwBHicTg8j8I2mibuLKjPwrzxzOKLcy2u4CQZhlUoeF0PGZ57j2qRdP0OihMZ+GCjxpPRhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CxaPMp5I; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CxaPMp5I"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7fdbd0960b9so30739217b3.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782082989; x=1782687789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmHevvrnhZQ8/zfxsuNTEo7fD+g8hNQYhAYcyvPaCI4=;
        b=CxaPMp5IMlIi4UdPhx0IIc9OTgzlWHhqbup0WWobtU5zf2CC1BDk1ujmo0Wx3hTspY
         wxnpxnJFxnOWaWT3RGzzP12NQ7EH2lrMOaRiY0cRCHRl7ivALfI8MStsliky7YvBn1JT
         E4NtcOENKnO60FYonDbqdTb8AX5NF/UxHKKenXPAoFE++hiQwYYwAQ3KihMvlDUgtXWA
         QYqnVVIXmJtqjVJgbRbstxntGGPLzE2xgrbTS6m/kmBxpdQIeJxr9bZ/xQdAs0e1mYhK
         wrkCJkpIkRvTNLf+pvtEk+0GG1Dl4a92RS4aGZa0HwflKI7g8wTmtNLMFwLc+iXSjJ5s
         r8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782082989; x=1782687789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmHevvrnhZQ8/zfxsuNTEo7fD+g8hNQYhAYcyvPaCI4=;
        b=O47+o36ap9/D/sGMp8JpBVfs+Wm5Je6qP0Sl6vM3SmXZl32U0oHIXRdY/7VbAqXFbN
         W8nsP6iToH8GpD4zC6WQT0WsC9561vXanGJ7QvwCzD9Cncf+BPxyQlUz42jkPAnkNYo/
         4cfttVYh+Ahh8vIvzvZOa0r3ry1IO8YXBZvzG7ET0qVHhJMs1ln34p+9BJqCkISeJ2h2
         j0gE4khKGKHCYRv8nZtu+dMaXhLoENRb+Z4ern68VRGG/XHSnszDITW9E/jeMmoQNl4j
         gFlmgo+HKfMhxMH4OTRLdOnkyMO5srvleyCMxDVpyx6gbel6gBKBOUbPaUOAQxB+1lru
         imFw==
X-Gm-Message-State: AOJu0Yw6TUYNnM1K/vlSc6EOhG6mKtN4MMn+mtazY+j93kI3Iytk66dH
	jNlGgcuP1/Z+ROhOE8YgKXvjzEDhI2pxf/K+ACZMvy2nHkwm4l3spvc1VTTEP3rvShLCDdmyQxl
	G9HIx9CHDkw==
X-Gm-Gg: AfdE7cnA0Z2rfxTl/+ltuvWBIimiAOLYbDklD8RpdG5kM9i6WeT25yVkJ5QEwPFWUm3
	orzYFzvXAbkLrwf22BzNb/w6Hqqs3/fq6bDksM+zOBDr45XqsoGM9s+nC8ISpYtzLe9gwwwlHVA
	mwmzS3VxARqVbuS1/4fPzoB2f4lvVZ9AXOS5H18/mTIjievGL7NZ6TQ6zF4DT6rufKkNAyQlsui
	W5l+fnoP/2+v/8T4u+fTYAN+qHY1zk+QVysGwTF50TJ6au9W92g+FaWKOdkDNxAkuMEBynb6Ijj
	PqWLaOXZzuXvSu+Z6dmX1u/R2xnOpwYGFbNhJ3xzNMEkWwKDGa/SQCXt1bGPT/ASImiWpDZow4y
	ZK8t0qQkvcbLkyuGSN9+uRnf9VZC4j+qMOWx3MzNFyhceU9TnceAuvfi+nfvBGGpB1baVUFencT
	/MeWDNTacO1tz1XzDnVKV8z+aqmTPATTbZq6/s/24beLIX61HYvoPfhq52xPomwJoZyMSVyTBqv
	6XwZQIzNeQNweKncCiambODMFD8RWNbM3M4MAn8vHX6+CcQ8vYqnriUXI2G50rw89zqYW4SmMF1
	VGcPiQ==
X-Received: by 2002:a05:690c:9a85:b0:7e2:47b0:1d5a with SMTP id 00721157ae682-80135d10011mr127083617b3.12.1782082988862;
        Sun, 21 Jun 2026 16:03:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf69b5asm24614257b3.20.2026.06.21.16.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:03:08 -0700 (PDT)
Date: Sun, 21 Jun 2026 19:03:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/4] pack-objects: extract `record_tree_depth()` helper
Message-ID: <315ee0b1988a91e53321d9df8ab6d8312074806e.1782082975.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1782082975.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782082975.git.me@ttaylorr.com>

Prepare for a subsequent change that needs to record tree depths from a
second call site by factoring the delta-islands tree-depth bookkeeping
out of `show_object()` and into a helper, `record_tree_depth()`.

The helper looks up the object in `to_pack`, returns early when the
object was not added there, computes the depth from the slash count in
the supplied name, and preserves the existing max-depth-wins behavior
when a tree is reached by more than one path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e4dcb563b7d..ec02e2b21d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2722,6 +2722,22 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
+static void record_tree_depth(const struct object_id *oid, const char *name)
+{
+	const char *p;
+	unsigned depth;
+	struct object_entry *ent;
+
+	/* the empty string is a root tree, which is depth 0 */
+	depth = *name ? 1 : 0;
+	for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+		depth++;
+
+	ent = packlist_find(&to_pack, oid);
+	if (ent && depth > oe_tree_depth(&to_pack, ent))
+		oe_set_tree_depth(&to_pack, ent, depth);
+}
+
 /*
  * Return the size of the object without doing any delta
  * reconstruction (so non-deltas are true object sizes, but deltas
@@ -4375,20 +4391,8 @@ static void show_object(struct object *obj, const char *name,
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
 
-	if (use_delta_islands) {
-		const char *p;
-		unsigned depth;
-		struct object_entry *ent;
-
-		/* the empty string is a root tree, which is depth 0 */
-		depth = *name ? 1 : 0;
-		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
-			depth++;
-
-		ent = packlist_find(&to_pack, &obj->oid);
-		if (ent && depth > oe_tree_depth(&to_pack, ent))
-			oe_set_tree_depth(&to_pack, ent, depth);
-	}
+	if (use_delta_islands)
+		record_tree_depth(&obj->oid, name);
 }
 
 static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
-- 
2.54.0.23.g371fc4317ad

