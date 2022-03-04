Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1561C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiCDPFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiCDPFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBED15B9B7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk29so13133961wrb.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d2lQjiwQo/d2+l3J+KrjN/UX3KHYu6mnvr6cgsfzWJw=;
        b=h4scN1PkQrUIo9FYCI8hiWNLgTnZtbx9w5yR9QM1t2AJl0SKAO8FksqZfPy25OZW1Z
         WZlYetulT/VyHPYCiCwRmMOEk+vEEO6mJXn4DNPSN+7kYMJsxBujeM2W12U2otkcgNNy
         /ib5ltrck4Ey//8s2q/IRs4brF20KG8pVt+imPCgkVaFk1OURsGbzHo/3ECoZJv1CFNO
         ORFU302L3ibzM/sE80MmMYVzQeOsKLRNoOhtFBLUTJpp8vlSEOxQTjIcxrhLkPj3AuMG
         LZf/XGDIOoDZRoey5C+tRmaHLSXTjLZ9AawOtXnRQmV/0+TGefIPxPc6JTRItxNW3mNE
         mjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d2lQjiwQo/d2+l3J+KrjN/UX3KHYu6mnvr6cgsfzWJw=;
        b=fW9YXDBd9It9Kce6GcqJdrK1v3ji7SlYalDr9d6MJAvS/s5bWxEWuLecaPh4grT7hF
         QIN4wY/F+o8QnYSKeJYECAYhAKWoL1AJff22vMsW/qH3hAW8BQ06KxfU4hFglwiYJMof
         Kkpax4tvwahR3s1fGqwaYmmy7A9agUUQxAGFFflKEIONaz69DiP2w3y6y/YIQin1Pob/
         MrshksBQ3xOuojyJ8LENCIUwk/YDrCPojZRIx9TLv/GTerZgG0pe7SY1W7w49G3YtoPK
         6lCWUX19Fdp75+S3LhG8CfpHOc9RDEarguOHiiiSPAAOgo4/GyvmQitxaZizMF7+c4fu
         j3bw==
X-Gm-Message-State: AOAM533rs0ZY3mJ1odsR2RniH75v5U0/a644usP4u1ZXjghv6n1GgY8e
        JDvI8PDYK+saSYUrOqtNGpJ4QhPbUbU=
X-Google-Smtp-Source: ABdhPJzrLrDE213y8NWvuxIHnNUYgSAUzkObRQ5vU1nX7zeoqF2phBNBK6C5YOWuQIWUBd3pMku4vQ==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr29437881wrn.454.1646406280595;
        Fri, 04 Mar 2022 07:04:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm4729902wmp.45.2022.03.04.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:40 -0800 (PST)
Message-Id: <01f22e784a527f11c34703241bdb63b3d99f6fe8.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:32 +0000
Subject: [PATCH v3 5/7] t5615-partial-clone: add test for fetch --refetch
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
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
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

