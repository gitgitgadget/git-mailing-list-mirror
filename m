Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777FC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiC1OEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiC1OEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C685EDFC
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i131-20020a1c3b89000000b0038ce25c870dso179465wma.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d2lQjiwQo/d2+l3J+KrjN/UX3KHYu6mnvr6cgsfzWJw=;
        b=L2mO/C5iwpPNX4fKvAYIGbvDtTJRI6yJb6ReRtBkKAU7loQEk+qcdM/HQkmuI2gXaU
         og5SIgVyZNln8azgZzKV2cH60Zhp5eZ88sNv7HBWn0a6eBBNaFUea5pno1oPbHSrs9ye
         LMCN0JdblssmHtPp47l1E+7/1XaffBKX7u13vV5n0tUtNEGd0w3O8tBFNaLcXs35Xdyk
         4FTWYsMAjCqukTUgiiRgRglbs3mGOKMmLckF1fwMeyWteGJ7DU2PGv/Fg5CyJT5LCvM9
         sGwhX22IB+hsHXBqyLCFJusBpOGLerJwVn+uN/d+glmFS98YBKmf3X1cBsQdkdMNKZIx
         YamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d2lQjiwQo/d2+l3J+KrjN/UX3KHYu6mnvr6cgsfzWJw=;
        b=kbQyr/KsqXePL13TkBq+sSqWpNjbt++IHlvp3SlPKBXbx/AtN4Mu8O1Ud5LKjyn1UT
         7qfeATCAtdg7DVyOvhVoRpWqJRmYzvVMOisAiz0jU1p4DHil/zexvTbb2cH9yV1v+k6N
         bICjNR98SViFV9atXkTys9BJdYm87qU2ga8TBZLDQjfgVQ9vHYd8woE55r0MnEh71rPH
         UQTqanqBuCyQduMVnQ/qlurSMQv+RExManc39fyJcoEzYGc5VvsyOCAUPVnjZm7H0hpu
         1qG861P9/+sqamo9mOhN64p5Fxw/K7efSV7mIjN6iR4S8JZbu9RzNXKLjF8AaRlMnfAt
         Wi7w==
X-Gm-Message-State: AOAM531fmCv6iMJ3ANXrGzChRzy2qqC+gxswQRmW+FgPcAdH72LOgUSu
        cEG3fMXGeXSuu9/B83e1X1q2EgEZzxo=
X-Google-Smtp-Source: ABdhPJy3isDLJ0z05FQix74aqVmATceSYHTojhM49USoMOvsg8jpn6pT/mFkfrd4x8taryW1gX8Lmg==
X-Received: by 2002:a05:600c:4f46:b0:38c:d4cd:ee31 with SMTP id m6-20020a05600c4f4600b0038cd4cdee31mr24017974wmq.16.1648476143186;
        Mon, 28 Mar 2022 07:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000184400b0020584c40778sm13161861wri.103.2022.03.28.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:22 -0700 (PDT)
Message-Id: <6c17167ac1edbeea5f6d375a989aa49f5748d099.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:09 +0000
Subject: [PATCH v4 5/7] t5615-partial-clone: add test for fetch --refetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a test for doing a refetch to apply a changed partial clone filter
under protocol v0 and v2.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 t/t5616-partial-clone.sh | 52 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 34469b6ac10..87ebf4b0b1c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -166,6 +166,56 @@ test_expect_success 'manual prefetch of missing objects' '
 	test_line_count = 0 observed.oids
 '
 
+# create new commits in "src" repo to establish a history on file.4.txt
+# and push to "srv.bare".
+test_expect_success 'push new commits to server for file.4.txt' '
+	for x in a b c d e f
+	do
+		echo "Mod file.4.txt $x" >src/file.4.txt &&
+		if list_contains "a,b" "$x"; then
+			printf "%10000s" X >>src/file.4.txt
+		fi &&
+		if list_contains "c,d" "$x"; then
+			printf "%20000s" X >>src/file.4.txt
+		fi &&
+		git -C src add file.4.txt &&
+		git -C src commit -m "mod $x" || return 1
+	done &&
+	git -C src push -u srv main
+'
+
+# Do partial fetch to fetch smaller files; then verify that without --refetch
+# applying a new filter does not refetch missing large objects. Then use
+# --refetch to apply the new filter on existing commits. Test it under both
+# protocol v2 & v0.
+test_expect_success 'apply a different filter using --refetch' '
+	git -C pc1 fetch --filter=blob:limit=999 origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 4 observed &&
+
+	git -C pc1 fetch --filter=blob:limit=19999 --refetch origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 2 observed &&
+
+	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
+		--refetch origin &&
+	git -C pc1 rev-list --quiet --objects --missing=print \
+		main..origin/main >observed &&
+	test_line_count = 0 observed
+'
+
+test_expect_success 'fetch --refetch works with a shallow clone' '
+	git clone --no-checkout --depth=1 --filter=blob:none "file://$(pwd)/srv.bare" pc1s &&
+	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
+	test_line_count = 6 observed &&
+
+	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --refetch origin &&
+	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
+	test_line_count = 6 observed
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
 	test_create_repo submodule &&
 	test_commit -C submodule mycommit &&
@@ -225,7 +275,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
 	git -C dst rev-list --missing=error --objects main >fetched_objects &&
-	test_line_count = 70 fetched_objects &&
+	test_line_count = 88 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
-- 
gitgitgadget

