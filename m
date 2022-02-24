Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D1C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiBXUjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbiBXUjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307B179A29
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j22so1398101wrb.13
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oPNuFQbuxhEXkfATdZeV447TAqaaEdYD+9qvHIVYfg0=;
        b=BxIqgiMxcHrbM0K9vJQfmFGG2xqAAPc5i0ekfMe7UmvShldycvzCBAe4l+gCf279yE
         K+ZRj0xnLYQgUfG3Rj1pYamVGjpfOpOBnbXhsvSoyG9U99zSa8ikcC2IngD0JQgHc9JZ
         rsGSexql0URBMGxK5Y+u/xKcMSrxu6Mj1glUQfhQGMtKGhWHgc3uT59hBiu3GTOc/Dg2
         jzlANaO8UM8K5ntmkhfnhx1iGaaWF8rIyCZAUUKX5hR1AH+UItN4g3lIfgndXpMlOmML
         dAol8oAxcxEm2gdhKtjEU0Y9txKew+NRIh2a2DzkdThtQ6dIk+hBLY+rDM9lAZK8B5dO
         WhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oPNuFQbuxhEXkfATdZeV447TAqaaEdYD+9qvHIVYfg0=;
        b=DL6WS2ezsD4v83xMBA9z9+I9LruVSh6xMFVp08VI7lkjS2VFhSaFDbhnkDAsI20wqq
         Xi2vbssiMBEMHyRwEchJGg6GKGSqrCqL/sWSM2qZsAdWH5r0GGxVvwAvqrK2em2lkDgF
         GUcNobPWNbyUu5lIcIRFX8jZBCnzHT4yUR2X640jPfXF+fRzzVfrA7puYOludQWtK+xw
         Hz/WxyztjrpTsDhDb35wCuVKynwa+hs84eWs2/BpWuQ97hp0HvmMufK1RtWDKXtTL6fx
         xmZNYgae1zsO6UNBKAOYvl/RA55O89T3Eljd/lEY11wG733TPQ3KOrqBaZtyS5QYZaY5
         bpHg==
X-Gm-Message-State: AOAM5333gyoZNrUsPYBk/pIqKe2++b4J8tlzftVSzn6H3NDwq52CeVsD
        JNGuHCG1FQiFvtSh4dO0E7tc687BmSg=
X-Google-Smtp-Source: ABdhPJx4a1vPH2nI4iJ060+NetX+V+dyMtJA7UefSpqJsWqHO9bKMPI1hSoIwu/WWR0MvKWaYnvYnA==
X-Received: by 2002:adf:f2c9:0:b0:1e3:1cfa:551a with SMTP id d9-20020adff2c9000000b001e31cfa551amr3707291wrp.603.1645735122229;
        Thu, 24 Feb 2022 12:38:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b001edc00dbeeasm334871wrw.69.2022.02.24.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:41 -0800 (PST)
Message-Id: <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:34 +0000
Subject: [PATCH 5/7] commit-graph: document file format v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The corrected commit date was first documented in 5a3b130ca (doc: add
corrected commit date info, 2021-01-16) and it used an optional chunk to
augment the commit-graph format without modifying the file format
version.

One major benefit to this approach is that corrected commit dates could
be written without causing a backwards compatibility issue with Git
versions that do not understand them. The topological level was still
available in the CDAT chunk as it was before.

However, this causes a different issue: more data needs to be loaded
from disk when parsing commits from the commit-graph. In cases where
there is no significant algorithmic gain from using corrected commit
dates, commit walks take up to 20% longer because of this extra data.

Create a new file format version for the commit-graph format that
differs only in the CDAT chunk: it now stores corrected commit date
offsets. This brings our data back to normal and will demonstrate
performance gains in almost all cases.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 .../technical/commit-graph-format.txt         | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 87971c27dd7..2cb48993314 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -36,7 +36,7 @@ HEADER:
       The signature is: {'C', 'G', 'P', 'H'}
 
   1-byte version number:
-      Currently, the only valid version is 1.
+      This version number can be 1 or 2.
 
   1-byte Hash Version
       We infer the hash length (H) from this value:
@@ -85,13 +85,22 @@ CHUNK DATA:
       position. If there are more than two parents, the second value
       has its most-significant bit on and the other bits store an array
       position into the Extra Edge List chunk.
-    * The next 8 bytes store the topological level (generation number v1)
-      of the commit and
-      the commit time in seconds since EPOCH. The generation number
-      uses the higher 30 bits of the first 4 bytes, while the commit
+    * The next 8 bytes store the generation number information of the
+      commit and the commit time in seconds since EPOCH. The generation
+      number uses the higher 30 bits of the first 4 bytes, while the commit
       time uses the 32 bits of the second 4 bytes, along with the lowest
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
+      - If the commit-graph file format is version 1, then the higher 30
+	bits contain the topological level (generation number v1) for the
+	commit.
+      - If the commit-graph file format is version 2, then the higher 30
+	bits contain the corrected commit date offset (generation number
+	v2) for the commit, except if the offset cannot be stored within
+	29 bits. If the offset is too large for 29 bits, then the value
+	stored here has its most-significant bit on and the other bits
+	store the position of the corrected commit date in the Generation
+	Date Overflow chunk.
 
   Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
     * This list of 4-byte values store corrected commit date offsets for the
@@ -103,6 +112,9 @@ CHUNK DATA:
     * Generation Data chunk is present only when commit-graph file is written
       by compatible versions of Git and in case of split commit-graph chains,
       the topmost layer also has Generation Data chunk.
+    * This chunk does not exist if the commit-graph file format version is 2,
+      because the corrected commit date offset data is stored in the Commit
+      Data chunk.
 
   Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
     * This list of 8-byte values stores the corrected commit date offsets
-- 
gitgitgadget

