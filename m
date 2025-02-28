Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5E2595
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702569; cv=none; b=OMJUkfAsxW2VwaGvnwmlXfpDnV5mpuJVhbv5FHTyiyN6av6d1NBwSt5JPGaNDRbsH0HpAp9MvxB2IH47juJZvjtm6jBY8t78upxAN1q9fEtSkiy7qE1+xUnDQTFW5Wf9MwVYcJMJM0LSeZG6Genmq4C87yF/szYimK66ShYtBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702569; c=relaxed/simple;
	bh=1J2x39s0XLh1sCWMM94XZ9BOn905I2s5UyrOQYTlPWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti2+fbm/Sx2/S/xZ8TTmL7TrebmB8jOugyix4/TMa66MSpx3m55aRLfC8eXZyEV5OVCm3znZkK+LMIKRICxNTe2Wwfk0te0qIrZ+MFNrFHfAtDMPNk4K7rIcmJZYS2uROGl7QABgZ5Zx02ywVrvh3a6oV9sDfpXO6FNYUYvpOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf0Q0pWI; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf0Q0pWI"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fcd56c34a1so868457eaf.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702566; x=1741307366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2S1IpkDcboFUmNqoGg63vclsReOu00DdzecLlPSqMs=;
        b=Pf0Q0pWIDgOa5jc84zn4C7nRcAZt32SgIbRwG6pYZzvP29e50SGqReGR2hM6pFN0XV
         zj9buX46Er3Xrp50zfCv/ZkowshULlekFPUjFqT1gi6fylUapLrHhCkuhjM4N1hAZf1Z
         zAqTKZkNMsNOiXXbkxnG91ltMZI1/906GoazQpmT3OhQrozCg2quB1T3Kb0Iz50fPopR
         K5TpNk2BU+EjoJRRMonR78ueTDBjlH1dEIwo2bLAAEEtPQ81VzMxjAXHR5iUwbPH91zK
         Iduzfai2Q+cUxDVYGnNCEPmy82um5KzkwHP4FjBmAJ1LdpiNPtNQZZB7LY4+1rM4buaF
         OpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702566; x=1741307366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2S1IpkDcboFUmNqoGg63vclsReOu00DdzecLlPSqMs=;
        b=ha0LFyNKa7gI/9uatfVr8U8o7F42bF+5DMZc6sVPCWV3FxUFSsJE6p9eoYYDoZxtQf
         ckUi7OtXkoE9d5vrugnf69xhpvMygdn4YNOAfXXfZ8AXgwnTfsb/ZeUUaVaCmpyi4vJo
         XouKZeTnb4Qh8gJDDIvgMoXGcebQ1/FGpkbIvwAp3ZOwKSopstOFYaviZ0xhfnX4r2fg
         DQsdfQyPtsQbB8IYNS/vn2PWXlg/vhzwL+IOcwYQugZ8Z0jz2KNxjMZVz377unHaUZr6
         wkNNljUX83MbR1JA0GRMAp6YbJJA2IaFuNLHHk7B6QbLz7b9zxlelKA4c/Ca0+ZUnjE/
         t+mQ==
X-Gm-Message-State: AOJu0Yz+9iNhQLf8Sr4EV3a+E/dZWIvLicFsPd7/mKXMlsSobaNnty8H
	dvHU7NTjXu2/AXt+1CHZBOTHC9oktG7v01TImTalJZTo+IoxbytLfkNOCTAE
X-Gm-Gg: ASbGncumHVRhTK9bLSMhW8bLOaDiFwh/nbmn1p9B76sKCiRLuC/lT44ISysn3ucUQth
	uEOMd7OyF5aFiB5JY6qDy7SMM6drdVmExr5aptw71Q4rrPDjmN+JhjDv7lR7YhByDlKYKQFnbnX
	sgQY16mu7nWPV0OLy0RvLiBncRwxfDJDGIrKS6u4BQ0bLEFho7mWmpHrlaJp4SiymyDMcRDF0Or
	scpg543+rBgrmv1SXG/2cQSbjJvWxwXOTVeRgJbls0tIRFxFbIEud0oXs5QFS15uPKC2yAZatqR
	y3J7/dLdR/hrw0feHbJLtLX2xtVKKTmCtA==
X-Google-Smtp-Source: AGHT+IHcuh5lT37zPVYPH18xah0ZMgW3AQRpzM2VrQDAESi1XK/M2OlbD7XtCudaChNy926AufR1MA==
X-Received: by 2002:a05:6820:270a:b0:5fc:fb1a:2b92 with SMTP id 006d021491bc7-5feb361493fmr645898eaf.6.1740702566322;
        Thu, 27 Feb 2025 16:29:26 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaab9c8f9sm456509eaf.19.2025.02.27.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:29:25 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/4] diff: return diff_filepair from diff queue helpers
Date: Thu, 27 Feb 2025 18:26:01 -0600
Message-ID: <20250228002604.3859939-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228002604.3859939-1-jltobler@gmail.com>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `diff_addremove()` and `diff_change()` functions set up and queue
diffs, but do not return the `diff_filepair` added to the queue. In a
subsequent commit, modifications to `diff_filepair` need to occur in
certain cases after being queued.

Since the existing `diff_addremove()` and `diff_change()` are also used
for callbacks in `diff_options` as types `add_remove_fn_t` and
`change_fn_t`, modifying the existing function signatures requires
further changes. The diff options for pruning use `file_add_remove()`
and `file_change()` where file pairs do not even get queued. Thus,
separate functions are implemented instead.

Split out the queuing operations into `diff_queue_addremove()` and
`diff_queue_change()` which also return a handle to the queued
`diff_filepair`. Both `diff_addremove()` and `diff_change()` are
reimplemented as thin wrappers around the new functions.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 diff.c | 70 +++++++++++++++++++++++++++++++++++++++++-----------------
 diff.h | 25 +++++++++++++++++++++
 2 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 019fb893a7..b5a779f997 100644
--- a/diff.c
+++ b/diff.c
@@ -7157,16 +7157,19 @@ void compute_diffstat(struct diff_options *options,
 	options->found_changes = !!diffstat->nr;
 }
 
-void diff_addremove(struct diff_options *options,
-		    int addremove, unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    const char *concatpath, unsigned dirty_submodule)
+struct diff_filepair *diff_queue_addremove(struct diff_queue_struct *queue,
+					   struct diff_options *options,
+					   int addremove, unsigned mode,
+					   const struct object_id *oid,
+					   int oid_valid,
+					   const char *concatpath,
+					   unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *pair;
 
 	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	/* This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
@@ -7186,7 +7189,7 @@ void diff_addremove(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7198,25 +7201,29 @@ void diff_addremove(struct diff_options *options,
 		two->dirty_submodule = dirty_submodule;
 	}
 
-	diff_queue(&diff_queued_diff, one, two);
+	pair = diff_queue(queue, one, two);
 	if (!options->flags.diff_from_contents)
 		options->flags.has_changes = 1;
+
+	return pair;
 }
 
-void diff_change(struct diff_options *options,
-		 unsigned old_mode, unsigned new_mode,
-		 const struct object_id *old_oid,
-		 const struct object_id *new_oid,
-		 int old_oid_valid, int new_oid_valid,
-		 const char *concatpath,
-		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
+struct diff_filepair *diff_queue_change(struct diff_queue_struct *queue,
+					struct diff_options *options,
+					unsigned old_mode, unsigned new_mode,
+					const struct object_id *old_oid,
+					const struct object_id *new_oid,
+					int old_oid_valid, int new_oid_valid,
+					const char *concatpath,
+					unsigned old_dirty_submodule,
+					unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
 	struct diff_filepair *p;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	if (options->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
@@ -7227,7 +7234,7 @@ void diff_change(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7235,19 +7242,42 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_oid, new_oid_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
-	p = diff_queue(&diff_queued_diff, one, two);
+	p = diff_queue(queue, one, two);
 
 	if (options->flags.diff_from_contents)
-		return;
+		return p;
 
 	if (options->flags.quick && options->skip_stat_unmatch &&
 	    !diff_filespec_check_stat_unmatch(options->repo, p)) {
 		diff_free_filespec_data(p->one);
 		diff_free_filespec_data(p->two);
-		return;
+		return p;
 	}
 
 	options->flags.has_changes = 1;
+
+	return p;
+}
+
+void diff_addremove(struct diff_options *options, int addremove, unsigned mode,
+		    const struct object_id *oid, int oid_valid,
+		    const char *concatpath, unsigned dirty_submodule)
+{
+	diff_queue_addremove(&diff_queued_diff, options, addremove, mode, oid,
+			     oid_valid, concatpath, dirty_submodule);
+}
+
+void diff_change(struct diff_options *options,
+		 unsigned old_mode, unsigned new_mode,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
+		 const char *concatpath,
+		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
+{
+	diff_queue_change(&diff_queued_diff, options, old_mode, new_mode,
+			  old_oid, new_oid, old_oid_valid, new_oid_valid,
+			  concatpath, old_dirty_submodule, new_dirty_submodule);
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
diff --git a/diff.h b/diff.h
index 0a566f5531..63afa17e84 100644
--- a/diff.h
+++ b/diff.h
@@ -508,6 +508,31 @@ void diff_set_default_prefix(struct diff_options *options);
 
 int diff_can_quit_early(struct diff_options *);
 
+/*
+ * Stages changes in the provided diff queue for file additions and deletions.
+ * If a file pair gets queued, it is returned.
+ */
+struct diff_filepair *diff_queue_addremove(struct diff_queue_struct *queue,
+					   struct diff_options *,
+					   int addremove, unsigned mode,
+					   const struct object_id *oid,
+					   int oid_valid, const char *fullpath,
+					   unsigned dirty_submodule);
+
+/*
+ * Stages changes in the provided diff queue for file modifications.
+ * If a file pair gets queued, it is returned.
+ */
+struct diff_filepair *diff_queue_change(struct diff_queue_struct *queue,
+					struct diff_options *,
+					unsigned mode1, unsigned mode2,
+					const struct object_id *old_oid,
+					const struct object_id *new_oid,
+					int old_oid_valid, int new_oid_valid,
+					const char *fullpath,
+					unsigned dirty_submodule1,
+					unsigned dirty_submodule2);
+
 void diff_addremove(struct diff_options *,
 		    int addremove,
 		    unsigned mode,
-- 
2.48.1

