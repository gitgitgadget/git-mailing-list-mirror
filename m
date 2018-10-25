Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612DD1F454
	for <e@80x24.org>; Thu, 25 Oct 2018 11:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJYThc (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:37:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44570 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJYThb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so3807743pgs.11
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MqHiMKV4Y0VL94TNgYJ6g/lC/1cs4jQWpZ6F4/47otI=;
        b=tmJ19RyWcj4eLPwfyO2PVqTWCH5vXrPazbK3Y5P181aRtIMzFVQ0rW12ZSF/M1uwNV
         K35MY+soAGoO6+AxEhnxD30OvwGQIcQOLAizYQB4C1zGKKGPFCmxoMVTKrmAsr+FijIJ
         q4wA9P5jsnacFwgT7xjVK1Ebl1xeYECRs7Rr4DHyYRbL2py/fwU0+79PcmISDJRGIoAj
         TaTo0oH53xSrOlrOCTO0a4llNGxTpY9+KL7cUOONlSljWETppLT83Nvz/ext+XeTO/KH
         qeRvUSzCr3bRlXu8L8VJy0wGSNrmtf2i+1rD52gn6+rVQlrRkfUpkKsJFuFiMZIvPyZk
         bIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqHiMKV4Y0VL94TNgYJ6g/lC/1cs4jQWpZ6F4/47otI=;
        b=HPx3y56IzYWGOMRs/7Wv/iTbtwrGkr0nrSYanxFUu5dobaRE1WccTxnTD79wWUBfuP
         vrxAtmnQsH2RWZtFT9FCs1Obp4Y2fIOblSKGNAnXWnCXPyrDBQZ6PLEaDEwOMRlryiO+
         0eFolNC28xnBg26iNRjmHptux2mGZaTFqbiEl7R8ES0NOAHsenS+PMPvENh1XB+LESRv
         dT9mWJKHBMywkcaayA3N90sd8ov8q4eiqndl+rJyND5bGfNeY02+e3zEnu8GhXIw7iOL
         NqNqFo+F5/efxQ+zz5FRI/GXPShTq7oBQHU27Lrb6Nsnqe8Y7HzEuWoJoEyLriI0K/hm
         qQOg==
X-Gm-Message-State: AGRZ1gIj3TilmbnuLUsA5Ahn7otNXcSLW/Uqb0TqqsJQN6CpS1vUxYVi
        CPrfIJOPZ8YWGxfiASYVOGPyS4zeAmg=
X-Google-Smtp-Source: AJdET5cSuEjlL7FyCwDVENKubuJqQzo7iT6ItimUb58zCxYN2hZB0G0Sh8J7FZej9G8PJjaAZdj5nw==
X-Received: by 2002:a63:d34f:: with SMTP id u15-v6mr1016554pgi.325.1540465514955;
        Thu, 25 Oct 2018 04:05:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 74-v6sm17545405pfx.182.2018.10.25.04.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 04:05:14 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 3/3] commit-slab: missing definitions and forward declarations (hdr-check)
Date:   Thu, 25 Oct 2018 04:04:27 -0700
Message-Id: <20181025110427.13655-4-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025110427.13655-1-carenas@gmail.com>
References: <20181025110427.13655-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct commmit needs to be defined before commit-slab can generate
working code, object_id should be at least known through a forward
declaration

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 commit-slab-impl.h | 2 ++
 commit-slab.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index e352c2f8c1..db7cf3f19b 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -1,6 +1,8 @@
 #ifndef COMMIT_SLAB_IMPL_H
 #define COMMIT_SLAB_IMPL_H
 
+#include "commit.h"
+
 #define implement_static_commit_slab(slabname, elemtype) \
 	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
 
diff --git a/commit-slab.h b/commit-slab.h
index 69bf0c807c..722252de61 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -1,6 +1,8 @@
 #ifndef COMMIT_SLAB_H
 #define COMMIT_SLAB_H
 
+struct object_id;
+
 #include "commit-slab-decl.h"
 #include "commit-slab-impl.h"
 
-- 
2.19.1

