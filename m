From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #05; Fri, 14)
Date: Fri, 14 Oct 2011 16:23:21 -0700
Message-ID: <7vd3dzximu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 01:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REr6N-0003Jb-Th
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 01:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab1JNXX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 19:23:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab1JNXXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 19:23:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA0C351AC;
	Fri, 14 Oct 2011 19:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	8M7OUQ9nO+SBMrhjq9gfkGgKWE=; b=MNPzl95DwxXe/y3C/z/wpI28eLBZzDY7O
	iy53FQWr/KkMQ4M3NMKQhlSn5Jp9i8Pqn/kkPfGD/FrNMpLKYMFoHqhO1FxaG9aj
	ld+wQtyzHoPrf2g9Gd0W68lEdIHKEOOzgy94z7+7WNIGW0XF7BTz0UKBUFR8lFu3
	i00sX9oNXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Lsw
	wpJI2CmSRxaq6rjzhHlqxCWaqoSay3DqgPALuPBmsF+B1k9ztkCxTkuRMG2fcjax
	d1tWJkhR3JJp/i8XQyC2qeuxyA8r3EW+ArL1fo4BEwkc7HG7LKYAKEHYvDbCNWkz
	cSayMwGl0d6Uloe/KhD4qT/+LqmIdLemgDsewptg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B106C51AB;
	Fri, 14 Oct 2011 19:23:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4409E51A9; Fri, 14 Oct 2011
 19:23:23 -0400 (EDT)
X-master-at: 463b0ea22b5b9a882e8140d0308433d8cbd0d1fe
X-next-at: b91c5812e819aca51af2c0611009f305f0a29b4f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82B045E8-F6BB-11E0-BC67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183630>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The second and third wave of topics have graduated to 'master'.

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

--------------------------------------------------
[New Topics]

* jk/config-test-cleanup (2011-10-12) 2 commits
  (merged to 'next' on 2011-10-12 at 7c857dd)
 + t1300: test mixed-case variable retrieval
 + t1300: put git invocations inside test function

Will merge to 'master' in the fourth wave.

* jm/maint-apply-detects-corrupt-patch-header (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 80d9503)
 + fix "git apply --index ..." not to deref NULL

Will merge to 'master' in the fifth wave.

* mh/ref-api (2011-10-12) 7 commits
 - clear_cached_refs(): inline function
 - write_ref_sha1(): only invalidate the loose ref cache
 - clear_cached_refs(): extract two new functions
 - clear_cached_refs(): rename parameter
 - invalidate_ref_cache(): expose this function in refs API
 - invalidate_ref_cache(): take the submodule as parameter
 - invalidate_ref_cache(): rename function from invalidate_cached_refs()

The first rename felt somewhat inconsistent in that it reworded the object
of one particular verb "invalidate" to "ref_cache" but otherwise that
entity is left as "cached_refs" throughout the codebase.

The updated series looked almost all trivial and sensible but they would
depend on this renaming, so I haven't queued them here yet. Personally I
think we should either not rename just the function name (i.e. drop the
first patch in this series) or rename both the function and what it
operates on (i.e. enhance the first patch in this series).

* bk/submodule-in-recursive-merge (2011-10-13) 2 commits
 - submodule: Search for merges only at end of recursive merge
 - submodule: Demonstrate known breakage during recursive merge

Brad helped resurrecting good bits earlier tangled in the stalled topic
hv/submodule-merge-search by mistake.
Will merge to 'next'.

* jk/pull-rebase-with-work-tree (2011-10-13) 1 commit
 - pull,rebase: handle GIT_WORK_TREE better

Looked reasonable.
Will merge to 'next'.

* sg/complete-refs (2011-10-12) 10 commits
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
 (this branch uses sg/completion, tm/completion-commit-fixup-squash and tm/completion-push-set-upstream.)

Re-roll expected.

* jc/unseekable-bundle (2011-10-13) 2 commits
 - bundle: add parse_bundle_header() helper function
 - bundle: allowing to read from an unseekable fd

I am not entirely happy with the first patch but it is not so bad either.

* js/check-ref-format-test-mingw (2011-10-13) 1 commit
 - t1402-check-ref-format: skip tests of refs beginning with slash on Windows

Will merge to 'next'.

* jk/daemon-msgs (2011-10-14) 1 commit
 - daemon: give friendlier error messages to clients

Will merge to 'next'.

* jk/http-auth (2011-10-14) 6 commits
 - http_init: accept separate URL parameter
 - http: use hostname in credential description
 - http: retry authentication failures for all http requests
 - remote-curl: don't retry auth failures with dumb protocol
 - improve httpd auth tests
 - url: decode buffers that are not NUL-terminated
 (this branch is tangled with jk/http-auth-keyring and js/cred-macos-x-keychain-2.)

Michael helped resurrecting uncontentious bits from the credential series.
Will merge to 'next'.

* jk/maint-pack-objects-compete-with-delete (2011-10-14) 2 commits
 - downgrade "packfile cannot be accessed" errors to warnings
 - pack-objects: protect against disappearing packs

Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* bw/grep-no-index-no-exclude (2011-09-15) 2 commits
  (merged to 'next' on 2011-10-06 at 325270b)
 + grep --no-index: don't use git standard exclusions
 + grep: do not use --index in the short usage output
 (this branch is used by jc/grep-untracked-exclude and jc/maint-grep-untracked-exclude.)

Originally merged to 'next' on 2011-09-26.

* cb/do-not-pretend-to-hijack-long-help (2011-10-05) 1 commit
  (merged to 'next' on 2011-10-06 at 46851fe)
 + use -h for synopsis and --help for manpage consistently

* cp/git-web-browse-browsers (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at da42ad0)
 + git-web--browse: avoid the use of eval

* cs/perl-config-path-send-email (2011-09-30) 2 commits
  (merged to 'next' on 2011-10-06 at 93c00f0)
 + use new Git::config_path() for aliasesfile
 + Add Git::config_path()

Originally merged to 'next' on 2011-10-05.

* di/fast-import-empty-tag-note-fix (2011-09-22) 2 commits
  (merged to 'next' on 2011-10-06 at 3a01ef1)
 + fast-import: don't allow to note on empty branch
 + fast-import: don't allow to tag empty branch

Originally merged to 'next' on 2011-10-05.

* il/archive-err-signal (2011-10-05) 1 commit
  (merged to 'next' on 2011-10-06 at 7e3083f)
 + Support ERR in remote archive like in fetch/push

* jc/apply-blank-at-eof-fix (2011-09-26) 1 commit
  (merged to 'next' on 2011-10-06 at a9dfd8f)
 + apply --whitespace=error: correctly report new blank lines at end

Originally merged to 'next' on 2011-10-05.

* jc/grep-untracked-exclude (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at b16cffe)
 + Merge branch 'jc/maint-grep-untracked-exclude' into jc/grep-untracked-exclude
 (this branch uses bw/grep-no-index-no-exclude and jc/maint-grep-untracked-exclude.)

* jc/is-url-simplify (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at d6c6741)
 + url.c: simplify is_url()

* jc/maint-grep-untracked-exclude (2011-10-04) 1 commit
 + grep: teach --untracked and --exclude-standard options
 (this branch is used by jc/grep-untracked-exclude; uses bw/grep-no-index-no-exclude.)

* jc/parse-options-boolean (2011-09-28) 5 commits
  (merged to 'next' on 2011-10-06 at dd4936c)
 + apply: use OPT_NOOP_NOARG
 + revert: use OPT_NOOP_NOARG
 + parseopt: add OPT_NOOP_NOARG
 + archive.c: use OPT_BOOL()
 + parse-options: deprecate OPT_BOOLEAN

* jn/ident-from-etc-mailname (2011-10-06) 2 commits
  (merged to 'next' on 2011-10-06 at a68770d)
 + ident: do not retrieve default ident when unnecessary
 + ident: check /etc/mailname if email is unknown

* jn/no-g-plus-s-on-bsd (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 3d85674)
 + Makefile: do not set setgid bit on directories on GNU/kFreeBSD

* js/maint-merge-one-file-osx-expr (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-07 at fbb28a2)
 + merge-one-file: fix "expr: non-numeric argument"

* nd/daemon-log-sock-errors (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 5f3630f)
 + daemon: log errors if we could not use some sockets

* nd/document-err-packet (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 0c5f5d0)
 + pack-protocol: document "ERR" line

* nd/git-daemon-error-msgs (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 209126d)
 + daemon: return "access denied" if a service is not allowed

* nd/maint-autofix-tag-in-head (2011-09-18) 4 commits
  (merged to 'next' on 2011-10-06 at c083e69)
 + Accept tags in HEAD or MERGE_HEAD
 + merge: remove global variable head[]
 + merge: use return value of resolve_ref() to determine if HEAD is invalid
 + merge: keep stash[] a local variable

Originally merged to 'next' on 2011-09-27.

* nd/maint-sparse-errors (2011-09-22) 2 commits
  (merged to 'next' on 2011-10-06 at e3cbb90)
 + Add explanation why we do not allow to sparse checkout to empty working tree
 + sparse checkout: show error messages when worktree shaping fails

Originally merged to 'next' on 2011-09-22.

* rs/diff-cleanup-records-fix (2011-10-03) 2 commits
  (merged to 'next' on 2011-10-06 at 91f035f)
 + diff: resurrect XDF_NEED_MINIMAL with --minimal
 + Revert removal of multi-match discard heuristic in 27af01

* rs/name-rev-usage (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at e51878e)
 + name-rev: split usage string

Originally merged to 'next' on 2011-10-05.

* rs/pending (2011-10-03) 8 commits
  (merged to 'next' on 2011-10-06 at 998462b)
 + commit: factor out clear_commit_marks_for_object_array
 + checkout: use leak_pending flag
 + bundle: use leak_pending flag
 + bisect: use leak_pending flag
 + revision: add leak_pending flag
 + checkout: use add_pending_{object,sha1} in orphan check
 + revision: factor out add_pending_sha1
 + checkout: check for "Previous HEAD" notice in t2020

* rs/test-ctype (2011-10-03) 2 commits
  (merged to 'next' on 2011-10-06 at b8c26d2)
 + test-ctype: add test for is_pathspec_magic
 + test-ctype: macrofy

Originally merged to 'next' on 2011-10-05.

* sp/smart-http-failure (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at 02f9982)
 + remote-curl: Fix warning after HTTP failure

* zj/send-email-authen-sasl (2011-09-29) 1 commit
  (merged to 'next' on 2011-10-06 at 78b31cd)
 + send-email: auth plain/login fix

Originally merged to 'next' on 2011-10-05.

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

* cn/fetch-prune (2011-10-07) 4 commits
 - fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
 - fetch: honor the user-provided refspecs when pruning refs
 - t5510: add tests for fetch --prune
 - fetch: free all the additional refspecs

Probably needs a little bit more polish to reduce code duplication between
existing remote_find_tracking() and new find_in_refs().

* jn/gitweb-manpages (2011-10-10) 6 commits
 . gitweb: Add gitweb manpages to 'gitweb' package in git.spec
 . Documentation: Add gitweb config variables to git-config(1)
 . Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
 . gitweb: Add manpage for gitweb
 . gitweb: Add manpage for gitweb configuration files
 . Documentation: Preparation for gitweb manpages

A re-roll already being discussed.

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

* ef/mingw-syslog (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d5d6945)
 + mingw: avoid using strbuf in syslog

Will merge to 'master' in the fourth wave.

* jk/name-hash-dirent (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at e2ea68b)
 + fix phantom untracked files when core.ignorecase is set

Will merge to 'master' in the fourth wave.

* js/merge-edit-option (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at db28da3)
 + Teach merge the '[-e|--edit]' option

Will merge to 'master' in the fifth wave.

* mm/maint-config-explicit-bool-display (2011-10-10) 1 commit
  (merged to 'next' on 2011-10-11 at 795939f)
 + config: display key_delim for config --bool --get-regexp

Will merge to 'master' in the fourth wave.

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

* sg/completion (2011-10-10) 2 commits
  (merged to 'next' on 2011-10-11 at 4724640)
 + completion: unite --format and --pretty for 'log' and 'show'
 + completion: unite --reuse-message and --reedit-message for 'notes'
 (this branch is used by sg/complete-refs; uses tm/completion-commit-fixup-squash.)

Will merge to 'master' in the fourth wave.

* tc/fetch-leak (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d867153)
 + fetch: plug two leaks on error exit in store_updated_refs

Will merge to 'master' in the fourth wave.

* jc/check-ref-format-fixup (2011-10-12) 2 commits
 - Restrict ref-like names immediately below $GIT_DIR
 - refs.c: move dwim_ref()/dwim_log() from sha1_name.c

An attempt to fix-up unfortunate side effect of mh/check-ref-format-3
topic. "git show -s config" is never meant to refer to $GIT_DIR/config
and treat it as a file that records an object name.

Will merge to 'next'.

* jc/maint-remove-renamed-ref (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 819c3e4)
 + branch -m/-M: remove undocumented RENAMED-REF

Will merge to 'master' in the fifth wave.

* tm/completion-commit-fixup-squash (2011-10-06) 2 commits
  (merged to 'next' on 2011-10-11 at 6bb192e)
 + completion: commit --fixup and --squash
 + completion: unite --reuse-message and --reedit-message handling
 (this branch is used by sg/complete-refs and sg/completion.)

Will merge to 'master' in the fourth wave.

* tm/completion-push-set-upstream (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-11 at 85544e5)
 + completion: push --set-upstream
 (this branch is used by sg/complete-refs.)

Will merge to 'master' in the fourth wave.

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

* jc/checkout-from-tree-keep-local-changes (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 64061aa)
 + checkout $tree $path: do not clobber local changes in $path not in $tree

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the fourth wave.

* ph/push-to-delete-nothing (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 33ac777)
 + receive-pack: don't pass non-existent refs to post-{receive,update} hooks

Will merge to 'master' in the fourth wave.

* js/bisect-no-checkout (2011-09-21) 1 commit
  (merged to 'next' on 2011-10-06 at 0354e94)
 + bisect: fix exiting when checkout failed in bisect_start()

Originally merged to 'next' on 2011-09-21.
Will merge to 'master' in the fourth wave.

* jc/request-pull-show-head-4 (2011-10-09) 10 commits
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

Will merge to 'master' in the fifth wave.

* bc/attr-ignore-case (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-11 at daa6b51)
 + attr.c: respect core.ignorecase when matching attribute patterns
 + attr: read core.attributesfile from git_default_core_config
 + builtin/mv.c: plug miniscule memory leak
 + cleanup: use internal memory allocation wrapper functions everywhere
 + attr.c: avoid inappropriate access to strbuf "buf" member

Will merge to 'master' in the fourth wave.

--------------------------------------------------
[Discarded]

* jk/http-auth-keyring (2011-10-12) 23 commits
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
 - http: retry authentication failures for all http requests
 - remote-curl: don't retry auth failures with dumb protocol
 - improve httpd auth tests
 - url: decode buffers that are not NUL-terminated
 (this branch is used by js/cred-macos-x-keychain-2; is tangled with jk/http-auth.)

Discarded without prejudice to allow design level discussions to continue.
Expecting a re-roll based on jk/http-auth

* js/cred-macos-x-keychain-2 (2011-10-12) 1 commit
 . contrib: add a pair of credential helpers for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring; is tangled with jk/http-auth.)

Discarded without prejudice to allow design level discussions to continue.
Expecting a re-roll based on jk/http-auth
