Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B2C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKGSgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiKGSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61C2611A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so17529021wrt.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHeEwR8h3+faHBEfGtCs65hIdEp9VCiZJMy/rStdD14=;
        b=N9ZRe4QgKgOheVfPjKjTXjwCL2WOOT3gu39maUKPaxxH4SBx8v0lHzACWCq1ker+Pu
         lEvYv58QPBkLW0d/HTX+VONxzWjeQ3ZMkBfkxmg36G6jAcoMufNeMUWqVwxtynFbSvKc
         tTsoPJ3MX8fHu1jKWjK//5ZY7TyYEJbCNL4X/4WvOandW7ZJ8xclRTTMRO0/rPMP+b+U
         4jUZgKjIDno0R1uLSWZmCbLi2u+nOIiUdTttdnea8Ab8aDpmss3X5pJzA9LsLDjs59JK
         s8U88zUByVhDghdys7UdzZwLWTTGu0KxIwSmXHvfmR6bwC3k2essvoWzkeZGax9GVJT7
         HnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHeEwR8h3+faHBEfGtCs65hIdEp9VCiZJMy/rStdD14=;
        b=3W4oRGKBYBm3FunzJuKcmIUEzmay6ewrG6JQCtRwELrdJK/TvQiXHf8T6/4qvrIZ+K
         p+9DAuI1T20OhdwdiLSEFiSmBzg2zZ3xEn7cAfFd3i9fxdxtNtrOuGRjkwKyz7ezkI7U
         HJrzajvZjVVhjuCpKZ7K9Yw2h1Qzdm6TbSFKMKVE3ZPleG0pTinbXyePoINhkaWwWnC4
         X0WyoouyVdCramWcFgkkfoLMnJdiUFi8ZOqcaaXiGvuudexa3n5/nsKvlATioFLLmeix
         BlYnvorbiC2yqr/+5RBguTz6yV2l+nMhH3L/Ie3ntQ5EwNLwfPDxzX671pT2WsDe2y9d
         Echw==
X-Gm-Message-State: ACrzQf1YHCFC+pG6yMH+EHKqxmpTPGMwiMxWEVqLid55/bIkFWKMTWzZ
        zjYY0Rw7SHpU4jsrZ0dNylhuF44sQ4c=
X-Google-Smtp-Source: AMsMyM7w61+pC1ohf8C3ShDnkysMeLe4Zw9n8MMp5W4urFgG/c930bEP7K6Dq7eaYwRW3WeD8YqsCg==
X-Received: by 2002:a5d:564c:0:b0:236:6089:cc50 with SMTP id j12-20020a5d564c000000b002366089cc50mr31490126wrw.520.1667846173691;
        Mon, 07 Nov 2022 10:36:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003c6c3fb3cf6sm8915492wml.18.2022.11.07.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:13 -0800 (PST)
Message-Id: <4fcbfed2c7c78c804c7eeeed5b7080b9fd812bb7.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:41 +0000
Subject: [PATCH 07/30] chunk-format: number of chunks is optional
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

Even though the commit-graph and multi-pack-index file formats specify a
number of chunks in their header information, this is optional. The
table of contents terminates with a null chunk ID, which can be used
instead. The extra value is helpful for some checks, but is ultimately
not necessary for the format.

This will be important in some future formats.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/gitformat-chunk.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitformat-chunk.txt b/Documentation/gitformat-chunk.txt
index 57202ede273..c01f5567c4f 100644
--- a/Documentation/gitformat-chunk.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -24,8 +24,9 @@ how they use the chunks to describe structured data.
 
 A chunk-based file format begins with some header information custom to
 that format. That header should include enough information to identify
-the file type, format version, and number of chunks in the file. From this
-information, that file can determine the start of the chunk-based region.
+the file type, format version, and (optionally) the number of chunks in
+the file. From this information, that file can determine the start of the
+chunk-based region.
 
 The chunk-based region starts with a table of contents describing where
 each chunk starts and ends. This consists of (C+1) rows of 12 bytes each,
-- 
gitgitgadget

