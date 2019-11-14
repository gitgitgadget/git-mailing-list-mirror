Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 982601F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKNUrL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:11 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43989 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNUrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:11 -0500
Received: by mail-pl1-f176.google.com with SMTP id a18so3173926plm.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9FWuuvu5G70lNsWR4KS5kh3YBAhvkQtXVLZ0Vk8CNzI=;
        b=SJnuo7KkK1WKsKIu7uRalAYB4SAiCCPuBgl14meA7Ev2SGorfuf7B8ftotrwMjUQT6
         hl17wY9yofNChSpDIo4fkQ+MjcSJxTeGgxSWyeJIqu8fX/XUM38viByswaMzF+5uhZ7H
         6cTxGE0Fqx268rr6iX6Qx98A+jlOFOkGQzimCAIK5lHgY2OztE2MCLpYX41+ZWwzHnue
         HaWKPRkNrxnYTjc20AwmzmEuaNesEgaYeqPGrO1yPGZ1CD0N2Q8qrcjvzGxDJ/e9dPZD
         5/IdDgcRNnbBJx4cGcGSF55r1sgCvDB0phP/XL3obgAOtWPQLluAIjdU/ZkHL0cicAGW
         KHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9FWuuvu5G70lNsWR4KS5kh3YBAhvkQtXVLZ0Vk8CNzI=;
        b=IkMg7nh4InfDnzmCO7ODTT/974nDGYxSvlFPVllrRGLTSakw9SF8FSGutnEZgj52zP
         +G6KqjQ1QM0Dzf3MGLTaoKwtqUHD7r0+JQpKoxJ2kbzIMcyI2iy1ebTfLg5akRe9kM3t
         1a/gU1xtFrsLmyjtXSNysB9v8+4Jx+JpBICIqo5hKFjgKU6JQHS7aQ9tSmRjPHWJvAyt
         L4K7rOXpNGaGRwKdNdjLsgkyxks2Z1V6tUqTb/Vq09Xn+n0bm7g+UUEMcvZ2VgadRLK6
         2OqJPlAFuD1mKrQda6bPeSlR3aRzWwm4oKVW680Cl+frpdFNM3RFD4tk9MIKl65SUrBl
         amvQ==
X-Gm-Message-State: APjAAAXnK9SLPFOs4gPq01OJ1nDgguXK6MBbJBSfUuwFGu3gN10Kbmf0
        fu5bzyrPXd+i/cjAyYCLX+CfbdMD
X-Google-Smtp-Source: APXvYqwNKtJHCj0Non9N+hht/cjrgRuqtOecWnCAkxwKxF7HBY/dJMreoxOTqB99Pw6MLDxmUCyXxQ==
X-Received: by 2002:a17:902:244:: with SMTP id 62mr11894082plc.14.1573764429867;
        Thu, 14 Nov 2019 12:47:09 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id i22sm5975923pjx.1.2019.11.14.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:09 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 01/10] SubmittingPatches: use generic terms for hash
Message-ID: <5a9e19b37ea77660a2f3900f98fe24c2569af76d.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 1a60cc1329..bb7e33ce15 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,7 +142,7 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated sha1 (subject, date)",
+branch, use the format "abbreviated hash (subject, date)",
 with the subject enclosed in a pair of double-quotes, like this:
 
 ....
-- 
2.24.0.346.gee0de6d492

