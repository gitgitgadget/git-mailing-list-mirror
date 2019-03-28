Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72FD20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfC1QO5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfC1QO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so23643774wrm.4
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXlEvWIWuf0LfwswZtIl3cIBvHeegqhbRdOcFQ8IUNo=;
        b=UtvZcgeLKNdzMqztBG52aTPTTyG2I+x4oJ7KrKu/hlWBPQQEKEwJSPDeL8/tI9eHZG
         qM01G+nkK4RvImGflWPNU9vg02sj4Z7PhgpYdVwg/AZxdIearEdA5+xIFiF1WylmtK6f
         nLtQwMASYxb+9O4jQQWioD8tsezec+JfxZxC8DVLpgmU8YWiWrAsipN5OXAn4WoGxDz5
         aUiOlQ0cJlBgnwoz4+juOZe/7w4fOq4a2rdk5QXlfLJ76HPs5Yz1J3dbw8Sb57oiTc3Y
         omOaBICYj/xRXwOa44xATrYB15rRhD2XZU3xhRG3ILNUV5moA9MUiNoRGDB/D7aBTLV0
         xM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXlEvWIWuf0LfwswZtIl3cIBvHeegqhbRdOcFQ8IUNo=;
        b=ZrOESkxtu77EwOFqxClUR6jTgV7oXKdwf9mDo585QfwcbVgzO8AdAA3lKc9gDkNrF/
         lNWifKPmystZor+Sc4NDlQ+u2xDA98lD69uBO89Ak5Mmo/KwtpHX8414UxXcDeoSjkJN
         wZ9EptuWT530blpdXGoQCSgjagHOsw4U0ERT2Qij593UKzoFwlMlz8HpPxXfT2RJJZRt
         4zqgiHsbjcvboaA4ct8uF1SdzwPIiE2sQydPoTAcZ7Dtb1Jf3Qc6MELRxlyKg/pV/AZB
         fwdpL2JuDfZzKXHb+Kz7eLUkE4Qf9ACM9xO5W9gb+8NQto11k3uqbGXg9WSKFtDX4oT8
         BqDw==
X-Gm-Message-State: APjAAAXY1h0gMsPora+jHQRYcGIxD5/O+Zc125TPEiX3n915n2+Ku6/8
        aF0NYNoOdbFiSm8gRxOwjh0yUdQzNpQ=
X-Google-Smtp-Source: APXvYqxxHCsYVK9VH+vn7TH4RjlycB+0V3If1I7ZPm5mnY+WnVa+KKWJuR/zWDM6gOfYokR+4aloSA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr26923392wrs.310.1553789693738;
        Thu, 28 Mar 2019 09:14:53 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/7] reflog tests: assert lack of early exit with expiry="never"
Date:   Thu, 28 Mar 2019 17:14:33 +0100
Message-Id: <20190328161434.19200-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
and --stale-fix isn't in effect we *could* exit early without
pointlessly looping over all the reflogs.

However, as an earlier change to add a test for the "points nowhere"
warning shows even in such a mode we might want to print out a
warning.

So while it's conceivable to implement this, I don't think it's worth
it. It's going to be too easy to inadvertently add some flag that'll
make the expiry happen anyway, and even with "never" we'd like to see
all the lines we're going to keep.

So let's assert that we're going to loop over all the references even
when this configuration is in effect.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1410-reflog.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index e8f8ac9785..79f731db37 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -235,7 +235,9 @@ test_expect_success 'gc.reflogexpire=never' '
 	test_config gc.reflogexpire never &&
 	test_config gc.reflogexpireunreachable never &&
 
-	git reflog expire --verbose --all &&
+	git reflog expire --verbose --all >output &&
+	test_line_count = 9 output &&
+
 	git reflog refs/heads/master >output &&
 	test_line_count = 4 output
 '
-- 
2.21.0.392.gf8f6787159e

