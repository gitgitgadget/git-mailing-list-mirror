From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #02; Wed, 5)
Date: Wed, 05 Oct 2011 15:15:10 -0700
Message-ID: <7vlisz5bm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 00:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZkN-0004su-CU
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935350Ab1JEWPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:15:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934910Ab1JEWPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:15:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B74F6AC4;
	Wed,  5 Oct 2011 18:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	vc/9B2k6CluZhmbCEdRHkaaFXk=; b=X3eTbrloddBhOszeIWRonsAThpOHDNPCD
	s7h5Ik6OyHOEynrTfA2Kbaqox73vKtsp06HG44gqmHLbu9QnSnX+h2dqQ3Wec9M5
	e7YlUx2uCEMIk+GsL+qHFC/1H51UjBim02VSWz9NJK97P5PpUWcKhrsBtbcodlX2
	XEFrTBryoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OqW
	44bnxfHxXUulO1Ei/sBiVa04gAmTo2H9+yP2P7x5xpsEZbGSzKaeBHdez/qxlsXl
	Mywr769WejM+wUBo19WGWMiXyVEHW9VwjTCXyBQ7MWFfdHGzpOtiCa9V0X/Nm/zh
	ieesf7BAm4pEdzt5g+uOYTEBt0YE5cAW8yAqETsw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71FFA6AC3;
	Wed,  5 Oct 2011 18:15:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A7D06AC1; Wed,  5 Oct 2011
 18:15:11 -0400 (EDT)
X-master-at: 7f41b6bbe3181dc4d1687db036bf22316997a1bf
X-next-at: 16d0eacc744f9eabe7ef4cdf3f9fece5424b951f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E658C1E-EF9F-11E0-930B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182895>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The first batch of topics that have been cooking in 'next' have now
graduated to 'master'.

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

    [url "https://github.com/git/git"]
	insteadOf = git://git.kernel.org/pub/scm/git/git.git

I am planning to kick some topics out of 'next' back to 'pu' to give them
a chance to be cleaned up. Not happened yet, but see below for ideas.

--------------------------------------------------
[New Topics]

* sp/smart-http-failure (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-05 at 73af367)
 + remote-curl: Fix warning after HTTP failure

Will merge to "master" in the second wave.

--------------------------------------------------
[Graduated to "master"]

* bc/unstash-clean-crufts (2011-08-27) 4 commits
  (merged to 'next' on 2011-09-02 at 7bfd66f)
 + git-stash: remove untracked/ignored directories when stashed
 + t/t3905: add missing '&&' linkage
 + git-stash.sh: fix typo in error message
 + t/t3905: use the name 'actual' for test output, swap arguments to test_cmp

Will merge to "master" in the first wave.

* bk/ancestry-path (2011-09-15) 4 commits
  (merged to 'next' on 2011-09-15 at aa64d04)
 + t6019: avoid refname collision on case-insensitive systems
  (merged to 'next' on 2011-09-02 at d05ba5d)
 + revision: do not include sibling history in --ancestry-path output
 + revision: keep track of the end-user input from the command line
 + rev-list: Demonstrate breakage with --ancestry-path --all
 (this branch is used by jc/request-pull-show-head-4.)

Will merge to "master" in the first wave.

* cb/send-email-help (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-14 at ae71999)
 + send-email: add option -h

Will merge to "master" in the first wave.

* cn/eradicate-working-copy (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-26 at 2683d36)
 + Remove 'working copy' from the documentation and C code

Will merge to "master" in the first wave.

* da/make-auto-header-dependencies (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at e04a4af)
 + Makefile: Improve compiler header dependency check
 (this branch uses fk/make-auto-header-dependencies.)

Will merge to "master" in the first wave.

* fk/make-auto-header-dependencies (2011-08-18) 1 commit
  (merged to 'next' on 2011-08-24 at 3da2c25)
 + Makefile: Use computed header dependencies if the compiler supports it
 (this branch is used by da/make-auto-header-dependencies.)

Will merge to "master" in the first wave.

* fk/use-kwset-pickaxe-grep-f (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-14 at 436d858)
 + obstack.c: Fix some sparse warnings
 + sparse: Fix an "Using plain integer as NULL pointer" warning

Will merge to "master" in the first wave.

* gb/am-hg-patch (2011-08-29) 1 commit
  (merged to 'next' on 2011-09-02 at 3edfe4c)
 + am: preliminary support for hg patches

Will merge to "master" in the first wave.

* hl/iso8601-more-zone-formats (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 270f5c7)
 + date.c: Support iso8601 timezone formats

Will merge to "master" in the first wave.

* jc/diff-index-unpack (2011-08-29) 3 commits
  (merged to 'next' on 2011-09-02 at 4206bd9)
 + diff-index: pass pathspec down to unpack-trees machinery
 + unpack-trees: allow pruning with pathspec
 + traverse_trees(): allow pruning with pathspec

Will merge to "master" in the first wave.

* jc/fetch-pack-fsck-objects (2011-09-04) 3 commits
  (merged to 'next' on 2011-09-12 at a031347)
 + test: fetch/receive with fsckobjects
 + transfer.fsckobjects: unify fetch/receive.fsckobjects
 + fetch.fsckobjects: verify downloaded objects

We had an option to verify the sent objects before accepting a push but
lacked the corresponding option when fetching. In the light of the recent
k.org incident, a change like this would be a good addition.

Will merge to "master" in the first wave.

* jc/fetch-verify (2011-09-01) 3 commits
  (merged to 'next' on 2011-09-12 at 3f491ab)
 + fetch: verify we have everything we need before updating our ref
 + rev-list --verify-object
 + list-objects: pass callback data to show_objects()
 (this branch uses jc/traverse-commit-list; is tangled with jc/receive-verify.)

During a fetch, we verify that the pack stream is self consistent,
but did not verify that the refs that are updated are consistent with
objects contained in the packstream, and this adds such a check.

Will merge to "master" in the first wave.

* jc/ls-remote-short-help (2011-09-16) 1 commit
  (merged to 'next' on 2011-09-26 at e24a27a)
 + ls-remote: a lone "-h" is asking for help

Will merge to "master" in the first wave.

* jc/maint-bundle-too-quiet (2011-09-19) 1 commit
  (merged to 'next' on 2011-09-26 at ba140d4)
 + Teach progress eye-candy to fetch_refs_from_bundle()

Will merge to "master" in the first wave.

* jc/maint-fsck-fwrite-size-check (2011-09-11) 1 commit
  (merged to 'next' on 2011-09-16 at 2258f11)
 + fsck: do not abort upon finding an empty blob

Will merge to "master" in the first wave.

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

Will merge to "master" in the third wave.

* jc/run-receive-hook-cleanup (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 68dd431)
 + refactor run_receive_hook()
 (this branch is used by jc/signed-push and jc/signed-push-3.)

Just to make it easier to run a hook that reads from its standard input.
Will merge to "master" in the first wave.

* jc/traverse-commit-list (2011-08-22) 3 commits
  (merged to 'next' on 2011-08-24 at df50dd7)
 + revision.c: update show_object_with_name() without using malloc()
 + revision.c: add show_object_with_name() helper function
 + rev-list: fix finish_object() call
 (this branch is used by jc/fetch-verify and jc/receive-verify.)

Will merge to "master" in the first wave.

* jc/want-commit (2011-09-15) 1 commit
  (merged to 'next' on 2011-09-26 at 5841512)
 + Allow git merge ":/<pattern>"

Will merge to "master" in the first wave.

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

This has a slight interaction with the "pending_sha1 without having to
read the object" work on rs/pending, but otherwise OK.

Will merge to "master" in the first wave.

* jk/filter-branch-require-clean-work-tree (2011-09-15) 1 commit
  (merged to 'next' on 2011-09-26 at 206a74a)
 + filter-branch: use require_clean_work_tree

Will merge to "master" in the first wave.

* jk/for-each-ref (2011-09-08) 5 commits
  (merged to 'next' on 2011-09-14 at 36ed515)
 + for-each-ref: add split message parts to %(contents:*).
 + for-each-ref: handle multiline subjects like --pretty
 + for-each-ref: refactor subject and body placeholder parsing
 + t6300: add more body-parsing tests
 + t7004: factor out gpg setup

Will merge to "master" in the first wave.

* jk/maint-fetch-submodule-check-fix (2011-09-12) 1 commit
  (merged to 'next' on 2011-09-12 at 3c73b8c)
 + fetch: avoid quadratic loop checking for updated submodules
 (this branch is used by jk/argv-array.)

Will merge to "master" in the first wave.

* jn/gitweb-highlite-sanitise (2011-09-16) 1 commit
  (merged to 'next' on 2011-09-26 at c79390a)
 + gitweb: Strip non-printable characters from syntax highlighter output

Will merge to "master" in the first wave.

* js/check-attr-cached (2011-09-22) 2 commits
  (merged to 'next' on 2011-09-27 at 74d7b66)
 + t0003: remove extra whitespaces
 + Teach '--cached' option to check-attr

Will merge to "master" in the first wave.

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

Will merge to "master" in the first wave.

* mg/maint-doc-sparse-checkout (2011-09-21) 3 commits
  (merged to 'next' on 2011-09-21 at f316dec)
 + git-read-tree.txt: correct sparse-checkout and skip-worktree description
 + git-read-tree.txt: language and typography fixes
 + unpack-trees: print "Aborting" to stderr

Will merge to "master" in the first wave.

* mm/mediawiki-as-a-remote (2011-09-28) 6 commits
  (merged to 'next' on 2011-09-28 at a1c9ae5)
 + git-remote-mediawiki: allow a domain to be set for authentication
  (merged to 'next' on 2011-09-27 at 7ce8254)
 + git-remote-mediawiki: obey advice.pushNonFastForward
 + git-remote-mediawiki: set 'basetimestamp' to let the wiki handle conflicts
 + git-remote-mediawiki: trivial fixes
  (merged to 'next' on 2011-09-12 at 163c6a5)
 + git-remote-mediawiki: allow push to set MediaWiki metadata
 + Add a remote helper to interact with mediawiki (fetch & push)

Will merge to "master" in the first wave.

* mm/rebase-i-exec-edit (2011-08-26) 2 commits
  (merged to 'next' on 2011-09-02 at e75b1b9)
 + rebase -i: notice and warn if "exec $cmd" modifies the index or the working tree
 + rebase -i: clean error message for --continue after failed exec

Will merge to "master" in the first wave.

* ms/patch-id-with-overlong-line (2011-09-22) 1 commit
  (merged to 'next' on 2011-09-26 at a33d0b2)
 + patch-id.c: use strbuf instead of a fixed buffer

Will merge to "master" in the first wave.

* nm/grep-object-sha1-lock (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at 336f57d)
 + grep: Fix race condition in delta_base_cache

Will merge to "master" in the first wave.

* rj/maint-t9159-svn-rev-notation (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-26 at 525a567)
 + t9159-*.sh: skip for mergeinfo test for svn <= 1.4

Will merge to "master" in the first wave.

* rj/quietly-create-dep-dir (2011-09-11) 1 commit
  (merged to 'next' on 2011-09-12 at 93d1c6b)
 + Makefile: Make dependency directory creation less noisy

Will merge to "master" in the first wave.

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

Will merge to "master" in the first wave.

Note that generalized sequencer still needs a bit more thought (see the
summary by Ram at $gmane/179613).

* sn/doc-update-index-assume-unchanged (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-21 at 325e796)
 + Documentation/git-update-index: refer to 'ls-files'

Will merge to "master" in the first wave.

* tr/doc-note-rewrite (2011-09-13) 1 commit
  (merged to 'next' on 2011-09-16 at 5fe813a)
 + Documentation: basic configuration of notes.rewriteRef

Will merge to "master" in the first wave.

* tr/mergetool-valgrind (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at f5f2c61)
 + Symlink mergetools scriptlets into valgrind wrappers

Will merge to "master" in the first wave.

* wh/normalize-alt-odb-path (2011-09-07) 1 commit
  (merged to 'next' on 2011-09-14 at 96f722b)
 + sha1_file: normalize alt_odb path before comparing and storing

Will merge to "master" in the first wave.

--------------------------------------------------
[Stalled]

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

Will kick back to 'pu'.

* jc/signed-push (2011-09-12) 7 commits
 - push -s: support pre-receive-signature hook
 - push -s: receiving end
 - push -s: send signed push certificate
 - push -s: skeleton
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message
 (this branch is tangled with jc/signed-push-3.)

This was the v2 that updated notes tree on the receiving end.

* jc/signed-push-3 (2011-09-12) 4 commits
 . push -s: signed push
 - Split GPG interface into its own helper library
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message
 (this branch is tangled with jc/signed-push.)

This is the third edition, that moves the preparation of the notes tree to
the sending end.
I expect that both of these topics will be discarded.

* jk/add-i-hunk-filter (2011-07-27) 5 commits
  (merged to 'next' on 2011-08-11 at 8ff9a56)
 + add--interactive: add option to autosplit hunks
 + add--interactive: allow negatation of hunk filters
 + add--interactive: allow hunk filtering on command line
 + add--interactive: factor out regex error handling
 + add--interactive: refactor patch mode argument processing

Will discard.

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
Will discard.

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
numbers is already in.
Will discard.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

Perhaps 281eee4 (revision: keep track of the end-user input from the
command line, 2011-08-25) in bk/ancestry-path would help.

* po/cygwin-backslash (2011-08-05) 2 commits
 - On Cygwin support both UNIX and DOS style path-names
 - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

Incomplete with respect to backslash processing in prefix_filename(), and
also loses the ability to escape glob specials.
Will discard.

--------------------------------------------------
[Cooking]

* cb/do-not-pretend-to-hijack-long-help (2011-10-05) 1 commit
 - use -h for synopsis and --help for manpage consistently

Will merge to "next".

* cp/git-web-browse-browsers (2011-10-03) 1 commit
 - git-web--browse: avoid the use of eval

Will merge to "next".

* il/archive-err-signal (2011-10-05) 1 commit
 - Support ERR in remote archive like in fetch/push

Will merge to "next".

* nd/daemon-log-sock-errors (2011-10-03) 1 commit
 - daemon: log errors if we could not use some sockets

Will merge to "next".

* nd/document-err-packet (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-05 at aca0326)
 + pack-protocol: document "ERR" line

Will merge to "master" in the second wave.

* nd/git-daemon-error-msgs (2011-10-03) 1 commit
 - daemon: return "access denied" if a service is not allowed

Will merge to "next".

* jc/is-url-simplify (2011-10-03) 1 commit
 - url.c: simplify is_url()

Will merge to "next".

* jn/ident-from-etc-mailname (2011-10-03) 1 commit
 - ident: check /etc/mailname if email is unknown

Will merge to "next".

The warning might have to be squelched further, but that can be done as a
separate patch in-tree.

* jn/no-g-plus-s-on-bsd (2011-10-03) 1 commit
 - Makefile: do not set setgid bit on directories on GNU/kFreeBSD

Will merge to "next".

* js/log-show-children (2011-10-04) 1 commit
 - log --children

Will merge to "next".

* rs/name-rev-usage (2011-10-03) 1 commit
  (merged to 'next' on 2011-10-05 at 16d0eac)
 + name-rev: split usage string

Will merge to "master" in the second wave.

* rs/test-ctype (2011-10-03) 2 commits
  (merged to 'next' on 2011-10-05 at 9a9b0e6)
 + test-ctype: add test for is_pathspec_magic
 + test-ctype: macrofy

Will merge to "master" in the second wave.

* rs/pending (2011-10-03) 8 commits
 - commit: factor out clear_commit_marks_for_object_array
 - checkout: use leak_pending flag
 - bundle: use leak_pending flag
 - bisect: use leak_pending flag
 - revision: add leak_pending flag
 - checkout: use add_pending_{object,sha1} in orphan check
 - revision: factor out add_pending_sha1
 - checkout: check for "Previous HEAD" notice in t2020

Will merge to "next" after reading the series over once more.

* ph/transport-with-gitfile (2011-10-04) 4 commits
 - Add test showing git-fetch groks gitfiles
 - Teach transport about the gitfile mechanism
 - Learn to handle gitfiles in enter_repo
 - enter_repo: do not modify input

Will merge to "next" after reading the series over once more.

* jc/grep-untracked-exclude (2011-10-04) 1 commit
 - Merge branch 'jc/maint-grep-untracked-exclude' into jc/grep-untracked-exclude
 (this branch uses bw/grep-no-index-no-exclude and jc/maint-grep-untracked-exclude.)

Will merge to "next".

* jc/maint-grep-untracked-exclude (2011-10-04) 1 commit
 - grep: teach --untracked and --exclude-standard options
 (this branch is used by jc/grep-untracked-exclude; uses bw/grep-no-index-no-exclude.)

Will merge to "next".

* dm/tree-walk (2011-09-28) 2 commits
  (merged to 'next' on 2011-10-05 at ca20a51)
 + tree-walk: micro-optimization in tree_entry_interesting
 + tree-walk: drop unused parameter from match_dir_prefix

Will merge to "master" in the second wave.

* cs/perl-config-path-send-email (2011-09-30) 2 commits
  (merged to 'next' on 2011-10-05 at 68dc976)
 + use new Git::config_path() for aliasesfile
 + Add Git::config_path()

Will merge to "master" in the second wave.

* jc/checkout-from-tree-keep-local-changes (2011-09-30) 1 commit
  (merged to 'next' on 2011-10-05 at 15d10f7)
 + checkout $tree $path: do not clobber local changes in $path not in $tree

Will merge to "master" in the fourth wave.

* jc/apply-blank-at-eof-fix (2011-09-26) 1 commit
  (merged to 'next' on 2011-10-05 at 99213f2)
 + apply --whitespace=error: correctly report new blank lines at end

Will merge to "master" in the third wave.

* nd/sparse-doc (2011-09-26) 1 commit
  (merged to 'next' on 2011-10-05 at 0ee812e)
 + git-read-tree.txt: update sparse checkout examples

Will merge to "master" in the second wave.

* jp/get-ref-dir-unsorted (2011-09-30) 2 commits
 - refs: Use binary search to lookup refs faster
 - Don't sort ref_list too early

Will merge to "next".

* jc/parse-options-boolean (2011-09-28) 5 commits
 - apply: use OPT_NOOP_NOARG
 - revert: use OPT_NOOP_NOARG
 - parseopt: add OPT_NOOP_NOARG
 - archive.c: use OPT_BOOL()
 - parse-options: deprecate OPT_BOOLEAN

Will merge to "next".

* mh/maint-notes-merge-pathbuf-fix (2011-09-27) 1 commit
  (merged to 'next' on 2011-10-05 at a4ce316)
 + notes_merge_commit(): do not pass temporary buffer to other function

Will merge to "master" in the second wave.

* ph/push-to-delete-nothing (2011-09-30) 1 commit
 - receive-pack: don't pass non-existent refs to post-{receive,update} hooks

Will merge to "next".

* ps/gitweb-js-with-lineno (2011-09-27) 1 commit
  (merged to 'next' on 2011-10-05 at 7f7d5da)
 + gitweb: Fix links to lines in blobs when javascript-actions are enabled

Will merge to "master" in the second wave.

* zj/send-email-authen-sasl (2011-09-29) 1 commit
  (merged to 'next' on 2011-10-05 at 127f3a5)
 + send-email: auth plain/login fix

Will merge to "master" in the second wave.

* jc/maint-diffstat-numstat-context (2011-09-22) 1 commit
  (merged to 'next' on 2011-09-26 at 12539ab)
 + diff: teach --stat/--numstat to honor -U$num

"diff" is allowed to match the common lines differently depending on how
many context lines it is showing, so running --(num)stat with 0 lines of
context internally gives a result that may be surprising to some people.

Will merge to "master" in the second wave.

* nd/maint-sparse-errors (2011-09-22) 2 commits
  (merged to 'next' on 2011-09-26 at cdcdec5)
 + Add explanation why we do not allow to sparse checkout to empty working tree
 + sparse checkout: show error messages when worktree shaping fails

Will merge to "master" in the third wave.

* rs/diff-cleanup-records-fix (2011-10-03) 2 commits
 - diff: resurrect XDF_NEED_MINIMAL with --minimal
  (merged to 'next' on 2011-09-27 at 3bd75d8)
 + Revert removal of multi-match discard heuristic in 27af01

Will merge to "next".

* di/fast-import-empty-tag-note-fix (2011-09-22) 2 commits
  (merged to 'next' on 2011-10-05 at da6cacf)
 + fast-import: don't allow to note on empty branch
 + fast-import: don't allow to tag empty branch

Will merge to "master" in the fourth wave.

* bw/grep-no-index-no-exclude (2011-09-15) 2 commits
  (merged to 'next' on 2011-09-26 at 776f13b)
 + grep --no-index: don't use git standard exclusions
 + grep: do not use --index in the short usage output
 (this branch is used by jc/grep-untracked-exclude and jc/maint-grep-untracked-exclude.)

Will merge to "master" in the third wave.

* mh/check-ref-format-3 (2011-10-05) 23 commits
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
 - get_sha1_hex(): do not read past a NUL character

Will merge to "next".

* js/bisect-no-checkout (2011-09-21) 1 commit
  (merged to 'next' on 2011-09-21 at e94ad3e)
 + bisect: fix exiting when checkout failed in bisect_start()

Will merge to "master" in the third wave.

* jc/request-pull-show-head-4 (2011-10-05) 7 commits
  (merged to 'next' on 2011-10-05 at 8f2b5a7)
 + request-pull: use the branch description
 + request-pull: state what commit to expect
 + request-pull: modernize style
 + branch: teach --edit-description option
 + format-patch: use branch description in cover letter
 + branch: add read_branch_desc() helper function
 + Merge branch 'bk/ancestry-path' into jc/branch-desc

Will merge to "master" in the fourth wave.

* jm/mergetool-pathspec (2011-09-26) 2 commits
  (merged to 'next' on 2011-09-26 at f699566)
 + mergetool: no longer need to save standard input
 + mergetool: Use args as pathspec to unmerged files

Will merge to "master" in the second wave.

* nd/maint-autofix-tag-in-head (2011-09-18) 4 commits
  (merged to 'next' on 2011-09-27 at dc8e2e3)
 + Accept tags in HEAD or MERGE_HEAD
 + merge: remove global variable head[]
 + merge: use return value of resolve_ref() to determine if HEAD is invalid
 + merge: keep stash[] a local variable

Will merge to "master" in the third wave.

* bc/attr-ignore-case (2011-09-14) 5 commits
  (merged to 'next' on 2011-09-26 at 1e0814c)
 + attr: read core.attributesfile from git_default_core_config
 + attr.c: respect core.ignorecase when matching attribute patterns
 + builtin/mv.c: plug miniscule memory leak
 + cleanup: use internal memory allocation wrapper functions everywhere
 + attr.c: avoid inappropriate access to strbuf "buf" member

Will merge to "master" in the second wave.

* js/cred-macos-x-keychain-2 (2011-09-14) 1 commit
  (merged to 'next' on 2011-09-26 at 4f289a4)
 + contrib: add a pair of credential helpers for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring.)

Will kick back to 'pu' together with 'jk/http-auth-keyring'.

* jk/default-attr (2011-09-12) 1 commit
 - attr: map builtin userdiff drivers to well-known extensions

Will discard, expecting a fresh re-roll.

* jc/make-static (2011-09-14) 4 commits
  (merged to 'next' on 2011-09-14 at c5943ff)
 + exec_cmd.c: prepare_git_cmd() is sometimes used
 + environment.c: have_git_dir() has users on Cygwin
  (merged to 'next' on 2011-09-11 at 2acb0af)
 + vcs-svn: remove unused functions and make some static
 + make-static: master

Will discard (or at least kick it back to 'pu').

* mz/remote-rename (2011-09-11) 4 commits
  (merged to 'next' on 2011-09-26 at 5e64f68)
 + remote: only update remote-tracking branch if updating refspec
 + remote rename: warn when refspec was not updated
 + remote: "rename o foo" should not rename ref "origin/bar"
 + remote: write correct fetch spec when renaming remote 'remote'

Will merge to "master" in the second wave.

* cb/common-prefix-unification (2011-09-12) 3 commits
  (merged to 'next' on 2011-09-14 at 24f571f)
 + rename pathspec_prefix() to common_prefix() and move to dir.[ch]
 + consolidate pathspec_prefix and common_prefix
 + remove prefix argument from pathspec_prefix

Will merge to "master" in the second wave.

* jn/maint-http-error-message (2011-09-06) 2 commits
  (merged to 'next' on 2011-09-12 at a843f03)
 + http: avoid empty error messages for some curl errors
 + http: remove extra newline in error message

Will merge to "master" in the second wave.

* fg/submodule-auto-push (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-11 at 3fc86f7)
 + submodule.c: make two functions static
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is tangled with hv/submodule-merge-search.)

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

Will kick back to "pu" at least tentatively.

* mh/iterate-refs (2011-09-11) 7 commits
  (merged to 'next' on 2011-09-27 at c289699)
 + refs.c: make create_cached_refs() static
 + Retain caches of submodule refs
 + Store the submodule name in struct cached_refs
 + Allocate cached_refs objects dynamically
 + Change the signature of read_packed_refs()
 + Access reference caches only through new function get_cached_refs()
 + Extract a function clear_cached_refs()

Will merge to "master" in the second wave.

* hv/submodule-update-none (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-24 at 5302fc1)
 + add update 'none' flag to disable update of submodule by default
 + submodule: move update configuration variable further up

Will merge to "master" in the second wave.

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

Will kick back to 'pu'.

* fg/submodule-git-file-git-dir (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-23 at 762194e)
 + Move git-dir for submodules
 + rev-parse: add option --resolve-git-dir <path>

Will merge to "master" in the second wave.

* jk/http-auth-keyring (2011-09-28) 22 commits
  (merged to 'next' on 2011-09-28 at 65ce6c2)
 + credential-cache: don't cache items without context
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
 (this branch is tangled with js/cred-macos-x-keychain-2.)

Will kick back to 'pu'.
