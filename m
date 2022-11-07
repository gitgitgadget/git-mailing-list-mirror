Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DAC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKGSgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKGSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE926483
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j15so17559212wrq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsBoUSCCBGR2rdNs7h7mrHxY35extMQtstKoNdGBAM=;
        b=MUF3Ox7IUGsFlhV2voeZhY8jThGs7Wf3zN0jbgCU0sRrgcKm73DLV7gGY88mNoWjy4
         dLmDHEiRVKXSXbU65/JuoIc9dsnJWk7VrdFj71aDa8WPUidwfOuJ8ITQI4I5t8KlSXcq
         7V5u5NVH0yqsLsATSeyGR/HoLca7khqancX2kp5X9vdbh1PRdmUgBEYMX4p8UtaKwcm1
         HHs1uF1dY6Fbi2/oFnC87SwIFF7en1zC46Vgg1tM19urA3YF5CipuhF81cD+GLuzqKyj
         GDzR90uGEXFFd4aJv59j9G/+u0LeGzPp0UeeAPrSX5RYkuEeTxkvMyqjgy4fcbogSFc5
         CQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsBoUSCCBGR2rdNs7h7mrHxY35extMQtstKoNdGBAM=;
        b=bGS1Z39E82KZ4dqaHTEUSwtK4N5ITJy8wlJax595jHpB3urZGSbN3aktG0xGmZ3O/H
         TQjsqw0AuwdZrMdWiWAKh8DeddG0Gn0tLi6crFNYAuijk17BUsYvdA6ThcH+UI0p49Pq
         bZHM9fWBPZ1HxYAVS9KehCNsaLUGab+8W69cTaYCPb/EeWF5iRR4OzJkvIDbQXcZZRYB
         Fprv7u3SJxoNW0nBftP65L3nfple3rDft7ZcLU9u+nt55lIXRkGuTFDr0LJ0fYVrdWEY
         xPMKoDxaICeHdIkOlzu6JqFvQs12kmn7P5a2Xg94+eYQY+gBmfgh61jXGbO83X6kXyS6
         ODQA==
X-Gm-Message-State: ACrzQf3NxN7iIdBMUBVImZDWzDbOQ+n8CX8lK3yQxHlY78QZkAEv31mm
        CPpHKFEwZqWZ2A/D+RiFH58wdG1Jq6U=
X-Google-Smtp-Source: AMsMyM7uM6pxz5JOrvp15bFDj2lGrIrad+mQ7WK/uRVC6wxw5E4IXZge3N5HgBcQ4q3WE/pzLJj2EA==
X-Received: by 2002:a05:6000:1ce:b0:236:ef02:bb56 with SMTP id t14-20020a05600001ce00b00236ef02bb56mr19910340wrx.238.1667846174601;
        Mon, 07 Nov 2022 10:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a056000010f00b0023691d62cffsm8081439wrx.70.2022.11.07.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:14 -0800 (PST)
Message-Id: <a7bf8cbec45859e79ac71dea06be391f75a0a524.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:42 +0000
Subject: [PATCH 08/30] chunk-format: document trailing table of contents
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

It will be helpful to allow a trailing table of contents when writing
some file types with the chunk-format API. The main reason is that it
allows dynamically computing the chunk sizes while writing the file.
This can use fewer resources than precomputing all chunk sizes in
advance.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitformat-chunk.txt | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitformat-chunk.txt b/Documentation/gitformat-chunk.txt
index c01f5567c4f..ee3718c4306 100644
--- a/Documentation/gitformat-chunk.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -52,8 +52,27 @@ The final entry in the table of contents must be four zero bytes. This
 confirms that the table of contents is ending and provides the offset for
 the end of the chunk-based data.
 
+The default chunk format assumes the table of contents appears at the
+beginning of the file (after the header information) and the chunks are
+ordered by increasing offset. Alternatively, the chunk format allows a
+table of contents that is placed at the end of the file (before the
+trailing hash) and the offsets are in descending order. In this trailing
+table of contents case, the data in order looks instead like the following
+table:
+
+  | Chunk ID (4 bytes) | Chunk Offset (8 bytes) |
+  |--------------------|------------------------|
+  | 0x0000             | OFFSET[C+1]            |
+  | ID[C]              | OFFSET[C]              |
+  | ...                | ...                    |
+  | ID[0]              | OFFSET[0]              |
+
+The concrete file format that uses the chunk format will mention that it
+uses a trailing table of contents if it uses it. By default, the table of
+contents is in ascending order before all chunk data.
+
 Note: The chunk-based format expects that the file contains _at least_ a
-trailing hash after `OFFSET[C+1]`.
+trailing hash after either `OFFSET[C+1]` or the trailing table of contents.
 
 Functions for working with chunk-based file formats are declared in
 `chunk-format.h`. Using these methods provide extra checks that assist
-- 
gitgitgadget

