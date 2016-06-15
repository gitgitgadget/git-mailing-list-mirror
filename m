From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #04; Wed, 12)
Date: Wed, 12 Oct 2011 11:48:48 -0700
Message-ID: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 20:49:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3rQ-0005tO-CK
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab1JLSsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:48:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957Ab1JLSsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:48:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABE534771;
	Wed, 12 Oct 2011 14:48:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	3jU2L3kODilvwmmmVN/N9EfXmI=; b=gLEbYdwAMPF/d1WzJuqUK3LwNyd5CkW2b
	QnmcQLn75NJL8Iyr70csNQGHCzc8QFDzaMZw5hLpo25Zhju20g9FOmlBLMHckJCG
	4C8QN4CtC4v2ZdYKdDZqpMszI2EhqTLOr5z6qgGWk0YSvfj8YC3C0kG/VIbTA0RZ
	1UezteTwP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YLs
	YxzfnjpaEthy5wVUS7eGCMkSzOuEsNMZYRhMfGsp+Z2CRxdhrqWtNY5V9mvF4XNt
	Ty0EITM4PotBba0NgnYwKeQHGbB9xfmO27Z2BQevPjTLVwGnyOwCVBe80TT/X9U4
	/LtU1lWVoFJTBWy/yXFVnlU5Ytqe9FetXKd+fb6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0A5476E;
	Wed, 12 Oct 2011 14:48:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 669AB476D; Wed, 12 Oct 2011
 14:48:50 -0400 (EDT)
X-master-at: 8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356
X-next-at: 6d5841794ba7a676b5918d0bc8cbad836597555b
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3440EE6-F502-11E0-BC71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183389>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

As reported earlier, 'next' has been rebuilt with some topics kicked back
to 'pu'.  Also, k.org is back.

The second wave of topics are starting to graduate to 'master'.

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

* cn/fetch-prune (2011-10-07) 4 commits
 - fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
 - fetch: honor the user-provided refspecs when pruning refs
 - t5510: add tests for fetch --prune
 - fetch: free all the additional refspecs

* ef/mingw-syslog (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d5d6945)
 + mingw: avoid using strbuf in syslog

* jk/name-hash-dirent (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at e2ea68b)
 + fix phantom untracked files when core.ignorecase is set

* jn/gitweb-manpages (2011-10-10) 6 commits
 . gitweb: Add gitweb manpages to 'gitweb' package in git.spec
 . Documentation: Add gitweb config variables to git-config(1)
 . Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
 . gitweb: Add manpage for gitweb
 . gitweb: Add manpage for gitweb configuration files
 . Documentation: Preparation for gitweb manpages

A re-roll already being discussed.

* js/merge-edit-option (2011-10-10) 2 commits
 - fixup! 0f6adfe2a26287c5c13366975f621c818bb3214d
 - Teach merge the '[-e|--edit]' option

The part to tweak builtin/merge.c in the fix-up should be removed but
otherwise ready to be squashed into one and merged to 'next'.

* mm/maint-config-explicit-bool-display (2011-10-10) 1 commit
  (merged to 'next' on 2011-10-11 at 795939f)
 + config: display key_delim for config --bool --get-regexp

* rr/revert-cherry-pick (2011-10-10) 7 commits
 - fixup! 82d520bd
 - revert: Simplify passing command-line arguments around
 - revert: Allow mixed pick and revert instructions
 - revert: Make commit descriptions in insn sheet optional
 - revert: Fix buffer overflow in insn sheet parser
 - revert: Simplify getting commit subject
 - revert: Free memory after get_message call

Probably needs a little bit more polish.

* rs/diff-whole-function (2011-10-10) 2 commits
  (merged to 'next' on 2011-10-11 at 6196752)
 + diff: add option to show whole functions as context
 + xdiff: factor out get_func_line()

* rs/pickaxe (2011-10-07) 7 commits
  (merged to 'next' on 2011-10-11 at 27d02b2)
 + pickaxe: factor out pickaxe
 + pickaxe: give diff_grep the same signature as has_changes
 + pickaxe: pass diff_options to contains and has_changes
 + pickaxe: factor out has_changes
 + pickaxe: plug regex/kws leak
 + pickaxe: plug regex leak
 + pickaxe: plug diff filespec leak with empty needle

* sc/difftool-skip (2011-10-10) 1 commit
  (merged to 'next' on 2011-10-11 at 38d7e84)
 + git-difftool: allow skipping file by typing 'n' at prompt

* sg/completion (2011-10-10) 2 commits
  (merged to 'next' on 2011-10-11 at 4724640)
 + completion: unite --format and --pretty for 'log' and 'show'
 + completion: unite --reuse-message and --reedit-message for 'notes'
 (this branch uses tm/completion-commit-fixup-squash.)

* tc/fetch-leak (2011-10-07) 1 commit
  (merged to 'next' on 2011-10-11 at d867153)
 + fetch: plug two leaks on error exit in store_updated_refs

* jc/check-ref-format-fixup (2011-10-12) 2 commits
 - Restrict ref-like names immediately below $GIT_DIR
 - refs.c: move dwim_ref()/dwim_log() from sha1_name.c

An attempt to fix-up unfortunate side effect of mh/check-ref-format-3
topic. "git show -s config" is never meant to refer to $GIT_DIR/config
and treat it as a file that records an object name.

* jc/maint-remove-renamed-ref (2011-10-12) 1 commit
 - branch -m/-M: remove undocumented RENAMED-REF

--------------------------------------------------
[Graduated to "master"]

* cb/common-prefix-unification (2011-09-12) 3 commits
  (merged to 'next' on 2011-10-06 at 8349bca)
 + rename pathspec_prefix() to common_prefix() and move to dir.[ch]
 + consolidate pathspec_prefix and common_prefix
 + remove prefix argument from pathspec_prefix

Originally merged to 'next' on 2011-09-14.

* dm/tree-walk (2011-09-28) 2 commits
  (merged to 'next' on 2011-10-06 at 76e90c3)
 + tree-walk: micro-optimization in tree_entry_interesting
 + tree-walk: drop unused parameter from match_dir_prefix

Originally merged to 'next' on 2011-10-05.

* fg/submodule-git-file-git-dir (2011-08-22) 2 commits
  (merged to 'next' on 2011-10-06 at 3526bb9)
 + Move git-dir for submodules
 + rev-parse: add option --resolve-git-dir <path>

Originally merged to 'next' on 2011-08-23.

* hv/submodule-update-none (2011-08-11) 2 commits
  (merged to 'next' on 2011-10-06 at 4c105df)
 + add update 'none' flag to disable update of submodule by default
 + submodule: move update configuration variable further up

Originally merged to 'next' on 2011-08-24.

* jc/maint-diffstat-numstat-context (2011-09-22) 1 commit
  (merged to 'next' on 2011-10-06 at 36c972d)
 + diff: teach --stat/--numstat to honor -U$num

"diff" is allowed to match the common lines differently depending on how
many context lines it is showing, so running --(num)stat with 0 lines of
context internally gives a result that may be surprising to some people.

Originally merged to 'next' on 2011-09-26.

* jm/mergetool-pathspec (2011-09-26) 2 commits
  (merged to 'next' on 2011-10-06 at b8e830f)
 + mergetool: no longer need to save standard input
 + mergetool: Use args as pathspec to unmerged files

Originally merged to 'next' on 2011-09-26.

* jn/maint-http-error-message (2011-09-06) 2 commits
  (merged to 'next' on 2011-10-06 at 668a706)
 + http: avoid empty error messages for some curl errors
 + http: remove extra newline in error message

Originally merged to 'next' on 2011-09-12.

* jp/get-ref-dir-unsorted (2011-09-30) 2 commits
  (merged to 'next' on 2011-10-06 at 69fe65d)
 + refs: Use binary search to lookup refs faster
 + Don't sort ref_list too early

* mh/check-ref-format-3 (2011-10-05) 23 commits
  (merged to 'next' on 2011-10-06 at c277498)
 + add_ref(): verify that the refname is formatted correctly
 + resolve_ref(): expand documentation
 + resolve_ref(): also treat a too-long SHA1 as invalid
 + resolve_ref(): emit warnings for improperly-formatted references
 + resolve_ref(): verify that the input refname has the right format
 + remote: avoid passing NULL to read_ref()
 + remote: use xstrdup() instead of strdup()
 + resolve_ref(): do not follow incorrectly-formatted symbolic refs
 + resolve_ref(): extract a function get_packed_ref()
 + resolve_ref(): turn buffer into a proper string as soon as possible
 + resolve_ref(): only follow a symlink that contains a valid, normalized refname
 + resolve_ref(): use prefixcmp()
 + resolve_ref(): explicitly fail if a symlink is not readable
 + Change check_refname_format() to reject unnormalized refnames
 + Inline function refname_format_print()
 + Make collapse_slashes() allocate memory for its result
 + Do not allow ".lock" at the end of any refname component
 + Refactor check_refname_format()
 + Change check_ref_format() to take a flags argument
 + Change bad_ref_char() to return a boolean value
 + git check-ref-format: add options --allow-onelevel and --refspec-pattern
 + t1402: add some more tests
 + get_sha1_hex(): do not read past a NUL character

An unpleasant minor side effect was discovered with this one. If you try
"git show -s config", the code warns that $GIT_DIR/config is not formatted
correctly as a ref, which is technically correct but totally unwarranted.

* mh/iterate-refs (2011-09-11) 7 commits
  (merged to 'next' on 2011-10-06 at c7a33e5)
 + refs.c: make create_cached_refs() static
 + Retain caches of submodule refs
 + Store the submodule name in struct cached_refs
 + Allocate cached_refs objects dynamically
 + Change the signature of read_packed_refs()
 + Access reference caches only through new function get_cached_refs()
 + Extract a function clear_cached_refs()

Originally merged to 'next' on 2011-09-27.

* mh/maint-notes-merge-pathbuf-fix (2011-09-27) 1 commit
  (merged to 'next' on 2011-10-06 at 0af69bb)
 + notes_merge_commit(): do not pass temporary buffer to other function

Originally merged to 'next' on 2011-10-05.

* mz/remote-rename (2011-09-11) 4 commits
  (merged to 'next' on 2011-10-06 at 96db20d)
 + remote: only update remote-tracking branch if updating refspec
 + remote rename: warn when refspec was not updated
 + remote: "rename o foo" should not rename ref "origin/bar"
 + remote: write correct fetch spec when renaming remote 'remote'

Originally merged to 'next' on 2011-09-26.

* nd/sparse-doc (2011-09-26) 1 commit
  (merged to 'next' on 2011-10-06 at f6b8355)
 + git-read-tree.txt: update sparse checkout examples

Originally merged to 'next' on 2011-10-05.

* ps/gitweb-js-with-lineno (2011-09-27) 1 commit
  (merged to 'next' on 2011-10-06 at 9236f5e)
 + gitweb: Fix links to lines in blobs when javascript-actions are enabled

Originally merged to 'next' on 2011-10-05.

--------------------------------------------------
[Stalled]

* jk/http-auth-keyring (2011-09-28) 22 commits
 - credential-cache: don't cache items without context
 - check_expirations: don't copy over same element
 - t0300: add missing EOF terminator for <<
 - credential-store: use a better storage format
 - t0300: make alternate username tests more robust
 - t0300: make askpass tests a little more robust
 - credential-cache: fix expiration calculation corner cases
 - docs: minor tweaks to credentials API
 - credentials: make credential_fill_gently() static
 - credentials: add "getpass" helper
 - credentials: add "store" helper
 - credentials: add "cache" helper
 - docs: end-user documentation for the credential subsystem
 - http: use hostname in credential description
 - allow the user to configure credential helpers
 - look for credentials in config before prompting
 - http: use credential API to get passwords
 - introduce credentials API
 - http: retry authentication failures for all http requests
 - remote-curl: don't retry auth failures with dumb protocol
 - improve httpd auth tests
 - url: decode buffers that are not NUL-terminated
 (this branch is used by js/cred-macos-x-keychain-2.)

Kicked back to 'pu' to allow design level discussions to continue.

* js/cred-macos-x-keychain-2 (2011-10-06) 1 commit
 - contrib: add a pair of credential helpers for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring.)

Kicked back to 'pu' to allow design level discussions to continue.

* hv/submodule-merge-search (2011-08-26) 5 commits
 - submodule: Search for merges only at end of recursive merge
 - allow multiple calls to submodule merge search for the same path
 - submodule: Demonstrate known breakage during recursive merge
 - push: Don't push a repository with unpushed submodules
 - push: teach --recurse-submodules the on-demand option
 (this branch is tangled with fg/submodule-auto-push.)

The second from the bottom one needs to be replaced with a properly
written commit log message.

* fg/submodule-auto-push (2011-09-11) 2 commits
 - submodule.c: make two functions static
 - push: teach --recurse-submodules the on-demand option
 (this branch is tangled with hv/submodule-merge-search.)

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

Perhaps 281eee4 (revision: keep track of the end-user input from the
command line, 2011-08-25) would help.

--------------------------------------------------
[Cooking]

* jc/signed-commit (2011-10-05) 4 commits
 - commit: teach --gpg-sign option
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message

This is to replace the earlier "signed push" experiments.

* js/maint-merge-one-file-osx-expr (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-07 at fbb28a2)
 + merge-one-file: fix "expr: non-numeric argument"

Will merge to 'master' in the third wave.

* tm/completion-commit-fixup-squash (2011-10-06) 2 commits
  (merged to 'next' on 2011-10-11 at 6bb192e)
 + completion: commit --fixup and --squash
 + completion: unite --reuse-message and --reedit-message handling
 (this branch is used by sg/completion.)

* tm/completion-push-set-upstream (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-11 at 85544e5)
 + completion: push --set-upstream

* js/no-cherry-pick-head-after-punted (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-10 at acb29ee)
 + Merge branch 'js/maint-no-cherry-pick-head-after-punted' into js/no-cherry-pick-head-after-punted
 (this branch uses js/maint-no-cherry-pick-head-after-punted.)

Will merge to 'master' in the third wave.

* js/maint-no-cherry-pick-head-after-punted (2011-10-06) 2 commits
 + cherry-pick: do not give irrelevant advice when cherry-pick punted
 + revert.c: defer writing CHERRY_PICK_HEAD till it is safe to do so
 (this branch is used by js/no-cherry-pick-head-after-punted.)

Will merge to 'maint' later.

* sp/smart-http-failure (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at 02f9982)
 + remote-curl: Fix warning after HTTP failure

Will merge to 'master' in the second wave.

* cb/do-not-pretend-to-hijack-long-help (2011-10-05) 1 commit
  (merged to 'next' on 2011-10-06 at 46851fe)
 + use -h for synopsis and --help for manpage consistently

Will merge to 'master' in the second wave.

* cp/git-web-browse-browsers (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at da42ad0)
 + git-web--browse: avoid the use of eval

Will merge to 'master' in the third wave.

* il/archive-err-signal (2011-10-05) 1 commit
  (merged to 'next' on 2011-10-06 at 7e3083f)
 + Support ERR in remote archive like in fetch/push

Will merge to 'master' in the third wave.

* nd/daemon-log-sock-errors (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 5f3630f)
 + daemon: log errors if we could not use some sockets

Will merge to 'master' in the third wave.

* nd/document-err-packet (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 0c5f5d0)
 + pack-protocol: document "ERR" line

Will merge to 'master' in the second wave.

* nd/git-daemon-error-msgs (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 209126d)
 + daemon: return "access denied" if a service is not allowed

Will merge to 'master' in the third wave.

* jc/is-url-simplify (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at d6c6741)
 + url.c: simplify is_url()

Will merge to 'master' in the third wave.

* jn/ident-from-etc-mailname (2011-10-06) 2 commits
  (merged to 'next' on 2011-10-06 at a68770d)
 + ident: do not retrieve default ident when unnecessary
 + ident: check /etc/mailname if email is unknown

Will merge to 'master' in the third wave.

* jn/no-g-plus-s-on-bsd (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at 3d85674)
 + Makefile: do not set setgid bit on directories on GNU/kFreeBSD

Will merge to 'master' in the third wave.

* js/log-show-children (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at de8f6f2)
 + log --children

Will merge to 'master' in the third wave.

* rs/name-rev-usage (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-06 at e51878e)
 + name-rev: split usage string

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the second wave.

* rs/test-ctype (2011-10-03) 2 commits
  (merged to 'next' on 2011-10-06 at b8c26d2)
 + test-ctype: add test for is_pathspec_magic
 + test-ctype: macrofy

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the second wave.

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

Will merge to 'master' in the third wave.

* ph/transport-with-gitfile (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-12 at 6d58417)
 + Fix is_gitfile() for files too small or larger than PATH_MAX to be a gitfile
  (merged to 'next' on 2011-10-06 at 891b8b6)
 + Add test showing git-fetch groks gitfiles
 + Teach transport about the gitfile mechanism
 + Learn to handle gitfiles in enter_repo
 + enter_repo: do not modify input

Will merge to 'master' in the third wave.

* jc/grep-untracked-exclude (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at b16cffe)
 + Merge branch 'jc/maint-grep-untracked-exclude' into jc/grep-untracked-exclude
 (this branch uses bw/grep-no-index-no-exclude and jc/maint-grep-untracked-exclude.)

Will merge to 'master' in the third wave.

* jc/maint-grep-untracked-exclude (2011-10-04) 1 commit
 + grep: teach --untracked and --exclude-standard options
 (this branch is used by jc/grep-untracked-exclude; uses bw/grep-no-index-no-exclude.)

Will merge to 'maint' later.

* cs/perl-config-path-send-email (2011-09-30) 2 commits
  (merged to 'next' on 2011-10-06 at 93c00f0)
 + use new Git::config_path() for aliasesfile
 + Add Git::config_path()

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the second wave.

* jc/checkout-from-tree-keep-local-changes (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 64061aa)
 + checkout $tree $path: do not clobber local changes in $path not in $tree

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the fourth wave.

* jc/apply-blank-at-eof-fix (2011-09-26) 1 commit
  (merged to 'next' on 2011-10-06 at a9dfd8f)
 + apply --whitespace=error: correctly report new blank lines at end

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the third wave.

* jc/parse-options-boolean (2011-09-28) 5 commits
  (merged to 'next' on 2011-10-06 at dd4936c)
 + apply: use OPT_NOOP_NOARG
 + revert: use OPT_NOOP_NOARG
 + parseopt: add OPT_NOOP_NOARG
 + archive.c: use OPT_BOOL()
 + parse-options: deprecate OPT_BOOLEAN

Will merge to 'master' in the second wave.

* ph/push-to-delete-nothing (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-06 at 33ac777)
 + receive-pack: don't pass non-existent refs to post-{receive,update} hooks

Will merge to 'master' in the fourth wave.

* zj/send-email-authen-sasl (2011-09-29) 1 commit
  (merged to 'next' on 2011-10-06 at 78b31cd)
 + send-email: auth plain/login fix

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the second wave.

* nd/maint-sparse-errors (2011-09-22) 2 commits
  (merged to 'next' on 2011-10-06 at e3cbb90)
 + Add explanation why we do not allow to sparse checkout to empty working tree
 + sparse checkout: show error messages when worktree shaping fails

Originally merged to 'next' on 2011-09-22.
Will merge to 'master' in the third wave.

* rs/diff-cleanup-records-fix (2011-10-03) 2 commits
  (merged to 'next' on 2011-10-06 at 91f035f)
 + diff: resurrect XDF_NEED_MINIMAL with --minimal
 + Revert removal of multi-match discard heuristic in 27af01

Will merge to 'master' in the third wave.

* di/fast-import-empty-tag-note-fix (2011-09-22) 2 commits
  (merged to 'next' on 2011-10-06 at 3a01ef1)
 + fast-import: don't allow to note on empty branch
 + fast-import: don't allow to tag empty branch

Originally merged to 'next' on 2011-10-05.
Will merge to 'master' in the fourth wave.

* bw/grep-no-index-no-exclude (2011-09-15) 2 commits
  (merged to 'next' on 2011-10-06 at 325270b)
 + grep --no-index: don't use git standard exclusions
 + grep: do not use --index in the short usage output
 (this branch is used by jc/grep-untracked-exclude and jc/maint-grep-untracked-exclude.)

Originally merged to 'next' on 2011-09-26.
Will merge to 'master' in the third wave.

* js/bisect-no-checkout (2011-09-21) 1 commit
  (merged to 'next' on 2011-10-06 at 0354e94)
 + bisect: fix exiting when checkout failed in bisect_start()

Originally merged to 'next' on 2011-09-21.
Will merge to 'master' in the third wave.

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

Will merge to 'master' in the fourth wave.

* nd/maint-autofix-tag-in-head (2011-09-18) 4 commits
  (merged to 'next' on 2011-10-06 at c083e69)
 + Accept tags in HEAD or MERGE_HEAD
 + merge: remove global variable head[]
 + merge: use return value of resolve_ref() to determine if HEAD is invalid
 + merge: keep stash[] a local variable

Originally merged to 'next' on 2011-09-27.
Will merge to 'master' in the third wave.

* bc/attr-ignore-case (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-11 at daa6b51)
 + attr.c: respect core.ignorecase when matching attribute patterns
 + attr: read core.attributesfile from git_default_core_config
 + builtin/mv.c: plug miniscule memory leak
 + cleanup: use internal memory allocation wrapper functions everywhere
 + attr.c: avoid inappropriate access to strbuf "buf" member

Re-rolled.

* jc/lookup-object-hash (2011-08-11) 6 commits
 - object hash: replace linear probing with 4-way cuckoo hashing
 - object hash: we know the table size is a power of two
 - object hash: next_size() helper for readability
 - pack-objects --count-only
 - object.c: remove duplicated code for object hashing
 - object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload. Will keep it in 'next' at least for one cycle.
