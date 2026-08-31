Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A23F39EE
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170559; cv=none; b=OdBb/Giw3eU3gkOT2IfKaj8xrTbk1OJNQ47/fP+2n34urMcmHOIKH3NIBW95yOS6yuXGb/lzPADRVAQXSQODl6U+Y66ZqgHwGkWeI3t8QIyQofoosLn9tE3py0fDk2hjiMGc58et6svFtTiTAga75i2Gux7KlHVVsHHzKzTpXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170559; c=relaxed/simple;
	bh=2ODqu3DNBuW5Id+D5jzjIf1eidBfVRAdq3D1f+eWYfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fy59COl1OE+HW3qk/CBMdQaGQ7SF4wQN33cK/JgB7/Ncqrj0zUjVZZHGJivQI6Bl8ADtEVTpKM4BAkxJJcykCi9E5SzIRkXMURrsRCTsomTdjYDQB9gECs+yT4zAop69TBiKUcaFsMfAyL1ke0ZA+sDBY81LK+8r73J6sOslmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=miWagVRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7XLE70A; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="miWagVRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7XLE70A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A53E7A019E;
	Mon, 31 Aug 2026 06:02:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 06:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170556;
	 x=1788256956; bh=ueTqkBzGbtPB9QaBmM0DMIH3na/WTHVRywlXUD1wmEU=; b=
	miWagVRvcJJeuodJprvLMboIjS6N82g5ECGZ3d819GbmC8cNLfyyf1nstXQjNYKl
	SHBI/lRFpB0Ijyi8ClyCGnrm2N3lP5ZvWCscOdfAxyP1bygzOe+IXVvoVDYHckTY
	z05Sfl7rdstmWfhGXSkhDbaUOHGnWGMsNhmeskdgsNjTnXWS6FH3oFiOq4VPgDO2
	EyOFTbc8091vzMcnY1VznAhK4m+ZN/aCTFEe/AAueR28BloXauKeFCWZBhe/TZYm
	8kR8DmkUR4zjSyqmlP+WnNPYx0soVc6FgurEWmOJ6QxHDqGCA9Yd7IUXwTuCpPyU
	RBtpBZEsF7g3vAjcJmTvOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170556; x=
	1788256956; bh=ueTqkBzGbtPB9QaBmM0DMIH3na/WTHVRywlXUD1wmEU=; b=G
	7XLE70AOGGAquVcM5d/3iI+R+rO/vpHzXvEZEurx0PPTfOd8nvnnTqLGGQToBbTM
	Cl2a5+AR8D4DXTj1MqV3XBt2kV57IQT5LljP1yZxXm8vrnO53QFPPLsCrXqSJcUs
	/+G4RoCQ+JVBlahDPqY+VQjNxSdUXm0NTLy8S6IMeKY34CCIhDMtbeVx5uzl1PXz
	dhf2ASzWmKnYBRALIMxNwYcAef8nwLQ7UeMkqyQGi0cxX2Y30klh4Orfe9y9malb
	gD3DQkGH8fUq76G9NYWzW18PMzJcOvtVrIkk7bv7R7vy0Y1RCnv3hnO2fEFbqWnZ
	470PCwUeE3W2PyQrMEZqA==
X-ME-Sender: <xms:PFGVampZBHkpSdXd62Ge1JKctazEqkEKe4unVkEf7pSOvemjUjb-iQ>
    <xme:PFGVasFFuXrNVoCFoimhi-F5T6-AuuquAsY6jLL_B8RS84dCfTQXS4ntbRJDksXWW
    tiKvxzZXxWSqXEojLn2ZgM_M39muvr45580FVVZHhd-Mxp0SOYOXJA>
X-ME-Received: <xmr:PFGVaokh-JWThElhK7A8ejg86KZ2iqcYf-hlD8uCp8u2-Z0vrdy7HsykugK0RrlrTwm_9g>
X-ME-Proxy-Cause: dmFkZTGGxg236fYUl2LXu9KGuRkpI99VCkA10xDA3cjgajUWB7gjuHswCFvAvHrp5IHIiE
    r8XNdnze0919wydLORvXBhborCdV/wNjvmWRU/iJ5oKv7EymA8m3uzSf0elaAujw2CBzpn
    JhieyXMheic53qNdvbcQ0fyYhkEqhs9LINV2inWsvEpB0H21QK1tGzz+rHU+eLJyNQXzlW
    XzA242nZbZXcLxMg5gRyzPpHk0vghSiTjSKlx6Ou+GYykkTqRKqoT1zCmaS+FCBsUaqPyy
    9A3m2UnbslCMXah9f5Xbbfr8nXj1NOwQLatfL8EJJmK2q3LSFtb8NjHepS0r4BDVPwnXM4
    PeMLtYF+1jEg4yRRIy0AuVTnkWC4IJMNYn89ZncBOurUjRNMm/MCrGsXJ3uwD7J0R0QQxS
    aA2+Sm+sOEdyLMOXYlAL5AQ33zDwMUl/3jfry265qH43XOJ/QT3Z1i1kYH7XqBZSrjDwzY
    E9CgfbQZ1ELANzxB9HEFtgf3p00b6sXwwfjAJIiynOj4YEIL3AykO4CHVwupHh2dkneVz9
    LhXkLT6DuZQC2ioBUTx/sRFllOUglJ07SICghbn1or1w6mtB7LaVt8nyGc5imvsk2CrW7A
    lH7u99hAdRfVprXmkRwWU8S1jlwADdi1Gjh2D9916A+RZKYmV766G/LLhj3Q
X-ME-Proxy: <xmx:PFGVavng3WkZeLsI6ipYcgVU93qqAawkm8X8nZfWBE7GkcpAS0fckQ>
    <xmx:PFGVapv7hSmWDUlS_IZ4P_T4OvdXyGmYnjPTQCuWLXBeAtqsv_lTKA>
    <xmx:PFGVainkjnXFWA2InmrC1Z-YJE9CWt7nFxfbHpgjqlOzuTv0P5m5bw>
    <xmx:PFGVaksFc8D6bh45uSWiHthaYZrZQf-SXh5TZC_T8Bz9dMVSS1HIig>
    <xmx:PFGVaktcYagqCATFrwlsF8PmEUyB-jPBCwkluBa2cwTgT2YdfhfM-sqk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5905796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:12 +0200
Subject: [PATCH v2 8/8] odb/source: remove the ability to write alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-8-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

There are no users of `odb_source_write_alternates()` in our tree
anymore. Remove that function and its supporting infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 |  9 ---------
 odb.h                 |  7 -------
 odb/source-files.c    | 54 ---------------------------------------------------
 odb/source-inmemory.c |  7 -------
 odb/source-loose.c    |  7 -------
 odb/source-packed.c   |  7 -------
 odb/source.h          | 26 -------------------------
 7 files changed, 117 deletions(-)

diff --git a/odb.c b/odb.c
index 67d98d64fc..b531cf8fb3 100644
--- a/odb.c
+++ b/odb.c
@@ -239,15 +239,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-void odb_add_to_alternates_file(struct object_database *odb,
-				const char *dir)
-{
-	int ret = odb_source_write_alternate(odb->sources, dir);
-	if (ret < 0)
-		die(NULL);
-	odb_add_alternate_recursively(odb, dir, 0);
-}
-
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 						const char *dir)
 {
diff --git a/odb.h b/odb.h
index b9e0db56ec..2d002461f8 100644
--- a/odb.h
+++ b/odb.h
@@ -270,13 +270,6 @@ int odb_mkstemp(struct object_database *odb,
  */
 int odb_has_alternates(struct object_database *odb);
 
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-void odb_add_to_alternates_file(struct object_database *odb,
-				const char *dir);
-
 /*
  * Add the directory to the in-memory list of alternate sources (along with any
  * recursive alternates it points to), but do not modify the on-disk alternates
diff --git a/odb/source-files.c b/odb/source-files.c
index 8fe65d91f8..b3f340dff8 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -306,59 +306,6 @@ static int odb_source_files_read_alternates(struct odb_source *source,
 	return 0;
 }
 
-static int odb_source_files_write_alternate(struct odb_source *source,
-					    const char *alternate)
-{
-	struct lock_file lock = LOCK_INIT;
-	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
-	FILE *in, *out;
-	int found = 0;
-	int ret;
-
-	repo_hold_lock_file_for_update(source->odb->repo, &lock, path,
-				       LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(&lock, "w");
-	if (!out) {
-		ret = error_errno(_("unable to fdopen alternates lockfile"));
-		goto out;
-	}
-
-	in = fopen(path, "r");
-	if (in) {
-		struct strbuf line = STRBUF_INIT;
-
-		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(alternate, line.buf)) {
-				found = 1;
-				break;
-			}
-			fprintf_or_die(out, "%s\n", line.buf);
-		}
-
-		strbuf_release(&line);
-		fclose(in);
-	} else if (errno != ENOENT) {
-		ret = error_errno(_("unable to read alternates file"));
-		goto out;
-	}
-
-	if (found) {
-		rollback_lock_file(&lock);
-	} else {
-		fprintf_or_die(out, "%s\n", alternate);
-		if (commit_lock_file(&lock)) {
-			ret = error_errno(_("unable to move new alternates file into place"));
-			goto out;
-		}
-	}
-
-	ret = 0;
-
-out:
-	free(path);
-	return ret;
-}
-
 static int too_many_loose_objects(struct odb_source_files *files, int limit)
 {
 	unsigned long loose_count;
@@ -842,7 +789,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_object_stream = odb_source_files_write_object_stream;
 	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
-	files->base.write_alternate = odb_source_files_write_alternate;
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 795672adf2..b00248dfb2 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -326,12 +326,6 @@ static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
-					       const char *alternate UNUSED)
-{
-	return error("in-memory source does not support alternates");
-}
-
 static void odb_source_inmemory_close(struct odb_source *source UNUSED)
 {
 }
@@ -388,7 +382,6 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
 	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
 	source->base.read_alternates = odb_source_inmemory_read_alternates;
-	source->base.write_alternate = odb_source_inmemory_write_alternate;
 
 	return source;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index bb3455dfbd..0f9b30bac1 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -982,12 +982,6 @@ static int odb_source_loose_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_loose_write_alternate(struct odb_source *source UNUSED,
-					    const char *alternate UNUSED)
-{
-	return error("loose source does not support alternates");
-}
-
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -1053,7 +1047,6 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 	loose->base.begin_transaction = odb_source_loose_begin_transaction;
 	loose->base.read_alternates = odb_source_loose_read_alternates;
-	loose->base.write_alternate = odb_source_loose_write_alternate;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 630d955585..c2d253759c 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -628,12 +628,6 @@ static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
 	return 0;
 }
 
-static int odb_source_packed_write_alternate(struct odb_source *source UNUSED,
-					     const char *alternate UNUSED)
-{
-	return error("packed backend cannot write alternates");
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -849,7 +843,6 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_object_stream = odb_source_packed_write_object_stream;
 	packed->base.begin_transaction = odb_source_packed_begin_transaction;
 	packed->base.read_alternates = odb_source_packed_read_alternates;
-	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source.h b/odb/source.h
index 63f1c0c531..693a9fc604 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -286,19 +286,6 @@ struct odb_source {
 	int (*read_alternates)(struct odb_source *source,
 			       struct strvec *out);
 
-	/*
-	 * This callback is expected to persist the singular alternate passed
-	 * to it into its list of alternates. Any pre-existing alternates are
-	 * expected to remain active. Subsequent calls to `read_alternates` are
-	 * thus expected to yield the pre-existing list of alternates plus the
-	 * newly added alternate appended to its end.
-	 *
-	 * The callback is expected to return 0 on success, a negative error
-	 * code otherwise.
-	 */
-	int (*write_alternate)(struct odb_source *source,
-			       const char *alternate);
-
 	/*
 	 * This callback is expected to optimize the object database source.
 	 * Returns 0 on success, a negative error code otherwise.
@@ -518,19 +505,6 @@ static inline int odb_source_read_alternates(struct odb_source *source,
 	return source->read_alternates(source, out);
 }
 
-/*
- * Write and persist a new alternate object database source for the given
- * source. Any preexisting alternates are expected to stay valid, and the new
- * alternate shall be appended to the end of the list.
- *
- * Returns 0 on success, a negative error code otherwise.
- */
-static inline int odb_source_write_alternate(struct odb_source *source,
-					      const char *alternate)
-{
-	return source->write_alternate(source, alternate);
-}
-
 /*
  * Create a new transaction that can be used to write objects into a temporary
  * staging area. The objects will only be persisted when the transaction is

-- 
2.55.0.979.g7e5102b832.dirty

