Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692833DD87B
	for <git@vger.kernel.org>; Tue, 26 May 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792499; cv=none; b=oyCptV8yTe1z7y1rvFeTVm6fcv2Qn/Gl/Us+6E2hvqQAUVqsL+ZdMOaVLwAeuZQcWs37lpKf2g+hXJP59hMsFAemGoUde9i+8LqA3zTOwyC5CLQPNQzMYvkCHOIE/jJnsnLlfp88faPEosxo+NYp0ozOnRu+n27r1Kq6HirLWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792499; c=relaxed/simple;
	bh=ow9yrQKQmZ3fQwCjWwLd49onsVd71d+huYfC60yOxM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKox/uBBImTpEHewJ3BwEifZM/FbASjkvZbGzO2qi6qEFEFy9H1eGzuhLGq6Iw3R1jZvbrSZUHkuw7btLbtHEzHR5y6+ZzkTnjaNt1jLdvVQx+3R3F9odMyCjzw8DHL7zaHxPorZX6y1N7yyEHPj2oUKb5pFxKT4BP5YQQ9bBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok4sXCWk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok4sXCWk"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7d983f91so93360591fa.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792481; x=1780397281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBehkgU6dXFhi1F9TLMDBM7IO06ef7H5b2EPzrQL9io=;
        b=Ok4sXCWkWJ/T/zieJODlVF4GCQ1fLBxqVU3tsj2EUh1fc8Oo5Vc19H/+23hNXO+6VH
         Exh0cMK67oVZ5JyXwFnhQ/H10nmbvxR1L7JgiJDJ4SO5Ta/PQboB4CFnSOm1UM8AFTa3
         LxcU3khWmsW2h/duYKUypvQnzY/F2tUMhGyaCEJfZCFwpk6pS4l9yFLdb7DWeHiwHbB6
         Dl/AV4pBNZWFtKyi0hXquJjdPspV1QHRAsz7ZAGe3WAP4suUFxJaZkXSz3PDI911DnK7
         zKnRQm87eHxHKZZNIKIwP/AXJP4/GtOCPLNlUCTUuSdMuZCHWaGCusWpSAsMIY6vfCru
         SxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792481; x=1780397281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBehkgU6dXFhi1F9TLMDBM7IO06ef7H5b2EPzrQL9io=;
        b=ascEnlOSDVzbtH3ftxCO/9P7cUsy/IU7/sM5eH1M1ucN0gboJ1fho6dqwkScg44bWh
         4yzic4CzPNGbkzV9/hx187QZI/0P9hD3Dt6Fg1WQFePxaWBpa/AYwnkc6jZ1JEete2xW
         6rdDYO8pnHa+2zyXmP/J28JZ4ypofp2yyMIl/USPXddT7ZMoBgPk9YPa4nFMm3/LxVg7
         a4oXv1dSnvAwHqkEq4EjEsLFy6EGSmOqxIhkkyWh/E0aMKoCid3KJq1mf0MtPrzdu/i9
         nogp46feiE+IcRFWUPJVuYQN6LURKszI+8V0nnj6SPqt7F/paaOKEtQVBlPPrH7taJ1b
         sqOg==
X-Gm-Message-State: AOJu0YyIs/fgsI2r3zbFchF3o7dh0f/cdnqVtRcDsd2N0GfRG7cjiupb
	lFJrGjFdLdK2KUUf4W9zJgeaWsXfXnDdncW5zuIjmp/vkrHi3k9NQlf8ZshkbQ==
X-Gm-Gg: Acq92OEA/LrBYs9NPHYOfGB69Y9/nhyZfWRhfPzblyNURfxwU24qIfnUTiS0ASFknmG
	Kqwwoy9xNCzGlEbXSJAFYg7No7lg9y/1lnPh3i3nBG2JNfZHtTbPXsFSm8lAkiahZFtx9HEHB8s
	RtImZ/uVgUTGsQA7+sOJrFqDRbGeYZL/SdY+AnE617ZPHUUKz7SXy94HP6qSwAfXrWL3z1Jc2bj
	buJMfGadOeI9fVwPaHMnNhaDq+kCZXHkJh8bzBI5M40TUlHUrNOroWXl1w6nDJGiraH+NN21RjA
	ONdxsmBsxMnyr39u/F25/oAdc6ZMy2mW7Zrp1hmjW2PCqeXOMUlx332lEBIIbAV0EgvAJrUc1Hw
	VtMhajY936g4H9JSeueGf401hmdcbw/0NkRnwtkeLJClswFqv8qsVnxtbNfrP/Cx8XMBnX8pFnd
	Ex4j2n1cf7cIP/65x2Bnw7866nEk4sfii5BmTnT9cb5jd1IFTFFChTFX7XIxUr3MNblRBYJH6+Y
	1DjXTJS5DtWfPaV2uWh1po/7PECL3WJfxAxOxbx99Bk6ZfZnsGFpTPgaXUXxUwx
X-Received: by 2002:a05:651c:154d:b0:393:7987:5862 with SMTP id 38308e7fff4ca-395d8cd94b9mr58785571fa.19.1779792480858;
        Tue, 26 May 2026 03:48:00 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:954c:d0e6:555c:211f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcaa226fsm26964061fa.18.2026.05.26.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:48:00 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v2 0/2] commit: allow -m/-F/-c/-C for all --fixup variations
Date: Tue, 26 May 2026 12:47:42 +0200
Message-ID: <cover.1779792311.git.erik@cervined.in>
X-Mailer: git-send-email 2.54.0.1014.g842965a2d5
In-Reply-To: <20260518112225.73172-2-erik@cervined.in>
References: <20260518112225.73172-2-erik@cervined.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

V1 was a single patch and only addressed -m/-F.  V2 makes two
substantive changes.

First, the refactor.  V1 added a special-cased file slurp in
cmd_commit() that pretended -F had been spelled -m.  Junio noted
this loses the "this came from a file" origin if anything goes
wrong later in the control flow [1], and Phillip suggested
refactoring prepare_to_commit() [2].  V2 does that: prepare_to_commit()
now consults fixup_message at each message-source branch and routes the
message origin flags through the same code path for all --fixup
variations.

Second, scope extended to -c/-C.  In the V1 thread I noted [3]
that -F made sense across all --fixup variants for consistency,
but that -c/-C felt "probably less justifiable" for plain --fixup.
Looking at it more while refactoring, the existing patchwork of
which flag works with which variant looked less and less like a
design and more like an accident -- once -F was threaded through
prepare_to_commit(), -c/-C fell out of the same path naturally
(blocked by the same die_for_incompatible_opt4() grouping that
caught -F).  This lives in its own patch (2/2) -- I won't object
if reviewers prefer to drop it or rolling it separately.

There is one wrinkle worth flagging on 2/2.  When -c/-C names a
source commit whose message starts with "amend! ",
prepare_amend_commit() strips that line -- the same stripping that
happens for a no-source --fixup=amend:<commit>.  This is independent
of which --fixup variant is being produced (the target); it depends
only on whether the -c/-C source is itself an amend!/reword! commit.
The upside is that

    git commit --fixup=amend:foo -C foo

and

    GIT_EDITOR=: git commit --fixup=amend:foo

produce the same commit.  If reviewers would rather -c/-C take the
source message verbatim, that's a small change and I'm open to it.

Smaller fixes from V1 review:

  * "unusable" softened to "poorly suited" in the rationale [1].

  * Dropped the incorrect claim that plain --fixup -m is
    "practically a no-op"

  * Adopted Phillip's suggestion to use test_commit_message in the
    new --fixup=amend: -m test, which also resolves the
    expected/expect golden-file naming Junio called out [1][2].

[1] https://lore.kernel.org/git/xmqqik8kc2nj.fsf@gitster.g/
[2] https://lore.kernel.org/git/ac6aaaca-2b7c-4892-ba93-0dc3e3c18ff7@gmail.com/
[3] https://lore.kernel.org/git/aguM7UIbAo19Zojv@mbp/

Erik Cervin-Edin (2):
  commit: allow -m/-F for all kinds of --fixup
  commit: allow -c/-C for all kinds of --fixup

 Documentation/git-commit.adoc             |  22 +++--
 builtin/commit.c                          |  41 ++++----
 t/t7500-commit-template-squash-signoff.sh | 114 +++++++++++++++++++---
 3 files changed, 133 insertions(+), 44 deletions(-)

Range-diff against v1:
1:  49e202f04b ! 1:  e9f07d49ee commit: allow -m/-F with --fixup=amend: or reword:
    @@ Metadata
     Author: Erik Cervin-Edin <erik@cervined.in>
     
      ## Commit message ##
    -    commit: allow -m/-F with --fixup=amend: or reword:
    +    commit: allow -m/-F for all kinds of --fixup
     
    -    commit: allow -m/-F with --fixup=amend: or reword:
    +    The ability to provide a commit message for git commit --fixup and its
    +    variations is limited:
     
    -    --fixup=amend: and --fixup=reword: require an editor to supply the
    -    replacement commit message. The -m and -F flags are rejected: -m is
    -    caught by a die() in prepare_to_commit(), and -F is caught by
    +      * Plain --fixup only allows using the -m flag
    +
    +      * The amend/reword --fixup variants only allow supplying the message
    +        using an editor
    +
    +    For amend/reword, the -m and -F flags are rejected: -m is caught by a
    +    die() in prepare_to_commit(), and -F is caught by
         die_for_incompatible_opt4() which groups -F with --fixup as mutually
    -    exclusive. This makes these modes unusable in non-interactive
    -    workflows -- notably AI coding agents.
    +    exclusive.  This makes these modes poorly suited for non-interactive
    +    workflows -- notably when using AI coding agents.
    +
    +    When support to use the -m option was introduced in [1] it was noted
    +    that there could be support for other options but at the time the use
    +    case was deemed too niche.  Later, when the amend suboption was
    +    introduced in [2] -m support for amend fixups was discussed but not
    +    pursued, and -F was already caught by the higher-layer incompatibility
    +    check grouping it with --fixup.
    +
    +    The rejections of these options hark back to when --fixup was
    +    introduced in [3] and as noted in [1] -- there's nothing inherently
    +    preventing support for them.  The current patchwork of which flags
    +    work with which --fixup variants has no strong logic to it, and
    +    allowing all of them simplifies both the code and the interface.
     
    -    When the amend suboption was introduced in 494d314a05 (commit: add
    -    amend suboption to --fixup to create amend! commit, 2021-03-15),
    -    -m support for amend fixups was discussed but not pursued, and -F
    -    was already caught by the higher-layer incompatibility check grouping
    -    it with --fixup.
    +    Allow -m and -F to supply the message body for all --fixup variations,
    +    mirroring the flow of a regular commit.  -c and -C, which are blocked
    +    by the same incompatibility check, are handled in the next commit.
     
    -    Allow -m and -F to supply the replacement message body for amend and
    -    reword fixups. When provided, bypass the editor and directly use the
    -    user's message as the body, replacing the original commit's message. For
    -    -F, the file contents are read into the message strbuf and then handled
    -    identically to -m.
    +    1. 30884c9afc (commit: add support for --fixup <commit> -m"<extra
    +       message>", 2017-12-22)
     
    -    Plain --fixup (without amend: or reword:) continues to reject -F but
    -    still accepts -m (even though it's practically a no-op).
    +    2. 494d314a05 (commit: add amend suboption to --fixup to create amend!
    +       commit, 2021-03-15)
     
    -    Signed-off-by: Erik Cervin Edin <erik@cervined.in>
    +    3. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
    +       2010-11-02)
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
    +    Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
     
      ## Documentation/git-commit.adoc ##
    -@@ Documentation/git-commit.adoc: commit, but the additional commentary will be thrown away once the
    +@@ Documentation/git-commit.adoc: include::diff-context-options.adoc[]
    + The commit created by plain `--fixup=<commit>` has a title
    + composed of "fixup!" followed by the title of _<commit>_,
    + and is recognized specially by `git rebase --autosquash`. The `-m`
    +-option may be used to supplement the log message of the created
    +-commit, but the additional commentary will be thrown away once the
    +-"fixup!" commit is squashed into _<commit>_ by
    ++or `-F` option may be used to supplement the log message
    ++of the created commit, but the additional commentary will be thrown
    ++away once the "fixup!" commit is squashed into _<commit>_ by
    + `git rebase --autosquash`.
    + +
      The commit created by `--fixup=amend:<commit>` is similar but its
      title is instead prefixed with "amend!". The log message of
      _<commit>_ is copied into the log message of the "amend!" commit and
    @@ Documentation/git-commit.adoc: commit, but the additional commentary will be thr
     -log message to be empty unless `--allow-empty-message` is
     -specified.
     +opened in an editor so it can be refined. The replacement message may
    -+also be supplied directly using `-m` or `-F`, bypassing the need to open
    -+an editor. When `git rebase --autosquash` squashes the "amend!" commit
    -+into _<commit>_, the log message of _<commit>_ is replaced by the
    -+refined log message from the "amend!" commit. It is an error for the
    -+"amend!" commit's log message to be empty unless `--allow-empty-message`
    -+is specified.
    ++also be supplied directly using `-m` or `-F`, bypassing the
    ++need to open an editor. When `git rebase
    ++--autosquash` squashes the "amend!" commit into _<commit>_, the log
    ++message of _<commit>_ is replaced by the refined log message from the
    ++"amend!" commit. It is an error for the "amend!" commit's log message
    ++to be empty unless `--allow-empty-message` is specified.
      +
      `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
       --only`. It creates an "amend!" commit with only a log message
     
      ## builtin/commit.c ##
    +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    + 	if (have_option_m && !fixup_message) {
    + 		strbuf_addbuf(&sb, &message);
    + 		hook_arg1 = "message";
    +-	} else if (logfile && !strcmp(logfile, "-")) {
    ++	} else if (logfile && !fixup_message && !strcmp(logfile, "-")) {
    + 		if (isatty(0))
    + 			fprintf(stderr, _("(reading log message from standard input)\n"));
    + 		if (strbuf_read(&sb, 0, 0) < 0)
    + 			die_errno(_("could not read log from standard input"));
    + 		hook_arg1 = "message";
    +-	} else if (logfile) {
    ++	} else if (logfile && !fixup_message) {
    + 		if (strbuf_read_file(&sb, logfile, 0) < 0)
    + 			die_errno(_("could not read log file '%s'"),
    + 				  logfile);
    + 		hook_arg1 = "message";
    +-	} else if (use_message) {
    ++	} else if (use_message && !fixup_message) {
    + 		const char *buffer;
    + 		buffer = strstr(use_message_buffer, "\n\n");
    + 		if (buffer)
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
      		hook_arg1 = "message";
      
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
     -		 * incompatible with all the forms of `--fixup` and
     -		 * have already errored out while parsing the `git commit`
     -		 * options.
    -+		 * `-m` (and `-F`, converted to `-m` earlier for
    -+		 * amend/reword) appends the message body here.
    -+		 * `-c`/`-C` are still incompatible with all forms
    -+		 * of `--fixup`.
    ++		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
    ++		 * incompatible with --fixup and have already errored out
    ++		 * during option parsing.
      		 */
    - 		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
    +-		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
    ++		if (have_option_m) {
      			strbuf_addbuf(&sb, &message);
    - 
    - 		if (!strcmp(fixup_prefix, "amend")) {
    - 			if (have_option_m)
    +-
    +-		if (!strcmp(fixup_prefix, "amend")) {
    +-			if (have_option_m)
     -				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
    --			prepare_amend_commit(commit, &sb, &ctx);
    -+				strbuf_addbuf(&sb, &message);
    -+			else
    -+				prepare_amend_commit(commit, &sb, &ctx);
    ++		} else if (logfile && !strcmp(logfile, "-")) {
    ++			if (isatty(0))
    ++				fprintf(stderr, _("(reading log message from standard input)\n"));
    ++			if (strbuf_read(&sb, 0, 0) < 0)
    ++				die_errno(_("could not read log from standard input"));
    ++		} else if (logfile) {
    ++			if (strbuf_read_file(&sb, logfile, 0) < 0)
    ++				die_errno(_("could not read log file '%s'"), logfile);
    ++		} else if (!strcmp(fixup_prefix, "amend")) {
    + 			prepare_amend_commit(commit, &sb, &ctx);
      		}
      	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
    - 		size_t merge_msg_start;
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
      	}
      	if (fixup_message && squash_message)
    @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      				  !!edit_message, "-c",
     -				  !!logfile, "-F",
      				  !!fixup_message, "--fixup");
    -+	die_for_incompatible_opt3(!!use_message, "-C",
    -+				  !!edit_message, "-c",
    -+				  !!logfile, "-F");
      	die_for_incompatible_opt4(have_option_m, "-m",
      				  !!edit_message, "-c",
    - 				  !!use_message, "-C",
    -@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    - 		}
    - 	}
    - 
    -+	if (logfile && fixup_message && !strcmp(fixup_prefix, "fixup"))
    -+		die(_("options '%s' and '%s' cannot be used together"), "-F", "--fixup");
    -+
    - 	if (0 <= edit_flag)
    - 		use_editor = edit_flag;
    - 
    -@@ builtin/commit.c: int cmd_commit(int argc,
    - 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
    - 					  builtin_commit_usage,
    - 					  prefix, current_head, &s);
    -+
    -+	if (logfile && fixup_message && !strcmp(fixup_prefix, "amend")) {
    -+		if (!strcmp(logfile, "-")) {
    -+			if (isatty(0))
    -+				fprintf(stderr, _("(reading log message from standard input)\n"));
    -+			if (strbuf_read(&message, 0, 0) < 0)
    -+				die_errno(_("could not read log from standard input"));
    -+		} else {
    -+			if (strbuf_read_file(&message, logfile, 0) < 0)
    -+				die_errno(_("could not read log file '%s'"), logfile);
    -+		}
    -+		strbuf_complete_line(&message);
    -+		have_option_m = 1;
    -+		FREE_AND_NULL(logfile);
    -+	}
    -+
    - 	if (trailer_args.nr)
    - 		trailer_config_init();
    - 
     
      ## t/t7500-commit-template-squash-signoff.sh ##
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword: ignores staged changes' '
    @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword:
      '
      
     -test_expect_success '--fixup=reword: error out with -m option' '
    -+test_expect_success '--fixup=amend: with -m option' '
    ++test_expect_success 'commit --fixup=reword: works with -m' '
      	commit_for_rebase_autosquash_setup &&
     -	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
     -	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
    -+	cat >expect <<-EOF &&
    -+	amend! $(git log -1 --format=%s HEAD~)
    +-	test_cmp expect actual
    ++	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
    ++	test_commit_message HEAD <<-EOF
    ++	amend! $(git log -1 --format=%s HEAD~2)
     +
    -+	amend commit message
    ++	reword commit message
     +	EOF
    -+	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
    -+	get_commit_msg HEAD >actual &&
    - 	test_cmp expect actual
      '
      
     -test_expect_success '--fixup=amend: error out with -m option' '
    -+test_expect_success '--fixup=reword: with -m option' '
    ++test_expect_success 'commit --fixup=amend: works with -m' '
      	commit_for_rebase_autosquash_setup &&
     -	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
     -	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
    -+	cat >expect <<-EOF &&
    -+	amend! $(git log -1 --format=%s HEAD~)
    +-	test_cmp expect actual
    ++	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
    ++	test_commit_message HEAD <<-EOF
    ++	amend! $(git log -1 --format=%s HEAD~2)
     +
    -+	reword commit message
    ++	amend commit message
     +	EOF
    -+	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
    -+	get_commit_msg HEAD >actual &&
    - 	test_cmp expect actual
      '
      
    + test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'deny to create amend! commit if its commit msg body is empt
      	test_cmp expected actual
      '
      
    -+test_expect_success '--fixup=amend: -m with empty message aborts' '
    ++test_expect_success 'deny to create amend! commit if -m is empty' '
     +	commit_for_rebase_autosquash_setup &&
    -+	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>err &&
    -+	test_grep "empty commit message body" err
    ++	echo "Aborting commit due to empty commit message body." >expect &&
    ++	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>actual &&
    ++	test_cmp expect actual
     +'
     +
      test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
    @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success '--fixup=reword:
     -test_expect_success '--fixup=reword: -F give error message' '
     -	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
     -	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
    -+test_expect_success '--fixup=reword: with -F option' '
    -+	commit_for_rebase_autosquash_setup &&
    -+	echo "message from file" >msgfile &&
    -+	cat >expect <<-EOF &&
    -+	amend! $(git log -1 --format=%s HEAD~)
    -+
    -+	message from file
    -+	EOF
    -+	git commit --fixup=reword:HEAD~ -F msgfile &&
    -+	get_commit_msg HEAD >actual &&
    - 	test_cmp expect actual
    - '
    - 
    -+test_expect_success '--fixup=amend: with -F option' '
    +-	test_cmp expect actual
    ++test_expect_success 'commit --fixup works with -F' '
     +	commit_for_rebase_autosquash_setup &&
    -+	echo "amend message from file" >msgfile &&
    -+	cat >expect <<-EOF &&
    -+	amend! $(git log -1 --format=%s HEAD~)
    ++	echo "message" >msgfile &&
    ++	git commit --fixup HEAD~ -F msgfile &&
    ++	test_commit_message HEAD <<-EOF
    ++	fixup! $(git log -1 --format=%s HEAD~2)
     +
    -+	amend message from file
    ++	message
     +	EOF
    -+	git commit --fixup=amend:HEAD~ -F msgfile &&
    -+	get_commit_msg HEAD >actual &&
    -+	test_cmp expect actual
     +'
     +
    -+test_expect_success '-F with plain --fixup still errors' '
    ++test_expect_success 'commit --fixup=reword: works with -F' '
     +	commit_for_rebase_autosquash_setup &&
    -+	echo "message" >msgfile &&
    -+	test_must_fail git commit --fixup HEAD~ -F msgfile 2>err &&
    -+	test_grep "cannot be used together" err
    -+'
    ++	echo "message from file" >msgfile &&
    ++	git commit --fixup=reword:HEAD~ -F msgfile &&
    ++	test_commit_message HEAD <<-EOF
    ++	amend! $(git log -1 --format=%s HEAD~2)
     +
    ++	$(cat msgfile)
    ++	EOF
    + '
    + 
      test_expect_success 'commit --squash works with -F' '
    - 	commit_for_rebase_autosquash_setup &&
    - 	echo "log message from file" >msgfile &&
    +@@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'invalid message options when using --fixup' '
    + 	git add foo &&
    + 	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
    + 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
    +-	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
    +-	test_must_fail git commit --fixup HEAD~1 -F log
    ++	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
    + '
    + 
    + cat >expected-template <<EOF
-:  ---------- > 2:  b3fc743abf commit: allow -c/-C for all kinds of --fixup

base-commit: 208068f2d8ae29d7edaa245d9975b1b22ec65738
-- 
2.54.0.1014.g842965a2d5

