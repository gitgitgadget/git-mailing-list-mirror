Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED53FBEC1
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769248; cv=none; b=c8Zu0F+p5MQ3nPL83Jzm8g4f19A9bRHkmx1Y4F6ZNL+p7tF0Ft7vn5/fAPVQ5hFRPU2OgEAXREMhQ61eJK67NDLfvE8PiOX4pOrFidsBfL6RUfuFWBjBA042DnfgUTBQmpgg+BhqmY435oG3io/ib/O6pULC1FNwGGel4dNdNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769248; c=relaxed/simple;
	bh=WG3ZByCDIzu1zOD7oBuqBWJCwN+FmJpSGQv89doD9JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JphMwHCqbZ63Iprmg9VMyZHaWCVRbmgI3Ci/4UTKRrpEuoraJ8RxiMghuTG9SaFT6VrbMFMdOUFUS5sTGrHtzvOtnZL49HMELV/5jtmYvFJozqgG2TZeydsdnccf8GhPjBG5scudEtWNHaI83EvFv+9ux09vDDf9TmWFjTt9QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd9+aV7t; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd9+aV7t"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d4f78fc9f6so840029085a.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769246; x=1779374046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGza/oB/omUWrEUqYMWq3PJ602f0FY8ei77rWHcS0/g=;
        b=Xd9+aV7tsIQ4WxFiSFHri97imGtThDo7PskgbuiT7jhqRLLZL5ZZjpaqkM1WrXjtf+
         POjrysby7w6Tn0c9ExO8ZFBdxJAvPihh9YxMw+bq7P4KEKIqoQhsukRtWxsje3owJxN3
         y3jWVbGb7RWDf5Li4FMh1FnvKw0eT+9fyG5+K2gW5J1j18xZ8N/054uaHgKKFZaXx7Lz
         ltr1lMKG9Yx5Vc6D1/azfMiJMuX+zond4NqYrnBGLifctyf9XBzBN/IIT+k0vc63j7C5
         ynNx+RmfHUMDUieMEO0QuY8A90bEiyuHcJ5JXKKWGYwFYMg0bur9SfdZcWGBmVlpHAfm
         dVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769246; x=1779374046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGza/oB/omUWrEUqYMWq3PJ602f0FY8ei77rWHcS0/g=;
        b=h0b4fiiyzgP829R8H3MmEGF5F42d053ao9/I969NcrM3F3aA/nA8GjaYttOCDEMREI
         lsxO/84ouE/b99ZmmMHGONbaPWgVSG9LhV8HchLrMr6LmXx7sa+cWgn84BvC5BOMLnGc
         5fPTjPcZJOkojxGetni+q3uhXZ+tPj3euCwa7s3/wwvg02Bad+aP8iR7OpJlIJMFQegi
         rYG3tDehKmNtAIxTDYNb+jkykFi1qaAkCiFLVITd6Wg9tuomfHMXHqByDmw3AJ7MZ/ic
         MjcIgXEA3TUzZgl0B+tG0FvbGtGDarrfv3AQVcS9aPGiX61UrIf5dr1d1JLchtFVeOyr
         nSUg==
X-Gm-Message-State: AOJu0YzTPVKbHzbXfwWWql7WgeCup8WiBUAtQsVwTW/U6wHzxm0NKOlu
	2iy+WIkWsT5ayow3w006pHHtn3XBW1zcuT3g7mxCKmC1Mx9uJ33NVTVaZhzVpF8c
X-Gm-Gg: Acq92OH4BBq57HRsvrXrj1zuPreHonc2btKbyTTjidSlFnEsZFcj/uc9XXhAcBuVd5o
	e1HxfcHpV87xIgOUNfebc/2WGSTxoSO1SAXfYM+zXEEAQ1j/sEgPaxkeeDf9uW91d04p7N1z3QO
	uLMqnXxTw9gbHtfVOqTVro3K3ruf3++aYnoouM9Hkmb1NtzwtYvOfrI1HxHFQo6zviZhoyNEsd7
	yK+tKEvKwRZm4FnfcguTD+v+/wSAWI2Nq1yR4gBDAK7Ov6QMy9SVosRE5V5iTF12xlgai8dALL1
	VM1o4mTHj8mquIHI+hhqDroZwn2y6YL0hYSztCH0KJkiAzwQSMhzL1V4vezTREVqsjplrza6C7y
	l8iZInBqiLbawc7Ug3QD0fTNYTC2/e43BTJiKWUL1XrYZjJ/txByObox5j7B378BJNITyoWIWmN
	y9BwiQvGl6i3uf/hj01w==
X-Received: by 2002:a05:620a:2584:b0:90d:75ff:7d7f with SMTP id af79cd13be357-90f8b0e84e6mr1136515885a.51.1778769245299;
        Thu, 14 May 2026 07:34:05 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:05 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 02/11] git-gui: refactor browser / blame argument parsing
Date: Thu, 14 May 2026 10:33:13 -0400
Message-ID: <20260514143322.865587-3-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui has subcommands blame and browser, both of which accept a
pathname, possibly preceded by a commit-ish item to specify a revision.
Also, blame can take a first argument that gives a line number to focus.

The command line parser for the above is more complex than needed, and
cannot work without a worktree as the pathname objects are checked
against the current worktree for existence. This also precludes naming a
directory or file that does not exist on the currently checked out
branch.

So, replace this with a simpler parser that looks at argument number and
number of arguments to know what value to expect. The blame and browser
backends already have error checking with diagnostic information, so
defer most error checking to those. Also, allow a line-number selection
to be given and silently ignored for the browser, further simplifying
this code.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 66 +++++++++++++-----------------------------------------
 1 file changed, 16 insertions(+), 50 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 6048f92..a951fcd 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2986,51 +2986,34 @@ blame {
 	set head {}
 	set path {}
 	set jump_spec {}
-	set is_path 0
+	set nargs [llength $argv]
+	if {$nargs < 1} {
+		usage
+	}
+	set argn 0
 	foreach a $argv {
-		set p [file join $_prefix $a]
+		set argn [expr {$argn + 1}]
 
-		if {$is_path || [file exists $p]} {
-			if {$path ne {}} usage
-			set path [normalize_relpath $p]
-			break
-		} elseif {$a eq {--}} {
-			if {$path ne {}} {
-				if {$head ne {}} usage
-				set head $path
-				set path {}
+		if {$argn < $nargs} {
+			# revision or line number
+			if {[regexp {^--line=(\d+)$} $a a lnum]} {
+				set jump_spec [list $lnum]
+			} else {
+				set head $a
 			}
-			set is_path 1
-		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
-			if {$jump_spec ne {} || $head ne {}} usage
-			set jump_spec [list $lnum]
-		} elseif {$head eq {}} {
-			if {$head ne {}} usage
-			set head $a
-			set is_path 1
-		} else {
-			usage
-		}
-	}
-	unset is_path
-
-	if {$head ne {} && $path eq {}} {
-		if {[string index $head 0] eq {/}} {
-			set path [normalize_relpath $head]
-			set head {}
 		} else {
-			set path [normalize_relpath $_prefix$head]
-			set head {}
+			set path [normalize_relpath $a]
 		}
 	}
 
 	if {$head eq {}} {
 		load_current_branch
+		set head $current_branch
 	} else {
 		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
 			if {[catch {
-					set head [git rev-parse --verify $head]
-				} err]} {
+				set head [git rev-parse --verify $head]
+			} err]} {
 				if {[tk windowingsystem] eq "win32"} {
 					tk_messageBox -icon error -title [mc Error] -message $err
 				} else {
@@ -3046,26 +3029,9 @@ blame {
 	switch -- $subcommand {
 	browser {
 		if {$jump_spec ne {}} usage
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
 		blame::new $head $path $jump_spec
 	}
 	}
-- 
2.54.0.99.14

