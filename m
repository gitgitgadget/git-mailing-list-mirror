Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC78C4321E
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiBQNzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiBQNzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744BB272DA3
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so9177101wrc.6
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7x4uCn/FbLLnXOpxQxwOKZWEYHfXkWZ+5D871Kaw7Sg=;
        b=ki40QNa9LV6p2wyfiyyL4eP0MlLXUnVheJrIcSEVHbKfyXssh1zCSOjx63CKwefHF6
         nlMGhDCsAimQNW/rcL9gdZw305ONdnRZkyWY50R3tMxUdZgxK1+r038K8fKZyYdLl+k0
         UZ1/RIJlPeicD4SkwIW9+i1/gFVeBFCTPyeyLp5AtWeIZSWApmFZ1yNL8CHuyZR4flZ3
         iZqhXQNju8bJxIcv7kk3EGy2o4W41IE7MLD6iOWmo/fx4VhS+VnBn8jPj4TcFkMZ8Q6U
         9uJ7fX8jLtbLVlZGS6sgxOz91P9C6GKAHezwCX4G1H8kAA5crLryflgTkqJSJ8smQMEU
         e0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7x4uCn/FbLLnXOpxQxwOKZWEYHfXkWZ+5D871Kaw7Sg=;
        b=h2uFYu8W7ikzWrqNZ+0CHpuFwQeq+5DTh/i+DMTNbEzwEMB9D0NoXvF1TRVIvIo7W4
         fXNC4HfNibFrFqWU4W8K837mVGvEdBiO1E7lOriGdGHw4L4jSOCAlt2zNr8V5107tnWl
         D3jrutFjbll1iGvE6Kb5M2q7Dy/79BZS2qx+hUrjSJmiEpxYogrIsnDjY8sP0lrmbU3O
         eNZTQbF9q11oW/04ORZ9eWIpVB9TGETPS4OH7xlGiFeKnznbG6f0cC29MzcNPdx+QGnQ
         rGApzCESMYKQLLVH0nc+4Sk87rAeUP2PIF+K5qTU4l6cQ6PE6R2MrM6oG5HPk0XNyzE2
         wviA==
X-Gm-Message-State: AOAM53200KqbDZF6Fqy0fRx4emOp0aEixC0o6pl9iOG4kpJYfK5QrVpo
        Im4BITcEpukaQgfYb9EKYceZlGeZi7w=
X-Google-Smtp-Source: ABdhPJxbkcEg7RBYqV90+MppIw1WLf9AjkRKFx2wvFClLFDqPPNDOBfkXtxxEN09bcFrO9TPChp1BQ==
X-Received: by 2002:adf:e4c2:0:b0:1e3:3e5d:bd65 with SMTP id v2-20020adfe4c2000000b001e33e5dbd65mr2466305wrm.422.1645106128839;
        Thu, 17 Feb 2022 05:55:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm13754420wri.88.2022.02.17.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:28 -0800 (PST)
Message-Id: <4c1a19fc4aef2742e2733b804221186aa164f721.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:19 +0000
Subject: [PATCH v2 2/7] reftable: reject 0 object_id_len
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
but we forbid 0, so we can we can be sure that we never read a
0-length key.

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

