From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Thu, 12 Dec 2013 16:57:43 -0800
Message-ID: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 13 01:58:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrH4z-0000lE-U5
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 01:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab3LMA5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 19:57:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab3LMA5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 19:57:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B455AAF9;
	Thu, 12 Dec 2013 19:57:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	M08wcMZWXrWceUZfCFIcS6f4b0=; b=sBw+lZ+FxBQjAYC7zZ7v/JzAT4IvB014l
	WQBD3XeRSzLB7ycVBcjw7BnQF+Ow6FNtdzd1E3WezGpOArJk7MZWj9JIp65rtm+4
	ipmkavTibIfnVsZXvtXOwKckP/iC6z8FVJ+u08P4bPblB5G1wQwAQu2R6wJ80dpV
	1W8bo7kd3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=U+e
	pQjuKXbCHz6kA5Vt1ZFeRIuEgjzqxL4JcQS/sg5xLTCLBsAajGYL5kSpyaAvbEod
	h2cjQs/oPsLQoXTxUN/SWQ+xJuk4Cb51XlYKl6zinOGY8qP37MCL6PG91K2s8KG/
	/sNS7AcpFtvQzDsy9fSWXC6C17p58lzA8mYzeSTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 193FE5AAF8;
	Thu, 12 Dec 2013 19:57:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ADC35AAF7;
	Thu, 12 Dec 2013 19:57:47 -0500 (EST)
X-master-at: d7aced95cd681b761468635f8d2a8b82d7ed26fd
X-next-at: aaad5e77ff44962de7a1fccb0c9def6b6dd228aa
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 94ECE73A-6391-11E3-BAD2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239252>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* bc/doc-merge-no-op-revert (2013-12-09) 1 commit
 - Documentation: document pitfalls with 3-way merge

 Will merge to 'next'.


* cc/replace-object-info (2013-12-12) 10 commits
 - Documentation/git-replace: describe --format option
 - builtin/replace: unset read_replace_refs
 - t6050: add tests for listing with --format
 - builtin/replace: teach listing using short, medium or full formats
 - sha1_file: perform object replacement in sha1_object_info_extended()
 - t6050: show that git cat-file --batch fails with replace objects
 - sha1_object_info_extended(): add an "unsigned flags" parameter
 - sha1_file.c: add lookup_replace_object_extended() to pass flags
 - replace_object: don't check read_replace_refs twice
 - rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT

 read_sha1_file() that is the workhorse to read the contents given
 an object name honoured object replacements, but there is no
 corresponding mechanism to sha1_object_info() that is used to
 obtain the metainfo (e.g. type & size) about the object, leading
 callers to weird inconsistencies.

 Will merge to 'next'.


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 Will merge to 'next'.


* fc/remote-helper-fixes (2013-12-09) 4 commits
 - remote-hg: add tests for special filenames
 - remote-hg: fix 'shared path' path
 - remote-helpers: add extra safety checks
 - remote-hg: avoid buggy strftime()

 Will merge to 'next'.


* fc/trivial (2013-12-09) 4 commits
 - remote: fix status with branch...rebase=preserve
 - fetch: add missing documentation
 - t: trivial whitespace cleanups
 - abspath: trivial style fix

 Will merge to 'next'.


* jk/cat-file-regression-fix (2013-12-12) 2 commits
 - cat-file: handle --batch format with missing type/size
 - cat-file: pass expand_data to print_object_or_die

 Will merge to 'next'.


* jk/pull-rebase-using-fork-point (2013-12-10) 2 commits
 - rebase: use reflog to find common base with upstream
 - pull: use merge-base --fork-point when appropriate

 Will merge to 'next'.


* jk/rev-parse-double-dashes (2013-12-09) 2 commits
 - rev-parse: be more careful with munging arguments
 - rev-parse: correctly diagnose revision errors before "--"

 "git rev-parse <revs> -- <paths>" did not implement the usual
 disambiguation rules the commands in the "git log" family used in
 the same way.

 Will merge to 'next'.


* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Comments?


* nd/remove-opt-boolean (2013-12-09) 1 commit
 - parse-options: remove OPT_BOOLEAN

 Will merge to 'next'.


* nd/shallow-clone (2013-12-10) 28 commits
 - git-clone.txt: remove shallow clone limitations
 - prune: clean .git/shallow after pruning objects
 - clone: use git protocol for cloning shallow repo locally
 - send-pack: support pushing from a shallow clone via http
 - receive-pack: support pushing to a shallow clone via http
 - smart-http: support shallow fetch/clone
 - remote-curl: pass ref SHA-1 to fetch-pack as well
 - send-pack: support pushing to a shallow clone
 - receive-pack: allow pushes that update .git/shallow
 - connected.c: add new variant that runs with --shallow-file
 - add GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
 - receive/send-pack: support pushing from a shallow clone
 - receive-pack: reorder some code in unpack()
 - fetch: add --update-shallow to accept refs that update .git/shallow
 - upload-pack: make sure deepening preserves shallow roots
 - fetch: support fetching from a shallow repository
 - clone: support remote shallow repository
 - fetch-pack.h: one statement per bitfield declaration
 - fetch-pack.c: move shallow update code out of fetch_pack()
 - shallow.c: steps 6 and 7 to select new commits for .git/shallow
 - shallow.c: the 8 steps to select new commits for .git/shallow
 - shallow.c: extend setup_*_shallow() to accept extra shallow commits
 - connect.c: teach get_remote_heads to parse "shallow" lines
 - make the sender advertise shallow commits to the receiver
 - clone: prevent --reference to a shallow repository
 - send-pack: forbid pushing from a shallow repository
 - remote.h: replace struct extra_have_objects with struct sha1_array
 - transport.h: remove send_pack prototype, already defined in send-pack.h

 Fetching from a shallow-cloned repository used to be forbidden,
 primarily because the codepaths involved were not carefully vetted
 and we did not bother supporting such usage. This attempts to allow
 object transfer out of a shallow-cloned repository in a controlled
 way (i.e. the receiver become a shallow repository with truncated
 history).


* tg/diff-no-index-refactor (2013-12-12) 2 commits
 - diff: don't read index when --no-index is given
 - diff: move no-index detection to builtin/diff.c

 "git diff ../else/where/A ../else/where/B" when ../else/where is
 clearly outside the repository, and "git diff --no-index A B", do
 not have to look at the index at all, but we used to read the index
 unconditionally.

 Will merge to 'next'.


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time (a
 few nights ago I tried and failed and that was why it hasn't been
 merged to 'pu' so far).

--------------------------------------------------
[Graduated to "master"]

* cl/p4-use-diff-tree (2013-11-22) 1 commit
  (merged to 'next' on 2013-12-06 at fc3c89e)
 + git p4: Use git diff-tree instead of format-patch

 Originally merged to 'next' on 2013-11-27


* cn/thin-push-capability (2013-11-25) 1 commit
  (merged to 'next' on 2013-12-06 at a7ae524)
 + send-pack: don't send a thin pack to a server which doesn't support it

 Allow receive-pack to insist on receiving a fat pack from "git
 push" clients.


* jk/remove-deprecated (2013-12-05) 6 commits
  (merged to 'next' on 2013-12-06 at c0c91a2)
 + Sync with 1.8.5
 + stop installing git-tar-tree link
 + peek-remote: remove deprecated alias of ls-remote
 + lost-found: remove deprecated command
 + tar-tree: remove deprecated command
 + repo-config: remove deprecated alias for "git config"
 (this branch is used by cc/starts-n-ends-with and cc/starts-n-ends-with-endgame.)

 Remove commands that have long been deprecated.


* jn/scripts-updates (2013-11-26) 7 commits
  (merged to 'next' on 2013-12-06 at 60a7026)
 + remove #!interpreter line from shell libraries
 + test: replace shebangs with descriptions in shell libraries
 + test: make FILEMODE a lazy prereq
 + contrib: remove git-p4import
 + mark contributed hooks executable
 + mark perl test scripts executable
 + mark Windows build scripts executable


* mh/fetch-tags-in-addition-to-normal-refs (2013-10-30) 23 commits
  (merged to 'next' on 2013-12-06 at 3b9c44a)
 + fetch: improve the error messages emitted for conflicting refspecs
 + handle_duplicate(): mark error message for translation
 + ref_remote_duplicates(): extract a function handle_duplicate()
 + ref_remove_duplicates(): simplify loop logic
 + t5536: new test of refspec conflicts when fetching
 + ref_remove_duplicates(): avoid redundant bisection
 + git-fetch.txt: improve description of tag auto-following
 + fetch-options.txt: simplify ifdef/ifndef/endif usage
 + fetch, remote: properly convey --no-prune options to subprocesses
 + builtin/remote.c:update(): use struct argv_array
 + builtin/remote.c: reorder function definitions
 + query_refspecs(): move some constants out of the loop
 + fetch --prune: prune only based on explicit refspecs
 + fetch --tags: fetch tags *in addition to* other stuff
 + fetch: only opportunistically update references based on command line
 + get_expanded_map(): avoid memory leak
 + get_expanded_map(): add docstring
 + builtin/fetch.c: reorder function definitions
 + get_ref_map(): rename local variables
 + api-remote.txt: correct section "struct refspec"
 + t5510: check that "git fetch --prune --tags" does not prune branches
 + t5510: prepare test refs more straightforwardly
 + t5510: use the correct tag name in test

 Originally merged to 'next' on 2013-11-06

 The "--tags" option to "git fetch" used to be literally a synonym to
 a "refs/tags/*:refs/tags/*" refspec, which meant that (1) as an
 explicit refspec given from the command line, it silenced the lazy
 "git fetch" default that is configured, and (2) also as an explicit
 refspec given from the command line, it interacted with "--prune"
 to remove any tag that the remote we are fetching from does not
 have.

 This demotes it to an option; with it, we fetch all tags in
 addition to what would be fetched without the option, and it does
 not interact with the decision "--prune" makes to see what
 remote-tracking refs the local has are missing the remote
 counterpart.


* rs/doc-submitting-patches (2013-11-27) 1 commit
  (merged to 'next' on 2013-12-06 at 0628818)
 + SubmittingPatches: document how to handle multiple patches


* tr/commit-slab-cleanup (2013-12-02) 3 commits
  (merged to 'next' on 2013-12-06 at faee247)
 + commit-slab: sizeof() the right type in xrealloc
 + commit-slab: declare functions "static inline"
 + commit-slab: document clear_$slabname()


* tr/config-multivalue-lift-max (2013-12-06) 1 commit
  (merged to 'next' on 2013-12-06 at 92afee2)
 + config: arbitrary number of matches for --unset and --replace-all


* tr/doc-git-cherry (2013-11-27) 1 commit
  (merged to 'next' on 2013-12-06 at 9a1ba7a)
 + Documentation: revamp git-cherry(1)

--------------------------------------------------
[Stalled]

* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


* nv/commit-gpgsign-config (2013-11-06) 1 commit
 - Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.

 Needs tests, perhaps?


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 It appears that the discussion stalled.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* jk/pack-bitmap (2013-11-18) 22 commits
 - compat/mingw.h: Fix the MinGW and msvc builds
 - pack-bitmap: implement optional name_hash cache
 - t/perf: add tests for pack bitmaps
 - t: add basic bitmap functionality tests
 - count-objects: recognize .bitmap in garbage-checking
 - repack: consider bitmaps when performing repacks
 - repack: handle optional files created by pack-objects
 - repack: turn exts array into array-of-struct
 - repack: stop using magic number for ARRAY_SIZE(exts)
 - pack-objects: implement bitmap writing
 - rev-list: add bitmap mode to speed up object lists
 - pack-objects: use bitmaps when packing objects
 - pack-bitmap: add support for bitmap indexes
 - documentation: add documentation for the bitmap format
 - ewah: compressed bitmap implementation
 - compat: add endianness helpers
 - sha1_file: export `git_open_noatime`
 - revision: allow setting custom limiter function
 - pack-objects: factor out name_hash
 - pack-objects: refactor the packing list
 - revindex: export new APIs
 + sha1write: make buffer const-correct
 (this branch is tangled with jk/name-pack-after-byte-representation.)

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 A reroll forthcoming?


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* fc/transport-helper-fixes (2013-12-09) 6 commits
 - remote-bzr: support the new 'force' option
 - test-hg.sh: tests are now expected to pass
 - transport-helper: check for 'forced update' message
 - transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.

 Will merge to 'next'.


* jn/git-gui-chmod+x (2013-11-25) 1 commit
 - git-gui: chmod +x po2msg, windows/git-gui.sh

 Parked here until I get the same change back from the upstream
 git-gui tree.


* jn/gitk-chmod+x (2013-11-25) 1 commit
 - gitk: chmod +x po2msg

 Parked here until I get the same change back from the upstream gitk
 tree.


* jk/name-pack-after-byte-representation (2013-12-05) 2 commits
  (merged to 'next' on 2013-12-09 at 247b2d0)
 + pack-objects: name pack files after trailer hash
 + sha1write: make buffer const-correct
 (this branch is tangled with jk/pack-bitmap.)

 Two packfiles that contain the same set of objects have
 traditionally been named identically, but that made repacking a
 repository that is already fully packed without any cruft with a
 different packing parameter cumbersome. Update the convention to
 name the packfile after the bytestream representation of the data,
 not after the set of objects in it.

 Will merge to 'master'.


* nd/negative-pathspec (2013-12-06) 3 commits
  (merged to 'next' on 2013-12-12 at 9f340c8)
 + pathspec.c: support adding prefix magic to a pathspec with mnemonic magic
 + Support pathspec magic :(exclude) and its short form :!
 + glossary-content.txt: rephrase magic signature part

 Introduce "negative pathspec" magic, to allow "git log . ':!dir'" to
 tell us "I am interested in everything but 'dir' directory".


* nd/transport-positive-depth-only (2013-12-06) 1 commit
  (merged to 'next' on 2013-12-12 at f953cb8)
 + clone,fetch: catch non positive --depth option value

 "git fetch --depth=0" was a no-op, and was silently
 ignored. Diagnose it as an error.


* zk/difftool-counts (2013-12-06) 1 commit
  (merged to 'next' on 2013-12-12 at ba35694)
 + difftool: display the number of files in the diff queue in the prompt

 Show the total number of paths and the number of paths shown so far
 when "git difftool" prompts to launch an external diff tool, which
 would give users some sense of progress.


* jl/commit-v-strip-marker (2013-12-05) 1 commit
  (merged to 'next' on 2013-12-09 at 2b85e9e)
 + commit -v: strip diffs and submodule shortlogs from the commit message

 "git commit -v" appends the patch to the log message before
 editing, and then removed the patch when the editor returned
 control. However, the patch was not stripped correctly when the
 first modified path was a submodule.


* cc/starts-n-ends-with (2013-12-05) 4 commits
  (merged to 'next' on 2013-12-12 at 76ee567)
 + replace {pre,suf}fixcmp() with {starts,ends}_with()
 + strbuf: introduce starts_with() and ends_with()
 + builtin/remote: remove postfixcmp() and use suffixcmp() instead
 + environment: normalize use of prefixcmp() by removing " != 0"
 (this branch is used by cc/starts-n-ends-with-endgame.)

 Remove a few duplicate implementations of prefix/suffix comparison
 functions, and rename them to starts_with and ends_with.


* cc/starts-n-ends-with-endgame (2013-12-05) 1 commit
 - strbuf: remove prefixcmp() and suffixcmp()
 (this branch uses cc/starts-n-ends-with.)

 Endgame for the above topic, that needs to be evil-merged with
 other topics that introduce new uses of prefix/suffix-cmp
 functions.


* jc/push-refmap (2013-12-04) 3 commits
  (merged to 'next' on 2013-12-12 at 71e358f)
 + push: also use "upstream" mapping when pushing a single ref
 + push: use remote.$name.push as a refmap
 + builtin/push.c: use strbuf instead of manual allocation

 Make "git push origin master" update the same ref that would be
 updated by our 'master' when "git push origin" (no refspecs) is run
 while the 'master' branch is checked out, which makes "git push"
 more symmetric to "git fetch" and more usable for the triangular
 workflow.


* jk/t5000-gzip-simplify (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at e9010f1)
 + t5000: simplify gzip prerequisite checks

 Test fix.


* js/gnome-keyring (2013-12-04) 1 commit
 - contrib/git-credential-gnome-keyring.c: small stylistic cleanups

 Style fix.


* kn/gitweb-extra-branch-refs (2013-12-12) 4 commits
  (merged to 'next' on 2013-12-12 at ae75b02)
 + gitweb: Denote non-heads, non-remotes branches
 + gitweb: Add a feature for adding more branch refs
 + gitweb: Return 1 on validation success instead of passed input
 + gitweb: Move check-ref-format code into separate function

 Allow gitweb to be configured to show refs out of refs/heads/ as if
 they were branches.


* mm/mv-file-to-no-such-dir-with-slash (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at f33bc0b)
 + mv: let 'git mv file no-such-dir/' error out


* nd/gettext-vsnprintf (2013-12-04) 1 commit
  (merged to 'next' on 2013-12-09 at e99106e)
 + gettext.c: detect the vsnprintf bug at runtime


* tr/send-email-ssl (2013-12-04) 3 commits
  (merged to 'next' on 2013-12-09 at facb859)
 + send-email: set SSL options through IO::Socket::SSL::set_client_defaults
 + send-email: --smtp-ssl-cert-path takes an argument
 + send-email: pass Debug to Net::SMTP::SSL::new

 SSL-related options were not passed correctly to underlying socket
 layer in "git send-email".


* tb/clone-ssh-with-colon-for-port (2013-12-09) 10 commits
  (merged to 'next' on 2013-12-12 at ae4ae39)
 + git_connect(): use common return point
 + connect.c: refactor url parsing
 + git_connect(): refactor the port handling for ssh
 + git fetch: support host:/~repo
 + t5500: add test cases for diag-url
 + git fetch-pack: add --diag-url
 + git_connect: factor out discovery of the protocol and its parts
 + git_connect: remove artificial limit of a remote command
 + t5601: add tests for ssh
 + t5601: remove clear_ssh, refactor setup_ssh_wrapper

 Be more careful when parsing remote repository URL given in the
 scp-style host:path notation.


* kb/doc-exclude-directory-semantics (2013-12-09) 1 commit
  (merged to 'next' on 2013-12-09 at e54b2ec)
 + gitignore.txt: clarify recursive nature of excluded directories

 Will merge to 'master'.


* gj/push-more-verbose-advice (2013-11-13) 1 commit
  (merged to 'next' on 2013-12-06 at 574b18a)
 + push: switch default from "matching" to "simple"

 Originally merged to 'next' on 2013-11-21

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will cook in 'next'.


* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 Will hold until using script appears.


* kb/fast-hashmap (2013-12-09) 15 commits
 - hashmap.h: make sure map entries are tightly packed
  (merged to 'next' on 2013-12-06 at f90be3d)
 + read-cache.c: fix memory leaks caused by removed cache entries
 + builtin/update-index.c: cleanup update_one
 + fix 'git update-index --verbose --again' output
 + remove old hash.[ch] implementation
 + name-hash.c: remove cache entries instead of marking them CE_UNHASHED
 + name-hash.c: use new hash map implementation for cache entries
 + name-hash.c: remove unreferenced directory entries
 + name-hash.c: use new hash map implementation for directories
 + diffcore-rename.c: use new hash map implementation
 + diffcore-rename.c: simplify finding exact renames
 + diffcore-rename.c: move code around to prepare for the next patch
 + buitin/describe.c: use new hash map implementation
 + add a hashtable implementation that supports O(1) removal
 + submodule: don't access the .gitmodules cache entry after removing it

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The tip one does not seem to have reached concensus (yet).


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-12-06 at ead2ec8)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-12-06 at ae18007)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-12-06 at 6fad61c)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-12-06 at fbaa75a)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
  (merged to 'next' on 2013-12-06 at 083d67c)
 + diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* aa/transport-non-positive-depth-only (2013-11-26) 1 commit
 . transport: catch non positive --depth option value


* cc/remote-remove-redundant-postfixcmp (2013-11-06) 2 commits
 . Rename suffixcmp() to has_suffix() and invert its result
 . builtin/remote: remove postfixcmp() and use suffixcmp() instead


* th/reflog-annotated-tag (2013-10-28) 1 commit
 . reflog: handle lightweight and annotated tags equally

 "git log -g $annotated_tag", when there is no reflog history, should
 have produced a single output entry (i.e. the ref creation event),
 but instead showed the history leading to the tag.

 Broken at the design level.  Any reflog entry that points at a non
 commit needs to be handled with new code that does not exist yet,
 and lifting the "this code handles only commits" without adding
 such code does not solve anything.
