Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA1AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiBPKPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:15:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiBPKP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98B1BE062
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v12so2628513wrv.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UfWdj/2T0vGo78iWFHoh4nkFyc6mFt6U4riKUx33tuI=;
        b=AuzkpUBKhiF/LG8f3Vkbw3cnjl4hhLR9nZK+mP7NM2hnVizlKn3ldZYTux76V4FVMd
         SnPxdl/JcGzjfA5b1LXYlakD6mxqLl7hJbMoMHim/bjO//wHFj34yPFf+ZRIrtPnuYJx
         cZVnuMshYG607Zs0T1IMSCBTLYTcj41QzPzXyEFgW3RkNOCBwgO0KngiX06Lij7zEo/+
         vGe6SY7a3N6vTX+zIEoax6tgd79qFwVdS21RzyhbsJRKWg9c4AbfqU3NTCK6nHIymOZR
         WhDsIRvgkDgMvBxRQw2DZyEQTTN0+EGIZp8VqF9IKsNRzPSHnruxwH8olD5s2+a1rUnD
         g8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UfWdj/2T0vGo78iWFHoh4nkFyc6mFt6U4riKUx33tuI=;
        b=r9SDgbZDqg0kAOt4tTe3GFGBjBssJqzw8WYpVbQU9mATE4Vtk7sC1jJgEmP8racRZB
         70LaMIgkIcFcmLEnkeVKFd9Y2VB3TxRZFivAN7VRZ3CkPM8sX3Akl4qfIBCi37zeisfj
         CNlD3qptjc857LmnoUjrkLXppMaequ5JX3BZZc0sOL585phXaxjvc7Osr9a/XeY4qVjP
         xiZbbDx9XMzAm3ZJQBqKoI5pHwez4w3jHY4AiyiO/YRGe2IZAAdS03djz950aKDRteri
         q/sVJkYiZ+f+u0QfQUxdlVoCXDKUySVEHJXqsSk3dE537Xo63Nbqy/QbQGCRKr4OPnaI
         KBqA==
X-Gm-Message-State: AOAM532D4iZhHuw93lXV6AK8zRV0ieoYIkYK57J/RXWlPrzFGjlTNYuw
        3VXcosJnwdF4/+Zn+MeoRtucwg3z9ng=
X-Google-Smtp-Source: ABdhPJzmqrPAfpGS1v7wLmIKDf80na3lYf7IEP6BTpkZDWPcPbwaUEP9WCYkZP08qZ6EJ/B4EkbegA==
X-Received: by 2002:adf:ebc1:0:b0:1e6:1109:5a1c with SMTP id v1-20020adfebc1000000b001e611095a1cmr1791699wrn.228.1645006514163;
        Wed, 16 Feb 2022 02:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm17719767wms.4.2022.02.16.02.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:15:13 -0800 (PST)
Message-Id: <073a45e9e8563686b43cb4f9beb4295523fb797f.1645006510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:15:08 +0000
Subject: [PATCH v2 3/4] xdiff: refactor a function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use the standard "goto out" pattern rather than repeating very similar
code after checking for each error. This will simplify the next commit
that starts handling allocation failures that are currently ignored.
On error xdl_do_diff() frees the environment so we need to take care
to avoid a double free in that case. xdl_build_script() does not
assign a result unless it is successful so there is no possibility of
a double free if it fails.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmerge.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fff0b594f9a..d43abe05b95 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -684,35 +684,30 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, mmbuffer_t *result)
 {
-	xdchange_t *xscr1, *xscr2;
+	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
 	xdfenv_t xe1, xe2;
-	int status;
+	int status = -1;
 	xpparam_t const *xpp = &xmp->xpp;
 
 	result->ptr = NULL;
 	result->size = 0;
 
-	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
 		return -1;
-	}
-	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
-	}
+
+	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0)
+		goto free_xe1; /* avoid double free of xe2 */
+
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe1, &xscr1) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
-	}
+	    xdl_build_script(&xe1, &xscr1) < 0)
+		goto out;
+
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe2, &xscr2) < 0) {
-		xdl_free_script(xscr1);
-		xdl_free_env(&xe1);
-		xdl_free_env(&xe2);
-		return -1;
-	}
+	    xdl_build_script(&xe2, &xscr2) < 0)
+		goto out;
+
 	status = 0;
 	if (!xscr1) {
 		result->ptr = xdl_malloc(mf2->size);
@@ -727,11 +722,13 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 				      &xe2, xscr2,
 				      xmp, result);
 	}
+ out:
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
 
-	xdl_free_env(&xe1);
 	xdl_free_env(&xe2);
+ free_xe1:
+	xdl_free_env(&xe1);
 
 	return status;
 }
-- 
gitgitgadget

