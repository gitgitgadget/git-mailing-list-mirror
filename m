From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2014, #04; Wed, 22)
Date: Wed, 22 Jan 2014 15:18:07 -0800
Message-ID: <xmqqob33wqq8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 00:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W673s-0000Gx-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbaAVXSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 18:18:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbaAVXSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 18:18:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B90649C5;
	Wed, 22 Jan 2014 18:18:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Vz9JuDaJMqcPvw2P5/5WibSFt
	tk=; b=rY8rouOxTjGLnRipYklb1HxiDQllJIKni6gSeamRN6rOZwnl+m+FXl093
	tPzutUrI+Kzj6x1jh8RrH2p5sswe3d3EGZJh2DtWUF1FAtJ5dQEeYJxw/1Yqc+JX
	0EwXfmKZCqUO252tZLfnUymZlOscMcRO2OExJ+wcbllwil63Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Ky6Zkwb4Zpbb4tJX1k6
	Qcd03YIcVIlO+sH6YX7C+jgc5RBY8jfNypFvCaJYte+AttVazn37wohh5RJUZ+su
	mhVnA7vTVEVEgiZdvpecJE3/GfLMEFAm9d9n88ClI4cKWCVDlrsHQ7GZpgRWjgSd
	tqjQDQad/dGqaJ1r+xE8TFB8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 192F7649C4;
	Wed, 22 Jan 2014 18:18:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5770D649C3;
	Wed, 22 Jan 2014 18:18:10 -0500 (EST)
X-master-at: f21e1c5d36cfbbff753cec652c21a88a129f1a27
X-next-at: 8e6341d90183123bf2e9368ab83d6382c9846761
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75706A7C-83BB-11E3-A8C9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240884>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* fp/submodule-checkout-mode (2014-01-07) 1 commit
  (merged to 'next' on 2014-01-10 at 647ba9b)
 + git-submodule.sh: 'checkout' is a valid update mode
 (this branch is used by wk/submodule-on-branch.)

 "submodule.*.update=3Dcheckout", when propagated from .gitmodules to
 .git/config, turned into a "submodule.*.update=3Dnone", which did not
 make much sense.


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

--------------------------------------------------
[New Topics]

* jn/ignore-doc (2014-01-16) 1 commit
  (merged to 'next' on 2014-01-22 at a07ac63)
 + gitignore doc: add global gitignore to synopsis

 Explicitly list $HOME/.config/git/ignore as one of the places you
 can use to keep ignore patterns that depend on your personal choice
 of tools, e.g. *~ for Emacs users.

 Will merge to 'master'.


* rk/send-email-ssl-cert (2014-01-16) 1 commit
  (merged to 'next' on 2014-01-22 at 2fb13f2)
 + send-email: /etc/ssl/certs/ directory may not be usable as ca_path

 The "if /etc/ssl/certs/ directory exists, explicitly tell the
 library to use it as SSL_ca_path" blind-defaulting in "git
 send-email" broke platforms where /etc/ssl/certs/ directory exists,
 but it cannot used as SSL_ca_path (e.g. Fedora rawhide).  Fix it by
 not specifying any SSL_ca_path/SSL_ca_file but still asking for
 peer verification in such a case.

 Will merge to 'master'.


* ef/mingw-write (2014-01-17) 2 commits
  (merged to 'next' on 2014-01-22 at b9ddab2)
 + mingw: remove mingw_write
 + prefer xwrite instead of write

 Will merge to 'master'.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark
 (this branch uses jk/interpret-branch-name-fix.)

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.


* jk/color-for-more-pagers (2014-01-17) 4 commits
 - pager: disable colors for some known-bad configurations
 - DONOTMERGE: needs matching change to git-sh-setup
 - setup_pager: set MORE=3DR
 - setup_pager: refactor LESS/LV environment setting


* jk/diff-filespec-cleanup (2014-01-17) 5 commits
  (merged to 'next' on 2014-01-22 at fb26e43)
 + diff_filespec: use only 2 bits for is_binary flag
 + diff_filespec: reorder is_binary field
 + diff_filespec: drop xfrm_flags field
 + diff_filespec: drop funcname_pattern_ident field
 + diff_filespec: reorder dirty_submodule macro definitions

 Will merge to 'master'.


* cc/interpret-trailers (2014-01-21) 17 commits
 - DONOTMERGE: style issues, unused funcs, etc.
 - trailer: add tests for commands using env variables
 - trailer: set author and committer env variables
 - trailer: add tests for trailer command
 - trailer: execute command from 'trailer.<name>.command'
 - strbuf: add strbuf_replace()
 - trailer: add new_trailer_item() function
 - trailer: if no input file is passed, read from stdin
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from input file
 - strbuf: add strbuf_isspace()
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from file and arguments
 - Add data structures and basic functions for commit trailers


* dk/blame-janitorial (2014-01-22) 2 commits
 - Eliminate same_suspect function in builtin/blame.c
 - builtin/blame.c: struct blame_entry does not need a prev link


* jc/parse-options-humint (2014-01-22) 2 commits
 - repack: accept larger window-memory and max-pack-size
 - parse-options: refactor human-friendly-integer parser out of pack-ob=
jects

 "git repack --max-pack-size=3D8g" stopped being parsed correctly when
 the command was reimplemented in C.


* jk/mark-edges-uninteresting (2014-01-21) 2 commits
  (merged to 'next' on 2014-01-22 at d8807c4)
 + list-objects: only look at cmdline trees with edge_hint
 + t/perf: time rev-list with UNINTERESTING commits

 Fix to regression in v1.8.4.x and later.

 Will merge to 'master'.


* ks/diff-c-with-diff-order (2014-01-21) 4 commits
 - combine-diff: combine_diff_path.len is not needed anymore
 - combine-diff: Optimize combine_diff_path sets intersection
 - diff test: Add tests for combine-diff with orderfile
 - diffcore-order: Export generic ordering interface

 Teach combine-diff to honour the path-output-order imposed by
 diffcore-order.


* tr/gitk-doc-range-trace (2014-01-21) 1 commit
  (merged to 'next' on 2014-01-22 at 1d93d1d)
 + Documentation/gitk: document -L option

 Will merge to 'master'.


* tr/nth-previous-is-a-commit (2014-01-21) 1 commit
  (merged to 'next' on 2014-01-22 at 0425887)
 + Documentation: @{-N} can refer to a commit

 Will merge to 'master'.


* pw/git-p4 (2014-01-22) 11 commits
  (merged to 'next' on 2014-01-22 at 60489cd)
 + git p4 doc: use two-line style for options with multiple spellings
 + git p4 test: examine behavior with locked (+l) files
 + git p4: fix an error message when "p4 where" fails
 + git p4: handle files with wildcards when doing RCS scrubbing
 + git p4 test: do not pollute /tmp
 + git p4 test: run as user "author"
 + git p4 test: is_cli_file_writeable succeeds
 + git p4 test: explicitly check p4 wildcard delete
 + git p4: work around p4 bug that causes empty symlinks
 + git p4 test: ensure p4 symlink parsing works
 + git p4 test: wildcards are supported

 Various "git p4" updates.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting to give a chance to reroll.


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

* ab/subtree-doc (2014-01-13) 1 commit
  (merged to 'next' on 2014-01-22 at e352c75)
 + subtree: fix argument validation in add/pull/push

 Will merge to 'master'.


* jk/complete-merge-base (2014-01-13) 2 commits
  (merged to 'next' on 2014-01-22 at 91c428d)
 + completion: handle --[no-]fork-point options to git-rebase
 + completion: complete merge-base options

 Will merge to 'master'.


* po/everyday-doc (2014-01-13) 1 commit
 - Make 'git help everyday' work


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


* jc/maint-pull-docfix-for-409b8d82 (2014-01-14) 1 commit
 + Documentation: exclude irrelevant options from "git pull"
 (this branch is used by jc/maint-pull-docfix.)


* jc/maint-pull-docfix (2014-01-14) 2 commits
  (merged to 'next' on 2014-01-22 at 2e62ef4)
 + Documentation: "git pull" does not have the "-m" option
 + Merge branch 'jc/maint-pull-docfix-for-409b8d82' into jc/maint-pull-=
docfix
 (this branch uses jc/maint-pull-docfix-for-409b8d82.)

 Will merge to 'master'.


* jc/revision-range-unpeel (2014-01-15) 2 commits
  (merged to 'next' on 2014-01-22 at ab2a159)
 + revision: propagate flag bits from tags to pointees
 + revision: mark contents of an uninteresting tree uninteresting

 "git log --left-right A...B" lost the "leftness" of commits
 reachable from A when A is a tag as a side effect of a recent
 bugfix.  This is a regression in 1.8.4.x series.

 Will merge to 'master'.


* jk/allow-fetch-onelevel-refname (2014-01-15) 1 commit
  (merged to 'next' on 2014-01-22 at 15089b1)
 + fetch-pack: do not filter out one-level refs

 "git clone" would fail to clone from a repository that has a ref
 directly under "refs/", e.g. "refs/stash", because different
 validation paths do different things on such a refname.  Loosen the
 client side's validation to allow such a ref.

 Will merge to 'master'.


* jk/interpret-branch-name-fix (2014-01-15) 5 commits
  (merged to 'next' on 2014-01-22 at f113c68)
 + interpret_branch_name: find all possible @-marks
 + interpret_branch_name: avoid @{upstream} past colon
 + interpret_branch_name: always respect "namelen" parameter
 + interpret_branch_name: rename "cp" variable to "at"
 + interpret_branch_name: factor out upstream handling
 (this branch is used by jk/branch-at-publish-rebased.)

 Fix a handful of bugs around interpreting $branch@{upstream}
 notation and its lookalike, when $branch part has interesting
 characters, e.g. "@", and ":".

 Will merge to 'master'.


* mh/attr-macro-doc (2014-01-14) 1 commit
  (merged to 'next' on 2014-01-22 at e3ed767)
 + gitattributes: document more clearly where macros are allowed

 Will merge to 'master'.


* mh/retire-ref-fetch-rules (2014-01-14) 1 commit
  (merged to 'next' on 2014-01-22 at 753b1f6)
 + refname_match(): always use the rules in ref_rev_parse_rules

 Code simplification.

 Will merge to 'master'.


* wk/submodule-on-branch (2014-01-16) 6 commits
 - Documentation: Describe 'submodule update' modes in detail
 - t7406: Add explicit tests for head attachement after cloning updates
 - [DONOTMERGE] t7406: Just-cloned checkouts update to the gitlinked ha=
sh with 'reset'
 - submodule: Explicit local branch creation in module_clone
 - submodule: Document module_clone arguments in comments
 - submodule: Make 'checkout' update_module explicit

 Makes sure 'submodule update' modes that do not detach HEADs can
 be used more pleasantly by checking out a concrete branch when
 cloning them to prime the well.

 This round seems to be almost ready; further discussions are of
 course very much welcomed.

 Waiting for another reroll to fix minor nits, at least.


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


* ss/safe-create-leading-dir-with-slash (2014-01-22) 1 commit
  (merged to 'next' on 2014-01-22 at ca62c45)
 + safe_create_leading_directories(): on Windows, \ can separate path c=
omponents
 (this branch uses mh/safe-create-leading-directories.)

 "git clone $origin foo\bar\baz" on Windows failed to create the
 leading directories (i.e. a moral-equivalent of "mkdir -p").

 Will merge to 'master'.


* mh/safe-create-leading-directories (2014-01-21) 17 commits
  (merged to 'next' on 2014-01-22 at ad38e73)
 + rename_tmp_log(): on SCLD_VANISHED, retry
 + rename_tmp_log(): limit the number of remote_empty_directories() att=
empts
 + rename_tmp_log(): handle a possible mkdir/rmdir race
 + rename_ref(): extract function rename_tmp_log()
 + remove_dir_recurse(): handle disappearing files and directories
 + remove_dir_recurse(): tighten condition for removing unreadable dir
 + lock_ref_sha1_basic(): if locking fails with ENOENT, retry
 + lock_ref_sha1_basic(): on SCLD_VANISHED, retry
 + safe_create_leading_directories(): add new error value SCLD_VANISHED
 + cmd_init_db(): when creating directories, handle errors conservative=
ly
 + safe_create_leading_directories(): introduce enum for return values
 + safe_create_leading_directories(): always restore slash at end of lo=
op
 + safe_create_leading_directories(): split on first of multiple slashe=
s
 + safe_create_leading_directories(): rename local variable
 + safe_create_leading_directories(): add explicit "slash" pointer
 + safe_create_leading_directories(): reduce scope of local variable
 + safe_create_leading_directories(): fix format of "if" chaining
 (this branch is used by ss/safe-create-leading-dir-with-slash.)

 Code clean-up and protection against concurrent write access to the
 ref namespace.

 Will merge to 'master'.


* jk/pack-bitmap (2014-01-16) 22 commits
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

* jk/branch-at-publish (2014-01-13) 6 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . interpret_branch_name: factor out upstream handling
 . sha1_name: refactor upstream_mark

 Rebased to be jk/branch-at-publish-rebased to share the same change
 with the jk/interpret-branch-name-fix topic.


* jn/git-gui-chmod+x (2013-11-25) 1 commit
 . git-gui: chmod +x po2msg, windows/git-gui.sh

 Now in 'master' from the upstream git-gui repository.
