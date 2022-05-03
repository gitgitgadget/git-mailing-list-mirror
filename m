Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D409C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiECKap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiECKab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F203E75
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q23so22761761wra.1
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z+SdrdfA82ej6bbOw4rrQsPd5k7rB2NP+NZoMPGkgnw=;
        b=Z2Zi3fsEF6IE5bdyDRkMr7tUwL87tazgf9YeAAiizhf9WcfOvBAJeU3IRIyEoQNmp8
         Y+yiyID3at4N/XFoMHRyOl8be9iT0HiMBL5jwApZ5ObXA1kYn/DvJOxphBU+CiOIe1vy
         PPWCjDJINxNirCebw8vk9NW7D5a4QyhYWVMad8SI/apbFaH5gS7lxPrVe3fJRxyYkhjB
         9P5VqrEHvUVezS9m5O3l+pq5BfjzQ0SLrlI92tNFwmlJS2i19dyG1gV5xNV1rl1luymn
         rAPzNd/YY6jm5T8tY5QTkotf0KF91DamU5/Izrx5LOvi7i5M7pmmcRO6/zf+IIChlaQH
         VuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z+SdrdfA82ej6bbOw4rrQsPd5k7rB2NP+NZoMPGkgnw=;
        b=ELWerOLX6YJnoPsl0ix7j4XDD6ejvxi5LfILzIH619DI2p1NohE3tsfdpYMLZckHbP
         dXp/gXPSbnu1ACpnYUDhUoSp555fL8lLy9T0R5wt99aYS8wLxgcxcnJobGf8lZtau4Wq
         OYYPvfgMRM0+O5HTkbyaAXD97lSmo0sE82SUGlQvIBYqN4t9iHz3+jS65SFaFlHVKQnL
         pETAyR8VgARUEZ66wD9uw6u/1bukQQaYIfP37FF6mM3pEG6eVYPw4pPpd2ukSUDhQrsZ
         cerUmqQ30WeGfqJb6JPEqkNrxqxbJeZO5Y8R/7xpUG+/tUMF4OCMzjPbnXSgpWpnB1kc
         e6og==
X-Gm-Message-State: AOAM530mrAaR59PkatNSPFOj88sVczrQI38DTwOVxA1XkLWjT84e1s4v
        aYf4G42uN+YRHjnQT+XR1hxmrD2c3ic=
X-Google-Smtp-Source: ABdhPJwes/mufNtCG/Yt6dkDj4e5tb6MkhJ69JYkGjk+bJxctZB7rQUMwFYVAYGiIiVYs0MLGCv6hw==
X-Received: by 2002:a5d:6e8b:0:b0:207:861e:36cd with SMTP id k11-20020a5d6e8b000000b00207861e36cdmr12154616wrz.563.1651573617768;
        Tue, 03 May 2022 03:26:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020adfc7c8000000b0020c5253d902sm9149192wrg.78.2022.05.03.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:57 -0700 (PDT)
Message-Id: <0c09fd000a6ee9827d78df8993e0310623f9fd56.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:46 +0000
Subject: [PATCH v2 5/6] trace2 docs: clarify what `varargs` is all about
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bf0f0750733..05fa38cf651 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -170,7 +170,7 @@ Some functions have a `_va_fl()` suffix to indicate that they also
 take a `va_list` argument.
 
 Some functions have a `_printf_fl()` suffix to indicate that they also
-take a varargs argument.
+take a `printf()` style format with a variable number of arguments.
 
 There are CPP wrapper macros and `#ifdef`s to hide most of these details.
 See `trace2.h` for more details.  The following discussion will only
-- 
gitgitgadget

