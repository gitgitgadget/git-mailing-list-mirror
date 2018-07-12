Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCDB1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeGLTvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43055 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGLTvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id z74-v6so16048989qkb.10
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZzPSJZhV07Ybob9z376OB1j2T3X0L8+TCFsgJGwqpfA=;
        b=pqJX+/po2ekht2qxBiI9FjOHPgpVLc3hhTvUfbbjENCT7oyYEbyTQ8mnV+NFoT8Alv
         tOJO7aaM7GsUVOTOTaLLcPfViaglY58G4V/A7J/6O6clKUfefsvIAOwp3rocj7r38ovq
         49d3LADcYjgtyytwWxoW1xL/VsfBvBJ8ZP28j6WEDFG6DSeOqXc4DDghU1Mo8Ci4rar3
         P8x3SXbcuTGBWKdTGGhpT+o3yHbTKzatsORsq4qC6ofnI4ln6ZhX91vZXngLCMFw5OS3
         QdSdFbgUWRzL5J4R60ps5J2Q56GfQ/A5jS12C6kFzYB8MjsA/S2DYUeB8qhei2Iyrn3p
         RSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZzPSJZhV07Ybob9z376OB1j2T3X0L8+TCFsgJGwqpfA=;
        b=lUpM4bEqrsAhokVK52KGNQqcFA4ioLy/hqeWN12I5t7MLb1yiFhfsBEB8IIWLEUQVa
         uaMNYSOqfcVKMWWCYvtqLgVowGFSD9RB6JnH6EPDnh3U339w7N8ItSnFb17lryT3pYIy
         6MWtQ7WfHnlujWR2xsl6EoD4o61AjtlamqKM2aHuu9aYioKaa75vG5rfyS6+xsybWoQE
         ayQpmBbc6WjqQDCuw+NaB1ZRtJELYouKXcvilIzoQzt3MLWh8w4ypUkQriiS2cBEEO9S
         FVutKrwgqggxwdR95+y/BbZBEN72lk6glLHCs5t7XIdpMWZost59+na8ZUl11RfKm7z0
         cjmA==
X-Gm-Message-State: AOUpUlHdcOUmvET8HX0qg6mhXfz3526p1T1xt8ASa58RriTZJML3YlpK
        7dlq0nxTo/Akp561Cem+G/Jfw5dpRLQ=
X-Google-Smtp-Source: AAOMgpdIUbRCVEXncw2/ahHa00PbGyCuhWRaUVmzmpNVTXx5OEx4liXyTzuzHCeD5qui9tHWCurZBg==
X-Received: by 2002:ae9:ed82:: with SMTP id c124-v6mr3053876qkg.303.1531424416825;
        Thu, 12 Jul 2018 12:40:16 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:16 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 07/23] t5319: expand test data
Date:   Thu, 12 Jul 2018 15:39:24 -0400
Message-Id: <20180712193940.21065-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we build the multi-pack-index file format, we want to test the format
on real repositories. Add tests that create repository data including
multiple packfiles with both version 1 and version 2 formats.

The current 'git multi-pack-index write' command will always write the
same file with no "real" data. This will be expanded in future commits,
along with the test expectations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 506bd8abb8..1240127ec1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -18,4 +18,88 @@ test_expect_success 'write midx with no packs' '
 	midx_read_expect
 '
 
+generate_objects () {
+	i=$1
+	iii=$(printf '%03i' $i)
+	{
+		test-tool genrandom "bar" 200 &&
+		test-tool genrandom "baz $iii" 50
+	} >wide_delta_$iii &&
+	{
+		test-tool genrandom "foo"$i 100 &&
+		test-tool genrandom "foo"$(( $i + 1 )) 100 &&
+		test-tool genrandom "foo"$(( $i + 2 )) 100
+	} >deep_delta_$iii &&
+	{
+		echo $iii &&
+		test-tool genrandom "$iii" 8192
+	} >file_$iii &&
+	git update-index --add file_$iii deep_delta_$iii wide_delta_$iii
+}
+
+commit_and_list_objects () {
+	{
+		echo 101 &&
+		test-tool genrandom 100 8192;
+	} >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree -p HEAD</dev/null) &&
+	{
+		echo $tree &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	git reset --hard $commit
+}
+
+test_expect_success 'create objects' '
+	test_commit initial &&
+	for i in $(test_seq 1 5)
+	do
+		generate_objects $i
+	done &&
+	commit_and_list_objects
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
+test_expect_success 'add more objects' '
+	for i in $(test_seq 6 10)
+	do
+		generate_objects $i
+	done &&
+	commit_and_list_objects
+'
+
+test_expect_success 'write midx with two packs' '
+	git pack-objects --index-version=1 pack/test-2 <obj-list &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'add more packs' '
+	for j in $(test_seq 11 20)
+	do
+		generate_objects $j &&
+		commit_and_list_objects &&
+		git pack-objects --index-version=2 test-pack <obj-list
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

