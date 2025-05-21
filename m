Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A122B581
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858590; cv=none; b=D2rCfz3Z4LZLnr28YSem06V1lIzh1X5/kJz2yAfuXWEcE1vC8+4Kv5s003YMQ15CpH7+8ThZaXv0hLBVw4qE5KlRt6M7TotLDJ1+eNbeilZ9kuz9emJ4GlNPQD17P2pQwTafs2t9F1rCM9QzTm9WrPLaRMfUrtwsqWw/F5Subwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858590; c=relaxed/simple;
	bh=wFvY2PcYkPmqO1Zp784Hs+kgEbeWdS7aA3XQ28vC1tE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=REytFO9Dc1PDtHhkDqm2e5wq9wGRM++QC7j/UuTR0yuQ1V/q1+ZD36rW1Vh+JAAhYiH3z5egPpHP3Z+8F3UzDSDflx+yrEKTkGatmXyTX7TvPu93cCgbXU5eoQDaMJfsRQBJecWzMX3Bv+QHfICzI+nMtUps65hQSzOyOHvsEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWoTa4nX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWoTa4nX"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a3683d8314so4043142f8f.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747858587; x=1748463387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZP37l/chcPNPeLWMmKLv6aL+ag+itRUIZ/2uBAaoRA=;
        b=AWoTa4nXWzeedIlu9ZRWfP6DtQF6m6MvVREJxDji30aSa/WGZ2kbrvOKSU7+iG79Ix
         2FS09vv3QhXTwgaX3LOMt7xoHH8ZVxa7PsxWwYZEIjEDzisFM63VZNpw0x4/W9aBPCiP
         fwgdJ3Dt/s5haXpKkbjfCe+Vj4FEQaHujubei5EoUcbwWDs0Be7ZWPmBiZpRwhjkquu1
         NzMFYwoYfvkY2YniQ3fVO2heADc7YUGjM0yvQek/FN0dzdpOJqOMX7KJGPaf1tZYpV7p
         DTFLxeJVauZdye2bFZfc8t8T4fr7ri8oH6JbzDQUOdrSa1bLN91FKOaUzLs0joI0z6q4
         8Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747858587; x=1748463387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZP37l/chcPNPeLWMmKLv6aL+ag+itRUIZ/2uBAaoRA=;
        b=vP9agYHrw7P3JLRc+k0/1zWGGJaJM4Uju515ng0ewyUceBEHg6B4jN3HIBHDxr/K8U
         a6OCNAKIWdqpgM4wNMLCA00sZMbKAQQKSrnp5uCZ5utTnNLQmeHkvaDsy2pvfqhUsK3Y
         P+ICyj4kmsJnCih5uuzTny/RCAMYMy3UYLgO7BDQ5dS6f473qI+3zDBmp+zpzggfeBcy
         5+0GmU06P6AXo3cY9BVNjLke8atXM7L686vo66ZPdMUetZONi+w5ykRgq7NaJq8tohCx
         bv8HPBRxLYcbrIeCQI/KZHen22n1WsYXD78NaCaBqkfor/cG7Je67TDu1qm1pxQUQeFi
         HcaA==
X-Gm-Message-State: AOJu0Yw9BPAlh9iSg7KfJCz8NFT56Gk9LT1wmv4ygckpZkshdrSoZgyU
	IdGYAvLDAToa00DPehAXaiicKsWkh5QTDswDTYaw2cv3g6U5hx7JJiKaLGZdGA==
X-Gm-Gg: ASbGncsEkE+snYagt5Gv1I6uDSA/a+kPPHYXZYUvNaDbv342+WkolIL2mRpYSCIBLod
	BtAZUU/YKlaGE+cMFLUY7QaMpDjH5TCqhkHkovGUQut0tJR5wDBlihha2L4LuB2vGc/D2ZINyjT
	IFldRoZjN8nxHzvDPbxxLpyFtkuglANUwuHJWca80KKLQfVeZbsNfOVo8bAXIkSmJDnXdZbbBeR
	9jyurFFD3YHw3x0ejQPvxqJQDlnmZyxfngec/60aqcrLhVXjEeftE0gHZlJCKl/4kRFnahdzzW9
	NIJGh4BPWYl6LtySEioDACmtb5RodCmj+ABbgdB+1wpLN5NRAVQW
X-Google-Smtp-Source: AGHT+IFVjGHEQ13CJkUJsBV1Gz2SKdPeTrnkV21Utn1IPadjeDXOvzwQFJO8DHS4bo6+1fTx3pvRlg==
X-Received: by 2002:a05:6000:178f:b0:3a3:7435:9a30 with SMTP id ffacd0b85a97d-3a374359b6fmr10087709f8f.47.1747858586676;
        Wed, 21 May 2025 13:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca9417dsm20384707f8f.101.2025.05.21.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:16:26 -0700 (PDT)
Message-Id: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
In-Reply-To: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
From: "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 20:16:25 +0000
Subject: [PATCH v2] name-hash: don't add sparse directories in threaded lazy
 init
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Alex Mironov <alexandrfox@gmail.com>,
    Alex Mironov <alexandrfox@gmail.com>

From: Alex Mironov <alexandrfox@gmail.com>

Ensure that logic added in 5f11669586 (name-hash: don't add directories
to name_hash, 2021-04-12) also applies in multithreaded hashtable init
path.

Sparse directory entries represent a directory that is outside the
sparse-checkout definition. These are not paths to blobs, so should not
be added to the name_hash table as they must never be queried.

Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
---
    name-hash: don't add sparse directories in threaded lazy init
    
    Changes since v1:
    
     * addressed feedback (code-style)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1970%2Falexandrfox%2Ffix-threaded-hash-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1970/alexandrfox/fix-threaded-hash-name-v2
Pull-Request: https://github.com/git/git/pull/1970

Range-diff vs v1:

 1:  d12ebc612c2 ! 1:  fb378147c73 name-hash: don't add sparse directories in threaded lazy init
     @@ Metadata
       ## Commit message ##
          name-hash: don't add sparse directories in threaded lazy init
      
     -    Similarly to 5f116695864788d1fe45ff06bfad7a71a8d98d0a
     -    make sure to avoid placing sparse directories into the name_hash
     -    hashtable whenever multithreaded initialization is performed.
     +    Ensure that logic added in 5f11669586 (name-hash: don't add directories
     +    to name_hash, 2021-04-12) also applies in multithreaded hashtable init
     +    path.
      
          Sparse directory entries represent a directory that is outside the
          sparse-checkout definition. These are not paths to blobs, so should not
     @@ name-hash.c: static void *lazy_name_thread_proc(void *_data)
       	for (k = 0; k < d->istate->cache_nr; k++) {
       		struct cache_entry *ce_k = d->istate->cache[k];
       		ce_k->ce_flags |= CE_HASHED;
     -+		if (S_ISSPARSEDIR(ce_k->ce_mode)) {
     -+			continue;
     +-		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
     +-		hashmap_add(&d->istate->name_hash, &ce_k->ent);
     ++		if (!S_ISSPARSEDIR(ce_k->ce_mode)) {
     ++			hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
     ++			hashmap_add(&d->istate->name_hash, &ce_k->ent);
      +		}
     - 		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
     - 		hashmap_add(&d->istate->name_hash, &ce_k->ent);
       	}
     + 
     + 	return NULL;


 name-hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index d66de1cdfd5..b91e2762678 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -492,8 +492,10 @@ static void *lazy_name_thread_proc(void *_data)
 	for (k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
-		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
-		hashmap_add(&d->istate->name_hash, &ce_k->ent);
+		if (!S_ISSPARSEDIR(ce_k->ce_mode)) {
+			hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
+			hashmap_add(&d->istate->name_hash, &ce_k->ent);
+		}
 	}
 
 	return NULL;

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
gitgitgadget
