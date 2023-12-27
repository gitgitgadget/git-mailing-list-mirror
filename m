Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A823B9
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWiCB3Kp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso49878205e9.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 18:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703643933; x=1704248733; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DaSnDZkBVw68WfDvxIfGA+TOj/0oR1HMmS3q5OPhIUU=;
        b=aWiCB3KpRDcOEsKo1ggAssAf3X35DICVUHYqxvA6lCxtCmmAgWwlLnwf7rqJ6NuR7H
         C9OXMISEZiGyZLQuGKREe6ca+JJUgaFKE9jAfD3eYvMXZ6ub/OtfuUledWIONN5OvSGW
         k32w8at2YJKE7kMUy//WrJNBlqooKKbeY4fGwuMq6ZlFCmqO04UuKCZm/ifKTYkRo5kn
         t5SimR2npaJUuQRpwLGlNMyEDjB+zq6Ks6DBBYY7NDTThRJI61y0RfWc5R7o0hCxou00
         e+mX2L0QTAdAhRQR4tjg4we27Ddt2icgoXC9nFe7OGT5OmnkdNSMEufECkCYhXy5wxFZ
         TpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703643933; x=1704248733;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaSnDZkBVw68WfDvxIfGA+TOj/0oR1HMmS3q5OPhIUU=;
        b=A1qwewRnEQNY8knWCSw2+1wIKu2ADAxTG9WjbQKRcsYuQn674AOMW6zoVAZ4+vMlqi
         yKg/Nq8ul6Q/qcm2yfeAIi/csm9dbCJhgJRNEE2eIpk/5yC/Vzu57EzzCrSA+XumQQbQ
         rRzHaMqhvqptDc7Ah2j+J2Oyuuq26Ur1c0sN6L1L4tETBoqr5h5Vj3d+PewnqvIOkicg
         w90FNs+0WlUEWFdwsXUjMQttYwZ9+9BzVaYE9/sqDLrZ+8cqoKZrKND+eFc1hLv6BnYv
         sBFQoPJhrUyTXcTmluCxEB3TIwPfBYFAs8mmK8hlLkwsTyqIEs3+p/WDH4FS07iTHVSp
         P8+g==
X-Gm-Message-State: AOJu0Yxitemfa9GIWZhHFV8irU2ISRYPOdr2wrS2tyUqneaJ3sxPYtAr
	fl+Ir++6SmKenQxGNCAxERuHLFSzFwc=
X-Google-Smtp-Source: AGHT+IEqvj9TXvw7bcChwMaVtYvY8m9QGP874tu2OyHWDDcYi3GRmm51PXOrzQqcc4lVbfEiepSexQ==
X-Received: by 2002:a05:600c:2ed3:b0:40c:48c2:f69f with SMTP id q19-20020a05600c2ed300b0040c48c2f69fmr4584630wmn.12.1703643932580;
        Tue, 26 Dec 2023 18:25:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jb11-20020a05600c54eb00b0040d1746f672sm21762606wmb.14.2023.12.26.18.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:25:32 -0800 (PST)
Message-ID: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Dec 2023 02:25:31 +0000
Subject: [PATCH] precious-files.txt: new document proposing new precious file
 type
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
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>,
    Josh Triplett <josh@joshtriplett.org>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

We have traditionally considered all ignored files to be expendable, but
users occasionally want ignored files that are not considered
expendable.  Add a design document covering how to split ignored files
into two types: 'trashable' (what all ignored files are currently
considered) and 'precious' (the new type of ignored file).

Helped-by: Sebastian Thiel <sebastian.thiel@icloud.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    precious-files.txt: new document proposing new precious file type
    
    A couple months ago, we had another in-depth discussion of precious
    files[1]. As with previous times, multiple strategies were discussed
    (including multiple new ones), meaning we keep making the possible
    solution space wider and never nail down an agreed path. I also got the
    feeling we were potentially pigeonholing on a subset of the problem
    space, and I thought it'd be good to better enumerate what areas of Git
    are affected.
    
    So, I went through the exercise of creating a design document to: (1)
    provide a specific design proposal and explore it, (2) cover at a high
    level the breadth of issues that an implementor needs to at least think
    about and which reviewers should be aware of in terms of readiness of a
    potential implementation, and (3) provide links to other discussions and
    alternative proposals for completeness.
    
    I had some off-list discussions with Sebastian about this proposal, and
    he provided some helpful feedback. The idea at this point is that if
    folks agree with the general direction, that he is going to be
    implementing at least the first cut basic capability. I'll help review
    changes, but I'm mostly interested in avoiding unfortunate surprises.
    
    So...does the proposed direction seem reasonable to folks?
    
    [1]
    https://lore.kernel.org/git/79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1627%2Fnewren%2Fprecious-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1627/newren/precious-files-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1627

 Documentation/technical/precious-files.txt | 540 +++++++++++++++++++++
 1 file changed, 540 insertions(+)
 create mode 100644 Documentation/technical/precious-files.txt

diff --git a/Documentation/technical/precious-files.txt b/Documentation/technical/precious-files.txt
new file mode 100644
index 00000000000..05c205b57bb
--- /dev/null
+++ b/Documentation/technical/precious-files.txt
@@ -0,0 +1,540 @@
+Precious Files Design Document
+==============================
+
+Table of Contents
+  * Objective
+  * Background
+    * File categorization exceptions
+  * Proposal
+    * Precious file specification
+    * Breakdown of suggested behaviors by command
+  * Backward compatibility notes
+    * Slightly incompatible syntax
+    * Interaction with sparse-checkout parsing
+    * Behavior of traditional flags
+    * Interaction with older Git clients
+    * Commands with modified meaning
+  * Implementation hints
+    * Data structures
+    * Code areas
+    * Minimum
+  * Out of scope
+  * Previous discussions
+  * Alternatives considered
+
+Objective
+---------
+Support "Precious" Files in git, a set of files which are considered
+ignored (e.g. do not show up in "git status" output) but are not expendable
+(thus won't be removed to make room for a file when switching or merging
+branches).
+
+Background
+----------
+In git we have different types of files, with various subdivisions:
+  * tracked
+    * present (i.e. part of sparse checkout)
+    * not present (i.e. not part of sparse checkout)
+  * not tracked
+    * ignored (also treated as expendable)
+    * untracked (more precisely, not-tracked-and-not-ignored, but often
+      referred to as simply "untracked" despite the fact that such a term
+      is easily mistaken as a synonym to "not tracked".  However, we haven't
+      been fully consistent, and some places like `git ls-files --others`
+      may use "untracked" to refer to the larger not-tracked category).
+      Not considered expendable.
+
+Over the years, the fact that ignored files are unconditionally treated as
+expendable (so that other operations like git checkout might wipe them out
+to make room for files on the other branch) has occasionally caused
+problems.  Many have expressed a desire for subdividing the ignored class,
+so that we have both ignored-and-expendable (possibly referred to as
+"trashable", covering the only type of ignored file we have today) and
+introducing ignored-and-not-expendable (often referred to as "precious").
+
+File categorization exceptions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Our division above into nice categories is actually a bit of a lie.
+
+Once upon a time untracked files were considered expendable[1].  Even after
+that changed, we still had lots of edge cases where untracked files were
+deleted when they shouldn't be, and ignored files weren't deleted when they
+should be[2].  While that has been (mostly) fixed, despite the general
+intent to preserve untracked files, we have special cases that are
+documented as not preserving them[4,5].  There are also a few codepaths
+that have comments about locations that might (or definitely do)
+erroneously delete untracked paths[6].  And at least one code path that is
+known to erroneously delete untracked paths which has not been commented:
+`git checkout <tree> <pathspec>`.  And there may be more.
+
+[1] https://lore.kernel.org/git/CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com/
+[2] https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
+[3] https://lore.kernel.org/git/de416f887d7ce24f20ad3ad4cc838394d6523635.1632760428.git.gitgitgadget@gmail.com/
+[4] https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/
+[5] https://lore.kernel.org/git/de416f887d7ce24f20ad3ad4cc838394d6523635.1632760428.git.gitgitgadget@gmail.com/
+[6] https://lore.kernel.org/git/6b42a80bf3d46e16980d0724e8b07101225239d0.1632760428.git.gitgitgadget@gmail.com/
+
+This history and these exceptions matter to this proposal because:
+  * it highlights how much work can be involved in trying to treat a class
+    of files as not expendable
+  * the existing corner cases where untracked files are erroneously
+    treated as expendable will probably also double as corner cases where
+    precious files are treated as expendable
+  * the past fixes for treating untracked files as precious will likely
+    highlight the needed types of code changes to treat ignored files as
+    precious
+
+Proposal
+--------
+We propose adding another class of files: ignored-but-not-expendable,
+referred to by the shorthand of "precious".  The proposal is simple at a
+high level, but there are many details to consider:
+  * How to specify precious files (extended .gitignore syntax?  attributes?)
+  * Which commands should be modified, and how?
+  * How to handle flags that are essentially a partial implementation of
+    a precious capability (e.g. [--[no-]overwrite-ignore])?
+  * How will older Git clients behave on a repo with precious files?
+The subsequent sections will try to address these questions in more detail.
+
+One thing to highlight here is that the class formerly called
+`ignored` now has two subtypes: (1) the type we already have,
+ignored-and-expendable (sometimes referred to below as "trashable")
+and (2) the new type, ignored-and-not-expendable (referred to as
+"precious").
+
+Precious file specification
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+As per [P2]:
+
+    """
+    Even though I referred to the precious _attribute_ in some of these
+    discussions, between the attribute mechanism and the ignore
+    mechanism, I am actually leaning toward suggesting to extend the
+    exclude/ignore mechanism to introduce the "precious" class.  That
+    way, we can avoid possible snafu arising from marking a path in
+    .gitignore as ignored, and in .gitattrbutes as precious, and have to
+    figure out how these two settings are to work together.
+    """
+
+we specify precious files via an extension to .gitignore.  In particular,
+lines starting with a '$' character specify that the file is precious.
+For example:
+  $.config
+would say the file `.config` is precious.
+
+Now that there are three types of files specified by .gitignore files --
+untracked, trashable (ignored-and-expendable), and precious
+(ignored-and-not-expendable), the meaning of `!` at the begining of a line
+needs careful clarification.  It could be seen as "not ignored" or as "not
+trashable", given the subdivision of ignored files that has occurred.  We
+specifically take it to mean "not ignored", i.e. "untracked".
+
+This leaves us with a simple set of rules to provide to users about lines
+in their '.gitignore' file:
+  * No special prefix character => ignored-and-expendable ("trashable")
+  * A '$' prefix character      => ignored-and-not-expendable ("precious")
+  * A '!' prefix character      => not ignored, i.e. untracked
+
+It's worth noting that the traditional use of '!' as a negation
+character needs updating, given the introduction of a ternary state
+("not trashable" could mean either untracked or precious, which is
+ambiguous).  Refrain from referring to '!' as a negation character to
+avoid confusion.  To assist users in making this mindset shift, flag
+any line beginning with '!$' as an error. As always,
+backslash-escaping remains an option, allowing users to specify
+entries like '!\$foo' to mark a file named '$foo' as untracked.
+
+Breakdown of suggested behaviors by command
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+See also "Out of Scope" section below, particularly for:
+  * apply, am [without -3]
+  * checkout/restore
+  * checkout-index
+  * additional information on merge backends
+
+Documentation:
+  * audit for references to "ignore" and "ignored", to see which ones need
+    to now replace those with either "ignored-and-expendable" (or
+    "trashable"), and which can remain "ignored".
+  * audit for "exclude" and "excluded" (the older terminology for ignored
+    files) and update them as well.
+  * add references to "precious" (and perhaps "trashable) as needed (don't
+    forget the glossary)
+  * rm: update the documentation:
+      "Ignored files are deemed expendable and won't stop" ->
+      "Ignored files, unless specifically marked precious, are by default
+       deemed expendable and won't stop"
+  * ensure all codepaths touched by 0e29222e0c2 ("Documentation: call out
+    commands that nuke untracked files/directories", 2021-09-27) also call
+    out that they'll nuke precious files in addition to untracked ones.
+  * change the documentation for '!' in gitignore to stop using the term
+    'negates'; it's potentially misleading now (negating a ternary value
+    yields an ambiguous value).  Instead, the prefix is used to mark
+    untracked (or "not ignored") files.
+  * note that the --[no-]overwrite-ignore option is deprecated, and, since
+    it predated the introduction of precious files is also a misnomer.  The
+    correct name of the option would actually be --[no-]overwrite-trashable
+    but it is too late to rename.
+  * consider documenting that merge's --no-overwrite-ignore option is
+    virtually worthless (only works with the fast-forwarding backend).
+  * consider auditing the code for 'untracked' and fixing those to be
+    'not tracked' in cases where both 'untracked' and 'ignored' files
+    are meant
+
+checkout/switch:
+  * will need to not overwrite precious files when they are in the way of
+    switching branches, unless --force/-f is specified.
+
+checkout/restore:
+  * when passed a <tree> as a source, do not overwrite precious files
+    (NOR untracked files!), unless --force/-f is specified.  [Could be
+    considered a stretch goal...]
+
+merge:
+  * do not overwrite precious files when they are in the way of merging
+    branches.  (Must be handled in each and every merge strategy;
+    user-defined merge strategies may get this wrong.)
+
+read-tree:
+  * -u: do not overwrite precious files when they are in the way, unless...
+  * --reset and -u: overwrite precious files as well as untracked files.
+    Add to the warning under --reset about overwritten untracked files to
+    note that precious files are also overwritten.
+
+am -3, cherry-pick, rebase, revert, : same as above for checkout/switch and
+  merge.
+
+add:
+  * same as today, just make sure when we split the ignored array (ignored &
+    ignored_nr) into multiple categories that it continues working
+
+rm:
+  * make sure submodules are not removed if precious files are present.
+    Currently, rm will remove submodules if only ignored files are present.
+
+check-ignore:
+  * since this command exists for debugging gitignore rules, there needs to
+    be some kind of mechanism for differentiating between trashable and
+    precious files.  It is okay if this comes with a new command-line flag,
+    but there should be some tests showing how it behaves both with and
+    without that flag when precious files are present
+
+clean:
+  * clarify the meaning of -x and -X options: -X now means only remove
+    trashable files.  -x means remove both untracked and trashable files.
+    (See also [P17])
+  * add a --all option for removing all not-tracked files: untracked,
+    trashable, and precious.
+  * Other than --all, it is not worth adding flags for cleaning subsets of
+    not-tracked files that include precious files (thus, no flag for just
+    precious, or trashable and precious, or untracked and precious)
+  * Patterns with a leading '$' can be passed to --exclude, if wanted.
+
+ls-files:
+  * --ignored/-i: shows every kind of ignored file (thus behaving the same
+    as today, since there is no way to distinguish between the types of
+    ignored in the output)
+  * add new `--ignored=precious` and `--ignored=trashable` flags for
+    differentiating.  A plain `--ignored` is like having both
+    `--ignored=precious` and `--ignored=trashable` specified.
+  * --exclude,--exclude-from can now take patterns with a leading '$' and
+    the file will be considered precious rather than trashable.
+
+status:
+  * --ignored (without additional parameters) continues behaving as-is: it
+    prints both trashable and precious files in its "Ignored" category with
+    no distinguishing.
+  * --ignored --short will continue showing trashable files with '!!', but
+    will now show precious files using '$$'.
+  * --ignored --porcelain={v1,v2} will continue showing precious files
+    with the '!' character, since scripts may not be prepared to parse a
+    leading '$'.  We can't break those scripts, even if it'd avoid the
+    off chance that those scripts act on the information about "ignored"
+    files and end up nuking precious files.
+  * --ignored --porcelain=v3 will need to be introduced to show precious
+    files with a leading '$'.
+
+sparse-checkout:
+  * the --rules-file option should be tested with a pattern with a leading
+    '$' to make sure it prints an expected error.
+  * it might be worth noting somewhere that sparse-checkout treats
+    ignored files as precious; when sparsifying, it attempts to remove
+    directories that do not match the sparse specification, but will
+    leave them present if any of the tracked files are modified, or if
+    there are any not-tracked files present.  That includes ignored
+    files.  That means no additional work is needed for precious
+    support; I just mention it for completeness.
+
+Backward compatibility notes
+----------------------------
+There are multiple issues that impinge on backward compatibility (either in
+terms of special care we need to take, or in terms of messaging we may need
+to send out about changes):
+  * Slightly incompatible syntax
+  * Interaction with sparse-checkout parsing
+  * Behavior of traditional flags
+  * Interaction with older Git clients
+  * Commands with modified meaning
+We'll discuss each in its own subsection below.
+
+Slightly incompatible syntax
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This new syntax obviously breaks backward compatibility in that an ignored
+path named `$.config` would now have to be specified as `\$.config`.  This
+is similar to how introducing `!` as a prefix in .gitignore files was a
+backward compatibility break.  We expect and hope that the fallout will be
+minor.  See also [P10].
+
+Interaction with sparse-checkout parsing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The $GIT_DIR/info/sparse-checkout file also makes use of gitignore syntax
+and the gitignore parsing to read the file.  It differs in that the files
+specified are considered the files to be included (i.e. present in the
+working copy) rather than which files should be excluded, but otherwise
+has until now used identical syntax and parsing.
+
+However, for sparse-checkout there is no third type of file, so the '$'
+prefix makes no sense for it.  As such, it should be an error for any
+lines to begin with '$' in a sparse-checkout file.
+
+(This also means that if anyone really did have a path beginning with '$'
+in sparse-checkout files previously, then they now need to backslash escape
+them, the same as with .gitignore files.)
+
+While we could theoretically avoid this small backward compatibility break
+for sparse-checkout parsing by just treating a leading '$' the way it
+traditionally has been done, I am worried about practically maintaining that
+solution:
+  * the gitignore parsing is peppered with references like 'exclude' that
+    are specific to the gitignore case
+  * because of the above, it is _heavily_ confusing to attempt to read and
+    understand the gitignore handling while considering the sparse-checkout
+    case.  I've been tripped up by it *many* times.
+  * I think trying to reuse the existing parsing engine and have it handling
+    both old and new syntax is a recipe for failure.  It'd be much cleaner
+    to have errors thrown if the processing turns up any "precious" files,
+    or perhaps if any line starts with '$'.
+  * I think making a copy of the existing parsing, and then letting them
+    diverge, means the two will eventually diverge even further, and we
+    would need to make a copy of all the documentation about gitignore rules
+    for sparse-checkout, all for the non-default non-cone case we are
+    already recommending users away from.
+
+Behavior of traditional flags
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+There are two flags to consider here: the --porcelain flag to git-status,
+and the --no-overwrite-ignore command to checkout & merge commands.  For
+the --porcelain flag to git-status, see the "Breakdown of suggested
+behaviors by command" and look for git-status there.  The rest of this
+section will focus on --[no-]overwrite-ignore.
+
+People have wanted precious files long enough, that they implemented an
+interim kludge of sorts -- a command line option that can be passed to
+various subcommands that treats all ignored files as precious:
+--no-overwrite-ignore.
+
+In particular, this flag can be passed to both git-checkout, and git-merge.
+However, in merge's case, the support depended the flag being passed to the
+backend and the backend supporting it.  The builtin/merge.c code only ever
+bothered to pass this flag down to the fast-forwarding merge handling code,
+so it never worked with any backends that actually create a merge commit.
+
+We do need to keep these flags working, at least as much as they did
+previously.  However, we don't want to consider them desired features,
+which would lead us to making related equivalents for precious files like
+--overwrite-precious.  Instead we will:
+  * Keep --[no-]overwrite-ignore working, as much as it already was.
+  * Recommend users mark precious files in their gitignore files instead of
+    using these flags
+
+Interaction with older Git clients
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Older Git clients will not understand precious files.  This means that:
+  * precious files will be considered untracked and not ignored.
+  * most comands will preserve these files, since untracked-and-not-ignored
+    are not considered expendable.
+  * git status will continue listing these files
+  * git add will add these files without requiring -f.
+
+This seems like a reasonable tradeoff that only has minor annoyances.  The
+alternative of having the precious files treated as ignored has the very
+risky trade-off of deleting files which the users marked as important for
+us to keep.
+
+Commands with modified meaning
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In clean, we adjust the meaning of both -x and -X:
+  -X: remove only trashable files
+  -x: remove untracked and trashable files (but preserve precious ones)
+
+Implementation hints
+--------------------
+
+Data structures
+~~~~~~~~~~~~~~~
+  * We will want to add a `precious` and `precious_nr` in dir_struct,
+    similar to the current entries/nr or ignored/ignored_nr.
+  * We may want to rename `ignored` and `ignored_nr` in dir_struct to
+    `trashable` and `trashable_nr`.
+
+Code areas
+~~~~~~~~~~
+  * "preserve_ignored", a flag in the code for handling the
+    --[no-]overwrite-ignore flag, is a very helpful marker about what needs
+    to be tweaked and how to tweak it to preserve more files.  In particular,
+    note that --no-overwrite-ignore works by telling the machinery in dir.c
+    to not do the setup_standard_excludes() stuff, so that all ignored files
+    just look like untracked files.  We'll need something slightly smarter,
+    which makes precious files look like untracked while trashable files
+    still appear in ignored.  Shouldn't be too bad.
+  * we might need to add another entry to the unpack_trees_reset_type
+    enum.  Or perhaps we still keep both UNPACK_RESET_PROTECT_UNTRACKED
+    and UNPACK_RESET_OVERWRITE_UNTRACKED but rename them with
+    s/UNTRACKED/NOT_EXPENDABLE/ so it is clear they handle both untracked and
+    precious files.  Not sure which is needed yet.
+  * dir_struct->flags _might_ need new entries.
+  * ensure all relevant codepaths touched by 94b7f1563ac ("Comment important
+    codepaths regarding nuking untracked files/dirs", 2021-09-27) are either
+    fixed or also mention precious files
+  * am/rebase/checkout[without -f]: see 480d3d6bf90 ("Change unpack_trees'
+    'reset' flag into an enum", 2021-09-27)
+  * Merge backends:
+    * (see also "Out of scope" section)
+    * merge-ort can be fixed by fixing the checkout code.
+    * merge-resolve and merge-octopus can probably be fixed by fixing
+      git-reset.
+  * stash:
+    * there is an existing --include-untracked option.  There was no reason
+      to add a --include-ignored, because ignored files were trashable.  Do
+      we need to add a --include-precious, though?
+    * this is a sad pile of shell-reimplemented-in-C.  It's just awful.
+      See b34ab4a43ba ("stash: remove unnecessary process forking",
+      2020-12-01) and ba359fd5070 ("stash: fix stash application in
+      sparse-checkouts", 2020-12-01) and 94b7f1563ac ("Comment important
+      codepaths regarding nuking untracked files/dirs", 2021-09-27).
+      Fixing stash to not nuke precious files (and to not nuke untracked
+      files either) might mean expunging the stupid
+      shell-reimplemented-in-C design, or at least moving things more in
+      that direction.
+  * rebase (merge backend), revert, cherry-pick, am -3: should automatically
+    be handled by getting merge-ort to work, which should work by making
+    checkout/switch work.
+  * bisect: should work by making checkout work
+
+Minimum
+~~~~~~~
+
+I think for a minimum implementation, we need to ensure that the following
+are handled:
+  * parsing:
+    * parsing of lines starting with '$' in .gitignore
+    * erroring on lines starting with '!$' in .gitignore
+    * erroring on lines starting with '$' in $GIT_DIR/info/sparse-checkout
+  * commands with support:
+    * switch/checkout
+    * merge when using the ort backend
+    * read-tree -u [without --reset] (due to internal use)
+    * ls-files
+
+Out of scope
+------------
+The following tasks are currently out of scope for this proposal:
+
+apply, am [without -3]: apply won't overwrite any file in the working
+  directory even when a new file is in the patch.  It should overwrite
+  trashable files.  We could log that bug via testcase, but make sure
+  there's a companion testcase that ensures overwriting untracked or
+  precious files continues to make apply throw an error.  However, since
+  apply/am don't misbehave for precious files, we can defer this to later.
+
+checkout-index: similar to apply; won't overwrite any existing files, but
+  trashable files should be overwritten
+
+reset --hard:
+  * `git reset --hard` is a little funny and we have thought about changing
+    it[4].  However, that can be left for later and will not be tackled as
+    part of the work of introducing "precious" files as a concept.
+
+merge backends:
+  * it may make sense to try to make --no-overwrite-ignore work with more
+    merge backends, both because it's technically documented behavior, and
+    because doing so may be a step towards getting precious files supported
+  * when multiple merge strategies are specified, builtin/merge.c will
+    stash and restore state between the attempt of different strategies.
+    Since the reset_hard() function invokes `read-tree --reset -u`, there
+    might be a way to cause it to trash untracked files or to trash
+    precious files, depending on what the merge strategies did.  It seems
+    unlikely (maybe the strategy handles D/F conflicts or rename
+    conflicts by renaming files in the way, and happens to rename a
+    precious file to a path that is considered either untracked or
+    precious -- merge-recursive certainly did this something like this
+    once upon a time and still might); we can probably ignore it for now.
+  * merge-recursive is a lost cause; it'd be a _huge_ amount of effort to
+    fix, but we intend to deprecate and delete it soon anyway (making all
+    requests for recursive just trigger ort instead).
+  * user-defined merge strategies are up to their authors to get right.
+    Odds are they won't, but odds are they already incorrectly nuke
+    untracked files too because who'd pay attention to a special case
+    like files being in the way of a merge?  Anyway, "not our problem".  :-)
+
+Previous discussions
+--------------------
+
+A far from exhaustive sampling of various past conversations on the topic:
+
+[P1] https://lore.kernel.org/git/7vipsnar23.fsf@alter.siamese.dyndns.org/
+[P2] https://lore.kernel.org/git/xmqqttqytnqb.fsf@gitster.g/
+[P3] https://lore.kernel.org/git/79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com/
+[P4] https://lore.kernel.org/git/87a6q9kacx.fsf@evledraar.gmail.com/
+[P5] https://lore.kernel.org/git/20190216114938.18843-1-pclouds@gmail.com/
+[P6] https://lore.kernel.org/git/87ftsi68ke.fsf@evledraar.gmail.com/
+[P7] https://lore.kernel.org/git/xmqqo7ub4sfh.fsf@gitster.g/
+[P8] https://lore.kernel.org/git/7v4oepaup7.fsf@alter.siamese.dyndns.org/
+[P9] https://lore.kernel.org/git/20181112232209.GK890086@genre.crustytoothpaste.net/
+[P10] https://lore.kernel.org/git/xmqqttqvg4lw.fsf@gitster.g/
+[P11] https://lore.kernel.org/git/xmqqk1hrr91s.fsf@gitster-ct.c.googlers.com/
+[P12] https://lore.kernel.org/git/9C4A2AFD-AAA2-4ABA-8A8B-2133FD870366@icloud.com/
+[P13] https://lore.kernel.org/git/xmqqfs2e3292.fsf@gitster.g/
+[P14] https://lore.kernel.org/git/0deee2bc-1775-4459-906d-1d44b3103499@gmail.com/
+[P15] https://lore.kernel.org/git/ZSkpOc%2FdcGcrFQNU@ugly/
+[P16] https://lore.kernel.org/git/xmqqil79t82q.fsf@gitster.g/
+[P17] https://lore.kernel.org/git/xmqqo7h6tnib.fsf@gitster.g/
+
+Alternatives considered
+-----------------------
+There have been multiple alternatives considered, along a few different
+axes:
+  * .gitattributes instead of .gitignore
+  * leaving sparse-checkout alone
+  * Trashable [P9,P11]
+  * Alternative gitignore syntax
+
+The choice of .gitattributes vs .gitignore was already addressed in the
+"Precious file specification" section.
+
+The choice to modify or leave alone the parsing of
+$GIT_DIR/info/sparse-checkout was already addressed in the "Interaction
+with sparse-checkout parsing" section.
+
+One alternative raised in the past was treating ignored files as not
+expendable by default, and then introducing a new category of
+ignored-but-expendable.  This new category has been dubbed "trashable" in
+the past.  That may have been a reasonable solution if Git did not have a
+large userbase already, but moving in this direction would cause severe
+problems for existing builds everywhere[P9] and would require users to
+doubly configure most files (since it is expected that
+ignored-but-expendable is a much larger class of files than
+ignored-but-precious).  See also [P11].
+
+There have been multiple alternative suggestions for extending gitignore
+syntax to handle precious files and optionally future extensions as well.
+For example: [P10, P12, P13, P14, P15, P16]  However:
+  * There have been on and off requests for precious files for about 14
+    years
+  * We are not aware of other types of extensions needed; there might
+    not be any
+  * The alternatives all seem much more complex to explain to users than
+    the simple proposal here.
+In particular, we like the simplicity of the providing the simple mapping
+to users from the penultimate paragraph of the "Precious file
+specification" section (the one regarding no-prefix vs. '!' vs '$').

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
