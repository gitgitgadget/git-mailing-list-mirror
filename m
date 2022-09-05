Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E3BECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 14:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiIEOej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiIEOed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 10:34:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81DBB2
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 07:34:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c11so7390780wrp.11
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=8D5z0jZR7gDgIGM6PjJgrcQxhsLX4i4p44w362X4Cqo=;
        b=VCLJtfx+BUoex4sQ5aVNzw59y/sXnxgyin9xm17uT6m4I/9HscGTork6Ebfhq1PZCV
         s/AoV69df74dou5A7UyrL73BujW3veL7siznY4ToAG2q/k+TX6i9StFjKJsU50CGVeZw
         EMPwflJzky0ZJWiWKbqBYDa1wq3s3J09caCogYYbXBkAs6z1guJ473C2D1B/rZa6Igqs
         WsjQP1t9Hs6/jcas/gL+VGUs9kpiY9B2r2nX9lW7F4cX8VhxZjELwXbo9TkPMSUTAwVM
         IBGhR/1qhbDnQqLAQZ0f+JZJn6itSrs+lQNuP0L0JV1uFNPqGIdS4GMG313AvdFTJK/1
         PHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8D5z0jZR7gDgIGM6PjJgrcQxhsLX4i4p44w362X4Cqo=;
        b=rDs1iOv/EDoUJEfsBPfppPGTzpQOmSvpPfw6gfclExem38jUxVw1NbTecFwk3lxL8x
         cLZwja5kTMcKpknGwcOekx8kMl1EA6xBTCzvxb2kl4MZdg3H2lSCLiUvgGLgXfYyyVh5
         19+wAChX7QX98prC2VcnPyKEw6FsmnY7CZZylRqYyBFSqaxEh3VMHKYdqRvv/VRvcioj
         Pe/S399r3XsRUouGHhhH4+HWweklUtYk9mxI3UeDBd+zwkTN6XGViIqqALUr5eCZrPyS
         aTNwsRITA2oDbgz82rUlj38cTQ4x0tzEpjN1Yr71nhb8ul9LXyWNmVE8s/5NE9ZQLEBt
         5xzg==
X-Gm-Message-State: ACgBeo2cgjCGGGYWeXCDPCZvho75JW52uX8YfPKhNSEHzFG/r+ieIAI4
        UXcNKk/WFVq3xPKusX0aBUGrOKDqyNw=
X-Google-Smtp-Source: AA6agR6LRRLbWVZmSbpGocYpWq+bBWLSFcRULxr6AyV08thkeOkfGRq1q5aNkx/ebmstXb8LGMMY9g==
X-Received: by 2002:a05:6000:1f83:b0:228:6278:796b with SMTP id bw3-20020a0560001f8300b002286278796bmr5240164wrb.520.1662388461708;
        Mon, 05 Sep 2022 07:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020adfeec8000000b00226d1821abesm8884442wrp.56.2022.09.05.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:34:21 -0700 (PDT)
Message-Id: <aaa2f3ec3139a7a48001d1d0357c302d0dc68780.1662388460.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Rub=C3=A9n=20Justo?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Sep 2022 14:34:19 +0000
Subject: [PATCH 1/2] branch: refactor edit_description command switch case
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>

Minor refactoring to reduce the return exits in the switch case
handling the edit_description command, so the calls to strbuf_release
can also be reduced.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e998..5229cb796f8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -614,7 +614,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_reset(&buf);
 	if (launch_editor(edit_description(), &buf, NULL)) {
 		strbuf_release(&buf);
-		return -1;
+		return 1;
 	}
 	strbuf_stripspace(&buf, 1);
 
@@ -791,6 +791,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		int ret = 0;
 
 		if (!argc) {
 			if (filter.detached)
@@ -803,19 +804,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
-			strbuf_release(&branch_ref);
-
 			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
+				ret = error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
-				return error(_("No branch named '%s'."),
+				ret = error(_("No branch named '%s'."),
 					     branch_name);
-		}
-		strbuf_release(&branch_ref);
+		} else
+			ret = edit_branch_description(branch_name);
 
-		if (edit_branch_description(branch_name))
-			return 1;
+		strbuf_release(&branch_ref);
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
-- 
gitgitgadget

