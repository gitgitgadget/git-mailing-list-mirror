Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39FC25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiHHN2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiHHN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB72A193
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n4so9139453wrp.10
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=r2kDf5GfPPgtHhXYHg1HscNJDVUfYeJJsSD9jO/tFqU=;
        b=Z7dyQsyrhCVuLGyD6xkRDSX7q2iPM8lpxWcobX9oGUfXz8YzZUZdhh6k7YD+Rflwas
         IHrP0qlSWap0ZSa1hMFj5R6QIwi+dEqQKs+yYSSaTvTGoAfblJTG5+AUAu/K1X1H4ZVf
         IMHPblcN6fOh9N3RxR5+DvUgUJe7rgof83//FQJ5TCVKR9NZiUBGfr3iI6eQLM45PtJg
         CvQzuPMei1lB+6HUfvbiJpSFEZE1I7K7WRO9BkcAB7kl7y6R/R4Gu9L41EwdvFMfdk6V
         BvbUELUavbbka/v3VKJFx2pzONO+zt+YHYduhVE6YIiki5h2/6LEGDGWyaSYaNXqYS9s
         pT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=r2kDf5GfPPgtHhXYHg1HscNJDVUfYeJJsSD9jO/tFqU=;
        b=ioE2oMiqOkVUhoRl4lMLfITT8wbKVNXo0Iv2AX3ievXo5U+jE9ajPFZ/wf+PGwFeuT
         u/yOUnWRtt/4c6zgoV3Z6QYLgjMW2UTmam991KtNzB7hd+cwKthfbgBn85FGk0N5b/ic
         47G1JipjYqGorMiXeWiegVxx0eon8dbgr6tb0XCjbfejSUV5agI+1BghEnIpjRAyzMl4
         kBmK4OqJTIRGUupIrHj9nqw/4Sf/IFBnyvts/eRYUgrCeFrhERGB2jhxgis1sW/85/K+
         SQt1CfiXUBLUreW7eDFQIP7jaCAv9FagvxD7cSc0munMRunQUJvl27sxToCTvhtXzpB/
         buOg==
X-Gm-Message-State: ACgBeo0O9/FhAfQ6dr0XTqQ1H6co6h9MgQArTrYIx6Xrk96g32XK+uSM
        EOGMpJogBE5xixeKjxT+OjMcvH+5Eh8=
X-Google-Smtp-Source: AA6agR4+/nXjRURXbob7DaSRJl1dFo1dyOmsfJtmufZg0ja5MYzDMCzOuSNM/5kqRap6OWgOP55lrg==
X-Received: by 2002:adf:ef8c:0:b0:21e:f504:6e54 with SMTP id d12-20020adfef8c000000b0021ef5046e54mr11423553wro.476.1659965272738;
        Mon, 08 Aug 2022 06:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b003a53731f273sm6065298wmb.31.2022.08.08.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:52 -0700 (PDT)
Message-Id: <301d94f18f501b44b6b96fd7c170134d4661be38.1659965270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:46 +0000
Subject: [PATCH v2 1/5] setup: fix some formatting
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

In preparation for touching code that was introduced in 3b0bf2704980
(setup: tighten ownership checks post CVE-2022-24765, 2022-05-10) and
that was formatted differently than preferred in the Git project, fix
the indentation before actually modifying the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 8c683e92b62..2f7b3e598f8 100644
--- a/setup.c
+++ b/setup.c
@@ -1142,7 +1142,7 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
  * added, for bare ones their git directory.
  */
 static int ensure_valid_ownership(const char *gitfile,
-				const char *worktree, const char *gitdir)
+				  const char *worktree, const char *gitdir)
 {
 	struct safe_directory_data data = {
 		.path = worktree ? worktree : gitdir
@@ -1316,10 +1316,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		strbuf_setlen(dir, offset);
 		if (gitdirenv) {
 			enum discovery_result ret;
+			const char *gitdir_candidate =
+				gitdir_path ? gitdir_path : gitdirenv;
 
-			if (ensure_valid_ownership(gitfile,
-						 dir->buf,
-				 (gitdir_path ? gitdir_path : gitdirenv))) {
+			if (ensure_valid_ownership(gitfile, dir->buf,
+						   gitdir_candidate)) {
 				strbuf_addstr(gitdir, gitdirenv);
 				ret = GIT_DIR_DISCOVERED;
 			} else
-- 
gitgitgadget

