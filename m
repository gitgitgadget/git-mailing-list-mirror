Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD81DDC28
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731185; cv=none; b=VKL02gOXUy8WBT3SyCwcWzfi1wimD0WiWwAvYtDqy3Y8y4zknmXHgQe/ryO4/eyphItdBgpQaZ5BqTn/lb7Wpoz7KEOgd+y48kDhEhqfJ2Vn+vsyylI/kAMSQqFiMgC1K65zBnlYh3kiSVZwJos2CWvh3aAA0KQqtcGYHtCgPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731185; c=relaxed/simple;
	bh=K1OjYE5OCDdFIt3LK9oIR2L4mMmeL1yNnGx/vgNl58o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gpl+RQCfYkfkAqlpd1IT7kIObXVLi9Kh8b9IRxBQBd4Xiw/bWBMmKDo2m/c/YDGbmpwBuBYe8uaCcSeU0lDGtKYfiqKQskyJYFKCscngggFd7gfO6+SbXWkM4p7KuJBRXe5UYN3ZS3qoO/OSzf540bxcyV3Z2O5/onihfvPnhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgUzr8jE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgUzr8jE"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso43602776d6.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731182; x=1777335982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Q9tBdmEXncJEkWtxXxORAJEEIdJttohrSzpfybj64=;
        b=GgUzr8jE7nFPEycHsR/Z5l7/oz7fjbF9l562ZbkMZ6Hc6IIneU28KGS5T72zU3D7/N
         1FDyBdQ8HJk/w42Yyu0Y9z+oTTgpZuhKsn/YGbHlrqcVzVWiX0lVba2k1nOgQYghmNID
         skVCjZh6fI+ezWddYIb7zPwTmXy9KHT+EWXlvStbHqMhJcUesldoDvpCwbvEDonY+Y7V
         JK8juLk+Z8djyycGd63FBss34SZYt0oaoJxL8V84yNrhjIAVNinaIZXGuoX1cfgTUIGJ
         ofTtbimQG58cVDz1SyLQHG4GTHDKD7eakKAuwCpLfBVNVG2uz/i9LbLqGyyFmM68ZdFJ
         XkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731182; x=1777335982;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1Q9tBdmEXncJEkWtxXxORAJEEIdJttohrSzpfybj64=;
        b=Uo7eQkfEA0AAszCQsVzhYQuOAcvXCVNYDIBAii8YCvNGs1hsrPSwfQhKpqZlUoR42Y
         s5eumBcaBArYuWQx3YUoFCG/dY1VJEZ1RSpybOpuS7KbJZqSqyItPDoqZnaoXFOXQfha
         NVbh9LTa8KlOoIdj2tcT3ckLDD+YbR2EHWHgIEW/jGrW1zPYYkn640++RgXnZOd38F58
         eYIMtXSAJ+XwSCU12o2aLR3ITMSm4/0WZS8XKInUBG6H9IBmQgTmQgKMm6U7CXvp2/bz
         KkoFgujuUYDIewla+0wXSiVPUxL7QS2XhlN2XfmOig9cCl6YphNbb2A6nzqvzF4vReyN
         zPjg==
X-Gm-Message-State: AOJu0Yz5ruHh1Vz+4TtrgX368k71OwduABY0hzVZh7D3760T4Tj77Hnc
	fAbawQGhdwupoD6uAX7IYmKlAter3tu0igedTWHPESfTIu9LL7wm3jBStn/OQQ==
X-Gm-Gg: AeBDietQoFMgbo0eA7OGg+46JZ7P6IJ4wb/AvRXZOk43YnaNxLQsL3Jcg7DuljJQgnE
	S+HUky3EKCI7geLOF+Xg4CP5mPh3PQnhVfPwgq+HICcwPHo1Xksjhm/Ie+qWaXYhxYJAiaG9p4c
	zzCGjs8iuv/7WeLSxxJ3T97c1hMF0wMpnpQU7JoWBOw6q5iBXCzX69kYNkEtO0P3+NX/zE6hNym
	yS8hj2UBLCjP2t1gfhqG0pqVfD/wZamZbjL0BqtEiMi9PTG1HFwrrm9vkBkkaefZcBKad2cII8N
	Dg+wG2ErysFxaaHC0W2cvNTbTNAgCmfsCGDUoecJigwvfREUHyVPWbygXr4DwXckq1gR/2SqgL2
	xCHnlfWuOhqmZg8Q4RlObt4B6ID2sKxc2PXg5zr713g39Ti0kTAxrmH46IilKF3bbhZR+xTZ4H+
	2DyMFRGcU3w1Rp6/ykgDmqJerEcvCb/7axsl3Y
X-Received: by 2002:a0c:e001:0:b0:8ae:60c4:857 with SMTP id 6a1803df08f44-8b02810c571mr212292666d6.18.1776731182010;
        Mon, 20 Apr 2026 17:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm119148566d6.28.2026.04.20.17.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:19 -0700 (PDT)
Message-Id: <d422f73e129535ffc7b24e64f4cfae1335f25452.1776731171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:09 +0000
Subject: [PATCH 3/5] merge-ort: free diff pairs queue in
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
Cc: Elijah Newren <newren@gmail.com>,
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

