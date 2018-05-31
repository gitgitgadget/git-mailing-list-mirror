Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4984C1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbeEaTxc (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53141 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754117AbeEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id 18-v6so50486346wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o4ZV1A7yptmojHoGw+4LxyUsicwV5Et6t83Od7Etvb8=;
        b=tOlB/pzZIucQE8y51C4uJIXUdakf9qF2O0sO1iYgLvb7MnJf/k9j5AQJaBbqu6JT44
         qi4mcoYH0/I/z6VYPN40Oqdg++SykYRUOCKCpL8wQ9i9qzYq0f/bAmzxe21fEnDvWuoE
         g4oJPhXTlH9XooajeCCkKjOkx++yCmCuVDZP3r/+tDJksEZdG3uUcETrTxN81AthLltL
         YV9wRCUHa+2IwHdYSLckCADfbsjc+vcF0HI4rekfOr2fEGTDAG2NDH504s0zfxM7aJ69
         nJyXxNruI3R+XgiV1LudAsnde6VNftr8xkBgule+TR05sPEVMqxMoHsJu+W1LJXpwiaz
         f8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o4ZV1A7yptmojHoGw+4LxyUsicwV5Et6t83Od7Etvb8=;
        b=LhEhgc3DG0RUJChe5LoUwKLBlBWpZiAjV17opfHKK8zqRdy+aCZsSiXL+mq4bUay3I
         3PE5fw8/NmRA54oCHuyTTbg+QNGLXjq3vKdFtAfSffMoPFmBdY0Cwj6q3BrFNkAjYa8R
         vyxEIYiNPcaZq1EzWNOTM1pBGZUsQRZZEdPXSwf3PN0zgleWBtA9HZlj6d011xfQcxHe
         bqcE3aUY7hDDkdzq8BLAnPvLAuBKHT0Co9G6u8M1Iq8z04C9jmvGkZtFP0rkTNUyZ6Cw
         ng5wCbKvTPy8Xmrh6sTfwK/nsC1rQqyhJsz65Fwoxnv6mzFKBMZlX81WAW3530R5AdvP
         LFtA==
X-Gm-Message-State: ALKqPwdnEZpPG2mFZLUiIU46McGPYixCriylUq5BAVsYvX2yFU+mgOb1
        jIvxhkOOnu4PgcwE0o2tldrgscUY
X-Google-Smtp-Source: ADUXVKLc6SoXdtBjeoc8MY0Cf0H8owPwowzwQzESRYQprh7KxF+b+UX7XeBrQlQQmSbxn2O3eQ4EhA==
X-Received: by 2002:a1c:eacd:: with SMTP id g74-v6mr706910wmi.103.1527796407086;
        Thu, 31 May 2018 12:53:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] checkout.[ch]: move struct declaration into *.h
Date:   Thu, 31 May 2018 19:52:46 +0000
Message-Id: <20180531195252.29173-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the tracking_name_data struct used in checkout.c into its
corresponding header file. This wasn't done in 7c85a87c54 ("checkout:
factor out functions to new lib file", 2017-11-26) when checkout.[ch]
were created, and is more consistent with the rest of the codebase.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 7 -------
 checkout.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/checkout.c b/checkout.c
index bdefc888ba..8d68f75ad1 100644
--- a/checkout.c
+++ b/checkout.c
@@ -3,13 +3,6 @@
 #include "refspec.h"
 #include "checkout.h"
 
-struct tracking_name_data {
-	/* const */ char *src_ref;
-	char *dst_ref;
-	struct object_id *dst_oid;
-	int unique;
-};
-
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
diff --git a/checkout.h b/checkout.h
index 4cd4cd1c23..04b52f9ffe 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,13 @@
 
 #include "cache.h"
 
+struct tracking_name_data {
+	/* const */ char *src_ref;
+	char *dst_ref;
+	struct object_id *dst_oid;
+	int unique;
+};
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
-- 
2.17.0.290.gded63e768a

