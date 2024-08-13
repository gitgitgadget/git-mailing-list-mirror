Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9769184554
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541487; cv=none; b=SaymJNc4ieeGQJixaiD+hCUG1SMt/Tauv+C0EXjF54n0CUZaB5DQQ8O833fwEGF0GXxxXArQJPG4uY4n9IZ8tqw08tqFh6lrIw5O4YI7RVkjmHBmNj+F7g8rc50sMattKY5RMG3jnKBnMs2ui8NZow2ZR9wUXTB58w3oDfRGUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541487; c=relaxed/simple;
	bh=dAZYz0j98vNnestOGKXW2iOYHIoBsZx/oj1Z4PZF0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vzt4VN8qgsfjpl8XYJFnSWBFlkHRQX3QvQWI7lyv1VTEgyPTBvN7TnbE3wIGHnwCgIbCZf7/Pt9XvuVV5G0Fq753yQLnbxf4JAJ8iJSKrUifSsqkrsiKr0qZkST/M2oEDh/nZXaPTCidrUZ1Q+Zxc7cWEh6NXUUlsM39PBdN7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mFoQcFZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boYNA9BD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mFoQcFZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boYNA9BD"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 162C41151B39;
	Tue, 13 Aug 2024 05:31:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541485; x=1723627885; bh=95K6mA5Ybu
	4amAaRvVVRKZHzdzJH9x1N6WV3yk/phGA=; b=mFoQcFZglPzPewHkFsz7O++bNn
	avf4VJioMuu1PgjgzwemItauc0Hq08MILeMdbSo13/yKYUlSrRQ1jtPO1+ThVt5x
	8d156iK1wHgBnItsgS7i8iyPLRbez0LgPUqUPgTmWuRO7tSVSN/g3wq03Hmmv5UQ
	fkmH+z5376P6CGbrjx4/fcKOTUMwjBuddsHAXzw5sL8sydr4SzCR5USaEeF8M7Fe
	vtwrxl/88nPAVJ80eB55LykSTA74qzn/9yfRnwY3j6MmRrVqdWxc9j0jZ4aV4mql
	xbVXZBBniynm7Ef6dQbWVbH/29j0zcPGf/gUrvZYoghhrI0FnG6TU75X1naw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541485; x=1723627885; bh=95K6mA5Ybu4amAaRvVVRKZHzdzJH
	9x1N6WV3yk/phGA=; b=boYNA9BDCgDvGcrFahyqhKUZepcat9mVmwW/OUBHNOi6
	wcca8XphYSFnjZ7/J/vMDKVxOQu/lFyK32TnJluwhYOGopsWK+IRq37L005O11/U
	SG17TJvcjSUrNflLw63F3kUs7XH/JfNuXLrW3h5UwmL3nZJxPhuXHL3LPHOu9Va5
	h3Pjf3UCOu/ulR7U2ithfekfwqUeLmP2N5FwS0LTJrjJgYdLCV99aCuyaM89HlZn
	SlQL+UxeKHgjx0tDNu3hPwvoe2p1ckrClmaBOYBtObPjC5brownTbpnRAw1h5vFs
	8ppNyYlwkNmRKQBuMdB0k9dx29gEYyPM0xrhStEVzw==
X-ME-Sender: <xms:7Ce7ZuckT6zxE_RJseck7UTWL43xCR3J9eARE5lE6eLjSWrZQ5-aJg>
    <xme:7Ce7ZoNcxBdvDTTCkgWdgVDn7WUjgvdOhqeJfJu7ZDiliuy54Xf33gOSmrrfL8XET
    IFYG7t8o9IwCu4EOw>
X-ME-Received: <xmr:7Ce7Zvht3WP752t8E7KqvPA5FGD02lDmQ627f5kTFonaw4D0mhUJw6hYEAorW62YSBWL8Zeg20ERv8uVwmkpEHwkzEeBUHsiEaZhllOyqwkdkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:7Ce7Zr8OmCv7NQLCruIzDFSPwp1pc90RDQ1-hloY96HDboRaseRRyg>
    <xmx:7Se7ZqulVaNj1S0Rah836pQzuGKg0CQ59xlga6ZLWhnpKMJxq5lvqA>
    <xmx:7Se7ZiHI2QLIILkvzQAT4JbUAire3Yua9tUlzi0S_vK4aTDFz3EugA>
    <xmx:7Se7ZpNtkW_N8bANfpE-hh8s0FalWlX0h4Fy2PN9zhMZtWqCfQzBvA>
    <xmx:7Se7ZuiRe2IZcAnPg1HN6txusP0_-iTbxH7PJcmsHVCGKZI0_2ARIgSp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61643a3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:07 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 06/22] read-cache: fix leaking hashfile when writing index
 fails
Message-ID: <ed0608e7059c925e50daf5dc454ced781a09a948.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

In `do_write_index()`, we use a `struct hashfile` to write the index
with a trailer hash. In case the write fails though, we never clean up
the allocated `hashfile` state and thus leak memory.

Refactor the code to have a common exit path where we can free this and
other allocated memory. While at it, refactor our use of `strbuf`s such
that we reuse the same buffer to avoid some unneeded allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache.c                       | 97 ++++++++++++++++++------------
 t/t1601-index-bogus.sh             |  2 +
 t/t2107-update-index-basic.sh      |  1 +
 t/t7008-filter-branch-null-sha1.sh |  1 +
 4 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..36821fe5b5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2840,8 +2840,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
-	int nr, nr_threads;
 	struct repository *r = istate->repo;
+	struct strbuf sb = STRBUF_INIT;
+	int nr, nr_threads, ret;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
@@ -2962,8 +2963,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	strbuf_release(&previous_name_buf);
 
 	if (err) {
-		free(ieot);
-		return err;
+		ret = err;
+		goto out;
 	}
 
 	offset = hashfile_total(f);
@@ -2985,20 +2986,20 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * index.
 	 */
 	if (ieot) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_ieot_extension(&sb, ieot);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		free(ieot);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	if (write_extensions & WRITE_SPLIT_INDEX_EXTENSION &&
 	    istate->split_index) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		if (istate->sparse_index)
 			die(_("cannot write split index for a sparse index"));
@@ -3007,59 +3008,66 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
 					       sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_CACHE_TREE_EXTENSION &&
 	    !drop_cache_tree && istate->cache_tree) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		cache_tree_write(&sb, istate->cache_tree);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_RESOLVE_UNDO_EXTENSION &&
 	    istate->resolve_undo) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		resolve_undo_write(&sb, istate->resolve_undo);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_UNTRACKED_CACHE_EXTENSION &&
 	    istate->untracked) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_untracked_extension(&sb, istate->untracked);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
 	    istate->fsmonitor_last_update) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_fsmonitor_extension(&sb, istate);
 		err = write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 	if (istate->sparse_index) {
-		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
-			return -1;
+		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	/*
@@ -3069,14 +3077,15 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * when loading the shared index.
 	 */
 	if (eoie_c) {
-		struct strbuf sb = STRBUF_INIT;
+		strbuf_reset(&sb);
 
 		write_eoie_extension(&sb, eoie_c, offset);
 		err = write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
 		hashwrite(f, sb.buf, sb.len);
-		strbuf_release(&sb);
-		if (err)
-			return -1;
+		if (err) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	csum_fsync_flag = 0;
@@ -3085,13 +3094,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+	f = NULL;
 
 	if (close_tempfile_gently(tempfile)) {
-		error(_("could not close '%s'"), get_tempfile_path(tempfile));
-		return -1;
+		ret = error(_("could not close '%s'"), get_tempfile_path(tempfile));
+		goto out;
+	}
+	if (stat(get_tempfile_path(tempfile), &st)) {
+		ret = -1;
+		goto out;
 	}
-	if (stat(get_tempfile_path(tempfile), &st))
-		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	trace_performance_since(start, "write index, changed mask = %x", istate->cache_changed);
@@ -3105,7 +3117,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	trace2_data_intmax("index", the_repository, "write/cache_nr",
 			   istate->cache_nr);
 
-	return 0;
+	ret = 0;
+
+out:
+	if (f)
+		free_hashfile(f);
+	strbuf_release(&sb);
+	free(ieot);
+	return ret;
 }
 
 void set_alternate_index_output(const char *name)
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 4171f1e141..5dcc101882 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test handling of bogus index entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..f0eab13f96 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,6 +5,7 @@ test_description='basic update-index tests
 Tests for command-line parsing and basic operation.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --nonsense fails' '
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 93fbc92b8d..0ce8fd2c89 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -2,6 +2,7 @@
 
 test_description='filter-branch removal of trees with null sha1'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
-- 
2.46.0.46.g406f326d27.dirty

