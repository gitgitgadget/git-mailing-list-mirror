Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9508E1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeFGOEr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46419 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932846AbeFGODv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so9906689qtm.13
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GLKqJkbToM3y3IqgjW5FcwuX7Yu7f4tsXNJ59t16Cg8=;
        b=K6uDuVpLW9td62Kd4RsaqyfYGR1A4auuRiz/iXu/+UAjJtd2PnTiXHvLzlFN03/52f
         4u+qTZv7DOtr5Ibis2kNgxzHw8dTyJevwL5uvAcaUCj4wIHfZtd0bRb9LepVDV3K+6Fx
         hYvAPOcmE8jx6AZl7cGZ0ikUNisP/YHFJhIHPZscvekyBx0YOrNP8UshjUSzeDHsVzOs
         YLIedO0od4vcQhXcoW4ZjywhbMAs64SslJBTGuXnbnKLC0azVCwtI6BAS+AtnkZSQ9o0
         ehgu9grptN7WR0Y1a4FdF/YFXK0opH+9OL4ubKiN6sdkJsaLQee98gnlko9QER0jHBHO
         hH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GLKqJkbToM3y3IqgjW5FcwuX7Yu7f4tsXNJ59t16Cg8=;
        b=Baj0kQdmp4oWyCe00pJ8zLMAGYPL9lGh1nMAqAfBHNVw0k/u6yCrDqVqavL6w6pohX
         nmO03PEjX7rE+8ewADA3TpHGuPLvS6wcdKYWQYe+tSftRBNTkt2OYwoNaeGQDho6a1bE
         IY90CbB2p4VzF51073PCNyKfgwGqVTmOxoo3Q371HwBESSs3Ov43NHdADolhJrkftKHB
         JXCqAMitUudp0GJReZCA+avZX1OikE1kfYTpx5x6asB9/y9bG8SjNBRcbtCKCaEfIo0d
         pniQNXTUg15k5ailv+6zNcCrdcgASe4P5anXyZKLJIBb5UC2sqhZOGjzavOd4aKBbBSK
         17tg==
X-Gm-Message-State: APt69E0+9Y9tew/LTuLmgIOS0VjOeTAmF5mDRmCuNAOcDFN20PJhII9M
        n+SqPJHlBMUlLUJMckVlzZiuPEin
X-Google-Smtp-Source: ADUXVKIxTk9Y1TDgv9Waq5ImF6Div/jEbqs6TAJVAeXVhzdY/Cb9ukYruyYy+C8SSbhQEPi958FiAA==
X-Received: by 2002:a0c:94fa:: with SMTP id k55-v6mr1797424qvk.20.1528380230884;
        Thu, 07 Jun 2018 07:03:50 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:50 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 07/23] midx: expand test data
Date:   Thu,  7 Jun 2018 10:03:22 -0400
Message-Id: <20180607140338.32440-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we build the multi-pack-index file format, we want to test the format
on real repoasitories. Add tests to t5319-midx.sh that create repository
data including multiple packfiles with both version 1 and version 2
formats.

The current 'git midx write' command will always write the same file
with no "real" data. This will be expanded in future commits, along with
the test expectations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-midx.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index e78514d8e9..2c25a69744 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -14,8 +14,109 @@ midx_read_expect() {
 
 test_expect_success 'write midx with no packs' '
 	git midx --object-dir=. write &&
+	test_when_finished rm pack/multi-pack-index &&
 	test_path_is_file pack/multi-pack-index &&
 	midx_read_expect
 '
 
+test_expect_success 'create objects' '
+	for i in `test_seq 1 5`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
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
+	git midx --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'write midx with one v2 pack' '
+	pack=$(git pack-objects --index-version=2,0x40 pack/test <obj-list) &&
+	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx &&
+	git midx --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more objects' '
+	for i in `test_seq 6 5`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
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
+	pack1=$(git pack-objects --index-version=1 pack/test-1 <obj-list) &&
+	pack2=$(git pack-objects --index-version=1 pack/test-2 <obj-list2) &&
+	git midx --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more packs' '
+	for j in `test_seq 1 10`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
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
+	git midx --object-dir=. write &&
+	midx_read_expect
+'
+
 test_done
-- 
2.18.0.rc1

