From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2011, #03; Sun, 11)
Date: Sun, 11 Sep 2011 23:21:58 -0700
Message-ID: <7vwrde9t6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 08:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2zuE-0000Yw-KE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 08:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab1ILGWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 02:22:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab1ILGWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 02:22:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1180B274C;
	Mon, 12 Sep 2011 02:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	jvFx2iuGFOdKv62BvxBr6DohA8=; b=lImIknv5UK+Mxd/IxL7YoY41lqAlZA5ZE
	N6rYGFoHhwKGsIJpbTKouv0lfpgV+5H4h+j2ijsURjQWgIA1/2iiyXL4RA2c3a0z
	xtUAMt4JPuX7uTl+ovtTjJKQREUPg8CBFKeXrlHaR4pqbuVlFgoYQ4ZdqSWHSsJS
	QyaXMXlDOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SIO
	1eAKp/BWjZ/k0whKG65W0hM4pGUyd4aqEHbLZLFYm3CHFCP4t9Vod7RGnDMlCEY0
	rjSjWveoES+MCfdWE/d6gOXyL/VTBKKbYRuiZi8xKK/4qWUqlZ4BV9+SAjso1Ilu
	tzFCWLCqoq3gnGDcCP8A79ZIVIVQAsFLJC0TLiv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D73274B;
	Mon, 12 Sep 2011 02:22:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD3B52749; Mon, 12 Sep 2011
 02:21:59 -0400 (EDT)
X-master-at: 2f9e2e75874e0f0722382106e2e189cc3f95cc7d
X-next-at: 3361ec88dee79e371d3b68c985d8dd7bdc0c4e6c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85AF9942-DD07-11E0-8585-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181210>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

Some of the recent patches are fixes to new feature topics already merged
to "master" and are being fast tracked for 1.7.7-rc1, but otherwise
patches for new features and fixes to longstanding issues will stay in
'pu' or 'next' until the 1.7.7 final.

I was hoping that k.org would be back into healthy state soonish and that
is why I haven't tagged the -rc1 yet, but it has already been two weeks,
so sometime in the middle of the coming week -rc1 will happen with or
without k.org repository keeping in sync with us.

In the meantime, here are the repositories that have my integration
branches:

With maint, master, next, pu and todo:

	url = git://repo.or.cz/alt-git.git
	url = https://code.google.com/p/git-core/

With only maint and master:

	url = git://git.sourceforge.jp/gitroot/git-core/git.git
	url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

	url = https://github.com/gitster/git

--------------------------------------------------
[New Topics]

* hl/iso8601-more-zone-formats (2011-09-09) 2 commits
 - fixup? simplification and tightening
 - date.c: Support iso8601 timezone formats

* jc/signed-push (2011-09-09) 7 commits
 . push -s: support pre-receive-signature hook
 . push -s: receiving end
 . push -s: send signed push certificate
 . push -s: skeleton
 . refactor run_receive_hook()
 - Split GPG interface into its own helper library
 - send-pack: typofix error message
 (this branch is tangled with jc/signed-push-3.)

This was the v2 that updated notes tree on the receiving end.

* jc/signed-push-3 (2011-09-09) 4 commits
 - push -s: signed push
 - rename "match_refs()" to "match_push_refs()"
 - Split GPG interface into its own helper library
 - send-pack: typofix error message
 (this branch is tangled with jc/signed-push.)

This is the third edition, that moves the preparation of the notes tree to
the sending end.

* jc/run-receive-hook-cleanup (2011-09-09) 1 commit
 - refactor run_receive_hook()

This is a remnant in the jc/signed-push topic that has become unnecessary
for the purpose of jc/signed-push-3, but is retained for its clean-up
value.

The corresponding one will be dropped when rebuilding the jc/signed-push
topic on top of this topic later.

* jk/for-each-ref (2011-09-08) 5 commits
 - for-each-ref: add split message parts to %(contents:*).
 - for-each-ref: handle multiline subjects like --pretty
 - for-each-ref: refactor subject and body placeholder parsing
 - t6300: add more body-parsing tests
 - t7004: factor out gpg setup

* wh/normalize-alt-odb-path (2011-09-07) 1 commit
 - sha1_file: normalize alt_odb path before comparing and storing

* fk/use-kwset-pickaxe-grep-f (2011-09-11) 2 commits
 - obstack.c: Fix some sparse warnings
 - sparse: Fix an "Using plain integer as NULL pointer" warning

* jc/make-static (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-11 at 2acb0af)
 + vcs-svn: remove unused functions and make some static
 + make-static: master

* jl/maint-fetch-submodule-check-fix (2011-09-09) 1 commit
 - fetch: skip on-demand checking when no submodules are configured

* rj/quietly-create-dep-dir (2011-09-11) 1 commit
 - Makefile: Make dependency directory creation less noisy

* js/cred-macos-x-keychain (2011-09-11) 1 commit
 - contrib: add a credential helper for Mac OS X's keychain
 (this branch uses jk/http-auth-keyring.)

* mh/check-ref-format (2011-09-11) 8 commits
 - Add tools to avoid the use of unnormalized refnames.
 - Do not allow ".lock" at the end of any refname component
 - Add a library function normalize_refname()
 - Change check_ref_format() to take a flags argument
 - fixup asciidoc formatting
 - git check-ref-format: add options --allow-onelevel and --refspec-pattern
 - Change bad_ref_char() to return a boolean value
 - t1402: add some more tests

* mz/remote-rename (2011-09-11) 4 commits
 - remote: only update remote-tracking branch if updating refspec
 - remote rename: warn when refspec was not updated
 - remote: "rename o foo" should not rename ref "origin/bar"
 - remote: write correct fetch spec when renaming remote 'remote'

* rj/maint-t9159-svn-rev-notation (2011-09-11) 1 commit
 - t9159-*.sh: Add an svn version check

--------------------------------------------------
[Stalled]

* jk/add-i-hunk-filter (2011-07-27) 5 commits
  (merged to 'next' on 2011-08-11 at 8ff9a56)
 + add--interactive: add option to autosplit hunks
 + add--interactive: allow negatation of hunk filters
 + add--interactive: allow hunk filtering on command line
 + add--interactive: factor out regex error handling
 + add--interactive: refactor patch mode argument processing

Needs documentation updates, tests, and integration with the higher level
callers, e.g. "git add -p".

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

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.
Cf. $gmane/176254, 176255, 166256

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

* po/cygwin-backslash (2011-08-05) 2 commits
 - On Cygwin support both UNIX and DOS style path-names
 - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

I think a further refactoring (no, not my suggestion) was offered?

--------------------------------------------------
[Cooking]

* cb/common-prefix-unification (2011-09-11) 4 commits
 - dir.c: make common_prefix_len() static
 - rename pathspec_prefix() to common_prefix() and move to dir.[ch]
 - consolidate pathspec_prefix and common_prefix
 - remove prefix argument from pathspec_prefix

* cb/send-email-help (2011-09-05) 1 commit
 - send-email: add option -h

* jc/fetch-pack-fsck-objects (2011-09-04) 3 commits
 - test: fetch/receive with fsckobjects
 - transfer.fsckobjects: unify fetch/receive.fsckobjects
 - fetch.fsckobjects: verify downloaded objects

* jc/receive-verify (2011-09-09) 6 commits
 - receive-pack: check connectivity before concluding "git push"
 - check_everything_connected(): libify
 - check_everything_connected(): refactor to use an iterator
 - fetch: verify we have everything we need before updating our ref
 - rev-list --verify-object
 - list-objects: pass callback data to show_objects()
 (this branch uses jc/traverse-commit-list; is tangled with jc/fetch-verify and jc/fetch-verify.)

* tr/doc-note-rewrite (2011-09-05) 1 commit
 - Documentation: "on for all" configuration of notes.rewriteRef

It was questioned if the new text suggests a sane and safe thing to do.

* jc/request-pull-show-head (2011-09-06) 1 commit
 - State what commit to expect in request-pull

* jn/maint-http-error-message (2011-09-06) 2 commits
 - http: avoid empty error messages for some curl errors
 - http: remove extra newline in error message

* bk/ancestry-path (2011-08-25) 3 commits
  (merged to 'next' on 2011-09-02 at d05ba5d)
 + revision: do not include sibling history in --ancestry-path output
 + revision: keep track of the end-user input from the command line
 + rev-list: Demonstrate breakage with --ancestry-path --all

The topic came up a bit too late in the cycle.
Will cook for a while.

* mg/branch-list (2011-09-08) 6 commits
  (merged to 'next' on 2011-09-11 at 20a9cdb)
 + branch: -v does not automatically imply --list
  (merged to 'next' on 2011-09-02 at b818eae)
 + branch: allow pattern arguments
 + branch: introduce --list option
 + git-branch: introduce missing long forms for the options
 + git-tag: introduce long forms for the options
 + t6040: test branch -vv

Not urgent; the topic came up a bit too late in the cycle.

* mm/rebase-i-exec-edit (2011-08-26) 2 commits
  (merged to 'next' on 2011-09-02 at e75b1b9)
 + rebase -i: notice and warn if "exec $cmd" modifies the index or the working tree
 + rebase -i: clean error message for --continue after failed exec

Not urgent; the topic came up a bit too late in the cycle.

* jk/default-attr (2011-08-26) 1 commit
 - attr: map builtin userdiff drivers to well-known extensions

Not urgent; I fixed up the test breakage just for fun.

* hv/submodule-merge-search (2011-08-26) 5 commits
 - submodule: Search for merges only at end of recursive merge
 - allow multiple calls to submodule merge search for the same path
 - submodule: Demonstrate known breakage during recursive merge
 - push: Don't push a repository with unpushed submodules
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is tangled with fg/submodule-auto-push.)

Not urgent; the topic came up a bit too late in the cycle.
The bottom one needs to be replaced with a properly written commit log message.

* mm/mediawiki-as-a-remote (2011-09-01) 2 commits
 - git-remote-mediawiki: allow push to set MediaWiki metadata
 - Add a remote helper to interact with mediawiki (fetch & push)

Fun.
Not urgent; the topic came up a bit too late in the cycle.

* nd/maint-autofix-tag-in-head (2011-08-26) 3 commits
 - Accept tags in HEAD or MERGE_HEAD
 - merge: remove global variable head[]
 - merge: keep stash[] a local variable

Probably needs a re-roll to aim a bit higher.
Not urgent; will not be in 1.7.7.

* bc/unstash-clean-crufts (2011-08-27) 4 commits
  (merged to 'next' on 2011-09-02 at 7bfd66f)
 + git-stash: remove untracked/ignored directories when stashed
 + t/t3905: add missing '&&' linkage
 + git-stash.sh: fix typo in error message
 + t/t3905: use the name 'actual' for test output, swap arguments to test_cmp

Not urgent; the topic came up a bit too late in the cycle.

* da/make-auto-header-dependencies (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at e04a4af)
 + Makefile: Improve compiler header dependency check
 (this branch uses fk/make-auto-header-dependencies.)

Not urgent; will not be in 1.7.7.

* gb/am-hg-patch (2011-08-29) 1 commit
  (merged to 'next' on 2011-09-02 at 3edfe4c)
 + am: preliminary support for hg patches

Not urgent; the topic came up a bit too late in the cycle.

* jc/diff-index-unpack (2011-08-29) 3 commits
  (merged to 'next' on 2011-09-02 at 4206bd9)
 + diff-index: pass pathspec down to unpack-trees machinery
 + unpack-trees: allow pruning with pathspec
 + traverse_trees(): allow pruning with pathspec

Will cook for a while.

* jn/remote-helpers-doc (2011-09-01) 3 commits
 - (short) documentation for the testgit remote helper
 - Documentation/git-remote-helpers: explain how import works with multiple refs
 - Documentation/remote-helpers: explain capabilities first

Not urgent.

* nm/grep-object-sha1-lock (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at 336f57d)
 + grep: Fix race condition in delta_base_cache

Not urgent; the topic came up a bit too late in the cycle.

* tr/mergetool-valgrind (2011-08-30) 1 commit
  (merged to 'next' on 2011-09-02 at f5f2c61)
 + Symlink mergetools scriptlets into valgrind wrappers

Not urgent; the topic came up a bit too late in the cycle.

* fg/submodule-auto-push (2011-09-11) 2 commits
  (merged to 'next' on 2011-09-11 at 3fc86f7)
 + submodule.c: make two functions static
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is tangled with hv/submodule-merge-search.)

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* jc/fetch-verify (2011-09-01) 3 commits
 - fetch: verify we have everything we need before updating our ref
 - rev-list --verify-object
 - list-objects: pass callback data to show_objects()
 (this branch uses jc/traverse-commit-list; is tangled with jc/receive-verify and jc/receive-verify.)

Make "git fetch" verify what it received a bit more carefully before
updating the refs in the receiving end.

Not urgent; the topic came up a bit too late in the cycle.

* jc/traverse-commit-list (2011-08-22) 3 commits
  (merged to 'next' on 2011-08-24 at df50dd7)
 + revision.c: update show_object_with_name() without using malloc()
 + revision.c: add show_object_with_name() helper function
 + rev-list: fix finish_object() call
 (this branch is used by jc/fetch-verify and jc/receive-verify.)

Not urgent; will not be in 1.7.7.

* fk/make-auto-header-dependencies (2011-08-18) 1 commit
  (merged to 'next' on 2011-08-24 at 3da2c25)
 + Makefile: Use computed header dependencies if the compiler supports it
 (this branch is used by da/make-auto-header-dependencies.)

Not urgent; will not be in 1.7.7.

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

Not urgent; will not be in 1.7.7.

* hv/submodule-update-none (2011-08-11) 2 commits
  (merged to 'next' on 2011-08-24 at 5302fc1)
 + add update 'none' flag to disable update of submodule by default
 + submodule: move update configuration variable further up

Not urgent; will not be in 1.7.7.

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

Not urgent; will not be in 1.7.7.

* fg/submodule-git-file-git-dir (2011-08-22) 2 commits
  (merged to 'next' on 2011-08-23 at 762194e)
 + Move git-dir for submodules
 + rev-parse: add option --resolve-git-dir <path>

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage outweighs any benefit for having this new
feature. Will keep it in 'next' at least for one cycle.

Not urgent; will not be in 1.7.7.

* jk/http-auth-keyring (2011-09-11) 14 commits
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
 (this branch is used by js/cred-macos-x-keychain.)

Looked mostly reasonable except for the limitation that it is not clear
how to deal with a site at which a user needs to use different passwords 
for different repositories. Will keep it in "next" at least for one cycle,
until we start hearing real-world success reports on the list.

Not urgent; will not be in 1.7.7.

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

Will keep it in 'next' at least for one cycle.
Not urgent; will not be in 1.7.7.

--------------------------------------------------
[Discarded]

* jk/pager-with-alias (2011-08-19) 1 commit
 . support pager.* for aliases

* cb/maint-quiet-push (2011-09-05) 4 commits
 . t5541: avoid TAP test miscounting
 . push: old receive-pack does not understand --quiet
 . fix push --quiet via http
 . tests for push --quiet

Dropped for rerolling after 1.7.7 cycle.
