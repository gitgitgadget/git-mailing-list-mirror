Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBFC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798A761B66
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhKPD1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhKPDZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:25:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A15C034035
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n29so33843331wra.11
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nIwWOzyteUPgtg6V/gbptI+dO14mDOtHt15Ldl+xrEE=;
        b=ABfTrJFrd7ePzBAXSZwidfuUXa2cy8LaIS+qYTevawsq1pYRgi7TFnPZqz/NWdbecU
         IxD3RJJwFewpQr/RwWB8dkvSF0ywZR1jxfTuI4MDGyWyRxfeLlUlxGyaFna0ucK8so/O
         q3Zt/BVC91a91CW8uBFKcdFJXcl2gVOpY/3y2KHXRSXZXKL3jL3Pv3zZXcn75MQOXtDx
         cJGhYI335v5+useMkp9DcOQSWwds4YtSyuJd94loZyi6nxFKJqmUnNP09yMLr/JYOAhu
         9uCrc/iXhApatjeaFdymY72VmdBOae8ur4ws7lgln0MW9j89zxIbP6e59Zp/glpVv/KU
         hPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nIwWOzyteUPgtg6V/gbptI+dO14mDOtHt15Ldl+xrEE=;
        b=ArmN911r6LPbLPLlmHeci9xIq9iH2lw+QP1nDte7bAT2k8vF8WU01Xts2JTVs+faCU
         IzyC+5NNmlC4Blrdfb8yibSoSOYpQ5nt79eDSSqoEv1ntNcTj6Q0KqpFWXhDqaQfABWD
         edK4+uJun3/jawgrQhtvKHrCkpN9f5oVyjKkKI3I99pHDKwUmwBkwDsk3U2y/a07dDjd
         aH3l2gO96g2ofBhAZPr1skl1xnObbSIK7fjJqhhscywK7vKUda7XMos7KJqfhMdlizbo
         gGFeTnyIdWVExbWY984YIJgCEwog5oY3fEqzfz++E2hzcYEfvV6R7QyZzyaZVrYRRyNI
         hhqA==
X-Gm-Message-State: AOAM531JEN3f3G794XyTeoP+ZuQ84Nf5cWKN18BME+IO3533edC7ZReI
        xKkWyFywrmiqooJYQsZD+63KRGRsfYg=
X-Google-Smtp-Source: ABdhPJyfZC7QjLjtvV2vRz+3v5hPZx6UUGOUYidj+sGr/nyEZcxGxir5sIIbgTy/1UvDmh1iYLxlpQ==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr3558582wrq.311.1637020266404;
        Mon, 15 Nov 2021 15:51:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm16677717wru.21.2021.11.15.15.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:05 -0800 (PST)
Message-Id: <71817cccfb9573929723a34fe9fb0db72498d4b9.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:50:56 +0000
Subject: [PATCH v9 2/9] tmp-objdir: disable ref updates when replacing the
 primary odb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When creating a subprocess with a temporary ODB, we set the
GIT_QUARANTINE_ENVIRONMENT env var to tell child Git processes not
to update refs, since the tmp-objdir may go away.

Introduce a similar mechanism for in-process temporary ODBs when
we call tmp_objdir_replace_primary_odb. Now both mechanisms set
the disable_ref_updates flag on the odb, which is queried by
the ref_transaction_prepare function.

Note: This change adds an assumption that the state of
the_repository is relevant for any ref transaction that might
be initiated. Unwinding this assumption should be straightforward
by saving the relevant repository to query in the transaction or
the ref_store.

Peff's test case was invoking ref updates via the cachetextconv
setting. That particular code silently does nothing when a ref
update is forbidden. See the call to notes_cache_put in
fill_textconv where errors are ignored.

Reported-by: Jeff King <peff@peff.net>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c  | 4 ++++
 object-file.c  | 6 ++++++
 object-store.h | 9 ++++++++-
 refs.c         | 2 +-
 repository.c   | 2 ++
 repository.h   | 1 +
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 342400fcaad..2701dfeeec8 100644
--- a/environment.c
+++ b/environment.c
@@ -169,6 +169,10 @@ void setup_git_env(const char *git_dir)
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		args.disable_ref_updates = 1;
+	}
+
 	repo_set_gitdir(the_repository, git_dir, &args);
 	strvec_clear(&to_free);
 
diff --git a/object-file.c b/object-file.c
index 0b6a61aeaff..659ef7623ff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -699,6 +699,12 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	 */
 	new_odb = xcalloc(1, sizeof(*new_odb));
 	new_odb->path = xstrdup(dir);
+
+	/*
+	 * Disable ref updates while a temporary odb is active, since
+	 * the objects in the database may roll back.
+	 */
+	new_odb->disable_ref_updates = 1;
 	new_odb->will_destroy = will_destroy;
 	new_odb->next = the_repository->objects->odb;
 	the_repository->objects->odb = new_odb;
diff --git a/object-store.h b/object-store.h
index cb173e69392..9ae9262c340 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,10 +27,17 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This is a temporary object store created by the tmp_objdir
+	 * facility. Disable ref updates since the objects in the store
+	 * might be discarded on rollback.
+	 */
+	unsigned int disable_ref_updates : 1;
+
 	/*
 	 * This object store is ephemeral, so there is no need to fsync.
 	 */
-	int will_destroy;
+	unsigned int will_destroy : 1;
 
 	/*
 	 * Path to the alternative object store. If this is a relative path,
diff --git a/refs.c b/refs.c
index d7cc0a23a3b..27ec7d1fc64 100644
--- a/refs.c
+++ b/refs.c
@@ -2137,7 +2137,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+	if (the_repository->objects->odb->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index c5b90ba93ea..dce8e35ac20 100644
--- a/repository.c
+++ b/repository.c
@@ -80,6 +80,8 @@ void repo_set_gitdir(struct repository *repo,
 	expand_base_dir(&repo->objects->odb->path, o->object_dir,
 			repo->commondir, "objects");
 
+	repo->objects->odb->disable_ref_updates = o->disable_ref_updates;
+
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
diff --git a/repository.h b/repository.h
index a057653981c..7c04e99ac5c 100644
--- a/repository.h
+++ b/repository.h
@@ -158,6 +158,7 @@ struct set_gitdir_args {
 	const char *graft_file;
 	const char *index_file;
 	const char *alternate_db;
+	int disable_ref_updates;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
-- 
gitgitgadget

