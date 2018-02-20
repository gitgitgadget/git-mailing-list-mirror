Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708771F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeBTU3d (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:29:33 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:34389 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBTU3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:29:32 -0500
Received: by mail-yw0-f201.google.com with SMTP id a7so10220607ywc.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=s6vGm5nwwMbGlEo7qowKKtRYvypFhOjT8Wp0NnafPDw=;
        b=sR0WaVNDXzD6ESkHnLBnLOu9v2GsMdi6uzVwFjsxmhXTiL88cnP4bmBVoDwycnnilI
         pPsutYDhNRfHkWU7XqMb5Tbp9lZqTR+SI14LGSRB5bSA7lCc7Ce/zj5jqTvBDSd3g9XM
         MJvxd4iCoCS4QW11VTfaOqPjbodrQfTpAwGKbFEd/v40d4GUQ/9Bek2VavKt0HQ99Rxu
         00oYovR2UybV4+EFfem5HM21DDaXaYCPOUlSD7rObVcEIvYY4lFRGUVNSkT9B4tEDodg
         EhEKb82D4KdAdGe8mIIgCycMcY3P8ENi3JBzmJu4K/ydx2F00OGQEduQvprMq9weCorn
         xl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=s6vGm5nwwMbGlEo7qowKKtRYvypFhOjT8Wp0NnafPDw=;
        b=HxiazH3XHueOLZ0TNbXFhboEJCAo83QqRgJxAgbojOf6DZiMGT7QScjFMPk4mApIcK
         uncsJYpTBa0GpABtCVOZvRe0HpoQSVpIXsRl8YHU3UMqsxhd1G5xtZrk5rCZVtE6ktOb
         8ED/n9w7tpAgL//mrK1PrPQyvmTRdNHXjEESW6yYoYuzdS2VWJHpK7BfE/qn12bD0B8h
         3oprNTCGwoLTYkIeMJYc97yxvkAyW3iePPLiA++e/QURFbqfqcUf7Cvmy1CY/djp8asp
         8lZzpJQmTjNRAXwc1RBuUKijF+q05zvcyk/roC2kckE+P5o3vDz67BZcvpy1z/HVxyLB
         6GZg==
X-Gm-Message-State: APf1xPAQZfnPuy6ZWMWCq6nR9aJQRp8HsIP/MLr04b3fiIPOl+tE7U8S
        85bn4BT9Qc70GCRqQ1KbFM5NVpPhkkGEImUz/6JAROt4ffgV4zTJ1zfdSFbzqR1hs9Bm50yVWAc
        mWWOAZ+FcXjSkYEzJ0tgwHPho/PspgpGGyPE+0yAQKnbf32asKIcPl4238A==
X-Google-Smtp-Source: AH8x225JjLY6k1it8MDTQoDMM1zkZOv+61YHeH6bJDbPHXV9531qPDDCmXTKw6NRcAuMNp8CVT0nGBAbrCQ=
MIME-Version: 1.0
X-Received: by 10.129.57.139 with SMTP id g133mr478655ywa.148.1519158571886;
 Tue, 20 Feb 2018 12:29:31 -0800 (PST)
Date:   Tue, 20 Feb 2018 12:29:22 -0800
Message-Id: <20180220202922.220568-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.108.g1cb35600b.dirty
Subject: [PATCH] submodule: indicate that 'submodule.recurse' doesn't apply to clone
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the documentation for the 'submodule.recurse' config to identify
that the clone command does not respect it.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10..59ff29d7a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3210,7 +3210,8 @@ submodule.active::
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option.
+	applies to all commands that have a `--recurse-submodules` option,
+	except `clone`.
 	Defaults to false.
 
 submodule.fetchJobs::
-- 
2.16.1.291.g4437f3f132-goog

