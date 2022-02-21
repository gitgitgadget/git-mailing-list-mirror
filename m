Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C480EC433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiBUSqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:46:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiBUSqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B53D91
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d3so13008754wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wcUoTutOvmdou1OMl+VGJ/zx0UEqyZ+p8oBLOioNDqU=;
        b=oxJXY+NR2NzhxvjafBX/7GeGGT29kQ6CUw9HYCmn8MKClQaimzb/+uEeKioqK1kpQ4
         zk3R8teilxUUFVLLxo1BpM1q4HVLMuhS493hsDukxVwrXBDs4oqUpFFx9dUsFmZjlLbP
         qpltKjgjo4PkhA0PZzs4r6C8wlL9cFWkvtKhfPIwTsDZO0NJAAAqDxbrCikaRHzpnAMX
         OH2x9te2mV0BlYFhP17f3KEZSDpCr3aFSB9WFZSDbiSjSEjLFRcTxBz6Z83XYTUO9OCb
         DYqVm2NfoiBLcdPua5I4hDipUKWzckAexmK0SV9w5nei7mV6Yd31aqAqoLw24QdNCQST
         1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wcUoTutOvmdou1OMl+VGJ/zx0UEqyZ+p8oBLOioNDqU=;
        b=ghtbqWp1rC03GjHcjgV3jZjfcDHnZEZq5Kpxhg3p5rkMQjb/+v/fYhGsQ4RMAXGAIe
         wmPeINIQVsyuKZ6y65PBRsWWa+LfXZuUf46Zi0757BzHb79jQs/NVaTLN0F+d682wR8c
         E6KWvtrq+PPJoZj5/Rlmk0INW/aR+/nXQkwiZKktuVYnUNPvwmYdq+MYno3mJcT84HiD
         jwmM8gUB8moXzxt8fSXXKguIyMIGvskn9AMF7E/7p6/XFq7QURtO3YlFEcItk9JaRdlA
         M7Fl2xOCZwOw853D40FKKOdFxPiTVUdiWqICwMzDKD3pH2Mz9zhQZZzIvw2mFLJEXJf+
         NCSQ==
X-Gm-Message-State: AOAM531AGkactYj9SFKcp1rfyWtZeqWJ2X0UKufgUnLVaBbf+JT2qwWe
        E1pOW7LtOSYcxOWuiaoZV2GqVsHnZeQ=
X-Google-Smtp-Source: ABdhPJzKUpJ3b5nT4mKeH+QiE6VCgvhKdwRCtGfj7zOLkd/KcgAS93G0eto7oAttEoBbVUKp31AlUw==
X-Received: by 2002:adf:cf0c:0:b0:1e6:22fe:4580 with SMTP id o12-20020adfcf0c000000b001e622fe4580mr16661085wrj.12.1645469172744;
        Mon, 21 Feb 2022 10:46:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay41sm153579wmb.44.2022.02.21.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:12 -0800 (PST)
Message-Id: <68e7bc32ff88da04c66993f68a84bbb401bc54c8.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:05 +0000
Subject: [PATCH v3 2/7] reftable: reject 0 object_id_len
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

The spec says 2 <= object_id_len <= 31. We are lenient and allow 1,
but we forbid 0, so we can be sure that we never read a 0-length key.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 00906e7a2de..54b4025105c 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -155,6 +155,11 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
 				     r->log_offsets.offset > 0);
 	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
+	if (r->obj_offsets.is_present && !r->object_id_len) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
 	err = 0;
 done:
 	return err;
-- 
gitgitgadget

