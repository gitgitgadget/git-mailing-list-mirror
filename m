Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67AC761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjC3P3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjC3P3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:29:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942AD333
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:28:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so8217943wms.5
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680190084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RPMJlXRQj3obpdviN0zME11xRBIlROo/wnFgFHROyBQ=;
        b=SZOp37/BbvUlzkoADePnIvqpgW6AQ0xQPWG1Dx71/a7pnReq6Z3Y+ljI6VwOBnAHb/
         F7xyU5xS3y9pB9Nkoi2Z3ZEPfz1Do/1BxR2OpyTfh7H0mPvlU7RY1lS+CeR//GAOMIbM
         GG8ZOMq/kN6zjw1/wvQ19G+0WqSNommgMsfahdnKk+ZlNnigezCl0PRDYf8olnPU4fdp
         mb26q3t7/gnN+vM6ZdEA6gqX7Ix1aTBW+NbTBjbQ5N8Xk8Lk2DKXpGG5LdaBY7ZWK3E7
         5BEhhxy4qytQjqT/hmZi6id81VIPz6rWPJCtq6+fMZgyzuCPFVnRXs1Y/1UqB01BCew/
         a9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPMJlXRQj3obpdviN0zME11xRBIlROo/wnFgFHROyBQ=;
        b=qQHGFl6l3PicNQXnGPl4ryzAMPt2BCrQ4xGhGPST1wIsQhO+PXpg+osar/Ny34t9Ap
         18ysbcjRIv1rKJ4IKFfbXmpmvuUBofuqrxQM0Og2nFv4mCjKfoYT5vduEPRYVgI4UEFo
         WQkkZEMuRglThnnAlpphKgja9V7hZkWU302lhrhcDX6+sN9GXNpPUf7sdd12khUGex47
         G9JF6kkWHTqPXKsQB26oov/Z97AjZaQTS9Inw15j2F12AFTxHiRtmx7wEBL0X6dLLdp7
         vjrk34/Lz4qh4+g9p4aRdsNBsb8IyQF0REif19EiDH0tImi2O1QH7AmDsTGKQk+uh3ec
         1joQ==
X-Gm-Message-State: AO0yUKX7h9w/s08qQyy1Rb5wygXtrX3iciSeIRsctkGvBLddhVyQENES
        UAwI25USEpuG7yaMJHpeWiVquvc3Ugs=
X-Google-Smtp-Source: AK7set+Oy/EORNaapwBSwk3NBZThAKq+hZKDRxfrvaN7SgWIrAZiNOMIR2O6uu+isIyKa90+PUO4XA==
X-Received: by 2002:a1c:f201:0:b0:3ee:6d55:8b68 with SMTP id s1-20020a1cf201000000b003ee6d558b68mr18094610wmc.37.1680190084459;
        Thu, 30 Mar 2023 08:28:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003ed1ff06faasm6132152wme.19.2023.03.30.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:28:04 -0700 (PDT)
Message-Id: <pull.1506.git.1680190083688.gitgitgadget@gmail.com>
From:   "Siddharth Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Mar 2023 15:28:03 +0000
Subject: [PATCH] hashmap.h: fix minor typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Emily Shaffer [ ]" <emilyshaffer@google.com>,
        "Jonathan Tan [ ]" <jonathantanmy@google.com>,
        Siddharth Singh <siddharthsingh3099@gmail.com>,
        Siddharth Singh <siddhartth@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Siddharth Singh <siddhartth@google.com>

The word "no" should be "not".

Signed-off-by: Siddharth Singh <siddhartth@google.com>
---
    hashmap.h: fix minor typo
    
    Hi folks ! I'm Siddharth from Google, I'm working on libification of
    Git, while going through the hashmap.h I found a minor typo in the
    documentation comment.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1506%2Fs-i-d-d-i-s%2Ffix-typo-in-hashmap.h-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1506/s-i-d-d-i-s/fix-typo-in-hashmap.h-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1506

Hi folks ! I'm Siddharth from Google, I'm working on
libification of Git, while going through the hashmap.h
I found a minor typo in the documentation comment.
---
 hashmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hashmap.h b/hashmap.h
index 7251687d730..e2cf9c78d84 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -270,7 +270,7 @@ void hashmap_clear_(struct hashmap *map, ssize_t offset);
 #define hashmap_clear(map) hashmap_clear_(map, -1)
 
 /*
- * Similar to hashmap_clear(), except that the table is no deallocated; it
+ * Similar to hashmap_clear(), except that the table is not deallocated; it
  * is merely zeroed out but left the same size as before.  If the hashmap
  * will be reused, this avoids the overhead of deallocating and
  * reallocating map->table.  As with hashmap_clear(), you may need to free

base-commit: 8d90352acc5c855620042fdcc6092f23a276af6d
-- 
gitgitgadget
