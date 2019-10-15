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
	by dcvr.yhbt.net (Postfix) with ESMTP id 477371F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbfJON4N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44219 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfJON4N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so23984690wrl.11
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sZirKfT27+Ssx068hMkSI0+aD9w3bi9w44mPtw/u0ec=;
        b=Cvef42P2RASpQyIddKluSt1Nu0ZMAzzKVVATeDpNiqKCGLcbYRfKX4L3sCfQE1/F0R
         //mCDrImQe2UUbr2fC0UT5MHYeVMbpkZjzD7LVTViGakp2C8dauf921bTatSGKxKIWEm
         9Pq9FbVyVg1/3aS/5qeXFBxHJqsvLfL6RMG+GkYSZ3JBEe/2k+QM0r1BOOEOW9nCiMLA
         /lUwcRUwMgn5Qhpaz6wQ9qIp0Medi171pYwVsrwxU5tlE4g2kHFIDCBNkfZEkDpjGEl/
         8fKtltDl8y5s6cB3KUbazKHEQL4UP9Z++bcu3Ty4aH/P7h34k+NSl8irWt7BMNwcHr/3
         LKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sZirKfT27+Ssx068hMkSI0+aD9w3bi9w44mPtw/u0ec=;
        b=Sd6nX1e3fielJRCEeOt3rLjY0j8tSVsADfXRLPiWUisD8g4MXnWwgPl4YaJvIhjzoT
         B9bDNKTQP8M3njn0z4cPymzucZWydUxFUljS+14Zkdu0VfULhm8cPFKp0++q6zetbKC0
         M2HlW1UKYLxe4vaXLtHT6t3sWTqRSI9TQgXBwGcWdEjz/yVsY3gnr/7KGyx2idyy8nKX
         hph/F3v8QXXqlsV3tvkqg/d/JTTMKRNfIjPhAuuijAorkqIUzn5SsXX+tlUYfpFY5s/W
         eX1v7YMrIBNF1OZg2CQ9gZpbzitu2RLNvWUcAhP7VF+otwBx5fe9A+ouBS65e4Ocy58G
         FyTQ==
X-Gm-Message-State: APjAAAXb8r5F33exTcO5H+j2jN++nTiuNhf2Xa4Cqamqoo4YgXFva3C+
        LnLSRVYG23NL1sauXwC8JTRsdw9q
X-Google-Smtp-Source: APXvYqxxpXKlDLSOcSa7zHk/EUwHQLctOCs5d0LQf0gsbI+paHi63PAXvBtVNSoaEj68wfU5+biHLw==
X-Received: by 2002:adf:9403:: with SMTP id 3mr32849631wrq.281.1571147767050;
        Tue, 15 Oct 2019 06:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23sm7485175wmg.42.2019.10.15.06.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:06 -0700 (PDT)
Message-Id: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:47 +0000
Subject: [PATCH v4 00/17] New sparse-checkout builtin and "cone" mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V4 UPDATE: Rebased on latest master to include ew/hashmap and
ds/include-exclude in the base.

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
   
   

Updates in V4:

 * Updated hashmap API usage to respond to ew/hashmap
   
   
 * Responded to detailed review by Elijah. Thanks!
   
   
 * Marked the feature as experimental in git-sparse-checkout.txt the same
   way that git-switch.txt does.
   
   

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
 Documentation/git-sparse-checkout.txt | 150 ++++++++
 Makefile                              |   1 +
 builtin.h                             |   1 +
 builtin/clone.c                       |  27 ++
 builtin/read-tree.c                   |   3 +-
 builtin/sparse-checkout.c             | 482 ++++++++++++++++++++++++++
 cache.h                               |   6 +-
 config.c                              |   5 +
 dir.c                                 | 207 ++++++++++-
 dir.h                                 |  36 ++
 environment.c                         |   1 +
 git.c                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 279 +++++++++++++++
 unpack-trees.c                        | 110 ++++--
 unpack-trees.h                        |   3 +-
 19 files changed, 1285 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-316%2Fderrickstolee%2Fsparse-checkout%2Fupstream-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-316/derrickstolee/sparse-checkout/upstream-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/316

Range-diff vs v3:

  1:  30a0db68cd !  1:  63626e1097 sparse-checkout: create builtin with 'list' subcommand
     @@ -75,6 +75,8 @@
      +Initialize and modify the sparse-checkout configuration, which reduces
      +the checkout to a set of directories given by a list of prefixes.
      +
     ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     ++
      +
      +COMMANDS
      +--------
     @@ -96,7 +98,7 @@
      +The `$GIT_DIR/info/sparse-checkout` file is used to define the
      +skip-worktree reference bitmap. When Git updates the working
      +directory, it updates the skip-worktree bits in the index based
     -+ont this file. The files matching the patterns in the file will
     ++on this file. The files matching the patterns in the file will
      +appear in the working directory, and the rest will not.
      +
      +## FULL PATTERN SET
  2:  08bb6fb7f3 !  2:  65d26de1c2 sparse-checkout: create 'init' subcommand
     @@ -32,10 +32,9 @@
      +	by Git. Add patterns to the sparse-checkout file to
      +	repopulate the working directory.
      ++
     -+The init subcommand also enables the 'extensions.worktreeConfig' setting
     -+and sets the `core.sparseCheckout` setting in the worktree-specific config
     -+file. This prevents the sparse-checkout feature from interfering with other
     -+worktrees.
     ++To avoid interfering with other worktrees, it first enables the
     ++`extensions.worktreeConfig` setting and makes sure to set the
     ++`core.sparseCheckout` setting in the worktree-specific config file.
       
       SPARSE CHECKOUT
       ----------------
     @@ -72,8 +71,8 @@
      +}
      +
      +enum sparse_checkout_mode {
     -+	MODE_NONE = 0,
     -+	MODE_FULL = 1,
     ++	MODE_NO_PATTERNS = 0,
     ++	MODE_ALL_PATTERNS = 1,
      +};
      +
      +static int sc_set_config(enum sparse_checkout_mode mode)
     @@ -107,7 +106,7 @@
      +	FILE *fp;
      +	int res;
      +
     -+	if (sc_set_config(MODE_FULL))
     ++	if (sc_set_config(MODE_ALL_PATTERNS))
      +		return 1;
      +
      +	memset(&pl, 0, sizeof(pl));
  3:  c8587a1fb0 !  3:  e59ed7128f clone: add --sparse mode
     @@ -22,8 +22,9 @@
      
          During the 'git sparse-checkout init' call, we must first look
          to see if HEAD is valid, since 'git clone' does not have a valid
     -    HEAD. The first checkout will create the HEAD ref and update the
     -    working directory correctly.
     +    HEAD at the point where it initializes the sparse-checkout. The
     +    following checkout within the clone command will create the HEAD
     +    ref and update the working directory correctly.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -121,7 +122,7 @@
       	int res;
      +	struct object_id oid;
       
     - 	if (sc_set_config(MODE_FULL))
     + 	if (sc_set_config(MODE_ALL_PATTERNS))
       		return 1;
      @@
       	fprintf(fp, "/*\n!/*/\n");
  4:  6ce1d60b38 !  4:  502b4b08f0 sparse-checkout: 'set' subcommand
     @@ -17,8 +17,8 @@
       --- a/Documentation/git-sparse-checkout.txt
       +++ b/Documentation/git-sparse-checkout.txt
      @@
     - file. This prevents the sparse-checkout feature from interfering with other
     - worktrees.
     + `extensions.worktreeConfig` setting and makes sure to set the
     + `core.sparseCheckout` setting in the worktree-specific config file.
       
      +'set'::
      +	Write a set of patterns to the sparse-checkout file, as given as
  5:  0b1ed06bc8 =  5:  2852cf8e11 sparse-checkout: add '--stdin' option to set subcommand
  6:  22b9bd21f4 !  6:  55f95f290e sparse-checkout: create 'disable' subcommand
     @@ -24,7 +24,7 @@
       ----------------
       
      @@
     - ont this file. The files matching the patterns in the file will
     + on this file. The files matching the patterns in the file will
       appear in the working directory, and the rest will not.
       
      +To enable the sparse-checkout feature, run `git sparse-checkout init` to
     @@ -82,7 +82,7 @@
      +	char *sparse_filename;
      +	FILE *fp;
      +
     -+	if (sc_set_config(MODE_FULL))
     ++	if (sc_set_config(MODE_ALL_PATTERNS))
      +		die(_("failed to change config"));
      +
      +	sparse_filename = get_sparse_checkout_filename();
     @@ -96,7 +96,7 @@
      +	unlink(sparse_filename);
      +	free(sparse_filename);
      +
     -+	return sc_set_config(MODE_NONE);
     ++	return sc_set_config(MODE_NO_PATTERNS);
      +}
      +
       int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
  7:  2c53ea13d0 =  7:  3d8f2f2007 trace2: add region in clear_ce_flags
  8:  a66ec1affc =  8:  03dc0ed716 sparse-checkout: add 'cone' mode
  9:  431933bec6 !  9:  28606a152c sparse-checkout: use hashmaps for cone patterns
     @@ -33,6 +33,8 @@
          While this example is contrived, it demonstrates how these
          patterns can slow the sparse-checkout feature.
      
     +    Helped-by: Eric Wong <e@80x24.org>
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/dir.c b/dir.c
     @@ -43,10 +45,14 @@
       }
       
      +static int pl_hashmap_cmp(const void *unused_cmp_data,
     -+			  const void *a, const void *b, const void *key)
     ++			  const struct hashmap_entry *a,
     ++			  const struct hashmap_entry *b,
     ++			  const void *key)
      +{
     -+	const struct pattern_entry *ee1 = (const struct pattern_entry *)a;
     -+	const struct pattern_entry *ee2 = (const struct pattern_entry *)b;
     ++	const struct pattern_entry *ee1 =
     ++			container_of(a, struct pattern_entry, ent);
     ++	const struct pattern_entry *ee2 =
     ++			container_of(b, struct pattern_entry, ent);
      +
      +	size_t min_len = ee1->patternlen <= ee2->patternlen
      +			 ? ee1->patternlen
     @@ -91,10 +97,11 @@
      +		translated = xmalloc(sizeof(struct pattern_entry));
      +		translated->pattern = truncated;
      +		translated->patternlen = given->patternlen - 2;
     -+		hashmap_entry_init(translated,
     ++		hashmap_entry_init(&translated->ent,
      +				   memhash(translated->pattern, translated->patternlen));
      +
     -+		if (!hashmap_get(&pl->recursive_hashmap, translated, NULL)) {
     ++		if (!hashmap_get_entry(&pl->recursive_hashmap,
     ++				       translated, ent, NULL)) {
      +			/* We did not see the "parent" included */
      +			warning(_("unrecognized negative pattern: '%s'"),
      +				given->pattern);
     @@ -103,8 +110,8 @@
      +			goto clear_hashmaps;
      +		}
      +
     -+		hashmap_add(&pl->parent_hashmap, translated);
     -+		hashmap_remove(&pl->recursive_hashmap, translated, &data);
     ++		hashmap_add(&pl->parent_hashmap, &translated->ent);
     ++		hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
      +		free(data);
      +		return;
      +	}
     @@ -119,16 +126,16 @@
      +
      +	translated->pattern = xstrdup(given->pattern);
      +	translated->patternlen = given->patternlen;
     -+	hashmap_entry_init(translated,
     ++	hashmap_entry_init(&translated->ent,
      +			   memhash(translated->pattern, translated->patternlen));
      +
     -+	hashmap_add(&pl->recursive_hashmap, translated);
     ++	hashmap_add(&pl->recursive_hashmap, &translated->ent);
      +
     -+	if (hashmap_get(&pl->parent_hashmap, translated, NULL)) {
     ++	if (hashmap_get_entry(&pl->parent_hashmap, translated, ent, NULL)) {
      +		/* we already included this at the parent level */
      +		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
      +			given->pattern);
     -+		hashmap_remove(&pl->parent_hashmap, translated, &data);
     ++		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
      +		free(data);
      +		free(translated);
      +	}
     @@ -137,8 +144,8 @@
      +
      +clear_hashmaps:
      +	warning(_("disabling cone pattern matching"));
     -+	hashmap_free(&pl->parent_hashmap, 1);
     -+	hashmap_free(&pl->recursive_hashmap, 1);
     ++	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
     ++	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
      +	pl->use_cone_patterns = 0;
      +}
      +
     @@ -150,8 +157,8 @@
      +	/* Check straight mapping */
      +	p.pattern = pattern->buf;
      +	p.patternlen = pattern->len;
     -+	hashmap_entry_init(&p, memhash(p.pattern, p.patternlen));
     -+	return !!hashmap_get(map, &p, NULL);
     ++	hashmap_entry_init(&p.ent, memhash(p.pattern, p.patternlen));
     ++	return !!hashmap_get_entry(map, &p, ent, NULL);
      +}
      +
      +int hashmap_contains_parent(struct hashmap *map,
 10:  69bd707e96 ! 10:  2ea3d8819b sparse-checkout: init and set in cone mode
     @@ -18,6 +18,8 @@
          we want to avoid the warning that the patterns do not match
          the cone-mode patterns.
      
     +    Helped-by: Eric Wong <e@80x24.org>
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     @@ -33,9 +35,9 @@
       	N_("git sparse-checkout [init|list|set|disable] <options>"),
      @@
       enum sparse_checkout_mode {
     - 	MODE_NONE = 0,
     - 	MODE_FULL = 1,
     -+	MODE_CONE = 2,
     + 	MODE_NO_PATTERNS = 0,
     + 	MODE_ALL_PATTERNS = 1,
     ++	MODE_CONE_PATTERNS = 2,
       };
       
       static int sc_set_config(enum sparse_checkout_mode mode)
     @@ -52,7 +54,7 @@
      +	argv_array_pushl(&cone_argv, "config", "--worktree",
      +			 "core.sparseCheckoutCone", NULL);
      +
     -+	if (mode == MODE_CONE)
     ++	if (mode == MODE_CONE_PATTERNS)
      +		argv_array_push(&cone_argv, "true");
      +	else
      +		argv_array_push(&cone_argv, "false");
     @@ -83,7 +85,7 @@
       	struct object_id oid;
      +	int mode;
       
     --	if (sc_set_config(MODE_FULL))
     +-	if (sc_set_config(MODE_ALL_PATTERNS))
      +	static struct option builtin_sparse_checkout_init_options[] = {
      +		OPT_BOOL(0, "cone", &init_opts.cone_mode,
      +			 N_("initialize the sparse-checkout in cone mode")),
     @@ -94,7 +96,7 @@
      +			     builtin_sparse_checkout_init_options,
      +			     builtin_sparse_checkout_init_usage, 0);
      +
     -+	mode = init_opts.cone_mode ? MODE_CONE : MODE_FULL;
     ++	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
      +
      +	if (sc_set_config(mode))
       		return 1;
     @@ -106,12 +108,12 @@
       
      +static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
      +{
     -+	struct pattern_entry *e = xmalloc(sizeof(struct pattern_entry));
     ++	struct pattern_entry *e = xmalloc(sizeof(*e));
      +	e->patternlen = path->len;
      +	e->pattern = strbuf_detach(path, NULL);
     -+	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
     ++	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
      +
     -+	hashmap_add(&pl->recursive_hashmap, e);
     ++	hashmap_add(&pl->recursive_hashmap, &e->ent);
      +
      +	while (e->patternlen) {
      +		char *slash = strrchr(e->pattern, '/');
     @@ -125,23 +127,22 @@
      +		e = xmalloc(sizeof(struct pattern_entry));
      +		e->patternlen = newlen;
      +		e->pattern = xstrndup(oldpattern, newlen);
     -+		hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
     ++		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
      +
     -+		if (!hashmap_get(&pl->parent_hashmap, e, NULL))
     -+			hashmap_add(&pl->parent_hashmap, e);
     ++		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
     ++			hashmap_add(&pl->parent_hashmap, &e->ent);
      +	}
      +}
      +
      +static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
      +{
      +	int i;
     -+	struct pattern_entry *entry;
     ++	struct pattern_entry *pe;
      +	struct hashmap_iter iter;
      +	struct string_list sl = STRING_LIST_INIT_DUP;
      +
     -+	hashmap_iter_init(&pl->parent_hashmap, &iter);
     -+	while ((entry = hashmap_iter_next(&iter)))
     -+		string_list_insert(&sl, entry->pattern);
     ++	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
     ++		string_list_insert(&sl, pe->pattern);
      +
      +	string_list_sort(&sl);
      +	string_list_remove_duplicates(&sl, 0);
     @@ -157,9 +158,8 @@
      +
      +	string_list_clear(&sl, 0);
      +
     -+	hashmap_iter_init(&pl->recursive_hashmap, &iter);
     -+	while ((entry = hashmap_iter_next(&iter)))
     -+		string_list_insert(&sl, entry->pattern);
     ++	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
     ++		string_list_insert(&sl, pe->pattern);
      +
      +	string_list_sort(&sl);
      +	string_list_remove_duplicates(&sl, 0);
     @@ -260,12 +260,16 @@
       }
       
      -static int pl_hashmap_cmp(const void *unused_cmp_data,
     --			  const void *a, const void *b, const void *key)
     +-			  const struct hashmap_entry *a,
     +-			  const struct hashmap_entry *b,
     +-			  const void *key)
      +int pl_hashmap_cmp(const void *unused_cmp_data,
     -+		   const void *a, const void *b, const void *key)
     ++		   const struct hashmap_entry *a,
     ++		   const struct hashmap_entry *b,
     ++		   const void *key)
       {
     - 	const struct pattern_entry *ee1 = (const struct pattern_entry *)a;
     - 	const struct pattern_entry *ee2 = (const struct pattern_entry *)b;
     + 	const struct pattern_entry *ee1 =
     + 			container_of(a, struct pattern_entry, ent);
      
       diff --git a/dir.h b/dir.h
       --- a/dir.h
     @@ -275,7 +279,9 @@
       		const char *name, int *dtype);
       
      +int pl_hashmap_cmp(const void *unused_cmp_data,
     -+		   const void *a, const void *b, const void *key);
     ++		   const struct hashmap_entry *a,
     ++		   const struct hashmap_entry *b,
     ++		   const void *key);
       int hashmap_contains_parent(struct hashmap *map,
       			    const char *path,
       			    struct strbuf *buffer);
     @@ -301,11 +307,13 @@
      +		a
      +		deep
      +	EOF
     ++	test_cmp expect dir &&
      +	ls repo/deep >dir  &&
      +	cat >expect <<-EOF &&
      +		a
      +		deeper1
      +	EOF
     ++	test_cmp expect dir &&
      +	ls repo/deep/deeper1 >dir  &&
      +	cat >expect <<-EOF &&
      +		a
 11:  e06349fcec = 11:  fefd1e1744 unpack-trees: hash less in cone mode
 12:  3ef32084f5 = 12:  034fbd31bd unpack-trees: add progress to clear_ce_flags()
 13:  3a677f32b6 = 13:  27aa9d22f0 read-tree: show progress by default
 14:  56444a5498 ! 14:  44c3078029 sparse-checkout: sanitize for nested folders
     @@ -22,43 +22,44 @@
          hashmap_contains_parent() method. It takes a strbuf buffer to
          avoid reallocating a buffer when calling in a tight loop.
      
     +    Helped-by: Eric Wong <e@80x24.org>
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
      @@
     - 	struct pattern_entry *entry;
     + 	struct pattern_entry *pe;
       	struct hashmap_iter iter;
       	struct string_list sl = STRING_LIST_INIT_DUP;
      +	struct strbuf parent_pattern = STRBUF_INIT;
       
     - 	hashmap_iter_init(&pl->parent_hashmap, &iter);
     --	while ((entry = hashmap_iter_next(&iter)))
     --		string_list_insert(&sl, entry->pattern);
     -+	while ((entry = hashmap_iter_next(&iter))) {
     -+		if (hashmap_get(&pl->recursive_hashmap, entry, NULL))
     +-	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
     +-		string_list_insert(&sl, pe->pattern);
     ++	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
     ++		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
      +			continue;
      +
      +		if (!hashmap_contains_parent(&pl->recursive_hashmap,
     -+					     entry->pattern,
     ++					     pe->pattern,
      +					     &parent_pattern))
     -+			string_list_insert(&sl, entry->pattern);
     ++			string_list_insert(&sl, pe->pattern);
      +	}
       
       	string_list_sort(&sl);
       	string_list_remove_duplicates(&sl, 0);
      @@
     + 
       	string_list_clear(&sl, 0);
       
     - 	hashmap_iter_init(&pl->recursive_hashmap, &iter);
     --	while ((entry = hashmap_iter_next(&iter)))
     --		string_list_insert(&sl, entry->pattern);
     -+	while ((entry = hashmap_iter_next(&iter))) {
     +-	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
     +-		string_list_insert(&sl, pe->pattern);
     ++	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
      +		if (!hashmap_contains_parent(&pl->recursive_hashmap,
     -+					     entry->pattern,
     ++					     pe->pattern,
      +					     &parent_pattern))
     -+			string_list_insert(&sl, entry->pattern);
     ++			string_list_insert(&sl, pe->pattern);
      +	}
      +
      +	strbuf_release(&parent_pattern);
 15:  a6f17e9a77 ! 15:  9ccec3ca9a sparse-checkout: update working directory in-process
     @@ -10,7 +10,7 @@
      
          Remove this extra process call by creating a direct call to
          unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
     -    adition, provide an in-memory list of patterns so we can avoid
     +    addition, provide an in-memory list of patterns so we can avoid
          reading from the sparse-checkout file. This allows us to test a
          proposed change to the file before writing to it.
      
     @@ -109,12 +109,12 @@
       			     builtin_sparse_checkout_init_options,
       			     builtin_sparse_checkout_init_usage, 0);
       
     --	mode = init_opts.cone_mode ? MODE_CONE : MODE_FULL;
     +-	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
      +	if (init_opts.cone_mode) {
     -+		mode = MODE_CONE;
     ++		mode = MODE_CONE_PATTERNS;
      +		core_sparse_checkout_cone = 1;
      +	} else
     -+		mode = MODE_FULL;
     ++		mode = MODE_ALL_PATTERNS;
       
       	if (sc_set_config(mode))
       		return 1;
     @@ -128,20 +128,12 @@
       }
       
       static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
     - {
     --	struct pattern_entry *e = xmalloc(sizeof(struct pattern_entry));
     -+	struct pattern_entry *e = xmalloc(sizeof(*e));
     -+
     - 	e->patternlen = path->len;
     - 	e->pattern = strbuf_detach(path, NULL);
     - 	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
      @@
       {
       	char *sparse_filename;
       	FILE *fp;
     --
      +	int result;
     -+	
     + 
       	if (!core_apply_sparse_checkout) {
       		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
       		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
     @@ -193,20 +185,6 @@
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
     -@@
     - 		a
     - 		deep
     - 	EOF
     -+	test_cmp dir expect &&
     - 	ls repo/deep >dir  &&
     - 	cat >expect <<-EOF &&
     - 		a
     - 		deeper1
     - 	EOF
     -+	test_cmp dir expect &&
     - 	ls repo/deep/deeper1 >dir  &&
     - 	cat >expect <<-EOF &&
     - 		a
      @@
       	test_cmp repo/.git/info/sparse-checkout expect
       '
 16:  8927494b8c ! 16:  d0421ef7b2 sparse-checkout: write using lockfile
     @@ -23,7 +23,7 @@
      +	int fd;
      +	struct lock_file lk = LOCK_INIT;
       	int result;
     - 	
     + 
       	if (!core_apply_sparse_checkout) {
      @@
       
 17:  7f377c1407 = 17:  ed1f148763 sparse-checkout: cone mode should not interact with .gitignore

-- 
gitgitgadget
