From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 12:49:14 -0700
Message-ID: <7vy649vah1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 20:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Odf-0002xu-Kq
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 20:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab1CTTtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 15:49:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab1CTTth (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 15:49:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D13142C6;
	Sun, 20 Mar 2011 15:51:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	6MHjW3WiApJx9EvsyGzbYaT5a0=; b=YPl16OUTOyYpf4qh2s8onxOiakW/jxiX7
	PMK3me28W0mT1pYzXr1s8d5AUgMH96PpzcSTQM6BGy8vlkwZESyenq7NWP5GHYuy
	oClVAn2h9butBZR0ZcVf5JJsxia+jgG5hZVXNr7C6qyCEz9z/4YZFTW4EjB9cuKt
	3Z8lEHl530=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hUp
	W966sDUbqTsgu82m0MV0BaVnfSD+5lh3FcKoFF2tRVEC44dqz2uxrkQ008j26woj
	eD5o84/VVb1jdIef4+Q+aehqAXxE1s19PkHX3Nv1FmQlHAAXuPpch7bJALAruDUn
	VEzZiN2ddPbzfdhUVuQfORQq4Ditgy6xGH90NA+s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2DB242C0;
	Sun, 20 Mar 2011 15:51:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D77C042BB; Sun, 20 Mar 2011
 15:50:53 -0400 (EDT)
X-master-at: a91df69cbb5ced7837525106ff57ff349180770b
X-next-at: a171c98383be633c617ac36a0665e26416ac90bd
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63EDFFD0-532B-11E0-BE51-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169520>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The very basic of i18n is now in 'master'.  I'll be moving the rest of the
series forward shortly.

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-basic (2011-02-25) 9 commits
  (merged to 'next' on 2011-03-10 at ab70d57)
 + i18n: "make distclean" should clean up after "make pot"
 + i18n: Makefile: "pot" target to extract messages marked for translation
 + i18n: add stub Q_() wrapper for ngettext
 + i18n: do not poison translations unless GIT_GETTEXT_POISON envvar is set
 + i18n: add GETTEXT_POISON to simulate unfriendly translator
 + i18n: add no-op _() and N_() wrappers
 + commit, status: use status_printf{,_ln,_more} helpers
 + commit: refer to commit template as s->fp
 + wt-status: add helpers for printing wt-status lines
 (this branch is used by ab/i18n-st.)

* fk/maint-cvsimport-early-failure (2011-01-31) 1 commit
  (merged to 'next' on 2011-03-09 at b4dee9e)
 + git-cvsimport.perl: Bail out right away when reading from the server fails

* jc/checkout-orphan-warning (2011-02-18) 1 commit
  (merged to 'next' on 2011-03-09 at 765cf75)
 + commit: give final warning when reattaching HEAD to leave commits behind

* jc/maint-apply-no-double-patch (2011-03-04) 1 commit
  (merged to 'next' on 2011-03-09 at 6ec48e7)
 + apply: do not patch lines that were already patched

* jc/maint-apply-report-offset (2011-03-04) 1 commit
  (merged to 'next' on 2011-03-09 at 1bb74ef)
 + apply -v: show offset count when patch did not apply exactly

* jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
  (merged to 'next' on 2011-03-09 at 13a9328)
 + branch/checkout --track: Ensure that upstream branch is indeed a branch

* jk/format-patch-multiline-header (2011-02-23) 3 commits
  (merged to 'next' on 2011-03-09 at f970fe3)
 + format-patch: rfc2047-encode newlines in headers
 + format-patch: wrap long header lines
 + strbuf: add fixed-length version of add_wrapped_text

* jk/merge-rename-ux (2011-02-20) 6 commits
  (merged to 'next' on 2011-03-09 at df1943a)
 + pull: propagate --progress to merge
 + merge: enable progress reporting for rename detection
 + add inexact rename detection progress infrastructure
 + commit: stop setting rename limit
 + bump rename limit defaults (again)
 + merge: improve inexact rename limit warning

* jk/strbuf-vaddf (2011-03-08) 3 commits
  (merged to 'next' on 2011-03-09 at 9651bc5)
 + compat: fall back on __va_copy if available
 + strbuf: add strbuf_vaddf
 + compat: provide a fallback va_copy definition
 (this branch is used by ab/i18n-basic, ab/i18n-st, jk/trace-sifter and jn/status-translatable.)

* jk/trace-sifter (2011-02-24) 6 commits
  (merged to 'next' on 2011-03-09 at 07841db)
 + trace: give repo_setup trace its own key
 + add packet tracing debug code
 + trace: add trace_strbuf
 + trace: factor out "do we want to trace" logic
 + trace: refactor to support multiple env variables
 + trace: add trace_vprintf

* jn/maint-instaweb-plack-fix (2011-02-26) 1 commit
  (merged to 'next' on 2011-03-09 at 3c9e14b)
 + git-instaweb: Change how gitweb.psgi is made runnable as standalone app

* jn/status-translatable (2011-02-25) 3 commits
  (merged to 'next' on 2011-03-09 at d00d23d)
 + commit, status: use status_printf{,_ln,_more} helpers
 + commit: refer to commit template as s->fp
 + wt-status: add helpers for printing wt-status lines

* js/rerere-forget-always-take-pathspec (2011-03-01) 1 commit
  (merged to 'next' on 2011-03-10 at 2d1ded3)
 + rerere forget: deprecate invocation without pathspec

* mg/rev-list-n-reverse-doc (2011-03-08) 2 commits
  (merged to 'next' on 2011-03-10 at 62d3161)
 + git-log.txt,rev-list-options.txt: put option blocks in proper order
 + git-log.txt,rev-list-options.txt: -n/--max-count is commit limiting

* mm/maint-log-n-with-diff-filtering (2011-03-09) 1 commit
  (merged to 'next' on 2011-03-10 at 33af1cd)
 + log: fix --max-count when used together with -S or -G

* mm/push-default-advice (2011-03-02) 2 commits
  (merged to 'next' on 2011-03-09 at 160095b)
 + push: better error message when no remote configured
 + push: better error messages when push.default = tracking

* mr/hpux (2011-03-07) 2 commits
  (merged to 'next' on 2011-03-09 at 8a5fe11)
 + git-compat-util.h: Honor HP C's noreturn attribute
 + Makefile: add NO_FNMATCH_CASEFOLD to HP-UX section

* sp/maint-fd-limit (2011-03-02) 3 commits
  (merged to 'next' on 2011-03-09 at 389e97d)
 + sha1_file.c: Don't retain open fds on small packs
 + mingw: add minimum getrlimit() compatibility stub
 + Limit file descriptors used by packs

* ss/mergetool--lib (2011-02-27) 2 commits
  (merged to 'next' on 2011-03-09 at 004fb9c)
 + mergetool--lib: Add Beyond Compare 3 as a tool
 + mergetool--lib: Sort tools alphabetically for easier lookup

* uk/ls-remote-in-get-remote-url (2011-03-01) 2 commits
  (merged to 'next' on 2011-03-09 at 09b570b)
 + git-request-pull: open-code the only invocation of get_remote_url
 + get_remote_url(): use the same data source as ls-remote to get remote urls

--------------------------------------------------
[New Topics]

* jc/maint-fetch-alt (2011-03-11) 2 commits
  (merged to 'next' on 2011-03-17 at c61ec4f)
 + fetch-pack: objects in our alternates are available to us
 + refs_from_alternate: helper to use refs from alternates

* jc/maint-rerere-in-workdir (2011-03-10) 1 commit
 - rerere: make sure it works even in a workdir attached to a young repository

Do not merge; needs more thought around relative symlinks.

* lt/default-abbrev (2010-10-28) 1 commit
  (merged to 'next' on 2011-03-17 at 1d7e406)
 + Make the default abbrev length configurable

The configuration roughly corresponds to --abbrev command line option, so
I should rename it back to core.abbrev as Linus originally named it.

* pk/stash-apply-status-relative (2011-03-12) 1 commit
 - git stash: show status relative to current directory

Will merge to 'next'.

* sg/complete-symmetric-diff (2011-03-10) 2 commits
  (merged to 'next' on 2011-03-17 at adb0618)
 + bash: complete 'git diff ...branc<TAB>'
 + bash: fix misindented esac statement in __git_complete_file()

* jc/maint-rev-list-culled-boundary (2011-03-14) 1 commit
  (merged to 'next' on 2011-03-17 at 001b546)
 + list-objects.c: don't add an unparsed NULL as a pending tree

* jn/test-sanitize-git-env (2011-03-15) 5 commits
  (merged to 'next' on 2011-03-17 at 80a3678)
 + tests: scrub environment of GIT_* variables
 + config: drop support for GIT_CONFIG_NOGLOBAL
 + gitattributes: drop support for GIT_ATTR_NOGLOBAL
 + tests: suppress system gitattributes
 + tests: stop worrying about obsolete environment variables

* js/maint-stash-index-copy (2011-03-16) 2 commits
  (merged to 'next' on 2011-03-17 at 9f74cc8)
 + stash: copy the index using --index-output instead of cp -p
 + stash: fix incorrect quoting in cleanup of temporary files

* sp/maint-fetch-pack-stop-early (2011-03-14) 2 commits
  (merged to 'next' on 2011-03-17 at 2580068)
 + fetch-pack: Implement no-done capability
 + fetch-pack: Finish negotation if remote replies "ACK %s ready"
 (this branch is used by jc/fetch-progressive-stride.)

* sp/maint-upload-pack-stop-early (2011-03-14) 2 commits
  (merged to 'next' on 2011-03-17 at e717a84)
 + upload-pack: Implement no-done capability
 + upload-pack: More aggressively send 'ACK %s ready'

* mg/doc-bisect-tweak-worktree (2011-03-15) 2 commits
  (merged to 'next' on 2011-03-17 at e0acf52)
 + git-bisect.txt: example for bisecting with hot-fix
 + git-bisect.txt: streamline run presentation

* tl/p4 (2011-03-15) 3 commits
  (merged to 'next' on 2011-03-17 at 3d7f69f)
 + git-p4: Fix error message crash in P4Sync.commit.
 + Teach git-p4 to ignore case in perforce filenames if configured.
 + git-p4: Teach gitConfig method about arguments.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

* jc/fetch-progressive-stride (2011-03-18) 3 commits
 - fetch-pack: use smaller handshake window for initial request
 - fetch-pack: progressively use larger handshake windows
 - fetch-pack: factor out hardcoded handshake window size
 (this branch uses sp/maint-fetch-pack-stop-early.)

The top two need to be cleaned up with correct author name.

* jc/maint-diff-q-filter (2011-03-16) 1 commit
 - diff --quiet: disable optimization when --diff-filter=X is used

Will merge to 'next'.

* jn/fortify-source-workaround (2011-03-16) 1 commit
 - run-command: prettify -D_FORTIFY_SOURCE workaround

Will merge to 'next'.

* jn/maint-c99-format (2011-03-16) 2 commits
 - unbreak and eliminate NO_C99_FORMAT
 - mktag: avoid %td in format string

Will merge to 'next'.

* kc/gitweb-pathinfo-w-anchor (2011-03-18) 1 commit
 - gitweb: fix #patchNN anchors when path_info is enabled

Will merge to 'next'.

* pw/p4 (2011-03-16) 2 commits
 - git-p4: test sync new branch
 - git-p4: fix sync new branch regression

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way? I've been wanting to move this forward for quite some time but
also hoping somebody else would send in a final version.

* mz/rebase (2011-02-28) 34 commits
 - rebase: define options in OPTIONS_SPEC
  (merged to 'next' on 2011-02-25 at 52caa7a)
 + Makefile: do not install sourced rebase scripts
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

I think the tip one is a response to J6t's regression concerns; it looked
Ok to me.

* jc/diff-irreversible-delete (2011-02-28) 1 commit
 - git diff -D: omit the preimage of deletes

"diff -B -D" should omit the deleting half of a broken pair from the
output.  Need documentation and tests.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

It seems that we need separate parsers for these two formats in order not
to regress the users of the original cvs.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jk/edit-notes-in-commit-log (2011-03-07) 2 commits
 - [wip] commit: allow editing notes in commit message editor
 - notes: make expand_notes_ref globally accessible

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 . diffcore-rename: fall back to -C when -C -C busts the rename limit
 . diffcore-rename: record filepair for rename src
 . diffcore-rename: refactor "too many candidates" logic

Will take another look.

* mg/grep-full-tree (2011-03-01) 2 commits
 - grep: make --full-tree work with pathspecs
 - grep: --full-tree

Do not merge; it would be preferable to use ":/" or whatever magic
pathspec that is relative to the root of the working tree.

* nd/rfc-add-u-full-tree (2011-02-07) 1 commit
 - add: make "add -u" update full tree without pathspec

A three-phase migration that:

 (1) first only warns when we would deviate from traditional behaviour and
     suggest adding "." if the user wants to limit it to cwd, but doesn't
     actually add full-tree, in the next release;

 (2) warn that we have changed the behaviour and suggest adding "." if the
     user wants to limit it to cwd, and actually do full-tree, in 1.8.0;

 (3) remove the warning, in 1.8.X (for X at least 2 or more).

would be a good way forward.

--------------------------------------------------
[Cooking]

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-03-18 at a32016b)
 + merge-recursive: tweak magic band-aid
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

I am not happy with these magic band aids.

* nd/init-gitdir (2011-03-19) 2 commits
 - init, clone: support --separate-git-dir for .git file
 - git-init.txt: move description section up

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
 - fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 - submodule update: Don't fetch when the submodule commit is already present
 - fetch/pull: Don't recurse into a submodule when commits are already present
 - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 - config: teach the fetch.recurseSubmodules option the 'on-demand' value
 - fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 - fetch/pull: recurse into submodules when necessary

Is this ready to move forward?

* ss/git-gui-mergetool (2011-02-26) 2 commits
  (merged to 'next' on 2011-03-17 at a8fac18)
 + mergetool--lib: Add Beyond Compare 3 as a tool
 + mergetool--lib: Sort tools alphabetically for easier lookup

The CLI side (ss/mergetool--lib topic) will be in the next release, so
I'll ping Pat to take this into gut-gui tree.

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

* ab/i18n-st (2011-02-22) 69 commits
 - i18n: git-shortlog basic messages
 - i18n: git-revert split up "could not revert/apply" message
 - i18n: git-revert literal "me" messages
 - i18n: git-revert "Your local changes" message
 - i18n: git-revert basic messages
 - i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 - i18n: git-notes basic commands
 - i18n: git-gc "Auto packing the repository" message
 - i18n: git-gc basic messages
 - i18n: git-describe basic messages
 - i18n: git-clean clean.requireForce messages
 - i18n: git-clean basic messages
 - i18n: git-bundle basic messages
 - i18n: git-archive basic messages
 - i18n: git-status "renamed: " message
 - i18n: git-status "Initial commit" message
 - i18n: git-status "Changes to be committed" message
 - i18n: git-status shortstatus messages
 - i18n: git-status "nothing to commit" messages
 - i18n: git-status basic messages
 - i18n: git-push "prevent you from losing" message
 - i18n: git-push basic messages
 - i18n: git-tag tag_template message
 - i18n: git-tag basic messages
 - i18n: git-reset "Unstaged changes after reset" message
 - i18n: git-reset reset_type_names messages
 - i18n: git-reset basic messages
 - i18n: git-rm basic messages
 - i18n: git-mv "bad" messages
 - i18n: git-mv basic messages
 - i18n: git-merge "Wonderful" message
 - i18n: git-merge "You have not concluded your merge" messages
 - i18n: git-merge "Updating %s..%s" message
 - i18n: git-merge basic messages
 - i18n: git-log "--OPT does not make sense" messages
 - i18n: git-log basic messages
 - i18n: git-grep "--open-files-in-pager" message
 - i18n: git-grep basic messages
 - i18n: git-fetch split up "(non-fast-forward)" message
 - i18n: git-fetch update_local_ref messages
 - i18n: git-fetch formatting messages
 - i18n: git-fetch basic messages
 - i18n: git-diff basic messages
 - i18n: git-commit advice messages
 - i18n: git-commit "enter the commit message" message
 - i18n: git-commit print_summary messages
 - i18n: git-commit formatting messages
 - i18n: git-commit "middle of a merge" message
 - i18n: git-commit basic messages
 - i18n: git-checkout "Switched to a .. branch" message
 - i18n: git-checkout "HEAD is now at" message
 - i18n: git-checkout describe_detached_head messages
 - i18n: git-checkout: our/their version message
 - i18n: git-checkout basic messages
 - i18n: git-branch "(no branch)" message
 - i18n: git-branch "git branch -v" messages
 - i18n: git-branch "Deleted branch [...]" message
 - i18n: git-branch "remote branch '%s' not found" message
 - i18n: git-branch basic messages
 - i18n: git-add "Unstaged changes" message
 - i18n: git-add "remove '%s'" message
 - i18n: git-add "did not match any files" message
 - i18n: git-add "The following paths are ignored" message
 - i18n: git-add basic messages
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone basic messages
 - i18n: git-init "Initialized [...] repository" message
 - i18n: git-init basic messages

* mg/rev-list-one-side-only (2011-03-10) 10 commits
  (merged to 'next' on 2011-03-10 at 2a69869)
 + git-log: put space after commit mark
 + t6007: test rev-list --cherry
 + log --cherry: a synonym
 + rev-list: documentation and test for --cherry-mark
 + revision.c: introduce --cherry-mark
 + rev-list/log: factor out revision mark generation
 + rev-list: --left/right-only are mutually exclusive
 + rev-list: documentation and test for --left/right-only
 + t6007: Make sure we test --cherry-pick
 + revlist.c: introduce --left/right-only for unsymmetric picking

Looked sensible, including the change of the output.
