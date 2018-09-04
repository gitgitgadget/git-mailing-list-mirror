Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B601F404
	for <e@80x24.org>; Tue,  4 Sep 2018 00:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeIDE20 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 00:28:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54720 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIDE20 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 00:28:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so2530060wmb.4
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oAX/E3mVhuLPPl0fHxdZPBYyNHfuT4LSOmR71O8rwc=;
        b=gjzKAC1huV3Ud16qDR5so82CLsAJKKPI9JFAbkioFwH59PJj2McWZAP3l0z+Bv1IL/
         9KBgTMqRhc1BYwox6HdBWWnrkc68zcnabXI4l5X8Kqo2LHeeIBDwBQ5uyEAqKx72giZ5
         GslAI2vkGyJ6jxiPMizmX+gMu07ykraoK8j7HX1KLJL9VDpSUcVcJV1Ilcug4Xv90aeX
         MRLIKtqcn6phWrg5zX8Nc+LEE8gSUxl5jrFIk1dUoYqEO/Bs1nlUTUT1hPtLpwjLqZE5
         c0V1mXk6csiK+PceVRjao6aGAk+BbrLU9bT4c19H7AIun9ECPZyxXC+3o1WyXjB4R1UV
         1VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oAX/E3mVhuLPPl0fHxdZPBYyNHfuT4LSOmR71O8rwc=;
        b=WvPH8oNZ5X5OQwtl5ThwbCJ9Xpe3XRiB9/WKJO4nGW4QhOlDzlw3xv4RCcTUUjNuqF
         uQiysl+LjSI3P77uGashG2Exf0uoEaHRdZFKdsoeVnwtrj049pzPrHKUaQGRDZLlms0S
         vJkEcnBglWRdxU0P4fTZ+mj05fV5/GU1k5SEBD+cQRb2S1xGeaLHM5sBifLSuNgsTJB+
         G6Zj0AjC8rGdkeRmYYOknVG6jBdCyxW0W5Jy42a3O8sYCvG7oJXaGFt81AY5+XPHMX3r
         v0xFsQU3MnsCbwnYFXRXtGztyehjJqnaPBcTOpp+TIBdjJFUShsVnKC47DUATDGR74T+
         EBrg==
X-Gm-Message-State: APzg51C0y+6zSLTE/DH0xXI6PJ7LrhYpM+j6rVtNhaHgGzMqqNHRVKUa
        8X9sF9KdO8UBKFTPE2umREY=
X-Google-Smtp-Source: ANB0Vdag62gWcxBIgQCJzmv5HUrBK5hyvWjFLHK8gBSxRfF/BuqGRJHxyq4OHjGO65CvIzvXbQHYkg==
X-Received: by 2002:a1c:6208:: with SMTP id w8-v6mr968799wmb.163.1536019555799;
        Mon, 03 Sep 2018 17:05:55 -0700 (PDT)
Received: from localhost.localdomain (x590c2a04.dyn.telefonica.de. [89.12.42.4])
        by smtp.gmail.com with ESMTPSA id z21-v6sm390491wmi.29.2018.09.03.17.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 17:05:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Documentation/git.txt: clarify that GIT_TRACE=/path appends
Date:   Tue,  4 Sep 2018 02:05:44 +0200
Message-Id: <20180904000544.13907-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current wording of the description of GIT_TRACE=/path/to/file
("... will try to write the trace messages into it") might be
misunderstood as "overwriting"; at least I interpreted it that way on
a cursory first read.

State it more explicitly that the trace messages are appended.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dba7f0c18e..74a9d7edb4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -599,8 +599,8 @@ trace messages into this file descriptor.
 +
 Alternatively, if the variable is set to an absolute path
 (starting with a '/' character), Git will interpret this
-as a file path and will try to write the trace messages
-into it.
+as a file path and will try to append the trace messages
+to it.
 +
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
-- 
2.19.0.rc0.188.g56c5ee2db1

