Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhLVSME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbhLVSL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D25C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1956716wme.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qgI6TbDXAZM6wFatIsEGgk9qsgud0pAZlI0mLqvy4xQ=;
        b=eD+EJt151JixLqT9wxWxBA2wjAL1MwQ84bAmgx8TVKKQR5vbrmNuAAxfThvamfP1b9
         PHFcrXJ7dZ64OmocNPNVfXlib96NezlK2GRr/31/u5FMLfYTMJwMlc8ke8g6Mqze5aRW
         Cdscq0QkNRmPlymXEN7ZDVMwTvZd8REM/dBHrWoebdxBairoQc0BBN4VwllVdQa4PpdG
         L4yIy8Su8gM5J33g3YG6DP2US+8Wjdsst+oraCtkkyxJ9yKgyWCbLx+UNiMKJ/pt3GuK
         LBfZMjQXMMBwO/DYL3T7/DS3cVPy/9yuABBdw2YZSMaUhiv9YYy/iJgHriAzGmxB6iB3
         yc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qgI6TbDXAZM6wFatIsEGgk9qsgud0pAZlI0mLqvy4xQ=;
        b=jw654ItTVJy1E8LeOaftmuABvNJ7cc8W3wg3cS8vdZ5+ZrO4eZbG1ysicNnyQM9GEf
         5xymkImOW3zUunwvakGICZz67FWDcdQvWU8/6Gg+k5m9OJQxbVpjTdiXa94hSqStIdL2
         szDRtGKGMrFZWTdSIk+5io9Zw8Y4srz88Gwe7pM0OL9AW2Kd37RvZBlEXYbrX8PKjqLB
         VQGdBkXS/SubXfJBemLzC3HiIqG8LBnihCIPPj3G1CZAYNF7vXq/epfehJb/jGs3VGRv
         zWpMgklBLTZteB4SdLWjcD4dQvTFm6oIIm5eDTCt8azL8RS5baDK0drOYr2VMDpucUTE
         LdVQ==
X-Gm-Message-State: AOAM532tIFL5xkdc+1SRrtgyvPzWH4SQCgbTFEDjMkU//ST4Y2zJsgka
        c8mW7v6ytuLXkEuI2qQ+hphLrckbsVI=
X-Google-Smtp-Source: ABdhPJy9osaQ9V1JFHo2+phcfWxrWxiu4txeq2kFQ+JkVM8VdCRmCMDOkW7p0Tl1AuVnoYMDqxfTZA==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr1763938wmj.191.1640196717539;
        Wed, 22 Dec 2021 10:11:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k19sm5663422wmo.29.2021.12.22.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:11:57 -0800 (PST)
Message-Id: <eea294b688f984f9218db7c6d96a6b7c75d7873a.1640196714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
        <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:11:54 +0000
Subject: [PATCH v2 3/3] refs: centralize initialization of the base ref_store.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 6 ++++--
 refs/debug.c          | 3 ++-
 refs/files-backend.c  | 5 +----
 refs/packed-backend.c | 6 ++----
 refs/refs-internal.h  | 4 ++--
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 4c317955813..f91edb73075 100644
--- a/refs.c
+++ b/refs.c
@@ -2007,10 +2007,12 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	return refs;
 }
 
-void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be)
+void base_ref_store_init(struct ref_store *refs, struct repository *repo,
+			 const char *path, const struct ref_storage_be *be)
 {
 	refs->be = be;
+	refs->repo = repo;
+	refs->gitdir = xstrdup(path);
 }
 
 /* backend functions */
diff --git a/refs/debug.c b/refs/debug.c
index 8a6bb157ee6..2b0771ca53b 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -26,7 +26,8 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
 	be_copy->name = store->be->name;
 	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
 	res->refs = store;
-	base_ref_store_init((struct ref_store *)res, be_copy);
+	base_ref_store_init((struct ref_store *)res, store->repo, gitdir,
+			    be_copy);
 	return (struct ref_store *)res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f1b66130dfb..5c6d49a267e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -86,11 +86,8 @@ static struct ref_store *files_ref_store_create(struct repository *repo,
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
-	ref_store->repo = repo;
-	ref_store->gitdir = xstrdup(gitdir);
-	base_ref_store_init(ref_store, &refs_be_files);
+	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
 	refs->store_flags = flags;
-
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	refs->packed_ref_store =
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index caa1957252a..d91a2018f60 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -201,13 +201,11 @@ struct ref_store *packed_ref_store_create(struct repository *repo,
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
-	base_ref_store_init(ref_store, &refs_be_packed);
-	ref_store->repo = repo;
-	ref_store->gitdir = xstrdup(gitdir);
+	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
 	refs->store_flags = store_flags;
+
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
-
 	chdir_notify_reparent("packed-refs", &refs->path);
 	return ref_store;
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 46a839539e3..7ff6fba4f0d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -710,8 +710,8 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
  * Fill in the generic part of refs and add it to our collection of
  * reference stores.
  */
-void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be);
+void base_ref_store_init(struct ref_store *refs, struct repository *repo,
+			 const char *path, const struct ref_storage_be *be);
 
 /*
  * Support GIT_TRACE_REFS by optionally wrapping the given ref_store instance.
-- 
gitgitgadget
