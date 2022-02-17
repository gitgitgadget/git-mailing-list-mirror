Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D361BC4167B
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiBQNzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbiBQNzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC601273756
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso4586586wmi.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZ3HRfDEndCA7wAlrfkPT7VVFBdUs+XxOFdsJK7f9GM=;
        b=Drbr9vdmigJDqD2KbuRRpvzTH8HY312jfl3WW6FxaHeXWCnzlPDGAjegWMBunjGNZT
         De3A/ESmqIgNvfH7jYZGohXIs6Xr9CeKzy6j40XL3gTF6HN3LBzrDcRmCd+Yk3zYGFbc
         4FNhAHMHwVep5ydy1IyQ0i+f8H8pWHLk8DrXf93vvVgzIlzix9D68RAZ8isAEgXqsUZJ
         X9tKzkUDDMdDqlRbCOOoyUqoDyTvCLDRfsB/hlQUHH3YFVwBNu/IkcmMEiOB9Czmitwh
         LlyMBWSYLu73uxw6Troz/d/CXFAcFn9xCsT9gloNSiIbfeFNHCsyWkPR9XZxvAzP+Lyk
         OF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZ3HRfDEndCA7wAlrfkPT7VVFBdUs+XxOFdsJK7f9GM=;
        b=k/PgHqOn6aFW3ili9jomNSRK6ZFB+LL4mJ9KZMHt0NOqrhWDFCCDINzYoHjCPTs4iJ
         FqW+VrLY6yGfH7uS8Apy/UJjv2aIYzQCzJMrqXg0HyCE7PhTLjFHFpJ//tNkpYtlwLWa
         Wm5tYdgo5nGbMGKGzYJ5x1Sxn+JFgR9pwy9h994RFN8ff0OQ6dHd00gBTRUOLFomt+il
         BfGUbxOAOHcyDSAQYbZn6EC2OFAC4yJoAyN0NAcwVGk/XQCaR8Q/wpF+TsysiS+8DKz1
         QIFeoJsrvp+/igIC4qTYLj4XVH5B37sofrteH4iongEO7jq6u1Pn8JGvHwUMOPPG8ac7
         2H+Q==
X-Gm-Message-State: AOAM532wqJPjGO8BxcsiH0BGC/WHAM+jc7xT8cdqP2lKymNCiIBnF//i
        xKpIHoi422g3m0gSIDR+CChbDVKojg8=
X-Google-Smtp-Source: ABdhPJykkWLjIvl1QpzmzYvbafChu3jYjHvTW0RDqUkNBSedmnJAN+ww99cBpIQ+PtLXQG95Ep1s7w==
X-Received: by 2002:a05:600c:3b87:b0:37c:af2b:4f36 with SMTP id n7-20020a05600c3b8700b0037caf2b4f36mr6271982wms.132.1645106129765;
        Thu, 17 Feb 2022 05:55:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm34451297wrm.105.2022.02.17.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:29 -0800 (PST)
Message-Id: <600b115f8b17322997bef9092349c13d32b6a121.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:20 +0000
Subject: [PATCH v2 3/7] reftable: add a test that verifies that writing empty
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

