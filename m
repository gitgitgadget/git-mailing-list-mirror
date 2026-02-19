Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BA325736
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493914; cv=none; b=CTvR6BbH3U8N0wBLPQhb9TcvKVFu1yrfNFduR3zKz5MxJxgUNXEAi4nsseCGKVZoTQ8KWuFv3U5Vkopetv8DCd+B2QwHHyE8bNJRyXknvRjotGly5zHpIongER2PjjigsN5JgzC4MhoDW5QSV11t2rgIsmNG/AVwrsMu0Kwjxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493914; c=relaxed/simple;
	bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDL9hCM+tjfte7qQlJ3WbTK9WPM3F0PQEm8HY59VIcTFss8xxKKq0t1B6xGqAKGAHa/4Er5hieAP5rGUpch1DeJe0aXb2EpOgWgTsa2essbVrzUe8Kam1j+WwodE+NlT/WVkBOxd15hk2IP+oqVIDn6ST84HCmsYPKxFk0F5vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGXloB/B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGXloB/B"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48375f10628so4404535e9.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493911; x=1772098711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=DGXloB/BVKz9QqR0vHSC8LDmVYIFpTrkLDPIRLUwtPAYshjY3dnOARxQQdYP61fC3h
         kAa7RRDTvTapiv3jwbN8czg7oBfmoFsibZy9qZbFXHchHaoYpumaO0Z3um53D7BfjTPv
         nsKUHF21YG5ZMAHzGG+AfXCZfndU1+q3bQB2IIPk2Z11v0nzf9VtaXdHZJ/015fNJmg4
         B3ZsCMsw0di2TS8SE6Q3aWWI3VkVPAfGlSMcMG0kkyOJWzHDC34sTTeoUSiwpw2Pts+v
         KqTWjKm1Ibno+P96sfRDv0xh5piipOFzd6FSYUn7tb5SF+OmHYOk72TNR6EMMwv3mmPA
         iZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493911; x=1772098711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=w9UAPpC+HhDVD943e5KUsmaVLJp9nlClkZdECcdzy6MbOYfdlQl7yvLDEe+XgwLxch
         PRzg76gvZeyCVZKZ/TWmPNV4HDisqU1vIkqRstyi5Vtt/QI/NG+NEfVJ7FSFPoyxpY1X
         jxX4RmZr5CD21cSI6mALudyaIrMtfpWp7Cx1LlnVORTFl/gPtOsKfbXTSrqootshWFmm
         oLu5fdqSpwMObeHOtr4R/DV8+CCw3QQKMbDROVbYHrdmK0VD2Wr5YbMvZu/ncRg6rglL
         FlEV8FvmlKrCnfdYBQCvvXwXm7psjA588nwHzmNPvwfEM6bMoMV/4k68XaHfyeCaYOCR
         6pUw==
X-Gm-Message-State: AOJu0YwXPauob6ZtI0va/Fb6vaSlXF6QXvNsoEqyi6JTsBNGpIao2qe2
	A+eDuboiM91DNF3PG7S1G05Cejk3CUd228Ex5Rtp4t+y0sVwFiUX0d5G
X-Gm-Gg: AZuq6aL0Bh2Ery9mDiF0aPCQFdI1M/+Fh14K9fRjHERdDjv+7zR7I2I312q0cQx/275
	FHeZCImP3GuG2CcvITp5AdIUwczAmjRS8NtcDPMndKz1a7MqiDtXW3fSKo/BPBqUsI9Nvn/HYO6
	lzS5FhHEEHfzvufxsmI6hNMoMuldjXDvvZ5vRigtFG4PRdeTBG941N9oI/tjEWEm4hN5J5xfzuB
	u05+xMnniSHApX1Jc3k7bE3fcqbDPOJ1qrG9/cghBWWxOgInpygBcjdVarx48X/+dyCY0VEbgPz
	kSEwoD+g3AtOiNdxQXJviMG6yq50HLhvRNtm1WvP4OgsqQFip73meDWoCBQvF2Scpv35GRipaY+
	kreagvdtUixE3E31gtu9JDtkfnVwMfMt24KGRadC9MgGiUvNqQup80D3glivuOhp5eAopG1vP/g
	PO47I26Q7DOpR8j/Q+indH+ZzwTLHRzQ==
X-Received: by 2002:a05:600c:83c6:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4839e636fa5mr22462125e9.8.1771493910757;
        Thu, 19 Feb 2026 01:38:30 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 19 Feb 2026 10:38:22 +0100
Subject: [PATCH v7 3/6] refs: move out stub modification to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-kn-alternate-ref-dir-v7-3-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hKHkVnsRLcFQ9PsFN4V7LfLCrhed0Vs0
 Ef/8thRXQf+y4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoSAAoJED7VnySO
 Rox/HYML/Aoiw5fj/q8l2v4u1nfe95/EBkOVjuk32VJf57eVIDOm6e8ffOKbXTbxjMFsYpe/LcV
 leQnhVxLREPoodB3TZx7qTq72SM+bsfkjEsCUjV5ffE7dFMr2YYPxkBmXhlfOuXEIQd6cJ1Cow+
 m5X1UaLhi0TKs6c/be99PhX4s9iLYP2GDLcjlAkdsPgKaAstbjPkLtFZD32hhQt7+8BfQwb63hi
 Vq2jl2k7sE/hiB6/goL0em5lre2ff73Ns45bBJxOHM4yW8rMcvXKCgCRblRrNhmA6cwuTN3lyEr
 K9tcA0/tSdq2dAGkVSmjdVBnTNtzBeOW4uzXKWfiNyODxX5PksCae55YAY46LlSgzaYnmr4j1qA
 9dMMRjDvsIdqesdcxENvlHTs5clM9KHgvnaEkR8fCwHVVuG9FhtncrCcUrjCyvcWCsIInydQQWA
 8t7YAzAer4RJrt9pqv8q58c2kVbZMKLQ8vsub8K4Mv7MSZDmhcr29JZDP/YJmvhk1yctIGXN0h7
 Sg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When creating the reftable reference backend on disk, we create stubs to
ensure that the directory can be recognized as a Git repository. This is
done by calling `refs_create_refdir_stubs()`. Move this to the generic
layer as this is needed for all backends excluding from the files
backends. In an upcoming commit where we introduce alternate reference
backend locations, we'll have to also create stubs in the $GIT_DIR
irrespective of the backend being used. This commit builds the base to
add that logic.

Similarly, move the logic for deletion of stubs to the generic layer.
The files backend recursively calls the remove function of the
'packed-backend', here skip calling the generic function since that
would try to delete stubs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c    |  6 +++++-
 refs/reftable-backend.c | 27 ---------------------------
 3 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index 77b93d655b..c83af63dc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2189,12 +2189,55 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
 /* backend functions */
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	return refs->be->create_on_disk(refs, flags, err);
+	int ret = refs->be->create_on_disk(refs, flags, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
+		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
+		strbuf_release(&msg);
+	}
+
+	return ret;
 }
 
 int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
 {
-	return refs->be->remove_on_disk(refs, err);
+	int ret = refs->be->remove_on_disk(refs, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub HEAD: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub heads: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", refs->gitdir);
+		if (rmdir(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete refs directory: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+
+		strbuf_release(&sb);
+	}
+
+	return ret;
 }
 
 int repo_resolve_gitlink_ref(struct repository *r,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..d3f6423261 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3700,7 +3700,11 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
 		ret = -1;
 
-	if (ref_store_remove_on_disk(refs->packed_ref_store, err) < 0)
+	/*
+	 * Directly access the cleanup functions for packed-refs as the generic function
+	 * would try to clear stubs which isn't required for the files backend.
+	 */
+	if (refs->packed_ref_store->be->remove_on_disk(refs->packed_ref_store, err) < 0)
 		ret = -1;
 
 	strbuf_release(&sb);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d8651fe779..6ce7f9bb8e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -491,9 +491,6 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
-				 "this repository uses the reftable format");
-
 	strbuf_release(&sb);
 	return 0;
 }
@@ -519,30 +516,6 @@ static int reftable_be_remove_on_disk(struct ref_store *ref_store,
 			    strerror(errno));
 		ret = -1;
 	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub HEAD: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub heads: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	if (rmdir(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete refs directory: %s",
-			    strerror(errno));
-		ret = -1;
-	}
 
 	strbuf_release(&sb);
 	return ret;

-- 
2.53.GIT

