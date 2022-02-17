Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC49C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiBQNz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiBQNzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61E2740E9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so9137799wra.12
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XxbM2A5F4fQmhL+gCS+SwLotSFUOUYIK9jyUgxWcDks=;
        b=SGXg44M9a7KJzl1OrS7MrfrbseKtTwpwbDIGKGp/EhqTXJsPJ5n1S4akXLrPnC5Drd
         7Y3DZRQ8qPVaOTUpQyyKMduVAVSKfYOyLJ5Mw+clx0jF66GB8e/bwYzdIqXYt3thXQ/4
         fiQ5tlqUgmtKgvwhJQbrL4m0gWL0GhEg1mKS36lvnvJ9ehpraj+tjHWh2QzegdOOZDua
         rztdht+LcpPdy1ksjCDm4t89uiVFz1hFQxn3C9en5xnxJ6du89akgQh305txtrQB0JIT
         J6TlmkIwlqinP34oJ/XdsyYMyKo1LBwcGOKUmHsxzfeF/M1i+a8mCthOroAGiiRd3Eko
         I/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XxbM2A5F4fQmhL+gCS+SwLotSFUOUYIK9jyUgxWcDks=;
        b=OgPOi66GMUcSqMSgPhFHHbyWKNFmQue+A3DMDsj1Rbccrm/z/zg8xN/pBtEq4z32Tw
         pKUAkTnLnVs5foOVjJwEzW6UWIwv4fYX0zksDSMwGQ/Ahse0pxqW42CjlHkneaFQ7AXf
         V7YkAqRVDF+FNI4Q8B4Bp/WitV+f81fIYVMdUa/GOXGUjWLsHxwAVk7hEbDYlbmr/KqM
         /ot9hKpJY/vgfot79g0JwMerTHHNMF1JpNLsOrdwB4dEkvP47/1xdCjNG4hdPJ3n9NIL
         4GtcPAICJwx2d2d1S+a8porc5MuqB3LWCKkFegnciept7a17STABnm5R9lFD9AOVOEOU
         QJvQ==
X-Gm-Message-State: AOAM532flT/gA3TySD5SXFGLj+BjhwGJIew/XahtLzZPdZYLzLoE3jaf
        2RllWJCqH3f7aTsH9GYaTxK34Aj9xac=
X-Google-Smtp-Source: ABdhPJzl3Quop9mI0M/ivRjd4sWfb/hVEQxi+rSt5HW+1voBxFJymOacXuW9rHwAJWIRZh03/roHkQ==
X-Received: by 2002:a05:6000:2c5:b0:1e6:2be7:b0fc with SMTP id o5-20020a05600002c500b001e62be7b0fcmr2399145wry.154.1645106132844;
        Thu, 17 Feb 2022 05:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm1506899wmq.35.2022.02.17.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:32 -0800 (PST)
Message-Id: <82d36ee0e0d7fedd40e4cc9013dbf469218fb68f.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:23 +0000
Subject: [PATCH v2 6/7] reftable: add test for length of disambiguating prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The ID => ref map is trimming object IDs to a disambiguating prefix.
Check that we are computing their length correctly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 35142eb070e..a1b835785a3 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -703,6 +703,43 @@ static void test_write_object_id_min_length(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_object_id_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = hash,
+	};
+	int err;
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		ref.value.val1[15] = i;
+		err = reftable_writer_add_ref(w, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	EXPECT(writer_stats(w)->object_id_len == 16);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -808,6 +845,7 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
+	RUN_TEST(test_write_object_id_length);
 	RUN_TEST(test_write_object_id_min_length);
 	return 0;
 }
-- 
gitgitgadget

