Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878DC1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeC2PDz (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:03:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35947 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeC2PDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:03:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id z143-v6so8865717lff.3
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lVMMlGrFXQaWxyJstlKiFjkPYy66fCW9b3k+ExmuyU=;
        b=eZ+LRhIlhrwMUedU520rt7OHPI8OCJt9enXx6G+nJMNsic00aP+72Co+v6JRa8mF9U
         hPt/kW4DZJFIfVun5PSjnaZRk4i5uNYvhOivRZ3xYwYz0KsZ1oSadi+lowbtYscldlEq
         W26O2SJac9RnC8KeZFSZB4tqEe0SpKAPOKC5z7Z4UTNS8u5DRGEWHgkVxT6ZF8l4/V9x
         6xeOO7Da6YF/H6l6wKM2fkse1x0qCB3Hvfey+xeBM5mOQcSnmaUNUOBMrE0hqTwlvtFh
         TKHYJK9A1k+W1VcvhQ5U4LF9oB5QKyWUGJZ2BK6puunApDgMSSmOK6nBzLgOrZQBKpur
         id5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lVMMlGrFXQaWxyJstlKiFjkPYy66fCW9b3k+ExmuyU=;
        b=tg6zVNr9M5xWB0lPC07m9v+GuDmSNBtfRdnbfwFdNQ/PRZj4X8BYYWFbbtsk6aqE4t
         9qyoIFgDlRYe2cIcs4fV/AX872zcJyQoC82xbLcF4oPGO6MZkPcvije2yjlEqErIg7gY
         W3tZ4gWPNBzQI/JNvgAmrrZffTDGye93LBHsPR+KUC+XG9oSb3uVQPOfk117n06LlsLJ
         CUdAMc/5Xd8dthm0Xlgxh43/L083nrBYmuQaFR8DUtr1xZa+CPQqCWU45qSZAn0RGONK
         4YTyu1BHfHAmsrt9fR9d6vuooxZo/eTaKsbSE2iQUwJygAtI+BxoxC6rYH4SLHiKz8Wb
         Fwow==
X-Gm-Message-State: AElRT7F2oK+7VqZmMw+7/uCrDTBerOLES0mVldlqVxYBaJjuZQX1CR7t
        +Uwi9+2CXtrg2BK8lji5QaOZyQ==
X-Google-Smtp-Source: AIpwx48rMN6uZ1LSxUKVPpJ0fZBu8S1yKU4pxvN9HQHhIH7RyE0o9CDo4GiRreCMGljJ7rRDtQM7uA==
X-Received: by 2002:a19:9dc5:: with SMTP id g188-v6mr5835520lfe.95.1522335813713;
        Thu, 29 Mar 2018 08:03:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1186265lff.64.2018.03.29.08.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 08:03:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ramsay@ramsayjones.plus.com, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 1/3] connect.c: mark die_initial_contact() NORETURN
Date:   Thu, 29 Mar 2018 17:03:20 +0200
Message-Id: <20180329150322.10722-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180329150322.10722-1-pclouds@gmail.com>
References: <20180324125348.6614-1-pclouds@gmail.com>
 <20180329150322.10722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a series running in parallel with this one that adds code
like this

    switch (...) {
    case ...:
        die_initial_contact();
    case ...:

There is nothing wrong with this. There is no actual falling
through. But since gcc is not that smart and gcc 7.x introduces
-Wimplicit-fallthrough, it raises a false alarm in this case.

This class of warnings may be useful elsewhere, so instead of
suppressing the whole class, let's try to fix just this code. gcc is
smart enough to realize that no execution can continue after a
NORETURN function call and no longer raises the warning.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index c3a014c5ba..49eca46462 100644
--- a/connect.c
+++ b/connect.c
@@ -46,7 +46,7 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int unexpected)
+static NORETURN void die_initial_contact(int unexpected)
 {
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));
-- 
2.17.0.rc1.439.gca064e2955

