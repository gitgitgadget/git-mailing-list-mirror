From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2011, #02; Tue, 6)
Date: Tue, 06 Sep 2011 16:43:48 -0700
Message-ID: <7v1uvt6xu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 01:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R15KK-0002tx-JH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 01:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab1IFXnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 19:43:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355Ab1IFXnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 19:43:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A505250EE;
	Tue,  6 Sep 2011 19:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	5WFI8COPX1Nqiliiqc3aKCR4HY=; b=lR5y92Y2NDi9WmvlnNddof5HsCez4+sZ2
	6bnbw2MlBXLJrMeAuyBXPvMsIdF/4kZunl2oCmHD5IjfA4hQQrM79g5P9ccthioY
	UsQpG3fwE+kO6dzjnlJgQgahwmCqvse9NfAGSVEcC/LkY3yiBZyDDEfRI7n6y4Zy
	4KEgaz6ApY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nMH
	OBWSzSoUeMaIFIeRP6kLf+YBCEkOBCTvk3EWWIVNG+Edd3Z2SVqVRQH+w2GpTvcR
	GD5kDojL5aGQACLbVNgqv/PMHskogTnNaGSNzhzPXSBi/gDGkSKQtVMK7Mkjd1yO
	Nc+nxHcO5jZ02Avr2Ne6ORSNtFP/pLEaq11NuV8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CBC550ED;
	Tue,  6 Sep 2011 19:43:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A495950EC; Tue,  6 Sep 2011
 19:43:49 -0400 (EDT)
X-master-at: 50963badbcfe2693d7a51ace3079c6b48ec52f01
X-next-at: 7931f38a2fd882b0f75a4d6f0eb60c3b1b094178
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11F8D938-D8E2-11E0-AE0A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180846>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

Some of the recent patches are fixes to new feature topics already merged
to "master" and are being fast tracked for 1.7.7-rc1, but otherwise
patches for new features and fixes to longstanding issues will stay in
'pu' or 'next' until the 1.7.7 final.

--------------------------------------------------
[Graduated to "master"]

* cb/maint-ls-files-error-report (2011-08-28) 1 commit
  (merged to 'next' on 2011-08-30 at b606e19)
 + t3005: do not assume a particular order of stdout and stderr of git-ls-files

* mh/check-ref-format-print-normalize (2011-08-27) 2 commits
  (merged to 'next' on 2011-08-30 at e827410)
 + Forbid DEL characters in reference names
 + check-ref-format --print: Normalize refnames that start with slashes

* rc/histogram-diff (2011-08-31) 1 commit
  (merged to 'next' on 2011-09-02 at be4d245)
 + xdiff/xprepare: initialise xdlclassifier_t cf in xdl_prepare_env()

--------------------------------------------------
[New Topics]

* cb/common-prefix-unification (2011-09-06) 3 commits
 - rename pathspec_prefix() to common_prefix() and move to dir.[ch]
 - consolidate pathspec_prefix and common_prefix
 - remove prefix argument from pathspec_prefix

* cb/maint-quiet-push (2011-09-05) 4 commits
 . t5541: avoid TAP test miscounting
 . push: old receive-pack does not understand --quiet
 . fix push --quiet via http
 . tests for push --quiet

Dropped for rerolling after 1.7.7 cycle.

* cb/send-email-help (2011-09-05) 1 commit
 - send-email: add option -h

* jc/fetch-pack-fsck-objects (2011-09-04) 3 commits
 - test: fetch/receive with fsckobjects
 - transfer.fsckobjects: unify fetch/receive.fsckobjects
 - fetch.fsckobjects: verify downloaded objects

* jc/receive-verify (2011-09-02) 3 commits
 - receive-pack: check connectivity before concluding "git push"
 - check_everything_connected(): libify
 - check_everything_connected(): refactor to use an iterator
 (this branch uses jc/fetch-verify, jc/fetch-verify and jc/traverse-commit-list.)

* tr/doc-note-rewrite (2011-09-05) 1 commit
 - Documentation: "on for all" configuration of notes.rewriteRef

* jc/request-pull-show-head (2011-09-06) 1 commit
 - State what commit to expect in request-pull

* jn/maint-http-error-message (2011-09-06) 2 commits
 - http: avoid empty error messages for some curl errors
 - http: remove extra newline in error message

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

* jk/generation-numbers (2011-07-14) 7 commits
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

* bk/ancestry-path (2011-08-25) 3 commits
  (merged to 'next' on 2011-09-02 at d05ba5d)
 + revision: do not include sibling history in --ancestry-path output
 + revision: keep track of the end-user input from the command line
 + rev-list: Demonstrate breakage with --ancestry-path --all

The topic came up a bit too late in the cycle.
Will cook for a while.

* mg/branch-list (2011-08-28) 5 commits
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

* hv/submodule-merge-search (2011-08-26) 4 commits
 - submodule: Search for merges only at end of recursive merge
 - allow multiple calls to submodule merge search for the same path
 - submodule: Demonstrate known breakage during recursive merge
 - push: Don't push a repository with unpushed submodules
 (this branch uses fg/submodule-auto-push.)

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

* fg/submodule-auto-push (2011-08-20) 1 commit
  (merged to 'next' on 2011-08-24 at 398e764)
 + push: teach --recurse-submodules the on-demand option
 (this branch is used by hv/submodule-merge-search.)

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* jc/fetch-verify (2011-09-01) 3 commits
 - fetch: verify we have everything we need before updating our ref
 - rev-list --verify-object
 - list-objects: pass callback data to show_objects()
 (this branch is used by jc/receive-verify and jc/receive-verify; uses jc/traverse-commit-list.)

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

* mh/iterate-refs (2011-08-14) 6 commits
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

* jk/http-auth-keyring (2011-08-03) 13 commits
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

Looked mostly reasonable except for the limitation that it is not clear
how to deal with a site at which a user needs to use different passwords 
for different repositories. Will keep it in "next" at least for one cycle,
until we start hearing real-world success reports on the list.

Not urgent; will not be in 1.7.7.

* rr/revert-cherry-pick-continue (2011-08-08) 18 commits
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
