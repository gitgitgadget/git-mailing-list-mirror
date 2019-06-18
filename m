Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A324E1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFRX3s (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37561 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so9760799qkl.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TA7qLhwVjgT7/njeUhcABACRPDG7IyBV0uSnJgIka+0=;
        b=OW3grMpaH4E11wreoHadPlHGG/YP31uAA1EWPqBTXpK97MXaC0R1vNWyuZMa6wk+he
         qJ/j8MdVuu+EX0X1LelZ4c+HC6mXnMEhxQpSO87xm9xNnb6niy4jSDRPX7ICimhtgYz9
         xN8wwAwagrU+ZG97Rez6aomqwC+h6tASSJ8FX5oLXnIUk4U4i+Ir4TTx3U1VeNHUcyiA
         aNgk8LMur9e2RnrvQW+EIY2Q00juv1Dns6gqK29OThlHtiff0g+diZc2qDUaaLkKR/BN
         1DKH58E4AwZbZSBbNvUTgqwx6LHFVzXDLerVlW7SwZDpOQJz4lTuAt0vl4wz5dfpFg0O
         0ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TA7qLhwVjgT7/njeUhcABACRPDG7IyBV0uSnJgIka+0=;
        b=f55q92/cIQtXwkIwpP/IRDAox/ADuaSpFUac5Ru6aTD6SqthgpkxBNOwyIZa6td2xI
         mpeRY6wvJYPX3QeCXkDgmFHgfeA2i/d3nYhmGSrYqk54WDB4qfsCbBwpLaaqua0U6kMJ
         F8+zhWMaIU0cq0bcsPXd+RVDwiERUOhU/60hEROR4babZa4V8U4flGs+d7hCNQBXb4/s
         3Aw7S794xqinpYWAF+10A774KEmsGzVnxS24rHOQkwM2xH0o3MHw8uMsV2AD6EhxDujQ
         gQSTxZQbzBzbAabkLzGZdM/oikIbYJ0mAJKAUgJrZSo381ig+EZAur4xGvoiQB5+5OgP
         +XdQ==
X-Gm-Message-State: APjAAAU3qseNHLOwj4jSR33QieN0Iu8XNijyBMSFBXCg3F4GyPPM6wqK
        670sggCYgdZfidBMvrmA/junDrL5ut0=
X-Google-Smtp-Source: APXvYqwIR1eSp0suJleH3eynzrOIE2oTWbIIp9oOX6AKg1nVriHXQpWDz7stVvauEHcIfJ4/makKXg==
X-Received: by 2002:a37:a5d5:: with SMTP id o204mr22089492qke.155.1560900587430;
        Tue, 18 Jun 2019 16:29:47 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:47 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v7 10/10] clone: replace strcmp by fspathcmp
Date:   Tue, 18 Jun 2019 20:27:47 -0300
Message-Id: <1ba1e9c395237aa34e698d5e5d2d0bbd875f6117.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of strcmp by fspathcmp at copy_or_link_directory, which
is more permissive/friendly to case-insensitive file systems.

Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 47cb4a2a8e..8da696ef30 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -444,7 +444,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(iter->relative_path, "info/alternates")) {
+		if (!fspathcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, src_repo);
 			continue;
 		}
-- 
2.22.0

