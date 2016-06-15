From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Mon, 29 Jul 2013 15:43:20 -0700
Message-ID: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 30 00:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3wA9-0004rX-3w
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 00:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218Ab3G2Wn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 18:43:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756176Ab3G2WnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 18:43:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78DFA34D02;
	Mon, 29 Jul 2013 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	OswaRsru8HzW1EsxY87A+Zam8g=; b=FYE6OkfPi/L5hs9UvKirbhlYC1M6kd1Pq
	6ptd89nlncf/fT5hOiOX5NhvdNcWVA8HiK+DthZoxv7O2owNvczrUWuQwEXgijbj
	CqFuRpDJJNK5p7pWHRcQBUIlHk7zsB5fP9gYJY01zdzQigdGjo2OXmMfDzaHUfw4
	8lU5aA0EyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pB1
	14XOkYUGfYxgAcl9TYbo58aCKnieAIcZV1YiZUw4v1/bAXEbQtTrDh5gOT471kOe
	8WmL+VPMkna0vvOvOAf0cyG2IKgS5cFpVV2fJLU4+o4aZtIw+V/VXZJO6qHJQQCY
	121lhJs67uMXrZY1Swhb5R7HqFxM59SwbymweqK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BACD34D00;
	Mon, 29 Jul 2013 22:43:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7AC734CFB;
	Mon, 29 Jul 2013 22:43:21 +0000 (UTC)
X-master-at: 8f6a3e5d71fa1800c3f330bab2b6b6399ec7aea7
X-next-at: cf3f07e67f28b0068199b16bc6974f4bbafb4e51
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4588C512-F8A0-11E2-9EFA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231333>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The shape of the upcoming release is pretty much known by now; all
the topics that are marked for 'master' in this issue will likely to
be in the final, and others will cook during the pre-release freeze
period.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ob/typofixes (2013-07-22) 3 commits
  (merged to 'next' on 2013-07-22 at 8574f9f)
 + typofix: in-code comments
 + typofix: documentation
 + typofix: release notes


* es/contacts (2013-07-21) 5 commits
  (merged to 'next' on 2013-07-22 at a78c3d6)
 + contrib: contacts: add documentation
 + contrib: contacts: add mailmap support
 + contrib: contacts: interpret committish akin to format-patch
 + contrib: contacts: add ability to parse from committish
 + contrib: add git-contacts helper

 A helper to read from a set of format-patch output files or a range
 of commits and find those who may have insights to the code that
 the changes touch by running a series of "git blame" commands.


* es/line-log-further-fixes (2013-07-23) 5 commits
 + line-log: fix "log -LN" crash when N is last line of file
 + range-set: satisfy non-empty ranges invariant
 + t4211: demonstrate crash when first -L encountered is empty range
 + t4211: demonstrate empty -L range crash
 + range-set: fix sort_and_merge_range_set() corner case bug
 (this branch is used by tr/line-log.)


* jk/cat-file-batch-optim (2013-07-18) 9 commits
  (merged to 'next' on 2013-07-22 at 965897c)
 + Fix some sparse warnings
 + sha1_object_info_extended: pass object_info to helpers
 + sha1_object_info_extended: make type calculation optional
 + packed_object_info: make type lookup optional
 + packed_object_info: hoist delta type resolution to helper
 + sha1_loose_object_info: make type lookup optional
 + sha1_object_info_extended: rename "status" to "type"
 + cat-file: disable object/refname ambiguity check for batch mode
 + Merge branch 'nd/warn-ambiguous-object-name' into jk/cat-file-batch-optim

 If somebody wants to only know on-disk footprint of an object
 without having to know its type or payload size, we can bypass a
 lot of code to cheaply learn it.


* jm/doc-ref-prune (2013-07-18) 2 commits
  (merged to 'next' on 2013-07-22 at 414e6ea)
 + Documentation: fix git-prune example usage
 + Documentation: remove --prune from pack-refs examples


* mh/multimail (2013-07-22) 2 commits
  (merged to 'next' on 2013-07-22 at e27c933)
 + post-receive-email: deprecate script in favor of git-multimail
 + git-multimail: an improved replacement for post-receive-email

 An enhanced "post-receive" hook to send e-mail messages.


* mh/ref-races-optim-invalidate-cached (2013-06-20) 1 commit
  (merged to 'next' on 2013-07-22 at 144d135)
 + refs: do not invalidate the packed-refs cache unnecessarily

 This requires the platform lstat() to be correct to avoid false
 negatives.


* ml/avoid-using-grep-on-crlf-files (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-22 at f861472)
 + test-lib.sh - define and use GREP_STRIPS_CR

 On systems that understand a CRLF as a line ending, tests in this
 script that worked on files with CRLF line endings using "grep" to
 extract matching lines may lose the CR at the end of lines that
 match, causing the actual output not to match the expected output.


* ml/cygwin-updates (2013-07-21) 4 commits
  (merged to 'next' on 2013-07-22 at e9c9872)
 + cygwin: stop forcing core.filemode=false
 + Cygwin 1.7 supports mmap
 + Cygwin 1.7 has thread-safe pread
 + Cygwin 1.7 needs compat/regex

 The tip one does _not_ revert c869753e (Force core.filemode to
 false on Cygwin., 2006-12-30) on purpose, so that people can
 still retain the old behaviour if they wanted to.


* rh/template-updates (2013-07-15) 3 commits
  (merged to 'next' on 2013-07-22 at 53dffdd)
 + templates: spell ASCII in uppercase in pre-commit hook
 + templates: Reformat pre-commit hook's message
 + templates: Use heredoc in pre-commit hook

 This is an earlier part of a 6 patch series, with log message
 corrected.


* rj/sparse (2013-07-21) 1 commit
  (merged to 'next' on 2013-07-22 at 24efece)
 + Revert "compat/unsetenv.c: Fix a sparse warning"


* sb/misc-fixes (2013-07-15) 3 commits
  (merged to 'next' on 2013-07-21 at 880b08c)
 + diff.c: Do not initialize a variable, which gets reassigned anyway.
 + commit: Fix a memory leak in determine_author_info
 + daemon.c:handle: Remove unneeded check for null pointer.

 Assorted code cleanups and a minor fix.


* sb/traverse-trees-bitmask-variable-name (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-22 at be3227c)
 + traverse_trees(): clarify return value of the callback


* tr/line-log (2013-07-23) 1 commit
  (merged to 'next' on 2013-07-23 at a0a7f9b)
 + Merge branch 'es/line-log-further-fixes' into tr/line-log
 (this branch uses es/line-log-further-fixes.)

--------------------------------------------------
[New Topics]

* ob/typofixes (2013-07-29) 1 commit
 - many small typofixes

 Will merge to 'next'.


* jh/remote-hg-fetch-fix (2013-07-25) 2 commits
  (merged to 'next' on 2013-07-25 at 33161ad)
 + Revert "remotes-hg: bugfix for fetching non local remotes"
  (merged to 'next' on 2013-07-24 at 9c96641)
 + remotes-hg: bugfix for fetching non local remotes

 Waiting for the final patch after discussion settles.


* ma/hg-to-git (2013-07-23) 1 commit
 - hg-to-git: --allow-empty-message in git commit

 Will merge to 'next'.


* nd/clone-connectivity-shortcut (2013-07-23) 1 commit
 - smart http: use the same connectivity check on cloning

 Will merge to 'next'.


* bc/completion-for-bash-3.0 (2013-07-24) 1 commit
  (merged to 'next' on 2013-07-24 at 913d89c)
 + git-completion.bash: replace zsh notation that breaks bash 3.X

 Will merge to 'master'.


* jk/capabilities-doc (2013-07-26) 5 commits
  (merged to 'next' on 2013-07-29 at cf3f07e)
 + document 'allow-tip-sha1-in-want' capability
  (merged to 'next' on 2013-07-24 at 5af9a33)
 + document 'quiet' receive-pack capability
 + document 'agent' protocol capability
 + docs: note that receive-pack knows side-band-64k capability
 + docs: fix 'report-status' protocol capability thinko

 Will merge to 'master'.


* jx/clean-interactive (2013-07-24) 2 commits
 - git-clean: implement partial matching for selection
  (merged to 'next' on 2013-07-24 at 1e63bb9)
 + Documentation/git-clean: fix description for range


* sb/mailmap-updates (2013-07-24) 1 commit
  (merged to 'next' on 2013-07-24 at 9f8e681)
 + .mailmap: combine more (email, name) to individual persons

 Will merge to 'master'.


* tr/log-full-diff-keep-true-parents (2013-07-29) 2 commits
 - SQUASH??? free saved-parents slab when done
 - [PERHAPS LIKE THIS] log: use true parents for diff even when rewriting


* db/http-savecookies (2013-07-24) 1 commit
 - http: Add http.savecookies option to write out HTTP cookies


* ds/doc-two-kinds-of-tags (2013-07-29) 1 commit
 - docs/git-tag: explain lightweight versus annotated tags

 Will merge to 'next' and then to 'master'.


* jk/commit-how-to-abort-cherry-pick (2013-07-29) 1 commit
 - commit: tweak empty cherry pick advice for sequencer

 Will merge to 'next' and then to 'master'.


* lf/echo-n-is-not-portable (2013-07-29) 1 commit
 - Avoid using `echo -n` anywhere

 Will merge to 'next'.


* rj/commit-slab-fix (2013-07-29) 1 commit
 - commit-slab.h: Fix memory allocation and addressing

 Will merge to 'next' and then to 'master'.


* rr/maint-tilde-markup-in-doc (2013-07-26) 1 commit
 - config doc: quote paths, fixing tilde-interpretation

 Will merge to 'next' and then to 'master'.


* rr/rebase-autostash (2013-07-29) 1 commit
 - git-rebase: fix typo

 Will merge to 'next' and then to 'master'.


* sb/fsck-opt-bool (2013-07-29) 1 commit
 - fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL

 Will merge to 'next'.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
 - editor: use canonicalized absolute path

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* tf/gitweb-ss-tweak (2013-07-15) 4 commits
 - gitweb: make search help link less ugly
 - gitweb: omit the repository owner when it is unset
 - gitweb: vertically centre contents of page footer
 - gitweb: ensure OPML text fits inside its box

 Comments?


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jl/submodule-mv (2013-04-23) 5 commits
 . submodule.c: duplicate real_path's return value
 . rm: delete .gitmodules entry of submodules removed from the work tree
 . Teach mv to update the path entry in .gitmodules for moved submodules
 . Teach mv to move submodules using a gitfile
 . Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Ejected from 'pu', as it conflicts with nd/magic-pathspec.


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* rj/doc-rev-parse (2013-07-22) 2 commits
  (merged to 'next' on 2013-07-22 at 8188667)
 + rev-parse(1): logically group options
 + rev-parse: remove restrictions on some options

 Will cook in 'next'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-07-22 at d26dab6)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Will cook in 'next'.


* jc/diff-filter-negation (2013-07-19) 6 commits
  (merged to 'next' on 2013-07-22 at 80d167d)
 + diff: deprecate -q option to diff-files
 + diff: allow lowercase letter to specify what change class to exclude
 + diff: reject unknown change class given to --diff-filter
 + diff: preparse --diff-filter string argument
 + diff: factor out match_filter()
 + diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".

 Will cook in 'next'.


* mh/packed-refs-do-one-ref-recursion (2013-07-17) 1 commit
 - do_one_ref(): save and restore value of current_ref

 Fix a NULL-pointer dereference during nested iterations over
 references (for example, when replace references are being used).

 Will merge to 'next' and then to 'master'.


* nd/magic-pathspec (2013-07-23) 48 commits
  (merged to 'next' on 2013-07-23 at 784c3a1)
 + rm: do not set a variable twice without intermediate reading.
  (merged to 'next' on 2013-07-22 at 39f7194)
 + t6131 - skip tests if on case-insensitive file system
 + parse_pathspec: accept :(icase)path syntax
 + pathspec: support :(glob) syntax
 + pathspec: make --literal-pathspecs disable pathspec magic
 + pathspec: support :(literal) syntax for noglob pathspec
 + kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 + parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 + parse_pathspec: make sure the prefix part is wildcard-free
 + rename field "raw" to "_raw" in struct pathspec
 + tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 + remove match_pathspec() in favor of match_pathspec_depth()
 + remove init_pathspec() in favor of parse_pathspec()
 + remove diff_tree_{setup,release}_paths
 + convert common_prefix() to use struct pathspec
 + convert add_files_to_cache to take struct pathspec
 + convert {read,fill}_directory to take struct pathspec
 + convert refresh_index to take struct pathspec
 + convert report_path_error to take struct pathspec
 + checkout: convert read_tree_some to take struct pathspec
 + convert unmerge_cache to take struct pathspec
 + convert run_add_interactive to use struct pathspec
 + convert read_cache_preload() to take struct pathspec
 + line-log: convert to use parse_pathspec
 + reset: convert to use parse_pathspec
 + add: convert to use parse_pathspec
 + check-ignore: convert to use parse_pathspec
 + archive: convert to use parse_pathspec
 + ls-files: convert to use parse_pathspec
 + rm: convert to use parse_pathspec
 + checkout: convert to use parse_pathspec
 + rerere: convert to use parse_pathspec
 + status: convert to use parse_pathspec
 + commit: convert to use parse_pathspec
 + clean: convert to use parse_pathspec
 + guard against new pathspec magic in pathspec matching code
 + parse_pathspec: support prefixing original patterns
 + parse_pathspec: support stripping/checking submodule paths
 + parse_pathspec: support stripping submodule trailing slashes
 + parse_pathspec: add special flag for max_depth feature
 + convert some get_pathspec() calls to parse_pathspec()
 + parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 + parse_pathspec: save original pathspec for reporting
 + add parse_pathspec() that converts cmdline args to struct pathspec
 + pathspec: add copy_pathspec
 + pathspec: i18n-ize error strings in pathspec parsing code
 + move struct pathspec and related functions to pathspec.[ch]
 + clean: remove unused variable "seen"

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).

 Will cook in 'next'.


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-07-15 at 62751bc)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  I am tempted to
 merge this to and keep it in 'next' for a while to see if anybody
 screams before deciding if we want to do anything to help existing
 users (there may be none).

 Will cook in 'next'.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-07-21 at 7ffb690)
 + fetch: make --prune configurable

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 "git fetch" that honors remote.*.prune is fine, but I wonder if we
 should somehow make "git push" aware of it as well.  Perhaps
 remote.*.prune should not be just a boolean, but a 4-way "none",
 "push", "fetch", "both"?

 Will cook in 'next'.


* km/http-curl-config-per-url (2013-07-25) 6 commits
  (merged to 'next' on 2013-07-25 at 531e8cb)
 + docs: update http.<url>.* options documentation
  (merged to 'next' on 2013-07-23 at f84689b)
 + config: allow http.<url>.* any user matching
 + tests: add new test for the url_normalize function
 + config: improve support for http.<url>.* settings
 + config: add support for http.<url>.* settings
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Allows custom curl configuration per URL when talking over http.

 Will cook in 'next'.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-07-19 at ab8d034)
 + Git.pm: revert _temp_cache use of temp_is_locked
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will cook in 'next'.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/push-cas (2013-07-22) 6 commits
  (merged to 'next' on 2013-07-23 at 72371b0)
 + t5533: test "push --force-with-lease"
 + push --force-with-lease: tie it all together
 + push --force-with-lease: implement logic to populate old_sha1_expect[]
 + remote.c: add command line option parser for "--force-with-lease"
 + builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 + cache.h: move remote/connect API out of it

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 The logic to choose the default implemented here is fragile
 (e.g. "git fetch" after seeing a failure will update the
 remote-tracking branch and will make the next "push" pass,
 defeating the safety pretty easily).  It is suitable only for the
 simplest workflows, and it may hurt users more than it helps them.

 Will cook in 'next'.


* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-07-22 at 748180e)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 See

 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229221

 for full discussion.

 Will cook in 'next'.


* rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
 - cygwin: Remove the Win32 l/stat() implementation

 Cygwin port added a "not quite correct but a lot faster and good
 enough for many lstat() calls that are only used to see if the
 working tree entity matches the index entry" lstat() emulation some
 time ago, and it started biting us in places.  This removes it and
 uses the standard lstat() that comes with Cygwin.

 I am personally in favor of this simpler solution.  Comments?


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future
 (this branch uses jc/diff-filter-negation.)

 Will cook in 'next' until a distant future.
