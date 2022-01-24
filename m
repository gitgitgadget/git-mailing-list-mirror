Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6007C4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbiAXTin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352024AbiAXT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CADC02980B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a203-20020a1c98d4000000b0034d2956eb04so62436wme.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l1ClT/iYWGksB0Zp15m6EJ9+FS/ahsYnhWO0zjx+q6I=;
        b=D+MxVKm2z61hp2+JAkhfFABs5CUAPj0CvKput9w7RUaLcdvpS0a8EUc3OP8ICQYFcw
         3SvIcHfUfS3Y0hc9+fLgg9SYjLefJmLGxT7nc6mj3Wn8jo0OMepW9bBZ4GNncpmhPWrY
         XBLYRWrJiycuXwvTgbFQsW/yKwnzp4zeB9s+at9ue+H0vaHyjUI5g5IppdEs3y2q7TkL
         WSd9ljxuBaeGT/HAttbUncODqb8pboNxBvKmnzLLXhZvINpMDDu4oH160FyZndy2keM5
         JbMdJOuKd+X1UZxTVEWzzc38jpiL5jjh/Xw8FkPhw0zQrqUL6+ltcpNfMT287jrblflN
         35gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l1ClT/iYWGksB0Zp15m6EJ9+FS/ahsYnhWO0zjx+q6I=;
        b=AJZ5xBhl6bqIAANJCU4iqTsDiGRSEVv8C/6UoaCP6hc4lapNgyIo6jUiN9aK77OFJ0
         kei1f5yvy/uF3LiqY1oCtDYbO8L9YKOsI0a9cCfE9HVWJeYtPRIxSYZ4n4FJj88AHk29
         Xx8t4uk81lwB0O3Jd4mihUnASwFOmxGzCpru5FLYYjL+6WWynVeHzYSB5FRFP3aGdp8X
         LSjjQKyXsci20Mf/6Tvhcz8SvOAsHoMVEHeTNlzA+yglI1JRNe/NgfxKPfmfTy5kkJER
         LbGIzGJTVSr+WcnHqgypjXL44CvXr2g+nbXOFLOhHxdJzRIcEkOtbp+n5nUtRWaaAG/q
         RmwA==
X-Gm-Message-State: AOAM530hUaKtKzeb74IgAWxHyDdWLfsXuESQRcTVM6RFTR7xVC4k9Yq0
        G6x9NzY8l7kEQWTyLLyr8vpAioJl4P/yjg==
X-Google-Smtp-Source: ABdhPJxW9cFYDSWC6B/xGiIH0y4pCIW9tahCCpg3A4oXC5joMe2HEFbRfkNIoZKheNIRzo4dPenx8w==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr3050867wmq.109.1643051626372;
        Mon, 24 Jan 2022 11:13:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18sm15847765wrw.5.2022.01.24.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:45 -0800 (PST)
Message-Id: <cc47ec7a50b44e6734a36e1fdb7c21e798efab7e.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:29 +0000
Subject: [PATCH v7 01/16] reftable: fix OOB stack write in print functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Remove /* BUG */ comment, whose meaning has escaped my memory.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6a5dac32dc6..1f236b47d1c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 void reftable_ref_record_print(struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
-	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
+	char hex[GIT_MAX_HEXSZ + 1];
 	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
 	switch (ref->value_type) {
 	case REFTABLE_REF_SYMREF:
@@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 void reftable_log_record_print(struct reftable_log_record *log,
 			       uint32_t hash_id)
 {
-	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 
 	switch (log->value_type) {
 	case REFTABLE_LOG_DELETION:
-- 
gitgitgadget

