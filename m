Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28CE44BC9A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540590; cv=none; b=m/DOY7Zv8B9XCn3FlxE3wxpvf3z9MuxHm87BCh4Uyk2AaXLdqNBDQXUW7vQNR0a8TnKfueYf3vc7ilmSYkazGBJszWjcM9QyoYz/2unTux4PCApFaOKpe5aU2510Pjf48ENtbQApzEPpMnHlPpMQhx228vzC5yWDGUvU70uLSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540590; c=relaxed/simple;
	bh=v4JJPFTvEOsrFAwQKJeTeyPPfKsQAJE8rGU+O5ocdvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GsapMSOG29KwU2QHfmfaplzvtoBJ98G9R//PzWpasN88rhMjeeHPxFC6KZbGt78iCjgoOwJydp/bLaTKa4YYBi2RBMAyDhVUp5CH+D67y0onc2Vdd0iQhbP3I1MVtO6xmARMzvfOrFx8p+lFxsziMOtbGCjPJbE1U2dE55JheJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6QKJb6J; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6QKJb6J"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b026020b92so567878eaf.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540588; x=1787145388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J0HjYINYrPoT3ou/Sbj36Rg6hfEbvuxrkQEi9dbLXLw=;
        b=A6QKJb6JrUSMfhzW5ACBYIYUib7HZzoskeqxKwJzxlBodQYq5vLjMiMD/5ZmsuqS66
         LxwEzpAwZr2KtzgfpisSPAJRsHBS8+375gbS9ABkYipZKs6bf8iQjS7XCk1AFJITo69J
         lp6L9GD3u7TE3yLx32BiatbKGKqdY52v6BPz57GDA67Psmhaf9IGQAR/o63SLn7u2mNB
         zDodgwA/doM+nsza1/3aWjavW2TjTXCOnTJwmGovkaFqy+KwhDo3na7cTL9gwcKEPtkA
         2cVDctj6XDS7jHjUU4f7/S2ufAvkfto6hqbjf5rgdJ1KrCSFk9DL3qBlq4g+xC9+KL/g
         xQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540588; x=1787145388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0HjYINYrPoT3ou/Sbj36Rg6hfEbvuxrkQEi9dbLXLw=;
        b=YIC9nfp/zqw7fTnpV6oIZutQHlN2WHwu28pXLdhBCWyrdeB9tcSm0UwtQyYWFVsbyv
         n1itlwy/wf36e+vODuEFcds9/SLa5+N2KOYHuS88VBQgKnlclTJe1wRrOoyPT43jXDyS
         pCCqqIdqg6UOvGNflTUU1sEqdQ7JH63g1fPmS9fv8FeuDyctkQYuOWQChMonvzS8zp1n
         tUM9zKjaGjT4vENtQo8788vjGz5/88vVRGyK9xRPLpb0WKXbTtS60kOF8UDCdU/6o/V1
         F/f1BJXusEx0aYsbmkDKG43AZ2mcZlEMgU48eHaXuw5XeVpaWnz9CjJ/g4vDCeTZwB0V
         yyPQ==
X-Gm-Message-State: AOJu0YxHCaZ3qe79dDMlWMbcEF0X0EIKr19Y9zphOVTMsAl6Vnm78vcW
	kQPPL50uWXuNqUaqpqo1QxXk+TlCrUjsIO0ipr2sOvpzJJywco0VquQce8e5Ag==
X-Gm-Gg: AR+sD10DfMBoic06c+q7b1jA9lTOstX0+EDghDaQPCW/ckKlF2tR0cymI92Ps9tSbXB
	fw76ATSnFDhukXzMJKQxx7EzhAmxK5JBAqkGC/Jgc79oKZtPJLrdSUraUHbV69dQBmcxp2AEZyu
	fw6VH2Xe5dmcTLM7qYh/hrA7dVXVGY5vzwuzJVoJAKLfzzT0YBWifwAFRA10F/CFOF2AzmHCUG7
	NPK7uhn/xTeDpAXt3xrtuVetSN3THDPd2GryWg1j4eZj4zyIIC4tjAErEzcKBEpw2Zh23b/yAjN
	tiL3JA2mldECfCVH3uTCnRxGjpGuBv8Dqok+1K6kg9aQawJ+xs62dCO1lWURXi21XY9nCggBhMw
	YZ3iYIJooEOp1H4+P3y75JnP7Iac3XW1zFQXcGSMAJDshMvnZoHJVOS4Vtg245LDAuFPUEUMg5G
	OpmQJ+ZqjgE/aV+yXawYWkcwF2GuThHexVNsyRHvrUwsRYVyrXLIIToTyKaSS804o=
X-Received: by 2002:a05:6820:617:b0:6a3:8023:f344 with SMTP id 006d021491bc7-6b0b2892414mr3881185eaf.2.1786540587563;
        Wed, 12 Aug 2026 06:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad478ce6sm2753663eaf.1.2026.08.12.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:26 -0700 (PDT)
Message-Id: <e7e62f428b3f460f0849dd6095643a7769248f29.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:16 +0000
Subject: [PATCH v2 1/6] gitk: set intitial colors of swatches using the
 available helper
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

After the user has selected a color in the Preferences dialog, the
helper proc prefspage_set_colorswatches is used to update the colors
shown in the Preferences dialog. Use this proc also to show the initial
colors after the Preferences dialog is constructed. This keeps the
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

