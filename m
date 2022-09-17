Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323FECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 04:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIQESr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 00:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQESp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 00:18:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFC895EE
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 21:18:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so38891947wrm.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=4j+HtQvOoX3Yci3VWxqqhis7SfRkRu3xO/nBdC4vlWI=;
        b=Os7JngUEqnSD9qBRjgJyjXyv48CcIAQWMYtdBE/c44NMVDPVTAq7vqofm/rQo7iNWv
         n6SfyL4xF6uhH3cy2z+rjBreoxoQDnpKCHAEuKCHC2cJS50m7DOyz6fwlyM4vSTTfTVi
         2ATSI/A23iGkjPz0vv3i/8BkIqnuL9UpzR6b0PHdcPv7kCNfgRecsMb/C6kycSgNvvnG
         DVdHa6EklsLkmZR/vx5ooJMkChF4Tf8LwKd8vLAKdrYvBldYNpOaRA+Sw3D03nzQ3f4x
         sjoG7YNQHphocKpSooPjtFlYsvOGzT1vU7yDKQFrGZL1z8F9+5FDogIdhZni5Zhlugg9
         AIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=4j+HtQvOoX3Yci3VWxqqhis7SfRkRu3xO/nBdC4vlWI=;
        b=JUFsrdgKV2idNkA+fZAdjLOmoI1JTamSkwj3g/QpqSST+T81JEfsjp/PnsLDVMMyG7
         3J9r3E++ubn86bYlCcevru8ZDXlzGZadd9438VWFmlUGA34xyYzaApFF4C6UINLpLlxK
         tt42syauiad3shM/Ymh3U8K1hLIM6J1YcGQluSZaLq/4K3WhvguQRE/QsPrhLAkLM+1g
         Ya80jdfg/tikyAO82aNxN4mqcnanLxTYAM3cUMCasPAZp/duDZfsxeF1oae+DKecPMEC
         LPIf+x5S50bWJQGksinPkR7Tn56F6HLhw13jL5+Oco0/wZn6Ka0bnwp91IIe29NjdWSX
         hvVA==
X-Gm-Message-State: ACrzQf1sw4z/vfqCqZk4Ij2HlTcfmcsaDmddA0reBYKTYh4ZhMZ8TGk7
        MhMF8Jr3U4jAuiktT5XNuLMOX+t7VZA=
X-Google-Smtp-Source: AMsMyM6meMc/b5+GeUNSEFzhIBA1BAX5jqPCLU8OyDytw7EXG+ToSMD6seFjpPXWxcZ5Gi8NxTzJIg==
X-Received: by 2002:a5d:49c8:0:b0:22a:35a1:1755 with SMTP id t8-20020a5d49c8000000b0022a35a11755mr4490346wrs.180.1663388321853;
        Fri, 16 Sep 2022 21:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg39-20020a05600c3ca700b003b47b913901sm9763940wmb.1.2022.09.16.21.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:18:41 -0700 (PDT)
Message-Id: <pull.1333.git.git.1663388320380.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 04:18:40 +0000
Subject: [PATCH] unicode: update the width tables to Unicode 15
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Force Charlie <charlieio@outlook.com>,
        Force Charlie <charlieio@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Force Charlie <charlieio@outlook.com>

Unicode 15 Released[0] and including several additional zero/double
width characters.

[0] https://home.unicode.org/announcing-the-unicode-standard-version-15-0/

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
    unicode: update the width tables to Unicode 15
    
    Unicode 15 Released[0] and including several additional zero/double
    width characters.
    
    [0]
    https://home.unicode.org/announcing-the-unicode-standard-version-15-0/
    
    Signed-off-by: Force Charlie charlieio@outlook.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1333%2Ffcharlie%2Fupdate-unicode-15-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1333/fcharlie/update-unicode-15-v1
Pull-Request: https://github.com/git/git/pull/1333

 unicode-width.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 97c851b27df..e15fb0455bb 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -94,7 +94,7 @@ static const struct interval zero_width[] = {
 { 0x0E47, 0x0E4E },
 { 0x0EB1, 0x0EB1 },
 { 0x0EB4, 0x0EBC },
-{ 0x0EC8, 0x0ECD },
+{ 0x0EC8, 0x0ECE },
 { 0x0F18, 0x0F19 },
 { 0x0F35, 0x0F35 },
 { 0x0F37, 0x0F37 },
@@ -228,6 +228,7 @@ static const struct interval zero_width[] = {
 { 0x10AE5, 0x10AE6 },
 { 0x10D24, 0x10D27 },
 { 0x10EAB, 0x10EAC },
+{ 0x10EFD, 0x10EFF },
 { 0x10F46, 0x10F50 },
 { 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
@@ -252,6 +253,7 @@ static const struct interval zero_width[] = {
 { 0x11234, 0x11234 },
 { 0x11236, 0x11237 },
 { 0x1123E, 0x1123E },
+{ 0x11241, 0x11241 },
 { 0x112DF, 0x112DF },
 { 0x112E3, 0x112EA },
 { 0x11300, 0x11301 },
@@ -313,7 +315,12 @@ static const struct interval zero_width[] = {
 { 0x11D95, 0x11D95 },
 { 0x11D97, 0x11D97 },
 { 0x11EF3, 0x11EF4 },
-{ 0x13430, 0x13438 },
+{ 0x11F00, 0x11F01 },
+{ 0x11F36, 0x11F3A },
+{ 0x11F40, 0x11F40 },
+{ 0x11F42, 0x11F42 },
+{ 0x13430, 0x13440 },
+{ 0x13447, 0x13455 },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
 { 0x16F4F, 0x16F4F },
@@ -339,9 +346,11 @@ static const struct interval zero_width[] = {
 { 0x1E01B, 0x1E021 },
 { 0x1E023, 0x1E024 },
 { 0x1E026, 0x1E02A },
+{ 0x1E08F, 0x1E08F },
 { 0x1E130, 0x1E136 },
 { 0x1E2AE, 0x1E2AE },
 { 0x1E2EC, 0x1E2EF },
+{ 0x1E4EC, 0x1E4EF },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
 { 0xE0001, 0xE0001 },
@@ -417,7 +426,9 @@ static const struct interval double_width[] = {
 { 0x1AFF5, 0x1AFFB },
 { 0x1AFFD, 0x1AFFE },
 { 0x1B000, 0x1B122 },
+{ 0x1B132, 0x1B132 },
 { 0x1B150, 0x1B152 },
+{ 0x1B155, 0x1B155 },
 { 0x1B164, 0x1B167 },
 { 0x1B170, 0x1B2FB },
 { 0x1F004, 0x1F004 },
@@ -451,7 +462,7 @@ static const struct interval double_width[] = {
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
 { 0x1F6D5, 0x1F6D7 },
-{ 0x1F6DD, 0x1F6DF },
+{ 0x1F6DC, 0x1F6DF },
 { 0x1F6EB, 0x1F6EC },
 { 0x1F6F4, 0x1F6FC },
 { 0x1F7E0, 0x1F7EB },
@@ -459,15 +470,13 @@ static const struct interval double_width[] = {
 { 0x1F90C, 0x1F93A },
 { 0x1F93C, 0x1F945 },
 { 0x1F947, 0x1F9FF },
-{ 0x1FA70, 0x1FA74 },
-{ 0x1FA78, 0x1FA7C },
-{ 0x1FA80, 0x1FA86 },
-{ 0x1FA90, 0x1FAAC },
-{ 0x1FAB0, 0x1FABA },
-{ 0x1FAC0, 0x1FAC5 },
-{ 0x1FAD0, 0x1FAD9 },
-{ 0x1FAE0, 0x1FAE7 },
-{ 0x1FAF0, 0x1FAF6 },
+{ 0x1FA70, 0x1FA7C },
+{ 0x1FA80, 0x1FA88 },
+{ 0x1FA90, 0x1FABD },
+{ 0x1FABF, 0x1FAC5 },
+{ 0x1FACE, 0x1FADB },
+{ 0x1FAE0, 0x1FAE8 },
+{ 0x1FAF0, 0x1FAF8 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
