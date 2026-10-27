Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084395;
	b=QsLWLqycr/D7eMzv32EFgxT4Z1BfZDx/I15BWTt30paWPRktRtijBjAAMd8tdkIcLAXQ
	 G1AX9BSv9jbyPu52AQQNOeHsGXTPHdZTU3uk9X/++EAru80W0acxF+4dL5jYHojeMIOII
	 ZwohBceLqV/68fvT61YIdFVUKLA+Qes8MfMb7zdmRRsBnfb+LzDZgnFx8hptM/5YEE8xD
	 uNynirQ2Tbv9kPnpjPgwv7cAgpn9Wp19uCUqEafrFEevfPZiEjItKn6zlnPFzXX8gwUtp
	 i9ssWvJuEvYA7AZJlhgZJGkJExowwTPb8QwM2WG3NSoqdAk84zAgoUX8AAzPGtRMqxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084395;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=O/oUHt6i2BK5FJIQc6Wid6eIjTMv502S3mJoBK7aACw=;
	b=FM2xd/LH3wy2NvJTQolaLz/1kLsUDcx/IbwUHoAVqCK8h7l9XGKB1HAyyHSDb7M5X0Wd
	 H9GNkhw9SWh64DcKU3GbeSJhVRghtToo8Vcjbd5xuJaPybfoT0DIHaiBIhCvs1yoaGdjt
	 r2zpcjJMikn2mQtbhXcwwXY7m8PEi0qj7fbpbSjTybVIjV6ojJPx8nkntAKfewLsLuDQS
	 +4eBTCWf2jkWnLlbFG8VUPdiv/h6HBEZUAHoOr355HIE3TWrB9RbSIescrc1G9q8LpUJn
	 xu7D7eA5snpjALEQv3CPfFKycbOJ9QnyMd443sJUtDFBwMOUxWhFHhRNAs4OMkK3kjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KjGHhZ19;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oGMfCCxA;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B7606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KjGHhZ19;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oGMfCCxA
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DA481D0008A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 27 Oct 2026 02:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084393;
	 x=1793170793; bh=O/oUHt6i2BK5FJIQc6Wid6eIjTMv502S3mJoBK7aACw=; b=
	KjGHhZ198mnhUefNpxFKuT54MLZ/qxvsrOeEYyVYrlJeSyxoOIcdNwf9HHn1IVhu
	PK90J8zKPxEUGGcDmrQtWPU3Cer05Xh2IKamUC5RSpGY9nH8fI8AU2YAX9xp5GRi
	7st8+n3grLvDi0krpZP/A6ccShdHn40cRAjpUftNvRvo7EKW872wCOulLQbXMiuZ
	IrNfhEoxKFQULWN4U5/MAx96wKzgwo4ZS1hFz6tbk0FtFqMGcJu9Iy4MsEPyvN7t
	YuVN8apeVREfZ2OYOW3mACnYY7aF9GCRwvL2dqSccmG8ZIofxzWE8s6OTrBfs14S
	zaDrQGST05blGmfV4o38uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084393; x=
	1793170793; bh=O/oUHt6i2BK5FJIQc6Wid6eIjTMv502S3mJoBK7aACw=; b=o
	GMfCCxAtyBUreUgbX2+dtga2AEFhD4NcAlSnt/4K8C3RsmjH1hdNjJ7oV7FySAza
	yt/ZojqWd3RqNeN1jRTZOkqi0NnqUv8ToGBfeJdmCpXqha2hB+F8j4DCcaEIwTKn
	NdFffHjB96XX3WyoYu39BqMWoJay2P4Wg/0HBiIfR+RuBtr2bkZaqOvHF3hMZX4X
	nm2GTc7/uMgE94UD8zX3F5G6YqctGe/4rpUMaPDSoEVMWwRpYaidNb0WXl08glIF
	wtVjlZ057NdQSLQIIpK5HlfsFrJzZ/H46L2xp2xh7Gx2ZvX+XF5awIPudejuUIOc
	LZHFcQP9CJq5q3Ip425Wg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084393; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:p1XxGGWS835fcIH+FRMvNlkXfVmFmsZkxx5WFrBKbMnwz1C
	++QidHxP3wRsYSjrB5I9VB+SQGOxwhwho/kFf9D8FdQBim/dTjcM+Cbf8C1BuMRg
	LvHPbOe9KSBM/Cp3dfGS9ectdnDMPbe+axUhuLsNumrwEjUZEe9v8GL1ish4b1xO
	ROOpWcC/Lnn98c0BX4uAOmxSqeM1QNBddibePaubmLKgj1SudhZdyMXxR002HD5p
	V5CtHpuOooJF+NHfzLQsIgbuy+hPfVlbhzJhfEn/uz4FBr6+Aiug6OTNInUJ1k+7
	UWUZ2bEAijvsSgmMhCcq49V/ql80UZLvlFarggQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kuF00Lii2Xb/Nn7g+N6cIFiPsdkvMwOmHcv5a8DEpH0=:JBiJPAH8Ir/Hx6VZ+yQ0y9ZKYhQqBWGOORZ79L8u4rA=;
X-ME-Sender: <xms:6Uvgaje8-a_VCfJCcX356D-im9h1J8oORAFiS19a__XEFwUfvmPe2g>
    <xme:6UvgagqF9DKc5ttwe2CAch1Sx_SFgpcun8dfzVr_4P0yEd1PwRO44CjdSFGtc48iP
    vGY2U_IkU-nNTtPZNLiC9o34fXuxs9gVwKqLA3WCG0NpoXwEd8xAcc>
X-ME-Received: <xmr:6Uvgap6pWecu0i46byvRc6ODBoP-3v0woGENgSo7Q0tp5Xl0tQjd5g>
X-ME-Proxy-Cause: dmFkZTFiJTMoZfENaBRamlYo6jUwqtatctngIl80GnvY560Z60MghnxUHqRWClEMaPNhjz
    GTSfIyE1WJQoctVHBHcB9oqzxn29/aS/wxltoM3v+Eddp3vW0tFqELsNHqwHObuah6wXaK
    Tv3W/aRFBNzMbwsyJh8klZVQRosY4pcaM90kygnealj6l6R7jKJW7rGBVCVOU7IlyofFzz
    PYAHj6mARsrC4ZeY3KSSkM1y2Ytx8T8H97lr6BJSTinbAhHkAZvYaI2wZD8NLtlhQzoz9x
    R4bAE+ZnGpJDEvL6xN5pIz6CQbk0/nuwRaGJWxk9ubc9HnjcaEiwOb9xwryuT8o9+oUBhQ
    7niS44cAL41HzSqYzHFJ3Fu0WyHhX2YtQ/Xq2+edjwL2szEvX+L+cC6WDPR1mA0mZHLxTI
    MOwDuMP+Ywh4lVxh5nwzMQbl0bvCJgY41hHQsRJYjacaxwcQm64ZNWI96D05hnfmuPAqRq
    zILI4midOa8aBs64F33vq9AAg2EB7zoDl0nDj/EO8Qk0KcmYrAeoTGhx9RuhNEK6Cdr8SX
    R5QtpKBaknSdie41tkAA9p4klVDGdlvSvQNca5Sod9ZjWR4Rbz9ITa9m3WnXH8qpGkFI4C
    9II4Q6uIvAKMQ5WbAOeEE0Bl/kdTLu/A8lSsGtQ5ctxMu54fRdo86d9zimpA
X-ME-Proxy: <xmx:6UvgauqvA1o9VDA5psOPRRLGF8Ad9MRcHdfiv9H068Ao-aN4MQjsuA>
    <xmx:6UvgajietyXTNDc5kOroaaOH3OTCAkasUVLizoKyn3Gqv1dXWit0BA>
    <xmx:6UvgagIvhn0zMVFjarpM7nKSwuixkJqJ9t9lmarMB0rurEMXhqIvPg>
    <xmx:6UvgarDZCIB2SZW3UFnv6iLO1hLwu5VFsMQ6sgHSH5omtqw0o7i_Uw>
    <xmx:6UvgavEdWARbWMfO6Mul8H8w1mD2thRpaYDWt3CxkqXwMgHuoB3vzYRD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39ac9244 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:31 +0100
Subject: [PATCH v4 7/7] builtin/submodule: propagate
 "--object-storage-format="
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
Message-Id: <20261027-b4-pks-odb-extension-v4-7-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

The ref storage format passed to git-clone(1) propagates to recursively
cloned submodules, and git-submodule(1)'s "add" and "update" subcommands
accept `--ref-storage-format=` so that newly cloned submodules can be
set up with a specific format.

Teach git-submodule(1) to also propagate the object storage format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-submodule.adoc           |  10 ++-
 builtin/clone.c                            |  19 ++++--
 builtin/submodule--helper.c                |  40 +++++++++++
 git-submodule.sh                           |  18 +++++
 t/meson.build                              |   1 +
 t/t7427-submodule-object-storage-format.sh | 104 +++++++++++++++++++++++++++++
 6 files changed, 185 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index e9c81a7170f..57a21bc8d96 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -34,7 +34,7 @@ COMMANDS
 With no arguments, shows the status of existing submodules.  Several
 subcommands are available to perform operations on the submodules.
 
-`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
+`add [-b <branch>] [-f | --force] [--name <name>] [--reference <repository>] [--ref-storage-format <format>] [--object-storage-format <format>] [--depth <depth>] [--] <repository> [<path>]`::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
@@ -75,6 +75,9 @@ URL in `.gitmodules`.
 If `--ref-storage-format <format>` or its deprecated alias `--ref-format
 <format>` is specified, the ref storage format of the newly cloned submodules
 will be set accordingly.
++
+If `--object-storage-format <format>` is specified, the object storage format
+of the newly cloned submodules will be set accordingly.
 
 `status [--cached] [--recursive] [--] [<path>...]`::
 	Show the status of the submodules. This will print the SHA-1 of the
@@ -140,7 +143,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
+`update [--init] [--remote] [-N | --no-fetch] [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase | --merge] [--reference=<repository>] [--ref-storage-format=<format>] [--object-storage-format=<format>] [--depth=<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter=<filter-spec>] [--] [<path>...]`::
 +
 --
 Update the registered submodules to match what the superproject
@@ -193,6 +196,9 @@ If `--ref-storage-format <format>` or its deprecated alias `--ref-format
 <format>` is specified, the ref storage format of the newly cloned submodules
 will be set accordingly.
 
+If `--object-storage-format <format>` is specified, the object storage format
+of the newly cloned submodules will be set accordingly.
+
 If `--filter <filter-spec>` is specified, the given partial clone filter will be
 applied to the submodule. See linkgit:git-rev-list[1] for details on filter
 specifications.
diff --git a/builtin/clone.c b/builtin/clone.c
index 437dd2b2776..993a4390b8a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -681,7 +681,8 @@ static int git_sparse_checkout_init(const char *repo)
 static int checkout(int submodule_progress,
 		    struct list_objects_filter_options *filter_options,
 		    int filter_submodules,
-		    enum ref_storage_format ref_storage_format)
+		    enum ref_storage_format ref_storage_format,
+		    enum object_storage_format object_storage_format)
 {
 	struct object_id oid;
 	char *head;
@@ -771,6 +772,10 @@ static int checkout(int submodule_progress,
 			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
+		if (object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
+			strvec_pushf(&cmd.args, "--object-storage-format=%s",
+				     object_storage_format_to_name(object_storage_format));
+
 		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
 				     expand_list_objects_filter_spec(filter_options));
@@ -936,6 +941,7 @@ int cmd_clone(int argc,
 	int submodule_progress;
 	int filter_submodules = 0;
 	int hash_algo;
+	enum object_storage_format object_storage_format = OBJECT_STORAGE_FORMAT_UNKNOWN;
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions = -1;
 	int option_reject_shallow = -1; /* unspecified */
@@ -1081,9 +1087,11 @@ int cmd_clone(int argc,
 			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
-	if (object_storage_format_uri &&
-	    object_storage_format_by_uri(object_storage_format_uri, NULL) == OBJECT_STORAGE_FORMAT_UNKNOWN)
-		die(_("unknown object storage format '%s'"), object_storage_format_uri);
+	if (object_storage_format_uri) {
+		object_storage_format = object_storage_format_by_uri(object_storage_format_uri, NULL);
+		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_format_uri);
+	}
 
 	if (option_mirror) {
 		option_bare = 1;
@@ -1701,7 +1709,8 @@ int cmd_clone(int argc,
 	err = checkout(submodule_progress,
 		       &filter_options,
 		       filter_submodules,
-		       ref_storage_format);
+		       ref_storage_format,
+		       object_storage_format);
 
 	list_objects_filter_release(&filter_options);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64412adf9f6..461b682d0d5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1739,6 +1739,7 @@ struct module_clone_data {
 	int depth;
 	struct list_objects_filter_options *filter_options;
 	enum ref_storage_format ref_storage_format;
+	enum object_storage_format object_storage_format;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1748,6 +1749,7 @@ struct module_clone_data {
 #define MODULE_CLONE_DATA_INIT { \
 	.single_branch = -1, \
 	.ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN, \
+	.object_storage_format = OBJECT_STORAGE_FORMAT_UNKNOWN, \
 }
 
 struct submodule_alternate_setup {
@@ -1948,6 +1950,9 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 			strvec_pushf(&cp.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(clone_data->ref_storage_format));
+		if (clone_data->object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
+			strvec_pushf(&cp.args, "--object-storage-format=%s",
+				     object_storage_format_to_name(clone_data->object_storage_format));
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
@@ -2044,6 +2049,7 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	const char *object_storage_format = NULL;
 	const char *ref_storage_format = NULL;
 
 	struct option module_clone_options[] = {
@@ -2065,6 +2071,8 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &clone_data.depth,
@@ -2095,6 +2103,13 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		if (clone_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+
+	if (object_storage_format) {
+		clone_data.object_storage_format = object_storage_format_by_name(object_storage_format);
+		if (clone_data.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_format);
+	}
+
 	clone_data.dissociate = !!dissociate;
 	clone_data.quiet = !!quiet;
 	clone_data.progress = !!progress;
@@ -2201,6 +2216,7 @@ struct update_data {
 	struct submodule_update_strategy update_strategy;
 	struct list_objects_filter_options *filter_options;
 	struct module_list list;
+	enum object_storage_format object_storage_format;
 	enum ref_storage_format ref_storage_format;
 	int depth;
 	int max_jobs;
@@ -2365,6 +2381,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(&child->args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
+	if (suc->update_data->object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN)
+		strvec_pushf(&child->args, "--object-storage-format=%s",
+			     object_storage_format_to_name(suc->update_data->object_storage_format));
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
 	strvec_pushl(&child->args, "--url", url, NULL);
@@ -2809,6 +2828,9 @@ static void update_data_to_args(const struct update_data *update_data,
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
+	if (update_data->object_storage_format)
+		strvec_pushf(args, "--object-storage-format=%s",
+			     object_storage_format_to_name(update_data->object_storage_format));
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
 				expand_list_objects_filter_spec(
@@ -2992,6 +3014,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	const char *object_storage_format = NULL;
 	const char *ref_storage_format = NULL;
 	int ret;
 	struct option module_update_options[] = {
@@ -3019,6 +3042,8 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -3067,6 +3092,11 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		if (opt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (object_storage_format) {
+		opt.object_storage_format = object_storage_format_by_name(object_storage_format);
+		if (opt.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_format);
+	}
 
 	opt.filter_options = &filter_options;
 	opt.prefix = prefix;
@@ -3371,6 +3401,7 @@ struct add_data {
 	const char *sm_name;
 	const char *repo;
 	const char *realrepo;
+	enum object_storage_format object_storage_format;
 	enum ref_storage_format ref_storage_format;
 	int depth;
 	unsigned int force: 1;
@@ -3477,6 +3508,7 @@ static int add_submodule(const struct add_data *add_data)
 			string_list_append(&reference, p)->util = p;
 		}
 		clone_data.ref_storage_format = add_data->ref_storage_format;
+		clone_data.object_storage_format = add_data->object_storage_format;
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = add_data->depth;
@@ -3652,6 +3684,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 {
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
+	const char *object_storage_format = NULL;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
 	const struct submodule *existing;
@@ -3669,6 +3702,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
@@ -3700,6 +3735,11 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		if (add_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (object_storage_format) {
+		add_data.object_storage_format = object_storage_format_by_name(object_storage_format);
+		if (add_data.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown object storage format '%s'"), object_storage_format);
+	}
 
 	add_data.repo = argv[0];
 	if (argc == 1)
diff --git a/git-submodule.sh b/git-submodule.sh
index 86321941380..4de5ffba049 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -103,6 +103,14 @@ cmd_add()
 		--ref-format=*|--ref-storage-format=*)
 			ref_storage_format="$1"
 			;;
+		--object-storage-format)
+			case "$2" in '') usage ;; esac
+			object_storage_format="--object-storage-format=$2"
+			shift
+			;;
+		--object-storage-format=*)
+			object_storage_format="$1"
+			;;
 		--dissociate)
 			dissociate=$1
 			;;
@@ -148,6 +156,7 @@ cmd_add()
 		${branch:+"$branch"} \
 		${reference:+"$reference"} \
 		${ref_storage_format:+"$ref_storage_format"} \
+		${object_storage_format:+"$object_storage_format"} \
 		$dissociate \
 		${name:+"$name"} \
 		${depth:+"$depth"} \
@@ -310,6 +319,14 @@ cmd_update()
 		--ref-format=*|--ref-storage-format=*)
 			ref_storage_format="$1"
 			;;
+		--object-storage-format)
+			case "$2" in '') usage ;; esac
+			object_storage_format="--object-storage-format=$2"
+			shift
+			;;
+		--object-storage-format=*)
+			object_storage_format="$1"
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
@@ -386,6 +403,7 @@ cmd_update()
 		$merge \
 		$checkout \
 		${ref_storage_format:+"$ref_storage_format"} \
+		${object_storage_format:+"$object_storage_format"} \
 		${reference:+"$reference"} \
 		$dissociate \
 		${depth:+"$depth"} \
diff --git a/t/meson.build b/t/meson.build
index 11b3752f006..8542035b6f9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -926,6 +926,7 @@ integration_tests = [
   't7424-submodule-mixed-ref-formats.sh',
   't7425-submodule-gitdir-path-extension.sh',
   't7426-submodule-get-default-remote.sh',
+  't7427-submodule-object-storage-format.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7427-submodule-object-storage-format.sh b/t/t7427-submodule-object-storage-format.sh
new file mode 100755
index 00000000000..e4e554b0732
--- /dev/null
+++ b/t/t7427-submodule-object-storage-format.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='submodules handle the object storage format'
+
+. ./test-lib.sh
+
+test_object_storage_format () {
+	echo "$2" >expect &&
+	git -C "$1" rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup' '
+	git config set --global protocol.file.allow always
+'
+
+test_expect_success 'add existing repository with different object storage format' '
+	test_when_finished "rm -rf parent" &&
+
+	git init parent &&
+	(
+		cd parent &&
+		test_commit parent &&
+		git init --object-storage-format=files://objs submodule &&
+		test_commit -C submodule submodule &&
+		git submodule add ./submodule &&
+		test_object_storage_format submodule files://objs
+	)
+'
+
+test_expect_success 'add submodules with explicit files storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	test_object_storage_format upstream files &&
+	git -C upstream submodule add --object-storage-format=files "file://$(pwd)/submodule" &&
+	test_object_storage_format upstream/submodule files
+'
+
+test_expect_success 'add submodules with garbage object storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git -C upstream submodule add --object-storage-format=garbage "file://$(pwd)/submodule" 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'add submodules with object storage payload is rejected' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}files://objs${SQ}
+	EOF
+	test_must_fail git -C upstream submodule add --object-storage-format=files://objs "file://$(pwd)/submodule" 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'recursive clone propagates object storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -am "add submodule" &&
+
+	test_object_storage_format upstream files &&
+	test_object_storage_format upstream/submodule files &&
+
+	git clone --object-storage-format=files://objs --recurse-submodules \
+		upstream downstream &&
+	test_object_storage_format downstream files://objs &&
+	test_object_storage_format downstream/submodule files &&
+	test_path_is_dir downstream/.git/objs/pack &&
+	test_path_is_dir downstream/.git/modules/submodule/objects/pack
+'
+
+test_expect_success 'clone submodules with explicit object storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -m "upstream submodule" &&
+
+	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
+	test_object_storage_format downstream files &&
+	git -C downstream submodule update --init --object-storage-format=files &&
+	test_object_storage_format downstream/submodule files &&
+	test_path_is_dir downstream/.git/modules/submodule/objects/pack
+'
+
+test_done

-- 
2.56.0.341.g393f52fd96.dirty

