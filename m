Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CBCB2023F
	for <e@80x24.org>; Thu,  3 May 2018 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeECStE (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50527 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECStB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:49:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id t11so585238wmt.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=HioJfWw0yRNxjPPyIgA4/vmiLYPKioo7s5/XNapITkp/40WUZywssrHYuErYoq66rI
         TctyUZudT6u+qyAUQHJwwv/8PUjfnNVY/NzJ65evrzSAgyXFIiNw3MbT/FgyTunVdD1W
         IugfKuaAFLpKCUoMQcKfpRsQkuTpaQD/yzn+hGVkggM+KkPdaPhRjdVHXQNqN7lbfIpy
         7TJsqXsD6sJiqAIkTQrfAW6kdYcCXk6120agODL+BGrmy1NI8kK0hDldFoDXmCU/5IaM
         xVRx03ltK/KK11pvc1d5oD8F4QDrGY7NpY07uKZqBcMtawUWoiOxBdPLG9auNfmDIWdq
         5AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B4hXo5YaDn5U1Ksa0qpcR1iow8jFE++N91lY8/P4xFo=;
        b=TlzXPVs/i9BJSUsNOzHD2WNAyJXHqHFMdS3lbUaqzgrmXzB+jm5rLwbAxk6zdu82/b
         oW1WCg5vYaAQQUrHWfuza3zMqo4onu3y5o4164jbDluOgVjkoAmOgNIG5OsapPb9ckh+
         fEPZRp9wnywv2ZqeYaBqPnqpQwpNyAOAMi4IqRUyOqv40j3zqnVzS7C6HVUlfwsrIpPV
         iNhG9859ALPwVvEuSn85x/jo4hXlZbzk+lmSGnnbmHZeSujB/UIDe1WZYPVP4Cm11BbS
         IQI1EDlijEts1sbUZgPJ0LG52tqd0E2xeA/Dlk7JpJ368AayW3Vqu2GEzbazsswcXU4f
         GI0Q==
X-Gm-Message-State: ALQs6tAEJetcoboU97833rAdKWVMHheodz5f6UvSotTRZ6dnyVgGNxOp
        qrT4uZE0WSPs8ZhF1jC+TGmpmAqG
X-Google-Smtp-Source: AB8JxZpppjvYA6PxJN+cCVScvvMRi/E0QhEj9t7mqUiBGPXvtEQ/W8/grtQ1Kbuj8C0MO4YKI19euw==
X-Received: by 10.28.157.198 with SMTP id g189mr17019127wme.50.1525373340389;
        Thu, 03 May 2018 11:49:00 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:48:59 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 3/7] doc: clarify ignore rules for git ls-files
Date:   Thu,  3 May 2018 20:48:26 +0200
Message-Id: <20180503184830.11889-4-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explain that `git ls-files --ignored` requires at least one
of the `--exclude*` options to do its job.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-ls-files.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3ac3e3a77d..f3474b2ede 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -53,7 +53,8 @@ OPTIONS
 	Show only ignored files in the output. When showing files in the
 	index, print only those matched by an exclude pattern. When
 	showing "other" files, show only those matched by an exclude
-	pattern.
+	pattern. Standard ignore rules are not automatically activated,
+	therefore at least one of the `--exclude*` options is required.
 
 -s::
 --stage::
-- 
2.16.2

