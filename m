Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2CB1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeGRUL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:26 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:56792 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:26 -0400
Received: by mail-yb0-f202.google.com with SMTP id e6-v6so2891818ybk.23
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HRrwvm2M8PzWj94y1RSXFrQqhrjrrqdindjAq8GwTO8=;
        b=FP0SOJxUITqoLpznK36BXPJcPQIAkFf7vSVhThAaoJYC7/Xwx4NkEiN7RQ4dwkdPtm
         ObovSeWjUxwxaV4UJu2mEil4szNQHuxuhxa5EW23MVNxoe4xBGje9bMXSsAiNFYHpIHc
         xMOT4TPafCLVWW1zgV19iyeqGbAdNcCub3PrrvoW5JDuqe401hTd6uN4RmAdfKKm0A4k
         MGT5BfRFW/Si9FjGijvnaT6zVx+tXcsyKNLJVZQjXUZhWYbpbN0sLFwUaT3f0u7ZSjY9
         IDrhlPeG6YM091OwEPhUC6QkINE97aU2Ee4zXr7S2HyXTbQWxbZY9PT5O87KKeRXg20t
         PcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HRrwvm2M8PzWj94y1RSXFrQqhrjrrqdindjAq8GwTO8=;
        b=AHVThS+tsucard9LasJLgtdwwZzo0NXK6AlVXRVEQNWiuEt6EbrKTMxzrXZInIioF4
         bztL/YKqmi+lrXIwtyDEc2Fr4fXLKvilGOOw4PnNLJJl44XMh0HMamIU7HfoBa6DAAy3
         3e0EFIWXt8lHsgTQUNoDueqcpRfW6PpjO3QW+s0xe/X1xnaLb4bmqd66SrGRY8ZOuKux
         ZP9u18yPotRYFLi71Jg0bB+94lRgQH60VAkT7ar/SGbgWggCLiuSsSE7TAD2qmnhfLCE
         P1ird3h6G74cY1VzKCRIgoRNYBu+Nee5+mXyXAG9HhE0PfnJeluw4pDICgx/EyMbOIoe
         prbw==
X-Gm-Message-State: AOUpUlGizutAKouFLjIZyrOUxyDskLaXf7DnrYRRLxLYuFLEcf0tAhyM
        MzAU3EAtDl/MEl1WBNvL8yhh7vpugl1emsPwHnMl8q0UL7yUdRYl2Aiaed9Ee6mQIH8a9KuJ0MG
        CyRo/QcJnTyPtfyN4gXllE+iyIdRegHMrdmbPYFeWXcgh+MnIiaLk/e2hKYaf
X-Google-Smtp-Source: AAOMgpcVI3YVKUXowMKfcYaEsyAiFatoCf2xO4QACI9kNy2SbMwOiVmugnLa11fVbc9mkpuAdDDDwgwU+B42
MIME-Version: 1.0
X-Received: by 2002:a25:5f51:: with SMTP id h17-v6mr2166194ybm.7.1531942326040;
 Wed, 18 Jul 2018 12:32:06 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:47 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-2-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 01/10] xdiff/xdiff.h: remove unused flags
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
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
2.18.0.233.g985f88cf7e-goog

