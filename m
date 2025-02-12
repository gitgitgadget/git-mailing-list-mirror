Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530927182D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334136; cv=none; b=cJMtxqBHfzKGrUOW4tNoz6H8zKN4jLbyDq4Slim+cebqEHMbEf8Dztr/Wu/jeI8WfD57lWJV3z/ejD1nIQzqgcBCQjjCmkRkjMsp4Q5b5lysuXAB8I9UXI0xvTqNJN2UnhTBZEN1eN9P6zSMFko3evYd3yY4oNbkYDsLKytJ5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334136; c=relaxed/simple;
	bh=e/CczNF1l4UyZLEUBQL8RsQUdOxAmksqCa4amXrpasM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SboGnz2bLIvGKK38vHi7dLh1MUHjVFq+9/MzlO5YgO1GYUDIBiBwtfMAUuoG52LhV4qpzAzo+tmrNzZOtPbr5RzSQNUPerMRXnVb/azyR8K7bADPaxydZdrxlNR8sUV6VTTL/K6N0/+1UN/ymbLwmMCxijUHGMeddsauO+mVjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7iPaIou; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7iPaIou"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b8d6040598so260073fac.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739334133; x=1739938933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaUmfXwbibB4wwFe6uLV7f9+xKiVxydehJ+z5ibKjo0=;
        b=Y7iPaIousTaa13HEaubT4koXzvG8x8r4qxpNZ/KI3KWDu3L4Ld7vsQodZxT6J9wDa3
         UJixrICgCEVSgFQn4DeOM7Huv9n0++unQU1VYt18LP+QShFz24ZPYZ0umS8BSTU6ZF/3
         ZvNO3bmYZQyKJ/wiwYyav65m+t3CMSwcozOgJfWYltQWk9mAE579aDBXmicDwMkA69np
         ROFJfz2VY8zct8tw+0pZugL3BUPjLpSR3iM1ksUAsQPvpwQqSh/1zqf2jLb65qH6Rjgw
         5qh/Mj2xdGFytiCcZOx4PD7TMflpJXe+R7150MBQXHgNWCBZ8GRYKidYh4LyRuMq4Nez
         ocUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739334133; x=1739938933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaUmfXwbibB4wwFe6uLV7f9+xKiVxydehJ+z5ibKjo0=;
        b=lUCQBEBMuFj6YAU7a/YI4G1pdorAiaeGhe4Vo+UZhC87rYI2RSCbPXfWhKBjetbsDq
         +hQrvU/SVDd4sgeVYnDWg5Pb9NtGoVXTOWFrNszOddRta0/2kzOAAEnyBuBpU4oG3cF4
         g8PRM8BdvNwAKu0LyMwHQ3XkEue4OQxD2x9b1OJAVGbkYk9j2BynqPLhsshhnbZXWGhr
         3n48OG9MM3kIt+UhFLvCy344UjPvtAAbG3r9snn2a3bKg32YT8QZZ+geJFYwglVToBlZ
         bVDmwvUzmr3gSHufrrQEK0LelYGXQlIt+YeQg+kNZR5fl4oRoPURivXIWUlTQ2yooIoj
         r6Ng==
X-Gm-Message-State: AOJu0Yy+RVSdEF19GsGBtVQAtj42zPevH3Mbt6QgwMOO8Cmn7sCj6/ys
	q+ahZ55IACTsv4QjdyY/RkX1cnQ4Cc7a1V1mt2GCs1+x9auP6Say062Hiw==
X-Gm-Gg: ASbGncvmUJ3bERf14AcfZiwnrpufFWVHnHv7bpBPNcRTbs/JlngchVQGKIMaIDYjoEk
	vnqkgGWt0FXi+Hadr5jD8zcK8yExc0hp36EZHoWH7Y8DwFP60ItUoAdCrC2kumVHgHqRcfT/OcP
	7v64UN7U2NNFStRZL5yqXuILz6xDRdHLx8JRlrzZ/4pncb+YTCPOzujAh2bhPPz88VNXxcYmad/
	7S5JVRf+NcX3G7grTjp/HpRELRD3qET/FXTASzTCmJykWld5lvr85IKh1j1UIeDYnedXsNYCsRP
	NAT9QOXv6IZMePtMmZimHns=
X-Google-Smtp-Source: AGHT+IEML/RQS9AT9nXlYVKGM5krqtKo5iECOvqJKzwkhiILGHVnY/m3xWPUs3qFAeGqIiGEdlpzaQ==
X-Received: by 2002:a05:6870:2253:b0:297:683:8b5b with SMTP id 586e51a60fabf-2b8b6e3082amr4037991fac.10.1739334132903;
        Tue, 11 Feb 2025 20:22:12 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8a0bb67fesm2293392fac.39.2025.02.11.20.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:22:12 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/3] diff: return diff_filepair from diff queue helpers
Date: Tue, 11 Feb 2025 22:18:23 -0600
Message-ID: <20250212041825.2455031-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212041825.2455031-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `diff_addremove()` and `diff_change()` functions setup and queue
diffs, but do not return the `diff_filepair` added to the queue. In a
subsequent commit, modifications to `diff_filepair` need to take place
in certain cases after being queued.

Split out the queuing operations into `diff_filepair_addremove()` and
`diff_filepair_change()` which also return a handle to the queued
`diff_filepair`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 diff.c | 66 +++++++++++++++++++++++++++++++++++++++++-----------------
 diff.h | 15 +++++++++++++
 2 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index 019fb893a7..afbb892c26 100644
--- a/diff.c
+++ b/diff.c
@@ -7157,16 +7157,18 @@ void compute_diffstat(struct diff_options *options,
 	options->found_changes = !!diffstat->nr;
 }
 
-void diff_addremove(struct diff_options *options,
-		    int addremove, unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    const char *concatpath, unsigned dirty_submodule)
+struct diff_filepair *diff_filepair_addremove(struct diff_options *options,
+					      int addremove, unsigned mode,
+					      const struct object_id *oid,
+					      int oid_valid,
+					      const char *concatpath,
+					      unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *pair;
 
 	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	/* This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
@@ -7186,7 +7188,7 @@ void diff_addremove(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7198,25 +7200,28 @@ void diff_addremove(struct diff_options *options,
 		two->dirty_submodule = dirty_submodule;
 	}
 
-	diff_queue(&diff_queued_diff, one, two);
+	pair = diff_queue(&diff_queued_diff, one, two);
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
+struct diff_filepair *diff_filepair_change(struct diff_options *options,
+					   unsigned old_mode, unsigned new_mode,
+					   const struct object_id *old_oid,
+					   const struct object_id *new_oid,
+					   int old_oid_valid, int new_oid_valid,
+					   const char *concatpath,
+					   unsigned old_dirty_submodule,
+					   unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
 	struct diff_filepair *p;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	if (options->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
@@ -7227,7 +7232,7 @@ void diff_change(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7238,16 +7243,39 @@ void diff_change(struct diff_options *options,
 	p = diff_queue(&diff_queued_diff, one, two);
 
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
+	diff_filepair_addremove(options, addremove, mode, oid, oid_valid,
+				concatpath, dirty_submodule);
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
+	diff_filepair_change(options, old_mode, new_mode, old_oid, new_oid,
+			     old_oid_valid, new_oid_valid, concatpath,
+			     old_dirty_submodule, new_dirty_submodule);
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
diff --git a/diff.h b/diff.h
index 0a566f5531..6ea63f01e7 100644
--- a/diff.h
+++ b/diff.h
@@ -508,6 +508,21 @@ void diff_set_default_prefix(struct diff_options *options);
 
 int diff_can_quit_early(struct diff_options *);
 
+struct diff_filepair *diff_filepair_addremove(struct diff_options *,
+					      int addremove, unsigned mode,
+					      const struct object_id *oid,
+					      int oid_valid, const char *fullpath,
+					      unsigned dirty_submodule);
+
+struct diff_filepair *diff_filepair_change(struct diff_options *,
+					   unsigned mode1, unsigned mode2,
+					   const struct object_id *old_oid,
+					   const struct object_id *new_oid,
+					   int old_oid_valid, int new_oid_valid,
+					   const char *fullpath,
+					   unsigned dirty_submodule1,
+					   unsigned dirty_submodule2);
+
 void diff_addremove(struct diff_options *,
 		    int addremove,
 		    unsigned mode,
-- 
2.48.1

