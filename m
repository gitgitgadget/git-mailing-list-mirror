Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC3246BA7
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174436; cv=none; b=T6ANrv2q0xn5LIUYDpwXcdww1I/ycY/mt4DUleIN7dhQjkquINqFowEIfRGTJDP3H3hnukcBJoMk0rCSyWEZkAfkveO43pft/808Fz8TYr829igt8DJW3YUb6Lzqp7D8QKdswuzROSwvq4wblRn2s7vSnDcDoJq6GNZmcnOq020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174436; c=relaxed/simple;
	bh=helFjOlO4dGXI9Guz6vhxWuweUpV2DqcqVz4m9y7u8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pkns1EphRSVxGeQ++Xpr4xXRuKY86MPr/8k3OZbU3ErFfbPbDXl0XmfxqaYnn+Mzr6AMP9Y/wCfwRu2I1PXvcICOqY0pCSJrEoUEDFizfIwba2jxp2LAFKV1GSp1U9l0mkLLlSG32aC0ZXmtPVGtkEbj4Y4B8ZwVXgx96XZ51RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvaZgFkB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvaZgFkB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54b0434101so448694a12.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174434; x=1758779234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KbawLf8aA+DCi6b7AAaaW/t/i9/k3/RF5JSMy7sgIE=;
        b=JvaZgFkB6XUyABXvpb7foOmjXgTSsxGG1ih7xNEhpqvFEtKk/PGyI96KOhCV0p+QqE
         GY8b11aUkVbS2rumgSgsVF2wianh52txoKim1SlwqqQCMCbtrG+9NZueDgx92VLI1T9d
         K7eZYU9eZpgaTRHIrhelKE4aTRYjOTeN+kGPBhdy9NZuzrD2bjZxx1QUa38xWpUOCS2O
         6BSxjV6lp447LxjtNwsO9bq8IfOu0HXGpRXhV+gBP44fifPhWMYOc3h1yRkl2gs+nxMl
         M2BcAiYbVU06kML/oOetgXHd8cu+7FgDH4QHRX+Y+lpKYbOYPLTvULD/gm2iawMmFCPg
         9/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174434; x=1758779234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KbawLf8aA+DCi6b7AAaaW/t/i9/k3/RF5JSMy7sgIE=;
        b=EeHYvly+1XQYyNQ4NBgHMVUU8zT96Mvl3wts1UHjW+FKlSf1QP189y/g8AcmviYzHR
         LYMAGrqwhTNz0NieeGOEYKVgaI/P6R/wdvejFDax+uvukbdAwrilOFVXzTnzAAY4s1nd
         caJQookdMunC5NFb36fGwjQdri0xBeqNQHOI8CEUT3JMeoxho3766FZB6YErwWzLse0L
         m/mTR16lIU4kSSTpRNcilZwN+BrDYE/HjuOA2Gy8WCsfNbAr1u6+ZYgoUoTCF320ojKg
         +bAVnN8P9Z4WaycC6GSEI2ncR+/7QV48duP2Y460+Ut5KhMCehgSjrwx8ydG3pxyVna7
         HEqw==
X-Gm-Message-State: AOJu0YxIjY62pqihWgQi8VzGdvJe8da2nfRDS1kKXVsnyoXPVSEi/I9R
	vHy2nmkpH0OMhh80N3hGIi37+gIuAM/SK1FbYSPfdv2mF+T+sZjvYer8zcfv3Q==
X-Gm-Gg: ASbGncuf6jy0pOp3JnT56iB+FPCZNzCGueuzOYqV2Ly/hTW29W6w+M5ny/e3Y26Jb2/
	jSR8PXZiqpxXHTZwigyqHIzAiGxLnRRIYZItUTqrPL5IAea7wNzsYO3Q9iS5DRwhqenV0Ys72Pr
	OLVZarM7jdO0vvcp3ROLvETlBudb9hkaZML6eADMfCIyFgTZE0kGDL1V6kY+lTcR+MGi4ysDjNK
	1s/VMbkoqB9NL215nfl0Y/hzjJnyxi3fYAqmjsZEW28LIKGsQ3OhC1KQyq/UAlTbFRQgVaZpr9M
	gfvDG89hrviabMLX2wGpG0EWq2KrDL/X4RTUEe6ZlgwAcAsKcsYCB4mFBhoCQ4J5jEutQpTmI5M
	I3BnKmcksyDskZapyPljGkvVy0+8PYJgcZVcX9w==
X-Google-Smtp-Source: AGHT+IEuMiB8na5vsnndBpCaaUmGgXnFpyZfTmR2E5OzE1SXPjksCHJhMEIjZMjOqvCb9IyE5gz3ZA==
X-Received: by 2002:a17:902:c40c:b0:267:bd8d:1ca with SMTP id d9443c01a7336-26813901dc8mr69307075ad.43.1758174434189;
        Wed, 17 Sep 2025 22:47:14 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:13 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 1/9] refs: add a generic 'optimize' API
Date: Thu, 18 Sep 2025 11:16:56 +0530
Message-Id: <20250918054704.544254-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new generic refs_optimize() API function that dispatches to a
backend-specific implementation via a new 'optimize' vtable method.

This lays the architectural groundwork for different reference backends
(like 'files' and 'reftable') to provide their own storage optimization
logic, which will be called from a single, generic entry point.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs.c               | 7 +++++++
 refs.h               | 6 ++++++
 refs/refs-internal.h | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..2ea6fd2218 100644
--- a/refs.c
+++ b/refs.c
@@ -2282,6 +2282,13 @@ int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
 	return refs->be->pack_refs(refs, opts);
 }
 
+int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
+{
+	if (!refs->be->optimize)
+		return 0;
+	return refs->be->optimize(refs, opts);
+}
+
 int peel_iterated_oid(struct repository *r, const struct object_id *base, struct object_id *peeled)
 {
 	if (current_ref_iter &&
diff --git a/refs.h b/refs.h
index f29e486e33..d28c4ef0af 100644
--- a/refs.h
+++ b/refs.h
@@ -480,6 +480,12 @@ struct pack_refs_opts {
  */
 int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
 
+/*
+ * Optimize the ref store. The exact behavior is up to the backend.
+ * For the files backend, this is equivalent to packing refs.
+ */
+int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54c2079c12..4ef3bd75c6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -447,6 +447,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int pack_refs_fn(struct ref_store *ref_store,
 			 struct pack_refs_opts *opts);
+typedef int optimize_fn(struct ref_store *ref_store,
+			struct pack_refs_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -572,6 +574,7 @@ struct ref_storage_be {
 	ref_transaction_abort_fn *transaction_abort;
 
 	pack_refs_fn *pack_refs;
+	optimize_fn *optimize;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
-- 
2.34.1

