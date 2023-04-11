Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6711C77B70
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 03:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKDBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDKDBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 23:01:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2932D42
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so6006003wrb.9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VeTpH3kyMpguKB8Gj505GTnimG4X0MOi0rx/4A8jNk=;
        b=WOm7/YdZkEX0TwHpmYH3dpBtjQAO5HFwclvr0fBc98ci5WkS7B9Eow20LezKqrXLXc
         9179CoxH2vmLDDjIKcCvyGmlT/9yxoJOsLHuxNTwiJo4c/VQ9XVvaqlsMogSQekm6dzJ
         BTmwGu1IM5iJzuEE4wxjCfbff0+Y2BFsHcG/x2jimhm0rwIzwq0MvsH89GqMhLy8Du31
         UC+etSPvUJrnSEJFsrVshSqJvIHxaKUqtceZrnyunA2YhIh5CN0LUThPhFiJA91nknxn
         MbUXhOcuz9ItL6f+3DPsV2pwSru6rVSewlBBEd3z8bXN1ZRCuJ9dQGoSTtz2po3lo7Qy
         VF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VeTpH3kyMpguKB8Gj505GTnimG4X0MOi0rx/4A8jNk=;
        b=T9bBLeKB2RnWQi8yAMGllNHtwA4Au5MuPebX4Vw1QDuirjG6qcFtbjD7c1NDDLyRkO
         7wYLHo+Cwaszw22LqnC9zsKmpSdA25rrhGk7I7bqO6ABSmxChVhyIE9/vBtaRVyTUaMc
         BZA1D1jLFVflqqNQvTBsB156uevH6ZHeClDWhISwVc8RfBpwiswwn7SPGtp88sBpGCIn
         ZmBgeoV/qqKQDA0DCP+7XOsEn48H5vDjpS1sGC4nGsX3xwX9OHxHNAs7APJ2BewhPmcL
         o1Rhc/xO1Vc5juC5IdYeqYPOhSocR9XJRuna5JjENyl1PhF7W/RC4mDZEK1s06T/UVFu
         l2bw==
X-Gm-Message-State: AAQBX9dWMZUT74HITmRe+OcyhFbqCxa3pBbmFgA0dIbGuBqqSddMQD64
        YNLIXL4hB+Ob5zr7WnQSCwg6OJrIAg0=
X-Google-Smtp-Source: AKy350ZvfnWYu4m/98bX0295M2Sf3oTrhuIy6wOUoltTdwke9GQuEQV38GQVXuDeiveiSGWqVRKMEw==
X-Received: by 2002:a05:6000:1b0a:b0:2ef:b3e6:8293 with SMTP id f10-20020a0560001b0a00b002efb3e68293mr9158766wrz.9.1681182069734;
        Mon, 10 Apr 2023 20:01:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d5284000000b002d1801018e2sm13216867wrv.63.2023.04.10.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:01:09 -0700 (PDT)
Message-Id: <bcc35c33728d25bef6e8c06bfb7bcf82127074e7.1681182062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
        <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 03:00:41 +0000
Subject: [PATCH v3 04/23] treewide: be explicit about dependence on
 pack-revindex.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 builtin/index-pack.c | 1 +
 cache.h              | 1 -
 pack-write.c         | 1 +
 packfile.c           | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b17e79cd40f..ceb0f120ede 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -17,6 +17,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
+#include "pack-revindex.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/cache.h b/cache.h
index 415f0f85670..5f1279454a8 100644
--- a/cache.h
+++ b/cache.h
@@ -7,7 +7,6 @@
 #include "list.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "pack-revindex.h"
 #include "hash.h"
 #include "path.h"
 #include "pathspec.h"
diff --git a/pack-write.c b/pack-write.c
index f1714054951..152c14aa7aa 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -9,6 +9,7 @@
 #include "pack-mtimes.h"
 #include "oidmap.h"
 #include "pack-objects.h"
+#include "pack-revindex.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/packfile.c b/packfile.c
index 2d3dabb1aee..02afbe77137 100644
--- a/packfile.c
+++ b/packfile.c
@@ -21,6 +21,7 @@
 #include "object-store.h"
 #include "midx.h"
 #include "commit-graph.h"
+#include "pack-revindex.h"
 #include "promisor-remote.h"
 #include "wrapper.h"
 
-- 
gitgitgadget

