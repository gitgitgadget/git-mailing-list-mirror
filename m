Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FCD208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 02:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHDD7E (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:59:04 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:51694 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDD7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:59:04 -0400
Received: by mail-it0-f74.google.com with SMTP id q5-v6so6939843ith.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FcrWYE3s13T1wxeo6BbHWddLhKPReF3KhWeA8cs7VR0=;
        b=rPyRJOKe1LDZ4rjgKhT+6mmwaE/UBrTNnm/zFY3/rLtfMaVkgpw58drSjWQYoscTVC
         642NsHfaFWJbBdCdrnxVZn9YJuLecWeE5F6bTnw65Ic8LtrYn9t/WybnrXoaQ418x8U/
         Wo34Jxj+aYIvpVHJUqFlVPfm13hoeu01Zz4cxSXFkn0eWKPNfyh/ZBwyKN0TiW+LhAH6
         BhQh8CmH6/NdVkcSNrNkwVd1m9ehedk+a8nbtAjM8BcHYk7YDpDUPNc7dBiRdTxDQmbx
         RLzlv6uGga8DcsLiDmGM1EsvVT8aBRrCVPzue1GUBdVgj0s+J7j5sBKTv3+hZny7CXPE
         iIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FcrWYE3s13T1wxeo6BbHWddLhKPReF3KhWeA8cs7VR0=;
        b=uSrRfchp9Z2DPcw+L4AvWrAei4yy2xoExRFuuFc+uKu1mpbar5Z11iAGHWZnCa6g1l
         rIrHLjtczFeVBOGFIgcObVCBTqBA8n53FR5QyjbF1zFnbiMNmqLm/3x7ehQnnQOQsx7g
         VqgvqcJU18jBo6v4F01FEV8E7D1Lub71MjucCO6Yf0VIQz4BQblyI3EDNWtMbLpA9qz9
         gNK0D2nLu9YdoKkKMpz2p+vFFkbRPNOLuVrwusaZPFstDWvylFTJ0Zt94+hRjbYcpk/g
         BmrKHZ57NM0Sx/wjH9pr7faGTOE60A3m5EjPwbg2Wrkp7WnKboNndMWQT3yMAqXmKYKy
         xD0w==
X-Gm-Message-State: AOUpUlGLlQvpG0yKYLNGR3qu6prQagySjsDR+PHwxYT3qIIO9D9yRnQD
        20O47CQLVS5FC3MI0uGmr3ZGcNMbWJ4MyhRnCSW8lZsCoDIE3PxmlW7Ff0hxZh5Qt57BCM0SDKT
        yq/xHw5Q9fpW8NkTLxi7Q8f/BfxAgklePvZY5VSrUZ/xZJsrJYO22nQ7HetH5
X-Google-Smtp-Source: AAOMgpfeJX07LgXOyZHMjzQ4ZMZHNBjgWhcFxiYgO/KZcsETItXm+UWYOfo/zUeotqfrpXFO0nK3yMxnVYlZ
X-Received: by 2002:a24:5d15:: with SMTP id w21-v6mr633368ita.45.1533348014359;
 Fri, 03 Aug 2018 19:00:14 -0700 (PDT)
Date:   Fri,  3 Aug 2018 19:00:09 -0700
Message-Id: <20180804020009.224582-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] Makefile: enable DEVELOPER by default
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewer bandwidth is limited, so let's have the machine of the
(potentially new) contributor warn about issues with the code by default.

As setting DEVELOPER, the compiler is stricter and we may run into problems
on some architectures. But packagers of said platforms are knowledgeable
enough to turn off this flag. (Also they are fewer than the number of new
contributors)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 41b93689add..95aa3ff3185 100644
--- a/Makefile
+++ b/Makefile
@@ -497,6 +497,8 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
+DEVELOPER=1
+
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
 
-- 
2.18.0.597.ga71716f1ad-goog

