Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084390;
	b=I/NC+HXMEuhkFHBr3BzN5aAswiBD62DbVW/GmJSptWivq+OF4HH0bhwUxG5QYHrdMLdR
	 NSd4X9fCK6VuFP7QCs6O819JgdgrYq12sr1OT1kBQZnwKFJ6pCteUCtcZTNWy1ATFSYF7
	 5SXXjzgEc4zAsmcf4ugsfeyPkPGx+/kc9HJA3pVU4j57CcG6mHohdyNmTaWk2lUylfH7d
	 1qSq0kCVapE0Rw1Ul7xGxTiYOP3Zas66KJAvR7AOg/UZeqZLM7L3XZq6es4dwZzEFX63x
	 6M7FVu2AlFNiLbkyfCm2US+FqNJTwjECGcVAUIVQ1vhbTsskvurvHbTvhuIrt+9CHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084390;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=jFIINoNdCwUJxxkyOuXmPGZo12aVKNAYorLcpN/JZ8c=;
	b=K2WGTKkegFec85CMTDimgCphQs2c7AGysJyVIXSZjNGuxG22XPlFD7PtvVufwyYafccG
	 dsaLbdAURlorexYr6eEJVRW1gCaK+aWEFKISwicYXbUgKOA6mcUuTlvgQJGKYtHuquwPs
	 PcEAEcbH9RE5gSk8fjFpFL/TbPm5OcHMdg3bbxsFRzj1WiUEaXWxvWliwJL2ecRyslmxR
	 uKLjr8cWmZhEF11ksDjwEGyjRF6C+wu/c9vgI+D3B7RAaRDcfk/8ScU9MAdICPX3Go2ly
	 g54z41E12oOPHVO2yAXA2OIo8WazFyOusk4Znh/pGISejHThu17ehCLuiBxsfxlPsrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=re6T5JQw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gqRNpVJK;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494F606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B494F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=re6T5JQw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gqRNpVJK
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D7807A00E7
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 02:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084388;
	 x=1793170788; bh=jFIINoNdCwUJxxkyOuXmPGZo12aVKNAYorLcpN/JZ8c=; b=
	re6T5JQwxZCkIaXRoEw0uaZr8/jz+ZTWCdnaPL3F6mg8bDYKRi9VCccz7dMTUjq9
	iKdCsa7ZSS1dmBuZwGtGCuFrXHXA9JePSFYYTQ8mE4uENB0w3G7fj7JPsPHiBEAJ
	77oLTMB1zaSQ9nEnXoa6uScoxBLTPiJXkD902zmhKUbMRGP6j5RfNG9vC2eNwFA5
	ePj4s7qUOZTnOas+RSaEvzd3f4bgBIXiyyzTcWCqBipm9mRTtUer06MeW/0hfZxw
	JbGf3RG7phh7lHH90bkiQ8p61xmIWz9o7jmg/Hr/A28DQzkmS2LNMg0hMEycwC6O
	wTBWsS6A/7Cgvl8IDUcz4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084388; x=
	1793170788; bh=jFIINoNdCwUJxxkyOuXmPGZo12aVKNAYorLcpN/JZ8c=; b=g
	qRNpVJKHHupi8aOrKczcvMyEdTLmayi40iiDVPwq53ijzDFqTeWPnkaSgUz6XmH7
	tVCwsADjkh+JdCmpV5Qfp5hQpDxj9gP9hOh7wMGCK1NZT/WlMEZYvw3kHdEtpawk
	mBPmHrATA+TqoG//Pj5Tf0Ch1G1hoU461XPWvWdUhFn0HF2oFVzFUETYjiwo/HYH
	S+O3ObuxSBQPr+2P10XnSHsOAeiCeH0fryEXNJng6Bt2byMnN9/a5XvFFMyNyQGB
	uD4EYpOC89Eke3gDLPVwjHzlLt0Egnw0seI81g8weYO3TMvRLR2neBCBG09veSQa
	zva2QOcg0hY0e1NwZ1akQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084388; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DaE3hG0++iLQXlF0Lz2y1WyjwMs+yrI0rA3OhyxW0rG08fP
	8XadAcZiY/NJjIOFHq/GK4jkF8PkrSp+VckVFotayO/Royx79DXYXp7ed+cTKfv/
	3TwrNrRAOnK8uiEjv10dEuvp20e7iSZFV9kmTmaAtp8RnGuH9UGOEBEfvzgv3pJV
	+KBgGJzsWgcLv4zfdpHg00xggnkizEEFfrQbIawHeEw14nAcTIL8hwSAjQbhsA3w
	GYx6fwRHOMVkKWj9xJTBVeesSQXp+3fisp7TJGv4NQ21gC91NMzj9WPCjvRK4kqH
	Ngy5wg17dDVRV1Sm3thKHX6OA1KVd6Aga60NkHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ObGo9yLCTdUfGBIVRHksJG9vqHDsPIxXOqDq8Dnpx+8=:/HtE2opDGsJIXNRRg9KcWSrltgOMzshb22n2dtlKNcM=;
X-ME-Sender: <xms:5EvgauXbrUT9Pg0QcC0Ll6rDI4MANzsRmWLfoocaCM7KFXtkPctaHQ>
    <xme:5EvgaiBWhHANZlhyUalWyCn7Ya3cn8l6qX5oilFX23p1JAgkJXmPGQDh4VHpK3bN5
    j-z8_bzlsoRwCVI-2F1zfNHi_DSPnNMMTFJw5F9tdCOXvOSfGt2zzxc>
X-ME-Received: <xmr:5EvgavxztycYKy2nqszkIzNlGit-YTtytyyu_cmjwiu7PlRQdUCXyw>
X-ME-Proxy-Cause: dmFkZTErK5cOGCg/kTbvOmZTEBA3VEiwFW3EFquUTgNsxYs80WlmxXqjYKaixk/MQhh/OU
    +q5yhTMAoKpd1jqeYSgkRszu9tjbBTfWmCC/1n1dmxqt7ZNcRgNW9NpRMPyR5gustC92pE
    7JtDYw/irLUEs5yrC4J68JJFlZWsBikah9V0/T8hg7vDL2PDnrkPGRpmDkF+L7P8EN56m5
    b+HoIr8Qo4kkz6dUjare2FD60QMDAtCQrhQoQr+UYLj6X0WYHV+gRPxj+rnQXHduUiQnA+
    9ggwDyGnOwoU/xL+EOrPGhbtXYCgJF0lGbC3oDzgVGdAGi0M5pICZK3I+wlhp0cVLNNgUA
    zvpwDNGFxs2p7sWdfQ+watdaJLrevHC6hE/dX9TA4RbgesGGcCt5jrVE1zC4ahm6+QX8wt
    0CHfUGDEOOtjaXbHqnlMqpVAvojYrWdZLq6sOxWM39kC7iRXIglgRvN4wEcEXLGSQ5wSap
    w6zPBc1y6E1V1IMljHxVebzfrQpqGHyIJpmfDnZlrZTTMebqRIEF76sTMrLU7Ur3hISd8M
    aysTMIfJ5AJ8xfnt9p9rPBPvkVc6yx0hvQYxKjF8ePZe7pADT7qmymk8avFLyGFJSSoNGi
    3a4dB1eo6YYe0VY8gC09j7JnwwkmuG4z5tZN4aBC9lv8Zr0pb8+3z4/CBdQA
X-ME-Proxy: <xmx:5EvgavBNaxjuBYBaVDDbdfWBAb1jww2ftWFsoNXkJEllOqREajdbIg>
    <xmx:5EvgasZKVzGyzUnif96ibG3wMtgLD7dn_j2Ws5GgcfaxhKng2xU37A>
    <xmx:5Evgang7chx-1bGuxzCRG0WlCSSMJgpvpndaVUD8J5FaWw7cWcNTIQ>
    <xmx:5Evgau4rhA5FrMz1JB_m2cDp9JoEO7sGQb9JUw_DAie1aTh6-m_QJQ>
    <xmx:5EvgameQdB46UlSENtNLDpgyzUAUkL22nvcrA5bKK6W9ZrgPWhQgKEhV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 133a6530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:29 +0100
Subject: [PATCH v4 5/7] builtin/init: introduce handling of object storage
 format
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-pks-odb-extension-v4-5-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

While the object storage format extension can already be configured
manually via git-config(1), this isn't exactly an ergonomic way of doing
so. For the reference storage format extension, users have a host of
options available to them.

Introduce the equivalent options for the object storage format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc |   5 ++
 Documentation/git-init.adoc    |  10 ++-
 Documentation/git.adoc         |   5 ++
 builtin/clone.c                |   9 ++-
 builtin/init-db.c              |   7 +-
 refs.c                         |   3 +-
 setup.c                        |  98 ++++++++++++++++++++++--
 setup.h                        |   2 +
 t/t0001-init.sh                | 166 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 293 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index e45bd692dbc..dbd9c663ee3 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -20,6 +20,11 @@ endif::[]
 	precedence over this config.
 `init.defaultRefFormat`::
 	Deprecated alias of `init.defaultRefStorageFormat`.
+`init.defaultObjectStorageFormat`::
+	Allows overriding the default object storage format for new
+	repositories. See `--object-storage-format=` in linkgit:git-init[1].
+	Both the command line option and the `GIT_DEFAULT_OBJECT_STORAGE_FORMAT`
+	environment variable take precedence over this config.
 
 init.defaultSubmodulePathConfig::
 	A boolean that specifies if `git init` and `git clone` should
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index b02af22ad11..9e022a7ba8b 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git init [-q | --quiet] [--bare] [--template=<template-directory>]
 	 [--separate-git-dir <git-dir>] [--object-format=<format>]
-	 [--ref-storage-format=<format>]
+	 [--ref-storage-format=<format>] [--object-storage-format=<format>]
 	 [-b <branch-name> | --initial-branch=<branch-name>]
 	 [--shared[=<permissions>]] [<directory>]
 
@@ -68,6 +68,14 @@ include::ref-storage-format.adoc[]
 `--ref-format=<format>`::
 Deprecated alias of `--ref-storage-format=<format>`.
 
+`--object-storage-format=<format>`::
+Specify the given object storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a path or a connection string identifying
+the database that shall store the objects. The valid values are:
++
+include::object-storage-format.adoc[]
+
 `--template=<template-directory>`::
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 34812131bb0..67de5646f08 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -609,6 +609,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_REFERENCE_BACKEND`::
 	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
 
+`GIT_DEFAULT_OBJECT_STORAGE_FORMAT`::
+	If this variable is set, the default object storage format for new
+	repositories will be set to this value. The default is "files".
+	See `--object-storage-format` in linkgit:git-init[1].
+
 `GIT_OBJECT_STORAGE_FORMAT`::
 	Specify which object storage format to use along with its URI.
 	See `extensions.objectStorage` option in linkgit:git-config[1] for more
diff --git a/builtin/clone.c b/builtin/clone.c
index 6047501dfc7..95e641b1a49 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1214,7 +1214,7 @@ int cmd_clone(int argc,
 	 */
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  option_template, GIT_HASH_UNKNOWN, ref_storage_format_uri,
-			  do_not_override_repo_unix_permissions, NULL);
+			  NULL, do_not_override_repo_unix_permissions, NULL);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1256,7 +1256,8 @@ int cmd_clone(int argc,
 	 * This is sufficient for Git commands to discover the Git directory.
 	 */
 	initialize_repository_version(the_repository, GIT_HASH_UNKNOWN,
-				      the_repository->ref_storage_format, 1);
+				      the_repository->ref_storage_format,
+				      the_repository->object_storage_format, 1);
 
 	refs_create_refdir_stubs(the_repository, git_dir, NULL);
 
@@ -1468,7 +1469,9 @@ int cmd_clone(int argc,
 	 * ours to the same thing.
 	 */
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
+	initialize_repository_version(the_repository, hash_algo,
+				      the_repository->ref_storage_format,
+				      the_repository->object_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
 	create_reference_database(the_repository, NULL, 1);
 	startup_info->have_repository = 1;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0abdbca8e93..71b748f2f24 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -57,7 +57,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 static const char *const init_db_usage[] = {
 	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>]\n"
 	   "         [--separate-git-dir <git-dir>] [--object-format=<format>]\n"
-	   "         [--ref-storage-format=<format>]\n"
+	   "         [--ref-storage-format=<format>] [--object-storage-format=<format>]\n"
 	   "         [-b <branch-name> | --initial-branch=<branch-name>]\n"
 	   "         [--shared[=<permissions>]] [<directory>]"),
 	NULL
@@ -84,6 +84,7 @@ int cmd_init_db(int argc,
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
 	const char *ref_storage_format_uri = NULL;
+	const char *object_storage_format_uri = NULL;
 	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	int init_shared_repository = -1;
@@ -111,6 +112,8 @@ int cmd_init_db(int argc,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &object_storage_format_uri, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_END()
 	};
 	int reinit;
@@ -232,7 +235,7 @@ int cmd_init_db(int argc,
 
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  template_dir, hash_algo, ref_storage_format_uri,
-			  init_shared_repository, &reinit);
+			  object_storage_format_uri, init_shared_repository, &reinit);
 	create_reference_database(the_repository, initial_branch, quiet);
 	create_object_database(the_repository, NULL);
 
diff --git a/refs.c b/refs.c
index 951db56113d..3f7458332e4 100644
--- a/refs.c
+++ b/refs.c
@@ -3521,7 +3521,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * repository format so that clients will use the new ref store.
 	 * We also need to swap out the repository's main ref store.
 	 */
-	initialize_repository_version(repo, hash_algo_by_ptr(repo->hash_algo), format, 1);
+	initialize_repository_version(repo, hash_algo_by_ptr(repo->hash_algo), format,
+				      repo->object_storage_format, 1);
 
 	/*
 	 * Unset the old ref store and release it. `get_main_ref_store()` will
diff --git a/setup.c b/setup.c
index 5580aaa10e1..6473c62fa4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2458,6 +2458,7 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
+				   enum object_storage_format object_storage_format,
 				   int reinit)
 {
 	struct strbuf repo_version = STRBUF_INIT;
@@ -2473,7 +2474,9 @@ void initialize_repository_version(struct repository *repo,
 	 */
 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
 	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
-	    repo->ref_storage_payload)
+	    repo->ref_storage_payload ||
+	    object_storage_format != OBJECT_STORAGE_FORMAT_FILES ||
+	    repo->object_storage_payload)
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
@@ -2497,6 +2500,22 @@ void initialize_repository_version(struct repository *repo,
 		repo_config_set_gently(repo, "extensions.refstorage", NULL);
 	}
 
+	if (repo->object_storage_payload) {
+		struct strbuf uri = STRBUF_INIT;
+
+		strbuf_addf(&uri, "%s://%s",
+			    object_storage_format_to_name(object_storage_format),
+			    repo->object_storage_payload);
+		repo_config_set(repo, "extensions.objectstorage", uri.buf);
+
+		strbuf_release(&uri);
+	} else if (object_storage_format != OBJECT_STORAGE_FORMAT_FILES) {
+		repo_config_set(repo, "extensions.objectstorage",
+				object_storage_format_to_name(object_storage_format));
+	} else if (reinit) {
+		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
+	}
+
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
 		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
@@ -2623,7 +2642,8 @@ static int create_default_files(struct repository *repo,
 		adjust_shared_perm(repo, repo_get_git_dir(repo));
 	}
 
-	initialize_repository_version(repo, fmt->hash_algo, fmt->ref_storage_format, reinit);
+	initialize_repository_version(repo, fmt->hash_algo, fmt->ref_storage_format,
+				      fmt->object_storage_format, reinit);
 
 	/* Check filemode trustability */
 	repo_git_path_replace(repo, &path, "config");
@@ -2733,6 +2753,7 @@ static void separate_git_dir(struct repository *repo,
 struct default_format_config {
 	int hash;
 	enum ref_storage_format ref_storage_format;
+	enum object_storage_format object_storage_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2764,6 +2785,16 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	if (!strcmp(key, "init.defaultobjectstorageformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		cfg->object_storage_format = object_storage_format_by_name(str);
+		if (cfg->object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			warning(_("unknown object storage format '%s'"), str);
+		goto out;
+	}
+
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
 	 * "init.defaultRefStorageFormat" takes precedence over this setting.
@@ -2784,7 +2815,8 @@ static int read_default_format_config(const char *key, const char *value,
 
 static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash,
-					const char *ref_storage_format_uri)
+					const char *ref_storage_format_uri,
+					const char *object_storage_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2795,7 +2827,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
+	enum object_storage_format object_storage_format;
 	enum ref_storage_format ref_storage_format;
+	char *object_storage_payload = NULL;
 	char *ref_storage_payload = NULL;
 	const char *env;
 
@@ -2884,9 +2918,52 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
 
+	/*
+	 * Determine the object storage format, with the same precedence as
+	 * for the ref storage format:
+	 *
+	 *   1. The format specified via the command line.
+	 *
+	 *   2. The format specified via "GIT_OBJECT_STORAGE_FORMAT".
+	 *
+	 *   3. The format of a preexisting repository when reinitializing.
+	 *
+	 *   4. The default format for new repositories as configured via
+	 *      "GIT_DEFAULT_OBJECT_STORAGE_FORMAT".
+	 *
+	 *   5. The default format for new repositories as configured via
+	 *      "init.defaultObjectStorageFormat".
+	 *
+	 *   6. The "files" format.
+	 */
+	if (object_storage_uri) {
+		object_storage_format = object_storage_format_by_uri(object_storage_uri,
+								     &object_storage_payload);
+		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format specified via command line: '%s'"),
+			    object_storage_uri);
+	} else if ((env = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT))) {
+		object_storage_format = object_storage_format_by_uri(env, &object_storage_payload);
+		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT, env);
+	} else if (repo_fmt->version >= 0) {
+		object_storage_format = repo_fmt->object_storage_format;
+		object_storage_payload = xstrdup_or_null(repo_fmt->object_storage_payload);
+	} else if ((env = getenv("GIT_DEFAULT_OBJECT_STORAGE_FORMAT"))) {
+		object_storage_format = object_storage_format_by_name(env);
+		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    "GIT_DEFAULT_OBJECT_STORAGE_FORMAT", env);
+	} else if (cfg.object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN) {
+		object_storage_format = cfg.object_storage_format;
+	} else {
+		object_storage_format = OBJECT_STORAGE_FORMAT_FILES;
+	}
+
 	/*
 	 * If we have a preexisting repository we need to verify that its
-	 * current ref storage format does not change.
+	 * current storage formats do not change.
 	 */
 	if (repo_fmt->version >= 0) {
 		if (ref_storage_format != repo_fmt->ref_storage_format)
@@ -2895,11 +2972,21 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		    strcmp(ref_storage_payload ? ref_storage_payload : "",
 			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
 			die(_("attempt to reinitialize repository with different reference storage payload"));
+		if (object_storage_format != repo_fmt->object_storage_format)
+			die(_("attempt to reinitialize repository with different object storage format"));
+		if ((object_storage_payload || repo_fmt->object_storage_payload) &&
+		    strcmp(object_storage_payload ? object_storage_payload : "",
+			   repo_fmt->object_storage_payload ? repo_fmt->object_storage_payload : ""))
+			die(_("attempt to reinitialize repository with different object storage payload"));
 	}
 
 	free(repo_fmt->ref_storage_payload);
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
+
+	free(repo_fmt->object_storage_payload);
+	repo_fmt->object_storage_format = object_storage_format;
+	repo_fmt->object_storage_payload = object_storage_payload;
 }
 
 void create_repository(struct repository *repo,
@@ -2909,6 +2996,7 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok)
 {
@@ -2947,7 +3035,7 @@ void create_repository(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri, object_storage_format_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index a4afa8910ed..829b63228ed 100644
--- a/setup.h
+++ b/setup.h
@@ -277,12 +277,14 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash_algo,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok);
 
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
+				   enum object_storage_format object_storage_format,
 				   int reinit);
 
 /*
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d080ab04a82..23317e0733a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -898,6 +898,172 @@ test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides ext
 	)
 '
 
+test_expect_success 'init with --object-storage-format=files does not set extension' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files objformat &&
+	test_must_fail git -C objformat config get extensions.objectstorage &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	if test_have_prereq DEFAULT_REPO_FORMAT
+	then
+		echo 0 >expect &&
+		git -C objformat config get core.repositoryformatversion >actual &&
+		test_cmp expect actual
+	fi
+'
+
+test_expect_success 'init with --object-storage-format=files:// does not set extension' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files:// objformat &&
+	test_must_fail git -C objformat config get extensions.objectstorage &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with --object-storage-format=files://<relative-path>' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files://objs objformat &&
+	echo files://objs >expect &&
+	git -C objformat config get extensions.objectstorage >actual &&
+	test_cmp expect actual &&
+	echo 1 >expect &&
+	git -C objformat config get core.repositoryformatversion >actual &&
+	test_cmp expect actual &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual &&
+	test_path_is_dir objformat/.git/objects &&
+	test_path_is_dir objformat/.git/objs &&
+	test_commit -C objformat A &&
+	git -C objformat rev-parse --verify HEAD &&
+	test_path_is_missing objformat/.git/objects/pack &&
+	test_path_is_dir objformat/.git/objs/pack
+'
+
+test_expect_success 'init with --object-storage-format=files://<absolute-path>' '
+	test_when_finished "rm -rf objformat objdir" &&
+	git init --object-storage-format=files://"$(pwd)/objdir" objformat &&
+	echo "files://$(pwd)/objdir" >expect &&
+	git -C objformat config get extensions.objectstorage >actual &&
+	test_cmp expect actual &&
+	test_commit -C objformat A &&
+	git -C objformat rev-parse --verify HEAD &&
+	test_path_is_dir objdir/pack
+'
+
+test_expect_success 'GIT_OBJECT_DIRECTORY takes precedence over extensions.objectStorage payload' '
+	test_when_finished "rm -rf objformat objdir" &&
+	git init --object-storage-format=files://objs objformat &&
+	test_commit -C objformat A &&
+	mkdir objdir &&
+	test_must_fail env GIT_DIR="$PWD/objformat/.git" GIT_OBJECT_DIRECTORY="$PWD/objdir" \
+		git cat-file -e HEAD &&
+	GIT_DIR="$PWD/objformat/.git" GIT_OBJECT_DIRECTORY="$PWD/objdir" \
+		git hash-object -w objformat/A.t >oid &&
+	test_path_is_file objdir/$(test_oid_to_path "$(cat oid)")
+'
+
+test_expect_success 'init with --object-storage-format=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format specified via command line: ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git init --object-storage-format=garbage objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format specified via GIT_DEFAULT_OBJECT_STORAGE_FORMAT: ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_DEFAULT_OBJECT_STORAGE_FORMAT=garbage git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'init with GIT_OBJECT_STORAGE_FORMAT=garbage' '
+	test_when_finished "rm -rf objformat" &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format specified via GIT_OBJECT_STORAGE_FORMAT: ${SQ}garbage${SQ}
+	EOF
+	test_must_fail env GIT_OBJECT_STORAGE_FORMAT=garbage git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'GIT_OBJECT_STORAGE_FORMAT takes precedence over default' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://default \
+	GIT_OBJECT_STORAGE_FORMAT=files://explicit git init objformat &&
+	echo files://explicit >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--object-storage-format= takes precedence over environment' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_OBJECT_STORAGE_FORMAT=files://explicit \
+	git init --object-storage-format=files://cmdline objformat &&
+	echo files://cmdline >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-init refuses with different storage format' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files objformat &&
+	cat >expect <<-EOF &&
+	fatal: attempt to reinitialize repository with different object storage payload
+	EOF
+	test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://objs git init objformat 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 're-init with same object storage format' '
+	test_when_finished "rm -rf objformat" &&
+	git init --object-storage-format=files://objs objformat &&
+	git init --object-storage-format=files://objs objformat &&
+	git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 're-init with default object storage format drops extension' '
+	test_when_finished "rm -rf objformat" &&
+
+	git init objformat &&
+	git -C objformat config set core.repositoryformatversion 1 &&
+	git -C objformat config set extensions.objectstorage files &&
+
+	git init --object-storage-format=files objformat &&
+	echo 0 >expect &&
+	git -C objformat config get core.repositoryformatversion >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C objformat config get extensions.objectstorage
+'
+
+test_expect_success 'init warns about invalid init.defaultObjectStorageFormat' '
+	test_when_finished "rm -rf objformat" &&
+	test_config_global init.defaultObjectStorageFormat garbage &&
+	echo "warning: unknown object storage format ${SQ}garbage${SQ}" >expect &&
+	git init objformat 2>err &&
+	test_cmp expect err &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with init.defaultObjectStorageFormat' '
+	test_when_finished "rm -rf objformat" &&
+	test_config_global init.defaultObjectStorageFormat files &&
+	git init objformat &&
+	echo files >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.341.g393f52fd96.dirty

