Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBEC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiCIQDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiCIQC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7217585A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so3741510wra.12
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=11Uo0gVQ9fME59Fqhjf9u776SRTbt2UmEbraPBNP+XE=;
        b=oJZITbxbSASCqjoeRKPqk3LkDGf/nJeM+v9fKogJr6ee2NROZzp+M5QhM5r4lcU0B0
         z9xguPAMRm1xZhVde4LliQ+LOypFWNdjOBU9uiRAPaWnNctPb4lCTBKlaQG/nRSwTpGd
         dt84WZloFolLSZsGceFHil3KZpGszCPgOokJ5zGt+dPgARh2kpiOez6EHr4WgsRBIsvc
         3/Y/JL2gG+R/VJYFV+WxDGOUVYXnzR9ilH00+eEBNfFg2PLsUppFDIReOn6xVCJe8EoU
         KvMsjPThwy4wQ5fV66s/zksyWLs8EikyiBY1DkK4jr4eL0aXajhjuwrva2Qk14nJqoef
         auVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=11Uo0gVQ9fME59Fqhjf9u776SRTbt2UmEbraPBNP+XE=;
        b=6MbdBlI9olJ+L0cqclHXCgPrLY8pmY6UAWvZY/D+sbMh+QXinkmam5p3WSqEbdpWjq
         Qb7P5CIp3dIxxG5L7y2sCkqpzTku+GsNw6c0eaoldYd/gMz/cIc5MS5DZeJEsBfUCiMd
         0x5NDEjJqU0iYX06LGmXCautF6JgitTSZW7+DzccmxGiKmR/bwdeD/DE1MdxNB5zfh8w
         ecxfpo1S2xUPtxsEYqTm8XuU3iyiiw7YCnC0dHlII56fqJZjOc21x5nUUg4OrEGP/7XG
         zGHT4n+OGXcoby7ejOxNnKz3jdzTNxReUvCh19c15JIznh5MPYuo1pD/H4Ktlv9XOSGj
         3jYQ==
X-Gm-Message-State: AOAM531BMaC4s6dlS9Hf7A1olcrunBAq04gI9iSKQb5Jy1pImV/Vi/WQ
        olHbP+kD6qoExPMJW+X81QwVVj62k2g=
X-Google-Smtp-Source: ABdhPJzrGqJA8c3QXE9r0ib+UhvM0OyJNSr/FzMuSMIyAbTkhUfJnl2YDvmzGdarSgnrcsWPsm1bjw==
X-Received: by 2002:adf:9d93:0:b0:1f0:639f:3bc2 with SMTP id p19-20020adf9d93000000b001f0639f3bc2mr218897wre.203.1646841716820;
        Wed, 09 Mar 2022 08:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b001f1d72a6f97sm1943993wru.50.2022.03.09.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:56 -0800 (PST)
Message-Id: <05d7322fdfcd6abb1f3a160405121e4c7974ebc4.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:40 +0000
Subject: [PATCH v4 10/13] rev-list: move --filter parsing into revision.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that 'struct rev_info' has a 'filter' member and most consumers of
object filtering are using that member instead of an external struct,
move the parsing of the '--filter' option out of builtin/rev-list.c and
into revision.c.

This use within handle_revision_pseudo_opt() allows us to find the
option within setup_revisions() if the arguments are passed directly. In
the case of a command such as 'git blame', the arguments are first
scanned and checked with parse_revision_opt(), which complains about the
option, so 'git blame --filter=blob:none <file>' does not become valid
with this change.

Some commands, such as 'git diff' gain this option without having it
make an effect. And 'git diff --objects' was already possible, but does
not actually make sense in that builtin.

The key addition that is coming is 'git bundle create --filter=<X>' so
we can create bundles containing promisor packs. More work is required
to make them fully functional, but that will follow.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/rev-list.c | 11 -----------
 revision.c         |  7 +++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ec433cb6d37..640828149c5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -591,17 +591,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
-
-		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&revs.filter, arg);
-			if (revs.filter.choice && !revs.blob_objects)
-				die(_("object filtering requires --objects"));
-			continue;
-		}
-		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			list_objects_filter_set_no_filter(&revs.filter);
-			continue;
-		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
 			filter_provided_objects = 1;
 			continue;
diff --git a/revision.c b/revision.c
index ad4286fbdde..15efe23c40f 100644
--- a/revision.c
+++ b/revision.c
@@ -32,6 +32,7 @@
 #include "utf8.h"
 #include "bloom.h"
 #include "json-writer.h"
+#include "list-objects-filter-options.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2669,6 +2670,10 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
+	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+		parse_list_objects_filter(&revs->filter, arg);
+	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+		list_objects_filter_set_no_filter(&revs->filter);
 	} else {
 		return 0;
 	}
@@ -2872,6 +2877,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
 		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
+	if (revs->filter.choice && !revs->blob_objects)
+		die(_("object filtering requires --objects"));
 
 	/*
 	 * Limitations on the graph functionality
-- 
gitgitgadget

