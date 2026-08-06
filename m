Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8283DFC6D
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998430; cv=none; b=GK5p+2wUHgCzAexdEIDJni9uhZfNdpHDjwCA7x3+zvYA2zrZ3OVC7r6682HIFmyGIwEhjCmvQRJUIwCV2n9ULnCVaCvInLgfx1fFbiNCbvPBNfL90PC/OFRFzHdXh+SuZS5ZnpLT9BgoU5s/c2pxoqYIEBd3uzdnkKdcwQSO2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998430; c=relaxed/simple;
	bh=O1wI4/taZvKjI9Oz5gfrCfhU7Kw6aQR2fEFl++b1718=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IcorFhxKtgiusw1VkQ/5H/uSrjJ0hSdbU+K3VqOhlULKyPZmMTHpyGVaJoc/UHntPIShohrqGiUlef81zDRv37/A472sn9CdMAQ7cyKVT9Sg0orfwRxA6CdWZR7aUPjewx8YwOlhaDF9ooNR90C5xNSGBdmS+HckcCdjeHAlyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+5MB7jg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+5MB7jg"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ee4399c3abso1369887a34.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998428; x=1786603228; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IwsFvMyFVU6tVpMyWCLr/Z3+cu+HcQMtzr+g87Od/60=;
        b=G+5MB7jgo0UdXpZ16jmyU3vX2bxmFqwxyn35feeJEasyqstDKPjZMJtlm1n6jfrN8A
         +OC1tseMOfJFdmwE+gC/2JceZ6WzF0ORXOLfBXIFY5O6DGEOylw09n73f1Qn9TlUayCx
         I1QaO3v7TWZZXOso0z41raD9S2M5eOTpvaQQE+SxK1KPZA65OHEacPhQcNiciE783rbQ
         jbAISVmsVl0tsWiCK+tAJeNz3JtJx/g7H1XIlUeGQEXAZTn2HZfGt+ATGpsXNPopHKBo
         TToW2tQOO+QaNkNd0hIWhVSnobZsP5BneMf8LyPbWoLfs/4zboi9AbBr/B3w8MSAFaAo
         C7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998428; x=1786603228;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwsFvMyFVU6tVpMyWCLr/Z3+cu+HcQMtzr+g87Od/60=;
        b=UlFysj6KIqwZ/QKYjbek9guuM4NJpX3R5qUju7vXbYv4ZQbujtPu06oNfLQ+LuJJ6U
         cgQnv722tTR16h9FeoMOmAoKk/nx4B7QZ2+FcqB0d/e6zHb4PmUxMogu8ve8ZNT83sA6
         R+egcin2hTFhD+UeleKbk1QJCNQrykhk53dWZOXDcJ4s2lhK2mR/J8orEsnIW8NoOZjV
         dw1IOucA+9WqE7bTLgtXtJd8tMy8sXqWZ/YsHdpd727MR+jK+TYSbmld7djpuWW0HqyF
         YqxA/WCoV++G+VgrYOiIBhq3V4TeXzH8GAChoHkPYoTCtXYgAtVKXyBGwHGMBT5gV4m4
         d9pw==
X-Gm-Message-State: AOJu0Yy9TYFLfOTHqG4WCKPQX75rulpzARauKt0VFu+o4qK6Iq8vyBQm
	8fBLZRzio3GKcJz4c4Sq1j9ImXwIJJQUpSa6/IotLeUxH9Ivnz8dAdNpNJWFseRO
X-Gm-Gg: AR+sD106ABiD+p7lLk4FcMoBBlqwWCTB5EwbYzzlf00twgCUcCCh8teM/S85uQkl9+L
	1/wXENGWAHL4odDqa7vTmJTisLAUBSoREVaOg9utlV91dgmUtC8GWOJM+aJlzpXV5qgMLeoGe2r
	1AMQQ/s0O5vUKS0hNXgc4XqiwdEwVHs+X0zryLklm6mxyGd1yMNkHiidxlqadXkk/5l01Rszcom
	TcY3kQi9V4RFi4b3ohyMjNR6oLj+0sDnsm5ME+3ZmKE1uU3Zmpgeg2xgpKM3Zk8i6WjJECFeleF
	JirW3yJlOJs/O7tPcLUH3X42BB0ZKiu/ZvVgkv46cYXeWD13byp7rKbfDJYbQi8Q/YH7TlIXUvM
	yO1VdTxGy9aodnPslC9ySM98ysKio2fq8kLtOMSlcR1e7h7yjaRop3r1wrieBHbHZVp0F+L86a7
	uctu5+iuAsR2CKexcO8m4XcxXoc4dSWURJriHNcvnIjeLhKJ2I+dJpKxT+01bATc+FzJ7IfrFND
	YI=
X-Received: by 2002:a05:6830:6d25:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f1e5d2f8b8mr8056915a34.7.1785998427698;
        Wed, 05 Aug 2026 23:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1defe4a4esm3995076a34.0.2026.08.05.23.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:26 -0700 (PDT)
Message-Id: <edb567608e1bda16efbdb8d4ec359318cf105284.1785998419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:15 +0000
Subject: [PATCH 2/5] gitk: condense repetitive code around color buttons into
 foreach loops
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

