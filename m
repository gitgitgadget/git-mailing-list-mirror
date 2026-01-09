Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D740359703
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962391; cv=none; b=r9QqRvLclq7Vv+7iiQhAJHry4cQPqGOOtOT9lJ04agXZnd0+TP9zQqKWJamPcPUMu9H1B64qs0oN8YY1UJAUJ09HCvj4rjXhbKDK56D6pjo+hCoyn3pTSvjEAyWgMP+exHnJglqgWXMljUnnGrzZ96MLnXSR9dj9QrxjYzSwUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962391; c=relaxed/simple;
	bh=XQlMJbMrlZpjeSiTIdlNgiA2MSuDOZ2tYvGtsZutb9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNu1bv/v17gtvhxn7ShO/NyHfRwoaZYAmg+dPg1vBsNSJI0r2lGl/Ru3YxLjT4DFOECDVTkNOyNVtfiFdgja0Ydp5PATsx/iU2NatwjgGMX9t04Z9CNHCMuU4m2qNpw8h4bCDGDUAs991gJtMhgVDC8ZVZ1FwQ/rNhMHf/cnHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gm2kzNMK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xtUtozUK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gm2kzNMK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xtUtozUK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81F4F140012E;
	Fri,  9 Jan 2026 07:39:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962389;
	 x=1768048789; bh=fEtM4lqtXw89Vh8goJyX2ifOvgtzS1STrUn7CqEGfD0=; b=
	gm2kzNMKfIq0ZJCVDT8CUlErbuRm5ktj0qNW4uOTrqndIEUZH+4XgMSQnhg/NEqj
	EPVV5ppHan80lYgUO/xqfEViHnaKC6ZuT5yfERsUeYBB4Ysd+zWl/FSoUn3RnlDc
	NqTjPFmfuY9k5T3smEU+1kzI2L3w4C4p8Pv/Mvtgl3R+NYDD6xcJKtle1yiW0HTV
	4j7XoaQXtAKQTJMPv+Zl3LRPWQ5/q/AldHlzdMRhSifUXz1OOkgri1aQQh0arM66
	gOTNwQxjqBRUS5oZtmanacPzI6wQqyAlqAy5UH5uAUrIwkdRt2sTWmX7sV1+ayDL
	eqBxNESz9jMPMrnzkiEANA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962389; x=
	1768048789; bh=fEtM4lqtXw89Vh8goJyX2ifOvgtzS1STrUn7CqEGfD0=; b=x
	tUtozUKLOFXdTQm0YzSkRdgzRB1f9ZM518euFfRDSrScibKaMRNNwO+K9EgXkapK
	5oKo/VUYlIztxdQ8nvR+7XmBpp/WH6kLAvFovQ40WKKI8QhSB0ckIjaxHH7mFMAA
	2tIEEPaM7BPH1X4VmKK8sfMfgzNGa5IVNPQsbEshqSqbsbsZw5Egfg0IBw3DGcam
	x1MtVLisgj2kMnRFH6oukyIEzqKsrvKSR7PgozpF+YXflw78qiAtpdkY2gnV0Iu4
	zog1G1cvYc+BGLDN9QMH/mOV+PGue5OAGrQLvv+QismPMogmKsL3RjrtsyZG1LDy
	wU1JiNBT0eS+nY3paHpRw==
X-ME-Sender: <xms:FPdgaUggyqTlnrYZ6TMxt_qFjS4FoDNBBco4-5CMTYNyCVb98CnPcw>
    <xme:FPdgaUdmQqc6ETQVlYF_i0PICRKMHs0G1QKMdWTiGFcL-VJ0LawxGqgdpucFfaSYI
    Q4aTibCGRhNfPkof74BKi-Zp088CUbhnB8p3_EZgdhwuBUD1S-Dxg>
X-ME-Received: <xmr:FPdgaZdeG-_8szEW-AGjIbBUA3BaxQZgrtuyQr-6yRCwIQ8zJlztN5svHnAAGxiplLtq_Nb2JxyeWse80PjF9ktwLFnKkl8pnxXuaVu50w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FPdgae9zoXMMMqLV9Wl1sSXREk5-I9cLWb5SbJ3ngpShrcJ5UN8nkA>
    <xmx:FPdgaVmSnNbXbOoFHsJYFEQLg-rKzWgBHYWNS1pLKuJ8GdJA04d9kQ>
    <xmx:FPdgaQ_Hwy4VnM5CoxZbcP4cy_PxgLMDGppyYHdmxkq_BVhzqFi1Ag>
    <xmx:FPdgaTlF2r9mPqqZUKnbViPl3xsi8-z7YVGcOpiyds-xf6kG2Asiuw>
    <xmx:FfdgadUWAXCXSq6h3qWB4eehIPQmZsCo6eZUHyE6MhVIJcriNq8maLTT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd268de6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:34 +0100
Subject: [PATCH 05/17] refs/files: extract function to check single ref
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-5-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When checking the consistency of references we create a directory
iterator and then verify each single reference in a loop. The logic to
perform the actual checks is embedded into that loop, which makes it
hard to reuse. But In a subsequent commit we're about to introduce a
second path that wants to verify references.

Prepare for this by extracting the logic to check a single reference
into a standalone function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 80 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4cbee23dad..9972221f9f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3715,7 +3715,8 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
 				  const char *refname,
-				  struct dir_iterator *iter);
+				  const char *path,
+				  int mode);
 
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
@@ -3772,7 +3773,8 @@ static int files_fsck_symref_target(struct fsck_options *o,
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *target_name,
-				   struct dir_iterator *iter)
+				   const char *path,
+				   int mode)
 {
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf abs_gitdir = STRBUF_INIT;
@@ -3786,7 +3788,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	report.path = target_name;
 
-	if (S_ISLNK(iter->st.st_mode)) {
+	if (S_ISLNK(mode)) {
 		const char *relative_referent_path = NULL;
 
 		ret = fsck_report_ref(o, &report,
@@ -3798,7 +3800,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
 			strbuf_addch(&abs_gitdir, '/');
 
-		strbuf_add_real_path(&ref_content, iter->path.buf);
+		strbuf_add_real_path(&ref_content, path);
 		skip_prefix(ref_content.buf, abs_gitdir.buf,
 			    &relative_referent_path);
 
@@ -3811,7 +3813,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+	if (strbuf_read_file(&ref_content, path, 0) < 0) {
 		/*
 		 * Ref file could be removed by another concurrent process. We should
 		 * ignore this error and continue to the next ref.
@@ -3819,7 +3821,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		if (errno == ENOENT)
 			goto cleanup;
 
-		ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);
+		ret = error_errno(_("cannot read ref file '%s'"), path);
 		goto cleanup;
 	}
 
@@ -3861,16 +3863,20 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
-				struct dir_iterator *iter)
+				const char *path,
+				int mode UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *filename;
 	int ret = 0;
 
+	filename = basename((char *) path);
+
 	/*
 	 * Ignore the files ending with ".lock" as they may be lock files
 	 * However, do not allow bare ".lock" files.
 	 */
-	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
+	if (filename[0] != '.' && ends_with(filename, ".lock"))
 		goto cleanup;
 
 	/*
@@ -3896,6 +3902,35 @@ static const files_fsck_refs_fn fsck_refs_fn[]= {
 	NULL,
 };
 
+static int files_fsck_ref(struct ref_store *ref_store,
+			  struct fsck_options *o,
+			  const char *refname,
+			  const char *path,
+			  int mode)
+{
+	int ret = 0;
+
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking %s", refname);
+
+	if (!S_ISREG(mode) && !S_ISLNK(mode)) {
+		struct fsck_ref_report report = { .path = refname };
+
+		if (fsck_report_ref(o, &report,
+				    FSCK_MSG_BAD_REF_FILETYPE,
+				    "unexpected file type"))
+			ret = -1;
+		goto out;
+	}
+
+	for (size_t i = 0; fsck_refs_fn[i]; i++)
+		if (fsck_refs_fn[i](ref_store, o, refname, path, mode))
+			ret = -1;
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       struct worktree *wt)
@@ -3918,30 +3953,17 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	}
 
 	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
-		if (S_ISDIR(iter->st.st_mode)) {
+		if (S_ISDIR(iter->st.st_mode))
 			continue;
-		} else if (S_ISREG(iter->st.st_mode) ||
-			   S_ISLNK(iter->st.st_mode)) {
-			strbuf_reset(&refname);
-
-			if (!is_main_worktree(wt))
-				strbuf_addf(&refname, "worktrees/%s/", wt->id);
-			strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
-			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s", refname.buf);
+		strbuf_reset(&refname);
+		if (!is_main_worktree(wt))
+			strbuf_addf(&refname, "worktrees/%s/", wt->id);
+		strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
-			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refname.buf, iter))
-					ret = -1;
-			}
-		} else {
-			struct fsck_ref_report report = { .path = iter->basename };
-			if (fsck_report_ref(o, &report,
-					    FSCK_MSG_BAD_REF_FILETYPE,
-					    "unexpected file type"))
-				ret = -1;
-		}
+		if (files_fsck_ref(ref_store, o, refname.buf,
+				   iter->path.buf, iter->st.st_mode) < 0)
+			ret = -1;
 	}
 
 	if (iter_status != ITER_DONE)

-- 
2.52.0.542.g9473a8513b.dirty

