Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC16C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 16:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiF2Q6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2Q6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 12:58:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBBD1EC66
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:58:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o16so23429411wra.4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7HJSB/MW+GkSUAynVvd56ZbaS7HaxOBFqSibX7gbNCs=;
        b=n6HZl/zzzqVQyDAtc8uOwjUQ4pM3g96kiAmKtGtQZuqyZ/IyCAHriixVzqKKHceDG7
         brCA/wTuHFJyahqD/JHcaEkM/cAoqBJANV70KDUfawG304GkW3Q354T9/fCBVXFVyUGr
         QNRVouvT1ztjO20gVL8SAZ2ZTAc9iWDXIZLW0P9c7EpE/TWxZ/tOb1Amf0yITeCLvCgq
         l8ob3FNd8Imr6PIzDsai4FIU0Yhc3OYzUqmr+AAOpncVQmVINdhy+1HmdsnqjOLaSTjH
         b8jDX52oZE1trI5oHS84yKLfmuqZS8hqZA1TU6iyU3tzCxP9NTQQfUOrGhu/s+QqWzC0
         QU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7HJSB/MW+GkSUAynVvd56ZbaS7HaxOBFqSibX7gbNCs=;
        b=p+YUqIT3DJ1kUWcVE9Uc2AqSLmWp+9YUx0cHtTa75CMr6nF2F+wvnFArXcsGz8jHF2
         7IVSb2wa6Wc/wg6o9CJ8HA5jHHb0kDQj7grv2DSlzMoBWPiuAGKH7LANC4gcNdUP3a8n
         KveZciBmaogsSWYbSFd2rvKvCPDkT2luNuKKUTUbv1fBteCAJ0R7oY9aLX95YftxyVga
         EQ759bH3r6f67TNhDnpJWXYBQX36NUu4yacHpA4HChx1CmTZ7RSwBHfWoCmHCF0vAbDf
         DHN5MDhqT/RTAmIH0XnqX5QdVTD8s3EsBAtxCLmNGKIT4/ZDtVY9cMSCYkEnMGnGDF74
         62DA==
X-Gm-Message-State: AJIora+FWqV2wi39AG+2OpZNtfK36CkvxW96IHn3/1Ydi05PwfUZpoFU
        SudWi5LHvtSXAELFbLfOWoRRLP5+oKbZEw==
X-Google-Smtp-Source: AGRyM1vnR+ScVQnWn9+kYh9Ln+YdylbOdGltHnYsO2WtlEX+WwYaeUz0vOMECUlOFUHbDIZG0JFWUw==
X-Received: by 2002:a5d:514b:0:b0:21d:2e00:9b9e with SMTP id u11-20020a5d514b000000b0021d2e009b9emr3051002wrt.485.1656521928976;
        Wed, 29 Jun 2022 09:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020adff4cd000000b002103aebe8absm17099958wrp.93.2022.06.29.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:58:48 -0700 (PDT)
Message-Id: <38c0b4dff90f44687590c3686d664599c712417b.1656521926.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 16:58:44 +0000
Subject: [PATCH 1/2] scalar: reword command documentation to clarify purpose
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

