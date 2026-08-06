Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085E64AA4
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998439; cv=none; b=Vf2f1WSPErWGNvgmxZ2LmEbTP/JmCc5f6wKl8FBbamVkp19aEdBcfz3FVPztU8TWYkaT5HpA8tqhjIt3pejbhGIqwYJ+vsbND/kZMJlJ40h+6YwwA65oiGUCFI8Dd6eyv66oIKLRJ7/8BSwB+PF7avVy493dMaWWfnF4arUm5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998439; c=relaxed/simple;
	bh=J3atxoGIiyi6WoK+w4qvgi4XYNvsWiBfDZPwX5wE/xs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aaIi1oB02CFXp1eHk+QL5FIkE7EUTl3egUedcMFNjF21gRri1vy2NpsbpkQdMMJu6nWr+qz56EOvYnOzk1SsHNV8NjXS3MGMsGTkRSXAa4BkCAZSAIKQABvf5IDTiQZvcyn69kHqxWjU3wK2YkFT6RswMH8s4Ck+eJI6ymtcoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgVxs1+N; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgVxs1+N"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448b0ff4a57so1199709fac.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998436; x=1786603236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Y1TjxwcFgpSG2aGeCSQ2w9h6fbo73DDRfU66ZvZJE8=;
        b=VgVxs1+NV3ZrPY6pi46Le6KhoqQbB93YCOTg3GezxHiLmKfhS7KmDP5YsxXDQ7ndjr
         +R9LjEicXPlc25V6I086n5v3QOLFk6g1iGNYyH54BWsNNAesIQdVeVxOnzVYOZKpmrOR
         BMP0QiSGD/OXXYV0nhaOlGxnuRH+6AhgHV912V9XG8TQolRh/qeaY8NiAd+KqqOXBnLK
         0a5ASo5f6RJ1/7M6ikMGtEWI2RXGIM3tSFw9qOREcTKIv+6/+icZTgJ4xvSRN+scdwzk
         H97r3Ib9JXqiHOl2UOzUMqprVhFX6DJg48ZRgo/9bIJd/ezUsMZwTWq28WvZ99MWILIA
         /tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998436; x=1786603236;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Y1TjxwcFgpSG2aGeCSQ2w9h6fbo73DDRfU66ZvZJE8=;
        b=solVHer1qrqLbCH/07ZusREpYMLmGB00Hn5EuIJGTKnhqk6Z7pRn6dWXb8TDQYNGr0
         GFuewo1dwAij7DqXzgGkcASBHFKScdHO9pqXbsBnv65kksiXGSVNnyzO1ozAwzipVcF5
         dE7Puah/g3kpS58nQFEuq16AVjLefOKQTkHNd3rqD4wzozWcZPruIfT/FBYgmHYprbOe
         DvAfAi8duV295iNg8cohm3kqBO3qeVa9yczZIbBUNnzwcf4rivz0A53tOt7K5JwG+MOA
         v2evh2RaexHOZGulsq/58JVLpPaqSYfxVRpFSaWBrEo0tRKt1quQdlr/jxOjK0gz2as4
         Em6w==
X-Gm-Message-State: AOJu0Yz6GL+0TZBTofCgsaePlPsOw24I4Kxo40HQC83CMHQP80Bo2lR3
	MGSNdhmjs9eW6memJMgZ+STIrA3nfNk1KSrjIu+UXUdhQi7F4p9FnxRaBYByn/y/
X-Gm-Gg: AR+sD13wLocjGeLiF2A6GgfVLQ2AOqbgLqiy9KpA1/9j7FmETmUj6Yz114wmVV6o/oi
	ec5SuNbsnlmRdgl/BGU9IuCCWCEhnH1nHXXXQtp0R7JximDp+uzgXcs9bTMchNr3n43zgckWQH3
	T2geZBbT9bYNaLvspch0PmES3pIIMLiy2r6Pk6jRMj/NVe/1mqQFvglnZprUub+V0G7nNff2ajL
	xJVFX6PbblOJG41yyUeNa1Ww6rBQsXpXAUOvpGw5JG1EeV1IXSb5eUGJ194NPl96+ZQS4ALiY+v
	wwmCrgZgU2Uk2HJWEsBMTkDqQ05txS+IQr3VZhvoSGe1LbCDWzZMxRpbqbaVfYCdoN+vh43yb2/
	c7MhZtL8zJ6dLGXj00mKa+PO+wOsrjCQBlNRmNDC3p/PlykP1bZ/vgmZirgbD3DZWGjKLh4AX9r
	zYZ7Y3w0jF5hgcQ7rGzGGw/asDtIpjc1Vn0BkfD0SvaZ5b4YcYyX4MUZ3WRhLYo3WB
X-Received: by 2002:a05:6870:248:b0:41b:e633:baf4 with SMTP id 586e51a60fabf-4599eac27dfmr6775114fac.3.1785998436488;
        Wed, 05 Aug 2026 23:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e1bc300sm4813517fac.3.2026.08.05.23.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:35 -0700 (PDT)
Message-Id: <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:18 +0000
Subject: [PATCH 5/5] gitk: avoid constructing dialog titles from text pieces
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

When the user clicks a color preference, a color selection dialog is
presented whose title is provided in parts by the caller. The dialog
implementation must supply the rest of the title. This is unfriendly
for translations. Provide the full title by the caller. Rewrite the
texts to be more natural language.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9e735d91bf..454f54dca8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11836,34 +11836,34 @@ proc prefspage_colors {notebook} {
     set coloruielems [list \
         bg          bgcolor {} \
                     [mc "Background"] \
-                    [mc "background"] \
+                    [mc "choose background color"] \
         fg          fgcolor {} \
                     [mc "Main text"] \
-                    [mc "foreground"] \
+                    [mc "choose main text color"] \
         diffold     diffcolors 0 \
                     [mc "Diff: old lines"] \
-                    [mc "diff old lines"] \
+                    [mc "choose text color of old lines"] \
         diffoldbg   diffbgcolors 0 \
                     [mc "Diff: old lines background"] \
-                    [mc "diff old lines bg"] \
+                    [mc "choose background color of old lines"] \
         diffnew     diffcolors 1 \
                     [mc "Diff: new lines"] \
-                    [mc "diff new lines"] \
+                    [mc "choose text color of new lines"] \
         diffnewbg   diffbgcolors 1 \
                     [mc "Diff: new lines background"] \
-                    [mc "diff new lines bg"] \
+                    [mc "choose background color of new lines"] \
         hunksep     diffcolors 2 \
                     [mc "Diff: hunk headers"] \
-                    [mc "diff hunk header"] \
+                    [mc "choose hunk header color"] \
         markbg      markbgcolor {} \
                     [mc "Marked lines background"] \
-                    [mc "marked line background"] \
+                    [mc "choose background color of marked lines"] \
         selbg       selectbgcolor {} \
                     [mc "Selected text background"] \
-                    [mc "background"] \
+                    [mc "choose background color of selected text"] \
         linkfg      linkfgcolor {} \
                     [mc "Link text"] \
-                    [mc "link"] \
+                    [mc "choose color of link text"] \
     ]
 
     foreach {uielem colorvar idx label title} $coloruielems {
@@ -12014,11 +12014,11 @@ proc choose_themeloader {prefspage} {
     }
 }
 
-proc choosecolor {v vi prefspage x} {
+proc choosecolor {v vi prefspage title} {
     global $v
 
     set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
-               -title [mc "Gitk: choose color for %s" $x]]
+               -title "Gitk: $title"]
     if {$c eq {}} return
     lset $v $vi $c
     set_gui_colors
-- 
gitgitgadget
