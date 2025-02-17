Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619C1494DF
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806106; cv=none; b=qkNx4B95u92TN3vMsoUZ3gdOn4ESWh8yXCPUrlhHnOw/h/myL716tVZhq+TF2SU13fAKlfvG2ISrHQ0r0yuAq11Y1oey3r7SOnEfFH+VRH2OjLsTPYFaipnRGOUnyLZA+5lz5twExagktipazXh4EIiMgc7JB5F1Cb1LGS+EYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806106; c=relaxed/simple;
	bh=wPaIqmLHwWRvrbBUYCny4tdq5axRNe06u08RN96g8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y79GiGb/MGDkaW0ZT3Wd+nIeSUJtkD06A/SJNAjSsmpZXha7MokWVBnLsdbIkV4wRplF/2pq0WPSYVuuXBeHdWSfutF3+mcVYxy8hV4a6FKkexciQ1pjNFoCEC7ArtuLQhNlpjG9KQr+NIhU62N7maSjs8yHA23aLi2BLq22SGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZawTrMZr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZawTrMZr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22114b800f7so26648525ad.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806103; x=1740410903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdXrc7vhpoU7P9lSCnZihSpFpzQm1O5gdN7HPnT6JKs=;
        b=ZawTrMZreUIjfNKwncaltLR48fVNvkKooQ1o4c0UgBE03LTZbTNmsmC5m/IJq2MaFd
         OZinlTAfQfTlpK03who81ej4bXEz70zI+OIw2Pm4qUzP9O0yo9r7sFwfVG807vpAAos6
         xIBqgsMmnRqGt7YpF+6MBmmfaVL+lz4gY2Ojk7WqD5OPPwqoF59BxlAxSavB2znzLAQa
         Jf/PMcoXgp4Dq2oN8EmxbDuOyS5714+LK9E3uDM5phPf/9ad4gt5wY0LGav+5k8wahnK
         uDoGuRXYncsJ8NY9veW/VV5renxUEkoXrC4X4RjFGyrtDmnwmTER0gtdbWVxUCjCIT3V
         VLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806103; x=1740410903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdXrc7vhpoU7P9lSCnZihSpFpzQm1O5gdN7HPnT6JKs=;
        b=lP4IeHmHCkygr9of4IhTYgGUZ2VYTq0SKRNynCOiu+5Sxs64ulQ3KMlzZB8bcOMDOM
         SCnH1UwJY8U+U/y8v9xs9BixFvlXnyNSI2MasiDYd2PEWv06z3hL9ltPbFhheZbUEKDN
         VIIUOjwQqabrU2LXXAf35t+7xBRn5zR78AqPl+hsjej4UNus2upU7bZylu2xUOBcB57/
         4hhRTyZ16NuyLM9kQJiL2xstd4UsYG37xMMRG2M10+ABHDh5GGwh7Qfb/qKk6/xaYh49
         HlW/zJSXSLBCUfzB+3IDC/x/YTihnkvBiOXyH2ajsWks5nV2HJVVqtWaK6w6XYH3FxXS
         Jkuw==
X-Gm-Message-State: AOJu0YxUg0UHE7ztvHQ40IegG+COeuoauxvp8h9TwYpO3BY79tY2SoHp
	nUoDy4Ac60tumBPVfQLHtCcLNHiwlsDvrWYJ6lDO+FWrfQZaw4mtzJW6uw==
X-Gm-Gg: ASbGncvZ88okdhJTo3DVklGOCOVxzwEkbmyMyb2u7+M7WZfcOwPdtRdYji06gZ8ezzQ
	M9HqIz90XSM4hcx7nGa3+8Pa4+BY0fp1mEqdtwwVcSpzTG4rjQrumI+g65iZz4pNh/gfVNxs1Oo
	q0ajJwWayDoQz2rNTaVHAu0cvFCMhOgV7Hev2RZti3D/6m4WKI8bURhMWIj0IjJ0LXK9rmk2VyM
	hh260DIU2c8g9/LBp9Vw6js7qrt4p+QLbcWqKhg6Pt4bL1Cx05aUABq7U1Vyqwua1Aqp3/aSkxu
	BogFTK7wyf4=
X-Google-Smtp-Source: AGHT+IFVensy4hbGSGnqpK2Z2myp/iYFa1jg0Db33vANDROKzWWBSwGxCiTkuCgTl6vnpxtkJXyJ+Q==
X-Received: by 2002:a17:903:22d2:b0:220:f7a6:a02b with SMTP id d9443c01a7336-2210406aac0mr157443375ad.30.1739806102795;
        Mon, 17 Feb 2025 07:28:22 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f29sm72700855ad.37.2025.02.17.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:28:22 -0800 (PST)
Date: Mon, 17 Feb 2025 23:28:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z7NVlG0coJ9JbuiG@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

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

