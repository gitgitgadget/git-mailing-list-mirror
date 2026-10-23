Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734996;
	b=BNQwOgtQ9BbQWZKmdNv1XLQSZe2Idpol2daJMLkna4ezgifxYtCChYf8HZqDPvlSN569
	 HLYuHajoAFG9MmwveLuqmZlJTy39d1lxxDmqvTYBvokVHZbzSunx/gQN7zGvwv/aqgZVt
	 yI6FBqHLsKE8UKDV7MTKApY0s/dYW+ztR5ve33Otxb1qlgJcRNR9/jUxjQisouyr5lGOM
	 VRFlhhjwUZRPaVruuU+pkeRbLRkjbOKd8wIUrtiR5MAWqbq/PmQXsx1jETrqsUxScrG+d
	 MydErbthPrHeyzP4fTB0FhnJskCrQwjwfMARQPQ9ppRbXO4ynU7hNfXgWg3zkSR3D0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hkfIHZQWuMldMzbFWTwr4pLpGkj4uey/onj+IEAxXy8=;
	b=aOhq1F5/YkrgevCmQUrTgmkPpaYdzJxYaDWnAd5Cv5Cs9sMZFU05dRFYYhCo01PGChDg
	 CkuEy5ax6saaRFzD6qVyublSn3mgoIMJxuSVkzfpD/mFwdSAl0p4rolQFv19cVBxKsKBJ
	 nD9sMkTQVo0xD5t2wKA5EDRIqgBGLp6x4OElzpzhGYN5GApP0GUwyuQlfa9++W8+BOJWx
	 caGl3WQ5GzEIfUqWg6KK+mmmJ6U9+wRv5sdelrPO7DwFlNrv8CJSER7ZB0MRFzFSQbiOc
	 kPgTftJEKO8thQ4zjW8ob64gM5dISAnsF7Q4sH2nGX5EbuE2cymDQ66M7hkuuQN57Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzzcoRs3;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D4606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzzcoRs3
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b813ac020so9114946d6.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792734995; x=1793339795; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hkfIHZQWuMldMzbFWTwr4pLpGkj4uey/onj+IEAxXy8=;
        b=hzzcoRs31hkQGTE1e5va/ZjDUX8ycnTPOeS8oZKrBvXJoIBMPFQlYANqKaRTE12KSi
         eLrAMYVTlMorHBwMtvslxYjomOVK/NwPPTqMixLEgElQ6PZDeLvX+nBM9WwRHvFf6SBk
         nAzXKHLUJ02oitvjUCJMG5pyu6GtnCSMTojUh/NXIDv1DjavcehHqm7M2iT6cvkIcuHk
         kxlcIG1nZ0Tl80jI0YtIXKNkKycFMVBViHBqvcS443VUsMU3u6JamWDaK8N9hi+0XlxE
         51OddolekMrG86OYVRoIEQ8cP5TRmkFKvzm+/nYSFTDJiCSEakaszkVUFACxLo5SxFku
         aM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734995; x=1793339795;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkfIHZQWuMldMzbFWTwr4pLpGkj4uey/onj+IEAxXy8=;
        b=df3BAcOl0/NMh8fVYJz9G9k4PdVbOTbeHxjiEdy/Mf3E2jOpFLYX0H8VyJLeM14k77
         r35DNfWigtwv42DUSM7947hvzknfH6Im6zzdtQcze0+1sSqoOUTZkhhcJlg+A+5yeqVM
         dmXXiU1VqycKd39sI+1nvyS+H2DNvs7yqJnKrZViKvV8hUzjpZQ5ay6r52g4Ye6jA9NR
         QcgVRwyAmcPW9aMq2HUvKcdbadEE6Z3sENrVcJEwg4Sau2We1KYoQ0OFNjZ8OxkYW50x
         67ZmN2Zb+VXeJPf0D4vHAdqO2Y6fOis+qHVPOKiDrA0dyNCE5cMnSj2JgJijjw/9Js3Y
         IT5Q==
X-Gm-Message-State: AFq9FYJ3+ozpjY+9DU5h0m5uVonzwFI6yWeJSqcFZ+LwJ/zMjh/qH3Pu
	C/VIT+shSPAIZcuAnM0uatWL5N5I7Noe6siXnh15ycGC2Em3MnMnJzqcYCURd27X
X-Gm-Gg: AYBFou3r7ImOtC0HrHoIK85noE2T3Xr90qLl+jlIbFwYvO1AOrxeV/WQZz3XDx499QG
	hdr0GY7gZnxwn48NZAyOFiznKXtF5JOso8fZGKVGrP9BIj926KvovmslhaaVO7wo49NGZnaDPTv
	R/bZfVHP0+GtNo7DfZ0kW5mFCqf5H01N4G9KSo/VLPEZcYHZYki2Cyem5IZFG592yFWv0E5pw2Q
	Oely4qRWzGN5UKPWlC5L1veYV9KUJOwqzkr6NZYNrXY3MNjPxJzeQ8ek+kRnai3U9PDiwk4bG4T
	Ic3yaj15sWqkHmeI1SodxkpZ+eh+nAOEFE98XQ+gZRp8tAXFVjZRw4XvB4doL/JEqJ/2V/ASHeI
	vawMhchUI3uoYmD6n0uWo6DBN8YLzqjbdZd4aqxG2wtzTilubhYN2GJ8rHlr4O+KlTzf0v6NOsS
	o2FRtMW+VT8VpGSLU2H6gZcwpAv9jbDLIRm2QQd3tfcMpEoyjBz1viPP1Gw5MaXOzo1dvewew4S
	SE0ewJ/tO3X8gLBOBDm4i4Bumf7Bx9d0DEDHnwY2rPmKqCYecDWwD5ATpM=
X-Received: by 2002:a05:6214:19c4:b0:91b:b26a:9783 with SMTP id 6a1803df08f44-91c3ac6db6amr12395386d6.55.1792734994681;
        Thu, 22 Oct 2026 22:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.62.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396e33a6sm11935706d6.16.2026.10.22.22.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:56:34 -0700 (PDT)
Message-Id: <pull.2276.v2.git.1792734993812.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 05:56:33 +0000
Subject: [PATCH v2] diff-delta: use safe integer arithmetic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Replace manual multiplication and addition in create_delta_index()
with safe integer helpers (st_mult, st_add, st_add3) to prevent
overflows.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v1:

 1:  a0aafe63a7 ! 1:  14ffd630ca [Outreachy PATCH] diff-delta: use safe integer arithmetic
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    [Outreachy PATCH] diff-delta: use safe integer arithmetic
     +    diff-delta: use safe integer arithmetic
      
          Replace manual multiplication and addition in create_delta_index()
          with safe integer helpers (st_mult, st_add, st_add3) to prevent
     -    overflows while preserving NULL returns on failure.
     +    overflows.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..45df070ab9 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+				st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			st_mult(sizeof(*packed_hash), hsize + 1),
+			st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
