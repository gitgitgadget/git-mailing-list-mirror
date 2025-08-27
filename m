Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84131301006
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337318; cv=none; b=Wq8LF54k8kSqxcdcNdt9FKHflKQtGHIkFZnWTZQM/RlqVaKXq4ar5s0MCNuMfAIx3r0mHeowu89ppbHuJiOyww4fu1ykUoIzd7zGHzO2lJEv2l/pNbJBP/J0YsJ9Nxu3BocrTq8Xye3Qpi8CKGWCA4bPvu+kLVRm1PIsvq7zEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337318; c=relaxed/simple;
	bh=HCssnrAJbAHxvjjYSbimEn7q6ouE+PqNLJpnN92ABkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bRMZik+uT32ejlHI34ZBlTLjqkl3NRQBTBUZx/Vkr5AOmHDziDvkDlmK/CRZirfiAj5AUA/b3egS9yp6gX5xO4X0iLHoitIWnLVAYDEjnu6y630zxeIh1b8fai4okc0wa7Wl46dO/RbWTXYNvTBn6xqrlXTj0o4aBQ4KD/2ZVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP7gpYOl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP7gpYOl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c79f0a604aso186074f8f.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756337314; x=1756942114; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY7hxxF1mR+Yr3lULJ7+pW+W1+qC6BFOdmZhrwSV6Yc=;
        b=hP7gpYOlkcUKUFJKuYnUfI3c7v7uk7ajnBtvhcgfoEPnvhWY/jQOX/oU+BtfM/rz4m
         sNOUtOiKhHUDHFM7VQDMBmkG/39CJwgqvS6AG1X8NWI6OvC5zzCFCfQfNkaeTN95f08p
         tOi0Q6yXpqqmU3S8wf9bh6QuKoZ/uM5LJCLwMW13zl16cCH4pHIXGeJgg+Wc+jls0gyf
         gzQCxhpB6MwZLiEB4fcFnr8jdtSCgciTYx71yR3jgAP6cBotypHLFK8aPNXIia/uRig+
         zu+asVwSMQ90DVqZmjMBpmiOC3ZB4lhjm4xLVEcIoaB/ockKmIz+rllB0SxNXeaEGVRN
         IV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756337314; x=1756942114;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY7hxxF1mR+Yr3lULJ7+pW+W1+qC6BFOdmZhrwSV6Yc=;
        b=dW0EMBlsMQPWwu935toKxnIxl3lmecDXchOY0Z5kB2N8zAF4HP5bk0QLxnlkyzRWmg
         Q1P1Q7nOymACsighSwRMMtl4ayL2khb4x3Fvci9rCUT2cEX7rWsne708MYUKplttPU8p
         aGIiwVeI+X3HN8x9Mvmjz+l4lYTGQzan4HFbgbZXZlyo1iQ4puLnNc1XkLSMWC3QePGy
         rBqXOrGt10j+H7HeIFYTSl9568npW/PrnZ99qgkTQdDMgs5BuVj15Tt4ezn750uF/c36
         eXqtgnN3Tm7dOYvdAxEhjeUYeIP2SxfC3jd+ipmCai2tBdli5hezhwJQIFAxAt5DhOQb
         gbqQ==
X-Gm-Message-State: AOJu0YxLH0TXsc12jQFYBSKGcZ6DPysD3T0P1fvrP1R8hMaqTCwrI26r
	Sp+rVIo1CKVpzVe+m0t8wjQD4FF/soHgpV1y9xbwyYQSUYLlLH1OHZZvDXR5HA==
X-Gm-Gg: ASbGncuq0UkAf0Z0S2xb7K5sFMsCSDjoKhisutc6DfTYXF6jsI+VURgMlbUIftGT8XC
	T42MsXW1lubBRp0BJwCJxNlTpYY/H6N/jAuywpgCy+yT9yPZZ37X6QNuAIIgZ4fJj/7yJbeRTdB
	WB391hcVR2Uf25PkBUBYk3P1zCf5eyIxWhYCkjaSGN+Gr0CR9jrEy+tsJcvsm1G3j4VGIFsR2Ak
	qcm3thJ9tT7kDXdj6uunnoUHh8HrdYdkskoFV3q3fLQrrxBXhtQIu5fsTUxRvDANCoZDKP4NWwo
	B81J50hj1zS8zgm5QpJf3Gvb/BpgrKVbvvAaWVDKueDiODJlOwQlg1Pw0EbpDKKMzRX8lMWaj/O
	e7bMseX0/CqOECeR8ekUQmaptqJpjI5lefTYhDQ==
X-Google-Smtp-Source: AGHT+IHlWXEGfa4uC9mf0x2BNmeSenJ9IEtUesAwrJuTz4Y6OW2tDpEz8zF2qqN2SoW5dr9JYtmPNw==
X-Received: by 2002:a5d:5d0d:0:b0:3cd:aff8:e22f with SMTP id ffacd0b85a97d-3cdb00827c7mr888822f8f.1.1756337314320;
        Wed, 27 Aug 2025 16:28:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6ee66bddsm49268025e9.0.2025.08.27.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 16:28:33 -0700 (PDT)
Message-Id: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
References: <pull.2040.git.git.1756238268790.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Aug 2025 23:28:32 +0000
Subject: [PATCH v2] alloc: fix dangling pointer in alloc_state cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare <nouraellm@gmail.com>,
    =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

clear_alloc_state() freed all slabs and nulled the slabs pointer but
left slab_alloc, nr, and p unchanged. If the alloc_state is reused,
ALLOC_GROW() can wrongly assume that the slab array is already
allocated because slab_alloc still holds a stale nonzero capacity.
In that case s->slabs remains NULL and the next dereference writes
through a NULL pointer, causing undefined behavior.

To fix this, this patch:

- Renames allocate_alloc_state() → alloc_state_alloc().
- Replaces the “just clear” API with
  alloc_state_free_and_null(struct alloc_state **s_),
  which frees all slabs and the alloc_state itself,
  and then nulls the caller’s pointer.
- Updates call sites to use the new helpers and drops
  redundant FREE_AND_NULL() calls.

This makes the alloc_state lifecycle API harder to misuse,
eliminates stale-capacity state,
and aligns naming with project conventions.

Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
---
    alloc: fix dangling pointer in alloc_state cleanup

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v2
Pull-Request: https://github.com/git/git/pull/2040

Range-diff vs v1:

 1:  643f14e6225 < -:  ----------- reset slab_alloc and state fields in clear_alloc_state()
 -:  ----------- > 1:  0b980850bdf alloc: fix dangling pointer in alloc_state cleanup


 alloc.c  |  9 +++++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dda..c1065551c07 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,24 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
+struct alloc_state *alloc_state_alloc(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
 
-void clear_alloc_state(struct alloc_state *s)
+void alloc_state_free_and_null(struct alloc_state **s_)
 {
+	struct alloc_state *s = *s_;
+
+	if (!s_ || !*s_) return;
+
 	while (s->slab_nr > 0) {
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
 
 	FREE_AND_NULL(s->slabs);
+	FREE_AND_NULL(*s_);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
diff --git a/alloc.h b/alloc.h
index 3f4a0ad310a..87a47a97095 100644
--- a/alloc.h
+++ b/alloc.h
@@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
+struct alloc_state *alloc_state_alloc(void);
+void alloc_state_free_and_null(struct alloc_state **s_);
 
 #endif
diff --git a/object.c b/object.c
index c1553ee4330..986114a6dba 100644
--- a/object.c
+++ b/object.c
@@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 
 	o->repo = repo;
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
-
+	o->blob_state = alloc_state_alloc();
+	o->tree_state = alloc_state_alloc();
+	o->commit_state = alloc_state_alloc();
+	o->tag_state = alloc_state_alloc();
+	o->object_state = alloc_state_alloc();
 	o->is_shallow = -1;
 	CALLOC_ARRAY(o->shallow_stat, 1);
 
@@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	o->buffer_slab = NULL;
 
 	parsed_object_pool_reset_commit_grafts(o);
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	alloc_state_free_and_null(&o->blob_state);
+	alloc_state_free_and_null(&o->tree_state);
+	alloc_state_free_and_null(&o->commit_state);
+	alloc_state_free_and_null(&o->tag_state);
+	alloc_state_free_and_null(&o->object_state);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
