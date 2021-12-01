Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80761C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 03:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbhLADlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 22:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346483AbhLADk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 22:40:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E8C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so49026624wrb.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=Z/r/KVQMuKpy5po71rq77QPTovJOzl4h5ODO915XU+70dQruVdFp9M3tb9DDtVopKu
         Vl2wWz0cyfoB0p1kNrMIEzn9Jvy/1z9R3mWL+dEJMXOL+ovCH+92n1GWmmvxWcSvOJhU
         ZDPTb4xtmACbcuE5YMObC2xERy9ZTlZElH32Tc507kVbflJ5t1Gicpg38THylaA/l+Tp
         hS+AlQKCAhcgth/IG85oNM8gNAPOXx3mNlGC9f64G1zG7V21M6/fBMgONIHdOdXeE1rJ
         QcNrkLbH20ak0/Ox8Z1zaEnKyIwtB4CjcwpqmNdp3yI4QA/xn3vD5vHmqwbknLki28dT
         Ouvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2wOIUyXvK6HBA37YvvgtpeXS/BCdUCODvPh5e+IWqzE=;
        b=bF8NxIungzVYMGuKEdPC6j9BfdkJp8AjD/vVPw+yZUgylEvHGtGSQ/iaCn1r8X2YJc
         hiO25u3tK/E39riUCAIt6pq6Nyp7U27CwVyymPsq37Azklb3SZ6LxKkmy1ZM+BG6y2Pa
         GXu8TgIblkFu75AU18OjM+qAZNPknFF2uXECrPNzJBZ1oLMdFTTkQS5ltd+vSqnKmZvU
         fxbanvnnFPKbPYyYFCR8Bpsa/SZDfazuTvv+5UagnVE8RO4C4ZydXscOnlg9i/0agYcr
         sGLKXneqKHOJEEtnI1Ev0vanwhbX2Zb+B9WDQDdjXnIcEZkMrrk9CwT+gEZy8xEX+ojh
         XaFg==
X-Gm-Message-State: AOAM533GL4mBa52/ntezq1NDASvN6GxN9TX7Xa7tXiryI9bJMIE9SmNm
        +KPn2ZWOZyGHfBwKXguQMnW/2RFtXfU=
X-Google-Smtp-Source: ABdhPJwW0ASOUgbgj+GWWmh/80R0kc7HV6i3mMs4SidP90yDCI+iyYHIUoN/E04FFTXIGMDPWdz3sQ==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr3781037wrz.404.1638329851637;
        Tue, 30 Nov 2021 19:37:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm22856860wry.0.2021.11.30.19.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:37:31 -0800 (PST)
Message-Id: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1638329848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
        <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 03:37:26 +0000
Subject: [PATCH v14 1/3] doc: git-format-patch: describe the option --always
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= 
        <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?=
 <aleen42@vip.qq.com>

This commit has described how to use '--always' option in the command
'git-format-patch' to include patches for commits that emit no changes.

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

