From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2011, #01; Wed, 9)
Date: Wed, 09 Mar 2011 17:27:32 -0800
Message-ID: <7v62rr933v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 02:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxUfJ-0002Ek-Ff
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 02:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1CJB1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 20:27:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1CJB1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 20:27:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60C3D42E8;
	Wed,  9 Mar 2011 20:29:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	jYpYPPX/Fl5H3btMcIEtzvYO10=; b=SJO5RP6C18AGf43YNaBQupNZH+AzXYYZB
	fv3IKVx6SS9hnKRO/pdOz32fBkA3mRi6SNqfv113yhZJ/l+UvBYcuZ3bHSFUOfQh
	nGstf7Lzti7NENd7NGUgg3xUgMOaczj5FywxdKtJdpgxGdJGOP6a9ssOfLkvi5br
	YMJ3xJoGwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ui5
	1TF8YbYYPFAl5SSiEv1i02txbqbBmh1tpYg8FBzmUMWABdqOxIbMDtMEBBgsBk3t
	qNfcJBLNw0JGKnzv5sYG3QGsVKqwxjbE9V2zzpITv/XAUwnUiKt3tArHcFex06Ut
	BR0jqtqKq8FJdL6b+VKkvoN3IyVptSs9r7kgeCew=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3796C42E7;
	Wed,  9 Mar 2011 20:29:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D84A542E6; Wed,  9 Mar 2011
 20:29:01 -0500 (EST)
X-master-at: 83c3c6222a2331042c973a991572eafa37f25d1d
X-next-at: 3762932566eb538e640deb32358f68ec4c28ad7f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8E75450-4AB5-11E0-988E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168778>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I started draft release notes for 1.7.5 on 'master' branch.

--------------------------------------------------
[New Topics]

* en/merge-recursive (2011-02-28) 3 commits
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

* jc/maint-apply-no-double-patch (2011-03-04) 1 commit
  (merged to 'next' on 2011-03-09 at 6ec48e7)
 + apply: do not patch lines that were already patched

* jc/maint-apply-report-offset (2011-03-04) 1 commit
  (merged to 'next' on 2011-03-09 at 1bb74ef)
 + apply -v: show offset count when patch did not apply exactly

* jk/edit-notes-in-commit-log (2011-03-07) 2 commits
 - [wip] commit: allow editing notes in commit message editor
 - notes: make expand_notes_ref globally accessible

* js/rerere-forget-always-take-pathspec (2011-03-01) 1 commit
 - rerere forget: deprecate invocation without pathspec

* mg/grep-full-tree (2011-03-01) 2 commits
 - grep: make --full-tree work with pathspecs
 - grep: --full-tree

* mg/rev-list-n-reverse-doc (2011-03-08) 2 commits
 - git-log.txt,rev-list-options.txt: put option blocks in proper order
 - git-log.txt,rev-list-options.txt: -n/--max-count is commit limiting

* mm/maint-log-n-with-diff-filtering (2011-03-09) 1 commit
 - log: fix --max-count when used together with -S or -G

* mr/hpux (2011-03-07) 2 commits
  (merged to 'next' on 2011-03-09 at 8a5fe11)
 + git-compat-util.h: Honor HP C's noreturn attribute
 + Makefile: add NO_FNMATCH_CASEFOLD to HP-UX section

* nd/init-gitdir (2011-03-03) 1 commit
 - init, clone: support --real-git-dir for .git file

--------------------------------------------------
[Graduated to "master"]

* jc/grep--no-index-pathspec-fix (2011-02-16) 1 commit
 + grep --no-index: honor pathspecs correctly

* jk/diffstat-binary (2011-02-19) 2 commits
 + diff: don't retrieve binary blobs for diffstat
 + diff: handle diffstat of rewritten binary files

* jk/fail-null-clone (2011-02-17) 1 commit
 + clone: die when trying to clone missing local path

* jn/maint-commit-missing-template (2011-02-25) 1 commit
 + commit: error out for missing commit message template

* jn/test-terminal-punt-on-osx-breakage (2011-02-17) 1 commit
 + tests: skip terminal output tests on OS X

* js/checkout-untracked-symlink (2011-02-20) 2 commits
 + do not overwrite untracked symlinks
 + Demonstrate breakage: checkout overwrites untracked symlink with directory

* js/cherry-pick-usability (2011-02-19) 4 commits
 + Teach commit about CHERRY_PICK_HEAD
 + bash: teach __git_ps1 about CHERRY_PICK_HEAD
 + Introduce CHERRY_PICK_HEAD
 + t3507: introduce pristine-detach helper

* lt/rename-no-extra-copy-detection (2011-02-18) 3 commits
 + diffcore-rename: improve estimate_similarity() heuristics
 + diffcore-rename: properly honor the difference between -M and -C
 + for_each_hash: allow passing a 'void *data' pointer to callback

* mg/maint-difftool-vim-readonly (2011-02-25) 1 commit
 + mergetool-lib: call vim in readonly mode for diffs

* mh/p4 (2011-02-25) 1 commit
 + git-p4 submit: prevent 'Jobs' section from being removed from p4 change log

* so/submodule-no-update-first-time (2011-02-17) 2 commits
 + t7406: "git submodule update {--merge|--rebase]" with new submodules
 + submodule: no [--merge|--rebase] when newly cloned

--------------------------------------------------
[Stalled]

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way?

* jc/diff-irreversible-delete (2011-02-28) 1 commit
 - git diff -D: omit the preimage of deletes

Just a POC.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP.

* jc/complete-symmetric-diff (2011-02-23) 1 commit
 - completion: complete "git diff ...branc<TAB>"

It was pointed out that this would regress diffing two blobs,
using <tree>:<path> syntax.

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

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 . diffcore-rename: fall back to -C when -C -C busts the rename limit
 . diffcore-rename: record filepair for rename src
 . diffcore-rename: refactor "too many candidates" logic

Somebody said that this is an expensive no-op?

--------------------------------------------------
[Cooking]

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
 - fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 - submodule update: Don't fetch when the submodule commit is already present
 - fetch/pull: Don't recurse into a submodule when commits are already present
 - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 - config: teach the fetch.recurseSubmodules option the 'on-demand' value
 - fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 - fetch/pull: recurse into submodules when necessary

* mm/push-default-advice (2011-03-02) 2 commits
  (merged to 'next' on 2011-03-09 at 160095b)
 + push: better error message when no remote configured
 + push: better error messages when push.default = tracking

* sp/maint-fd-limit (2011-03-02) 3 commits
  (merged to 'next' on 2011-03-09 at 389e97d)
 + sha1_file.c: Don't retain open fds on small packs
 + mingw: add minimum getrlimit() compatibility stub
 + Limit file descriptors used by packs

* uk/ls-remote-in-get-remote-url (2011-03-01) 2 commits
  (merged to 'next' on 2011-03-09 at 09b570b)
 + git-request-pull: open-code the only invocation of get_remote_url
 + get_remote_url(): use the same data source as ls-remote to get remote urls

* fk/maint-cvsimport-early-failure (2011-01-31) 1 commit
  (merged to 'next' on 2011-03-09 at b4dee9e)
 + git-cvsimport.perl: Bail out right away when reading from the server fails

* jk/strbuf-vaddf (2011-03-08) 3 commits
  (merged to 'next' on 2011-03-09 at 9651bc5)
 + compat: fall back on __va_copy if available
 + strbuf: add strbuf_vaddf
 + compat: provide a fallback va_copy definition
 (this branch is used by ab/i18n-st, jk/trace-sifter and jn/status-translatable.)

* jk/trace-sifter (2011-02-24) 6 commits
  (merged to 'next' on 2011-03-09 at 07841db)
 + trace: give repo_setup trace its own key
 + add packet tracing debug code
 + trace: add trace_strbuf
 + trace: factor out "do we want to trace" logic
 + trace: refactor to support multiple env variables
 + trace: add trace_vprintf
 (this branch uses jk/strbuf-vaddf; is tangled with ab/i18n-st and jn/status-translatable.)

* jn/maint-instaweb-plack-fix (2011-02-26) 1 commit
  (merged to 'next' on 2011-03-09 at 3c9e14b)
 + git-instaweb: Change how gitweb.psgi is made runnable as standalone app

* jn/status-translatable (2011-02-25) 3 commits
  (merged to 'next' on 2011-03-09 at d00d23d)
 + commit, status: use status_printf{,_ln,_more} helpers
 + commit: refer to commit template as s->fp
 + wt-status: add helpers for printing wt-status lines
 (this branch uses jk/strbuf-vaddf; is tangled with ab/i18n-st and jk/trace-sifter.)

* nd/rfc-add-u-full-tree (2011-02-07) 1 commit
 - add: make "add -u" update full tree without pathspec

* ss/git-gui-mergetool (2011-02-26) 2 commits
 - mergetool--lib: Add Beyond Compare 3 as a tool
 - mergetool--lib: Sort tools alphabetically for easier lookup

* ss/mergetool--lib (2011-02-27) 2 commits
  (merged to 'next' on 2011-03-09 at 004fb9c)
 + mergetool--lib: Add Beyond Compare 3 as a tool
 + mergetool--lib: Sort tools alphabetically for easier lookup

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

I'll try to find time to fill in the details.

* ab/i18n-st (2011-02-22) 79 commits
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
 - i18n: "make distclean" should clean up after "make pot"
 - i18n: Makefile: "pot" target to extract messages marked for translation
 - i18n: avoid conflict with ngettext from libintl
 - i18n: add stub ngettext implementation
 - i18n: do not poison translations unless GIT_GETTEXT_POISON envvar is set
 - i18n: add GETTEXT_POISON to simulate unfriendly translator
 - i18n: add no-op _() and N_() wrappers
 - commit, status: use status_printf{,_ln,_more} helpers
 - commit: refer to commit template as s->fp
 - wt-status: add helpers for printing wt-status lines
 (this branch uses jk/strbuf-vaddf; is tangled with jk/trace-sifter and jn/status-translatable.)

Added ngettext() stuff to the base.
Will merge early parts to 'next'.

* jc/checkout-orphan-warning (2011-02-18) 1 commit
  (merged to 'next' on 2011-03-09 at 765cf75)
 + commit: give final warning when reattaching HEAD to leave commits behind

* jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
  (merged to 'next' on 2011-03-09 at 13a9328)
 + branch/checkout --track: Ensure that upstream branch is indeed a branch

* jk/merge-rename-ux (2011-02-20) 6 commits
  (merged to 'next' on 2011-03-09 at df1943a)
 + pull: propagate --progress to merge
 + merge: enable progress reporting for rename detection
 + add inexact rename detection progress infrastructure
 + commit: stop setting rename limit
 + bump rename limit defaults (again)
 + merge: improve inexact rename limit warning

* mg/rev-list-one-side-only (2011-03-07) 9 commits
 - t6007: test rev-list --cherry
 - log --cherry: a synonym
 - rev-list: documentation and test for --cherry-mark
 - revision.c: introduce --cherry-mark
 - rev-list/log: factor out revision mark generation
 - rev-list: --left/right-only are mutually exclusive
 - rev-list: documentation and test for --left/right-only
 - t6007: Make sure we test --cherry-pick
 - revlist.c: introduce --left/right-only for unsymmetric picking

Will merge to 'next'. Looked much nicer than the previous round.

* jk/format-patch-multiline-header (2011-02-23) 3 commits
  (merged to 'next' on 2011-03-09 at f970fe3)
 + format-patch: rfc2047-encode newlines in headers
 + format-patch: wrap long header lines
 + strbuf: add fixed-length version of add_wrapped_text

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
