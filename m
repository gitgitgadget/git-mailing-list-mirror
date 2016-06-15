From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2013, #07; Mon, 22)
Date: Mon, 22 Apr 2013 13:07:03 -0700
Message-ID: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 22:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUN1D-00079w-Ij
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab3DVUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:07:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755217Ab3DVUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 16:07:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39CEB1876E;
	Mon, 22 Apr 2013 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	UB5cm8ItyBbycST+EHhNIFmEL0=; b=TpVBzMRrSsonT1a5skvl4W7Dl06jlhBmM
	FahlzHhYHcg0rwX881eGkZVUAGt/EXY/PJrsoj/w2D6fM0jgxIQycsrVtrTfRZUc
	VTIgMoqOVrysE6/DGN3iHyKREfjWRWQoIs/OkdAYM/vX+ffNw653WOtZquA65zFm
	Gn7qgod7bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=j3n
	s9E1tJNmuua0yVvooU2wvFxhU0gF8/xjtM3x76N0gh95rNak2KF8TZ20K0n6nttC
	VaIRP9OtcBMXnK23sIIIQ7MPMiVFrXLT6ZGENAFEHeHaJFGQuH91CYsSK62F0sUW
	1xk8ecQFL+wrGxl3kDFG9HsC3NJp0k0sJwtkHWNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E951876D;
	Mon, 22 Apr 2013 20:07:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB22118766;
	Mon, 22 Apr 2013 20:07:04 +0000 (UTC)
X-master-at: 118f60ee06612083ff4f1810424e80a3e896f73e
X-next-at: 46dda50f1b80376d17129b9546d08f602af44864
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33EEB100-AB88-11E2-ABE3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222085>

What's cooking in git.git (Apr 2013, #07; Mon, 22)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Both of the two topics on preparing "git add" users for the
behaviour change in Git 2.0 are in 'master'.  We may want to tweak
the wording of warning messages and such before the feature freeze.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

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


* fc/branch-upstream-color (2013-04-15) 1 commit
  (merged to 'next' on 2013-04-15 at 2fc50fd)
 + branch: colour upstream branches

 Add more colors to "git branch -vv" output.


* fc/remote-hg (2013-04-11) 21 commits
  (merged to 'next' on 2013-04-16 at cbeaf41)
 + remote-hg: activate graphlog extension for hg_log()
 + remote-hg: fix bad file paths
 + remote-hg: document location of stored hg repository
 + remote-hg: fix bad state issue
 + remote-hg: add 'insecure' option
 + remote-hg: add simple mail test
 + remote-hg: add basic author tests
 + remote-hg: show more proper errors
 + remote-hg: force remote push
 + remote-hg: push to the appropriate branch
 + remote-hg: update tags globally
 + remote-hg: update remote bookmarks
 + remote-hg: refactor export
 + remote-hg: split bookmark handling
 + remote-hg: redirect buggy mercurial output
 + remote-hg: trivial test cleanups
 + remote-hg: make sure fake bookmarks are updated
 + remote-hg: fix for files with spaces
 + remote-hg: properly report errors on bookmark pushes
 + remote-hg: add missing config variable in doc
 + remote-hg: trivial cleanups

 Updates remote-hg helper (in contrib/).


* jk/a-thread-only-dies-once (2013-04-16) 2 commits
  (merged to 'next' on 2013-04-18 at 3208f44)
 + run-command: use thread-aware die_is_recursing routine
 + usage: allow pluggable die-recursion checks

 A regression fix for the logic to detect die() handler triggering
 itself recursively.


* jk/chopped-ident (2013-04-17) 3 commits
  (merged to 'next' on 2013-04-19 at ecec2d4)
 + blame: handle broken commit headers gracefully
 + pretty: handle broken commit headers gracefully
 + cat-file: print tags raw for "cat-file -p"

 A commit object whose author or committer ident are malformed
 crashed some code that trusted that a name, an email and an
 timestamp can always be found in it.


* jk/doc-http-backend (2013-04-13) 3 commits
  (merged to 'next' on 2013-04-19 at 7932840)
 + doc/http-backend: match query-string in apache half-auth example
 + doc/http-backend: give some lighttpd config examples
 + doc/http-backend: clarify "half-auth" repo configuration

 Improve documentation to illustrate "push authenticated, fetch
 anonymous" configuration for smart HTTP servers.


* jx/i18n-branch-error-messages (2013-04-15) 1 commit
  (merged to 'next' on 2013-04-18 at 630c211)
 + i18n: branch: mark strings for translation


* lf/read-blob-data-from-index (2013-04-17) 3 commits
  (merged to 'next' on 2013-04-17 at 611208f)
 + convert.c: remove duplicate code
 + read_blob_data_from_index(): optionally return the size of blob data
 + attr.c: extract read_index_data() as read_blob_data_from_index()

 Reduce duplicated code between convert.c and attr.c.


* mv/sequencer-pick-error-diag (2013-04-11) 1 commit
  (merged to 'next' on 2013-04-16 at a2da926)
 + cherry-pick: make sure all input objects are commits

 "git cherry-pick $blob $tree" is diagnosed as a nonsense.


* mv/ssl-ftp-curl (2013-04-12) 1 commit
  (merged to 'next' on 2013-04-15 at 7fdada6)
 + Support FTP-over-SSL/TLS for regular FTP

 Does anybody really use commit walkers over ftp???


* nd/checkout-keep-sparse (2013-04-15) 1 commit
  (merged to 'next' on 2013-04-19 at 803dabc)
 + checkout: add --ignore-skip-worktree-bits in sparse checkout mode

 Make the initial "sparse" selection of the paths more sticky across
 "git checkout".


* rt/commentchar-fmt-merge-msg (2013-04-18) 1 commit
  (merged to 'next' on 2013-04-18 at 96799bd)
 + t6200: avoid path mangling issue on Windows

 A test fix for recent update.


* ta/glossary (2013-04-15) 4 commits
  (merged to 'next' on 2013-04-19 at 63ee8a4)
 + glossary: improve definitions of refspec and pathspec
 + The name of the hash function is "SHA-1", not "SHA1"
 + glossary: improve description of SHA-1 related topics
 + glossary: remove outdated/misleading/irrelevant entries


* th/bisect-final-log (2013-04-15) 1 commit
  (merged to 'next' on 2013-04-19 at 89d2041)
 + bisect: Store first bad commit as comment in log file

 Leave a commit to note what the final outcome was in the bisect log
 file.

* tr/copy-revisions-from-stdin (2013-04-16) 1 commit
  (merged to 'next' on 2013-04-16 at d882870)
 + read_revisions_from_stdin: make copies for handle_revision_arg

 A fix to a long-standing issue in the command line parser for
 revisions, which was triggered by mv/sequence-pick-error-diag topic.

--------------------------------------------------
[New Topics]

* jh/checkout-auto-tracking (2013-04-21) 8 commits
  (merged to 'next' on 2013-04-22 at 2356700)
 + glossary: Update and rephrase the definition of a remote-tracking branch
 + branch.c: Validate tracking branches with refspecs instead of refs/remotes/*
 + t9114.2: Don't use --track option against "svn-remote"-tracking branches
 + t7201.24: Add refspec to keep --track working
 + t3200.39: tracking setup should fail if there is no matching refspec.
 + checkout: Use remote refspecs when DWIMming tracking branches
 + t2024: Show failure to use refspec when DWIMming remote branch names
 + t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'

 Updates "git checkout foo" that DWIMs the intended "upstream" and
 turns it into "git checkout -t -b foo remotes/origin/foo" to
 correctly take existing remote definitions into account.  The
 remote "origin" may be what uniquely map its own branch to
 remotes/some/where/foo but that some/where may not be "origin".

 Will cook in 'next'.


* mg/more-textconv (2013-04-19) 6 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - t4030: demonstrate behavior of show with textconv

 Will be rerolled.


* jk/receive-pack-deadlocks-with-early-failure (2013-04-19) 1 commit
  (merged to 'next' on 2013-04-22 at 1e27177)
 + receive-pack: close sideband fd on early pack errors

 When receive-pack detects error in the pack header it received in
 order to decide which of unpack-objects or index-pack to run, it
 returned without closing the error stream, which led to a hang
 sideband thread.

 Will fast-track to 'master'.


* fc/untracked-zsh-prompt (2013-04-21) 1 commit
  (merged to 'next' on 2013-04-22 at 472da3e)
 + prompt: fix untracked files for zsh

 Will fast-track to 'master'.


* jn/glossary-revision (2013-04-21) 1 commit
 - glossary: a revision is just a commit

 The wording for "revision" in the glossary wanted to say it refers
 to "commit (noun) as a concept" but it was badly phrased.

 Will cook in 'next'.

 This may need further updates to hint that in contexts where it is
 clear, the word may refer to an object name, not necessarily a
 commit.


* rr/shortlog-doc (2013-04-22) 8 commits
 - builtin/shortlog.c: make usage string consistent with log
 - builtin/log.c: make usage string consistent with doc
 - git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
 - git-log.txt: rewrite note on why "--" may be required
 - git-log.txt: generalize <since>..<until>
 - git-log.txt: order OPTIONS properly; move <since>..<until>
 - revisions.txt: clarify the .. and ... syntax
 - git-shortlog.txt: remove (-h|--help) from OPTIONS

 Update documentation for "log" and "shortlog".

 Looked reasonable.
 Will merge to 'next'.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for comments.

--------------------------------------------------
[Stalled]

* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Waiting for a reroll after a review.


* jk/commit-info-slab (2013-04-19) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand

 Technology demonstration to show a way we could use unbound number
 of flag bits on commit objects.


* jn/config-ignore-inaccessible (2013-04-15) 1 commit
 - config: allow inaccessible configuration under $HOME

 When $HOME is misconfigured to point at an unreadable directory, we
 used to complain and die. This loosens the check.

 I do not think we agreed that this is a good idea, though.

--------------------------------------------------
[Cooking]

* jc/prune-all (2013-04-18) 3 commits
  (merged to 'next' on 2013-04-22 at b00ccf6)
 + api-parse-options.txt: document "no-" for non-boolean options
 + git-gc.txt, git-reflog.txt: document new expiry options
 + date.c: add parse_expiry_date()

 We used the approxidate() parser for "--expire=<timestamp>" options
 of various commands, but it is better to treat --expire=all and
 --expire=now a bit more specially than using the current timestamp.
 Update "git gc" and "git reflog" with a new parsing function for
 expiry dates.

 Will cook in 'next'.


* nd/pretty-formats (2013-04-18) 13 commits
  (merged to 'next' on 2013-04-22 at 3d63014)
 + pretty: support %>> that steal trailing spaces
 + pretty: support truncating in %>, %< and %><
 + pretty: support padding placeholders, %< %> and %><
 + pretty: add %C(auto) for auto-coloring
 + pretty: split color parsing into a separate function
 + pretty: two phase conversion for non utf-8 commits
 + utf8.c: add reencode_string_len() that can handle NULs in string
 + utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 + utf8.c: move display_mode_esc_sequence_len() for use by other functions
 + pretty: share code between format_decoration and show_decorations
 + pretty-formats.txt: wrap long lines
 + pretty: get the correct encoding for --pretty:format=%e
 + pretty: save commit encoding from logmsg_reencode if the caller needs it

 pretty-printing body of the commit that is stored in non UTF-8
 encoding did not work well.  The early part of this series fixes
 it.  And then it adds %C(auto) specifier that turns the coloring on
 when we are emitting to the terminal, and adds column-aligning
 format directives.

 Will merge to 'master'.


* kb/status-ignored-optim-2 (2013-04-15) 14 commits
  (merged to 'next' on 2013-04-21 at d2a5c70)
 + dir.c: git-status --ignored: don't scan the work tree twice
 + dir.c: git-status --ignored: don't scan the work tree three times
 + dir.c: git-status: avoid is_excluded checks for tracked files
 + dir.c: replace is_path_excluded with now equivalent is_excluded API
 + dir.c: unify is_excluded and is_path_excluded APIs
 + dir.c: move prep_exclude
 + dir.c: factor out parts of last_exclude_matching for later reuse
 + dir.c: git-clean -d -X: don't delete tracked directories
 + dir.c: make 'git-status --ignored' work within leading directories
 + dir.c: git-status --ignored: don't list empty directories as ignored
 + dir.c: git-ls-files --directories: don't hide empty directories
 + dir.c: git-status --ignored: don't list empty ignored directories
 + dir.c: git-status --ignored: don't list files in ignored directories
 + dir.c: git-status --ignored: don't drop ignored directories

 Rerolls kb/status-ignored-optim topic (reverted from 'next').
 With help from Karsten, conflicts with as/check-ignore topic have
 been sorted out and it is now in 'pu'.

 Will merge to 'master'.


* as/check-ignore (2013-04-11) 5 commits
  (merged to 'next' on 2013-04-21 at 7515aa8)
 + Documentation: add caveats about I/O buffering for check-{attr,ignore}
 + check-ignore: allow incremental streaming of queries via --stdin
 + check-ignore: move setup into cmd_check_ignore()
 + check-ignore: add -n / --non-matching option
 + t0008: remove duplicated test fixture data

 Enhance "check-ignore" (1.8.2 update) to work more like "check-attr"
 over bidi-pipes.

 Will cook in 'next'.
 The test in the second from the tip needs to be updated.


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

 Waiting for comments.


* jk/remote-helper-with-signed-tags (2013-04-15) 3 commits
  (merged to 'next' on 2013-04-21 at 0231d45)
 + transport-helper: add 'signed-tags' capability
 + transport-helper: pass --signed-tags=warn-strip to fast-export
 + fast-export: add --signed-tags=warn-strip mode

 Allows remote-helpers to declare they can handle signed tags, and
 issue a warning when using those that don't.

 Will merge to 'master'.


* jn/gitweb-install-doc (2013-04-17) 2 commits
  (merged to 'next' on 2013-04-22 at a5d4812)
 + gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
 + gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM

 Reword gitweb configuration instrutions.

 Will merge to 'master'.


* fc/transport-helper-error-reporting (2013-04-17) 9 commits
  (merged to 'next' on 2013-04-22 at 5ba6467)
 + transport-helper: update remote helper namespace
 + transport-helper: trivial code shuffle
 + transport-helper: warn when refspec is not used
 + transport-helper: clarify pushing without refspecs
 + transport-helper: update refspec documentation
 + transport-helper: clarify *:* refspec
 + transport-helper: improve push messages
 + transport-helper: mention helper name when it dies
 + transport-helper: report errors properly

 Update transport helper to report errors and maintain ref hierarchy
 used to keep track of remote helper state better.

 Will merge to 'master'.


* jk/submodule-subdirectory-ok (2013-04-18) 2 commits
  (merged to 'next' on 2013-04-22 at f211e25)
 + submodule: drop the top-level requirement
 + rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Will cook in 'next'.


* jl/submodule-mv (2013-04-11) 4 commits
  (merged to 'next' on 2013-04-19 at 45ae3c9)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + Teach mv to update the path entry in .gitmodules for moved submodules
 + Teach mv to move submodules using a gitfile
 + Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will cook in 'next'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-03) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


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

 Will be rerolled.


* tr/line-log (2013-04-22) 13 commits
  (merged to 'next' on 2013-04-22 at 8f2c1de)
 + git-log(1): remove --full-line-diff description
  (merged to 'next' on 2013-04-21 at cd92620)
 + line-log: fix documentation formatting
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

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-04-03) 1 commit
 - push: switch default from "matching" to "simple"

 The early bits to adjust the tests have been merged to 'master'.

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-delete-default (2013-04-21) 1 commit
 - git add <pathspec>... defaults to "-A"

 Will cook in 'next' until Git 2.0.
