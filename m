Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E36C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444C2611EE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhJGNyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhJGNyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12AC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r18so19380927wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=it/bgcb/DlJBVIvX7AtAI/7Ufqe/EdnQGFJf07mMxEionvNw+AJRgnGScIrI8Gb5UX
         AjmehprApbkNgSJyOoHygaKpKEtK3r0SNiyGbwae5fTqUdLXBlS5kKFhLOsD6y3QESAu
         M4dTNCzCryOLl9l0BqioxlFK6D3bg97v5XYYwTRLw6t1ZZnH2dlBI9DGpjO/fU2rN7u2
         59eA96dO4+9okpy6EABY8U4qDKTysjY8HlchULhRJYpab6HggxPQVcDvcu641PP2TPLa
         iB8lPvOCRVfpbyUvqdDe6HG4TmIQDAXTF+k5bxKirCBLvPsX6kUYXJKZZiL0+OgYKDaH
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=OxkAvEbta07mXtxRO9UutfTqdpUqHTR4peW7JbsUqyB0kuHPpd1oHnEbZ2LkNjghZO
         PUrIdzIgbN9G0WIK4bO/3UN6STORLXZ7tbmmFTAMzSahBCG9X7DLnuT5K1VyPzErURO1
         ts/YiAkBkfYTmQan/M7tB2aQUTtOg/qR8gIyAt4QmfFxtVd8+UVQ1XKVfuUQjCHbBi56
         ID4Aqw9beFbYEQpLAyjXuV+Rs0t6w8L3l4Q+rOreKj/o6PuEJnAPI0h7XV8eYhAhzRhd
         fr2IAnyj52t+ODhFX4xeOLaHvCflwK30i6+pdSEFgTeu6Ar8/lnJEzN8/ahEAm4iAR/J
         DKvg==
X-Gm-Message-State: AOAM530nt8dCZL8aFRUCbFw8GWMt9pgHmscKwmJGa/PnISWmEU1ms7O3
        pM0NEFNZCmv5Mwdyc1EcLSGWca1X35Y=
X-Google-Smtp-Source: ABdhPJz7MnU/OmDG/P6S3GCQeVHKMWZWM/T58ie/gTNQ8lMv8zP87jL9pd8P8gypdFyJOo7YIJ0Hrg==
X-Received: by 2002:a05:600c:250:: with SMTP id 16mr1819908wmj.128.1633614774906;
        Thu, 07 Oct 2021 06:52:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm1965909wrq.4.2021.10.07.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:54 -0700 (PDT)
Message-Id: <cb25eeaf72dfe25bfa62bd550a0cabf8817bf914.1633614772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:48 +0000
Subject: [PATCH v2 1/5] fsmonitor: enhance existing comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..ec4c46407c5 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -301,9 +301,25 @@ void refresh_fsmonitor(struct index_state *istate)
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
+	/*
+	 * The response from FSMonitor (excluding the header token) is
+	 * either:
+	 *
+	 * [a] a (possibly empty) list of NUL delimited relative
+	 *     pathnames of changed paths.  This list can contain
+	 *     files and directories.  Directories have a trailing
+	 *     slash.
+	 *
+	 * [b] a single '/' to indicate the provider had no
+	 *     information and that we should consider everything
+	 *     invalid.  We call this a trivial response.
+	 */
 	if (query_success && query_result.buf[bol] != '/') {
-		/* Mark all entries returned by the monitor as dirty */
+		/*
+		 * Mark all pathnames returned by the monitor as dirty.
+		 *
+		 * This updates both the cache-entries and the untracked-cache.
+		 */
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
@@ -318,11 +334,15 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	} else {
-
-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
-		 * if we actually changed entries or not */
+		/*
+		 * We received a trivial response, so invalidate everything.
+		 *
+		 * We only want to run the post index changed hook if
+		 * we've actually changed entries, so keep track if we
+		 * actually changed entries or not.
+		 */
 		int is_cache_changed = 0;
-		/* Mark all entries invalid */
+
 		for (i = 0; i < istate->cache_nr; i++) {
 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
 				is_cache_changed = 1;
@@ -330,7 +350,10 @@ void refresh_fsmonitor(struct index_state *istate)
 			}
 		}
 
-		/* If we're going to check every file, ensure we save the results */
+		/*
+		 * If we're going to check every file, ensure we save
+		 * the results.
+		 */
 		if (is_cache_changed)
 			istate->cache_changed |= FSMONITOR_CHANGED;
 
-- 
gitgitgadget

