Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561180;
	b=K037yctCB9dvvDbDNPWgOB66RyUlmU6IZxXsiDHXLw62xrW1MO8t2hJ6v2dQz1cZ04+8
	 DXd1/hjz7/TPiG+Y4cShelIqmJ2vEzLBmCVUgXYjMYrusCLuFNLVSZodMoOdzshU+t5Fj
	 VRVGvDURLgMvvRJEPRjl+5O73HScN/gFV43FMEPlyhitZCzEXjQ4Sek1Dugxi3K3KZnGX
	 pVL7yDKYpL7vLhXMlXFZAhPeFX+906s5CiBBpUuUooO723mx7hIXdzfnS0ZdtF/vBGXMC
	 TQTRQfZvhUZFrYP+FvO4H1yMxF31JAeZrCPJbJGE7yBlJLCl/CsZQFIVHN9CoiCwKdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561180;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=8dpKUO7Ow+9ugXsL595ZJIjSzgRKktdCJBFlehSnGe8=;
	b=dg4bxa3DXi+ZNnyccyDdzUks/jZFTmpjG+yHNMDO97vdV2cDYX5k6bEaB08mcGgGBcqz
	 OSEhLJaM3T9UekGy8bN1N8/B3bz/qdVsQSzVwkUwMUZ3ZO9z0NsZ1qfN2DXMhsjll4HmX
	 h+4SrBQxyAzO2JmZR6lwzV2OZC5Do2R5BbBsGDA0OlL/bjbyREMRj/j7Wqu588dgOsrVy
	 E98g7p9Qiy00Tcr96ik8rhmU2kybkezix8PF73t3q5qD0sACTow4ROLzSoJT3EnE4gdhv
	 CCX9EdDZpFVo76CqVf/kPjSnZk6UhJc40ZersWkasw61ykEBJLnVqI2wxHqr2pp2XqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mLemEn7T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PcVZWp+y;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C5606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mLemEn7T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PcVZWp+y
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83CE67A00B4
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 01:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561179;
	 x=1792647579; bh=8dpKUO7Ow+9ugXsL595ZJIjSzgRKktdCJBFlehSnGe8=; b=
	mLemEn7Tn8UiqiEmBLndhGD5o6hma0EFnk38M0tcvZJfJyCjklOschO2Kvik1oUc
	bVvgrsPy4t34i1nWVTcOYIEjpqVijmHZclBy/Vxqq/vjtKn8RhcGq5KXWWawhqCj
	YfgpZCKgOViSzdhzHLPQwrTCbNjEacMEfBzE0NPG0D+bQZj0D/1QhD6FZgtpfaH9
	JCo4wF4QGUHutMyC3VI0thyrvIPuhCPSuf8Jvxd/OsL/HfHMbheaXacFCG80boex
	USsyRXFvB6IFCJaVR9f7UaRD/jOMkdDn8hS4RgUtKvJAhS2wrrLsFrGvHcLFd1t8
	KYVMX2eAYwRbUEFH2PX63w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561179; x=
	1792647579; bh=8dpKUO7Ow+9ugXsL595ZJIjSzgRKktdCJBFlehSnGe8=; b=P
	cVZWp+yhapY5Fqpi4JLCkFL/oBRP3oZ6TOhpPqO95bs0+fZntLQlVlOLG/vJmJP4
	dJ0eTcS6QJJPC23epILLQBYdoMIWl5C8fJpIz28hKiZq0x56fg2mb+/XN2cCHBr5
	Kq1DQfTmvyETdu1tJhiBWvRxS9mw4EH542rb7BrNZCsAcVSryi7DEsr5+bZakAnn
	/vavNBjZMAP1HDJ5C1aQu2yVmz5IDTbIrMrdyfaXS59Mg4wkIMRu9dbpkfv//W1w
	qxcDVjqmDH9rIbkznCyt2w1YIVIkZSkBotrc0hINztvFPsb8fAfnup8Tzaik8Z2I
	np2nnA7Tx1ihKI4L3QMcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561179; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bE8NXYCmy5D7iOb9K+QFfxkfOhWTp2ygcfzz9CEZxFphFSz
	XyF4yQG4yLj8WE2rQF0V3LfMYxybV9ZgwCeBdSiozOay+VJiinkAfssxu2SYDHYg
	vRATtvrEGd1n339Cat818mtQB/DjHxT4ioD0LE3Y3rpkkAKuVUQCl3eaGJZ4o220
	VTzmz/8v4y5D3cFA0Qhq50sg6ZOMrUI5yqqsgqCKF38frdmbE319U02qMPOG5H9S
	ZleR7yRHuYzeI42MUfReI5rC74QW1obkmrcgbhZSAH3nhxga5bNUyImPzXGqtQH6
	/Vnh8xXoQF96NIYAJYGuOsL4APkdYSpUKrHgLCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LZkJOa/8gEqP17BNIQS9p5hYyf1FD8BiCVxyeFMY9B4=:fNwJvczEJb/T/cjSTx9KKIQ0zJshVK1MAlZtPRshDTc=;
X-ME-Sender: <xms:G1DYavLaftnj84BBH5dtkR6yCIvgH6MXedl92S8urxWe3-CurQaobA>
    <xme:G1DYapJEZB9RKeiYWHcryjHciQXwTHMjDwoQCzlcOEY5iRaVm002QtrmRkRgKydui
    4tx4010PdgOO1rZODgbB6O5ZvMqoNVRI3bFQMvoZPmawkY80ucMfxA>
X-ME-Received: <xmr:G1DYalVULXqnFjxqxtxKYqSfCvdLjpIJ77fdxzrJUmSGzeZ3S9JwnQ>
X-ME-Proxy-Cause: dmFkZTE0M5GoZUQYJtNvenl/k2oAozh4DGHM8dAWSmISTqiJXpbiDj7koGqIym3CTMbmuq
    NVJyBD1CU/Rd8wfxuYQYr+4dheScMW8czLIAlx+8ZNoU8F7W3j2aE5qyZKcXJnMG2Ju5up
    vmzEquJv1BiFDhW9rK2x1PcYBYw9Cha7NuhOLLOhMQUMaCR0UJ07ULUyzCV4r666DQlN1t
    43VH3m1QyLdzPT2QmE9aaDTvlGnHbD1k96/cMWSArRLZ7j+6VjlqL5bFR7hrHe6IyJtgav
    euEgvB//s4yiaii23qwTA2lQmpUdR56x49Og7UGzaBB6BV3gL3ebecBIXZd1XT7S+DcRkT
    bh0j1dzpY4FW7qwwiqfv4HZglWjO9Tf+kXLKLlI8CcMmC+EodGJHB3wHActLlJAGE+SGtz
    ENPjEhqWWw3o5Dcdn9xEoAJ872lnaswzD6VnWORkhThqIWH3R5UEKiZ6vdQsNcDCjdakro
    XFUsYWmGEsURZT4uWll+1NAPCmeaZ5qG2XUpDC0lvSI+Rl/hdGTCZfDqZGW9r3wlRfdnKD
    5A6vq3FUAXeho4d35ePjZoVxJqijFzBszDHeSi/+CJokGSASYfybtNKNo63jk/SWXW6woV
    Z95j933e4/5cSd7gMZIZYLzMiPmgimwETQNI47L4j/gxw59i8wd5+DR0nkAQ
X-ME-Proxy: <xmx:G1DYajiPR1uSWHbNKVyhCeaLgWbW9q_Ap8KjJsjeop0VXKmAekse9w>
    <xmx:G1DYao_Iiql6QC6tHyLw3M4cA66xPqgkBRBxeBpUFIHx_TPUtOOJ2w>
    <xmx:G1DYalDKs2P0KxHEhFWg8WwtMdODVCPU2jrEwOZux6eUePYOm0cyEA>
    <xmx:G1DYatK2pbj1SXY6lN0dTzIda6LAetNWyKFYhBHM813VghvxUhCFZg>
    <xmx:G1DYag61Vujq7lzfq27L91IrTbvkF9AYtYqFfvI3F9ckorZjRlZY-m1_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10af3ab7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:20 +0200
Subject: [PATCH v2 7/7] builtin/submodule: propagate
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
Message-Id: <20261021-b4-pks-odb-extension-v2-7-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
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
 Documentation/git-submodule.adoc           | 10 +++-
 builtin/clone.c                            | 10 +++-
 builtin/submodule--helper.c                | 28 +++++++++
 git-submodule.sh                           | 18 ++++++
 t/meson.build                              |  1 +
 t/t7427-submodule-object-storage-format.sh | 91 ++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 4 deletions(-)

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
index 85c124dc37..63348c3f34 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -686,7 +686,8 @@ static int git_sparse_checkout_init(const char *repo)
 static int checkout(int submodule_progress,
 		    struct list_objects_filter_options *filter_options,
 		    int filter_submodules,
-		    enum ref_storage_format ref_storage_format)
+		    enum ref_storage_format ref_storage_format,
+		    const char *object_storage_format_uri)
 {
 	struct object_id oid;
 	char *head;
@@ -776,6 +777,10 @@ static int checkout(int submodule_progress,
 			strvec_pushf(&cmd.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(ref_storage_format));
 
+		if (object_storage_format_uri)
+			strvec_pushf(&cmd.args, "--object-storage-format=%s",
+				     object_storage_format_uri);
+
 		if (filter_submodules && filter_options->choice)
 			strvec_pushf(&cmd.args, "--filter=%s",
 				     expand_list_objects_filter_spec(filter_options));
@@ -1703,7 +1708,8 @@ int cmd_clone(int argc,
 	err = checkout(submodule_progress,
 		       &filter_options,
 		       filter_submodules,
-		       ref_storage_format);
+		       ref_storage_format,
+		       object_storage_format_uri);
 
 	list_objects_filter_release(&filter_options);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64412adf9f..8a9c9e17b6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1739,6 +1739,7 @@ struct module_clone_data {
 	int depth;
 	struct list_objects_filter_options *filter_options;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1948,6 +1949,9 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		if (clone_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 			strvec_pushf(&cp.args, "--ref-storage-format=%s",
 				     ref_storage_format_to_name(clone_data->ref_storage_format));
+		if (clone_data->object_storage_format)
+			strvec_pushf(&cp.args, "--object-storage-format=%s",
+				     clone_data->object_storage_format);
 		if (clone_data->dissociate)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
@@ -2065,6 +2069,8 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &clone_data.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &clone_data.depth,
@@ -2095,6 +2101,9 @@ static int module_clone(int argc, const char **argv, const char *prefix,
 		if (clone_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (clone_data.object_storage_format &&
+	    odb_source_type_by_uri(clone_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), clone_data.object_storage_format);
 	clone_data.dissociate = !!dissociate;
 	clone_data.quiet = !!quiet;
 	clone_data.progress = !!progress;
@@ -2202,6 +2211,7 @@ struct update_data {
 	struct list_objects_filter_options *filter_options;
 	struct module_list list;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	int depth;
 	int max_jobs;
 	int single_branch;
@@ -2365,6 +2375,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(&child->args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(suc->update_data->ref_storage_format));
+	if (suc->update_data->object_storage_format)
+		strvec_pushf(&child->args, "--object-storage-format=%s",
+			     suc->update_data->object_storage_format);
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
 	strvec_pushl(&child->args, "--url", url, NULL);
@@ -2809,6 +2822,9 @@ static void update_data_to_args(const struct update_data *update_data,
 	if (update_data->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
 		strvec_pushf(args, "--ref-storage-format=%s",
 			     ref_storage_format_to_name(update_data->ref_storage_format));
+	if (update_data->object_storage_format)
+		strvec_pushf(args, "--object-storage-format=%s",
+			     update_data->object_storage_format);
 	if (update_data->filter_options && update_data->filter_options->choice)
 		strvec_pushf(args, "--filter=%s",
 				expand_list_objects_filter_spec(
@@ -3019,6 +3035,8 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &opt.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
 		OPT_INTEGER(0, "depth", &opt.depth,
@@ -3067,6 +3085,9 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		if (opt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (opt.object_storage_format &&
+	    odb_source_type_by_uri(opt.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), opt.object_storage_format);
 
 	opt.filter_options = &filter_options;
 	opt.prefix = prefix;
@@ -3372,6 +3393,7 @@ struct add_data {
 	const char *repo;
 	const char *realrepo;
 	enum ref_storage_format ref_storage_format;
+	const char *object_storage_format;
 	int depth;
 	unsigned int force: 1;
 	unsigned int quiet: 1;
@@ -3477,6 +3499,7 @@ static int add_submodule(const struct add_data *add_data)
 			string_list_append(&reference, p)->util = p;
 		}
 		clone_data.ref_storage_format = add_data->ref_storage_format;
+		clone_data.object_storage_format = add_data->object_storage_format;
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = add_data->depth;
@@ -3669,6 +3692,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format, N_("format"),
 			   N_("specify the reference storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
+		OPT_STRING(0, "object-storage-format", &add_data.object_storage_format, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
 		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
 			   N_("sets the submodule's name to the given string "
@@ -3700,6 +3725,9 @@ static int module_add(int argc, const char **argv, const char *prefix,
 		if (add_data.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), ref_storage_format);
 	}
+	if (add_data.object_storage_format &&
+	    odb_source_type_by_uri(add_data.object_storage_format, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), add_data.object_storage_format);
 
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
index 0000000000..a2c9a5e753
--- /dev/null
+++ b/t/t7427-submodule-object-storage-format.sh
@@ -0,0 +1,91 @@
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
+test_expect_success 'add submodules with different object storage format' '
+	test_when_finished "rm -rf submodule upstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	test_object_storage_format upstream files &&
+	git -C upstream submodule add --object-storage-format=files://objs "file://$(pwd)/submodule" &&
+	test_object_storage_format upstream/submodule files://objs &&
+	test_path_is_dir upstream/.git/modules/submodule/objs/pack
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
+	test_object_storage_format downstream/submodule files://objs &&
+	test_path_is_dir downstream/.git/objs/pack &&
+	test_path_is_dir downstream/.git/modules/submodule/objs/pack
+'
+
+test_expect_success 'clone submodules with different object storage format' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -m "upstream submodule" &&
+
+	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
+	git -C downstream submodule update --init --object-storage-format=files://objs &&
+	test_object_storage_format downstream files &&
+	test_object_storage_format downstream/submodule files://objs
+'
+
+test_done

-- 
2.56.0.307.g5fe7bd680c.dirty

