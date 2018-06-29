Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9490D1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030253AbeF2AUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:16 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:49373 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:14 -0400
Received: by mail-io0-f201.google.com with SMTP id x13-v6so5544711iog.16
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hMrodoXV6Ioa3+A5WNdBPUIvfzfdTp2nu+VwwJ7USko=;
        b=YttTeoJH5msE6h2dWmLmPZvPf5ebXBjI2jwQ3U4WAPqn2iuqhaW1ynz2/NiwcOAK70
         mn9VfskxSfDK7Xrrl2VNRZSZY5Ia2yxbV/TuwPr8/bghE2sAI2A0Ti356IP2EdGJhB4E
         X48vEwZlzXCR92N7d6+WB3dtAsKJ8lCpPlwXDAHqs1Ng0EnWXl7Y2wa5KiHoJZYy89rL
         rmqiPTt0kAgID+tM7/aMhiqCip0Ro2j+Hq8TExoJUcMdm38hfyVNUm5sdGih9qGz5/dQ
         Zb2JdoGg4+OAFXT+b3zaJ3kKZoQw9nBdNRKyuJHmidmZ1IZ3oi6+THO9bDcbYOnkA3fT
         0ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hMrodoXV6Ioa3+A5WNdBPUIvfzfdTp2nu+VwwJ7USko=;
        b=QAk5FrFkTAVb4mAV/or1C8GLnxsejEDCM4ZKpazDFTUw+tJ0+l6hWtUCAgNSs/53BW
         aFVwe+62Z9RwaDXlG6Vt0GqmHDEAiUYPVy8bDfUCJNGbAbGYbJpWu2lRgnZG3BCn3AUe
         ufsZIP1QBOZQ1ehQ7xjaW7tBzjkIDE4R4FhOyqCPyjEzjzOcy7bkHM/YW/U8WfaY4k4O
         vyOhZP4BoSNB6JKFrnA+aE4uCIiO1FtgO1bABqNbA5dzlgHsQhso8A2xk8v4Gpu7s0ZO
         aSXQmvg8bGPx3zHHe6lNxc/hCIxFoTLGDNC2+OTK1Y+kt28ZcbKyjSXV4vqWOLSwiPFo
         p42w==
X-Gm-Message-State: APt69E0Lphmh9PKgSZjHptccfK3t7cBAqBanrqkGoPkloShoIWvs30/y
        7kOrFqPB9p9fkT6RBDQUrxyaCPlYchkN
X-Google-Smtp-Source: AAOMgpdqys5DjrbFYZCE2/HKDG7T4k4rCVe8sUHWze+K9giNejgoM0OazqgCLtnoD93bD8q4FQC6RR9U90p5
MIME-Version: 1.0
X-Received: by 2002:a24:3f4c:: with SMTP id d73-v6mr36947ita.30.1530231614110;
 Thu, 28 Jun 2018 17:20:14 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:50 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-2-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 1/9] xdiff/xdiff.h: remove unused flags
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
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
2.18.0.399.gad0ab374a1-goog

