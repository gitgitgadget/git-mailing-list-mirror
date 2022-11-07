Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F9C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiKGSga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiKGSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF825EAE
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so17559101wrq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1auC5rAXkQITen61m670krVuOIVE+OUY+QjwiUQp/YU=;
        b=C+gIRI/LRC7xs2mG5txVSMcn9wMAEju4GKH+u+BqOGJHBD3dYNLklcrN5ZIGEX2EoG
         FjfBMTonxQMxxoyrWLVF6rSe74j3/R7m/D4voLLmtmD6VDI/uIKE55WqA6fZzIJ1Ia8J
         VyAaqNIPF+ngjlmx37jUp/550As6tPSnwO5NBpgQxr7umaQAbwg1D1Vz4eEGqeohpEFg
         Ct24cd7MwKl21yQquul5qn49w7O9/Q71nh5RMSEGGGEFH0QSaxA/ZDjOZbFaobDcckx0
         1XAUDrZ50CzyfJghMYVqWAMZgauMCUYDPorh88JkHRSpikMceb5H7ttpXNxBgzfDACaY
         GuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1auC5rAXkQITen61m670krVuOIVE+OUY+QjwiUQp/YU=;
        b=fkcTH1phB7e8u/JmIAAsWk23t7If/aoENzBkLsg8BtIrsi0Lh5obVmYTsbGZUSOJlh
         eoyNrcLzR3pXr+vOChiIune1tEfb4GH3wmBOgyA1jQb60sQd52BMrhL/7+gNwqMpfwJp
         +jI5RrBVKt1sjhT+INJYNlFNSbSHx790f0rKU8oXTsdYKrfsTXDY6Y6GbJO6q7fqMz7j
         plvqxLlETyfVUcIeoKLtHhFlSfYOqEUg9SuNg40jnGXEvhwwmKZ9avCJprJRwNfijLbE
         +5YK45MsdGbzs6A0ISzUnqH9RzLGLd+Sw/m/eAFDGdrgee9eBVCyAM6cfX0XJ/0A4TAl
         lPDg==
X-Gm-Message-State: ACrzQf2ypjw1D71kn6i2423bJewcB+nDIE7oTGcxjBQq50zmzNZorcoD
        sAaDpA90dUxOqQINFmEoQonBaJx45DY=
X-Google-Smtp-Source: AMsMyM62ukR7ug4S+lWxRXQarws4XcT7qXpMwQVBz+r1ubqCUJGIbVKAq8Oev/8qaPus8I70rlMt7A==
X-Received: by 2002:adf:f7d2:0:b0:236:87bc:a8f7 with SMTP id a18-20020adff7d2000000b0023687bca8f7mr32437674wrq.579.1667846172615;
        Mon, 07 Nov 2022 10:36:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003c6bd12ac27sm9581105wmb.37.2022.11.07.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:11 -0800 (PST)
Message-Id: <531bf1b6db0f5bbaf1508de5ea33f2e6d114f820.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:40 +0000
Subject: [PATCH 06/30] refs: allow loose files without packed-refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The extensions.refFormat extension is a multi-valued config that
specifies which ref formats are available to the current repository. By
default, Git assumes the list of "files" and "packed", unless there is
at least one of these extensions specified.

With the current values, it is possible for a user to specify only
"files" or only "packed". The only-"packed" option was already ruled as
invalid since Git's current code has too many places that require a
loose reference. This could change in the future.

However, we can now allow the user to specify extensions.refFormat=files
alone, making it impossible to create a packed-refs file (or to read one
that might exist).

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/extensions.txt |  5 +++++
 refs/files-backend.c                |  6 ++++++
 refs/packed-backend.c               |  3 +++
 refs/refs-internal.h                |  5 +++++
 t/t3212-ref-formats.sh              | 20 ++++++++++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 18ed1c58126..18071c336d0 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -46,6 +46,11 @@ The following combinations are supported by this version of Git:
 	format. Loose references are preferred, and the `packed-refs` file
 	is updated only when deleting a reference that is stored in the
 	`packed-refs` file or during a `git pack-refs` command.
+
+`files`;;
+	When only this value is present, Git will ignore the `packed-refs`
+	file and refuse to write one during `git pack-refs`. All references
+	will be read from and written to loose reference files.
 --
 
 extensions.worktreeConfig::
diff --git a/refs/files-backend.c b/refs/files-backend.c
index db6c8e434c6..4a18aed6204 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1198,6 +1198,12 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
+	if (!packed_refs_enabled(refs->store_flags)) {
+		warning(_("refusing to create '%s' file because '%s' is not set"),
+			"packed-refs", "extensions.refFormat=packed");
+		return -1;
+	}
+
 	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
 	if (!transaction)
 		return -1;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c1c71d183ea..a4371b711b9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -478,6 +478,9 @@ static int load_contents(struct snapshot *snapshot)
 	size_t size;
 	ssize_t bytes_read;
 
+	if (!packed_refs_enabled(snapshot->refs->store_flags))
+		return 0;
+
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 41520c945e4..a1900848a87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -524,6 +524,11 @@ struct ref_store;
 #define REF_STORE_FORMAT_FILES		(1 << 8) /* can use loose ref files */
 #define REF_STORE_FORMAT_PACKED		(1 << 9) /* can use packed-refs file */
 
+static inline int packed_refs_enabled(int flags)
+{
+	return flags & REF_STORE_FORMAT_PACKED;
+}
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index 8c4e70196a0..67aa65c116f 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -36,4 +36,24 @@ test_expect_success 'extensions.refFormat=packed only' '
 	)
 '
 
+test_expect_success 'extensions.refFormat=files only' '
+	test_commit T &&
+	git pack-refs --all &&
+	git init only-loose &&
+	(
+		cd only-loose &&
+		git config core.repositoryFormatVersion 1 &&
+		git config extensions.refFormat files &&
+		test_commit A &&
+		test_commit B &&
+		test_must_fail git pack-refs 2>err &&
+		grep "refusing to create" err &&
+		test_path_is_missing .git/packed-refs &&
+
+		# Refuse to parse a packed-refs file.
+		cp ../.git/packed-refs .git/packed-refs &&
+		test_must_fail git rev-parse refs/tags/T
+	)
+'
+
 test_done
-- 
gitgitgadget

