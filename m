Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0D36A35F
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308675; cv=none; b=Ei1hwktb4hWbLD7A+zxl9V5C2u3BwOi0wqvXOnKzqtiihF/l+JhImE54sCoOLB79Ikx+aqb+2QY/o7pz855+oSlxZGKttAz+zhCyFvU+N/VBP8YRKykKAFwWfoGMJ16bPL1dVxq5SFu2Xus9iXBoj/lJuAo9PJ5iJ7r5SIe8bGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308675; c=relaxed/simple;
	bh=tiHFvqYYVRB4vhr94CNSsomxbYrwuzdwFprUNs7Cs+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/tKzvL/E4hvnsnvHfK3nq7gpd/SHDhVZEOBG92BSMxI++9pxYekxFry40qpa5KlR3oLEPTBUiKbtkWTw1y84aXQZ/S1UmvsQZfvJQbAvqcprkTfN9Nf3K6SObMcGcfjkTxGirxVLWKB5yNQMXynxry1ag4TR0W+G9bs1PDUdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2TMlaH/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2TMlaH/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90eb7a63a30so363279785a.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308673; x=1779913473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOTiS/6+0k4Yg0mrnjSm1pJvyqR1cA0EHelpgzh8IlM=;
        b=V2TMlaH/CkoQKYJuhp2fjkd3CwZi8PFffl/Jvg0uy85x+dWC9DLGv7CGl0NdK34NQi
         +6DVlqNe7sCj8o5kWCD4pjrPTmMfkBbgaH0EhyDD3KmI28D4yhEUbbYUkhqmRGfDRm77
         juju7lmQCUP0ZI7ICByY7iwqlwKBM/VmklrHsnyhE+iVh5pi8KXNYEt1mV8M0pKFAibT
         1gxLbzEfgfPxhzSkPgHfCzSch8m77jeLO/dOawkLdukj98GdDEMK/OtgMS7JtfftyxzC
         K5dj0YhelCapZOUbOLwMSSqb0Pm3FzHnqyRVD5pUbt0CaVZ9FioAWTTlRQ5n14AKfHN5
         t9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308673; x=1779913473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kOTiS/6+0k4Yg0mrnjSm1pJvyqR1cA0EHelpgzh8IlM=;
        b=MShNgtLb62UMfn1FO1M2lETj72Dranif2xSfwgzJZL0lLXREzgnH5gyf1MpFf2yhyU
         6Fwi65Gvcd4mPglXCZnhd74w10CaY7IlNdFgFpwBROwbAqxLXjlmc2Kl8OxK854xeQwA
         yYw/oOC77QaEpUR26IhvDMU850AwyvyGwlH4AwKARakMwBgywTT/RM1hE8gYvZ4YtIP1
         0gBeoFCKQXV55qaOKDwQn/z3nQvAYKMAdYlGLmuVK1+DjQTLqAGtNRqM9L/4k8yeZJbh
         YuGI0sgCJMt+0fAhCa6FSRMovENJiz2ipwxHfoaDEjmMaMt+tg0GTNGIrPqimNCx7wnk
         i2qA==
X-Gm-Message-State: AOJu0Yz/8wzK4lYA+XFsvxp2Qs5OwabvEWF9JSImyhU7n+aDwGfy0Ejg
	8IoMIVZYJyW0L7QUngNxcwnRow0HJZPiSBJXosm2HytWg0/0fVcOVuYR5d3tm+CF
X-Gm-Gg: Acq92OGQ6u2Ze7RmCU+25TCIL5JmC05lgpfI/fT9m5pePefCmXhsYjBaFixetju11Ty
	DfEzeQI5VN+Smje0O4gOyhUq953qBuhfsuqlFyErreMxHVEOUmXAtiPF7F9b9fTYJQ/yME3k0kr
	XyuL4X8Z6/sgLGQihUX7j++quo+lA5d2WJ/PvfPrWn52DJN0vJlTWd+vIiBI2EC0MAmnl+oa8fR
	a/ucRQBt8XBnXO4NcJomuZE6h100FTL/NZ5xdv68Bj3HbyrcCvfsI9pBHMvkigJH8r2Qrja3nyU
	g/DvBeAIzOY8lxBgMCV9jroZ+0ix6RdHU5H6bLcYIDrZFFwXMSq+6i/+OM4kW13QlTLAXR9NCh6
	xMfYyCasgBE0/21qp5L2pKMXLFtqDlioc0CH9XLgmde7CI7Lz1iAMhcnJCT6DusHpXxRiprLV8d
	KFMrFdsmcXSj3TVbmnU9o721tsUw==
X-Received: by 2002:a05:620a:1727:b0:90c:fc17:95f8 with SMTP id af79cd13be357-911cfdd63a4mr4067397785a.51.1779308672777;
        Wed, 20 May 2026 13:24:32 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:32 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
Date: Wed, 20 May 2026 16:24:00 -0400
Message-ID: <20260520202411.108764-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui unconditionally exports _gitdir as GIT_DIR, and _gitworktree as
GIT_WORK_TREE, to the environment, and furthermore unconditionally
unsets these environment variables in many

git gui must have a repository, so _gitdir can never be empty and its
export is always valid if repository discovery completes successfully.

git gui might not find a worktree, so _gitworktree can be empty. While
having no worktree is valid for blame/browser subcommands, exporting
GIT_WORK_TREE=<empty> is not valid. Rather, an empty GIT_WORK_TREE
raises errors in git builtins, for instance 'git branch --show-current'
as used by git, and causes breakage. This is one cause of git blame /
git browser not working without a worktree.

A user may set GIT_DIR and/or GIT_WORK_TREE to override git's normal
discovery rules, including repository configuration of core.worktree
and/or worktree specific gitdirs. It is always safe to export the
absolute pathnames of the discovered values, even though they may not be
needed. However, the gitdir might not be found from the worktree without
GIT_DIR being set. Furthermore, the worktree defined by the discovered
gitdir might be overridden by GIT_WORK_TREE set before git-gui started.
So, it is also sometimes necessary that one or both of these variables
is set.

So, let's provide two procs, one to unset GIT_DIR / GIT_WORK_TREE if
they are set, one to set GIT_DIR and, if not empty, GIT_WORK_TREE,  so
all call sites do the same thing, and problems with _gitworktree == {}
are avoided.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 23fe76e498..4ba25da7b6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1122,6 +1122,22 @@ unset argv0dir
 ##
 ## repository setup
 
+proc set_gitdir_vars {} {
+	global _gitdir _gitworktree env
+	if {$_gitdir ne {}} {
+		set env(GIT_DIR) $_gitdir
+	}
+	if {$_gitworktree ne {}} {
+		set env(GIT_WORK_TREE) $_gitworktree
+	}
+}
+
+proc unset_gitdir_vars {} {
+	global env
+	catch {unset env(GIT_DIR)}
+	catch {unset env(GIT_WORK_TREE)}
+}
+
 set picked 0
 if {[catch {
 		set _gitdir $env(GIT_DIR)
@@ -1207,8 +1223,8 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
-set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
+# Export the final paths
+set_gitdir_vars
 
 ######################################################################
 ##
@@ -2007,7 +2023,7 @@ proc incr_font_size {font {amt 1}} {
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitdir _gitworktree
+	global _gitworktree
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
@@ -2017,8 +2033,6 @@ proc do_gitk {revs {is_submodule false}} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find gitk in PATH"]
 	} else {
-		global env
-
 		set pwd [pwd]
 
 		if {!$is_submodule} {
@@ -2050,13 +2064,11 @@ proc do_gitk {revs {is_submodule false}} {
 			# TODO we could make life easier (start up faster?) for gitk
 			# by setting these to the appropriate values to allow gitk
 			# to skip the heuristics to find their proper value
-			unset env(GIT_DIR)
-			unset env(GIT_WORK_TREE)
+			unset_gitdir_vars
 		}
 		safe_exec_bg [concat $cmd $revs "--" "--"]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		if {[info exists main_status]} {
@@ -2079,21 +2091,16 @@ proc do_git_gui {} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
-		global env
-		global _gitdir _gitworktree
-
 		# see note in do_gitk about unsetting these vars when
 		# running tools in a submodule
-		unset env(GIT_DIR)
-		unset env(GIT_WORK_TREE)
+		unset_gitdir_vars
 
 		set pwd [pwd]
 		cd $current_diff_path
 
 		safe_exec_bg [concat $exe gui]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		set status_operation [$::main_status \
-- 
2.54.0.99.14

