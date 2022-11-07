Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A303C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiKGSiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiKGShI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7129354
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t1so7424262wmi.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1msgsAfJBAvhgId5qf6c2a1kBCGuldXrr95UAzR688=;
        b=ajh9SZcPyYvdLPMRDiF8t6heFPqEbwyL9HqJhRNsVRiC9LymIRWyzC7tysRn7GJu7z
         AkQQvqLGD5ixsTYjKTmrPWIg8IXn+dSQ6u4tHK0n558svFj2+NNDGFr+XQqvMTuAku9i
         QDr35BkHI9o47ThuVMBhW1rAUkQp5Uwl4mVsNftiiU+8GrRE8rp7IeHwTcHSzHDPf7pq
         g3JszMynMUGjkSR+/KuuVgFwlCEn/Z1S1XoeQ9PWZ7QMAirmImMqk+7tu3cZ+DorEBhh
         rCPjadkDufDwzxT1D9bkoaHKbHzcG4OVX2PHRGfCdAPDqNvAx9Mtwb1Es0ZPBAvcvbFR
         2Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1msgsAfJBAvhgId5qf6c2a1kBCGuldXrr95UAzR688=;
        b=LZ5qIaIb2NhhXdoUD5ekf4msT0NbkDI8MO5afiIKFmTlG6ftHbfqq8EWuu7+hFJbD1
         ITC4MaR03Ng1rqRoi1TjEG/aX2ZI4MqKSR1gcdynzpEIR3EIqrwltVapyRtTO++K2e5n
         ktrhTA1dsVyjE+dk+rNK2ovWrxmUladCuaPXG6dNY4Y2Bjj487P3P5C2uZQD0LzlPTom
         Z9Q5ia3omoqQ+zKennLZkBNziYWQOI+PScGL7rNt254UKoCEBHlLGkJL2gQi+/bv/yP/
         PgKTxOp/KefSXhoKrEBn23iak0RIIkE3Nyt+ctczqa+HoxtCts5DiL8lcybYKQzLdAsd
         c9rQ==
X-Gm-Message-State: ANoB5pmU1CqHl68HX4QT7TzHTQX7n5rF3ols8dpEooR8S4q+5H1ebMdw
        H0QRicQPKhqWtXdkgPW/bp/wbEl2joA=
X-Google-Smtp-Source: AA0mqf7W+FoMc5mQ6/JWjyd+y9+AIhn1nlYAovFONMEPLdxgeJ1oIJRnjsdyacEd/k7FnWI+8X2I9A==
X-Received: by 2002:a05:600c:4a11:b0:3cf:b128:39ad with SMTP id c17-20020a05600c4a1100b003cfb12839admr2701315wmp.127.1667846195248;
        Mon, 07 Nov 2022 10:36:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003b95ed78275sm9506418wms.20.2022.11.07.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:34 -0800 (PST)
Message-Id: <a4a69d8ee91d23465f945488ad42fa38818c2651.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:36:03 +0000
Subject: [PATCH 29/30] p1401: create performance test for ref operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

TBD

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/perf/p1401-ref-operations.sh | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 t/perf/p1401-ref-operations.sh

diff --git a/t/perf/p1401-ref-operations.sh b/t/perf/p1401-ref-operations.sh
new file mode 100755
index 00000000000..1c372ba0ee8
--- /dev/null
+++ b/t/perf/p1401-ref-operations.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description="Tests performance of ref operations"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_perf 'git pack-refs (v1)' '
+	git commit --allow-empty -m "change one ref" &&
+	git pack-refs --all
+'
+
+test_perf 'git for-each-ref (v1)' '
+	git for-each-ref --format="%(refname)" >/dev/null
+'
+
+test_perf 'git for-each-ref prefix (v1)' '
+	git for-each-ref --format="%(refname)" refs/tags/ >/dev/null
+'
+
+test_expect_success 'configure packed-refs v2' '
+	git config core.repositoryFormatVersion 1 &&
+	git config --add extensions.refFormat files &&
+	git config --add extensions.refFormat packed &&
+	git config --add extensions.refFormat packed-v2 &&
+	git config refs.packedRefsVersion 2 &&
+	git commit --allow-empty -m "change one ref" &&
+	git pack-refs --all &&
+	test_copy_bytes 16 .git/packed-refs | xxd >actual &&
+	grep PREF actual
+'
+
+test_perf 'git pack-refs (v2)' '
+	git commit --allow-empty -m "change one ref" &&
+	git pack-refs --all
+'
+
+test_perf 'git for-each-ref (v2)' '
+	git for-each-ref --format="%(refname)" >/dev/null
+'
+
+test_perf 'git for-each-ref prefix (v2)' '
+	git for-each-ref --format="%(refname)" refs/tags/ >/dev/null
+'
+
+test_done
-- 
gitgitgadget

