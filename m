Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D85DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 00:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiGLAGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 20:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGLAGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 20:06:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA371144E
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so8963671wrv.10
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7HJSB/MW+GkSUAynVvd56ZbaS7HaxOBFqSibX7gbNCs=;
        b=ouRcpOPSziNMdOv2Ott0Wnelz86jz8BcKNFnbQNVPsFWISbMOD5xI1Gkx4ygAAA8eh
         ef2FFkJ+zJ99kh7bZy/y5BHE/4XOoqG60/g6P/VCF8+nzVMvB0zE+PKPvE1g8Bmnp+34
         jRwAia4J/quTb9aLXKAEpNk9fGMZZcMAblJCmLjkc+UJYKJ0BY5zEIqlpk1Dyd2rIljF
         1ES00KeoWaH+OWSk0QKYz4kstF7ILCq9+fCk+oIzKRH2AXALtkjvvgmZELC+CkjsdTv8
         4ixLc7fnwQdHy4yXiZayCYR/eqXxYRwEChRhzpEAJf9KimRkDbQ3hcULBVKOHDh3sRBR
         80Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7HJSB/MW+GkSUAynVvd56ZbaS7HaxOBFqSibX7gbNCs=;
        b=cPq9x6Bhmh9cEevb55Dro0reX8Cd8SiiGCUjeq/m+SKsiYiXaWeKrMJsVtihp9LxSN
         WsKvXkxIQoa9LE5TmmqlfwDdLKeWBLPPQFo4sa4VlXj5xTqyZHJU1iJtl+yfJDhOhI6w
         +ForGsTtmqKMkAxm1riqa4W3Gd0wMAVvzo66tchcZzVlxrJho816SWYk64q0u2XHIvwe
         Gy29yzAOJtG0JrLeRjz7xqMc8yaPC9rHiVZvytaWpYujjxDiJ77f1wzFwJvUR2aXumOB
         Mt8uLcWQPHv5qjIxgr2MEzlAnevpF41ENRy/c+qOW87wSH4AaV2Ux3BBQi0nTQNPU7b0
         mN0w==
X-Gm-Message-State: AJIora9Gpo2C7omBaMFTMcdI/G6BWk8aguGvJrW5k0Q7inOrmhtKM7NH
        wOn4Hp0Bi2tlLyMtIi0ryHUy0TO1vCg=
X-Google-Smtp-Source: AGRyM1vjl2tlsKhFOF6X+eCwYthCdbrWWNvkQSTdnx4dms6U4pcEIsqI9C75LYGvXjG8Rh87I2C0ag==
X-Received: by 2002:a5d:6da8:0:b0:21d:2598:4e28 with SMTP id u8-20020a5d6da8000000b0021d25984e28mr20071776wrs.373.1657584369954;
        Mon, 11 Jul 2022 17:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5-20020adf9dc5000000b0021d928d2388sm6895670wre.85.2022.07.11.17.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:06:09 -0700 (PDT)
Message-Id: <38c0b4dff90f44687590c3686d664599c712417b.1657584367.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
        <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 00:06:06 +0000
Subject: [PATCH v2 1/2] scalar: reword command documentation to clarify
 purpose
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rephrase documentation to describe scalar as a "large repo management tool"
rather than an "opinionated management tool". The new description is
intended to more directly reflect the utility of scalar to better guide
users in preparation for scalar being built and installed as part of Git.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index c0425e06533..1a12dc45077 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -3,7 +3,7 @@ scalar(1)
 
 NAME
 ----
-scalar - an opinionated repository management tool
+scalar - A tool for managing large Git repositories
 
 SYNOPSIS
 --------
@@ -20,10 +20,9 @@ scalar delete <enlistment>
 DESCRIPTION
 -----------
 
-Scalar is an opinionated repository management tool. By creating new
-repositories or registering existing repositories with Scalar, your Git
-experience will speed up. Scalar sets advanced Git config settings,
-maintains your repositories in the background, and helps reduce data sent
+Scalar is a repository management tool that optimizes Git for use in large
+repositories. Scalar improves performance by configuring advanced Git settings,
+maintaining repositories in the background, and helping to reduce data sent
 across the network.
 
 An important Scalar concept is the enlistment: this is the top-level directory
-- 
gitgitgadget

