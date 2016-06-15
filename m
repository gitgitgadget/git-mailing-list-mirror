From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2011, #11; Fri, 28)
Date: Fri, 28 Oct 2011 11:12:59 -0700
Message-ID: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 20:13:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJqvX-0007gf-56
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab1J1SNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:13:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab1J1SNC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:13:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1669B4644;
	Fri, 28 Oct 2011 14:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	bQBh6c0NMXfUxXqrw65KDJQ+yY=; b=kNIZRBuspM7VFvwGBRaacP2OUDiSh+/6o
	aJ+uS2Lb7H+D7Z+aLb/ZAIZCc0FaFbWi88TR5P8utqGXgWmXpyVnOlb49dwIj34q
	3kbarhA/UTlv6V1SNnSbLcpOzYSkWcyVyiQlixI8bZoO6PvqvOvuqISIEI2Ljw/O
	Zyz01Y+7JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oWd
	0eIdMixIkk3Od2RarwRRCsA/ukzqVW8fRc0QC6dpwFwTUFThIcVUMqrVQGVIddlO
	kapxeeTY/V3AtI81X+kg9zv32A/KCiLrL+jZicOyijcZ01Ot3WT2Cs33n2XUjJYv
	yZEvzuRKjHjVup7zy6n5KnrsJGDS2DMKvtZ0hGG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1A84643;
	Fri, 28 Oct 2011 14:13:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4024A4642; Fri, 28 Oct 2011
 14:13:01 -0400 (EDT)
X-master-at: e8e1c29021da446d0c50573ef9619bf74f515c20
X-next-at: 2527a49a5c76e4269d28e410ef11c6c243f1abcb
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78E096BE-0190-11E1-8B9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184421>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

I am hoping to tag 1.7.8-rc0 this weekend. Proposals and patches for
changes that are not regression fixes need to wait until the next
development cycle.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches but not todo, html or man:

        https://github.com/gitster/git

I will stop pushing the generated documentation branches to the above
repositories, as they are not sources. The only reason the source
repository at k.org has hosted these branches was because it was the only
repository over there that was writable by me; it was an ugly historical
and administrative workaround and not a demonstration of the best
practice.

These branches are pushed to their own separate repositories instead:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* nd/misc-cleanups (2011-10-27) 6 commits
  (merged to 'next' on 2011-10-28 at 2527a49)
 + unpack_object_header_buffer(): clear the size field upon error
 + tree_entry_interesting: make use of local pointer "item"
 + tree_entry_interesting(): give meaningful names to return values
 + read_directory_recursive: reduce one indentation level
 + get_tree_entry(): do not call find_tree_entry() on an empty tree
 + tree-walk.c: do not leak internal structure in tree_entry_len()

These are unquestionably good parts taken out of a larger series, so that
we can focus more on the other changes in later rounds of review.

Will keep in 'next' during this cycle.

* ss/blame-textconv-fake-working-tree (2011-10-28) 2 commits
 - (squash) test for previous
 - blame.c: Properly initialize strbuf after calling, textconv_object()

A trivial fix for a breakage worth fixing.
Will merge to 'master' before -rc1.

--------------------------------------------------
[Graduated to "master"]

* js/grep-mutex (2011-10-26) 3 commits
  (merged to 'next' on 2011-10-26 at 6fac2d6)
 + builtin/grep: simplify lock_and_read_sha1_file()
 + builtin/grep: make lock/unlock into static inline functions
 + git grep: be careful to use mutexes only when they are initialized

* rj/gitweb-clean-js (2011-10-26) 1 commit
  (merged to 'next' on 2011-10-26 at db36a24)
 + gitweb/Makefile: Remove static/gitweb.js in the clean target

* rs/maint-estimate-cache-size (2011-10-26) 1 commit
  (merged to 'next' on 2011-10-26 at 2f11375)
 + read-cache.c: fix index memory allocation

* sn/complete-bash-wo-process-subst (2011-10-26) 1 commit
  (merged to 'next' on 2011-10-26 at 8662ed6)
 + completion: fix issue with process substitution not working on Git for Windows

--------------------------------------------------
[Stalled]

* hv/submodule-merge-search (2011-10-13) 4 commits
 - submodule.c: make two functions static
 - allow multiple calls to submodule merge search for the same path
 - push: Don't push a repository with unpushed submodules
 - push: teach --recurse-submodules the on-demand option

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

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

* kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
 - gitweb: add a feature to show side-by-side diff
 - gitweb: change format_diff_line() to remove leading SP from $diff_class

Fun.
Will keep in 'pu' until the planned re-roll comes.

--------------------------------------------------
[Cooking]

* ef/mingw-upload-archive (2011-10-26) 3 commits
 - upload-archive: use start_command instead of fork
 - compat/win32/poll.c: upgrade from upstream
 - mingw: move poll out of sys-folder

Are msysgit folks OK with this series (I didn't see msysgit list Cc'ed on
these patches)? If so let's move this forward, as the changes to the core
part seem solid.

* rs/allocate-cache-entry-individually (2011-10-26) 2 commits
  (merged to 'next' on 2011-10-27 at 2e4acd6)
 + cache.h: put single NUL at end of struct cache_entry
 + read-cache.c: allocate index entries individually

Will keep in 'next' during this cycle.

* nd/pretty-commit-log-message (2011-10-23) 2 commits
  (merged to 'next' on 2011-10-27 at 4b61df7)
 + pretty.c: use original commit message if reencoding fails
 + pretty.c: free get_header() return value

Will merge to 'master' before -rc0.

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

Will keep in 'next' during this cycle.

* rr/revert-cherry-pick (2011-10-23) 5 commits
  (merged to 'next' on 2011-10-26 at 27b7496)
 + revert: simplify communicating command-line arguments
 + revert: allow mixed pick and revert instructions
 + revert: make commit subjects in insn sheet optional
 + revert: simplify getting commit subject in format_todo()
 + revert: free msg in format_todo()

The internals of "git revert/cherry-pick" has been further refactored to
serve as the basis for the sequencer.

Will keep in 'next' during this cycle.

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

Will keep in 'next' during this cycle.

* dm/pack-objects-update (2011-10-20) 4 commits
  (merged to 'next' on 2011-10-27 at fa52898)
 + pack-objects: don't traverse objects unnecessarily
 + pack-objects: rewrite add_descendants_to_write_order() iteratively
 + pack-objects: use unsigned int for counter and offset values
 + pack-objects: mark add_to_write_order() as inline

Will merge to 'master' before -rc0.

* jk/git-tricks (2011-10-21) 3 commits
  (merged to 'next' on 2011-10-23 at 7c9bf71)
 + completion: match ctags symbol names in grep patterns
 + contrib: add git-jump script
 + contrib: add diff highlight script

As this stuff is in contrib/ I do not care too much about the stability.
Will merge to 'master' unless there is strong objection.

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
  (merged to 'next' on 2011-10-26 at d65e2b4)
 + completion: remove broken dead code from __git_heads() and __git_tags()
 + completion: fast initial completion for config 'remote.*.fetch' value
 + completion: improve ls-remote output filtering in __git_refs_remotes()
 + completion: query only refs/heads/ in __git_refs_remotes()
 + completion: support full refs from remote repositories
 + completion: improve ls-remote output filtering in __git_refs()
 + completion: make refs completion consistent for local and remote repos
 + completion: optimize refs completion
 + completion: document __gitcomp()

Will keep in 'next' until an Ack or two from completion folks.

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
