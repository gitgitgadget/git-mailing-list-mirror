Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864859;
	b=MPEPXEHyX3IS23nqfi0aNZss81W3xGVBgU0S+lV38cgueufKDK/BMhgjftlRnRF6MGse
	 e6oLOFSSxDfvIWmbTC9+6h3l9HQM+ZnM77vtJozyQhazAspYjdj8pkGZJb2Mzq1mHUp4V
	 doxrGNJn5GaRwm+nPLFf512GaCkX+8HlVT44SzBDxTwWJMtECYADQfJsNtqcU2JA1fXNA
	 y5MsxihMQTv5DVEgfaOic/NXTrM0vECwMk1uQBV8txZYkOG4p7I6wohWkxKAOULy9sISQ
	 /c1FrwI/u18mMMeGs4cBeMEY4/brmBKTmdy8xbXseD/UHtklK89jHnfueQQtIHgob7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ghv0QqGCNosXzQ1jVt7KLzGVxDuvOwy+l20G5T4gD8s=;
	b=nfODw310ZXScj4iSmtFwMyaK0NTaXWfQUGvLTkIhqXNWI9i4DXVzReV8f9qQWe1DTrTd
	 +ZmZ/BE7X954nRalJ/oGD330xzE9yMLmKlrbtNkynyMV2y1d2CFTPimO/4LonU3+HQQl2
	 ze88nRtU+xxxMXXuXOJpl4LgfGBeEcRWapFMbN+m/NbkjYWolwhrfy7VCg/uk0qOXbhg7
	 8HyzSdzh0wiWhpKGSPbP2un8dl9du3yITxzpuYQ6qqfgWSBYpdFlzK0kYtxw447uWnG+8
	 6gXNlYUnJEJvwQn590XyIyjqYH/OL2UgesZOOT17grOabRU01YW5YYTVujVhWIX+EDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DdosRLTI;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB72606A31D
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB72606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DdosRLTI
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1319477a91.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792864858; x=1793469658; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ghv0QqGCNosXzQ1jVt7KLzGVxDuvOwy+l20G5T4gD8s=;
        b=DdosRLTIcRz2+VGs3NVJF/U8mzWOXnXYDzfrRdZ/NoTgZOrVGTdni14ztyu9UQGHqu
         7At/h0PoBi89XlZ2grCr8HPOWSTpZgnOlfitJLqliWr15uNVDLBEtbOAKwAld6/eUEYI
         7cuPOP3q78ubQCNXdrQkQWPj7PhCKU7a5H2lCSQrET7z7MlUaQmdSaMot33vwAArDMTs
         cSXVukFXGs0uEkpqEfeiyiUCgkPxVJc6GmQohoYCzKlZ8k6TeMN5RMz87vLdOF5jnjSr
         2ZFyGcDE083CiSqklQqSzy4ay2kFlg/msxxG6Dcyp9anCJCZ+Z1Dee4vdUTwlyp+uQLD
         6MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864858; x=1793469658;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghv0QqGCNosXzQ1jVt7KLzGVxDuvOwy+l20G5T4gD8s=;
        b=nlWkIWD9suC5TYrqJ/h2Qo0pditoCyhTrr2MgtlQsqa30xvJ0b/JhF5puOrphOKUg2
         9nn6TfB8f07prv1I8C8wsrVKBUvct/PyTR9+x/+juK5S/Mi9Qfs/hY0cb2YgnZvP02dE
         bVqfICQQoCbkku1EGbYt/dD8fVxLaRShASFVKx7heHq0yNAu04D/mT3fAKpWtXOZ5JMG
         LLSPvR8o1ucV+l1+7gFZGIzpZp8zyoN7lyn00+JEMDMew8Tqt7w4lmL/LD3esWxIKCqQ
         hd2Vybo2jLNvGhBr/nI7yOudTg4bC5m2AA+v+phL//fZ2MPxTnO16d6JAEnTgyqAsPii
         xtDw==
X-Gm-Message-State: AFq9FYIZZOLWnMmhqXoPhQe5N6/xsltSw4pCSGVJcsIQsBTCnY4TI39C
	gA0P0K6wMVzGQuGlKAJ4Smj4hJNWDIb8Cs/fVCRL8KVlw8ufEI/jYHwa2+DNGX6n
X-Gm-Gg: AYBFou0Vm728hmVJSuC+MmxTOz1gEWkjvPZ6F3ejJHVqNuT3mWK0ZD7HbUjKYQ3Z+tf
	/KspkeBMgfN5figeFxZiVJvVZGzIb6pwXoZrVOylgoN2VHPbJmehbExwiZFs840GwdRbyoqH1bY
	fULZ4nwvJnkxQQFsdWWkUg3H29043fVCforJnfo5FYfvuRjeR+InwpAl1WYd7RIIrITLXE/G30H
	DhEp2ZmH8pjubZFTTyTmoPF3VpxuctaQ+/wlR5Dyv+R5AvXWESCBC54O0T11to0eR2pPr72y6m6
	W2Uq1zcJYOB5e84zeltgn036KozjDox0gzHsK+wRwXyGQ+e/Z9bohEpE7hp+LFwbpt67eVWNv9q
	v2BwdZqsyCOcgZ91Bg+YjwkbXAwvpsb98t8ndcplMSaNkhoKg7l+7Gxhpkd7IUToQpVwJErqRw6
	oQSDQC7dqRpmOj0qHA+CJR+zta+FTt+MMJ299cXFG2lPeFaXSemXX/W3JFgy2Tg0bcIhYyFAZjx
	yRUhRSMvywmeGsOLkAVwZugFyZ5e9PVMgcglY31nzvrw/WXoeA2LNWw
X-Received: by 2002:a17:90a:e7c9:b0:3ac:96a3:77d5 with SMTP id 98e67ed59e1d1-3adeb0f4e28mr2169200a91.36.1792864858226;
        Sat, 24 Oct 2026 11:00:58 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.55.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0977asm3392280a91.13.2026.10.24.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:00:57 -0700 (PDT)
Message-Id: <pull.2276.v4.git.1792864857176.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 24 Oct 2026 18:00:57 +0000
Subject: [PATCH v4] diff-delta: use safe integer arithmetic
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
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Replace manual multiplication and addition in create_delta_index()
with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
overflows when computing memory allocation sizes.

For the unpacked index, we allocate hsize instances of hash pointers and
entries instances of struct index_entry:
  - hsize is capped at 2^26.
  - entries is capped at 2^28.
On 32-bit platforms with 4-byte padding for struct unpacked_index_entry,
the calculation size (sizeof(*hash) * hsize + sizeof(*entry) * entries) can
exceed 2^32, making safe integer arithmetic necessary.

Similarly, for the packed index, we compute allocation size across
struct index, packed_hash, and entries. Using safe helpers prevents
wrap-around across both allocations.

Note that passing (hsize + 1) as an argument to st_add3() is safe from
overflow because hsize is capped at 2^26 early in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v3:

 1:  d288bfe9e3 ! 1:  0d5a729cde diff-delta: use safe integer arithmetic
     @@ Commit message
          with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
          overflows when computing memory allocation sizes.
      
     -    On 32-bit platforms, struct alignment padding could cause the total
     -    allocation size calculation to exceed 2^32, making safe integer arithmetic
     -    necessary. Note that hsize + 1 inside st_add3() is safe from overflow
     -    because hsize is capped at 2^26 early in the function.
     +    For the unpacked index, we allocate hsize instances of hash pointers and
     +    entries instances of struct index_entry:
     +      - hsize is capped at 2^26.
     +      - entries is capped at 2^28.
     +    On 32-bit platforms with 4-byte padding for struct unpacked_index_entry,
     +    the calculation size (sizeof(*hash) * hsize + sizeof(*entry) * entries) can
     +    exceed 2^32, making safe integer arithmetic necessary.
     +
     +    Similarly, for the packed index, we compute allocation size across
     +    struct index, packed_hash, and entries. Using safe helpers prevents
     +    wrap-around across both allocations.
     +
     +    Note that passing (hsize + 1) as an argument to st_add3() is safe from
     +    overflow because hsize is capped at 2^26 early in the function.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


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
