Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCBC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiBYRKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBYRKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:10:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99A186B95
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so5481704wrb.6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv2jZjUK6lbjXJZCOXpjHPeNtKrW1epocKS0+GVZpxE=;
        b=Y9CnQ/ym4teKpzJfhbmM0SLWgOPev5x1Xz1jnn/WjcigqtSDCys3/x/kuf6RFupx0D
         665ivfE0oWfMFvB5zdWmoMyLV06uqXrdlHkqJI1X5Hz0xae6wmg0PvB4r0TH9XvDsYc/
         Y2yoJyj/8NPfPEEFoWg/RM6P72aUd3zt4fncJE1PNfney5eJTjFUJ33k5fbR8O6D5OKF
         UYYbL5DI8PvvL+WxOi6P141f5qhiMm/UlzPIY0D0D2GWGZgeE8z0eAFRFeylMfDqmXOF
         V6Semez0K8LWQEv0Otm3YNDAHBFMQWPEwfwLpNAzzU0s8jXg1Ywt7ANCLwOSe8t9m1/F
         P5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv2jZjUK6lbjXJZCOXpjHPeNtKrW1epocKS0+GVZpxE=;
        b=B21TB5LIjhot/6tBplf6gZeh3naFVOqaaJL4Q29QfjZT72bs0bdP/0zcduVgbpEo5t
         mgPhz6aeJ6/npORH4wX/iQOvSeGd35P2Kml09lPR8HUW/WGptLgUDEqTJVQAwU9x4Ef/
         2NGMZ7GdWawjpaPxP8IxK6bqN5A4UKrLyESXNfcKK3gA0chPOROfiGx3WO+VgqmZHWee
         ZJTZvjx+sz06vp3Mu9yYmaVoGCO4AJuBm7XQNqB5WX3c1sdsQc+JKrTDlUUxNyOCcvN2
         mDdBIa9e3zieSu+PlIYYaZvJd/PWuNRH61C/Cwe24TZA1tASQ+0lVSror7TSCYK19MGV
         Xv1A==
X-Gm-Message-State: AOAM533KN+3wx1mVt5c/oXx0zYOqA3tHDZAUEXT1hqVv76V9Y2Tl1Pa7
        LZzJr2CXCKam0LsA/gAvTVCXtYIVhGE=
X-Google-Smtp-Source: ABdhPJxDq1KKpR2q0u9nqZEUe6jNnI2cEuppb+9PXv7kui1tBRr3IO/z5z4b6PPrjxb/PcXi6Gbxqg==
X-Received: by 2002:a5d:6e0f:0:b0:1ed:a72f:8842 with SMTP id h15-20020a5d6e0f000000b001eda72f8842mr6995138wrz.568.1645809017226;
        Fri, 25 Feb 2022 09:10:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7-20020adfc507000000b001ed9f31afdcsm2749255wrf.3.2022.02.25.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:10:16 -0800 (PST)
Message-Id: <9421b71540d1f1764db6931d0781576d8a710866.1645809015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 17:10:12 +0000
Subject: [PATCH v2 1/3] t7519: avoid file to index mtime race for untracked
 cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In t7519 there is a test that writes files to disk, and immediately
writes the untracked index. Because of mtime-comparison logic that
uses a 1-second resolution, this means the cached entries are not
trusted/used under some circumstances
(see read-cache.c#is_racy_stat()).

Untracked cache tests in t7063 use a 1-second delay to avoid this
issue, but we don't want to introduce arbitrary slowdowns, so instead
use test-tool chmtime to backdate the files slightly.

This change doesn't actually affect the outcome of the test, but does
enhance its validity, and becomes relevant after later changes.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..3f984136ea9 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -324,13 +324,19 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		cd dot-git &&
 		mkdir -p .git/hooks &&
 		: >tracked &&
+		test-tool chmtime =-60 tracked &&
 		: >modified &&
+		test-tool chmtime =-60 modified &&
 		mkdir dir1 &&
 		: >dir1/tracked &&
+		test-tool chmtime =-60 dir1/tracked &&
 		: >dir1/modified &&
+		test-tool chmtime =-60 dir1/modified &&
 		mkdir dir2 &&
 		: >dir2/tracked &&
+		test-tool chmtime =-60 dir2/tracked &&
 		: >dir2/modified &&
+		test-tool chmtime =-60 dir2/modified &&
 		write_integration_script &&
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
 		git update-index --untracked-cache &&
-- 
gitgitgadget

