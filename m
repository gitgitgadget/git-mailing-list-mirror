Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110865;
	b=oStvcB1t8bIUaJ6PiLnmkSRmxVENf7LYoU2oMUv7MJ4aOyht+L55aoMr6R0upPLDUGkm
	 b4Nt9wsbWO36DMldZ/3r94O1GT9HXOxrZhwlaxXW/jnWNf1hkq871zvpOjrrQbzFVKSdw
	 g31BREedeNJU1i2VC7D7eKOGC9TohDSLaepms5dFYz6RjM0Fkk/8KteUT/cDOnMDDuJQ/
	 v1Ok0F42IgiJlS2z3uHaWSp2lFuWn4JICjJH4l0zntWmR3HMR6QX9fNnaRpR9RxTAAG81
	 7gXLK++l48IGQoRtp+A9ZkwsoIqA8mbHks4Qf9HpY0MiwvIUCDDIL5YNpT4j6yFs60A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=izlnucM5kuP9L1/DoCotA8xnDVTF2Bzo8Q7X98NJKz0=;
	b=sqcQgtW7gSISjSY8+86ap6E4iFJV/Yrci9AEpj8Jhn/oMnsHClyk7vkU/j3t/uYUXaes
	 lSoRTUNkE+llBdtCwASyn6QOuILYDpYL+eHGX33VRa0hh/jBGOuUB23p4j+bo4Oqu3WtL
	 2h0jOKN0fnAtNUUMvvPMrcNYgtkFwkE3CltsC59FM1MX7Y3sTIoQv2Ef695rGbPi+MXyr
	 vELik0pVOPkdjeU7utpq+jj2YKRNIgcaw9AcGK3WQLlRY/mE4ZFj8IRELJ2Cz6HOHFH5R
	 XiEYviOUJ167NBGLv+qba+VI8E68CKZGUykIjf843UZU0ZahUM5rlP0anXQsle7jhCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Z/esB2P2";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E2606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C3E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z/esB2P2
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5366463571cso49096041cf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793110864; x=1793715664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=izlnucM5kuP9L1/DoCotA8xnDVTF2Bzo8Q7X98NJKz0=;
        b=Z/esB2P28hgP92pw/YZygHzq+tVy8X49zKOXobN/YphNZYdTyF48idmcaHu03A/YC1
         hFSj/C2IjXIZ7mPwR+h/AimmBhlCMnXIma3/K2FziJ4YjvQrG4EuGyHX91n5tkzWYK+y
         4XtRF/Yad0eKZSR6wddQeMFEziGW5TDaLFuPuR49MwtUtAVbvD2YKofbHNAbHKpGGiqb
         AASRiusQqkfzSuI3QeDC74tquREUPqcsJLe7l7avZuzS5a2kWHG/hw2KZFihqJ4T8cTj
         D0TbxJyEHkW2Arg3rYVksep1MhmbPHxB2e6zpw6uXEl2PcNF42bit967BFa/ADtm/2XJ
         H0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110864; x=1793715664;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izlnucM5kuP9L1/DoCotA8xnDVTF2Bzo8Q7X98NJKz0=;
        b=x7FLiNkNWRa/SnKuFXv2GPqR1vMq2VBYxeYPzlWjh/QyOBKkJIW1JLPSqj9DEs78Wh
         oz7Lq4vSnnXI9JsLqcJWgD61b2t/nVEirODbwa2smMBLApbirHucBxxgybiq0Qym9/LU
         8rx+/yhCB7c0TaBkWYVETrCpODRbp9iNEvLqz7wRBe9un77d6tZvwFPlUNYmIeOekwNP
         OW6GdDkAyKHs2Xlcvz4hSSXOCdahm81u/vDujEtemR2RMhcNPhgh4zd2dukR/PsYac0G
         XAHu/6VjnvM91Wx6gFQtpoV9iExNyoLpbsKum1a6YYiG9jNx3UcVhIq/f2SoolFWYXy1
         lbYA==
X-Gm-Message-State: AFq9FYKJJ0eNSk7eEqgclsPF2B5uwu+v0VXx4/xq9t5aq3w4UWnDEdXw
	LMn9902/G4K8J6XgxPxI/nJjg9kWjQERwKKcEuJ8dd2f/6rokMPdw3t7ZIGnvqFg
X-Gm-Gg: AYBFou0vMNqLMX87eipjcZN5gPK1srcKo1of6C31sYj8MQYa4jCB4CJpIgfpUba86hC
	fQ8Fm0NlOAX1eD6bwazLSTEwA/mOQKONYeHnKHADjjN7arm3yOHFOkLFvXBhkzNKo7rwFVF3gSw
	y3aohR3/UzLleqdbo2axedjI7Gdmhagy7ry5bDOj2U8eNtXaDnu0Wx/DSt+9ULzUGqmxX6t+ZbY
	JSZl2gClEThW4kueZsW9auaITwROUISpcvR6nM2kQoyc0NW97ULi9FrB8B/rTp/oxZpF0vxqsFt
	i2NFD5feB7MeKvR7/HrDs5cLcF3CYDKuxzRXkI04NkeiX6ON7Ylku6soPAW37hh0KgGCj3Cxf+g
	lgr2zdnSw4lbDpwInSbN/Axo1I9XZmVF/Cc0uMfcmCuuIZ7VuB+NBpQCR8OiaYv1zPCG+4SN41F
	UPqIJa9OClUxLSRPPqcjFfMZZmB3lseghQv3Jppq3xNRGO2w6qf7XdrXQd+VFsxOZWESQhmhLFq
	senzFnjhyNdTJN92VelF1JSZ3oE6D6CtjMxxCLaPkAXIp1eJHO+k/wXcA==
X-Received: by 2002:ac8:5756:0:b0:536:780e:8f42 with SMTP id d75a77b69052e-5383b667071mr168476741cf.33.1793110864222;
        Tue, 27 Oct 2026 07:21:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cb4f56sm105386586d6.35.2026.10.27.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:21:03 -0700 (PDT)
Message-Id: <pull.2276.v8.git.1793110862959.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 14:21:02 +0000
Subject: [PATCH v8] diff-delta: use safe integer arithmetic
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

For the unpacked index allocation:
- sizeof(struct unpacked_index_entry) is 16 bytes on 32-bit systems
  (4 bytes for ptr, 4 bytes for val, and 4 bytes for the next pointer,
  where "inner entry" consists of ptr + val).
- sizeof(struct index_entry *) is 4 bytes.
- entries is capped by 0xfffffffeU / RABIN_WINDOW, limiting entries.
- hsize is the smallest power of 2 >= (entries / 4), capped at 2^26
  (with a minimum of 16).

Using st_mult() and st_add() guarantees that any allocation calculations
will safely die() on size_t overflow instead of wrapping around.

For the packed index allocation:
- (hsize + 1) is passed to st_mult(), which is evaluated as an argument
  inside st_add3(), and is safe from overflow because hsize is capped early
  in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v7:

 1:  8eb6d31788 ! 1:  0b88f5a10b diff-delta: use safe integer arithmetic
     @@ Commit message
          helpers (st_mult, st_add, st_add3).
      
          For the unpacked index allocation:
     -    - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit systems
     -      (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, and 4 bytes
     -      for the next pointer).
     +    - sizeof(struct unpacked_index_entry) is 16 bytes on 32-bit systems
     +      (4 bytes for ptr, 4 bytes for val, and 4 bytes for the next pointer,
     +      where "inner entry" consists of ptr + val).
          - sizeof(struct index_entry *) is 4 bytes.
     -    - entries is capped by (0xffffffu / RABIN_WINDOW), limiting entries.
     -    - hsize is determined as the smallest power of 2 >= (entries / 4), capped
     -      appropriately.
     +    - entries is capped by 0xfffffffeU / RABIN_WINDOW, limiting entries.
     +    - hsize is the smallest power of 2 >= (entries / 4), capped at 2^26
     +      (with a minimum of 16).
      
          Using st_mult() and st_add() guarantees that any allocation calculations
          will safely die() on size_t overflow instead of wrapping around.


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
