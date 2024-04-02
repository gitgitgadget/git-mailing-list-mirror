Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877415E5C1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093912; cv=none; b=b1SDRMYYaZIPwv6yPwS0mRibsLaGkp9/1ikE70FwPoV5U9HnZdkZOaKsbkxOJvU4rQTTbkjEDz2SNHEZLhAAqY+CdZe7PIt0+fDc77JAfR65InxSOLCF0X6b6fYMAiyyQnEDlGrALQ+CohWZ/2ZBb2PswnzGFK5LbNhen6JD9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093912; c=relaxed/simple;
	bh=yTE/5A21D1siAXrg242cbxs1GzvxvXjnMOg10rkg7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3TzULuaphtrAUo9R1obgW4KVtmJKr+G0aKmjs2Erdons8gJhiK0zVB+XYTwuFPzQ4rNtf+v2m9j8StwINA4bzqPKj4q+aJI7ckTsjtV/hoFxyJarHROV4bi2qsWlsvSNQJnvISm6chp21aJEAh7n79d+BF5TfeW8INAV6wxT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKoCUPpy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKoCUPpy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0f3052145so53295955ad.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093909; x=1712698709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv4tZHjT5AL2gvmOA1FJoEGBKrvOF/EacxCd7yXYOx8=;
        b=GKoCUPpyp/hohUKiO9MmSvXtOZV/Wb7OeZrCJZBNeTUeGvgl81nQ/Mt7j7rH6/w8bV
         nQNaaR8raCwrxnc37k73KnF6WfsrMRdaq0rzFD/THnc+RHT7lQ6AU0+tZtuRLh6SGLki
         fNRKhWBZIB3RdTM/rAApwJd3FPd2O3tk4QUwTMn1K3KOmHPaoR+ei/8Fuld3LHrmvIiA
         VxQbrPEhvDmuC1mrACoBowSuyRT0PUiH/v0EoeBMPsoDHQvnCs86Y2ZidsuDo5nm07H6
         SFqFPixz84Lfb96tArkHgv87RTDcHT/9OfdWcd3MHRUxucE65RFpi292AqedenkCt7JS
         KWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093909; x=1712698709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tv4tZHjT5AL2gvmOA1FJoEGBKrvOF/EacxCd7yXYOx8=;
        b=lWNEC2UqqRKPrlWu3402ipMiz6Xx0c02MDBccWydyQMuqEtO07kegvTJzQhlrTfbkm
         cbSpUBtriI98HzKhLREcoEXngPtBw1PF5Skl8ihXq9ARkpR5Y79t4YGCqj+6Mg1+HGSh
         gNs7MdWp2gs8a/xv+JybiczD9PDfRNZIb1VhYG+9WKdzGv6TwuwiI7Rhe5fDsJG4x+UV
         13YRlI+hQHPLnPgBdRCuKrSDvRek0/Q/G3tFJ0w8ML8YmfaKp4KYS7JtoVnHoDNK7Vvp
         Okc1AmU0LoEOOq8F5vXa00l8ncfiU+38joypPFIQvrvCNngqfY1nxb9FX/ploasLg/bV
         xhTA==
X-Gm-Message-State: AOJu0YyPRfn4CgrJWvCd3VZabS4vIBGl9+A/NTY82iKanZ2l4nSmESvg
	PqcKJLKAJ9x2XC0IgihXra5f+AIP5DynKbK0v6XaMTLJjduhE/iXqC3POahb
X-Google-Smtp-Source: AGHT+IE+hdfVpBAMmh88y7754PPh5kLNihE153/s+5qZhmm7/BoG/+IHBsJHP07j3XNGjK4/defD0Q==
X-Received: by 2002:a17:902:ecd1:b0:1e2:7c3a:835d with SMTP id a17-20020a170902ecd100b001e27c3a835dmr1055242plh.8.1712093909484;
        Tue, 02 Apr 2024 14:38:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001e1071cf0bbsm11641513plb.302.2024.04.02.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:38:29 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] revision: optionally record matches with pathspec elements
Date: Wed,  3 Apr 2024 03:06:23 +0530
Message-ID: <20240402213640.139682-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Unlike "git add" and other end-user facing commands, where it is
diagnosed as an error to give a pathspec with an element that does
not match any path, the diff machinery does not care if some
elements of the pathspec do not match. Given that the diff
machinery is heavily used in pathspec-limited "git log" machinery,
and it is common for a path to come and go while traversing the
project history, this is usually a good thing.

However, in some cases, we would want to know if all the pathspec
elements matched. For example, "git add -u <pathspec>" internally
uses the machinery used by "git diff-files" to decide contents from
what paths to add to the index, and as an end-user facing command,
"git add -u" would want to report an unmatched pathspec element.

Add a new .ps_matched member next to the .prune_data member in
"struct rev_info" so that we can optionally keep track of the use of
.prune_data pathspec elements that can be inspected by the caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c      |  4 ++--
 builtin/checkout.c |  3 ++-
 builtin/commit.c   |  2 +-
 diff-lib.c         | 11 ++++++++++-
 read-cache-ll.h    |  4 ++--
 read-cache.c       |  8 +++++---
 revision.h         |  1 +
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..dc4b42d0ad 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -553,8 +553,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, include_sparse,
-						  flags);
+						  &pathspec, NULL,
+						  include_sparse, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b6166c284..c297aa0e32 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,7 +882,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(the_repository, NULL, NULL, 0, 0);
+			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
+					   0);
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index b27b56c8be..8f31decc6b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -444,7 +444,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
-				   &pathspec, 0, 0);
+				   &pathspec, NULL, 0, 0);
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
diff --git a/diff-lib.c b/diff-lib.c
index 1cd790a4d2..683f11e509 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -127,7 +127,16 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		/*
+		 * NEEDSWORK:
+		 * Here we filter with pathspec but the result is further
+		 * filtered out when --relative is in effect.  To end-users,
+		 * a pathspec element that matched only to paths outside the
+		 * current directory is like not matching anything at all;
+		 * the handling of ps_matched[] here may become problematic
+		 * if/when we add the "--error-unmatch" option to "git diff".
+		 */
+		if (!ce_path_match(istate, ce, &revs->prune_data, revs->ps_matched))
 			continue;
 
 		if (revs->diffopt.prefix &&
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2a50a784f0..09414afd04 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -480,8 +480,8 @@ extern int verify_ce_order;
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags);
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags);
 
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index f546cf7875..e1723ad796 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3958,8 +3958,8 @@ static void update_callback(struct diff_queue_struct *q,
 }
 
 int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags)
+		       const struct pathspec *pathspec, char *ps_matched,
+		       int include_sparse, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3971,8 +3971,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	if (pathspec)
+	if (pathspec) {
 		copy_pathspec(&rev.prune_data, pathspec);
+		rev.ps_matched = ps_matched;
+	}
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
diff --git a/revision.h b/revision.h
index 94c43138bc..0e470d1df1 100644
--- a/revision.h
+++ b/revision.h
@@ -142,6 +142,7 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
+	char *ps_matched; /* optionally record matches of prune_data */
 	struct pathspec prune_data;
 
 	/*
-- 
2.44.0

