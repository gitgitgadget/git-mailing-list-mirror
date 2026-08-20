Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCE2D839C
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269788; cv=none; b=UPcQhbPLMznCVRvBfaZo0u0NdEVPqy7C4qldFTUV0G6PSoi0ebVjQ4c0R6iA3CPBXy48z0kfKCDLjJRD5bRr7JzB8biycInllYXIX/BDb0n4neXv/vMiL3egN8M2m9ss8oYW/B684icgyA+ANUIP9/ShMRCN8b6k5bnNdc+zBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269788; c=relaxed/simple;
	bh=rgVi4OepjsSkHvDn4gvDkx0TU6AXrQJYVajRznIat8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWwab+ii1vxhI4cT6e1Do0wcHffkq0y4U+qUlE1U+M50FrDPz+/Sa88SEqaCiXk0GFZGm2R3/knyYpbvssQ1XXgUV9KRDgpzvyWsxPbGKAv5s+tiTbPVlG1PAs6N9BC9nQZ3SijhIHpWoYItemumBtvdQL2J7i7byeX8No9iVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pX+dxitA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX+dxitA"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43b7e186a0cso187333fac.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269786; x=1787874586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=124CMtkUNTN3Mga1tddMzDhaOn/1nSQ3tMelzP9nT9A=;
        b=pX+dxitAx+qnJaHF1Bkemnfc3t7kysYOIpu3Zz5UUpYpun8462vtSL7/uQQ0Od8dIW
         OEKXAtEAcxP2AImGt0WQdQlBIgMoIRzsoHqhoymG80NCFgLoT25INao7v8EFTsy3vb67
         BYiHibbIaUVBPaYjk8/DJH+mwmQjs7xXRPLdujIfY0oZDzLrUpegz3SVmsKW1gWau/We
         mY1YfR/0BGrsgM0Bjb1+sc1X7eNHIQvhZ69yAFM0ljSnEdXLRvVRtedwGObm5trkDWME
         VRP/sKHmD+FCUTBWSIemHm7w9wmI8U7mf1BzbeBA5vrBAdhcmuyPr2CLbsGlsIEP42rK
         ahWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269786; x=1787874586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=124CMtkUNTN3Mga1tddMzDhaOn/1nSQ3tMelzP9nT9A=;
        b=MB60/3wUUw7nztonMoUIWA/2sOXngzdMa6/rgNM8yQ+wEV0l/zNP9ZMbsgE+X3qyWm
         R/aNHpV7Xp604ADRj8TmXeq03XTBBYxrsfGSEMMBP/Mw9g8y+YPW7i077G2WxSoKludk
         lVU+HVzeOBRAU62D5moH+ePQe+rOrzlN+wftX/N1qVUPcUt2g7QfXeXbPF/rCgnjyk3Q
         HhBfvd2Ir9Rdbdv9TnBRqIhsS548XIVC7kMgnvMOQlD+1pSFohJ2knWqRfcKFadH3rDg
         XFCsKuGxMMtxAIuxzju6dsk8rhhufTPQskpAbi+xGqMQRZ3rUIyvK/rZ9fMAqTWZ+QpZ
         iAAQ==
X-Gm-Message-State: AOJu0Yx+UZCfT5VNqEp/hOQd2vC+XEzjTtQOL4Yup7pv7wm0X8oWK84h
	wETzkdwTxNGG60kH+QLpAAYJNjq9MZTPj4hqln+Khk84mQRpClsT5B2fsgVtCA==
X-Gm-Gg: AR+sD13/dYkS1sC6IoSuviYS0GYaMndzMmulCTiUeLZw0TxgnYlz3H3uz5w/cPQX+Gx
	E+90Sw7Ep/VZXwKLP5xg4r/SuSPH2HdmQTAmIU0JHJmxYyYxlCp137O0dBk5SZdM2lXiUqByPRx
	uiR2l1BH03IClLfmdBXO7eU3axjdJdh3inAShijSx7b96CtJaAj0d9al6WnRnHcmFXlhbvcHjKs
	mId5tTNMmwyw/BygpEaki2iRBpdxjXkakdt+IX+9fB+Q0O+ROYu2bdPNkbBjqUlmhe/qpkJRMm9
	SpZ8YdAWtfCUtHx3UWGRWxo06PvY3NKrCBVDSNCgwPwDbrAUWKFw9p3aMovG2mDnO5tIfxbkmSV
	H5g1LB1Fc75bSBo42s0kRow6PtsZpCJZ/K+62VrqnEtrwiv7Kg94dlIgbup7uM2NtsSr+iQb95/
	E+d3922Uv1xvcO1LnwBcVS2xviywPFksqk/rEpiyfOVjDWs/tSb3pi62aBp04QI9FDdIjL
X-Received: by 2002:a4a:ee12:0:b0:6ae:3815:ff7d with SMTP id 006d021491bc7-6b1592b781bmr2494106eaf.14.1787269786324;
        Thu, 20 Aug 2026 16:49:46 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 1/9] builtin/receive-pack: properly clean up keep files
Date: Thu, 20 Aug 2026 18:49:32 -0500
Message-ID: <20260820234940.894624-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-receive-pack(1) stores an incoming packfile with
git-index-pack(1), a ".keep" file is written alongside it in the
transaction quarantine directory and also gets migrated to the main ODB
when the ODB transaction is committed. This keep lockfile ensures the
packfile remains in place until the references have been updated and is
removed afterwards. The path used to remove it is derived via
`index_pack_lockfile()` from the repository's primary object directory.

In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces instead of managing a temporary directory
directly. When starting an ODB transaction, the sources list is
reordered to insert the newly created transaction source first as the
primary to ensure writes are routed to it accordingly.

Prior to using ODB transactions, git-receive-pack(1) would only set the
temporary directory as the primary source for the child
git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
parent process would set the temporary directory set as an alternate
only. By using ODB transactions, the ODB source list is also reordered
for the parent process which results in `index_pack_lockfile()` deriving
the ".keep" path relative to the temporary directory instead of the
actual main ODB source path. Consequently, this prevents the ".keep"
file from being properly removed after being migrated into the main ODB
source post-commit.

Update `index_pack_lockfile()` to operate on an ODB source explicitly
provided to it and update call sites accordingly to pass the expected
ODB source.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c     |  8 +++++++-
 fetch-pack.c               |  2 +-
 pack-write.c               |  7 ++++---
 pack.h                     |  4 +++-
 t/t5547-push-quarantine.sh | 31 +++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..d74b787148 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 922a9b2581..6df5813b33 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1075,7 +1075,7 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(the_repository,
+		char *pack_lockfile = index_pack_lockfile(the_repository->objects->sources,
 							  cmd.out,
 							  &is_well_formed);
 
diff --git a/pack-write.c b/pack-write.c
index 24033a9101..85674e4b72 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,10 +469,11 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = r->hash_algo->hexsz + 6;
+	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -489,7 +490,7 @@ char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(r), name);
+				       source->path, name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 1cde92082b..ada506b5c5 100644
--- a/pack.h
+++ b/pack.h
@@ -7,6 +7,7 @@
 struct packed_git;
 struct pack_window;
 struct repository;
+struct odb_source;
 
 /*
  * Packed object header
@@ -105,7 +106,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
+char *index_pack_lockfile(struct odb_source *source, int fd,
+			  int *is_well_formed);
 
 struct ref;
 
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 0798ddab02..1b7097179e 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -70,4 +70,35 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
 	git -C update.git fsck
 '
 
+test_expect_success '.keep file is removed after push' '
+	test_when_finished rm -rf keep.git &&
+	git init --bare keep.git &&
+
+	git -C keep.git config set receive.unpackLimit 0 &&
+
+	# While incoming objects are still quarantined, validate that the
+	# ".keep" lockfile is present in the quarantine directory.
+	test_hook -C keep.git pre-receive <<-\EOF &&
+	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
+	test -f "$keep"
+	EOF
+
+	# After quarantined objects are migrated, validate that the ".keep"
+	# lockfile is migrated and present in the main ODB.
+	test_hook -C keep.git reference-transaction <<-\EOF &&
+	keep="$(ls objects/pack/pack-*.keep)" &&
+	test -f "$keep"
+	EOF
+
+	test_commit foo &&
+	git push keep.git HEAD &&
+
+	# Once the operation is complete, validate that the ".keep" lockfile has
+	# been removed.
+	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
+	keep="${pack%.pack}.keep" &&
+	test_path_is_file "$pack" &&
+	test_path_is_missing "$keep"
+'
+
 test_done
-- 
2.55.0.424.g13c7afec21

