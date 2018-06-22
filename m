Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9BF1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934289AbeFVB5m (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:42 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:54909 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbeFVB5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:40 -0400
Received: by mail-yb0-f202.google.com with SMTP id i9-v6so3076345ybj.21
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gqkbLF2OfT89hFFNnJeb77zgMBxPziOyhwt3jUuLavc=;
        b=RK+VRJ5tYGKxlJ0kBUYRPn785VFRo3UD/Q6euf7OXcLhgH/6c2wZnaZfHQCt6CK4SE
         aKWZyec0N8qYWpdBvxUrPT8LViR5dkn86Vs9xR2T6vCWiwF2bFCvnR6sV/Uq12QxS/FY
         e8tI3hcpF5+WU6Quku0lY1uhfSStUV7O+FtaC8Qj3uEwjWiIJkskxAN4R/YQhtXm73ZT
         T0NvSksqXz4VqYVfnySQ3LvDar/r5a6jJonjOpxgrSOjDcTOqLqe4QDAnsiGrelrKhVP
         QJhRozGe5AkoYMJ77nfpHLjINzs4UJWICn7tc+b6Iqlp4WlYf+LowQPNPcxwVY7Yi6HY
         jiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gqkbLF2OfT89hFFNnJeb77zgMBxPziOyhwt3jUuLavc=;
        b=CvRSUI+Yi+srEaqLPtC9vpbhf4HtVZOF0aOT32JXAW//QjusBDhCoXGh4i1mc2aDFX
         WUqdPN1lsb34msvZEmuBoU0rnYBlQ4H+XHJb9CBVhpq1Jz19+4777lFn1rgdrnzER+Hr
         IamFWaKQsdfnE2OZb/XZ2HycQALwP9lg2Rkc4dNqW33wno7HeDfJYMFWaeQjFy9JNEmn
         1wrutsO+Is4+ohBfaCLn2gAufokfE80T0pF1ZRoCj12BGnlR10wZN1e0Z/UBOYM/qxCS
         KFIr0pLBVqGD9WKPAMOz+uzvzUNzD25RSyN4z2MboaQyMJiARK6fOc/ygD4NaAn+YoBn
         65Uw==
X-Gm-Message-State: APt69E1DsG0GTHmzck5AFSXr704gWFXzucQgPNi4QdFXZDZEZlDNMmnk
        XWEQZO0Ucy7JVQWLIvUpPzWS/piDFHXt
X-Google-Smtp-Source: ADUXVKKF0h4TLVq0oAk+FwRnhhz6erlLPdPiaF4fLWC4UU0jN3ubHXZMJGbqgioy7suzlmRchWUW8XOBnbcT
MIME-Version: 1.0
X-Received: by 2002:a25:b950:: with SMTP id s16-v6mr7880978ybm.18.1529632660182;
 Thu, 21 Jun 2018 18:57:40 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:18 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-2-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 1/8] xdiff/xdiff.h: remove unused flags
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
2.18.0.rc2.346.g013aa6912e-goog

