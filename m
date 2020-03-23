Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55EEC54FCF
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 01:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B7A206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 01:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="of1drN4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCWBKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:10:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58380 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCWBKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 21:10:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3BF443E6;
        Sun, 22 Mar 2020 21:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=txJJRFTlkMteoUcNpDuUMsJEp
        b4=; b=of1drN4O8guvoO9J6c1gibQ0ycNOuNYCigT7n4+4FZDavEQGvO1E66JTP
        Q8Sw1lygcQ6kTJDgoSgUugMoVGwAEOw3CHQPTb/B7gs5eQNUE4/q4uLpuZROh5NR
        GfLtxNbmC7ZyWDxt2CbVjd+w6YYSqIgbx8FQWSOjKkT8inu9WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=rjDmmqoRbPTXTu4kw1j
        ZXpgCQZIaqEDYf7uVUtrT8axJ8yT11eCqxH9tA3gp8GaxgsBloQUFz7iN5mqbRap
        pgLyVYICn9Z7aRAlUTtPXhahyuF1dYu60fXsax9sDrkCDEvjrgQ82BYZK4/gUWMQ
        Dxglaguq3PfGYVxBmPpPW6qE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85E61443E5;
        Sun, 22 Mar 2020 21:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0135443E4;
        Sun, 22 Mar 2020 21:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.26.0
Date:   Sun, 22 Mar 2020 18:10:12 -0700
Message-ID: <xmqqa7477u6j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C427E1E-6CA3-11EA-A899-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.26.0 is now available at the
usual places.  It is comprised of 504 non-merge commits since
v2.25.0, contributed by 64 people, 12 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.26.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.25.0 are as follows.
Welcome to the Git development community!

  Abhishek Kumar, Benno Evers, Emir Sar=C4=B1, Eyal Soha, Harald
  van Dijk, Jacques Bodin-Hullin, Kir Kolyshkin, Lucius Hu,
  Luke Bonanomi, Peter Kaestle, Rasmus Jonsson, and Shourya Shukla.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alban Gruin, Alessandro Menti, Alexander Shopov, Alexandr
  Miloslavskiy, Beat Bolli, Bert Wesarg, brian m. carlson,
  Christian Stimming, Christopher Diaz Riveros, David Turner,
  Denton Liu, Derrick Stolee, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh,=
 Elijah
  Newren, Emily Shaffer, Eric Sunshine, Fangyi Zhou, Hans
  Jerry Illikainen, Hariom Verma, Heba Waly, Jean-No=C3=ABl Avila,
  Jeff King, Jiang Xin, Johan Herland, Johannes Berg, Johannes
  Schindelin, Johannes Sixt, Jonathan Nieder, Jonathan Tan, Jordi
  Mas, Junio C Hamano, Kevin Willford, Kyle Meyer, Luke Diamand,
  Martin =C3=85gren, Masaya Suzuki, Matheus Tavares, Matthew Rogers,
  Matthias R=C3=BCster, Miriam Rubio, Paolo Bonzini, Peter Krefting,
  Philippe Blain, Pranit Bauva, Pratyush Yadav, Ralf Thielow,
  Ren=C3=A9 Scharfe, SZEDER G=C3=A1bor, Tanushree Tumane, Taylor Blau,
  Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and Yi-Jyun Pan.

----------------------------------------------------------------

Git 2.26 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v2.25
-------------------

Backward compatibility notes

 * "git rebase" uses a different backend that is based on the 'merge'
   machinery by default.  There are a few known differences in the
   behaviour from the traditional machinery based on patch+apply.

   If your workflow is negatively affected by this change, please
   report it to git@vger.kernel.org so that we can take a look into
   it.  After doing so, you can set the 'rebase.backend' configuration
   variable to 'apply', in order to use the old default behaviour in
   the meantime.


UI, Workflows & Features

 * Sample credential helper for using .netrc has been updated to work
   out of the box.

 * gpg.minTrustLevel configuration variable has been introduced to
   tell various signature verification codepaths the required minimum
   trust level.

 * The command line completion (in contrib/) learned to complete
   subcommands and arguments to "git worktree".

 * Disambiguation logic to tell revisions and pathspec apart has been
   tweaked so that backslash-escaped glob special characters do not
   count in the "wildcards are pathspec" rule.

 * One effect of specifying where the GIT_DIR is (either with the
   environment variable, or with the "git --git-dir=3D<where> cmd"
   option) is to disable the repository discovery.  This has been
   placed a bit more stress in the documentation, as new users often
   get confused.

 * Two help messages given when "git add" notices the user gave it
   nothing to add have been updated to use advise() API.

 * A new version of fsmonitor-watchman hook has been introduced, to
   avoid races.

 * "git config" learned to show in which "scope", in addition to in
   which file, each config setting comes from.

 * The basic 7 colors learned the brighter counterparts
   (e.g. "brightred").

 * "git sparse-checkout" learned a new "add" subcommand.

 * A configuration element used for credential subsystem can now use
   wildcard pattern to specify for which set of URLs the entry
   applies.

 * "git clone --recurse-submodules --single-branch" now uses the same
   single-branch option when cloning the submodules.

 * "git rm" and "git stash" learns the new "--pathspec-from-file"
   option.

 * "git am --show-current-patch" is a way to show the piece of e-mail
   for the stopped step, which is not suitable to directly feed "git
   apply" (it is designed to be a good "git am" input).  It learned a
   new option to show only the patch part.

 * Handling of conflicting renames in merge-recursive have further
   been made consistent with how existing codepaths try to mimic what
   is done to add/add conflicts.


Performance, Internal Implementation, Development Support etc.

 * Tell .editorconfig that in this project, *.txt files are indented
   with tabs.

 * The test-lint machinery knew to check "VAR=3DVAL shell_function"
   construct, but did not check "VAR=3D shell_function", which has been
   corrected.

 * Replace "git config --bool" calls with "git config --type=3Dbool" in
   sample templates.

 * The effort to move "git-add--interactive" to C continues.

 * Improve error message generation for "git submodule add".

 * Preparation of test scripts for the day when the object names will
   use SHA-256 continues.

 * Warn programmers about pretend_object_file() that allows the code
   to tentatively use in-core objects.

 * The way "git pack-objects" reuses objects stored in existing pack
   to generate its result has been improved.

 * The transport protocol version 2 becomes the default one.

 * Traditionally, we avoided threaded grep while searching in objects
   (as opposed to files in the working tree) as accesses to the object
   layer is not thread-safe.  This limitation is getting lifted.

 * "git rebase -i" (and friends) used to unnecessarily check out the
   tip of the branch to be rebased, which has been corrected.

 * A low-level API function get_oid(), that accepts various ways to
   name an object, used to issue end-user facing error messages
   without l10n, which has been updated to be translatable.

 * Unneeded connectivity check is now disabled in a partial clone when
   fetching into it.

 * Some rough edges in the sparse-checkout feature, especially around
   the cone mode, have been cleaned up.

 * The diff-* plumbing family of subcommands now pay attention to the
   diff.wsErrorHighlight configuration, which has been ignored before;
   this allows "git add -p" to also show the whitespace problems to
   the end user.

 * Some codepaths were given a repository instance as a parameter to
   work in the repository, but passed the_repository instance to its
   callees, which has been cleaned up (somewhat).

 * Memory footprint and performance of "git name-rev" has been
   improved.

 * The object reachability bitmap machinery and the partial cloning
   machinery were not prepared to work well together, because some
   object-filtering criteria that partial clones use inherently rely
   on object traversal, but the bitmap machinery is an optimization
   to bypass that object traversal.  There however are some cases
   where they can work together, and they were taught about them.

 * "git rebase" has learned to use the merge backend (i.e. the
   machinery that drives "rebase -i") by default, while allowing
   "--apply" option to use the "apply" backend (e.g. the moral
   equivalent of "format-patch piped to am").  The rebase.backend
   configuration variable can be set to customize.

 * Underlying machinery of "git bisect--helper" is being refactored
   into pieces that are more easily reused.


Fixes since v2.25
-----------------

 * "git commit" gives output similar to "git status" when there is
   nothing to commit, but without honoring the advise.statusHints
   configuration variable, which has been corrected.

 * has_object_file() said "no" given an object registered to the
   system via pretend_object_file(), making it inconsistent with
   read_object_file(), causing lazy fetch to attempt fetching an
   empty tree from promisor remotes.

 * Complete an update to tutorial that encourages "git switch" over
   "git checkout" that was done only half-way.

 * C pedantry ;-) fix.

 * The code that tries to skip over the entries for the paths in a
   single directory using the cache-tree was not careful enough
   against corrupt index file.

 * Reduce unnecessary round-trip when running "ls-remote" over the
   stateless RPC mechanism.

 * "git restore --staged" did not correctly update the cache-tree
   structure, resulting in bogus trees to be written afterwards, which
   has been corrected.

 * The code recently added to move to the entry beyond the ones in the
   same directory in the index in the sparse-cone mode did not count
   the number of entries to skip over incorrectly, which has been
   corrected.

 * Rendering by "git log --graph" of ancestry lines leading to a merge
   commit were made suboptimal to waste vertical space a bit with a
   recent update, which has been corrected.

 * Work around test breakages caused by custom regex engine used in
   libasan, when address sanitizer is used with more recent versions
   of gcc and clang.

 * Minor bugfixes to "git add -i" that has recently been rewritten in C.

 * "git fetch --refmap=3D" option has got a better documentation.

 * "git checkout X" did not correctly fail when X is not a local
   branch but could name more than one remote-tracking branches
   (i.e. to be dwimmed as the starting point to create a corresponding
   local branch), which has been corrected.
   (merge fa74180d08 am/checkout-file-and-ref-ref-ambiguity later to main=
t).

 * Corner case bugs in "git clean" that stems from a (necessarily for
   performance reasons) awkward calling convention in the directory
   enumeration API has been corrected.

 * A fetch that is told to recursively fetch updates in submodules
   inevitably produces reams of output, and it becomes hard to spot
   error messages.  The command has been taught to enumerate
   submodules that had errors at the end of the operation.
   (merge 0222540827 es/fetch-show-failed-submodules-atend later to maint=
).

 * The "--recurse-submodules" option of various subcommands did not
   work well when run in an alternate worktree, which has been
   corrected.

 * Futureproofing a test not to depend on the current implementation
   detail.

 * Running "git rm" on a submodule failed unnecessarily when
   .gitmodules is only cache-dirty, which has been corrected.

 * C pedantry ;-) fix.

 * "git grep --no-index" should not get affected by the contents of
   the .gitmodules file but when "--recurse-submodules" is given or
   the "submodule.recurse" variable is set, it did.  Now these
   settings are ignored in the "--no-index" mode.

 * Technical details of the bundle format has been documented.

 * Unhelpful warning messages during documentation build have been squelc=
hed.

 * "git rebase -i" identifies existing commits in its todo file with
   their abbreviated object name, which could become ambiguous as it
   goes to create new commits, and has a mechanism to avoid ambiguity
   in the main part of its execution.  A few other cases however were
   not covered by the protection against ambiguity, which has been
   corrected.

 * Allow the rebase.missingCommitsCheck configuration to kick in when
   "rebase --edit-todo" and "rebase --continue" restarts the procedure.
   (merge 5a5445d878 ag/edit-todo-drop-check later to maint).

 * The way "git submodule status" reports an initialized but not yet
   populated submodule has not been reimplemented correctly when a
   part of the "git submodule" command was rewritten in C, which has
   been corrected.
   (merge f38c92452d pk/status-of-uncloned-submodule later to maint).

 * The code to automatically shrink the fan-out in the notes tree had
   an off-by-one bug, which has been killed.

 * The index-pack code now diagnoses a bad input packstream that
   records the same object twice when it is used as delta base; the
   code used to declare a software bug when encountering such an
   input, but it is an input error.


 * The code to compute the commit-graph has been taught to use a more
   robust way to tell if two object directories refer to the same
   thing.
   (merge a7df60cac8 tb/commit-graph-object-dir later to maint).

 * "git remote rename X Y" needs to adjust configuration variables
   (e.g. branch.<name>.remote) whose value used to be X to Y.
   branch.<name>.pushRemote is now also updated.

 * Update to doc-diff.

 * Doc markup fix.

 * "git check-ignore" did not work when the given path is explicitly
   marked as not ignored with a negative entry in the .gitignore file.

 * The merge-recursive machinery failed to refresh the cache entry for
   a merge result in a couple of places, resulting in an unnecessary
   merge failure, which has been fixed.

 * Fix for a bug revealed by a recent change to make the protocol v2
   the default.

 * In rare cases "git worktree add <path>" could think that <path>
   was already a registered worktree even when it wasn't and refuse
   to add the new worktree. This has been corrected.
   (merge bb69b3b009 es/worktree-avoid-duplication-fix later to maint).

 * "git push" should stop from updating a branch that is checked out
   when receive.denyCurrentBranch configuration is set, but it failed
   to pay attention to checkouts in secondary worktrees.  This has
   been corrected.
   (merge 4d864895a2 hv/receive-denycurrent-everywhere later to maint).

 * "git rebase BASE BRANCH" rebased/updated the tip of BRANCH and
   checked it out, even when the BRANCH is checked out in a different
   worktree.  This has been corrected.
   (merge b5cabb4a96 es/do-not-let-rebase-switch-to-protected-branch late=
r to maint).

 * "git describe" in a repository with multiple root commits sometimes
   gave up looking for the best tag to describe a given commit with
   too early, which has been adjusted.

 * "git merge signed-tag" while lacking the public key started to say
   "No signature", which was utterly wrong.  This regression has been
   reverted.

 * MinGW's poll() emulation has been improved.

 * "git show" and others gave an object name in raw format in its
   error output, which has been corrected to give it in hex.

 * "git fetch" over HTTP walker protocol did not show any progress
   output.  We inherently do not know how much work remains, but still
   we can show something not to bore users.
   (merge 7655b4119d rs/show-progress-in-dumb-http-fetch later to maint).

 * Both "git ls-remote -h" and "git grep -h" give short usage help,
   like any other Git subcommand, but it is not unreasonable to expect
   that the former would behave the same as "git ls-remote --head"
   (there is no other sensible behaviour for the latter).  The
   documentation has been updated in an attempt to clarify this.

 * Other code cleanup, docfix, build fix, etc.
   (merge d0d0a357a1 am/update-pathspec-f-f-tests later to maint).
   (merge f94f7bd00d am/test-pathspec-f-f-error-cases later to maint).
   (merge c513a958b6 ss/t6025-modernize later to maint).
   (merge b441717256 dl/test-must-fail-fixes later to maint).
   (merge d031049da3 mt/sparse-checkout-doc-update later to maint).
   (merge 145136a95a jc/skip-prefix later to maint).
   (merge 5290d45134 jk/alloc-cleanups later to maint).
   (merge 7a9f8ca805 rs/parse-options-concat-dup later to maint).
   (merge 517b60564e rs/strbuf-insertstr later to maint).
   (merge f696a2b1c8 jk/mailinfo-cleanup later to maint).
   (merge de26f02db1 js/test-avoid-pipe later to maint).
   (merge a2dc43414c es/doc-mentoring later to maint).
   (merge 02bbbe9df9 es/worktree-cleanup later to maint).
   (merge 2ce6d075fa rs/micro-cleanups later to maint).
   (merge 27f182b3fc rs/blame-typefix-for-fingerprint later to maint).
   (merge 3c29e21eb0 ma/test-cleanup later to maint).
   (merge 240fc04f81 ag/rebase-remove-redundant-code later to maint).
   (merge d68ce906c7 rs/commit-graph-code-simplification later to maint).
   (merge a51d9e8f07 rj/t1050-use-test-path-is-file later to maint).
   (merge fd0bc17557 kk/complete-diff-color-moved later to maint).
   (merge 65bf820d0e en/test-cleanup later to maint).

----------------------------------------------------------------

Changes since v2.25.0 are as follows:

Abhishek Kumar (2):
      lib-log-graph: consolidate test_cmp_graph logic
      lib-log-graph: consolidate colored graph cmp logic

Alban Gruin (4):
      rebase -i: stop checking out the tip of the branch to rebase
      sequencer: move check_todo_list_from_file() to rebase-interactive.c
      rebase-interactive: warn if commit is dropped with `rebase --edit-t=
odo'
      builtin/rebase: remove a call to get_oid() on `options.switch_to'

Alessandro Menti (2):
      l10n: it.po: update the Italian translation for Git 2.26.0 round 1
      l10n: it.po: update the Italian translation for Git 2.26.0 round 2

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (4835t)
      l10n: bg.po: Updated Bulgarian translation (4839t)

Alexandr Miloslavskiy (14):
      parse_branchname_arg(): extract part as new function
      checkout: don't revert file on ambiguous tracking branches
      t: add tests for error conditions with --pathspec-from-file
      t: fix quotes tests for --pathspec-from-file
      t: directly test parse_pathspec_file()
      doc: rm: synchronize <pathspec> description
      rm: support the --pathspec-from-file option
      doc: stash: split options from description (1)
      doc: stash: split options from description (2)
      doc: stash: document more options
      doc: stash: synchronize <pathspec> description
      stash: eliminate crude option parsing
      stash push: support the --pathspec-from-file option
      mingw: workaround for hangs when sending STDIN

Beat Bolli (1):
      unicode: update the width tables to Unicode 13.0

Benno Evers (1):
      describe: don't abort too early when searching tags

Bert Wesarg (6):
      pull --rebase/remote rename: document and honor single-letter abbre=
viations rebase types
      remote: clean-up by returning early to avoid one indentation
      remote: clean-up config callback
      remote rename/remove: handle branch.<name>.pushRemote config values
      config: provide access to the current line number
      remote rename/remove: gently handle remote.pushDefault config

Christian Stimming (3):
      git-gui: update pot template and German translation to current sour=
ce code
      git-gui: extend translation glossary template with more terms
      git-gui: update German translation

Christopher Diaz Riveros (1):
      l10n: es: 2.26.0 round#2

David Turner (1):
      git rm submodule: succeed if .gitmodules index stat info is zero

Denton Liu (34):
      t/lib-git-p4: use test_path_is_missing()
      t0000: replace test_must_fail with run_sub_test_lib_test_err()
      t0003: use named parameters in attr_check()
      t0003: use test_must_be_empty()
      t0003: don't use `test_must_fail attr_check`
      t0020: don't use `test_must_fail has_cr`
      t0020: use ! check_packed_refs_marked
      t1306: convert `test_might_fail rm` to `rm -f`
      t1307: reorder `nongit test_must_fail`
      t1409: let sed open its own input file
      t1409: use test_path_is_missing()
      t1501: remove use of `test_might_fail cp`
      t1507: stop losing return codes of git commands
      t1507: run commands within test_expect_success
      t1507: inline full_name()
      contrib/credential/netrc: make PERL_PATH configurable
      contrib/credential/netrc: work outside a repo
      t2018: remove trailing space from test description
      t2018: add space between function name and ()
      t2018: improve style of if-statement
      .mailmap: fix erroneous authorship for Johannes Schindelin
      t2018: be more discerning when checking for expected exit codes
      t2018: teach do_checkout() to accept `!` arg
      t2018: don't lose return code of git commands
      t2018: replace "sha" with "oid"
      t3030: use test_path_is_missing()
      t3310: extract common notes_merge_files_gone()
      t3415: stop losing return codes of git commands
      t3415: increase granularity of test_auto_{fixup,squash}()
      t3419: stop losing return code of git command
      t3507: fix indentation
      t3507: use test_path_is_missing()
      t4124: only mark git command with test_must_fail
      .mailmap: map Yi-Jyun Pan's email

Derrick Stolee (26):
      unpack-trees: correctly compute result count
      graph: add test to demonstrate horizontal line bug
      graph: fix collapse of multiple edges
      clean: demonstrate a bug with pathspecs
      fetch: document and test --refmap=3D""
      t1091: use check_files to reduce boilerplate
      t1091: improve here-docs
      sparse-checkout: create leading directories
      clone: fix --sparse option with URLs
      sparse-checkout: cone mode does not recognize "**"
      sparse-checkout: detect short patterns
      sparse-checkout: warn on globs in cone patterns
      sparse-checkout: properly match escaped characters
      sparse-checkout: write escaped patterns in cone mode
      sparse-checkout: unquote C-style strings over --stdin
      sparse-checkout: use C-style quotes in 'list' subcommand
      sparse-checkout: escape all glob characters on write
      sparse-checkout: improve docs around 'set' in cone mode
      sparse-checkout: fix cone mode behavior mismatch
      sparse-checkout: extract add_patterns_from_input()
      sparse-checkout: extract pattern update from 'set' subcommand
      sparse-checkout: create 'add' subcommand
      sparse-checkout: work with Windows paths
      sparse-checkout: allow one-character directories in cone mode
      partial-clone: demonstrate bugs in partial fetch
      partial-clone: avoid fetching when looking for objects

Elijah Newren (36):
      unpack-trees: exit check_updates() early if updates are not wanted
      string-list: note in docs that callers can specify sorting function
      dir: treat_leading_path() and read_directory_recursive(), round 2
      git-rebase.txt: update description of --allow-empty-message
      t3404: directly test the behavior of interest
      rebase (interactive-backend): make --keep-empty the default
      rebase (interactive-backend): fix handling of commits that become e=
mpty
      t3406: simplify an already simple test
      rebase, sequencer: remove the broken GIT_QUIET handling
      rebase: make sure to pass along the quiet flag to the sequencer
      rebase: fix handling of restrict_revision
      t3432: make these tests work with either am or merge backends
      rebase: allow more types of rebases to fast-forward
      git-rebase.txt: add more details about behavioral differences of ba=
ckends
      rebase: move incompatibility checks between backend options a bit e=
arlier
      rebase: add an --am option
      git-prompt: change the prompt for interactive-based rebases
      rebase: drop '-i' from the reflog for interactive-based rebases
      rebase tests: mark tests specific to the am-backend with --am
      rebase tests: repeat some tests using the merge backend instead of =
am
      rebase: make the backend configurable via config setting
      rebase: change the default backend from "am" to "merge"
      rebase: rename the two primary rebase backends
      check-ignore: fix documentation and implementation to match
      t3433: new rebase testcase documenting a stat-dirty-like failure
      merge-recursive: fix the refresh logic in update_file_flags
      merge-recursive: apply collision handling unification to recursive =
case
      t602[1236], t6034: modernize test formatting
      t6020, t6022, t6035: update merge tests to use test helper function=
s
      t3035: prefer test_must_fail to bash negation for git commands
      t6022, t6046: test expected behavior instead of testing a proxy for=
 it
      t6020: new test with interleaved lexicographic ordering of director=
ies
      sequencer: clear state upon dropping a become-empty commit
      git-rebase.txt: highlight backend differences with commit rewording
      t6022, t6046: fix flaky files-are-updated checks
      RelNotes/2.26.0: fix various typos

Emily Shaffer (9):
      unpack-trees: watch for out-of-range index position
      fetch: emphasize failure during submodule fetch
      MyFirstContribution: add avenues for getting help
      submodule: add newline on invalid submodule error
      MyFirstContribution: rephrase contact info
      prefix_path: show gitdir when arg is outside repo
      submodule--helper: use C99 named initializer
      clone: pass --single-branch during --recurse-submodules
      prefix_path: show gitdir if worktree unavailable

Emir Sar=C4=B1 (5):
      l10n: tr: Add Turkish translation team info
      l10n: tr: Add Turkish translations
      l10n: tr: Add glossary for Turkish translations
      l10n: tr: v2.26.0 round 2
      l10n: tr: Fix a couple of ambiguities

Eric Sunshine (6):
      t3400: make test clean up after itself
      rebase: refuse to switch to branch already checked out elsewhere
      worktree: drop unused code from get_main_worktree()
      worktree: improve find_worktree() documentation
      worktree: add utility to find worktree by pathname
      worktree: don't allow "add" validation to be fooled by suffix match=
ing

Eyal Soha (3):
      color.c: refactor color_output arguments
      color.c: support bright aixterm colors
      color.c: alias RGB colors 8-15 to aixterm colors

Fangyi Zhou (1):
      l10n: zh_CN: Revise v2.26.0 translation

Hans Jerry Illikainen (2):
      editorconfig: indent text files with tabs
      gpg-interface: add minTrustLevel as a configuration option

Harald van Dijk (1):
      show_one_mergetag: print non-parent in hex form.

Hariom Verma (4):
      get_main_worktree(): allow it to be called in the Git directory
      t5509: use a bare repository for test push target
      receive.denyCurrentBranch: respect all worktrees
      t2402: test worktree path when called in .git directory

Heba Waly (5):
      commit: honor advice.statusHints when rejecting an empty commit
      doc/gitcore-tutorial: fix prose to match example command
      add: use advise function to display hints
      git: update documentation for --git-dir
      add: change advice config variables used by the add API

Jacques Bodin-Hullin (1):
      parse-options: lose an unnecessary space in an error message

Jean-No=C3=ABl Avila (2):
      l10n: fr v2.26.0 rnd1
      l10n: fr : v2.26.0 rnd 2

Jeff King (70):
      builtin/pack-objects: report reused packfile objects
      packfile: expose get_delta_base()
      restore: invalidate cache-tree when removing entries with --staged
      transport: don't flush when disconnecting stateless-rpc helper
      dir: restructure in a way to avoid passing around a struct dirent
      dir: point treat_leading_path() warning to the right place
      Makefile: use compat regex with SANITIZE=3Daddress
      t4018: drop "debugging" cat from hunk-header tests
      t7800: don't rely on reuse_worktree_file()
      ewah/bitmap: introduce bitmap_word_alloc()
      pack-bitmap: introduce bitmap_walk_contains()
      pack-bitmap: uninteresting oid can be outside bitmapped packfile
      pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
      csum-file: introduce hashfile_total()
      pack-objects: introduce pack.allowPackReuse
      builtin/pack-objects: introduce obj_is_packed()
      pack-objects: improve partial packfile reuse
      pack-objects: add checks for duplicate objects
      pack-bitmap: don't rely on bitmap_git->reuse_objects
      sparse-checkout: fix documentation typo for core.sparseCheckoutCone
      verify_filename(): handle backslashes in "wildcards are pathspecs" =
rule
      merge-recursive: silence -Wxor-used-as-pow warning
      t1400: avoid "test" string comparisons
      t1506: drop space after redirection operator
      avoid computing zero offsets from NULL pointer
      xdiff: avoid computing non-zero offset from NULL pointer
      obstack: avoid computing offsets from NULL pointer
      doc: drop "explicitly given" from push.default description
      sha1-name: mark get_oid() error messages for translation
      normalize_path_copy(): document "dst" size expectations
      walker_fetch(): avoid raw array length computation
      traverse_trees(): use stack array for name entries
      diff: move diff.wsErrorHighlight to "basic" config
      tree-walk.c: break circular dependency with unpack-trees
      index-pack: downgrade twice-resolved REF_DELTA to die()
      mailinfo: treat header values as C strings
      mailinfo: simplify parsing of header values
      mailinfo: be more liberal with header whitespace
      mailinfo: factor out some repeated header handling
      pack-bitmap: factor out type iterator initialization
      pack-bitmap: fix leak of haves/wants object lists
      rev-list: fallback to non-bitmap traversal when filtering
      pack-bitmap: refuse to do a bitmap traversal with pathspecs
      rev-list: factor out bitmap-optimized routines
      rev-list: make --count work with --objects
      rev-list: allow bitmaps when counting objects
      t5310: factor out bitmap traversal comparison
      rev-list: allow commit-only bitmap traversals
      pack-bitmap: basic noop bitmap filter infrastructure
      rev-list: use bitmap filters for traversal
      bitmap: add bitmap_unset() function
      pack-bitmap: implement BLOB_NONE filtering
      pack-bitmap: implement BLOB_LIMIT filtering
      pack-objects: support filters with bitmaps
      doc: move credential helper info into gitcredentials(7)
      doc/config/push: use longer "--" line for preformatted example
      doc-diff: use single-colon rule in rendering Makefile
      run-command.h: fix mis-indented struct member
      nth_packed_object_oid(): use customary integer return
      pack-objects: read delta base oid into object_id struct
      pack-objects: convert oe_set_delta_ext() to use object_id
      pack-objects: use object_id struct in pack-reuse code
      pack-bitmap: use object_id when loading on-disk bitmaps
      pack-check: convert "internal error" die to a BUG()
      pack-check: push oid lookup into loop
      packed_object_info(): use object_id for returning delta base
      packed_object_info(): use object_id internally for delta base
      packfile: drop nth_packed_object_sha1()
      config.mak.dev: re-enable -Wformat-zero-length
      remote: drop "explicit" parameter from remote_ref_for_branch()

Jiang Xin (5):
      l10n: git.pot: v2.26.0 round 1 (73 new, 38 removed)
      l10n: git.pot: v2.26.0 round 2 (7 new, 2 removed)
      i18n: unmark a message in rebase.c
      l10n: zh_CN: for git v2.26.0 l10n round 1 and 2
      l10n: tr.po: change file mode to 644

Johan Herland (2):
      t3305: check notes fanout more carefully and robustly
      notes.c: fix off-by-one error when decreasing notes fanout

Johannes Berg (1):
      pack-format: correct multi-pack-index description

Johannes Schindelin (33):
      built-in add -p: prepare for patch modes other than "stage"
      built-in add -p: implement the "stash" and "reset" patch modes
      legacy stash -p: respect the add.interactive.usebuiltin setting
      built-in stash: use the built-in `git add -p` if so configured
      built-in add -p: implement the "checkout" patch modes
      built-in add -p: implement the "worktree" patch modes
      commit --interactive: make it work with the built-in `add -i`
      t3701: adjust difffilter test
      built-in add -p: support interactive.diffFilter
      built-in add -p: handle diff.algorithm
      terminal: make the code of disable_echo() reusable
      terminal: accommodate Git for Windows' default terminal
      terminal: add a new function to read a single keystroke
      built-in add -p: respect the `interactive.singlekey` config setting
      built-in add -p: handle Escape sequences in interactive.singlekey m=
ode
      built-in add -p: handle Escape sequences more efficiently
      ci: include the built-in `git add -i` in the `linux-gcc` job
      msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
      built-in add -i: do not try to `patch`/`diff` an empty list of file=
s
      built-in add -i: accept open-ended ranges again
      parse_insn_line(): improve error message when parsing failed
      rebase -i: re-fix short SHA-1 collision
      rebase -i: also avoid SHA-1 collisions with missingCommitsCheck
      ci: ignore rubygems warning in the "Documentation" job
      convert: fix typo
      tests: fix --write-junit-xml with subshells
      t9001, t9116: avoid pipes
      t5580: test cloning without file://, test fetching via UNC paths
      mingw: add a helper function to attach GDB to the current process
      t/lib-httpd: avoid using macOS' sed
      ci: prevent `perforce` from being quarantined
      Azure Pipeline: switch to the latest agent pools
      t5537: adjust test_oid label

Johannes Sixt (1):
      t3504: do check for conflict marker after failed cherry-pick

Jonathan Nieder (9):
      sha1-file: document how to use pretend_object_file
      fetch test: avoid use of "VAR=3D cmd" with a shell function
      t/check-non-portable-shell: detect "FOO=3D shell_func", too
      fetch test: mark test of "skipping" haves as v0-only
      fetch test: use more robust test for filtered objects
      config doc: protocol.version is not experimental
      test: request GIT_TEST_PROTOCOL_VERSION=3D0 when appropriate
      protocol test: let protocol.version override GIT_TEST_PROTOCOL_VERS=
ION
      fetch: default to protocol version 2

Jonathan Tan (4):
      sha1-file: remove OBJECT_INFO_SKIP_CACHED
      t5616: make robust to delta base change
      connected: verify promisor-ness of partial clone
      fetch: forgo full connectivity check if --filter

Jordi Mas (3):
      l10n: Update Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Junio C Hamano (21):
      The first batch post 2.25 cycle
      merge-recursive: use subtraction to flip stage
      .mailmap: fix GGG authoship screwup
      The second batch
      C: use skip_prefix() to avoid hardcoded string length
      The third batch for 2.26
      The fourth batch for 2.26
      The fifth batch for 2.26
      Git 2.25.1
      The sixth batch for 2.26
      rev-list --count: comment on the use of count_right++
      The seventh batch for 2.26
      Documentation: clarify that `-h` alone stands for `help`
      Revert "gpg-interface: prefer check_signature() for GPG verificatio=
n"
      The eighth batch for 2.26
      Git 2.26-rc0
      Git 2.26-rc1
      Hopefully the final batch before -rc2
      Git 2.26-rc2
      Git 2.25.2
      Git 2.26

Kevin Willford (4):
      fsmonitor: change last update timestamp on the index_state to opaqu=
e token
      fsmonitor: handle version 2 of the hooks that will use opaque token
      fsmonitor: add fsmonitor hook scripts for version 2
      fsmonitor: update documentation for hook version and watchman hooks

Kir Kolyshkin (1):
      completion: add diff --color-moved[-ws]

Kyle Meyer (2):
      submodule add: show 'add --dry-run' stderr when aborting
      submodule foreach: replace $path with $sm_path in example

Lucius Hu (1):
      templates: fix deprecated type option `--bool`

Luke Bonanomi (1):
      git-gui--askpass: coerce answers to UTF-8 on Windows

Luke Diamand (7):
      git-p4: make closeStreams() idempotent
      git-p4: add P4CommandException to report errors talking to Perforce
      git-p4: disable some pylint warnings, to get pylint output to somet=
hing manageable
      git-p4: create helper function importRevisions()
      git-p4: cleanup better on error exit
      git-p4: check for access to remote host earlier
      git-p4: avoid leak of file handle when cloning

Martin =C3=85gren (7):
      git-filter-branch.txt: wrap "maths" notation in backticks
      name-rev: rewrite create_or_update_name()
      diff-options.txt: avoid "regex" overload in example
      t4117: check for files using `test_path_is_file`
      t9810: drop debug `cat` call
      t: drop debug `cat` calls
      t1091: don't grep for `strerror()` string

Masaya Suzuki (1):
      doc: describe Git bundle format

Matheus Tavares (21):
      grep: fix race conditions on userdiff calls
      grep: fix race conditions at grep_submodule()
      grep: fix racy calls in grep_objects()
      replace-object: make replace operations thread-safe
      object-store: allow threaded access to object reading
      grep: replace grep_read_mutex by internal obj read lock
      submodule-config: add skip_if_read option to repo_read_gitmodules()
      grep: allow submodule functions to run in parallel
      grep: protect packed_git [re-]initialization
      grep: re-enable threads in non-worktree case
      grep: move driver pre-load out of critical section
      grep: use no. of cores as the default no. of threads
      doc: sparse-checkout: mention --cone option
      completion: add support for sparse-checkout
      diff: make diff_populate_filespec() honor its repo argument
      cache-tree: use given repo's hash_algo at verify_one()
      pack-check: use given repo's hash_algo at verify_packfile()
      streaming: allow open_istream() to handle any repo
      sha1-file: pass git_hash_algo to write_object_file_prepare()
      sha1-file: pass git_hash_algo to hash_object_file()
      sha1-file: allow check_object_signature() to handle any repo

Matthew Rogers (10):
      config: fix typo in variable name
      t1300: fix over-indented HERE-DOCs
      t1300: create custom config file without special characters
      config: make scope_name non-static and rename it
      config: split repo scope to local and worktree
      config: clarify meaning of command line scoping
      config: preserve scope in do_git_config_sequence
      config: teach git_config_source to remember its scope
      submodule-config: add subomdule config scope
      config: add '--show-scope' to print the scope of a config value

Matthias R=C3=BCster (1):
      l10n: de.po: Update German translation for Git 2.26.0

Miriam Rubio (3):
      bisect--helper: convert `vocab_*` char pointers to char arrays
      bisect: use the standard 'if (!var)' way to check for 0
      bisect: add enum to represent bisect returning codes

Paolo Bonzini (5):
      parse-options: add testcases for OPT_CMDMODE()
      parse-options: convert "command mode" to a flag
      am: convert "resume" variable to a struct
      am: support --show-current-patch=3Draw as a synonym for--show-curre=
nt-patch
      am: support --show-current-patch=3Ddiff to retrieve .git/rebase-app=
ly/patch

Peter Kaestle (3):
      t7400: add a testcase for submodule status on empty dirs
      submodule: fix status of initialized but not cloned submodules
      t7400: testcase for submodule status on unregistered inner git repo=
s

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4835t0f0u)
      l10n: sv.po: Update Swedish translation (4839t0f0u)

Philippe Blain (5):
      t7410: rename to t2405-worktree-submodule.sh
      t2405: use git -C and test_commit -C instead of subshells
      t2405: clarify test descriptions and simplify test
      submodule.c: use get_git_dir() instead of get_git_common_dir()
      grep: ignore --recurse-submodules if --no-index is given

Pranit Bauva (7):
      bisect--helper: return error codes from `cmd_bisect__helper()`
      bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and=
 its dependents
      bisect: libify `bisect_checkout`
      bisect: libify `check_merge_bases` and its dependents
      bisect: libify `check_good_are_ancestors_of_bad` and its dependents
      bisect: libify `handle_bad_merge_base` and its dependents
      bisect: libify `bisect_next_all`

Pratyush Yadav (4):
      git-gui: add missing close bracket
      git-gui: fix error popup when doing blame -> "Show History Context"
      git-gui: reduce Tcl version requirement from 8.6 to 8.5
      git-gui: create a new namespace for chord script evaluation

Ralf Thielow (3):
      submodule.c: mark more strings for translation
      rebase-interactive.c: silence format-zero-length warnings
      l10n: de.po: add missing space

Rasmus Jonsson (1):
      t1050: replace test -f with test_path_is_file

Ren=C3=A9 Scharfe (21):
      name-rev: remove unused typedef
      name-rev: respect const qualifier
      name-rev: don't leak path copy in name_ref()
      name-rev: don't _peek() in create_or_update_name()
      name-rev: put struct rev_name into commit slab
      name-rev: factor out get_parent_name()
      name-rev: pre-size buffer in get_parent_name()
      name-rev: generate name strings only if they are better
      name-rev: release unused name strings
      name-rev: sort tip names before applying
      strbuf: add and use strbuf_insertstr()
      mailinfo: don't insert header prefix for handle_content_type()
      parse-options: use COPY_ARRAY in parse_options_concat()
      parse-options: factor out parse_options_count()
      parse-options: const parse_options_concat() parameters
      parse-options: simplify parse_options_dup()
      quote: use isalnum() to check for alphanumeric characters
      use strpbrk(3) to search for characters from a given set
      blame: provide type of fingerprints pointer
      commit-graph: use progress title directly
      remote-curl: show progress for fetches over dumb HTTP

SZEDER G=C3=A1bor (6):
      t9902-completion: add tests for the __git_find_on_cmdline() helper
      completion: clean up the __git_find_on_cmdline() helper function
      completion: return the index of found word from __git_find_on_cmdli=
ne()
      completion: simplify completing 'git worktree' subcommands and opti=
ons
      completion: list existing working trees for 'git worktree' subcomma=
nds
      completion: list paths and refs for 'git worktree add'

Shourya Shukla (2):
      t6025: modernize style
      t6025: use helpers to replace test -f <path>

Tanushree Tumane (2):
      bisect--helper: change `retval` to `res`
      bisect--helper: introduce new `decide_next()` function

Taylor Blau (5):
      t5318: don't pass non-object directory to '--object-dir'
      commit-graph.h: store an odb in 'struct write_commit_graph_context'
      commit-graph.h: store object directory in 'struct commit_graph'
      commit-graph.c: remove path normalization, comparison
      commit-graph.h: use odb in 'load_commit_graph_one_fd_st'

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi(4839t): Updated Vietnamese translation for v2.26.0

Yi-Jyun Pan (2):
      l10n: zh_TW.po: v2.26.0 round 1 (11 untranslated)
      l10n: zh_TW.po: v2.26.0 round 2 (0 untranslated)

brian m. carlson (54):
      run-command: avoid undefined behavior in exists_in_PATH
      t4054: make hash-size independent
      t4066: compute index line in diffs
      t4134: compute appropriate length constant
      t4200: make hash size independent
      t4202: abstract away SHA-1-specific constants
      t4204: make hash size independent
      t4300: abstract away SHA-1-specific constants
      t5318: update for SHA-256
      t5319: change invalid offset for SHA-256 compatibility
      t5319: make test work with SHA-256
      t5324: make hash size independent
      t5504: make hash algorithm independent
      t5510: make hash size independent
      t5512: abstract away SHA-1-specific constants
      t5530: compute results based on object length
      t5537: make hash size independent
      t5540: make hash size independent
      t5562: use $ZERO_OID
      t5601: switch into repository to hash object
      t5604: make hash independent
      docs: use "currently" for the present time
      doc: move author and committer information to git-commit(1)
      docs: expand on possible and recommended user config options
      doc: provide guidance on user.name format
      doc: dissuade users from trying to ignore tracked files
      docs: mention when increasing http.postBuffer is valuable
      t/lib-pack: support SHA-256
      t3206: make hash size independent
      t3308: make test work with SHA-256
      t3309: make test work with SHA-256
      t3310: make test work with SHA-256
      t3311: make test work with SHA-256
      t4013: make test hash independent
      t4211: move SHA-1-specific test cases into a directory
      t4211: add test cases for SHA-256
      t4060: make test work with SHA-256
      t5302: make hash size independent
      t5309: make test hash independent
      t5313: make test hash independent
      t5321: make test hash independent
      t5515: make test hash independent
      t5318: update for SHA-256
      t5607: make hash size independent
      t5703: make test work with SHA-256
      t6000: abstract away SHA-1-specific constants
      t6006: make hash size independent
      t6024: update for SHA-256
      mailmap: add an additional email address for brian m. carlson
      t1300: add test for urlmatch with multiple wildcards
      t0300: add tests for some additional cases
      credential: use the last matching username in the config
      credential: allow wildcard patterns when matching config
      t3419: prevent failure when run with EXPENSIVE

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      l10n: vi: fix translation + grammar

