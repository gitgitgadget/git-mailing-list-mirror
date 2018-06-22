Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C341F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeFVB5p (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:45 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:45274 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934246AbeFVB5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:43 -0400
Received: by mail-qk0-f202.google.com with SMTP id o140-v6so4204830qke.12
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/wixFzMxGfvmkiL2xZL/e3jOzW4RBomHu1wFNYcygEg=;
        b=bnzCHxE7p1ph+Pp9ZwqcI/FgWBeCPg7M8MzU5KVunDjJF46CypxPb29dsPATbiANxa
         WVlSiL/5jndRu4lsjlLc8cXPk+5zJqALIFHlC61qaxiCGfslVgQVTTXrdpacN4fPfXV+
         xwgOtuQqsuQCl7l5o04yQfiKhUegBvqm9s8acev8TRwZP320pxK777uqr0USgXHgenZ0
         1swwZ/maQWPwZHOgHN9pg6ZlwfIp5t2XMdmbrA87yVeFARD7loBHaEHypkzjwpLWpjbr
         4YcyDhELm8QzI3fq5CS5BsPBU+hwp4YqQuHHQdPgzGd4HS4f9LkaEEU9Ao5uRKzuo0GO
         OVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/wixFzMxGfvmkiL2xZL/e3jOzW4RBomHu1wFNYcygEg=;
        b=tN9zoM2wGgwKh2DQ9NXunOeckr9oMWWCKW3SPvWpR5cX4lRPjC6JX+Np1jAApe1myO
         ayiPVe4ynt7OP6Q6gOqmfEagFq+3z3T0huWHIvAuuIWodggImqS8SXykruGg6aQQtcSK
         LLIPl4UVuxxhdonXFshFchncYBhZBOjnWyW4ByE/4cl4R5yNsXsjzPTga2OtPmt9jl23
         1DWb33BE68QeexnoiRLvgupm7Jg0SU8i3w1mEsffg9Kr6fX5PXfXNjClbUfe/7JDauW5
         LNedMNP7BTY8J11Y8PtfMsSvA49mD3O+ep4X0200FhectGpXmEBLHr+L7BQGwnfBmGDI
         b8tw==
X-Gm-Message-State: APt69E3mHWeaXduYif2mRHepEyun05wczttN/tHyKaBKQrOTTaGIMZh/
        HO3yO3dauW/ftOThoF/fGU9fUvMrtF4L
X-Google-Smtp-Source: ADUXVKK+oVj9g+9ckEljPzvj4DLftuWwxJJC+pGmQbTww3r5MA0viIo7XFOQ27Y8zjSWSv+LoJX5hI8jR7/Z
MIME-Version: 1.0
X-Received: by 2002:ae9:f44b:: with SMTP id z11-v6mr5186493qkl.1.1529632662571;
 Thu, 21 Jun 2018 18:57:42 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:19 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-3-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 2/8] xdiff/xdiffi.c: remove unneeded function declarations
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to forward-declare these functions, as they are used
after their implementation only.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiffi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463bf..3e8aff92bc4 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,34 +22,17 @@
 
 #include "xinclude.h"
 
-
-
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
 #define XDL_SNAKE_CNT 20
 #define XDL_K_HEUR 4
 
-
-
 typedef struct s_xdpsplit {
 	long i1, i2;
 	int min_lo, min_hi;
 } xdpsplit_t;
 
-
-
-
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
-		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
-		      xdalgoenv_t *xenv);
-static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
-
-
-
-
-
 /*
  * See "An O(ND) Difference Algorithm and its Variations", by Eugene Myers.
  * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
-- 
2.18.0.rc2.346.g013aa6912e-goog

