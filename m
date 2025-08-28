Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F81C01
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371535; cv=none; b=QN1WzLyvKMpjVVs1MYdoVUBF6FoZkkb4cgU6UblUcLpHiA5ewQ8dE2nOnToLPXPfBrltUe57fLfFN6Uz2LssmV07lQwLCkoKuKtzzQKuBfW5EmwvU+Gx67c3gqcNVqwUhyftqabGY8E1SLxDFgFDy+Vkrhuxh3DVMyMqCL72Klo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371535; c=relaxed/simple;
	bh=SfUnVfn8u4W6fqbiWP6+BW4V/o0ZB0VJgXiMkA5iVHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f4xqeSfABfIb7q+yzl6xIOmz4Ta0UFU281uofMjlFEXn2UK03vMkp8CI4OAgKnjpzxVoQCWMDVaBVpOqFZ/HQ2QlbK2tmm5kHPqwr8dUwJfo3OqFOFQaOeKo9TXLJ35TE2Pxo4v2nBx9lNij5SF6zJKDctkLyfp18w60I0em4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6BehHu0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6BehHu0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b618b7d33so5754695e9.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756371532; x=1756976332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlC8+kyDVef4P110KJqFiWTe9dRLWkEuc5Q95eqZ1jQ=;
        b=B6BehHu0+5Dl5PVkGkfAHGfX2ftb6LK+v5FRGq2sluLhLK7jnPOnybcDeutEhWLLQW
         6y4i5W/bVy8f46MvSLe0LuZx+y7mm6QnJNsu2pcl1VpseEEhNyTaE7cZfukdjase83EL
         gTvKKCp/s2o5iluTPkDkvDtRdPUYe4wA8PTsvDBNsATWUl6MF2A3yyoLktGUYt7jJybE
         P1FzOtaj+9qYNUij4MoXddsA0YOuQxfZx5TPEm0wCcsreUWqxVANiJNtoB0SOrb6A1Js
         3v68UkxH+OpWtwr50kuDM9ZGYj1fMsk1EfbSg0uF/oQZxYp1/k7OkmIZaPQi55AKHdfE
         jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371532; x=1756976332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlC8+kyDVef4P110KJqFiWTe9dRLWkEuc5Q95eqZ1jQ=;
        b=EW+WSVnbZ0WOmaskhZVHwM4H+9WzfgSdG7ZTHC1MuZrNqwmbDe/R9EOwsRWeJoOfm3
         v0rYFbrxABWRQ9yMfvqcrzffwt+T4bUBJqOOOMLCKf8hvHvKbZHP1/umNgik8lsmjNmf
         sxX7cfvc41gbn8pWIh3WKcbdleCy31f/cKVk69yldQtfGbeKmZZjwZEyTyniqaBr1dEf
         LqQo6o5myu60YzYsL+a+I1hWZx5afsM1HvfVbIMPKCZuF60oJRQgbjFKXKSyEow8j8+R
         S7nyM/Cd+S/7lgfrXow6uMLZX121Sz8wtEUBgYgWcciW/Iqor/E2tWKEcAnRIweRBCSP
         nS1w==
X-Gm-Message-State: AOJu0YxUKQLzhdyVtIz7sf1GFD+v0Wkkcfwqr2zf11P9JMiTEmERbBtj
	jlzHWu6jtOwLirTgXkIuJsRm8hpuEh1SYR5IcWXhkL+fL6zPto1NYpB2dHed2w==
X-Gm-Gg: ASbGncvyjDxqXVh8grJGaEjA1RQWPrIRgPQN6P1kjdts8lb5/Ugqj9dD4S55tLfg5c3
	19AffV3Fnng0P74Tr4NWYnV9ODEGagK8vbWik6RjfIuSz084UWzxswAUrJYLJeGxL/vth8dyqLo
	A0ehh1GvslbPmwpE0sOFSz9PxwQ15VcalQ7APdyghYeRkc0GLgDIJMB0XhOhBlF04+i3LFlxdgI
	I3dJ3l7KcmKgrXaYOezG7TAYbacMbvNF0JzFuQvU8Huhq8QV6jFf6vlVoJrF9CzWzaKIfZJKuXP
	Ty7A44yKKP+ChWG+GjewGDnZbieViUbigL005R9X+1rk2GHAT5psWs2Uu3mD94qCryw5VO0oMGo
	g5+poD5XTr9N2OTYFmwtScvW8lY07X/VbAMwbvw==
X-Google-Smtp-Source: AGHT+IGaT+nrS/kS/Ea0WP+58WU6GjgDt78hVfkeQaV1NC7nGSyRh12idH54sU1RA3SahBTsgeTvig==
X-Received: by 2002:a05:600c:c87:b0:45b:47e1:ef76 with SMTP id 5b1f17b1804b1-45b517dfe11mr180657765e9.37.1756371531553;
        Thu, 28 Aug 2025 01:58:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ce87c62433sm567259f8f.62.2025.08.28.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:58:51 -0700 (PDT)
Message-Id: <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.git.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:58:46 +0000
Subject: [PATCH v2 0/4] git-gui: GIT_ASK_YESNO/GIT_ASKPASS patches from Git for Windows
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Pratyush Yadav <me@yadavpratyush.com>

This is another set of patches from Git for Windows' fork that have been
sitting there since 2010, providing cross-platform GUI helpers to ask the
user a question or allow typing in a password.

This patch series was first submitted as
https://github.com/patthoyts/git-gui/pull/5 which was ignored for almost
three years, then re-submitted as
https://github.com/prati0100/git-gui/pull/3 which was rejected in favor of a
contribution by mail.

The patches are based on Git GUI's master branch at
https://github.com/j6t/git-gui/.

Changes since v1:

 * Rebased to current master branch of Git GUI, resolving merge conflicts.
 * Dropped double empty line.
 * Skip yes/no functions in favor of inline exit 0/exit 1.
 * The --title option is now documented in the git-gui--askyesno script.

Heiko Voigt (1):
  git-gui: provide question helper for retry fallback on Windows

Johannes Schindelin (3):
  git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
  git-gui--askyesno: allow overriding the window title
  git-gui--askyesno (mingw): use Git for Windows' icon, if available

 Makefile          |  2 ++
 git-gui--askyesno | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 git-gui.sh        |  6 +++++
 3 files changed, 71 insertions(+)
 create mode 100755 git-gui--askyesno


base-commit: e3923e3e90da55e12545b5ef5aa34f21e97409d8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-358%2Fdscho%2Fgit-gui-askpass-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-358/dscho/git-gui-askpass-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/358

Range-diff vs v1:

 1:  58972068a230 ! 1:  08b106ebedb9 git-gui: provide question helper for retry fallback on Windows
     @@ git-gui--askyesno (new)
      +}
      +
      +${NS}::frame .t
     -+${NS}::label .t.m -text $prompt -justify center -width 400px
     -+.t.m configure -wraplength 400px
     ++${NS}::label .t.m -text $prompt -justify center -width 40
     ++.t.m configure -wraplength 400
      +pack .t.m -side top -fill x -padx 20 -pady 20 -expand 1
      +pack .t -side top -fill x -ipadx 20 -ipady 20 -expand 1
      +
      +${NS}::frame .b
      +${NS}::frame .b.left -width 200
     -+${NS}::button .b.yes -text Yes -command yes
     -+${NS}::button .b.no  -text No  -command no
     -+
     ++${NS}::button .b.yes -text Yes -command {exit 0}
     ++${NS}::button .b.no  -text No  -command {exit 1}
      +
      +pack .b.left -side left -expand 1 -fill x
      +pack .b.yes -side left -expand 1
     @@ git-gui--askyesno (new)
      +bind . <Key-Return> {exit 0}
      +bind . <Key-Escape> {exit 1}
      +
     -+proc no {} {
     -+	exit 1
     -+}
     -+
     -+proc yes {} {
     -+	exit 0
     -+}
     -+
      +wm title . "Question?"
      +tk::PlaceWindow .
      
       ## git-gui.sh ##
     -@@ git-gui.sh: set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
     +@@ git-gui.sh: set argv0dir [file dirname [file normalize $::argv0]]
       if {![info exists env(SSH_ASKPASS)]} {
     - 	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
     + 	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
       }
      +if {![info exists env(GIT_ASK_YESNO)]} {
     -+	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
     ++	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
      +}
     + unset argv0dir
       
       ######################################################################
     - ##
 2:  cb9f8c8158c5 ! 2:  e1aef533bfe8 git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## git-gui.sh ##
     -@@ git-gui.sh: set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
     +@@ git-gui.sh: set argv0dir [file dirname [file normalize $::argv0]]
       if {![info exists env(SSH_ASKPASS)]} {
     - 	set env(SSH_ASKPASS) [gitexec git-gui--askpass]
     + 	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
       }
      +if {![info exists env(GIT_ASKPASS)]} {
      +	set env(GIT_ASKPASS) [gitexec git-gui--askpass]
      +}
       if {![info exists env(GIT_ASK_YESNO)]} {
     - 	set env(GIT_ASK_YESNO) [gitexec git-gui--askyesno]
     + 	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
       }
 3:  8cfc935cdba3 ! 3:  2e7e2c1524a7 git-gui--askyesno: allow overriding the window title
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## git-gui--askyesno ##
     +@@ git-gui--askyesno: exec wish "$0" -- "$@"
     + # This is an implementation of a simple yes no dialog
     + # which is injected into the git commandline by git gui
     + # in case a yesno question needs to be answered.
     ++#
     ++# The window title, which defaults to "Question?", can be
     ++# overridden via the optional `--title` command-line
     ++# option.
     + 
     + set NS {}
     + set use_ttk [package vsatisfies [package provide Tk] 8.5]
      @@ git-gui--askyesno: if {$use_ttk} {
       	set NS ttk
       }
     @@ git-gui--askyesno: if {$use_ttk} {
       	set prompt [join $argv " "]
       }
       
     -@@ git-gui--askyesno: proc yes {} {
     - 	exit 0
     - }
     +@@ git-gui--askyesno: pack .b -side bottom -fill x -ipadx 20 -ipady 15
     + bind . <Key-Return> {exit 0}
     + bind . <Key-Escape> {exit 1}
       
      -wm title . "Question?"
      +wm title . $title
 4:  6025b38d2659 ! 4:  4b04832c0b81 git-gui--askyesno (mingw): use Git for Windows' icon, if available
     @@ Metadata
       ## Commit message ##
          git-gui--askyesno (mingw): use Git for Windows' icon, if available
      
     -    For additional GUI goodness.
     +    This provides a unified look-and-feel in Git for Windows.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## git-gui--askyesno ##
     -@@ git-gui--askyesno: proc yes {} {
     - 	exit 0
     - }
     +@@ git-gui--askyesno: pack .b -side bottom -fill x -ipadx 20 -ipady 15
     + bind . <Key-Return> {exit 0}
     + bind . <Key-Escape> {exit 1}
       
      +if {$::tcl_platform(platform) eq {windows}} {
      +	set icopath [file dirname [file normalize $argv0]]

-- 
gitgitgadget
