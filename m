Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9271F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeEaTx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53486 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbeEaTxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so55817853wmf.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=UuF6sPNxqFjpLVPBvj/Fsz/LAegUD+yYys1a7dSpv5rFWxuxRwK0JacyluwqBJDFTl
         8ZCgOYE/vFzr46gk98PxqWQjxmVSezdQPHHLWdOQyMez5P+sBIYgxIHc24qQvYJIwzfg
         mD6dxdYCZbWrIEPKCzyABQtXTO93LjoF8PKf4I9ruaYLj4pP+rf10ZE4qYxXdWwjBeXC
         BeyIu3sBIFuGqr7mITFPFOfSIj3JbwVlXs70s0UiD80tNQAf3aUC6WroBHJZRKMhlC6b
         FTmQtznJY0Fsl4lMYwzNDnd+SbCuIvU+NF2pZ7rjidnx+WVqNjS9bvUYJM5Qa2edLFo/
         ORzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rKYvEF+swU/2WALNlaiUJm8QtnHf8iC+tCfnyYJ2MrQ=;
        b=AZam9mYD26crQ+5sV2GnhgBzgP2m4D/ZnAVytfP/fpaoSkuzD1rxafwHR4xDyW5ljY
         tQpnr7bh6CL6FuxQdJ1ePSXSejnTXcB5NaWG1qcH62z5/NQeZ6e7eUShWNHPOg1xb/Mq
         xk1ceTSNUycE9twUYsJ+1sl52HwCuSlWYNxgsBKMrEO4B8ZYWJyPl9S/qXwGi6V7ED+c
         BM/POSg9Q4BaXMba5axhzpqF/s7sssRhI3hvq/wyjzMKLypbFECnUM9KQ7mBdtXV3Jl7
         jfIHbRbP4mfqxG+uR0OxbzRud39wooCCN13zGqOtQMS8BvgKIMdmbC7pya6H15roxlWW
         0JLQ==
X-Gm-Message-State: APt69E0xCZcQgH6xlNVoyRJF3ZEBTVK+hJommPkkruKhiX340gfpErdu
        pdDZPrXMU/EMZuk6waq96efMkWJW
X-Google-Smtp-Source: ADUXVKK5FtH1xOjYZkz/ZikfPOqWxcfYzyF160MUwRF4qViAqRlgtR8ZTWnH8dmsgFGxGZpJpVYeyg==
X-Received: by 2002:a1c:8012:: with SMTP id b18-v6mr723588wmd.13.1527796404162;
        Thu, 31 May 2018 12:53:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:23 -0700 (PDT)
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
Subject: [PATCH v4 2/9] checkout.h: wrap the arguments to unique_tracking_name()
Date:   Thu, 31 May 2018 19:52:45 +0000
Message-Id: <20180531195252.29173-3-avarab@gmail.com>
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

The line was too long already, and will be longer still when a later
change adds another argument.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checkout.h b/checkout.h
index 9980711179..4cd4cd1c23 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,6 +8,7 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-extern const char *unique_tracking_name(const char *name, struct object_id *oid);
+extern const char *unique_tracking_name(const char *name,
+					struct object_id *oid);
 
 #endif /* CHECKOUT_H */
-- 
2.17.0.290.gded63e768a

