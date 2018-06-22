Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7CA11F516
	for <e@80x24.org>; Fri, 22 Jun 2018 19:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeFVTB2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 15:01:28 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:42824 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbeFVTB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 15:01:28 -0400
Received: by mail-it0-f74.google.com with SMTP id y23-v6so284084itc.7
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=M4hO0qB0rT4b1h+Or7WbCnZ4x66DJx4Cz3xAR8k7Mm4=;
        b=TxZW28bszzs6B/POxfHif/P+iehzXyN/Wqd8b0vI3f6d+t6j0GRrLohIi6eyUEI4hD
         7YUBRoYHHCM8cM/f6sjpZhCbosieJWyop6srwo8ZSzCawT1RKZFLyvQyri9UjOeR0C3o
         lU/NICBUp4dPY8nRw8FTeJMsUPI49wpfPJMK7MrfGgs6mzj5El01eGH87nec3dnGmcib
         0B/BLUfQHxP7rw9HXWVNxTBTQMNJ1EKo1jRx2KZvv8hRekwruekRXyq2C06UOnSrg/QT
         Vr48gXfuA+oQJdsayaKAQhJwW9nIbicmI5IVckjFSQAOvMh/dUX/C/HgbVrDXovwI+ca
         4G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=M4hO0qB0rT4b1h+Or7WbCnZ4x66DJx4Cz3xAR8k7Mm4=;
        b=lDU8ou7l/HJCe/1aB4MSafpEQktB26AyLcElad645LZwI8O9T74ix5luXcGTQBeZCA
         mKuzE8rM9pxTYPffvXuyaFpUclmTY2dzQ3YIksxgBfeQp855a0wbbk/r+FJHG3zc1LnI
         0jtU1yqar445XF8HSP0po8LDT1OCRE3zRuE90RxgUVD+EdtpaJMxKx3+o1BkwlzxT2cD
         9OZ6exPP3KHuMcZcDP2WyzMOc3X8Y6E4FYDir751v2A+XpBXDjvjgoY7VI98vHZlVOBS
         2o/QN+ry8rlKmMQ72A0WJ810da4sdF+qU1L8pD7YMetJfSBvZq1nNBxS44zgs00pdnoh
         pk2w==
X-Gm-Message-State: APt69E2JMMM42Cp+X+jLLCJPSccb3pponW0sjVnqgADlOdoToD6evADJ
        SfrvAE4xkjXeJEEKMCak5HygCPHA/esv878T1sm2yDEGD3+gsg/xCeKaOHB9u2pcLdBiM46kz53
        U9NDqCGKGdwovnFIOL1QOgAsHqq37Glt2JsS1X3VjHb0Nvh0isDUh4aQsc89IPK0=
X-Google-Smtp-Source: ADUXVKL0KqDb1Q4zDFCJl9hrtTL1geob1EnpoSiVue2FC/A0etckYQZ3bSyoycrmGulbOvPKBOv8eE8ydSMSbw==
MIME-Version: 1.0
X-Received: by 2002:a24:4314:: with SMTP id s20-v6mr1219907itb.4.1529694087521;
 Fri, 22 Jun 2018 12:01:27 -0700 (PDT)
Date:   Fri, 22 Jun 2018 12:01:12 -0700
Message-Id: <20180622190112.7559-1-steadmon@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] protocol-v2 doc: put HTTP headers after request
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP servers return 400 if you send headers before the GET request.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/protocol-v2.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 49bda76d2..f58f24b1e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -64,9 +64,8 @@ When using the http:// or https:// transport a client makes a "smart"
 info/refs request as described in `http-protocol.txt` and requests that
 v2 be used by supplying "version=2" in the `Git-Protocol` header.
 
-   C: Git-Protocol: version=2
-   C:
    C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
+   C: Git-Protocol: version=2
 
 A v2 server would reply:
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

