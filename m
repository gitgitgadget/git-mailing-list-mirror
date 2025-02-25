Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1326868B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489738; cv=none; b=W40VqnbgfnOnnRhbEu5MIV72Mfwyn2rDsn/2GCw96HgYx/ngZYHNX4bn8sPuAqmuwLhigcuKE3PBFq0e+qyJ55Ap/3e98d+9tgu/DzPvUXtT0KW5uvdJAhTQehtHenlVO7GfyU4raVSKX/NUN1koKuXSDi/i+MQfJ6ceJIkw/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489738; c=relaxed/simple;
	bh=wPaIqmLHwWRvrbBUYCny4tdq5axRNe06u08RN96g8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g31ztEN9q5JX849ua5Sb8EBWCDnRY2SsaY8YUlgbXG59WrFVS/+4nI4xIsTIJyZjfvIwQozEwjRltStTTfzuvsE1SjV1ntKvrFfmKOXRNoUZw6XJ5pvjSH5HvipaKf8lwZXyARBLLYKXisP37lqgeroJ2qqgLiwsrkXo6SGSohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVFEpe30; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVFEpe30"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220dc3831e3so102038295ad.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489735; x=1741094535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdXrc7vhpoU7P9lSCnZihSpFpzQm1O5gdN7HPnT6JKs=;
        b=QVFEpe30RrX05YNK5L0zZpP2U+Dz4/rDgtH2Y8jU21aPZeB8wKwD2nlCXVXsiWrt8M
         9osmLqjeZDtpYU+wY/terwT5NOIUUf7tDsUwS2f/YIo1p0eMzSa1+AFI2Br/Fj47L6MZ
         C/YZn8uET3MU7tCmbSNMCW0Gf6sP47iH74R/gcgcYy8ph8r99gIIvHwZw5r+orcgjCH1
         NwZh21fR1ViuHbr9nWA9KEXA4/3S4fYN8ixqICdhkJSkSpRooMUbz8uAsn5W2RQKTfru
         NUdMYT4Z0daF9X2GQTZ1App82hrArl+fwDuxSNkfD3CX0N9E76jWo64v61TMOzHsZefi
         spKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489735; x=1741094535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdXrc7vhpoU7P9lSCnZihSpFpzQm1O5gdN7HPnT6JKs=;
        b=YJ66aoG8F7RQT7/4kFXFZw1MtCQAPELqseYDUPzBcKsLOTNqMtXLdbV5hSsfrIwxzB
         alFj7JOc6i0Lbc4PULCp7jrpvVtj9oGFfJC5V9BF4SM3nR9C3HIXLiag0YgCXdt13yGv
         N9ev4I/ioIaF+ClUuMkWG5xf6V4G4kcoUoi1xFI2b8L+DzrsnK6rnxrWEAKSiFBSh8G6
         i8Op7elFy9qExGweXh2ohuX473U2Pimx8Ptt57TybdAwRT+uUqW/IdWogEF/qfYUep7x
         rXkMIVTwtGWS/9Eixu8sytdn4t9nvb4uDZj3b9bGjBhFy8x4NP9jEmYVxorTsNuxNLSF
         kyOA==
X-Gm-Message-State: AOJu0Yx/SR0JutcH2fNqwV/y58XOjBn53L5TBzUOMiRFqafWJmbkgFXN
	OBfZh9yl+u0n55TSzMlD3rm9zlHFrl072ZnGUjm/RXGO4Se+SOCQveHKmQ==
X-Gm-Gg: ASbGncsmyI6HViT8AS6m4JqxCE2thERUTTaXny8qoWkHmwaQwYknDMAAtth/zYzTtrn
	BVJQgrOwQMCf3UWiSwyqXmDFb0Is2IbTwUuKO98nbqnc6G+4LXfEYKHg17Td8eTOeqbN1J5dLU+
	p3RiBh7fns/J0T073fd31jkamVC4jDneuLf7tZmcRGUAREX6wpWFgndGlCA8wMgvIMfEENYmC2U
	jWfU3CuZzxruszYqxVXtv2ypkb+RJqFMS0HCxVU8Igao5sIN1ZvsEBDktQl0ub3XZwCuH8XyJ1N
	BZFt4fgpV5UxmTDocuJKvA==
X-Google-Smtp-Source: AGHT+IG1TC6g2AdaMBxDMsS1XHjpSGF3bpq+5YCLl1TZtv1Mk1HULTSeFXvTmQFAQ5Ocb45SlwWQKg==
X-Received: by 2002:a05:6a00:991:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73425a1fab8mr29216580b3a.0.1740489734951;
        Tue, 25 Feb 2025 05:22:14 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a6f7c1csm1462874b3a.49.2025.02.25.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:22:14 -0800 (PST)
Date: Tue, 25 Feb 2025 21:22:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 9/9] builtin/fsck: add `git refs verify` child process
Message-ID: <Z73EDq-xCm1GO28-@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

At now, we have already implemented the ref consistency checks for both
"files-backend" and "packed-backend". Although we would check some
redundant things, it won't cause trouble. So, let's integrate it into
the "git-fsck(1)" command to get feedback from the users. And also by
calling "git refs verify" in "git-fsck(1)", we make sure that the new
added checks don't break.

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git refs verify" command. In order to provide
the user interface create a progress which makes the total task be 1.
It's hard to know how many loose refs we will check now. We might
improve this later.

Then, introduce the option to allow the user to disable checking ref
database consistency. Put this function in the very first execution
sequence of "git-fsck(1)" due to that we don't want the existing code of
"git-fsck(1)" which would implicitly check the consistency of refs to
die the program.

Last, update the test to exercise the code.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-fsck.adoc |  7 ++++++-
 builtin/fsck.c              | 33 ++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh    | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.adoc b/Documentation/git-fsck.adoc
index 8f32800a83..11203ba925 100644
--- a/Documentation/git-fsck.adoc
+++ b/Documentation/git-fsck.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>...]
+	 [--[no-]name-objects] [--[no-]references] [<object>...]
 
 DESCRIPTION
 -----------
@@ -104,6 +104,11 @@ care about this output and want to speed it up further.
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
+--[no-]references::
+	Control whether to check the references database consistency
+	via 'git refs verify'. See linkgit:git-refs[1] for details.
+	The default is to check the references database.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a4dcb0716..f4f395cfbd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -50,6 +50,7 @@ static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
 static int name_objects;
+static int check_references = 1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -905,11 +906,37 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(struct repository *r)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_progress(r, _("Checking ref database"), 1);
+
+	if (verbose)
+		fprintf_ln(stderr, _("Checking ref database"));
+
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+
+	display_progress(progress, 1);
+	stop_progress(&progress);
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
 	   "         [--[no-]dangling] [--[no-]progress] [--connectivity-only]\n"
-	   "         [--[no-]name-objects] [<object>...]"),
+	   "         [--[no-]name-objects] [--[no-]references] [<object>...]"),
 	NULL
 };
 
@@ -928,6 +955,7 @@ static struct option fsck_opts[] = {
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
+	OPT_BOOL(0, "references", &check_references, N_("check reference database consistency")),
 	OPT_END(),
 };
 
@@ -970,6 +998,9 @@ int cmd_fsck(int argc,
 	git_config(git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
 
+	if (check_references)
+		fsck_refs(the_repository);
+
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(the_repository,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 28dc8dcddc..42e8a84739 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -822,4 +822,43 @@ test_expect_success 'packed-ref without sorted trait should not be checked' '
 	)
 '
 
+test_expect_success '--[no-]references option should apply to fsck' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	(
+		cd repo &&
+		test_commit default &&
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
+
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck --references 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
+
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse HEAD)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git fsck --no-references 2>err &&
+			rm $branch_dir_prefix/branch-garbage &&
+			test_must_be_empty err || return 1
+		done
+	)
+'
+
 test_done
-- 
2.48.1

