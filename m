From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2013, #03; Tue, 13)
Date: Tue, 13 Aug 2013 15:06:49 -0700
Message-ID: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 00:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Mjz-000387-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 00:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758487Ab3HMWGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 18:06:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab3HMWGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 18:06:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDD0383D5;
	Tue, 13 Aug 2013 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	QX4vVxkE0rGOETGEar6RX5wha8=; b=A8RMMYcsIHKrl9UT5Gj+4eqYUbe7QGVeA
	qPMiUPrc1au77oC5AI16O64CBvy5isRhVNQP1hAKHXdGzbvu1s2eD1/P9+fqCTsZ
	z6FOBFT8bhAcxAf9WQNjU3jf7vfOsUHTe0dO7n+pXGj5p6PyVXW670pJq0EIQ3LD
	mWnM7oVMh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Pgz
	jup09h7eRjDG24tBG6UCjixSCdWvQ1hm1sspMMw2cGYgzoP7x4zcKkiaEbHB7Otk
	g3WaNKh2WO5ndqwOkqhpCEzCMopOdFq+gjK81QyBGPM0YXtyptksDYpVtPq3tZyb
	vEo/YA+MpCPWdNydLK2ObS0dHRH5pyw10aU1owGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E606383D4;
	Tue, 13 Aug 2013 22:06:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 983D2383CE;
	Tue, 13 Aug 2013 22:06:50 +0000 (UTC)
X-master-at: 425df881e08bed7a8fcc9a23f452cff792f9ec6c
X-next-at: 80e72f1fb22b04aabd28f14eb96d1beb23e37b9d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7998794-0464-11E3-B4CD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232253>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The -rc3 has been tagged; we will need to revert a7365313 (git
stash: avoid data loss when "git stash save" kills a directory,
2013-06-28) that is killing "git stash" in repositories with too
many untracked cruft before the final, with a plan to reapply it
after trying to whip "ls-files --killed" into a reasonable
performer, which needs to happen after the final.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* sb/mailmap-updates (2013-08-12) 1 commit
 + .mailmap: update long-lost friends with multiple defunct addresses

--------------------------------------------------
[New Topics]

* es/blame-L-twice (2013-08-06) 16 commits
  (merged to 'next' on 2013-08-08 at 9d6f821)
 + line-range: reject -L line numbers less than 1
 + t8001/t8002: blame: add tests of -L line numbers less than 1
 + line-range: teach -L^:RE to search from start of file
 + line-range: teach -L:RE to search from end of previous -L range
 + line-range: teach -L^/RE/ to search from start of file
 + line-range-format.txt: document -L/RE/ relative search
 + log: teach -L/RE/ to search from end of previous -L range
 + blame: teach -L/RE/ to search from end of previous -L range
 + line-range: teach -L/RE/ to search relative to anchor point
 + blame: document multiple -L support
 + t8001/t8002: blame: add tests of multiple -L options
 + blame: accept multiple -L ranges
 + blame: inline one-line function into its lone caller
 + range-set: publish API for re-use by git-blame -L
 + line-range-format.txt: clarify -L:regex usage form
 + git-log.txt: place each -L option variation on its own line
 (this branch is used by es/contacts-blame-L-multi; uses es/blame-L-more.)

 Teaches "git blame" to take more than one -L ranges.

 Will cook in 'next'.


* mm/no-shell-escape-in-die-message (2013-08-07) 1 commit
  (merged to 'next' on 2013-08-08 at bddff86)
 + die_with_status: use "printf '%s\n'", not "echo"

 Fixes a minor bug in "git rebase -i" (there could be others, as the
 root cause is pretty generic) where the code feeds a random, data
 dependeant string to 'echo' and expects it to come out literally.

 Will cook in 'next'.


* tr/fd-gotcha-fixes (2013-08-06) 1 commit
  (merged to 'next' on 2013-08-08 at f452c5b)
 + t0070: test that git_mkstemps correctly checks return value of open()

 Finishing touches to an earlier fix already in 'master'.

 Will cook in 'next'.


* ap/remote-hg-tilde-is-home-directory (2013-08-09) 1 commit
 - remote-hg: fix path when cloning with tilde expansion

 Will merge to and cook in 'next'.


* es/rebase-i-no-abbrev (2013-08-11) 3 commits
 - rebase: interactive: fix short SHA-1 collision
 - t3404: rebase: interactive: demonstrate short SHA-1 collision
 - t3404: restore specialized rebase-editor following commentchar test

 Will merge to and cook in 'next'.


* fc/remote-hg-shared-setup (2013-08-11) 2 commits
 - remote-hg: add shared repo upgrade
 - remote-hg: ensure shared repo is initialized

 Will merge to and cook in 'next'.


* jc/transport-do-not-use-connect-twice-in-fetch (2013-08-07) 5 commits
 - fetch: work around "transport-take-over" hack
 - fetch: refactor code that fetches leftover tags
 - fetch: refactor code that prepares a transport
 - fetch: rename file-scope global "transport" to "gtransport"
 - t5802: add test for connect helper

 The auto-tag-following code in "git fetch" tries to reuse the same
 transport twice when the serving end does not cooperate and does
 not give tags that point to commits that are asked for as part of
 the primary transfer.  Unfortunately, Git-aware transport helper
 interface is not designed to be used more than once, hence this
 does not work over smart-http transfer.

 I'll try to see if this workaround can be done in a cleaner way
 before merging this to 'next'.


* ks/p4-view-spec (2013-08-11) 3 commits
 - WAITING FOR ACK
 - git p4: implement view spec wildcards with "p4 where"
 - git p4 test: sanitize P4CHARSET

 Waiting for an ack.


* mm/war-on-whatchanged (2013-08-13) 2 commits
 - whatchanged: document its historical nature
 - core-tutorial: trim the section on Inspecting Changes

 Will merge to and cook in 'next'.


* nd/gc-lock-against-each-other (2013-08-09) 1 commit
 - gc: reject if another gc is running, unless --force is given

 Will merge to and cook in 'next'.


* rt/doc-merge-file-diff3 (2013-08-09) 1 commit
 - Documentation/git-merge-file: document option "--diff3"

 Will merge to and cook in 'next'.


* sb/misc-cleanup (2013-08-09) 3 commits
 - rm: remove unneeded null pointer check
 - diff: fix a possible null pointer dereference
 - diff: remove ternary operator evaluating always to true

 Will merge to and cook in 'next'.


* aj/p4-symlink-lose-nl (2013-08-12) 1 commit
 - git-p4: Fix occasional truncation of symlink contents.

 Will merge to and cook in 'next'.


* es/contacts-blame-L-multi (2013-08-13) 3 commits
 - contacts: reduce git-blame invocations
 - contacts: gather all blame sources prior to invoking git-blame
 - contacts: validate hunk length earlier
 (this branch uses es/blame-L-more and es/blame-L-twice.)

 Will merge to and cook in 'next'.


* fc/unpack-trees-leakfix (2013-08-13) 1 commit
 - unpack-trees: plug a memory leak

 Will merge to and cook in 'next'.


* nd/push-no-thin (2013-08-13) 1 commit
 - push: respect --no-thin

 Will merge to and cook in 'next'.


* sh/pull-rebase-preserve (2013-08-13) 1 commit
 - pull: Allow pull to preserve merges when rebasing.

 Will merge to and cook in 'next'.

--------------------------------------------------
[Stalled]

* tf/gitweb-ss-tweak (2013-07-15) 4 commits
 - gitweb: make search help link less ugly
 - gitweb: omit the repository owner when it is unset
 - gitweb: vertically centre contents of page footer
 - gitweb: ensure OPML text fits inside its box

 Comments?


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


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

* es/blame-L-more (2013-08-05) 11 commits
  (merged to 'next' on 2013-08-06 at 2679f3e)
 + blame: reject empty ranges -L,+0 and -L,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -L,+0 and -L,-0
 + blame: reject empty ranges -LX,+0 and -LX,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -LX,+0 and -LX,-0
 + log: fix -L bounds checking bug
 + t4211: retire soon-to-be unimplementable tests
 + t4211: log: demonstrate -L bounds checking bug
 + blame: fix -L bounds checking bug
 + t8001/t8002: blame: add empty file & partial-line tests
 + t8001/t8002: blame: demonstrate -L bounds checking bug
 + t8001/t8002: blame: decompose overly-large test
 (this branch is used by es/blame-L-twice and es/contacts-blame-L-multi.)

 More fixes to the code to parse the "-L" option in "log" and "blame".

 Will cook in 'next'.


* jk/cat-file-batch-optim (2013-08-05) 1 commit
  (merged to 'next' on 2013-08-06 at cd48621)
 + cat-file: only split on whitespace when %(rest) is used

 Rework the reverted change to `cat-file --batch-check`.

 Will cook in 'next'.


* jn/post-receive-utf8 (2013-08-05) 3 commits
 - hooks/post-receive-email: set declared encoding to utf-8
 - hooks/post-receive-email: force log messages in UTF-8
 - hooks/post-receive-email: use plumbing instead of git log/show

 Update post-receive-email script to make sure the message contents
 and pathnames are encoded consistently in UTF-8.

 I have a feeling that it is a lost cause to solve the issue the
 topic tries to address in general, because the patch text can have
 payload in any encodings that are different from either the
 pathnames or the log message.  Patches that touch paths that use an
 encoding that conflicts with the encoding of the payload and/or the
 log message could be transferred with core.quotepath set and patch
 generated as all binary, but that would be pretty much useless.


* sb/parseopt-boolean-removal (2013-08-07) 9 commits
  (merged to 'next' on 2013-08-08 at b138a2d)
 + revert: use the OPT_CMDMODE for parsing, reducing code
 + checkout-index: fix negations of even numbers of -n
 + config parsing options: allow one flag multiple times
 + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
 + branch, commit, name-rev: ease up boolean conditions
 + checkout: remove superfluous local variable
 + log, format-patch: parsing uses OPT__QUIET
 + Replace deprecated OPT_BOOLEAN by OPT_BOOL
 + Remove deprecated OPTION_BOOLEAN for parsing arguments
 (this branch uses jc/parseopt-command-modes.)

 Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
 OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
 remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary;
 there seems to be some misconversion that makes many tests fail,
 though.

 Will cook in 'next'.


* mb/docs-favor-en-us (2013-08-01) 1 commit
  (merged to 'next' on 2013-08-06 at 763d868)
 + Provide some linguistic guidance for the documentation.

 Declare that the official grammar & spelling of the source of this
 project is en_US, but strongly discourage patches only to "fix"
 existing en_UK strings to avoid unnecessary churns.

 Will cook in 'next'.


* jc/parseopt-command-modes (2013-07-30) 2 commits
  (merged to 'next' on 2013-08-08 at 43abba9)
 + tag: use OPT_CMDMODE
 + parse-options: add OPT_CMDMODE()
 (this branch is used by sb/parseopt-boolean-removal.)

 Many commands use --dashed-option as a operation mode selector
 (e.g. "git tag --delete") that the user can use at most one
 (e.g. "git tag --delete --verify" is a nonsense) and you cannot
 negate (e.g. "git tag --no-delete" is a nonsense).  Make it easier
 for users of parse_options() to enforce these restrictions.

 Will cook in 'next'.


* tr/log-full-diff-keep-true-parents (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-08 at 2fb633f)
 + log: use true parents for diff when walking reflogs
 + log: use true parents for diff even when rewriting

 Output from "git log --full-diff -- <pathspec>" looked strange,
 because comparison was done with the previous ancestor that touched
 the specified <pathspec>, causing the patches for paths outside the
 pathspec to show more than the single commit has changed.

 Tweak "git reflog -p" for the same reason using the same mechanism.

 Will cook in 'next'.


* bc/unuse-packfile (2013-08-02) 2 commits
  (merged to 'next' on 2013-08-06 at 01aa4fd)
 + Don't close pack fd when free'ing pack windows
 + sha1_file: introduce close_one_pack() to close packs on fd pressure

 Handle memory pressure and file descriptor pressure separately when
 deciding to release pack windows to honor resource limits.

 Will cook in 'next'.


* da/darwin (2013-08-05) 3 commits
  (merged to 'next' on 2013-08-05 at 5c54cfa)
 + OS X: Fix redeclaration of die warning
 + Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
  (merged to 'next' on 2013-08-01 at d151a94)
 + imap-send: use Apple's Security framework for base64 encoding

 Will cook in 'next'.


* nd/sq-quote-buf (2013-07-30) 3 commits
  (merged to 'next' on 2013-08-01 at dc7934a)
 + quote: remove sq_quote_print()
 + tar-tree: remove dependency on sq_quote_print()
 + for-each-ref, quote: convert *_quote_print -> *_quote_buf

 Code simplification as a preparatory step to something larger.

 Will cook in 'next'.


* jc/url-match (2013-08-09) 7 commits
  (merged to 'next' on 2013-08-12 at 381d358)
 + builtin/config.c: compilation fix
  (merged to 'next' on 2013-08-08 at c1ee470)
 + config: "git config --get-urlmatch" parses section.<url>.key
 + builtin/config: refactor collect_config()
 + config: parse http.<url>.<variable> using urlmatch
 + config: add generic callback wrapper to parse section.<url>.key
 + config: add helper to normalize and match URLs
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Allow section.<urlpattern>.var configuration variables to be
 treated as a "virtual" section.var given a URL, and use the
 mechanism to enhance http.* configuration variables.

 This is a reroll of Kyle J. McKay's work.

 Will cook in 'next'.


* jl/submodule-mv (2013-08-06) 5 commits
  (merged to 'next' on 2013-08-08 at 1a57bdf)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + mv: update the path entry in .gitmodules for moved submodules
 + submodule.c: add .gitmodules staging helper functions
 + mv: move submodules using a gitfile
 + mv: move submodules together with their work trees
 (this branch uses nd/magic-pathspec.)

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will cook in 'next'.


* nd/clone-connectivity-shortcut (2013-07-23) 1 commit
  (merged to 'next' on 2013-07-30 at 8d16721)
 + smart http: use the same connectivity check on cloning

 Will cook in 'next'.


* db/http-savecookies (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-05 at be6f3a3)
 + t5551: Remove header from curl cookie file
  (merged to 'next' on 2013-07-30 at d2ad6e5)
 + http: add http.savecookies option to write out HTTP cookies

 Will cook in 'next'.


* sb/fsck-opt-bool (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 8a9964c)
 + fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL

 Will cook in 'next'.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 72c9bcb)
 + editor: use canonicalized absolute path

 Will cook in 'next'.


* rj/doc-rev-parse (2013-07-22) 2 commits
  (merged to 'next' on 2013-07-22 at 8188667)
 + rev-parse(1): logically group options
 + rev-parse: remove restrictions on some options

 Will cook in 'next'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-07-22 at d26dab6)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Will cook in 'next'.


* jc/diff-filter-negation (2013-07-19) 6 commits
  (merged to 'next' on 2013-07-22 at 80d167d)
 + diff: deprecate -q option to diff-files
 + diff: allow lowercase letter to specify what change class to exclude
 + diff: reject unknown change class given to --diff-filter
 + diff: preparse --diff-filter string argument
 + diff: factor out match_filter()
 + diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".

 Will cook in 'next'.


* nd/magic-pathspec (2013-07-23) 48 commits
  (merged to 'next' on 2013-07-23 at 784c3a1)
 + rm: do not set a variable twice without intermediate reading.
  (merged to 'next' on 2013-07-22 at 39f7194)
 + t6131 - skip tests if on case-insensitive file system
 + parse_pathspec: accept :(icase)path syntax
 + pathspec: support :(glob) syntax
 + pathspec: make --literal-pathspecs disable pathspec magic
 + pathspec: support :(literal) syntax for noglob pathspec
 + kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 + parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 + parse_pathspec: make sure the prefix part is wildcard-free
 + rename field "raw" to "_raw" in struct pathspec
 + tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 + remove match_pathspec() in favor of match_pathspec_depth()
 + remove init_pathspec() in favor of parse_pathspec()
 + remove diff_tree_{setup,release}_paths
 + convert common_prefix() to use struct pathspec
 + convert add_files_to_cache to take struct pathspec
 + convert {read,fill}_directory to take struct pathspec
 + convert refresh_index to take struct pathspec
 + convert report_path_error to take struct pathspec
 + checkout: convert read_tree_some to take struct pathspec
 + convert unmerge_cache to take struct pathspec
 + convert run_add_interactive to use struct pathspec
 + convert read_cache_preload() to take struct pathspec
 + line-log: convert to use parse_pathspec
 + reset: convert to use parse_pathspec
 + add: convert to use parse_pathspec
 + check-ignore: convert to use parse_pathspec
 + archive: convert to use parse_pathspec
 + ls-files: convert to use parse_pathspec
 + rm: convert to use parse_pathspec
 + checkout: convert to use parse_pathspec
 + rerere: convert to use parse_pathspec
 + status: convert to use parse_pathspec
 + commit: convert to use parse_pathspec
 + clean: convert to use parse_pathspec
 + guard against new pathspec magic in pathspec matching code
 + parse_pathspec: support prefixing original patterns
 + parse_pathspec: support stripping/checking submodule paths
 + parse_pathspec: support stripping submodule trailing slashes
 + parse_pathspec: add special flag for max_depth feature
 + convert some get_pathspec() calls to parse_pathspec()
 + parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 + parse_pathspec: save original pathspec for reporting
 + add parse_pathspec() that converts cmdline args to struct pathspec
 + pathspec: add copy_pathspec
 + pathspec: i18n-ize error strings in pathspec parsing code
 + move struct pathspec and related functions to pathspec.[ch]
 + clean: remove unused variable "seen"
 (this branch is used by jl/submodule-mv.)

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).

 Will cook in 'next'.


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-07-15 at 62751bc)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  I am tempted to
 merge this to and keep it in 'next' for a while to see if anybody
 screams before deciding if we want to do anything to help existing
 users (there may be none).

 Will cook in 'next'.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-21 at 7ffb690)
 + fetch: make --prune configurable

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 "git fetch" that honors remote.*.prune is fine, but I wonder if we
 should somehow make "git push" aware of it as well.  Perhaps
 remote.*.prune should not be just a boolean, but a 4-way "none",
 "push", "fetch", "both"?

 Will cook in 'next'.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-07-19 at ab8d034)
 + Git.pm: revert _temp_cache use of temp_is_locked
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will cook in 'next'.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/push-cas (2013-08-02) 9 commits
  (merged to 'next' on 2013-08-05 at 34f4cf3)
 + push: teach --force-with-lease to smart-http transport
 + send-pack: fix parsing of --force-with-lease option
  (merged to 'next' on 2013-08-01 at a7604ee)
 + t5540/5541: smart-http does not support "--force-with-lease"
  (merged to 'next' on 2013-07-23 at 72371b0)
 + t5533: test "push --force-with-lease"
 + push --force-with-lease: tie it all together
 + push --force-with-lease: implement logic to populate old_sha1_expect[]
 + remote.c: add command line option parser for "--force-with-lease"
 + builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 + cache.h: move remote/connect API out of it

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 The logic to choose the default implemented here is fragile
 (e.g. "git fetch" after seeing a failure will update the
 remote-tracking branch and will make the next "push" pass,
 defeating the safety pretty easily).  It is suitable only for the
 simplest workflows, and it may hurt users more than it helps them.

 Will cook in 'next'.


* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-22 at 748180e)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 See

 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229221

 for full discussion.

 Will cook in 'next'.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future
 (this branch uses jc/diff-filter-negation.)

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jh/remote-hg-fetch-fix (2013-07-25) 2 commits
  (merged to 'next' on 2013-07-25 at 33161ad)
 + Revert "remotes-hg: bugfix for fetching non local remotes"
  (merged to 'next' on 2013-07-24 at 9c96641)
 + remotes-hg: bugfix for fetching non local remotes

 Reverted.

 Waiting for the final patch to replace, after discussion settles.


* km/http-curl-config-per-url (2013-07-31) 7 commits
  (merged to 'next' on 2013-07-31 at e88aad5)
 + Revert km/http-curl-config-per-url in its entirety
  (merged to 'next' on 2013-07-25 at 531e8cb)
 + docs: update http.<url>.* options documentation
  (merged to 'next' on 2013-07-23 at f84689b)
 + config: allow http.<url>.* any user matching
 + tests: add new test for the url_normalize function
 + config: improve support for http.<url>.* settings
 + config: add support for http.<url>.* settings
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Reverted to be replaced with a reroll (jc/url-match topic).
