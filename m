Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3F920372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbdJFUNM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:13:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45555 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFUMm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id q124so9667231wmb.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ZerLirMbz4sn3wglZwbXgkOwddOMslIYD7aGZh2oBQ=;
        b=AvazV3rBOEwmc5Tfx6jB+qZo/NwprHPJssihwoBi+fPN4r4NzNXMdNeeTKhvORIVDU
         DHwkjZThBLGLD1LEQgSlxXq8oPZ2ItpGMgK4D34auA6PpeWhnCHnI7SGVQ/CzicQnuF+
         k4nBFuj9Ffh+gA+ADa1M+bs7ioXQskhUvkZ7bTOeuRnU0RCq9mrjOOOJYOBT6hUL6XgY
         CdiX61vLxIOHoPHwh7ncsGAKdyygvK/KWT7vQvI48uiztb84BMVLJPULf2snXfKWYt2m
         ZwjPKWxBD3mnC5bzFMZn4IoWoQVoqBUi6NxCrrcOy9bjaZkjnCfyPXSAojSHNETiojEK
         hbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZerLirMbz4sn3wglZwbXgkOwddOMslIYD7aGZh2oBQ=;
        b=t2r4hJuywVsd8py/Vt1sJYcy2CMpTlmS3nzE8ca7QiFnYzDR4qRx5iv//WP0lh/TK0
         +hZBH0f9Li+ei35Sd2QdA6kVeJE5iNPYd54//obFFwk6qhb+E/q6Ar7UVCihAmQThYnV
         jsz4cP32+8gPoy3v355x65pRTz5LXSbUlgLhCKU36uQcxn4U+LWEBnN+osoInMg/lgFV
         XWNkEnnXjBiQoCZ4VR0RTcqfWJFANwfLFa/Zx4TeGOkDNTflWgP7/aCH+MqCzUbhFWpU
         5ah13R/4AE0uboI4DQ1HfFp/cIfupHvQpSvxNdFGT7dq13dOUabY6OyGYjHKVC9TayqP
         C0QQ==
X-Gm-Message-State: AMCzsaXI5ECb3C1pCFETA7i+lf13UauwJuqcrc5BIJJWZFfsxk4MYaZ/
        BH7TFdmZqoxl899K7/4F5Obucpqprb0=
X-Google-Smtp-Source: AOwi7QBlSXEbg7nk5kneGhjjX43qBgpQC2i8hsQpR2KW64kB6QnSwdsDZhApbHUPqP1h+kXPkipyiw==
X-Received: by 10.28.23.3 with SMTP id 3mr2553086wmx.62.1507320760847;
        Fri, 06 Oct 2017 13:12:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/12] lockfile: fix documentation on `close_lock_file_gently()`
Date:   Fri,  6 Oct 2017 22:12:05 +0200
Message-Id: <d613576dfe7010b13157e63b2401d321074bbab8.1507320376.git.martin.agren@gmail.com>
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

Commit 83a3069a3 (lockfile: do not rollback lock on failed close,
2017-09-05) forgot to update the documentation by the function definition
to reflect that the lock is not rolled back in case closing fails.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 lockfile.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 7c1c484d7..f401c979f 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -240,8 +240,8 @@ extern char *get_locked_file_path(struct lock_file *lk);
  * If the lockfile is still open, close it (and the file pointer if it
  * has been opened using `fdopen_lock_file()`) without renaming the
  * lockfile over the file being locked. Return 0 upon success. On
- * failure to `close(2)`, return a negative value and roll back the
- * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
+ * failure to `close(2)`, return a negative value (the lockfile is not
+ * rolled back). Usually `commit_lock_file()`, `commit_lock_file_to()`,
  * or `rollback_lock_file()` should eventually be called.
  */
 static inline int close_lock_file_gently(struct lock_file *lk)
-- 
2.15.0.rc0

