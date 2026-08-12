Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D173448D03
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540591; cv=none; b=ox8iWIlqxtyFRAf3AwXgt1xLSZtb1GcjnVHrC4GcxkvmkkjW4rn2fy2GRcKQ0XS/B5tmvldnRE/sx6k08rUrHV8sZxVkeRDibbbJyJqvBqAK2JBEHb8kVlCxKInMetBXGF6leps7+p+XAn6YqQ3Hj/cyGVq2pTnYuJjkObVocPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540591; c=relaxed/simple;
	bh=O1wI4/taZvKjI9Oz5gfrCfhU7Kw6aQR2fEFl++b1718=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kGLID/1rEB2mOQ7GyN6W30R1+8IE+twc4NEx6Mxc2Hi6rPXiNYjQyApNFhgJGvBNOLKB5wY5HPU13LKXi3NkivWx7r5R/3cvfpT4eqH/m7xrgapkh292reVD3Rysk7DUkXBk5fYmLPJ/etgYkfXJxU28tvnnh5QKCn2kHM/oONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAM6IiNA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAM6IiNA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb4d532e65so402680a34.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540589; x=1787145389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IwsFvMyFVU6tVpMyWCLr/Z3+cu+HcQMtzr+g87Od/60=;
        b=tAM6IiNA/xKSvKdd6CqmfDbL3/eQaeCuxkOBYUcjVu9kb9Q5uFSzYJhO9lx4wXAJ1C
         L/lRDor9Q6OBPmKSETrzghmB45m0bzHSedKK0AAdh5CfyImH8tYBkq5NtlYC0jR9QaAt
         5oZMPHfwSMEYwxa8LqWhjs8Tu720nBDHr5iauNtdUadBfQHTE8++oaRxXoOplH09ozyq
         3fChgYSJbExyHH+Q4xZfR/EMsoCpT3PYDx9JZePJ5kissg3tr3DiJ9lEbtasHqziyuvJ
         mDxh4QIr7s98guuP33f9tvVsVxTZhC/xEWoPxOLdNxY55Z6uxSyjIFjzI6A9yDjOW+ca
         nFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540589; x=1787145389;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwsFvMyFVU6tVpMyWCLr/Z3+cu+HcQMtzr+g87Od/60=;
        b=HXmCEM26QUDmtoB5q65JczbeNzDz3GPteuhFhrgVkuXbKtizURj349Mn2Hepdex+LJ
         KXVU27RHvoaiyz7+4Lr7EDQQT0AaS5GGcCF09yxi0xC0Z3Kh9I2+LJ9SVwQkx3u/d3MD
         WfMJ794dMgfJcp4b26H9kbuGD/TTRvhhg6d72sMl5VqxgNvKIthPxfUF1UbMnc0gkrLn
         tT6Bwl8QxiDfE8VRs9OxJ7ImF4dpy+lpn6QUD2N8Q+uSCczCaVMZA5oxOMBypGDFArxu
         gmLXgAm8z8eEZ5IF/nz3BJSSPSdIIiaJjlH0MjWIMsbZzj1i4bp9vkd/azsPk/57qbDg
         fDpw==
X-Gm-Message-State: AOJu0YyLLK4jsApnj0hFeDlNH+zxyvQIURdqqHpTHj3iU0WKtVHEe8Ig
	pFxLh1+kdtRZp1w+5FBiwpy/0edc1wJjslF7TE1C5EZZt30n1El/y8UGQH+kUA==
X-Gm-Gg: AR+sD127D+60jivrRN2S+XzXLKzY+zF7ZTqXhvdgX1A+X0tr3TdPUqp3NjyCDszbmLy
	dbhu02kvkMzCF5B3cNgo9LBuDsiEe9tvomL5LERn96LpIPrDfLAYuFyiKmnpy1IZRGaw3TTIVHo
	e36WqZp9Q7drNFIQHtyGqPPIF8gJWvhREx+aJyRDgBfL+jeK7PaBSkqj7FHRqKGdE/GEDaXyq1T
	WxiE5ffzd9Ns6+zTE3HKiCZ66VyBGu6bgqEu40rvuzgVcNu1aQHYgLY1g14+n8w3fz91Tabju9i
	13AKFf8upO5vq1dW4AX9E3lFt6EBAGX1JeeLX69OEFl9kCzhDeVtWlpnuyrmD2Qhn2on+ytG9SV
	CtCLlFpHRyQLOh9px9RTFnq/0wcx9lQxmkEFcHC+iqdPAQGCbAKnWFLX/74GK5KnDpP3O2gOJMi
	d49DA0KxcE2Th5y/tqJWqCOxLnQiIHjFgK2WPtBNm/c1IK4ZHLm1d/kfn701TfCj8=
X-Received: by 2002:a05:6830:2b14:b0:7e9:8867:cb23 with SMTP id 46e09a7af769-7f3b7b3ed2emr4635761a34.16.1786540589058;
        Wed, 12 Aug 2026 06:16:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3475bf1sm2677141a34.26.2026.08.12.06.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:28 -0700 (PDT)
Message-Id: <52dacc4924163812f8c68399ba7b56b6352e815a.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:17 +0000
Subject: [PATCH v2 2/6] gitk: condense repetitive code around color buttons
 into foreach loops
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

The color selection elements in the Preferences dialog are set up in a
very uniform manner. The code doing that has grown in the past by simply
modifying a copy of a paragraph. Extract the varying parts into a list
and then operate the repeating parts in a foreach loop. This helps a
later change where we want to set up the UI elements in a different way.

Change the UI names "markbgsep" and "selbgsep" to drop the "sep", which
has obviously been left over by accident when "hunksep" was copied.

Change the suffix "but" to "btn", which resonates a bit better when
reading the code.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 114 ++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 59 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index f5eb963b86..137940defb 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11832,55 +11832,46 @@ proc prefspage_colors {notebook} {
 
     ttk::label $page.cdisp -text [mc "Colors: press to choose"] -font mainfontbold
     grid $page.cdisp - -sticky w -pady 10
-    label $page.bg -padx 40 -relief sunk
-    ttk::button $page.bgbut -text [mc "Background"] \
-        -command [list choosecolor bgcolor {} $page [mc "background"]]
-    grid x $page.bgbut $page.bg -sticky w
-
-    label $page.fg -padx 40 -relief sunk
-    ttk::button $page.fgbut -text [mc "Foreground"] \
-        -command [list choosecolor fgcolor {} $page [mc "foreground"]]
-    grid x $page.fgbut $page.fg -sticky w
-
-    label $page.diffold -padx 40 -relief sunk
-    ttk::button $page.diffoldbut -text [mc "Diff: old lines"] \
-        -command [list choosecolor diffcolors 0 $page [mc "diff old lines"]]
-    grid x $page.diffoldbut $page.diffold -sticky w
-
-    label $page.diffoldbg -padx 40 -relief sunk
-    ttk::button $page.diffoldbgbut -text [mc "Diff: old lines bg"] \
-        -command [list choosecolor diffbgcolors 0 $page [mc "diff old lines bg"]]
-    grid x $page.diffoldbgbut $page.diffoldbg -sticky w
-
-    label $page.diffnew -padx 40 -relief sunk
-    ttk::button $page.diffnewbut -text [mc "Diff: new lines"] \
-        -command [list choosecolor diffcolors 1 $page [mc "diff new lines"]]
-    grid x $page.diffnewbut $page.diffnew -sticky w
-
-    label $page.diffnewbg -padx 40 -relief sunk
-    ttk::button $page.diffnewbgbut -text [mc "Diff: new lines bg"] \
-        -command [list choosecolor diffbgcolors 1 $page [mc "diff new lines bg"]]
-    grid x $page.diffnewbgbut $page.diffnewbg -sticky w
-
-    label $page.hunksep -padx 40 -relief sunk
-    ttk::button $page.hunksepbut -text [mc "Diff: hunk header"] \
-        -command [list choosecolor diffcolors 2 $page [mc "diff hunk header"]]
-    grid x $page.hunksepbut $page.hunksep -sticky w
-
-    label $page.markbgsep -padx 40 -relief sunk
-    ttk::button $page.markbgbut -text [mc "Marked line bg"] \
-        -command [list choosecolor markbgcolor {} $page [mc "marked line background"]]
-    grid x $page.markbgbut $page.markbgsep -sticky w
-
-    label $page.selbgsep -padx 40 -relief sunk
-    ttk::button $page.selbgbut -text [mc "Select bg"] \
-        -command [list choosecolor selectbgcolor {} $page [mc "background"]]
-    grid x $page.selbgbut $page.selbgsep -sticky w
-
-    label $page.linkfg -padx 40 -relief sunk
-    ttk::button $page.linkfgbut -text [mc "Link"] \
-        -command [list choosecolor linkfgcolor {} $page [mc "link"]]
-    grid x $page.linkfgbut $page.linkfg -sticky w
+
+    set coloruielems [list \
+        bg          bgcolor {} \
+                    [mc "Background"] \
+                    [mc "background"] \
+        fg          fgcolor {} \
+                    [mc "Foreground"] \
+                    [mc "foreground"] \
+        diffold     diffcolors 0 \
+                    [mc "Diff: old lines"] \
+                    [mc "diff old lines"] \
+        diffoldbg   diffbgcolors 0 \
+                    [mc "Diff: old lines bg"] \
+                    [mc "diff old lines bg"] \
+        diffnew     diffcolors 1 \
+                    [mc "Diff: new lines"] \
+                    [mc "diff new lines"] \
+        diffnewbg   diffbgcolors 1 \
+                    [mc "Diff: new lines bg"] \
+                    [mc "diff new lines bg"] \
+        hunksep     diffcolors 2 \
+                    [mc "Diff: hunk header"] \
+                    [mc "diff hunk header"] \
+        markbg      markbgcolor {} \
+                    [mc "Marked line bg"] \
+                    [mc "marked line background"] \
+        selbg       selectbgcolor {} \
+                    [mc "Select bg"] \
+                    [mc "background"] \
+        linkfg      linkfgcolor {} \
+                    [mc "Link"] \
+                    [mc "link"] \
+    ]
+
+    foreach {uielem colorvar idx label title} $coloruielems {
+        label $page.$uielem -padx 40 -relief sunk
+        ttk::button $page.${uielem}btn -text $label \
+            -command [list choosecolor $colorvar $idx $page $title]
+        grid x $page.${uielem}btn $page.$uielem -sticky w
+    }
 
     grid columnconfigure $page 2 -weight 1
     prefspage_set_colorswatches $page
@@ -11892,16 +11883,21 @@ proc prefspage_set_colorswatches {page} {
     global bgcolor fgcolor diffcolors selectbgcolor markbgcolor
     global diffbgcolors linkfgcolor
 
-    $page.bg configure -background $bgcolor
-    $page.fg configure -background $fgcolor
-    $page.diffold configure -background [lindex $diffcolors 0]
-    $page.diffoldbg configure -background [lindex $diffbgcolors 0]
-    $page.diffnew configure -background [lindex $diffcolors 1]
-    $page.diffnewbg configure -background [lindex $diffbgcolors 1]
-    $page.hunksep configure -background [lindex $diffcolors 2]
-    $page.markbgsep configure -background $markbgcolor
-    $page.selbgsep configure -background $selectbgcolor
-    $page.linkfg configure -background $linkfgcolor
+    set coloruielems [list \
+        bg        $bgcolor \
+        fg        $fgcolor \
+        diffold   [lindex $diffcolors 0] \
+        diffoldbg [lindex $diffbgcolors 0] \
+        diffnew   [lindex $diffcolors 1] \
+        diffnewbg [lindex $diffbgcolors 1] \
+        hunksep   [lindex $diffcolors 2] \
+        markbg    $markbgcolor \
+        selbg     $selectbgcolor \
+        linkfg    $linkfgcolor \
+    ]
+    foreach {uielem color} $coloruielems {
+        $page.$uielem configure -background $color
+    }
 }
 
 proc prefspage_fonts {notebook} {
-- 
gitgitgadget

