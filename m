From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #07; Wed, 19)
Date: Wed, 19 Oct 2011 14:57:37 -0700
Message-ID: <7vk480bq5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 23:58:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGe9B-0005gD-P6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab1JSV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:57:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1JSV5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:57:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A9F6449;
	Wed, 19 Oct 2011 17:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	WtSlLbmm1LQalLGm4msTcAfFE4=; b=KAIP9igjD+l+k/CCb6PB0bPVXeet+xm0y
	0DcRG3P8b7rMG0MuvNnDHe9QXAGFf9673qzj4eLxBGKyoHV+ExoLCO4EX1nkRCoV
	XWqLqiCar0xAMMWXpkiUqKpoqRaYGDn0QDkNxNKW+KB1OvaENt9JddOqo/hUMvwr
	m9fouEmzRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Kyn
	+uydnpLL0ha+NqpFEo+ahbrRCMblf+UKPoxWDzaQd84x7k1KbAQn8x8HvnDD/aNT
	C7B2uch2XyHjgzGb+sMMQzfFJuzo1ChvFSVT2ncdIYoa2uXqoUnM0yNntrfigEx9
	u7oUGsazKYL7id4Ap8KzHfU0PyP6YoacI1+rrSoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914796448;
	Wed, 19 Oct 2011 17:57:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 669BE6447; Wed, 19 Oct 2011
 17:57:39 -0400 (EDT)
X-master-at: 87009edcbd0b4987ccb7ba050a1efe368a315753
X-next-at: cbf5e0b121e34b6b879a06938b34acda5e1b509d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CC47B70-FA9D-11E0-8732-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183985>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fifth batch of topics started graduating to the master branch. It is
probably a good point to stop taking new topics and start switching our
focus to fixing bugs in the topics already in 'master'.

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

* jc/match-refs-clarify (2011-09-12) 2 commits
 - rename "match_refs()" to "match_push_refs()"
 - send-pack: typofix error message

* jn/libperl-git-config (2011-10-18) 1 commit
 - libperl-git: refactor Git::config_*

* ss/inet-ntop (2011-10-18) 1 commit
 - inet_ntop.c: Work around GCC 4.6's detection of uninitialized variables

--------------------------------------------------
[Graduated to "master"]

* bk/submodule-in-recursive-merge (2011-10-13) 2 commits
  (merged to 'next' on 2011-10-15 at e02205c)
 + submodule: Search for merges only at end of recursive merge
 + submodule: Demonstrate known breakage during recursive merge

Brad helped resurrecting good bits earlier tangled in the stalled topic
hv/submodule-merge-search by mistake.

* cb/httpd-test-fix-port (2011-10-17) 1 commit
  (merged to 'next' on 2011-10-17 at 84fb7e6)
 + use test number as port number

* jm/maint-apply-detects-corrupt-patch-header (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 80d9503)
 + fix "git apply --index ..." not to deref NULL

* jn/gitweb-manpages (2011-10-16) 5 commits
  (merged to 'next' on 2011-10-16 at 6555a07)
 + gitweb: Add gitweb manpages to 'gitweb' package in git.spec
 + Documentation: Add gitweb config variables to git-config(1)
 + Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
 + gitweb: Add gitweb(1) manpage for gitweb itself
 + gitweb: Add gitweb.conf(5) manpage for gitweb configuration files

* js/log-show-children (2011-10-04) 1 commit
  (merged to 'next' on 2011-10-06 at de8f6f2)
 + log --children

* js/maint-no-cherry-pick-head-after-punted (2011-10-06) 2 commits
 + cherry-pick: do not give irrelevant advice when cherry-pick punted
 + revert.c: defer writing CHERRY_PICK_HEAD till it is safe to do so
 (this branch is used by js/no-cherry-pick-head-after-punted.)

Will merge to 'maint' later.

* js/merge-edit-option (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at db28da3)
 + Teach merge the '[-e|--edit]' option

* js/no-cherry-pick-head-after-punted (2011-10-06) 1 commit
  (merged to 'next' on 2011-10-10 at acb29ee)
 + Merge branch 'js/maint-no-cherry-pick-head-after-punted' into js/no-cherry-pick-head-after-punted
 (this branch uses js/maint-no-cherry-pick-head-after-punted.)

* md/smtp-tls-hello-again (2011-10-15) 1 commit
  (merged to 'next' on 2011-10-16 at 3e27de4)
 + send-email: Honour SMTP domain when using TLS

* pt/mingw-misc-fixes (2011-10-15) 7 commits
  (merged to 'next' on 2011-10-16 at 2dc0b55)
 + t9901: fix line-ending dependency on windows
 + mingw: ensure sockets are initialized before calling gethostname
 + mergetools: use the correct tool for Beyond Compare 3 on Windows
 + t9300: do not run --cat-blob-fd related tests on MinGW
 + git-svn: On MSYS, escape and quote SVN_SSH also if set by the user
 + t9001: do not fail only due to CR/LF issues
 + t1020: disable the pwd test on MinGW

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

* jc/check-ref-format-fixup (2011-10-12) 2 commits
  (merged to 'next' on 2011-10-15 at 8e89bc5)
 + Restrict ref-like names immediately below $GIT_DIR
 + refs.c: move dwim_ref()/dwim_log() from sha1_name.c

An attempt to fix-up unfortunate side effect of mh/check-ref-format-3
topic. "git show -s config" is never meant to refer to $GIT_DIR/config
and treat it as a file that records an object name. But tightening the
rule for reading side means we would need to tighten the rule for the
writing side, too, which turned out to be rather nasty fallout that
needs to be sorted out before the next release.

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
  (merged to 'next' on 2011-10-19 at cc89f0e)
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 + cache.h: add comments for git_path() and git_path_submodule()
 (this branch uses mh/ref-api.)

* po/insn-editor (2011-10-17) 1 commit
  (merged to 'next' on 2011-10-19 at cbf5e0b)
 + "rebase -i": support special-purpose editor to edit insn sheet

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

* jc/signed-commit (2011-10-18) 3 commits
 - log: --show-signature
 - commit: teach --gpg-sign option
 - Split GPG interface into its own helper library

This is to replace the earlier "signed push" experiments. "verify-tag"
equivalent needs to be written before this can proceed. I suspect that
teaching "verify-tag" to notice and also handle signed commits would be
the easiest, but "git tag --verify $commit" might look slightly funny
from the UI POV. I dunno.

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
  (merged to 'next' on 2011-10-19 at 2978ee0)
 + bundle: add parse_bundle_header() helper function
 + bundle: allowing to read from an unseekable fd

I am not entirely happy with the first patch but it is not so bad either.

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

* sc/difftool-skip (2011-10-14) 2 commits
  (merged to 'next' on 2011-10-14 at b91c581)
 + t7800: avoid arithmetic expansion notation
  (merged to 'next' on 2011-10-11 at 38d7e84)
 + git-difftool: allow skipping file by typing 'n' at prompt

Will merge to 'master' in the fifth wave.

* jc/maint-remove-renamed-ref (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 819c3e4)
 + branch -m/-M: remove undocumented RENAMED-REF

Will merge to 'master' in the sixth wave.

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
