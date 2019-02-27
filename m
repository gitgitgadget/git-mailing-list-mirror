Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E6E202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfB0SSW (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 13:18:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39819 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfB0SSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:18:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id r123so4805408lff.6
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfgffQqqOTLwvrmsIofFupimNbVLrb2SmoGlEkJUMws=;
        b=Ly28976/HWDTVdJu6KAzG6RsjxxQHgoxcRtwBFCNAkr0pEicHfhqhllhNl/G7pJ1u/
         ly0L8LYaul8LNQ62bzxIaxOtN4fwiA7RFm7DY+KSm2VMZ0aCsiQ03LvRaRyv9MeJhtQW
         CZA0r6BtnoaOeGcnBOGy2hMJ6YM8HWBzZfBlnZVK1+W7MS2ISREgvg7uvONJ7qNDSShD
         pu+7tul/cVDvhId74D226003v8jp8ZTlYs0wh/MQ+WVgpbPACQx1KSyTKhjD9zDR+8NK
         cKmMuvMGN8+9VyLKcjlIF4Q2FQE2Q+0+TkgGb15U+5OHAf5/YKe7wgDBccMGpqiQZaFp
         nGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfgffQqqOTLwvrmsIofFupimNbVLrb2SmoGlEkJUMws=;
        b=UO6M3OP8Q5KNRX2VIesYq7U34+Uog7m7htUHqZLqRwhR/uR7EaxBbHQDypzVNK3GvF
         NhIjccXuneb//GX914Nv5Vy4hv3GS1A3cWIRMx3axz7qbMuevd1v+xAHuUmCJqEmVXnN
         nahHV7GdYa8du7TLBWm2LatKS9NXu5ZHELHAojs0RjqtONwpxub5oTwS9X7WCc5p/oL+
         2W7k3BzrOy+cuB1PxiNFZXqOQw+A7mqoBX0enoGs7CLhXsxSxTYqQ5fdB4baXD4/Wq/w
         aQpTHHl+FT+09txTVoWcgs/DJUi5oyCzWaCsZQmTVEBapnX8ZmulF1OpMQHpUbxm8qGw
         eJug==
X-Gm-Message-State: AHQUAubBvnnTYqI8Oj7RDhxPKcLcZJ0KkGskRvp7A9GCin+xp3sBzBqa
        /g8/eiNZx+IX94hbKzO4yPxR/qv4
X-Google-Smtp-Source: AHgI3IYmBkS7iRm1eKElNPpc2hLebyTAjZNA10h4ysWiJUV1v+1n80Vn4VskLEpsjR3lnAAF7oPSPw==
X-Received: by 2002:a19:a404:: with SMTP id q4mr1517386lfc.113.1551291499142;
        Wed, 27 Feb 2019 10:18:19 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f19sm547297lfk.69.2019.02.27.10.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:18:18 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] Documentation/Makefile: add missing dependency on asciidoctor-extensions
Date:   Wed, 27 Feb 2019 19:17:53 +0100
Message-Id: <9e206ac0e870807d5baaba4e75fe22124b3922dd.1551290936.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551290936.git.martin.agren@gmail.com>
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com> <cover.1551290936.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

asciidoctor-extensions.rb has never changed, but when it does -- such as
in the next commit --, it helps if the xml-files depend on it. We're
casting the net a bit too wide here, since we'll be rebuilding even with
AsciiDoc, which won't look at this file. But since this file changes so
rarely, that should be ok. It's better than missing a dependency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f8054a115..a9697f5146 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -358,7 +358,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf
+%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
-- 
2.21.0

