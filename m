Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADB36A364
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419056; cv=none; b=J/WrcYszfnQatPdJN8KJiycsNED6GGlyAZRBG1iMGvdW7TJO+mVxLkwSq/qv7kPOcDFW6RoekT7HHSaKCt3pzo6Yw+W4hqLhiNBEiC+1+gWCGwLFTtELezKhvcjvtEKF0ip8Jsi4nSHamiGrckZxKWGVaSNlyVG+E4Bx3NBxHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419056; c=relaxed/simple;
	bh=K1OjYE5OCDdFIt3LK9oIR2L4mMmeL1yNnGx/vgNl58o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j29+ONdTpMRCx8shAfDvliiYvuQ0KhYD8hCuaBjrz5KtnQdIQitYTJy4d17cIF7t+O0UOPhkHqDxwVXBLeCNyi7b9k0KRJvLi5GbTipi+yhL9Udl/KjNhCuYDTWEvwJ6ipr7QpK0bFpQE7yu4La+dLO4ka1gn+VVSIkyRNoWhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH1Tyqgc; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH1Tyqgc"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5175b6c4e19so23735881cf.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419054; x=1782023854; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Q9tBdmEXncJEkWtxXxORAJEEIdJttohrSzpfybj64=;
        b=dH1Tyqgc/n2kYmLat9EBdxd+TGfk9A8lYP2hGGmbE7Ka0OmUwxzshcruUT27f0y1zi
         Kb5gn3vcECWdzKP37C0+yG1xRdLzV3znLD7y4M8EslGXAyc6xAGpI8xu9BpSQ8kwdTuv
         BUkKTlhm8PF6deOoPGJW14oMTEskuLCHR549mQX8UQT3n7mUHFAGlQUeGW59Qg/dvCb3
         Gyc5Wp4JEQeXljFYNA5CpWVKihQR2G7GQYVBk+7v3XZVvsEjj1tAnVsUpgAwGMReVPqQ
         Q5Ees1wdIOYSZjYkVjJw2/cdxAgDtiHwIFOZCexPLuirzOHPWUQ0uX3SXPUX3l63ky7w
         daiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419054; x=1782023854;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1Q9tBdmEXncJEkWtxXxORAJEEIdJttohrSzpfybj64=;
        b=G1QsUDgctXlqdUrLgWbyxGajKZ7kW8GKI5UmU79dWl9IizVTYxdIKO+eWqpxwkdN3p
         JwRYng81R1KIKEnDQoCzcRdBCubtUY1hs1dMRiAjSQcYiwVHwF1RnTeHbjBMI1dwoESk
         pU2KScQw5SOucgBzupDIoTOD4LPbgaQ7mhKCwVR8sy5RvbsM3bG/N930oPdQ+Vy/C8ST
         wY9gSw+EYZk+vpDoWhJt+K0SGqLR1lHXCWD5NVC0y2KHLvg2b8mDJlGafGvV0S6FQzGa
         3lQwWPZrNESMVNBmKYow9HVIzq9L6c/Q1utL0JYjTkhCHPc09WPfMBo1WkH2EjXp/mSU
         meUw==
X-Gm-Message-State: AOJu0Yzj8OmX028DX57au72TAWuyE7e3kHdSyErUy5prT0sbz/hemOp7
	dbra9YL8Iqlo1zx4Wjp131ZsJqA14rU5oIxRSSL5DEAJxP1wIRtZ3So4loZwtA==
X-Gm-Gg: Acq92OFpxgHJJHej/rCiVB890qNUBcqJFC3l0MRwQ56UcG/DYmJIeBW5EYiPDd72OXO
	Y2pMUtJN5ZMy+lvUZrb01X5+67vJo9t1/jss94ZHh1AG15N8tierni9pdp87dQn5wYyIjav4h2o
	vujCR7+9rcM91LYceGt1/Y3jibqfehfuZO2TWR4bxTrPMu6ERzxkk2C2PSo1p0eZdzbzf5kFSei
	TyS7iZVnZA7YnP+PnWJlVxzTBqHNEgybE/fUu6Mq8AS1WWGKnS6eWqDsLN7/h9WKxEa40rpur25
	GKu9v8x1hb8d9aQuwVQ+sT6fw/Lpm4rK7e7MWbA2DFKfYkmpToz5+13PVr6a6wnTfgn34u4O21m
	kmSJkiPSRG27tMqIpgwzcGt2apBOpO5rSCVirIRHl1NpM1XHpKfqIInH16OgvcYNZlgWUS02eH2
	1umnpus4jyOXUnrx4PL/jsaA==
X-Received: by 2002:ac8:5d42:0:b0:517:8353:3497 with SMTP id d75a77b69052e-519533b50f7mr99734481cf.23.1781419053653;
        Sat, 13 Jun 2026 23:37:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61fb15sm66966971cf.5.2026.06.13.23.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:33 -0700 (PDT)
Message-Id: <673fbea13f7612eefec8cc2561b1a0289e4b8e71.1781419047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:24 +0000
Subject: [PATCH v2 3/5] merge-ort: free diff pairs queue in
 clear_or_reinit_internal_opts()
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
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

clear_or_reinit_internal_opts() is responsible for cleaning up the
various data structures in merge_options_internal.  It already handles
many renames-related structures (dirs_removed, dir_renames,
relevant_sources, cached_pairs, deferred, etc.) but does not free
renames->pairs[].queue.

In the normal code path, resolve_and_process_renames() frees
pairs[s].queue and reinitializes it with diff_queue_init() before
clear_or_reinit_internal_opts() runs, so the omission is harmless.
However, if collect_merge_info() encounters an error and returns early
(before resolve_and_process_renames() is ever called), any diff pairs
already queued by collect_rename_info()/add_pair() will have their
backing array leaked.

Fix this by freeing renames->pairs[].queue in the cleanup function.
In the normal path the pointer is already NULL (from the earlier
diff_queue_init() in resolve_and_process_renames()), so free(NULL) is
a safe no-op.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 74e9636020..8f911cb639 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -728,6 +728,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strintmap_clear_func(&renames->deferred[i].possible_trivial_merges);
 		strset_clear_func(&renames->deferred[i].target_dirs);
 		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
+		free(renames->pairs[i].queue);
+		diff_queue_init(&renames->pairs[i]);
 	}
 	renames->cached_pairs_valid_side = 0;
 	renames->dir_rename_mask = 0;
-- 
gitgitgadget

