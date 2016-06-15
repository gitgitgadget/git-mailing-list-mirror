From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #09; Sun, 23)
Date: Mon, 24 Oct 2011 08:31:31 -0700
Message-ID: <7v39ei4d9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 17:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMV9-0003D9-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 17:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621Ab1JXPbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 11:31:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932516Ab1JXPbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 11:31:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3566352E5;
	Mon, 24 Oct 2011 11:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=w
	aolhUN5oa85eZRkictMvcJ4YBc=; b=DL3Zng3H70h/rqcQ38Edsy8QQn3XhqV2u
	h5wxZPEAL2CPpxAyGeXnRAd57oxNRBnjwuF6veocJUXVAouzH6WdZ8vU+SrAJlLt
	BQRg2x+ytdbI/W2oub7a1V/ClMhqzOuVupqnNDxT0JBM/O3SiETcqCQn3Y1JQ7kR
	hzNCM4yW8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=S/8
	FhH7yv1XuIJl+MhGm7+pJj0SozdsK6Rve5iC9i4YCIc4fWoVqBjspbb8r6hNugK9
	eaiuX7KOxq/5ef7lumrCRc1VwyUe9TbJnbRBOvivuJKq/lRPSt6YH6/vV++gj/JP
	gf9yzye5pi4pgmCaoheXy/ksCHFVagAhS74UcRN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3A852E4;
	Mon, 24 Oct 2011 11:31:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C01752E3; Mon, 24 Oct 2011
 11:31:32 -0400 (EDT)
X-master-at: 10b2a48113b8ab6b8f48229eb40fc3637ce025ae
X-next-at: 03eec2553f5bdf546687f47517181ada4484cae8
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40998D9E-FE55-11E0-A720-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184173>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

It probably is a good point to stop taking new topics and start
switching our focus to fixing bugs in the topics already in 'master'.

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
[New Topics]

* nd/pretty-commit-log-message (2011-10-23) 2 commits
 - pretty.c: use original commit message if reencoding fails
 - pretty.c: free get_header() return value

--------------------------------------------------
[Graduated to "master"]

* cn/doc-config-bare-subsection (2011-10-16) 1 commit
  (merged to 'next' on 2011-10-17 at a6412d4)
 + Documentation: update [section.subsection] to reflect what git does

* jc/broken-ref-dwim-fix (2011-10-19) 3 commits
  (merged to 'next' on 2011-10-19 at 40cad95)
 + resolve_ref(): report breakage to the caller without warning
 + resolve_ref(): expose REF_ISBROKEN flag
 + refs.c: move dwim_ref()/dwim_log() from sha1_name.c
 (this branch is tangled with jc/check-ref-format-fixup.)

This only takes good bits from the failed jc/check-ref-format-fixup topic
and implements saner workaround for the recent breakage on the 'master'.

* jc/maint-remove-renamed-ref (2011-10-12) 1 commit
  (merged to 'next' on 2011-10-12 at 819c3e4)
 + branch -m/-M: remove undocumented RENAMED-REF

* jc/make-tags (2011-10-18) 1 commit
  (merged to 'next' on 2011-10-19 at b0b91bf)
 + Makefile: ask "ls-files" to list source files if available

* jc/match-refs-clarify (2011-09-12) 2 commits
  (merged to 'next' on 2011-10-19 at b295e1e)
 + rename "match_refs()" to "match_push_refs()"
 + send-pack: typofix error message

* jc/unseekable-bundle (2011-10-13) 2 commits
  (merged to 'next' on 2011-10-19 at 2978ee0)
 + bundle: add parse_bundle_header() helper function
 + bundle: allowing to read from an unseekable fd

* jk/daemon-msgs (2011-10-15) 1 commit
  (merged to 'next' on 2011-10-15 at 415cf53)
 + daemon: give friendlier error messages to clients
 (this branch is used by cb/daemon-permission-errors.)

* jk/maint-pack-objects-compete-with-delete (2011-10-14) 2 commits
  (merged to 'next' on 2011-10-15 at 49479e4)
 + downgrade "packfile cannot be accessed" errors to warnings
 + pack-objects: protect against disappearing packs

* mh/ref-api (2011-10-16) 7 commits
  (merged to 'next' on 2011-10-17 at 219000f)
 + clear_ref_cache(): inline function
 + write_ref_sha1(): only invalidate the loose ref cache
 + clear_ref_cache(): extract two new functions
 + clear_ref_cache(): rename parameter
 + invalidate_ref_cache(): expose this function in the refs API
 + invalidate_ref_cache(): take the submodule as parameter
 + invalidate_ref_cache(): rename function from invalidate_cached_refs()
 (this branch is used by mh/ref-api-2 and mh/ref-api-3.)

* ph/transport-with-gitfile (2011-10-11) 5 commits
  (merged to 'next' on 2011-10-12 at 6d58417)
 + Fix is_gitfile() for files too small or larger than PATH_MAX to be a gitfile
  (merged to 'next' on 2011-10-06 at 891b8b6)
 + Add test showing git-fetch groks gitfiles
 + Teach transport about the gitfile mechanism
 + Learn to handle gitfiles in enter_repo
 + enter_repo: do not modify input

* po/insn-editor (2011-10-17) 1 commit
  (merged to 'next' on 2011-10-19 at cbf5e0b)
 + "rebase -i": support special-purpose editor to edit insn sheet

* pw/p4-update (2011-10-17) 6 commits
  (merged to 'next' on 2011-10-17 at f69f6cc)
 + git-p4: handle files with shell metacharacters
 + git-p4: keyword flattening fixes
 + git-p4: stop ignoring apple filetype
 + git-p4: recognize all p4 filetypes
 + git-p4: handle utf16 filetype properly
 + git-p4 tests: refactor and cleanup

* sc/difftool-skip (2011-10-14) 2 commits
  (merged to 'next' on 2011-10-14 at b91c581)
 + t7800: avoid arithmetic expansion notation
  (merged to 'next' on 2011-10-11 at 38d7e84)
 + git-difftool: allow skipping file by typing 'n' at prompt

* ss/inet-ntop (2011-10-18) 1 commit
  (merged to 'next' on 2011-10-19 at 85469f6)
 + inet_ntop.c: Work around GCC 4.6's detection of uninitialized variables

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

* jc/verbose-checkout (2011-10-16) 2 commits
 - checkout -v: give full status output after switching branches
 - checkout: move the local changes report to the end

This is just to leave a record that the reason why we do not do this not
because we are incapable of coding this, but because it is not a good idea
to do this. I suspect people who are new to git that might think they need
it would soon realize the don't.

Will keep in 'pu' as a showcase for a while and then will drop.

--------------------------------------------------
[Cooking]

* tc/submodule-clone-name-detection (2011-10-21) 2 commits
  (merged to 'next' on 2011-10-23 at c18af03)
 + submodule::module_clone(): silence die() message from module_name()
 + submodule: whitespace fix

"git submodule clone" used to show unnecessary error message when
submodule mapping from name to path is not found in .gitmodules file.

Will merge to 'master'.

* jm/maint-gitweb-filter-forks-fix (2011-10-21) 1 commit
  (merged to 'next' on 2011-10-21 at debedcd)
 + gitweb: fix regression when filtering out forks

Will merge to 'master' shortly.

* lh/gitweb-site-html-head (2011-10-21) 1 commit
  (merged to 'next' on 2011-10-23 at 65075df)
 + gitweb: provide a way to customize html headers

Will merge to 'master' shortly.

* mh/ref-api-3 (2011-10-19) 11 commits
  (merged to 'next' on 2011-10-23 at 92e2d35)
 + is_refname_available(): reimplement using do_for_each_ref_in_array()
 + names_conflict(): simplify implementation
 + names_conflict(): new function, extracted from is_refname_available()
 + repack_without_ref(): reimplement using do_for_each_ref_in_array()
 + do_for_each_ref_in_array(): new function
 + do_for_each_ref(): correctly terminate while processesing extra_refs
 + add_ref(): take a (struct ref_entry *) parameter
 + create_ref_entry(): extract function from add_ref()
 + parse_ref_line(): add a check that the refname is properly formatted
 + repack_without_ref(): remove temporary
 + Rename another local variable name -> refname
 (this branch uses mh/ref-api-2.)

* mm/mediawiki-author-fix (2011-10-20) 1 commit
  (merged to 'next' on 2011-10-23 at 9f85b67)
 + git-remote-mediawiki: don't include HTTP login/password in author

Will merge to 'master' shortly.

* rr/revert-cherry-pick (2011-10-23) 5 commits
 - revert: simplify communicating command-line arguments
 - revert: allow mixed pick and revert instructions
 - revert: make commit subjects in insn sheet optional
 - revert: simplify getting commit subject in format_todo()
 - revert: free msg in format_todo()

The internals of "git revert/cherry-pick" has been further refactored to
serve as the basis for the sequencer.

Will merge to 'next'.

* jn/libperl-git-config (2011-10-21) 2 commits
  (merged to 'next' on 2011-10-21 at 76e2d4b)
 + Add simple test for Git::config_path() in t/t9700-perl-git.sh
 + libperl-git: refactor Git::config_*

Will merge to 'master' shortly.

* jc/check-ref-format-fixup (2011-10-19) 2 commits
  (merged to 'next' on 2011-10-19 at 98981be)
 + Revert "Restrict ref-like names immediately below $GIT_DIR"
  (merged to 'next' on 2011-10-15 at 8e89bc5)
 + Restrict ref-like names immediately below $GIT_DIR

This became a no-op except for the bottom one which is part of the other
topic now.
Will discard once the other topic graduates to 'master'.

* cb/daemon-permission-errors (2011-10-17) 2 commits
 - daemon: report permission denied error to clients
 - daemon: add tests

The tip commit might be loosening things a bit too much.
Will keep in 'pu' until hearing a convincing argument for the patch.

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
 (this branch is used by mh/ref-api-3.)

It is either merge this quickly to 'master' and hope there won't be any
more unexpected breakage that forces us to delay the release, or hold it
on 'next' until the next cycle. I am inclined to do the former, but not
quite ready to commit to it yet.

* dm/pack-objects-update (2011-10-20) 4 commits
 - pack-objects: don't traverse objects unnecessarily
 - pack-objects: rewrite add_descendants_to_write_order() iteratively
 - pack-objects: use unsigned int for counter and offset values
 - pack-objects: mark add_to_write_order() as inline

Need to re-read this before deciding what to do; it came a bit too late in
the cycle for a series that touches a seriously important part of the
system.

* jk/git-tricks (2011-10-21) 3 commits
  (merged to 'next' on 2011-10-23 at 7c9bf71)
 + completion: match ctags symbol names in grep patterns
 + contrib: add git-jump script
 + contrib: add diff highlight script

* jc/signed-commit (2011-10-21) 7 commits
  (merged to 'next' on 2011-10-23 at 03eec25)
 + pretty: %G[?GS] placeholders
 + parse_signed_commit: really use the entire commit log message
 + test "commit -S" and "log --show-signature"
 + t7004: extract generic "GPG testing" bits
 + log: --show-signature
 + commit: teach --gpg-sign option
 + Split GPG interface into its own helper library

This is to replace the earlier "signed push" experiments.
Will keep in 'next' during this cycle.

* sg/complete-refs (2011-10-21) 9 commits
 - completion: remove broken dead code from __git_heads() and __git_tags()
 - completion: fast initial completion for config 'remote.*.fetch' value
 - completion: improve ls-remote output filtering in __git_refs_remotes()
 - completion: query only refs/heads/ in __git_refs_remotes()
 - completion: support full refs from remote repositories
 - completion: improve ls-remote output filtering in __git_refs()
 - completion: make refs completion consistent for local and remote repos
 - completion: optimize refs completion
 - completion: document __gitcomp()

Will merge to 'next' but won't merge further until an Ack or two from
people who have worked on the completion in the past comes.

* cn/fetch-prune (2011-10-15) 5 commits
  (merged to 'next' on 2011-10-16 at 02a449e)
 + fetch: treat --tags like refs/tags/*:refs/tags/* when pruning
 + fetch: honor the user-provided refspecs when pruning refs
 + remote: separate out the remote_find_tracking logic into query_refspecs
 + t5510: add tests for fetch --prune
 + fetch: free all the additional refspecs

"git fetch --prune" used to prune remote tracking branches by comparing
what was actually fetched and what was configured to be fetched, which was
wrong.

Will merge to 'master' shortly.

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

Allow setting "description" for branches and use it to help communications
between humans in various workflow elements.

Will keep in 'next' during this cycle.
