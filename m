Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF06261B95
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589015; cv=none; b=UFE5bkv0+s1EdWZuT29jrlzWCbJwD8ZkHj9WWdFDHGJa76rm2ELZ7B+xZA6B5XX2tCsRXXYrrLyT9fLHmp2uEDKfmrTb8LYRZiMjV86cH/k7ZVdbN714zUO1OV6rcUXC42lNoMs8TsTfKkJoXgaGPhkv6uSBN9MZnH067SnHXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589015; c=relaxed/simple;
	bh=BId7CO0Ry905V5u+Y+NUPA6OTjBxnuyogf7hXrp5HJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XIAUyCBh+g9TF02BkRmrSIVnGT37y4DOngs/TXT2NA4ZRbgGjDpxbsjJLiYx3p4jGZntEq1qT0qkZDDJovPNdtIBdQ64ZkkA12Kvy4ByEoL00TDfjm5WsCq1MW82EgGJBD7RWbeQOI9p+1TZ0k7+/xcijq3iCMhrFtrQvt79JP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBWfZZ2M; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBWfZZ2M"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70def6089b2so41670246d6.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589012; x=1757193812; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpAJHrgblnZfs1WTyafYD58KwnP0jr50eJmlMgqRJyc=;
        b=CBWfZZ2MikziS/U83edRNNMvpz3rNw2/3BfMDWGxoNaqlUG2CtrX7JPGful2Wf/SUD
         JcJEwtz9QoMPmdOuwvR4eQ37h5g8540+4u2KCbQ30JwlpfCloTcDJBYAv3wY5xKbnct/
         wzl6L8v0ta3I+kOxYEFpGgIc6uL2QlNTDLAE0yArTuXb6KkPEkO2D1ftnlWYLwrfXBXp
         3YTxE8xbaGzVknuRt2Kl2i7Zsm6jcxeKH7tvzZWmjso2ByECygcj9/Bu13xY0XjV64IR
         COOqdRDAD2YIiwfjc3M003X6AnKAdx/49/483bEfbnbV9vamfWgTkF3VIzfAGnt/oBls
         oNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589012; x=1757193812;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpAJHrgblnZfs1WTyafYD58KwnP0jr50eJmlMgqRJyc=;
        b=cd0CZ5K1YQ8x9yMv1eVJCuJQ1FSxwRjIZQaV6S7FXT8ySHLjGY7MXdl+UwQtjlIf84
         YgzBhmSKs6Bt97E05bzkmNkRwVvVOpPtkTUJyweXPwBbTggHjUxSegAIUXLeuXqpuWwv
         IxopSMzEyCipfnmVu/yGpT8xqX/bGDLUFrm57KlXfATMyzQe0C4StM3cIjVgS1uj3Spu
         CyA8Pa5fFDT0hGDuObw2bpuY1NXY3UO5vgLEFk1XS6CwF2pXoyeU72qwK4PuX9aVLZC/
         HUM8a2wPv1+vTPyoqq5oHe2Ejq46amKzP1NwRLNpydjU5cAYn/HCdutHKRm2oTgpk4LK
         Mmmg==
X-Gm-Message-State: AOJu0Yx14troyEH5E9ue6r+/dDhOIAbSnTCiN8F5Nmm3Cs/EWVxmc14P
	pJ5YUqfT9AHL9R9KvqzIe/hxg3abDQ3AOfUxA/DC3B/cyX2Alfi983G7c3oElaY3
X-Gm-Gg: ASbGncv7qy7qUB/zduWMaGOHhsDLn3gRavUQdfqYpoQdHpuplltX5nbww9aJlSB/wJ/
	njmOLJvJCFzumG1VgjQX5/n5OUZJZtvrFK1SY574Lb2U2ymfBtb2aEMseEv7r9qmh0N2QDRIDT4
	1yKnZNuJYGADJQJIP9yrOAylLncHFiy/OTBfr3oXP89iwteFDYbdPXhDpplFKCcX4qL7Gd8ibPo
	KjBSFOvk/9n229wn4PphwZKK2Kwm315yR2fCCKALCwLFGEvAIG5OpqhG1yFwK7muhnfMUJW3hHk
	o3glyXxYSyUtP3NP8cTDlcZaL59Z+uk5CdY9gr4p4puxQ1ATe6+ejLedZjQ5H67sd1hbBoftHQY
	Fhh7JbHdBrjW551SQsq3h5rRRRqgY08ilEOq/IFaFlId66O4=
X-Google-Smtp-Source: AGHT+IG5j7CN/ObX/88kj1YP81GWwsE47PSNLJ1eiHqIMt7a1PZWvc+/48dyilfE241KXf7qWa+k0g==
X-Received: by 2002:ad4:5bce:0:b0:70d:eec2:cff2 with SMTP id 6a1803df08f44-70fac9026dbmr27128396d6.49.1756589012300;
        Sat, 30 Aug 2025 14:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb25c6dd6sm11737046d6.1.2025.08.30.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:31 -0700 (PDT)
Message-Id: <a1dd3ed87437322e298bb192fbfe4a9641d1356e.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:23 +0000
Subject: [PATCH v2 2/6] midx-write: put failing response value back
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This instance of setting the result to 1 before going to cleanup was
accidentally removed in fcb2205b77 (midx: implement support for writing
incremental MIDX chains, 2024-08-06). Build upon a test that already deletes
a packfile to verify that this error propagates to full command failure.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c                | 1 +
 t/t5319-multi-pack-index.sh | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 070a7f61f4..0f1d5653ab 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1104,6 +1104,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
+		result = 1;
 		goto cleanup;
 	}
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 49705c62a2..008e65c22e 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1100,7 +1100,10 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 		mv $idx.bak $idx &&
 
 		mv $pack $pack.bak &&
-		git cat-file --batch-check="%(objectsize:disk)" <tip
+		git cat-file --batch-check="%(objectsize:disk)" <tip &&
+
+		test_must_fail git multi-pack-index write 2>err &&
+		grep "could not load pack" err
 	)
 '
 
-- 
gitgitgadget

