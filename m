Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B9C6FA90
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 06:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiITGVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiITGVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 02:21:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606855A3D5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 23:21:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b5so2559086wrr.5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=kLTuvZ7Rf9iC7i2if+7nmsEow9Ut8tzT1N5q3rsdopo=;
        b=Woj9wSpmi9G9oOEqriCF3xnHRVzMYgm6cDZ+G9/d9s6ybIX23bXnb8HARDXbjDzynp
         WqrzJ0EG2SEOQAKuPQSOtFLV6uKxeMbRtgnUgdMCTHKTuKjtQdS64iSAZhI78KgAD7ne
         9E7ErSbEzfjP6Xa9hr8fgWTEKqE5okqgk43mglEuhHWsZo+Q1ZPLFT8OHrnFwFv+WQcf
         6iCWBbAAdsMMN5FRSyTfEVK9Jra4LebOcuD+YmSh4u3+gUNccN0H1OT68CpPF4bwFfXg
         5Gh2kYJcPn7h6VpG7t+L8l26z2Q/dvVHJBgaVhtduUqTW0BljevixpZL2raQ6nXwRZYt
         x4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kLTuvZ7Rf9iC7i2if+7nmsEow9Ut8tzT1N5q3rsdopo=;
        b=5sLjdJx2Ehh7GRde+8/HhEoMJN4G00hBbT74ZPetu7D+ULbiE6r3wkCzfemHbJ//q8
         2ij2fBzXbRu2qIROufBNDzH1ucNl57107/2Xbj4tEhJwnQV+JaoeZbTX/tU5CTls6+XU
         fuT/jU80iX41hq5XfhNP2qhp21Gbp8cIByLFbFVFKvHAHli5gKHtNyoK9Z67YpbiRQc2
         RnRrV2CyfNrGC/HZ/Q0QIZKhX+99whTalcsPsO3PTfWlGYbAWLMKmgDqeLSPB/TKhvL3
         uDFi3ptcgMbbQJ5S1UfypR7+y1ePBgTM44SThC8skBsXFZyKMiX/iiLAbV8mAFfHiz4Q
         fDjA==
X-Gm-Message-State: ACrzQf0Eeh0ccUNN7msIC1Kd06kAE2GxN5T0AwrJ73Yezx7Y4YKxd4c+
        lGbV39hWobHpXopZWzt8sYY27cNL/GM=
X-Google-Smtp-Source: AMsMyM7eTEomdEm/EL1Rs6bp7TMwTgRjvT9dyRV50J3u9HM1gte1yWEuTaOxl1kDIX3RmULXskYKmg==
X-Received: by 2002:a5d:4acc:0:b0:22a:dcfa:4d93 with SMTP id y12-20020a5d4acc000000b0022adcfa4d93mr12577210wrs.614.1663654861734;
        Mon, 19 Sep 2022 23:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003a2f2bb72d5sm19388147wmb.45.2022.09.19.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:21:01 -0700 (PDT)
Message-Id: <945508df7b6335cb419b2769755c484236538c8e.1663654859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
References: <pull.1359.git.1663653505.gitgitgadget@gmail.com>
        <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 06:20:58 +0000
Subject: [PATCH v2 1/2] patch-id: fix stable patch id for binary / header-only
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
index dd68281ba44..70bc1902e11 100644
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
+			/* don't do anything since we're only populating header info */
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

