Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6C14A619
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268558; cv=none; b=YPgX0QdmCJuuOQXkoWoJGkhw3Dzvmu21LXN01XXcRyY7F12wxNahDIMDzq+gnqAkFXKJFJojT+2BpQFr1tpGU9o84U91lb7PDnFEFyCCCOMTXIXC2Vc2bBNWkNyHslL3HNFSk44288d5x1qAYslXqJlEFfkBvaKKbb5AVl1ZMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268558; c=relaxed/simple;
	bh=V3rM4Vxt8O+40e63BS0VHdz+wiOaIwWf1XtWZk1eyT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNgSrm6cQPoLtXky6KgSgfUZ2ShlTBONuDiMpivqAWHbRulYOG54izkZNWkJCwTbxwQHIHEQL1s2hXB94hULKOipn7eUAdulBbGXr9HdVxa2X5i+aDe+8yUypd1jXVGSCcqGyavH3udMhI3vQnXqdhCzQspm86krmm7+JM7oH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxuO9nCD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxuO9nCD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5174363a843so12774771cf.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268556; x=1780873356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7SQh9Ce1r/nAsEQIbP79GBWLw76z7l86emiSVbL7LQ=;
        b=BxuO9nCDd+Ue+MWxkWon5Wno14ycJIeltls1iPkYhfaZX7Um/lNC25FsKST2GWQJKU
         16tgtS89opDXbyOGH82LCG80X6Noe1U5HDCRGj/okwnxzvl/YnePTgv1IncsPkBp+iM6
         GXJr4Kmb3obEzFFvPdeT9vlev+DEeAJoeU1Lg8Z3MGzTOeJMP+zt8ZYEJkmdAWKLGztp
         OpCiqGA9jTBVsFhjEO0FqM+1fUucOqQL+pkr9ES8KkDmaJ9Ba9LBPSKqu/vRGWMTZMwD
         SP9cKTLRoaGSY6xDgPB+yOG5m96REBNh0Egm7Rk7LT6NKjQhkUxQZ2dlHlMgUwr2VjqU
         Gfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268556; x=1780873356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7SQh9Ce1r/nAsEQIbP79GBWLw76z7l86emiSVbL7LQ=;
        b=Cnt0Zrv65bKAdf+v1v8n298G7c9nPQSFSNsZIfG2lACSGGYJ15S2oddmvVPQTSlaPJ
         hAA9cHfuFQGwDpiPzLt8yiNzZVBObluWsGU/eeqmhgSOe01EoxYxFJX+ck1c2X1NA95g
         GjgVNp6mVxdNr7x1gbSIB8z3np/28Ij7C5KZorF0DvchIbZ/WPIvB1EvJDtBOyVB6j5U
         eT53w8DO2wpTuJmnRztGcgDXmDKGsXUdnZSkLv0jPxbhbeHhU3BZeTsZ9WySzqwDHpbM
         3OwhvJvytujwLlk6aWx4vuNuk/IHaM6N1dOoGygQw8WIKSFuXSL9mUGdDU8PRYqVWJpz
         oPRA==
X-Gm-Message-State: AOJu0Yzqk0UjUhZu1l8CnafKE5pnCTFNjewp5yZmztaKFJ9Cnbq9OPG2
	Vp2bTTr1rJVcBdHGyKvDWNcLpNKwxQ8zcqaPj6DG1xtIZCKeTazy19yI0MsP7A==
X-Gm-Gg: Acq92OEJve2fp7pjoCv0g247Fk6i36ZyLr046sJdmYj8+++EYm7+n3n2OJ43TaPF4uN
	aAWWPw5B+fNzoiJrOhkJNwrQ4bYYEEXmEdnNDK6yHsgQ1eXDKdYcXU0sB7kxwQTq/LH7iTBYIMm
	MRDq2fzy8Fe3lShqJYmalS22TPtONC6uQt22m/eVlwZzA1YRrFU+3pANvHi5VHLO25Qhk1LBLuH
	S0LTrr7LQMSlE5ljRRn1fyobuNTQVPgjJ2utkS04aDmkP4azI+1ZY4O9x7+mfZV4pDMP6BliEvo
	NF/InqnkHy1pk1/uXAN6GKYGuA5KovkkOmwPSPgxQ5LJkXiQjqBH7GWzfO59a2QELTZiqCjTzSq
	04/fofIbL1RQSwoZzmWItm259vviQ7LtWBbdxOxgDtxYHWzMveonubNVl6uBtluZhS6ZuuQM3jD
	NIxNwRk9TWOh1AKBYmlxll/kfLsn0GW09X8Wlr92J4BSHk5uM=
X-Received: by 2002:ac8:7d81:0:b0:516:4059:f035 with SMTP id d75a77b69052e-5172dcc1e60mr144508261cf.29.1780268555850;
        Sun, 31 May 2026 16:02:35 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:02:35 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 00/12] Improve git gui operation without a worktree
Date: Sun, 31 May 2026 19:02:13 -0400
Message-ID: <20260531230225.126817-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git gui has a number of inter-related problems that result in problems
during startup from anything but a checked out worktree pointing at a
valid git repository. Some of the symptoms are:
- blame / browser subcommands, and launching gitk, are intended to be
  useful without a worktree, but fail to work.
- unlike git, git-gui is supposed to use the parent directory as a
  worktree if started from the .git subdirectory in the very common
  single worktree + embedded git repository format. This does not
  work.
- git-gui includes a repository picker allowing a user to select a
  worktree from a list and/or start a new repo+worktree: this dialog can
  appear at unexpected times, masking useful error feedback on
  configuration problems.

This patch series addresses the above issues, substantially rewriting
the initial repository/worktree process to rely upon git rev-parse so
that git's knowledge of access rules, repository configuration, and use
of GIT_DIR / GIT_WORK_TREE (or git --gitdir / --work-tree) is used
throughout, replacing code largely based upon what git did in 2008. This
also means that git gui will naturally gain any new rules implmented in
git-core.

With this, git-gui only exports GIT_WORK_TREE when non-empty.
GIT_WORK_TREE is needed, and must be exported, if the user is overriding
core.worktree in the git repository. But, GIT_WORK_TREE cannot be used
to specify the lack of a worktree, so exporting an empty GIT_WORK_TREE
is one of the problems fixed by this series.

v3 of this series addresses j6t's review of v2, with some reordering of
patches (1 from j6t added, patch #8 moved to #1), adds another rewrite
of the browser / blame parser that eliminates the notion of path before
rev on the command line, blame works correctly with a user modified file
in the worktree. Clarification is added on the need for GTI_WORK_TREE,
and the logic in finding a worktree from the gitdir is simplified.

Johannes Sixt (1):
  git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk

Mark Levedahl (11):
  git-gui: use HEAD as current branch when detached
  git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
  git-gui: do not change global vars in choose_repository::pick
  git-gui: use --absolute-git-dir
  git-gui: use rev-parse exclusively to find a repository
  git-gui: use git rev-parse for worktree discovery
  git-gui: simplify [is_bare] to report if a worktree is known
  git-gui: try harder to find worktree from gitdir
  git-gui: allow specifying path '.' to the browser
  git-gui: check browser/blame arguments carefully
  git-gui: add gui and pick as explicit subcommands

 git-gui.sh                | 377 ++++++++++++++++++++++----------------
 lib/choose_repository.tcl |  21 +--
 2 files changed, 223 insertions(+), 175 deletions(-)

Interdiff against v2:
diff --git a/git-gui.sh b/git-gui.sh
index 299c1a0292..933e72c9b2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1114,33 +1114,29 @@ unset argv0dir
 ## repository setup
 
 proc find_worktree_from_gitdir {} {
-	# Directory 'parent' of a repository named 'parent/.git' might be the worktree.
-	# Assure parent is a worktree and using the git repository already discovered.
-	# Also, handle case of being in a worktree's gitdir, where file "gitdir" points to
-	# gitlink file .git in the real worktree.
+	# this is invoked only if the current directory is inside the repository
 	set worktree {}
 	if {[file tail $::_gitdir] eq {.git}} {
+		# the dir containing .git is a worktree if repo allows it
+		# Check that git reports parent as a worktree (gitdir might not allow a worktree)
 		if {[catch {
-			set gitdir_parent [file dirname $::_gitdir]
-			set worktree [git -C $gitdir_parent rev-parse --show-toplevel]
-			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
-			if {$::_gitdir ne $parent_gitdir} {
-				set worktree {}
-			}
-		}]} {
+				set parent [file dirname $::_gitdir]
+				set worktree [git -C $parent rev-parse --show-toplevel]
+			}]} {
 			set worktree {}
 		}
 	} elseif [file exists {gitdir}] {
+		# a worktree gitdir has .gitdir naming worktree/.git
+		# assure git run there reports this dir as the gitdir (links might be broken)
 		if {[catch {
-			set fd_gitdir [open {gitdir} {r}]
-			set gitlink_parent [file dirname [read $fd_gitdir]]
-			catch {close $fd_gitdir}
-			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
-			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
-			if {$::_gitdir ne $parent_gitdir} {
-				set worktree {}
-			}
-		}]} {
+				set fd_gitdir [open {gitdir} {r}]
+				set worktree [file dirname [read $fd_gitdir]]
+				catch {close $fd_gitdir}
+				set worktree_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+				if {$::_gitdir ne $worktree_gitdir} {
+					set worktree {}
+				}
+			}]} {
 			catch {close $fd_gitdir}
 			set worktree {}
 		}
@@ -1153,7 +1149,7 @@ proc is_gitvars_error {err} {
 	set GIT_DIR {}
 	set GIT_WORK_TREE {}
 	catch {set GIT_DIR $::env(GIT_DIR); set havevars 1}
-	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE) ; set havevars 1}
+	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE); set havevars 1}
 
 	if {$havevars} {
 		catch {wm withdraw .}
@@ -1168,9 +1164,7 @@ proc is_gitvars_error {err} {
 
 proc set_gitdir_vars {} {
 	global _gitdir _gitworktree env
-	if {$_gitdir ne {}} {
-		set env(GIT_DIR) $_gitdir
-	}
+	set env(GIT_DIR) $_gitdir
 	if {$_gitworktree ne {}} {
 		set env(GIT_WORK_TREE) $_gitworktree
 	}
@@ -1182,12 +1176,12 @@ proc unset_gitdir_vars {} {
 	catch {unset env(GIT_WORK_TREE)}
 }
 
-# find repository.
+# find repository
 set _gitdir {}
 if {[is_enabled gitdir_discovery]} {
 	if {[catch {
-		set _gitdir [git rev-parse --absolute-git-dir]
-	} err]} {
+			set _gitdir [git rev-parse --absolute-git-dir]
+		} err]} {
 		if {[is_gitvars_error $err]} {
 			exit 1
 		}
@@ -1200,14 +1194,13 @@ if {$_gitdir eq {} && [is_enabled picker]} {
 	unset_gitdir_vars
 	load_config 1
 	apply_config
-	if {![choose_repository::pick]} {
-		exit 1
-	}
+	choose_repository::pick
 	if {[catch {
-		set _gitdir [git rev-parse --absolute-git-dir]
-	} err]} {
+			set _gitdir [git rev-parse --absolute-git-dir]
+		} err]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
+		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] \n\n$err"]
+		exit 1
 	}
 	set picked 1
 }
@@ -1220,9 +1213,9 @@ if {$_gitdir eq {}} {
 
 # find worktree, continue without if not required
 if {[catch {
-	set _gitworktree [git rev-parse --show-toplevel]
-	set _prefix [git rev-parse --show-prefix]
-} err]} {
+		set _gitworktree [git rev-parse --show-toplevel]
+		set _prefix [git rev-parse --show-prefix]
+	} err]} {
 	if {[is_gitvars_error $err]} {
 		exit 1
 	}
@@ -1238,17 +1231,14 @@ if {[is_bare]} {
 }
 
 if {![is_bare]} {
-	if {[catch {
-		cd $_gitworktree
-	} err]} {
+	if {[catch {cd $_gitworktree} err]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot change to discovered worktree: "] \
-			"$_gitworktree" "\n\n$err"]
-		exit 1;
+		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
+		exit 1
 	}
 } elseif {![is_enabled bare]} {
 	catch {wm withdraw .}
-	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
+	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
 	exit 1
 }
 
@@ -2086,11 +2076,7 @@ proc do_gitk {revs {is_submodule false}} {
 	} else {
 		set pwd [pwd]
 
-		if {!$is_submodule} {
-			if {![is_bare]} {
-				cd $_gitworktree
-			}
-		} else {
+		if {$is_submodule} {
 			cd $current_diff_path
 			if {$revs eq {--}} {
 				set s $file_states($current_diff_path)
@@ -3026,26 +3012,18 @@ proc normalize_relpath {path} {
 	if {$elements ne {}} {
 		return [eval file join $elements]
 	} else {
-		return {./}
+		return {.}
 	}
 }
 
-proc find_path_type {head path} {
-	if {$path eq {./}} {
-		# the root-tree exists in every rev, ls-tree gives data on the contents,
-		# not the type of tree itself. So, if the rev exists, return {tree}
-		if {[catch {set objtype [git ls-tree $head]}]} {
-			set objtype {}
-		} else {
-			set objtype {tree}
-		}
+proc show_parse_err {err} {
+	if {[tk windowingsystem] eq "win32"} {
+		catch {wm withdraw .}
+		error_popup $err
 	} else {
-		# test that the path exists in head, ls-tree gives info on the path only
-		if {[catch {set objtype [git ls-tree {--format=%(objecttype)} $head $path]}]} {
-			set objtype {}
-		}
+		puts stderr $err
 	}
-	return $objtype
+	exit 1
 }
 
 # -- Not a normal commit type invocation?  Do that instead!
@@ -3054,91 +3032,80 @@ switch -- $subcommand {
 browser -
 blame {
 	if {$subcommand eq "blame"} {
-		set subcommand_args {[--line=<num>] <[rev] [--] filename | [--] filename rev>}
-		set required_objtype blob
+		set subcommand_args {[--line=<num>] [rev] [--] <filename>}
+		set required_pathtype blob
 	} else {
-		set subcommand_args {<[rev] [--] directory | [--] directory rev>}
-		set required_objtype tree
+		set subcommand_args {[rev] [--] <dirname>}
+		set required_pathtype tree
 	}
 	set maxargs [llength $subcommand_args]
 	set nargs [llength $argv]
 	if {$nargs < 1 || $nargs > $maxargs} usage
 	set head {}
-	set althead {}
 	set path {}
-	set altpath {}
-	set canswap 1
 	set jump_spec {}
 
-	# assume: [--line=num] [head] [--] path as the possible arguments, in order.
-	# head and path may need a swap later.
-	for {set iarg 0} {$iarg < $nargs} {incr iarg} {
-		set arg [lindex $argv $iarg]
-		if {$arg eq {--}} {
-			# next arg is the path, prevent or FORCE swap?
-			if {$iarg == $nargs - 2} {
-				set canswap 0
-			} elseif {$iarg == $nargs - 3} {
-				set canswap 2
-			} else {
+	set iarg 0
+	foreach a $argv {
+		incr iarg
+		if {$iarg == $nargs} {
+			# final argument is path
+			set path [normalize_relpath [file join $_prefix $a]]
+		} elseif {$a eq {--}} {
+			# allow before required final arg that must be path
+			if {$iarg != $nargs - 1} {
 				usage
 			}
-		} elseif {[regexp {^--line=(\d+)$} $arg arg lnum]} {
+		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
 			# --line can only be the first arg
-			if {$iarg != 0 || $maxargs < 4} usage
+			if {$iarg != 1 || $subcommand ne {blame}} usage
 			set jump_spec [list $lnum]
-		} elseif {$iarg == $nargs - 1} {
-			# assume final argument is path
-			set path [normalize_relpath [file join $_prefix $arg]]
-			set althead $arg
 		} elseif {$head eq {}} {
-			# assume the other argument is head
-			set head $arg
-			set altpath [normalize_relpath [file join $_prefix $arg]]
+			set head $a
 		} else {
 			usage
 		}
 	}
 
-	# no swapping allowed if head not given, use current branch (HEAD)
+	# If head not given, use current branch (HEAD),
+	# and blame will use worktree if there is one.
+	set use_worktree 0
 	if {$head eq {}} {
 		load_current_branch
 		set head $current_branch
-		set canswap 0
-	}
-
-	# -- before "rev" arg means we got -- path head
-	if {$canswap == 2} {
-		set head $althead
-		set path $altpath
-		set canswap 0
-	}
-
-	set objtype [find_path_type $head $path]
-	if {$objtype eq {} && $canswap} {
-		set objtype [find_path_type $althead $altpath]
-		if {$objtype ne {}} {
-			set head $althead
-			set path $altpath
+		if {$subcommand eq {blame} && ![is_bare]} {
+			if {![file isfile $path]} {
+				show_parse_err [mc "fatal: no such file '%s' in worktree" $path]
+			}
+			set use_worktree 1
 		}
-	}
-	set current_branch $head
-
-	# check that path exists in head, and objtype matches need
-	if {$objtype ne $required_objtype} {
-		switch -- $required_objtype {
-			tree {set err [strcat \
-				[mc "'%s' is not a directory in rev '%s'" $path $head]]}
-			blob {set err [strcat \
-				[mc "'%s' is not a filename in rev '%s'" $path $head]]}
-		}
-		if {[tk windowingsystem] eq "win32"} {
-			catch {wm withdraw .}
-			error_popup $err
+	} else {
+		if {[catch {
+				set commitid \
+					[git rev-parse --verify --end-of-options \
+					[strcat $head "^{commit}"]]
+			}]} {
+			show_parse_err [mc "fatal: '%s' is not a valid rev'" $head]
 		} else {
-			puts stderr $err
+			set current_branch $head
+		}
+	}
+
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
-		exit 1
 	}
 
 	wm deiconify .
@@ -3146,8 +3113,8 @@ blame {
 	browser {
 		browser::new $head $path
 	}
-	blame {
-		blame::new $head $path $jump_spec
+	blame   {
+		blame::new [expr {$use_worktree ? {} : $head}] $path $jump_spec
 	}
 	}
 	return
-- 
2.54.0.99.14

