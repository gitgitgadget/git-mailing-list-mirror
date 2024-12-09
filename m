Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154D70819
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767743; cv=none; b=V2FXCtvLoovebRwy2frSK3CjGxE3k6Zgdw7m7bHUrWmnapNy8iiyP9vcaYEE8VCy4fd8aViYG6TYlvhIacTU7AgD2uoAfOqdwW7Ki+XlF5/QBKYyKeTMwvMutje8ivuBt99/wrJWSSoTUX6Lt8BFIhNK210ndeXBDClmTxiY2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767743; c=relaxed/simple;
	bh=3+juZQ019wtpi3SOcZTJ7osevloepnuDeeuhTiUl7qs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lecNxsIPCMZ4E81Zzuq7Fp4K/Iqj/Juima+0TH0ynKSB6qBHbWSl1IRmbb3HZG3omOS6D+4582570DH+tb/qrvzXSTelHx5vrjBJNCQuvnqnT94neauGTGaihuCJQE+es62QGIjjeM+3azkVxaGbJBDXq4ggR0q1/Eh4VHpFXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmn348Lp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmn348Lp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso3948350f8f.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767740; x=1734372540; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXRpARscPDVG+UIPeR1TSS+Nr+/W6X6AbKzSdHhOQdg=;
        b=mmn348Lp9pAQESBoY3A7Pn4gM1KACRO50SH46nty4uZjQizwDpl25NnmuzNlhnG6FZ
         nIdsw4VjxzjQgQuH8480LN+Y3VnmjZVQN8ZxkwkHSUzlk/CUIgU5bC3Tnso4HofHRexA
         usKTnXdunFEdWwhNCUw4dz4sZGW5c6U9WzRm5tFeDv5OQTvMdBA4bM6Q7QxRNdz5ITkD
         SGh8rJGwXjcfqoNvUtcdMXm/nn1x43yfcuZOW7SmFwaYKRoUgjYkric30njbhRCwjRaf
         J1JNJdiqwRJiCqsBa0YpUSOIxt7ZdaMS5qWJSMwGPuNTAlVecSjCXKTNvFzEz4FWlYPF
         aGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767740; x=1734372540;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXRpARscPDVG+UIPeR1TSS+Nr+/W6X6AbKzSdHhOQdg=;
        b=b9+cR9VHKpbfoVvIzSCHLXeWBNYM7B1dXQ6vxZY+VzNaErwtDT84J/8UoubPlqKyit
         swBi5MreDTjKjWTY2g5Q73RtH6m4u+goWMzQwPz273j1fM6kDzJUovTBHWwDDTSLQyDl
         eZ/gkDB4g0rfbYVQPOO+UN3teWqcfP5ilH0K/KBN8Ji6EDT1HrTOfcn9Ogk6N7zxYXbm
         bFiInA2wWBADJr1pPqGSXfE8esl6z7ap6A/Fp3ixuXZTexIE4JRm+Di9FdKeDXt0y5FY
         nYgsYxEhbH8WoAsFr0g/InIfwL1EW0cdr+2uxUkSiiIfEiwbCpwVKgIr+bYnwErtM9Kf
         buWg==
X-Gm-Message-State: AOJu0YyILVVB6ZF/frF0jON4HkFEYC2md0nNWfNYNpuDI09EMTp4t4Vc
	EEU4u04oj9mtZvgSExMW16G2lJqWOm2Y974jh06J7E8pjge81/aq1tth6Q==
X-Gm-Gg: ASbGncuPYliSifST/hlnqqcZlgY3MkpBUYJucTQ4sjwt9BbPUuYwmuNL0pDa6DOVJ2M
	AVCfrJIThwWcDRYmGEoit9u6DFo0xWkJJtDaLGufQ4AIgi+Fm9OhP7ZYci0+IjBSTMA2KkJqHfS
	Z2Af+klzCC7QX7VQu1FgeZSPAjp+5jsA9L44/GruA/MmwYHU9UoZ3JsdUj7ivDtyQ8343ouHuvz
	zN7RC+l4Ad60esCj++yEyRAq3LRDs/XtKKqIJCQCcejqY+iu14=
X-Google-Smtp-Source: AGHT+IFh/jY30X0Hw1rCZLZ7krZMcmOrBpwoIIMY4f2Xdc1rFoXsBYvEBcZ7mhr6TW88RYD09dnkAg==
X-Received: by 2002:a05:6000:2a83:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-386453e7472mr1275807f8f.34.1733767739547;
        Mon, 09 Dec 2024 10:08:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a85f2sm13613603f8f.29.2024.12.09.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:08:59 -0800 (PST)
Message-Id: <d58ce9d609d8a5da3edd1e1061d84919af12b02d.1733767737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
References: <pull.1835.git.1733767737.gitgitgadget@gmail.com>
From: "Christoph Sommer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Dec 2024 18:08:56 +0000
Subject: [PATCH 1/2] gitk: make headings of preferences bold
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
Cc: Christoph Sommer <sommer@cms-labs.org>,
    Christoph Sommer <sommer@cms-labs.org>

From: Christoph Sommer <sommer@cms-labs.org>

Make preference groups like "Diff display options" stand out more.

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
---
 gitk-git/gitk | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d7..d024e58d016 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11581,7 +11581,7 @@ proc prefspage_general {notebook} {
 
     set page [create_prefs_page $notebook.general]
 
-    ${NS}::label $page.ldisp -text [mc "Commit list display options"]
+    ${NS}::label $page.ldisp -text [mc "Commit list display options"] -font mainfontbold
     grid $page.ldisp - -sticky w -pady 10
     ${NS}::label $page.spacer -text " "
     ${NS}::label $page.maxwidthl -text [mc "Maximum graph width (lines)"]
@@ -11602,7 +11602,7 @@ proc prefspage_general {notebook} {
         -variable hideremotes
     grid x $page.hideremotes -sticky w
 
-    ${NS}::label $page.ddisp -text [mc "Diff display options"]
+    ${NS}::label $page.ddisp -text [mc "Diff display options"] -font mainfontbold
     grid $page.ddisp - -sticky w -pady 10
     ${NS}::label $page.tabstopl -text [mc "Tab spacing"]
     spinbox $page.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
@@ -11635,7 +11635,7 @@ proc prefspage_general {notebook} {
     pack configure $page.webbrowserf.l -padx 10
     grid x $page.webbrowserf $page.webbrowser -sticky ew
 
-    ${NS}::label $page.lgen -text [mc "General options"]
+    ${NS}::label $page.lgen -text [mc "General options"] -font mainfontbold
     grid $page.lgen - -sticky w -pady 10
     ${NS}::checkbutton $page.want_ttk -variable want_ttk \
         -text [mc "Use themed widgets"]
@@ -11654,7 +11654,7 @@ proc prefspage_colors {notebook} {
 
     set page [create_prefs_page $notebook.colors]
 
-    ${NS}::label $page.cdisp -text [mc "Colors: press to choose"]
+    ${NS}::label $page.cdisp -text [mc "Colors: press to choose"] -font mainfontbold
     grid $page.cdisp - -sticky w -pady 10
     label $page.ui -padx 40 -relief sunk -background $uicolor
     ${NS}::button $page.uibut -text [mc "Interface"] \
@@ -11712,7 +11712,7 @@ proc prefspage_colors {notebook} {
 proc prefspage_fonts {notebook} {
     global NS
     set page [create_prefs_page $notebook.fonts]
-    ${NS}::label $page.cfont -text [mc "Fonts: press to choose"]
+    ${NS}::label $page.cfont -text [mc "Fonts: press to choose"] -font mainfontbold
     grid $page.cfont - -sticky w -pady 10
     mkfontdisp mainfont $page [mc "Main font"]
     mkfontdisp textfont $page [mc "Diff display font"]
-- 
gitgitgadget

