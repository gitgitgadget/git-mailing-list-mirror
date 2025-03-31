Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C21DF270
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433942; cv=none; b=esRct5erjlL7EtM7Y0+x6EKVS63LYPkkMTJvQACyzC6XxdBCNPUXcaFKBebO/eH0nT9XisVxWtpM9X2Ucp0ywpvAD5TTDcn1Cnr9RgQJgkRdKrikQeBD/TPxuwjPlW9JnPTnZX+gaH62jDYx+/MMKixw1kR8woPTwqQOMwscEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433942; c=relaxed/simple;
	bh=e+fpWNQQi1h1JRSLqLecjkehS0JRRlENyvw2AEizgk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eus6b/gjHF30nPF9HLG0W14LdNitGbYGqj89I72F3fQwZsgFhyfzGsVQStvqDyRyL20Qnr1Eqw2DPcwKR17lCTuuA1CC40rZqxp4aEGJSCfGpK0vNN5DPiYY1W80dzH8nsE9YrUqFhWSGGS4O54lgcq4861frX1F4t+WC5Xc1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcMLnKNY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcMLnKNY"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c592764e54so102413685a.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433939; x=1744038739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXcGu/3Z37pojExfMDnaCpuVeeCEzW6RiqJw5u/ilWo=;
        b=UcMLnKNYvRXKLfY7FRxlPRZqSoxVlxkdaM6kv4I36ayIDsmVfyyK0t8nVIiDiR8u6X
         Luvn9Ky/qXbh/2+gaMPUzxGIXcVRCWfzewORtBwKqakGTjoHu6/gtSYBmBH0hIYkl0AR
         25QMvOoTWCNs3uzhyjXbPKUN3DBn0spJXn8whdXdQ6s6oS2IaBfsn9b7rui5ZF6P0pXA
         HqmiOcFy2k2IzpCh6bGqZK8eRAOKe5hDaTAQTRf3TPCko922PvQuW8yWNhwvsxTu2I2/
         gNGqgbp5D4iN7HEXWcKFsc6gee3oOr1YOWZaj3im5fKwKwTXs6/U16SBq+CENYlzEGwo
         xeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433939; x=1744038739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXcGu/3Z37pojExfMDnaCpuVeeCEzW6RiqJw5u/ilWo=;
        b=omP/tfTiaLeLgdFLAVUD1ctEe4RRrErmSw1b0KMrnU/nUleezFOF/quqCdN+PccQTZ
         NB5AcOn2u7wg/PSMo/ViEdPQu6yGzyaQEs/jdXFA1jiv4stgOnP8h7I3DLoUkmaF7RAg
         TeUsSfRkLSy9pKTPbhOQ27t0hdsy/hUx/HB+1j5Gt1Tz/L2SnDGt84jkX0VufPBE0mW/
         iFCPHP8tAM7/IQ0iw9XIJiwSQ5bxDpVYi+ZmSvhJVxpjcmtiaa7lq6S+xsTXADpff1VP
         owaUByDWxQYNZW/Uw/twnehTCUjHStZvYuup27RLD5uaLr+bXg2lw/fIKXX25v9qICSD
         YPRw==
X-Gm-Message-State: AOJu0YzgaPsBFe5dBBy/yyGYKD3RQgWjAlvKV19MnchFeqSIVJ1z9yXN
	HgrUH2+B487jArzge9z8Ou/HBStV+ylPM4v4AzQwOtiYHWcpGohn
X-Gm-Gg: ASbGnctcf3AjTiLsq+hNX3BHy/CN+Tzf6TvoVbbAHzr27BK1bc5xuMWfERU3r47P5r2
	LTl+bVFHjWrE4H8PIGEua8ZBmn3fXZXDV6BiXPM4TkeZ1mEZEjuYPqUgnvfDppZtSfsG8RuB99n
	AeHjjCTY1lyiB+Yvl+f6Fj8uUYQtYk/gWVrAMhBGJzhh3foeq7CWKK5hN49EumK7J3MNy3LxX48
	Ntg7PFuphA7og1W4Un0OEc6UTdtzdRFajlyo6tkJsTlC36QZ8ZU+TiobrvmURubUTG2DcpHl08v
	CKt/wswxPhXIXFK2Z521slSVx8hW
X-Google-Smtp-Source: AGHT+IFTGcCnOaLlOr1Nzn7H89tpUs20wqRVlm0Dmk9mplFC+wI5ju3sS2b/Z98qQfN+WxjvgIzJmw==
X-Received: by 2002:a05:620a:f02:b0:7c5:4caa:21b6 with SMTP id af79cd13be357-7c690890298mr1313234185a.57.1743433939529;
        Mon, 31 Mar 2025 08:12:19 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76a6ee8sm509620685a.50.2025.03.31.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:12:18 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org,
	johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] gitk - override $PATH search only on Windows
Date: Mon, 31 Mar 2025 11:12:13 -0400
Message-ID: <20250331151213.274691-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.31
In-Reply-To: <53c31331-97ed-48be-8399-2701581b09a9@gmail.com>
References: <53c31331-97ed-48be-8399-2701581b09a9@gmail.com>
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

However, 4cbe9e0e2 implements the override for all platforms.  and
includes specialized code for Cygwin, copied copied from git-gui prior
to commit 6d2f9d90 on https://github.com/j6t/git-gui.git), so targets a
long retired Cygwin port of the Windows Tcl/Tk using Windows pathnames.
Since 2012, Cygwin uses a Unix/X11 port requiring Unix pathnames,
meaning 4cbe9e0e2 is incompatible. The patch also induces an infinite
recursion as _which now invokes the exec wrapper that invokes _which.
As this is part of git v2.49.0, gitk on Cygwin is broken in that
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

