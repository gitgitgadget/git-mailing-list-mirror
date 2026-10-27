Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120163;
	b=YJk3rB4aE9DFm08U0fgav9D4XUEsisDV838m9GHd0V3XDk0X9T9AeZ21TdqmZ1BjDvnB
	 8+fZEMP2fzWV7/ocCgm6YDmUYR8ANLEbBgwNQUYSi1BMRue8WhTjyRXOm4HU059SFoHfw
	 z00hDVfwR14obGOA1vpKFz4z1hYZjv+YlHmfuWPFMTR914EPdBnqGuh57qO6ub0cuMWPE
	 1YTveOqQzcAdsIEWrHEfiv4VS25EKgR56kyJSQPsg1TYgEcRE+kdcJJcFqiqhs3DSvqEz
	 HDvjyQkXNxSlm3ItGyWEzgEqzfi0NoKSQYymqP9S2vBhSdHUCD7c5lbv+iz4RNUHjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Fcc:To:Cc;
	bh=O8WTqs9aVWBXyHmmhTlUZwCDURm4xQpXOcbml7catus=;
	b=d4vSLS4Fxr9pL0WI1gJ6uzA3rJJa43fZWsQoWWiaAsXKwNIAGr/IbYO36yCrUGmBE2ge
	 dxXmdojAIL+i4wgEmezcz9NNBVQqhphOdHMtvGbRyRcb0Mq/uejPe9y6sOanzwroS9sJn
	 CLSgVG9rZEzYaHVH5viaQorf2i8O0mKirf4uSKF/rlMwFPyUUdDsNMFhaTtDkDG38ITO/
	 cjHXp73apeaoLAzJ31tfbJi/jo5y386DCFL0QGq+qZs/EYlX1CmHBCLD3qj5PmMqf2Yud
	 L0klWZ5hH1SWfwYEea96xNCMH8zjh/d5tgehHz5ocTT7J0wEOto6MC/a0HZW/6Z1tHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWaEvUDG;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31663606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31663606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rWaEvUDG
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so66467a91.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120162; x=1793724962; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O8WTqs9aVWBXyHmmhTlUZwCDURm4xQpXOcbml7catus=;
        b=rWaEvUDGXno9Cv5+jbD4s9Tukorssy6PnhTFNMsyCuM0pNIlmPyeAOt/w8HCLB+wHV
         b2HKIHODY8ifE3gCzdF5MiB7UFzVGg5y2aPJVNX0Ww5+Jtx5U+ANxV9aEc+CUGfxtLRA
         Bo/kiWt9u8r0tF6j4Pob0I3Pk6J6UpSOiS2WGopQ07WP+xHyMtdqo/ENAgBvfIs5RjCe
         0eMjN7j9eK4xyF7OpeBEQWBQVkoTrQZEiECGVfCvt7WMqYsElqXZN9Sg6dw7ugiRKphx
         gFnpRbzqDjCLc0Rvn3mh6jys9dqsvqCWeMbasnx/z9LtcZMfwVb6mMJi+pzJrFU5/QPH
         zc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120162; x=1793724962;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8WTqs9aVWBXyHmmhTlUZwCDURm4xQpXOcbml7catus=;
        b=iUMc2CVT+nurQFT7brIG1tyf28xSBfzLM8cE9Bj3kXe1QAfRSHESKejMfGJJTshFh9
         HdNr6Q9Sl4MfEChF5TswKoUttqI9E4nYhm13BvH22lEDyFnDdz9jMDrKVid3st4C/4Wo
         ihdDE/WDivmXHU03uSlhizQ2hw/QmUNMGeAxjhopusAqISW6MdvLwI1C9LiazJQMvWxJ
         4Pf3U+LmlKwPmgMm0hoDNJ3OY6xBYuY0uszOZB+ThkXo13fsaO6u0fezNKppjZWSXb6e
         eUl3JwsXwe7J4FwEMVMt5w9AKxSKGbKckOVHmkelrNFLZWJYZbfnZt+wvA6z6qTYoqTc
         hyUA==
X-Gm-Message-State: AFq9FYKWYnwsNVWNzSNiDR3UMG/ZhhRKag7Yhz63WKaFjTlqMXdaIeT7
	boyXp2hmtnmDKbk4OLLFmGlSrh7XKwB8ij6j+KOBlq20Q5RPxPj37ZvNOPBVlnR1
X-Gm-Gg: AYBFou1hLrR3obPsZAdez0kjYCmtGRrCLwnEK/26wqVK62DS1fHH36nEI//4/znHViV
	V+2X4fEc/QdlOBAqd0g/qiSyCfg3E5sllEQY8EReH1DAVSwUadyGb5016d3BcXGnd7SpRWW8Eee
	5Dg6sPPsaHQkGqEModWnX5t4iKWtKdk17kPG8gdU/esKl5Y+z3SvzyUNAKe4oByPa/uQD2bNxjw
	OHPDwQyollFlxT04WGHIp8dE6MmCbYHEfcCjpTuKBa/RbVglPubb+sLO5R6NcDS+sVDj0A86518
	yPqafrHu3Xkr0z6aH21zO5ay7I+1INQtEMs5z3kLSd9/K+LLa+HKUCyKO9KCSpRaM2hZkECBLoC
	4KB6w8/Fbx5i4m20Tu9Aiha/ArY13ygp0REK7IyJFrgof7bfQVrjUnCimVpmH+da1RdxKgaG8ao
	GdE1x1tkMtLO6RgV81IWe9iIbACZx52WDBeG48Ji9mV4Ic+jh2ztsaMnzs1CVcsIe3Ueo5kgWOT
	ySGz2ea2+BkL5H8JzjTWw9c1bvus4loeGIwxSbJT5AdwqB11SN9BStth+Q=
X-Received: by 2002:a17:90b:1b03:b0:3ac:80dc:f409 with SMTP id 98e67ed59e1d1-3adeb1713e2mr7729770a91.61.1793120162284;
        Tue, 27 Oct 2026 09:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5571a461sm205928a91.9.2026.10.27.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:56:00 -0700 (PDT)
Message-Id: <pull.2276.v9.git.1793120160248.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 16:56:00 +0000
Subject: [PATCH v9] diff-delta: use safe integer arithmetic
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

In create_delta_index(), buffer sizes for allocating the delta index
are calculated using arithmetic operations on entries and hsize:

  memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries

To prevent potential size_t wrap-around when computing allocation sizes
on 32-bit systems, replace manual arithmetic with overflow-checked
helpers (st_mult, st_add, st_add3).

Struct sizes and alignment rules (such as padding for
struct unpacked_index_entry) are implementation-defined and can vary
across compilers and platforms. While current bounds on entries and
hsize limit allocation sizes (with entries capped by 0xfffffffeU /
RABIN_WINDOW and hsize capped at 2^26 with a minimum of 16), using
st_mult() and st_add() provides robust defensive programming—ensuring
that any future layout changes, compiler padding differences, or boundary
adjustments will safely die() on size_t overflow instead of wrapping around.

For the packed index allocation:
- (hsize + 1) is passed to st_mult(), which is evaluated as an argument
  inside st_add3(), and is safe from overflow because hsize is capped early
  in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v8:

 1:  0b88f5a10b ! 1:  1be2ccdf19 diff-delta: use safe integer arithmetic
     @@ Commit message
          on 32-bit systems, replace manual arithmetic with overflow-checked
          helpers (st_mult, st_add, st_add3).
      
     -    For the unpacked index allocation:
     -    - sizeof(struct unpacked_index_entry) is 16 bytes on 32-bit systems
     -      (4 bytes for ptr, 4 bytes for val, and 4 bytes for the next pointer,
     -      where "inner entry" consists of ptr + val).
     -    - sizeof(struct index_entry *) is 4 bytes.
     -    - entries is capped by 0xfffffffeU / RABIN_WINDOW, limiting entries.
     -    - hsize is the smallest power of 2 >= (entries / 4), capped at 2^26
     -      (with a minimum of 16).
     -
     -    Using st_mult() and st_add() guarantees that any allocation calculations
     -    will safely die() on size_t overflow instead of wrapping around.
     +    Struct sizes and alignment rules (such as padding for
     +    struct unpacked_index_entry) are implementation-defined and can vary
     +    across compilers and platforms. While current bounds on entries and
     +    hsize limit allocation sizes (with entries capped by 0xfffffffeU /
     +    RABIN_WINDOW and hsize capped at 2^26 with a minimum of 16), using
     +    st_mult() and st_add() provides robust defensive programming—ensuring
     +    that any future layout changes, compiler padding differences, or boundary
     +    adjustments will safely die() on size_t overflow instead of wrapping around.
      
          For the packed index allocation:
          - (hsize + 1) is passed to st_mult(), which is evaluated as an argument


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..efebce3aca 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+			 st_mult(sizeof(*entry), entries));
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
+			  st_mult(sizeof(*packed_hash), hsize + 1),
+			  st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
