Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91A3876A7
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998428; cv=none; b=CwHjgY2FGmAW+Ab5z37+jCqMlrfyC/3+14Y6SM6rgnnpJjQvapX3LYM23sLZXxLvbVQlHdqwElGMhnMlwtGzwN63H3gouBvw8yYGtXyiGlpvUdIjYixJvRdcOfzcdiiex4r/LW7KCjriCDMXK1pDbgKHfx4lb79TmpxJE/+sJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998428; c=relaxed/simple;
	bh=S9o3R454c07JWe2UM2ssBNcYBFniz9a7LhwN+ZjmXMs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qRwTMZ+m6SEUoxn8D+tnL612q+OXkcIKzkd4U4WT8OSpapZRwmVq9DP0gZW9gfCzX08TLW3AwaDv0u+LnPSda98NNT7+lCXlHTwopAENAZi6b9+NzZ7+hC5ewJoDltGjTJ9WvxhMSLkNXoDNx0OHKMdz2TR/elZrjcYeLXfp2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaCtl63U; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaCtl63U"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f18c0e03e3so1003920a34.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998426; x=1786603226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sIJNkM+9LrBaKJBpUIlOTSwrWxkc9Ju6OUWvm//YNtM=;
        b=gaCtl63U6/V/U8b7vMSoAkYNUBLX35Chc/LvM4m+bSQ252bAnTe5SRuRVZNei1tZkb
         gxBZ1UvW/Dd8X/SZORkQeBQ+N+Zu149SAj4+ANbTIS0VyQZONRIgquhD68QpA+6b5JSr
         gJc/kZyt3T3H5GaShlBPnXIk3ZT1WZEMEPXcTxYcYRqt2wETCTI8ZO0cY3dCzzEII8TA
         YA0W90vVJr496gm7cqRwitXY8I51SbcYGz95SIaRCFCmNNUs6i+jinlp1CPbmZiYcKNK
         iqDRsOgsIT9VyBxX0qMpPVT1PCNc6FE0AvVPOwN1C9vpBCgXbScDrC4UrOuxfukJdEuI
         l0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998426; x=1786603226;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIJNkM+9LrBaKJBpUIlOTSwrWxkc9Ju6OUWvm//YNtM=;
        b=TbhgeOwSdfuxa4R5dVOaFHg85ZA5SPSVEcHlaD305x/18RwvtC1HD0WvQX0zI8OAwK
         rfei3eJ/r2CgqVAA2GNoojoB1bCSWEC8Gz/wCo/VzkYDFWoJNj7PR5brgFViurkgneFK
         qXH8lUaBpNBJCdwGR84TCLI2t6nCyF8du5f3bIxgPOpwS6LJpPU+fBVA43Gg/5yeVq9T
         WOJ0g74pvQPdMxKJpzFXaANRgWQcbytSKC3ySBQZVKtC0SP7BQTA0fNPNtQFcoGU6CFD
         OpMo3KFK9tvF/ORdshAJseoQz+Z6MlhVNNZg68cA5x/mFyFa2Xg+kQ1vxfphiPmbz2Ft
         YIeg==
X-Gm-Message-State: AOJu0YwN7ijVc1vTvs02DWmwnCYz7kPLupGMjfmtXdckS+jJlVkCyC3B
	JjFu4f16KwiwYavDjwCrexOorWEgvJZ+gqDxbaMfJ48aGObMyl24F0jG3n43gDAy
X-Gm-Gg: AR+sD10qrlHvWOkmnVb8lgHgFjtU3NPx2y4Hd+GGCuUZud/8tJKSJZQs3EelVRn45b+
	AF7HpMUaMj2njjuoRGGaLliR164jxP4wToKwDTHX37BjRVEoZErl9g48Rd/UkYpfKe4FSAs4h9x
	A751j8kor6xZU5BJpFTfYNiMz2g5n2Cu5qK8uRSsWebTG+HzEkBzUUQ5DPAfOm1/cqzaVreBPhW
	+nB8YYI0kvfB2dkLeexObXxqw/7JDi6arI/5WeUR2TH+mBIVzW60SWp23/BBday8pE7vTkKz+f9
	QkYHlrkNCX/WNbHPV6EziAdmetmiRr3TcTwLQqnxtM9I99GkkppWGMoe8A9CGQC32pMK28MxeQL
	VUyrc8I8d5FXiJ+5HuMxwy4pLnbtS6zaoWria8KmDMl4djt8G9D8rbOH0zX8jW1K5iWnznyL9+6
	K3nRcQj6VbpOnTZSLqwS6lvFG01iR5FjvuHOJifBApfindVnGDaYaCzL2GuA8fw7Xl
X-Received: by 2002:a05:6830:2b1e:b0:7e9:e313:4fdb with SMTP id 46e09a7af769-7f1e5c29681mr7998692a34.2.1785998425647;
        Wed, 05 Aug 2026 23:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1defe4a4esm3995029a34.0.2026.08.05.23.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:24 -0700 (PDT)
Message-Id: <ab16ec6276e448db3c8150e58e2f08d137317198.1785998419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:14 +0000
Subject: [PATCH 1/5] gitk: set intitial colors of swatches using the available
 helper
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

After the user has selected a color in the Preferences dialog, the
helper proc prefspage_set_colorswatches is used update the colors shown
in the Preferences dialog. Use this proc also after the Preferences
dialog is constructed to show the initial colors. This keeps the
procedure that gives the UI elements their colors in a single place.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 0f3571050b..f5eb963b86 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11801,8 +11801,6 @@ proc prefspage_general {notebook} {
 }
 
 proc prefspage_colors {notebook} {
-    global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global diffbgcolors linkfgcolor
     global themeloader
 
     set page [create_prefs_page $notebook.colors]
@@ -11834,63 +11832,64 @@ proc prefspage_colors {notebook} {
 
     ttk::label $page.cdisp -text [mc "Colors: press to choose"] -font mainfontbold
     grid $page.cdisp - -sticky w -pady 10
-    label $page.bg -padx 40 -relief sunk -background $bgcolor
+    label $page.bg -padx 40 -relief sunk
     ttk::button $page.bgbut -text [mc "Background"] \
         -command [list choosecolor bgcolor {} $page [mc "background"]]
     grid x $page.bgbut $page.bg -sticky w
 
-    label $page.fg -padx 40 -relief sunk -background $fgcolor
+    label $page.fg -padx 40 -relief sunk
     ttk::button $page.fgbut -text [mc "Foreground"] \
         -command [list choosecolor fgcolor {} $page [mc "foreground"]]
     grid x $page.fgbut $page.fg -sticky w
 
-    label $page.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
+    label $page.diffold -padx 40 -relief sunk
     ttk::button $page.diffoldbut -text [mc "Diff: old lines"] \
         -command [list choosecolor diffcolors 0 $page [mc "diff old lines"]]
     grid x $page.diffoldbut $page.diffold -sticky w
 
-    label $page.diffoldbg -padx 40 -relief sunk -background [lindex $diffbgcolors 0]
+    label $page.diffoldbg -padx 40 -relief sunk
     ttk::button $page.diffoldbgbut -text [mc "Diff: old lines bg"] \
         -command [list choosecolor diffbgcolors 0 $page [mc "diff old lines bg"]]
     grid x $page.diffoldbgbut $page.diffoldbg -sticky w
 
-    label $page.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
+    label $page.diffnew -padx 40 -relief sunk
     ttk::button $page.diffnewbut -text [mc "Diff: new lines"] \
         -command [list choosecolor diffcolors 1 $page [mc "diff new lines"]]
     grid x $page.diffnewbut $page.diffnew -sticky w
 
-    label $page.diffnewbg -padx 40 -relief sunk -background [lindex $diffbgcolors 1]
+    label $page.diffnewbg -padx 40 -relief sunk
     ttk::button $page.diffnewbgbut -text [mc "Diff: new lines bg"] \
         -command [list choosecolor diffbgcolors 1 $page [mc "diff new lines bg"]]
     grid x $page.diffnewbgbut $page.diffnewbg -sticky w
 
-    label $page.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
+    label $page.hunksep -padx 40 -relief sunk
     ttk::button $page.hunksepbut -text [mc "Diff: hunk header"] \
         -command [list choosecolor diffcolors 2 $page [mc "diff hunk header"]]
     grid x $page.hunksepbut $page.hunksep -sticky w
 
-    label $page.markbgsep -padx 40 -relief sunk -background $markbgcolor
+    label $page.markbgsep -padx 40 -relief sunk
     ttk::button $page.markbgbut -text [mc "Marked line bg"] \
         -command [list choosecolor markbgcolor {} $page [mc "marked line background"]]
     grid x $page.markbgbut $page.markbgsep -sticky w
 
-    label $page.selbgsep -padx 40 -relief sunk -background $selectbgcolor
+    label $page.selbgsep -padx 40 -relief sunk
     ttk::button $page.selbgbut -text [mc "Select bg"] \
         -command [list choosecolor selectbgcolor {} $page [mc "background"]]
     grid x $page.selbgbut $page.selbgsep -sticky w
 
-    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
+    label $page.linkfg -padx 40 -relief sunk
     ttk::button $page.linkfgbut -text [mc "Link"] \
         -command [list choosecolor linkfgcolor {} $page [mc "link"]]
     grid x $page.linkfgbut $page.linkfg -sticky w
 
     grid columnconfigure $page 2 -weight 1
+    prefspage_set_colorswatches $page
 
     return $page
 }
 
 proc prefspage_set_colorswatches {page} {
-    global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
+    global bgcolor fgcolor diffcolors selectbgcolor markbgcolor
     global diffbgcolors linkfgcolor
 
     $page.bg configure -background $bgcolor
-- 
gitgitgadget

