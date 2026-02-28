Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EA3A0B10
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265590; cv=none; b=N8ytSLBhgbJwkA2QRmKoRA75jRyKtjjYHsvYA3zOQBs6lLjA5kPafz2pn5h0o+xBnqv2dxnqyl1d6CdSI43XzexX5tJY6u9Dl7NtGP4Ke13JXhZOwpnmW3M+cKeI/LaffNBdJacZrZK7/ZTNNS8yNwCdYSofiwsc/mQml8fhxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265590; c=relaxed/simple;
	bh=Jame3lc7WcQsvbzG5VdzjZcDp5C5skVU9FV2DwriAhQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XBhhT96pAOgQglBRa2RWoO9rQYBv81ZjuPeKhKXkB/ymSQEVXTO7zVWp3M8Svs29dprGTmg6Xcf0E9+eWt4s9eummHHI8KLaqff6vTlhupMdnZ0VRB25n2RE2p3kIh7qUdQ/gkATbsctj/XRztpn5I/sYaxt2f0uOckTt/Gz0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asxW3/Ld; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asxW3/Ld"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3e0093e3so271564785a.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772265586; x=1772870386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uJ8oNMGXNSSJdy8PC0eS4l3myfk+JayRvTpKEXWXho=;
        b=asxW3/LdcQY7bTq6cqh5DHGfGxIP+rZ2zIFU0qzfMzsBigBje9U3tW53iiGR2sOhJd
         LqSDtVYCz8+f2bcNjdjmnrH1R5uxpLAniEeRpO1RQ0+FyKXky+yM9I4bipsIRIGGGmWV
         5DLHerDk0ZPVpPyjxXsePAxajkhjFeJESH1fu5IB9rURMvMhHfg3UXf7ojAtpsq7pGjv
         /zgrqJr6Js+vaHDESN5vtWZXCyjflnII245TvFajFUapHT/7GJlvSgvW5lFxzGLASxBE
         P5V+uJ6YP1887DxpSBAnuPHjz3gj9YqzRCezmmwrl+CqgqOS9r1NeoqvYiEbst1WLECi
         MXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772265586; x=1772870386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9uJ8oNMGXNSSJdy8PC0eS4l3myfk+JayRvTpKEXWXho=;
        b=T+9pu80fTy7HrHmJcF36zxBMdYm4xLleZllPyMEl50t9CkzQfHOdtebL5C5qmFc9YJ
         IPiQ1PSEYuuOZmhonJx+O0AzeX0lem3dQp++LG42kAbrt4CYzET+f7Us2CY9fYMBITw/
         Te7wC3sirywtXKCfXMWYKYLNkaYPXaLgLoiYxC2Le9Vyi9jx9jD97sHlqn0Go7If8jUw
         FJlXf0qRWhkoUteSlglClYpfGZNV0XLKyN7Xoc7cNyC4XwE+Aw4jEnrLaQlX3LPuJhWa
         eKf3fQXksBIGTKwTBqP9Y5HEwN7GpIpRkl4l0QACDVtOnHZrwSWulzOZVL+xAnzWPoTV
         hXKw==
X-Gm-Message-State: AOJu0YwrDzjZWcm07TLB5Qd8N9oE868Qi7ZlpWMPyS4gjK32c7c2YBGX
	zE3jYiZX1l9mdSKLzYWvG24ulcqvvymhEa7vutKZq8q8t8yaei9OdniyVSU6V1ls
X-Gm-Gg: ATEYQzzEJ8kwFp4m5wYKTDmHTtyFwLUOy8l+g+/3vX03bTRTlBuIZQdwVlgqEl+uIlq
	htWtb8y8ddxrL5okwCT0aN4mJyHG9Aq+JBh32L1pp8ssS8vOFPvWDR1rLUFmYKgDqLPwxxyaHoX
	B76Z8WidLQaaMl5wmRCGnx8Z9mRBEVE3yrHfg/fyGOOCvK7c2ul8m/WdalJX8/2YPVJ7vP9iiMM
	c6U4q2THm8ow8ykPMMPl14AX5UXTRu9gTWPwHTihcNLIFELVmge3ceIjkw6w7GUYzWKSxyS8vB6
	FFjRARnAkzPPSQoD9ZI+rbsd274OxjT1KPijiD/iavxgCnF1cUZ9CN+QA6Pp7DU2Q99kfIFhyVm
	SMjFwS064hP/TPAYZk2NnrfvMF77+VUj55hy1tf8Ceo0B/uxfXxomE1tJYXh85CT+EtIXOKsnTA
	koS8Fnq53bThYeTiaTmovl/+QflQ==
X-Received: by 2002:a05:620a:198f:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8cbc8d83930mr654707585a.11.1772265586368;
        Fri, 27 Feb 2026 23:59:46 -0800 (PST)
Received: from [127.0.0.1] ([52.162.137.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf678156sm746340885a.18.2026.02.27.23.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:59:45 -0800 (PST)
Message-Id: <pull.2217.v3.git.git.1772265584806.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v2.git.git.1772251558434.gitgitgadget@gmail.com>
References: <pull.2217.v2.git.git.1772251558434.gitgitgadget@gmail.com>
From: "Gary Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Feb 2026 07:59:44 +0000
Subject: [PATCH v3] gitk: support link color in the Preferences dialog
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
Cc: Mark Levedahl <mlevedahl@gmail.com>,
    Paul Mackerras <paulus@samba.org>,
    Johannes Sixt <j6t@kdbg.org>,
    Gary Wang <git@blumia.net>,
    Wang Zichong <wangzichong@deepin.org>

From: Wang Zichong <wangzichong@deepin.org>

As a dark-theme user, I use the Preferences dialog to set colors
for gitk. The only color I cannot change via that dialog is the
link foreground color, which leads to using the default link color
on a dark background that makes it hard to read.

Make the link foreground color also configurable in the Gitk
Preferences dialog's Color tab, so users won't need to dig into
the code/manual to check if it is configurable and can simply set
the color there.

Signed-off-by: Wang Zichong <wangzichong@deepin.org>
---
    gitk: support config the color of linkfgcolor via Gitk Preferences

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2217%2FBLumia%2Fgitk-linkfgcolor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2217/BLumia/gitk-linkfgcolor-v3
Pull-Request: https://github.com/git/git/pull/2217

Range-diff vs v2:

 1:  f533af7ac5 ! 1:  a2be1c0441 gitk: support link color in the Preferences dialog
     @@ Commit message
          the code/manual to check if it is configurable and can simply set
          the color there.
      
     -    CC: Mark Levedahl <mlevedahl@gmail.com>
     -    CC: Paul Mackerras <paulus@samba.org>
     -    CC: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Wang Zichong <wangzichong@deepin.org>
          ---
     -    Changelog (v2):
     +    Changelog (v3):
      
     -      * reword commit message as suggesed by Johannes
     -      * Rename button text from "link color" to "link" as suggested
     -        by Johannes
     +      * Remove CC list from commit message as suggested by Hannes
      
       ## gitk-git/gitk ##
      @@ gitk-git/gitk: proc prefspage_general {notebook} {


Changelog (v3):

  * Remove CC list from commit message as suggested by Hannes
---
 gitk-git/gitk | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index cbaaee994e..1c289174d5 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11796,7 +11796,7 @@ proc prefspage_general {notebook} {
 
 proc prefspage_colors {notebook} {
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global diffbgcolors
+    global diffbgcolors linkfgcolor
     global themeloader
 
     set page [create_prefs_page $notebook.colors]
@@ -11873,6 +11873,11 @@ proc prefspage_colors {notebook} {
         -command [list choosecolor selectbgcolor {} $page [mc "background"]]
     grid x $page.selbgbut $page.selbgsep -sticky w
 
+    label $page.linkfg -padx 40 -relief sunk -background $linkfgcolor
+    ttk::button $page.linkfgbut -text [mc "Link"] \
+        -command [list choosecolor linkfgcolor {} $page [mc "link"]]
+    grid x $page.linkfgbut $page.linkfg -sticky w
+
     grid columnconfigure $page 2 -weight 1
 
     return $page
@@ -11880,7 +11885,7 @@ proc prefspage_colors {notebook} {
 
 proc prefspage_set_colorswatches {page} {
     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
-    global diffbgcolors
+    global diffbgcolors linkfgcolor
 
     $page.bg configure -background $bgcolor
     $page.fg configure -background $fgcolor
@@ -11891,6 +11896,7 @@ proc prefspage_set_colorswatches {page} {
     $page.hunksep configure -background [lindex $diffcolors 2]
     $page.markbgsep configure -background $markbgcolor
     $page.selbgsep configure -background $selectbgcolor
+    $page.linkfg configure -background $linkfgcolor
 }
 
 proc prefspage_fonts {notebook} {

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
