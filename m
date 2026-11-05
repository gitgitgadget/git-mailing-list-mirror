Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864632;
	b=GA7RgfiuZa9weqkC7zIlppOHVkw2iOhf1YECAq0Ds3YGDSFJrqIfERlbhSBvWGmZ/VZB
	 JbhIa2aVqQHgs28DavfT4+P9CX5nBRXCzK8Cy8L9lgsOyzmyV1O4D8lo/XO+TzlJkk0yS
	 CuOIt1EZxfdVVHDzbUr0FT+admnjlLgmMUM4BTTyk9A5VAbiEtZd/8vrOBpLh+jOB/7/O
	 fnEVMNZXz05ESBEs7eltHniZ9CyUjehn2wAXzpkQPmgqPa9QRgwtqY+ZNNiWCkWeffZuj
	 yh3bx9n3BAEejPQaQyqA+hukC+4RR6n5n0mOG3WEr0Fu1L//5I+JtPGtNHDfWHJL1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gq432o8y8jWfPXNQ3J218c8o7qO5Y6OdnX4JnhxK9Ds=;
	b=5lgqbNqpNB/czEMBHSezBSj6JgCir7ceGqBW0ZGO3KZDsxliCO0qIXY9Bjth9Kk58F8a
	 8bm4Pc++ZONC4/hZdHrojAKXBWjhc6hxg2DkLrTXKRjJB7BT3O0EptfyNC/paFL1Jr0gS
	 vV2JV9u77cZyjZaB0KboZc3Y0Moi4vlP5dyuMJB+Gaw8OJ8Mu5G8H7N91WLDvDmS73+Ws
	 s0cMB4fa1rlaP0bfBkBbh6MdIz9yfPV3Lfij+XRPhTN/nN8XQxUbnC3oazLhBeMK/RPjF
	 SDyCNAtRvfs2rPzH8KNA0ihEgiTubC1Zn4Ue/ipZsBrRMTZNodpgyLrOOzrJfCoVMzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Opnd/iSn";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF5606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Opnd/iSn
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so12503275e9.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 23:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864631; x=1794469431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gq432o8y8jWfPXNQ3J218c8o7qO5Y6OdnX4JnhxK9Ds=;
        b=Opnd/iSnDHPlMkmktuLRptk0PJOdqk3h2fV+BdOKK97whi9mp+SUY37gn0tX2oCJDN
         GXXxQahayVfdb01+5UCZ1Cnlc71/USTtLtVxmXjt3Lnvolq6i+/AGbO1VB9dd8NoBJD9
         8dWxTRNrlfJE0xG3+XpHvQ6tRwyJGtDrHcJDfLiwz4kTwrQ7ttEojgkXFjNhqMDjpHdT
         7zMydqnzCLb7uMKtMmIUhXajs3HqmKtu7Am0hqibsunF6kdFrLiAPDZgwsVf1MDyI4uH
         A4h7DZU/Ng3jdx1kje5K9JxvmmkAspD3pgK0NPYrpK34l5Lh/51M+ur6skeQsMlLaUj/
         ph2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864631; x=1794469431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gq432o8y8jWfPXNQ3J218c8o7qO5Y6OdnX4JnhxK9Ds=;
        b=URcQg4Inorj+XKgVfJHhy+FoQYDGdD5IPvGCySl745GvEe05oYRYMtM9du4UaAUQJS
         L6qKACEO4VdEIZneW1+69eBSccmrQ1ssV9e+sbn3H9aCb9oZKIru5MhH0Wm4ZijqmXQ/
         EpfX1ekuQKhkfYsNS9AbtPqos8zrk0fevdiaapdv0NYXfOJw4Bu+b85IIlRscC3HKjTj
         Rr650nIyeM90i+r+5YAngHZslvZbIH8ELjT1xNd0ObWxZ78TPyUPQmgalPtCAXt2kMoi
         D7pp9bRpt1zcucxFgj1HjPd31ZlgFAeEihWhq7SrItSPodmpDU3W0sphEQErwKfljpCS
         BXkg==
X-Gm-Message-State: APuU4Z8Ls6hL9PKchhGDcqKJaK8lJOd0DyGu0QCUtfYI+JqeXZHwgjcH
	Hc5Hxf/t5gAFvivif/xaV5hwe+lIHx1FM4pLEioBZ/2KfXbom++rbFt57IMS/jjRPHoLcA==
X-Gm-Gg: AYBFou0p3nyVBsM+i3RjJ58ILa8FzAgCfjDr9r9U2tySp6rlDr8Ufkf10iovGh/W2XN
	sq0C/ReNP3el524nahUS+daO4yHKTHMwNAthjrAlXioMJNHBHql4tKmLuBPUtye1a9iY7oHFZqv
	BuNtCGwXflRWRdEu0GAe8SNneqo6c2Auxn/9e6yAgqW3ASu3CXN2sM8VN4N+xcLqq6QdD1CVD5S
	bkaKgxXpjUxdtpJcVsV5RU8/crL7Mjj5FYGt23i6sd02eb7Zo5hGWXht2s3HP82gqEEPHX/wAmM
	X3RdxsAK7dNP4UAzB7HRSkfoN3unGaQOPkuXH5IEvRqWBiLlbXVbswFzQ/Q8LW+Png1Zq72c/4M
	D9c4sP0NnafTFs9fR3SQcC/ZpgtsD1Z7J27jmlRMOyNgDRj7AZceMBh36CHYXBOjaxm50VGfH/A
	TTqlfajIPnbYB6KthENkM2fmBqP25InvTfNwU/INLGdAoryqcfh/PNvslvVwBz8Ed6IS7H0d/nc
	6SI3a5zPKrDD3I5G47haDbz3jiPD8+ht1tastdTLzMwPClrYssPVVYs+4R0rdT0XqSXDZ/HzeAm
	witsQPUhxJnKVGCLXZavn7LluTjQYfwYAzZ93ZCPAwe03g/7AKoGFWgyz6bM6NK16HINBdWDomd
	xrcC/4dIRrK6N5jXLd/Bjctq3k4BSL4x0TpgghA3cJl2SBprOZzWfETpSqjxlkXvqvxQRGvY0oM
	yZkm2tPNl5BVG/5S/ubnsrT3V5Zna4
X-Received: by 2002:a05:600c:354c:b0:4a1:9663:7639 with SMTP id 5b1f17b1804b1-4ac18c7389amr414642895e9.34.1793864630582;
        Wed, 04 Nov 2026 23:43:50 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ef2e968sm52493895e9.8.2026.11.04.23.43.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:43:50 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	karthik.188@gmail.com,
	ps@pks.im,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [Outreachy PATCH] notes-utils: hide functions that still need the_repository
Date: Thu,  5 Nov 2026 08:43:33 +0100
Message-ID: <20261105074333.16756-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqjymt94l3.fsf@gitster.g>
References: <xmqqjymt94l3.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helpers declared in notes-utils.h call into notes.c, which
still only works on the_repository. write_notes_tree() writes
its tree into the_repository->objects.

Passing a repository argument does not make these helpers work
on another repository yet. Guard them with
USE_THE_REPOSITORY_VARIABLE, as environment.h and repository.h
do, so code that has dropped the global cannot call them by
mistake.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
This replaces my notes-utils series [1], which I'm dropping after
Junio pointed out that the functions underneath, in notes.c, still
only work on the_repository.

The guard also hides the enum and struct that notes-merge.h uses.
All current users define USE_THE_REPOSITORY_VARIABLE, so nothing
breaks today.

[1] https://lore.kernel.org/git/20261103084930.15532-1-okhuomonajayi54@gmail.com/

 notes-utils.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/notes-utils.h b/notes-utils.h
index c54b1fe141..1503991cf6 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -7,6 +7,9 @@ struct commit_list;
 struct object_id;
 struct repository;
 
+/* most of the things in notes.h still only work with the_repository */
+# ifdef USE_THE_REPOSITORY_VARIABLE
+
 /*
  * Create new notes commit from the given notes tree
  *
@@ -52,4 +55,5 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 				   struct notes_rewrite_cfg *c,
 				   const char *msg);
 
+# endif
 #endif

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
2.56.0

