Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A095B20372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbdJFUMp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53610 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdJFUMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id q132so10051955wmd.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSWwDSa1aRDr1APyznlCM1XNVehiY3NmBR0FKYpfkUc=;
        b=sMbzFkXUhJSQiY/3AJa6ofYMMoPFDHGz6mej67QQEK8UuqJqVYc1PHaspYVu+D0ViS
         81J23WUMRanWyzRkV9AqCi5dxcuqQZmqEiuJBE0/W9RgXBAzF0H3FhVrDWeJLmC0nIpQ
         /3XucIt3JiCWCTShQCNkGEIxkUNVvalBjRe3XGmX8K+4r7BUe14C5UQQY6G3EOfTC6S9
         X5Ea7y4yovIaVBTwUq2Wd0Sf4/NjMY33m5iKwBcoxUbund8/FYjPoOhJ56OUjCuVJ7B7
         x5wCId0XjwsyvP4qVmf4+p5q7Ls42HwyCTyEa83bBJLTNxVfABS6FlyVM5Yoln3OyGR0
         P0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSWwDSa1aRDr1APyznlCM1XNVehiY3NmBR0FKYpfkUc=;
        b=GfJSdpFPPyqdLxyBfzaoR7BIinwIRTMuvDK9x7Z+HxWBcbXGa/9K8OGgzxeDEUnTIs
         cLpuOi6Fi3sh+XlD247ob4h2fEUtuGBb3yqxuDnjlaRlODuVladD/Bh5+j7D+Ft3AaIU
         ve11rT9zRWiy+BU/4zv7EGlRQMdTUhoINMBIkxbtaZKHo0z37wzYesjLPszqhS+hJjBF
         cyDWfDK9CqNUnnndyV7BfIoV0Tsc4OC++tcPVIq8MwDkpLa3J48zOxYEJDL1fpayJPpO
         +hVakNee0oDWvxNC6cWjCVIfIGslFYisFnG2RvJI4vElkTaDFuwuj7KG7022Eswx/cme
         IhmQ==
X-Gm-Message-State: AMCzsaW+4YLKtyvWOEQO0wWVb0FI/n7aisut/iwOazPGhPVS/7uTarDU
        2I89FYPfdChyHW7ANNuir0JNpHg4wmc=
X-Google-Smtp-Source: AOwi7QCPFXuvV9wtbVaNb937kANSDgq564kUqb7iMQ2KWcW8qUPVh2dcVxhV566XS1WwnNQ8xy2Xlw==
X-Received: by 10.28.157.83 with SMTP id g80mr2853472wme.9.1507320762578;
        Fri, 06 Oct 2017 13:12:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/12] tempfile: fix documentation on `delete_tempfile()`
Date:   Fri,  6 Oct 2017 22:12:06 +0200
Message-Id: <5de134ca8594de22f2a0b738824f9b5176ae6c00.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function has always been documented as returning 0 or -1. It is in
fact `void`. Correct that. As part of the rearrangements we lose the
mention that `delete_tempfile()` might set `errno`. Because there is
no return value, the user can't really know whether it did anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tempfile.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tempfile.h b/tempfile.h
index b8f4b5e14..450908b2e 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -68,10 +68,10 @@
  * `create_tempfile()` returns an allocated tempfile on success or NULL
  * on failure. On errors, `errno` describes the reason for failure.
  *
- * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile_gently()`
- * return 0 on success. On failure they set `errno` appropriately and return
- * -1. `delete` and `rename` (but not `close`) do their best to delete the
- * temporary file before returning.
+ * `rename_tempfile()` and `close_tempfile_gently()` return 0 on success.
+ * On failure they set `errno` appropriately and return -1.
+ * `delete_tempfile()` and `rename` (but not `close`) do their best to
+ * delete the temporary file before returning.
  */
 
 struct tempfile {
-- 
2.15.0.rc0

