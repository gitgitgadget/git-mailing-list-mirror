Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE92798E4
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855782; cv=none; b=F7m6gSqcZD9P4O/d2vHCuuTVE/b2GaPXeQXnALJo6O6r+4sUrn9ngNNCmAFjSWSVTLYraf61Beu8VHpj86Npvn4yhNzWxX+QFGwAU4TFxFEuec7rCG12un3avUL+Nl30Qg8sPl+omWIH8m1WT0yyDz+sGB6kCq7GgKrM3PIe//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855782; c=relaxed/simple;
	bh=8g7t0tPoaaDEINQUVp6F1ieY+r8nY9zTwQ87Y/1CVUo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T7GaEzwvlM9dfWPaBS6NFGfUox8lQQz9tyZX7ZwxdW7fNQj+Jk2OZ7Bq3x5oEf19JeaDtfjfMjogvJjIIvGb2N3e2g5kvGUVa2HJx3fIABF2LYDaa73xC6xhcCfF395ArtSd2ntUXMyjlxavQE0IpQY8gRsIi4QfYpktDWUKpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec83j6eI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec83j6eI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso3882070f8f.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745855777; x=1746460577; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN45tzFANl5BNZSZn4xiiBFScQyAiONLQ8ZtBJ+lVxE=;
        b=ec83j6eI+AauNBWqOpDkeBppM3l145PuilDI7abVwR4ANa92bNC7boC/pQt9cbGe57
         y1DVonCa50KR7diBIn9B/7pOTlegHLl6MnzD5i1YiW8AVVcUaUZyPRJ9L4kuqaZXE+ri
         LqSIgdN8QHBsjXX71I2WsXoAbyGC5RD0gRZt5+Mibh8hCIN7e3oP/IYS+BqSHuhymKQh
         Oc8JGVnJ+BwMNM7IFCvvsKaccpiM35TCCIhDIMnxLBwLnAF0D6s2i5/QZJUO1L2NaQZZ
         IUY6L3AhFYEmcgTarRhOj+kLb5ZNHlG5nMIe+fzc4kN1S8KcTgyM6q0fgGFkLTgkgeeW
         Gvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855777; x=1746460577;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN45tzFANl5BNZSZn4xiiBFScQyAiONLQ8ZtBJ+lVxE=;
        b=F9iPJu8nwPMVnAjEL87fQf8qZsZ+phLOHYHfNVxu1Vx0cZ1xORXMO2zwpWyVKDL2IA
         i86NhzWXUXy38lOlEQcMAkUDHf7XLbfyRRrv/CmLFZTf/ysix7NGAWgagjDl+NJ8N1Cx
         WtHtEsiHRl5RhcWse/3+vRbJ3tRh+gdMnekWRwhDt2BFuJRhDpyfwxCBcfaOq0ziGbYN
         KvuUBGOgS35J03v1AFRtftX5wMVapxxT5kDDUqYXAA+aHB4QeV8NbDkI9vAiAb9w0zEo
         vAWou0g4lWA0GJ6hryrQjTa0uZed+9EFlKXzBHkGCjbD3X2ZiGBT2vwPuCvA1vkSFjrk
         zh3Q==
X-Gm-Message-State: AOJu0YykHl0w/riek11lHqSMCuxrv8OuBWknJcdHCvyDs+46+ClG+VlU
	PfIpLAtnjZ1XWm+WGpzk3KuoYNHvKdAoxz+/9vIa/YhNVHQv5lo/pHALpg==
X-Gm-Gg: ASbGncsbbbRzWvPuUX/ceGR+Q+x+qVveMo3b9Orb9TFTLmRg6khdlDT7U2mtQOWIJ88
	KjFlORq9K6GQiKA7EDShcFa0nF1HI9x3VHvokhlZGF0IiB5lpEdz5M17MYfj4wzG3qX/uI6wcNb
	G/UJvns2hhQEViWsRpRG5BMVBk6hV0w+Lfp1kmPLajYLgyqftvuIBjaUN+reesjkKJIV1biCiSu
	2cphFM10VF+DbXZx3Rhll4EO90u4VLTtWthLRAu3CI32e9Zxiz5nQOeUI7P7eOTeCNhOiF4+/CP
	TnIIhoIshNCLxxNWqKrzUBrfD0mpXX04phHLKi4v6g==
X-Google-Smtp-Source: AGHT+IGslTBe8kvim9vd321A8bv0xk2zLLIEtsoEZUswHCtthVJVT64jMvUWLEcTRRCSPbt4vAjn0A==
X-Received: by 2002:a05:6000:144a:b0:3a0:8282:88e3 with SMTP id ffacd0b85a97d-3a08282890dmr4425138f8f.27.1745855777052;
        Mon, 28 Apr 2025 08:56:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cd7fsm11523186f8f.1.2025.04.28.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 08:56:16 -0700 (PDT)
Message-Id: <78d87c0ecc87df6c89130a6cbb417b534db8395d.1745855773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
References: <pull.1909.git.1745855773.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 15:56:13 +0000
Subject: [PATCH 3/3] gitk: on themed tk, use uicolor to draw a sash between
 panes
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
    Christoph Sommer <sommer@cms-labs.org>,
    Christoph Sommer <sommer@cms-labs.org>

From: Christoph Sommer <sommer@cms-labs.org>

Add a custom sash (grab/resize handle) where the window is split into
panes when using themed Tk as. Other than native Tk which draws sashes
by default, themed Tk does not, by default, render such handles leaving
users to guess where to click to start resizing window panes. The color
used for drawing these is uicolor, which is not needed on themed Tk,
allowing the user to make these elements as pronounced or as invisible
as desired.

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
---
 gitk-git/gitk | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index da7507af360..d19f29bbf18 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2133,7 +2133,31 @@ proc setoptions {} {
     option add *Listbox.font mainfont startupFile
 }
 
+proc createttkimages {} {
+    global uicolor
+
+    image create bitmap img:myVerticalSash -foreground $uicolor -data {
+        #define xbm_width 5
+        #define xbm_height 47
+        static unsigned char xbm_bits[] = {
+        0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
+        0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x00, 0x00, 0x0e, 0x00, 0x00, 0x0e,
+        0x00, 0x00, 0x0e, 0x00, 0x00, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
+        0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04 };
+    }
+
+    image create bitmap img:myHorizontalSash -foreground $uicolor -data {
+        #define xbm_width 47
+        #define xbm_height 5
+        static unsigned char xbm_bits[] = {
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90, 0x04, 0x00, 0x00,
+        0xff, 0xff, 0x93, 0xe4, 0xff, 0x7f, 0x00, 0x00, 0x90, 0x04, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+    }
+}
+
 proc setttkstyle {} {
+
     eval font configure TkDefaultFont [fontflags mainfont]
     eval font configure TkTextFont [fontflags textfont]
     eval font configure TkHeadingFont [fontflags mainfont]
@@ -2143,6 +2167,16 @@ proc setttkstyle {} {
     eval font configure TkIconFont    [fontflags uifont]
     eval font configure TkMenuFont    [fontflags uifont]
     eval font configure TkSmallCaptionFont [fontflags uifont]
+
+    createttkimages
+
+    ttk::style element create myVerticalSash image img:myVerticalSash -sticky ew
+
+    ttk::style element create myHorizontalSash image img:myHorizontalSash -sticky ns
+
+    ttk::style layout Vertical.Sash { myVerticalSash }
+
+    ttk::style layout Horizontal.Sash { myHorizontalSash }
 }
 
 # Make a menu and submenus.
@@ -11825,7 +11859,7 @@ proc prefspage_colors {notebook} {
     grid $page.cdisp - -sticky w -pady 10
     label $page.ui -padx 40 -relief sunk -background $uicolor
     ${NS}::button $page.uibut -text [mc "Interface"] \
-       -command [list choosecolor uicolor {} $page.ui [mc "interface"] setui]
+       -command [list choosecolor uicolor {} $page.ui [mc "interface"] setui_dialog]
     grid x $page.uibut $page.ui -sticky w
     label $page.bg -padx 40 -relief sunk -background $bgcolor
     ${NS}::button $page.bgbut -text [mc "Background"] \
@@ -12006,6 +12040,14 @@ proc setui {c} {
     tk_setPalette background $c selectColor $selc
 }
 
+proc setui_dialog {c} {
+    global uicolor
+
+    setui $c
+
+    createttkimages
+}
+
 proc setbg {c} {
     global bglist
 
@@ -12706,8 +12748,6 @@ eval font create textfontbold [fontflags textfont 1]
 parsefont uifont $uifont
 eval font create uifont [fontflags uifont]
 
-setui $uicolor
-
 setoptions
 
 # check that we can find a .git directory somewhere...
@@ -12788,6 +12828,8 @@ if {![info exists have_ttk]} {
 set use_ttk [expr {$have_ttk && $want_ttk}]
 set NS [expr {$use_ttk ? "ttk" : ""}]
 
+setui $uicolor
+
 if {$use_ttk} {
     setttkstyle
 }
-- 
gitgitgadget
