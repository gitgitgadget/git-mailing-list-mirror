From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #06; Tue, 18)
Date: Tue, 18 Oct 2011 00:50:24 -0700
Message-ID: <7vzkgyhh6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 09:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4RY-00089S-8e
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359Ab1JRHua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:50:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757253Ab1JRHu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:50:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CD73E0C;
	Tue, 18 Oct 2011 03:50:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	MNvkWZqy5UaQMQEsJaD0a1fwD0=; b=dccNnRg/hRT1NczOf7LJqugUPxQKnzTUQ
	Gqb3E9bAj5F1mFEMLuXHO5zXami9vg57jbfwcW+/d75WLOcKhAKmIwfVWFw9u/Zh
	VGNLrSgGKfQalPE2Z/lj7NJUCplYbSGr7QxPW/4sAy1CzXTUTQvfZMpLFQcVRjpt
	gl3ZWrdG2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=EEl
	9yHmdAATnCSrK3mVD4celx2gVbH4zyCZ8tTNIBsE30Fq/YjSsgV6gk7m9fWhJR4B
	sQEIOsPC/wUtr/J6GflhXNbJ6M1X6aXg3nP7I36Fy8rtHSinBOH4vnupv1Hot8Zo
	L7ZqhjsCY2HHjUG/N67Jvkr6QPbUnOvVqxpR2OsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F453E0B;
	Tue, 18 Oct 2011 03:50:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C15423E0A; Tue, 18 Oct 2011
 03:50:26 -0400 (EDT)
X-master-at: 08cfdbb88cd6225b4fc4b8a3cecd0e01758c835d
X-next-at: 84fb7e6e14c3124e875b0326d84f1a4347e044d5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7BF422E-F95D-11E0-8170-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183870>

What's cooking in git.git (Oct 2011, #06; Tue, 18)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fourth batch of topics have graduated to the master branch. This batch
ended up to be mostly fixes, as can be seen in the updates in the RelNotes
file. These topics will be further merged down to the maint branch for the
1.7.7.1 maintenance release.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo, html and man:

	git://git.kernel.org/pub/scm/git/git.git
	git://repo.or.cz/alt-git.git
	https://code.google.com/p/git-core/
	https://github.com/git/git

With only maint, master, html and man:

	git://git.sourceforge.jp/gitroot/git-core/git.git
	git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches but not todo, html or man:

	https://github.com/gitster/git

By the way, I am planning to stop pushing the generated documentation
branches to the above repositories in the near term, as they are not
sources. The only reason the source repository at k.org has hosted these
branches was because it was the only repository over there that was
writable by me; it was an ugly historical and administrative workaround
and not a demonstration of the best practice.

They are pushed to their own separate repositories instead:

	git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
	git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[Graduated to "master"]

* bc/attr-ignore-case (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-11 at daa6b51)
 + attr.c: respect core.ignorecase when matching attribute patterns
 + attr: read core.attributesfile from git_default_core_config
 + builtin/mv.c: plug miniscule memory leak
 + cleanup: use internal memory allocation wrapper functions everywhere
 + attr.c: avoid inappropriate access to strbuf "buf" member

* ef/mingw-syslog (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d5d6945)
 + mingw: avoid using strbuf in syslog

* jc/checkout-from-tree-keep-local-changes (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 64061aa)
 + checkout $tree $path: do not clobber local changes in $path not in $tree

Originally merged to 'next' on 2011-10-05.

* jk/config-test-cleanup (2011-10-12) 2 commits
  (merged to 'next' on 2011-10-12 at 7c857dd)
 + t1300: test mixed-case variable retrieval
 + t1300: put git invocations inside test function

* jk/http-auth (2011-10-15) 6 commits
  (merged to 'next' on 2011-10-15 at 2ff0053)
 + http_init: accept separate URL parameter
 + http: use hostname in credential description
 + http: retry authentication failures for all http requests
 + remote-curl: don't retry auth failures with dumb protocol
 + improve httpd auth tests
 + url: decode buffers that are not NUL-terminated
 (this branch is tangled with jk/http-auth-keyring and js/cred-macos-x-keychain-2.)

Michael helped resurrecting uncontentious bits from the credential series.

* jk/name-hash-dirent (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at e2ea68b)
 + fix phantom untracked files when core.ignorecase is set

* jk/pull-rebase-with-work-tree (2011-10-13) 1 commit
  (merged to 'next' on 2011-10-15 at 2707482)
 + pull,rebase: handle GIT_WORK_TREE better

* js/bisect-no-checkout (2011-09-21) 1 commit
  (merged to 'next' on 2011-10-06 at 0354e94)
 + bisect: fix exiting when checkout failed in bisect_start()

Originally merged to 'next' on 2011-09-21.

* js/check-ref-format-test-mingw (2011-10-13) 1 commit
  (merged to 'next' on 2011-10-15 at fbc2ee6)
 + t1402-check-ref-format: skip tests of refs beginning with slash on Windows

* mm/maint-config-explicit-bool-display (2011-10-10) 1 commit
  (merged to 'next' on 2011-10-11 at 795939f)
 + config: display key_delim for config --bool --get-regexp

* ph/push-to-delete-nothing (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 33ac777)
 + receive-pack: don't pass non-existent refs to post-{receive,update} hooks

* sg/completion (2011-10-10) 2 commits
  (merged to 'next' on 2011-10-11 at 4724640)
 + completion: unite --format and --pretty for 'log' and 'show'
 + completion: unite --reuse-message and --reedit-message for 'notes'
 (this branch is used by sg/complete-refs; uses tm/completion-commit-fixup-squash.)

* tc/fetch-leak (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d867153)
 + fetch: plug two leaks on error exit in store_updated_refs

* tm/completion-commit-fixup-squash (2011-10-06) 2 commits
  (merged to 'next' on 2011-10-11 at 6bb192e)
 + completion: commit --fixup and --squash
 + completion: unite --reuse-message and --reedit-message handling
 (this branch is used by sg/complete-refs and sg/completion.)

* tm/completion-push-set-upstream (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-11 at 85544e5)
 + completion: push --set-upstream
 (this branch is used by sg/complete-refs.)

--------------------------------------------------
[New Topics]

* md/smtp-tls-hello-again (2011-10-15) 1 commit
  (merged to 'next' on 2011-10-16 at 3e27de4)
 + send-email: Honour SMTP domain when using TLS

Will merge to 'master' soonish.

* pt/mingw-misc-fixes (2011-10-15) 7 commits
  (merged to 'next' on 2011-10-16 at 2dc0b55)
 + t9901: fix line-ending dependency on windows
 + mingw: ensure sockets are initialized before calling gethostname
 + mergetools: use the correct tool for Beyond Compare 3 on Windows
 + t9300: do not run --cat-blob-fd related tests on MinGW
 + git-svn: On MSYS, escape and quote SVN_SSH also if set by the user
 + t9001: do not fail only due to CR/LF issues
 + t1020: disable the pwd test on MinGW

Will merge to 'master' soonish.

* pw/p4-update (2011-10-17) 6 commits
  (merged to 'next' on 2011-10-17 at f69f6cc)
 + git-p4: handle files with shell metacharacters
 + git-p4: keyword flattening fixes
 + git-p4: stop ignoring apple filetype
 + git-p4: recognize all p4 filetypes
 + git-p4: handle utf16 filetype properly
 + git-p4 tests: refactor and cleanup

Will merge to 'master' in the fifth wave.

* cn/doc-config-bare-subsection (2011-10-16) 1 commit
  (merged to 'next' on 2011-10-17 at a6412d4)
 + Documentation: update [section.subsection] to reflect what git does

Will merge to 'master' in the fifth wave.

* cb/daemon-permission-errors (2011-10-17) 2 commits
 - daemon: report permission denied error to clients
 - daemon: add tests
 (this branch uses jk/daemon-msgs.)

The tip commit might be loosening things a bit too much.
Will keep in 'pu' until hearing a convincing argument for the patch.

* cb/httpd-test-fix-port (2011-10-17) 1 commit
  (merged to 'next' on 2011-10-17 at 84fb7e6)
 + use test number as port number

Will merge to 'master' soonish.

* jc/verbose-checkout (2011-10-16) 2 commits
 - checkout -v: give full status output after switching branches
 - checkout: move the local changes report to the end

This is just to leave a record that the reason why we do not do this not
because we are incapable of coding this, but because it is not a good idea
to do this. I suspect people who are new to git that might think they need
it would soon realize the don't.

Will keep in 'pu' as a showcase for a while and then will drop.

* kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
 - gitweb: add a feature to show side-by-side diff
 - gitweb: change format_diff_line() to remove leading SP from $diff_class

Fun.
Will keep in 'pu' until the planned re-roll comes.

* mh/ref-api-2 (2011-10-17) 14 commits
 - resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 - Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 - resolve_gitlink_ref(): improve docstring
 - get_ref_dir(): change signature
 - refs: change signatures of get_packed_refs() and get_loose_refs()
 - is_dup_ref(): extract function from sort_ref_array()
 - add_ref(): add docstring
 - parse_ref_line(): add docstring
 - is_refname_available(): remove the "quiet" argument
 - clear_ref_array(): rename from free_ref_array()
 - refs: rename parameters result -> sha1
 - refs: rename "refname" variables
 - struct ref_entry: document name member
 - cache.h: add comments for git_path() and git_path_submodule()
 (this branch uses mh/ref-api.)

Will merge to 'next'.

* po/insn-editor (2011-10-17) 1 commit
 - "rebase -i": support special-purpose editor to edit insn sheet

Will merge to 'next'.

* dm/pack-objects-update (2011-10-18) 4 commits
 - pack-objects: don't traverse objects unnecessarily
 - pack-objects: rewrite add_descendants_to_write_order() iteratively
 - pack-objects: use unsigned int for counter and offset values
 - pack-objects: mark add_to_write_order() as inline

* jk/git-tricks (2011-10-18) 3 commits
 - completion: match ctags symbol names in grep patterns
 - contrib: add git-jump script
 - contrib: add diff highlight script

* jc/make-tags (2011-10-18) 1 commit
 - Makefile: ask "ls-files" to list source files if available

--------------------------------------------------
[Stalled]

* hv/submodule-merge-search (2011-10-13) 4 commits
 - submodule.c: make two functions static
 - allow multiple calls to submodule merge search for the same path
 - push: Don't push a repository with unpushed submodules
 - push: teach --recurse-submodules the on-demand option

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

The fix-up at the tip queued on fg/submodule-auto-push topic has been
moved to this topic.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

Perhaps 281eee4 (revision: keep track of the end-user input from the
command line, 2011-08-25) would help.

* rr/revert-cherry-pick (2011-10-12) 7 commits
 - revert: further simplify parsing of a line in insn sheet
 - revert: Simplify passing command-line arguments around
 - revert: Allow mixed pick and revert instructions
 - revert: Make commit descriptions in insn sheet optional
 - revert: Fix buffer overflow in insn sheet parser
 - revert: Simplify getting commit subject
 - revert: Free memory after get_message call

Probably needs a little bit more polish, e.g. squashing the tip fixup into
an earlier one in the series.

* jc/signed-commit (2011-10-05) 4 commits
 - commit: teach --gpg-sign option
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message

This is to replace the earlier "signed push" experiments. "verify-tag"
equivalent needs to be written before this can proceed. I suspect that
teaching "verify-tag" to notice and also handle signed commits would be
the easiest, but "git tag --verify $commit" might look slightly funny
from the UI POV. I dunno.

* jc/lookup-object-hash (2011-08-11) 6 commits
 - object hash: replace linear probing with 4-way cuckoo hashing
 - object hash: we know the table size is a power of two
 - object hash: next_size() helper for readability
 - pack-objects --count-only
 - object.c: remove duplicated code for object hashing
 - object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload.

--------------------------------------------------
[Cooking]

* mh/ref-api (2011-10-16) 7 commits
  (merged to 'next' on 2011-10-17 at 219000f)
 + clear_ref_cache(): inline function
 + write_ref_sha1(): only invalidate the loose ref cache
 + clear_ref_cache(): extract two new functions
 + clear_ref_cache(): rename parameter
 + invalidate_ref_cache(): expose this function in the refs API
 + invalidate_ref_cache(): take the submodule as parameter
 + invalidate_ref_cache(): rename function from invalidate_cached_refs()
 (this branch is used by mh/ref-api-2.)

Will merge to 'master' in the sixth wave.

* jn/gitweb-manpages (2011-10-16) 5 commits
  (merged to 'next' on 2011-10-16 at 6555a07)
 + gitweb: Add gitweb manpages to 'gitweb' package in git.spec
 + Documentation: Add gitweb config variables to git-config(1)
 + Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
 + gitweb: Add gitweb(1) manpage for gitweb itself
 + gitweb: Add gitweb.conf(5) manpage for gitweb configuration files

Will merge to 'master' soonish.

* jm/maint-apply-detects-corrupt-patch-header (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 80d9503)
 + fix "git apply --index ..." not to deref NULL

Will merge to 'master' soonish.

* bk/submodule-in-recursive-merge (2011-10-13) 2 commits
  (merged to 'next' on 2011-10-15 at e02205c)
 + submodule: Search for merges only at end of recursive merge
 + submodule: Demonstrate known breakage during recursive merge

Brad helped resurrecting good bits earlier tangled in the stalled topic
hv/submodule-merge-search by mistake.

Will merge to 'master' soonish.

* sg/complete-refs (2011-10-15) 10 commits
 - completion: remove broken dead code from __git_heads() and __git_tags()
 - completion: fast initial completion for config 'remote.*.fetch' value
 - completion: improve ls-remote output filtering in __git_refs_remotes()
 - completion: query only refs/heads/ in __git_refs_remotes()
 - completion: support full refs from remote repositories
 - completion: improve ls-remote output filtering in __git_refs()
 - completion: make refs completion consistent for local and remote repos
 - completion: optimize refs completion
 - completion: document __gitcomp()
 - Merge branches 'tm/completion-push-set-upstream', 'tm/completion-commit-fixup-squash' and 'sg/completion' into HEAD

Rerolled.

Will keep in 'pu' until an Ack or two from people who have worked on the
completion in the past comes.

* jc/unseekable-bundle (2011-10-13) 2 commits
 - bundle: add parse_bundle_header() helper function
 - bundle: allowing to read from an unseekable fd

I am not entirely happy with the first patch but it is not so bad either.
Will merge to 'next'.

* jk/daemon-msgs (2011-10-15) 1 commit
  (merged to 'next' on 2011-10-15 at 415cf53)
 + daemon: give friendlier error messages to clients
 (this branch is used by cb/daemon-permission-errors.)

Will merge to 'master' in the fifth wave.

* jk/maint-pack-objects-compete-with-delete (2011-10-14) 2 commits
  (merged to 'next' on 2011-10-15 at 49479e4)
 + downgrade "packfile cannot be accessed" errors to warnings
 + pack-objects: protect against disappearing packs

Will merge to 'master' in the fifth wave.

* cn/fetch-prune (2011-10-15) 5 commits
  (merged to 'next' on 2011-10-16 at 02a449e)
 + fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
 + fetch: honor the user-provided refspecs when pruning refs
 + remote: separate out the remote_find_tracking logic into query_refspecs
 + t5510: add tests for fetch --prune
 + fetch: free all the additional refspecs

Will merge to 'master' in the sixth wave.

* js/merge-edit-option (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at db28da3)
 + Teach merge the '[-e|--edit]' option

Will merge to 'master' in the fifth wave.

* rs/diff-whole-function (2011-10-10) 2 commits
  (merged to 'next' on 2011-10-11 at 6196752)
 + diff: add option to show whole functions as context
 + xdiff: factor out get_func_line()

Will merge to 'master' in the fifth wave.

* rs/pickaxe (2011-10-07) 7 commits
  (merged to 'next' on 2011-10-11 at 27d02b2)
 + pickaxe: factor out pickaxe
 + pickaxe: give diff_grep the same signature as has_changes
 + pickaxe: pass diff_options to contains and has_changes
 + pickaxe: factor out has_changes
 + pickaxe: plug regex/kws leak
 + pickaxe: plug regex leak
 + pickaxe: plug diff filespec leak with empty needle

Will merge to 'master' in the fifth wave.

* sc/difftool-skip (2011-10-14) 2 commits
  (merged to 'next' on 2011-10-14 at b91c581)
 + t7800: avoid arithmetic expansion notation
  (merged to 'next' on 2011-10-11 at 38d7e84)
 + git-difftool: allow skipping file by typing 'n' at prompt

Will merge to 'master' in the fifth wave.

* jc/check-ref-format-fixup (2011-10-12) 2 commits
  (merged to 'next' on 2011-10-15 at 8e89bc5)
 + Restrict ref-like names immediately below $GIT_DIR
 + refs.c: move dwim_ref()/dwim_log() from sha1_name.c

An attempt to fix-up unfortunate side effect of mh/check-ref-format-3
topic. "git show -s config" is never meant to refer to $GIT_DIR/config
and treat it as a file that records an object name.

Will merge to 'master' soonish so that we can have enough time to deal
with possible fall-outs.

* jc/maint-remove-renamed-ref (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 819c3e4)
 + branch -m/-M: remove undocumented RENAMED-REF

Will merge to 'master' in the sixth wave.

* js/no-cherry-pick-head-after-punted (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-10 at acb29ee)
 + Merge branch 'js/maint-no-cherry-pick-head-after-punted' into js/no-cherry-pick-head-after-punted
 (this branch uses js/maint-no-cherry-pick-head-after-punted.)

Will merge to 'master' in the fifth wave.

* js/maint-no-cherry-pick-head-after-punted (2011-10-06) 2 commits
 + cherry-pick: do not give irrelevant advice when cherry-pick punted
 + revert.c: defer writing CHERRY_PICK_HEAD till it is safe to do so
 (this branch is used by js/no-cherry-pick-head-after-punted.)

Will merge to 'maint' later.

* js/log-show-children (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at de8f6f2)
 + log --children

Will merge to 'master' in the fifth wave.

* ph/transport-with-gitfile (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-12 at 6d58417)
 + Fix is_gitfile() for files too small or larger than PATH_MAX to be a gitfile
  (merged to 'next' on 2011-10-06 at 891b8b6)
 + Add test showing git-fetch groks gitfiles
 + Teach transport about the gitfile mechanism
 + Learn to handle gitfiles in enter_repo
 + enter_repo: do not modify input

Will merge to 'master' in the fifth wave.

* jc/request-pull-show-head-4 (2011-10-15) 11 commits
  (merged to 'next' on 2011-10-15 at 7e340ff)
 + fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield" sparse error
  (merged to 'next' on 2011-10-10 at 092175e)
 + environment.c: Fix an sparse "symbol not declared" warning
 + builtin/log.c: Fix an "Using plain integer as NULL pointer" warning
  (merged to 'next' on 2011-10-07 at fcaeca0)
 + fmt-merge-msg: use branch.$name.description
  (merged to 'next' on 2011-10-06 at fa5e0fe)
 + request-pull: use the branch description
 + request-pull: state what commit to expect
 + request-pull: modernize style
 + branch: teach --edit-description option
 + format-patch: use branch description in cover letter
 + branch: add read_branch_desc() helper function
 + Merge branch 'bk/ancestry-path' into jc/branch-desc

Will merge to 'master' in the sixth wave.

--------------------------------------------------
[Discarded]

* jk/http-auth-keyring (2011-10-12) 19 commits
 . http_init: accept separate URL parameter
 . credential-cache: don't cache items without context
 . check_expirations: don't copy over same element
 . t0300: add missing EOF terminator for <<
 . credential-store: use a better storage format
 . t0300: make alternate username tests more robust
 . t0300: make askpass tests a little more robust
 . credential-cache: fix expiration calculation corner cases
 . docs: minor tweaks to credentials API
 . credentials: make credential_fill_gently() static
 . credentials: add "getpass" helper
 . credentials: add "store" helper
 . credentials: add "cache" helper
 . docs: end-user documentation for the credential subsystem
 . http: use hostname in credential description
 . allow the user to configure credential helpers
 . look for credentials in config before prompting
 . http: use credential API to get passwords
 . introduce credentials API
 (this branch is used by js/cred-macos-x-keychain-2.)

Discarded without prejudice to allow design level discussions to continue.
Expecting a re-roll based on jk/http-auth

* js/cred-macos-x-keychain-2 (2011-10-12) 1 commit
 . contrib: add a pair of credential helpers for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring.)

Discarded without prejudice to allow design level discussions to continue.
Expecting a re-roll based on jk/http-auth
