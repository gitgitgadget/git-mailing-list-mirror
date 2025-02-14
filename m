Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B5155335
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509208; cv=none; b=dhV0o0VLQIyLys5C+5kOb8t2wmyqoB9qWKsbiOkDkOJM2PJr7dCIictpW2VjGxIfYW9s/nmrhdDatFD2GFdI83Cqdlq3yiEc+h19TL4EC24TC0BPVGSNEJtGTBp7IUpSxVIhXvZYwmg7nS2HObzZ5ad9bGLNQ23gR8V5UqAB+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509208; c=relaxed/simple;
	bh=bOH8EXS/qoID+eTMIaUS5T2Cf4HXM1yFX6eN6nldINI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emwyxYVykTCVuzTIzv1bWg0MWpquMnZCxY5w8fIhSSqrmRBOXdL2z/wgHKVwbm/itzCdrIWOTw1TQYcBe+Aq91fl0GPiC+ku6UiC7GNmMupW+829icM6a163JJ+z9v0pnB1KEnAbSkQ2siffONE4j/93HKXTpOlal8hcU9xCTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+DsoX5t; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+DsoX5t"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ef7c9e9592so14069297b3.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 21:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739509205; x=1740114005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFe8USlvzqm0SFaL8IfMaARwBqQYjT6+vEiHsm5EcBI=;
        b=A+DsoX5tp+9502e9wllaJtWuL4tDkH/AMUoO2nR9gk5KNumJx5M4ZYu3yGW72s+i1N
         791GeC7xk0jfvXcF9oL+6Ff3Yin4CCHqEsmCEJcoJs4Xc/WUiPAVQ4CSq55kaOi7EF8V
         sq9jPO6jzT9pYXt/Fp9YoUY0/GKdU9dhiyaDuqfXMTpfmQD1XRSH6zQwc13Yu+hcJytd
         aTU09DN/aRQ0Unr2VvNLAioGyBZ6V2vlWEw78UV1Drm/LoQuUzmoJiY6mlqjmyShxklm
         RMJJNmJydC26LoeT4ywzN4QbtG6/9PavHtXsNs7voDuYqXtb6l5rf6coK4gdLwlV4Rnb
         F8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739509205; x=1740114005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFe8USlvzqm0SFaL8IfMaARwBqQYjT6+vEiHsm5EcBI=;
        b=uOMqnIKpyShFoQTtU2S1erdiSMwCZocdAbGVhBDzmdONKc9B1SgmCPo5KrN8Gw0peI
         L8JEEOATQEGNJOsxvPOfTwSKXzkDL4s9DldgCqZEzSAbe9c/UF3hZkFAva+oMRuClgBg
         FdFVOtR74cQfHeZ87xSWmjkQ0hH1YDoIxi4W+5nAEH+lmj65poXirtApNGQSnyaZ3/55
         8eVdANhvrjHmC952F0GYXyX5dXFfzjV1wGjpYXzNPG6IyRGrikCk6t1GxbriIMs+XMRP
         0GRHXcBlex9cxYkCQHaTurFyzyc3HKm43/45+A+i/WoqBCg6iwOM3fQSQDzFMcPfy5I6
         WRMw==
X-Gm-Message-State: AOJu0Ywxn2Uwyx9kXzo6L8/IpQufC0QZvbT7IBKoBquGdDWzMN17a7wn
	8gYKswm3oVajmqeKiItBoveDnb8HK2e4w9AKzG8DR6UG9UIEV90Z0m0VFwsP
X-Gm-Gg: ASbGnctmKuhSDFjAbafebSALQ3/QY5S2rFA4Shhuvd0fQ33v3VHn1qWuXAz22XQfCn+
	vwUyX01Knjy7Eg9svl3yhMKzqyv9mHi6sdobAqVbf4q6qDGJoh4rkvAVf25uGonQ2DSv/tWXdNx
	8Zy6jIE/foL0AqD/NggwSR16p0Qd8SCh1/oVkmWz+H8fnSpsa3MNWtHd5iFMEODY6WImBUmC6W4
	wh4u9raRaJ5rYL+R7J6wep3RzUeY3SCZMUXMrR+iPJ6ACNUUuIBKdcCFg0SjOudPwY6IA==
X-Google-Smtp-Source: AGHT+IFS5W3LxvxUUJ5MEBX8v9p3H7xemezSvLFgVtfVC9WFACBcDi9IgNwCOsQjD6ucpwZg+/Y2Gg==
X-Received: by 2002:a05:690c:700e:b0:6ef:64e8:c708 with SMTP id 00721157ae682-6fb32ca520amr56914427b3.17.1739509205482;
        Thu, 13 Feb 2025 21:00:05 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb361d037esm6083857b3.118.2025.02.13.21.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 21:00:04 -0800 (PST)
Date: Fri, 14 Feb 2025 12:59:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z67Nz4GwAVS3fEds@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

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
 Documentation/git-fsck.txt |  7 ++++++-
 builtin/fsck.c             | 33 +++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh   | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 5b82e4605c..5e71a29c3b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
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
index f305428f12..22bd847782 100755
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

