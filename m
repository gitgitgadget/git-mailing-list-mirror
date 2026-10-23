Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759695;
	b=zSBzyy7FUjtg4SaFroJ5iAEvqTxOtMM3JHIhezYltdD5gLD8zcc1ZJ1CV+Sv/S+y9I/y
	 nQpETUQnJqX81c66PLBITjFVVPkzgk07+DLYr6Ngboe5zpfD7syd3DSYYe3Iy9plyx7J4
	 nHxxEhYJ3mS0XMVsljUPphkPopQveFlSKGIsmLdqEvp9gsHPz4JSXJAs6Xgmwk3LZQWfe
	 KaCTzymHYw7R3rRB9iaVLfjyMdoJHSY/PFst06s8iv8f7aHBqykhTIHymGidgFDzUWCti
	 OHTua8T2i6rIW0VsGadLo6afiZkJ1hLs0U+SbLDhx2vCtNT30OOpKc58nI8IQdtBdRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=NS3kauo0zU6F23aUSEiSytqtsGkKA8y8T/brG/yUY54=;
	b=Y3xu+b2W7imRv7PVwOx8p0E4tg3wZPKuoai8cK/WjIM8us1eX9VVLMS0fWdOkGGd72/T
	 ts1bQ3dwANEbC7ioBNPeUVc3FAQ8EwD86u7YwtrMFtdz98U4yFTI8cs0w16d0Girj2j4Y
	 LhDq4N1lptyVEJpOFAx2/SxEYhJsAZGkQ0CxqRY/B+nr9T4UPYC60AwR6uS5vEMmiltv5
	 0Dvn/JnAY0JyrObDqLSxxGgAGEhfRD4RB73UbmlWWZual8EmRcBoq6H2ujFDmI2p8nAKN
	 2RnQOWq9dNK5TxWMjY801JIO5bCisLrITih8RUswgyYQnTsAHQ8u2D4G763LSlBdbhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VN7GFz57;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RSx6+qWE;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA41606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA41606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VN7GFz57;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RSx6+qWE
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ED831D0007A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 08:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759693;
	 x=1792846093; bh=NS3kauo0zU6F23aUSEiSytqtsGkKA8y8T/brG/yUY54=; b=
	VN7GFz57JuBQOmcZRpIGqlNQFPcdHof25B5S7E30xjicRA7BK7PG6FBl1bBndcaL
	gPrlixXt73YtoZVPQG/sirajWEINxg3cLYjTOhHLlLXj8VRVJAnxNPJlbnKJNN0O
	Q3Exhr0Te123SKj6e6/9LRbodfYbJgNB9O6JdxUk2S93JRQlnbZqREZCw9q20YY4
	572ZZqqxyxDI7DOm78DM3EXrer+jij1xIfQcaEdHxLQnEMBgKY9LWlsNmrPT7uqV
	c0nGLGi7COvH/l68gctYSt/Zsr1oHLzUhP9NJ6BAJdIfNA+phS5CIKupCEPWeiRC
	/N27fecQHuVSMqOLWjeCOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759693; x=
	1792846093; bh=NS3kauo0zU6F23aUSEiSytqtsGkKA8y8T/brG/yUY54=; b=R
	Sx6+qWEZwVhM/sqtoGHcW5SRZJv+dsL+QMGEKmyC77BYU48Y6wD+mVNSLQv3UVv7
	RC6gEQ5DEqHeCWSa3ugRQ04RgRn4BlTEUeO0K8xxX1E2pjBvRlfkpQ+N+Hrb/xC0
	p4KfhY0KXKgV680lZWJlsmxULPQ3+5fnSOwCkNoq3LxoOm4zg1vVKDtSdYss8jPL
	gz7aOQ4RrvXCGsMJXGSLF/gjmpQ/YS0DJH50p1IquGPpp3V5b/m5tmEyGDOTB6SG
	lsFJYqOQkYvCQbzz5LcfCLOSIVwwBZCzF6rnB7Mk8VBnAoL6NTfD3RaotpMg5bIX
	R/IXFMbj6BfjUPNf7v6Jw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759693; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gDMLDK+bOzM8e0njQYee1GizMLBvhJp6Ukf1RWZgxaP81vk
	dhOIlpHwiHp3M+RcaiYr8bJj1paZYg+/tfQ/oKMTvM4yp2kEgNVe/QFF4usbCoQQ
	y5lLezLnQkxQmU1B8iqnODBG4TQtD1xneu+VkN5FEXIWT79lXYIek2Q4maLZ4OXa
	sD0A1siePTzZ8yy0yvi5dAblcDXdtjsOGQs8Gu+FxcvYn3prHyz3Um687UkAD4xR
	J8fC20Zv8MUqF9MULbf9x2d23kvjkGfz2f+PcnLxWz8/gLIXkwK/2jxrNBeU/oqE
	lEqUazBEKNk4TdKXmtE05NC+FnN8MEDtrwOBs6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wl0P8BPTsQomtDkfOpmw34uKFfDgxL1b55+MUNNFoSc=:7M+nbv2xjx3/pSjpYsrfo+xgMimp29z39YLuG9sZ2Pk=;
X-ME-Sender: <xms:jVfbau7IvaE8fenMdWgruj_qk7G1Z6kPDX8q6ZIKdTAVZ_MyNyHA-g>
    <xme:jVfbat4AUNjWUTXZVxrQerrkmRew5xpWq-QNsim9lFqFf_vm7pvWvv4YkyrDpxeSG
    72TtRJOQVoUqOGpHFDnvUh5bQ0qYzEhptgz4Uixe5Aeh7GP0LPcHTc>
X-ME-Received: <xmr:jVfbarHIyH8dxRDWAIWX8_owMEi9FA0WFGMtXICbpQD6LTCtKnuKb-G9bgrmXqdZ7PDRGA>
X-ME-Proxy-Cause: dmFkZTEsP9rvaXc5w03Q155sMS/D9z92m5ujAkaN8fdTfhwcWbS2VdD7BG/f8OPc7VrDbE
    p1WSOh2TWLugQvPv/IkonZKSkl4RAoEIWiOVb3g7W7rII9IwjDtNLOpCmVSTz47JZC8mif
    peOk9pX6Eg6d3f5CHBr8nxtOgboRLAxMkM1rFdTISk6EFK3G13LbChqI32gbleTXhH5xfD
    eMKV0fl34BRUMv2fI4BuDWzq1octdv8yEX5gsRiCxZWOS3Iz3+Tzhv++k7zUIhD2WI8MvV
    L7+NyP0tNaip4ntFxK92zjuyrZuNYtHkcUmHd7cPDjj6tVlmgVN/6ylKwskqaDCoJsJtMs
    KknhWwIgckSPVrO590fyfIrQQX/EhNPII88Ig6UZ58JdyoARhwg+AM/kziTuDqijYJyPOL
    EPg/Ac6uPf/QA8F6rO6/WuXEq7cbj5NPD/r0G8OXxOT5k26rrdvO7fNLaZOPkjuYkWd4oU
    wMaCHtklwzefD7dbqGAJKi2hnMH+4p3SW8My9fIp/Vra/ks0rLlQgRenJLYDWJz94/DZQk
    K0FuPd07e6nsgW5KQHP+xv7c30ptGDekXXZP8S6PBRV+cX3atnJNeOqYcNU2svjG6qSEW3
    QD1N9W9Ox85iRGc7FRxxkGHQQHma6pQ24gLt0MwR6vkStlqPRMVylesArkfg
X-ME-Proxy: <xmx:jVfbamTC0nUIlLv88HSWgMKYG8ywOh9oTFjR0aweX-2CCQz_rA1sZQ>
    <xmx:jVfbaksaWVtCO6orF5_3Xze26qHksszfbjlVaEfzDycSZkP5UaaBPg>
    <xmx:jVfbalx_S9ekVUDTSsWRIqAAdQ7umE_zw8zpnazlXcM1a2zDKxcj2A>
    <xmx:jVfbau6U9osluzgFfzIgvkWqrZ07em7mkMLcGoli-yDe-IapPHvkjg>
    <xmx:jVfbasoiM0TETVFkwd99EEFztISfDRYxVw5lD1jBWnMV3E1AAM5Ij-xa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d223f600 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:02 +0200
Subject: [PATCH v2 3/6] odb/source-files: reload alternates on retry
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-3-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

When an object ID cannot be found we retry reading it from our packfiles
after we have flushed the respective caches of the packed backends. But
this misses one scenario: it may happen that the object databases'
alternates get rewritten concurrently and all of its objects are moved
to such an alternate. If so, we won't be able to find any of the objects
anymore. This used to be working just fine, but with 5946a564cd
(odb/source: make `read_object_info()` function pluggable, 2026-03-05)
we have accidentally dropped this logic.

This scenario sounds somewhat unlikely, but we've actually been hitting
it in the wild: when running long-lived git-cat-file(1) processes that
we interactively query over many minutes, and that repository gets
forked concurrently, then we move all objects into an object pool, write
a new alternates file, and the git-cat-file(1) process will remain
broken for the rest of its lifetime.

Fix this bug by re-preparing alternates when the object in question
could not be found and then retrying the read. A couple things to note:

  - This requires us to re-read loose objects, which is an operation
    that we previously skipped on the retry. But we only need to do this
    for the loose object directories that are actually new.

  - The result is still incomplete, as we only reload the alternates of
    the primary object directory. But alternates are added recursively,
    so in theory we'd also have to check whether alternates of any of
    the alternates have changed. But we never did that before the
    regression, either, so for now we don't care about this edge case.

  - It may happen that we reload when a quarantine directory is active.
    If no alternates existed before that reload we may not have lazily
    populated the map of object directories yet. So the assertion in
    `odb_files_dir_is_usable()` does not necessarily hold anymore, and
    we now have to populate the map with all object directories.

Furthermore, this change causes a performance regression when asking for
lots of missing objects. But that regression is basically in line with
the performance we had before this mechanism got broken. The following
benchmark demonstrates this when asking for 20k missing commits in an
empty repository with a single empty alternate:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    289.9 ms  ±     3.4 ms     285.8 ms  …   307.5 ms
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    184.8 ms  ±     2.5 ms     181.5 ms  …   191.9 ms           -36.2%  (1.6x faster)
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB           -0.1%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    189.1 ms  ±     2.7 ms     185.9 ms  …   196.1 ms           -34.8%  (1.5x faster)
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.9%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    293.2 ms  ±     2.6 ms     289.3 ms  …   303.2 ms            +1.1%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.4%

There's no helping this though, with the regression fixed we will be
slower compared to before as we have to do more work. But the next
commits will improve the status quo a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  | 21 +++++++++++++--------
 t/t1006-cat-file.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index c0375e7cb7..d66949b7de 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -243,10 +243,11 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	 * thing twice, or object directory itself.
 	 */
 	if (!hashmap_get_size(&files->dirs_by_path)) {
-		assert(!files->dirs->next);
-		hashmap_entry_init(&files->dirs->by_path_entry,
-				   strihash(files->dirs->abspath));
-		hashmap_add(&files->dirs_by_path, &files->dirs->by_path_entry);
+		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+			hashmap_entry_init(&dir->by_path_entry,
+					   strihash(dir->abspath));
+			hashmap_add(&files->dirs_by_path, &dir->by_path_entry);
+		}
 	}
 
 	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
@@ -425,6 +426,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 							      struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_files_dir **tail = NULL;
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
 	enum odb_read_status ret;
 	bool retry = false;
@@ -448,10 +450,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 			status = ret;
 	}
 
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		if (retry)
-			break;
-
+	/*
+	 * When we have reprepared alternates then we only re-scan directories
+	 * that were newly added.
+	 */
+	for (struct odb_files_dir *dir = tail ? *tail : files->dirs; dir; dir = dir->next) {
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
@@ -461,6 +464,8 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	}
 
 	if (!retry && !(flags & OBJECT_INFO_QUICK)) {
+		tail = files->dirs_tail;
+		prepare_alternates(files, NULL);
 		retry = true;
 		goto retry;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 72fc8acc61..f2b24dd278 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1481,4 +1481,36 @@ test_objects_filter "object:type=commit"
 test_objects_filter "object:type=tag"
 test_objects_filter "object:type=tree"
 
+test_expect_success PIPE 'concurrently written alternates are loaded' '
+	test_when_finished "rm -rf repo alternate stdin stdout" &&
+	git init repo &&
+	git init alternate &&
+	oid=$(git -C alternate hash-object -w --stdin </dev/null) &&
+	mkfifo stdin &&
+	mkfifo stdout &&
+	{ git -C repo cat-file --batch-check <stdin >stdout & } &&
+	(
+		exec 8>stdin &&
+		exec 9<stdout &&
+
+		# Read the object the first time, without having alternates
+		# wired up yet. The object should be reported as missing.
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid missing" >expect &&
+		test_cmp expect actual &&
+
+		# Read the object the second time, this time with the alternate
+		# set up. The backend should reload alternates and thus find
+		# the object.
+		echo "$PWD/alternate/.git/objects" >repo/.git/objects/info/alternates &&
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid blob 0" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done

-- 
2.56.0.307.g5fe7bd680c.dirty

