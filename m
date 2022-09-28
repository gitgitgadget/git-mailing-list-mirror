Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C727C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiI1Ic5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI1Ico (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:32:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76289CC6
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:32:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x18so18593024wrm.7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=AcnxC6uNUUxTOy2zpLYZBKFroHDfOBtKAAoJGJdefo4=;
        b=D4gpp4r50EZvu2TYyrLVM6GvQANOI/tgIcr8fUXJTV72ZnbEEHjIjC7GDZP/OJF/w1
         DS93iexoGdrjzgB9W1gI2tSwhtp8P209HddX8vP51T+quRbvFQV2vkCic1zmWUTuNO6S
         poydHXafG7ay+0h+tg+YUmKCYhR0XEf1EJovoTlg6dPEfx681lD5x6iofEfG2GBsaPpu
         RxsymiCXQJs7YWPCn/fzuNJm3prQXC4Mgzw6hdbiRxJVH7IIgt5Hag7rKH5KgBvivXqU
         K4VMzNAzfOwnVMo9XUms960/KQyN4QgKTB61H2N8LBDoLDUwGIURV5aKeilryoyeYDNS
         vG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AcnxC6uNUUxTOy2zpLYZBKFroHDfOBtKAAoJGJdefo4=;
        b=RPLSY6ib/g2GMZJKckJ1BD1f5U+STw42fjoJDVxdlwqeAjmetq4WmpzpmtD9NrDKIN
         KqFUgXorC6VBuy47kUEGtmlTeUxm6Aum1asxwTYOpIjaAfQQ7owt78CRgbs+QaEQiSIo
         q68vOdHUKHTLXudL/kzBogzGloK68OJH4ue7dNPmLpWAF1FbAj4SiUGC56xWUSQLxlnb
         AXzGrUZVTTD4x9JBZ1l67XptYrvkoTvEzW67eljpkFDGgECdk7W5/+MHqskqiAcTaN7N
         Kca7XfsgqjmaJOUJ649/EP5PwedHN6XxSBcSObZftVhBo/eoIixSwiy2OK1LA30pf1mK
         lnCQ==
X-Gm-Message-State: ACrzQf0KybkiWwd2ZR+NotF37ciur2Dt4X/YUgIry552RQ1eWdXMWqBR
        FYcHCsvqei9hb8CLBCWkXDacb0Hkjd0=
X-Google-Smtp-Source: AMsMyM7UuYGltUBpu+CYDaEZpOX1gmaC0jEYqTEIyJdacA4DsLsjlnN5wHgF6m1U52lFHEDtbAKg3A==
X-Received: by 2002:a5d:47a4:0:b0:226:e547:b602 with SMTP id 4-20020a5d47a4000000b00226e547b602mr20235491wrb.406.1664353954484;
        Wed, 28 Sep 2022 01:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003b4bd18a23bsm1104253wma.12.2022.09.28.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:32:32 -0700 (PDT)
Message-Id: <pull.1367.v2.git.1664353951797.gitgitgadget@gmail.com>
In-Reply-To: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 08:32:31 +0000
Subject: [PATCH v2] sparse-checkout.txt: new document with sparse-checkout
 directions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Once upon a time, Matheus wrote some patches to make
   git grep [--cached | <REVISION>] ...
restrict its output to the sparsity specification when working in a
sparse checkout[1].  That effort got derailed by two things:

  (1) The --sparse-index work just beginning which we wanted to avoid
      creating conflicts for
  (2) Never deciding on flag and config names and planned high level
      behavior for all commands.

More recently, Shaoxuan implemented a more limited form of Matheus'
patches that only affected --cached, using a different flag name,
but also changing the default behavior in line with what Matheus did.
This again highlighted the fact that we never decided on command line
flag names, config option names, and the big picture path forward.

The --sparse-index work has been mostly complete (or at least released
into production even if some small edges remain) for quite some time
now.  We have also had several discussions on flag and config names,
though we never came to solid conclusions.  Stolee once upon a time
suggested putting all these into some document in
Documentation/technical[3], which Victoria recently also requested[4].
I'm behind the times, but here's a patch attempting to finally do that.

Note that the "Implementation Questions" section is pretty large,
reflecting the fact that this is perhaps more RFC than proposal.

[1] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/
    (See his second link in that email in particular)
[2] https://lore.kernel.org/git/20220908001854.206789-2-shaoxuan.yuan02@gmail.com/
[3] https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/
    (Scroll to the very end for the final few paragraphs)
[4] https://lore.kernel.org/git/cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    [RFC] sparse-checkout.txt: new document with sparse-checkout directions
    
    As discussion has shown so far, we seem to have a variety of different
    ideas in a number of areas, and sometimes are pulling a bit in different
    directions. But the discussion is very illuminating. Anyway, take any
    proposal or option names with a big grain of salt and don't consider
    anything final. Thoughts and opinions still very much welcome.
    
    (I've worked really hard to get this document out, because I feel bad
    that I've blocked multiple contributors' changes in this area over
    concerns of not having a clear direction and possibly painting ourselves
    into corners. But it's taken a lot of time, so I may have to back off
    for a bit, so I may wait a week or two to respond further to this topic.
    That might be better anyway, because it's long enough that folks may
    need time to digest it and all its updates.)
    
    Changes since v1:
    
     * Added new sections:
       * "Terminology"
       * "Behavior classes"
       * "Sparse specification vs. sparsity patterns"
     * Tried to shuffle commands from unknown into appropriate sections
       based on feedback, but I got some conflicting feedback, so...who
       knows if thing are in the right place
     * More consistency in using "sparse specification" over other terms
     * Extra comments about how add/rm/mv operate on moving files across the
       tracked/untracked boundary
     * --restrict-but-warn should have been "restrict or error", but
       reworded even more heavily as part of "Behavior classes" section
     * Added extra questions based on feedback (--no-expand, update-index
       stuff, apply --index)
     * More details on apply/am bugs
     * Documented read-tree issue
     * A few cases of fixing line wrapping at <=80 chars
     * Added more alternate name suggestions for options instead of
       --[no-]restrict

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1367%2Fnewren%2Fsparse-checkout-directions-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1367/newren/sparse-checkout-directions-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1367

Range-diff vs v1:

 1:  3b6b1910eb4 ! 1:  d20e63206dc sparse-checkout.txt: new document with sparse-checkout directions
     @@ Documentation/technical/sparse-checkout.txt (new)
      @@
      +Table of contents:
      +
     ++  * Terminology
      +  * Purpose of sparse-checkouts
      +  * Desired behavior
     ++  * Behavior classes
      +  * Subcommand-dependent defaults
     ++  * Sparse specification vs. sparsity patterns
      +  * Implementation Questions
      +  * Implementation Goals/Plans
      +  * Known bugs
      +  * Reference Emails
      +
      +
     ++=== Terminology ===
     ++
     ++cone mode: one of two modes for specifying the desired subset of files
     ++	in a sparse-checkout.  In cone-mode, the user specifies
     ++	directories (getting both everything under that directory as
     ++	well as everything in leading directories), while in non-cone
     ++	mode, the user specifies gitignore-style patterns.  Controlled
     ++	by the --[no-]cone option to sparse-checkout init|set.
     ++
     ++SKIP_WORKTREE: When tracked files do not match the sparse specification and
     ++	are removed from the working tree, the file in the index is marked
     ++	with a SKIP_WORKTREE bit.  Note that if a tracked file has the
     ++	SKIP_WORKTREE bit set but is later written by the user to the
     ++	working tree anyway, the SKIP_WORKTREE bit will be cleared at the
     ++	beginning of any Git operation.
     ++
     ++	Most sparse checkout users are unaware of this implementation
     ++	detail, and the term should generally be avoided in user-facing
     ++	descriptions and command flags.  Unfortunately, prior to the
     ++	`sparse-checkout` subcommand these low-level details were exposed,
     ++	and as of time of writing, still are in various places.
     ++
     ++sparse-checkout: a subcommand in git used to reduce the files present in
     ++	the working tree to a subset of all tracked files.  Also, the
     ++	name of the file in the $GIT_DIR/info directory used to track
     ++	the sparsity patterns corresponding to the user's desired
     ++	subset.
     ++
     ++sparse cone: see cone mode
     ++
     ++sparse directory: An entry in the index corresponding to a directory
     ++	rather, and used to replace all files under that directory that
     ++	would normally appear in the index.  See also sparse-index.
     ++	Something that can cause confusion is that the "sparse
     ++	directory" does NOT match the sparse specification, i.e. the
     ++	directory is NOT present in the working tree.
     ++
     ++sparse index: A special mode for sparse-checkout that also makes the
     ++	index sparse by recording a directory entry in lieu of all the
     ++	files underneath that directory.  Controlled by the
     ++	--[no-]sparse-index option to init|set|reapply.  See also
     ++	"sparse directory".
     ++
     ++sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
     ++	define the set of files of interest.  A warning: It is easy to
     ++	over-use this term (or the shortened "patterns" term), for two
     ++	reasons (1) users in cone mode specify directories rather
     ++	than patterns (their directories are transformed into patterns,
     ++	but users may think you are talking about non-cone mode if you
     ++	use the word "patterns"), and (b) the sparse specification might
     ++	transiently differ in the working tree from the sparsity
     ++	patterns (see "Sparse specification vs. sparsity patterns").
     ++
     ++sparse specification: The set of paths in the user's area of focus.  When
     ++	interacting with the working tree, this is the set of tracked files
     ++	present in the working copy or with a clear SKIP_WORKTREE bit.
     ++	When working with history, this is the set of files matching the
     ++	sparsity patterns.  Usually the tracked files present in the
     ++	working copy are precisely the set of tracked files matching
     ++	sparsity patterns, but they can temporarily differ.  (See also
     ++	"Sparse specification vs. sparsity patterns")
     ++
     ++vivifying: When a command restores a tracked file to the working tree
     ++	(and clearing the SKIP_WORKTREE bit in the index), this is
     ++	referred to as "vivifying" the file.
     ++
     ++
      +=== Purpose of sparse-checkouts ===
      +
      +sparse-checkouts exist to allow users to work with a subset of their
      +files.
      +
     -+The idea is simple enough, but there are two different high-level
     -+usecases which affect how some Git subcommands should behave.  Further,
     -+even if we only considered one of those usecases, sparse-checkouts
     -+modify different subcommands in over a half dozen different ways.  Let's
     -+start by considering the high level usecases in this section:
     ++You can think of sparse-checkouts as subdividing "tracked" files into
     ++two categories -- a sparse subset, and all the rest.
     ++Implementationally, we mark "all the rest" with SKIP_WORKTREE.  The
     ++SKIP_WORKTREE files are still tracked, just not present in the working
     ++tree.
     ++
     ++In the past, sparse-checkouts were defined by "SKIP_WORKTREE means the file
     ++is missing from the working tree but pretend the file matches HEAD".  That
     ++was a low-level detail which provided decent behavior for a few commands,
     ++but which had a surprising number of ways in which it violated user
     ++expectations and was a bad mental model.  However, it persisted for many
     ++years and may still be found in some corners of the code base.
     ++
     ++Anyway, the idea of "working with a subset of files" is simple enough, but
     ++there are two different high-level usecases which affect how some Git
     ++subcommands should behave.  Further, even if we only considered one of
     ++those usecases, sparse-checkouts modify different subcommands in over a
     ++half dozen different ways.  Let's start by considering the high level
     ++usecases:
      +
      +  A) Users are _only_ interested in the sparse portion of the repo
      +
     @@ Documentation/technical/sparse-checkout.txt (new)
      +outside the sparsity specification, then the partial clone will attempt
      +to download additional blobs on demand, fail, and then fail the user's
      +command.  (This may be unavoidable in some cases, e.g. when `git merge`
     -+has non-trivial changes to reconcile outside the sparsity path, but we
     -+should limit how often users are forced to connect to the network.)
     ++has non-trivial changes to reconcile outside the sparse specification,
     ++but we should limit how often users are forced to connect to the
     ++network.)
      +
      +Also, even for users using partial clones that do not mind being
      +always connected to the network, the need to download blobs as
     @@ Documentation/technical/sparse-checkout.txt (new)
      +you are interested in or that depends upon one of your
      +dependencies...AND you need all the dependencies of that expanded group.
      +That can easily change your sparse-checkout into a nearly dense one.
     ++
      +Naturally, that tends to kill the benefits of sparse-checkouts.  There
      +are a couple solutions to this conundrum: either avoid grabbing
      +dependencies (maybe have built versions of your dependencies pulled from
     @@ Documentation/technical/sparse-checkout.txt (new)
      +
      +  * commands that only look at files within the sparsity specification
      +
     -+      * status
      +      * diff (without --cached or REVISION arguments)
      +      * grep (without --cached or REVISION arguments)
     ++      * diff-files
      +
     -+  * commands that restore files to the working tree that match sparsity patterns, and
     -+    remove unmodified files that don't match those patterns:
     ++  * commands that restore files to the working tree that match sparsity
     ++    patterns, and remove unmodified files that don't match those
     ++    patterns:
      +
      +      * switch
      +      * checkout (the switch-like half)
     @@ Documentation/technical/sparse-checkout.txt (new)
      +      * cherry-pick
      +      * revert
      +
     ++      * `am` and `apply --index` should probably be in this section but are buggy
     ++	(see the "Known bugs" section below)
     ++
      +    Note that this somewhat depends upon the merge strategy being used:
      +      * `ort` behaves as described above
      +      * `recursive` tries to not vivify files unnecessarily, but does sometimes
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    and whether those paths match sparsity patterns or not):
      +
      +      * stash
     -+
     -+      * am/apply probably should be in the above category, but need to be fixed to
     -+	auto-vivify instead of failing
     ++      * apply (without `--index` or `--cached`)
      +
      +* Commands that differ for behavior A vs. behavior B:
      +
     -+  * commands that make modifications:
     ++  * commands that make modifications to which files are tracked:
      +      * add
      +      * rm
      +      * mv
     ++      * update-index
     ++
     ++    The fact that files can move between the 'tracked' and 'untracked'
     ++    categories means some commands will have to treat untracked files
     ++    differently.  But if we have to treat untracked files differently,
     ++    then additional commands may also need changes:
     ++
     ++      * status
     ++      * clean
     ++
     ++    In particular, `status` may need to report any untracked files outside
     ++    the sparsity specification as an erroneous condition (especially to
     ++    avoid the user trying to `git add` them, forcing `git add` to display
     ++    an error).
     ++
     ++    It's not clear to me exactly how (or if `clean` would change, but it's
     ++    the other command that also affects untracked files.
     ++
     ++    `update-index` may be slightly special.  Its --[no-]skip-worktree flag
     ++    may need to ignore the sparse specification by its nature.  Also, its
     ++    current --[no-]ignore-skip-worktree-entries default is totally bogus.
      +
      +  * commands that query history
      +      * diff (with --cached or REVISION arguments)
      +      * grep (with --cached or REVISION arguments)
      +      * show (when given commit arguments)
      +      * bisect
     -+      * blame
     ++      * blame (only matters when one or more -C flags passed)
      +	* and annotate
      +      * log
     -+	* and variants: shortlog, gitk, show-branch, whatchanged
     -+
     -+* Comands I don't know how to classify
     -+
     -+  * ls-files
     ++	* and variants: shortlog, gitk, show-branch, whatchanged, rev-list
     ++      * ls-files
     ++      * diff-index
     ++      * diff-tree
     ++      * ls-tree
      +
     -+    Shows all tracked files by default, and with an option can show
     -+    sparse directory entries instead of expanding them.  Should there be
     -+    a way to restrict to just the non SKIP_WORKTREE files?
     ++    ls-files may be slightly special in that e.g. `git ls-files -t` is
     ++    often used to see what is sparse and what is not.  Perhaps -t should
     ++    always work on the full tree?
      +
     -+    Note that `git ls-files -t` is often used to see what is sparse and
     -+    what is not, which only works with a non-restricted assumption.
     -+
     -+  * checkout-index
     -+
     -+    should it be like `checkout` and pay attention to sparsity paths, or
     -+    be considered special and write to working tree anyway?  The
     -+    interaction with --prefix, and the use of specifically named files
     -+    (rather than globs) makes me wonder.
     -+
     -+  * update-index
     -+
     -+    The --[no-]ignore-skip-worktree-entries default is totally bogus,
     -+    but otherwise this command seems okay?  Not sure what category it
     -+    would go under, though.
     ++* Commands I don't know how to classify
      +
      +  * range-diff
      +
     @@ Documentation/technical/sparse-checkout.txt (new)
      +
      +    See range-diff
      +
     -+  * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
     -+
     -+    should these be tweaked or always operate full-tree?
     -+
      +* Commands unaffected by sparse-checkouts
      +
      +  * branch
     -+  * clean (works on untracked files, whereas SKIP_WORKTREE files are still tracked)
      +  * describe
      +  * fetch
      +  * gc
     @@ Documentation/technical/sparse-checkout.txt (new)
      +  * merge-index
      +
      +
     ++=== Behavior classes ====
     ++
     ++From the above there are a few classes of behavior:
     ++
     ++  * "restrict"
     ++
     ++    Commands in this class only read or write files within the sparse
     ++    specification.  Some of these commands may also attempt, at the end of
     ++    their operation, to cull transient differences between the sparse
     ++    specification and the sparsity patterns (see "Sparse specification
     ++    vs. sparsity patterns" for details, but this basically means either
     ++    removing unmodified files not matching the sparsity patterns and
     ++    marking those files as SKIP_WORKTREE, or vivifying files that match the
     ++    sparsity patterns and marking those files as !SKIP_WORKTREE).
     ++
     ++  * "restrict modulo conflicts"
     ++
     ++    Commands in this class generally behave like the "restrict" class,
     ++    except that:
     ++      (1) they ignore the sparse specification in terms of updates to the
     ++	  index, though they'll preserve or update the SKIP_WORKTREE bit
     ++	  for files as needed to follow the sparsity patterns.
     ++      (2) they will ignore the sparse specification and write files with
     ++	  conflicts to the working tree (thus temporarily expanding the
     ++	  sparse specification to include such files.)
     ++
     ++  * "restrict also specially applied to untracked files"
     ++
     ++    Commands in this class generally behave like the "restrict" class,
     ++    except that they have to handle untracked files differently too, often
     ++    because these commands are dealing with files changing state between
     ++    'tracked' and 'untracked'.  Often, this may mean printing an error
     ++    message if the command had nothing to do, but the arguments may have
     ++    referred to files whose tracked-ness state could have changed were it
     ++    not for the sparsity patterns excluding them.
     ++
     ++  * "no restrict"
     ++
     ++    Commands in this class ignore the sparse specification entirely.
     ++
     ++  * "restrict or no restrict dependent upon behavior A vs. behavior B"
     ++
     ++    Commands in this class behave like "no restrict" for folks in the
     ++    behavior B camp, and like "restrict" for folks in the behavior A camp.
     ++    However, when behaving like "restrict" a warning of some sort might be
     ++    provided that history queries have been limited by the sparse-checkout
     ++    specification.
     ++
     ++
      +=== Subcommand-dependent defaults ===
      +
     -+Note that we have different defaults (for the desired behavior, not just
     -+the current implementation) depending on the command:
     ++Note that we have different defaults depending on the command for the
     ++desired behavior :
      +
     -+  * Commands defaulting to --restrict:
     ++  * Commands defaulting to "restrict":
      +    * status
      +    * diff (without --cached or REVISION arguments)
      +    * grep (without --cached or REVISION arguments)
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    * reset (--hard)
      +    * restore/checkout
      +    * checkout-index
     ++    * diff-files
      +
      +    This behavior makes sense; these interact with the working tree.
      +
     -+  * Commands defaulting to --restrict-unless-conflicts
     ++  * Commands defaulting to "restrict modulo conflicts":
      +    * merge
      +    * rebase
      +    * cherry-pick
      +    * revert
      +
     ++    * am
     ++    * apply --index
     ++
      +    These also interact with the working tree, but require slightly different
      +    behavior so that conflicts can be resolved.
      +
     -+  * Commands defaulting to --no-restrict
     ++    (See also the "Known bugs" section below regarding `am` and `apply`)
     ++
     ++  * Commands defaulting to "no restrict":
      +    * archive
      +    * bundle
      +    * commit
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    * fast-import
      +    * commit-tree
      +
     -+    * ls-files
      +    * stash
     -+    * am
     -+    * apply
     ++    * apply (without `--index`)
      +
     -+    These have completely different defaults and perhaps deserve the most detailed
     -+    explanation:
     ++    These have completely different defaults and perhaps deserve the most
     ++    detailed explanation:
      +
      +    In the case of commands in the first group (format-patch,
      +    fast-export, bundle, archive, etc.), these are commands for
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    In the case of stash, it needs to vivify files to avoid losing the
      +    user's changes.
      +
     -+    In the case of am and apply, those commands only operate on the
     -+    working tree, so they are kind of in the same boat as stash.
     -+    Perhaps `git am` could run `git sparse-checkout reapply`
     -+    automatically afterward and move into a category more similar to
     -+    merge/rebase/cherry-pick, but it'd still be weird because it'd
     -+    vivify files besides just conflicted ones when there are conflicts.
     -+
     -+    In the case of ls-files, `git ls-files -t` is often used to see what
     -+    is sparse and not, in which case restricting would not make sense.
     -+    Also, ls-files has traditionally been used to get a list of "all
     -+    tracked files", which would suggest not restricting.  But it's
     -+    slightly funny, because sparse-checkouts essentially split tracked
     -+    files into two categories -- those in the sparse specification and
     -+    those outside -- and how does the user specify which of those two
     -+    types of tracked files they want?
     -+
     -+  * Commands defaulting to --restrict-but-warn (although Behavior A vs. Behavior B
     -+    may affect how verbose the warnings are):
     ++    In the case of apply without `--index`, that command needs to update
     ++    the working tree without the index (or the index without the working
     ++    tree if `--cached` is passed), and if we restrict those updates to the
     ++    sparse specification then we'll lose changes from the user.
     ++
     ++  * Commands defaulting to "restrict also specially applied to untracked files":
      +    * add
      +    * rm
      +    * mv
      +
     -+    The defaults here perhaps make sense since they are nearly --restrict, but
     -+    actually using --restrict could cause user confusion if users specify a
     -+    specific filename, so they warn by default.  That logic may sound like
     -+    --no-restrict should be the default, but that's prone to even bigger confusion:
     -+      * `git add <somefile>` if honored and outside the sparse cone, can result in
     -+	the file randomly disappearing later when some subsequent command is run
     -+	(since various commands automatically clean up unmodified files outside
     -+	the sparsity specification).
     -+      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
     -+	outside the range of the user's interest.  Much better to operate on the
     -+	sparsity specification and give the user warnings if other files could have
     -+	matched.
     -+      * `git mv` has similar surprises when moving into or out of the cone, so
     -+	best to restrict and throw warnings if restriction might affect the result.
     -+
     -+    There may be a difference in here between behavior A and behavior B.
     -+    For behavior A, we probably only want to warn if there were no
     -+    suitable matches for files in the sparsity specification, whereas
     -+    for behavior B, we may want to warn even if there are valid files to
     -+    operate on if the result would have been different under
     -+    `--no-restrict`.
     -+
     -+  * Commands whose default for --restrict vs. --no-restrict should vary depending
     -+    on Behavior A or Behavior B
     ++    Our original implementation for these commands was "no restrict", but
     ++    it had some severe usability issues:
     ++      * `git add <somefile>` if honored and outside the sparse
     ++	specification, can result in the file randomly disappearing later
     ++	when some subsequent command is run (since various commands
     ++	automatically clean up unmodified files outside the sparse
     ++	specification).
     ++      * `git rm '*.jpg'` could very negatively surprise users if it deletes
     ++	files outside the range of the user's interest.
     ++      * `git mv` has similar surprises when moving into or out of the cone,
     ++	so best to restrict by default
     ++
     ++    So, we switched `add` and `rm` to default to "restrict", which made
     ++    usability problems much less severe and less frequent, but we still got
     ++    complaints because commands like:
     ++	git add <file-outside-sparse-specification>
     ++	git rm <file-outside-sparse-specification>
     ++    would silently do nothing.  We should instead print an error in those
     ++    cases to get usability right.
     ++
     ++    There may be a difference in here between behavior A and behavior B in
     ++    terms of verboseness of errors or additional warnings.
     ++
     ++  * Commands falling under "restrict or no restrict dependent upon behavior
     ++    A vs. behavior B"
     ++
      +    * diff (with --cached or REVISION arguments)
      +    * grep (with --cached or REVISION arguments)
      +    * show (when given commit arguments)
      +    * bisect
     -+    * blame
     ++    * blame (only matters when one or more -C flags passed)
      +      * and annotate
      +    * log
     -+      * and variants: shortlog, gitk, show-branch, whatchanged
     ++      * and variants: shortlog, gitk, show-branch, whatchanged, rev-list
     ++    * ls-files
     ++    * diff-index
     ++    * diff-tree
     ++    * ls-tree
      +
      +    For now, we default to behavior B for these, which want a default of
     -+    --no-restrict.
     -+
     -+    Note that two of these commands -- diff and grep -- also appeared in
     -+    a different list with a default of --restrict, but only when limited
     -+    to searching the working tree.  The working tree vs. history
     -+    distinction is fundamental in how behavior B operates, so this is
     -+    expected.
     -+
     -+    --restrict may make more sense as the long term default for
     -+    these[12], but that's a fair amount of work to implement, and it'd
     -+    be very problematic for behavior B users.  Making it the default
     -+    now, and then slowly implementing that default in various
     -+    subcommands over multiple releases would mean that behavior B users
     -+    would need to learn to slowly add additional flags to their
     -+    commands, depending on git version, to get the behavior they want.
     -+    That gradual switchover would be painful, so we should avoid it at
     -+    least until it's fully implemented.
     ++    "no restrict".
     ++
     ++    Note that two of these commands -- diff and grep -- also appeared in a
     ++    different list with a default of "restrict", but only when limited to
     ++    searching the working tree.  The working tree vs. history distinction
     ++    is fundamental in how behavior B operates, so this is expected.
     ++
     ++    "restrict" may make more sense as the long term default for these[12],
     ++    though Stolee seems to have some reservations[17].  Also, supporting
     ++    "restrict" for these commands might be a fair amount of work to
     ++    implement, meaning it might be implemented over multiple releases.  If
     ++    that behavior were the default in the commands that supported it, that
     ++    would force behavior B users to need to learn to slowly add additional
     ++    flags to their commands, depending on git version, to get the behavior
     ++    they want.  That gradual switchover would be painful, so we should
     ++    avoid it at least until it's fully implemented.
     ++
     ++
     ++=== Sparse specification vs. sparsity patterns ===
     ++
     ++In a well-behaved situation, the sparse specification is given directly
     ++by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
     ++diverge for a few reasons:
     ++
     ++    * needing to resolve conflicts (merging will vivify conflicted files)
     ++    * running Git commands that implicitly vivify files (e.g. "git stash apply")
     ++    * running Git commands that explicitly vivify files (e.g. "git checkout
     ++      --ignore-skip-worktree-bits FILENAME")
     ++    * other commands that write to these files (perhaps a user copies it
     ++      from elsewhere)
     ++
     ++For the last item, note that we do automatically clear the SKIP_WORKTREE
     ++bit for files that are present in the working tree.  This has been true
     ++since 82386b4496 ("Merge branch 'en/present-despite-skipped'",
     ++2022-03-09)
     ++
     ++However, such a situation is transient because:
     ++
     ++   * Such transient differences can and will be automatically removed as
     ++     a side-effect of commands which call unpack_trees() (checkout,
     ++     merge, reset, etc.).
     ++   * Users can also request such transient differences be corrected via
     ++     running `git sparse-checkout reapply`.  Various places recommand
     ++     running that command.
     ++   * Additional commands are also welcome to implicitly fix these
     ++     differences; we may add more in the future.
     ++
     ++While we avoid dropping unstaged changes or files which have conflicts,
     ++we otherwise aggressively try to fix these transient differences.  If
     ++users want these differences to persist, they should run the `set` or
     ++`add` subcommands of `git sparse-checkout` to reflect their intended
     ++sparse specification.
     ++
     ++However, when we need to do a query on history restricted to the
     ++"relevant subset of files" such a transiently expanded sparse
     ++specification is ignored.  There are a couple reasons for this:
     ++
     ++   * The behavior wanted when doing something like
     ++	 git grep expression REVISION
     ++     is roughly what the users would expect from
     ++	 git checkout REVISION && git grep expression
     ++     (modulo a "REVISION:" prefix), which has a couple ramifications:
     ++
     ++   * REVISION may have paths not in the current index, so there is no
     ++     path we can consult for a SKIP_WORKTREE setting for those paths.
     ++
     ++   * Since `checkout` is one of those commands that tries to remove
     ++     transient differences in the sparse specification, it makes sense
     ++     to use the corrected sparse specification
     ++     (i.e. $GIT_DIR/info/sparse-checkout) rather than attempting to
     ++     consult SKIP_WORKTREE anyway.
     ++
     ++So, a transiently expanded (or restricted) sparse specification applies to
     ++the working tree, but not to history history queries where we always use
     ++the sparsity patterns.  (See [16] for an early discussion of this.)
     ++
     ++Similar to a transiently expanded sparse specification of the working tree
     ++based on additional files being present in the working tree, we could also
     ++consider the concept of a transiently expanded sparse specification for the
     ++index.  In particular, if the user has staged changes to files that do not
     ++match the sparsity patterns, and the file is not present in the working
     ++tree, we may still want to consider the file part of the sparse
     ++specification if we are specifically performing a query related to the
     ++index (e.g. git diff REVISION, git diff-index REVISION, etc.)
      +
      +
      +=== Implementation Questions ===
      +
     -+  * Does the name --[no-]restrict sound good to others?  Are there better options?
     ++  * Does the name --[no-]restrict sound good to others?  Are there better
     ++    options?
      +    * Names in use, or appearing in patches, or previously suggested:
      +      * --sparse/--dense
      +      * --ignore-skip-worktree-bits
     @@ Documentation/technical/sparse-checkout.txt (new)
      +      * --[no-]restrict-to-sparse-paths
      +      * --full-tree/--sparse-tree
      +      * --[no-]restrict
     ++      * --scope={sparse,all}
     ++      * --focus/--unfocus
     ++      * --limit/--unlimited
      +    * Rationale making me lean slightly towards --[no-]restrict:
      +      * We want a name that works for many commands, so we need a name that
      +	does not conflict
     @@ Documentation/technical/sparse-checkout.txt (new)
      +	which would probably be even more ridiculously long.  (But we
      +	can make --ignore-skip-worktree-bits a deprecated alias for
      +	--no-restrict.)
     ++    * BUT, as others points out, --[no-]restrict isn't very clear about what
     ++      it's restricting nor does it automatically tie in to the concept of
     ++      "sparse-checkout" in the user's mind
      +
      +  * Should --[no-]restrict be a git global option, or added as options to each
      +    relevant command?  (Does that make sense given the multitude of different
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    commands (add/rm/mv), but certainly not most the others.  Previous config
      +    suggestion here: [13]
      +
     -+  * Should --sparse in ls-files be made an alias for --restrict?
     -+    `--restrict` is certainly a near synonym in cone-mode, but even then
     -+    it's not quite the same.  In non-cone mode, ls-files' `--sparse`
     -+    option has no effect, and in cone-mode it still shows the sparse
     -+    directory entries which are technically outside the sparsity
     -+    specification.
     ++  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
     ++    (`--sparse` does not map to either `--restrict` or `--no-restrict`,
     ++    because in non-cone mode it does nothing and in cone-mode it shows the
     ++    sparse directory entries which are technically outside the sparse
     ++    specification) Should `--restrict` be the default (does that imply that
     ++    `--no-expand` needs a `--no-restrict` or that it just partially
     ++    overrides it)?  Should `-t` imply `--no-restrict`?
      +
      +  * Should --ignore-skip-worktree-bits in checkout-index, checkout, and
      +    restore be made deprecated aliases for --no-restrict?  (They have the
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    the reverse option is never wanted and the sole purpose of this
      +    option was to turn off a bug?)
      +
     -+  * sparse-checkout: once behavior A is fully implemented, should we
     -+    take an interim measure to easy people into switching the default?
     -+    Namely, if folks are not already in a sparse checkout, then require
     -+    `sparse-checkout init/set` to take a `--[no-]restrict` flag (which
     -+    would set core.restrictToSparse according to the setting given), and
     -+    throw an error if the flag is not provided?  That error would be a
     -+    great place to warn folks that the default may change in the future,
     -+    and get them used to specifying what they want so that the eventual
     -+    default switch is seamless for them.
     ++  * Should update-index be made like add/rm/mv with the restrict-or-error
     ++    default functionality?  If we do, should some flags like
     ++    --[no-]skip-worktree imply --no-restrict?
     ++
     ++  * Should `apply --index` preserve SKIP_WORKTREE bits for
     ++    non-conflicted files?  We normally like preserving those bits (and
     ++    it'd make git-am more like cherry-pick/rebase/merge), but `apply`
     ++    without `--index` should unconditionally clear them and it seems a
     ++    little weird for the addition of the `--index` flag to affect how
     ++    the working tree is treated.  On the other hand, `am` builds on
     ++    `apply --index` and it needs the SKIP_WORKTREE bits preserved for
     ++    non-conflicted files in order to behave like
     ++    cherry-pick/rebase/merge.
     ++
     ++  * sparse-checkout: once behavior A is fully implemented, should we take
     ++    an interim measure to ease people into switching the default?  Namely,
     ++    if folks are not already in a sparse checkout, then require
     ++    `sparse-checkout init/set` to take a `--set-[no-]restrict-mode` or
     ++    `--set-scope=(sparse|all)` flag (which would set core.restrictToSparse
     ++    according to the setting given), and throw an error if the flag is not
     ++    provided?  That error would be a great place to warn folks that the
     ++    default may change in the future, and get them used to specifying what
     ++    they want so that the eventual default switch is seamless for them.
      +
      +  * clone: should we provide some mechanism for tying partial clones and
      +    sparse checkouts together better.  Maybe an option
     @@ Documentation/technical/sparse-checkout.txt (new)
      +
      +=== Implementation Goals/Plans ===
      +
     ++ * Get buy-in on this document in general.
     ++
      + * Figure out answers to the 'Implementation Questions' sections (above)
      +
      + * Fix bugs in the 'Known bugs' section (below)
      +
     ++ [Below here is kind of spitballing since the first two haven't been resolved]
     ++
      + * update-index: flip the default to --no-ignore-skip-worktree-entries, possibly
      +   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users request
      +   that they not trigger this bug." flag
      +
     -+  * Flags & Config
     -+    * Make `--sparse` in add/rm/mv a deprecated alias for `--no-restrict`
     -+    * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
     -+      a deprecated aliases for `--no-restrict`
     -+    * Create config option (core.restrictToSparsity?), note how it only
     -+      affects two classes of commands
     ++ * ls-files: add a --[no-]restrict flag for limiting tracked files listed to
     ++   the relevant subset.  (Plus more stuff after questions are answered.)
     ++
     ++ * Flags & Config
     ++   * Make `--sparse` in add/rm/mv a deprecated alias for `--no-restrict`
     ++   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
     ++     a deprecated aliases for `--no-restrict`
     ++   * Create config option (core.restrictToSparsity?), note how it only
     ++     affects two classes of commands
      +
      + * Behavioral plans:
      +     add, rm, mv:
     -+	Behavior B: throw error if would have affected paths outside of sparsity.
     -+	Behavior A: throw error if would have only affected paths outside of sparsity.
     ++	Behavior B: throw error if would have affected paths outside of sparse
     ++		    specification.
     ++	Behavior A: throw error if would have *only* affected paths outside of
     ++		    sparse specification.
      +     grep (on history), diff (on history), log, etc:
      +	Behavior B: act on all paths (already implemented)
     -+	Behavior A: act on limited paths, maybe show stderr warning ("results limited")
     -+		    if selected via config rather than explicitly
     ++	Behavior A: act on limited paths, maybe show stderr warning ("results
     ++		    limited") if selected via config rather than explicitly
      +     other diff machinery:
     -+	make sure diff machinery changes don't mess with format-patch, fast-export, etc.
     ++	make sure diff machinery changes don't mess with format-patch,
     ++	fast-export, etc.
      +
      +  * Fix performance issues, such as
      +    https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
     @@ Documentation/technical/sparse-checkout.txt (new)
      +This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
      +been working on it.
      +
     -+0. Behavior A is not well supported in Git.  (Behavior B didn't used to be either,
     -+   but was the easier of the two to implement.)
     ++0. Behavior A is not well supported in Git.  (Behavior B didn't used to
     ++   be either, but was the easier of the two to implement.)
      +
      +1. am and apply:
      +
     -+   am and apply rely on files being present in the working copy, and
     -+   also write to them unconditionally.  They should probably first check
     -+   for the files' presence, and if found to be SKIP_WORKTREE, then clear
     -+   the bit and vivify the paths, then do its work.
     ++   apply, without `--index` or `--cached`, relies on files being present
     ++   in the working copy, and also writes to them unconditionally.  As
     ++   such, it should first check for the files' presence, and if found to
     ++   be SKIP_WORKTREE, then clear the bit and vivify the paths, then do
     ++   its work.  Currently, it just throws an error.
     ++
     ++   apply, with either `--cached` or `--index`, will not preserve the
     ++   SKIP_WORKTREE bit.  This is fine if the file has conflicts, but
     ++   otherwise SKIP_WORKTREE bits should be preserved for --cached and
     ++   probably also for --index.
     ++
     ++   am, if there are no conflicts, will vivify files and fail to preserve
     ++   the SKIP_WORKTREE bit.  If there are conflicts and `-3` is not
     ++   specified, it will vivify files and then complain the patch doesn't
     ++   apply.  If there are conflicts and `-3` is specified, it will vivify
     ++   files and then complain that those vivified files would be
     ++   overwritten by merge.
      +
      +2. reset --hard:
      +
     @@ Documentation/technical/sparse-checkout.txt (new)
      +    `git reset --hard` DID remove addme from the index and the working tree, contrary
      +    to the error message, but in line with how reset --hard should behave.
      +
     -+3. Checkout, restore:
     ++3. read-tree
     ++
     ++   `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
     ++   entries it reads into the index, resulting in all your files suddenly
     ++   appearing to be "deleted".
     ++
     ++4. Checkout, restore:
      +
      +   These command do not handle path & revision arguments appropriately:
      +
     @@ Documentation/technical/sparse-checkout.txt (new)
      +[9] (Move from out-of-cone to in-cone)
      +    https://lore.kernel.org/git/20220630023737.473690-6-shaoxuan.yuan02@gmail.com/
      +    https://lore.kernel.org/git/20220630023737.473690-4-shaoxuan.yuan02@gmail.com/
     -+[10] (Unnecessarily downloading objects outside sparsity specification)
     ++[10] (Unnecessarily downloading objects outside sparse specification)
      +     https://lore.kernel.org/git/CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com/
      +
      +[11] (Stolee's comments on high-level usecases)
     @@ Documentation/technical/sparse-checkout.txt (new)
      +[13] Previous config name suggestion and description
      +  * https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
      +
     -+[14] Tangential issue: switch to cone mode as default sparsity specification mechanism:
     ++[14] Tangential issue: switch to cone mode as default sparse specification mechanism:
      +  https://lore.kernel.org/git/a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com/
      +
      +[15] Lengthy email on grep behavior, covering what should be searched:
      +  * https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/
     ++
     ++[16] Email explaining sparsity patterns vs. SKIP_WORKTREE and history operations,
     ++     search for the parenthetical comment starting "We do not check".
     ++    https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/
     ++
     ++[17] "I'm not even sure if we would want to make this available via a
     ++     config setting"
     ++   and
     ++     "But I also want to avoid doing this as a default or even behind a
     ++     config setting"
     ++   respectively, from:
     ++     https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
     ++     https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/


 Documentation/technical/sparse-checkout.txt | 938 ++++++++++++++++++++
 1 file changed, 938 insertions(+)
 create mode 100644 Documentation/technical/sparse-checkout.txt

diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
new file mode 100644
index 00000000000..408f66eaba6
--- /dev/null
+++ b/Documentation/technical/sparse-checkout.txt
@@ -0,0 +1,938 @@
+Table of contents:
+
+  * Terminology
+  * Purpose of sparse-checkouts
+  * Desired behavior
+  * Behavior classes
+  * Subcommand-dependent defaults
+  * Sparse specification vs. sparsity patterns
+  * Implementation Questions
+  * Implementation Goals/Plans
+  * Known bugs
+  * Reference Emails
+
+
+=== Terminology ===
+
+cone mode: one of two modes for specifying the desired subset of files
+	in a sparse-checkout.  In cone-mode, the user specifies
+	directories (getting both everything under that directory as
+	well as everything in leading directories), while in non-cone
+	mode, the user specifies gitignore-style patterns.  Controlled
+	by the --[no-]cone option to sparse-checkout init|set.
+
+SKIP_WORKTREE: When tracked files do not match the sparse specification and
+	are removed from the working tree, the file in the index is marked
+	with a SKIP_WORKTREE bit.  Note that if a tracked file has the
+	SKIP_WORKTREE bit set but is later written by the user to the
+	working tree anyway, the SKIP_WORKTREE bit will be cleared at the
+	beginning of any Git operation.
+
+	Most sparse checkout users are unaware of this implementation
+	detail, and the term should generally be avoided in user-facing
+	descriptions and command flags.  Unfortunately, prior to the
+	`sparse-checkout` subcommand these low-level details were exposed,
+	and as of time of writing, still are in various places.
+
+sparse-checkout: a subcommand in git used to reduce the files present in
+	the working tree to a subset of all tracked files.  Also, the
+	name of the file in the $GIT_DIR/info directory used to track
+	the sparsity patterns corresponding to the user's desired
+	subset.
+
+sparse cone: see cone mode
+
+sparse directory: An entry in the index corresponding to a directory
+	rather, and used to replace all files under that directory that
+	would normally appear in the index.  See also sparse-index.
+	Something that can cause confusion is that the "sparse
+	directory" does NOT match the sparse specification, i.e. the
+	directory is NOT present in the working tree.
+
+sparse index: A special mode for sparse-checkout that also makes the
+	index sparse by recording a directory entry in lieu of all the
+	files underneath that directory.  Controlled by the
+	--[no-]sparse-index option to init|set|reapply.  See also
+	"sparse directory".
+
+sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
+	define the set of files of interest.  A warning: It is easy to
+	over-use this term (or the shortened "patterns" term), for two
+	reasons (1) users in cone mode specify directories rather
+	than patterns (their directories are transformed into patterns,
+	but users may think you are talking about non-cone mode if you
+	use the word "patterns"), and (b) the sparse specification might
+	transiently differ in the working tree from the sparsity
+	patterns (see "Sparse specification vs. sparsity patterns").
+
+sparse specification: The set of paths in the user's area of focus.  When
+	interacting with the working tree, this is the set of tracked files
+	present in the working copy or with a clear SKIP_WORKTREE bit.
+	When working with history, this is the set of files matching the
+	sparsity patterns.  Usually the tracked files present in the
+	working copy are precisely the set of tracked files matching
+	sparsity patterns, but they can temporarily differ.  (See also
+	"Sparse specification vs. sparsity patterns")
+
+vivifying: When a command restores a tracked file to the working tree
+	(and clearing the SKIP_WORKTREE bit in the index), this is
+	referred to as "vivifying" the file.
+
+
+=== Purpose of sparse-checkouts ===
+
+sparse-checkouts exist to allow users to work with a subset of their
+files.
+
+You can think of sparse-checkouts as subdividing "tracked" files into
+two categories -- a sparse subset, and all the rest.
+Implementationally, we mark "all the rest" with SKIP_WORKTREE.  The
+SKIP_WORKTREE files are still tracked, just not present in the working
+tree.
+
+In the past, sparse-checkouts were defined by "SKIP_WORKTREE means the file
+is missing from the working tree but pretend the file matches HEAD".  That
+was a low-level detail which provided decent behavior for a few commands,
+but which had a surprising number of ways in which it violated user
+expectations and was a bad mental model.  However, it persisted for many
+years and may still be found in some corners of the code base.
+
+Anyway, the idea of "working with a subset of files" is simple enough, but
+there are two different high-level usecases which affect how some Git
+subcommands should behave.  Further, even if we only considered one of
+those usecases, sparse-checkouts modify different subcommands in over a
+half dozen different ways.  Let's start by considering the high level
+usecases:
+
+  A) Users are _only_ interested in the sparse portion of the repo
+
+  B) Users want a sparse working tree, but are working in a larger whole
+
+It may be worth explaining both of these in a bit more detail:
+
+  (Behavior A) Users are _only_ interested in the sparse portion of the repo
+
+These folks might know there are other things in the repository, but
+don't care.  They are uninterested in other parts of the repository, and
+only want to know about changes within their area of interest.  Showing
+them other results from history (e.g. from diff/log/grep/etc.) is a
+usability annoyance, potentially a huge one since other changes in
+history may dwarf the changes they are interested in.
+
+Some of these users also arrive at this usecase from wanting to use
+partial clones together with sparse checkouts and do disconnected
+development.  Not only do these users generally not care about other
+parts of the repository, but consider it a blocker for Git commands to
+try to operate on those.  If commands attempt to access paths in history
+outside the sparsity specification, then the partial clone will attempt
+to download additional blobs on demand, fail, and then fail the user's
+command.  (This may be unavoidable in some cases, e.g. when `git merge`
+has non-trivial changes to reconcile outside the sparse specification,
+but we should limit how often users are forced to connect to the
+network.)
+
+Also, even for users using partial clones that do not mind being
+always connected to the network, the need to download blobs as
+side-effects of various other commands (such as the printed diffstat
+after a merge or pull) can lead to worries about local repository size
+growing unnecessarily[10].
+
+  (Behavior B) Users want a sparse working tree, but are working in a larger whole
+
+Stolee described this usecase this way[11]:
+
+"I'm also focused on users that know that they are a part of a larger
+whole. They know they are operating on a large repository but focus on
+what they need to contribute their part. I expect multiple "roles" to
+use very different, almost disjoint parts of the codebase. Some other
+"architect" users operate across the entire tree or hop between different
+sections of the codebase as necessary. In this situation, I'm wary of
+scoping too many features to the sparse-checkout definition, especially
+"git log," as it can be too confusing to have their view of the codebase
+depend on your "point of view."
+
+People might also end up wanting behavior B due to complex inter-project
+dependencies.  The initial attempts to use sparse-checkouts usually
+involve the directories you are directly interested in plus what those
+directories depend upon within your repository.  But there's a monkey
+wrench here: if you have integration tests, they invert the hierarchy:
+to run integration tests, you need not only what you are interested in
+and its dependencies, you also need everything that depends upon what
+you are interested in or that depends upon one of your
+dependencies...AND you need all the dependencies of that expanded group.
+That can easily change your sparse-checkout into a nearly dense one.
+
+Naturally, that tends to kill the benefits of sparse-checkouts.  There
+are a couple solutions to this conundrum: either avoid grabbing
+dependencies (maybe have built versions of your dependencies pulled from
+a CI cache somewhere), or say that users shouldn't run integration tests
+directly and instead do it on the CI server when they submit a code
+review.  Or do both.  Regardless of whether you stub out your
+dependencies or stub out the things that depend upon you, there is
+certainly a reason to want to query and be aware of those other
+stubbed-out parts of the repository, particularly when the dependencies
+are complex or change relatively frequently.  Thus, for such uses,
+sparse-checkouts can be used to limit what you directly build and
+modify, but these users do not necessarily want their sparse checkout
+paths to limit their queries of history.
+
+Some people may also be interested in behavior B simply as a performance
+workaround: if they are using non-cone mode, then they have to deal with
+its inherent quadratic performance problems.  In that mode, every
+operation that checks whether paths match the sparsity specification can
+be expensive.  As such, these users may only be willing to pay for those
+expensive checks when interacting with the working copy, and may prefer
+getting "unrelated" results from their history queries over having slow
+commands.
+
+
+=== Desired behavior ===
+
+As noted in the previous section, despite the simple idea of just
+working with a subset of files, there are a range of different
+behavioral changes that need to be made to different subcommands to work
+well with such a feature.  See [1,2,3,4,5,6,7,8,9,10] for various
+examples.  In particular, at [2], we saw that mere composition of other
+commands that individually worked correctly in a sparse-checkout context
+did not imply that the higher level command would work correctly; it
+sometimes requires further tweaks.  So, understanding these differences
+can be beneficial.
+
+* Commands behaving the same regardless of high-level use-case
+
+  * commands that only look at files within the sparsity specification
+
+      * diff (without --cached or REVISION arguments)
+      * grep (without --cached or REVISION arguments)
+      * diff-files
+
+  * commands that restore files to the working tree that match sparsity
+    patterns, and remove unmodified files that don't match those
+    patterns:
+
+      * switch
+      * checkout (the switch-like half)
+      * read-tree
+      * reset --hard
+
+      * `restore` & the restore-like half of `checkout` SHOULD be in this above
+	category, but are buggy (see the "Known bugs" section below)
+
+  * commands that write conflicted files to the working tree, but otherwise will
+    omit writing files that do not match the sparsity patterns:
+
+      * merge
+      * rebase
+      * cherry-pick
+      * revert
+
+      * `am` and `apply --index` should probably be in this section but are buggy
+	(see the "Known bugs" section below)
+
+    Note that this somewhat depends upon the merge strategy being used:
+      * `ort` behaves as described above
+      * `recursive` tries to not vivify files unnecessarily, but does sometimes
+	vivify files without conflicts.
+      * `octopus` and `resolve` will always vivify any file changed in the merge
+	relative to the first parent, which is rather suboptimal.
+
+  * commands that always ignore sparsity since commits must be full-tree
+
+      * archive
+      * bundle
+      * commit
+      * format-patch
+      * fast-export
+      * fast-import
+      * commit-tree
+
+  * commands that write any modified file to the working tree (conflicted or not,
+    and whether those paths match sparsity patterns or not):
+
+      * stash
+      * apply (without `--index` or `--cached`)
+
+* Commands that differ for behavior A vs. behavior B:
+
+  * commands that make modifications to which files are tracked:
+      * add
+      * rm
+      * mv
+      * update-index
+
+    The fact that files can move between the 'tracked' and 'untracked'
+    categories means some commands will have to treat untracked files
+    differently.  But if we have to treat untracked files differently,
+    then additional commands may also need changes:
+
+      * status
+      * clean
+
+    In particular, `status` may need to report any untracked files outside
+    the sparsity specification as an erroneous condition (especially to
+    avoid the user trying to `git add` them, forcing `git add` to display
+    an error).
+
+    It's not clear to me exactly how (or if `clean` would change, but it's
+    the other command that also affects untracked files.
+
+    `update-index` may be slightly special.  Its --[no-]skip-worktree flag
+    may need to ignore the sparse specification by its nature.  Also, its
+    current --[no-]ignore-skip-worktree-entries default is totally bogus.
+
+  * commands that query history
+      * diff (with --cached or REVISION arguments)
+      * grep (with --cached or REVISION arguments)
+      * show (when given commit arguments)
+      * bisect
+      * blame (only matters when one or more -C flags passed)
+	* and annotate
+      * log
+	* and variants: shortlog, gitk, show-branch, whatchanged, rev-list
+      * ls-files
+      * diff-index
+      * diff-tree
+      * ls-tree
+
+    ls-files may be slightly special in that e.g. `git ls-files -t` is
+    often used to see what is sparse and what is not.  Perhaps -t should
+    always work on the full tree?
+
+* Commands I don't know how to classify
+
+  * range-diff
+
+    Is this like `log` or `format-patch`?
+
+  * cherry
+
+    See range-diff
+
+* Commands unaffected by sparse-checkouts
+
+  * branch
+  * describe
+  * fetch
+  * gc
+  * init
+  * maintenance
+  * notes
+  * pull (merge & rebase have the necessary changes)
+  * push
+  * submodule
+  * tag
+
+  * config
+  * filter-branch (works in separate checkout without sparse-checkout setup)
+  * pack-refs
+  * prune
+  * remote
+  * repack
+  * replace
+
+  * bugreport
+  * count-objects
+  * fsck
+  * gitweb
+  * help
+  * instaweb
+  * merge-tree (doesn't touch worktree or index, and merges always compute full-tree)
+  * rerere
+  * verify-commit
+  * verify-tag
+
+  * commit-graph
+  * hash-object
+  * index-pack
+  * mktag
+  * mktree
+  * multi-pack-index
+  * pack-objects
+  * prune-packed
+  * symbolic-ref
+  * unpack-objects
+  * update-ref
+  * write-tree (operates on index, possibly optimized to use sparse dir entries)
+
+  * for-each-ref
+  * get-tar-commit-id
+  * ls-remote
+  * merge-base (merges are computed full tree, so merge base should be too)
+  * name-rev
+  * pack-redundant
+  * rev-parse
+  * show-index
+  * show-ref
+  * unpack-file
+  * var
+  * verify-pack
+
+  * <Everything under 'Interacting with Others' in 'git help --all'>
+  * <Everything under 'Low-level...Syncing' in 'git help --all'>
+  * <Everything under 'Low-level...Internal Helpers' in 'git help --all'>
+  * <Everything under 'External commands' in 'git help --all'>
+
+* Commands that might be affected, but who cares?
+
+  * merge-file
+  * merge-index
+
+
+=== Behavior classes ====
+
+From the above there are a few classes of behavior:
+
+  * "restrict"
+
+    Commands in this class only read or write files within the sparse
+    specification.  Some of these commands may also attempt, at the end of
+    their operation, to cull transient differences between the sparse
+    specification and the sparsity patterns (see "Sparse specification
+    vs. sparsity patterns" for details, but this basically means either
+    removing unmodified files not matching the sparsity patterns and
+    marking those files as SKIP_WORKTREE, or vivifying files that match the
+    sparsity patterns and marking those files as !SKIP_WORKTREE).
+
+  * "restrict modulo conflicts"
+
+    Commands in this class generally behave like the "restrict" class,
+    except that:
+      (1) they ignore the sparse specification in terms of updates to the
+	  index, though they'll preserve or update the SKIP_WORKTREE bit
+	  for files as needed to follow the sparsity patterns.
+      (2) they will ignore the sparse specification and write files with
+	  conflicts to the working tree (thus temporarily expanding the
+	  sparse specification to include such files.)
+
+  * "restrict also specially applied to untracked files"
+
+    Commands in this class generally behave like the "restrict" class,
+    except that they have to handle untracked files differently too, often
+    because these commands are dealing with files changing state between
+    'tracked' and 'untracked'.  Often, this may mean printing an error
+    message if the command had nothing to do, but the arguments may have
+    referred to files whose tracked-ness state could have changed were it
+    not for the sparsity patterns excluding them.
+
+  * "no restrict"
+
+    Commands in this class ignore the sparse specification entirely.
+
+  * "restrict or no restrict dependent upon behavior A vs. behavior B"
+
+    Commands in this class behave like "no restrict" for folks in the
+    behavior B camp, and like "restrict" for folks in the behavior A camp.
+    However, when behaving like "restrict" a warning of some sort might be
+    provided that history queries have been limited by the sparse-checkout
+    specification.
+
+
+=== Subcommand-dependent defaults ===
+
+Note that we have different defaults depending on the command for the
+desired behavior :
+
+  * Commands defaulting to "restrict":
+    * status
+    * diff (without --cached or REVISION arguments)
+    * grep (without --cached or REVISION arguments)
+    * switch
+    * checkout (the switch-like half)
+    * read-tree
+    * reset (--hard)
+    * restore/checkout
+    * checkout-index
+    * diff-files
+
+    This behavior makes sense; these interact with the working tree.
+
+  * Commands defaulting to "restrict modulo conflicts":
+    * merge
+    * rebase
+    * cherry-pick
+    * revert
+
+    * am
+    * apply --index
+
+    These also interact with the working tree, but require slightly different
+    behavior so that conflicts can be resolved.
+
+    (See also the "Known bugs" section below regarding `am` and `apply`)
+
+  * Commands defaulting to "no restrict":
+    * archive
+    * bundle
+    * commit
+    * format-patch
+    * fast-export
+    * fast-import
+    * commit-tree
+
+    * stash
+    * apply (without `--index`)
+
+    These have completely different defaults and perhaps deserve the most
+    detailed explanation:
+
+    In the case of commands in the first group (format-patch,
+    fast-export, bundle, archive, etc.), these are commands for
+    communicating history, which will be broken if they restrict to a
+    subset of the repository.  As such, they operate on full paths and
+    have no `--restrict` option for overriding.  Some of these commands may
+    take paths for manually restricting what is exported, but it needs to
+    be very explicit.
+
+    In the case of stash, it needs to vivify files to avoid losing the
+    user's changes.
+
+    In the case of apply without `--index`, that command needs to update
+    the working tree without the index (or the index without the working
+    tree if `--cached` is passed), and if we restrict those updates to the
+    sparse specification then we'll lose changes from the user.
+
+  * Commands defaulting to "restrict also specially applied to untracked files":
+    * add
+    * rm
+    * mv
+
+    Our original implementation for these commands was "no restrict", but
+    it had some severe usability issues:
+      * `git add <somefile>` if honored and outside the sparse
+	specification, can result in the file randomly disappearing later
+	when some subsequent command is run (since various commands
+	automatically clean up unmodified files outside the sparse
+	specification).
+      * `git rm '*.jpg'` could very negatively surprise users if it deletes
+	files outside the range of the user's interest.
+      * `git mv` has similar surprises when moving into or out of the cone,
+	so best to restrict by default
+
+    So, we switched `add` and `rm` to default to "restrict", which made
+    usability problems much less severe and less frequent, but we still got
+    complaints because commands like:
+	git add <file-outside-sparse-specification>
+	git rm <file-outside-sparse-specification>
+    would silently do nothing.  We should instead print an error in those
+    cases to get usability right.
+
+    There may be a difference in here between behavior A and behavior B in
+    terms of verboseness of errors or additional warnings.
+
+  * Commands falling under "restrict or no restrict dependent upon behavior
+    A vs. behavior B"
+
+    * diff (with --cached or REVISION arguments)
+    * grep (with --cached or REVISION arguments)
+    * show (when given commit arguments)
+    * bisect
+    * blame (only matters when one or more -C flags passed)
+      * and annotate
+    * log
+      * and variants: shortlog, gitk, show-branch, whatchanged, rev-list
+    * ls-files
+    * diff-index
+    * diff-tree
+    * ls-tree
+
+    For now, we default to behavior B for these, which want a default of
+    "no restrict".
+
+    Note that two of these commands -- diff and grep -- also appeared in a
+    different list with a default of "restrict", but only when limited to
+    searching the working tree.  The working tree vs. history distinction
+    is fundamental in how behavior B operates, so this is expected.
+
+    "restrict" may make more sense as the long term default for these[12],
+    though Stolee seems to have some reservations[17].  Also, supporting
+    "restrict" for these commands might be a fair amount of work to
+    implement, meaning it might be implemented over multiple releases.  If
+    that behavior were the default in the commands that supported it, that
+    would force behavior B users to need to learn to slowly add additional
+    flags to their commands, depending on git version, to get the behavior
+    they want.  That gradual switchover would be painful, so we should
+    avoid it at least until it's fully implemented.
+
+
+=== Sparse specification vs. sparsity patterns ===
+
+In a well-behaved situation, the sparse specification is given directly
+by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
+diverge for a few reasons:
+
+    * needing to resolve conflicts (merging will vivify conflicted files)
+    * running Git commands that implicitly vivify files (e.g. "git stash apply")
+    * running Git commands that explicitly vivify files (e.g. "git checkout
+      --ignore-skip-worktree-bits FILENAME")
+    * other commands that write to these files (perhaps a user copies it
+      from elsewhere)
+
+For the last item, note that we do automatically clear the SKIP_WORKTREE
+bit for files that are present in the working tree.  This has been true
+since 82386b4496 ("Merge branch 'en/present-despite-skipped'",
+2022-03-09)
+
+However, such a situation is transient because:
+
+   * Such transient differences can and will be automatically removed as
+     a side-effect of commands which call unpack_trees() (checkout,
+     merge, reset, etc.).
+   * Users can also request such transient differences be corrected via
+     running `git sparse-checkout reapply`.  Various places recommand
+     running that command.
+   * Additional commands are also welcome to implicitly fix these
+     differences; we may add more in the future.
+
+While we avoid dropping unstaged changes or files which have conflicts,
+we otherwise aggressively try to fix these transient differences.  If
+users want these differences to persist, they should run the `set` or
+`add` subcommands of `git sparse-checkout` to reflect their intended
+sparse specification.
+
+However, when we need to do a query on history restricted to the
+"relevant subset of files" such a transiently expanded sparse
+specification is ignored.  There are a couple reasons for this:
+
+   * The behavior wanted when doing something like
+	 git grep expression REVISION
+     is roughly what the users would expect from
+	 git checkout REVISION && git grep expression
+     (modulo a "REVISION:" prefix), which has a couple ramifications:
+
+   * REVISION may have paths not in the current index, so there is no
+     path we can consult for a SKIP_WORKTREE setting for those paths.
+
+   * Since `checkout` is one of those commands that tries to remove
+     transient differences in the sparse specification, it makes sense
+     to use the corrected sparse specification
+     (i.e. $GIT_DIR/info/sparse-checkout) rather than attempting to
+     consult SKIP_WORKTREE anyway.
+
+So, a transiently expanded (or restricted) sparse specification applies to
+the working tree, but not to history history queries where we always use
+the sparsity patterns.  (See [16] for an early discussion of this.)
+
+Similar to a transiently expanded sparse specification of the working tree
+based on additional files being present in the working tree, we could also
+consider the concept of a transiently expanded sparse specification for the
+index.  In particular, if the user has staged changes to files that do not
+match the sparsity patterns, and the file is not present in the working
+tree, we may still want to consider the file part of the sparse
+specification if we are specifically performing a query related to the
+index (e.g. git diff REVISION, git diff-index REVISION, etc.)
+
+
+=== Implementation Questions ===
+
+  * Does the name --[no-]restrict sound good to others?  Are there better
+    options?
+    * Names in use, or appearing in patches, or previously suggested:
+      * --sparse/--dense
+      * --ignore-skip-worktree-bits
+      * --ignore-skip-worktree-entries
+      * --ignore-sparsity
+      * --[no-]restrict-to-sparse-paths
+      * --full-tree/--sparse-tree
+      * --[no-]restrict
+      * --scope={sparse,all}
+      * --focus/--unfocus
+      * --limit/--unlimited
+    * Rationale making me lean slightly towards --[no-]restrict:
+      * We want a name that works for many commands, so we need a name that
+	does not conflict
+      * --[no-]restrict isn't overly long and seems relatively explanatory
+      * `--sparse`, as used in add/rm/mv, is totally backwards for
+	grep/log/etc.  Changing the meaning of `--sparse` for these
+	commands would fix the backwardness, but possibly break existing
+	scripts.  Using a new name pairing would allow us to treat
+	`--sparse` in these commands as a deprecated alias.
+      * There is a different `--sparse`/`--dense` pair for commands using
+	revision machinery, so using that naming might cause confusion
+      * There is also a `--sparse` in both pack-objects and show-branch, which
+	don't conflict but do suggest that `--sparse` is overloaded
+      * The name --ignore-skip-worktree-bits is a double negative, is
+	quite a mouthful, refers to an implementation detail that many
+	users may not be familiar with, and we'd need a negation for it
+	which would probably be even more ridiculously long.  (But we
+	can make --ignore-skip-worktree-bits a deprecated alias for
+	--no-restrict.)
+    * BUT, as others points out, --[no-]restrict isn't very clear about what
+      it's restricting nor does it automatically tie in to the concept of
+      "sparse-checkout" in the user's mind
+
+  * Should --[no-]restrict be a git global option, or added as options to each
+    relevant command?  (Does that make sense given the multitude of different
+    default behaviors we have for different options?)
+
+  * If a config option is added (core.restrictToSparsity?) what should
+    the values and description be?  There's a risk of confusion, because
+    we only want this config option to affect the history-querying
+    commands (log/diff/grep) and maybe the path-modifying worktree
+    commands (add/rm/mv), but certainly not most the others.  Previous config
+    suggestion here: [13]
+
+  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
+    (`--sparse` does not map to either `--restrict` or `--no-restrict`,
+    because in non-cone mode it does nothing and in cone-mode it shows the
+    sparse directory entries which are technically outside the sparse
+    specification) Should `--restrict` be the default (does that imply that
+    `--no-expand` needs a `--no-restrict` or that it just partially
+    overrides it)?  Should `-t` imply `--no-restrict`?
+
+  * Should --ignore-skip-worktree-bits in checkout-index, checkout, and
+    restore be made deprecated aliases for --no-restrict?  (They have the
+    same meaning.)
+
+  * Should --ignore-skip-worktree-entries in update-index be made a
+    deprecated alias for --no-restrict?  (Or, better yet, should the
+    option just be nuked from orbit after flipping the default, since
+    the reverse option is never wanted and the sole purpose of this
+    option was to turn off a bug?)
+
+  * Should update-index be made like add/rm/mv with the restrict-or-error
+    default functionality?  If we do, should some flags like
+    --[no-]skip-worktree imply --no-restrict?
+
+  * Should `apply --index` preserve SKIP_WORKTREE bits for
+    non-conflicted files?  We normally like preserving those bits (and
+    it'd make git-am more like cherry-pick/rebase/merge), but `apply`
+    without `--index` should unconditionally clear them and it seems a
+    little weird for the addition of the `--index` flag to affect how
+    the working tree is treated.  On the other hand, `am` builds on
+    `apply --index` and it needs the SKIP_WORKTREE bits preserved for
+    non-conflicted files in order to behave like
+    cherry-pick/rebase/merge.
+
+  * sparse-checkout: once behavior A is fully implemented, should we take
+    an interim measure to ease people into switching the default?  Namely,
+    if folks are not already in a sparse checkout, then require
+    `sparse-checkout init/set` to take a `--set-[no-]restrict-mode` or
+    `--set-scope=(sparse|all)` flag (which would set core.restrictToSparse
+    according to the setting given), and throw an error if the flag is not
+    provided?  That error would be a great place to warn folks that the
+    default may change in the future, and get them used to specifying what
+    they want so that the eventual default switch is seamless for them.
+
+  * clone: should we provide some mechanism for tying partial clones and
+    sparse checkouts together better.  Maybe an option
+	--sparse=dir1,dir2,...,dirN
+    which:
+       * Does initial fetch with `--filter=blob:none`
+       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
+       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
+	 fault in the missing blobs within the sparse
+	 specification...except that rev-list needs some kind of options
+	 to also get files from leading directories too.
+       * Sets --restrict mode to allow focusing on the cone of interest
+	 (and to permit disconnected development)
+
+
+=== Implementation Goals/Plans ===
+
+ * Get buy-in on this document in general.
+
+ * Figure out answers to the 'Implementation Questions' sections (above)
+
+ * Fix bugs in the 'Known bugs' section (below)
+
+ [Below here is kind of spitballing since the first two haven't been resolved]
+
+ * update-index: flip the default to --no-ignore-skip-worktree-entries, possibly
+   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users request
+   that they not trigger this bug." flag
+
+ * ls-files: add a --[no-]restrict flag for limiting tracked files listed to
+   the relevant subset.  (Plus more stuff after questions are answered.)
+
+ * Flags & Config
+   * Make `--sparse` in add/rm/mv a deprecated alias for `--no-restrict`
+   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
+     a deprecated aliases for `--no-restrict`
+   * Create config option (core.restrictToSparsity?), note how it only
+     affects two classes of commands
+
+ * Behavioral plans:
+     add, rm, mv:
+	Behavior B: throw error if would have affected paths outside of sparse
+		    specification.
+	Behavior A: throw error if would have *only* affected paths outside of
+		    sparse specification.
+     grep (on history), diff (on history), log, etc:
+	Behavior B: act on all paths (already implemented)
+	Behavior A: act on limited paths, maybe show stderr warning ("results
+		    limited") if selected via config rather than explicitly
+     other diff machinery:
+	make sure diff machinery changes don't mess with format-patch,
+	fast-export, etc.
+
+  * Fix performance issues, such as
+    https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
+
+
+=== Known bugs ===
+
+This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
+been working on it.
+
+0. Behavior A is not well supported in Git.  (Behavior B didn't used to
+   be either, but was the easier of the two to implement.)
+
+1. am and apply:
+
+   apply, without `--index` or `--cached`, relies on files being present
+   in the working copy, and also writes to them unconditionally.  As
+   such, it should first check for the files' presence, and if found to
+   be SKIP_WORKTREE, then clear the bit and vivify the paths, then do
+   its work.  Currently, it just throws an error.
+
+   apply, with either `--cached` or `--index`, will not preserve the
+   SKIP_WORKTREE bit.  This is fine if the file has conflicts, but
+   otherwise SKIP_WORKTREE bits should be preserved for --cached and
+   probably also for --index.
+
+   am, if there are no conflicts, will vivify files and fail to preserve
+   the SKIP_WORKTREE bit.  If there are conflicts and `-3` is not
+   specified, it will vivify files and then complain the patch doesn't
+   apply.  If there are conflicts and `-3` is specified, it will vivify
+   files and then complain that those vivified files would be
+   overwritten by merge.
+
+2. reset --hard:
+
+   reset --hard provides confusing error message (works correctly, but
+   misleads the user into believing it didn't):
+
+    $ touch addme
+    $ git add addme
+    $ git ls-files -t
+    H addme
+    H tracked
+    S tracked-but-maybe-skipped
+    $ git reset --hard                           # usually works great
+    error: Path 'addme' not uptodate; will not remove from working tree.
+    HEAD is now at bdbbb6f third
+    $ git ls-files -t
+    H tracked
+    S tracked-but-maybe-skipped
+    $ ls -1
+    tracked
+
+    `git reset --hard` DID remove addme from the index and the working tree, contrary
+    to the error message, but in line with how reset --hard should behave.
+
+3. read-tree
+
+   `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
+   entries it reads into the index, resulting in all your files suddenly
+   appearing to be "deleted".
+
+4. Checkout, restore:
+
+   These command do not handle path & revision arguments appropriately:
+
+    $ ls
+    tracked
+    $ git ls-files -t
+    H tracked
+    S tracked-but-maybe-skipped
+    $ git status --porcelain
+    $ git checkout -- '*skipped'
+    error: pathspec '*skipped' did not match any file(s) known to git
+    $ git ls-files -- '*skipped'
+    tracked-but-maybe-skipped
+    $ git checkout HEAD -- '*skipped'
+    error: pathspec '*skipped' did not match any file(s) known to git
+    $ git ls-tree HEAD | grep skipped
+    100644 blob 276f5a64354b791b13840f02047738c77ad0584f	tracked-but-maybe-skipped
+    $ git status --porcelain
+    $ git checkout HEAD~1 -- '*skipped'
+    $ git ls-files -t
+    H tracked
+    H tracked-but-maybe-skipped
+    $ git status --porcelain
+    M  tracked-but-maybe-skipped
+    $ git checkout HEAD -- '*skipped'
+    $ git status --porcelain
+    $
+
+    Note that checkout without a revision (or restore --staged) fails to
+    find a file to restore from the index, even though ls-files shows
+    such a file certainly exists.
+
+    Similar issues occur with HEAD (--source=HEAD in restore's case),
+    but suddenly works when HEAD~1 is specified.  And then after that it
+    will work with HEAD specified, even though it didn't before.
+
+    Directories are also an issue:
+
+    $ git sparse-checkout set nomatches
+    $ git status
+    On branch main
+    You are in a sparse checkout with 0% of tracked files present.
+
+    nothing to commit, working tree clean
+    $ git checkout .
+    error: pathspec '.' did not match any file(s) known to git
+    $ git checkout HEAD~1 .
+    Updated 1 path from 58916d9
+    $ git ls-files -t
+    S tracked
+    H tracked-but-maybe-skipped
+
+
+=== Reference Emails ===
+
+Emails that detail various bugs we've had in sparse-checkout:
+
+[1] (Original descriptions of behavior A & behavior B)
+    https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
+[2] (Fix stash applications in sparse checkouts; bugs from behavioral differences)
+    https://lore.kernel.org/git/ccfedc7140dbf63ba26a15f93bd3885180b26517.1606861519.git.gitgitgadget@gmail.com/
+[3] (Present-despite-skipped entries)
+    https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/
+[4] (Clone --no-checkout interaction)
+    https://lore.kernel.org/git/pull.801.v2.git.git.1591324899170.gitgitgadget@gmail.com/ (clone --no-checkout)
+[5] (The need for update_sparsity() and avoiding `read-tree -mu HEAD`)
+    https://lore.kernel.org/git/3a1f084641eb47515b5a41ed4409a36128913309.1585270142.git.gitgitgadget@gmail.com/
+[6] (SKIP_WORKTREE is advisory, not mandatory)
+    https://lore.kernel.org/git/844306c3e86ef67591cc086decb2b760e7d710a3.1585270142.git.gitgitgadget@gmail.com/
+[7] (`worktree add` should copy sparsity settings from current worktree)
+    https://lore.kernel.org/git/c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com/
+[8] (Avoid negative surprises in add, rm, and mv)
+    https://lore.kernel.org/git/cover.1617914011.git.matheus.bernardino@usp.br/
+    https://lore.kernel.org/git/pull.1018.v4.git.1632497954.gitgitgadget@gmail.com/
+[9] (Move from out-of-cone to in-cone)
+    https://lore.kernel.org/git/20220630023737.473690-6-shaoxuan.yuan02@gmail.com/
+    https://lore.kernel.org/git/20220630023737.473690-4-shaoxuan.yuan02@gmail.com/
+[10] (Unnecessarily downloading objects outside sparse specification)
+     https://lore.kernel.org/git/CAOLTT8QfwOi9yx_qZZgyGa8iL8kHWutEED7ok_jxwTcYT_hf9Q@mail.gmail.com/
+
+[11] (Stolee's comments on high-level usecases)
+     https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
+
+[12] Others commenting on eventually switching default to behavior A:
+  * https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
+  * https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
+  * https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com/
+
+[13] Previous config name suggestion and description
+  * https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
+
+[14] Tangential issue: switch to cone mode as default sparse specification mechanism:
+  https://lore.kernel.org/git/a1b68fd6126eb341ef3637bb93fedad4309b36d0.1650594746.git.gitgitgadget@gmail.com/
+
+[15] Lengthy email on grep behavior, covering what should be searched:
+  * https://lore.kernel.org/git/CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com/
+
+[16] Email explaining sparsity patterns vs. SKIP_WORKTREE and history operations,
+     search for the parenthetical comment starting "We do not check".
+    https://lore.kernel.org/git/CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com/
+
+[17] "I'm not even sure if we would want to make this available via a
+     config setting"
+   and
+     "But I also want to avoid doing this as a default or even behind a
+     config setting"
+   respectively, from:
+     https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
+     https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
