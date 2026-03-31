Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0736AB6B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937994; cv=none; b=SGTvhtpSHj+VmD8CBr4ypWR0LoIw5s/8aBOrV9Lk87wVVxqU5ihDQ731RxNaLMe8X5pL9Ikicofeb6hxylhEcNK1hyfaaYQSpnXb6t/UOu+53QFWIygCts3KxyYin0dEtrPGc5flCZOKxvMUdiT6ZN29Q7ZkW7WD6Ay/K2TlPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937994; c=relaxed/simple;
	bh=qqZvl9p05kIVO6nE6mWZf3e8pZn4kf5apGdqTe5NHfM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AEG39hPoqsDze9UaGemCUUrh0S44tZoYaUKIrjWQ0WCBSUybGcfYRhGQBtEPpRwkEg3WaG6SOanOQnM48rFyHnU9Z8RKBFqyeufxLly/nMZo25PxZjq974BZ4Zr51GufWfVPOXQq3qvEkGqHGUNtH9VHTz1fh1MGrtI9iUx6mAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwnTxhdl; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwnTxhdl"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d75371d873so5112955a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937991; x=1775542791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FDpa3SNk1bz7Uuj9GtWYNOnTgYj/q/xxHy178htTps=;
        b=qwnTxhdlRRA/v0jO9DhmEyOtJJwwpBJnFG0qob/g2mFAn4vR03RzY3vnTtXPG4d2Xv
         Ix0CnwAtjZCO+Zf9vo/mW3NzVIAwgN+YxHs2PHh0eNB3Bl1CH8gXLmeRtzxIkkJXTKRZ
         KYYa+ASHeaSuWfPq6Uh8BpD4Uwy8iZSSM9AqT4OdFc7kXYHsc0c8zMM/9mHVOtnITM8G
         +G1//58hv1E0tT+ozSROdw8sBUjXhv3p9Zn14+DKFB9QT0iR4ccbSxVxwjTa/wt0tekX
         ENjHnaNs4fs9mi7RXwaoXnZexE+JVBpqD7+z6UtNiuCZh447Il19NxaniMKPl+ec8wVH
         2ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937991; x=1775542791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FDpa3SNk1bz7Uuj9GtWYNOnTgYj/q/xxHy178htTps=;
        b=sPN2Neyc74xqg2l1GwTp3q83peMQhNM2BhlsGNZfvXtOGWSlxSLmLU8BklKNujsLzA
         iFXCL/Ffu+3VeOjqBM7tOIFN7jMW3c8B7UkOQp37r/fBJr+naXIifHl5cv+lpnGzfNxK
         3k0G3nUm4EgBGBY8WG04OuyC+JPrhxuz2+NaOTbEWJhIYlL7TXTnIQOuB+Qm8eX2aMtl
         HkUho7/flNoo5NTzfbVGNAWt0EnPbJBrw3iB6hpJ1PF171DhpcrmXCS7nBMPi70hRD8d
         3W5VlNvEewblUpXOloQiJK90qqFWGkXrur9PTszx8HGI+Odrxp+CFNuLgn8OMmL3jQwT
         MX/w==
X-Gm-Message-State: AOJu0YxcVb5dIv/bgXdMKGF0Jyaq0DNhzgDYADC5TuPPCU0KVjaKFeox
	pKAjhpvRMaQrHM3QmLvlTKxL4x++YpMBwbPO5uT7SPiFOe3ZOn6zGj2NOU3Jv3OX
X-Gm-Gg: ATEYQzy3zNkoMKToF/Jmsk8RibE4kJ9qeXHKp7+dAVtcgyuZbzj2/PEYQogVQrna6pW
	ORMMRmyKPF70ii/BoZuEZISGjY8H6p2IFYmlDAqIBu7rESU8vxlFmlFF9jctMsuIBby8bDQp+hU
	2SLMd+a3QB3tpINP4s0EaJwsnOn0kjev/dwK9xhoFvsPdw96GmDNfWKnhTDKeZsPcfUlm1a/MQH
	ns7G+zTvFR+11sRu2jBdvRyTEwDtaut7oZYKJZj5bBuK946MMWkC7G5wsWuoiccvB5vEmo5i+9S
	bnKHwb+GA9oXC1NbQolslp7uUDhOm3FhHzq3z5KtFDiackVp0/94GEQw2VEdUSw8myVe2zsWexO
	RfTkZeRCSeKHeShskybeLGgZHmGWFtEPqdnjzOtuXK6XmZcf3vazfpMKl78JFcG7Mwhl3D4ZHhY
	Zj9Oqc7yIEWWS1jwwXBoOMVzL7VAA=
X-Received: by 2002:a05:6830:82f9:b0:7d7:da43:387 with SMTP id 46e09a7af769-7d9faead555mr9986417a34.16.1774937991274;
        Mon, 30 Mar 2026 23:19:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335414sm7329732a34.6.2026.03.30.23.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:50 -0700 (PDT)
Message-Id: <84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:18 +0000
Subject: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

When GIT_TEST_SPLIT_INDEX=yes is set and the fsmonitor daemon is
active, tweak_fsmonitor() can hit a BUG() assertion:

  BUG: fsmonitor.c:27: fsmonitor_dirty has more entries than the index (2 > 0)

The fsmonitor_dirty EWAH bitmap may reference positions from a
previous index state.  With split-index, cache_nr can be smaller
than the bitmap expects because entries have not been merged yet.

This is related to the issue that 05f28e4b3c (scalar: use
index.skipHash=true for performance, 2025-06-04) worked around by
disabling GIT_TEST_SPLIT_INDEX in t9210, noting "the issue should
be resolved in a series focused on the split index."  This fixes
the fsmonitor bitmap side; the index.skipHash interaction remains.

Two places hit this:

  - tweak_fsmonitor() calls assert_index_minimum() without the
    !istate->split_index guard that the read path (line 98) and
    write path (line 128) already have.  Add the same guard.

  - fsmonitor_ewah_callback() unconditionally asserts and then
    accesses istate->cache[pos], which is out of bounds with
    split-index.  Replace the assertion with a bounds check that
    silently skips positions beyond cache_nr.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 fsmonitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index d07dc18967..5e5a4fadea 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -33,7 +33,8 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
 	struct index_state *istate = (struct index_state *)is;
 	struct cache_entry *ce;
 
-	assert_index_minimum(istate, pos + 1);
+	if (pos >= istate->cache_nr)
+		return;
 
 	ce = istate->cache[pos];
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
@@ -805,7 +806,8 @@ void tweak_fsmonitor(struct index_state *istate)
 			}
 
 			/* Mark all previously saved entries as dirty */
-			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
+			if (!istate->split_index)
+				assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
 			refresh_fsmonitor(istate);
-- 
gitgitgadget
