From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2014, #02; Fri, 10)
Date: Fri, 10 Jan 2014 13:58:06 -0800
Message-ID: <xmqq8uun8pox.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 10 22:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1k5s-0001sc-HE
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 22:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaAJV6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jan 2014 16:58:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaAJV6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 16:58:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C49A962C52;
	Fri, 10 Jan 2014 16:58:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SaOM3kK6kHY+d3Q/fxJ4Dw9KE
	Sk=; b=VdjChciSNBeEmae2zpd4Kahyh7nyAnWgS7nZa0OSsoXlzRyNpEAwHA+6o
	nEi7I64Yyy/ME5UMBMTc3P9TJyNKE01G38xgNv4CnZEd7DCGhdbwMXQGKov3RZRS
	sJOKxoAJqUGesDqCQp/vZhZ9Go+gjG5YPrFubmcdd29GtcUOZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=UM/Tkn6XGdLgpfehEM+
	YAksmWL5nFKRqgZB2eIQFMVgu0Mgjwt3UD0vYvull62TJc4ImAQ9rqAWjPFGMBDY
	uoU0p5wj+UzlTCTOb2s6rtkntvQK/8WRJkZ8H0Re3ylYzvGsePJ/W/Ju1CAlHmQT
	wsIx74gUoi6SEHVOuLSwOsfo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0A6562C51;
	Fri, 10 Jan 2014 16:58:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6189962C4F;
	Fri, 10 Jan 2014 16:58:09 -0500 (EST)
X-master-at: a25014bc4cef56712f7d005d7b76070d0270f454
X-next-at: 7559984f930784464fd0cfdd0a69e17c779ae117
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AE32934-7A42-11E3-A87A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240319>

What's cooking in git.git (Jan 2014, #02; Fri, 10)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Quite a few topics have graduated to 'master' in this round and the
upcoming release is starting to take shape.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/path-max (2013-12-16) 1 commit
  (merged to 'next' on 2014-01-03 at affc620)
 + Prevent buffer overflows when path is too long


* bc/log-decoration (2013-12-20) 1 commit
  (merged to 'next' on 2014-01-03 at ff8873f)
 + log: properly handle decorations with chained tags

 "git log --decorate" did not handle a tag pointed by another tag
 nicely.


* bm/merge-base-octopus-dedup (2013-12-30) 2 commits
  (merged to 'next' on 2014-01-06 at 355d62b)
 + merge-base --octopus: reduce the result from get_octopus_merge_bases=
()
 + merge-base: separate "--independent" codepath into its own helper

 "git merge-base --octopus" used to leave cleaning up suboptimal
 result to the caller, but now it does the clean-up itself.


* bs/mirbsd (2014-01-02) 1 commit
  (merged to 'next' on 2014-01-06 at d5cecbb)
 + Add MirBSD support to the build system.


* cc/replace-object-info (2013-12-30) 11 commits
  (merged to 'next' on 2014-01-03 at 4473803)
 + replace info: rename 'full' to 'long' and clarify in-code symbols
  (merged to 'next' on 2013-12-17 at aeb9e18)
 + Documentation/git-replace: describe --format option
 + builtin/replace: unset read_replace_refs
 + t6050: add tests for listing with --format
 + builtin/replace: teach listing using short, medium or full formats
 + sha1_file: perform object replacement in sha1_object_info_extended()
 + t6050: show that git cat-file --batch fails with replace objects
 + sha1_object_info_extended(): add an "unsigned flags" parameter
 + sha1_file.c: add lookup_replace_object_extended() to pass flags
 + replace_object: don't check read_replace_refs twice
 + rename READ_SHA1_FILE_REPLACE flag to LOOKUP_REPLACE_OBJECT

 read_sha1_file() that is the workhorse to read the contents given
 an object name honoured object replacements, but there is no
 corresponding mechanism to sha1_object_info() that is used to
 obtain the metainfo (e.g. type & size) about the object, leading
 callers to weird inconsistencies.


* jh/rlimit-nofile-fallback (2013-12-18) 1 commit
  (merged to 'next' on 2014-01-03 at b56ae0c)
 + get_max_fd_limit(): fall back to OPEN_MAX upon getrlimit/sysconf fai=
lure

 When we figure out how many file descriptors to allocate for
 keeping packfiles open, a system with non-working getrlimit() could
 cause us to die(), but because we make this call only to get a
 rough estimate of how many is available and we do not even attempt
 to use up all file descriptors available ourselves, it is nicer to
 fall back to a reasonable low value rather than dying.


* jk/credential-plug-leak (2014-01-02) 1 commit
  (merged to 'next' on 2014-01-06 at 88e29a3)
 + Revert "prompt: clean up strbuf usage"

 An earlier "clean-up" introduced an unnecessary memory leak.


* jk/http-auth-tests-robustify (2014-01-02) 1 commit
  (merged to 'next' on 2014-01-06 at 7e87bba)
 + use distinct username/password for http auth tests

 Using the same username and password during the tests would not
 catch a potential breakage of sending one when we should be sending
 the other.


* jk/oi-delta-base (2013-12-26) 2 commits
  (merged to 'next' on 2014-01-06 at 8cf3ed2)
 + cat-file: provide %(deltabase) batch format
 + sha1_object_info_extended: provide delta base sha1s

 Teach "cat-file --batch" to show delta-base object name for a
 packed object that is represented as a delta.


* jk/sha1write-void (2013-12-26) 1 commit
  (merged to 'next' on 2014-01-06 at d8cd8ff)
 + do not pretend sha1write returns errors

 Code clean-up.


* jk/test-framework-updates (2014-01-02) 3 commits
  (merged to 'next' on 2014-01-06 at f81f373)
 + t0000: drop "known breakage" test
 + t0000: simplify HARNESS_ACTIVE hack
 + t0000: set TEST_OUTPUT_DIRECTORY for sub-tests

 The basic test used to leave unnecessary trash directories in the
 t/ directory.


* js/lift-parent-count-limit (2013-12-27) 1 commit
  (merged to 'next' on 2014-01-06 at b74133c)
 + Remove the line length limit for graft files

 There is no reason to have a hardcoded upper limit of the number of
 parents for an octopus merge, created via the graft mechanism.


* km/gc-eperm (2014-01-02) 1 commit
  (merged to 'next' on 2014-01-06 at fe107de)
 + gc: notice gc processes run by other users

 A "gc" process running as a different user should be able to stop a
 new "gc" process from starting.


* mh/path-max (2013-12-18) 2 commits
  (merged to 'next' on 2014-01-03 at 5227c9b)
 + builtin/prune.c: use strbuf to avoid having to worry about PATH_MAX
 + prune-packed: use strbuf to avoid having to worry about PATH_MAX

 A few places where we relied on a fixed length buffer to hold
 pathnames in these two programs have been converted to use strbuf.


* nd/add-empty-fix (2013-12-26) 1 commit
  (merged to 'next' on 2014-01-06 at 88a78c9)
 + add: don't complain when adding empty project root

 "git add -A" (no other arguments) in a totally empty working tree
 used to emit an error.


* nd/commit-tree-constness (2013-12-26) 1 commit
  (merged to 'next' on 2014-01-06 at a177c9f)
 + commit.c: make "tree" a const pointer in commit_tree*()

 Code clean-up.


* nd/daemon-informative-errors-typofix (2013-12-20) 1 commit
  (merged to 'next' on 2014-01-03 at 1b87648)
 + daemon: be strict at parsing parameters --[no-]informative-errors


* nd/negative-pathspec (2013-12-06) 3 commits
  (merged to 'next' on 2013-12-12 at 9f340c8)
 + pathspec.c: support adding prefix magic to a pathspec with mnemonic =
magic
 + Support pathspec magic :(exclude) and its short form :!
 + glossary-content.txt: rephrase magic signature part

 Introduce "negative pathspec" magic, to allow "git log -- . ':!dir'" t=
o
 tell us "I am interested in everything but 'dir' directory".


* rr/completion-branch-config (2014-01-06) 4 commits
  (merged to 'next' on 2014-01-06 at ed9eecc)
 + completion: fix remote.pushdefault
 + completion: fix branch.autosetup(merge|rebase)
 + completion: introduce __gitcomp_nl_append ()
 + zsh completion: find matching custom bash completion

 Two-level configuration variable names in "branch.*" and "remote.*"
 hierarchies whose variables are predominantly three-level where not
 completed by hitting a <TAB> in bash and zsh completions.


* rt/bfg-ad-in-filter-branch-doc (2013-12-18) 1 commit
  (merged to 'next' on 2014-01-03 at 2a45e3b)
 + docs: add filter-branch notes on The BFG


* sb/diff-orderfile-config (2013-12-18) 3 commits
  (merged to 'next' on 2014-01-03 at 744eba7)
 + diff: add diff.orderfile configuration variable
 + diff: let "git diff -O" read orderfile from any file and fail proper=
ly
 + t4056: add new tests for "git diff -O"

 Allow "git diff -O<file>" to be configured with a new configuration
 variable.


* ss/builtin-cleanup (2014-01-06) 3 commits
  (merged to 'next' on 2014-01-06 at ffcac50)
 + builtin/help.c: speed up is_git_command() by checking for builtin co=
mmands first
 + builtin/help.c: call load_command_list() only when it is needed
 + git.c: consistently use the term "builtin" instead of "internal comm=
and"

 "git help $cmd" unnecessarily enumerated potential command names
 from the filesystem, even when $cmd is known to be a built-in.

 Ideas for further optimization, primarily by killing the use of
 is_in_cmdlist(), were suggested in the discussion, but they can
 come as follow-ups on top of this series.


* ta/format-user-manual-as-an-article (2014-01-06) 1 commit
  (merged to 'next' on 2014-01-06 at 37858f6)
 + user-manual: improve html and pdf formatting

 Update the way the user-manual is formatted via AsciiDoc to save
 trees.


* tm/fetch-prune (2014-01-03) 2 commits
  (merged to 'next' on 2014-01-03 at a58c6b4)
 + fetch --prune: Run prune before fetching
 + fetch --prune: always print header url

 Fetching 'frotz' branch with "git fetch", while having
 'frotz/nitfol' remote-tracking branch from an earlier fetch, would
 error out, primarily because the command has not been told to
 remove anything on our side. In such a case, "git fetch --prune"
 can be used to remove 'frotz/nitfol' to make room to fetch and
 store 'frotz' remote-tracking branch.


* vm/octopus-merge-bases-simplify (2014-01-03) 1 commit
  (merged to 'next' on 2014-01-06 at 35df672)
 + get_octopus_merge_bases(): cleanup redundant variable

--------------------------------------------------
[New Topics]

* br/sha1-name-40-hex-no-disambiguation (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at 2a0973b)
 + sha1_name: don't resolve refs when core.warnambiguousrefs is false
 (this branch is used by jk/warn-on-object-refname-ambiguity.)

 When parsing a 40-hex string into the object name, the string is
 checked to see if it can be interpreted as a ref so that a warning
 can be given for ambiguity. The code kicked in even when the
 core.warnambiguousrefs is set to false to squelch this warning, in
 which case the cycles spent to look at the ref namespace were an
 expensive no-op, as the result was discarded without being used.

 Will merge to 'master'.


* jl/submodule-mv-checkout-caveat (2014-01-07) 2 commits
  (merged to 'next' on 2014-01-10 at 8d3953c)
 + rm: better document side effects when removing a submodule
 + mv: better document side effects when moving a submodule

 With a submodule that was initialized in an old fashioned way
 without gitlinks, switching branches in the superproject between
 the one with and without the submodule may leave the submodule
 working tree with its embedded repository behind, as there may be
 unexpendable state there. Document and warn users about this.

 Will merge to 'master'.


* jn/pager-lv-default-env (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at 22d4755)
 + pager: set LV=3D-c alongside LESS=3DFRSX

 Just like we give a reasonable default for "less" via the LESS
 environment variable, specify a reasonable default for "lv" via the
 "LV" environment variable when spawning the pager.

 Will merge to 'master'.


* ow/stash-with-ifs (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at 4fc9bdb)
 + stash: handle specifying stashes with $IFS

 The implementation of 'git stash $cmd "stash@{...}"' did not quote
 the stash argument properly and left it split at IFS whitespace.

 Will merge to 'master'.


* rr/completion-format-coverletter (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at d2dbc9d)
 + completion: complete format.coverLetter

 The bash/zsh completion code did not know about format.coverLetter
 among many format.* configuration variables.

 Will merge to 'master'.


* wk/submodule-on-branch (2014-01-07) 2 commits
 - DONTMERGE: RFC will be rerolled with tests ($gmane/239967)
 - submodule: respect requested branch on all clones

 Waiting for the discussion to settle.


* jk/branch-at-publish (2014-01-09) 5 commits
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - interpret_branch_name: factor out upstream handling
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Expecting a reroll.


* jk/pull-rebase-using-fork-point (2014-01-09) 1 commit
  (merged to 'next' on 2014-01-10 at e86e59d)
 + rebase: fix fork-point with zero arguments

 Will merge to 'master'.


* jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
 - get_sha1: drop object/refname ambiguity flag
 - get_sha1: speed up ambiguous 40-hex test
 - FIXUP: teach DO_FOR_EACH_NO_RECURSE to prime_ref_dir()
 - refs: teach for_each_ref a flag to avoid recursion
 - cat-file: fix a minor memory leak in batch_objects
 - cat-file: refactor error handling of batch_objects
 (this branch uses br/sha1-name-40-hex-no-disambiguation.)

 Expecting a reroll.


* mh/shorten-unambigous-ref (2014-01-09) 3 commits
 - shorten_unambiguous_ref(): tighten up pointer arithmetic
 - gen_scanf_fmt(): delete function and use snprintf() instead
 - shorten_unambiguous_ref(): introduce a new local variable

 Will merge to 'next'.


* mm/mv-file-to-no-such-dir-with-slash (2014-01-10) 1 commit
 - mv: let 'git mv file no-such-dir/' error out on Windows, too

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


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

 Reported to break t5541.
 Will hold.


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 SZEDER G=C3=A1bor noticed that this breaks "git -c var=3Dval alias" an=
d
 also suggested a better description of the change.

 Will hold.


* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Comments?


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
 quite badly, and I think I got the resolution right this time.


* kb/fast-hashmap (2014-01-03) 19 commits
 - hashmap.h: make sure map entries are tightly packed
  (merged to 'next' on 2014-01-03 at dc85001)
 + name-hash: retire unused index_name_exists()
 + hashmap.h: Use 'unsigned int' for hash-codes everywhere
  (merged to 'next' on 2013-12-16 at bff99b1)
 + Drop unnecessary #includes from test-hashmap
 + Add test-hashmap to .gitignore
  (merged to 'next' on 2013-12-06 at f90be3d)
 + read-cache.c: fix memory leaks caused by removed cache entries
 + builtin/update-index.c: cleanup update_one
 + fix 'git update-index --verbose --again' output
 + remove old hash.[ch] implementation
 + name-hash.c: remove cache entries instead of marking them CE_UNHASHE=
D
 + name-hash.c: use new hash map implementation for cache entries
 + name-hash.c: remove unreferenced directory entries
 + name-hash.c: use new hash map implementation for directories
 + diffcore-rename.c: use new hash map implementation
 + diffcore-rename.c: simplify finding exact renames
 + diffcore-rename.c: move code around to prepare for the next patch
 + buitin/describe.c: use new hash map implementation
 + add a hashtable implementation that supports O(1) removal
 + submodule: don't access the .gitmodules cache entry after removing i=
t

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The tip one does not seem to have reached concensus (yet).


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will hold.


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
 - diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part t=
o make rename visible

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
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it ou=
t.

--------------------------------------------------
[Cooking]

* ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
 - remote-hg: do not fail on invalid bookmarks

 Reported to break tests ($gmane/240005)
 Expecting a reroll.


* ss/safe-create-leading-dir-with-slash (2014-01-06) 1 commit
 - safe_create_leading_directories(): on Windows, \ can separate path c=
omponents

 Expecting to be rolled into mh/safe-create-leading-directories


* fp/submodule-checkout-mode (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at 647ba9b)
 + git-submodule.sh: 'checkout' is a valid update mode

 "submodule.*.update=3Dcheckout", when propagated from .gitmodules to
 .git/config, turned into a "submodule.*.update=3Dnone", which did not
 make much sense.

 Will merge to 'master'.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


* mh/safe-create-leading-directories (2014-01-06) 17 commits
 - rename_tmp_log(): on SCLD_VANISHED, retry
 - rename_tmp_log(): limit the number of remote_empty_directories() att=
empts
 - rename_tmp_log(): handle a possible mkdir/rmdir race
 - rename_ref(): extract function rename_tmp_log()
 - remove_dir_recurse(): handle disappearing files and directories
 - remove_dir_recurse(): tighten condition for removing unreadable dir
 - lock_ref_sha1_basic(): if locking fails with ENOENT, retry
 - lock_ref_sha1_basic(): on SCLD_VANISHED, retry
 - safe_create_leading_directories(): add new error value SCLD_VANISHED
 - cmd_init_db(): when creating directories, handle errors conservative=
ly
 - safe_create_leading_directories(): introduce enum for return values
 - safe_create_leading_directories(): always restore slash at end of lo=
op
 - safe_create_leading_directories(): split on first of multiple slashe=
s
 - safe_create_leading_directories(): rename local variable
 - safe_create_leading_directories(): add explicit "slash" pointer
 - safe_create_leading_directories(): reduce scope of local variable
 - safe_create_leading_directories(): fix format of "if" chaining

 Code clean-up and protection against concurrent write access to the
 ref namespace.

 Asked Michael and Sebastian to work together to roll the latter's
 "allow passing p\a\t\h to safe_create_leading_dir()" into this.

 Expecting a reroll.


* jk/pack-bitmap (2013-12-30) 21 commits
  (merged to 'next' on 2014-01-10 at bdbe0a4)
 + pack-bitmap: implement optional name_hash cache
 + t/perf: add tests for pack bitmaps
 + t: add basic bitmap functionality tests
 + count-objects: recognize .bitmap in garbage-checking
 + repack: consider bitmaps when performing repacks
 + repack: handle optional files created by pack-objects
 + repack: turn exts array into array-of-struct
 + repack: stop using magic number for ARRAY_SIZE(exts)
 + pack-objects: implement bitmap writing
 + rev-list: add bitmap mode to speed up object lists
 + pack-objects: use bitmaps when packing objects
 + pack-objects: split add_object_entry
 + pack-bitmap: add support for bitmap indexes
 + documentation: add documentation for the bitmap format
 + ewah: compressed bitmap implementation
 + compat: add endianness helpers
 + sha1_file: export `git_open_noatime`
 + revision: allow setting custom limiter function
 + pack-objects: factor out name_hash
 + pack-objects: refactor the packing list
 + revindex: export new APIs

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 Will cook in 'next'.


* nv/commit-gpgsign-config (2013-12-17) 3 commits
  (merged to 'next' on 2014-01-03 at 9780cbb)
 + test the commit.gpgsign config option
 + commit-tree: add and document --no-gpg-sign
 + Add the commit.gpgsign option to sign all commits

 Introduce commit.gpgsign configuration variable to force every
 commit to be GPG signed.  The variable cannot be overriden from the
 command line of some of the commands that create commits except for
 "git commit" and "git commit-tree", but I am not convinced that it
 is a good idea to sprinkle support for --no-gpg-sign everywhere.

 Will cook in 'next'.


* nd/shallow-clone (2014-01-09) 31 commits
  (merged to 'next' on 2014-01-09 at 6608634)
 + t5537: fix incorrect expectation in test case 10
  (merged to 'next' on 2014-01-06 at 3dc7fab)
 + shallow: remove unused code
 + send-pack.c: mark a file-local function static
  (merged to 'next' on 2014-01-03 at a776065)
 + git-clone.txt: remove shallow clone limitations
 + prune: clean .git/shallow after pruning objects
 + clone: use git protocol for cloning shallow repo locally
 + send-pack: support pushing from a shallow clone via http
 + receive-pack: support pushing to a shallow clone via http
 + smart-http: support shallow fetch/clone
 + remote-curl: pass ref SHA-1 to fetch-pack as well
 + send-pack: support pushing to a shallow clone
 + receive-pack: allow pushes that update .git/shallow
 + connected.c: add new variant that runs with --shallow-file
 + add GIT_SHALLOW_FILE to propagate --shallow-file to subprocesses
 + receive/send-pack: support pushing from a shallow clone
 + receive-pack: reorder some code in unpack()
 + fetch: add --update-shallow to accept refs that update .git/shallow
 + upload-pack: make sure deepening preserves shallow roots
 + fetch: support fetching from a shallow repository
 + clone: support remote shallow repository
 + fetch-pack.h: one statement per bitfield declaration
 + fetch-pack.c: move shallow update code out of fetch_pack()
 + shallow.c: steps 6 and 7 to select new commits for .git/shallow
 + shallow.c: the 8 steps to select new commits for .git/shallow
 + shallow.c: extend setup_*_shallow() to accept extra shallow commits
 + connect.c: teach get_remote_heads to parse "shallow" lines
 + make the sender advertise shallow commits to the receiver
 + clone: prevent --reference to a shallow repository
 + send-pack: forbid pushing from a shallow repository
 + remote.h: replace struct extra_have_objects with struct sha1_array
 + transport.h: remove send_pack prototype, already defined in send-pac=
k.h

 Fetching from a shallow-cloned repository used to be forbidden,
 primarily because the codepaths involved were not carefully vetted
 and we did not bother supporting such usage. This attempts to allow
 object transfer out of a shallow-cloned repository in a controlled
 way (i.e. the receiver become a shallow repository with truncated
 history).

 Will merge to 'master'.


* jn/git-gui-chmod+x (2013-11-25) 1 commit
 - git-gui: chmod +x po2msg, windows/git-gui.sh

 Parked here until I get the same change back from the upstream
 git-gui tree.


* jn/gitk-chmod+x (2013-11-25) 1 commit
 - gitk: chmod +x po2msg

 Parked here until I get the same change back from the upstream gitk
 tree.


* cc/starts-n-ends-with-endgame (2013-12-05) 1 commit
  (merged to 'next' on 2014-01-07 at 4cdf8d0)
 + strbuf: remove prefixcmp() and suffixcmp()

 Endgame for the cc/starts-n-ends-with topic; this needs to be
 evil-merged with other topics that introduce new uses of
 prefix/suffix-cmp functions.

 Will cook in 'next' until Git 2.0.


* gj/push-more-verbose-advice (2013-11-13) 1 commit
  (merged to 'next' on 2013-12-06 at 574b18a)
 + push: switch default from "matching" to "simple"

 Originally merged to 'next' on 2013-11-21

 Explain 'simple' and 'matching' in "git push" advice message; the
 topmost patch is a rebase of jc/push-2.0-default-to-simple on top
 of it.

 Will cook in 'next' until Git 2.0.


* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 Will hold until using script appears.


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
