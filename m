Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6033E344
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268591; cv=none; b=pAF3jM1OUuxzj4CGidiThQpv7+n1Uv5HC5nAyOZofBkWQuYmm4q8KOul58u5QB41NcqXCycoRMrbi5wjeSt9nJBXuQZHP8ND4PR4k+pNwsoxd6lcLtBMkn3QPAfV+D26efzu/apcO8Q5SkFsFbScv4e5QdrkQBJ2Pnc80aeXJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268591; c=relaxed/simple;
	bh=7wz6UFQJYB/rWLxlaYffuNfbbgMTHVCHwP3XlvT3TUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc2RoN9v94wqhvQSkMe1Wp5444JrlIeCRNjS1hTLeOhwSeD4zkoyVHnDtFSmC0GGPJ1RLgR9tKPE3PWVIZfZvp7XQAPfvqQpwuCa1HS0TH67Z+rCAV/e0j2M/8Yna2ed2eSOh5mTZSCW361v9OKkAK7cXSV4gZtV2T72X+ycySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD4lod1H; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD4lod1H"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so30627576d6.2
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268589; x=1780873389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9Za3z8Fbt76iVnoLht0yzAk0AU/kZanICCAMZNrveY=;
        b=tD4lod1HTVPnikRG+N5Rr8SA3jpucVJ9pY+Mnt2TkdEoa+IiWO99RcZNRPAgC0D0Sj
         WNiRdWTWOtR5eCqAUCi/1LDRkx2SxouVBdadTiTqcPCOmfKJRJESLRBwvqi+6EhhT2j4
         HWoS34NxFPrlVri+S9kqKenUv93jw1LfQEWp6S7Be0QMMsnpNucW74t+txjxf9Y5X12D
         4SclWBDzfkQySOxCTi4HbvqhF0VpM/eqdyQohzeeCojrEa+h6SiCyoEAcUBHZEVxr4AF
         tAqDP9xEI+JkFRn2mE9n1BfZuhosFImnozypgaYVqoQecmYxxIra37MwrsD8AuZkYlrh
         lRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268589; x=1780873389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9Za3z8Fbt76iVnoLht0yzAk0AU/kZanICCAMZNrveY=;
        b=P7ui957scPXGXzBwz5wv6tNjsdv1x+gQCMO6coT6bsumtrxGKRI+s1ZIso6AktXQrr
         LMfYSNfro3cQSGuCf5bSqxDzPNQk/WE8TG12IIPBmNnu4uF8QdiyVEKG2HRnNs3VvcG+
         MuI9c4TgTqKg2KKrxgNALdk9BY3WllSh++wVehvJz3TjZjg67ZPcGPdQnR3zcFq39gvF
         3OW+3PXy20uc7uIBMS0tdn0YTdD2Do0ZDo5W3hOkB0mP8xaSyMv30IxoFxpKIIU2C7BW
         WK+GEpwYx6ZJ3B9BhslubfrUqUhzG+gRx6HBHeLa3cf7FIPZWal7jrFN8iQVrq6fZKPI
         A6+A==
X-Gm-Message-State: AOJu0YwEgAgs4PKHwsnylIW4llYBtyPqJdgzzCYkEj4I6IXls2GlWP2z
	FKDv+JLsdHXcBRJWlyFYqXF4Tcd0mCWldc2jqt69J9CJhdWL0+dsrPW6GmCT58jc
X-Gm-Gg: Acq92OFOd3XQYqOCY3YgV2NH+vPP8b+ZPpPkhyoEoxhjWEasyEedvcf+pm0NdrkHIaS
	wxCNN+SwV7yS90OJRLBTDVaETsfKTTQefXd2gygJuMwEydFHi4UUXn5v8RPTdysTGP+aPamTItJ
	vlOhDVA18LKMPpD44XbvEtNuirnhiv+Dw5980mXfPFkwOpV/ladaGcuFgZhAD4gUGIJyzWv7pLR
	ZjSe5f8Ox1idxspTn29EScqYHovhhHMOyGzeCxQMwaT4KXGwsXXZpPLLzqI7dUyopWdxYYW8aq2
	HgbV3e9kaH/T01wedcyk+lhfRo1kCSO77vWH8cj0ccNMtlbdX0nXm+ejHOrMc5ZhRPpokz11O/E
	f3qjyrM7naF8fYt6tTAc5J5nt4vPI1m8S/DF1iFsUMzPgFEqfnWWw0MANGbD+XGlgDyZNiD+G62
	9eH61wcSYRQK4WVwby2vFh+CgXRRaCtNJPGkqQ
X-Received: by 2002:a05:6214:da6:b0:8ad:87a2:3c1a with SMTP id 6a1803df08f44-8ccefe014e0mr158161706d6.46.1780268588825;
        Sun, 31 May 2026 16:03:08 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:08 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 11/12] git-gui: check browser/blame arguments carefully
Date: Sun, 31 May 2026 19:02:24 -0400
Message-ID: <20260531230225.126817-12-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git gui offers two related commands, browser and blame, that provide
graphical interfaces driven by git ls-tree and git blame. As such, the
arguments to git-gui need to satisfy those two git commands. But,
git-gui does not assure this leading to confusing or incorrect results.
For instance 'git browser <non-existent path>' shows a blank browser
window rather than error message.

Also, commit 3e45ee1ef2 ("git-gui: Smarter command line parsing for
browser, blame", 2007-05-08) implemented code to allow giving path
before rev on the command line, and unconditionally uses the worktree to
disambiguate. As a result, the following command run in a current
git-gui checkout of the master branch shows the master branch version of
blame.tcl, when none should be shown as that file does not exist in
gitgui-0.6.0.

  git gui blame lib/blame.tcl gitgui-0.6.0

This 'file before rev' feature in git-gui mirrors ideas considered when
git's user interface was very young, but no such feature is documented
for any git command.  Rather than try to fix an idea git itself
rejected, let's just remove this broken and hopefully unused feature.

git-gui browser|blame both accept 'rev' and 'path' as command line
arguments.  rev defaults to 'HEAD' if not given, while path must be
given. path names a directory tree to ls-tree or a file to blame. path
must exist in rev for ls-tree and for blame.  In addition git blame will
include uncommitted changes from the worktree file at 'path' if rev is
not given (thus defaulting to HEAD), but still requires that the file
exists in HEAD.

So, let's clean up the parser to check that the arguments are usable.
- give a full synopsis, including '--' that may be used to separate rev and
  path. (as path is the required final arg, -- gives no extra info)
- explicitly check the number of arguments
- use rev-parse to assure a user supplied rev is valid
- use ls-tree to assure that path exists in rev
- for blame only, with no rev given and a worktree existing, also assure
  that path points to a file in the worktree

With these changes, error messages are thrown by the parser if the path
or rev are not known: no blank or erroneous displays are created. Also,
this avoids accessing the worktree except in the specific use case
supported by blame / git-blame, meaning browser|blame now also work
without a worktree.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 122 +++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 16d6b3051a..22939215a6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3000,101 +3000,105 @@ proc normalize_relpath {path} {
 	}
 }
 
+proc show_parse_err {err} {
+	if {[tk windowingsystem] eq "win32"} {
+		catch {wm withdraw .}
+		error_popup $err
+	} else {
+		puts stderr $err
+	}
+	exit 1
+}
+
 # -- Not a normal commit type invocation?  Do that instead!
 #
 switch -- $subcommand {
 browser -
 blame {
 	if {$subcommand eq "blame"} {
-		set subcommand_args {[--line=<num>] rev? path}
+		set subcommand_args {[--line=<num>] [rev] [--] <filename>}
+		set required_pathtype blob
 	} else {
-		set subcommand_args {rev? path}
+		set subcommand_args {[rev] [--] <dirname>}
+		set required_pathtype tree
 	}
-	if {$argv eq {}} usage
+	set maxargs [llength $subcommand_args]
+	set nargs [llength $argv]
+	if {$nargs < 1 || $nargs > $maxargs} usage
 	set head {}
 	set path {}
 	set jump_spec {}
-	set is_path 0
-	foreach a $argv {
-		set p [file join $_prefix $a]
 
-		if {$is_path || [file exists $p]} {
-			if {$path ne {}} usage
-			set path [normalize_relpath $p]
-			break
+	set iarg 0
+	foreach a $argv {
+		incr iarg
+		if {$iarg == $nargs} {
+			# final argument is path
+			set path [normalize_relpath [file join $_prefix $a]]
 		} elseif {$a eq {--}} {
-			if {$path ne {}} {
-				if {$head ne {}} usage
-				set head $path
-				set path {}
+			# allow before required final arg that must be path
+			if {$iarg != $nargs - 1} {
+				usage
 			}
-			set is_path 1
 		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
-			if {$jump_spec ne {} || $head ne {}} usage
+			# --line can only be the first arg
+			if {$iarg != 1 || $subcommand ne {blame}} usage
 			set jump_spec [list $lnum]
 		} elseif {$head eq {}} {
-			if {$head ne {}} usage
 			set head $a
-			set is_path 1
 		} else {
 			usage
 		}
 	}
-	unset is_path
 
-	if {$head ne {} && $path eq {}} {
-		if {[string index $head 0] eq {/}} {
-			set path [normalize_relpath $head]
-			set head {}
+	# If head not given, use current branch (HEAD),
+	# and blame will use worktree if there is one.
+	set use_worktree 0
+	if {$head eq {}} {
+		load_current_branch
+		set head $current_branch
+		if {$subcommand eq {blame} && ![is_bare]} {
+			if {![file isfile $path]} {
+				show_parse_err [mc "fatal: no such file '%s' in worktree" $path]
+			}
+			set use_worktree 1
+		}
+	} else {
+		if {[catch {
+				set commitid \
+					[git rev-parse --verify --end-of-options \
+					[strcat $head "^{commit}"]]
+			}]} {
+			show_parse_err [mc "fatal: '%s' is not a valid rev'" $head]
 		} else {
-			set path [normalize_relpath $_prefix$head]
-			set head {}
+			set current_branch $head
 		}
 	}
 
-	if {$head eq {}} {
-		load_current_branch
-	} else {
-		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
-			if {[catch {
-					set head [git rev-parse --verify $head]
-				} err]} {
-				if {[tk windowingsystem] eq "win32"} {
-					tk_messageBox -icon error -title [mc Error] -message $err
-				} else {
-					puts stderr $err
-				}
-				exit 1
-			}
+	# check path is known in head, and is file / directory as required
+	set pathtype {}
+	catch {set pathtype [git ls-tree {--format=%(objecttype)} $head $path]}
+	if {$pathtype ne {} && $path eq {.}} {
+		# ls-tree gives contents of root-dir, we need root-dir itself
+		set pathtype {tree}
+	}
+
+	if {$pathtype ne $required_pathtype} {
+		switch -- $required_pathtype {
+			tree {show_parse_err \
+				[mc "'%s' is not a directory in rev '%s'" $path $head]}
+			blob {show_parse_err \
+				[mc "'%s' is not a filename in rev '%s'" $path $head]}
 		}
-		set current_branch $head
 	}
 
 	wm deiconify .
 	switch -- $subcommand {
 	browser {
-		if {$jump_spec ne {}} usage
-		if {$head eq {}} {
-			if {$path ne {} && [file isdirectory $path]} {
-				set head $current_branch
-			} else {
-				set head $path
-				set path {}
-			}
-		}
 		browser::new $head $path
 	}
 	blame   {
-		if {$head eq {} && ![file exists $path]} {
-			catch {wm withdraw .}
-			tk_messageBox \
-				-icon error \
-				-type ok \
-				-title [mc "git-gui: fatal error"] \
-				-message [mc "fatal: cannot stat path %s: No such file or directory" $path]
-			exit 1
-		}
-		blame::new $head $path $jump_spec
+		blame::new [expr {$use_worktree ? {} : $head}] $path $jump_spec
 	}
 	}
 	return
-- 
2.54.0.99.14

