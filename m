Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892B51F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeK0GxR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:53:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33840 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeK0GxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:53:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so17821176ljd.1
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqCg8Lsv7eAvHQY+E17lqiXfZ2265fGhpPpJcwqGohM=;
        b=K9oJBqAQj2E28DGL+Mnw/mWszw9a1OErLdLBmnZWR8iIKhRD49c6SCmzczG1qKQgak
         Kyp5oDRILuS3Yyjaw7d5bzBJb3C8GF6+ij5+7FNCjDEZ/rKIOMN+TcJc1VKXGFhP2Qki
         uWnlKQdbxkJhL0aAfA+B6ne4y+RoMtxb331k/H8qd3XVA3rzeUH5oquK6BjXF0KK1fE9
         iwpJnvbuszhw3FVZT2xQEQPtqwqaUEiYYoQ2u3FmcZbJ7SJUZyIfl8Qe4PIAmj+0db/N
         e3z62lq7qZZgqMqceBYWFUCH62S3DUOagKEpj7y0tSQsou3aBG0JC0l/kGlDy0Oao0fT
         ZH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqCg8Lsv7eAvHQY+E17lqiXfZ2265fGhpPpJcwqGohM=;
        b=N/fWGCaqZYiT8tCy5ZZCuuJ7h9KAK6RXSTW89rBLKlS3alrYL3VTFAzJMVWGBWCsoZ
         eJS5YfW7VL+yeGbujR+0Moicg6JBYmD4EWQN7E57CSHMZt6zu4JGjOFYEPoZE8RQh1iI
         mjb/9YzRPpsQyLS/9Mh9P1vwMjeHjc8bboijiHDc+R5SorEh5PLclFkiW+olKjceAS5q
         ZeFsM8GD3K5ubIwu4W/hPTLMy55c4Q5Wca7hbI57+aQW65RJ1gp7fic0gRkRhkLFdbkV
         7YgXzKYXnqm0mFEwAV/bUpm3cRcmKOe+RVdnrmmUcbZMTkL73FK4rDNico9Nb/0yDTvX
         HAMQ==
X-Gm-Message-State: AGRZ1gLMCu45hzd2aMlhGnkB/EWtAx9rYEsAYCNj0PgMx/DxUXMSnTU9
        HN9dNGxMHpHCW4vy8392EXejEHW1
X-Google-Smtp-Source: AFSGD/X22OdZrKrmYtL9zTIEHzZpr1bLaPgg2EwDwqnDwrakaG+lOwyg32GKLZT2mRUgKLY0cyqH6Q==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr17676877lja.24.1543262283643;
        Mon, 26 Nov 2018 11:58:03 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v11-v6sm200985ljc.57.2018.11.26.11.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:58:02 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] transport-helper.c: do not translate a string twice
Date:   Mon, 26 Nov 2018 20:57:56 +0100
Message-Id: <20181126195756.15537-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 My bad.

 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 7213fa0d32..bf225c698f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -573,7 +573,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else {
-		die(_(_("unknown response to connect: %s")),
+		die(_("unknown response to connect: %s"),
 		    cmdbuf->buf);
 	}
 
-- 
2.19.1.1327.g328c130451.dirty

