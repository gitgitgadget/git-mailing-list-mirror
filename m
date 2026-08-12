Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0144CAD4
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540598; cv=none; b=iMOIKubGOUhzsE/WZNkskgubL2eENOHHnXDW+wC6AZzmhw9dd838w3VyVq6v3JtUyNynFk6u+hmQsKhCJY5zYJpuaBymrTde2PIlqHgvuucCMGgcz20+5BAy3x29cwhJ8q4DOB0j3kV/lPTOraRsc9bsVgCakfaT1xUYXzUrBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540598; c=relaxed/simple;
	bh=Fv/Sk5mv44HU/Wbsc0b/CezLF6onMO4CV2fj3qJY6+s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mu09Pie3XEuC1Uq2QxY+ln8inlo/AhzpFPAl1b8uF13xQwy7qL/xGSj3lC9ZoHqtpjQrpmiURsxFpZT/EgVacmCaYuw+2YvNlZDCwXvl7gkLiBiDSlLxF6TDsEq2mvUH1MivABU9pQUWpEkhfPfXvuVP6BcYkzmMBCEVCNq4PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UagpJC3+; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UagpJC3+"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b1fcd3b1a9so431235b6e.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540596; x=1787145396; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d8OZhz0sfxcdAJImXLujPVDjTcSuOgKZL2nnmu7S5ds=;
        b=UagpJC3+v0LWyEc1+z/7jyiOGTN1+KT4rZsdHvcmO6SL07GuRpzPjzCfcy/DBYYC1A
         VMQ7zztzqutv1jPVggu9/1XGAwLQ9pyf6yC0fC+HY0N3bFJHs7JY0WW3WfJitgU5ijJJ
         GNztLVnu5laywgfOm4sG9pQGQWJ8yfAJPu+WldCSi5a/RbkGI4vbA/5qOwwjnkppxylw
         iZeqAA3rAY90JICRk9WewnBBjzNjMfiSxBO4lfVyKXjPAdDuObXR2kMsNA5YYgYWpyLJ
         D0HOYB0WFLLQIgqOZwEPOYliFcD4i5TCHADWPYV3IMnZTHlSil06ealnbR9CKGSPXbls
         jwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540596; x=1787145396;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8OZhz0sfxcdAJImXLujPVDjTcSuOgKZL2nnmu7S5ds=;
        b=SUVFjXa7w6e2iTgNSy42zE86egPF7Hw+59VVQZrh9B4PdsozChrxeO7apk5DJSSGpJ
         sNMsaNV+f9Osnk5k18SV9VZCAxipPSPqo2kdB1cgv2MG6+U5hTbwsvj95Duu+P4gqFQy
         Q4c2wP2rO6Ok/5Jbt0C/0mEER0nuzGrtAjFESRwOc0+gUVy6nWV9tEdax43y92wn4q3p
         HOU0kYmjXHbRL5Big4XzqsMLUQLmvhOnt56UFGUZYBjF+MuBlLFuWLDVlSGt4SeIE+sX
         wcMshdg86C99lWTzqMPjEu+s7piKifm6vXmY+aXlZltrGAijcr1xIwWPx4fhF5KFxb9z
         L9Rg==
X-Gm-Message-State: AOJu0Yzi+OJUxq82OCGhzES/boGO0hucQ39rVr8Q5jCDZ1iCB1mWKdE/
	EZpaVZkvFyJMlO22tVJKaBG83aSZcvbk/Mj5d59LadTm0Twg5QtEj6n/rok1xA==
X-Gm-Gg: AR+sD11hXqngy07w9c0hKhv10fOfqqgaUAto3rZpmLCOKAzkdSvIdJmUgmow1NCcAHu
	U8FGay1GA0FKnLpIs4BNUrWQlxml6Nt37aeeiM/DAqnRkMihl6oRwIp2WHYT88NwFzIVfzoQ16R
	4wl22epBsc+aH+Ss2lI6KjTrfNsNUeaLIzkumqlX1E4IsALvNttFX8ShcJ4mVup2IAhNNLgC4ap
	VK6+uppu6OtAE5Y3zV3u35RaaSm9uoOszEJ++XhC4Ga//HGlDSkW/0EQFi2Tb/Y1q1BPQwD1mZK
	fxmeXq9p9KYla4ui1G/xy466WFf6xBdtyiIG0b8Hka+Z6qG0tBwl5dafmitj/tbXtibdmjLSqmz
	O/q6q3BdT+cKjyslgV/QtPHMXJOlUrpDrYM5R37VfD3Ls1kGpMeNo4lkRJGtlIhgTFjpEg/fWvU
	hSZLHDfRizTRk4cWynmiOFMOsmdePwo6FUz//zst9ZYSaS8idwkLnMvQd2HTIqY3Y=
X-Received: by 2002:a05:6808:179f:b0:4af:88b7:94ab with SMTP id 5614622812f47-4b2109e9f2amr5131634b6e.7.1786540595777;
        Wed, 12 Aug 2026 06:16:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1fff65619sm3090465b6e.8.2026.08.12.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:35 -0700 (PDT)
Message-Id: <36590e857d3c9a83b17f32b5790df2bd6c1cb588.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:21 +0000
Subject: [PATCH v2 6/6] gitk: move UI for generic colors above diff colors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: mark <mlevedahl@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

The selection and link colors apply not only to the diff panel, but also
to the the commit list. Move these right after the generic background
and text color options.

The color for marked lines is only used in the diff panel, hence, leave
it below the diff color options.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d4c229a3c0..9506739c50 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11840,6 +11840,12 @@ proc prefspage_colors {notebook} {
         fg          fgcolor {} \
                     [mc "Main text"] \
                     [mc "choose main text color"] \
+        selbg       selectbgcolor {} \
+                    [mc "Selected text background"] \
+                    [mc "choose background color of selected text"] \
+        linkfg      linkfgcolor {} \
+                    [mc "Link text"] \
+                    [mc "choose color of link text"] \
         diffold     diffcolors 0 \
                     [mc "Old line text"] \
                     [mc "choose text color of old lines"] \
@@ -11858,12 +11864,6 @@ proc prefspage_colors {notebook} {
         markbg      markbgcolor {} \
                     [mc "Marked line background"] \
                     [mc "choose background color of marked lines"] \
-        selbg       selectbgcolor {} \
-                    [mc "Selected text background"] \
-                    [mc "choose background color of selected text"] \
-        linkfg      linkfgcolor {} \
-                    [mc "Link text"] \
-                    [mc "choose color of link text"] \
     ]
 
     foreach {uielem colorvar idx label title} $coloruielems {
-- 
gitgitgadget
