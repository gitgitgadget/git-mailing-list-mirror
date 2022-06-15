Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356EAC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351538AbiFOXgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiFOXf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:35:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E51B79C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so7069607wmn.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XiVF6nIhCq/TCqZicNwCBbpD/oTYFMdBLjrfs+dbp60=;
        b=aVCK/yG8xDekyK2fP9/2nlggV4CQ/8DTJjBGKIsBjuXqOUFgSeVFuchWepnknEJbDL
         2nDmSSs80E0YPLTHIhkECTpSr8WP+5oaC6HEyzk0esx/hGpW+LJJ5e1mhPRASH2rsUZT
         TEKzQucEM2IA+rVCUN5JLk+TLYQDYhHr9kcsHoPg/ZbLkfHtGZu9FKbPry+ATZeP6Jgi
         vF0yrKh4FF8yB2K/sQfJmyVrCruARnQZuRpPM6A1+PtKUR6hwXgXN/dxQjlTEJFtsarU
         vLDMNs5yuGIDrJFEdacGR6o3rr4fw3HFB9Rz0GAUkQoCtkopskw7EFhaO5iZ4LcTMJhf
         vE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XiVF6nIhCq/TCqZicNwCBbpD/oTYFMdBLjrfs+dbp60=;
        b=Kkzw0UTbeUJJZaxdDGLjJuVtVNnJ8YONbgiHdwV+l0nZdqHt/y3/yLLc2HHIU8QBGc
         XxBiFaDKsB2FXC7oJ2aqc5Mxn6yVmtiJRS61lZe90p7h0h4CQPxsI5lFnFi+ldYUNFcR
         p9qTKs06CNPEOM0jQV97ooheSJqwCOfAPqTolSS+p/tQ4nw2k4uixVRoVTjH8R5Bhr9S
         sT8rjHvCxAGQWUg49Nkt0u6szSUu1P71EoHydC2mTiXqik4sQbjZXkOcJ74lC5nY7JaZ
         yb7UB64DwGzQPNDRO6QhrDahmDbSfm6N4dDvdTV6nOrAtGJ3DJ9YgImiuid4vGqLE+l5
         9xuQ==
X-Gm-Message-State: AOAM5322cAQvcZc2MxJYt3EUebC7STMEczwxNpCWnviiACxeW9V7pSTT
        loRVBZhfi/rAKQWCmCwBkK67uHOZfXTrHA==
X-Google-Smtp-Source: ABdhPJwyCPRNZZfa8Hq489t4MGMF+ZP4ZYNm8Bg7JYs1tx+MXHlnJhQP/spNNdW0xBqWl3UoyZI3PA==
X-Received: by 2002:a7b:c777:0:b0:39c:4e1d:fd27 with SMTP id x23-20020a7bc777000000b0039c4e1dfd27mr12307993wmk.1.1655336153768;
        Wed, 15 Jun 2022 16:35:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b003971fc23185sm4386235wmq.20.2022.06.15.16.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:53 -0700 (PDT)
Message-Id: <877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:37 +0000
Subject: [PATCH 03/11] submodule--helper: avoid memory leak in
 `update_submodule()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5c77dfcffee..d7b8004b933 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2512,6 +2512,8 @@ static int update_submodule(struct update_data *update_data)
 
 		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
 								  update_data->prefix);
+		free(prefixed_path);
+
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
 		oidcpy(&next.suboid, null_oid());
-- 
gitgitgadget

