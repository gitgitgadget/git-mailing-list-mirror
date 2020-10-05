Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_META_ALL,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E441C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9919B206C3
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 22:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="beRsrySZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgJEWlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:41:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57421 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJEWlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 18:41:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15437FEB84;
        Mon,  5 Oct 2020 18:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=C2qT30MudLWiueo4TNEnDLc9I
        DE=; b=beRsrySZoKNJt8icqVJDX1yxFv+DDvfok4t5tmZnuEL9qlq9LefPUspBi
        0D4Lza3U71tF9+jPMukYU4A7RUjVkT9AorVkeoWkmXM7ug+3GXneXQzwwWaxJ8FL
        jaOc4o/oWAgZ6EPVR6sYwSPNBLqaSb1kq5NSCwFAaW6hrLf5g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Zp4Ygbv8FhyO8KSlZyJ
        8bsPhi3wy4bWp/DL4EGI82wSiQSmugytFKwzbtEEsPMZzhAsztPraYpqIiLVT0sy
        o0x6j2cocUe+7tlhsZ7xvSNAPb8THhK4AjK0ClSvquQe1e4PQ0xVs0vOZmFDzSyp
        YZjLIC+gnJLyKPDg4SSBSwu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E05AFEB83;
        Mon,  5 Oct 2020 18:41:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F165BFEB80;
        Mon,  5 Oct 2020 18:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.29.0-rc0
Date:   Mon, 05 Oct 2020 15:41:24 -0700
Message-ID: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAF19D54-075B-11EB-BBB1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.29.0-rc0 is now available for
testing at the usual places.  It is comprised of 588 non-merge
commits since v2.28.0, contributed by 76 people, 22 of which are
new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.29.0-rc0' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.28.0 are as follows.
Welcome to the Git development community!

  Aaron Lipman, Adrian Moennich, =C3=81kos Uzonyi, Antti Ker=C3=A4nen,
  Christian Schlack, Conor Davis, Eric Huber, Evan Gates, Han
  Xin, Hugo Locurcio, Kyohei Kadota, Lin Sun, Nikita Leonov,
  Noam Yorav-Raphael, pudinha, Raymond E. Pasco, Ryan Zoeller,
  Samanta Navarro, Sibi Siddharthan, Simon Legner, Steve Kemp,
  and Theodore Dubois.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alban Gruin, Alex Henrie, Alex
  Riesen, Andrei Rybak, Beat Bolli, Ben Wijen, brian m. carlson,
  Christian Couder, Chris Torek, Danny Lin, Denton Liu, Derrick
  Stolee, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh, Drew DeVault, Edmun=
do Carmona
  Antoranz, Elijah Newren, Emily Shaffer, Eric Sunshine, Han-Wen
  Nienhuys, Hariom Verma, Jacob Keller, Jeff Hostetler, Jeff King,
  Jiang Xin, Johannes Berg, Johannes Schindelin, Johannes Sixt,
  Jonathan Tan, Junio C Hamano, Kazuhiro Kato, Luke Diamand,
  Martin =C3=85gren, Matheus Tavares, Matthew Rogers, Michael Forney,
  Michal Privoznik, Miriam Rubio, Orgad Shaneh, Patrick Steinhardt,
  Paul Mackerras, Philippe Blain, Phillip Wood, Pranit Bauva,
  Prathamesh Chavan, Ren=C3=A9 Scharfe, Rohit Ashiwal, Sergey Organov,
  Shourya Shukla, Stefan Dotterweich, SZEDER G=C3=A1bor, Taylor Blau,
  Thomas Guyot-Sionnest, and =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=
=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE.

----------------------------------------------------------------

Git 2.29 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since v2.28
-------------------

UI, Workflows & Features

 * "git help log" has been enhanced by sharing more material from the
   documentation for the underlying "git rev-list" command.

 * "git for-each-ref --format=3D<>" learned %(contents:size).

 * "git merge" learned to selectively omit " into <branch>" at the end
   of the title of default merge message with merge.suppressDest
   configuration.

 * The component to respond to "git fetch" request is made more
   configurable to selectively allow or reject object filtering
   specification used for partial cloning.

 * Stop when "sendmail.*" configuration variables are defined, which
   could be a mistaken attempt to define "sendemail.*" variables.

 * The existing backends for "git mergetool" based on variants of vim
   have been refactored and then support for "nvim" has been added.

 * "git bisect" learns the "--first-parent" option to find the first
   breakage along the first-parent chain.

 * "git log --first-parent -p" showed patches only for single-parent
   commits on the first-parent chain; the "--first-parent" option has
   been made to imply "-m".  Use "--no-diff-merges" to restore the
   previous behaviour to omit patches for merge commits.

 * The commit labels used to explain each side of conflicted hunks
   placed by the sequencer machinery have been made more readable by
   humans.

 * The "--batch-size" option of "git multi-pack-index repack" command
   is now used to specify that very small packfiles are collected into
   one until the total size roughly exceeds it.

 * The recent addition of SHA-256 support is marked as experimental in
   the documentation.

 * "git fetch" learned --no-write-fetch-head option to avoid writing
   the FETCH_HEAD file.

 * Command line completion (in contrib/) usually omits redundant,
   deprecated and/or dangerous options from its output; it learned to
   optionally include all of them.

 * The output from the "diff" family of the commands had abbreviated
   object names of blobs involved in the patch, but its length was not
   affected by the --abbrev option.  Now it is.

 * "git worktree" gained a "repair" subcommand to help users recover
   after moving the worktrees or repository manually without telling
   Git.  Also, "git init --separate-git-dir" no longer corrupts
   administrative data related to linked worktrees.

 * The "--format=3D" option to the "for-each-ref" command and friends
   learned a few more tricks, e.g. the ":short" suffix that applies to
   "objectname" now also can be used for "parent", "tree", etc.

 * "git worktree add" learns that the "-d" is a synonym to "--detach"
   option to create a new worktree without being on a branch.

 * "format-patch --range-diff=3D<prev> <origin>..HEAD" has been taught
   not to ignore <origin> when <prev> is a single version.

 * "add -p" now allows editing paths that were only added in intent.

 * The 'meld' backend of the "git mergetool" learned to give the
   underlying 'meld' the '--auto-merge' option, which would help
   reduce the amount of text that requires manual merging.

 * "git for-each-ref" and friends that list refs used to allow only
   one --merged or --no-merged to filter them; they learned to take
   combination of both kind of filtering.

 * "git maintenance", a "git gc"'s big brother, has been introduced to
   take care of more repository maintenance tasks, not limited to the
   object database cleaning.

 * "git receive-pack" that accepts requests by "git push" learned to
   outsource most of the ref updates to the new "proc-receive" hook.

 * "git push" that wants to be atomic and wants to send push
   certificate learned not to prepare and sign the push certificate
   when it fails the local check (hence due to atomicity it is known
   that no certificate is needed).

 * "git commit-graph write" learned to limit the number of bloom
   filters that are computed from scratch with the --max-new-filters
   option.

 * The transport protocol v2 has become the default again.

 * The installation procedure learned to optionally omit "git-foo"
   executable files for each 'foo' built-in subcommand, which are only
   required by old timers that still rely on the age old promise that
   prepending "git --exec-path" output to PATH early in their script
   will keep the "git-foo" calls they wrote working.

 * The command line completion (in contrib/) learned that "git restore
   -s <TAB>" is often followed by a refname.

 * "git shortlog" has been taught to group commits by the contents of
   the trailer lines, like "Reviewed-by:", "Coauthored-by:", etc.

 * "git archive" learns the "--add-file" option to include untracked
   files into a snapshot from a tree-ish.

 * "git fetch" and "git push" support negative refspecs.

 * "git format-patch" learns to take "whenAble" as a possible value
   for the format.useAutoBase configuration variable to become no-op
   when the  automatically computed base does not make sense.

 * Credential helpers are now allowed to terminate lines with CRLF
   line ending, as well as LF line ending.


Performance, Internal Implementation, Development Support etc.

 * The changed-path Bloom filter is improved using ideas from an
   independent implementation.

 * Updates to the changed-paths bloom filter.

 * The test framework has been updated so that most tests will run
   with predictable (artificial) timestamps.

 * Preliminary clean-up of the refs API in preparation for adding a
   new refs backend "reftable".

 * Dev support to limit the use of test_must_fail to only git commands.

 * While packing many objects in a repository with a promissor remote,
   lazily fetching missing objects from the promissor remote one by
   one may be inefficient---the code now attempts to fetch all the
   missing objects in batch (obviously this won't work for a lazy
   clone that lazily fetches tree objects as you cannot even enumerate
   what blobs are missing until you learn which trees are missing).

 * The pretend-object mechanism checks if the given object already
   exists in the object store before deciding to keep the data
   in-core, but the check would have triggered lazy fetching of such
   an object from a promissor remote.

 * The argv_array API is useful for not just managing argv but any
   "vector" (NULL-terminated array) of strings, and has seen adoption
   to a certain degree.  It has been renamed to "strvec" to reduce the
   barrier to adoption.

 * The final leg of SHA-256 transition plus doc updates.  Note that
   there is no inter-operability between SHA-1 and SHA-256
   repositories yet.

 * CMake support to build with MSVC for Windows bypassing the Makefile.

 * A new helper function has_object() has been introduced to make it
   easier to mark object existence checks that do and don't want to
   trigger lazy fetches, and a few such checks are converted using it.

 * A no-op replacement function implemented as a C preprocessor macro
   does not perform as good a job as one implemented as a "static
   inline" function in catching errors in parameters; replace the
   former with the latter in <git-compat-util.h> header.

 * Test framework update.
   (merge d572f52a64 es/test-cmp-typocatcher later to maint).

 * Updates to "git merge" tests, in preparation for a new merge
   strategy backend.

 * midx and commit-graph files now use the byte defined in their file
   format specification for identifying the hash function used for
   object names.

 * The FETCH_HEAD is now always read from the filesystem regardless of
   the ref backend in use, as its format is much richer than the
   normal refs, and written directly by "git fetch" as a plain file..

 * A handful of places in in-tree code still relied on being able to
   execute the git subcommands, especially built-ins, in "git-foo"
   form, which have been corrected.

 * An unused binary has been discarded, and and a bunch of commands
   have been turned into into built-in.

 * A handful of places in in-tree code still relied on being able to
   execute the git subcommands, especially built-ins, in "git-foo"
   form, which have been corrected.

 * When a packfile is removed by "git repack", multi-pack-index gets
   cleared; the code was taught to do so less aggressively by first
   checking if the midx actually refers to a pack that no longer
   exists.

 * Internal API clean-up to handle two options "diff-index" and "log"
   have, which happen to share the same short form, more sensibly.

 * The "add -i/-p" machinery has been written in C but it is not used
   by default yet.  It is made default to those who are participating
   in feature.experimental experiment.

 * Allow maintainers to tweak $(TAR) invocations done while making
   distribution tarballs.

 * "git index-pack" learned to resolve deltified objects with greater
   parallelism.

 * "diff-highlight" (in contrib/) had a logic to flush its output upon
   seeing a blank line but the way it detected a blank line was broken.


Fixes since v2.28
-----------------

 * "git clone --separate-git-dir=3D$elsewhere" used to stomp on the
   contents of the existing directory $elsewhere, which has been
   taught to fail when $elsewhere is not an empty directory.
   (merge dfaa209a79 bw/fail-cloning-into-non-empty later to maint).

 * With the base fix to 2.27 regresion, any new extensions in a v0
   repository would still be silently honored, which is not quite
   right.  Instead, complain and die loudly.
   (merge ec91ffca04 jk/reject-newer-extensions-in-v0 later to maint).

 * Fetching from a lazily cloned repository resulted at the server
   side in attempts to lazy fetch objects that the client side has,
   many of which will not be available from the third-party anyway.
   (merge 77aa0941ce jt/avoid-lazy-fetching-upon-have-check later to main=
t).

 * Fix to an ancient bug caused by an over-eager attempt for
   optimization.
   (merge a98f7fb366 rs/add-index-entry-optim-fix later to maint).

 * Pushing a ref whose name contains non-ASCII character with the
   "--force-with-lease" option did not work over smart HTTP protocol,
   which has been corrected.
   (merge cd85b447bf bc/push-cas-cquoted-refname later to maint).

 * "git mv src dst", when src is an unmerged path, errored out
   correctly but with an incorrect error message to claim that src is
   not tracked, which has been clarified.
   (merge 9b906af657 ct/mv-unmerged-path-error later to maint).

 * Fix to a regression introduced during 2.27 cycle.
   (merge cada7308ad en/fill-directory-exponential later to maint).

 * Command line completion (in contrib/) update.
   (merge 688b87c81b mp/complete-show-color-moved later to maint).

 * All "mergy" operations that internally use the merge-recursive
   machinery should honor the merge.renormalize configuration, but
   many of them didn't.

 * Doc cleanup around "worktree".
   (merge dc9c144be5 es/worktree-doc-cleanups later to maint).

 * The "git blame --first-parent" option was not documented, but now
   it is.
   (merge 11bc12ae1e rp/blame-first-parent-doc later to maint).

 * The logic to find the ref transaction hook script attempted to
   cache the path to the found hook without realizing that it needed
   to keep a copied value, as the API it used returned a transitory
   buffer space.  This has been corrected.
   (merge 09b2aa30c9 ps/ref-transaction-hook later to maint).

 * Recent versions of "git diff-files" shows a diff between the index
   and the working tree for "intent-to-add" paths as a "new file"
   patch; "git apply --cached" should be able to take "git diff-files"
   and should act as an equivalent to "git add" for the path, but the
   command failed to do so for such a path.
   (merge 4c025c667e rp/apply-cached-with-i-t-a later to maint).

 * "git diff [<tree-ish>] $path" for a $path that is marked with i-t-a
   bit was not showing the mode bits from the working tree.
   (merge cb0dd22b82 rp/ita-diff-modefix later to maint).

 * Ring buffer with size 4 used for bin-hex translation resulted in a
   wrong object name in the sequencer's todo output, which has been
   corrected.
   (merge 5da69c0dac ak/sequencer-fix-find-uniq-abbrev later to maint).

 * When given more than one target line ranges, "git blame -La,b
   -Lc,d" was over-eager to coalesce groups of original lines and
   showed incorrect results, which has been corrected.
   (merge c2ebaa27d6 jk/blame-coalesce-fix later to maint).

 * The regexp to identify the function boundary for FORTRAN programs
   has been updated.
   (merge 75c3b6b2e8 pb/userdiff-fortran-update later to maint).

 * A few end-user facing messages have been updated to be
   hash-algorithm agnostic.
   (merge 4279000d3e jc/object-names-are-not-sha-1 later to maint).

 * "unlink" emulation on MinGW has been optimized.
   (merge 680e0b4524 jh/mingw-unlink later to maint).

 * The purpose of "git init --separate-git-dir" is to initialize a
   new project with the repository separate from the working tree,
   or, in the case of an existing project, to move the repository
   (the .git/ directory) out of the working tree. It does not make
   sense to use --separate-git-dir with a bare repository for which
   there is no working tree, so disallow its use with bare
   repositories.
   (merge ccf236a23a es/init-no-separate-git-dir-in-bare later to maint).

 * "ls-files -o" mishandled the top-level directory of another git
   working tree that hangs in the current git working tree.
   (merge ab282aa548 en/dir-nonbare-embedded later to maint).

 * Fix some incorrect UNLEAK() annotations.
   (merge 3e19816dc0 jk/unleak-fixes later to maint).

 * Use more buffered I/O where we used to call many small write(2)s.
   (merge a698d67b08 rs/more-buffered-io later to maint).

 * The patch-id computation did not ignore the "incomplete last line"
   marker like whitespaces.
   (merge 82a62015a7 rs/patch-id-with-incomplete-line later to maint).

 * Updates into a lazy/partial clone with a submodule did not work
   well with transfer.fsckobjects set.

 * The parser for "git for-each-ref --format=3D..." was too loose when
   parsing the "%(trailers...)" atom, and forgot that "trailers" and
   "trailers:<modifiers>" are the only two allowed forms, which has
   been corrected.
   (merge 2c22e102f8 hv/ref-filter-trailers-atom-parsing-fix later to mai=
nt).

 * Long ago, we decided to use 3 threads by default when running the
   index-pack task in parallel, which has been adjusted a bit upwards.
   (merge fbff95b67f jk/index-pack-w-more-threads later to maint).

 * "git restore/checkout --no-overlay" with wildcarded pathspec
   mistakenly removed matching paths in subdirectories, which has been
   corrected.
   (merge bfda204ade rs/checkout-no-overlay-pathspec-fix later to maint).

 * The description of --cached/--index options in "git apply --help"
   has been updated.
   (merge d064702be3 rp/apply-cached-doc later to maint).

 * Feeding "$ZERO_OID" to "git log --ignore-missing --stdin", and
   running "git log --ignore-missing $ZERO_OID" fell back to start
   digging from HEAD; it has been corrected to become a no-op, like
   "git log --tags=3Dno-tag-matches-this-pattern" does.
   (merge 04a0e98515 jk/rev-input-given-fix later to maint).

 * Various callers of run_command API has been modernized.
   (merge afbdba391e jc/run-command-use-embedded-args later to maint).

 * List of options offered and accepted by "git add -i/-p" were
   inconsistent, which have been corrected.
   (merge ce910287e7 pw/add-p-allowed-options-fix later to maint).

 * Various callers of run_command API has been modernized.
   (merge afbdba391e jc/run-command-use-embedded-args later to maint).

 * "git diff --stat -w" showed 0-line changes for paths whose changes
   were only whitespaces, which was not intuitive.  We now omit such
   paths from the stat output.
   (merge 1cf3d5db9b mr/diff-hide-stat-wo-textual-change later to maint).

 * It was possible for xrealloc() to send a non-NULL pointer that has
   been freed, which has been fixed.
   (merge 6479ea4a8a jk/xrealloc-avoid-use-after-free later to maint).

 * "git status" has trouble showing where it came from by interpreting
   reflog entries that record certain events, e.g. "checkout @{u}", and
   gives a hard/fatal error.  Even though it inherently is impossible
   to give a correct answer because the reflog entries lose some
   information (e.g. "@{u}" does not record what branch the user was
   on hence which branch 'the upstream' needs to be computed, and even
   if the record were available, the relationship between branches may
   have changed), at least hide the error to allow "status" show its
   output.

 * "git status --short" quoted a path with SP in it when tracked, but
   not those that are untracked, ignored or unmerged.  They are all
   shown quoted consistently.

 * "git diff/show" on a change that involves a submodule used to read
   the information on commits in the submodule from a wrong repository
   and gave a wrong information when the commit-graph is involved.
   (merge 85a1ec2c32 mf/submodule-summary-with-correct-repository later t=
o maint).

 * Unlike "git config --local", "git config --worktree" did not fail
   early and cleanly when started outside a git repository.
   (merge 378fe5fc3d mt/config-fail-nongit-early later to maint).

 * There is a logic to estimate how many objects are in the
   repository, which is mean to run once per process invocation, but
   it ran every time the estimated value was requested.
   (merge 67bb65de5d jk/dont-count-existing-objects-twice later to maint)=
.

 * "git remote set-head" that failed still said something that hints
   the operation went through, which was misleading.
   (merge 5a07c6c3c2 cs/don-t-pretend-a-failed-remote-set-head-succeeded =
later to maint).

 * "git fetch --all --ipv4/--ipv6" forgot to pass the protocol options
   to instances of the "git fetch" that talk to individual remotes,
   which has been corrected.
   (merge 4e735c1326 ar/fetch-ipversion-in-all later to maint).

 * The "unshelve" subcommand of "git p4" used incorrectly used
   commit^N where it meant to say commit~N to name the Nth generation
   ancestor, which has been corrected.
   (merge 0acbf5997f ld/p4-unshelve-fix later to maint).

 * "git clone" that clones from SHA-1 repository, while
   GIT_DEFAULT_HASH set to use SHA-256 already, resulted in an
   unusable repository that half-claims to be SHA-256 repository
   with SHA-1 objects and refs.  This has been corrected.

 * Adjust sample hooks for hash algorithm other than SHA-1.
   (merge d8d3d632f4 dl/zero-oid-in-hooks later to maint).

 * "git range-diff" showed incorrect diffstat, which has been
   corrected.

 * Earlier we taught "git pull" to warn when the user does not say the
   histories need to be merged, rebased or accepts only fast-
   forwarding, but the warning triggered for those who have set the
   pull.ff configuration variable.
   (merge 54200cef86 ah/pull later to maint).

 * Compilation fix around type punning.
   (merge 176380fd11 jk/drop-unaligned-loads later to maint).

 * "git blame --ignore-rev/--ignore-revs-file" failed to validate
   their input are valid revision, and failed to take into account
   that the user may want to give an annotated tag instead of a
   commit, which has been corrected.
   (merge 610e2b9240 jc/blame-ignore-fix later to maint).

 * "git bisect start X Y", when X and Y are not valid committish
   object names, should take X and Y as pathspec, but didn't.
   (merge 73c6de06af cc/bisect-start-fix later to maint).

 * The explanation of the "scissors line" has been clarified.
   (merge 287416dba6 eg/mailinfo-doc-scissors later to maint).

 * A race that leads to an access to a free'd data was corrected in
   the codepath that reads pack files.
   (merge bda959c476 mt/delta-base-cache-races later to maint).

 * in_merge_bases_many(), a way to see if a commit is reachable from
   any commit in a set of commits, was totally broken when the
   commit-graph feature was in use, which has been corrected.
   (merge 8791bf1841 ds/in-merge-bases-many-optim-bug later to maint).

 * "git submodule update --quiet" did not squelch underlying "rebase"
   and "pull" commands.
   (merge 3ad0401e9e td/submodule-update-quiet later to maint).

 * The lazy fetching done internally to make missing objects available
   in a partial clone incorrectly made permanent damage to the partial
   clone filter in the repository, which has been corrected.

 * "log -c --find-object=3DX" did not work well to find a merge that
   involves a change to an object X from only one parent.
   (merge 957876f17d jk/diff-cc-oidfind-fix later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 84544f2ea3 sk/typofixes later to maint).
   (merge b17f411ab5 ar/help-guides-doc later to maint).
   (merge 98c6871fad rs/grep-simpler-parse-object-or-die-call later to ma=
int).
   (merge 861c4ce141 en/typofixes later to maint).
   (merge 60e47f6773 sg/ci-git-path-fix-with-pyenv later to maint).
   (merge e2bfa50ac3 jb/doc-packfile-name later to maint).
   (merge 918d8ff780 es/worktree-cleanup later to maint).
   (merge dc156bc31f ma/t1450-quotefix later to maint).
   (merge 56e743426b en/merge-recursive-comment-fixes later to maint).
   (merge 7d23ff818f rs/bisect-oid-to-hex-fix later to maint).
   (merge de20baf2c9 ny/notes-doc-sample-update later to maint).
   (merge f649aaaf82 so/rev-parser-errormessage-fix later to maint).
   (merge 6103d58b7f bc/sha-256-cvs-svn-updates later to maint).
   (merge ac900fddb7 ma/stop-progress-null-fix later to maint).
   (merge e767963ab6 rs/upload-pack-sigchain-fix later to maint).
   (merge a831908599 rs/preserve-merges-unused-code-removal later to main=
t).
   (merge 6dfefe70a9 jb/commit-graph-doc-fix later to maint).
   (merge 847b37271e pb/set-url-docfix later to maint).
   (merge 748f733d54 mt/checkout-entry-dead-code-removal later to maint).
   (merge ce820cbd58 dl/subtree-docs later to maint).
   (merge 55fe225dde jk/leakfix later to maint).
   (merge ee22a29215 so/pretty-abbrev-doc later to maint).
   (merge 3100fd5588 jc/post-checkout-doc later to maint).
   (merge 17bae89476 pb/doc-external-diff-env later to maint).
   (merge 27ed6ccc12 jk/worktree-check-clean-leakfix later to maint).
   (merge 1302badd16 ea/blame-use-oideq later to maint).
   (merge e6d5a11fed al/t3200-back-on-a-branch later to maint).
   (merge 324efcf6b6 pw/add-p-leakfix later to maint).
   (merge 1c6ffb546b jk/add-i-fixes later to maint).
   (merge e40e936551 cd/commit-graph-doc later to maint).
   (merge 0512eabd91 jc/sequencer-stopped-sha-simplify later to maint).
   (merge d01141de5a so/combine-diff-simplify later to maint).
   (merge 3be01e5ab1 sn/fast-import-doc later to maint).

----------------------------------------------------------------

Changes since v2.28.0 are as follows:

Aaron Lipman (12):
      t6030: modernize "git bisect run" tests
      rev-list: allow bisect and first-parent flags
      cmd_bisect__helper: defer parsing no-checkout flag
      bisect: introduce first-parent flag
      bisect: combine args passed to find_bisection()
      bisect: add first-parent option to documentation
      t3200: clean side effect of git checkout --orphan
      t3201: test multiple branch filter combinations
      Doc: cover multiple contains/no-contains filters
      ref-filter: allow merged and no-merged filters
      ref-filter: make internal reachable-filter API more precise
      Doc: prefer more specific file name

Adrian Moennich (1):
      ci: fix inconsistent indentation

Alban Gruin (1):
      t6300: fix issues related to %(contents:size)

Alex Henrie (1):
      pull: don't warn if pull.ff has been set

Alex Riesen (1):
      fetch: pass --ipv4 and --ipv6 options to sub-fetches

Andrei Rybak (1):
      git-help.txt: fix mentions of option --guides

Antti Ker=C3=A4nen (1):
      rebase -i: fix possibly wrong onto hash in todo

Beat Bolli (1):
      gitk: rename "commit summary" to "commit reference"

Ben Wijen (1):
      git clone: don't clone into non-empty directory

Chris Torek (1):
      git-mv: improve error message for conflicted file

Christian Couder (4):
      Documentation: clarify %(contents:XXXX) doc
      t6300: test refs pointing to tree and blob
      ref-filter: add support for %(contents:size)
      bisect: don't use invalid oid as rev when starting

Christian Schlack (1):
      remote: don't show success message when set-head fails

Conor Davis (1):
      commit-graph-format.txt: fix no-parent value

Danny Lin (2):
      contrib/subtree: fix "unsure" for --message in the document
      contrib/subtree: document 'push' does not take '--squash'

Denton Liu (11):
      t3701: stop using `env` in force_color()
      t5324: reorder `run_with_limited_open_files test_might_fail`
      t7107: don't use test_must_fail()
      t9834: remove use of `test_might_fail p4`
      t9400: don't use test_must_fail with cvs
      test-lib-functions: restrict test_must_fail usage
      contrib/completion: complete options that take refs for format-patc=
h
      hooks--pre-push.sample: modernize script
      hooks--pre-push.sample: use hash-agnostic zero OID
      hooks--update.sample: use hash-agnostic zero OID
      gitk: replace tabs with spaces

Derrick Stolee (22):
      commit-graph: place bloom_settings in context
      commit-graph: change test to die on parse, not load
      bloom: fix logic in get_bloom_filter()
      commit-graph: persist existence of changed-paths
      revision.c: fix whitespace
      multi-pack-index: repack batches below --batch-size
      t/README: document GIT_TEST_DEFAULT_HASH
      commit-graph: use the "hash version" byte
      multi-pack-index: use hash version byte
      bloom/diff: properly short-circuit on max_changes
      maintenance: create basic maintenance runner
      maintenance: add --quiet option
      maintenance: replace run_auto_gc()
      maintenance: initialize task array
      maintenance: add commit-graph task
      maintenance: add --task option
      maintenance: take a lock on the objects directory
      maintenance: create maintenance.<task>.enabled config
      maintenance: use pointers to check --auto
      maintenance: add auto condition for commit-graph task
      maintenance: add trace2 regions for task execution
      commit-reach: fix in_merge_bases_many bug

Drew DeVault (1):
      git-send-email: die if sendmail.* config is set

Edmundo Carmona Antoranz (1):
      blame.c: replace instance of !oidcmp for oideq

Elijah Newren (26):
      Remove doubled words in various comments
      hashmap: fix typo in usage docs
      merge-recursive: fix unclear and outright wrong comments
      t6038: make tests fail for the right reason
      t6038: remove problematic test
      merge: make merge.renormalize work for all uses of merge machinery
      checkout: support renormalization with checkout -m <paths>
      Collect merge-related tests to t64xx
      t6418: tighten delete/normalize conflict testcase
      t6422: fix bad check against missing file
      t6416, t6422: fix incorrect untracked file count
      t6423: fix test setup for a couple tests
      t6422: fix multiple errors with the mod6 test expectations
      t6416, t6423: clarify some comments and fix some typos
      t6423: add an explanation about why one of the tests does not pass
      t6422, t6426: be more flexible for add/add conflicts involving rena=
mes
      t642[23]: be more flexible for add/add conflicts involving pair ren=
ames
      t6425: be more flexible with rename/delete conflict messages
      t3000: fix some test description typos
      dir: avoid prematurely marking nonbare repositories as matches
      sequencer: avoid garbled merge machinery messages due to commit lab=
els
      mem-pool: add convenience functions for strdup and strndup
      mem-pool: use more standard initialization and finalization
      mem-pool: use consistent pool variable name
      dir: make clear_directory() free all relevant memory
      dir: fix problematic API to avoid memory leaks

Emily Shaffer (1):
      Revert "contrib: subtree: adjust test to change in fmt-merge-msg"

Eric Huber (1):
      gitk: Preserve window dimensions on exit when not using ttk themes

Eric Sunshine (22):
      worktree: drop pointless strbuf_release()
      worktree: drop unused code from get_linked_worktree()
      worktree: drop bogus and unnecessary path munging
      worktree: retire special-case normalization of main worktree path
      git-worktree.txt: employ fixed-width typeface consistently
      git-worktree.txt: consistently use term "working tree"
      git-worktree.txt: fix minor grammatical issues
      git-worktree.txt: make start of new sentence more obvious
      git-worktree.txt: link to man pages when citing other Git commands
      test_cmp: diagnose incorrect arguments
      init: disallow --separate-git-dir with bare repository
      worktree: add skeleton "repair" command
      worktree: teach "repair" to fix worktree back-links to main worktre=
e
      worktree: teach "repair" to fix outgoing links to worktrees
      init: teach --separate-git-dir to repair linked worktrees
      init: make --separate-git-dir work from within linked worktree
      git-checkout.txt: document -d short option for --detach
      worktree: teach `add` to recognize -d as shorthand for --detach
      git-worktree.txt: discuss branch-based vs. throwaway worktrees
      diff: move show_interdiff() from its own file to diff-lib
      diff-lib: tighten show_interdiff()'s interface
      format-patch: use 'origin' as start of current-series-range when kn=
own

Evan Gates (1):
      Doc: show example scissors line

Han Xin (1):
      send-pack: run GPG after atomic push checking

Han-Wen Nienhuys (17):
      lib-t6000.sh: write tag using git-update-ref
      t3432: use git-reflog to inspect the reflog for HEAD
      bisect: treat BISECT_HEAD as a pseudo ref
      t1400: use git rev-parse for testing PSEUDOREF existence
      Modify pseudo refs through ref backend storage
      Make HEAD a PSEUDOREF rather than PER_WORKTREE.
      refs: move the logic to add \t to reflog to the files backend
      refs: split off reading loose ref data in separate function
      refs: fix comment about submodule ref_stores
      refs: move gitdir into base ref_store
      refs: read FETCH_HEAD and MERGE_HEAD generically
      refs: make refs_ref_exists public
      sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
      builtin/commit: suggest update-ref for pseudoref removal
      sequencer: treat REVERT_HEAD as a pseudo ref
      refs: move REF_LOG_ONLY to refs-internal.h
      refs: add GIT_TRACE_REFS debugging mechanism

Hariom Verma (10):
      t6300: unify %(trailers) and %(contents:trailers) tests
      ref-filter: 'contents:trailers' show error if `:` is missing
      ref-filter: support different email formats
      ref-filter: refactor `grab_objectname()`
      ref-filter: modify error messages in `grab_objectname()`
      ref-filter: rename `objectname` related functions and fields
      ref-filter: add `short` modifier to 'tree' atom
      ref-filter: add `short` modifier to 'parent' atom
      pretty: refactor `format_sanitized_subject()`
      ref-filter: add `sanitize` option for 'subject' atom

Hugo Locurcio (1):
      bisect: swap command-line options in documentation

Jacob Keller (4):
      refspec: fix documentation referring to refspec_item
      refspec: make sure stack refspec_item variables are zeroed
      refspec: add support for negative refspecs
      format-patch: teach format.useAutoBase "whenAble" option

Jeff Hostetler (1):
      mingw: improve performance of mingw_unlink()

Jeff King (80):
      t6000: use test_tick consistently
      t9700: loosen ident timezone regex
      t5539: make timestamp requirements more explicit
      t9100: explicitly unset GIT_COMMITTER_DATE
      test-lib: set deterministic default author/committer date
      t9100: stop depending on commit timestamps
      verify_repository_format(): complain about new extensions in v0 rep=
o
      argv-array: use size_t for count and alloc
      argv-array: rename to strvec
      strvec: rename files from argv-array to strvec
      quote: rename sq_dequote_to_argv_array to mention strvec
      strvec: convert builtin/ callers away from argv_array name
      strvec: convert more callers away from argv_array name
      strvec: convert remaining callers away from argv_array name
      strvec: fix indentation in renamed calls
      strvec: update documention to avoid argv_array
      strvec: drop argv_array compatibility layer
      log: drop "--cc implies -m" logic
      revision: add "--no-diff-merges" option to counteract "-m"
      log: enable "-m" automatically with "--first-parent"
      doc/git-log: move "Diff Formatting" from rev-list-options
      doc/git-log: drop "-r" diff option
      doc/git-log: move "-t" into diff-options list
      doc/git-log: clarify handling of merge commit diffs
      strvec: rename struct fields
      config: work around gcc-10 -Wstringop-overflow warning
      revision: avoid out-of-bounds read/write on empty pathspec
      revision: avoid leak when preparing bloom filter for "/"
      t5616: use test_i18ngrep for upload-pack errors
      sideband: mark "remote error:" prefix for translation
      t1416: avoid hard-coded sha1 ids
      t8003: check output of coalesced blame
      t8003: factor setup out of coalesce test
      blame: only coalesce lines that are adjacent in result
      Makefile: drop builtins from MSVC pdb list
      make credential helpers builtins
      make git-bugreport a builtin
      make git-fast-import a builtin
      drop vcs-svn experiment
      stop calling UNLEAK() before die()
      ls-remote: simplify UNLEAK() usage
      clear_pattern_list(): clear embedded hashmaps
      submodule--helper: use strbuf_release() to free strbufs
      checkout: fix leak of non-existent branch names
      config: fix leaks from git_config_get_string_const()
      config: drop git_config_get_string_const()
      config: fix leak in git_config_get_expiry_in_days()
      submodule--helper: fix leak of core.worktree value
      p5302: disable thread-count parameter tests by default
      p5302: count up to online-cpus for thread tests
      index-pack: adjust default threading cap
      revision: set rev_input_given in handle_revision_arg()
      worktree: fix leak in check_clean_worktree()
      xrealloc: do not reuse pointer freed by zero-length realloc()
      add-patch: fix inverted return code of repo_read_index()
      add--interactive.perl: specify --no-color explicitly
      packfile: actually set approximate_object_count_valid
      diff-highlight: correctly match blank lines for flush
      bswap.h: drop unaligned loads
      Revert "fast-export: use local array to store anonymized oid"
      shortlog: change "author" variables to "ident"
      protocol: re-enable v2 protocol by default
      shortlog: add grouping option
      trailer: add interface for iterating over commit trailers
      shortlog: match commit trailers with --group
      shortlog: de-duplicate trailer values
      shortlog: rename parse_stdin_ident()
      shortlog: parse trailer idents
      shortlog: allow multiple groups to be specified
      convert: drop unused crlf_action from check_global_conv_flags_eol()
      drop unused argc parameters
      env--helper: write to opt->value in parseopt helper
      assert PARSE_OPT_NONEG in parse-options callbacks
      push: drop unused repo argument to do_push()
      sequencer: drop repository argument from run_git_commit()
      sparse-checkout: fill in some options boilerplate
      test-advise: check argument count with argc instead of argv
      sequencer: handle ignore_footer when parsing trailers
      dir.c: drop unused "untracked" from treat_path_fast()
      combine-diff: handle --find-object in multitree code path

Jiang Xin (10):
      transport: not report a non-head push as a branch
      t5411: add basic test cases for proc-receive hook
      receive-pack: add new proc-receive hook
      receive-pack: feed report options to post-receive
      New capability "report-status-v2" for git-push
      doc: add document for capability report-status-v2
      receive-pack: new config receive.procReceiveRefs
      t5411: test updates of remote-tracking branches
      transport: parse report options for tracking refs
      doc: add documentation for the proc-receive hook

Johannes Berg (2):
      pack-write/docs: update regarding pack naming
      docs: commit-graph: fix some whitespace in the diagram

Johannes Schindelin (20):
      t3404: prepare 'short SHA-1 collision' tests for SHA-256
      ci: fix indentation of the `ci-config` job
      ci: avoid ugly "failure" in the `ci-config` job
      t/test-terminal: avoid non-inclusive language
      fast-export: avoid using unnecessary language in a code comment
      t3200: avoid variations of the `master` branch name
      msvc: copy the correct `.pdb` files in the Makefile target `install=
`
      Optionally skip linking/copying the built-ins
      ci: stop linking built-ins to the dashed versions
      cmake: ignore files generated by CMake as run in Visual Studio
      tests: avoid variations of the `master` branch name
      t9902: avoid using the branch name `master`
      cmake: do find Git for Windows' shell interpreter
      cmake: ensure that the `vcpkg` packages are found on Windows
      cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
      cmake: quote the path accurately when editing `test-lib.sh`
      cmake (Windows): let the `.dll` files be found when running the tes=
ts
      cmake (Windows): complain when encountering an unknown compiler
      cmake (Windows): initialize vcpkg/build dependencies automatically
      cmake (Windows): recommend using Visual Studio's built-in CMake sup=
port

Johannes Sixt (1):
      gitk: Un-hide selection in areas with non-default background color

Jonathan Tan (32):
      upload-pack: do not lazy-fetch "have" objects
      pack-objects: refactor to oid_object_info_extended
      pack-objects: prefetch objects to be packed
      sha1-file: make pretend_object_file() not prefetch
      sha1-file: introduce no-lazy-fetch has_object()
      apply: do not lazy fetch when applying binary
      pack-objects: no fetch when allow-{any,promisor}
      fsck: do not lazy fetch known non-promisor object
      negotiator/noop: add noop fetch negotiator
      fetch: allow refspecs specified through stdin
      fetch: avoid reading submodule config until needed
      fetch: only populate existing_refs if needed
      fetch-pack: do not lazy-fetch during ref iteration
      promisor-remote: lazy-fetch objects in subprocess
      fetch-pack: remove no_dependents code
      fetch-pack: in partial clone, pass --promisor
      Documentation: deltaBaseCacheLimit is per-thread
      index-pack: remove redundant parameter
      index-pack: unify threaded and unthreaded code
      index-pack: remove redundant child field
      index-pack: calculate {ref,ofs}_{first,last} early
      index-pack: make resolve_delta() assume base data
      (various): document from_promisor parameter
      fetch-pack: document only_packfile in get_pack()
      fetch-pack: make packfile URIs work with transfer.fsckobjects
      fetch: no FETCH_HEAD display if --no-write-fetch-head
      sha1-name: replace unsigned int with option struct
      refs: move dwim_ref() to header file
      wt-status: tolerate dangling marks
      index-pack: make quantum of work smaller
      promisor-remote: remove unused variable
      fetch: do not override partial clone filter

Junio C Hamano (49):
      gitk: be prepared to be run in a bare repository
      reflog: cleanse messages in the refs.c layer
      Revert "fmt-merge-msg: stop treating `master` specially"
      fmt-merge-msg: allow merge destination to be omitted again
      First batch post 2.28
      The second batch -- mostly minor typofixes
      Third batch
      Fourth batch
      Documentation: don't hardcode command categories twice
      compat-util: type-check parameters of no-op replacement functions
      Fifth batch
      Sixth batch
      Seventh batch
      messages: avoid SHA-1 in end-user facing messages
      Eighth batch
      fetch: optionally allow disabling FETCH_HEAD update
      Ninth batch
      ident: say whose identity is missing when giving user.name hint
      Tenth batch
      t3436: do not run git-merge-recursive in dashed form
      transport-helper: do not run git-remote-ext etc. in dashed form
      cvsexportcommit: do not run git programs in dashed form
      run_command: teach API users to use embedded 'args' more
      credential-cache: use child_process.args
      Eleventh batch
      doc: clarify how exit status of post-checkout hook is used
      Twelfth batch
      Thirteenth batch
      add -i: use the built-in version when feature.experimental is set
      Makefile: allow extra tweaking of distribution tarball
      Fourteenth batch
      quote_path: rename quote_path_relative() to quote_path()
      quote_path: give flags parameter to quote_path()
      quote_path: optionally allow quoting a path with SP in it
      quote_path: code clarification
      wt-status: consistently quote paths in "status --short" output
      quote: rename misnamed sq_lookup[] to cq_lookup[]
      quote: turn 'nodq' parameter into a set of flags
      Fifteenth batch
      Sixteenth batch
      t8013: minimum preparatory clean-up
      blame: validate and peel the object names on the ignore list
      t1506: rev-parse A..B and A...B
      sequencer: stop abbreviating stopped-sha file
      Seventeenth batch
      Eighteenth batch
      hashmap_for_each_entry(): workaround MSVC's runtime check failure #=
3
      Nineteenth batch
      Git 2.29-rc0

Kazuhiro Kato (1):
      gitk: fix branch name encoding error

Kyohei Kadota (1):
      Fit to Plan 9's ANSI/POSIX compatibility layer

Lin Sun (1):
      mergetool: allow auto-merge for meld to follow the vim-diff behavio=
r

Luke Diamand (2):
      git-p4 unshelve: adding a commit breaks git-p4 unshelve
      git-p4: use HEAD~$n to find parent commit for unshelve

Martin =C3=85gren (19):
      dir: check pathspecs before returning `path_excluded`
      t1450: fix quoting of NUL byte when corrupting pack
      t: don't spuriously close and reopen quotes
      t4104: modernize and simplify quoting
      progress: don't dereference before checking for NULL
      http-protocol.txt: document SHA-256 "want"/"have" format
      index-format.txt: document SHA-256 index format
      protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-25=
6
      shallow.txt: document SHA-256 shallow format
      Documentation: mark `--object-format=3Dsha256` as experimental
      wt-status: replace sha1 mentions with oid
      wt-status: print to s->fp, not stdout
      wt-status: introduce wt_status_state_free_buffers()
      worktree: inline `worktree_ref()` into its only caller
      worktree: update renamed variable in comment
      worktree: rename copy-pasted variable
      worktree: use skip_prefix to parse target
      config/fmt-merge-msg.txt: drop space in quote
      config/uploadpack.txt: fix typo in `--filter=3Dtree:<n>`

Matheus Tavares (4):
      checkout_entry(): remove unreachable error() call
      config: complain about --worktree outside of a git repo
      packfile: fix race condition on unpack_entry()
      packfile: fix memory leak in add_delta_base_cache()

Matthew Rogers (1):
      diff: teach --stat to ignore uninteresting modifications

Michael Forney (2):
      revision: use repository from rev_info when parsing commits
      submodule: use submodule repository when preparing summary

Michal Privoznik (1):
      completion: add show --color-moved[-ws]

Miriam Rubio (4):
      bisect--helper: BUG() in cmd_*() on invalid subcommand
      bisect--helper: use '-res' in 'cmd_bisect__helper' return
      bisect--helper: introduce new `write_in_file()` function
      bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'

Nikita Leonov (1):
      credential: treat CR/LF as line endings in the credential protocol

Noam Yorav-Raphael (1):
      docs: improve the example that illustrates git-notes path names

Orgad Shaneh (5):
      vcbuild: fix library name for expat with make MSVC=3D1
      vcbuild: fix batch file name in README
      fetch: do not look for submodule changes in unchanged refs
      submodule: suppress checking for file name and ref ambiguity for ob=
ject ids
      contrib/buildsystems: fix expat library name for generated vcxproj

Patrick Steinhardt (2):
      refs: fix interleaving hook calls with reference-transaction hook
      refs: remove lookup cache for reference-transaction hook

Paul Mackerras (1):
      gitk: Resize panes correctly when reducing window size

Philippe Blain (19):
      git-log.txt: add links to 'rev-list' and 'diff' docs
      revisions.txt: describe 'rev1 rev2 ...' meaning for ranges
      git-rev-list.txt: fix Asciidoc syntax
      git-rev-list.txt: tweak wording in set operations
      git-rev-list.txt: move description to separate file
      git-log.txt: include rev-list-description.txt
      command-list.txt: add missing 'gitcredentials' and 'gitremote-helpe=
rs'
      help: drop usage of 'common' and 'useful' for guides
      git.txt: add list of guides
      fetch, pull doc: correct description of '--set-upstream'
      userdiff: add tests for Fortran xfuncname regex
      userdiff: improve Fortran xfuncname regex
      git-imap-send.txt: don't duplicate 'Examples' sections
      git-imap-send.txt: do verify SSL certificate for gmail.com
      git-imap-send.txt: add note about localized Gmail folders
      doc: mention GIT_SEQUENCE_EDITOR and 'sequence.editor' more
      git.txt: correct stale 'GIT_EXTERNAL_DIFF' description
      Makefile: add support for generating JSON compilation database
      gitsubmodules doc: invoke 'ls-files' with '--recurse-submodules'

Phillip Wood (7):
      add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
      add -p: fix checking of user input
      am: stop exporting GIT_COMMITTER_DATE
      rebase -i: support --committer-date-is-author-date
      rebase -i: support --ignore-date
      add -p: fix memory leak
      add -p: fix editing of intent-to-add paths

Pranit Bauva (2):
      bisect--helper: reimplement `bisect_autostart` shell function in C
      bisect--helper: reimplement `bisect_next` and `bisect_auto_next` sh=
ell functions in C

Prathamesh Chavan (1):
      submodule: port submodule subcommand 'summary' from shell to C

Raymond E. Pasco (6):
      apply: allow "new file" patches on i-t-a entries
      blame-options.txt: document --first-parent option
      apply: make i-t-a entries never match worktree
      t4140: test apply with i-t-a paths
      diff-lib: use worktree mode in diffs from i-t-a entries
      git-apply.txt: update descriptions of --cached, --index

Ren=C3=A9 Scharfe (21):
      read-cache: remove bogus shortcut
      grep: avoid using oid_to_hex() with parse_object_or_die()
      bisect: use oid_to_hex_r() instead of memcpy()+oid_to_hex()
      upload-pack: remove superfluous sigchain_pop() call
      rebase: remove unused function reschedule_last_action
      connected: use buffered I/O to talk to rev-list
      midx: use buffered I/O to talk to pack-objects
      upload-pack: use buffered I/O to talk to rev-list
      patch-id: ignore newline at end of file in diff_flush_patch_id()
      checkout, restore: make pathspec recursive
      read-cache: fix mem-pool allocation for multi-threaded index loadin=
g
      push: release strbufs used for refspec formatting
      refspec: add and use refspec_appendf()
      fast-import: use write_pack_header()
      midx: use hashwrite_u8() in write_midx_header()
      pack-bitmap-write: use hashwrite_be32() in write_hash_cache()
      pack-write: use hashwrite_be32() in write_idx_file()
      archive: read short blobs in archive.c::write_archive_entry()
      archive: add --add-file
      Makefile: use git-archive --add-file
      ref-filter: plug memory leak in reach_filter()

Rohit Ashiwal (2):
      rebase -i: add --ignore-whitespace flag
      rebase: add --reset-author-date

Ryan Zoeller (2):
      parse-options: add --git-completion-helper-all
      completion: add GIT_COMPLETION_SHOW_ALL env var

SZEDER G=C3=A1bor (15):
      tree-walk.c: don't match submodule entries for 'submod/anything'
      commit-graph: fix parsing the Chunk Lookup table
      commit-graph-format.txt: all multi-byte numbers are in network byte=
 order
      commit-slab: add a function to deep free entries on the slab
      diff.h: drop diff_tree_oid() & friends' return value
      commit-graph: clean up #includes
      commit-graph: simplify parse_commit_graph() #1
      commit-graph: simplify parse_commit_graph() #2
      commit-graph: simplify write_commit_graph_file() #1
      commit-graph: simplify write_commit_graph_file() #2
      commit-graph: unify the signatures of all write_graph_chunk_*() fun=
ctions
      commit-graph: simplify chunk writes into loop
      commit-graph: check chunk sizes after writing
      commit-graph: check all leading directories in changed path Bloom f=
ilters
      ci: use absolute PYTHON_PATH in the Linux jobs

Samanta Navarro (1):
      fast-import: fix typo in documentation

Sergey Organov (9):
      revision: fix die() message for "--unpacked=3D"
      revision: change "--diff-merges" option to require parameter
      doc/git-log: describe --diff-merges=3Doff
      t/t4013: add test for --diff-merges=3Doff
      pretty-options.txt: fix --no-abbrev-commit description
      revision: add separate field for "-m" of "diff-index -m"
      log_tree_diff: get rid of code duplication for first_parent_only
      log_tree_diff: get rid of extra check for NULL
      diff: get rid of redundant 'dense' argument

Shourya Shukla (11):
      submodule: remove extra line feeds between callback struct and macr=
o
      submodule: rename helper functions to avoid ambiguity
      t7421: introduce a test script for verifying 'summary' output
      t7401: modernize style
      t7401: use 'short' instead of 'verify' and cut in rev-parse calls
      t7401: change syntax of test_i18ncmp calls for clarity
      t7401: change indentation for enhanced readability
      t7401: add a NEEDSWORK
      submodule: eliminate unused parameters from print_submodule_summary=
()
      submodule: fix style in function definition
      t7421: eliminate 'grep' check in t7421.4 for mingw compatibility

Sibi Siddharthan (8):
      Introduce CMake support for configuring Git
      cmake: generate the shell/perl/python scripts and templates, transl=
ations
      cmake: installation support for git
      cmake: support for testing git with ctest
      cmake: support for testing git when building out of the source tree
      cmake: support for building git on windows with mingw
      cmake: support for building git on windows with msvc and clang.
      ci: modification of main.yml to use cmake for vs-build job

Simon Legner (1):
      remote-mediawiki: fix duplicate revisions being imported

Stefan Dotterweich (1):
      gitk: add diff lines background colors

Steve Kemp (1):
      comment: fix spelling mistakes inside comments

Taylor Blau (18):
      revision: empty pathspecs should not use Bloom filters
      list_objects_filter_options: introduce 'list_object_filter_config_n=
ame'
      upload-pack.c: allow banning certain object filter(s)
      upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
      builtin/repack.c: invalidate MIDX only when necessary
      midx: traverse the local MIDX first
      commit-graph: introduce 'get_bloom_filter_settings()'
      t4216: use an '&&'-chain
      commit-graph: pass a 'struct repository *' in more places
      t/helper/test-read-graph.c: prepare repo settings
      commit-graph: respect 'commitGraph.readChangedPaths'
      commit-graph.c: store maximum changed paths
      bloom: split 'get_bloom_filter()' in two
      bloom: use provided 'struct bloom_filter_settings'
      bloom: encode out-of-bounds filters as non-empty
      commit-graph: rename 'split_commit_graph_opts'
      builtin/commit-graph.c: introduce '--max-new-filters=3D<n>'
      commit-graph: introduce 'commitGraph.maxNewFilters'

Theodore Dubois (1):
      submodule update: silence underlying merge/rebase with "--quiet"

Thomas Guyot-Sionnest (1):
      diff: fix modified lines stats with --stat and --numstat

brian m. carlson (48):
      remote-curl: make --force-with-lease work with non-ASCII ref names
      t: make test-bloom initialize repository
      t1001: use $ZERO_OID
      t3305: make hash agnostic
      t6100: make hash size independent
      t6101: make hash size independent
      t6301: make hash size independent
      t6500: specify test values for SHA-256
      t6501: avoid hard-coded objects
      t7003: compute appropriate length constant
      t7063: make hash size independent
      t7201: abstract away SHA-1-specific constants
      t7102: abstract away SHA-1-specific constants
      t7400: make hash size independent
      t7405: make hash size independent
      t7506: avoid checking for SHA-1-specific constants
      t7508: use $ZERO_OID instead of hard-coded constant
      t8002: make hash size independent
      t8003: make hash size independent
      t8011: make hash size independent
      t9300: abstract away SHA-1-specific constants
      t9300: use $ZERO_OID instead of hard-coded object ID
      t9301: make hash size independent
      t9350: make hash size independent
      t9500: ensure that algorithm info is preserved in config
      t9700: make hash size independent
      t5308: make test work with SHA-256
      t0410: mark test with SHA1 prerequisite
      http-fetch: set up git directory before parsing pack hashes
      builtin/verify-pack: implement an --object-format option
      bundle: add new version for use with SHA-256
      setup: add support for reading extensions.objectformat
      repository: enable SHA-256 support by default
      t: add test_oid option to select hash algorithm
      t: allow testing different hash algorithms via environment
      t: make SHA1 prerequisite depend on default hash
      ci: run tests with SHA-256
      docs: add documentation for extensions.objectFormat
      t: remove test_oid_init in tests
      git-cvsexportcommit: support Perl before 5.10.1
      docs: document SHA-256 pack and indices
      docs: fix step in transition plan
      t4013: improve diff-post-processor logic
      po: add missing letter for French message
      docs: explain why squash merges are broken with long-running branch=
es
      docs: explain why reverts are not always applied on merge
      docs: explain how to deal with files that are always modified
      builtin/clone: avoid failure with GIT_DEFAULT_HASH

pudinha (2):
      mergetool--lib: improve support for vimdiff-style tool variants
      mergetools: add support for nvimdiff (neovim) family

=C3=81kos Uzonyi (2):
      completion: use "prev" variable instead of introducing "prevword"
      completion: complete refs after 'git restore -s'

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (17):
      remote-mediawiki doc: correct link to GitHub project
      remote-mediawiki doc: link to MediaWiki's current version
      remote-mediawiki doc: don't hardcode Debian PHP versions
      remote-mediawiki tests: use the login/password variables
      remote-mediawiki tests: use a 10 character password
      remote-mediawiki tests: use test_cmp in tests
      remote-mediawiki tests: change `[]` to `test`
      remote-mediawiki tests: use "$dir/" instead of "$dir."
      remote-mediawiki tests: use a more idiomatic dispatch table
      remote-mediawiki tests: replace deprecated Perl construct
      remote-mediawiki tests: use inline PerlIO for readability
      remote-mediawiki tests: use CLI installer
      remote-mediawiki tests: annotate failing tests
      remote-mediawiki: provide a list form of run_git()
      remote-mediawiki: convert to quoted run_git() invocation
      remote-mediawiki: annotate unquoted uses of run_git()
      remote-mediawiki: use "sh" to eliminate unquoted commands

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (1):
      diff: index-line: respect --abbrev in object's name

=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE (2):
      gitk: don't highlight files after submodules as submodules
      gitk: fix the context menu not appearing in the presence of submodu=
le diffs

