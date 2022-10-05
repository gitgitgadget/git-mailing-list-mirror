Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E6C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJEPAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiJEPAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A86246
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu30so6469065wrb.8
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=YrdR4Hozyc3DsXTy4w4GIs3Pp3AzvNFwFd5DXY0kiR4=;
        b=gYYPMYmu9nc14bHEjA0i4YvL60fwRRsXtSmVrlSPdkUA5Bza6VZBXLXu9toLkZ7DqZ
         A0+OCOzqDrSHOSeK/Lv9C1mfZIJATZNsevJdNNHdhCcF57MKSBls6e8YcVYOSED1JjH2
         4+mmADTCynDbbuL04xYZiLmIokwr/mRmjKRnB1/a8Xd3biCehGeKUqHCGt++zmfcDGCd
         4883ckgjdHjbSaIZzzxJ7hMmzpq5PQISzJnLKmWq5KKLRbsNYLWVmZAx4LrwrPgZqJPR
         58ITlrtSLVXuJ+DBn1COCQLgyBuYViugwTYTx9KiwCJoUPRB7CfmxHoadAT4vGELUYh9
         ShVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YrdR4Hozyc3DsXTy4w4GIs3Pp3AzvNFwFd5DXY0kiR4=;
        b=QS+VW0nTqcm9lCWfiHELBq8EdHA/aNov23mx8uKVhjVbd0Gc6HhW8u8fM6CPWldWPR
         /70nJyu2YDhaswKcVPKISDV2M9PK5CzzcwrttK/X/w8ols5CCblongpAGBNIwqtJHCla
         GZzVFL6xwxAWfktJ9BZAiJPq2I2/7hV/j8O6A/L/ZugimmKxpFossZRAWF3PHUH0xHdY
         g9MPtFhTYlBWW9N9fsMWSS7P15T4yqpAlKCbIefC+0xLOa9IuRybrBYivEkGxQUADgJ5
         1qYBbKAjas6arXfzjv4lVMssULYgM1JJf49UtrOZcrEZ0kgXExvAMacALU8yzXwEa+Pw
         J/Aw==
X-Gm-Message-State: ACrzQf3DNozCAwDTiyjbAuPgTzqeRhFKcom2OsG+8nsu/anJtiAhomj2
        Co9G2i0vYBk86BqFKBBtX0DRCs7ELzE=
X-Google-Smtp-Source: AMsMyM5z6zNeM9SkcwvI70T6u9gMT9sfRtFZXITsLpina0mQ15JBzUQuTgiw3akvS2nWti7aBStJXA==
X-Received: by 2002:adf:e88c:0:b0:22e:2e7c:54a5 with SMTP id d12-20020adfe88c000000b0022e2e7c54a5mr75034wrm.245.1664981961809;
        Wed, 05 Oct 2022 07:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020adfed0e000000b0022ae4f8395dsm15116442wro.96.2022.10.05.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:21 -0700 (PDT)
Message-Id: <ed5106d6080363ae47e1126dd9717c8772302a6e.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:09 +0000
Subject: [PATCH v2 02/10] sha1-array: implement oid_array_readonly_contains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

Implement a "readonly_contains" function for oid_array that won't
sort the array if it is unsorted. This can be used to test containment in
the rare situations where the array order matters.

The function has intentionally been given a name that is more cumbersome
than the "lookup" function, which is what most callers will will want
in most situations.

Signed-off-by: Chris Poucet <poucet@google.com>
---
 oid-array.c               | 12 ++++++++++++
 oid-array.h               |  7 +++++++
 t/helper/test-oid-array.c |  6 ++++++
 t/t0064-oid-array.sh      | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/oid-array.c b/oid-array.c
index 73ba76e9e9a..1e12651d245 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -28,6 +28,18 @@ static const struct object_id *oid_access(size_t index, const void *table)
 	return &array[index];
 }
 
+int oid_array_readonly_contains(const struct oid_array *array,
+				const struct object_id* oid) {
+	int i;
+
+	if (array->sorted)
+		return oid_pos(oid, array->oid, array->nr, oid_access) >= 0;
+	for (i = 0; i < array->nr; i++)
+		if (oideq(&array->oid[i], oid))
+			return 1;
+	return 0;
+}
+
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	oid_array_sort(array);
diff --git a/oid-array.h b/oid-array.h
index f60f9af6741..e056eb61fa2 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -58,6 +58,13 @@ struct oid_array {
 
 #define OID_ARRAY_INIT { 0 }
 
+/**
+ * Sees whether an array contains an object ID. Optimized for when the array is
+ * sorted but does not require the array to be sorted.
+ */
+int oid_array_readonly_contains(const struct oid_array *array,
+				const struct object_id* oid);
+
 /**
  * Add an item to the set. The object ID will be placed at the end of the array
  * (but note that some operations below may lose this ordering).
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index d1324d086a2..0dbfc91ca8d 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -28,10 +28,16 @@ int cmd__oid_array(int argc, const char **argv)
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal oid: %s", arg);
 			printf("%d\n", oid_array_lookup(&array, &oid));
+		} else if (skip_prefix(line.buf, "readonly_contains ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal oid: %s", arg);
+			printf("%d\n", oid_array_readonly_contains(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
 			oid_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
 			oid_array_for_each_unique(&array, print_oid, NULL);
+		else if (!strcmp(line.buf, "for_each"))
+			oid_array_for_each(&array, print_oid, NULL);
 		else
 			die("unknown command: %s", line.buf);
 	}
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 88c89e8f48a..aa677af132d 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -35,6 +35,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 	test_cmp expect actual
 '
 
+test_expect_success 'readonly_contains finds existing' '
+	echo 1 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 55 &&
+		echo for_each
+	} | test-tool oid-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'readonly_contains non-existing query' '
+	echo 0 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 33 &&
+		echo for_each
+	} | test-tool oid-array >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'lookup' '
 	{
 		echoid append 88 44 aa 55 &&
-- 
gitgitgadget

