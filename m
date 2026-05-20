Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22E836A35F
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308671; cv=none; b=dKrjDymaIwPUphOKYfvE/BddyxBz+BlpMJefopKq2orqf1o441Ja0hfQFdgXICOEKyGx7N14JQ4KQpEBmd1cAs1DTbd2HTYlr1wSXKuvGzRuPECBtj6k8fYMpWVSyFn1KK9vxU+xkXxivuEKEl0UwG9Eb0tOL3vtBbcoC/sPCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308671; c=relaxed/simple;
	bh=x/3F9eW7ivAPTmNjNkcDkoJcODOc3IS2yfYKzjIK7nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om7SNPacfO8rDeDVpWbqpiQzX9GTEW4ZHu2EbJbEXT5YfBHS/ekICtNKSHchNDEMMUgLa4VcYZYwHsmZ0LnFpLCI8Nxuta0eFXRRtXRr5zF7RkzRatzC6DP/g6n/F2kwTlohA8BGRiYsFN/Bf/9o25LEgQFYiyynw/px9V0oLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjQ04QGv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjQ04QGv"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90ca6f20872so764240285a.0
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308669; x=1779913469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzonEtsUVn0f1mrVEymI8htbncQGSAUXQCLJaYqTQkQ=;
        b=CjQ04QGv8QhU24GRhygR46gbuP0jIYQg3brZf3qJG/Y/CGKrwaT8BygvkwZfKhsGEd
         GMEMIi4ZJ1PSaq25vJPtG0CdF2LWJ0pYFm1U+CZg6mFDD/GQVt8eS9LHAWEqoKyaOpZq
         d4BMNOF3BxucJzMdE10khA5aa9qaNEaNUOHikXjOICPeudFOIb4Uz9bCmaGg9xiZMEst
         FFPCl/JcfDmkMPHQ9NLA7Tm+F1Aa2nKmmKocKqzj6O6X47Hh5GL1NLsOa8ez5yTH/3JK
         vju0OU6J4LJAjUZtf+s2D+MvKQNwEZHRsrRoNdaA4I/AW2OTgY36zwyOMVMUTC1NhDiK
         /7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308669; x=1779913469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzonEtsUVn0f1mrVEymI8htbncQGSAUXQCLJaYqTQkQ=;
        b=SLG3UlQ7Xnb+mgW6VcJLgUF+UeKf2d44umZNkyh0I3AbFHXmO0LGuYL/YXtzl6mhbO
         aEaEbA9MueiYz3BQkp01HfGrK54rC5Gwbf7MkjlB3YzH4I9pBHCE7Qd1u0muv8xevsIi
         9F6hhXvzBgl7j4o4uDvQY8Hr1C5MMHGLnv6i7lwJg6pZgF42zj3th/kk54+3AqHaAWCH
         65N1nptCixpEKK69LH4rmeCeyYxyUUH9GT9+BAFP2B+9Ibd7fWXGu6D2dWsgx56z3GRD
         dVcM9wSOKvMCnwTIwAA6y3cexVW8pqqPJs6ZxD1hdi99FrEo9b37tIGKGMc1tqn+bDQ1
         lw4g==
X-Gm-Message-State: AOJu0YyOMMEzbr9y6zsankdxaj7XiNaPyZXxhqPG9812d+SVolMy1M7r
	CtcE9dG+o/uMi2tfCAv/9smW2b+kvZWDWNrpzTsowtstebuWEyQObi8eR9c/HcLE
X-Gm-Gg: Acq92OHpw1/CrSjYmBX/tnuSWbyogvzsblPj4o0KXc/tU9w4rigzvvSnkJU465S0Cq3
	meyJyFYQzbT30p3Pjo9uXp4SE8NIHYT10F3BLGL5YW+jyaGMuNIKo+IXDMIsmITIN8Fwud0gmAy
	xADCysevhbS0BHi4NtmLTFA7GTVh/QNCo4lp/Du/XF+sAXv5FZ+bglfSHbgbF5XsqZxyx3cB3Qd
	D/qsanpc1yps4dSzm9XWZoD2VriJrJloVDc5V6ANM+WKSP1KA8+IMmXi82ncefqx9/3JqYXvADQ
	37uJ/ipVzjzMz1TOyzozHXHxKrES6LceszaBjZOfZidiEGeOrgIVXxbtnHineGasPBwpZyR/5+I
	xlsQlnORqsL485N6okTT6/sYuDQG2XigVrWT8AVLo//Ju00K9Znn/Mg5NW7yjfM05EobvSO2z8q
	bmuFZu+VFMCh8s6OsXk8EwrR34Sw==
X-Received: by 2002:a05:620a:2552:b0:8ef:6b87:5c52 with SMTP id af79cd13be357-914a03055a4mr150309085a.38.1779308668402;
        Wed, 20 May 2026 13:24:28 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:27 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 00/11] Improve git gui operation without a worktree
Date: Wed, 20 May 2026 16:23:59 -0400
Message-ID: <20260520202411.108764-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
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

v2 of this series is a very substantial rewrite driven by j6t's review,
with patches reoranized and squashed, interfaces to the repository
chooser changed, a different code structure to allow user control of the
repository picker, a different approach to fixing the command line
parser for blame / browser, and other more minor changes. Patches
for fixing blame / browser are now after all discovery refactoring as
they cannot be tested without some of those fixes.

Many subtle things are fixed beyond the list at the top, including
better compatibility with git blame and repeatable browser / blame
operation for specific revs not in the worktree, regardless of the
worktree state. j6t indicated that in the git-gui project, the following
fails in the current release:

cd lib
GIT_DIR=$PWD/../.git GIT_WORK_TREE=$PWD/.. ../git-gui.sh browser origin/master .

This is due to a _prefix issue, and is fixed as of the patch
     git-gui: use git rev-parse for worktree discovery

Mark Levedahl (11):
  git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
  git-gui: return status from choose_repository::pick
  git-gui: use --absolute-git-dir
  git-gui: use rev-parse exclusively to find a repository
  git-gui: simplify [is_bare] to report if a worktree is known
  git-gui: use git rev-parse for worktree discovery
  git-gui: try harder to find worktree from gitdir
  git-gui: use HEAD as current branch when detached (bug fix)
  git-gui: allow specifying path '.' to the browser
  git-gui: adapt blame/browser parsing for bare operation
  git-gui: add gui and pick as explicit subcommands

 git-gui.sh                | 412 +++++++++++++++++++++++---------------
 lib/choose_repository.tcl |  21 +-
 2 files changed, 257 insertions(+), 176 deletions(-)

Interdiff against v1:
diff --git a/git-gui.sh b/git-gui.sh
index c56aeeff88..299c1a0292 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -648,6 +648,9 @@ proc load_current_branch {} {
 
 	set current_branch [git branch --show-current]
 	set is_detached [expr [string length $current_branch] == 0]
+	if {$is_detached} {
+		set current_branch {HEAD}
+	}
 }
 
 auto_load tk_optionMenu
@@ -1021,7 +1024,8 @@ proc load_config {include_global} {
 ##
 ## feature option selection
 
-set run_picker_on_error 1
+enable_option picker
+enable_option gitdir_discovery
 if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
 	unset _junk
 } else {
@@ -1031,9 +1035,11 @@ if {$subcommand eq {gui.sh}} {
 	set subcommand gui
 }
 if {$subcommand eq {gui} && [llength $argv] > 0} {
-	set run_picker_on_error 0
 	set subcommand [lindex $argv 0]
 	set argv [lrange $argv 1 end]
+	if {$subcommand eq {gui}} {
+		disable_option picker
+	}
 }
 
 enable_option multicommit
@@ -1049,7 +1055,7 @@ blame {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
-	set run_picker_on_error 0
+	disable_option picker
 }
 citool {
 	enable_option singlecommit
@@ -1058,7 +1064,7 @@ citool {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
-	set run_picker_on_error 0
+	disable_option picker
 
 	while {[llength $argv] > 0} {
 		set a [lindex $argv 0]
@@ -1081,6 +1087,9 @@ citool {
 		set argv [lrange $argv 1 end]
 	}
 }
+pick {
+	disable_option gitdir_discovery
+}
 }
 
 ######################################################################
@@ -1104,21 +1113,39 @@ unset argv0dir
 ##
 ## repository setup
 
-proc is_parent_worktree {} {
-	# Directory 'parent' of a repository named 'parent/.git' might be the worktree
-	set ok 0
+proc find_worktree_from_gitdir {} {
+	# Directory 'parent' of a repository named 'parent/.git' might be the worktree.
+	# Assure parent is a worktree and using the git repository already discovered.
+	# Also, handle case of being in a worktree's gitdir, where file "gitdir" points to
+	# gitlink file .git in the real worktree.
+	set worktree {}
 	if {[file tail $::_gitdir] eq {.git}} {
-		set gitdir_parent [file join $::_gitdir {..}]
-		set expected_worktree [file normalize $gitdir_parent]
-		catch {set git_worktree [git -C $gitdir_parent rev-parse --show-toplevel]}
-		if {[string compare $expected_worktree $git_worktree] == 0} {
-			set ::_prefix {}
-			set ::_gitworktree $git_worktree
-			cd $git_worktree
-			set ok 1
+		if {[catch {
+			set gitdir_parent [file dirname $::_gitdir]
+			set worktree [git -C $gitdir_parent rev-parse --show-toplevel]
+			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+			if {$::_gitdir ne $parent_gitdir} {
+				set worktree {}
+			}
+		}]} {
+			set worktree {}
+		}
+	} elseif [file exists {gitdir}] {
+		if {[catch {
+			set fd_gitdir [open {gitdir} {r}]
+			set gitlink_parent [file dirname [read $fd_gitdir]]
+			catch {close $fd_gitdir}
+			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
+			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+			if {$::_gitdir ne $parent_gitdir} {
+				set worktree {}
+			}
+		}]} {
+			catch {close $fd_gitdir}
+			set worktree {}
 		}
 	}
-	return $ok
+	return $worktree
 }
 
 proc is_gitvars_error {err} {
@@ -1155,62 +1182,76 @@ proc unset_gitdir_vars {} {
 	catch {unset env(GIT_WORK_TREE)}
 }
 
+# find repository.
+set _gitdir {}
+if {[is_enabled gitdir_discovery]} {
+	if {[catch {
+		set _gitdir [git rev-parse --absolute-git-dir]
+	} err]} {
+		if {[is_gitvars_error $err]} {
+			exit 1
+		}
+		set _gitdir {}
+	}
+}
+
 set picked 0
-proc pick_repo {} {
+if {$_gitdir eq {} && [is_enabled picker]} {
 	unset_gitdir_vars
 	load_config 1
 	apply_config
-	choose_repository::pick
-	set _gitdir [git rev-parse --absolute-git-dir]
-	set _prefix {}
+	if {![choose_repository::pick]} {
+		exit 1
+	}
+	if {[catch {
+		set _gitdir [git rev-parse --absolute-git-dir]
+	} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
+	}
 	set picked 1
 }
 
-# run repository picker if explicitly requested
-switch -- $subcommand {
-	pick {
-		pick_repo
-		set subcommand gui
-		set run_picker_on_error 0
-	}
-}
-
-# find repository.
-if {[catch {
-	set _gitdir [git rev-parse --absolute-git-dir]
-} err]} {
-	if {[is_gitvars_error $err]} {
-		exit 1
-	}
-	if {$run_picker_on_error} {
-		pick_repo
-	} else {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
-		exit 1
-	}
+if {$_gitdir eq {}} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
+	exit 1
 }
 
 # find worktree, continue without if not required
 if {[catch {
 	set _gitworktree [git rev-parse --show-toplevel]
 	set _prefix [git rev-parse --show-prefix]
-	cd $_gitworktree
 } err]} {
 	if {[is_gitvars_error $err]} {
 		exit 1
 	}
 	set _gitworktree {}
 	set _prefix {}
-	if {[is_enabled bare]} {
-		cd $_gitdir
-	} elseif {![is_parent_worktree]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
-		exit 1
+}
+
+if {[is_bare]} {
+	# Maybe we are in an embedded or worktree specific gitdir
+	if {[set _gitworktree [find_worktree_from_gitdir]] ne {}} {
+		set _prefix {}
 	}
 }
 
+if {![is_bare]} {
+	if {[catch {
+		cd $_gitworktree
+	} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Cannot change to discovered worktree: "] \
+			"$_gitworktree" "\n\n$err"]
+		exit 1;
+	}
+} elseif {![is_enabled bare]} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
+	exit 1
+}
+
 # repository and worktree config are complete, export them
 set_gitdir_vars
 
@@ -1229,8 +1270,6 @@ if {$hashalgorithm eq "sha1"} {
 load_config 0
 apply_config
 
-
-# Derive a human-readable repository name
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end-1]
@@ -2035,7 +2074,7 @@ proc incr_font_size {font {amt 1}} {
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitdir _gitworktree
+	global _gitworktree
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
@@ -2045,8 +2084,6 @@ proc do_gitk {revs {is_submodule false}} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find gitk in PATH"]
 	} else {
-		global env
-
 		set pwd [pwd]
 
 		if {!$is_submodule} {
@@ -2105,9 +2142,6 @@ proc do_git_gui {} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
-		global env
-		global _gitdir _gitworktree
-
 		# see note in do_gitk about unsetting these vars when
 		# running tools in a submodule
 		unset_gitdir_vars
@@ -2992,77 +3026,135 @@ proc normalize_relpath {path} {
 	if {$elements ne {}} {
 		return [eval file join $elements]
 	} else {
-		return {}
+		return {./}
 	}
 }
 
+proc find_path_type {head path} {
+	if {$path eq {./}} {
+		# the root-tree exists in every rev, ls-tree gives data on the contents,
+		# not the type of tree itself. So, if the rev exists, return {tree}
+		if {[catch {set objtype [git ls-tree $head]}]} {
+			set objtype {}
+		} else {
+			set objtype {tree}
+		}
+	} else {
+		# test that the path exists in head, ls-tree gives info on the path only
+		if {[catch {set objtype [git ls-tree {--format=%(objecttype)} $head $path]}]} {
+			set objtype {}
+		}
+	}
+	return $objtype
+}
+
 # -- Not a normal commit type invocation?  Do that instead!
 #
 switch -- $subcommand {
 browser -
 blame {
 	if {$subcommand eq "blame"} {
-		set subcommand_args {[--line=<num>] rev? path}
+		set subcommand_args {[--line=<num>] <[rev] [--] filename | [--] filename rev>}
+		set required_objtype blob
 	} else {
-		set subcommand_args {rev? path}
+		set subcommand_args {<[rev] [--] directory | [--] directory rev>}
+		set required_objtype tree
 	}
-	if {$argv eq {}} usage
-	set head {}
-	set path {}
-	set jump_spec {}
+	set maxargs [llength $subcommand_args]
 	set nargs [llength $argv]
-	if {$nargs < 1} {
-		usage
-	}
-	set argn 0
-	foreach a $argv {
-		set argn [expr {$argn + 1}]
+	if {$nargs < 1 || $nargs > $maxargs} usage
+	set head {}
+	set althead {}
+	set path {}
+	set altpath {}
+	set canswap 1
+	set jump_spec {}
 
-		if {$argn < $nargs} {
-			# revision or line number
-			if {[regexp {^--line=(\d+)$} $a a lnum]} {
-				set jump_spec [list $lnum]
+	# assume: [--line=num] [head] [--] path as the possible arguments, in order.
+	# head and path may need a swap later.
+	for {set iarg 0} {$iarg < $nargs} {incr iarg} {
+		set arg [lindex $argv $iarg]
+		if {$arg eq {--}} {
+			# next arg is the path, prevent or FORCE swap?
+			if {$iarg == $nargs - 2} {
+				set canswap 0
+			} elseif {$iarg == $nargs - 3} {
+				set canswap 2
 			} else {
-				set head $a
+				usage
 			}
+		} elseif {[regexp {^--line=(\d+)$} $arg arg lnum]} {
+			# --line can only be the first arg
+			if {$iarg != 0 || $maxargs < 4} usage
+			set jump_spec [list $lnum]
+		} elseif {$iarg == $nargs - 1} {
+			# assume final argument is path
+			set path [normalize_relpath [file join $_prefix $arg]]
+			set althead $arg
+		} elseif {$head eq {}} {
+			# assume the other argument is head
+			set head $arg
+			set altpath [normalize_relpath [file join $_prefix $arg]]
 		} else {
-			set path [normalize_relpath $a]
+			usage
 		}
 	}
 
+	# no swapping allowed if head not given, use current branch (HEAD)
 	if {$head eq {}} {
 		load_current_branch
 		set head $current_branch
-	} else {
-		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
-			if {[catch {
-				set head [git rev-parse --verify $head]
-			} err]} {
-				if {[tk windowingsystem] eq "win32"} {
-					tk_messageBox -icon error -title [mc Error] -message $err
-				} else {
-					puts stderr $err
-				}
-				exit 1
-			}
+		set canswap 0
+	}
+
+	# -- before "rev" arg means we got -- path head
+	if {$canswap == 2} {
+		set head $althead
+		set path $altpath
+		set canswap 0
+	}
+
+	set objtype [find_path_type $head $path]
+	if {$objtype eq {} && $canswap} {
+		set objtype [find_path_type $althead $altpath]
+		if {$objtype ne {}} {
+			set head $althead
+			set path $altpath
 		}
-		set current_branch $head
+	}
+	set current_branch $head
+
+	# check that path exists in head, and objtype matches need
+	if {$objtype ne $required_objtype} {
+		switch -- $required_objtype {
+			tree {set err [strcat \
+				[mc "'%s' is not a directory in rev '%s'" $path $head]]}
+			blob {set err [strcat \
+				[mc "'%s' is not a filename in rev '%s'" $path $head]]}
+		}
+		if {[tk windowingsystem] eq "win32"} {
+			catch {wm withdraw .}
+			error_popup $err
+		} else {
+			puts stderr $err
+		}
+		exit 1
 	}
 
 	wm deiconify .
 	switch -- $subcommand {
 	browser {
-		if {$jump_spec ne {}} usage
 		browser::new $head $path
 	}
-	blame   {
+	blame {
 		blame::new $head $path $jump_spec
 	}
 	}
 	return
 }
 citool -
-gui {
+gui -
+pick {
 	if {[llength $argv] != 0} {
 		usage
 	}
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 7e1462a20c..4b06afee93 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -15,7 +15,7 @@ field w_recentlist ; # Listbox containing recent repositories
 field w_localpath  ; # Entry widget bound to local_path
 
 field done              0 ; # Finished picking the repository?
-field clone_ok      false ; # clone succeeeded
+field pick_ok           0 ; # true if repo pick/clone succeeded
 field local_path       {} ; # Where this repository is locally
 field origin_url       {} ; # Where we are cloning from
 field origin_name  origin ; # What we shall call 'origin'
@@ -220,6 +220,8 @@ constructor pick {} {
 	if {$top eq {.}} {
 		eval destroy [winfo children $top]
 	}
+
+	return $pick_ok
 }
 
 method _center {} {
@@ -327,8 +329,7 @@ method _git_init {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir .git
-	set ::_prefix {}
+	set pick_ok 1
 	return 1
 }
 
@@ -409,6 +410,7 @@ method _do_new2 {} {
 	if {![_git_init $this]} {
 		return
 	}
+	set pick_ok 1
 	set done 1
 }
 
@@ -621,7 +623,7 @@ method _do_clone2 {} {
 	}
 
 	tkwait variable @done
-	if {!$clone_ok} {
+	if {!$pick_ok} {
 		error_popup [mc "Clone failed."]
 		return
 	}
@@ -632,18 +634,12 @@ method _do_clone2_done {ok} {
 	if {$ok} {
 		if {[catch {
 			cd $local_path
-			set ::_gitdir .git
-			set ::_prefix {}
 			_append_recentrepos [pwd]
 		} err]} {
 			set ok 0
 		}
 	}
-	if {!$ok} {
-		set ::_gitdir {}
-		set ::_prefix {}
-	}
-	set clone_ok $ok
+	set pick_ok $ok
 	set done 1
 }
 
@@ -721,8 +717,7 @@ method _do_open2 {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir $actualgit
-	set ::_prefix {}
+	set pick_ok 1
 	set done 1
 }
 
-- 
2.54.0.99.14

