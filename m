Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0CDC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiBUSrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiBUSqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7DC65
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az13-20020a05600c600d00b003808a3380faso17148wmb.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZ3HRfDEndCA7wAlrfkPT7VVFBdUs+XxOFdsJK7f9GM=;
        b=o4vHeSQ0NDEDSzIq3WEDRMXYzhGQvh61ennof3kLyMZwJgkWqwxR756aTClSd8DcFu
         5r7y4CQpVaSNjP3NATEZ/Tr2uXgYW5PYpU1gXJWM4aliWPZFQXy72AP+eF91qI9o4wXf
         BtEhJgh/U6pA57VcSWz2bns3Dh6Bn82InM9qQeZFpYP8hrCBVB6aaCa4qrbNv1pDm7+5
         Kv2levjCzIsVKl1XbyUTTwkEjz7CEHTAXsAgrG8TdZEy4kXZXHEwiGYH7S3cuXIOuWi+
         bAkwzq9OQ/FYRmGnOZau4a2/wyqNBub3QSQefKvKUaZRK8S3ldwBrIngxsoeQ7kILrvw
         StgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZ3HRfDEndCA7wAlrfkPT7VVFBdUs+XxOFdsJK7f9GM=;
        b=h0E7jS1mfdHav/yluAFQIHbirhAVGHLTh/KTGTrWrm1Jta1vixyWNityoEWQGupn1f
         rrTK66uyoH0Ruk9T1bWzARAYzGtChkwxx4/QtYRgWRlf4T1ykXW90zcIQuQ7FkeUOOow
         KAFUkTKTn2IYJvA1Ibx8yGtlHJK4SOcYoeL7lR9MFWORKZFCaaxUOn7HarYCfXHcs9N2
         Bvlo6i2s5KjAVGIKUAy2wHkYbRKToVoaBhyokSMrzS1Q+M3Qu3w8GMCur17gZrbU4EVf
         HOiSbC+8CBxE+Lslf2Di9C3uTuJY8SmDlOQGRceYPtXeeqbD63s4rQp8mWfG+7ZNdw0e
         rmeQ==
X-Gm-Message-State: AOAM530RY+yiJjZUPA4cM9QE3rP1xDxeQKmXK62u6HiwtkX5yEvVd2Kv
        QCeqB4mBzoR/zjO65NHsddCxFtVoAKU=
X-Google-Smtp-Source: ABdhPJyaATF/NshxxgcNOfQbXvM947Qjo1zbpLbVuHYh0ZDa/V54+tfRABJRSqk6dEjmqIayg1S8pQ==
X-Received: by 2002:a05:600c:2192:b0:380:9319:2eb1 with SMTP id e18-20020a05600c219200b0038093192eb1mr283682wme.156.1645469173585;
        Mon, 21 Feb 2022 10:46:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm227213wmq.20.2022.02.21.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:13 -0800 (PST)
Message-Id: <8b5aebdb07a6182196217f6750fbda95c17d1402.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:06 +0000
Subject: [PATCH v3 3/7] reftable: add a test that verifies that writing empty
 keys fails
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

Empty keys can only be written as ref records with empty names. The
log record has a logical timestamp in the key, so the key is never
empty.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 605ba0f9fd4..fd5922e55f6 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -667,6 +667,29 @@ static void test_write_empty_table(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_empty_key(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_ref_record ref = {
+		.refname = "",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_DELETION,
+	};
+	int err;
+
+	reftable_writer_set_limits(w, 1, 1);
+	err = reftable_writer_add_ref(w, &ref);
+	EXPECT(err == REFTABLE_API_ERROR);
+
+	err = reftable_writer_close(w);
+	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -746,6 +769,7 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_table_read_write_seek_index);
 	RUN_TEST(test_table_refs_for_no_index);
 	RUN_TEST(test_table_refs_for_obj_index);
+	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
 	return 0;
-- 
gitgitgadget

