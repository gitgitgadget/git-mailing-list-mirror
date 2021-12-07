Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5591BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhLGNl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbhLGNlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBBC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so1629030wmi.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jL466pEYc6tScMJdo6weuZggZZcoDMfxZ5k5yFTYTd0=;
        b=VlpvmapMRSl0u1iQ9mDvRBQLXx/vWa0qtuNFDYJO6Rlv1NUdrwnFhH4RmnINoYHm7E
         SvNUFKk3wcBQ3raoJ1Rhq3yvVG/af4mNChYkv4Ky2iZCU0m6Xm79UCKobVvDnqIrV84Z
         Gkc5HBfNKW5mRHJKZjCIq77iB9HzVRixI8y0NCOzba+4zY1JRnlznXXjCXW2P7abyUN0
         pChr+jc5NtWYCRQCZGpVVTfFySfB1kTzHEzOdmkHlcHt1JL+ijJUoycc7xd5Dv9xG63J
         +SJu54l7mKOY2OOb28b1wZMHAVuV7hb38jiYkxcDWDp6SZRpObzrMXmJ/U5kpvXxksRY
         vigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jL466pEYc6tScMJdo6weuZggZZcoDMfxZ5k5yFTYTd0=;
        b=04ImnPfyfilrlFNXFrk6cZ9BOxMZzZdRgvCvpRqmp5t0QCWDg5MT50LgfxfIS+0Iz4
         JBXtvPA3+NpQtG4hXm9SGOLl2O6nCzWPlYfxzQYCbIYgR6ffEILD/1Sq0RVtnluSLrEY
         t+jOCP1h9gHkUMjWJc+0pEUMHFJ4LhUZLdvBf0skhspZNVOIpxVXQv8fOriOBt/pwF2I
         iJd6QZ57jRBsJ2TCEBpKMRKsHk11h8D3Z7oGE2MC1uS2aqK4yXEk9UK1xG5hkgrU0tRz
         ZVcdGFatZwjW+beERsMVYUxROxiUdf1OrnopE9ldTKTm7/i9r2/x8zLmIX6BKdD7YCpu
         z6Jg==
X-Gm-Message-State: AOAM5312vyXDx6fiLmYe/nOvtkTUKOW9PgckFGy0SPNlZxfPiznEUUHW
        fVFBem5tLPkcGoG2v0BET0fQ2ZxQ7d0=
X-Google-Smtp-Source: ABdhPJw6lcT7J5nm8vLKTK1Suk5BxAlEBhzrsCHtVKEso0J7ES2reyRzKYEJvFRArjcrLXZ3YQGQhg==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr7038510wma.78.1638884302842;
        Tue, 07 Dec 2021 05:38:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm3012359wmq.14.2021.12.07.05.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:22 -0800 (PST)
Message-Id: <3649ef6d0fa14ea1796264188466cdfc42d6d9e1.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:13 +0000
Subject: [PATCH v4 1/8] test-ref-store: remove force-create argument for
 create-reflog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Nobody uses force_create=0, so this flag is unnecessary.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c      | 2 +-
 t/t1405-main-ref-store.sh      | 5 ++---
 t/t1406-submodule-ref-store.sh | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3986665037a..b795a56eedf 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -182,9 +182,9 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
 static int cmd_create_reflog(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
-	int force_create = arg_flags(*argv++, "force-create");
 	struct strbuf err = STRBUF_INIT;
 	int ret;
+	int force_create = 1;
 
 	ret = refs_create_reflog(refs, refname, force_create, &err);
 	if (err.len)
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..5e0f7073286 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -35,8 +35,7 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
 	m=$(git rev-parse main) &&
-	REF_NO_DEREF=1 &&
-	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
+	$RUN delete-refs REF_NO_DEREF nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse --symbolic-full-name FOO &&
 	test_must_fail git rev-parse FOO -- &&
 	test_must_fail git rev-parse refs/tags/new-tag --
@@ -108,7 +107,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 '
 
 test_expect_success 'create-reflog(HEAD)' '
-	$RUN create-reflog HEAD 1 &&
+	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..f1e57a9c051 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -92,7 +92,7 @@ test_expect_success 'delete_reflog() not allowed' '
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD 1
+	test_must_fail $RUN create-reflog HEAD
 '
 
 test_done
-- 
gitgitgadget

