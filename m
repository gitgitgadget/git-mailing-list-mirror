Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C429C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350019AbhLWT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350009AbhLWT3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 14:29:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB9C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so13359361wra.6
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MNKExPXAXPFXsQtxvWEVqdC9mz/V9KWUqhnLUFeuAEg=;
        b=Wui3Zs8z4Jhf0gDK+VnWpzZT5Dc5YvJMpmwRHNtUPa9SaQeN1bMtC8Uxs3NSkIfmeb
         kjhCXtfp/LDyqlLnXzc4iwRhvPKpqhh4omzFIBiEvxjCujaXlXiMWlBZ+Tiif2Eyvib1
         7IqTgj91CwZk/NtUZr3PNI7XGfXdbnJumdA80SCHhmWKy7YkL1DV0MosLaDJmRrI5ukp
         0YGweDusdWPyFry3njTyjuLJiidW5nHGZ95IYelm3v0zn3HRJebQyiYTA8YXc22KFUVc
         INX8J3uT7y0nS2AVljN9oil6t4dX9VfiFuKOW90kuB8ZVAAhbwAcpxeRs/l22+Thaujg
         pe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MNKExPXAXPFXsQtxvWEVqdC9mz/V9KWUqhnLUFeuAEg=;
        b=6SM5lsxK5Gl6lPWkJ68IY34AWs+VZs8eHGSTVQnt/a5c7Ro4aDJLs4RV0cx8EUfsj2
         C91+oAbWsVly4zSOnOpe/V51qcsW8+fGY6bwbykR9vX2yn4ZnRwAAtEukqNJC//fmdzU
         jKFFqsYbDlt/iyilW9iuIxYQoyz4Dob+TSg3LA41VJPfdLWMkKtHgTIxKI3g72sG1Gv2
         +6NpSCvsGLUck8ZtUm6KFJKUyZhdlv18B5zhKh7CUZqmmTX9wiMsLeTZGa42IdEs6aRK
         N/VXM45FpJ2v4ZP9uqZNIEMdNwkCEiZJxxduq7SVqR41LEF+sFS4K/cGwYyJModqwqno
         awGA==
X-Gm-Message-State: AOAM530Xv9ffxqTXZdadUlJtg60lXuMaOVqFdn0lgF0pA6DCN/8AoBQC
        VLuI5oMrQKwcubIA9oNtkq4vRv5xgE4=
X-Google-Smtp-Source: ABdhPJys5TVtaX7C8LLRME6P+2W6/uuYJNIsH4PUI4be+/h71utuZH7RWTk1wdKzueMTKQzWt8bYWg==
X-Received: by 2002:adf:a115:: with SMTP id o21mr2603607wro.412.1640287792325;
        Thu, 23 Dec 2021 11:29:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm5586510wrt.14.2021.12.23.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:29:52 -0800 (PST)
Message-Id: <603b0a1ada98692f504f2a004b49d4f7fe5b30c4.1640287790.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 19:29:48 +0000
Subject: [PATCH 1/3] reftable: fix typo in header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/block.h b/reftable/block.h
index e207706a644..87c77539b5b 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -21,7 +21,7 @@ struct block_writer {
 	uint8_t *buf;
 	uint32_t block_size;
 
-	/* Offset ofof the global header. Nonzero in the first block only. */
+	/* Offset of the global header. Nonzero in the first block only. */
 	uint32_t header_off;
 
 	/* How often to restart keys. */
-- 
gitgitgadget

