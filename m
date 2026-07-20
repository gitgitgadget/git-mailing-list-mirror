Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBED3D2FF7
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538625; cv=none; b=ifMFhr23n5y+CHGLprS3ZsJOMZn8xEuS+fm0zq/+2hAMAmAqZECct98YwgwRYEibMDGB8QCdSPjan+xy1X8vB8p2/u6bgJwZT/OwaZKeLNQQgMRd39EwMHVjOyuHwAvj4AznKkpRFGdTHBH5e97gInpfl4ldPIPwUK6vckTu/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538625; c=relaxed/simple;
	bh=UU4L/MZnkxr5rRz8Id+fk3tsR+ADuI8ErCUE85Att80=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CjF6a7HeAIRZiwDTDGiJOFRJJbs1GVNnrcMHoy0iDfNfRUIaUj1Lo4DvWTqNaJ8FD7esAqNhI9gz5t6huy/63SDhRk6LeIVekNrvoWwx7RJkD8PeqEjOE/r/NEiA1oUkANcPOzd0gZsQlBW/b+HJTnZNHL3nCpx2GYlhNvXeWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHdDEd92; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHdDEd92"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e54f8c051so747091585a.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538622; x=1785143422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PDvMGrwQcYWiWI88A/dVmwnF5wJH39gLtfqmXP14QmU=;
        b=JHdDEd922hDaNB5vLHlNUd3OqBMeWDnuFhL8KQIdnsjGg9H1xzy+JwPLIh2wxVCGdr
         JcKzTD6llbGbUcAVKyOS2Y3m0IUaIkZsb1EppqyoKaSTaIOHdUWn/TCdMDJAVk8zLisk
         UDdXCrweYjT3DgAkmNxV49bK9HPImWZ8e3bg40HbBAgpKnT8PVi30Q0hYHkELI3GpORZ
         sOtVwpfII9cQ+1ytU80YiEq2Un312kYphgLHbNa+Ei+hwOqVquXjQbz4UyFLopHqSBih
         W6LllaayY/i/3DUeswKbb5I88Gt7W2A9HcRKSKqa7W3bjy0+7OpaiJZsupGa8ZHuLAGI
         +z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538622; x=1785143422;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PDvMGrwQcYWiWI88A/dVmwnF5wJH39gLtfqmXP14QmU=;
        b=Ys0oIoyCPyasOD80KNvJoYl1iAJT3IH7v23SWhSA4UAs/qUDAD/XozIkiN6KB/7g//
         EM/OjcXDmyP4LhTrqVKN8Vg7p14Ye//3f2tcqiuHpcsQhHEbsYkpdFdbDrrOKcAjFOGX
         MGbs0P0nLItRbRRWK4dI+qzlAlkKWoszmtk3Kw/VjUY75pHQ7C8QIzxIkpTdxxYU9Qut
         Rc3ZmsoMki33dTuL1cUEbMD18dOL4qRSj631OvR5d0hmIo0hj+W1bCpBhOr17wbGOfWT
         QCm06eQN17V57xvJpobZJTKXwi97GDGYae0T5zlPZX/kEb2xftV9pL7Hd9iphj1YROy0
         hGlg==
X-Gm-Message-State: AOJu0YzkV8aHw0Dh1NV4V9VkSV1Etqr/0l+tlpdh2D4R+ML/p/NMo19o
	nXYf0585ER18jZNTlJDBGAr0810BuXYbqJGmwwS/2paHN1dlFGj8VDOZU9orHw==
X-Gm-Gg: AfdE7cmRxsmWYnclI3VP6+JWM6p7e4hKX9Qn5IEH0apl64hTWU8ootaTNLHBwryPUjd
	njwfiNfewPjutXupl9sLEBb6QyRFGP7hWXyB6oiLRqwdknY968iX5nrTjivWNjXJaF2Qyro4QYM
	vVJx/nCsMvNxPeBBfpqTUJh34DmQ/AAG9gw9H6N+8VFj6+QpLXDS4KgO3kCMF3DA8wjI9Cczy0V
	pNxDf91s9wTW5PKzKLaWD25ZKlIhVJDGSZ2oTzwylMZ8wgaW2o2jiEGgqZGDHTNXfQRuYzKa6/I
	0CpLGFVsuTTIehueLowk0Cod8zZS5Ykohc8ESwYGLIfmcaKQLONi5d9XC9xg4ifGZ63EJcEAdeK
	kPr67/JhvTFKLCah4f4N2hWEPlGnTE/CKCJyNFa9cTNOfaNa5zoXl3uinconW8CYt6z4M5lJnUj
	jiCKo/hllH8EwUzU0=
X-Received: by 2002:a05:620a:4416:b0:92f:279:594f with SMTP id af79cd13be357-930b41ce41dmr1301418885a.78.1784538621504;
        Mon, 20 Jul 2026 02:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.23.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52e061csm833893685a.5.2026.07.20.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:20 -0700 (PDT)
Message-Id: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:17 +0000
Subject: [PATCH v3 0/2] bisect: add --auto-reset to leave when done
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
    Harald Nordgren <haraldnordgren@gmail.com>

Add a --reset-when-found option to git bisect that resets the bisect session
when culprit is found.

Changes in v3:

 * Rename --auto-reset to --reset-when-found, including internal names.
 * Defer git bisect run cleanup until captured output is printed and
   BISECT_RUN is closed. Drop the open-descriptor preparatory change,
   retaining the existing filename-based output handling.

Changes in v2:

 * Add option --auto-reset[=<where>] with option to go to final commit as
   well as original.
 * Refactored tests.

Harald Nordgren (2):
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --reset-when-found to leave when done

 Documentation/git-bisect.adoc |  14 +++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 146 +++++++++++++++++++++++++++++-----
 t/t6030-bisect-porcelain.sh   | 109 +++++++++++++++++++++++++
 4 files changed, 250 insertions(+), 21 deletions(-)


base-commit: 41365c2a9ba347870b80881c0d67454edd22fd49
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v3
Pull-Request: https://github.com/git/git/pull/2335

Range-diff vs v2:

 1:  0de8b12f65 < -:  ---------- bisect: read run output from the open descriptor
 2:  8a2dcdf305 = 1:  59920c51ae bisect: let bisect_reset() optionally check out quietly
 3:  5b3704fbd4 ! 2:  542f4b2c80 bisect: add --auto-reset to leave when done
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    bisect: add --auto-reset to leave when done
     +    bisect: add --reset-when-found to leave when done
      
          When a bisection finishes, "git bisect" reports the first bad commit
          but leaves the session active until "git bisect reset" is run by hand.
      
     -    Add an "--auto-reset[=<where>]" option, accepted by both "git bisect
     -    start" and "git bisect run", that resets as soon as the first bad commit
     -    is found. The "original" value returns to the commit checked out before
     -    "git bisect start", while "found" leaves the first bad commit checked
     -    out; omitting the value defaults to "original".
     +    Add a "--reset-when-found[=<where>]" option, accepted by both "git
     +    bisect start" and "git bisect run", that resets as soon as the first
     +    bad commit is found. The "original" value returns to the commit checked
     +    out before "git bisect start", while "found" leaves the first bad commit
     +    checked out; omitting the value defaults to "original".
      
     -    Persist the selected target in a BISECT_AUTO_RESET state file and perform
     -    the reset quietly. Reject this option together with "--no-checkout",
     -    since that mode must not check out either target.
     +    Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
     +    and perform the reset quietly.
     +
     +    For "git bisect run", defer the reset until after the captured output
     +    is printed and BISECT_RUN is closed. This lets cleanup remove the file
     +    on systems that cannot unlink an open file.
     +
     +    Reject this option together with "--no-checkout", since that mode must
     +    not check out either target.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-bisect.adoc: SYNOPSIS
       [synopsis]
       git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
      -		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
     -+		 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
     ++		 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
       git bisect (bad|new|<term-new>) [<rev>]
       git bisect (good|old|<term-old>) [<rev>...]
       git bisect terms [--term-(good|old) | --term-(bad|new)]
     @@ Documentation/git-bisect.adoc: git bisect reset [<commit>]
       git bisect replay <logfile>
       git bisect log
      -git bisect run <cmd> [<arg>...]
     -+git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]
     ++git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]
       git bisect help
       
       DESCRIPTION
     @@ Documentation/git-bisect.adoc: ignored.
       This option is particularly useful in avoiding false positives when a merged
       branch contained broken or non-buildable commits, but the merge itself was OK.
       
     -+`--auto-reset[=<where>]`::
     ++`--reset-when-found[=<where>]`::
      +	Once the first bad commit is found, report it and clean up the
      +	bisection state. `<where>` may be `original` to return to the commit
      +	checked out before `git bisect start`, or `found` to leave the first
     @@ bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
       static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
       static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
     -+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
     ++static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
       
       static void read_bisect_paths(struct strvec *array)
       {
     @@ bisect.c: int bisect_clean_state(void)
       	unlink_or_warn(git_path_bisect_run());
       	unlink_or_warn(git_path_bisect_terms());
       	unlink_or_warn(git_path_bisect_first_parent());
     -+	unlink_or_warn(git_path_bisect_auto_reset());
     ++	unlink_or_warn(git_path_bisect_reset_when_found());
       	/*
       	 * Cleanup BISECT_START last to support the --no-checkout option
       	 * introduced in the commit 4796e823a.
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
       static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
       static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
     -+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
     ++static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
       static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
       
       #define BUILTIN_GIT_BISECT_START_USAGE \
       	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
      -	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
     -+	   "                 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
     ++	   "                 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
       #define BUILTIN_GIT_BISECT_BAD_USAGE \
       	N_("git bisect (bad|new|<term-new>) [<rev>]")
       #define BUILTIN_GIT_BISECT_GOOD_USAGE \
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
       	"git bisect log"
       #define BUILTIN_GIT_BISECT_RUN_USAGE \
      -	N_("git bisect run <cmd> [<arg>...]")
     -+	N_("git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]")
     ++	N_("git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]")
       #define BUILTIN_GIT_BISECT_HELP_USAGE \
       	"git bisect help"
       
     @@ builtin/bisect.c: static const char * const git_bisect_usage[] = {
       	NULL
       };
       
     -+enum auto_reset_mode {
     -+	AUTO_RESET_NONE,
     -+	AUTO_RESET_ORIGINAL,
     -+	AUTO_RESET_FOUND,
     ++enum reset_when_found_mode {
     ++	RESET_WHEN_FOUND_NONE,
     ++	RESET_WHEN_FOUND_TO_ORIGINAL,
     ++	RESET_WHEN_FOUND_TO_FOUND,
      +};
      +
       struct add_bisect_ref_data {
     @@ builtin/bisect.c: static int bisect_reset(const char *commit, int quiet)
       	return bisect_clean_state();
       }
       
     -+static int parse_auto_reset(const char *value, enum auto_reset_mode *mode)
     ++static int parse_reset_when_found(const char *value,
     ++				  enum reset_when_found_mode *mode)
      +{
      +	if (!strcmp(value, "original"))
     -+		*mode = AUTO_RESET_ORIGINAL;
     ++		*mode = RESET_WHEN_FOUND_TO_ORIGINAL;
      +	else if (!strcmp(value, "found"))
     -+		*mode = AUTO_RESET_FOUND;
     ++		*mode = RESET_WHEN_FOUND_TO_FOUND;
      +	else
     -+		return error(_("invalid value for '--auto-reset': '%s'"), value);
     ++		return error(_("invalid value for '--reset-when-found': '%s'"),
     ++			     value);
      +
      +	return 0;
      +}
      +
     -+static const char *auto_reset_mode_name(enum auto_reset_mode mode)
     ++static const char *reset_when_found_mode_name(enum reset_when_found_mode mode)
      +{
      +	switch (mode) {
     -+	case AUTO_RESET_ORIGINAL:
     ++	case RESET_WHEN_FOUND_TO_ORIGINAL:
      +		return "original";
     -+	case AUTO_RESET_FOUND:
     ++	case RESET_WHEN_FOUND_TO_FOUND:
      +		return "found";
     -+	case AUTO_RESET_NONE:
     -+		BUG("no name for unset auto-reset mode");
     ++	case RESET_WHEN_FOUND_NONE:
     ++		BUG("no name for unset reset-when-found mode");
      +	}
     -+	BUG("unknown auto-reset mode %d", mode);
     ++	BUG("unknown reset-when-found mode %d", mode);
      +}
      +
     -+static int bisect_auto_reset(struct bisect_terms *terms)
     ++static int bisect_reset_when_found(struct bisect_terms *terms)
      +{
      +	struct strbuf value = STRBUF_INIT;
     -+	enum auto_reset_mode mode;
     ++	enum reset_when_found_mode mode;
      +	char *commit = NULL;
      +	int res;
      +
     -+	if (strbuf_read_file(&value, git_path_bisect_auto_reset(), 0) < 0) {
     ++	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
      +		res = error_errno(_("could not read '%s'"),
     -+				  git_path_bisect_auto_reset());
     ++				  git_path_bisect_reset_when_found());
      +		goto cleanup;
      +	}
      +	strbuf_trim(&value);
     -+	if (parse_auto_reset(value.buf, &mode)) {
     ++	if (parse_reset_when_found(value.buf, &mode)) {
      +		res = -1;
      +		goto cleanup;
      +	}
      +
     -+	if (mode == AUTO_RESET_FOUND)
     ++	if (mode == RESET_WHEN_FOUND_TO_FOUND)
      +		commit = xstrfmt("refs/bisect/%s", terms->term_bad);
      +	res = bisect_reset(commit, 1);
      +
     @@ builtin/bisect.c: static int bisect_reset(const char *commit, int quiet)
       static void log_commit(FILE *fp,
       		       const char *fmt, const char *state,
       		       struct commit *commit)
     +@@ builtin/bisect.c: static int bisect_successful(struct bisect_terms *terms)
     + 	return res;
     + }
     + 
     +-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
     ++static enum bisect_error bisect_next(struct bisect_terms *terms,
     ++				     const char *prefix, bool defer_reset)
     + {
     + 	enum bisect_error res;
     + 
      @@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
       
       	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
       		res = bisect_successful(terms);
     -+		if (!res && !is_empty_or_missing_file(git_path_bisect_auto_reset()))
     -+			res = bisect_auto_reset(terms);
     ++		if (!res && !defer_reset &&
     ++		    !is_empty_or_missing_file(git_path_bisect_reset_when_found()))
     ++			res = bisect_reset_when_found(terms);
       		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
       	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
       		res = bisect_skipped_commits(terms);
     +@@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
     + 	return res;
     + }
     + 
     +-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
     ++static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
     ++					  const char *prefix, bool defer_reset)
     + {
     + 	if (bisect_next_check(terms, NULL)) {
     + 		bisect_print_status(terms);
     + 		return BISECT_OK;
     + 	}
     + 
     +-	return bisect_next(terms, prefix);
     ++	return bisect_next(terms, prefix, defer_reset);
     + }
     + 
     + static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
      @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
       {
       	int no_checkout = 0;
       	int first_parent_only = 0;
     -+	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
     ++	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
       	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
       	int flags, pathspec_pos;
       	enum bisect_error res = BISECT_OK;
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       			no_checkout = 1;
       		} else if (!strcmp(arg, "--first-parent")) {
       			first_parent_only = 1;
     -+		} else if (!strcmp(arg, "--auto-reset")) {
     -+			auto_reset = AUTO_RESET_ORIGINAL;
     -+		} else if (skip_prefix(arg, "--auto-reset=", &arg)) {
     -+			if (parse_auto_reset(arg, &auto_reset)) {
     ++		} else if (!strcmp(arg, "--reset-when-found")) {
     ++			reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
     ++		} else if (skip_prefix(arg, "--reset-when-found=", &arg)) {
     ++			if (parse_reset_when_found(arg, &reset_when_found)) {
      +				res = BISECT_FAILED;
      +				goto finish;
      +			}
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       			break;
       		}
       	}
     -+	if (auto_reset != AUTO_RESET_NONE && no_checkout) {
     -+		res = error(_("'--auto-reset' cannot be used with '--no-checkout'"));
     ++	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
     ++		res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
      +		goto finish;
      +	}
       	pathspec_pos = i;
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       	if (first_parent_only)
       		write_file(git_path_bisect_first_parent(), "\n");
       
     -+	if (auto_reset != AUTO_RESET_NONE)
     -+		write_file(git_path_bisect_auto_reset(), "%s\n",
     -+			   auto_reset_mode_name(auto_reset));
     ++	if (reset_when_found != RESET_WHEN_FOUND_NONE)
     ++		write_file(git_path_bisect_reset_when_found(), "%s\n",
     ++			   reset_when_found_mode_name(reset_when_found));
      +
       	if (no_checkout) {
       		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
       			res = error(_("invalid ref: '%s'"), start_head.buf);
     +@@ builtin/bisect.c: finish:
     + 	if (res)
     + 		return res;
     + 
     +-	res = bisect_auto_next(terms, NULL);
     ++	res = bisect_auto_next(terms, NULL, false);
     + 	if (!is_bisect_success(res))
     + 		bisect_clean_state();
     + 	return res;
     +@@ builtin/bisect.c: static int bisect_autostart(struct bisect_terms *terms)
     + }
     + 
     + static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
     +-				      const char **argv)
     ++				      const char **argv, bool defer_reset)
     + {
     + 	const char *state;
     + 	int i, verify_expected = 1;
     +@@ builtin/bisect.c: static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
     + 	}
     + 
     + 	oid_array_clear(&revs);
     +-	return bisect_auto_next(terms, NULL);
     ++	return bisect_auto_next(terms, NULL, defer_reset);
     + }
     + 
     + static enum bisect_error bisect_log(void)
     +@@ builtin/bisect.c: static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
     + 	if (res)
     + 		return BISECT_FAILED;
     + 
     +-	return bisect_auto_next(terms, NULL);
     ++	return bisect_auto_next(terms, NULL, false);
     + }
     + 
     + static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
     +@@ builtin/bisect.c: static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
     + 			strvec_push(&argv_state, argv[i]);
     + 		}
     + 	}
     +-	res = bisect_state(terms, argv_state.nr, argv_state.v);
     ++	res = bisect_state(terms, argv_state.nr, argv_state.v, false);
     + 
     + 	strvec_clear(&argv_state);
     + 	return res;
      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
       {
       	int res = BISECT_OK;
       	struct strbuf command = STRBUF_INIT;
     -+	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
     -+	const char *auto_reset_arg;
     ++	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
     ++	const char *reset_when_found_arg;
       	const char *new_state;
       	int temporary_stdout_fd, saved_stdout;
       	int is_first_run = 1;
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       	if (bisect_next_check(terms, NULL))
       		return BISECT_FAILED;
       
     -+	if (argc && !strcmp(argv[0], "--auto-reset"))
     -+		auto_reset = AUTO_RESET_ORIGINAL;
     -+	else if (argc && skip_prefix(argv[0], "--auto-reset=", &auto_reset_arg)) {
     -+		if (parse_auto_reset(auto_reset_arg, &auto_reset))
     ++	if (argc && !strcmp(argv[0], "--reset-when-found"))
     ++		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
     ++	else if (argc && skip_prefix(argv[0], "--reset-when-found=",
     ++				    &reset_when_found_arg)) {
     ++		if (parse_reset_when_found(reset_when_found_arg, &reset_when_found))
      +			return BISECT_FAILED;
      +	}
      +
     -+	if (auto_reset != AUTO_RESET_NONE) {
     ++	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
      +		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
     -+			return error(_("'--auto-reset' cannot be used with '--no-checkout'"));
     -+		write_file(git_path_bisect_auto_reset(), "%s\n",
     -+			   auto_reset_mode_name(auto_reset));
     ++			return error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
     ++		write_file(git_path_bisect_reset_when_found(), "%s\n",
     ++			   reset_when_found_mode_name(reset_when_found));
      +		argc--;
      +		argv++;
      +	}
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       	if (!argc) {
       		error(_("bisect run failed: no command provided."));
       		return BISECT_FAILED;
     +@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     + 		saved_stdout = dup(1);
     + 		dup2(temporary_stdout_fd, 1);
     + 
     +-		res = bisect_state(terms, 1, &new_state);
     ++		res = bisect_state(terms, 1, &new_state, true);
     + 
     + 		fflush(stdout);
     + 		dup2(saved_stdout, 1);
     +@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     + 			res = BISECT_OK;
     + 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
     + 			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
     +-			res = BISECT_OK;
     ++			if (!is_empty_or_missing_file(git_path_bisect_reset_when_found()) &&
     ++			    bisect_reset_when_found(terms))
     ++				res = BISECT_FAILED;
     ++			else
     ++				res = BISECT_OK;
     + 		} else if (res) {
     + 			error(_("bisect run failed: 'git bisect %s'"
     + 				" exited with error code %d"), new_state, res);
     +@@ builtin/bisect.c: static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
     + 		return error(_("'%s' requires 0 arguments"),
     + 			     "git bisect next");
     + 	get_terms(&terms);
     +-	res = bisect_next(&terms, prefix);
     ++	res = bisect_next(&terms, prefix, false);
     + 	free_terms(&terms);
     + 	return res;
     + }
     +@@ builtin/bisect.c: int cmd_bisect(int argc,
     + 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
     + 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
     + 				       options, argv[0]);
     +-		res = bisect_state(&terms, argc, argv);
     ++		res = bisect_state(&terms, argc, argv, false);
     + 		free_terms(&terms);
     + 	} else {
     + 		argc--;
      
       ## t/t6030-bisect-porcelain.sh ##
      @@ t/t6030-bisect-porcelain.sh: test_bisect_usage () {
     @@ t/t6030-bisect-porcelain.sh: test_bisect_usage () {
      +	git bisect bad
      +}
      +
     -+bisect_run_auto_reset () {
     ++bisect_run_reset_when_found () {
      +	write_script test_script.sh <<-\EOF &&
      +	! grep Another hello >/dev/null
      +	EOF
      +	git bisect start $HASH4 $HASH2 &&
      +	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
     -+	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt
     ++	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
     ++	test_bisect_state_missing BISECT_RUN
      +}
      +
     -+test_auto_reset_fails () {
     ++test_reset_when_found_fails () {
      +	local pattern="$1" &&
      +	local state_file="$2" &&
      +	shift 2 &&
     @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case'
       	git bisect reset
       '
       
     -+test_expect_success '"git bisect start --auto-reset" defaults to original' '
     ++test_expect_success '"git bisect start --reset-when-found" defaults to original' '
      +	test_when_finished "git bisect reset; git checkout main" &&
      +	git checkout main &&
     -+	bisect_start_and_finish --auto-reset &&
     ++	bisect_start_and_finish --reset-when-found &&
      +	test "$HASH4" = "$(git rev-parse HEAD)" &&
      +	test main = "$(git branch --show-current)" &&
      +	test_bisect_state_missing BISECT_START &&
      +
     -+	bisect_start_and_finish --auto-reset=original &&
     ++	bisect_start_and_finish --reset-when-found=original &&
      +	test "$HASH4" = "$(git rev-parse HEAD)" &&
      +	test main = "$(git branch --show-current)" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
     -+test_expect_success '"git bisect start --auto-reset=found" leaves first bad checked out' '
     ++test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
      +	test_when_finished "git bisect reset; git checkout main" &&
     -+	bisect_start_and_finish --auto-reset=found &&
     ++	bisect_start_and_finish --reset-when-found=found &&
      +	test "$HASH3" = "$(git rev-parse HEAD)" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
     -+test_expect_success '"git bisect run --auto-reset" defaults to original' '
     ++test_expect_success '"git bisect run --reset-when-found" defaults to original' '
      +	test_when_finished "git bisect reset; git checkout main" &&
     -+	bisect_run_auto_reset --auto-reset &&
     ++	bisect_run_reset_when_found --reset-when-found &&
      +	test "$HASH4" = "$(git rev-parse HEAD)" &&
      +	test main = "$(git branch --show-current)" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
     -+test_expect_success '"git bisect run --auto-reset=found" leaves first bad checked out' '
     ++test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
      +	test_when_finished "git bisect reset; git checkout main" &&
     -+	bisect_run_auto_reset --auto-reset=found &&
     ++	bisect_run_reset_when_found --reset-when-found=found &&
      +	test "$HASH3" = "$(git rev-parse HEAD)" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
     -+test_expect_success '--auto-reset rejects an unknown reset target' '
     ++test_expect_success '--reset-when-found rejects an unknown reset target' '
      +	test_when_finished "git bisect reset; git checkout main" &&
     -+	test_auto_reset_fails \
     -+		"invalid value for.*--auto-reset.*unknown" BISECT_START \
     -+		git bisect start --auto-reset=unknown $HASH4 $HASH2 &&
     ++	test_reset_when_found_fails \
     ++		"invalid value for.*--reset-when-found.*unknown" BISECT_START \
     ++		git bisect start --reset-when-found=unknown $HASH4 $HASH2 &&
      +
      +	git bisect start $HASH4 $HASH2 &&
     -+	test_auto_reset_fails \
     -+		"invalid value for.*--auto-reset.*unknown" BISECT_AUTO_RESET \
     -+		git bisect run --auto-reset=unknown true
     ++	test_reset_when_found_fails \
     ++		"invalid value for.*--reset-when-found.*unknown" \
     ++		BISECT_RESET_WHEN_FOUND \
     ++		git bisect run --reset-when-found=unknown true
      +'
      +
     -+test_expect_success '--auto-reset cannot be used with --no-checkout' '
     ++test_expect_success '--reset-when-found cannot be used with --no-checkout' '
      +	test_when_finished "git bisect reset" &&
     -+	test_auto_reset_fails \
     ++	test_reset_when_found_fails \
      +		"cannot be used with.*--no-checkout" BISECT_START \
     -+		git bisect start --auto-reset=original --no-checkout $HASH4 $HASH2 &&
     ++		git bisect start --reset-when-found=original --no-checkout $HASH4 $HASH2 &&
      +
      +	git bisect start --no-checkout $HASH4 $HASH2 &&
     -+	test_auto_reset_fails \
     -+		"cannot be used with.*--no-checkout" BISECT_AUTO_RESET \
     -+		git bisect run --auto-reset=found true
     ++	test_reset_when_found_fails \
     ++		"cannot be used with.*--no-checkout" BISECT_RESET_WHEN_FOUND \
     ++		git bisect run --reset-when-found=found true
      +'
      +
     -+test_expect_success 'without --auto-reset the bisection state is kept' '
     ++test_expect_success 'without --reset-when-found the bisection state is kept' '
      +	test_when_finished "git bisect reset" &&
      +	git bisect start $HASH4 $HASH2 &&
      +	git bisect bad &&
      +	test_bisect_state_file BISECT_START
      +'
      +
     -+test_expect_success '--auto-reset does not leak into a later bisection' '
     ++test_expect_success '--reset-when-found does not leak into a later bisection' '
      +	test_when_finished "git bisect reset; git checkout main" &&
     -+	bisect_start_and_finish --auto-reset &&
     ++	bisect_start_and_finish --reset-when-found &&
      +
      +	git bisect start $HASH4 $HASH2 &&
      +	git bisect bad &&

-- 
gitgitgadget
