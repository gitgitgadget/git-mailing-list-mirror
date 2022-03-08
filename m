Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F92C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbiCHOkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347568AbiCHOka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758039143
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so18525928wrb.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=GRYPGzVVqZQOa0gisGG5gxH7kONDMMiRE5GBhxQDzqnbNovysKuSOH3KNk6DXDjm/V
         YIMFBmjVefPFIelPYeIO5CWp/ZYBvrbxJCS7ZlxFJ4DsK4SmmDuuh2K2+V1YBMzdLTSe
         D9tXU2HQgNp9qT6qsDhmd1Zyb5j/oDSrXLsdJZl6Tn/7ZJDPZYXNJRwNUgIqzAKxFxQk
         kmzB5CVYjOlEPHpkpxzhtipx7jTAJNExArSgMh4nm+kPzJ39Ur1XR/nkSlXRh9apvMei
         Cx/8h/jHD78LtoSpU/3m6RIk8Nf2EpPKezKhkLS+prTkKf0n4XGW86YL4VnJag8XOVeh
         rtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=banR2/YPRedUlMEFqceTdv5AzXLOH8Pv1nIbKygHUss=;
        b=fLgZI+IpkoFk3jEeQiwcrQ3DEtSuXMlBtmw1dNStdGeZTE7um8Sl2/sgKJYFkwWFCe
         zInP6K2A5IeaJSAA9SL0wtSux6xt+SBjVPzF1g3qd4RoaOeLevMcrYlHRC2rmRlNPvI/
         PLgggo0nPvQ5dYl/4j/Y+mDmvxYkjToEfsaQNyIEZ+tRDCqKZ0T7p1hSwEtBeFFOzhcZ
         NZ7hUEi6z99xtuppwnHLBr5wKgDfCsn1sgg1C0kstBSjHDglT0uga5MVM8qxzlHcLytH
         gMg/4ijIkvNDNlOjfFM5bbvOsJjwYUkHJbDnyGYKv7B31eCrUsaPg9veMmNDBc49thD+
         nBAg==
X-Gm-Message-State: AOAM533TAvw5BVouKQjt/Uvhza5/ph5oqyEOBetn3Co6e/gPm2x2xd0W
        JSKnVo59JHYgOpM0BcXefURLWrjeIu4=
X-Google-Smtp-Source: ABdhPJyOf9SZycgKh/IjZ+1agV2Pupp8mhSMaw9EDLwDtSJt5HEWSD7KPwrHdF9256pBlNgwQflHRw==
X-Received: by 2002:adf:fbc4:0:b0:1e7:2060:d65 with SMTP id d4-20020adffbc4000000b001e720600d65mr12331133wrs.583.1646750368870;
        Tue, 08 Mar 2022 06:39:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 186-20020a1c19c3000000b0038990c0925fsm2551440wmz.14.2022.03.08.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:28 -0800 (PST)
Message-Id: <2c8e8a6c2a50aced72d70fbc610f5b4273b00947.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:16 +0000
Subject: [PATCH v3 09/12] rev-list: move --filter parsing into revision.c
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
 builtin/rev-list.c | 15 ---------------
 revision.c         | 11 +++++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3ab727817fd..640828149c5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -591,21 +591,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
-
-		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			parse_list_objects_filter(revs.filter, arg);
-			if (revs.filter->choice && !revs.blob_objects)
-				die(_("object filtering requires --objects"));
-			continue;
-		}
-		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
-			if (!revs.filter)
-				CALLOC_ARRAY(revs.filter, 1);
-			list_objects_filter_set_no_filter(revs.filter);
-			continue;
-		}
 		if (!strcmp(arg, "--filter-provided-objects")) {
 			filter_provided_objects = 1;
 			continue;
diff --git a/revision.c b/revision.c
index ad4286fbdde..1d612c1c102 100644
--- a/revision.c
+++ b/revision.c
@@ -32,6 +32,7 @@
 #include "utf8.h"
 #include "bloom.h"
 #include "json-writer.h"
+#include "list-objects-filter-options.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2669,6 +2670,14 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
+	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		parse_list_objects_filter(revs->filter, arg);
+	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+		if (!revs->filter)
+			CALLOC_ARRAY(revs->filter, 1);
+		list_objects_filter_set_no_filter(revs->filter);
 	} else {
 		return 0;
 	}
@@ -2872,6 +2881,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
 		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
+	if (revs->filter && revs->filter->choice && !revs->blob_objects)
+		die(_("object filtering requires --objects"));
 
 	/*
 	 * Limitations on the graph functionality
-- 
gitgitgadget

