From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Wed, 03 Mar 2010 16:02:20 -0800
Message-ID: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 01:02:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmyWc-0003Jw-0m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 01:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab0CDACc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 19:02:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab0CDACa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 19:02:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB6B9E4C9;
	Wed,  3 Mar 2010 19:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=c8ND
	hWaGP5/J7TA1U+MdOsuQWng=; b=HHcqam7njgjsw/SrpIzg9ZVS3AhN+hTxLA07
	XWBIkruxXhGOX/001FF9+csEHQGKp3ZpaZXPndTjqQFXoymh29mW1tqurJDn9Wx1
	dRO5B/Ub4YCGZIweujHAuoaWpAAN4+qhiB6sTognBAZNKpRsMZdp2Mj3s95RMMg3
	Me8pe20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=U2S
	bBWRdUhuGGaIYUDfuASyGNYYC9oSNgIFf/q9ANIFGmbSyQi8Qmma/22Kl99q3gO2
	p1Sfg5oioQfd+RVTgRO83wGdMpP7kePvGQrsbQi/yhBFaoZeS7h/eVGE7osV+w9i
	7l1j2iSV1jyYxDICGhjq94/3Hzw9/Y8+WHeQ5FHM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E4D79E4C7;
	Wed,  3 Mar 2010 19:02:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C57E9E4C6; Wed,  3 Mar
 2010 19:02:22 -0500 (EST)
X-master-at: 6d84bcb5de78251d98f7d3e80e822d9a4b8f4df3
X-next-at: d855a59a115b20c6483b87c1e71e287d1c7e8b6c
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 372B9868-2721-11DF-BA18-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141492>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* dp/read-not-mmap-small-loose-object (2010-02-21) 1 commit
  (merged to 'next' on 2010-02-21 at fa39a9a)
 + hash-object: don't use mmap() for small files

* np/compress-loose-object-memsave (2010-02-21) 2 commits
  (merged to 'next' on 2010-02-21 at 1e558d6)
 + sha1_file: be paranoid when creating loose objects
 + sha1_file: don't malloc the whole compressed result when writing out objects

* ml/connect-refactor (2010-02-17) 1 commit
  (merged to 'next' on 2010-02-21 at 7361651)
 + connect.c: move duplicated code to a new function 'get_host_and_port'

* ml/encode-header-refactor (2010-02-23) 2 commits
  (merged to 'next' on 2010-02-23 at ac4ec8f)
 + move encode_in_pack_object_header() to a better place
  (merged to 'next' on 2010-02-21 at efe648b)
 + refactor duplicated encode_header in pack-objects and fast-import

* ml/fill-mm-refactor (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at 2fc5570)
 + refactor duplicated fill_mm() in checkout and merge-recursive

* ml/send-pack-transport-refactor (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at db276f4)
 + refactor duplicated code in builtin-send-pack.c and transport.c

* rs/optim-text-wrap (2010-02-19) 4 commits
  (merged to 'next' on 2010-02-21 at 70ef189)
 + utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()
 + utf8.c: remove strbuf_write()
 + utf8.c: remove print_spaces()
 + utf8.c: remove print_wrapped_text()

* tr/maint-cherry-pick-list (2010-02-20) 1 commit
  (merged to 'next' on 2010-02-21 at 65fded0)
 + cherry_pick_list: quit early if one side is empty

* ld/maint-diff-quiet-w (2010-02-21) 2 commits
  (merged to 'next' on 2010-02-21 at 4701142)
 + git-diff: add a test for git diff --quiet -w
 + git diff --quiet -w: check and report the status

* jc/for-each-ref (2010-02-13) 4 commits
  (merged to 'next' on 2010-02-21 at c9a6c2f)
 + for-each-ref --format='%(flag)'
 + for-each-ref --format='%(symref) %(symref:short)'
 + builtin-for-each-ref.c: check if we need to peel onion while parsing the format
 + builtin-for-each-ref.c: comment fixes

* jn/gitweb-config-error-die (2010-02-14) 1 commit
  (merged to 'next' on 2010-02-21 at e3ecd65)
 + gitweb: Die if there are parsing errors in config file

* jn/maint-fix-pager (2010-02-22) 8 commits
  (merged to 'next' on 2010-02-23 at 575e0e4)
 + tests: Fix race condition in t7006-pager
  (merged to 'next' on 2010-02-21 at 640e10c)
 + t7006-pager: if stdout is not a terminal, make a new one
 + tests: Add tests for automatic use of pager
 + am: Fix launching of pager
 + git svn: Fix launching of pager
 + git.1: Clarify the behavior of the --paginate option
 + Make 'git var GIT_PAGER' always print the configured pager
 + Fix 'git var' usage synopsis

* ml/color-when (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at d52c051)
 + Add an optional argument for --color options

* hm/imap-send-cram-md5 (2010-02-15) 1 commit
  (merged to 'next' on 2010-02-21 at de8f650)
 + imap-send: support CRAM-MD5 authentication

* gf/maint-sh-setup-nongit-ok (2010-02-16) 1 commit
  (merged to 'next' on 2010-02-21 at aca55e6)
 + require_work_tree broken with NONGIT_OK

* jc/maint-status-preload (2010-02-17) 1 commit
  (merged to 'next' on 2010-02-21 at d79e163)
 + status: preload index to optimize lstat(2) calls

* ac/cvsimport-revision-mapping (2010-02-06) 1 commit
  (merged to 'next' on 2010-02-17 at 6756446)
 + cvsimport: new -R option: generate .git/cvs-revisions mapping

* jn/maint-makedepend (2010-01-26) 5 commits
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: drop dependency on $(wildcard */*.h)
 + Makefile: clean up http-walker.o dependency rules
 + Makefile: remove wt-status.h from LIB_H
 + Makefile: make sure test helpers are rebuilt when headers change
 + Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

* jn/master-makedepend (2010-01-26) 0 commits
 (this branch uses jn/maint-makedepend; is used by jn/makedepend.)

* jn/makedepend (2010-02-28) 10 commits
  (merged to 'next' on 2010-02-28 at 6604fd0)
 + Makefile: clarify definition of TEST_OBJS
  (merged to 'next' on 2010-02-21 at 34a3e48)
 + Makefile: always remove .depend directories on 'make clean'
 + Makefile: tuck away generated makefile fragments in .depend
 + Teach Makefile to check header dependencies
 + Makefile: list standalone program object files in PROGRAM_OBJS
 + Makefile: lazily compute header dependencies
 + Makefile: list generated object files in OBJECTS
 + Makefile: disable default implicit rules
 + Makefile: rearrange dependency rules
 + Makefile: transport.o depends on branch.h now
 (this branch uses jn/maint-makedepend and jn/master-makedepend.)

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
  (merged to 'next' on 2010-02-17 at 3b7be80)
 + "log --author=me --grep=it" should find intersection, not union

* jh/maint-submodule-status-in-void (2010-03-03) 1 commit
 + submodule summary: Don't barf when invoked in an empty repo

We might also want to enable showing the submodule change, which is
currently queued in 'pu'.

--------------------------------------------------
[New Topics]

* bg/apply-fix-blank-at-eof (2010-02-27) 5 commits
 - t3417: Add test cases for "rebase --whitespace=fix"
 - t4124: Add additional tests of --whitespace=fix
 - apply: Allow blank context lines to match beyond EOF
 - apply: Remove the quick rejection test
 - apply: Don't unnecessarily update line lengths in the preimage

Probably ready for 'next'.

* gb/maint-submodule-env (2010-02-25) 5 commits
  (merged to 'next' on 2010-02-25 at 8c22d03)
 + is_submodule_modified(): clear environment properly
 + submodules: ensure clean environment when operating in a submodule
 + shell setup: clear_local_git_env() function
 + rev-parse: --local-env-vars option
 + Refactor list of of repo-local env vars

Ready for 'master'.

* jc/fetch-param (2010-02-24) 3 commits
  (merged to 'next' on 2010-02-25 at e95e252)
 + fetch --all/--multiple: keep all the fetched branch information
 + builtin-fetch --all/--multi: propagate options correctly
 + t5521: fix and modernize

Ready for 'master'.

* jk/maint-push-tracking-wo-remote (2010-02-24) 1 commit
  (merged to 'next' on 2010-02-25 at da946ba)
 + push: fix segfault for odd config

Ready for 'master'.

* mb/shortlog-nongit-stdin (2010-02-24) 1 commit
  (merged to 'next' on 2010-02-25 at d17bb74)
 + shortlog: warn the user when there is no input

Ready for 'master'.

* sg/bash-completion (2010-02-23) 4 commits
 - bash: completion for gitk aliases
 - bash: support user-supplied completion scripts for aliases
 - bash: support user-supplied completion scripts for user's git commands
 - bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* fn/maint-mkdtemp-compat (2010-02-25) 1 commit
  (merged to 'next' on 2010-02-25 at 2899a47)
 + Fix gitmkdtemp: correct test for mktemp() return value

Ready for 'master'.

* ml/maint-grep-doc (2010-02-25) 4 commits
  (merged to 'next' on 2010-03-02 at a75dfe0)
 + grep docs: document --no-index option
  (merged to 'next' on 2010-02-25 at ec1faf8)
 + grep docs: --cached and <tree>... are incompatible
 + grep docs: use AsciiDoc literals consistently
 + grep docs: pluralize "Example" section

Ready for 'master'.

* fl/askpass (2010-03-03) 2 commits
 - git-core: Support retrieving passwords with GIT_ASKPASS
 - git-svn: Support retrieving passwords with GIT_ASKPASS

As we export GIT_ASKPASS when it is not set but SSH_ASKPASS is from "git"
potty (the third patch in the series, which I applied to 'master'), I
removed the first hunk that did that by hand.

* as/maint-expire (2010-02-26) 2 commits
  (merged to 'next' on 2010-03-02 at 4015ae4)
 + reflog: honor gc.reflogexpire=never
 + prune: honor --expire=never

* jc/color-attrs (2010-02-27) 1 commit
 - color: allow multiple attributes

Perhaps I should remove the counting, extend COLOR_MAXLEN and remove the
test that checks overlong color specification and then merge this to
'next'.

* jc/maint-add-ignored-dir (2010-02-28) 3 commits
 - builtin-add: fix exclude handling
 - tests for "git add ignored-dir/file" without -f
 - t0050: mark non-working test as such

Not quite happy.

* ml/color-grep (2010-02-26) 3 commits
 - grep: Colorize selected, context, and function lines
 - grep: Colorize filename, line number, and separator
 - Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*

There was a comment about not special casing filename coloring?

* sb/notes-parse-opt (2010-02-27) 1 commit
 - notes: rework subcommands and parse options
 (this branch uses early parts of jh/notes and tr/notes-display.)

* sh/am-keep-cr (2010-02-27) 4 commits
  (merged to 'next' on 2010-03-02 at ffe3c5e)
 + git-am: Add tests for `--keep-cr`, `--no-keep-cr` and `am.keepcr`
 + git-am: Add am.keepcr and --no-keep-cr to override it
 + git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit
 + documentation: 'git-mailsplit --keep-cr' is not hidden anymore

* bw/union-merge-refactor (2010-03-01) 4 commits
 - merge-file: add option to select union merge favor
 - merge-file: add option to specify the marker size
 - refactor merge flags into xmparam_t
 - make union merge an xdl merge favor

The first two are ready for 'next'; the latter two are safe and perhaps
useful.

* mg/test-svn-info (2010-03-03) 2 commits
 - t9119-git-svn-info.sh: test with svn 1.6.* as well
 - git-svn: req_svn when needed

--------------------------------------------------
[Stalled]

* sd/format-patch-to (2010-02-17) 1 commit
 - Add 'git format-patch --to=' option and 'format.to' configuration variable.

Shouldn't be too hard to add tests to t4014; other than that looked ready
for 'next'.

* sd/log-decorate (2010-02-17) 3 commits
 - log.decorate: usability fixes
 - Add `log.decorate' configuration variable.
 - git_config_maybe_bool()

Probably ready for 'next', except that people need to be warned about
having to update their scripts to explicitly pass --no-decorate to keep
them working.  A good idea to disable this when --pretty was given, just
like notes are disabled by default, was floated.

* pb/log-first-parent-p-m (2010-02-10) 1 commit
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Needs tests but otherwise looked fine.  We might want to teach "-m trumps
implicit --cc" to "git show", but that is a totally separate topic.

I actually care about this "log -p --first-parent" very much, but if Pasky
is counting on that and procrastinating until I write the tests myself, he
is in for a disappointment.  I don't have that much free time these days.
Help is appreciated.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

--------------------------------------------------
[Cooking]

* ld/push-porcelain (2010-02-26) 4 commits
  (merged to 'next' on 2010-03-02 at d15bb1e)
 + git-push: add tests for git push --porcelain
 + git-push: make git push --porcelain print "Done"
 + git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 + git-push: fix an advice message so it goes to stderr

* sd/init-template (2010-03-02) 5 commits
  (merged to 'next' on 2010-03-02 at 2d87e3f)
 + wrap-for-bin: do not export an empty GIT_TEMPLATE_DIR
 + t/t0001-init.sh: add test for 'init with init.templatedir set'
 + init: having keywords without value is not a global error.
 + Add a "TEMPLATE DIRECTORY" section to git-init[1].
 + Add `init.templatedir` configuration variable.

* il/loosen-remote-helper-names (2010-02-23) 1 commit
  (merged to 'next' on 2010-02-25 at 5c22a39)
 + Allow '+', '-' and '.' in remote helper names

Ready for 'master'.

* jk/maint-add--interactive-delete (2010-02-22) 1 commit
  (merged to 'next' on 2010-02-24 at 908cef8)
 + add-interactive: fix bogus diff header line ordering

Probably ready for 'master'.

* js/runtime-prefix-trace-not-warn (2010-02-23) 1 commit
  (merged to 'next' on 2010-02-24 at 8d9d305)
 + Print RUNTIME_PREFIX warning only when GIT_TRACE is set

Ready for 'master'.

* lt/deepen-builtin-source (2010-02-22) 1 commit
  (merged to 'next' on 2010-02-25 at 320aa74)
 + Move 'builtin-*' into a 'builtin/' subdirectory

This is a painful one to keep out of 'master' for a long time, as any
topic with new builtin commands will need evil merges to adjust to it.

* tc/http-cleanup (2010-03-02) 7 commits
 - remote-curl: init walker only when needed
 - remote-curl: use http_fetch_ref() instead of walker wrapper
 - http: init and cleanup separately from http-walker
 - http-walker: cleanup more thoroughly
 - http-push: remove "|| 1" to enable verbose check
 - t554[01]-http-push: refactor, add non-ff tests
 - t5541-http-push: check that ref is unchanged for non-ff test

Rerolled.

* tr/notes-display (2010-02-23) 11 commits
 - notes: add shorthand --ref to override GIT_NOTES_REF
 - commit --amend: copy notes to the new commit
 - rebase: support automatic notes copying
 - notes: implement helpers needed for note copying during rewrite
 - notes: implement 'git notes copy --stdin'
 - rebase -i: invoke post-rewrite hook
 - rebase: invoke post-rewrite hook
 - commit --amend: invoke post-rewrite hook
 - Documentation: document post-rewrite hook
 - Support showing notes from more than one notes tree
 - test-lib: unset GIT_NOTES_REF to stop it from influencing tests
 (this branch uses early parts of jh/notes; is used by sb/notes-parse-opt.)

Didn't look too carefully except for the second one.

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Ack-collection in progress.

* jc/maint-fix-mailinfo-strip (2010-02-19) 1 commit
  (merged to 'next' on 2010-02-24 at 621fa3d)
 + mailinfo: do not strip leading spaces even for a header line

Ready for 'master'.

* ne/pack-local-doc (2010-02-24) 3 commits
  (merged to 'next' on 2010-02-25 at 75cfba5)
 + pack-objects documentation: Fix --honor-pack-keep as well.
 + pack-objects documentation: reword "objects that appear in the standard input"
 + Documentation: pack-objects: Clarify --local's semantics.

Ready for 'master'.

* mm/mkstemps-mode-for-packfiles (2010-02-22) 6 commits
  (merged to 'next' on 2010-02-24 at 31b5903)
 + Use git_mkstemp_mode instead of plain mkstemp to create object files
 + git_mkstemps_mode: don't set errno to EINVAL on exit.
 + Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
 + git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
 + Move gitmkstemps to path.c
 + Add a testcase for ACL with restrictive umask.

Ready for 'master'.

* tc/transport-verbosity (2010-02-24) 10 commits
 - transport: update flags to be in running order
 - fetch and pull: learn --progress
 - push: learn --progress
 - transport->progress: use flag authoritatively
 - clone: support multiple levels of verbosity
 - push: support multiple levels of verbosity
 - fetch: refactor verbosity option handling into transport.[ch]
 - Documentation/git-push: put --quiet before --verbose
 - Documentation/git-pull: put verbosity options before merge/fetch ones
 - Documentation/git-clone: mention progress in -v

Didn't look very carefully.  Comments from transport people are very much
appreciated before moving this forward.

* cp/add-u-pathspec (2010-02-09) 2 commits
  (merged to 'next' on 2010-02-24 at 2f3f2bc)
 + test for add with non-existent pathspec
 + git add -u: die on unmatched pathspec

Not quite happy, but will merge to 'master' shortly anyway.

* nd/root-git (2010-02-14) 5 commits
  (merged to 'next' on 2010-02-25 at bff4955)
 + Add test for using Git at root of file system
 + Support working directory located at root
 + Move offset_1st_component() to path.c
 + init-db, rev-parse --git-dir: do not append redundant slash
 + make_absolute_path(): Do not append redundant slash

Probably ready for 'master'.

* jh/notes (2010-02-24) 32 commits
  (merged to 'next' on 2010-02-24 at c88263d)
 + notes: fix malformed tree entry
 + builtin-notes: Minor (mostly parse_options-related) fixes
  (merged to 'next' on 2010-02-21 at 75fc451)
 + builtin-notes: Add "copy" subcommand for copying notes between objects
 + builtin-notes: Misc. refactoring of argc and exit value handling
 + builtin-notes: Add -c/-C options for reusing notes
 + builtin-notes: Refactor handling of -F option to allow combining -m and -F
 + builtin-notes: Deprecate the -m/-F options for "git notes edit"
 + builtin-notes: Add "append" subcommand for appending to note objects
 + builtin-notes: Add "add" subcommand for adding notes to objects
 + builtin-notes: Add --message/--file aliases for -m/-F options
 + builtin-notes: Add "list" subcommand for listing note objects
 + Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 + builtin-notes: Add "prune" subcommand for removing notes for missing objects
 + Notes API: prune_notes(): Prune notes that belong to non-existing objects
 + t3305: Verify that removing notes triggers automatic fanout consolidation
 + builtin-notes: Add "remove" subcommand for removing existing notes
 + Teach builtin-notes to remove empty notes
 + Teach notes code to properly preserve non-notes in the notes tree
 + t3305: Verify that adding many notes with git-notes triggers increased fanout
 + t3301: Verify successful annotation of non-commits
 + Builtin-ify git-notes
 + Refactor notes concatenation into a flexible interface for combining notes
 + Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 + Notes API: write_notes_tree(): Store the notes tree in the database
 + Notes API: for_each_note(): Traverse the entire notes tree with a callback
 + Notes API: get_note(): Return the note annotating the given object
 + Notes API: remove_note(): Remove note objects from the notes tree structure
 + Notes API: add_note(): Add note objects to the internal notes tree structure
 + Notes API: init_notes(): Initialize the notes tree from the given notes ref
 + Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 + Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 + Minor cosmetic fixes to notes.c
 (this branch shares commits with sb/notes-parse-opt and tr/notes-display.)

Ready for 'master'.

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"

I am not sure if this series is useful, and even less sure if the
usefulness of it outweighs the confusion factor.
