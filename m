Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDA31F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfKFPv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfKFPvY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id v3so2658480wmh.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x+dJWgV2gzFgesdskQOFInhRtgwvg2QkOU6Lonz44Nc=;
        b=HRd7Dyz62LkuVLdKe77DSVn47OeBL7tIpNf68u1ogR2QfgUyJn4T6qno7N5I2zZFkW
         2DodLBhx8yeLEEj7jcb5sa0Cb+Qq3fWXtIRHckvDQZ/IgCEJmtLrF/387fshz9Esn8Oh
         zHFPFfYeRIPH/CV48pDh8pDFvT1OF3/drdn0LMlALhaDvlE/glnP07qLdXmyiAakn030
         Q0xCCermWZdIzpZNmeMguXNFbT/WF5QFy7gN1Xa0aBTis0fGNUFgYsFPpznAc6t0BGDK
         mUZKzt44ooWiKhsjKaHSt++8e2/xQXGhLsBBOHEF51ocet2K0PQgB0rGP0NAiIUi48+A
         cM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x+dJWgV2gzFgesdskQOFInhRtgwvg2QkOU6Lonz44Nc=;
        b=smnHcxaxHIQbBudqk4vNVCINwfGT2UoFEP5Xz4EFOjg3ZWHpehoBbRWGls72WbDP/9
         Q+9cevzqnV/yGdt4BaR/lKMWEuv4XhUN11FugfQz7QQqBXMmkl7oE1qxal4ilo5FmAGy
         9U9r+3expReSZhJsXIqvnlqdBTEkTIRvjeqi+KnkEa6AX2+Zll1ntvEKwVgE62jCP+zB
         ec9Tc4c6ViINKTQbfK2+nDZ8G5GJf+3D8dlgBGf1gbBA4BeIOf2TLuR/pwtBPjDWHgAe
         d1gfLHhJRshWiwQil4z0JPIRDgj9FUq2MiJ+ncVF1wwkmWuxQkJfgTOx+6Fz2hi+G36r
         gwNg==
X-Gm-Message-State: APjAAAU2kRZcXtRP9uZRrqXqZ8qatS/m37Km61jl9JlNZ9IbZO724+OX
        IeCvElDRxtulAZrPujiJJYSIKdGB
X-Google-Smtp-Source: APXvYqx8j7slqQZquEIRBk3f765yanr//3byz6sV5nshPdn5rOV+2B3X4XDJzQeBrxqGjQtEL8jP0w==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr2975807wmd.160.1573055479745;
        Wed, 06 Nov 2019 07:51:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm12308125wro.76.2019.11.06.07.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:19 -0800 (PST)
Message-Id: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:12 +0000
Subject: [PATCH v2 0/6] Add --pathspec-from-file option for reset, commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds --pathspec-from-file option for porcelain commands to avoid commandline
length limit.

So far I implemented it for git commit and git reset, but my goal is to
support other commands as well after these patches are reviewed.

The patches are based on the following discussions:
https://public-inbox.org/git/c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com/T/#u
There, --stdin-paths was suggested.
https://public-inbox.org/git/a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com/T/#u
There, --stdin-paths was extended to --paths-file.
https://public-inbox.org/git/pull.133.git.gitgitgadget@gmail.com/
https://github.com/gitgitgadget/git/pull/133Patch from Johannes, I used it
as base of my patch. There, --pathspec-from-file is suggested in discussion.

Major changes compared to patch from Johannes:

1) --pathspec-from-file allows to read file, not just stdin

2) --literal-pathspecs should be honored. This is a good improvement because
it keeps --pathspec-from-file much closer to passing args on commandline.
Since the goal of the new option is to avoid commandline length limit, both
behaviors should be close to each other.

3) Patches are designed with all other git commands in mind

Changes from V1: A lot of small changes here and there, in accordance with
review suggestions.

Alexandr Miloslavskiy (6):
  parse-options.h: add new options `--pathspec-from-file`,
    `--pathspec-file-nul`
  pathspec: add new function to parse file
  doc: reset: unify <pathspec> description
  reset: support the `--pathspec-from-file` option
  doc: commit: unify <pathspec> description
  commit: support the --pathspec-from-file option

 Documentation/git-commit.txt    |  29 ++++--
 Documentation/git-reset.txt     |  37 +++++---
 builtin/commit.c                |  25 +++++-
 builtin/reset.c                 |  25 +++++-
 parse-options.h                 |   2 +
 pathspec.c                      |  38 ++++++++
 pathspec.h                      |  10 +++
 t/t7107-reset-pathspec-file.sh  | 155 ++++++++++++++++++++++++++++++++
 t/t7526-commit-pathspec-file.sh | 130 +++++++++++++++++++++++++++
 9 files changed, 425 insertions(+), 26 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh
 create mode 100755 t/t7526-commit-pathspec-file.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-445%2FSyntevoAlex%2F%230207_pathspec_from_file-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-445/SyntevoAlex/#0207_pathspec_from_file-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/445

Range-diff vs v1:

 -:  ---------- > 1:  2dfaccf0d5 parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`
 1:  52e7a84a2e ! 2:  96697ba072 pathspec: add new function to parse file
     @@ -50,16 +50,13 @@
      +	if (!strcmp(file, "-"))
      +		in = stdin;
      +	else
     -+		in = fopen(file, "r");
     -+
     -+	if (!in)
     -+		die(_("could not open '%s' for reading"), file);
     ++		in = xfopen(file, "r");
      +
      +	while (getline_fn(&buf, in) != EOF) {
      +		if (!nul_term_line && buf.buf[0] == '"') {
      +			strbuf_reset(&unquoted);
      +			if (unquote_c_style(&unquoted, buf.buf, NULL))
     -+				die(_("line is badly quoted"));
     ++				die(_("line is badly quoted: %s"), buf.buf);
      +			strbuf_swap(&buf, &unquoted);
      +		}
      +		argv_array_push(&parsed_file, buf.buf);
     @@ -91,11 +88,11 @@
      + * When 'file' is exactly "-" it uses 'stdin' instead.
      + */
      +void parse_pathspec_file(struct pathspec *pathspec,
     -+		    unsigned magic_mask,
     -+		    unsigned flags,
     -+		    const char *prefix,
     -+		    const char *file,
     -+		    int nul_term_line);
     ++			 unsigned magic_mask,
     ++			 unsigned flags,
     ++			 const char *prefix,
     ++			 const char *file,
     ++			 int nul_term_line);
       void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
       void clear_pathspec(struct pathspec *);
       
 2:  1740ac7a29 ! 3:  f961a5155a doc: reset: unify <pathspec> description
     @@ -21,8 +21,11 @@
       
       DESCRIPTION
      @@
     + In the third form, set the current branch head (`HEAD`) to `<commit>`,
       optionally modifying index and working tree to match.
       The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
     ++The <pathspec> is used to limit the paths affected by the operation
     ++(see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
       
      -'git reset' [-q] [<tree-ish>] [--] <paths>...::
      -	This form resets the index entries for all `<paths>` to their
     @@ -34,14 +37,11 @@
      -This means that `git reset <paths>` is the opposite of `git add
      -<paths>`. This command is equivalent to
      -`git restore [--source=<tree-ish>] --staged <paths>...`.
     -+For more details about the <pathspec> syntax, see the 'pathspec' entry
     -+in linkgit:gitglossary[7].
     - +
     --After running `git reset <paths>` to update the index entry, you can
      +This means that `git reset <pathspec>` is the opposite of `git add
      +<pathspec>`. This command is equivalent to
      +`git restore [--source=<tree-ish>] --staged <pathspec>...`.
     -++
     + +
     +-After running `git reset <paths>` to update the index entry, you can
      +After running `git reset <pathspec>` to update the index entry, you can
       use linkgit:git-restore[1] to check the contents out of the index to
       the working tree. Alternatively, using linkgit:git-restore[1]
     @@ -54,10 +54,18 @@
       	Interactively select hunks in the difference between the index
       	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
       	in reverse to the index.
     - +
     -+For more details about the <pathspec> syntax, see the 'pathspec' entry
     -+in linkgit:gitglossary[7].
     -++
     - This means that `git reset -p` is the opposite of `git add -p`, i.e.
     - you can use it to selectively reset hunks. See the ``Interactive Mode''
     - section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
     +
     + diff --git a/builtin/reset.c b/builtin/reset.c
     + --- a/builtin/reset.c
     + +++ b/builtin/reset.c
     +@@
     + 
     + static const char * const git_reset_usage[] = {
     + 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
     +-	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
     +-	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
     ++	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
     ++	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
     + 	NULL
     + };
     + 
 3:  8d9f1fbc18 ! 4:  d72d4f16b5 reset: support the --pathspec-from-file option
     @@ -1,33 +1,13 @@
      Author: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     -    reset: support the --pathspec-from-file option
     -
     -    This option solves the problem of commandline length limit for UI's
     -    built on top of git. Plumbing commands are not always a good fit, for
     -    two major reasons:
     -    1) Some UI's serve as assistants that help user run git commands. In
     -       this case, replacing familiar commands with plumbing commands will
     -       confuse most users.
     -    2) Some UI's have started and grown with porcelain commands. Replacing
     -       existing logic with plumbing commands could be cumbersome and prone
     -       to various new problems.
     -
     -    The new option is designed to behave very close to pathspecs passed in
     -    commandline args, so that switching from one to another is simple.
     -
     -    The new option allows to read either a specified file or `stdin`.
     -    Reading from file is a good way to avoid competing for stdin, and
     -    also gives some extra flexibility.
     +    reset: support the `--pathspec-from-file` option
      
          Decisions taken for simplicity:
     -    1) The new option is declared incompatible with other options that
     -       could use `stdin`.
     -    2) It is not allowed to pass some refspecs in args and others in file.
     -    3) New options do not have shorthands to avoid shorthand conflicts.
     -
     -    Also add new '--pathspec-file-null' switch that mirrors '-z' used in
     -    various places. Some porcelain commands, such as `git commit`, already
     -    use '-z', therefore it needed a new unambiguous name.
     +    1) For now, `--pathspec-from-file` is declared incompatible with
     +       `--patch`, even when <file> is not `stdin`. Such use case it not
     +       really expected. Also, it is harder to support in `git commit`, so
     +       I decided to make it incompatible in all places.
     +    2) It is not allowed to pass pathspec in both args and file.
      
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
     @@ -39,7 +19,7 @@
       --------
       [verse]
       'git reset' [-q] [<tree-ish>] [--] <pathspec>...
     -+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]
     ++'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
       'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
       'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
       
     @@ -51,11 +31,13 @@
      +In the last form, set the current branch head (`HEAD`) to `<commit>`,
       optionally modifying index and working tree to match.
       The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
     + The <pathspec> is used to limit the paths affected by the operation
     + (see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
       
       'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
      -	This form resets the index entries for all `<pathspec>` to their
     -+'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-null]] [<tree-ish>]::
     -+	These forms reset the index entries for all `<pathspec>` to their
     ++'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
     ++	These forms reset the index entries matching pathspec to their
       	state at `<tree-ish>`.  (It does not affect the working tree or
       	the current branch.)
       +
     @@ -64,14 +46,15 @@
       	override the default behavior.
       
      +--pathspec-from-file=<file>::
     -+	Read `<pathspec>` from `<file>` instead. If `<file>` is exactly `-`
     -+	then read from standard input. Pathspecs are separated by LF or
     -+	CR/LF. Pathspecs can be quoted as explained for the configuration
     -+	variable `core.quotePath` (see linkgit:git-config[1]). See also
     -+	`--pathspec-file-null` and global `--literal-pathspecs`.
     -+
     -+--pathspec-file-null::
     -+	Only meaningful with `--pathspec-from-file`. Pathspecs are
     ++	Pathspec is passed in `<file>` instead of commandline args. If
     ++	`<file>` is exactly `-` then standard input is used. Pathspec
     ++	elements are separated by LF or CR/LF. Pathspec elements can be
     ++	quoted as explained for the configuration variable `core.quotePath`
     ++	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
     ++	global `--literal-pathspecs`.
     ++
     ++--pathspec-file-nul::
     ++	Only meaningful with `--pathspec-from-file`. Pathspec elements are
      +	separated with NUL character and are not expected to be quoted.
       
       EXAMPLES
     @@ -83,9 +66,9 @@
      @@
       static const char * const git_reset_usage[] = {
       	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
     - 	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
     -+	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-null]] [<tree-ish>]"),
     - 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
     + 	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
     ++	N_("git reset [-q] [--pathspec-from-file [--pathspec-file-nul]] [<tree-ish>]"),
     + 	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
       	NULL
       };
      @@
     @@ -94,7 +77,7 @@
       	int reset_type = NONE, update_ref_status = 0, quiet = 0;
      -	int patch_mode = 0, unborn;
      -	const char *rev;
     -+	int patch_mode = 0, pathspec_file_null = 0, unborn;
     ++	int patch_mode = 0, pathspec_file_nul = 0, unborn;
      +	const char *rev, *pathspec_from_file = NULL;
       	struct object_id oid;
       	struct pathspec pathspec;
     @@ -103,10 +86,8 @@
       		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
       		OPT_BOOL('N', "intent-to-add", &intent_to_add,
       				N_("record only the fact that removed paths will be added later")),
     -+		OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file,
     -+				N_("read pathspecs from file")),
     -+		OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null,
     -+				N_("with --pathspec-from-file, pathspecs are separated with NUL character")),
     ++		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
     ++		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
       		OPT_END()
       	};
       
     @@ -119,13 +100,14 @@
      +			die(_("--pathspec-from-file is incompatible with --patch"));
      +
      +		if (pathspec.nr)
     -+			die(_("--pathspec-from-file is incompatible with path arguments"));
     ++			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
      +
      +		parse_pathspec_file(&pathspec, 0,
      +				    PATHSPEC_PREFER_FULL,
     -+				    prefix, pathspec_from_file, pathspec_file_null);
     -+	} else if (pathspec_file_null)
     -+		die(_("--pathspec-file-null requires --pathspec-from-file"));
     ++				    prefix, pathspec_from_file, pathspec_file_nul);
     ++	} else if (pathspec_file_nul) {
     ++		die(_("--pathspec-file-nul requires --pathspec-from-file"));
     ++	}
      +
       	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
       	if (unborn) {
     @@ -142,21 +124,7 @@
      +
      +. ./test-lib.sh
      +
     -+cat > expect.a <<EOF
     -+ D fileA.t
     -+EOF
     -+
     -+cat > expect.ab <<EOF
     -+ D fileA.t
     -+ D fileB.t
     -+EOF
     -+
     -+cat > expect.a_bc_d <<EOF
     -+D  fileA.t
     -+ D fileB.t
     -+ D fileC.t
     -+D  fileD.t
     -+EOF
     ++test_tick
      +
      +test_expect_success setup '
      +	echo A >fileA.t &&
     @@ -165,16 +133,16 @@
      +	echo D >fileD.t &&
      +	git add . &&
      +	git commit --include . -m "Commit" &&
     -+	checkpoint=$(git rev-parse --verify HEAD)
     ++	git tag checkpoint
      +'
      +
      +restore_checkpoint () {
     -+	git reset --hard "$checkpoint"
     ++	git reset --hard checkpoint
      +}
      +
     -+verify_state () {
     ++verify_expect () {
      +	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
     -+	test_cmp "$1" actual
     ++	test_cmp expect actual
      +}
      +
      +test_expect_success '--pathspec-from-file from stdin' '
     @@ -183,7 +151,10 @@
      +	git rm fileA.t &&
      +	echo fileA.t | git reset --pathspec-from-file=- &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success '--pathspec-from-file from file' '
     @@ -193,34 +164,62 @@
      +	echo fileA.t >list &&
      +	git reset --pathspec-from-file=list &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'NUL delimiters' '
      +	restore_checkpoint &&
      +
      +	git rm fileA.t fileB.t &&
     -+	printf fileA.tQfileB.t | q_to_nul | git reset --pathspec-from-file=- --pathspec-file-null &&
     ++	printf "fileA.t\0fileB.t\0" | git reset --pathspec-from-file=- --pathspec-file-nul &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	 D fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'LF delimiters' '
      +	restore_checkpoint &&
      +
      +	git rm fileA.t fileB.t &&
     ++	printf "fileA.t\nfileB.t\n" | git reset --pathspec-from-file=- &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	 D fileB.t
     ++	EOF
     ++	verify_expect
     ++'
     ++
     ++test_expect_success 'no trailing delimiter' '
     ++	restore_checkpoint &&
     ++
     ++	git rm fileA.t fileB.t &&
      +	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	 D fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'CRLF delimiters' '
      +	restore_checkpoint &&
      +
      +	git rm fileA.t fileB.t &&
     -+	printf "fileA.t\r\nfileB.t" | git reset --pathspec-from-file=- &&
     ++	printf "fileA.t\r\nfileB.t\r\n" | git reset --pathspec-from-file=- &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	 D fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'quotes' '
     @@ -229,21 +228,27 @@
      +	git rm fileA.t &&
      +	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	EOF
     ++	verify_expect
      +'
      +
     -+test_expect_success 'quotes not compatible with --pathspec-file-null' '
     ++test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      +	restore_checkpoint &&
      +
      +	git rm fileA.t &&
      +	printf "\"file\\101.t\"" >list &&
      +	# Note: "git reset" has not yet learned to fail on wrong pathspecs
     -+	git reset --pathspec-from-file=list --pathspec-file-null &&
     ++	git reset --pathspec-from-file=list --pathspec-file-nul &&
      +	
     -+	test_must_fail verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	 D fileA.t
     ++	EOF
     ++	test_must_fail verify_expect
      +'
      +
     -+test_expect_success '--pathspec-from-file is not compatible with --soft --hard' '
     ++test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
      +	restore_checkpoint &&
      +
      +	git rm fileA.t &&
     @@ -256,9 +261,15 @@
      +	restore_checkpoint &&
      +
      +	git rm fileA.t fileB.t fileC.t fileD.t &&
     -+	printf "fileB.t\nfileC.t" | git reset --pathspec-from-file=- &&
     -+
     -+	verify_state expect.a_bc_d
     ++	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	D  fileA.t
     ++	 D fileB.t
     ++	 D fileC.t
     ++	D  fileD.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_done
 4:  251d06e27f ! 5:  20c4495fd3 doc: commit: unify <pathspec> description
     @@ -24,12 +24,16 @@
       	Do not interpret any more arguments as options.
       
      -<file>...::
     +-	When files are given on the command line, the command
     +-	commits the contents of the named files, without
     +-	recording the changes already staged.  The contents of
     +-	these files are also staged for the next commit on top
     +-	of what have been staged before.
      +<pathspec>...::
     - 	When files are given on the command line, the command
     - 	commits the contents of the named files, without
     - 	recording the changes already staged.  The contents of
     - 	these files are also staged for the next commit on top
     - 	of what have been staged before.
     ++	When pathspec is given on the command line, commit the contents of
     ++	the files that match the pathspec without recording the changes
     ++	already added to the index. The contents of these files are also
     ++	staged for the next commit on top of what have been staged before.
      ++
      +For more details about the <pathspec> syntax, see the 'pathspec' entry
      +in linkgit:gitglossary[7].
 5:  f484704689 ! 6:  cb5fc9b14d commit: support the --pathspec-from-file option
     @@ -2,32 +2,12 @@
      
          commit: support the --pathspec-from-file option
      
     -    This option solves the problem of commandline length limit for UI's
     -    built on top of git. Plumbing commands are not always a good fit, for
     -    two major reasons:
     -    1) Some UI's serve as assistants that help user run git commands. In
     -       this case, replacing familiar commands with plumbing commands will
     -       confuse most users.
     -    2) Some UI's have started and grown with porcelain commands. Replacing
     -       existing logic with plumbing commands could be cumbersome and prone
     -       to various new problems.
     -
     -    The new option is designed to behave very close to pathspecs passed in
     -    commandline args, so that switching from one to another is simple.
     -
     -    The new option allows to read either a specified file or `stdin`.
     -    Reading from file is a good way to avoid competing for stdin, and
     -    also gives some extra flexibility.
     -
          Decisions taken for simplicity:
     -    1) The new option is declared incompatible with other options that
     -       could use `stdin`.
     -    2) It is not allowed to pass some refspecs in args and others in file.
     -    3) New options do not have shorthands to avoid shorthand conflicts.
     -
     -    Also add new '--pathspec-file-null' switch that mirrors '-z' used in
     -    various places. Some porcelain commands, such as `git commit`, already
     -    use '-z', therefore it needed a new unambiguous name.
     +    1) For now, `--pathspec-from-file` is declared incompatible with
     +       `--interactive/--patch`, even when <file> is not `stdin`. Such use
     +       case it not really expected. Also, it would require changes to
     +       `interactive_add()`.
     +    2) It is not allowed to pass pathspec in both args and file.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -39,7 +19,7 @@
       	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
       	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
      -	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
     -+	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-null]]
     ++	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
      +	   [-S[<keyid>]] [--] [<pathspec>...]
       
       DESCRIPTION
     @@ -50,14 +30,15 @@
       	paths are also not required, and an empty commit will be created.
      +	
      +--pathspec-from-file=<file>::
     -+	Read `<pathspec>` from `<file>` instead. If `<file>` is exactly `-`
     -+	then read from standard input. Pathspecs are separated by LF or
     -+	CR/LF. Pathspecs can be quoted as explained for the configuration
     -+	variable `core.quotePath` (see linkgit:git-config[1]). See also
     -+	`--pathspec-file-null` and global `--literal-pathspecs`.
     -+
     -+--pathspec-file-null::
     -+	Only meaningful with `--pathspec-from-file`. Pathspecs are
     ++	Pathspec is passed in `<file>` instead of commandline args. If
     ++	`<file>` is exactly `-` then standard input is used. Pathspec
     ++	elements are separated by LF or CR/LF. Pathspec elements can be
     ++	quoted as explained for the configuration variable `core.quotePath`
     ++	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
     ++	global `--literal-pathspecs`.
     ++
     ++--pathspec-file-nul::
     ++	Only meaningful with `--pathspec-from-file`. Pathspec elements are
      +	separated with NUL character and are not expected to be quoted.
       
       -u[<mode>]::
     @@ -71,7 +52,7 @@
       static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
       static int config_commit_verbose = -1; /* unspecified */
      -static int no_post_rewrite, allow_empty_message;
     -+static int no_post_rewrite, allow_empty_message, pathspec_file_null;
     ++static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
       static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
      -static char *sign_commit;
      +static char *sign_commit, *pathspec_from_file;
     @@ -87,14 +68,14 @@
      +			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
      +
      +		if (pathspec.nr)
     -+			die(_("--pathspec-from-file is incompatible with path arguments"));
     ++			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
      +
      +		parse_pathspec_file(&pathspec, 0,
      +				    PATHSPEC_PREFER_FULL,
     -+				    prefix, pathspec_from_file, pathspec_file_null);
     ++				    prefix, pathspec_from_file, pathspec_file_nul);
     ++	} else if (pathspec_file_nul) {
     ++		die(_("--pathspec-file-nul requires --pathspec-from-file"));
      +	}
     -+	else if (pathspec_file_null)
     -+		die(_("--pathspec-file-null requires --pathspec-from-file"));
      +
      +	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
      +		die(_("No paths with --include/--only does not make sense."));
     @@ -115,8 +96,8 @@
       		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
       		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
       		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
     -+		OPT_FILENAME(0, "pathspec-from-file", &pathspec_from_file, N_("read pathspecs from file")),
     -+		OPT_BOOL(0, "pathspec-file-null", &pathspec_file_null, N_("with --pathspec-from-file, pathspecs are separated with NUL character")),
     ++		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
     ++		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
       		/* end commit contents options */
       
       		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
     @@ -134,23 +115,9 @@
      +
      +test_tick
      +
     -+cat > expect.a <<EOF
     -+A	fileA.t
     -+EOF
     -+
     -+cat > expect.ab <<EOF
     -+A	fileA.t
     -+A	fileB.t
     -+EOF
     -+
     -+cat > expect.bc <<EOF
     -+A	fileB.t
     -+A	fileC.t
     -+EOF
     -+
      +test_expect_success setup '
      +	test_commit file0 &&
     -+	checkpoint=$(git rev-parse --verify HEAD) &&
     ++	git tag checkpoint &&
      +	
      +	echo A >fileA.t &&
      +	echo B >fileB.t &&
     @@ -160,12 +127,12 @@
      +'
      +
      +restore_checkpoint () {
     -+	git reset --soft "$checkpoint"
     ++	git reset --soft checkpoint
      +}
      +
     -+verify_state () {
     ++verify_expect () {
      +	git diff-tree --no-commit-id --name-status -r HEAD >actual &&
     -+	test_cmp "$1" actual
     ++	test_cmp expect actual
      +}
      +
      +test_expect_success '--pathspec-from-file from stdin' '
     @@ -173,7 +140,10 @@
      +
      +	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success '--pathspec-from-file from file' '
     @@ -182,31 +152,58 @@
      +	echo fileA.t >list &&
      +	git commit --pathspec-from-file=list -m "Commit" &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'NUL delimiters' '
      +	restore_checkpoint &&
      +
     -+	printf fileA.tQfileB.t | q_to_nul | git commit --pathspec-from-file=- --pathspec-file-null -m "Commit" &&
     ++	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	A	fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'LF delimiters' '
      +	restore_checkpoint &&
      +
     ++	printf "fileA.t\nfileB.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	A	fileB.t
     ++	EOF
     ++	verify_expect
     ++'
     ++
     ++test_expect_success 'no trailing delimiter' '
     ++	restore_checkpoint &&
     ++
      +	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	A	fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'CRLF delimiters' '
      +	restore_checkpoint &&
      +
     -+	printf "fileA.t\r\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
     ++	printf "fileA.t\r\nfileB.t\r\n" | git commit --pathspec-from-file=- -m "Commit" &&
      +
     -+	verify_state expect.ab
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	A	fileB.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_expect_success 'quotes' '
     @@ -214,22 +211,29 @@
      +
      +	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
      +
     -+	verify_state expect.a
     ++	cat >expect <<-\EOF &&
     ++	A	fileA.t
     ++	EOF
     ++	verify_expect expect
      +'
      +
     -+test_expect_success 'quotes not compatible with --pathspec-file-null' '
     ++test_expect_success 'quotes not compatible with --pathspec-file-nul' '
      +	restore_checkpoint &&
      +
      +	printf "\"file\\101.t\"" >list &&
     -+	test_must_fail git commit --pathspec-from-file=list --pathspec-file-null -m "Commit"
     ++	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
      +'
      +
      +test_expect_success 'only touches what was listed' '
      +	restore_checkpoint &&
      +
     -+	printf "fileB.t\nfileC.t" | git commit --pathspec-from-file=- -m "Commit" &&
     ++	printf "fileB.t\nfileC.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
      +
     -+	verify_state expect.bc
     ++	cat >expect <<-\EOF &&
     ++	A	fileB.t
     ++	A	fileC.t
     ++	EOF
     ++	verify_expect
      +'
      +
      +test_done

-- 
gitgitgadget
