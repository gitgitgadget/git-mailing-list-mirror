From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2011, #07; Fri, 23)
Date: Fri, 23 Sep 2011 16:33:07 -0700
Message-ID: <7vsjnmsuks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 01:33:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7FFA-0007Pn-EW
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 01:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab1IWXdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 19:33:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738Ab1IWXdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 19:33:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F064755C6;
	Fri, 23 Sep 2011 19:33:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	VP5o6vLjXtYhvPgiRzZCqR46PU=; b=kT7ne4srwgpetSH5CAqNJkK9evIuGzNm7
	r9e1ORPsZDBK4K7s5Kpm63lPw22ggrc9SBF1insPjO/Dl+5IUUqjIW+QHUsjlfvt
	c8bRTCLoNpxbTuNRkxPdPKpXABhIMUQE6aL2OglyRxzoGYRSD+GIgb55kf+XETMw
	87LT4nCEVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rDz
	2Ldb13e2IfJsQ5jF0AOLfsf1eujnLx0V+V/u2W9Pp66fo8M9c/hHr0EaYiti3QuF
	sBBy+N06dWGYEMhjqP4LufmP552uv9Jn8zF5EV52gfsmeZKzYOFzhDu9slB1ZKMS
	smnmhRNHYuoXNbqfji8pSO2uGxmv4hKLOii8JLqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E836D55C5;
	Fri, 23 Sep 2011 19:33:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B444955C3; Fri, 23 Sep 2011
 19:33:09 -0400 (EDT)
X-master-at: 85e9c7e1d42849c5c3084a9da748608468310c0e
X-next-at: 6bcf0e2b7ff196fa238fc8d8e9e9e116e0a55e25
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65901900-E63C-11E0-AC06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182012>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

We are at 1.7.7-rc3 as of today; I had to make a quick fix for a recent
regression directly on master, and I would like to cook it for a few days,
so the final has to wait til mid next week.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo, html and man:

	url = git://repo.or.cz/alt-git.git
	url = https://code.google.com/p/git-core/

With only maint, master, html and man:

	url = git://git.sourceforge.jp/gitroot/git-core/git.git
	url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches but not todo, html or man:

	url = https://github.com/gitster/git

Until kernel.org comes back to life, it might be a good idea to
tentatively have the following in your $HOME/.gitconfig:

    [url "http://code.google.com/p/git-core"]
      insteadOf = git://git.kernel.org/pub/scm/git/git.git

--------------------------------------------------
[New Topics]

* jc/maint-diffstat-numstat-context (2011-09-22) 1 commit
 - diff: teach --stat/--numstat to honor -U$num

* nd/maint-sparse-errors (2011-09-22) 2 commits
 - Add explanation why we do not allow to sparse checkout to empty working tree
 - sparse checkout: show error messages when worktree shaping fails

* rs/diff-cleanup-records-fix (2011-09-22) 1 commit
 - Revert a part of rc/diff-cleanup-records

It seems that the differences (the reverse of) this patch introduces are
of harmless kind but not very well explained in the original series. We
would need to try harder to write our log messages better next time.

* di/fast-import-empty-tag-note-fix (2011-09-22) 2 commits
 - fast-import: don't allow to note on empty branch
 - fast-import: don't allow to tag empty branch

* js/check-attr-cached (2011-09-22) 2 commits
 - t0003: remove extra whitespaces
 - Teach '--cached' option to check-attr

--------------------------------------------------
[Stalled]

* jc/signed-push (2011-09-12) 7 commits
 - push -s: support pre-receive-signature hook
 - push -s: receiving end
 - push -s: send signed push certificate
 - push -s: skeleton
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message
 (this branch uses jc/run-receive-hook-cleanup; is tangled with jc/signed-push-3.)

This was the v2 that updated notes tree on the receiving end.

* jc/signed-push-3 (2011-09-12) 4 commits
 . push -s: signed push
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message
 (this branch uses jc/run-receive-hook-cleanup; is tangled with jc/signed-push.)

This is the third edition, that moves the preparation of the notes tree to
the sending end.

* jk/add-i-hunk-filter (2011-07-27) 5 commits
  (merged to 'next' on 2011-08-11 at 8ff9a56)
 + add--interactive: add option to autosplit hunks
 + add--interactive: allow negatation of hunk filters
 + add--interactive: allow hunk filtering on command line
 + add--interactive: factor out regex error handling
 + add--interactive: refactor patch mode argument processing

Will be dropped.

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.

* jk/generation-numbers (2011-09-11) 8 commits
 - metadata-cache.c: make two functions static
 - limit "contains" traversals based on commit generation
 - check commit generation cache validity against grafts
 - pretty: support %G to show the generation number of a commit
 - commit: add commit_generation function
 - add metadata-cache infrastructure
 - decorate: allow storing values instead of pointers
 - Merge branch 'jk/tag-contains-ab' (early part) into HEAD

The initial "tag --contains" de-pessimization without need for generation
numbers is already in; backburnered.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

Perhaps 281eee4 (revision: keep track of the end-user input from the
command line, 2011-08-25) in bk/ancestry-path would help.

* po/cygwin-backslash (2011-08-05) 2 commits
 - On Cygwin support both UNIX and DOS style path-names
 - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

Incomplete with respect to backslash processing in prefix_filename(), and
also loses the ability to escape glob specials. Perhaps drop?

--------------------------------------------------
[Cooking]

* bw/grep-no-index-no-exclude (2011-09-15) 2 commits
 - grep --no-index: don't use git standard exclusions
 - grep: do not use --index in the short usage output

* jc/namespace-doc-with-old-asciidoc (2011-09-16) 1 commit
 - Documentation/gitnamespaces.txt: cater to older asciidoc

* jc/want-commit (2011-09-15) 1 commit
 - Allow git merge ":/<pattern>"

* jc/ls-remote-short-help (2011-09-16) 1 commit
 - ls-remote: a lone "-h" is asking for help

* jc/maint-bundle-too-quiet (2011-09-19) 1 commit
 - Teach progress eye-candy to fetch_refs_from_bundle()

* jk/filter-branch-require-clean-work-tree (2011-09-15) 1 commit
 - filter-branch: use require_clean_work_tree

* jn/gitweb-highlite-sanitise (2011-09-16) 1 commit
 - gitweb: Strip non-printable characters from syntax highlighter output

* mh/check-ref-format-3 (2011-09-16) 22 commits
 - add_ref(): verify that the refname is formatted correctly
 - resolve_ref(): expand documentation
 - resolve_ref(): also treat a too-long SHA1 as invalid
 - resolve_ref(): emit warnings for improperly-formatted references
 - resolve_ref(): verify that the input refname has the right format
 - remote: avoid passing NULL to read_ref()
 - remote: use xstrdup() instead of strdup()
 - resolve_ref(): do not follow incorrectly-formatted symbolic refs
 - resolve_ref(): extract a function get_packed_ref()
 - resolve_ref(): turn buffer into a proper string as soon as possible
 - resolve_ref(): only follow a symlink that contains a valid, normalized refname
 - resolve_ref(): use prefixcmp()
 - resolve_ref(): explicitly fail if a symlink is not readable
 - Change check_refname_format() to reject unnormalized refnames
 - Inline function refname_format_print()
 - Make collapse_slashes() allocate memory for its result
 - Do not allow ".lock" at the end of any refname component
 - Refactor check_refname_format()
 - Change check_ref_format() to take a flags argument
 - Change bad_ref_char() to return a boolean value
 - git check-ref-format: add options --allow-onelevel and --refspec-pattern
 - t1402: add some more tests

* cn/eradicate-working-copy (2011-09-21) 1 commit
 - Remove 'working copy' from the documentation and C code

* js/bisect-no-checkout (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-21 at e94ad3e)
 + bisect: fix exiting when checkout failed in bisect_start()

* mg/maint-doc-sparse-checkout (2011-09-21) 3 commits
  (merged to 'next' on 2011-09-21 at f316dec)
 + git-read-tree.txt: correct sparse-checkout and skip-worktree description
 + git-read-tree.txt: language and typography fixes
 + unpack-trees: print "Aborting" to stderr

* ms/patch-id-with-overlong-line (2011-09-22) 1 commit
 - patch-id.c: use strbuf instead of a fixed buffer

* sn/doc-update-index-assume-unchanged (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-21 at 325e796)
 + Documentation/git-update-index: refer to 'ls-files'

* jc/request-pull-show-head-4 (2011-09-21) 7 commits
 - request-pull: use the branch description
 - request-pull: state what commit to expect
 - request-pull: modernize style
 - branch: teach --edit-description option
 - format-patch: use branch description in cover letter
 - branch: add read_branch_desc() helper function
 - Merge branch 'bk/ancestry-path' into jc/branch-desc
 (this branch uses bk/ancestry-path.)

* jm/mergetool-pathspec (2011-09-16) 2 commits
 - mergetool: no longer need to save standard input
 - mergetool: Use args as pathspec to unmerged files

* nd/maint-autofix-tag-in-head (2011-09-18) 4 commits
 - Accept tags in HEAD or MERGE_HEAD
 - merge: remove global variable head[]
 - merge: use return value of resolve_ref() to determine if HEAD is invalid
 - merge: keep stash[] a local variable

* jk/maint-fetch-submodule-check-fix (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 3c73b8c)
 + fetch: avoid quadratic loop checking for updated submodules
 (this branch is used by jk/argv-array.)

This probably can wait, as long as the other half of the regression fix
is in the upcoming release.

* bc/attr-ignore-case (2011-09-14) 5 commits
 - attr: read core.attributesfile from git_default_core_config
 - attr.c: respect core.ignorecase when matching attribute patterns
 - builtin/mv.c: plug miniscule memory leak
 - cleanup: use internal memory allocation wrapper functions everywhere
 - attr.c: avoid inappropriate access to strbuf "buf" member

* jc/maint-fsck-fwrite-size-check (2011-09-11) 1 commit
  (merged to 'next' on 2011-09-16 at 2258f11)
 + fsck: do not abort upon finding an empty blob

* jk/argv-array (2011-09-14) 7 commits
  (merged to 'next' on 2011-09-16 at 90feab4)
 + run_hook: use argv_array API
 + checkout: use argv_array API
 + bisect: use argv_array API
 + quote: provide sq_dequote_to_argv_array
 + refactor argv_array into generic code
 + quote.h: fix bogus comment
 + add sha1_array API docs
 (this branch uses jk/maint-fetch-submodule-check-fix.)

* js/cred-macos-x-keychain-2 (2011-09-14) 1 commit
 - contrib: add a pair of credential helpers for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring.)

Welcome addition to build our confidence in the jk/http-auth-keyring topic.

* rj/maint-t9159-svn-rev-notation (2011-09-21) 1 commit
 - t9159-*.sh: skip for mergeinfo test for svn <= 1.4

* tr/doc-note-rewrite (2011-09-13) 1 commit
  (merged to 'next' on 2011-09-16 at 5fe813a)
 + Documentation: basic configuration of notes.rewriteRef

Updated to a safer wording.

* jk/default-attr (2011-09-12) 1 commit
 - attr: map builtin userdiff drivers to well-known extensions

Will be re-rolled after 1.7.7 final.

* hl/iso8601-more-zone-formats (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 270f5c7)
 + date.c: Support iso8601 timezone formats

* jc/run-receive-hook-cleanup (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 68dd431)
 + refactor run_receive_hook()
 (this branch is used by jc/signed-push and jc/signed-push-3.)

Just to make it easier to run a hook that reads from its standard input.

* jk/for-each-ref (2011-09-08) 5 commits
  (merged to 'next' on 2011-09-14 at 36ed515)
 + for-each-ref: add split message parts to %(contents:*).
 + for-each-ref: handle multiline subjects like --pretty
 + for-each-ref: refactor subject and body placeholder parsing
 + t6300: add more body-parsing tests
 + t7004: factor out gpg setup

* wh/normalize-alt-odb-path (2011-09-07) 1 commit
  (merged to 'next' on 2011-09-14 at 96f722b)
 + sha1_file: normalize alt_odb path before comparing and storing

* fk/use-kwset-pickaxe-grep-f (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-14 at 436d858)
 + obstack.c: Fix some sparse warnings
 + sparse: Fix an "Using plain integer as NULL pointer" warning

In general we would prefer to see these fixed at the upstream first, but
we have essentially forked from them at their last GPLv2 versions...

* jc/make-static (2011-09-14) 4 commits
  (merged to 'next' on 2011-09-14 at c5943ff)
 + exec_cmd.c: prepare_git_cmd() is sometimes used
 + environment.c: have_git_dir() has users on Cygwin
  (merged to 'next' on 2011-09-11 at 2acb0af)
 + vcs-svn: remove unused functions and make some static
 + make-static: master
 (this branch is tangled with jc/reflog-walk-use-only-nsha1.)

With a few fix-ups; probably needs to be ejected after 1.7.7 happens.

* rj/quietly-create-dep-dir (2011-09-11) 1 commit
  (merged to 'next' on 2011-09-12 at 93d1c6b)
 + Makefile: Make dependency directory creation less noisy

* mz/remote-rename (2011-09-11) 4 commits
 - remote: only update remote-tracking branch if updating refspec
 - remote rename: warn when refspec was not updated
 - remote: "rename o foo" should not rename ref "origin/bar"
 - remote: write correct fetch spec when renaming remote 'remote'

* cb/common-prefix-unification (2011-09-12) 3 commits
  (merged to 'next' on 2011-09-14 at 24f571f)
 + rename pathspec_prefix() to common_prefix() and move to dir.[ch]
 + consolidate pathspec_prefix and common_prefix
 + remove prefix argument from pathspec_prefix

* cb/send-email-help (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-14 at ae71999)
 + send-email: add option -h

A separate set of patches to remove the hidden fully-spelled "help" from
other commands would be nice to have as companion patches as well.

* jc/fetch-pack-fsck-objects (2011-09-04) 3 commits
  (merged to 'next' on 2011-09-12 at a031347)
 + test: fetch/receive with fsckobjects
 + transfer.fsckobjects: unify fetch/receive.fsckobjects
 + fetch.fsckobjects: verify downloaded objects

We had an option to verify the sent objects before accepting a push but
lacked the corresponding option when fetching. In the light of the recent
k.org incident, a change like this would be a good addition.

* jc/fetch-verify (2011-09-01) 3 commits
  (merged to 'next' on 2011-09-12 at 3f491ab)
 + fetch: verify we have everything we need before updating our ref
 + rev-list --verify-object
 + list-objects: pass callback data to show_objects()
 (this branch uses jc/traverse-commit-list; is tangled with jc/receive-verify.)

During a fetch, we verify that the pack stream is self consistent,
but did not verify that the refs that are updated are consistent with
objects contained in the packstream, and this adds such a check.

* jc/receive-verify (2011-09-09) 6 commits
  (merged to 'next' on 2011-09-12 at 856de78)
 + receive-pack: check connectivity before concluding "git push"
 + check_everything_connected(): libify
 + check_everything_connected(): refactor to use an iterator
 + fetch: verify we have everything we need before updating our ref
 + rev-list --verify-object
 + list-objects: pass callback data to show_objects()
 (this branch uses jc/traverse-commit-list; is tangled with jc/fetch-verify.)

While accepting a push, we verify that the pack stream is self consistent,
but did not verify that the refs the push updates are consistent with
objects contained in the packstream, and this adds such a check.

* jn/maint-http-error-message (2011-09-06) 2 commits
  (merged to 'next' on 2011-09-12 at a843f03)
 + http: avoid empty error messages for some curl errors
 + http: remove extra newline in error message

* bk/ancestry-path (2011-09-15) 4 commits
  (merged to 'next' on 2011-09-15 at aa64d04)
 + t6019: avoid refname collision on case-insensitive systems
  (merged to 'next' on 2011-09-02 at d05ba5d)
 + revision: do not include sibling history in --ancestry-path output
 + revision: keep track of the end-user input from the command line
 + rev-list: Demonstrate breakage with --ancestry-path --all
 (this branch is used by jc/request-pull-show-head-4.)

* mg/branch-list (2011-09-13) 7 commits
  (merged to 'next' on 2011-09-14 at 6610a2e)
 + t3200: clean up checks for file existence
  (merged to 'next' on 2011-09-11 at 20a9cdb)
 + branch: -v does not automatically imply --list
  (merged to 'next' on 2011-09-02 at b818eae)
 + branch: allow pattern arguments
 + branch: introduce --list option
 + git-branch: introduce missing long forms for the options
 + git-tag: introduce long forms for the options
 + t6040: test branch -vv

* mm/rebase-i-exec-edit (2011-08-26) 2 commits
  (merged to 'next' on 2011-09-02 at e75b1b9)
 + rebase -i: notice and warn if "exec $cmd" modifies the index or the working tree
 + rebase -i: clean error message for --continue after failed exec

* hv/submodule-merge-search (2011-08-26) 5 commits
 - submodule: Search for merges only at end of recursive merge
 - allow multiple calls to submodule merge search for the same path
 - submodule: Demonstrate known breakage during recursive merge
 - push: Don't push a repository with unpushed submodules
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is tangled with fg/submodule-auto-push.)

The second from the bottom one needs to be replaced with a properly
written commit log message.

* mm/mediawiki-as-a-remote (2011-09-01) 2 commits
  (merged to 'next' on 2011-09-12 at 163c6a5)
 + git-remote-mediawiki: allow push to set MediaWiki metadata
 + Add a remote helper to interact with mediawiki (fetch & push)

Fun.

* bc/unstash-clean-crufts (2011-08-27) 4 commits
  (merged to 'next' on 2011-09-02 at 7bfd66f)
 + git-stash: remove untracked/ignored directories when stashed
 + t/t3905: add missing '&&' linkage
 + git-stash.sh: fix typo in error message
 + t/t3905: use the name 'actual' for test output, swap arguments to test_cmp

* da/make-auto-header-dependencies (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at e04a4af)
 + Makefile: Improve compiler header dependency check
 (this branch uses fk/make-auto-header-dependencies.)

* gb/am-hg-patch (2011-08-29) 1 commit
  (merged to 'next' on 2011-09-02 at 3edfe4c)
 + am: preliminary support for hg patches

* jc/diff-index-unpack (2011-08-29) 3 commits
  (merged to 'next' on 2011-09-02 at 4206bd9)
 + diff-index: pass pathspec down to unpack-trees machinery
 + unpack-trees: allow pruning with pathspec
 + traverse_trees(): allow pruning with pathspec

* nm/grep-object-sha1-lock (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at 336f57d)
 + grep: Fix race condition in delta_base_cache

* tr/mergetool-valgrind (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at f5f2c61)
 + Symlink mergetools scriptlets into valgrind wrappers

* fg/submodule-auto-push (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-11 at 3fc86f7)
 + submodule.c: make two functions static
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is tangled with hv/submodule-merge-search.)

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* jc/traverse-commit-list (2011-08-22) 3 commits
  (merged to 'next' on 2011-08-24 at df50dd7)
 + revision.c: update show_object_with_name() without using malloc()
 + revision.c: add show_object_with_name() helper function
 + rev-list: fix finish_object() call
 (this branch is used by jc/fetch-verify and jc/receive-verify.)

* fk/make-auto-header-dependencies (2011-08-18) 1 commit
  (merged to 'next' on 2011-08-24 at 3da2c25)
 + Makefile: Use computed header dependencies if the compiler supports it
 (this branch is used by da/make-auto-header-dependencies.)

* mh/iterate-refs (2011-09-11) 7 commits
 - refs.c: make create_cached_refs() static
 - Retain caches of submodule refs
 - Store the submodule name in struct cached_refs
 - Allocate cached_refs objects dynamically
 - Change the signature of read_packed_refs()
 - Access reference caches only through new function get_cached_refs()
 - Extract a function clear_cached_refs()

I did not see anything fundamentally wrong with this series, but it was
unclear what the benefit of these changes are.  If the series were to read
parts of the ref hierarchy (like refs/heads/) lazily, the story would
have been different, though.

* hv/submodule-update-none (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-24 at 5302fc1)
 + add update 'none' flag to disable update of submodule by default
 + submodule: move update configuration variable further up

* jc/lookup-object-hash (2011-08-11) 6 commits
  (merged to 'next' on 2011-08-24 at 5825411)
 + object hash: replace linear probing with 4-way cuckoo hashing
 + object hash: we know the table size is a power of two
 + object hash: next_size() helper for readability
 + pack-objects --count-only
 + object.c: remove duplicated code for object hashing
 + object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload. Will keep it in 'next' at least for one cycle.

* fg/submodule-git-file-git-dir (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-23 at 762194e)
 + Move git-dir for submodules
 + rev-parse: add option --resolve-git-dir <path>

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage outweighs any benefit for having this new
feature. Will keep it in 'next' at least for one cycle.

* jk/http-auth-keyring (2011-09-16) 21 commits
  (merged to 'next' on 2011-09-16 at b4195eb)
 + check_expirations: don't copy over same element
 + t0300: add missing EOF terminator for <<
  (merged to 'next' on 2011-09-14 at 589c7c9)
 + credential-store: use a better storage format
 + t0300: make alternate username tests more robust
 + t0300: make askpass tests a little more robust
 + credential-cache: fix expiration calculation corner cases
 + docs: minor tweaks to credentials API
  (merged to 'next' on 2011-09-11 at 491ce6a)
 + credentials: make credential_fill_gently() static
  (merged to 'next' on 2011-08-03 at b06e80e)
 + credentials: add "getpass" helper
 + credentials: add "store" helper
 + credentials: add "cache" helper
 + docs: end-user documentation for the credential subsystem
 + http: use hostname in credential description
 + allow the user to configure credential helpers
 + look for credentials in config before prompting
 + http: use credential API to get passwords
 + introduce credentials API
 + http: retry authentication failures for all http requests
 + remote-curl: don't retry auth failures with dumb protocol
 + improve httpd auth tests
 + url: decode buffers that are not NUL-terminated
 (this branch is tangled with js/cred-macos-x-keychain and js/cred-macos-x-keychain-2.)

* rr/revert-cherry-pick-continue (2011-09-11) 19 commits
  (merged to 'next' on 2011-09-11 at 7d78054)
 + builtin/revert.c: make commit_list_append() static
  (merged to 'next' on 2011-08-24 at 712c115)
 + revert: Propagate errors upwards from do_pick_commit
 + revert: Introduce --continue to continue the operation
 + revert: Don't implicitly stomp pending sequencer operation
 + revert: Remove sequencer state when no commits are pending
 + reset: Make reset remove the sequencer state
 + revert: Introduce --reset to remove sequencer state
 + revert: Make pick_commits functionally act on a commit list
 + revert: Save command-line options for continuing operation
 + revert: Save data for continuing after conflict resolution
 + revert: Don't create invalid replay_opts in parse_args
 + revert: Separate cmdline parsing from functional code
 + revert: Introduce struct to keep command-line options
 + revert: Eliminate global "commit" variable
 + revert: Rename no_replay to record_origin
 + revert: Don't check lone argument in get_encoding
 + revert: Simplify and inline add_message_to_msg
 + config: Introduce functions to write non-standard file
 + advice: Introduce error_resolve_conflict

--------------------------------------------------
[Discarded]

* js/cred-macos-x-keychain (2011-09-11) 15 commits
  (merged to 'next' on 2011-09-12 at 8d17f94)
 + contrib: add a credential helper for Mac OS X's keychain
  (merged to 'next' on 2011-09-11 at 491ce6a)
 + credentials: make credential_fill_gently() static
  (merged to 'next' on 2011-08-03 at b06e80e)
 + credentials: add "getpass" helper
 + credentials: add "store" helper
 + credentials: add "cache" helper
 + docs: end-user documentation for the credential subsystem
 + http: use hostname in credential description
 + allow the user to configure credential helpers
 + look for credentials in config before prompting
 + http: use credential API to get passwords
 + introduce credentials API
 + http: retry authentication failures for all http requests
 + remote-curl: don't retry auth failures with dumb protocol
 + improve httpd auth tests
 + url: decode buffers that are not NUL-terminated
 (this branch is tangled with jk/http-auth-keyring and js/cred-macos-x-keychain-2.)

Reverted out of 'next'.

* jc/reflog-walk-use-only-nsha1 (2011-09-13) 4 commits
 . (baloon) teach reflog-walk to look at only new-sha1 field
 + environment.c: have_git_dir() has users on Cygwin
  (merged to 'next' on 2011-09-11 at 2acb0af)
 + vcs-svn: remove unused functions and make some static
 + make-static: master
 (this branch is tangled with jc/make-static.)

* hw/maint-abspath-cwd-limit (2011-09-21) 3 commits
  (merged to 'next' on 2011-09-21 at 210cf9a)
 + Revert 622fea4 (abspath.c: increase array size of cwd variable)
  (merged to 'next' on 2011-09-19 at 7d5e921)
 + abspath.c: increase array size of cwd variable to PATH_MAX
 + path.c: increase array size of cwd variable to PATH_MAX

Reverted out of 'next'.

* jc/request-pull-show-head (2011-09-13) 2 commits
  (merged to 'next' on 2011-09-13 at c82fb3a)
 + Revert "State what commit to expect in request-pull"
  (merged to 'next' on 2011-09-12 at c1c7b73)
 + State what commit to expect in request-pull

Reverted out of 'next'.
