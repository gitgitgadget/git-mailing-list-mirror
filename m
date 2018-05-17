Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172231F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEQTrG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36191 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id 63-v6so109037pgg.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O11qhqN1qm9jFBlZubt0tWfbq0YEk2F5H61HZfdmgQs=;
        b=GEpzE7RFan4MD//FiKn8ju+7gbjUJjPJTsXT9ptZtBzmg7dal3UoV42EOZzJwsuWf6
         BreJ+syEnDGujEstDIp7eZGPtYLCcwkeY6SHLaJxF74fXQvf8DfW3ZdNOfvwzL2UYdjN
         IlwwHA8edPLu0iuWlVtUfwj48koHH5GOScl9w7+j8Esy4xBV/AlLiOB2CXfRX+Uf4UJp
         v+yF/LtUpVOV//KXQoCwFiw6z2PW/V/lQwxIeBPjh7r8J7nU9I4aHIexm0fhOjRS+iF9
         8Nfg379oOiQDkKi1iZQfm4zkn7XP/vdYRFTKFRy4WuxxPK6HbFGlizXje+WBr7O5TPyb
         i8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O11qhqN1qm9jFBlZubt0tWfbq0YEk2F5H61HZfdmgQs=;
        b=l6SxVFkwH49ISuo7cKxb7Mj9RRL9okpCw2rY/MfeBPxrg8XL3k2pAyOxg4qm4Of7bR
         ao9i3Y9Nof4eDg0Xjbb+sTbAyzBzG1EKdmKImJy41BV/bsDs2x72ElZZ/6UMM60AgqUv
         6R4Jn/54fXWGpJu8FoImPnEBiogmHEk38rYIL7fRfmgZ8m8bV3MyisH851O7m+IeRjmo
         SOjyIMvjJl4IGqptpJ6ZWBwOWayZ43yyXII6iLN0aPkWhRgFyuZoNpcZlWs/pdtnvUQS
         9pAEEQr93Ergi0vHclN9SfsTagWp/DpUk9a7hHa7gnJosBxpkIPXOPnRXxlWEP7bTWgW
         5+9Q==
X-Gm-Message-State: ALKqPwcearZRPcI2yMCz3+B5Cuj0NUeVXFKYzKk8SfxSV1zBjY+si+1d
        fV1if6d8an8jsUlVRavDB9Z+9w==
X-Google-Smtp-Source: AB8JxZpzV2rUjhAKPrVH680dml14TLtrF3QVEix9p0G5Q1Y0CmfehpB9bQV/fhv0RNT4lMTGiSA/vA==
X-Received: by 2002:a62:fe0e:: with SMTP id z14-v6mr6420896pfh.73.1526586424695;
        Thu, 17 May 2018 12:47:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d19-v6sm14736426pfk.59.2018.05.17.12.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 1/8] xdiff/xdiff.h: remove unused flags
Date:   Thu, 17 May 2018 12:46:46 -0700
Message-Id: <20180517194653.48928-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were there since the beginning (3443546f6e (Use a *real*
built-in diff generator, 2006-03-24), but were never used. Remove them.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c1937a29112..2356da5f784 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -52,14 +52,6 @@ extern "C" {
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-#define XDL_MMB_READONLY (1 << 0)
-
-#define XDL_MMF_ATOMIC (1 << 0)
-
-#define XDL_BDOP_INS 1
-#define XDL_BDOP_CPY 2
-#define XDL_BDOP_INSB 3
-
 /* merge simplification levels */
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
-- 
2.17.0.582.gccdcbd54c44.dirty

