Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF62DC796
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787120; cv=none; b=RYY/HiMgTkXr+Ibcs2KsclRpai54DTNbceUmMMeC1xr3WzjC9U3heNfeDNLWkPKQ+dbNHg+He6d8h75hp6M0OvZVby2OHlaB7s7w0eOguDdsm2gXhxQ0Vl9XFQrTx25rc/K7rWBXCGMpLUvPqmsTyymiYlJ6m8M/3l0MVX5nM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787120; c=relaxed/simple;
	bh=9gEVP6O/SFpk6gFMD8XfSe9zs9eMu/1zQExFULIdh7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2vMSebh7rB/PYVGhYtKbvyTaUlL77RK/oN1NCHShaGkVyiUOV3DjK1PqDeyKKapSBqz2cF4Fd3sRyy/f51vjaxgA+WnQ0LLBg0kkm0enh//7/L3O6FkXBdoI/tNXDsu31MK16SjJxBfogCRuLccMwA7A7lt4iMbs9XtzKYOil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saxb/8su; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saxb/8su"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-72267c05050so25373417b3.3
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757787118; x=1758391918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auQ4OGuzAbnifEysjvfodoyxuuCmZ4O8p+CTa8UZVFg=;
        b=Saxb/8suXBhK8piU3rmp4kfN5zEGWrSuA3kjbaVzG+4bubIWmiM/ykmGg75cE/gvWK
         S0fz11ivTCFGRO7b0T54o7KF3TW3FLkZLZJd4kaR2LiN+G+28PxviVcgQHsmapSR8tc8
         qi7hzUSFpYhD5p9yQAJldoJdvATE59DHMnlS3r5fiA2wx6yCFzVmPla2AAYA9vTJK5u5
         SrhdK/iv6b5yLOESDcfcRC7nnj3yLln1JcpqI95zAlFhITEz33wFUFZpcnr2EA8+lvrS
         n/V8LxM40s7phYYTQV8BnhxQeeszj4f61oo0Dc/MvX8sE1DqLjtC5Q5L1lfWOcb5Z7cD
         TWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757787118; x=1758391918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auQ4OGuzAbnifEysjvfodoyxuuCmZ4O8p+CTa8UZVFg=;
        b=MYUvBApM012XmJAKeKpG+EhHG4PgBYOmSA77u/j1v7vSzWO5drOMhq5CRm+2SV1CXD
         cWHbVCIsvdu8o9pgOHSryefmynCGbnI2AF1Jr4Tgt8cvJJ4Bh+u83iBqKYHFidEqajV7
         0+V6aa13ZrRCvA3kTQWxDI2l+LnR/WPRCfmypJDcynLNVQwL6xgsd0D2BFpOXfenuG3D
         HZP8F0F0WLnD2fMoyvAbSarUYmoEyqweMbT3e3ixQ0rJBaErjCA7AmuINnZ0/+BNeJYO
         hwV1hyJcVgH3PiCZcE4fx8AR/EWjY8D7svnD6uCHDHrauQDm7JgNppxD+vT7kFWObOet
         dS4A==
X-Gm-Message-State: AOJu0Yz+gdSozo//NUmCUtj9HuCIUareSwIP/C8ED27xdWfuiRSE1rt0
	IeswSNp+wLo+DeO8IJrfKesVVWO1CH1esL7H4vbLwUfZoIIacMLY3EFDL8tsQpKm
X-Gm-Gg: ASbGnctHGQgLE7O+Je2c4GGMhNcXLMon1im+V07p73QuY4e/dZJga/0XqGRIb5ySHOY
	2XRGi4lAWV9c5N3FkbKkzmHbvrZTMiXjtq8ohrM7nHFrxPhTonRQuYSliq6thM7mScEBVZdCRiF
	qB/1cJV4Xlh6Rfj9sQm8PlI/HYJkru+QmI2FzvBpdCzDjSgaoCrJKCOb2Fyo3B/oZzf90pBZoP7
	D+M7gt2eQVgdCvYM9uS9+wv5r8/pnoAlFmuxuaqYBiXuVnE3cg3gG5z8kwMoExGrFFf4AWL4m6M
	i6JwNp/RWZYLgLxsvU1G0zqyWi2IVk6HPB2urV/fdqNfHOhqVvP81xiRGoKgzGWpDSQ0A3RQhds
	NQE3qz/UlQzOw2QFzRp87lW0JhEuwe/00XHPP4U0RgqTe5CLZSuEJcieSKDYEHoAX2azhU4u0Yt
	SS3UX/TwSYKLcMREUB6o8740I2vpc7M1E=
X-Google-Smtp-Source: AGHT+IHvDz+QgHjdx9C2HeGnKZsRGYck5x0HNgDeSy1nUy8MeE9jMFor7kOExkr87SAzyJWlhdQAlg==
X-Received: by 2002:a05:690c:650a:b0:724:3a98:701b with SMTP id 00721157ae682-7306357d21fmr66693757b3.21.1757787117562;
        Sat, 13 Sep 2025 11:11:57 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79a8b7e2sm19882947b3.64.2025.09.13.11.11.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Sep 2025 11:11:57 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: make the 'Tags and Heads' window geometry sticky
Date: Sat, 13 Sep 2025 14:10:06 -0400
Message-ID: <20250913181153.46575-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Tags and Heads window always opens at a default position
and size, requiring users to reposition it each time. 

This change saves and restores the Tags and Heads window size and position
relative to the main gitk window. The geometry is stored in the config file
as `geometry(showrefs)` and persists between gitk sessions. The window
position is stored relative to the main window, so it maintains the same
spatial relationship when the main window is moved or when gitk is restarted
on different monitors.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 6e4d71d585..49b2ceefc0 100755
--- a/gitk
+++ b/gitk
@@ -3114,6 +3114,19 @@ proc savestuff {w} {
         puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
         puts $f "set geometry(botwidth) [winfo width .bleft]"
         puts $f "set geometry(botheight) [winfo height .bleft]"
+        if {[winfo exists .showrefs]} {
+            set geom [parse_geometry [wm geometry .showrefs]]
+            set main_geom [parse_geometry [wm geometry .]]
+            if {[llength $geom] == 4 && [llength $main_geom] == 4} {
+                lassign $geom w h x y
+                lassign $main_geom mw mh mx my
+                set rel_x [expr {$x - $mx}]
+                set rel_y [expr {$y - $my}]
+                puts $f "set geometry(showrefs) \"${w}x${h}+${rel_x}+${rel_y}\""
+            }
+        } elseif {[info exists geometry(showrefs)]} {
+            puts $f "set geometry(showrefs) \"$geometry(showrefs)\""
+        }
 
         array set view_save {}
         array set views {}
@@ -10207,11 +10220,13 @@ proc showrefs {} {
     if {[winfo exists $top]} {
         raise $top
         refill_reflist
+        wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
         return
     }
     ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     make_transient $top .
+    wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
     text $top.list -background $bgcolor -foreground $fgcolor \
         -selectbackground $selectbgcolor -font mainfont \
         -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -10237,8 +10252,8 @@ proc showrefs {} {
     ttk::checkbutton $top.sort -text [mc "Sort refs by type"] \
         -variable sortrefsbytype -command {refill_reflist}
     grid $top.sort - -sticky w -pady 2
-    ttk::button $top.close -command [list destroy $top] -text [mc "Close"]
-    bind $top <Key-Escape> [list destroy $top]
+    ttk::button $top.close -command [list destroy_showrefs $top] -text [mc "Close"]
+    bind $top <Key-Escape> [list destroy_showrefs $top]
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
     grid rowconfigure $top 0 -weight 1
@@ -10247,6 +10262,7 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    bind $top <Map> [list restore_showrefs_geometry $top]
 }
 
 proc sel_reflist {w x y} {
@@ -10279,6 +10295,61 @@ proc reflistfilter_change {n1 n2 op} {
     after 200 refill_reflist
 }
 
+proc parse_geometry {geom_string} {
+    if {[regexp {^(\d+)x(\d+)\+(-?\d+)\+(-?\d+)$} $geom_string -> w h x y]} {
+        return [list $w $h $x $y]
+    }
+    return {}
+}
+
+proc save_showrefs_geometry {top} {
+    global geometry
+
+    if {![winfo exists $top] || ![winfo exists .]} return
+
+    set geom [parse_geometry [wm geometry $top]]
+    set main_geom [parse_geometry [wm geometry .]]
+    if {[llength $geom] == 4 && [llength $main_geom] == 4} {
+        lassign $geom w h x y
+        lassign $main_geom mw mh mx my
+        set rel_x [expr {$x - $mx}]
+        set rel_y [expr {$y - $my}]
+        set geometry(showrefs) "${w}x${h}+${rel_x}+${rel_y}"
+    }
+}
+
+proc restore_showrefs_geometry {top} {
+    global geometry
+
+    if {![info exists geometry(showrefs)] || ![winfo exists $top] || ![winfo exists .]} return
+
+    set saved_geom [parse_geometry $geometry(showrefs)]
+    set main_geom [parse_geometry [wm geometry .]]
+    if {[llength $saved_geom] == 4 && [llength $main_geom] == 4} {
+        lassign $saved_geom w h rel_x rel_y
+        lassign $main_geom mw mh mx my
+
+        set abs_x [expr {$mx + $rel_x}]
+        set abs_y [expr {$my + $rel_y}]
+
+        # Ensure window stays on screen
+        set screen_w [winfo screenwidth .]
+        set screen_h [winfo screenheight .]
+        if {$abs_x < 0} { set abs_x 0 }
+        if {$abs_y < 0} { set abs_y 0 }
+        if {$abs_x + $w > $screen_w} { set abs_x [expr {$screen_w - $w}] }
+        if {$abs_y + $h > $screen_h} { set abs_y [expr {$screen_h - $h}] }
+
+        wm geometry $top "${w}x${h}+${abs_x}+${abs_y}"
+    }
+    bind $top <Map> {}
+}
+
+proc destroy_showrefs {top} {
+    save_showrefs_geometry $top
+    destroy $top
+}
+
 proc refill_reflist {} {
     global reflist reflistfilter showrefstop headids tagids otherrefids sortrefsbytype
     global curview upstreamofref
-- 
2.51.0

