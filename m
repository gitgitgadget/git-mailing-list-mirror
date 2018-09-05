Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EDA1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIETRL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44321 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so3585581pff.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5fVHzWDPu9udq+31ahAIMBcpGSJeuwlJZcuOSpRu8bM=;
        b=hiiQr+sYqQMcdwU3nY82ec5JDsbdcN06wQnMdqRJ93tbJloOnbInCHRzntDbPQt3Xc
         Y6e/xecCaui+2tF0ENPuc7D7cIHcDpHFvYCpxb8dWsAklixDDsqmxLPORLjpc6rqwfBo
         PzuRXLL+Uz8AGZ/AJovsl9ntf9fC2jMbYq7h8fD3iGCmJLVlBIfdfM8cj2prI3ypMDDC
         9CQ83GQvIbX/Dd+2jn36ZB9LB1ajWii2g8tOJIbDiRQi3klhptX6VeefEGfnBCZHrn4s
         cbf02mwNnc6ZriZnti1Jq9JsaIM7R5WyoZx20UcsXD3tqEyk6IF6vsf2Vk6Cw69A86p6
         woEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5fVHzWDPu9udq+31ahAIMBcpGSJeuwlJZcuOSpRu8bM=;
        b=E1w8mAn+ae99bDyyQ19gsCoIIG8WjOUvTaNn6KraYPCSEhDAE0obc8RA9/AL3K+e3F
         UU1HazgS/oxO8+SMyo8VyWR6IKaf4+6xnrt28dJD5HaN7cuvNIu5D1AYQeW+h9ZYDJbM
         erDzk56lxjTngboz0Zw7Le0mDWSYSSI8CrgErqT9E7Dv9XrJ11BqNOU++t+ljkLXDFUz
         nnyi+oABHBuXqhpOXQcTs2YBz9yANQxNTvhoe2R7/gf0qshRkbZUNs9W2JX6dIyq+BEZ
         +o0AeG4QSPC/zvoAfwNcwmXrZH17BYkL4yYYXnv66anxPCfwaRZ1kn5bQOp6EXyJpLWR
         dp7Q==
X-Gm-Message-State: APzg51AKJdbatVhKRKP/nHRSIxcvKeUCH2U8BRvzMXS+YTqE5XCatVBc
        XBv18vhV06TPqo2623uGX1UONyiU
X-Google-Smtp-Source: ANB0VdYeyCgsbq0PGFfzYbN5FQYveRPAzjIBux8C2w8McfF2TbfKy5H8vps+ycruPtBCxR5ORDQwcA==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr37223185pgv.436.1536158799571;
        Wed, 05 Sep 2018 07:46:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 193-v6sm3610396pgh.47.2018.09.05.07.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:38 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:38 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:23 GMT
Message-Id: <b747da415cc7eb1e47f5ac377f527957a322b034.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/11] multi-pack-index: verify missing pack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 16 ++++++++++++++++
 t/t5319-multi-pack-index.sh |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/midx.c b/midx.c
index e655a15aed..a02b19efc1 100644
--- a/midx.c
+++ b/midx.c
@@ -926,13 +926,29 @@ void clear_midx_file(const char *object_dir)
 
 int verify_midx_error;
 
+static void midx_report(const char *fmt, ...)
+{
+	va_list ap;
+	verify_midx_error = 1;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
 int verify_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
 	if (!m)
 		return 0;
 
+	for (i = 0; i < m->num_packs; i++) {
+		if (prepare_midx_pack(m, i))
+			midx_report("failed to load pack in position %d", i);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 4a8f231d93..52b7f7905b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -222,6 +222,11 @@ test_expect_success 'verify packnames out of order' '
 		"pack names out of order"
 '
 
+test_expect_success 'verify packnames out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
+		"failed to load pack"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

