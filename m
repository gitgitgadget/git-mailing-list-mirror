Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6784A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577858; cv=none; b=TtlgwSYF/GO+768g7j1Qa8S8i3kmL1RLvMiAUfBDWsSJvoC3+Oor/T0FLdhL0KkehcX53UTz31afjpqYjbXwTE11YBveKsfiUnR5HRO/Ej7zX/pw6nzb5Rotp9YkYBCguRdmP2mNxDuBa+v+xN9HiVx68aDYIAAYm6mtDcjYcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577858; c=relaxed/simple;
	bh=+aHq/0mhg3mqmhS9d2qjcyWfrd49Ck2gOcmj77QlhX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFBkDMtT5Ganxe+LOZq+yIyDSQEM1g0+GNE4dUEPLTrBoaHf7BLQs9q4TlazNAvL/E4gfgDOG3lNywN+c1uCk6m9nCkY56ox/2krP1HUEhhQHBdqIhJp17LECCBTsmp3DK0BvFOsl6S1ED0fw2//W02kJSBr5WRRTw7VD7Xz2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inpA9tXs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inpA9tXs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22100006bc8so120017935ad.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577856; x=1741182656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P97hX1r72VErTTUpW28u0qQ0ZvGnJob0r/Tm2EjItaM=;
        b=inpA9tXsu9T2iwbqtM9iTiUiuis5AzySKnN5rGhebY45s7wGAhFZUyzCCpKd+oDKPq
         +HfaQBfUeFYoU4ub1qtSdEsf/fk5PaYhpJny/EPMH4aA8ruTwJFYTUbTdTUoK+uwoMRB
         gC6NUdUaIIYCL1de6De2N3jBWNIokti8P4iNhHlOMLMA8DhIxPdlJJIfapT7KyKlFERT
         eaCq6Wd5jdo64S44qKJ6lBqefhGwf1hlISz9XPaGHVAjSgXJDBl8pmHfQPJyrYwJC/u8
         D7aYuTqtmYIHlfFzvhWpWb5ez/QWXOYx7IQFaAZWmfgIWbfUNqy6yayEZowjyLo2hZT5
         9PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577856; x=1741182656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97hX1r72VErTTUpW28u0qQ0ZvGnJob0r/Tm2EjItaM=;
        b=LsCIETrs2vZW4/NVwbdKGx3aTyvs8A+jHaRHyoku45iAGr7nrzGpGLlsQWS3ayWqoN
         RDPBT6Ekft20NhdTcEoh+53DA+HQnar9Gka8v6xEVjXe/ysa63ehlLGp/K3xYxQCTB0j
         Ckd/GBZuO025EgWmzj3IK2IjvzoGCG+dWwK1Hutrdg7GDwAqE9ZbS8BIcBx/jbYzULxd
         /H5Jn5LYuUgPKSADkfxvwEuxxONrNVkJIUjmoLON4KtupbOb6geC9Jjk6TIApAXgSXPV
         6R5Jk44Aq0JmqQa2jBOfoC1HQlEa4MadLQPho8BYwoOY4GvDC9OROR9BBalT4h8Wu4zC
         m9JQ==
X-Gm-Message-State: AOJu0YwK+BRdcyVaTpNpikzDtsUBoMmvYolrrgIoPtWGEiPXTA2+SG5Q
	pxQ9Wt4wnZE9Rnc7qtLlvRDNn7cSiXnzzHsSX5w4QtygX3h351MUM+/CZA==
X-Gm-Gg: ASbGncs5O067JM4z/XDmSh52EwYQNIMGfK5liFGIzzxRXP6j7j1XL415LGJlOh4P0Nq
	LAmEGvnZ+Mc5ffsgjyYjiBh9CWKW6E6TrTRDhr0nbbeRLN4ytRrXRc+WHDjVQsrGBQzOcsCQKMX
	lB3DFQuszTcAcyudGyWBcVey4CIi0NJgK53xtGwUC6wKULFYfqQas1ay+tNe2pDB9y3AAy8aJSb
	Onh4balV+WfyMKrRmXez8blZB2bVa2A294q2S78CpX3wsvCvIennklQjFxqNohq+x2jhUzAC7f9
	H5j3u/vD3e818D7e4jroXw==
X-Google-Smtp-Source: AGHT+IEMa6omrjFcmrkBSZj8yIOt0zYRIssC7Skv6Xt9FxQN0bRmMTqFGKTeDxAdv1E+dNGR/Uq8ZQ==
X-Received: by 2002:a05:6a00:1ad4:b0:732:5c88:990 with SMTP id d2e1a72fcca58-7347918c4e9mr9514893b3a.17.1740577855882;
        Wed, 26 Feb 2025 05:50:55 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aeda7f8453csm3111061a12.28.2025.02.26.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:50:55 -0800 (PST)
Date: Wed, 26 Feb 2025 21:51:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 9/9] builtin/fsck: add `git refs verify` child process
Message-ID: <Z78cSA6qOF5KaATM@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

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
index 767e2bd4a0..9d1dc2144c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -830,4 +830,43 @@ test_expect_success 'packed-ref without sorted trait should not be checked' '
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

