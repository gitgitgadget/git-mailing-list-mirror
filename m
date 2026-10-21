Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561175;
	b=u5pTFE1UyugGMSktf36fpgIA/7bhMYLDKNxLxzYwpoa5otLC0JOFOg/WucJ2J/hEn8XO
	 csptjiqPJF3yxsFe1QNbjQ2Yu8vg7bO+kpbPxXu9JFGZDPiYzHcH6FA8Uj+JLvogN3wj0
	 NgJRv1Kt/ts3/bI7I9dNOzhELL5JWJUrazoTn/jcAX6S4P1TKJP5eX2rCDeqJhf94Ym9Q
	 MIeDLdCeh9Vwsn/ipNkQdbdicsP653qOvQ6LYr+k8u7RUAvpSEzQ2JYE+LyeIDbRSUyYA
	 j7cuL0Ls653O0G0cFDQX9P6Gm8XjLehARmgnjrHs66iAZsEq2FiOo9mPsCQpRo765+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561175;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pusbqmfvduPIJiTfuM11Ew0jkjheLldEfG9zSW/qUWc=;
	b=ZlRFd8KKYsJrf5eeCVfR7C4VmqAczW4FxjtX6Q6FNkSD6ufX9q8ZbgMgVo3dBezQZMs+
	 HUvjQL63S95A919lIcIXHthGzUqA/cZPfDTNndw8mj7nAT2X/f7IQFR6xM6E5eQfbwpyp
	 7p2ugH6DlIz3wMujCCpQPZK01su5vkKxQ962DlG6tpK8d/KQBxwcTfhR5GVZhIm8SNo+B
	 ejVdnoDicTwcEI0T6f82B09jAq4FnsyUL+axSc0e3Xm/NjkUqIpSMp5eRYmjeGYnRg2Qh
	 Q0xINXPCx0QK2+Ftu49mWmrT7/TPmXwDYGyf21spFWMV3hWwTOVi62H9YOVZgFRe5sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KgEp9uCp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fRXEjRxM;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF00606A323
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF00606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KgEp9uCp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fRXEjRxM
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B2451D0007A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 01:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561173;
	 x=1792647573; bh=pusbqmfvduPIJiTfuM11Ew0jkjheLldEfG9zSW/qUWc=; b=
	KgEp9uCpgsm3YpsjW73wq+DJiOj6lC/3UuO9HPAnC4Pw/9QvrCNZdFwSGeVPKXuB
	MgQqlyxM06NzgYt49wLfov4saV3V9Ri+7vcmK4BHJLH5jL3sugjdblUBMSvxLB2u
	HnM0EbPN8tyogtcnr6k7WtDbCuasJ8OdG71MJHZzvHDB0mbvjqcNU5vpnWoSlK30
	R4TfrWgXU25PeTOVaX5HvaHQguuIKz743N3Phg4So1J5D90IXTQmeMEcr6ErUEZe
	APIxMQS24HZyP0GKMgoPDiqUI5olLNjF4Qwdc9FMRGN+sKzGM88G2Ouxnsj6CXGA
	U5CcnoRSc6DDPgQrkZtanA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561173; x=
	1792647573; bh=pusbqmfvduPIJiTfuM11Ew0jkjheLldEfG9zSW/qUWc=; b=f
	RXEjRxMljhIo51w+nrPNfTnqLyMokvo/ON0o6GAHKbfqjLDepGMumpcRdnGsgDA7
	v4U4/MvfHtDM3O1WshC5cGrcXuBTGID4MCt06wyYWCf9XmVrZjdeDCVlaDy1PfSu
	EeoMIgK2riNvmO4s4cZmqfBPAguPaInuzH2OQTi7WsnKjGHQW+YszRMQl7TwqjZL
	hQr7GOpGIle/j8bczGbG91J39t0qwdzV/ycNboujYsoeekSNtOYkca+BJhw3Vuh7
	M+AOQS/1323pIEr4rND18G2FC3PrFSjPiRnSOl3x9p98O3m34np1HoPM7BfQ3Bv0
	6zcgDDXXPvSoBFDJ6g8vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561173; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:uch7swixEa0w6Tf4C6/DgTLayiOH+8Tz89+80arMIWcGYCr
	iPKIlGFl/Du5jM1Jh4cmQg36kRzLsrX6X2zAys/dVyF/EjPKRdyTHJJ2UA85LntE
	W8VzbaB06UIGTp4vEVc9W1XEw8WuBX30ZwBRy1A9O8LKgGBy6whzZ/BCV7bhSi8G
	MscHpKFWK7s73UAk4iu5w0K7w0vpWABcojIceOblonptQ8tqkh9dlxNGiR+MiRju
	zbHUqJRXQbjrhm5C6gJsWyE1WsJLzm9UmSPemKrTShB1IM3Z9PkM12M8gytBgpBz
	X/lZiZZuwP9DIbpJi4GZwVwqpVMGgEKXhN0jZhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s7yWbUaQldY7sz33HSxog1S28EEm7VuEuWjpG5R6Id8=:za4ALkX8AoQ403DQ+kspS6HjV6y+7F/TjAddaasSEQU=;
X-ME-Sender: <xms:FVDYajn8ppg03mO7XoMbXdYnAWtYp9NY9pCqG_28vjx_cf5Mk0v8-A>
    <xme:FVDYas051NBN0-qa7paVAJ6XFGd4FKylhj2k3Pk_2PUK1tLI95T1uzgJc9oJR54yi
    XFY-7w9hkU8Cjur0FBGjZsVW7q82xzlHIOLps-Awpy_IZsJOtH075I>
X-ME-Received: <xmr:FVDYanTAj9n_uPbhJJ2m8MxwyVT8WlMNAuADmqQ-rC2AwbMKpmdFoQ>
X-ME-Proxy-Cause: dmFkZTE0M5GoZUQYJtNvenl/k2oAozh4DGHM8dAWSmISTqiJXpbiDj7koGqIym3CTMbmuq
    NVJyBD1CU/Rd8wfxuYQYr+4dheScMW8czLIAlx+8ZNoU8F7W3j2aE5qyZKcXJnMG2Ju5up
    vmzEquJv1BiFDhW9rK2x1PcYBYw9Cha7NuhOLLOhMQUMaCR0UJ07ULUyzCV4r666DQlN1t
    43VH3m1QyLdzPT2QmE9aaDTvlGnHbD1k96/cMWSArRLZ7j+6VjlqL5bFR7hrHe6IyJtgav
    euEgvB//s4yiaii23qwTA2lQmpUdR56x49Og7UGzaBB6BV3gL3ebecBIXZd1XT7S+DcRj5
    hHQTDn2XT2upRR4Bu+egf//I2BHa4qSoYF2JPQbOTYqjiiUvLucyaz1irfVgJ4sqvWXMfK
    t8K0jOYE1d1CHobv4dtWhmccqorRZCaqYattVttTi8ucNP3ze5cuYxwrkbx+QuGXSdsOta
    0QDLaQENpIrnLi9riG7y1SIrjIZyxLHCsAKmcV8cbHAOSgoA4TwqjOJT/Bv0YFM+wWSIkR
    O+GOjWHnJ4DpCQKmJDtJxYQs8WHB40vXBbUD4fQJKIaJHirj/DgVfB8dg6C1P0Kw2OpQlg
    JOws+jkjVKjBHnvaD92pyvXVMBWxkFTXH3LWhu6rFLpcmSX+tQUT/ApcWJow
X-ME-Proxy: <xmx:FVDYamty5_Phk6vDKn9uXvz7MM-Y8zzvMxxF3JxeFojsZHZqROPvQg>
    <xmx:FVDYakZXwvheepoaZarS1GyUF_DcWcsgYg59nABUcZ8MgpvV9sAGrw>
    <xmx:FVDYajv4R0uqKhg0djgCranr27YaZCw_W80xkd7BuygiYIJcro0jPg>
    <xmx:FVDYauFlopIiacoXI38nMJYKXIwMcDYWB2TNlOima1WR3lchrSpePQ>
    <xmx:FVDYasVSKVMgqRQIrkyfSOpRXprlLPdp3HqwQGYV-DMczp8h0Doi3DBv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6de2f0c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:18 +0200
Subject: [PATCH v2 5/7] builtin/init: introduce handling of object storage
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
Message-Id: <20261021-b4-pks-odb-extension-v2-5-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
 builtin/clone.c                |   2 +-
 builtin/init-db.c              |   7 +-
 setup.c                        |  89 +++++++++++++++++++++-
 setup.h                        |   1 +
 t/t0001-init.sh                | 162 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 273 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index e45bd692db..dbd9c663ee 100644
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
index b02af22ad1..9e022a7ba8 100644
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
index 34812131bb..67de5646f0 100644
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
index 6047501dfc..ba4fc16def 100644
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
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0abdbca8e9..71b748f2f2 100644
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
 
diff --git a/setup.c b/setup.c
index 98140a7641..3d74f8eeed 100644
--- a/setup.c
+++ b/setup.c
@@ -2466,7 +2466,8 @@ void initialize_repository_version(struct repository *repo,
 	 */
 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
 	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
-	    repo->ref_storage_payload)
+	    repo->ref_storage_payload ||
+	    strcmp(repo->object_storage_format, "files"))
 		target_version = GIT_REPO_VERSION_READ;
 
 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
@@ -2490,6 +2491,12 @@ void initialize_repository_version(struct repository *repo,
 		repo_config_set_gently(repo, "extensions.refstorage", NULL);
 	}
 
+	if (strcmp(repo->object_storage_format, "files"))
+		repo_config_set(repo, "extensions.objectstorage",
+				repo->object_storage_format);
+	else if (reinit)
+		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
+
 	if (reinit) {
 		struct strbuf config = STRBUF_INIT;
 		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
@@ -2726,6 +2733,7 @@ static void separate_git_dir(struct repository *repo,
 struct default_format_config {
 	int hash;
 	enum ref_storage_format ref_storage_format;
+	char *object_storage_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2757,6 +2765,20 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	if (!strcmp(key, "init.defaultobjectstorageformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		if (odb_source_type_by_uri(str, NULL) == ODB_SOURCE_UNKNOWN) {
+			warning(_("unknown object storage format '%s'"), str);
+			goto out;
+		}
+		free(cfg->object_storage_format);
+		cfg->object_storage_format = str;
+		str = NULL;
+		goto out;
+	}
+
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
 	 * "init.defaultRefStorageFormat" takes precedence over this setting.
@@ -2777,7 +2799,8 @@ static int read_default_format_config(const char *key, const char *value,
 
 static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash,
-					const char *ref_storage_format_uri)
+					const char *ref_storage_format_uri,
+					const char *object_storage_uri)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
@@ -2790,6 +2813,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	};
 	enum ref_storage_format ref_storage_format;
 	char *ref_storage_payload = NULL;
+	char *object_storage = NULL;
 	const char *env;
 
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
@@ -2877,9 +2901,58 @@ static void repository_format_configure(struct repository_format *repo_fmt,
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
+		if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_uri);
+		object_storage = xstrdup(object_storage_uri);
+	} else if ((env = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT))) {
+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT, env);
+		object_storage = xstrdup(env);
+	} else if (repo_fmt->version >= 0) {
+		object_storage = xstrdup_or_null(repo_fmt->object_storage);
+	} else if ((env = getenv("GIT_DEFAULT_OBJECT_STORAGE_FORMAT"))) {
+		if (odb_source_type_by_uri(env, NULL) == ODB_SOURCE_UNKNOWN)
+			die(_("unknown object storage format specified via %s: '%s'"),
+			    "GIT_DEFAULT_OBJECT_STORAGE_FORMAT", env);
+		object_storage = xstrdup(env);
+	} else {
+		object_storage = xstrdup_or_null(cfg.object_storage_format);
+	}
+
+	/*
+	 * The "files" format without a payload is the default and thus doesn't
+	 * need to be recorded as an extension.
+	 */
+	if (object_storage) {
+		char *payload = NULL;
+		if (odb_source_type_by_uri(object_storage, &payload) == ODB_SOURCE_FILES && !payload)
+			FREE_AND_NULL(object_storage);
+		free(payload);
+	}
+
 	/*
 	 * If we have a preexisting repository we need to verify that its
-	 * current ref storage format does not change.
+	 * current storage formats do not change.
 	 */
 	if (repo_fmt->version >= 0) {
 		if (ref_storage_format != repo_fmt->ref_storage_format)
@@ -2888,11 +2961,18 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		    strcmp(ref_storage_payload ? ref_storage_payload : "",
 			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
 			die(_("attempt to reinitialize repository with different reference storage payload"));
+		if (strcmp(object_storage ? object_storage : "",
+			   repo_fmt->object_storage ? repo_fmt->object_storage : ""))
+			die(_("attempt to reinitialize repository with different object storage format"));
 	}
 
 	free(repo_fmt->ref_storage_payload);
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
+
+	free(repo_fmt->object_storage);
+	repo_fmt->object_storage = object_storage;
+	free(cfg.object_storage_format);
 }
 
 void create_repository(struct repository *repo,
@@ -2902,6 +2982,7 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok)
 {
@@ -2940,7 +3021,7 @@ void create_repository(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
-	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format_uri, object_storage_format_uri);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
diff --git a/setup.h b/setup.h
index 9145aacc5f..4e1737ade9 100644
--- a/setup.h
+++ b/setup.h
@@ -275,6 +275,7 @@ void create_repository(struct repository *repo,
 		       const char *template_dir,
 		       int hash_algo,
 		       const char *ref_storage_format_uri,
+		       const char *object_storage_format_uri,
 		       int init_shared_repository,
 		       int *reinit_ok);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d080ab04a8..0da14e8f70 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -898,6 +898,168 @@ test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides ext
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
+	fatal: unknown object storage format ${SQ}garbage${SQ}
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
+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs' '
+	test_when_finished "rm -rf objformat" &&
+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT=files://objs git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
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
+	fatal: attempt to reinitialize repository with different object storage format
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
+	test_config_global init.defaultObjectStorageFormat files://objs &&
+	git init objformat &&
+	echo files://objs >expect &&
+	git -C objformat rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	test_commit -C objformat A &&
+	test_path_is_dir objformat/.git/objs/pack
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.307.g5fe7bd680c.dirty

