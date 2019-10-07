Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E371F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfJGUIe (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36689 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so16788321wrd.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7rkUIX1c04EJHxWsjb6kjIXP4XeBHewJy1O/dYBj14o=;
        b=rOmsF1oC4OD1tNIkGmhJCedfTHUBWDRChR7r/q25nHayDYArFuvITBlb8wBTOWdJft
         65WLCrqFUhsWAlTt/FytNSYYnX4EAU3nUoiDb7XDYjLuyLEqd6fN9d43eckugebWRukd
         plhXUpNzCzagUZsH9z5ghuqeTF5qfmYUVvYUJ6l8XSciJx7yyc0+bWzyCXUxhzihNswA
         /rfeTxktyULPwQtGCbSgSklWD0xCPw+VDtKbUmlyNLoi2yK9kfH+3QxGSoz5sOzjkgK9
         D6mmOXCb3lqx7V80r/9db8QOwnjuyuCQfp1ANO+YuKc67JHBdv2HGLDwl3gkNlCcltbR
         QKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7rkUIX1c04EJHxWsjb6kjIXP4XeBHewJy1O/dYBj14o=;
        b=BlPiI1scQEN//ntgUES3tTjU42UTrr4Boi89bYNoq0nYPjdkrj61EEEetFskbkTlVH
         QFUKKSKXaxERFykaEHydRlkac2bzCMkyngjUTNyoaORj1DrmCxEVbLs3N9a/eM5DLOCJ
         VVMNJCmuZDELuPqpVnGasvKuut2bGduunHMgNXPCjG3S472UoekWuJpLBg2mhJ5YUu02
         mM8q3J8TT1AK+Pxrx6eoLh71dYOx6UK1rZCKQXZvgROEkR7THIl+1gecHxwf04wlyXhr
         3Q8Ro8EwBuDl3qp4BJbb+Kjnfn2Q7yqQLyJ1fsII8uceDNvclW8zEUvHXbKAN7+/3ksA
         Jz7g==
X-Gm-Message-State: APjAAAUVOmop9LdGsRIIlj3tLNPJI7HVSKkPxL6NBjY8rZB3TFx8UXRQ
        S326eitB9UdqafThZgUSsqkWvTzG
X-Google-Smtp-Source: APXvYqyRZSxCSC4EfNVJ7ndc/HYXMMuua/tVHWJhmDZhVsoW2wWm541+VFAGNbJFZdQgCcooChAdRA==
X-Received: by 2002:adf:e386:: with SMTP id e6mr21854047wrm.91.1570478907149;
        Mon, 07 Oct 2019 13:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b144sm759791wmb.3.2019.10.07.13.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:26 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:26 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:08 GMT
Message-Id: <pull.316.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/17] New sparse-checkout builtin and "cone" mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the sparse-checkout feature more user-friendly. While
there, I also present a way to use a limited set of patterns to gain a
significant performance boost in very large repositories.

Sparse-checkout is only documented as a subsection of the read-tree docs
[1], which makes the feature hard to discover. Users have trouble navigating
the feature, especially at clone time [2], and have even resorted to
creating their own helper tools [3].

This series attempts to solve these problems using a new builtin. Here is a
sample workflow to give a feeling for how it can work:

In an existing repo:

$ git sparse-checkout init
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder
$ ls myFolder
a.c a.h
$ git sparse-checkout disable
$ ls
hiddenFolder myFile1.txt myFile2.txt myFolder

At clone time:

$ git clone --sparse origin repo
$ cd repo
$ ls
myFile1.txt myFile2.txt
$ git sparse-checkout set "/*" "!/*/" /myFolder/
$ ls
myFile1.txt myFile2.txt myFolder

Here are some more specific details:

 * git sparse-checkout init enables core.sparseCheckout and populates the
   sparse-checkout file with patterns that match only the files at root.
   
   
 * git clone learns the --sparse argument to run git sparse-checkout init 
   before the first checkout.
   
   
 * git sparse-checkout set reads patterns from the arguments, or with
   --stdin reads patterns from stdin one per line, then writes them to the
   sparse-checkout file and refreshes the working directory.
   
   
 * git sparse-checkout disable removes the patterns from the sparse-checkout
   file, disables core.sparseCheckout, and refills the working directory.
   
   
 * git sparse-checkout list lists the contents of the sparse-checkout file.
   
   

The documentation for the sparse-checkout feature can now live primarily
with the git-sparse-checkout documentation.

Cone Mode
=========

What really got me interested in this area is a performance problem. If we
have N patterns in the sparse-checkout file and M entries in the index, then
we can perform up to O(N * M) pattern checks in clear_ce_flags(). This
quadratic growth is not sustainable in a repo with 1,000+ patterns and
1,000,000+ index entries.

To solve this problem, I propose a new, more restrictive mode to
sparse-checkout: "cone mode". In this mode, all patterns are based on prefix
matches at a directory level. This can then use hashsets for fast
performance -- O(M) instead of O(N*M). My hashset implementation is based on
the virtual filesystem hook in the VFS for Git custom code [4].

In cone mode, a user specifies a list of folders which the user wants every
file inside. In addition, the cone adds all blobs that are siblings of the
folders in the directory path to that folder. This makes the directories
look "hydrated" as a user drills down to those recursively-closed folders.
These directories are called "parent" folders, as a file matches them only
if the file's immediate parent is that directory.

When building a prototype of this feature, I used a separate file to contain
the list of recursively-closed folders and built the hashsets dynamically
based on that file. In this implementation, I tried to maximize the amount
of backwards-compatibility by storing all data in the sparse-checkout file
using patterns recognized by earlier Git versions.

For example, if we add A/B/C as a recursive folder, then we add the
following patterns to the sparse-checkout file:

/*
!/*/
/A/
!/A/*/
/A/B/
!/A/B/*/
/A/B/C/

The alternating positive/negative patterns say "include everything in this
folder, but exclude everything another level deeper". The final pattern has
no matching negation, so is a recursively closed pattern.

Note that I have some basic warnings to try and check that the
sparse-checkout file doesn't match what would be written by a cone-mode add.
In such a case, Git writes a warning to stderr and continues with the old
pattern matching algorithm. These checks are currently very barebones, and
would need to be updated with more robust checks for things like regex
characters in the middle of the pattern. As review moves forward (and if we
don't change the data storage) then we could spend more time on this.

Thanks, -Stolee

Updates in v2, relative to the RFC:

 * Instead of an 'add' subcommand, use a 'set' subcommand. We can consider
   adding 'add' and/or 'remove' subcommands later.
   
   
 * 'set' reads from the arguments by default. '--stdin' option is available.
   
   
 * A new performance-oriented commit is added at the end.
   
   
 * Patterns no longer end with a trailing asterisk except for the first "/*"
   pattern.
   
   
 * References to a "bug" (that was really a strange GVFS interaction in
   microsoft/git) around deleting outside the cone are removed.
   
   

Updates in v3:

 * The bad interaction with "cone mode" and .gitignore files is fixed. A
   test is added in the last patch.
   
   
 * Several patches are added that make the feature more robust. One
   sanitizes user input, another few add progress indicators, and another
   more prevent users from getting in bad states due to working directory
   changes or concurrent processes.
   
   
 * Updated several docs and commit messages according to feedback. Thanks,
   Elijah!
   
   

Things to leave for future patches:

 1. Integrate in 'git worktree add' to copy the sparse-checkout file to a
    worktree-specific file.
    
    
 2. More robustness around detecting non-cone patterns with wildcards in the
    middle of the line.
    
    
 3. 'git clone --sparse-cone' to clone into "cone mode" sparse-checkouts
    (i.e. set 'core.sparseCheckoutCone=true'). This may not be
    super-valuable, as it only starts changing behavior when someone calls
    'git sparse-checkout set', but may be interesting.
    
    

[1] https://git-scm.com/docs/git-read-tree#_sparse_checkoutSparse-checkout
documentation in git-read-tree.

[2] https://stackoverflow.com/a/4909267/127088Is it possible to do a sparse
checkout without checking out the whole repository first?

[3] http://www.marcoyuen.com/articles/2016/06/07/git-sparse.htmlA blog post
of a user's extra "git-sparse" helper.

[4] 
https://github.com/git/git/compare/fc5fd706ff733392053e6180086a4d7f96acc2af...01204f24c5349aa2fb0c474546d768946d315dab
The virtual filesystem hook in microsoft/git.

Derrick Stolee (16):
  sparse-checkout: create builtin with 'list' subcommand
  sparse-checkout: create 'init' subcommand
  clone: add --sparse mode
  sparse-checkout: 'set' subcommand
  sparse-checkout: add '--stdin' option to set subcommand
  sparse-checkout: create 'disable' subcommand
  sparse-checkout: add 'cone' mode
  sparse-checkout: use hashmaps for cone patterns
  sparse-checkout: init and set in cone mode
  unpack-trees: hash less in cone mode
  unpack-trees: add progress to clear_ce_flags()
  read-tree: show progress by default
  sparse-checkout: sanitize for nested folders
  sparse-checkout: update working directory in-process
  sparse-checkout: write using lockfile
  sparse-checkout: cone mode should not interact with .gitignore

Jeff Hostetler (1):
  trace2: add region in clear_ce_flags

 .gitignore                            |   1 +
 Documentation/config/core.txt         |  10 +-
 Documentation/git-clone.txt           |   8 +-
 Documentation/git-read-tree.txt       |   2 +-
 Documentation/git-sparse-checkout.txt | 149 ++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/read-tree.c                   |   3 +-
 builtin/sparse-checkout.c             | 485 ++++++++++++++++++++++++++
 cache.h                               |   6 +-
 config.c                              |   5 +
 dir.c                                 | 202 ++++++++++-
 dir.h                                 |  34 ++
 environment.c                         |   1 +
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 279 +++++++++++++++
 unpack-trees.c                        | 110 ++++--
 unpack-trees.h                        |   3 +-
 19 files changed, 1280 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 468ce99b77a0efaf1ace4c31a7b0a7d036fd9ca1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/316

Range-diff vs v2:

  1:  dbaf3de88e !  1:  30a0db68cd sparse-checkout: create builtin with 'list' subcommand
     @@ -15,12 +15,6 @@
          builtin will be the preferred mechanism for manipulating the
          sparse-checkout file and syncing the working directory.
      
     -    The `$GIT_DIR/info/sparse-checkout` file defines the skip-
     -    worktree reference bitmap. When Git updates the working
     -    directory, it updates the skip-worktree bits in the index
     -    based on this file and removes or restores files in the
     -    working copy to match.
     -
          The documentation provided is adapted from the "git read-tree"
          documentation with a few edits for clarity in the new context.
          Extra sections are added to hint toward a future change to
     @@ -101,14 +95,9 @@
      +
      +The `$GIT_DIR/info/sparse-checkout` file is used to define the
      +skip-worktree reference bitmap. When Git updates the working
     -+directory, it resets the skip-worktree bit in the index based on this
     -+file. If an entry
     -+matches a pattern in this file, skip-worktree will not be set on
     -+that entry. Otherwise, skip-worktree will be set.
     -+
     -+Then it compares the new skip-worktree value with the previous one. If
     -+skip-worktree turns from set to unset, it will add the corresponding
     -+file back. If it turns from unset to set, that file will be removed.
     ++directory, it updates the skip-worktree bits in the index based
     ++ont this file. The files matching the patterns in the file will
     ++appear in the working directory, and the rest will not.
      +
      +## FULL PATTERN SET
      +
     @@ -136,7 +125,7 @@
      +----------------
      +
      +Then you can disable sparse checkout. Sparse checkout support in 'git
     -+read-tree' and similar commands is disabled by default. You need to
     ++checkout' and similar commands is disabled by default. You need to
      +set `core.sparseCheckout` to `true` in order to have sparse checkout
      +support.
      +
     @@ -333,4 +322,3 @@
      +'
      +
      +test_done
     -+
  2:  412211f5dd !  2:  08bb6fb7f3 sparse-checkout: create 'init' subcommand
     @@ -8,12 +8,12 @@
          an initial set of patterns to the sparse-checkout file, and update
          their working directory.
      
     -    Using 'git read-tree' to clear directories does not work cleanly
     -    on Windows, so manually delete directories that are tracked by Git
     -    before running read-tree.
     +    Make sure to use the `extensions.worktreeConfig` setting and write
     +    the sparse checkout config to the worktree-specific config file.
     +    This avoids confusing interactions with other worktrees.
      
     -    The use of running another process for 'git read-tree' is likely
     -    suboptimal, but that can be improved in a later change, if valuable.
     +    The use of running another process for 'git read-tree' is sub-
     +    optimal. This will be removed in a later change.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -31,6 +31,11 @@
      +	no other directories, then will remove all directories tracked
      +	by Git. Add patterns to the sparse-checkout file to
      +	repopulate the working directory.
     +++
     ++The init subcommand also enables the 'extensions.worktreeConfig' setting
     ++and sets the `core.sparseCheckout` setting in the worktree-specific config
     ++file. This prevents the sparse-checkout feature from interfering with other
     ++worktrees.
       
       SPARSE CHECKOUT
       ----------------
     @@ -66,7 +71,12 @@
      +	return result;
      +}
      +
     -+static int sc_enable_config(void)
     ++enum sparse_checkout_mode {
     ++	MODE_NONE = 0,
     ++	MODE_FULL = 1,
     ++};
     ++
     ++static int sc_set_config(enum sparse_checkout_mode mode)
      +{
      +	struct argv_array argv = ARGV_ARRAY_INIT;
      +
     @@ -75,7 +85,12 @@
      +		return 1;
      +	}
      +
     -+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
     ++	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
     ++
     ++	if (mode)
     ++		argv_array_pushl(&argv, "true", NULL);
     ++	else
     ++		argv_array_pushl(&argv, "false", NULL);
      +
      +	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
      +		error(_("failed to enable core.sparseCheckout"));
     @@ -92,7 +107,7 @@
      +	FILE *fp;
      +	int res;
      +
     -+	if (sc_enable_config())
     ++	if (sc_set_config(MODE_FULL))
      +		return 1;
      +
      +	memset(&pl, 0, sizeof(pl));
     @@ -178,4 +193,3 @@
      +'
      +
       test_done
     - 
  3:  fef41b794a !  3:  c8587a1fb0 clone: add --sparse mode
     @@ -21,9 +21,9 @@
          point.
      
          During the 'git sparse-checkout init' call, we must first look
     -    to see if HEAD is valid, or else we will fail while trying to
     -    update the working directory. The first checkout will actually
     -    update the working directory correctly.
     +    to see if HEAD is valid, since 'git clone' does not have a valid
     +    HEAD. The first checkout will create the HEAD ref and update the
     +    working directory correctly.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -121,7 +121,7 @@
       	int res;
      +	struct object_id oid;
       
     - 	if (sc_enable_config())
     + 	if (sc_set_config(MODE_FULL))
       		return 1;
      @@
       	fprintf(fp, "/*\n!/*/\n");
     @@ -157,4 +157,3 @@
      +'
      +
       test_done
     - 
  4:  9a78f9ea0f !  4:  6ce1d60b38 sparse-checkout: 'set' subcommand
     @@ -17,8 +17,8 @@
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
      @@
     - 	by Git. Add patterns to the sparse-checkout file to
     - 	repopulate the working directory.
     + file. This prevents the sparse-checkout feature from interfering with other
     + worktrees.
       
      +'set'::
      +	Write a set of patterns to the sparse-checkout file, as given as
     @@ -56,20 +56,24 @@
      +	fclose(fp);
      +	free(sparse_filename);
      +
     -+	clear_pattern_list(pl);
      +	return update_working_directory();
      +}
      +
      +static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
      +{
     ++	static const char *empty_base = "";
      +	int i;
      +	struct pattern_list pl;
     ++	int result;
      +	memset(&pl, 0, sizeof(pl));
      +
      +	for (i = 1; i < argc; i++)
     -+		add_pattern(argv[i], NULL, 0, &pl, 0);
     ++		add_pattern(argv[i], empty_base, 0, &pl, 0);
      +
     -+	return write_patterns_and_update(&pl);
     ++	result = write_patterns_and_update(&pl);
     ++
     ++	clear_pattern_list(&pl);
     ++	return result;
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     @@ -112,4 +116,3 @@
      +'
      +
       test_done
     - 
  5:  21a0165be7 !  5:  0b1ed06bc8 sparse-checkout: add '--stdin' option to set subcommand
     @@ -14,6 +14,18 @@
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
     +@@
     + 	char *sparse_filename;
     + 	FILE *fp;
     + 
     ++	if (!core_apply_sparse_checkout) {
     ++		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
     ++		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
     ++	}
     ++
     + 	sparse_filename = get_sparse_checkout_filename();
     + 	fp = fopen(sparse_filename, "w");
     + 	write_patterns_to_file(fp, pl);
      @@
       	return update_working_directory();
       }
     @@ -29,8 +41,10 @@
      +
       static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
       {
     + 	static const char *empty_base = "";
       	int i;
       	struct pattern_list pl;
     + 	int result;
      +
      +	static struct option builtin_sparse_checkout_set_options[] = {
      +		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
     @@ -41,7 +55,7 @@
       	memset(&pl, 0, sizeof(pl));
       
      -	for (i = 1; i < argc; i++)
     --		add_pattern(argv[i], NULL, 0, &pl, 0);
     +-		add_pattern(argv[i], empty_base, 0, &pl, 0);
      +	argc = parse_options(argc, argv, prefix,
      +			     builtin_sparse_checkout_set_options,
      +			     builtin_sparse_checkout_set_usage,
     @@ -53,15 +67,15 @@
      +		while (!strbuf_getline(&line, stdin)) {
      +			size_t len;
      +			char *buf = strbuf_detach(&line, &len);
     -+			add_pattern(buf, buf, len, &pl, 0);
     ++			add_pattern(buf, empty_base, 0, &pl, 0);
      +		}
      +	} else {
      +		for (i = 0; i < argc; i++)
     -+			add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
     ++			add_pattern(argv[i], empty_base, 0, &pl, 0);
      +	}
       
     - 	return write_patterns_and_update(&pl);
     - }
     + 	result = write_patterns_and_update(&pl);
     + 
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -70,6 +84,20 @@
       	test_cmp expect dir
       '
       
     ++test_expect_success 'warn if core.sparseCheckout is disabled' '
     ++	test_when_finished git -C repo config --worktree core.sparseCheckout true &&
     ++	git -C repo config --worktree core.sparseCheckout false &&
     ++	git -C repo sparse-checkout set folder1 2>err &&
     ++	test_i18ngrep "core.sparseCheckout is disabled" err
     ++'
     ++
     + test_expect_success 'set sparse-checkout using builtin' '
     + 	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
     + 	cat >expect <<-EOF &&
     +@@
     + 	test_cmp expect dir
     + '
     + 
      +test_expect_success 'set sparse-checkout using --stdin' '
      +	cat >expect <<-EOF &&
      +		/*
     @@ -91,4 +119,3 @@
      +'
      +
       test_done
     - 
  6:  b62b76013f !  6:  22b9bd21f4 sparse-checkout: create 'disable' subcommand
     @@ -24,15 +24,16 @@
       ----------------
       
      @@
     - skip-worktree turns from set to unset, it will add the corresponding
     - file back. If it turns from unset to set, that file will be removed.
     + ont this file. The files matching the patterns in the file will
     + appear in the working directory, and the rest will not.
       
     ++To enable the sparse-checkout feature, run `git sparse-checkout init` to
     ++initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
     ++config setting. Then, run `git sparse-checkout set` to modify the patterns in
     ++the sparse-checkout file.
     ++
      +To repopulate the working directory with all files, use the
      +`git sparse-checkout disable` command.
     -+
     -+Sparse checkout support in 'git checkout' and similar commands is
     -+disabled by default. You need to set `core.sparseCheckout` to `true`
     -+in order to have sparse checkout support.
      +
       ## FULL PATTERN SET
       
     @@ -53,7 +54,7 @@
      -----------------
      -
      -Then you can disable sparse checkout. Sparse checkout support in 'git
     --read-tree' and similar commands is disabled by default. You need to
     +-checkout' and similar commands is disabled by default. You need to
      -set `core.sparseCheckout` to `true` in order to have sparse checkout
      -support.
       
     @@ -76,44 +77,12 @@
       	return result;
       }
       
     --static int sc_enable_config(void)
     -+static int sc_set_config(int mode)
     - {
     - 	struct argv_array argv = ARGV_ARRAY_INIT;
     - 
     -@@
     - 		return 1;
     - 	}
     - 
     --	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
     -+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
     -+
     -+	if (mode)
     -+		argv_array_pushl(&argv, "true", NULL);
     -+	else
     -+		argv_array_pushl(&argv, "false", NULL);
     - 
     - 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     - 		error(_("failed to enable core.sparseCheckout"));
     -@@
     - 	int res;
     - 	struct object_id oid;
     - 
     --	if (sc_enable_config())
     -+	if (sc_set_config(1))
     - 		return 1;
     - 
     - 	memset(&pl, 0, sizeof(pl));
     -@@
     - 	return write_patterns_and_update(&pl);
     - }
     - 
      +static int sparse_checkout_disable(int argc, const char **argv)
      +{
      +	char *sparse_filename;
      +	FILE *fp;
      +
     -+	if (sc_set_config(1))
     ++	if (sc_set_config(MODE_FULL))
      +		die(_("failed to change config"));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     @@ -127,7 +96,7 @@
      +	unlink(sparse_filename);
      +	free(sparse_filename);
      +
     -+	return sc_set_config(0);
     ++	return sc_set_config(MODE_NONE);
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     @@ -166,4 +135,3 @@
      +'
      +
       test_done
     - 
  7:  25642f8df2 =  7:  2c53ea13d0 trace2: add region in clear_ce_flags
  8:  84511255d1 !  8:  a66ec1affc sparse-checkout: add 'cone' mode
     @@ -11,7 +11,7 @@
          indicate that we expect the sparse-checkout file to contain a
          more limited set of patterns. This is a separate config setting
          from core.sparseCheckout to avoid breaking older clients by
     -    introcuding a tri-state option.
     +    introducing a tri-state option.
      
          The config option does nothing right now, but will be expanded
          upon in a later commit.
     @@ -27,11 +27,14 @@
       core.sparseCheckout::
      -	Enable "sparse checkout" feature. See section "Sparse checkout" in
      -	linkgit:git-read-tree[1] for more information.
     -+	Enable "sparse checkout" feature. If "false", then sparse-checkout
     -+	is disabled. If "true", then sparse-checkout is enabled with the full
     -+	.gitignore pattern set. If "cone", then sparse-checkout is enabled with
     -+	a restricted pattern set. See linkgit:git-sparse-checkout[1] for more
     -+	information.
     ++	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
     ++	for more information.
     ++
     ++core.sparseCheckoutCone::
     ++	Enables the "cone mode" of the sparse checkout feature. When the
     ++	sparse-checkout file contains a limited set of patterns, then this
     ++	mode provides significant performance advantages. See
     ++	linkgit:git-sparse-checkout[1] for more information.
       
       core.abbrev::
       	Set the length object names are abbreviated to.  If
  9:  95a3285bc6 !  9:  431933bec6 sparse-checkout: use hashmaps for cone patterns
     @@ -64,8 +64,17 @@
      +	if (!pl->use_cone_patterns)
      +		return;
      +
     -+	if (!strcmp(given->pattern, "/*"))
     ++	if (given->flags & PATTERN_FLAG_NEGATIVE &&
     ++	    given->flags & PATTERN_FLAG_MUSTBEDIR &&
     ++	    !strcmp(given->pattern, "/*")) {
     ++		pl->full_cone = 0;
      +		return;
     ++	}
     ++
     ++	if (!given->flags && !strcmp(given->pattern, "/*")) {
     ++		pl->full_cone = 1;
     ++		return;
     ++	}
      +
      +	if (given->patternlen > 2 &&
      +	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
     @@ -144,6 +153,33 @@
      +	hashmap_entry_init(&p, memhash(p.pattern, p.patternlen));
      +	return !!hashmap_get(map, &p, NULL);
      +}
     ++
     ++int hashmap_contains_parent(struct hashmap *map,
     ++			    const char *path,
     ++			    struct strbuf *buffer)
     ++{
     ++	char *slash_pos;
     ++
     ++	strbuf_setlen(buffer, 0);
     ++
     ++	if (path[0] != '/')
     ++		strbuf_addch(buffer, '/');
     ++
     ++	strbuf_addstr(buffer, path);
     ++
     ++	slash_pos = strrchr(buffer->buf, '/');
     ++
     ++	while (slash_pos > buffer->buf) {
     ++		strbuf_setlen(buffer, slash_pos - buffer->buf);
     ++
     ++		if (hashmap_contains_path(map, buffer))
     ++			return 1;
     ++
     ++		slash_pos = strrchr(buffer->buf, '/');
     ++	}
     ++
     ++	return 0;
     ++}
      +
       void add_pattern(const char *string, const char *base,
       		 int baselen, struct pattern_list *pl, int srcpos)
     @@ -161,7 +197,6 @@
       	int i, lineno = 1;
       	char *entry;
       
     -+	pl->use_cone_patterns = core_sparse_checkout_cone;
      +	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
      +	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
      +
     @@ -194,14 +229,16 @@
      +		}
      +
      +		return UNDECIDED;
     - 	}
     - 
     --	return UNDECIDED;
     ++	}
     ++
     ++	if (pl->full_cone)
     ++		return MATCHED;
     ++
      +	strbuf_addch(&parent_pathname, '/');
      +	strbuf_add(&parent_pathname, pathname, pathlen);
      +
      +	if (hashmap_contains_path(&pl->recursive_hashmap,
     -+					&parent_pathname)) {
     ++				  &parent_pathname)) {
      +		result = MATCHED;
      +		goto done;
      +	}
     @@ -212,8 +249,9 @@
      +		/* include every file in root */
      +		result = MATCHED;
      +		goto done;
     -+	}
     -+
     + 	}
     + 
     +-	return UNDECIDED;
      +	strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
      +
      +	if (hashmap_contains_path(&pl->parent_hashmap, &parent_pathname)) {
     @@ -221,19 +259,10 @@
      +		goto done;
      +	}
      +
     -+	while (parent_pathname.len) {
     -+		if (hashmap_contains_path(&pl->recursive_hashmap,
     -+					  &parent_pathname)) {
     -+			result = UNDECIDED;
     -+			goto done;
     -+		}
     -+
     -+		slash_pos = strrchr(parent_pathname.buf, '/');
     -+		if (slash_pos == parent_pathname.buf)
     -+			break;
     -+
     -+		strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
     -+	}
     ++	if (hashmap_contains_parent(&pl->recursive_hashmap,
     ++				    pathname,
     ++				    &parent_pathname))
     ++		result = MATCHED;
      +
      +done:
      +	strbuf_release(&parent_pathname);
     @@ -279,6 +308,7 @@
      +	 * excludes array above. If non-zero, that check succeeded.
      +	 */
      +	unsigned use_cone_patterns;
     ++	unsigned full_cone;
      +
      +	/*
      +	 * Stores paths where everything starting with those paths
     @@ -293,6 +323,16 @@
       };
       
       /*
     +@@
     + 		struct index_state *istate,
     + 		const char *name, int *dtype);
     + 
     ++int hashmap_contains_parent(struct hashmap *map,
     ++			    const char *path,
     ++			    struct strbuf *buffer);
     + struct pattern_list *add_pattern_list(struct dir_struct *dir,
     + 				      int group_type, const char *src);
     + int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -322,3 +362,15 @@
       test_expect_success 'sparse-checkout disable' '
       	git -C repo sparse-checkout disable &&
       	test_path_is_missing repo/.git/info/sparse-checkout &&
     +
     + diff --git a/unpack-trees.c b/unpack-trees.c
     + --- a/unpack-trees.c
     + +++ b/unpack-trees.c
     +@@
     + 		o->skip_sparse_checkout = 1;
     + 	if (!o->skip_sparse_checkout) {
     + 		char *sparse = git_pathdup("info/sparse-checkout");
     ++		pl.use_cone_patterns = core_sparse_checkout_cone;
     + 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
     + 			o->skip_sparse_checkout = 1;
     + 		else
 10:  995c5b8e2b ! 10:  69bd707e96 sparse-checkout: init and set in cone mode
     @@ -32,14 +32,13 @@
       static char const * const builtin_sparse_checkout_usage[] = {
       	N_("git sparse-checkout [init|list|set|disable] <options>"),
      @@
     - 	return result;
     - }
     + enum sparse_checkout_mode {
     + 	MODE_NONE = 0,
     + 	MODE_FULL = 1,
     ++	MODE_CONE = 2,
     + };
       
     -+#define SPARSE_CHECKOUT_NONE 0
     -+#define SPARSE_CHECKOUT_FULL 1
     -+#define SPARSE_CHECKOUT_CONE 2
     -+
     - static int sc_set_config(int mode)
     + static int sc_set_config(enum sparse_checkout_mode mode)
       {
       	struct argv_array argv = ARGV_ARRAY_INIT;
      +	struct argv_array cone_argv = ARGV_ARRAY_INIT;
     @@ -53,7 +52,7 @@
      +	argv_array_pushl(&cone_argv, "config", "--worktree",
      +			 "core.sparseCheckoutCone", NULL);
      +
     -+	if (mode == SPARSE_CHECKOUT_CONE)
     ++	if (mode == MODE_CONE)
      +		argv_array_push(&cone_argv, "true");
      +	else
      +		argv_array_push(&cone_argv, "false");
     @@ -83,19 +82,19 @@
       	int res;
       	struct object_id oid;
      +	int mode;
     -+
     + 
     +-	if (sc_set_config(MODE_FULL))
      +	static struct option builtin_sparse_checkout_init_options[] = {
      +		OPT_BOOL(0, "cone", &init_opts.cone_mode,
      +			 N_("initialize the sparse-checkout in cone mode")),
      +		OPT_END(),
      +	};
     - 
     --	if (sc_set_config(1))
     ++
      +	argc = parse_options(argc, argv, NULL,
      +			     builtin_sparse_checkout_init_options,
      +			     builtin_sparse_checkout_init_usage, 0);
      +
     -+	mode = init_opts.cone_mode ? SPARSE_CHECKOUT_CONE : SPARSE_CHECKOUT_FULL;
     ++	mode = init_opts.cone_mode ? MODE_CONE : MODE_FULL;
      +
      +	if (sc_set_config(mode))
       		return 1;
     @@ -119,7 +118,7 @@
      +		char *oldpattern = e->pattern;
      +		size_t newlen;
      +
     -+		if (!slash)
     ++		if (slash == e->pattern)
      +			break;
      +
      +		newlen = slash - e->pattern;
     @@ -153,7 +152,7 @@
      +		char *pattern = sl.items[i].string;
      +
      +		if (strlen(pattern))
     -+			fprintf(fp, "/%s/\n!/%s/*/\n", pattern, pattern);
     ++			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
      +	}
      +
      +	string_list_clear(&sl, 0);
     @@ -167,7 +166,7 @@
      +
      +	for (i = 0; i < sl.nr; i++) {
      +		char *pattern = sl.items[i].string;
     -+		fprintf(fp, "/%s/\n", pattern);
     ++		fprintf(fp, "%s/\n", pattern);
      +	}
      +}
      +
     @@ -188,7 +187,6 @@
       	fclose(fp);
       	free(sparse_filename);
       
     -@@
       	return update_working_directory();
       }
       
     @@ -201,11 +199,8 @@
      +	if (!line->len)
      +		return;
      +
     -+	if (line->buf[0] == '/')
     -+		strbuf_remove(line, 0, 1);
     -+
     -+	if (!line->len)
     -+		return;
     ++	if (line->buf[0] != '/')
     ++		strbuf_insert(line, 0, "/", 1);
      +
      +	insert_recursive_pattern(pl, line);
      +}
     @@ -224,7 +219,7 @@
      -		while (!strbuf_getline(&line, stdin)) {
      -			size_t len;
      -			char *buf = strbuf_detach(&line, &len);
     --			add_pattern(buf, buf, len, &pl, 0);
     +-			add_pattern(buf, empty_base, 0, &pl, 0);
      +		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
      +		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
      +
     @@ -240,40 +235,22 @@
       		}
       	} else {
      -		for (i = 0; i < argc; i++)
     --			add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
     +-			add_pattern(argv[i], empty_base, 0, &pl, 0);
      +		if (set_opts.use_stdin) {
      +			struct strbuf line = STRBUF_INIT;
      +
      +			while (!strbuf_getline(&line, stdin)) {
      +				size_t len;
      +				char *buf = strbuf_detach(&line, &len);
     -+				add_pattern(buf, buf, len, &pl, 0);
     ++				add_pattern(buf, empty_base, 0, &pl, 0);
      +			}
      +		} else {
      +			for (i = 0; i < argc; i++)
     -+				add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
     ++				add_pattern(argv[i], empty_base, 0, &pl, 0);
      +		}
       	}
       
     - 	return write_patterns_and_update(&pl);
     -@@
     - 	char *sparse_filename;
     - 	FILE *fp;
     - 
     --	if (sc_set_config(1))
     -+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
     - 		die(_("failed to change config"));
     - 
     - 	sparse_filename = get_sparse_checkout_filename();
     -@@
     - 	unlink(sparse_filename);
     - 	free(sparse_filename);
     - 
     --	return sc_set_config(0);
     -+	return sc_set_config(SPARSE_CHECKOUT_NONE);
     - }
     - 
     - int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     + 	result = write_patterns_and_update(&pl);
      
       diff --git a/dir.c b/dir.c
       --- a/dir.c
     @@ -299,10 +276,9 @@
       
      +int pl_hashmap_cmp(const void *unused_cmp_data,
      +		   const void *a, const void *b, const void *key);
     -+
     - struct pattern_list *add_pattern_list(struct dir_struct *dir,
     - 				      int group_type, const char *src);
     - int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
     + int hashmap_contains_parent(struct hashmap *map,
     + 			    const char *path,
     + 			    struct strbuf *buffer);
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -361,4 +337,3 @@
      +'
      +
       test_done
     - 
 11:  1d4321488e ! 11:  e06349fcec unpack-trees: hash less in cone mode
     @@ -19,21 +19,21 @@
      @@
       
       	if (hashmap_contains_path(&pl->recursive_hashmap,
     - 					&parent_pathname)) {
     + 				  &parent_pathname)) {
      -		result = MATCHED;
      +		result = MATCHED_RECURSIVE;
       		goto done;
       	}
       
      @@
     - 	while (parent_pathname.len) {
     - 		if (hashmap_contains_path(&pl->recursive_hashmap,
     - 					  &parent_pathname)) {
     --			result = UNDECIDED;
     -+			result = MATCHED_RECURSIVE;
     - 			goto done;
     - 		}
     + 	if (hashmap_contains_parent(&pl->recursive_hashmap,
     + 				    pathname,
     + 				    &parent_pathname))
     +-		result = MATCHED;
     ++		result = MATCHED_RECURSIVE;
       
     + done:
     + 	strbuf_release(&parent_pathname);
      
       diff --git a/dir.h b/dir.h
       --- a/dir.h
  -:  ---------- > 12:  3ef32084f5 unpack-trees: add progress to clear_ce_flags()
  -:  ---------- > 13:  3a677f32b6 read-tree: show progress by default
  -:  ---------- > 14:  56444a5498 sparse-checkout: sanitize for nested folders
  -:  ---------- > 15:  a6f17e9a77 sparse-checkout: update working directory in-process
  -:  ---------- > 16:  8927494b8c sparse-checkout: write using lockfile
  -:  ---------- > 17:  7f377c1407 sparse-checkout: cone mode should not interact with .gitignore

-- 
gitgitgadget
