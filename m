Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756182;
	b=ES+fa7Ts9PVrCEtSLI42wC7lUJ964eaS+Mey8uuXm5+KRi+hUXnTU4T1ksNSUk/smh0e
	 +R8ksOc3Jgj57uaoTAaG9wtm4R+sSKP2l2BAHhHOKS4MXlK1QIjc4D8HHEBC0Wmuiv4Ti
	 ggsZYa04d41h/Ki2/sA6h4j33gYrNFC8nrJS1rV0zot1hRWmyzhpkfZ4c46hbcMRSCFX4
	 hDBYbw71kD+H0dxmVjSusMF8CtluZiFkM++W6gf8h4QfVO023bKLkZLo1L5OPWovW785m
	 FqshxmbZC+aWE18fes7Ly98Hf/tsBKUotTEMaFRaz/8eSStBqh3hybMf+sfOGODbulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756182;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yZN+HWIFh0qwTIG/sCvZjYumyslRmcBWodhz3NOYOpg=;
	b=mNhaaMVp1Dpp3gn1mzLZPzjTOyQIVDGbM7Ce/NUcdin0AkRss6q24i1kEfGo07NT8QOG
	 ypAZm0H+i933aVpp8FjrPN0Jo7GIQa/gKV9IthcQIKjL4oIbEG1HT1o9yuP4aspjBk4Km
	 l9l0ghcTIC0PiiP5Zn14N1vPls0k6u+1d394NPtvqmTh5uIlS0HzYeIs2MuD519Ldg6UJ
	 zOW2qU4/ONfGPGwGNJxqorKTysX0gn0nED3pAmM/od9984OpMZCDlJIbtvGzxmzhaK5Vq
	 Gk4a1bYIF/cDG9Gmmf+1P8hGkgy4fVFE4J+JNtSx2fU+mZyE1wUHZPPiKdReCQKgv8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ng8Tf9hk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jNbOeqNM;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C46606A32E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C46606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ng8Tf9hk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jNbOeqNM
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 41DCBEC01E2
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 23 Oct 2026 07:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756181;
	 x=1792842581; bh=yZN+HWIFh0qwTIG/sCvZjYumyslRmcBWodhz3NOYOpg=; b=
	ng8Tf9hkfQZymtucmJLw/KfseO3FhQ+jxxmhPeVicYUYMP96J0omvGotJ6v1iXJM
	+MKlysgNLuReCWGhi5HLXA4naBUXVK78xsO26uWlK3ppQQlXSt3dxDNECLrjnV54
	KpTRhkIkwV70jnk5/uEjEyxlkl9VPOa0w2uQUB8GjZBSyDrSaJ2oANe2XESlooAK
	Oi7H6eKJf/R+X7DqiXWliQHuAtrJ/yp7s75PmaEpUD41vk5njDN7oq11KTXlviW3
	gW0ebPPa89HezqwsUFvX38GJxa5JzioQGS1lpdTMN1Y7NJG8P19x8HbLjrLboLjQ
	ScFxJX3rnhYbzSJOaBtjug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756181; x=
	1792842581; bh=yZN+HWIFh0qwTIG/sCvZjYumyslRmcBWodhz3NOYOpg=; b=j
	NbOeqNM4nSO4VlSTusCjgwf/mXO9MjxbVQV7LTLWfcyeoP3uXPzTGKFb1f/BbtWF
	/YGHwTVY/6Qbx+DiBlUqIaIx9kX4FC7w2rdPkL4ttsrFbmoOBTYQT1Mhz314tIza
	Oc3neZz5vXtP//Z7iqVtivDxFahnALvqA2aisLJ1KSGoCdIZBMgfdSE3kiAJPQ3v
	IwTkObjKtc4CKghodNI6/ISlAhFpNFhZZFSSKlmhwKJUHe00Bw1f2rn7I+ojS5bF
	J9H0Z/Q/Q0cv7mVTUx2E/itQqDtuKjbxuJyxMnpPxMy5qOFEQfiKdWqMDqiVEhIX
	S6nRy4+o9cfuQHOW6aRNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756181; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HWkpDrvZlQgcshnm+Jj1oDc3EucjWUp4OhtT+uK5+z0xBrM
	xU58Lz8RGUAEbjzVVu5jKQ1mpvgDhyVstq9rFMFU8F+ieh6MOgoneAIui7FzMM9s
	OV2sBViQHenNTzWiqW5NGwPDMHz2vkOZLycecw+njAOjZL+1FAbIabGwZGXdVuLy
	rOo9WWMkx4tjugO/F9RowDp2nh7lQXVESqsPg+AiQeOVESOhIqNjZWIb6WAOlS0W
	eB/AeS7NNbEO4bjUvveh0bPstBAzHWZmSGyvLeRfWJXDFcHwSGL+s+pe/DsfAidF
	N+7UQL1winLf5kzRoSRPdZCOG+foi2lTx6dPVDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vzlv4IQnFTyTV9usTfjSSy2cQW0Aa8bqmKi1puti2Ns=:CTY0Y3eKVzapWW7HT/VmeeLEb0duzeZgQmJTUFsyACk=;
X-ME-Sender: <xms:1UnbanCS2gwLkmQOMEWZWaIbZlfEY7uh2V4BV_1eb7lVJh8eNVabbA>
    <xme:1UnbajiZdNDhrD9cPxqNRN7lpaj0isIcIh_aTSI_QIStv0jX8T-bFcjM52Rw7NwJL
    O6rmC9RMCa2PsbmCfBWMJv9eOPovoypeyRgOrafNL-x6hkd-xBXAw>
X-ME-Received: <xmr:1UnbagODNofIFq3FyPmmXlwEN6jWIUlnGfQl2-kbqjAQPmuo6_3oPxLnrAKU1exN-Ka6KA>
X-ME-Proxy-Cause: dmFkZTETiKl8zLrP0TLEWU1svkdLdUEuRYcvYB954Ymnp/43Dja23/M1Al52sMICPKk2YE
    /sZyvwtiljiWi9UTE+Ne8q8rTQDieBPE3rVbbRt0JGe0vebqpgRJmh37k5J0GVJqJUyEiW
    B3/zBuPgUVR4P88CIPiTXPwH7qQ3MVxRBsgZj8ejl2IdQ2nqPuK3eCnHxOe3hggiLOgq3T
    G5yyXo0l6mgvBcdD3SPUmx8CwyW6lVtjhfAh3huMeALopdWPGSaB56bfUKVFup/WJylOC0
    U9Hsnd7aFN9ufDOgyvajszj/DNteaIoB1q0HYk7Z9d6wxUop94oPwEUvBJB7KET8XoShk1
    lpmgHWBMI3vuT+rPNxOA/R4WkgCGmAPLLYhICo5apKgiOIEehGPgXURjJAIZyXKb6lWBwq
    PL+0Aaw3lmt9ZO3MoWzjHcLuZ9Z1K0+fJKA0Iz8Hb5Zr94febVL7XI3Gen0RYIMIyjh3ZD
    o5nnojuwj4ui3BdcvskSDxTCysge38ZamFBuoSQBdAmJw/usg22Y1ETwOJK2wEu7nWSrdP
    f2tfcpfw6JgVVPnevVPv5BsyoGCpyxwDwHsAGDT3M48piMqkQA8aKEl3PLlLkCvetLsfT7
    V4yAXRIwlaqJ/exjSuXrqy2OqQRi/eGM3SNsZYJ59Y024rwznsIoUTOP9sNg
X-ME-Proxy: <xmx:1Unbak7DiBTmap-1ZVpmHSvmBZVFiSSrkdktRBsGuwuVSoTIlDbjWQ>
    <xmx:1Unbau25YTeA-fC3UBH2xoZGeZDfgE24h42xuCD41ipmU89mDTuNhw>
    <xmx:1UnbalYDu-sDRRdZ8m4mh8H9mXjM0MB8eOht3eE2uHVkTZHJdowAvg>
    <xmx:1UnbamBifOZ-jTJjtscothWwlYzqqELet-o_c2ftoSno1-FdVli5gQ>
    <xmx:1Unbamw0cdPoR8uiyDuT8cEanKlYV5qPwOIyDj7AwpEmA1d4kasoB7hj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e1b8455 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:16 +0200
Subject: [PATCH v3 7/7] builtin/submodule: propagate
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
Message-Id: <20261023-b4-pks-odb-extension-v3-7-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index e9c81a7170..57a21bc8d9 100644
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
index 437dd2b277..993a4390b8 100644
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
index 64412adf9f..461b682d0d 100644
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
index 8632194138..4de5ffba04 100755
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
index 11b3752f00..8542035b6f 100644
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
index 0000000000..e4e554b073
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
2.56.0.307.g5fe7bd680c.dirty

