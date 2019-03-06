Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE283202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfCFGbd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:31:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40520 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfCFGaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so8042920lfi.7
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6HZfNHF2F1EuctjDBQmf7V47UrCuX/tUZC9PRQKVxSI=;
        b=rU6XiZunR09sNee1YZfk1WthrhrpIb/ZuF9PcpGFFoIxo2xn8JDjEBL3O4YTV7pV8b
         yZnLAi43yFnswOykNJfSgJtoMhnNC15/HJWDrvC7GJX1ICu7isTJW9g8QCEE7ibtChz+
         PROQ3CfSp322T0P3MrdC+NrOxS9Wq/IsGZ2Jdtp3sCYcWAa7fp0QxaAFf5akBTHK2wQ9
         nVWtTK67B2JtR9ZWSm/23/UPFQvhzx7CW8E6/m0exuoL9KnmWcIrWh7Xj2uoL7AEwgTc
         Oxno34/CoFLp3klQuTt6cXhnmFpLh54YtHSkZwJTbOP9sIaT85HtaGkwdBT8NuN1sjTG
         Qj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6HZfNHF2F1EuctjDBQmf7V47UrCuX/tUZC9PRQKVxSI=;
        b=dEpikOMzynsU8ikl1/X7Ixy7grGJNVsEMwECi6KerzPaRsiBlOJ2PcPIfx+nFDdhyS
         mL2L/sbegRBSEy5Y+w99OF8wn98c/dxXlLXGHmEPmjmVa7eDlJ2OyHCGQAsNJiJydwHW
         WZeJwoMhtyme8AniTCeJBvgf9FenuRGYMzb07yWp+ioWIoZwEoi2rubexVLTdow8j490
         m7UjkZ0im6W02Q5icIL3jBiZDmEFQckxzHYhic0oHueSqjiiPsjY5AWcV+a9uaSvVPF5
         4fEyqB4RxGKWZ1eI3rfX3/NdPIm5NqaT13LL/SjgGaOeH8CJWyRlD5CF/ULy5im4J/C+
         8QQw==
X-Gm-Message-State: APjAAAWYnEltxot23jSzDC0knnkwMqxCOwrCZqfrXjQxtjCDdEahRwuS
        Yya0pVyqIZZG2ZYgFzMEoZ+zvMJ+
X-Google-Smtp-Source: APXvYqxXQ9sAtONDioEc11oaV9VKhpe07GCnIrPiKoqk6gA1JJFlCyck1uieFTm/ZjXekvqpZnup3w==
X-Received: by 2002:a19:e601:: with SMTP id d1mr3048517lfh.71.1551853837088;
        Tue, 05 Mar 2019 22:30:37 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] config/fsck.txt: avoid starting line with dash
Date:   Wed,  6 Mar 2019 07:30:15 +0100
Message-Id: <d3d025240b6a7a18323173cbaeeb8dab72429904.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551853194.git.martin.agren@gmail.com>
References: <cover.1551853194.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This dash at the start of the line causes Asciidoctor to trip on the
list continuations that follow and to render the pluses literally.
Rewrap a little to put the dash elsewhere.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config/fsck.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 879c5a29c4..450e8c38e3 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -23,9 +23,9 @@ When `fsck.<msg-id>` is set, errors can be switched to warnings and
 vice versa by configuring the `fsck.<msg-id>` setting where the
 `<msg-id>` is the fsck message ID and the value is one of `error`,
 `warn` or `ignore`. For convenience, fsck prefixes the error/warning
-with the message ID, e.g. "missingEmail: invalid author/committer line
-- missing email" means that setting `fsck.missingEmail = ignore` will
-hide that issue.
+with the message ID, e.g. "missingEmail: invalid author/committer
+line - missing email" means that setting `fsck.missingEmail = ignore`
+will hide that issue.
 +
 In general, it is better to enumerate existing objects with problems
 with `fsck.skipList`, instead of listing the kind of breakages these
-- 
2.21.0

