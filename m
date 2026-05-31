Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20D1F1513
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268592; cv=none; b=m9BiZP3VRt2lLHtTTI1BdNARlJs8Su4jJh7kAseQqijVqCH5Q9KSgFRzep6YjtOjDJvhONqR+C+ad4CzJtqyfSoRtjQS3r9ajw2pvYmmAwiAQlI+hXaBmY+bsuqvRZl13f1K6tGSNpHeIxwkXJY0en9Uyjt2VBmOZrziVOZNtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268592; c=relaxed/simple;
	bh=mFKJjMhl+Z6Npo0yD9aye8WUJd2zXKGGxsSxyd4eWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF2WXddMXrHZolD91OSmgdB2WGtEV1mCp/YVmgLcAURSmNmUq5+zXD8BHRlfepRlqTvCH8WzVmu8e0kyV5vcT4C47LEwmhBY6i+/MElpXW5dq9EHIx/Zlh0/86F0Fn2Lf9qx9BC9eZxm71BeJ3ZacqvItZkV0SR9xRwG/RzHSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYJ/fao0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYJ/fao0"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccea53f35cso28458916d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268590; x=1780873390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MLfIM5AN5iCsdpyGtiqWmsFqns3yQe4TOcWgiSDtoE=;
        b=CYJ/fao0UySM4kOVFExGB4Nn6THgoagMYdzCbhnPNAmw69N20X3qEQYRYOIHPVP2do
         XfVzCiokhSAvQTWKUnx0q6nvNaWur7eUNxNZTp0zYvp28EfuHIro4IiBcrRWsMGq+5rt
         dL1Q865J8C1ol+0P5I+TY1zYAV/pGYt9K7zjKcTtrq2jc6LitjPylv50GZ1Dh1xXTRIo
         dClZKFIi9YDOyU4j5xWAi+y6F2ej6Nohn6arHno03I9nfn1wnltt5QZDmY5GgNWmhUhH
         Z3d5x9M+FWzEYhJ7uQdIAz92djMjrs0SUFjmVANj6g4jXft8jESp2DkRD5JpNh0GOFYt
         qEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268590; x=1780873390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MLfIM5AN5iCsdpyGtiqWmsFqns3yQe4TOcWgiSDtoE=;
        b=C9d0hq4NZwSZQMRnGeK8XLGuS2PjnDn9xc6hstzXnlgIpCg5v39Y5UPxU/M3ad1luk
         hdy0hF5MRx9lN2y5w8XSUHhgx1QgVuQvWRZQTVUEbbsprRU+AzdpB2m/PMer4Fzx0sYK
         6WgaNtRYmUS2jPTnBlIEJbYLHrZaYch29nAgWyaiFAhtlw9u/BFzImIH60VXq5dSeUND
         gpNsmrDLnHrZknuCFyz3snfNDgFN7oxUJrk8hE2xEvfssviSfsEZUEBbb1JkrZ11Lg9p
         PZRHA5BX2b1Hl5MmjKKJkdentg+IzteX8Tl5BWULsDX20E/8voEMilQDRyeG0kIcIy1m
         fgNg==
X-Gm-Message-State: AOJu0YzABQ1njxtZrbY4bm4sFfTaGcCvGPLF7WcRvQF+SlkYkftAvIsE
	NCW2/UVI6CEzCv1ySkrKvnqZGlJUQtpuT435iyPLo84Hq25r8XeYjXL8K9E0+3mp
X-Gm-Gg: Acq92OGdCxLcsTP2zmvMKJlTAJ34E71Cn6rotl7L5OGkkE+6+rkGPiEz9fslXPhwa7v
	IBU7FiUhVaVQFE2T0bri7/dMq75F/AXyZ2XPjbb9D/K6MkDnmy27UeSUfT3Q69wyEqbA/WTrGy/
	JDhyVzFk43STTrK+eL28pnx/sbO906d/cGx/wv/lZgCP7bBfMRUbQzx6MvHonD2FEKGtCcHuUXd
	zbWzVizo8dOfCdhBneLmOkzXzdkeD0U3OyZFkmSaEKkrOjMzm/FkoNCuR/WP1MT/ylqb+DvbkGi
	7Iw7bCnMoqpwy4YNn7E2x42nS/r+Drpu2rKuuPz+L5qCZIRgxBmv2Fqj6nDghOQ31pqOY7wHYXs
	P+WGazQpWfDAHGsZ/PkotgqBpkDLmJH1x8Kw0Wnjd0X0xGZiYIcvyfoPAFdqLGjyLcSf2mg+R6F
	1XDoJ5g+f0n3rB2+yNcWw2iNuw3eb5+sBNAaca
X-Received: by 2002:a05:6214:20a3:b0:8c6:27f7:30e1 with SMTP id 6a1803df08f44-8ccefd4d0bfmr120414316d6.15.1780268590173;
        Sun, 31 May 2026 16:03:10 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:09 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 12/12] git-gui: add gui and pick as explicit subcommands
Date: Sun, 31 May 2026 19:02:25 -0400
Message-ID: <20260531230225.126817-13-mlevedahl@gmail.com>
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

git-gui accepts subcommands blame | browser | citool, and assumes the
subcommand is 'gui' if none is actually given, But, git-gui also has a
repository picker (choose_repository::pick) that can create a new
repository + worktree, or choose an existing one, switch to that, and
the run the gui. The user has no direct control over invoking the
picker, instead the picker is triggered by failure in the repository /
worktree discovery process: this includes being started in a directory
not controlled by git, which is probably the intended use case.

The picker can appear when the user has no intention of creating a new
worktree, and the user cannot use the picker to create a new worktree
inside another.

So, add two explicit subcommands:
    gui  - Run the gui if repository/worktree discovery succeeds, or die
           with an error message, but never run the picker.
    pick - First run the picker, regardless, then start the gui in
           the chosen worktree.

Nothing in this changes the prior behavior, the alternates above must be
explicitly selected to see any change.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 22939215a6..933e72c9b2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1024,6 +1024,8 @@ proc load_config {include_global} {
 ##
 ## feature option selection
 
+enable_option picker
+enable_option gitdir_discovery
 if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
 	unset _junk
 } else {
@@ -1035,6 +1037,9 @@ if {$subcommand eq {gui.sh}} {
 if {$subcommand eq {gui} && [llength $argv] > 0} {
 	set subcommand [lindex $argv 0]
 	set argv [lrange $argv 1 end]
+	if {$subcommand eq {gui}} {
+		disable_option picker
+	}
 }
 
 enable_option multicommit
@@ -1050,6 +1055,7 @@ blame {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
+	disable_option picker
 }
 citool {
 	enable_option singlecommit
@@ -1058,6 +1064,7 @@ citool {
 	disable_option multicommit
 	disable_option branch
 	disable_option transport
+	disable_option picker
 
 	while {[llength $argv] > 0} {
 		set a [lindex $argv 0]
@@ -1080,6 +1087,9 @@ citool {
 		set argv [lrange $argv 1 end]
 	}
 }
+pick {
+	disable_option gitdir_discovery
+}
 }
 
 ######################################################################
@@ -1168,7 +1178,7 @@ proc unset_gitdir_vars {} {
 
 # find repository
 set _gitdir {}
-if {$_gitdir eq {}} {
+if {[is_enabled gitdir_discovery]} {
 	if {[catch {
 			set _gitdir [git rev-parse --absolute-git-dir]
 		} err]} {
@@ -1180,7 +1190,7 @@ if {$_gitdir eq {}} {
 }
 
 set picked 0
-if {$_gitdir eq {}} {
+if {$_gitdir eq {} && [is_enabled picker]} {
 	unset_gitdir_vars
 	load_config 1
 	apply_config
@@ -1195,6 +1205,12 @@ if {$_gitdir eq {}} {
 	set picked 1
 }
 
+if {$_gitdir eq {}} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
+	exit 1
+}
+
 # find worktree, continue without if not required
 if {[catch {
 		set _gitworktree [git rev-parse --show-toplevel]
@@ -3104,14 +3120,15 @@ blame {
 	return
 }
 citool -
-gui {
+gui -
+pick {
 	if {[llength $argv] != 0} {
 		usage
 	}
 	# fall through to setup UI for commits
 }
 default {
-	set err "[mc usage:] $argv0 \[{blame|browser|citool}\]"
+	set err "[mc usage:] $argv0 \[{blame|browser|citool|gui|pick}\]"
 	if {[tk windowingsystem] eq "win32"} {
 		wm withdraw .
 		tk_messageBox -icon error -message $err \
-- 
2.54.0.99.14

