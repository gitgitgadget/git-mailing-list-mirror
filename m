Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D268C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiBUSrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:47:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiBUSql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A69C76
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so2230982wrg.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XxbM2A5F4fQmhL+gCS+SwLotSFUOUYIK9jyUgxWcDks=;
        b=IA7h7HBdLHpgup0R6MfjLeFyzsE5Iz0sReD8Q3Q2bry+SUSE4bCFtqYoVrOnXK12W+
         jCzvTaphMUCjs355hQvL32shHsUFSM6sakOI3VnjsYD0oBOLqDCi9TaNIu3oZaKNfnao
         fiX4wHS5yxGNSqs68mlOxFRVHqTTw4R11vnmm94lvY6/+1A3/cDxYM44aEyChQVOKhzz
         OSwZGXUHKpO6EbveswwqSCpl1tiYO0phXlv6yDVqSUNi+Ks69Z/IBeqtw0Cfopo0uiT4
         qejOAdmiYv9dUsHzsu53aeQZ7dvZKi3X6ddhWilnpjsbb8BGXiRdrbxXbnQJR6d0b0I6
         hXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XxbM2A5F4fQmhL+gCS+SwLotSFUOUYIK9jyUgxWcDks=;
        b=hb8mf+JGTRU/OVKwJhncuSy8lAYbTZ+u/WX/DSWpD+C9UCt/tCD8roNOSudEyBgdoa
         CJE+WF5nDk/pxjBUTKMDtMa4cbd+Zue3pQQqoxoDwjIrRt1VCDR28zXlWK6gUSxAtZ2/
         N+8cXqq6j3y2HjiWr2KbfziMvNIDPKcdIdEYZqDILxLYYC1xRH0xWBMK9Hj/7hItCAAI
         Gtghc3ZYlLY0ZcoW7oQqSVNjWJGu9ZCkoNl0UKXPtdludqLdIoSSxu85MCn9QkG9uvZ2
         YmjbM1fq/MPFnR9v7xc2Ks5912Of7DpVlKpxgflHr+sLxoN8QF0QEsCPS7Y3Y+hDJ2v0
         2ObA==
X-Gm-Message-State: AOAM533vNX/6LudEjV24mHpV0sLUvXpWG19kp6lnSm8PDkdhdDnuzsGM
        JouRsuVnQPSjI7aS8G9gThtU8Zo+Nkw=
X-Google-Smtp-Source: ABdhPJzd7Cn78FGzVrjS0K3+eJDwPpTpp1fb9PhLPN/FnQzhLW7TPUe/YZzT8F0DmIPnqzPoNznQtg==
X-Received: by 2002:a5d:5885:0:b0:1ea:8099:1ed6 with SMTP id n5-20020a5d5885000000b001ea80991ed6mr778420wrf.494.1645469175908;
        Mon, 21 Feb 2022 10:46:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0037e9868e364sm159870wmq.33.2022.02.21.10.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:15 -0800 (PST)
Message-Id: <bdccd96947531ecc352999c764ae0968ea210011.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:09 +0000
Subject: [PATCH v3 6/7] reftable: add test for length of disambiguating prefix
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

