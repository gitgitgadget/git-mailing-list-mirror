Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6574420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeLNVW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34320 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbeLNVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so3422037pfg.1
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=sSgi7TWLMDBJhhl1IklN8Oh/Yk3rtc7rO+siUvPrAfHcWF/z8mlRj4rbq502fGGoQW
         ChwpfYEo2o2frUooy5YANhQwsBthRrMkpMn12ty5rGvamEwlQPkF9rjXVed0JEa+VVis
         l+7Rpgsd89VzxzNlmAUHziUmsqcaLr9sxvoVFKQ8t5CZc6ADFNl34TuIKRsgbbsq2hzx
         xAk1Kom4cx/w3CiCpy7kB85kHrsCfw7VIdyAM0aCVkGcXAOTlhhm65J0fc+HTDusP+R4
         QiegG6lRkIPaiMEs4VvLw0w70FtYtphs9uPeIi5urZl9Cd0li8cyBaNd06XaEbVaTZvt
         ndGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=BLUlRsz5naPWat6bl/RUVMs9i15xAufkyD4VYVIkTgGteYPimPM022XtM2PWLeEZBU
         xqmZSq4YL2OA1oNVDCm7zKh9NLHcT8ZI3cJGL/XyGG57AaWIZo6TAQM5Uv8eCapi+Ibn
         0q5Z85KFNDSQcXzVpT5p24xkZj2j2PnTFkB55pxOW7qeHOQvyMREIOQuNXdSPb9XtJn7
         8vsgue5FlBFGTdE/aUjR2Hi3Hr4kOf+5QMDykY+5n3Wb+f9xLbLDtzsOoJdiIV/XlVd7
         hhVJNRq7IwmsiS3zwjonq1HB/yMVhFBVTUUaWZHlCzqFWSHOm7mQz4zs9kuKuetZx0dQ
         R4bA==
X-Gm-Message-State: AA+aEWaiWD3/lOJqplC7b1LVRNArOH7v+q5Sg/GnEgb6UNMTHykGWhrz
        pT1j3rF+Z6w32XYG/W1xPbrWBnyA
X-Google-Smtp-Source: AFSGD/XSNftgIE2Toj7hgpTpVc3F12k085liPsNxvuI6tcsihm6SjFcUHM/HHvNLhh86FsfEtld6PA==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr4376653pfg.248.1544822544421;
        Fri, 14 Dec 2018 13:22:24 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u8sm10023672pfl.16.2018.12.14.13.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:23 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:23 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:12 GMT
Message-Id: <d011a9c1b1c197fa1a77e924a50463a984efc0d1.1544822533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 6/6] pack-objects: create GIT_TEST_PACK_SPARSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Create a test variable GIT_TEST_PACK_SPARSE to enable the sparse
object walk algorithm by default during the test suite. Enabling
this variable ensures coverage in many interesting cases, such as
shallow clones, partial clones, and missing objects.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c         | 1 +
 t/README                       | 4 ++++
 t/t5322-pack-objects-sparse.sh | 6 +++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 124b1bafc4..507d381153 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3331,6 +3331,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
+	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/t/README b/t/README
index 28711cc508..8b6dfe1864 100644
--- a/t/README
+++ b/t/README
@@ -342,6 +342,10 @@ GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
 
+GIT_TEST_PACK_SPARSE=<boolean> if enabled will default the pack-objects
+builtin to use the sparse object walk. This can still be overridden by
+the --no-sparse command-line argument.
+
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 8f5699bd91..e8cf41d1c6 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup repo' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
@@ -70,7 +70,7 @@ test_expect_success 'duplicate a folder from f3 and commit to topic1' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
@@ -102,7 +102,7 @@ test_expect_success 'non-sparse pack-objects' '
 		topic1			\
 		topic1^{tree}		\
 		topic1:f3 | sort >expect_objects.txt &&
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
-- 
gitgitgadget
