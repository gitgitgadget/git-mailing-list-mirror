Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00585C5E
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743476494; cv=none; b=DjuV78HYrQh3rReF9Zt6lgl1JsdJzODBi71pnjm8akcWxFnkFvL9Q1hgaKtKuA6HPD4uoSIU587tcWcj50ZhGIh/87TqhRSLdU3sEr5J+meTcvY0MXQ9dr/yfLydaElSkTCG2SXJjKho1mcd7grExuzKJv1062QcESRkHc1rmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743476494; c=relaxed/simple;
	bh=n1Lzr+Gh92b47/ExV+QGhZruiILiKDlCesRdBOvF/a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUyP1IQd2xUNOG4THopI0SsebsvxRXQd490LaMNpTJF1SKbJtWoB7WNT8GDKSOh8Roc81ipfcq3UYWVhi0bDIV95IZ8X9cFYSP7Tqzl31iqWiZZ+a6bE7WPFpZk+bpO9Lhq97ts0EVBjP+EWDmUffJ14VCJD+/wGRDGbufCun00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYocPB3u; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYocPB3u"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso77150526d6.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743476492; x=1744081292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdhwvXngjiqNGUBrpDqnSq+YKs4D+7BIiin22gXhdiU=;
        b=iYocPB3uE9tJbuq6P8/eJPP6iciX1araiVA9Wn+jAVJdN9JoGfyFZqOvbizUuWAG71
         ckBP5Q9RInAMiBsxDPoeZFeQR/4j972V2vyDHXfML5HN2LPGesNLAiBR58Al9ZPfekXj
         zi8Y1OYxyISTjrr0w+PT+wsbc9QVjASeZ5htZcaVZDNG09u/mgWKyzgc7RvDHvV5V2/t
         guBRcvtviQOYZ8pC+W7TQ1QNoZ1fIYxeul5xsuN9aw6qwp5yawqWf0IfMR2K+0OLZP03
         qStb0OiW1eC8jBHePP3HLdsEJJk8nYDNafQp6N3XmrVi9Tl0baQtiaooTOyOShOweCDw
         m4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743476492; x=1744081292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdhwvXngjiqNGUBrpDqnSq+YKs4D+7BIiin22gXhdiU=;
        b=XNDkZ0ab3Dq7pyEq3qLt1RoWgLM9OdrQltq0dDINIiI1x5Ed40wGTM9AR0iG6Jse+O
         DppQHJdlKsxcoOdnNVU5RPZhxHG6bi46h89mJoZ2e7abvKu8mqi6drA5ABSEMulnLcBr
         Tv5orfMR5MCMsqzbYNhjK2xAmt4Nmr/yEAOoJSpUh7o1WnocTQ+E1W+xnve6zD7EKKlu
         0ze276WYzArawx3NK8x26H1AirIhNRHNwWGiEwR9YO6a2XznGEMGikCYNPqboSGXasTX
         8qQNX+nI/1WsdTxPdbDiDw1i9VL/0vszAUuZJWI7hZVkngthT1Es4VrOytlnxM5TNn2y
         vpHQ==
X-Gm-Message-State: AOJu0YzSaYMrDGUdOvIyYcsP/dHTsK5LQCMbDghCELj6sxeEPKY+ZRvq
	5pbh5mNxdRdUy5ohRsnY9YouRJlzNXGkeNGPiLth6EbKgkz8if5F
X-Gm-Gg: ASbGncvLZKpP1bFYJXa9sbZyBDQ0eCIMkXkRTyDBra1pTncjanmyVAQL1ldugG8jOxn
	XuZMKBZ/vSIJPRi5s9UQSXeGAsL9ZiI4jWByO5BAN/QKTcS0z/OyHbZYDc3f1pQP1flNGkjAsAY
	M2chbt+UL3QZEzq/cRHqTNlTsBvcl801lb6hQtofuQJu3Piwe3zeqzBoy2xDlQzBQp85KoZ8nh1
	jvCJev1IochTCVgQzKOiOS3jbxNvburvrHThhqqDlvygJJWr6yPOwjaGjBGP4uiSAdYVsNjYNP8
	ggcTkFYDmTvxaBS4jO6LC4mHA5MR
X-Google-Smtp-Source: AGHT+IG7Hc0/uAaifBiLVHYzRrqXwVeWeM+3U0yrzhEWq8AM+0lkG4xStzJl5WOrvhfnkyAQvDRRug==
X-Received: by 2002:ad4:5dea:0:b0:6e8:9b26:8c5 with SMTP id 6a1803df08f44-6eed5f796camr164985226d6.10.1743476492069;
        Mon, 31 Mar 2025 20:01:32 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec96284d7sm55209556d6.1.2025.03.31.20.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:01:31 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org,
	johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 1/3] gitk: override $PATH search only on Windows
Date: Mon, 31 Mar 2025 23:01:00 -0400
Message-ID: <20250401030102.297272-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.31
In-Reply-To: <20250401030102.297272-1-mlevedahl@gmail.com>
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
 <20250401030102.297272-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4cbe9e0e2 was written to address problems that result from Tcl's
documented behavior on Windows where the current working directory and a
number of Windows system directories are automatically prepended to
$PATH when searching for executables [1].  This basic Windows behavior
has resulted in more than one CVE against git for Windows:
CVE-2023-23618, CVE-2022-41953 are listed on the git for Windows github
website for the Tcl components of git (gitk, git-gui).

4cbe9e0e2 is intended to restrict the search to looking only in
directories given in $PATH and in the given order, which is exactly the
Tcl behavior documented to exist on non-Windows platforms [1]. Thus,
this change could have been written to affect only Windows, leaving
other platforms alone.

However, 4cbe9e0e2 implements the override for all platforms. This
includes specialized code for Cygwin, copied from git-gui prior to
commit 7145c654 on https://github.com/j6t/git-gui, so targets a
long retired Cygwin port of the Windows Tcl/Tk using Windows pathnames.
Since 2012, Cygwin uses a Unix/X11 port requiring Unix pathnames,
meaning 4cbe9e0e2 is incompatible.  4cbe9e0e2 also induces an infinite
recursion as _which now invokes the exec wrapper that invokes _which.
This is part of git v2.49.0, so gitk on Cygwin is broken in that
release.

Rather than fix the unnecessary override code for Cygwin, let's just
limit the override of exec/open to Windows, leaving all other platforms
using their native exec/open as they did prior to 4cbe9e0e2. This patch
wraps the override code in an "if {[is_Windows]} { ... }" block while
removing the non-Windows code added in 4cbe9e0e2.

[1] see https://www.tcl-lang.org/man/tcl8.6/TclCmd/exec.htm

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 gitk | 146 ++++++++++++++++++++++++-----------------------------------
 1 file changed, 58 insertions(+), 88 deletions(-)

diff --git a/gitk b/gitk
index bc9efa1..a101b07 100755
--- a/gitk
+++ b/gitk
@@ -13,13 +13,6 @@ package require Tk
 ##
 ## Enabling platform-specific code paths
 
-proc is_MacOSX {} {
-	if {[tk windowingsystem] eq {aqua}} {
-		return 1
-	}
-	return 0
-}
-
 proc is_Windows {} {
 	if {$::tcl_platform(platform) eq {windows}} {
 		return 1
@@ -27,36 +20,16 @@ proc is_Windows {} {
 	return 0
 }
 
-set _iscygwin {}
-proc is_Cygwin {} {
-	global _iscygwin
-	if {$_iscygwin eq {}} {
-		if {[string match "CYGWIN_*" $::tcl_platform(os)]} {
-			set _iscygwin 1
-		} else {
-			set _iscygwin 0
-		}
-	}
-	return $_iscygwin
-}
-
 ######################################################################
 ##
 ## PATH lookup
 
-set _search_path {}
-proc _which {what args} {
-	global env _search_exe _search_path
-
-	if {$_search_path eq {}} {
-		if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
-			set _search_path [split [exec cygpath \
-				--windows \
-				--path \
-				--absolute \
-				$env(PATH)] {;}]
-			set _search_exe .exe
-		} elseif {[is_Windows]} {
+if {[is_Windows]} {
+	set _search_path {}
+	proc _which {what args} {
+		global env _search_exe _search_path
+
+		if {$_search_path eq {}} {
 			set gitguidir [file dirname [info script]]
 			regsub -all ";" $gitguidir "\\;" gitguidir
 			set env(PATH) "$gitguidir;$env(PATH)"
@@ -65,81 +38,78 @@ proc _which {what args} {
 			set _search_path [lsearch -all -inline -not -exact \
 				$_search_path ""]
 			set _search_exe .exe
-		} else {
-			set _search_path [split $env(PATH) :]
-			set _search_exe {}
 		}
-	}
 
-	if {[is_Windows] && [lsearch -exact $args -script] >= 0} {
-		set suffix {}
-	} else {
-		set suffix $_search_exe
-	}
+		if {[lsearch -exact $args -script] >= 0} {
+			set suffix {}
+		} else {
+			set suffix $_search_exe
+		}
 
-	foreach p $_search_path {
-		set p [file join $p $what$suffix]
-		if {[file exists $p]} {
-			return [file normalize $p]
+		foreach p $_search_path {
+			set p [file join $p $what$suffix]
+			if {[file exists $p]} {
+				return [file normalize $p]
+			}
 		}
+		return {}
 	}
-	return {}
-}
 
-proc sanitize_command_line {command_line from_index} {
-	set i $from_index
-	while {$i < [llength $command_line]} {
-		set cmd [lindex $command_line $i]
-		if {[file pathtype $cmd] ne "absolute"} {
-			set fullpath [_which $cmd]
-			if {$fullpath eq ""} {
-				throw {NOT-FOUND} "$cmd not found in PATH"
+	proc sanitize_command_line {command_line from_index} {
+		set i $from_index
+		while {$i < [llength $command_line]} {
+			set cmd [lindex $command_line $i]
+			if {[file pathtype $cmd] ne "absolute"} {
+				set fullpath [_which $cmd]
+				if {$fullpath eq ""} {
+					throw {NOT-FOUND} "$cmd not found in PATH"
+				}
+				lset command_line $i $fullpath
 			}
-			lset command_line $i $fullpath
-		}
 
-		# handle piped commands, e.g. `exec A | B`
-		for {incr i} {$i < [llength $command_line]} {incr i} {
-			if {[lindex $command_line $i] eq "|"} {
-				incr i
-				break
+			# handle piped commands, e.g. `exec A | B`
+			for {incr i} {$i < [llength $command_line]} {incr i} {
+				if {[lindex $command_line $i] eq "|"} {
+					incr i
+					break
+				}
 			}
 		}
+		return $command_line
 	}
-	return $command_line
-}
 
-# Override `exec` to avoid unsafe PATH lookup
+	# Override `exec` to avoid unsafe PATH lookup
 
-rename exec real_exec
+	rename exec real_exec
 
-proc exec {args} {
-	# skip options
-	for {set i 0} {$i < [llength $args]} {incr i} {
-		set arg [lindex $args $i]
-		if {$arg eq "--"} {
-			incr i
-			break
-		}
-		if {[string range $arg 0 0] ne "-"} {
-			break
+	proc exec {args} {
+		# skip options
+		for {set i 0} {$i < [llength $args]} {incr i} {
+			set arg [lindex $args $i]
+			if {$arg eq "--"} {
+				incr i
+				break
+			}
+			if {[string range $arg 0 0] ne "-"} {
+				break
+			}
 		}
+		set args [sanitize_command_line $args $i]
+		uplevel 1 real_exec $args
 	}
-	set args [sanitize_command_line $args $i]
-	uplevel 1 real_exec $args
-}
 
-# Override `open` to avoid unsafe PATH lookup
+	# Override `open` to avoid unsafe PATH lookup
 
-rename open real_open
+	rename open real_open
 
-proc open {args} {
-	set arg0 [lindex $args 0]
-	if {[string range $arg0 0 0] eq "|"} {
-		set command_line [string trim [string range $arg0 1 end]]
-		lset args 0 "| [sanitize_command_line $command_line 0]"
+	proc open {args} {
+		set arg0 [lindex $args 0]
+		if {[string range $arg0 0 0] eq "|"} {
+			set command_line [string trim [string range $arg0 1 end]]
+			lset args 0 "| [sanitize_command_line $command_line 0]"
+		}
+		uplevel 1 real_open $args
 	}
-	uplevel 1 real_open $args
 }
 
 # End of safe PATH lookup stuff
-- 
2.49.0.99.31

