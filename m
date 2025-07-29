Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27F1CDFD5
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798372; cv=none; b=ovqCRPrEIpbAen4ozFJPH08DI1aNkG1PYR4RY5jDNdNJrWHz3faRFiJX3mwFKNbIFV+uR4MbmNsT26JH2luIskIrSC8Oemm6osainNIJvQvcgG5d7Q/o0Jf+lSQwFz//dpPIEsMKfg36U0VVtShchFXnGr/MOmLbXEYEJW5tZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798372; c=relaxed/simple;
	bh=kxFliY0diRAIGzTfDYfMrFtmXRXrWIBkR8LGZPJoJQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5Nk/QtNqdNx0sFWXqxrPNBhmW0AKrhGE7Cef8SMHWnj0QHo9Divhm949hE2NQ2AmKeSy6I0I2YJv4bLjJjGIhXTyu2JX2k1mt34amJCxih5/tCWlPghxULFFI6HiQwkTycGHMIpM87/L/I/iFdDSMazi6O/PSj6EX7lsGVGCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UGOGydmy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CflpG9LV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UGOGydmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CflpG9LV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7FBB7A00C0;
	Tue, 29 Jul 2025 10:12:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753798369;
	 x=1753884769; bh=IDQ5W222rWsuYzafyOKrdM5IImPxnYmv3cZw05GlfdA=; b=
	UGOGydmy6yJQVhUYqnx9xjB+Wokl32Uo0CDW0FsoDfj/ft7/j9ZxWUJ3n1O25kVg
	Ly4FFcA6vzhVulCcxbBiQ4p9DO+uMb51jeQ8Rji0BVIQAf3pyRkrSpv8ENC2FbgF
	gXpHIjfzW4qcDv/7wgvzOiDTBBaMVHjCUtWAdYPk2z1ckpA7FuRWL3qDELELrdKQ
	Ykng5EDetKPpB5sUAVT8CcKVqCYZoikXpHUYDRIcwTZFp01NKH+QEoa2cHRdN4ko
	dfG7SuQfgRSjrXAp8DnrpfEZeBTATLg3P3uwxYyjJIEABroDy6zZ+PL2zH+EhZZX
	fqiW77TR6v9UVIAiVgnvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753798369; x=
	1753884769; bh=IDQ5W222rWsuYzafyOKrdM5IImPxnYmv3cZw05GlfdA=; b=C
	flpG9LVGEm47DE5zRQJKtaMbS6pVHQGTBxehLSFSrv/fety6cpA/BlcumMHPxhgL
	HB6qZ6gd77bxZRO8CJsot2SYm94sXV54mPgIH0zt/fB+zrW/B05mMd/+ECvdHEqG
	XW0bmhln3YhXg4Oa7TWw1xJIiAMO9/70icIi+0hhjvonrKn/CDXxvw/bxdfGLm/Y
	e11HvXe0lUx3/5unDYl4FAvaZ3a4HjtNE3VMPOX5fDwj8r/Z3vrmhoU7f7dvHu8k
	KBESiMlSrk8M+qkgVuv9tg7hBtCbUeD6po+E0BraAItIz5tVQj7t4O6vbDVpuSjG
	d8bEKDaVc+E8fxmLNw89w==
X-ME-Sender: <xms:4daIaBOSeLB7xGUC6S_rfZE-EphDel7-AhQMlxq-3k4QPxbWAOUMuw>
    <xme:4daIaEI6YM4BlOjBTE9TxzkNSEbAz8y00aQ4yT-eHynwFPJ2fFU5jYQeK8w2o9XyY
    hRxhg5DDz53u60pzQ>
X-ME-Received: <xmr:4daIaCFjAmwdo1eHUmWd84ivXO9HRSocRfZgaQ6d9eoqPbPlVFm833CF4RgX_B6mN4qWPl5jKUPIqnbcU07wDgzBHYMidjD8hv_RFawXpEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:4daIaMRYRgyMiBXBmVhTrQrBGk1vKZAQRF7zvqiTRHVKGERpKqfvIg>
    <xmx:4daIaOHO-9cQZY28x40xK4CpQSgzWrWnjDp0fi3IhpexP5HcWgbrjg>
    <xmx:4daIaI_uFeNERMU42Fi3OIuE4CawB7-KO6D0f6c1P7zSxxyTdu7iew>
    <xmx:4daIaIIEUQS1SCUDRXHTboCy6HgCUbey_wGSrCem8o7KkckwURVLaw>
    <xmx:4daIaLBLEFZfpK4OXD4qOTmhzYs-n-GWN0X2kx-s1JLehX-xBVSACItS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:12:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58e35f71 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:12:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:12:40 +0200
Subject: [PATCH 1/8] odb: store locality in object database sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Object database sources are classified either as:

  - Local, which means that the source is the repository's primary
    source. This is typically ".git/objects".

  - Non-local, which is everything else. Most importantly this includes
    alternates and quarantine directories.

This locality is often computed ad-hoc by checking whether a given
object source is the first one. This works, but it is quite roundabout.

Refactor the code so that we store locality when creating the sources in
the first place. This makes it both more accessible and robust.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c       | 5 +++--
 midx.h       | 2 +-
 odb.c        | 1 +
 odb.h        | 8 ++++++++
 packfile.c   | 9 ++++-----
 repository.c | 1 +
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 7d407682e6..b9ca0915a6 100644
--- a/midx.c
+++ b/midx.c
@@ -723,7 +723,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct odb_source *source, int local)
+int prepare_multi_pack_index_one(struct odb_source *source)
 {
 	struct repository *r = source->odb->repo;
 
@@ -734,7 +734,8 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	if (source->midx)
 		return 1;
 
-	source->midx = load_multi_pack_index(r, source->path, local);
+	source->midx = load_multi_pack_index(r, source->path,
+					     source->local);
 
 	return !!source->midx;
 }
diff --git a/midx.h b/midx.h
index 076382de8a..28c426a823 100644
--- a/midx.h
+++ b/midx.h
@@ -122,7 +122,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct odb_source *source, int local);
+int prepare_multi_pack_index_one(struct odb_source *source);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
diff --git a/odb.c b/odb.c
index 1f48a0448e..1761a50840 100644
--- a/odb.c
+++ b/odb.c
@@ -176,6 +176,7 @@ static int link_alt_odb_entry(struct object_database *odb,
 
 	CALLOC_ARRAY(alternate, 1);
 	alternate->odb = odb;
+	alternate->local = false;
 	/* pathbuf.buf is already in r->objects->source_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
diff --git a/odb.h b/odb.h
index 09177bf430..d9f4dcf79f 100644
--- a/odb.h
+++ b/odb.h
@@ -63,6 +63,14 @@ struct odb_source {
 	 */
 	struct multi_pack_index *midx;
 
+	/*
+	 * Figure out whether this is the local alternate of the owning
+	 * repository, which would typically be its ".git/objects" directory.
+	 * This local object directory is usually where objects would be
+	 * written to.
+	 */
+	bool local;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
diff --git a/packfile.c b/packfile.c
index 5d73932f50..a38544b87b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -935,14 +935,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct odb_source *source, int local)
+static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
 		.m = source->midx,
 		.r = source->odb->repo,
 		.garbage = &garbage,
-		.local = local,
+		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
@@ -1037,9 +1037,8 @@ static void prepare_packed_git(struct repository *r)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		int local = (source == r->objects->sources);
-		prepare_multi_pack_index_one(source, local);
-		prepare_packed_git_one(source, local);
+		prepare_multi_pack_index_one(source);
+		prepare_packed_git_one(source);
 	}
 	rearrange_packed_git(r);
 
diff --git a/repository.c b/repository.c
index ecd691181f..97f0578381 100644
--- a/repository.c
+++ b/repository.c
@@ -168,6 +168,7 @@ void repo_set_gitdir(struct repository *repo,
 	if (!repo->objects->sources) {
 		CALLOC_ARRAY(repo->objects->sources, 1);
 		repo->objects->sources->odb = repo->objects;
+		repo->objects->sources->local = true;
 		repo->objects->sources_tail = &repo->objects->sources->next;
 	}
 	expand_base_dir(&repo->objects->sources->path, o->object_dir,

-- 
2.50.1.619.g074bbf1d35.dirty

