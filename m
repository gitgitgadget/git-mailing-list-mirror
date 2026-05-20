Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7410371D14
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308684; cv=none; b=XoJ22OEM3NAtueikbtikOuuVvfEa1w1dfASjG1UaRzllidBPHV77y+AlmPMdkZmdDMFFjlelwEy5jgMEDG9MG3NtVICyfobIX1Z+8w9u2JIl0TjYdb3hnfnaYj8VJ5L+igU3RttwMXHy9ygxQCwP5sZ7b14Ochu3kd5CI3IuQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308684; c=relaxed/simple;
	bh=mkG5kY6UJmPTN9IEedvI+M4Vt0qmkaBC6eOl98XbcmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i23Dl4s0QGpaX2A9roSQ915CQJxMURz3xbxdN1GNMaeM4F7hZwKHDMYHNeIK2QNmOa/dnU8rDQ3Qv61lB7XG8h2/tZg1LrYNtyiOmq6iKinnSOhjda5L39au+W00TaTUpA1pAuHvj8IV62bNHA4jxKYWHDiQ7dkacIsWcdBDxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBtyJdXA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBtyJdXA"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso81260206d6.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308682; x=1779913482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mamMkYcGJuyJ/+9lv7yI/qfsoSFNllfwmSse58dfQrE=;
        b=EBtyJdXAGtgdc+x/Tft2ppE6/YS/gWbzTXtrkE8zyPngRh2gd6OEM3HBmcPyWckbdA
         v60X2DaH9VWY5s8zZaUfx24hF2IFl16QNP4eV02HwWfLesWriFeaBx/RkpJBSHXnjbt5
         0QJ2H4yr9vYgFJQWu+bTUu6i4CqwGALI7s4tVRKkSjlMT69ivv41G40PqVVrd1Teamv+
         4zpQ7eT3HZm7ZF3jriQSW1eglWcsfDM8AlVUiz74DCUrFJ525/RP1CzUTmXrri0FBGs3
         4cH8urKPhxfPVW32suTfvUMDeVh1fnjJ5yM5tqxRWsEhFQakALUhlN8ar8oKoFI22cCr
         d1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308682; x=1779913482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mamMkYcGJuyJ/+9lv7yI/qfsoSFNllfwmSse58dfQrE=;
        b=F6puAxq5kOpf1+BUjZ3vPbCXCLr0pj9uhS400vlAFAO3TSQJhfAoZWLKG4wBHz5HTk
         W62ou8y3x/44gG4J0XpXdqsGTt98R9AyaazR5kyAuLQhoyZmHrBSqrenNITWVHyJVk9T
         i+CnDU+/QEXyHYm8RlHk11RwmlBCI1pBusZrgufNa2V8GuLzbF3wQ6jb3bONQ2PHsnMR
         EQ0hHGkkL76KgYSh39I4S2BfMUOBuN7WfMMkquDo5T+GEQWDQvVtLEMoBn061VstHqKM
         65S4kn2i42oUh+QtFVEqM7H4fCIzcRanMnP3xAW4Gf02MUdovsipY2JnpYUiV5a81bOZ
         rIaQ==
X-Gm-Message-State: AOJu0YwdBJttrCncRVJzRFNseNRM3kFqRzhhrVCcwF4zBqnl2CQpAtG4
	JclTNvO6h/6S/whtL5v7GGn44OK+3exq0jjLV+om0iXI2j/gU5EWoFvkp0qIzw==
X-Gm-Gg: Acq92OFBVrNtLOOVJEIe4drdMP+md/JmtEJteOYO0fLJU/Px0nW+mLO9KYK+NfvhlKK
	G1TZX1DoQKZLIfuSAS1QKDkbrqzk7746dIQUiIHgPZ1+iQHwkvzwwelBWnX+g3TUV79KS8csRsn
	9DXRJvMW/3n4px2e8U+LfHYZxILxAHvWaW/PZJeN3ahT+8nE8EZPvMys71qYLe/HoVyAtXdR7tu
	39A3WPv2mueYwJSk3PHbtoq4wfVl4PgKB6HbASCVzNyT/lQqhN3GhHv5eXjYj3xhUH7gR1yrwv2
	eQeou+1TXiD0J2iay87QcNacqU2aYLM5l9/FUPzh+//KQ4gSq2Tz+ckl2Pa+RlZtwQm6t4Rguop
	hYW+cHyDnhiSBNwFkNSNdkZE4wTvVYhtDZ4hQrEwSwuT3tq3TgvMN6E310m229+3ImVuLy1RYOa
	kziqwUfxTsqJ1wABuPkvtjecr+PQ==
X-Received: by 2002:a05:6214:5710:b0:8ba:be50:f19f with SMTP id 6a1803df08f44-8cc6e35634dmr129186d6.6.1779308681911;
        Wed, 20 May 2026 13:24:41 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:41 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 11/11] git-gui: add gui and pick as explicit subcommands
Date: Wed, 20 May 2026 16:24:10 -0400
Message-ID: <20260520202411.108764-12-mlevedahl@gmail.com>
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
index ae609f86f1..299c1a0292 100755
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
@@ -1174,7 +1184,7 @@ proc unset_gitdir_vars {} {
 
 # find repository.
 set _gitdir {}
-if {$_gitdir eq {}} {
+if {[is_enabled gitdir_discovery]} {
 	if {[catch {
 		set _gitdir [git rev-parse --absolute-git-dir]
 	} err]} {
@@ -1186,7 +1196,7 @@ if {$_gitdir eq {}} {
 }
 
 set picked 0
-if {$_gitdir eq {}} {
+if {$_gitdir eq {} && [is_enabled picker]} {
 	unset_gitdir_vars
 	load_config 1
 	apply_config
@@ -1202,6 +1212,12 @@ if {$_gitdir eq {}} {
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
@@ -3137,14 +3153,15 @@ blame {
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

