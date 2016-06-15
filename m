From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Wed, 19 Feb 2014 13:41:32 -0800
Message-ID: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 19 22:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGEtn-0002RC-0c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 22:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbaBSVll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 16:41:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbaBSVlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 16:41:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C64B46D786;
	Wed, 19 Feb 2014 16:41:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YThwo6Gq2x9gdnnqBGfBREUWC
	Vw=; b=flqrgOmOva5Rs/pNbac4Mu+S6dh5Os/nLv87XmDggEckSHbek0beqESXN
	Tkq/+rPX9CL2mNVJw9PA64HhaC9pn0ZSA3A55yAeQ6VhqlBupxJNWRYEOBe+X/1u
	1Y9p/HV/dnlcyS7sjOyT79i/bOtqW0zhbvtX2jieWMEDBvYVxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Twgh1g/FdGPdhvPHLtX
	M4SJfzzRtMfomT7zl/5KSaBTNf1qIgFfg7ARXUYD+n6e7Iho3dN2IcjK4Jw7s+cB
	u20mV8E7fGvmd+y2Kw5Kgq6WeQtwlMMBG3qoe6f42j5vuDs0Jriz7fAWPVGS/vX5
	4rKfrk/SY8JwyT9uWaUVLviU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1C636D785;
	Wed, 19 Feb 2014 16:41:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5856C6D783;
	Wed, 19 Feb 2014 16:41:35 -0500 (EST)
X-master-at: 5f95c9f850b19b368c43ae399cc831b17a26a5ac
X-next-at: dc9e3eb950a3fce88e01983170c37200a6d34d8f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9AEB9796-99AE-11E3-B11C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242412>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of 'next' hasn't been rewound, and none of the topics that
have been cooking there has graduated, yet.  Hopefully that can
start happening to open the new development cycle later this week,
at which time I'll be also updating tinyurl.com/gitCal and also
annotate the topics listed in this file with the course of action
(i.e. if you run "Meta/cook -w", many are listed as Undecided right
now, which I need to fix).

There are many stalled topics; I think some of them do deserve to be
discarded as marked, but others do solve (or at least attempt to)
real issues and it would be nice to see people help unblock them
(one reason for blockage would be that they introduce regressions).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.


* jk/http-no-curl-easy (2014-02-18) 1 commit
 - http: never use curl_easy_perform


* jk/janitorial-fixes (2014-02-18) 5 commits
 - open_istream(): do not dereference NULL in the error case
 - builtin/mv: don't use memory after free
 - utf8: use correct type for values in interval table
 - utf8: fix iconv error detection
 - notes-utils: handle boolean notes.rewritemode correctly


* ks/config-file-stdin (2014-02-18) 4 commits
 - config: teach "git config --file -" to read from the standard input
 - config: change git_config_with_options() interface
 - builtin/config.c: rename check_blob_write() -> check_write()
 - config: disallow relative include paths from blobs


* lb/contrib-contacts-looser-diff-parsing (2014-02-18) 1 commit
 - git-contacts: do not fail parsing of good diffs


* mh/replace-refs-variable-rename (2014-02-18) 1 commit
 - Rename read_replace_refs to check_replace_refs


* nd/commit-editor-cleanup (2014-02-18) 3 commits
 - commit: add --cleanup=3Dscissors
 - wt-status.c: move cut-line print code out to wt_status_add_cut_line
 - wt-status.c: make cut_line[] const to shrink .data section a bit


* nd/no-more-fnmatch (2014-02-18) 4 commits
 - Actually remove compat fnmatch source code
 - Stop using fnmatch (either native or compat)
 - Revert "test-wildmatch: add "perf" command to compare wildmatch and =
fnmatch"
 - Use wildmatch() directly without fnmatch() wrapper


* nd/reset-setup-worktree (2014-02-18) 1 commit
 - reset: optionally setup worktree and refresh index on --mixed


* po/git-help-user-manual (2014-02-18) 1 commit
 - Provide a 'git help user-manual' route to the docbook


* rt/links-for-asciidoctor (2014-02-18) 1 commit
 - Fix documentation AsciiDoc links for external urls


* tg/index-v4-format (2014-02-18) 5 commits
 - read-cache: add index.version config variable
 - FIXUP
 - test-lib: allow setting the index format version
 - FIXUP
 - introduce GIT_INDEX_VERSION environment variable


* tr/diff-submodule-no-reuse-worktree (2014-02-18) 2 commits
 - diff: refactor reuse_worktree_file()
 - diff: do not reuse_worktree_file for submodules


* nd/multiple-work-trees (2014-02-19) 26 commits
 - FIXUP???
 - gc: support prune --repos
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - Add new environment variable $GIT_COMMON_DIR
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_gi=
t_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - Make git_path() aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() togeth=
er
 - path.c: rename vsnpath() to do_git_path()
 - Convert git_snpath() to strbuf_git_path()
 - path.c: make get_pathname() return strbuf instead of static buffer

--------------------------------------------------
[Stalled]

* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


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

 Reported to break t5541, and has been stalled for a while without
 fixes.

 Will discard.


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 SZEDER G=C3=A1bor noticed that this breaks "git -c var=3Dval alias" an=
d
 also suggested a better description of the change.

 Has been stalled for a while without much comments from anybody
 interested.

 Will discard.


* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Has been stalled for a while without much comments from anybody
 interested.

 Will discard.


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

 Waiting for a reroll.


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

 Will hold.


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will discard.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 cc/interpret-trailers could be such a generic solution (although
 there don't seem to be much concensus yet).

 Will discard.


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

 Will discard.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part t=
o make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.

 Will discard.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub

 Will discard.


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

 Drew Northup volunteered to take a look into this ($gmane/226216)
 but nothing seems to have happened since then.

 Will discard.


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

* ks/tree-diff-nway (2014-02-14) 2 commits
 - combine-diff: speed it up, by using multiparent diff
 - tree-diff: rework diff_tree() to generate diffs for multiparent case=
s as well
 (this branch uses ks/combine-diff, ks/tree-diff-more and ks/tree-diff-=
walk.)

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=3D2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.

 Promising, but unfortunately the implementation seems a bit too
 unportable for such a core part of the system.


* al/docs (2014-02-11) 4 commits
  (merged to 'next' on 2014-02-13 at 4157cf3)
 + docs/git-blame: explain more clearly the example pickaxe use
 + docs/git-clone: clarify use of --no-hardlinks option
 + docs/git-remote: capitalize first word of initial blurb
 + docs/merge-strategies: remove hyphen from mis-merges

 A handful of documentation updates, all trivially harmless.

 Will cook in 'next'.


* jk/test-ports (2014-02-10) 2 commits
  (merged to 'next' on 2014-02-13 at cbedcb2)
 + tests: auto-set git-daemon port
 + tests: auto-set LIB_HTTPD_PORT from test name
 (this branch is tangled with nd/http-fetch-shallow-fix.)

 Avoid having to assign port number to be used in tests manually.

 Will cook in 'next'.


* nd/daemonize-gc (2014-02-10) 2 commits
 - gc: config option for running --auto in background
 - daemon: move daemonize() to libgit.a

 Allow running "gc --auto" in the background.

 Will merge to 'next'.


* nd/gitignore-trailing-whitespace (2014-02-10) 2 commits
 - dir: ignore trailing spaces in exclude patterns
 - dir: warn about trailing spaces in exclude patterns

 Warn and then ignore trailing whitespaces in .gitignore files,
 unless they are quoted for fnmatch(3), e.g. "path\ ".


* nd/log-show-linear-break (2014-02-10) 1 commit
 - log: add --show-linear-break to help see non-linear history


* ss/completion-rec-sub-fetch-push (2014-02-11) 1 commit
 - completion: teach --recurse-submodules to fetch, pull and push


* ks/tree-diff-more (2014-02-13) 15 commits
 - tree-diff: reuse base str(buf) memory on sub-tree recursion
 - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 - tree-diff: rework diff_tree interface to be sha1 based
 - tree-diff: remove special-case diff-emitting code for empty-tree cas=
es
 - tree-diff: simplify tree_entry_pathcmp
 - tree-diff: show_path prototype is not needed anymore
 - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 - tree-diff: move all action-taking code out of compare_tree_entry()
 - tree-diff: don't assume compare_tree_entry() returns -1,0,1
 - tree-diff: consolidate code for emitting diffs and recursion in one =
place
 - tree-diff: show_tree() is not needed
 - tree-diff: no need to pass match to skip_uninteresting()
 - tree-diff: no need to manually verify that there is no mode change f=
or a path
 - combine-diff: move changed-paths scanning logic into its own functio=
n
 - combine-diff: move show_log_first logic/action out of paths scanning
 (this branch is used by ks/tree-diff-nway; uses ks/combine-diff and ks=
/tree-diff-walk.)


* jh/note-trees-record-blobs (2014-02-12) 1 commit
 - notes: Disallow reusing non-blob as a note object


* jk/run-network-tests-by-default (2014-02-14) 1 commit
 - tests: turn on network daemon tests by default

 Teach "make test" to run networking tests when possible by default.

 Will merge to and then cook in 'next'.


* jc/check-attr-honor-working-tree (2014-02-06) 2 commits
 - check-attr: move to the top of working tree when in non-bare reposit=
ory
 - t0003: do not chdir the whole test process

 "git check-attr" when (trying to) work on a repository with a
 working tree did not work well when the working tree was specified
 via --work-tree (and obviously with --git-dir).

 The command also works in a bare repository but it reads from the
 (possibly stale, irrelevant and/or nonexistent) index, which may
 need to be fixed to read from HEAD, but that is a completely
 separate issue.  As a related tangentto this separate issue, we may
 want to also fix "check-ignore", which refuses to work in a bare
 repository, to also operate in a bare one.


* nd/http-fetch-shallow-fix (2014-02-13) 7 commits
  (merged to 'next' on 2014-02-13 at 7ec3c2f)
 + t5537: move http tests out to t5539
 + fetch-pack: fix deepen shallow over smart http with no-done cap
 + protocol-capabilities.txt: document no-done
 + protocol-capabilities.txt: refer multi_ack_detailed back to pack-pro=
tocol.txt
 + pack-protocol.txt: clarify 'obj-id' in the last ACK after 'done'
 + test: rename http fetch and push test files
 + tests: auto-set LIB_HTTPD_PORT from test name
 (this branch is tangled with jk/test-ports.)

 Attempting to deepen a shallow repository by fetching over smart
 HTTP transport failed in the protocol exchange, when no-done
 extension was used.  The fetching side waited for the list of
 shallow boundary commits after the sending end stopped talking to
 it.

 Will cook in 'next'.


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* ks/tree-diff-walk (2014-02-06) 5 commits
  (merged to 'next' on 2014-02-06 at d56a3be)
 + Finally switch over tree descriptors to contain a pre-parsed entry
 + revision: convert to using diff_tree_sha1()
 + line-log: convert to using diff_tree_sha1()
 + tree-diff: convert diff_root_tree_sha1() to just call diff_tree_sha1=
 with old=3DNULL
 + tree-diff: allow diff_tree_sha1 to accept NULL sha1
 (this branch is used by ks/combine-diff, ks/tree-diff-more and ks/tree=
-diff-nway.)

 Will cook in 'next'.


* nd/reset-intent-to-add (2014-02-05) 1 commit
  (merged to 'next' on 2014-02-07 at 3497008)
 + reset: support "--mixed --intent-to-add" mode

 Will cook in 'next'.


* nd/test-rename-reset (2014-02-04) 1 commit
  (merged to 'next' on 2014-02-06 at ca188bd)
 + t7101, t7014: rename test files to indicate what that file is for

 Will cook in 'next'.


* tb/repack-fix-renames (2014-02-05) 1 commit
 - repack.c: rename a few variables

 Perhaps unneeded, as the longer-term plan is to drop the codeblock
 this change touches.

 Will discard.


* tr/remerge-diff (2014-02-05) 6 commits
 - log --remerge-diff: show what the conflict resolution changed
 - merge-recursive: allow storing conflict hunks in index
 - Fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - log: add a merge base inspection option
 - pretty: refactor add_merge_info() into parts
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 RFC.


* bs/stdio-undef-before-redef (2014-01-31) 1 commit
  (merged to 'next' on 2014-01-31 at 9874918)
 + git-compat-util.h: #undef (v)snprintf before #define them

 When we replace broken macros from stdio.h in git-compat-util.h,
 #undef them to avoid re-definition warnings from the C
 preprocessor.

 Will cook in 'next'.


* ep/varscope (2014-01-31) 7 commits
  (merged to 'next' on 2014-01-31 at d198f5d)
 + builtin/gc.c: reduce scope of variables
 + builtin/fetch.c: reduce scope of variable
 + builtin/commit.c: reduce scope of variables
 + builtin/clean.c: reduce scope of variable
 + builtin/blame.c: reduce scope of variables
 + builtin/apply.c: reduce scope of variables
 + bisect.c: reduce scope of variable

 Shrink lifetime of variables by moving their definitions to an
 inner scope where appropriate.

 Will cook in 'next'.


* mw/symlinks (2014-02-04) 6 commits
  (merged to 'next' on 2014-02-06 at 3d6df37)
 + setup: don't dereference in-tree symlinks for absolute paths
 + setup: add abspath_part_inside_repo() function
 + t0060: add tests for prefix_path when path begins with work tree
 + t0060: add test for prefix_path when path =3D=3D work tree
 + t0060: add test for prefix_path on symlinks via absolute paths
 + t3004: add test for ls-files on symlinks via absolute paths

 All subcommands that take pathspecs mishandled an in-tree symbolic
 link when given it as a full path from the root (which arguably is
 a sick way to use pathspecs).  "git ls-files -s $(pwd)/RelNotes" in
 our tree is an easy reproduction recipe.

 Will cook in 'next'.


* ks/combine-diff (2014-02-12) 6 commits
 - tests: add checking that combine-diff emits only correct paths
 - combine-diff: simplify intersect_paths() further
 - combine-diff: combine_diff_path.len is not needed anymore
 - combine-diff: optimize combine_diff_path sets intersection
 - diff test: add tests for combine-diff with orderfile
 - diffcore-order: export generic ordering interface
 (this branch is used by ks/tree-diff-more and ks/tree-diff-nway; uses =
ks/tree-diff-walk.)

 By avoiding running full two-way diff between the resulting
 revision and each of its N parents, combine-diff can be sped up
 significantly.

 Will merge to 'next' after reading it over one more time.
 Help in reviewing the series is very much appreciated.


* bc/gpg-sign-everywhere (2014-02-11) 9 commits
  (merged to 'next' on 2014-02-13 at 390376c)
 + pull: add the --gpg-sign option.
 + rebase: add the --gpg-sign option
 + rebase: parse options in stuck-long mode
 + rebase: don't try to match -M option
 + rebase: remove useless arguments check
 + am: add the --gpg-sign option
 + am: parse options in stuck-long mode
 + git-sh-setup.sh: add variable to use the stuck-long mode
 + cherry-pick, revert: add the --gpg-sign option

 Teach "--gpg-sign" option to many commands that create commits.

 Changes to some scripted Porcelains use unsafe variable
 substitutions and still need to be tightened.

 Will cook in 'next'.


* ds/rev-parse-required-args (2014-01-28) 1 commit
  (merged to 'next' on 2014-01-31 at 73b7514)
 + rev-parse: check i before using argv[i] against argc

 "git rev-parse --default" without the required option argument did
 not diagnose it as an error.

 Will cook in 'next'.


* jk/config-path-include-fix (2014-01-28) 2 commits
  (merged to 'next' on 2014-01-31 at 8550a9e)
 + handle_path_include: don't look at NULL value
 + expand_user_path: do not look at NULL path

 include.path variable (or any variable that expects a path that can
 use ~username expansion) in the configuration file is not a
 boolean, but the code failed to check it.

 Will cook in 'next'.


* jk/repack-honor-pack-keep (2014-02-12) 1 commit
 - repack: add `repack.honorpackkeep` config var
 (this branch uses jk/pack-bitmap.)

 Optionally allow "git repack" to include objects that exist in kept
 packs in newly created packfiles.

 Waiting for response to review comments.


* nd/submodule-pathspec-ending-with-slash (2014-01-27) 8 commits
  (merged to 'next' on 2014-01-31 at cfddaa5)
 + clean: use cache_name_is_other()
 + clean: replace match_pathspec() with dir_path_match()
 + Pass directory indicator to match_pathspec_item()
 + match_pathspec: match pathspec "foo/" against directory "foo"
 + dir.c: prepare match_pathspec_item for taking more flags
 + Rename match_pathspec_depth() to match_pathspec()
 + Convert some match_pathspec_depth() to dir_path_match()
 + Convert some match_pathspec_depth() to ce_path_match()

 Allow "git cmd path/", when the 'path' is where a submodule is
 bound to the top-level working tree, to match 'path', despite the
 extra and unnecessary trailing slash.

 Will cook in 'next'.


* lt/request-pull (2014-01-31) 4 commits
 - pull-request: test updates
 - request-pull: pick up tag message as before
 - Make request-pull able to take a refspec of form local:remote
 - Make 'git request-pull' more strict about matching

 Waiting for the updates to settle.


* bk/refresh-missing-ok-in-merge-recursive (2014-01-27) 4 commits
  (merged to 'next' on 2014-01-29 at 614c158)
 + merge-recursive.c: Tolerate missing files while refreshing index
 + read-cache.c: Extend make_cache_entry refresh flag with options
 + read-cache.c: Refactor --ignore-missing implementation
 + t3030-merge-recursive: Test known breakage with empty work tree

 Allows "merge-recursive" to work in an empty (temporary) working
 tree again when there are renames involved, correcting an old
 regression in 1.7.7 era.

 Will cook in 'next'.


* nd/diff-quiet-stat-dirty (2014-01-27) 2 commits
  (merged to 'next' on 2014-01-31 at 8b6e35d)
 + diff: do not quit early on stat-dirty files
 + Move diffcore_skip_stat_unmatch core logic out for reuse later

 "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
 correct status value.

 Will cook in 'next'.


* cc/interpret-trailers (2014-02-06) 14 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands using env variables
 - trailer: set author and committer env variables
 - trailer: add tests for trailer command
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: if no input file is passed, read from stdin
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from input file
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from file and arguments
 - Add data structures and basic functions for commit trailers


* dk/blame-janitorial (2014-02-12) 4 commits
  (merged to 'next' on 2014-02-13 at cc6f7eb)
 + blame.c: prepare_lines should not call xrealloc for every line
  (merged to 'next' on 2014-02-11 at 4af3ebd)
 + builtin/blame.c::prepare_lines: fix allocation size of sb->lineno
  (merged to 'next' on 2014-01-29 at 0b7ea97)
 + Eliminate same_suspect function in builtin/blame.c
 + builtin/blame.c: struct blame_entry does not need a prev link

 Code clean-up.

 Will cook in 'next'.


* ks/diff-c-with-diff-order (2014-02-03) 5 commits
  (merged to 'next' on 2014-02-04 at 24a8b2e)
 + combine-diff: simplify intersect_paths() further
 + combine-diff: combine_diff_path.len is not needed anymore
 + combine-diff: optimize combine_diff_path sets intersection
 + diff test: add tests for combine-diff with orderfile
 + diffcore-order: export generic ordering interface

 Teach combine-diff to honour the path-output-order imposed by
 diffcore-order.

 Will cook in 'next'.


* bl/blame-full-history (2014-01-14) 1 commit
 - blame: new option --prefer-first to better handle merged cherry-pick=
s

 By disabling the tree-same optimization (which is consistent with
 the default behaviour of "git log"-family of commands), make "git
 blame" sometimes produce different result from the original code.

 Because the "git blame" output can give result for each line from
 only one lineage of the history, however, this can be only useful
 when you are lucky---unlike "--full-history" of "git log"-family,
 where we can show commits from both lineages of histories with an
 equal weight.  See $gmane/240392 for more detailed discussion.

 Will discard.


* da/pull-ff-configuration (2014-01-15) 2 commits
  (merged to 'next' on 2014-01-22 at 2686b09)
 + pull: add --ff-only to the help text
 + pull: add pull.ff configuration

 "git pull" learned to pay attention to pull.ff configuration
 variable.

 Will cook in 'next'.


* wk/submodule-on-branch (2014-01-27) 4 commits
  (merged to 'next' on 2014-02-06 at 03dc3fd)
 + Documentation: Describe 'submodule update --remote' use case
 + submodule: Explicit local branch creation in module_clone
 + submodule: Document module_clone arguments in comments
 + submodule: Make 'checkout' update_module explicit

 Makes sure 'submodule update' modes that do not detach HEADs can
 be used more pleasantly by checking out a concrete branch when
 cloning them to prime the well.

 Will cook in 'next'.


* jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
 - get_sha1: drop object/refname ambiguity flag
 - get_sha1: speed up ambiguous 40-hex test
 - FIXUP: teach DO_FOR_EACH_NO_RECURSE to prime_ref_dir()
 - refs: teach for_each_ref a flag to avoid recursion
 - cat-file: fix a minor memory leak in batch_objects
 - cat-file: refactor error handling of batch_objects

 Expecting a reroll.


* ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
 - remote-hg: do not fail on invalid bookmarks

 Reported to break tests ($gmane/240005)
 Expecting a reroll.


* jk/pack-bitmap (2014-02-12) 26 commits
  (merged to 'next' on 2014-02-13 at 591b040)
 + ewah: unconditionally ntohll ewah data
  (merged to 'next' on 2014-01-27 at 0b1dcb5)
 + ewah: support platforms that require aligned reads
 + read-cache: use get_be32 instead of hand-rolled ntoh_l
 + block-sha1: factor out get_be and put_be wrappers
  (merged to 'next' on 2014-01-16 at ddac2d2)
 + do not discard revindex when re-preparing packfiles
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
 (this branch is used by jk/repack-honor-pack-keep.)

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


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


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
