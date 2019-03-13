Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C5C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCMS2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:28:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45559 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMS2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so3088541wrh.12
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2eeGrn/AD0ujkwtoyCIDI3CmNvtFnGH4/0u4v9UQwdE=;
        b=tsPwPumRqzGVy4iNpwBBAZ501GPtHTw+D8ZLpr0QhKk5HEne0NFDbA0pV1+5+bLUew
         MQPBefay9Qr3+uxa84ouQIDIe4ZsFt4/lfcsSxVa+OnrdbiJ6Ju/6z7kIj6o7MLfGsKG
         sSLGuADE/2SUJMMr25HyS3uiAoHDqTw/MNPDILvM54opqfS48V6se8VIusjLsvTETYKn
         9lQNwlifMUviZHppijZy8vg6hMs6Hh2XoJVMonaFzggLDKTs/XgheISRTpHOUcgxnd3s
         HyS7Jw8GtIIGatFhyKe0j2Ago77x95SJ2atabKa+7WjAu+7mTyAFdzmgmE1Tg1yhf+B3
         sT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2eeGrn/AD0ujkwtoyCIDI3CmNvtFnGH4/0u4v9UQwdE=;
        b=CO2mz9ZKOmHyKM4xSfzQmQ0axVzbgOFatA+3CqL1R/aLV8Gf9OBVuWVs+FbRLeDAIp
         3fcNBQSdoF7dIKAaPR69BW20y9AqwSTtBUK9S8owzabT37TsD9z6AGM1mHWIzthGwUI8
         lvg420xM4/+6M1zCGUypuNVJKH4wCw0rXiWJFRSAjCKvQ7KLmCGhQGGf1JhPpPDuN49V
         hyGz3kleCMbKAIcplVob5P2M4e8hvguA/48qGAI9PgTSx1+i3WOcGDYEmWjRJG9/B1bb
         lCh8NUeUTuezciV4P8rY1Q7fkfkLVLg0yb4TfbCRDrCBOpsmseK4wDHHwC2YqGFds3kj
         WjEQ==
X-Gm-Message-State: APjAAAUQ9AiJZPgV4eQb5U6S5KXRafnFPwyHrzyROVIZvvp5nMoViZyI
        jd6L2P8Z9zLk1eyp1gfObDVfTSH5xHf9HQ==
X-Google-Smtp-Source: APXvYqyxMHVfeUMi149k0NvjqFeOEDsL0XnrF2ucQaQaLukvlc+lf/sqX5smyH1nfBItLGMYvtmG+A==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr22648885wre.10.1552501686565;
        Wed, 13 Mar 2019 11:28:06 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id b3sm2793929wmj.15.2019.03.13.11.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:28:06 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/4] am: document --rerere-autoupdate
Date:   Wed, 13 Mar 2019 18:27:55 +0000
Message-Id: <20190313182756.8076-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313182756.8076-1-phillip.wood123@gmail.com>
References: <20190313182756.8076-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This option was missing from the man page.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-am.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6f6c34b0f4..fc3b993c33 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -99,6 +99,11 @@ default.   You can use `--no-utf8` to override this.
 	am.threeWay configuration variable. For more information,
 	see am.threeWay in linkgit:git-config[1].
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 --ignore-space-change::
 --ignore-whitespace::
 --whitespace=<option>::
-- 
2.21.0

