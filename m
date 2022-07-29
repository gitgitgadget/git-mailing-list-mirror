Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D5C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiG2T3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiG2T3r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464A5F11C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m13so3183448wrq.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oa8F6UISOftTCgWXDlHBf7u9PgQ9MG6BPAoOJ3khpvw=;
        b=PCQzi4McDKcrS0MIdpLkencxUsj1ILOwW70hxqWQxFbw6xwU0bp69FkMGp+3hI6uJc
         +BxF5Lh2ubrksy3RbupiSb7CR9xhm+8yeHpBn8BZeBGnr1eKngXkTSlGLTkkHyFU05IO
         954gwpPJTFF0DCD0xhUbjfqkzEVPfpRo5vLb8aVV/AZAcMzV8KrLoN4cc5gDIKflpOSJ
         WRawO+rUaPgCrcsBvbVyiA2F53/W5GGT7l5DB+MOZlNA2dAZc6DebGdhQBHq+qvu8Brg
         dojfnKMQiP66uZUH2U3DwW6hjqf06WMaQ9vPOfrGJAbNqg3bbAIYkbypdGnn4HIfEqpZ
         Nzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oa8F6UISOftTCgWXDlHBf7u9PgQ9MG6BPAoOJ3khpvw=;
        b=s97IHnPorj3j5pcuvFhD9Vte4wC6kZNUlfYy8Z1wih1hcstNXmPJVDduXrYxQg1vYr
         qxXZCEWMGNxomJSDllksklY5tU02hndivRp1ZhDU/X6PbsPjrvaMuh6nC0bfkPNmZbuI
         dpJAdPE8QrAjXMH24UUu1xDjlc6Gd9W7w5ymzJcpv3uPm1GqmiwacLvinS+xP58IrDy6
         /oqAoejVA7j0X5DfQ8fIYntQkwIVNC48PR7rS/TKJ2I1Linwg/daivlPuz9N8BB2VU5Q
         WTc7pzalC96UeEkbCTELa71Lyu+lXghEzU0YaGVIhF0uEXfJcNo2vHft/CaYvkdHs+jq
         FvMw==
X-Gm-Message-State: ACgBeo3CLvX3DRbaSQcGGkVkNc0TIDjXEkLph/uGMmhTKug6axrO2bMW
        I9WN/7TIzya8F/e0NNVTLUbmDx8JddQ=
X-Google-Smtp-Source: AA6agR60za6uZfYboRFSchEV+QofxRIFqKb2jk9IXWdpkrMZMu/7obKI32iwyX0e2dkCsXwVETKEng==
X-Received: by 2002:a05:6000:692:b0:21f:d91:f154 with SMTP id bo18-20020a056000069200b0021f0d91f154mr3146585wrb.668.1659122984120;
        Fri, 29 Jul 2022 12:29:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q186-20020a1c43c3000000b003a302fb9df7sm9753513wma.21.2022.07.29.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:43 -0700 (PDT)
Message-Id: <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:32 +0000
Subject: [PATCH v2 03/10] refs: add array of ref namespaces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Git interprets different meanings to different refs based on their
names. Some meanings are cosmetic, like how refs in  'refs/remotes/*'
are colored differently from refs in 'refs/heads/*'. Others are more
critical, such as how replace refs are interpreted.

Before making behavior changes based on ref namespaces, collect all
known ref namespaces into a array of ref_namespace_info structs. This
array is indexed by the new ref_namespace enum for quick access.

As of this change, this array is purely documentation. Future changes
will add dependencies on this array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 environment.c |  2 ++
 notes.c       |  1 +
 refs.c        | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h        | 46 ++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/environment.c b/environment.c
index b3296ce7d15..9eb22f975c7 100644
--- a/environment.c
+++ b/environment.c
@@ -185,6 +185,8 @@ void setup_git_env(const char *git_dir)
 	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
+
 	free(git_namespace);
 	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/notes.c b/notes.c
index 7452e71cc8d..7bade6d8f69 100644
--- a/notes.c
+++ b/notes.c
@@ -1005,6 +1005,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 
 	if (!notes_ref)
 		notes_ref = default_notes_ref();
+	update_ref_namespace(NAMESPACE_NOTES, xstrdup(notes_ref));
 
 	if (!combine_notes)
 		combine_notes = combine_notes_concatenate;
diff --git a/refs.c b/refs.c
index ec3134e4842..8e87cc7efb0 100644
--- a/refs.c
+++ b/refs.c
@@ -20,6 +20,7 @@
 #include "repository.h"
 #include "sigchain.h"
 #include "date.h"
+#include "commit.h"
 
 /*
  * List of all available backends
@@ -56,6 +57,88 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+struct ref_namespace_info ref_namespaces[] = {
+	[NAMESPACE_HEAD] = {
+		.ref = "HEAD",
+		.decoration = DECORATION_REF_HEAD,
+		.exact = 1,
+	},
+	[NAMESPACE_BRANCHES] = {
+		.ref = "refs/heads/",
+		.decoration = DECORATION_REF_LOCAL,
+	},
+	[NAMESPACE_TAGS] = {
+		.ref = "refs/tags/",
+		.decoration = DECORATION_REF_TAG,
+	},
+	[NAMESPACE_REMOTE_REFS] = {
+		/*
+		 * The default refspec for new remotes copies refs from
+		 * refs/heads/ on the remote into refs/remotes/<remote>/.
+		 * As such, "refs/remotes/" has special handling.
+		 */
+		.ref = "refs/remotes/",
+		.decoration = DECORATION_REF_REMOTE,
+	},
+	[NAMESPACE_STASH] = {
+		/*
+		 * The single ref "refs/stash" stores the latest stash.
+		 * Older stashes can be found in the reflog.
+		 */
+		.ref = "refs/stash",
+		.exact = 1,
+		.decoration = DECORATION_REF_STASH,
+	},
+	[NAMESPACE_REPLACE] = {
+		/*
+		 * This namespace allows Git to act as if one object ID
+		 * points to the content of another. Unlike the other
+		 * ref namespaces, this one can be changed by the
+		 * GIT_REPLACE_REF_BASE environment variable. This
+		 * .namespace value will be overwritten in setup_git_env().
+		 */
+		.ref = "refs/replace/",
+		.decoration = DECORATION_GRAFTED,
+	},
+	[NAMESPACE_NOTES] = {
+		/*
+		 * The refs/notes/commit ref points to the tip of a
+		 * parallel commit history that adds metadata to commits
+		 * in the normal history. This branch can be overwritten
+		 * by the core.notesRef config variable or the
+		 * GIT_NOTES_REFS environment variable.
+		 */
+		.ref = "refs/notes/commit",
+		.exact = 1,
+	},
+	[NAMESPACE_PREFETCH] = {
+		/*
+		 * Prefetch refs are written by the background 'fetch'
+		 * maintenance task. It allows faster foreground fetches
+		 * by advertising these previously-downloaded tips without
+		 * updating refs/remotes/ without user intervention.
+		 */
+		.ref = "refs/prefetch/",
+	},
+	[NAMESPACE_REWRITTEN] = {
+		/*
+		 * Rewritten refs are used by the 'label' command in the
+		 * sequencer. These are particularly useful during an
+		 * interactive rebase that uses the 'merge' command.
+		 */
+		.ref = "refs/rewritten/",
+	},
+};
+
+void update_ref_namespace(enum ref_namespace namespace, char *ref)
+{
+	struct ref_namespace_info *info = &ref_namespaces[namespace];
+	if (info->ref_updated)
+		free(info->ref);
+	info->ref = ref;
+	info->ref_updated = 1;
+}
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
diff --git a/refs.h b/refs.h
index 47cb9edbaa8..94e8dedf939 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,7 @@
 #define REFS_H
 
 #include "cache.h"
+#include "commit.h"
 
 struct object_id;
 struct ref_store;
@@ -930,4 +931,49 @@ struct ref_store *get_main_ref_store(struct repository *r);
 struct ref_store *get_submodule_ref_store(const char *submodule);
 struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
+/*
+ * Some of the names specified by refs have special meaning to Git.
+ * Organize these namespaces in a comon 'ref_namespaces' array for
+ * reference from multiple places in the codebase.
+ */
+
+struct ref_namespace_info {
+	char *ref;
+	enum decoration_type decoration;
+
+	/*
+	 * If 'exact' is true, then we must match the 'ref' exactly.
+	 * Otherwise, use a prefix match.
+	 *
+	 * 'orig_ref' is for internal use. It represents whether the
+	 * 'ref' value was replaced from its original literal version.
+	 */
+	unsigned exact:1,
+		 ref_updated:1;
+};
+
+enum ref_namespace {
+	NAMESPACE_HEAD,
+	NAMESPACE_BRANCHES,
+	NAMESPACE_TAGS,
+	NAMESPACE_REMOTE_REFS,
+	NAMESPACE_STASH,
+	NAMESPACE_REPLACE,
+	NAMESPACE_NOTES,
+	NAMESPACE_PREFETCH,
+	NAMESPACE_REWRITTEN,
+
+	/* Must be last */
+	NAMESPACE__COUNT
+};
+
+/* See refs.c for the contents of this array. */
+extern struct ref_namespace_info ref_namespaces[];
+
+/*
+ * Some ref namespaces can be modified by config values or environment
+ * variables. Modify a namespace as specified by its ref_namespace key.
+ */
+void update_ref_namespace(enum ref_namespace namespace, char *ref);
+
 #endif /* REFS_H */
-- 
gitgitgadget

