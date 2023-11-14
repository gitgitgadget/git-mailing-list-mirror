Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777C2C180
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uuzIdkGq"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC88124;
	Tue, 14 Nov 2023 09:25:57 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07BD81C19DE;
	Tue, 14 Nov 2023 12:25:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=yKaiqVzqKvdQG9S9MAUeXJP6O
	+WbgXmcHiO1D+Dz56A=; b=uuzIdkGqn4AHL7pvqsOtJ/TVOVld+pALJvVe4tPw0
	o/QfB25PqXSCU1+CD1F1dkWxBeNdgd9Sjj5YGuq7+rCAs11c2tJe//+maXUigsbU
	2gMlMd3jI5Y0XrjWfeGDOmlYTe/9jheEwn+XREgmP3HsyNxPTbTh2DuBnm79ViYL
	eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFEB41C19DD;
	Tue, 14 Nov 2023 12:25:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C43F1C19DA;
	Tue, 14 Nov 2023 12:25:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.43.0-rc2
Date: Wed, 15 Nov 2023 02:25:55 +0900
Message-ID: <xmqqo7fwxn4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DE9E5BEC-8312-11EE-90EB-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

A release candidate Git v2.43.0-rc2 is now available for testing at
the usual places.  It is comprised of 451 non-merge commits since
v2.42.0, contributed by 71 people, 17 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.43.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.42.0 are as follows.
Welcome to the Git development community!

  Aditya Neelamraju, Alyssa Ross, Caleb Hill, Dorcas AnonoLitunya,
  Dragan Simic, Isoken June Ibizugbe, Jan Alexander Steffens
  (heftig), Javier Mora, ks1322 ks1322, Mark Ruvald Pedersen,
  Matthew McClain, Naomi Ibe, Romain Chossart, Tang Yuyi, Vipul
  Kumar, =E7=8E=8B=E5=B8=B8=E6=96=B0, and =E8=B0=A2=E8=87=B4=E9=82=A6 (XI=
E Zhibang).

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Andrei Rybak, Andy Koppe, Bagas
  Sanjaya, Beat Bolli, brian m. carlson, Calvin Wan, Christian
  Couder, Christian Hesse, Derrick Stolee, Drew DeVault, Elijah
  Newren, Emily Shaffer, Eric W. Biederman, Eric Wong, Evan
  Gates, Han Young, Hariom Verma, Jacob Abel, Jacob Stopak,
  Jason Hatton, Jeff King, Johannes Schindelin, John Cai,
  Josh Soref, Josip Sokcevic, Junio C Hamano, Karthik Nayak,
  Kousik Sanagavarapu, Kristoffer Haugsbakk, Linus Arver, Mark
  Levedahl, Martin =C3=85gren, Martin Storsj=C3=B6, M Hickford, Michael
  Strawbridge, Michal Suchanek, Oswald Buddenhagen, Patrick
  Steinhardt, Philippe Blain, Phillip Wood, Randall S. Becker,
  Ren=C3=A9 Scharfe, Robert Coup, Rub=C3=A9n Justo, Sergey Organov, Shuqi
  Liang, Stefan Haller, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Taylor Blau, Te=
ng Long,
  Todd Zullinger, Victoria Dye, and Wesley Schwengle.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.43 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Backward Compatibility Notes

 * The "--rfc" option of "git format-patch" used to be a valid way to
   override an earlier "--subject-prefix=3D<something>" on the command
   line and replace it with "[RFC PATCH]", but from this release, it
   merely prefixes the string "RFC " in front of the given subject
   prefix.  If you are negatively affected by this change, please use
   "--subject-prefix=3DPATCH --rfc" as a replacement.

 * "git rev-list --stdin" learned to take non-revisions (like "--not")
   recently from the standard input, but the way such a "--not" was
   handled was quite confusing, which has been rethought.  The updated
   rule is that "--not" given from the command line only affects revs
   given from the command line that comes but not revs read from the
   standard input, and "--not" read from the standard input affects
   revs given from the standard input and not revs given from the
   command line.

UI, Workflows & Features

 * A message written in olden time prevented a branch from getting
   checked out saying it is already checked out elsewhere, but these
   days, we treat a branch that is being bisected or rebased just like
   a branch that is checked out and protect it.  Rephrase the message
   to say that the branch is in use.

 * Hourly and other schedules of "git maintenance" jobs are randomly
   distributed now.

 * "git cmd -h" learned to signal which options can be negated by
   listing such options like "--[no-]opt".

 * The way authentication related data other than passwords (e.g.,
   oauth token and password expiration data) are stored in libsecret
   keyrings has been rethought.

 * Update the libsecret and wincred credential helpers to correctly
   match which credential to erase; they erased the wrong entry in
   some cases.

 * Git GUI updates.

 * "git format-patch" learns a way to feed cover letter description,
   that (1) can be used on detached HEAD where there is no branch
   description available, and (2) also can override the branch
   description if there is one.

 * Use of --max-pack-size to allow multiple packfiles to be created is
   now supported even when we are sending unreachable objects to cruft
   packs.

 * "git format-patch --rfc --subject-prefix=3D<foo>" used to ignore the
   "--subject-prefix" option and used "[RFC PATCH]"; now we will add
   "RFC" prefix to whatever subject prefix is specified.

 * "git log --format" has been taught the %(decorate) placeholder.

 * The default log message created by "git revert", when reverting a
   commit that records a revert, has been tweaked, to encourage people
   to describe complex "revert of revert of revert" situations better in
   their own words.

 * The command-line completion support (in contrib/) learned to
   complete "git commit --trailer=3D" for possible trailer keys.

 * "git update-index" learns "--show-index-version" to inspect
   the index format version used by the on-disk index file.

 * "git diff" learned diff.statNameWidth configuration variable, to
   give the default width for the name part in the "--stat" output.

 * "git range-diff --notes=3Dfoo" compared "log --notes=3Dfoo --notes" of
   the two ranges, instead of using just the specified notes tree.

 * The command line completion script (in contrib/) can be told to
   complete aliases by including ": git <cmd> ;" in the alias to tell
   it that the alias should be completed in a similar way to how "git <cm=
d>" is
   completed.  The parsing code for the alias has been loosened to
   allow ';' without an extra space before it.

 * "git for-each-ref" and friends learned to apply mailmap to
   authorname and other fields.

 * "git repack" machinery learns to pay attention to the "--filter=3D"
   option.

 * "git repack" learned "--max-cruft-size" to prevent cruft packs from
   growing without bounds.

 * "git merge-tree" learned to take strategy backend specific options
   via the "-X" option, like "git merge" does.

 * "git log" and friends learned "--dd" that is a short-hand for
   "--diff-merges=3Dfirst-parent -p".

 * The attribute subsystem learned to honor `attr.tree` configuration
   that specifies which tree to read the .gitattributes files from.

 * "git merge-file" learns a mode to read three contents to be merged
   from blob objects.


Performance, Internal Implementation, Development Support etc.

 * "git check-attr" has been taught to work better with sparse-index.

 * It may be tempting to leave the help text NULL for a command line
   option that is either hidden or too obvious, but "git subcmd -h"
   and "git subcmd --help-all" would have segfaulted if done so.  Now
   the help text is optional.

 * Tests that are known to pass with LSan are now marked as such.

 * Flaky "git p4" tests, as well as "git svn" tests, are now skipped
   in the (rather expensive) sanitizer CI job.

 * Tests with LSan from time to time seem to emit harmless messages
   that make our tests unnecessarily flaky; we work around it by
   filtering the uninteresting output.

 * Unused parameters to functions are marked as such, and/or removed,
   in order to bring us closer to -Wunused-parameter clean.

 * The code to keep track of existing packs in the repository while
   repacking has been refactored.

 * The "streaming" interface used for bulk-checkin codepath has been
   narrowed to take only blob objects for now, with no real loss of
   functionality.

 * GitHub CI workflow has learned to trigger Coverity check.

 * Test coverage for trailers has been improved.

 * The code to iterate over loose references has been optimized to
   reduce the number of lstat() system calls.

 * The codepaths that read "chunk" formatted files have been corrected
   to pay attention to the chunk size and notice broken files.

 * Replace macos-12 used at GitHub CI with macos-13.
   (merge 682a868f67 js/ci-use-macos-13 later to maint).


Fixes since v2.42
-----------------

 * Overly long label names used in the sequencer machinery are now
   chopped to fit under filesystem limitation.

 * Scalar updates.

 * Tweak GitHub Actions CI so that pushing the same commit to multiple
   branch tips at the same time will not waste building and testing
   the same thing twice.

 * The commit-graph verification code that detects a mixture of zero and
   non-zero generation numbers has been updated.

 * "git diff -w --exit-code" with various options did not work
   correctly, which is being addressed.

 * transfer.unpackLimit ought to be used as a fallback, but overrode
   fetch.unpackLimit and receive.unpackLimit instead.

 * The use of API between two calls to require_clean_work_tree() from
   the sequencer code has been cleaned up for consistency.

 * "git diff --no-such-option" and other corner cases around the exit
   status of the "diff" command have been corrected.

 * "git for-each-ref --sort=3D'contents:size'" sorts the refs according
   to size numerically, giving a ref that points at a blob twelve-byte
   (12) long before showing a blob hundred-byte (100) long.

 * We now limit the depth of the tree objects and maximum length of
   pathnames recorded in tree objects.
   (merge 4d5693ba05 jk/tree-name-and-depth-limit later to maint).

 * Various fixes to the behavior of "rebase -i" when the command got
   interrupted by conflicting changes.

 * References from a description of the `--patch` option in various
   manual pages have been simplified and improved.

 * "git grep -e A --no-or -e B" is accepted, even though the negation
   of "or" did not mean anything, which has been tightened.

 * The completion script (in contrib/) has been taught to treat the
   "-t" option to "git checkout" and "git switch" just like the
   "--track" option, to complete remote-tracking branches.

 * "git diff --no-index -R <(one) <(two)" did not work correctly,
   which has been corrected.

 * Update "git maintenance" timers' implementation based on systemd
   timers to work with WSL.

 * "git diff --cached" codepath did not fill the necessary stat
   information for a file when fsmonitor knows it is clean and ended
   up behaving as if it is not clean, which has been corrected.

 * Clarify how "alias.foo =3D : git cmd ; aliased-command-string" should =
be
   spelled with necessary whitespace around punctuation marks to
   work.

 * HTTP Header redaction code has been adjusted for a newer version of
   cURL library that shows its traces differently from earlier
   versions.

 * An error message given by "git send-email" when given a malformed
   address did not give correct information, which has been corrected.

 * UBSan options were not propagated through the test framework to git
   run via the httpd, unlike ASan options, which has been corrected.

 * "checkout --merge -- path" and "update-index --unresolve path" did
   not resurrect conflicted state that was resolved to remove path,
   but now they do.
   (merge 5bdedac3c7 jc/unresolve-removal later to maint).

 * The display width table for unicode characters has been updated for
   Unicode 15.1
   (merge 872976c37e bb/unicode-width-table-15 later to maint).

 * Update mailmap entry for Derrick.
   (merge 6e5457d8c7 ds/mailmap-entry-update later to maint).

 * In .gitmodules files, submodules are keyed by their names, and the
   path to the submodule whose name is $name is specified by the
   submodule.$name.path variable.  There were a few codepaths that
   mixed the name and path up when consulting the submodule database,
   which have been corrected.  It took long for these bugs to be found
   as the name of a submodule initially is the same as its path, and
   the problem does not surface until it is moved to a different path,
   which apparently happens very rarely.

 * "git diff --merge-base X other args..." insisted that X must be a
   commit and errored out when given an annotated tag that peels to a
   commit, but we only need it to be a committish.  This has been
   corrected.
   (merge 4adceb5a29 ar/diff-index-merge-base-fix later to maint).

 * Fix "git merge-tree" to stop segfaulting when the --attr-source
   option is used.
   (merge e95bafc52f jc/merge-ort-attr-index-fix later to maint).

 * Unlike "git log --pretty=3D%D", "git log --pretty=3D"%(decorate)" did
   not auto-initialize the decoration subsystem, which has been
   corrected.

 * Feeding "git stash store" with a random commit that was not created
   by "git stash create" now errors out.
   (merge d9b6634589 jc/fail-stash-to-store-non-stash later to maint).

 * The index file has room only for the lower 32-bit of the file size in
   the cached stat information, which means cached stat information
   will have 0 in its sd_size member for a file whose size is a multiple
   of 4GiB.  This is mistaken for a racily clean path.  Avoid it by
   storing a bogus sd_size value instead for such files.
   (merge 5143ac07b1 bc/racy-4gb-files later to maint).

 * "git p4" tried to store symlinks to LFS when told, but has been
   fixed not to do so, because it does not make sense.
   (merge 10c89a02b0 mm/p4-symlink-with-lfs later to maint).

 * The codepath to handle recipient addresses `git send-email
   --compose` learns from the user was completely broken, which has
   been corrected.
   (merge 3ec6167567 jk/send-email-fix-addresses-from-composed-messages l=
ater to maint).

 * "cd sub && git grep -f patterns" tried to read "patterns" file at
   the top level of the working tree; it has been corrected to read
   "sub/patterns" instead.


 * "git reflog expire --single-worktree" has been broken for the past
   20 months or so, which has been corrected.

 * "git send-email" did not have certain pieces of data computed yet
   when it tried to validate the outgoing messages and its recipient
   addresses, which has been sorted out.

 * "git bugreport" learned to complain when it received a command line
   argument that it will not use.

 * The codepath to traverse the commit-graph learned to notice that a
   commit is missing (e.g., corrupt repository lost an object), even
   though it knows something about the commit (like its parents) from
   what is in commit-graph.
   (merge 7a5d604443 ps/do-not-trust-commit-graph-blindly-for-existence l=
ater to maint).

 * "git rev-list --missing" did not work for missing commit objects,
   which has been corrected.

 * "git rev-list --unpacked --objects" failed to exclude packed
   non-commit objects, which has been corrected.
   (merge 7b3c8e9f38 tb/rev-list-unpacked-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge c2c349a15c xz/commit-title-soft-limit-doc later to maint).
   (merge 1bd809938a tb/format-pack-doc-update later to maint).
   (merge 8f81532599 an/clang-format-typofix later to maint).
   (merge 3ca86adc2d la/strvec-header-fix later to maint).
   (merge 6789275d37 jc/test-i18ngrep later to maint).
   (merge 9972cd6004 ps/leakfixes later to maint).

----------------------------------------------------------------

Changes since v2.42.0 are as follows:

Aditya Neelamraju (1):
      clang-format: fix typo in comment

Alyssa Ross (1):
      diff: fix --merge-base with annotated tags

Andrei Rybak (1):
      SubmittingPatches: call gitk's command "Copy commit reference"

Andy Koppe (8):
      pretty-formats: enclose options in angle brackets
      decorate: refactor format_decorations()
      decorate: avoid some unnecessary color overhead
      decorate: color each token separately
      pretty: add %(decorate[:<options>]) format
      pretty: add pointer and tag options to %(decorate)
      decorate: use commit color for HEAD arrow
      pretty: fix ref filtering for %(decorate) formats

Beat Bolli (1):
      unicode: update the width tables to Unicode 15.1

Caleb Hill (1):
      git-clean doc: fix "without do cleaning" typo

Calvin Wan (4):
      hex-ll: separate out non-hash-algo functions
      wrapper: reduce scope of remove_or_warn()
      config: correct bad boolean env value error message
      parse: separate out parsing functions from config.h

Christian Couder (9):
      pack-objects: allow `--filter` without `--stdout`
      t/helper: add 'find-pack' test-tool
      repack: refactor finishing pack-objects command
      repack: refactor finding pack prefix
      pack-bitmap-write: rebuild using new bitmap when remapping
      repack: add `--filter=3D<filter-spec>` option
      gc: add `gc.repackFilter` config option
      repack: implement `--filter-to` for storing filtered out objects
      gc: add `gc.repackFilterTo` config option

Christian Hesse (2):
      t/lib-gpg: forcibly run a trustdb update
      t/t6300: drop magic filtering

Derrick Stolee (13):
      upload-pack: fix race condition in error messages
      maintenance: add get_random_minute()
      maintenance: use random minute in launchctl scheduler
      maintenance: use random minute in Windows scheduler
      maintenance: use random minute in cron scheduler
      maintenance: swap method locations
      maintenance: use random minute in systemd scheduler
      maintenance: fix systemd schedule overlaps
      maintenance: update schedule before config
      scalar: add --[no-]src option
      setup: add discover_git_directory_reason()
      scalar reconfigure: help users remove buggy repos
      mailmap: change primary address for Derrick Stolee

Dorcas AnonoLitunya (1):
      t7601: use "test_path_is_file" etc. instead of "test -f"

Dragan Simic (2):
      diff --stat: add config option to limit filename width
      diff --stat: set the width defaults in a helper function

Drew DeVault (1):
      format-patch: --rfc honors what --subject-prefix sets

Elijah Newren (26):
      documentation: wording improvements
      documentation: fix small error
      documentation: fix typos
      documentation: fix apostrophe usage
      documentation: add missing words
      documentation: remove extraneous words
      documentation: fix subject/verb agreement
      documentation: employ consistent verb tense for a list
      documentation: fix verb tense
      documentation: fix adjective vs. noun
      documentation: fix verb vs. noun
      documentation: fix singular vs. plural
      documentation: whitespace is already generally plural
      documentation: fix choice of article
      documentation: add missing article
      documentation: remove unnecessary hyphens
      documentation: add missing hyphens
      documentation: use clearer prepositions
      documentation: fix punctuation
      documentation: fix capitalization
      documentation: fix whitespace issues
      documentation: add some commas where they are helpful
      documentation: add missing fullstops
      documentation: add missing quotes
      documentation: add missing parenthesis
      RelNotes: minor wording fixes in 2.43.0 release notes

Emily Shaffer (2):
      t0091-bugreport: stop using i18ngrep
      bugreport: reject positional arguments

Eric W. Biederman (1):
      bulk-checkin: only support blobs in index_bulk_checkin

Eric Wong (1):
      treewide: fix various bugs w/ OpenSSL 3+ EVP API

Evan Gates (1):
      git-config: fix misworded --type=3Dpath explanation

Han Young (1):
      show doc: redirect user to git log manual instead of git diff-tree

Isoken June Ibizugbe (1):
      builtin/branch.c: adjust error messages to coding guidelines

Jacob Abel (1):
      builtin/worktree.c: fix typo in "forgot fetch" msg

Jacob Stopak (1):
      Include gettext.h in MyFirstContribution tutorial

Jan Alexander Steffens (heftig) (6):
      submodule--helper: use submodule_from_path in set-{url,branch}
      submodule--helper: return error from set-url when modifying failed
      t7419: actually test the branch switching
      t7419, t7420: use test_cmp_config instead of grepping .gitmodules
      t7419: test that we correctly handle renamed submodules
      t7420: test that we correctly handle renamed submodules

Jason Hatton (1):
      Prevent git from rehashing 4GiB files

Javier Mora (2):
      git-status.txt: fix minor asciidoc format issue
      doc/git-bisect: clarify `git bisect run` syntax

Jeff King (114):
      hashmap: use expected signatures for comparison functions
      diff-files: avoid negative exit value
      diff: show usage for unknown builtin_diff_files() options
      diff: die when failing to read index in git-diff builtin
      diff: drop useless return from run_diff_{files,index} functions
      diff: drop useless return values in git-diff helpers
      diff: drop useless "status" parameter from diff_result_code()
      commit-graph: verify swapped zero/non-zero generation cases
      test-lib: ignore uninteresting LSan output
      sequencer: use repository parameter in short_commit_name()
      sequencer: mark repository argument as unused
      ref-filter: mark unused parameters in parser callbacks
      pack-bitmap: mark unused parameters in show_object callback
      worktree: mark unused parameters in each_ref_fn callback
      commit-graph: mark unused data parameters in generation callbacks
      ls-tree: mark unused parameter in callback
      stash: mark unused parameter in diff callback
      trace2: mark unused us_elapsed_absolute parameters
      trace2: mark unused config callback parameter
      test-trace2: mark unused argv/argc parameters
      grep: mark unused parameter in output function
      add-interactive: mark unused callback parameters
      negotiator/noop: mark unused callback parameters
      worktree: mark unused parameters in noop repair callback
      imap-send: mark unused parameters with NO_OPENSSL
      grep: mark unused parmaeters in pcre fallbacks
      credential: mark unused parameter in urlmatch callback
      fetch: mark unused parameter in ref_transaction callback
      bundle-uri: mark unused parameters in callbacks
      gc: mark unused descriptors in scheduler callbacks
      update-ref: mark unused parameter in parser callbacks
      ci: allow branch selection through "vars"
      ci: deprecate ci/config/allow-ref script
      merge: make xopts a strvec
      merge: simplify parsing of "-n" option
      format-patch: use OPT_STRING_LIST for to/cc options
      tree-walk: reduce stack size for recursive functions
      tree-walk: drop MAX_TRAVERSE_TREES macro
      tree-walk: rename "error" variable
      fsck: detect very large tree pathnames
      add core.maxTreeDepth config
      traverse_trees(): respect max_allowed_tree_depth
      read_tree(): respect max_allowed_tree_depth
      list-objects: respect max_allowed_tree_depth
      tree-diff: respect max_allowed_tree_depth
      lower core.maxTreeDepth default to 2048
      checkout-index: delay automatic setting of to_tempfile
      parse-options: prefer opt->value to globals in callbacks
      parse-options: mark unused "opt" parameter in callbacks
      merge: do not pass unused opt->value parameter
      parse-options: add more BUG_ON() annotations
      interpret-trailers: mark unused "unset" parameters in option callba=
cks
      parse-options: mark unused parameters in noop callback
      merge-ort: drop custom err() function
      merge-ort: stop passing "opt" to read_oid_strbuf()
      merge-ort: drop unused parameters from detect_and_process_renames()
      merge-ort: drop unused "opt" parameter from merge_check_renames_reu=
sable()
      http: factor out matching of curl http/2 trace lines
      http: update curl http/2 info matching for curl 8.3.0
      merge-ort: lowercase a few error messages
      fsmonitor: prefer repo_git_path() to git_pathdup()
      fsmonitor/win32: drop unused parameters
      fsmonitor: mark some maybe-unused parameters
      fsmonitor/win32: mark unused parameter in fsm_os__incompatible()
      fsmonitor: mark unused parameters in stub functions
      fsmonitor/darwin: mark unused parameters in system callback
      fsmonitor: mark unused hashmap callback parameters
      run-command: mark unused parameters in start_bg_wait callbacks
      test-lib: set UBSAN_OPTIONS to match ASan
      commit-graph: factor out chain opening function
      commit-graph: check mixed generation validation when loading chain =
file
      t5324: harmonize sha1/sha256 graph chain corruption
      commit-graph: detect read errors when verifying graph chain
      commit-graph: tighten chain size check
      commit-graph: report incomplete chains during verification
      t6700: mark test as leak-free
      commit-reach: free temporary list in get_octopus_merge_bases()
      merge: free result of repo_get_merge_bases()
      commit-graph: move slab-clearing to close_commit_graph()
      commit-graph: free all elements of graph chain
      commit-graph: delay base_graph assignment in add_graph_to_chain()
      commit-graph: free graph struct that was not added to chain
      commit-graph: free write-context entries before overwriting
      commit-graph: free write-context base_graph_name during cleanup
      commit-graph: clear oidset after finishing write
      decorate: add clear_decoration() function
      revision: clear decoration structs during release_revisions()
      daemon: free listen_addr before returning
      repack: free existing_cruft array after use
      chunk-format: note that pair_chunk() is unsafe
      t: add library for munging chunk-format files
      midx: stop ignoring malformed oid fanout chunk
      commit-graph: check size of oid fanout chunk
      midx: check size of oid lookup chunk
      commit-graph: check consistency of fanout table
      midx: check size of pack names chunk
      midx: enforce chunk alignment on reading
      midx: check size of object offset chunk
      midx: bounds-check large offset chunk
      midx: check size of revindex chunk
      commit-graph: check size of commit data chunk
      commit-graph: detect out-of-bounds extra-edges pointers
      commit-graph: bounds-check base graphs chunk
      commit-graph: check size of generations chunk
      commit-graph: bounds-check generation overflow chunk
      commit-graph: check bounds when accessing BDAT chunk
      commit-graph: check bounds when accessing BIDX chunk
      commit-graph: detect out-of-order BIDX offsets
      chunk-format: drop pair_chunk_unsafe()
      t5319: make corrupted large-offset test more robust
      doc/send-email: mention handling of "reply-to" with --compose
      Revert "send-email: extract email-parsing code into a subroutine"
      send-email: handle to/cc/bcc from --compose message
      t: avoid perl's pack/unpack "Q" specifier

Johannes Schindelin (19):
      windows: ignore empty `PATH` elements
      is_Cygwin: avoid `exec`ing anything
      Move is_<platform> functions to the beginning
      Move the `_which` function (almost) to the top
      Work around Tcl's default `PATH` lookup
      rebase: allow overriding the maximal length of the generated labels
      ci: avoid building from the same commit in parallel
      ci(linux-asan-ubsan): let's save some time
      var: avoid a segmentation fault when `HOME` is unset
      completion(switch/checkout): treat --track and -t the same
      maintenance(systemd): support the Windows Subsystem for Linux
      ci: add a GitHub workflow to submit Coverity scans
      coverity: cache the Coverity Build Tool
      coverity: allow overriding the Coverity project
      coverity: support building on Windows
      coverity: allow running on macOS
      coverity: detect and report when the token or project is incorrect
      max_tree_depth: lower it for MSVC to avoid stack overflows
      ci: upgrade to using macos-13

John Cai (3):
      merge-ort: initialize repo in index state
      attr: read attributes from HEAD when bare repo
      attr: add attr.tree for setting the treeish to read attributes from

Josh Soref (1):
      Documentation/git-status: add missing line breaks

Josip Sokcevic (1):
      diff-lib: fix check_removed when fsmonitor is on

Junio C Hamano (56):
      update-index: do not read HEAD and MERGE_HEAD unconditionally
      resolve-undo: allow resurrecting conflicted state that resolved to =
deletion
      update-index: use unmerge_index_entry() to support removal
      update-index: remove stale fallback code for "--unresolve"
      checkout/restore: refuse unmerging paths unless checking out of the=
 index
      checkout/restore: add basic tests for --merge
      checkout: allow "checkout -m path" to unmerge removed paths
      mv: fix error for moving directory to another
      diff: move the fallback "--exit-code" code down
      diff: mode-only change should be noticed by "--patch -w --exit-code=
"
      diff: teach "--stat -w --exit-code" to notice differences
      t4040: remove test that succeeded for a wrong reason
      pretty-formats: define "literal formatting code"
      diff: spell DIFF_INDEX_CACHED out when calling run_diff_index()
      diff: the -w option breaks --exit-code for --raw and other output m=
odes
      transfer.unpackLimit: fetch/receive.unpackLimit takes precedence
      Start the 2.43 cycle
      The second batch for 2.43
      The extra batch to update credenthal helpers
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      update-index doc: v4 is OK with JGit and libgit2
      update-index: add --show-index-version
      test-tool: retire "index-version"
      The eighth batch
      The ninth batch
      The tenth batch
      The eleventh batch
      completion: loosen and document the requirement around completing a=
lias
      The twelfth batch
      The thirteenth batch
      The fourteenth batch
      The fifteenth batch
      doc: update list archive reference to use lore.kernel.org
      The sixteenth batch
      merge: introduce {copy|clear}_merge_options()
      stash: be careful what we store
      grep: -f <path> is relative to $cwd
      The seventeenth batch
      The eighteenth batch
      commit: do not use cryptic "new_index" in end-user facing messages
      The nineteenth batch
      am: align placeholder for --whitespace option with apply
      The twentieth batch
      The twenty-first batch
      The twenty-second batch
      test framework: further deprecate test_i18ngrep
      Git 2.42.1
      tests: teach callers of test_i18ngrep to use test_grep
      A bit more before -rc1
      Prepare for -rc1
      Git 2.43-rc1
      Git 2.43-rc2

Karthik Nayak (3):
      revision: rename bit to `do_not_die_on_missing_objects`
      rev-list: move `show_commit()` to the bottom
      rev-list: add commit object support in `--missing` option

Kousik Sanagavarapu (4):
      ref-filter: sort numerically when ":size" is used
      t/t6300: cleanup test_atom
      t/t6300: introduce test_bad_atom
      ref-filter: add mailmap support

Kristoffer Haugsbakk (2):
      range-diff: treat notes like `log`
      grep: die gracefully when outside repository

Linus Arver (17):
      trailer tests: make test cases self-contained
      trailer test description: this tests --where=3Dafter, not --where=3D=
before
      trailer: add tests to check defaulting behavior with --no-* flags
      trailer doc: narrow down scope of --where and related flags
      trailer: trailer location is a place, not an action
      trailer --no-divider help: describe usual "---" meaning
      trailer --parse help: expose aliased options
      trailer --only-input: prefer "configuration variables" over "rules"
      trailer --parse docs: add explanation for its usefulness
      trailer --unfold help: prefer "reformat" over "join"
      trailer doc: emphasize the effect of configuration variables
      trailer doc: separator within key suppresses default separator
      trailer doc: <token> is a <key> or <keyAlias>, not both
      trailer: separate public from internal portion of trailer_iterator
      trailer: split process_input_file into separate pieces
      trailer: split process_command_line_args into separate functions
      strvec: drop unnecessary include of hex.h

M Hickford (3):
      credential/libsecret: store new attributes
      credential/libsecret: erase matching creds only
      credential/wincred: erase matching creds only

Mark Levedahl (6):
      git gui Makefile - remove Cygwin modifications
      git-gui - remove obsolete Cygwin specific code
      git-gui - use cygstart to browse on Cygwin
      git-gui - use mkshortcut on Cygwin
      git-gui - re-enable use of hook scripts
      git-gui - use git-hook, honor core.hooksPath

Mark Ruvald Pedersen (1):
      sequencer: truncate labels to accommodate loose refs

Martin =C3=85gren (1):
      git-merge-file doc: drop "-file" from argument placeholders

Matthew McClain (1):
      git-p4 shouldn't attempt to store symlinks in LFS

Michael Strawbridge (1):
      send-email: move validation code below process_address_list

Michal Suchanek (1):
      git-push doc: more visibility for -q option

Naomi Ibe (1):
      builtin/add.c: clean up die() messages

Oswald Buddenhagen (16):
      t/lib-rebase: set_fake_editor(): fix recognition of reset's short c=
ommand
      t/lib-rebase: set_fake_editor(): handle FAKE_LINES more consistentl=
y
      sequencer: simplify allocation of result array in todo_list_rearran=
ge_squash()
      t/lib-rebase: improve documentation of set_fake_editor()
      t9001: fix indentation in test_no_confirm()
      format-patch: add --description-file option
      sequencer: rectify empty hint in call of require_clean_work_tree()
      sequencer: beautify subject of reverts of reverts
      git-revert.txt: add discussion
      sequencer: fix error message on failure to copy SQUASH_MSG
      t3404-rebase-interactive.sh: fix typos in title of a rewording test
      sequencer: remove unreachable exit condition in pick_commits()
      am: fix error message in parse_opt_show_current_patch()
      rebase: simplify code related to imply_merge()
      rebase: handle --strategy via imply_merge() as well
      rebase: move parse_opt_keep_empty() down

Patrick Steinhardt (23):
      upload-pack: fix exit code when denying fetch of unreachable object=
 ID
      revision: make pseudo-opt flags read via stdin behave consistently
      doc/git-worktree: mention "refs/rewritten" as per-worktree refs
      doc/git-repack: fix syntax for `-g` shorthand option
      doc/git-repack: don't mention nonexistent "--unpacked" option
      commit-graph: introduce envvar to disable commit existence checks
      commit: detect commits that exist in commit-graph but not in the OD=
B
      builtin/show-ref: convert pattern to a local variable
      builtin/show-ref: split up different subcommands
      builtin/show-ref: fix leaking string buffer
      builtin/show-ref: fix dead code when passing patterns
      builtin/show-ref: refactor `--exclude-existing` options
      builtin/show-ref: stop using global variable to count matches
      builtin/show-ref: stop using global vars for `show_one()`
      builtin/show-ref: refactor options for patterns subcommand
      builtin/show-ref: ensure mutual exclusiveness of subcommands
      builtin/show-ref: explicitly spell out different modes in synopsis
      builtin/show-ref: add new mode to check for reference existence
      t: use git-show-ref(1) to check for ref existence
      test-bloom: stop setting up Git directory twice
      shallow: fix memory leak when registering shallow roots
      setup: refactor `upgrade_repository_format()` to have common exit
      setup: fix leaking repository format

Philippe Blain (3):
      completion: commit: complete configured trailer tokens
      completion: commit: complete trailers tokens more robustly
      completion: improve doc for complex aliases

Phillip Wood (7):
      rebase -i: move unlink() calls
      rebase -i: remove patch file after conflict resolution
      sequencer: use rebase_path_message()
      sequencer: factor out part of pick_commits()
      rebase: fix rewritten list for failed pick
      rebase --continue: refuse to commit after failed command
      rebase -i: fix adding failed command to the todo list

Ren=C3=A9 Scharfe (18):
      subtree: disallow --no-{help,quiet,debug,branch,message}
      t1502, docs: disallow --no-help
      t1502: move optionspec help output to a file
      t1502: test option negation
      parse-options: show negatability of options in short help
      parse-options: factor out usage_indent() and usage_padding()
      parse-options: no --[no-]no-...
      parse-options: simplify usage_padding()
      parse-options: allow omitting option help text
      name-rev: use OPT_HIDDEN_BOOL for --peel-tag
      grep: use OPT_INTEGER_F for --max-depth
      grep: reject --no-or
      diff --no-index: fix -R with stdin
      parse-options: drop unused parse_opt_ctx_t member
      parse-options: make CMDMODE errors more precise
      am: simplify --show-current-patch handling
      am, rebase: fix arghelp syntax of --empty
      reflog: fix expire --single-worktree

Robert Coup (1):
      upload-pack: add tracing for fetches

Rub=C3=A9n Justo (2):
      branch: error message deleting a branch in use
      branch: error message checking out a branch in use

Sergey Organov (4):
      doc/diff-options: fix link to generating patch section
      diff-merges: improve --diff-merges documentation
      diff-merges: introduce '--dd' option
      completion: complete '--dd'

Shuqi Liang (3):
      t1092: add tests for 'git check-attr'
      attr.c: read attributes in a sparse directory
      check-attr: integrate with sparse-index

Tang Yuyi (1):
      merge-tree: add -X strategy option

Taylor Blau (28):
      repack: move `pack_geometry` struct to the stack
      commit-graph: introduce `commit_graph_generation_from_graph()`
      t/t5318-commit-graph.sh: test generation zero transitions during fs=
ck
      commit-graph: avoid repeated mixed generation number warnings
      leak tests: mark a handful of tests as leak-free
      leak tests: mark t3321-notes-stripspace.sh as leak-free
      leak tests: mark t5583-push-branches.sh as leak-free
      builtin/pack-objects.c: remove unnecessary strbuf_reset()
      builtin/pack-objects.c: support `--max-pack-size` with `--cruft`
      Documentation/gitformat-pack.txt: remove multi-cruft packs alternat=
ive
      Documentation/gitformat-pack.txt: drop mixed version section
      builtin/repack.c: extract structure to store existing packs
      builtin/repack.c: extract marking packs for deletion
      builtin/repack.c: extract redundant pack cleanup for --geometric
      builtin/repack.c: extract redundant pack cleanup for existing packs
      builtin/repack.c: extract `has_existing_non_kept_packs()`
      builtin/repack.c: store existing cruft packs separately
      builtin/repack.c: avoid directly inspecting "util"
      builtin/repack.c: extract common cruft pack loop
      git-send-email.perl: avoid printing undef when validating addresses
      t7700: split cruft-related tests to t7704
      builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
      builtin/repack.c: implement support for `--max-cruft-size`
      builtin/repack.c: avoid making cruft packs preferred
      Documentation/gitformat-pack.txt: fix typo
      Documentation/gitformat-pack.txt: fix incorrect MIDX documentation
      list-objects: drop --unpacked non-commit objects from results
      pack-bitmap: drop --unpacked non-commit objects from results

Todd Zullinger (2):
      RelNotes: minor typo fixes in 2.43.0 draft
      RelNotes: improve wording of credential helper notes

Victoria Dye (4):
      ref-cache.c: fix prefix matching in ref iteration
      dir.[ch]: expose 'get_dtype'
      dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
      files-backend.c: avoid stat in 'loose_fill_ref_dir'

Vipul Kumar (1):
      git-gui: Fix a typo in README

Wesley Schwengle (2):
      git-push.txt: fix grammar
      git-svn: drop FakeTerm hack

brian m. carlson (2):
      t: add a test helper to truncate files
      merge-file: add an option to process object IDs

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (6):
      doc: fix some typos, grammar and wording issues
      doc/diff-options: improve wording of the log.diffMerges mention
      git-jump: admit to passing merge mode args to ls-files
      doc/gitk: s/sticked/stuck/
      t/README: fix multi-prerequisite example
      doc/cat-file: make synopsis and description less confusing

=E7=8E=8B=E5=B8=B8=E6=96=B0 (1):
      merge-ort.c: fix typo 'neeed' to 'needed'

=E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) (2):
      doc: correct the 50 characters soft limit
      doc: correct the 50 characters soft limit (+)

