Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348CC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiITF7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiITF6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:58:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D012ED70
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g3so2419778wrq.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=HJArE7AqUCuPS4LQ6OV0W24AhaNle60ph0wfG/kXAls=;
        b=HQ5NFXIbTjnDHsUfadb4NlIQqzyIoOawCvfb7K2ddeH/vJLOFD6pF7QpvmQ2ItQgMN
         dPXOR1O6phmnyrrp1u4x4dsc36jVH/RTrL//wSJZCk08pOASzAVxVLIny3mn1JvfdvJJ
         oLpkMGdJzz4/rmdDFSb993fp7vma1z/rc2EYldes9MhRKrZq/7imUjQVTH1wfksR1bmx
         QSCDsC10//YpzsUyMt4CSHltWxXpceeO0BfNdkBZ/kBLKz/fbnvqYW7ltP7ZlFpf+qfS
         3yLxl2rre1IrL3A1b/zp4Cef/CZeNAuNKzrkMHsmxCrxF0idK/vzWX68ut1QNsy/vQCG
         AOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HJArE7AqUCuPS4LQ6OV0W24AhaNle60ph0wfG/kXAls=;
        b=Mzj8YZd60ZC7fJlf2LIXUCEWZ+QiaCAF2p1KAjKPeWr473sx+OR1HL5vPwGXIDPXKX
         OG+j62xWAqpr/RJdjtv2lsrz4YRu9dpAtNiYqFUKze5NqFN2wnrCYyZ43UIwE1E2StzS
         Y7SKS/Qa/v8XMi40h9UR0+eLl2GdAwjMz+x8lDPeONtQujUGombrGLXC8eUicFlGGeFp
         7iI+0fBkVW8ScwVvuwzvFcBgYhc2D/3qpTyVjmT1l07Riy0u4evsdJzM2kPBqNaTFHpU
         hzFfXPFJS3f11Rph2VV0FDHmf9rifMSMwgTdCC7Nt5sWWEwyKL/zmSFMRzrEyQ5P3mn5
         mJuw==
X-Gm-Message-State: ACrzQf2+e0ULhTIIw8i0UCLQY+JRZF+pXe/87bGxZ5CIbVNPVM+ptpPk
        av4AF24cdoM6dEoQIMRb97Kbe/lDLZY=
X-Google-Smtp-Source: AMsMyM6r9Xc+QIvHcHt85Zcvv/GI43HCSvifLtrAOql1Fv1C/8pnWdlp6gE2chM+vfoK6JtDrNHCCg==
X-Received: by 2002:a05:6000:178e:b0:22b:451:9f63 with SMTP id e14-20020a056000178e00b0022b04519f63mr3865434wrg.521.1663653507887;
        Mon, 19 Sep 2022 22:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ib3-20020a05600ca14300b003b341a2cfadsm928583wmb.17.2022.09.19.22.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:58:27 -0700 (PDT)
Message-Id: <82fe77c1ce0122423c6bd67ccbf472a3fc7f5c3e.1663653506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
References: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 05:58:24 +0000
Subject: [PATCH 1/2] patch-id: fix stable patch id for binary / header-only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

Previous logic here skipped flushing the hunks for binary
and header-only patch ids, which would always result in a
patch-id of 0000.

Reorder the logic to branch into 3 cases for populating the
patch body: header-only which populates nothing, binary which
populates the object ids, and normal which populates the text
diff. All branches will end up flushing the hunk.

Update the test to run on both binary and normal files.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 diff.c                     | 32 ++++++++++++++------------------
 t/t3419-rebase-patch-id.sh | 19 +++++++++++++------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/diff.c b/diff.c
index dd68281ba44..2f8f0c2e4f4 100644
--- a/diff.c
+++ b/diff.c
@@ -6248,30 +6248,26 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		}
 
-		if (diff_header_only)
-			continue;
-
-		if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
-		    fill_mmfile(options->repo, &mf2, p->two) < 0)
-			return error("unable to read files to diff");
-
-		if (diff_filespec_is_binary(options->repo, p->one) ||
+		if (diff_header_only) {
+			// Don't do anything since we're only populating header info
+		} else if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
 					the_hash_algo->hexsz);
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
-			continue;
+		} else {
+			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
+			    fill_mmfile(options->repo, &mf2, p->two) < 0)
+				return error("unable to read files to diff");
+			xpp.flags = 0;
+			xecfg.ctxlen = 3;
+			xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+			if (xdi_diff_outf(&mf1, &mf2, NULL,
+					  patch_id_consume, &data, &xpp, &xecfg))
+				return error("unable to generate patch-id diff for %s",
+					     p->one->path);
 		}
-
-		xpp.flags = 0;
-		xecfg.ctxlen = 3;
-		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
-				  patch_id_consume, &data, &xpp, &xecfg))
-			return error("unable to generate patch-id diff for %s",
-				     p->one->path);
-
 		if (stable)
 			flush_one_hunk(oid, &ctx);
 	}
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 295040f2fe3..f7b7e9e5b7c 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -46,10 +46,6 @@ test_expect_success 'setup: 500 lines' '
 	git cherry-pick main >/dev/null 2>&1
 '
 
-test_expect_success 'setup attributes' '
-	echo "file binary" >.gitattributes
-'
-
 test_expect_success 'detect upstream patch' '
 	git checkout -q main &&
 	scramble file &&
@@ -58,7 +54,13 @@ test_expect_success 'detect upstream patch' '
 	git checkout -q other^{} &&
 	git rebase main &&
 	git rev-list main...HEAD~ >revs &&
-	test_must_be_empty revs
+	test_must_be_empty revs &&
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	git rebase main &&
+	git rev-list main...HEAD~ >revs &&
+	test_must_be_empty revs &&
+	rm .gitattributes
 '
 
 test_expect_success 'do not drop patch' '
@@ -68,7 +70,12 @@ test_expect_success 'do not drop patch' '
 	git commit -q -m squashed &&
 	git checkout -q other^{} &&
 	test_must_fail git rebase squashed &&
-	git rebase --quit
+	git rebase --abort &&
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	test_must_fail git rebase squashed &&
+	git rebase --abort &&
+	rm .gitattributes
 '
 
 test_done
-- 
gitgitgadget

