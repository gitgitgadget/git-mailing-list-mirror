Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E04D27E
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052535; cv=none; b=a6YOiguGeExjx0+ohZFz+TXK6ijp0OBboiTFPY3yoZWGOUkqmz1P7Lr693LdTiYiUNnKDHChbaPRBSjsoOKZgz4oJagsvQlJodl1EFzEb6x/5iU7y9kpxRb38BtEO0ku2B7IvnzPvgtzAyly9GIbfN1S1Ag/loJh/la2VEYT5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052535; c=relaxed/simple;
	bh=fADw5A1/dLZZKX6kMZSRzUhitQXNBMp872UsMYv2m1g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QnNwlF9kVQSF61k08KJfHesp419WH7maYtNoyeUzKtFkB8f8K0BiKeITNZx3BEa0Q1QN1dn9Ywx35v+tE+WrKKSgFb1bExq2ES3XP3GPJqJd1kiu0igwRM2w71znwftdVZ8IgWYmqQvTzKdwu7OCtIj44F6M8/PftrAU24Jf8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSPqFJjb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSPqFJjb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso44233565e9.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747052532; x=1747657332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GF4tPfMh15xUWmUJcRmMMTh7I5vtIKb7wwHWaUftlYA=;
        b=DSPqFJjbYx41cTLJ/rKpPB/dmpjI9t6vLCRc0MosD/CoZkhxjkVufVS0Skeekhny84
         FpJJneB+g0Ao1RaNGXMS6UJuYrfPxij3OoPtwjPzuJdqnfAcRoTo2u69J6vjupXvj2/S
         8m7R0/Z0WDL5EJgmGposGy7t48j6ojlbR09Cinnr4qhzvsyvkwguh90X5h8Ho2Q8KXsK
         tfoOTRLNU5NjhjG/tIKPcMlbMgOHpRsyfMkDnRO0Y3VepNLQVJrOjEND+5i4ySKdaRVP
         VXOdKLqR4bi8zNJ1IgS04vRQd8CsYiOMpwScI0ZGz6a8LYBlAvE49Ad7ld0/vRhb8Kfr
         aF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052532; x=1747657332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF4tPfMh15xUWmUJcRmMMTh7I5vtIKb7wwHWaUftlYA=;
        b=tpIwS7yqlSscHV+ocsAwn3J0TXSjMHpvsyGaGC0g8v0KH7wMdx30UP8IBBLJ8Z3gid
         u6ebr0+IzG0+eAEnqBcfriGm8+uHTStPEZ05micix8g+o0lnQte9wJ0W1vPwbP20jAVo
         jaixyIh/WuTvhftjI5imoZFEvd1UBCCGURVG0ri/mERz5Exn4deQCZ/eRv78mA+iNnR0
         hp/o7l9kRXcA1RO5KF5jo+ZbOEo8aB1RUKbvESLzPJp7CrmqnY3zYomqfXF5/kA0GXec
         +OqM56YXhew+EWXfY2jC78zvZ9wvmwsBXRWrj3jUho9qdqyk+jpXui7aPs93/nIWWC7a
         lXgA==
X-Gm-Message-State: AOJu0YySnptrNCae3QG2+I5k2fVENpdK2s3eCfOibYQKqyq1qo5MObhm
	2YWLR1Ke0sDdMDLT+rMrapJukBENvphqzcPvPwqDwYgMOJCkVSkDdwX2Qg==
X-Gm-Gg: ASbGncuSfw/cGRYOe+25hxeiPc8JsgMvslBC7KrewktVNtwpRfKw2rZCUjDVqgjXNMm
	VgO2k6OA9WDfToiJg/eV0VAS5PmcMvbYNZrdAxQJIQG9DOh5Dvl5rs8tSx81XgWoJ/ku1r7NvJ8
	E/Yc04qoEIQ5bhcMK2uhtT3mpvOkUSzCjWFUrt1WMci7DLCVRxhi+R/9MvxBBLlC0diidGhYRDT
	KeJUJahENzuWJZ+GL2PcHTt3kE9rh8Fsm7CrynPLQc/SM+7ogvraskqwVb1UVIINsmn0YaJAH7I
	KWjrRRfrGy7VYISTnm/pugX6j9+LM8uBj2dEAOwYZgLUjhhyTN0P
X-Google-Smtp-Source: AGHT+IEd+bthkC7p78oHdblTsN5ViR5zfRpClksTwShf8CO4HgS+bWp3LyA/fIQrR9rHcFy1yys0Mw==
X-Received: by 2002:a05:600c:a343:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-442d6d3e238mr118903455e9.9.1747052531559;
        Mon, 12 May 2025 05:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d7795sm127619555e9.8.2025.05.12.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:22:11 -0700 (PDT)
Message-Id: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 12:22:10 +0000
Subject: [PATCH] pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
 failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:load_bitmap_entries_v1, the function `read_bitmap_1`
allocates a bitmap and reads index data into it. However, if any of
the validation checks following the allocation fail, the allocated bitmap
is not freed, resulting in a memory leak. To avoid this, the validation
checks should be performed before the bitmap is allocated.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: fix memory leak if load_bitmap_entries_v1 failed
    
    In pack-bitmap.c:load_bitmap_entries_v1, the function read_bitmap_1
    allocates a bitmap and reads index data into it. However, if any of the
    validation checks following the allocation fail, the allocated bitmap is
    not freed, resulting in a memory leak. To avoid this, the validation
    checks should be performed before the bitmap is allocated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v1
Pull-Request: https://github.com/git/git/pull/1962

 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d866046..ac6d62b980c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -388,10 +388,6 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return error(_("corrupt ewah bitmap: commit index %u out of range"),
 				     (unsigned)commit_idx_pos);
 
-		bitmap = read_bitmap_1(index);
-		if (!bitmap)
-			return -1;
-
 		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
 			return error(_("corrupted bitmap pack index"));
 
@@ -402,6 +398,10 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 				return error(_("invalid XOR offset in bitmap pack index"));
 		}
 
+		bitmap = read_bitmap_1(index);
+		if (!bitmap)
+			return -1;
+
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
 			index, bitmap, &oid, xor_bitmap, flags);
 	}

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
