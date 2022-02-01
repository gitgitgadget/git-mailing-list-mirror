Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032AC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiBAPuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbiBAPuC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:50:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ACCC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:50:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso2328214wma.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HZN4t4sPFiAuqBJZVrWcvMVijbfFBwGAh9BS6MOF2Xg=;
        b=MGcONPpD9lJmAW3810Y/jEHGxIBK/2GKL95Z5GCXr04xpIBAyLNvQtLzJUkCFeWFcX
         GbUdyRevcsUm9zemXrDd2bl5jDzBlqpce6uMpLXO040RH5tJeGoEc0FnAvZooFI2sp5n
         LAkK/KTmHgrKOAgY4efgLJXDX12ITMEfNMSg5AE6wiYdTUVWZz/J2UN5E8XsXwoDntcV
         XKr7j7PZ16kOSD1bSWKJ+byPmt5Osy6uqyKCpkp8eg0285U7aIRKj0gdCNadGKnufcuL
         lwXbvGBcwdD6lqbtgRjHefxjy/J5TfbP+6z0SMMkMm2Ow1WHokoiQlSzIBfexzVOYW5u
         h4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HZN4t4sPFiAuqBJZVrWcvMVijbfFBwGAh9BS6MOF2Xg=;
        b=agT7cLWg16i2j2uVYem0gurGihj+6WjscuACNYErhcuBnp/TAnKcJcxGzkP2b3i/H4
         37oqHOMSdl5P7si1wqsRsQLrsPyfzr9tFeWq1L3p2gP1U2g8eDqqAyw65gUPBkMiTmdE
         aXGBrb97RQOWzTl757sR7QhaTUOHdkTb8wGDeoKIh7fMDSFubR0T2iI0FFyt2wl+eBFt
         0M0lSPj3wOjKnj/RJjIb+14K9sC5gnqO9/SmnmWQAEj0a0G0lfuxPRsMIScA07XE009E
         PQbz+vnvBquwGLyyWq6VszWgTPiAo+kffAuTSvX5ikUT+KYMFXN7njoxx8KZmf8R5LAM
         EvOg==
X-Gm-Message-State: AOAM532atUe1S+CWbdBmswsVi/G0shzq+svKrXWMevZY4G2nOhifYehQ
        xQRS0tzdWm2cdXWwglK3g2snH1y6GHI=
X-Google-Smtp-Source: ABdhPJwfovP5+KUXvael+HNS6kpz/Z6ahzAP+t5HLDr169UII0/n2evi6o7ol/YXoY0Nj9jt56oWOw==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr2268619wma.129.1643730600679;
        Tue, 01 Feb 2022 07:50:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm14853574wrs.93.2022.02.01.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:50:00 -0800 (PST)
Message-Id: <6c4d4260bfc565d4aec9776e4709fea3e531ad2b.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:53 +0000
Subject: [PATCH 6/6] doc/partial-clone: mention --refilter option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add the fetch --refilter option to the partial clone documentation.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/technical/partial-clone.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index a0dd7c66f24..e246b0778e5 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -181,6 +181,9 @@ Fetching Missing Objects
   currently fetches all objects referred to by the requested objects, even
   though they are not necessary.
 
+- Fetching with `--refilter` will request a complete new filtered packfile from
+  the remote, which can be used to change a filter without needing to
+  dynamically fetch missing objects.
 
 Using many promisor remotes
 ---------------------------
-- 
gitgitgadget
