Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085034040A
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705874; cv=none; b=R+CO46Um+CYvueFXvHV3kcPicfoneqDd2HYi0NfoOq5MNnhppUhUJLi61LWBFyYpKv6Ehz6PDh0xPTd0RNvGpZZ6cJMdcpDmfNk601HOmIpaMPQf8M58pCh3p8/+5rrBvXpoq74ZGis5F+lQi/CPloSkeLEPkuHbbyBdwdJnlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705874; c=relaxed/simple;
	bh=oa99Hs6ZT+3zGlZZjMl8ZDhJj75n0N11dzz1F0aCpyI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=otNOGfRSf9eeG2mOu36kYHu0ppOHHBC64q4KuYp5R7OwSOsjhqp1SRkSLGEIidQFrhr/XySdtlZSaZeV2F2kGLH56AvXOLfQtPe5raasY6WfaJuWeddSy3iOpSE1//QscDvuWipmVdClI1UbSdWXvyM3q0b88P5yV51nnSFZcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i50XHKYt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i50XHKYt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9309d4ea213so215102585a.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705869; x=1786310669; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hk/myl710nAksuPFCIZr1T4oTgxkkbG9u7Y+RKjN6Eo=;
        b=i50XHKYty2j9BDqYmAGW6p1iySI62krryHlnsvqGxMOfSjyVAABsn32fqI3fM9qesv
         oeyqGNFdy3kTm/SNXjTDMC+k6x4m5OT6EL+43UQUwzK4h9tLTEIjfW48GuTWBmbqxnnD
         fU9DRBek0tm79N78UdfXr9r/lPgMxvRERJIe91vZ1dtHBfGDlEAG+dYmVlLhpOlZvetg
         Wz2xt4HukkVhLh0npP2Ef6EYwCmRpnBqiikPrPkdyArZMJYkEarz6nEziTzwuCtALa4N
         AR2wrcULgKArteyFPlCxpCistLFlkTUBIjoburqUlSLdbAztfyWNGik5mhLbkHQvsYWY
         ++6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705869; x=1786310669;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hk/myl710nAksuPFCIZr1T4oTgxkkbG9u7Y+RKjN6Eo=;
        b=F1F1vzNtXvdVH1+c1Cul1O6YgJJ4th4TNP0ptzyj6O4fhkhxRmKpHlbfMpMDI3XaGQ
         k0z7nhMFeKg7FQAnM2OkSiL8iPp9OiPpcZUkkLGlRBZKF3zZW5ot7lTDeVTUvKCbAvFP
         4HFhZv1H/PuLPtu/zy24KyPbtmmo4QWkeC3p4t93mnC7hc6DXZCIWCAkgexvrfPktzTT
         7bFu8KVQrCGemvSwZTv/m8snVDEKoOH6dWfZyybzwZmqWwxEx4BUmmzk8JIC8PxJBQ6c
         yr7XAeHWE2HUMAzwmH+2H5KaSdlSyF3ugP1B2OXFfQnNIUJhukx/pjKa/xZ07XyLQUkM
         ZVqQ==
X-Gm-Message-State: AOJu0YwfTSYxQzvgV+F59RSQwiGuHddvH9Nlow8/2pmhWvpSt6wRnEXe
	z4M/zYclK83N/iNN4HX0dxnFetjIum5CvAk91boiuHdw80Wb8I4taEiBP+thYg==
X-Gm-Gg: AR+sD125AvCcIkRIz3JE7EuZchxa9v9DA+fh2rwZ+agZ+H1fLBXRSM9VaBxvx7EJztd
	ZC0pvxaAO/oQ0KhMR9Br3l1w043pxhiTGvGN8ThrvtzgxUiAie/w3W3wfpvXpAoYmaRE1smNdqw
	x21Sw3C5HtsWir+7Uxhtif9mbjbVdyo94uAWTCTYhiIWiIhuQmoklYCnsWC6Ddehzve4IYuCz3j
	1dVJufLVrNT30AX2oEOwBbscaCmYQ9+rIsWx45b7BOYc3ma3+KrwlWEj4Abz5dBfRSA+wV3RASd
	B/Z+Sflh+f4xlwnhk+1wO6A5DRMz8oE9bmfLCLjTrtvc2kSbNsjfCmB8SCZW7JsGuGHSSWT1jqc
	dfQSuQ/IOTeMcdgYqUUDPv9VRdfHKF5vOiXerqwt3REMHIZlN31TR7UC4+uw6mz9hcriYjSwySC
	hQF3OQPlxC7rrnbls7sUE+L2nX8DYVe+XbZrj4RByEXV/8zMWT7JA21GKvVBj25Us=
X-Received: by 2002:a05:620a:6509:b0:92e:8310:7369 with SMTP id af79cd13be357-934a0a9c743mr1565300785a.37.1785705868816;
        Sun, 02 Aug 2026 14:24:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc24ffesm528894885a.10.2026.08.02.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:24:27 -0700 (PDT)
Message-Id: <97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
	<pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 21:24:20 +0000
Subject: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a bisection finishes, "git bisect" reports the first bad commit
but leaves the session active until "git bisect reset" is run by hand.

Add a "--reset-when-found[=<where>]" option, accepted by both "git
bisect start" and "git bisect run", that resets as soon as the first
bad commit is found. The "original" value returns to the commit checked
out before "git bisect start", while "found" leaves the first bad commit
checked out; omitting the value defaults to "original".

Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
and perform the reset quietly.

Let the internal first-bad result propagate to cmd_bisect(), which
performs the reset using the existing bad bisect ref after the
subcommand has returned. For "git bisect run", this means BISECT_RUN
has been printed and closed before cleanup, which also works on systems
that cannot unlink an open file.

Reject this option together with "--no-checkout", since that mode must
not check out either target.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-bisect.adoc |  14 +++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 154 ++++++++++++++++++++++++++++++++--
 t/t6030-bisect-porcelain.sh   | 121 ++++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index d2115b2990..aabddd42ca 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
 git bisect (bad|new|<term-new>) [<rev>]
 git bisect (good|old|<term-old>) [<rev>...]
 git bisect terms [--term-(good|old) | --term-(bad|new)]
@@ -20,7 +20,7 @@ git bisect reset [<commit>]
 git bisect (visualize|view)
 git bisect replay <logfile>
 git bisect log
-git bisect run <cmd> [<arg>...]
+git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]
 git bisect help
 
 DESCRIPTION
@@ -385,6 +385,16 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+`--reset-when-found[=<where>]`::
+	Once the first bad commit is found, report it and clean up the
+	bisection state. `<where>` may be `original` to return to the commit
+	checked out before `git bisect start`, or `found` to leave the first
+	bad commit checked out. If `<where>` is omitted, it defaults to
+	`original`.
++
+This option may be given to `git bisect start` or to `git bisect run`. It
+cannot be used for a bisection started with `--no-checkout`.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 94c7028d2a..d426fcd5a9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -488,6 +488,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1211,6 +1212,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_reset_when_found());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 5393690f6b..93420ac0ea 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -24,11 +24,12 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
 	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
-	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+	   "                 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_BAD_USAGE \
 	N_("git bisect (bad|new|<term-new>) [<rev>]")
 #define BUILTIN_GIT_BISECT_GOOD_USAGE \
@@ -48,7 +49,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]")
 #define BUILTIN_GIT_BISECT_HELP_USAGE \
 	"git bisect help"
 
@@ -68,6 +69,12 @@ static const char * const git_bisect_usage[] = {
 	NULL
 };
 
+enum reset_when_found_mode {
+	RESET_WHEN_FOUND_NONE,
+	RESET_WHEN_FOUND_TO_ORIGINAL,
+	RESET_WHEN_FOUND_TO_FOUND,
+};
+
 struct add_bisect_ref_data {
 	struct rev_info *revs;
 	unsigned int object_flags;
@@ -269,7 +276,79 @@ static int bisect_reset(const char *commit, bool quiet)
 	}
 
 	strbuf_release(&branch);
-	return bisect_clean_state();
+	return 0;
+}
+
+static int parse_reset_when_found(const char *value,
+				  enum reset_when_found_mode *mode)
+{
+	if (!strcmp(value, "original"))
+		*mode = RESET_WHEN_FOUND_TO_ORIGINAL;
+	else if (!strcmp(value, "found"))
+		*mode = RESET_WHEN_FOUND_TO_FOUND;
+	else
+		return error(_("invalid value for '--reset-when-found': '%s'"),
+			     value);
+
+	return 0;
+}
+
+static const char *reset_when_found_mode_name(enum reset_when_found_mode mode)
+{
+	switch (mode) {
+	case RESET_WHEN_FOUND_TO_ORIGINAL:
+		return "original";
+	case RESET_WHEN_FOUND_TO_FOUND:
+		return "found";
+	case RESET_WHEN_FOUND_NONE:
+		BUG("no name for unset reset-when-found mode");
+	}
+	BUG("unknown reset-when-found mode %d", mode);
+}
+
+static int read_reset_when_found(enum reset_when_found_mode *mode)
+{
+	struct strbuf value = STRBUF_INIT;
+	int res = 0;
+
+	*mode = RESET_WHEN_FOUND_NONE;
+	if (is_empty_or_missing_file(git_path_bisect_reset_when_found()))
+		return 0;
+
+	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
+		res = error_errno(_("could not read '%s'"),
+				  git_path_bisect_reset_when_found());
+		goto out;
+	}
+	strbuf_trim(&value);
+	if (parse_reset_when_found(value.buf, mode))
+		res = -1;
+
+out:
+	strbuf_release(&value);
+	return res;
+}
+
+static int bisect_reset_when_found(enum reset_when_found_mode mode)
+{
+	struct bisect_terms terms = { 0 };
+	char *commit = NULL;
+	int res;
+
+	if (mode == RESET_WHEN_FOUND_TO_FOUND) {
+		read_bisect_terms(&terms.term_bad, &terms.term_good);
+		commit = xstrfmt("refs/bisect/%s", terms.term_bad);
+	} else if (mode == RESET_WHEN_FOUND_NONE) {
+		BUG("automatic reset requested without a reset mode");
+	}
+
+	res = bisect_reset(commit, true);
+	if (!res)
+		res = bisect_clean_state();
+
+	free(commit);
+	free_terms(&terms);
+	return res;
 }
 
 static void log_commit(FILE *fp,
@@ -682,7 +761,8 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_next(struct bisect_terms *terms,
+				     const char *prefix)
 {
 	enum bisect_error res;
 
@@ -705,7 +785,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	return res;
 }
 
-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
+					  const char *prefix)
 {
 	if (bisect_next_check(terms, NULL)) {
 		bisect_print_status(terms);
@@ -729,6 +810,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct strbuf bisect_names = STRBUF_INIT;
 	struct object_id head_oid;
 	struct object_id oid;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
 	const char *head;
 
 	if (is_bare_repository(the_repository))
@@ -752,6 +834,13 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--reset-when-found")) {
+			reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+		} else if (skip_prefix(arg, "--reset-when-found=", &arg)) {
+			if (parse_reset_when_found(arg, &reset_when_found)) {
+				res = BISECT_FAILED;
+				goto finish;
+			}
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -789,6 +878,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			break;
 		}
 	}
+	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
+		res = error(_("options '%s' and '%s' cannot be used together"),
+			    "--reset-when-found", "--no-checkout");
+		goto finish;
+	}
 	pathspec_pos = i;
 
 	/*
@@ -868,6 +962,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (reset_when_found != RESET_WHEN_FOUND_NONE)
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+
 	if (no_checkout) {
 		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -1098,7 +1196,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL, false))
+	if (bisect_clean_state())
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1246,13 +1344,36 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
+	const char *reset_when_found_arg;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
 
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
+	if (argc && !strcmp(argv[0], "--reset-when-found")) {
+		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+	} else if (argc && skip_prefix(argv[0], "--reset-when-found=",
+				    &reset_when_found_arg)) {
+		if (parse_reset_when_found(reset_when_found_arg,
+					   &reset_when_found))
+			return BISECT_FAILED;
+	}
+
+	if (reset_when_found != RESET_WHEN_FOUND_NONE &&
+	    refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
+		return error(_("options '%s' and '%s' cannot be used together"),
+			     "--reset-when-found", "--no-checkout");
+
+	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+		argc--;
+		argv++;
+	}
+
 	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
@@ -1327,7 +1448,6 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
-			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"
 				" exited with error code %d"), new_state, res);
@@ -1344,10 +1464,15 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
 			     struct repository *repo UNUSED)
 {
+	int res;
+
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL, false);
+	res = bisect_reset(argc ? argv[0] : NULL, false);
+	if (res)
+		return res;
+	return bisect_clean_state();
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
@@ -1489,7 +1614,8 @@ int cmd_bisect(int argc,
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
 				       options, argv[0]);
-		res = bisect_state(&terms, argc, argv);
+		else
+			res = bisect_state(&terms, argc, argv);
 		free_terms(&terms);
 	} else {
 		argc--;
@@ -1497,5 +1623,15 @@ int cmd_bisect(int argc,
 		res = fn(argc, argv, prefix, repo);
 	}
 
+	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
+		enum reset_when_found_mode mode;
+
+		if (read_reset_when_found(&mode))
+			res = BISECT_FAILED;
+		else if (mode != RESET_WHEN_FOUND_NONE &&
+			 bisect_reset_when_found(mode))
+			res = BISECT_FAILED;
+	}
+
 	return is_bisect_success(res) ? 0 : -res;
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 338df4f886..a7588222a8 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -43,6 +43,42 @@ test_bisect_usage () {
 	test_cmp expect actual
 }
 
+test_bisect_state_file () {
+	local file &&
+	file=$(git rev-parse --git-path "$1") &&
+	test_path_is_file "$file"
+}
+
+test_bisect_state_missing () {
+	local file &&
+	file=$(git rev-parse --git-path "$1") &&
+	test_path_is_missing "$file"
+}
+
+bisect_start_and_finish () {
+	git bisect start "$1" $HASH4 $HASH2 &&
+	git bisect bad
+}
+
+bisect_run_reset_when_found () {
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH2 &&
+	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
+	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
+	test_bisect_state_missing BISECT_RUN
+}
+
+test_reset_when_found_fails () {
+	local pattern="$1" &&
+	local state_file="$2" &&
+	shift 2 &&
+	test_must_fail "$@" 2>err &&
+	test_grep -- "$pattern" err &&
+	test_bisect_state_missing "$state_file"
+}
+
 test_expect_success 'bisect usage' "
 	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
 	error: 'git bisect reset' requires either no argument or a commit
@@ -453,6 +489,91 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect start --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	git checkout main &&
+	bisect_start_and_finish --reset-when-found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START &&
+
+	bisect_start_and_finish --reset-when-found=original &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_start_and_finish --reset-when-found=found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH3" = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH4" = "$actual" &&
+	actual=$(git branch --show-current) &&
+	test main = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found=found &&
+	actual=$(git rev-parse HEAD) &&
+	test "$HASH3" = "$actual" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '--reset-when-found rejects an unknown reset target' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" BISECT_START \
+		git bisect start --reset-when-found=unknown $HASH4 $HASH2 &&
+
+	git bisect start $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" \
+		BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=unknown true
+'
+
+test_expect_success '--reset-when-found cannot be used with --no-checkout' '
+	test_when_finished "git bisect reset" &&
+	test_reset_when_found_fails \
+		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_START \
+		git bisect start --reset-when-found=original --no-checkout $HASH4 $HASH2 &&
+
+	git bisect start --no-checkout $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=found true
+'
+
+test_expect_success 'without --reset-when-found the bisection state is kept' '
+	test_when_finished "git bisect reset" &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
+test_expect_success '--reset-when-found does not leak into a later bisection' '
+	test_when_finished "git bisect reset && git checkout main" &&
+	bisect_start_and_finish --reset-when-found &&
+
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
gitgitgadget
