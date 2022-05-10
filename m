Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E53C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiEJXcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiEJXcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBC1D525F
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m1so626669wrb.8
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kmRhr3MUwD/F4lNde5G+0NGyyrjYIY/ktlBil4PtfRQ=;
        b=qRVgWrnX1PKRYi2QGP0M6pnQVPfcNx6V6JGob00aOp9Zr9xRXVExpgmEmn/5yrkKlx
         +9sQg5QSzAQoUkISLid2JR5oL0DzZn3gtATEs6dik8F1KYYNajYbgsrru+b01HWlfwsZ
         aYdQaER5oz0/P8RIF7u98scPOX3G9luKv5KaOEe/oyqt/xhrSnw3/Que0WsyF/d7iTmC
         Xh5fj57+tIv0GYttem7NC6mJxA8tRBoKi7hO4wQyJhmlV+//0BExKmO6GQPU4mZrK2pA
         6KL250Wo0R0iE6q6s0jPgnM/kQLpXIHHm5Ee21lOAh82Q6h/iBGNrTJEolBoyzvK2MNK
         +0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kmRhr3MUwD/F4lNde5G+0NGyyrjYIY/ktlBil4PtfRQ=;
        b=q0UGw4fOBl/q+NyQfXjpkJsbxwkhUNQ+/fx2j0EYmVFzfNf7BJWnjLI55xKDcgsoUH
         6Ogbg+A9KvAgIm9uf/7B9uI/KHUyB/jN8OlY8mxjMoXAedpzlkpeLNsrrwS1nTV2gCIe
         fRZyVUeM1cFX8aTIdW4chokmbgbtfQWcbY8XarEddu5jUdgB2dAN/gStd1PYxvwxPyu8
         cdBnA0T0fSgFObx/QkfoTBVZf1DUEyLDP6nK6FuQblpagvPHDjq/2c+lqPEzfUolzKuZ
         Bp2D7K9HFLkmZML9p4qR77I2FhW/pCHFn3WXXsbsDAVb+/h3U1DXaRE+XzQR/IykXt+I
         mRIA==
X-Gm-Message-State: AOAM530/NNPNiJ93AvGlZwT9aAnpsSfaZsF0ghVIMSrna4bL/AR02DRL
        TVmU8/LH8O7uUkMJXLMxtBK2AaiJ/ww=
X-Google-Smtp-Source: ABdhPJx1AnITbLv6/mubiOZWostdwzWFvfr5szPGQJTWKWe5cD3C8sBB4AZHNUAzNgE3mD803CiStw==
X-Received: by 2002:a05:6000:1f03:b0:20c:4d9e:7400 with SMTP id bv3-20020a0560001f0300b0020c4d9e7400mr20438639wrb.257.1652225560670;
        Tue, 10 May 2022 16:32:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c2503000000b003942a244ecfsm323567wml.20.2022.05.10.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:39 -0700 (PDT)
Message-Id: <bb092c075f499acd5aa86debee0a23fa66ac523d.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:30 +0000
Subject: [PATCH v3 4/6] read-cache: set sparsity when index is new
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When the index read in 'do_read_index()' does not exist on-disk, mark the
index "sparse" if the executing command does not require a full index and
sparse index is otherwise enabled.

Some commands (such as 'git stash -u') implicitly create a new index (when
the 'GIT_INDEX_FILE' variable points to a non-existent file) and perform
some operation on it. However, when this index is created, it isn't created
with the same sparsity settings as the repo index. As a result, while these
indexes may be sparse during the operation, they are always expanded before
being written to disk. We can avoid that expansion by defaulting the index
to "sparse", in which case it will only be expanded if the full index is
needed.

Note that the function 'set_new_index_sparsity()' is created despite having
only a single caller because additional callers will be added in a
subsequent patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             | 18 +++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4df97e185e9..60355f5ad6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2260,6 +2260,20 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 	return consumed;
 }
 
+static void set_new_index_sparsity(struct index_state *istate)
+{
+	/*
+	 * If the index's repo exists, mark it sparse according to
+	 * repo settings.
+	 */
+	if (istate->repo) {
+		prepare_repo_settings(istate->repo);
+		if (!istate->repo->settings.command_requires_full_index &&
+		    is_sparse_index_allowed(istate, 0))
+			istate->sparse_index = 1;
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -2281,8 +2295,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (!must_exist && errno == ENOENT)
+		if (!must_exist && errno == ENOENT) {
+			set_new_index_sparsity(istate);
 			return 0;
+		}
 		die_errno(_("%s: index file open failed"), path);
 	}
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 75d844cd71d..85c6a56f1b7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1389,7 +1389,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
-	! ensure_not_expanded stash -u &&
+	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
 		! ensure_not_expanded stash pop
-- 
gitgitgadget

