Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B732FC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiCDPFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiCDPF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6716A15B99A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so13087148wra.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tCVQy7Pb+9IIEdTsd+jypO1SgAlFt6YjxzWgUr20SHg=;
        b=Zb7cuDs/X//iK3D9ya5l8uM/XsgHhwxq+5KCgSC+TGoti3UbH21uFO55I2eXd7zGrA
         8V4vehvkm6+VOUAeAQv5W6LICdgX/oFN5/j9h23NzcG3TAahPYPaSq6Qrvm0qchQmOBi
         Qdsa5j7KRqaAk/9rqZ/i6UaALMeLNBmiSixGABzY2S3qEy34HMRFVAllvN94wXWK4WfB
         G6GLofIinqijWHMY29XhDagEIkA5E7D11Jqr2d++nIBJZfnQxerMZ7fiRLVBZaH+xeLP
         ABMq2kUtJIgidKFm1JAY9jfFUCefmhssSobRih6NByoPH2ZaKXOeDKuVJDMtVHsNE9Cm
         uxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tCVQy7Pb+9IIEdTsd+jypO1SgAlFt6YjxzWgUr20SHg=;
        b=0+ny0zN4L7Ih8m9DFrGO8rrs/w7OUorjU87fIkgVou6j9BsR3dLZqGG+aHYh9u1MRR
         ar3/wTqVF/9/LVh9hd7oiRpJ9eRSETi/FIerqPNa1hF4IRTIUuebHh83R9cvXAQPR3Gi
         2PWdH7bdCyqrZtrv3IAIb6OHDwo/oECi35jgtec9BeLhsfJ/OrZH3B2ML+9lFGaBScQG
         BwRPVc2wujhYXEzmv0c5U6ny6ZrP5P4rGUl8sgH6RbAQrCxyZaSctbrHHnKaI4Ym/Nfg
         pRcb0fQTUkkyEjE07NiwSulLM6+hRJ9eHl7kdIaHCGRKZr110C8jAo+2ZctdRhnJczDd
         Tycg==
X-Gm-Message-State: AOAM532cB3j4cmqRqqzp3IylMzZ8mMm3QLL9N1KFEqcWsj60jkcDaZGS
        c9gUIJ3Iqb7OBECTCbcXTD9ZORN/2Js=
X-Google-Smtp-Source: ABdhPJw/uvV4fmRmaOptCUKTsQeHj1lizLUVsinEmc1T+7C2iYw+FfAZg6lBk4uK4nbOc1hM8/GGuw==
X-Received: by 2002:a05:6000:1c1c:b0:1ef:e989:260 with SMTP id ba28-20020a0560001c1c00b001efe9890260mr17079774wrb.668.1646406279701;
        Fri, 04 Mar 2022 07:04:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm8621087wmq.2.2022.03.04.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:39 -0800 (PST)
Message-Id: <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:31 +0000
Subject: [PATCH v3 4/7] fetch: add --refetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Teach fetch and transports the --refetch option to force a full fetch
without negotiating common commits with the remote. Use when applying a
new partial clone filter to refetch all matching objects.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  9 +++++++++
 builtin/fetch.c                 | 15 ++++++++++++++-
 transport-helper.c              |  3 +++
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f9036831898..21a247abfa4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,6 +163,15 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
 
+ifndef::git-pull[]
+--refetch::
+	Instead of negotiating with the server to avoid transferring commits and
+	associated objects that are already present locally, this option fetches
+	all objects as a fresh clone would. Use this to reapply a partial clone
+	filter from configuration or using `--filter=` when the filter
+	definition has changed.
+endif::git-pull[]
+
 --refmap=<refspec>::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95832ba1dfd..f7bcf6fa64d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -59,7 +59,7 @@ static int prune_tags = -1; /* unspecified */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
 static int write_fetch_head = 1;
-static int verbosity, deepen_relative, set_upstream;
+static int verbosity, deepen_relative, set_upstream, refetch;
 static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
@@ -190,6 +190,9 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT_F(0, "unshallow", &unshallow,
 		      N_("convert to a complete repository"),
 		      1, PARSE_OPT_NONEG),
+	OPT_SET_INT_F(0, "refetch", &refetch,
+		      N_("re-fetch without negotiating common commits"),
+		      1, PARSE_OPT_NONEG),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	OPT_CALLBACK_F(0, "recurse-submodules-default",
@@ -1296,6 +1299,14 @@ static int check_exist_and_connected(struct ref *ref_map)
 	if (deepen)
 		return -1;
 
+	/*
+	 * Similarly, if we need to refetch, we always want to perform a full
+	 * fetch ignoring existing objects.
+	 */
+	if (refetch)
+		return -1;
+
+
 	/*
 	 * check_connected() allows objects to merely be promised, but
 	 * we need all direct targets to exist.
@@ -1492,6 +1503,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (refetch)
+		set_option(transport, TRANS_OPT_REFETCH, "yes");
 	if (filter_options.choice) {
 		const char *spec =
 			expand_list_objects_filter_spec(&filter_options);
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..b4dbbabb0c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -715,6 +715,9 @@ static int fetch_refs(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.refetch)
+		set_helper_option(transport, "refetch", "true");
+
 	if (data->transport_options.filter_options.choice) {
 		const char *spec = expand_list_objects_filter_spec(
 			&data->transport_options.filter_options);
diff --git a/transport.c b/transport.c
index 253d6671b1f..e2817b7a715 100644
--- a/transport.c
+++ b/transport.c
@@ -243,6 +243,9 @@ static int set_git_option(struct git_transport_options *opts,
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_REFETCH)) {
+		opts->refetch = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
 		opts->reject_shallow = !!value;
 		return 0;
@@ -377,6 +380,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
 	args.filter_options = data->options.filter_options;
+	args.refetch = data->options.refetch;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
diff --git a/transport.h b/transport.h
index a0bc6a1e9eb..12bc08fc339 100644
--- a/transport.h
+++ b/transport.h
@@ -16,6 +16,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned reject_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned refetch : 1;
 
 	/* see documentation of corresponding flag in fetch-pack.h */
 	unsigned from_promisor : 1;
@@ -216,6 +217,9 @@ void transport_check_allowed(const char *type);
 /* Filter objects for partial clone and fetch */
 #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
 
+/* Refetch all objects without negotiating */
+#define TRANS_OPT_REFETCH "refetch"
+
 /* Request atomic (all-or-nothing) updates when pushing */
 #define TRANS_OPT_ATOMIC "atomic"
 
-- 
gitgitgadget

