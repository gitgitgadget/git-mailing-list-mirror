Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC077C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiI0OIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiI0OIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561CC1B86A2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id iv17so6606504wmb.4
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=aKl3Onov2T+8/sArHI5L+UWHBu2/fNKV1f04cjJ7KEY=;
        b=DiBEMqn9HYN7jlv4LhZx4c8HRafdDgf54tCEXHGpEsMTgOWskQL3rjeA986Y632hQ0
         8WALz2bHUE77kJo34YI1NP6Bm0DWB+1GY4BxZ+LETRTh8cZD4cXeCDNfDzkijEvDiozX
         xjXHwuX6xumVcJUvrHwazmfEoXrFHYdC9/fF/m0+GzRSgrrLXlS08pijSUCMlgEOjVf5
         A1pnXs9XtIh53q/Z2p4DaowlWLkJfBhsQtUyflrU/iUGwucoZ07PJaoIk4D+0Q2L93Ef
         WYbfvvhN53HanLOuk6AfKFOGpI8ZhknUztJ2vvWq9w0Bksq1Zj9UtnwKFEayjz2ATfK/
         3RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aKl3Onov2T+8/sArHI5L+UWHBu2/fNKV1f04cjJ7KEY=;
        b=G178eFD2beaP8qPDJgrfTRllkaVVHa7augBpaZ07kBOYjJiQaqpK0zHJyR7qtcUYcS
         /hFS5mVREhCQeEyNxEI4ayaxD58f66D0Q/dRgwGUcPQRvoG2k4nN+9fN71NK1YXRtgSn
         gecwvHtZJ+XdZ/XS9V/kkmtMx7lzp3twzC9C/e5qW4E0q8DS7nv80Uih5rL3Ez3mtRRu
         FOS+E+W2jZbt1SV/Bt6mOiq7rGeKqFYYfvFOm9B2/AbA4MOcDZftUgpboNq/wfaX2vJY
         uPWLwEMmaI/h5st/0Z1eF0gUPnmRQwh/I36ZiUKNL19v+3srg5v2/m+3qBwqtxi8ctgt
         piyQ==
X-Gm-Message-State: ACrzQf1NW5hVgvecBsQUQTakRg5XY8MZNFkG7v2gC8UzS0c2rR+THrbp
        CSjKwafk2gx32ql9cLls8M/LopwR7Ps=
X-Google-Smtp-Source: AMsMyM7mOjZry1q2tc1Pc3WsOlWorUYSEFzl1Uno89y0cZ4y9P9bb+kLNvGJ1MywMmYJyd2ncM0bhg==
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr3014436wmq.157.1664287713913;
        Tue, 27 Sep 2022 07:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk9-20020a0560001d8900b002252884cc91sm1963790wrb.43.2022.09.27.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:33 -0700 (PDT)
Message-Id: <b2558a737f31465b38ad361a412d923ef186a38a.1664287711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:27 +0000
Subject: [PATCH 1/5] config: relax requirements on multi-value return
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The git_configset_get_value() method has an assert() statement
guaranteeing that the result from git_configset_get_value_multi() is
either NULL or has at least one element. We want to change that return
to provide an empty list instead of a NULL list, so change the earlier
'return 1' condition to care about a NULL or empty list.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index cbb5a3bab74..bf89afbdab0 100644
--- a/config.c
+++ b/config.c
@@ -2407,9 +2407,8 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	 */
 	values = git_configset_get_value_multi(cs, key);
 
-	if (!values)
+	if (!values || !values->nr)
 		return 1;
-	assert(values->nr > 0);
 	*value = values->items[values->nr - 1].string;
 	return 0;
 }
-- 
gitgitgadget

