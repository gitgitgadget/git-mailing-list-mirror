From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 13:28:53 -0700
Message-ID: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 22:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URq1P-0007Oe-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab3DOU26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:28:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab3DOU24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15CB01518A;
	Mon, 15 Apr 2013 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	mitBHN2uGCczon+2fpzr0C4EqE=; b=GwLw3fcK96h0GqTX+7o/Aoou+XllscrcW
	aSyKo1TX4M/hIUwpJbbucW525VEmur26VXuGroTs61G3EWt+QQpJFBPE/Ii6RZjX
	lq5ZUH79z5rvJ6JwgicuLIQ8lO0Ni5jkGsfOqHFwlz3HHiqHioPZVAaGbiYn6IRT
	7Yjw2DdHJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mzh
	OvkbbEJqQKq64JMbPy1WFNXpDadfKbK0K+2CxqeOAy8MfcXY/EBkB0fWeo+2mFzQ
	Hb0GpTd6YjzQb5XhvivfQnmHyao6JHoTXAFsYpCkKL5jv+vOLuGb3Xyxx4ZmOG6W
	nqkY3jrQ+BA6HhYAb4NKMAjxGUu1W+FaGIzR9d3k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AFFE15189;
	Mon, 15 Apr 2013 20:28:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1F9115188; Mon, 15 Apr
 2013 20:28:54 +0000 (UTC)
X-master-at: aec3f77941205909f0671aa9767315a50e20ff87
X-next-at: 7fdada62084c4fa855f6cf269a638ff1faea5ba2
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17B88402-A60B-11E2-972E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221311>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/diff-algo-finishing-touches (2013-04-05) 2 commits
  (merged to 'next' on 2013-04-11 at af83b2b)
 + diff: allow unstuck arguments with --diff-algorithm
 + git-merge(1): document diff-algorithm option to merge-recursive

 "git diff --diff-algorithm algo" is also understood as "git diff
 --diff-algorithm=algo".


* jk/diff-graph-submodule-summary (2013-04-05) 1 commit
  (merged to 'next' on 2013-04-11 at 70dfa8d)
 + submodule: print graph output next to submodule log

 Make "git diff --graph" work better with submodule log output.


* jk/http-error-messages (2013-04-06) 9 commits
  (merged to 'next' on 2013-04-11 at 7a03981)
 + http: drop http_error function
 + remote-curl: die directly with http error messages
 + http: re-word http error message
 + http: simplify http_error helper function
 + remote-curl: consistently report repo url for http errors
 + remote-curl: always show friendlier 404 message
 + remote-curl: let servers override http 404 advice
 + remote-curl: show server content on http errors
 + http: add HTTP_KEEP_ERROR option

 Improve error reporting from the http transfer clients.


* jk/show-branch-strbuf (2013-04-06) 1 commit
  (merged to 'next' on 2013-04-11 at 7a20aa5)
 + show-branch: use strbuf instead of static buffer

 "git show-branch" was not prepared to show a very long run of
 ancestor operators e.g. foobar^2~2^2^2^2...^2~4 correctly.


* lf/bundle-with-tip-wo-message (2013-04-07) 1 commit
  (merged to 'next' on 2013-04-11 at bb9f869)
 + bundle: Accept prerequisites without commit messages

 "git bundle" did not like a bundle created using a commit without
 any message as its one of the prerequistes.


* po/help-guides (2013-04-03) 5 commits
  (merged to 'next' on 2013-04-04 at 3d99b28)
 + doc: include --guide option description for "git help"
 + help: mention -a and -g option, and 'git help <concept>' usage.
 + builtin/help.c: add list_common_guides_help() function
 + builtin/help.c: add --guide option
 + builtin/help.c: split "-a" processing into two

 "git help" learned "-g" option to show the list of guides just like
 list of commands are given with "-a".
 * po/help-guides (2013-04-12) 1 commit
 - help: mark common_guides[] as translatable

 Finishing touches.


* rt/commentchar-fmt-merge-msg (2013-04-07) 2 commits
  (merged to 'next' on 2013-04-11 at 6af638b)
 + fmt-merge-msg: use core.commentchar in tag signatures completely
 + fmt-merge-msg: respect core.commentchar in people credits

 The new core.commentchar configuration was not applied to a few
 places.


* tr/perl-keep-stderr-open (2013-04-04) 2 commits
  (merged to 'next' on 2013-04-07 at 04f737a)
 + t9700: do not close STDERR
 + perl: redirect stderr to /dev/null instead of closing

 Closing (not redirecting to /dev/null) the standard error stream is
 not a very smart thing to do.  Later open may return file
 descriptor #2 for unrelated purpose, and error reporting code may
 write into them.

--------------------------------------------------
[New Topics]

* kb/status-ignored-optim-2 (2013-04-15) 14 commits
 . dir.c: git-status --ignored: don't scan the work tree twice
 . dir.c: git-status --ignored: don't scan the work tree three times
 . dir.c: git-status: avoid is_excluded checks for tracked files
 . dir.c: replace is_path_excluded with now equivalent is_excluded API
 . dir.c: unify is_excluded and is_path_excluded APIs
 . dir.c: move prep_exclude
 . dir.c: factor out parts of last_exclude_matching for later reuse
 . dir.c: git-clean -d -X: don't delete tracked directories
 . dir.c: make 'git-status --ignored' work within leading directories
 . dir.c: git-status --ignored: don't list empty directories as ignored
 . dir.c: git-ls-files --directories: don't hide empty directories
 . dir.c: git-status --ignored: don't list empty ignored directories
 . dir.c: git-status --ignored: don't list files in ignored directories
 . dir.c: git-status --ignored: don't drop ignored directories

 Rerolls kb/status-ignored-optim topic (reverted from 'next').  Not
 merged to 'pu' as it heavily interferes with as/check-ignore topic.


* fc/branch-upstream-color (2013-04-15) 1 commit
  (merged to 'next' on 2013-04-15 at 2fc50fd)
 + branch: colour upstream branches

 Add more colors to "git branch -vv" output.

 Will merge to 'master'.


* jk/commit-info-slab (2013-04-13) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand

 Technology demonstration to show a way we could use unbound number
 of flag bits on commit objects.


* jk/test-trash (2013-04-14) 2 commits
  (merged to 'next' on 2013-04-15 at 15a6624)
 + t/test-lib.sh: drop "$test" variable
 + t/test-lib.sh: fix TRASH_DIRECTORY handling

 Fix longstanding issues with the test harness when used with --root=<there>
 option.


* lf/read-blob-data-from-index (2013-04-15) 3 commits
  (merged to 'next' on 2013-04-15 at 09f92c6)
 + convert.c: Remove duplicate code
 + Add size parameter to read_blob_data_from_index_path()
 + Add public function read_blob_data_from_index_path()

 Reduce duplicated code between convert.c and attr.c.

 Will merge to 'master'.


* mv/ssl-ftp-curl (2013-04-12) 1 commit
  (merged to 'next' on 2013-04-15 at 7fdada6)
 + Support FTP-over-SSL/TLS for regular FTP

 Does anybody really use commit walkers over ftp???

 Will merge to 'master'.


* as/check-ignore (2013-04-11) 5 commits
 - Documentation: add caveats about I/O buffering for check-{attr,ignore}
 - check-ignore: allow incremental streaming of queries via --stdin
 - check-ignore: move setup into cmd_check_ignore()
 - check-ignore: add -n / --non-matching option
 - t0008: remove duplicated test fixture data

 Enhance "check-ignore" (1.8.2 update) to work more like "check-attr"
 over bidi-pipes.


* mh/packed-refs-various (2013-04-15) 33 commits
 - refs: handle the main ref_cache specially
 - refs: change do_for_each_*() functions to take ref_cache arguments
 - pack_one_ref(): do some cheap tests before a more expensive one
 - pack_one_ref(): use write_packed_entry() to do the writing
 - pack_one_ref(): use function peel_entry()
 - refs: inline function do_not_prune()
 - pack_refs(): change to use do_for_each_entry()
 - refs: use same lock_file object for both ref-packing functions
 - pack_one_ref(): rename "path" parameter to "refname"
 - pack-refs: merge code from pack-refs.{c,h} into refs.{c,h}
 - pack-refs: rename handle_one_ref() to pack_one_ref()
 - refs: extract a function write_packed_entry()
 - repack_without_ref(): write peeled refs in the rewritten file
 - t3211: demonstrate loss of peeled refs if a packed ref is deleted
 - refs: change how packed refs are deleted
 - search_ref_dir(): return an index rather than a pointer
 - repack_without_ref(): silence errors for dangling packed refs
 - t3210: test for spurious error messages for dangling packed refs
 - refs: change the internal reference-iteration API
 - refs: extract a function peel_entry()
 - peel_ref(): fix return value for non-peelable, not-current reference
 - peel_object(): give more specific information in return value
 - refs: extract function peel_object()
 - refs: extract a function ref_resolves_to_object()
 - repack_without_ref(): use function get_packed_ref()
 - peel_ref(): use function get_packed_ref()
 - get_packed_ref(): return a ref_entry
 - do_for_each_ref_in_dirs(): remove dead code
 - refs: define constant PEELED_LINE_LENGTH
 - refs: document how current_ref is used
 - refs: document do_for_each_ref() and do_one_ref()
 - refs: document the fields of struct ref_value
 - refs: document flags constants REF_*

 Updates reading and updating packed-refs file, correcting corner
 case bugs.


* jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
 - transport-helper: add 'signed-tags' capability
 - transport-helper: pass --signed-tags=warn-strip to fast-export
 - fast-export: add --signed-tags=warn-strip mode

 Allows remote-helpers to declare they can handle signed tags, and
 issue a warning when using those that don't.

 Comments?


* jn/config-ignore-inaccessible (2013-04-15) 1 commit
 - config: allow inaccessible configuration under $HOME

 When $HOME is misconfigured to point at an unreadable directory, we
 used to complain and die. This loosens the check.

 I do not think we agreed that this is a good idea, though.


* jn/gitweb-install-doc (2013-04-15) 1 commit
 - gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM

 Reword gitweb configuration instrutions.

 Will merge to 'next'.


* jx/i18n-branch-error-messages (2013-04-15) 1 commit
 - i18n: branch: mark strings for translation

 Will merge to 'master'.


* nd/checkout-keep-sparse (2013-04-15) 1 commit
 - checkout: add --ignore-skip-worktree-bits in sparse checkout mode

 Make the initial "sparse" selection of the paths more sticky across
 "git checkout".

 Will merge to 'next'.


* ta/glossary (2013-04-15) 4 commits
 - glossary: improve definitions of refspec and pathspec
 - The name of the hash function is "SHA-1", not "SHA1"
 - glossary: improve description of SHA-1 related topics
 - glossary: remove outdated/misleading/irrelevant entries

 Will merge to 'next'.


* th/bisect-final-log (2013-04-15) 1 commit
 - bisect: Store first bad commit as comment in log file

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nd/pretty-formats (2013-04-01) 12 commits
 - pretty: support %>> that steal trailing spaces
 - pretty: support truncating in %>, %< and %><
 - pretty: support padding placeholders, %< %> and %><
 - pretty: add %C(auto) for auto-coloring on the next placeholder
 - pretty: two phase conversion for non utf-8 commits
 - utf8: keep NULs in reencode_string()
 - pretty: get the correct encoding for --pretty:format=%e
 - pretty: save commit encoding from logmsg_reencode if the caller needs it
 - utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 - utf8.c: move display_mode_esc_sequence_len() for use by other functions
 - pretty: share code between format_decoration and show_decorations
 - pretty-formats.txt: wrap long lines

 A mixed bag of a bugfix and two fun enhancements on pretty formats
 placeholder.

 Expecting a reroll.


* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

--------------------------------------------------
[Cooking]

* ap/strbuf-humanize (2013-04-10) 2 commits
  (merged to 'next' on 2013-04-14 at 66d7af5)
 + count-objects: add -H option to humanize sizes
 + strbuf: create strbuf_humanise_bytes() to show byte sizes

 Teach "--human-readable" aka "-H" option to "git count-objects" to
 show various large numbers in Ki/Mi/GiB scaled as necessary.

 I've decided to let this topic supersede mc/count-objects-kibibytes.
 Human users will get an even easier output with "-H" and by not
 changing the output without an explicit option we do not have to
 break third-party tools that may have been reading from the output
 of this command.


* as/clone-reference-with-gitfile (2013-04-09) 2 commits
  (merged to 'next' on 2013-04-15 at ab0d128)
 + clone: Allow repo using gitfile as a reference
 + clone: Fix error message for reference repository

 "git clone" did not work if a repository pointed at by the
 "--reference" option is a gitfile that points at another place.

 Waiting for comments.


* fc/transport-helper-error-reporting (2013-04-11) 3 commits
 - transport-helper: improve push messages
 - transport-helper: mention helper name when it dies
 - transport-helper: report errors properly

 Rerolled enough times.  In-code comments may want to be further
 extended to explain tricky parts, but seems to be ready otherwise.

 Will merge to 'next'.


* jk/doc-http-backend (2013-04-13) 3 commits
 - doc/http-backend: match query-string in apache half-auth example
 - doc/http-backend: give some lighttpd config examples
 - doc/http-backend: clarify "half-auth" repo configuration

 Improve documentation to illustrate "push authenticated, fetch
 anonymous" configuration for smart HTTP servers.

 Will merge to 'next'.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Waiting for a reroll after a review.


* jk/submodule-subdirectory-ok (2013-04-10) 2 commits
 - submodule: drop the top-level requirement
 - rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Waiting for comments.


* kb/co-orphan-suggestion-short-sha1 (2013-04-08) 1 commit
  (merged to 'next' on 2013-04-14 at 8caf7fd)
 + checkout: abbreviate hash in suggest_reattach

 Update the informational message when "git checkout" leaves the
 detached head state.

 Will merge to 'master'.


* mv/sequencer-pick-error-diag (2013-04-11) 1 commit
 - cherry-pick: make sure all input objects are commits

 "git cherry-pick $blob $tree" is diagnosed as a nonsense.

 Will merge to 'next'.


* rs/empty-archive (2013-04-10) 1 commit
  (merged to 'next' on 2013-04-15 at eab39bc)
 + t5004: fix issue with empty archive test and bsdtar

 Implementations of "tar" of BSD descend have found to have trouble
 with reading an otherwise empty tar archive with pax headers and
 causes an unnecessary test failure.

 Will merge to 'master'.


* th/t9903-symlinked-workdir (2013-04-11) 1 commit
  (merged to 'next' on 2013-04-15 at f062dc6)
 + t9903: Don't fail when run from path accessed through symlink

 Will merge to 'master'.


* fc/completion (2013-04-14) 8 commits
  (merged to 'next' on 2013-04-14 at a509746)
 + completion: small optimization
 + completion: inline __gitcomp_1 to its sole callsite
 + completion: get rid of compgen
 + completion: add __gitcomp_nl tests
 + completion: add new __gitcompadd helper
 + completion: get rid of empty COMPREPLY assignments
 + completion: trivial test improvement
 + completion: add more cherry-pick options

 Will merge to 'master'.


* jk/daemon-user-doc (2013-04-12) 1 commit
  (merged to 'next' on 2013-04-14 at 56c08ff)
 + doc: clarify that "git daemon --user=<user>" option does not export HOME=~user

 Will merge to 'master'.


* fc/send-email-annotate (2013-04-14) 7 commits
  (merged to 'next' on 2013-04-14 at 4af1076)
 + rebase-am: explicitly disable cover-letter
 + format-patch: trivial cleanups
 + format-patch: add format.coverLetter configuration variable
 + log: update to OPT_BOOL
 + format-patch: refactor branch name calculation
 + format-patch: improve head calculation for cover-letter
 + send-email: make annotate configurable

 Allows format-patch --cover-letter to be configurable; the most
 notable is the "auto" mode to create cover-letter only for multi
 patch series.

 Will merge to 'master'.


* fc/remote-hg (2013-04-11) 21 commits
 - remote-hg: activate graphlog extension for hg_log()
 - remote-hg: fix bad file paths
 - remote-hg: document location of stored hg repository
 - remote-hg: fix bad state issue
 - remote-hg: add 'insecure' option
 - remote-hg: add simple mail test
 - remote-hg: add basic author tests
 - remote-hg: show more proper errors
 - remote-hg: force remote push
 - remote-hg: push to the appropriate branch
 - remote-hg: update tags globally
 - remote-hg: update remote bookmarks
 - remote-hg: refactor export
 - remote-hg: split bookmark handling
 - remote-hg: redirect buggy mercurial output
 - remote-hg: trivial test cleanups
 - remote-hg: make sure fake bookmarks are updated
 - remote-hg: fix for files with spaces
 - remote-hg: properly report errors on bookmark pushes
 - remote-hg: add missing config variable in doc
 - remote-hg: trivial cleanups

 Rerolled.

 Waiting for comments.


* jk/http-dumb-namespaces (2013-04-09) 1 commit
  (merged to 'next' on 2013-04-15 at 4bfa834)
 + http-backend: respect GIT_NAMESPACE with dumb clients

 Allow smart-capable HTTP servers to be restricted via the
 GIT_NAMESPACE mechanism when talking with commit-walker clients
 (they already do so when talking with smart HTTP clients).

 Will merge to 'master'.


* jl/submodule-mv (2013-04-11) 4 commits
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will merge to 'next'.


* jc/detached-head-doc (2013-04-05) 1 commit
  (merged to 'next' on 2013-04-14 at 24b9271)
 + glossary: extend "detached HEAD" description

 Will merge to 'master'.


* jk/merge-tree-added-identically (2013-04-08) 1 commit
  (merged to 'next' on 2013-04-15 at 35fd4b9)
 + merge-tree: don't print entries that match "local"

 The resolution of some corner cases by "git merge-tree" were
 inconsistent between top-of-the-tree and in a subdirectory.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-03) 6 commits
 - git add: -u/-A now affects the entire working tree
  (merged to 'next' on 2013-04-05 at eae93ef)
 + add -A: only show pathless 'add -A' warning when changes exist outside cwd
 + add -u: only show pathless 'add -u' warning when changes exist outside cwd
 + add: make warn_pathless_add() a no-op after first call
 + add: add a blank line at the end of pathless 'add [-u|-A]' warning
 + add: make pathless 'add [-u|-A]' warning a file-global function

 "git add -u/-A" without any pathspec traditionally limited its
 operation to the current directory when run from a subdirectory,
 but in Git 2.0, they will affect the entire working tree.  Start
 training users to explicitly say "." or ":/" to smooth out the
 transition hump with the earlier parts of this series, and flip the
 default as the final step.

 Will merge to 'master' the early bits and cook the rest in 'next' until Git 2.0.


* tr/packed-object-info-wo-recursion (2013-03-27) 3 commits
  (merged to 'next' on 2013-03-29 at b1c3858)
 + sha1_file: remove recursion in unpack_entry
 + Refactor parts of in_delta_base_cache/cache_or_unpack_entry
 + sha1_file: remove recursion in packed_object_info

 Attempts to reduce the stack footprint of sha1_object_info()
 and unpack_entry() codepaths.

 Will merge to 'master'.


* nd/magic-pathspecs (2013-03-31) 45 commits
 . Rename field "raw" to "_raw" in struct pathspec
 . pathspec: support :(glob) syntax
 . pathspec: make --literal-pathspecs disable pathspec magic
 . pathspec: support :(literal) syntax for noglob pathspec
 . Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 . parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 . parse_pathspec: make sure the prefix part is wildcard-free
 . tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 . Remove match_pathspec() in favor of match_pathspec_depth()
 . Remove init_pathspec() in favor of parse_pathspec()
 . Remove diff_tree_{setup,release}_paths
 . Convert common_prefix() to use struct pathspec
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert run_add_interactive to use struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . reset: convert to use parse_pathspec
 . add: convert to use parse_pathspec
 . check-ignore: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Guard against new pathspec magic in pathspec matching code
 . parse_pathspec: support prefixing original patterns
 . parse_pathspec: support stripping/checking submodule paths
 . parse_pathspec: support stripping submodule trailing slashes
 . parse_pathspec: a special flag for max_depth feature
 . Convert some get_pathspec() calls to parse_pathspec()
 . parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 . parse_pathspec: save original pathspec for reporting
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: add copy_pathspec
 . pathspec: i18n-ize error strings in pathspec parsing code
 . Move struct pathspec and related functions to pathspec.[ch]
 . clean: remove unused variable "seen"
 . setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
  (merged to 'next' on 2013-04-05 at 199442e)
 + git add: start preparing for "git add <pathspec>..." to default to "-A"
 + builtin/add.c: simplify boolean variables

 In Git 2.0, "git add pathspec" will mean "git add -A pathspec".  If
 you did this in a working tree that tracks dir/lost and dir/another:

 $ rm dir/lost
 $ edit dir/another
 $ git add dir

 The last step will not only notices and records updated
 dir/another, but also notices and records the removal of dir/lost
 in the index.

 Start training the users for this change to say --no-all when they
 want to ignore the removal to smooth the transition hump.

 Will merge to 'master' the early bits and cook the rest in 'next' until Git 2.0.


* tr/line-log (2013-04-12) 11 commits
  (merged to 'next' on 2013-04-15 at 504559e)
 + log -L: improve comments in process_all_files()
 + log -L: store the path instead of a diff_filespec
 + log -L: test merge of parallel modify/rename
 + t4211: pass -M to 'git log -M -L...' test
  (merged to 'next' on 2013-04-05 at 5afb00c)
 + log -L: fix overlapping input ranges
 + log -L: check range set invariants when we look it up
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc


* jc/push-2.0-default-to-simple (2013-04-03) 13 commits
 - push: switch default from "matching" to "simple"
  (merged to 'next' on 2013-04-05 at 1b42c19)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Update the test suite that still assumed the push.default will
 forever be 'matching'.  In Git 2.0, that will no longer be the
 case.

 Will merge to 'master' the early bits and cook the rest in 'next' until Git 2.0.

--------------------------------------------------
[Discarded]

* fc/transport-helper-waitpid (2013-04-07) 3 commits
 . SQUASH???
 . transport-helper: check if remote helper is alive
 . [EXPLAIN BETTER] run-command: add new check_command helper

 fc/transport-helper-error-reporting supersedes this topic.


* jc/gg (2013-04-08) 3 commits
 . commit: add get_commit_encoding()
 . commit: rename parse_commit_date()
 . commit: shrink "indegree" field
 (this branch uses jc/decorate.)


* mc/count-objects-kibibytes (2013-04-14) 2 commits
  (merged to 'next' on 2013-04-14 at ff03f2b)
 + Revert "count-objects: output "KiB" instead of "kilobytes""
  (merged to 'next' on 2013-04-05 at f4e50e8)
 + count-objects: output "KiB" instead of "kilobytes"

 The command reports the total diskspace used to store loose objects
 in kibibytes, but it was labelled as "kilobytes".  The number now
 is shown with "KiB", e.g. "6750 objects, 50928 KiB".

 If you have scripts that decide when to run "git repack" by parsing
 the output from "git count-objects", this release may break them.
 Sorry about that.  One of the scripts shipped by git-core itself
 also had to be adjusted.  You may want to consider updating such
 scripts to always call "git gc --auto" to let it decide when to
 repack for you.

 Discarded.


* jc/decorate (2013-04-07) 2 commits
 - decorate: add "clear_decoration()"
 - decorate: document API
 (this branch is used by jc/gg.)

 Discarded.


* kb/status-ignored-optim (2013-03-19) 8 commits
  (merged to 'next' on 2013-04-01 at 0c12ed9)
 + dir.c: git-status: avoid is_excluded checks for tracked files
 + dir.c: replace is_path_excluded with now equivalent is_excluded API
 + dir.c: unify is_excluded and is_path_excluded APIs
 + dir.c: move prep_exclude and factor out parts of last_exclude_matching
 + dir.c: git-status --ignored: don't list empty directories as ignored
 + dir.c: git-status --ignored: don't list empty ignored directories
 + dir.c: git-status --ignored: don't list files in ignored directories
 + dir.c: git-status --ignored: don't drop ignored directories

 "git status --ignored" had many corner case bugs.  Also the command
 has been optimized by taking advantage of the fact that paths that
 are already known to the index do not have to be checked against
 the .gitignore mechanism most of the time.

 Discarded.
