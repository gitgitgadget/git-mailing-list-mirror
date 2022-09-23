Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E8C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIWSzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIWSza (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E879F190E
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cc5so1308541wrb.6
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=YrdR4Hozyc3DsXTy4w4GIs3Pp3AzvNFwFd5DXY0kiR4=;
        b=p7H153SFts+vmWSGhjCsJz0RMeBeBIwtXZrwx4wDxPXxud9P5dwvTDcB6VobmT2yvK
         vIEIjcHSrgYR2pqjfuobuvuqkGm16d0ECflcE2RHQCQUZJso+faAjXcK8oQo2LjZI+CJ
         5ExbBMf8HL8MPPWimL2SK3dfnblHuogf1PO87umMGmfnDLm4zlvsyCwcPt0ao5AAnCPM
         0PEUgge8EGeDJYkaOLg5Hi81sJ/Vt24dGaCcmrBlxJCheKo5115pBAIuYjUDdFuSBYci
         41Y76FuJbiRxnf7POoEgLOrEqp8VNdBO9u9cCwZ06L/hf4d0pI5zhfUncJHBkC+G3rkW
         PoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YrdR4Hozyc3DsXTy4w4GIs3Pp3AzvNFwFd5DXY0kiR4=;
        b=WSEcl4rv65SNPp/cO8qyOqBsrlFVuwOUO3DT+wT3t9ZWi4Qagy1LahA+litSrw7DFr
         4i2rbt5NcRl4xWbptwhLBEx2Tz1F1HcXZg5LgMXiK9+AJMPDT9SYxoVMETRgyaEB9PKH
         FcGCKQv4WF1j8C9FfJ2xZKCAAJZ2+0146ut7gt7AE8G5Zi82SGJ6p10JuqpyJNqedHUd
         W3cgzE85bKeecC4w8AV09tKeHf0znhxQfWUug4MX+yxHdg/ikJJYoJHUCbKEnalthLx7
         bMOfcqvuGQFYRDMUXujpQPR1+7ZqLou4jYktbKqmC9sOkzZxHKMRj62N6jyr8K9kJ+cE
         kPnw==
X-Gm-Message-State: ACrzQf12Om9fOQ860T0kf11Ce8MTIStv14TQWg+Tfm4abH43qzsNupgi
        FjMzK1HnNLhdmtDJuQ9RRV4MBtZp77A=
X-Google-Smtp-Source: AMsMyM4DnaFc1Lzw77JuE2iotvMCaZ7WbPyMgFM59b6veKk+7A1lUNNc7HkbmyxsmLKAij7gpcgNzw==
X-Received: by 2002:a05:6000:1ac7:b0:22a:906d:3577 with SMTP id i7-20020a0560001ac700b0022a906d3577mr6367845wry.33.1663959327570;
        Fri, 23 Sep 2022 11:55:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d6dcc000000b0022af5e36981sm9503341wrz.9.2022.09.23.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:27 -0700 (PDT)
Message-Id: <84588312c1d4a62ff6c6211e85b4e58ab0563daa.1663959324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:16 +0000
Subject: [PATCH 02/10] sha1-array: implement oid_array_readonly_contains
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
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

