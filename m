Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF871F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeGFAyg (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:36 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44252 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbeGFAxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id b15-v6so8704612qtp.11
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oE2UVtBKiS1ufaSgi4BHZb7Cnm8IwBGOno/qBnOpULU=;
        b=reoVqvOKOQZ8/WiNGFnj6QBFe7hCV8BpQamg00M14wuf5Tcw3h9mYEAtXF8UnBiKjJ
         Vq5Cc2EJ3tqe/jnhic7PEfQIlh1h1v8hwht7S3LlL651T917uelckScMOFE4bLIz08zo
         eaH6cnhOgYsffEY1gmgut7RjqjCI6whtWTAAjeY2fw90B6tQqDEMOwYarzNoD/3faqfY
         CEKvWX/IxxHpHDGP2WdQrtOvH+nXy5bSF1K4WPHVwA+TzYhbm7pUV/cfQZqFQ6ubl9op
         GwP+UlzuIsNOXlwD8Da4cZqxhfpCXDDtQABvVI+g9MgbpEPoH+oCI0ShVOSYg0u43rWP
         GTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oE2UVtBKiS1ufaSgi4BHZb7Cnm8IwBGOno/qBnOpULU=;
        b=b+hS0UA86XBzcGqKhu7ZEW6S0ohQDaxIAiVG/27LeWMWIJRdJEDGNEaPzcQdJw/SrH
         umGgj1GfeofqxbqEMcMG8stVYchIq0IRynMVOXkIZVv4J2oyhRQxLCIfZZy7ClcZKx3G
         JCo8mbahzphENIpPJHc37IBM+X7fc+kg6GRl1kgNCbdbWOquw2Ppv0YWLhWPwJRyrwCI
         g4ipg4coV899vb6X4iLYp0W28mUDEM3TY4iIz2YQQ6/Ig9TGvLag8tBjNaU5qsafd7ti
         Gncfo8XSTjbR72bYtK9vaqmHVnmN72aPmoSwTqeYR3TM92TmaBptXi1B7ozT4JX18zR3
         RKPg==
X-Gm-Message-State: APt69E0YJw+NqshJdU4Xg1WAfSjT7ftbFSUXcMjFcxnOKNj16InojjZO
        zv5Q4ZkH6W2XwGrCYDRD0wRsgDdd
X-Google-Smtp-Source: AAOMgpfjTerVAEAPSXqMmBsTjh0UYolZMVUMNGQY4IpQcqEdablP3Zka2QvK+y7WhJd/aGqugcRfbw==
X-Received: by 2002:a0c:d647:: with SMTP id e7-v6mr7182529qvj.238.1530838420291;
        Thu, 05 Jul 2018 17:53:40 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:39 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 07/24] multi-pack-index: expand test data
Date:   Thu,  5 Jul 2018 20:53:04 -0400
Message-Id: <20180706005321.124643-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we build the multi-pack-index file format, we want to test the format
on real repoasitories. Add tests to t5319-multi-pack-index.sh that
create repository data including multiple packfiles with both version 1
and version 2 formats.

The current 'git multi-pack-index write' command will always write the
same file with no "real" data. This will be expanded in future commits,
along with the test expectations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 99 +++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2ecc369529..1be7be02b8 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -13,9 +13,108 @@ midx_read_expect () {
 }
 
 test_expect_success 'write midx with no packs' '
+	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
 	test_path_is_file pack/multi-pack-index &&
 	midx_read_expect
 '
 
+test_expect_success 'create objects' '
+	for i in $(test_seq 1 5)
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 >wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		i=$(expr $i + 1) || return 1
+	done &&
+	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree </dev/null) && {
+	echo $tree &&
+	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	git update-ref HEAD $commit
+'
+
+test_expect_success 'write midx with one v1 pack' '
+	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
+	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'write midx with one v2 pack' '
+	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more objects' '
+	for i in $(test_seq 6 10)
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 >wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		i=$(expr $i + 1) || return 1
+	done &&
+	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree -p HEAD</dev/null) && {
+	echo $tree &&
+	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list2 &&
+	git update-ref HEAD $commit
+'
+
+test_expect_success 'write midx with two packs' '
+	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more packs' '
+	for j in $(test_seq 1 10)
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 >wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+		git update-index --add file_101 &&
+		tree=$(git write-tree) &&
+		commit=$(git commit-tree $tree -p HEAD</dev/null) && {
+		echo $tree &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+		} >obj-list &&
+		git update-ref HEAD $commit &&
+		git pack-objects --index-version=2 test-pack <obj-list &&
+		i=$(expr $i + 1) || return 1 &&
+		j=$(expr $j + 1) || return 1
+	done
+'
+
+test_expect_success 'write midx with twelve packs' '
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
 test_done
-- 
2.18.0.118.gd4f65b8d14

