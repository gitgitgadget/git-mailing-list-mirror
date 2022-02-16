Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F7C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiBPKP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:15:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiBPKPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E9985B0
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so3349591wme.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k23/a9nt/ZYATWx2JICPY6A4IE4l7D2RC0453hEVPkg=;
        b=YrspewrQTl/yx4e7SelMemYOnyjpKUVzxqyXurJC2HztArf8TdK87Pouv2OQEPF/i2
         JUYi5Rm7/oPkLfgy7lHxZjOUsZ+RHXXggPJBiKvzCUJXYjTzEsqMegYMZYZvqCFi7UvS
         cRQeaeBfMEkieXYtjkOMYyodFYzEsZPVD93cA1YXIGO+kXSeDl/aJZWY/x/Qq4CxHwTH
         eKnULdI7Uo9f2qxWtjPVtzUoKL0xMdqxEXUrQJi1voFKNj3upJ0is13swoCB4kA6hXw0
         S13uw5+n3IpTzSztQx3WpZ16ozTh6fgOaV7Y7+KSugdlyPDfuNtmmt8F6xgf0jQEw6ls
         In7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k23/a9nt/ZYATWx2JICPY6A4IE4l7D2RC0453hEVPkg=;
        b=t/4LibIYLCn+HQd26AISR76qfh5nSIu4Vq/fMaf7UDL1TakfGgCpqZ5X5/++JTPcAy
         B/E+rykBq14OaMcltp/46wpLzhi1syGEqGznxC7JTEGo/hR664POsDi/LG+xMBY+Gf0I
         +WN/qI20xNk1hudpQl2aWhfFIZtZbDHWQC3Dyt1dVo83wMGyJm97VRegEBzYEe1kzsb+
         Rv28JFXG6ky1cHcD0OnMLCXnAkJGD+3W0rxWhFE8g54KVPZk75EphFkRp7JwjZbEpjng
         3W6V3+p1pDzELd2zCmnkizWn4yAxSl1xplitxTdf7uSck0JblW4V0gUHykbjbGtFdZlH
         hDGw==
X-Gm-Message-State: AOAM532IfUE7ZqwyG2KDjFrlzgKkGN4xC6Tq8H2vgndnpSpDynBP7rnX
        Yt7+RLfXDubk38v4ooTN0/9DouNlnyE=
X-Google-Smtp-Source: ABdhPJwATBoAhPGMotCb3mx422lFNbsQU4LEadwWvg2/hUE4iV6SxersHp3/2VbfX4MKf/q8dSLduw==
X-Received: by 2002:a1c:544d:0:b0:37d:1bdf:d26b with SMTP id p13-20020a1c544d000000b0037d1bdfd26bmr858988wmi.79.1645006512076;
        Wed, 16 Feb 2022 02:15:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm6045804wro.104.2022.02.16.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:15:11 -0800 (PST)
Message-Id: <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:15:06 +0000
Subject: [PATCH v2 1/4] xdiff: fix a memory leak
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

Although the patience and histogram algorithms initialize the
environment they do not free it if there is an error. In contrast for
the Myers algorithm the environment is initalized in xdl_do_diff() and
it is freed if there is an error. Fix this by always initializing the
environment in xdl_do_diff() and freeing it there if there is an
error. Remove the comment in do_patience_diff() about the environment
being freed by xdl_diff() as it is not accurate because (a) xdl_diff()
does not do that if there is an error and (b) xdl_diff() is not the
only caller.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xdiffi.c     | 33 +++++++++++++++++----------------
 xdiff/xhistogram.c |  3 ---
 xdiff/xpatience.c  |  4 ----
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 69689fab247..758410c11ac 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -315,16 +315,19 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
 	diffdata_t dd1, dd2;
+	int res;
 
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
-		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
-
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
-		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
+	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
+		return -1;
 
-	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
+		res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
+		goto out;
+	}
 
-		return -1;
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
+		res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
+		goto out;
 	}
 
 	/*
@@ -359,17 +362,15 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	dd2.rchg = xe->xdf2.rchg;
 	dd2.rindex = xe->xdf2.rindex;
 
-	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
-			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0, &xenv) < 0) {
-
-		xdl_free(kvd);
-		xdl_free_env(xe);
-		return -1;
-	}
-
+	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
+			   &xenv);
 	xdl_free(kvd);
+ out:
+	if (res < 0)
+		xdl_free_env(xe);
 
-	return 0;
+	return res;
 }
 
 
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 80794748b0d..01decffc332 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -372,9 +372,6 @@ out:
 int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
 	xpparam_t const *xpp, xdfenv_t *env)
 {
-	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
-		return -1;
-
 	return histogram_diff(xpp, env,
 		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
 		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index c5d48e80aef..e8de8d150ce 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -373,10 +373,6 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 int xdl_do_patience_diff(mmfile_t *file1, mmfile_t *file2,
 		xpparam_t const *xpp, xdfenv_t *env)
 {
-	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
-		return -1;
-
-	/* environment is cleaned up in xdl_diff() */
 	return patience_diff(file1, file2, xpp, env,
 			1, env->xdf1.nrec, 1, env->xdf2.nrec);
 }
-- 
gitgitgadget

