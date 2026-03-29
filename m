Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F702C15AC
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779500; cv=none; b=ane9A7n7v7QcRJGJ2INSOOP2a8/p9d+PxdMm7qvW0RpA7aWFl3Y43nkhzE/fF0GX5fqG9VeWBGJ+ReFntN/qdEkOOTm9staYtkdlNzwigjMNwd3oud/2wFEVUwiAeAhwJa+yhhqZD76M1BXzYXwGFzudZfzFhpUtQp+R7PJCqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779500; c=relaxed/simple;
	bh=I+8Kd3URrtigFcHycvmzgpzdAWoxJBf59Qrb7TvbbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrp6GA/kr5nX0qjnPD6+L7Z6zgWkCRNJin6jwk4QTO9rC+8iFQRp7xtMq6E67meGtvVYpFTR6r2I+NnvYPFVwddzWauT3uN3CcQbdLLH5k6s7sPmesG3a4WPyZiVAcFePVORB9aPVvV1jDAiLS1rDJ7g98a7g+cNxHI99QI/fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW/tWifJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW/tWifJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0603ee486so21462365ad.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779498; x=1775384298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=NW/tWifJRnUv8UDtKNujIzl5xwHzx9cKitUUao8XCSxzGrrhfa5UQML9PSaFTihERI
         p38j+7EIv9w4tCOV8LQ8CYksqfGR4/QRURdM6MK79qdyhh69XsKZlFLjemo68P3hlWT0
         MgUBSBBzaPWq/1FirLU+fo4SuITiiFlUoZDZxPAAfrKpwZ2ODMOMI8vWpy3Ya75um4nl
         3jIEeszC6M+JWKMYcjsMUKLrn71fqnQ1p4SM2+q6VnkZ3b1b9npReJPFbweXbCx71lNW
         gtdWwIiTqtKxGCj1zzQ5SHhn0WANZyTopkc9hbxxIvNvG0vALAfTe0o66rxBPB6oD+bQ
         96IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779498; x=1775384298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgHTK7u0Acklax1nW7Us6DmBsMCO830vFRHi1c2dJHA=;
        b=IrqmcRbfNso/kdQHEd9YvEmCQ3Cd4rqbOzSJHLmZ/9WELVhUfPkUy4EzIc/ogt1f89
         sUpLagZELcsPiPRQVB/D/MD+EIDSyfOagIbJyXrV464OafAK+si37sdl0uOqFxUDl/az
         fpwaFKVHB30WNehzKuWIOBjeUod5mErTDcVwjU8sRP0+Q1QYGnchj/qJ7+aKDNqP63VN
         zfD+hPGLcf1hxvEiIaBre9/PuAkrdrmWCCm2y934A2bRIX6i+ePc40cfT9AUPWJTorWQ
         AdXB4APXm3SsbysgkQZJM2HxD/U/C10D/sWJN5NQAZ+AtUSjY043kqJ8bT1P9ijhnoHg
         dohQ==
X-Gm-Message-State: AOJu0Yxk9NFqg7YNragnJvoQIKnx4YyqqmraVEEM8U0JvwUKPl8B58TC
	VUTAVKnY5OGacfU6XkdD9m5BflVV/3kYvC74L+kFSPz0d0BtQ92q+UZbUgPXcg==
X-Gm-Gg: ATEYQzx/p+L3LWBQJ5/WcQWIqhqbISUdE2Yta4i1q+eONeAt0rNbGn5cIxYdMQyRwvm
	OwTof4VwDt6F7XZks50JkrJz309L2C8iUQ9mRhrdx0J+sBSmRo46sMX/pKw7Ci8yxUAgLOuUodC
	s5hezXRBiueVu5QwxBiuOe/NdVvZpfvKfubqPWvZy/CwmtPDBvznXSD8JecYtxmGJ8y2t4rCFfI
	534fgxeQZJJAsvaduRfO7BGOY3e2iJtsD9/Tq57kO9T+eyKjCyM0P6IQ/D3GxZFMmcYrM6GFBcA
	1lrRz1aqEx/kOfPA6gGmh+Ub0V9GrkaCbiM/bitcOsxJOCDBcTipChNoTA0on+P+RO8hRSArHQf
	jEZrTzlaKSEoFJ/+ZIypv6xz9ErPtpnA5/Q8S8s+sVZLMf7iD/A0+tlLtvsfr8Fjyt8JlIzDAhy
	bIsxqvzEhSdgAHzjRNZlCuXp56zs1DhTvMsLXXA80GrTU=
X-Received: by 2002:a17:903:3d0e:b0:2b0:673a:7c85 with SMTP id d9443c01a7336-2b0cdd6bea5mr89285165ad.37.1774779498460;
        Sun, 29 Mar 2026 03:18:18 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:18 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 4/5] refs/reftable-backend: drop uses of the_repository
Date: Sun, 29 Mar 2026 15:46:42 +0530
Message-ID: <20260329101725.1092900-5-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_be_init() and reftable_be_create_on_disk() use the_repository even
though a repository instance is already available, either directly or via
struct ref_store.

Replace these uses with the appropriate local repository instance (repo or
ref_store->repo) to avoid relying on global state.

Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
is_bare_repository() is still there in the file.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b124404663..7c8a992fcb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -404,13 +404,13 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(the_repository, 0666 & ~mask);
+	refs->write_options.default_permissions = calc_shared_perm(repo, 0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
 	refs->write_options.fsync = reftable_be_fsync;
 
-	repo_config(the_repository, reftable_be_config, &refs->write_options);
+	repo_config(repo, reftable_be_config, &refs->write_options);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
@@ -492,7 +492,7 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
+	safe_create_dir(ref_store->repo, sb.buf, 1);
 	strbuf_reset(&sb);
 
 	strbuf_release(&sb);
-- 
2.53.0

