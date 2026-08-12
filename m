Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBE44A739
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540597; cv=none; b=YxgasLLUcwNTMPGt0j3flX+DVfrI06ZbQFM6RAZZuRFh1rpcJqzm0f4ZbdAAM5icwnOVLDVh5VSgMtBTs8185BtddThpOobpGYzWUQzJ3ZhBox+PZq+TFkJ257X5eCsUDAgBr0BFkSCDPZ+4/pgYvS32WMn6Dk1JVsFuSbKKQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540597; c=relaxed/simple;
	bh=qI9JhmwbfF8RQFa6HBXO6w0XX4HUNLyaBjtgEOAlHiQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Uxvfy9JykpnLEHaAIe/+BquTOeJ9atpZtH26ciOm+31i+WsbWr+TJb8CJibEkZ7dlgqPi8Yz8By9BFTtgpicQGz/XzxUOQIZSY/fj9B7AIYxkNqmkmTbZUwOsXIZc/wDknDz/nTExRNzq9uk5ttvtVHgQzi9SG47tv0au/77BkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4jRJniZ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4jRJniZ"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b057877851so694923eaf.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540594; x=1787145394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qA+pCraz0XaBpQDNjpUMiwBNFCLz8r6WiiRH/RSpxrY=;
        b=Q4jRJniZdG/udLglgdB/tgXayIYhm/u1xVjQyvDbDWgYn+0U87Twz8xGfKTxjj1XQa
         6A1dYtOdYIy4qDFaUbC6K92R7TkhrpsLGHBJiF1OlF9lHk3ToFMCDtBB6p5ozU+g1Fn+
         lFm0t/tgNRoqVtonVVyilIEmwsk3xBHErfv0RCDcBJwNvTJEJxTvI7pH8tHKac0RWO6v
         2PduYQuYZhf9MSIhwqsLeDsICp1z/oABAmhS1SOI2Rjm+n71TY9twmj37eueaOdatyQH
         pswp4rtFlbOBT3U+ZAbVTxMPElYi1URZjWTNkLP5V3m1SUU9JKg+UGmWnp5v/BD3AzAD
         IEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540594; x=1787145394;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qA+pCraz0XaBpQDNjpUMiwBNFCLz8r6WiiRH/RSpxrY=;
        b=JvGOgHPV2oh779HLkBg5zO7JeBeFA8Rd6d/mqJZI/hHG/ZGvmcrsfZIgi14sXuNxlB
         iK9+oEjyv/3eghhJ5pbkItfdro5NuquXY+C95gDIikTJkitDG0oeiboRrtMsVSXSqJA9
         qSY2k4EhBxip6KHAXXyxn0Se1T7sJvusb67KhYyk94OsMOFcdcn85Y1kk7sKfhIt1kiH
         yoJB4EVAOMP5exBzQALpajACIGmqDiT7Ho1fWX/BzxC+pjUyU8/qpmJ35OdNgMJrFMsU
         312YDr6VDdkZQr0TZLXaXAZUxPgid9w1+iOxZoX3w7iL84rjqdHT1idiFO+OWVJBvYob
         pgaw==
X-Gm-Message-State: AOJu0Yy/yz5Z9/1E7ZBF//ExkucKgPfBhRm0NM3RMUwFmHgL/e0+xEe8
	YyLfg3+z4qMj+tAc2sTfIqJ3KP5xgXkakt0oUhqEXD1lcXhLkhutkOxk+a5zrQ==
X-Gm-Gg: AR+sD10aabDv24wYSgmPcovC+2pzcQzBirxV0aEIz9e9Y/PCf/ZnMTJ/x4TGTM1Ka89
	vyhSQG8okfgwD0/sTQ4Pq3/3A48HzWWKv5qLmbI7b4S/2Grxg9J+5cm0mYYH8mBsjBnYNXfihCV
	CUnmxoLqko4GROCP+p63zqIVOQSNobGuT/No5POqqx7YqrvyW6Yc4Wlxq+sBWshGONBLipEHXkc
	i/xFK1dGwRJEGwurJZ0C8DT85s2U/37+jjEEieMViH0aOPDpSLKAfA3eJnkrDfXOwVheN3aRl0o
	QvehIEfuEgMiBkRgsbeQb8iXsPYLw7VIysUDVqomfJtDBNnwWlWEZ53FCKY8BYIh6ggCJ0sdkwf
	qrW0keA+N7XWZ1sccltzgSKf2HNMPd2Re0J1bA5d+LzIvZOIVC6qk1Ow29Am0Ivc3AIKGRCbHZ/
	tdU/s6bXpDHPkhSyJU4BOYV6UwJselke8vJaX7ziX/kFEqkyWsjJPUUiXSb5KXsuHB/AJd
X-Received: by 2002:a05:6820:16a7:b0:6b0:4302:f587 with SMTP id 006d021491bc7-6b0b2c1c1aemr3421467eaf.31.1786540594506;
        Wed, 12 Aug 2026 06:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad4c6b04sm2669107eaf.4.2026.08.12.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:34 -0700 (PDT)
Message-Id: <697159c20e9903dc720d8afdd6535007e61fa095.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:20 +0000
Subject: [PATCH v2 5/6] gitk: avoid constructing dialog titles from text
 pieces
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
index c0ab55845b..d4c229a3c0 100755
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
                     [mc "Old line text"] \
-                    [mc "diff old lines"] \
+                    [mc "choose text color of old lines"] \
         diffoldbg   diffbgcolors 0 \
                     [mc "Old line background"] \
-                    [mc "diff old lines bg"] \
+                    [mc "choose background color of old lines"] \
         diffnew     diffcolors 1 \
                     [mc "New line text"] \
-                    [mc "diff new lines"] \
+                    [mc "choose text color of new lines"] \
         diffnewbg   diffbgcolors 1 \
                     [mc "New line background"] \
-                    [mc "diff new lines bg"] \
+                    [mc "choose background color of new lines"] \
         hunksep     diffcolors 2 \
                     [mc "Hunk header text"] \
-                    [mc "diff hunk header"] \
+                    [mc "choose text color of hunk headers"] \
         markbg      markbgcolor {} \
                     [mc "Marked line background"] \
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

