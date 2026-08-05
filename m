Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A3484254
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946497; cv=none; b=p4a6t8qrsfnOkxr+/yd3lsFlFMEjodZl4EFJKEKBSVZz6Wb0QNbO9drsEx4pAsoLlrSeKpYSK9l20mYeFaGpGQbT1PTUXQ6Nx7ncz3M4HsmriqnNGJYO87GHPUCBjXVUuj49XZaNCEXgKeiHqUljU/vxaF19WbQtXE6p2XBNjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946497; c=relaxed/simple;
	bh=XBD/7nxptagjs5H2PpX5CLiH2Z9YzMUXPv/q39eA2BA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=en9H/tYddCldedajEO01dbUtbL4t88DnK+DiZMjtk8id+H5Afu/K2Rgdmw2EytD0AVs/AkVCeLnX+2QfjCtNRaKrOpZmRKxNmxyu2kY7KDI8ynbq/YQipQG9icirLa6Tqifv3nArf7vAIlBn1F6Fn5lj2a81LvF9zLy464jvs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuBlg2za; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuBlg2za"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6128bd9b3so600297a34.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946483; x=1786551283; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xB9c5ioOsoU7YRqllaZjae3d00lxOg3IiwEUaaVOg2M=;
        b=kuBlg2zaGISOVjEqI5Ir+FaJ1LNkELYKO0p/uxK5By2OXlOiFDyzOMHB9fE3BCIO59
         dUNqSUbDpKxm/5DSYrSpXYySloDjAbMLd1hsZB1jUZ6HSm/jkcHpFqKEt4ZqoOaGxrFo
         xPJssIu8fNlh/4o8Q7vUNwdUT6ihwL7X5OMzB7P6edYldrXnF45z9ACWDwsGkGcZKO3a
         3sAO3S5OQZTQUjAPGzMgFwjZrOPQrcs2ryMP4ckNKawjyT4QaOm6ZN/TS0u58LZ+WSo/
         6ReGp1ySSCuOi8GfgFg8zBy5smweR2ae1XZlb/5FvfHwPkLeUYCAGTS7e9nlhR7Y4xhM
         bnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946483; x=1786551283;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xB9c5ioOsoU7YRqllaZjae3d00lxOg3IiwEUaaVOg2M=;
        b=NW4mhnXVsI3/swIV07TRm2vpZGB57qGPvJAdJaLPk0dGLdTqrykVoVAEpo8d9ghXVi
         dZxk+bklClVjw4cEsYPvpiuHUE2xHNkP6i+qEcJhvY/k5nSDWLqkmqD//47mIZtuiaYT
         4bdLFx0JU9+JV5l3WjbxOg2006ySjF7Lb7xah9lwffe2cwjP6fFZ2Xg5PQu0BqKEWml4
         iwKarjdMOH02OczhpxhdYFOPBxckutRrGkwd44+fA1eDo+Xpcch6Lr9PKB3lttFJyA4N
         pOrNtyWn0pgRjodtTQrIn6XQO2qWZOIvxXGnJ0OXCNenvmFAGKwFNPqrYXoLj//gT/Oj
         6mXQ==
X-Gm-Message-State: AOJu0YyQQwwbqSw+bacBkFJW8lZKrRXODslNiXPQj9wSuK7CDB4NU5GA
	RWvgihVycdwyQ0N10fZiGnVfR+EWlZ/GWwWUCHtK3zpy7W6jN/mwFPCVIO+7wA==
X-Gm-Gg: AR+sD12/WamQOC1H7hSoBlRQK2ZDeZuRNMWLz+dNzfszBCzsdL6mDyzZaDah5ktnLOn
	kkf6Mh1qv/eoVx0NV9r2WY9aCFGWbrTWcUI98ba+3jZIs+r2/WCj/CJVfUWbn7wc4BaZIwl3K+M
	H3QIpwL4bK0Vsuu0X2pj2u22WHV0khe+d/CoKCQ0Lc/X9CbMW5sLmQlUtL7dI74Lxghgs4eJYMM
	DyAWGD9ejrVvUgKZhWlrYZ2xqZ5SeFnG8c2LVm//CI6Iwvh1/Ng9ydDU/SFYO6kRh2srrJ2Kf+3
	3BKo6qHwPe3nFDuqtGrgeGpdZ3wMKi1gqIbyq9w1SI5RrAz8E17/TrR86zzdrj7CXUZKVBj7csm
	gCybFVTAq8UR1IxrfzUYmWon8geVxb3F/K4Oj81I5ETOQlLT4eB78zs3xxP/ma9I/hKgAtl9rJO
	dg2BigrXKME4b0JWY09N9IkZduNYiwi7MjdgQzrJXJUvUtj6Fb0kiwD0j9itNNRzFbxqaTQMN+H
	eoQ
X-Received: by 2002:a05:6820:410a:b0:6a3:f597:7552 with SMTP id 006d021491bc7-6ae970b956bmr3787488eaf.35.1785946482740;
        Wed, 05 Aug 2026 09:14:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm3236667eaf.7.2026.08.05.09.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:42 -0700 (PDT)
Message-Id: <0012c1007bc5d0e6ab143a0ab8201456e4f33a24.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:28 +0000
Subject: [PATCH v2 01/12] diff-delta: widen `struct delta_index`' size fields
 to `size_t`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Preparation for widening the delta-encoding API to `size_t` in
subsequent commits, which is what lets pack-objects drop the
`cast_size_t_to_ulong()` shims that 606c192380 (odb, packfile: use
size_t for streaming object sizes, 2026-05-08) had to leave behind in
`get_delta()` and `try_delta()` because their downstream consumers were
still narrow.

The struct is private to diff-delta.c, so widening its fields in
isolation is a no-op at runtime: the values stored continue to fit in 32
bits on Windows because the public API around it still truncates.
Splitting it out keeps the API-change commit focused on caller updates.

Since the `memsize` attribute is returned by the `sizeof_delta_index()`
function verbatim, that function's return type is adjusted, too.

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h      | 2 +-
 diff-delta.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/delta.h b/delta.h
index eb5c6d2fdb..ab0279168c 100644
--- a/delta.h
+++ b/delta.h
@@ -28,7 +28,7 @@ void free_delta_index(struct delta_index *index);
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-unsigned long sizeof_delta_index(struct delta_index *index);
+size_t sizeof_delta_index(struct delta_index *index);
 
 /*
  * create_delta: create a delta from given index for the given buffer
diff --git a/diff-delta.c b/diff-delta.c
index 43c339f010..9e1f9e6f95 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -125,9 +125,9 @@ struct unpacked_index_entry {
 };
 
 struct delta_index {
-	unsigned long memsize;
+	size_t memsize;
 	const void *src_buf;
-	unsigned long src_size;
+	size_t src_size;
 	unsigned int hash_mask;
 	struct index_entry *hash[FLEX_ARRAY];
 };
@@ -140,7 +140,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	struct unpacked_index_entry *entry, **hash;
 	struct index_entry *packed_entry, **packed_hash;
 	void *mem;
-	unsigned long memsize;
+	size_t memsize;
 
 	if (!buf || !bufsize)
 		return NULL;
@@ -302,7 +302,7 @@ void free_delta_index(struct delta_index *index)
 	free(index);
 }
 
-unsigned long sizeof_delta_index(struct delta_index *index)
+size_t sizeof_delta_index(struct delta_index *index)
 {
 	if (index)
 		return index->memsize;
-- 
gitgitgadget

