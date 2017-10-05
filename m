Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C3C20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJEUcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51086 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so4143463wmu.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NkX3UXctAgczppqMQaTbVP5jGMzhl5x1Ww44e1UIpw=;
        b=PlXVUCAHvzfgb0UCKW6ymPev4DtgkR7TTTlECzZvOU6T+FO8vl8U5ragjwJd2ouXlh
         oDbyrm+RnGsrlaka7JT2FuO6ODNA97R0lJtAZHqICGt5mc9c9EqO31fMzJNm6HdtvoT1
         oe0Wk/fn05UB69LEmsLur0mzOoPILN4Yh6t4Trq1Z2dcLNU4GyThKhJXzFHK74GMvrd4
         JDc+jzUiFtnIghf9Ox/OP5CgRcWZbYoA/BII8o2IjNGEWJCBT39vgrl/MeJou9sSQ+cD
         BhGs1MJOtk0AladzxUgVNyHS2v/ocr8+VjFYNclSHhVeiytVYSTQcqYuSNbDeCky4hri
         K4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NkX3UXctAgczppqMQaTbVP5jGMzhl5x1Ww44e1UIpw=;
        b=BqG93lnOOmK0pXpovWweDPQitcGVlPx+okBR+j305qHMLYec2QlaqC56htAMiOrom2
         u8U6sN5UpV47PWEubvcqxCy8TThOfDUZ6VyA+3lLPUtIFifid+FdibGwtHdUEHtFl8A7
         OuKhdpgEYZGodFT9u+2/fOTLJP9ZmsM1fjc/dHb0N2VWkqVpzpQJX8CZz+XrQiKDPhQv
         VCbALJTGBOhEkPpNJ2jHiXFLFRFtCfMlfwTo8oy0IpdQz/zVDwuJNXzrou9W4sVEaeHF
         mblGsgAiMYxg1uxiDt0358ldTmyRs9QOht9LeF4c1O0xktro0ycJyYdp/xdKeV/EJYyx
         Xjqg==
X-Gm-Message-State: AMCzsaU6tdcivO24rVyjOAE75Ad6d4yzL8+8gmu5TRWwUJ3An7fmhddz
        8XZ8QYfXqzhQ71wyohFhIpx/oBSN
X-Google-Smtp-Source: AOwi7QDZwyz33HbtdJlTcOotNyofAL72UClNq0ijl63OM8Z5id8/75edg6SQvLHihvCiYEmYSpJAcg==
X-Received: by 10.28.139.72 with SMTP id n69mr281246wmd.29.1507235561705;
        Thu, 05 Oct 2017 13:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/12] tempfile: fix documentation on `delete_tempfile()`
Date:   Thu,  5 Oct 2017 22:32:06 +0200
Message-Id: <d7837015eb5706a32918b6a87688d9ac895ecb81.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function has always been documented as returning 0 or -1. It is in
fact `void`. Correct that. As part of the rearrangements we lose the
mention that `delete_tempfile()` might set `errno`. Because there is
no return value, the user can't really know whether it did anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 tempfile.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tempfile.h b/tempfile.h
index b8f4b5e14..450908b2e 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -68,10 +68,10 @@
  * `create_tempfile()` returns an allocated tempfile on success or NULL
  * on failure. On errors, `errno` describes the reason for failure.
  *
- * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile_gently()`
- * return 0 on success. On failure they set `errno` appropriately and return
- * -1. `delete` and `rename` (but not `close`) do their best to delete the
- * temporary file before returning.
+ * `rename_tempfile()` and `close_tempfile_gently()` return 0 on success.
+ * On failure they set `errno` appropriately and return -1.
+ * `delete_tempfile()` and `rename` (but not `close`) do their best to
+ * delete the temporary file before returning.
  */
 
 struct tempfile {
-- 
2.14.2.666.gea220ee40

