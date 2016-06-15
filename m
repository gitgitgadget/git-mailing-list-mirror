From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2012, #09; Wed, 29)
Date: Wed, 29 Aug 2012 16:09:26 -0700
Message-ID: <7vpq69uwgp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 01:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6rOu-00005m-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 01:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab2H2XJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 19:09:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab2H2XJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 19:09:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5384F8A77;
	Wed, 29 Aug 2012 19:09:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	d6Wrr8GHvZY7xNOTvelZchrBbs=; b=lAz4kOXzOllViPB7Kz13k8U23xdKHnyKD
	nFlLCojyW/M+gMc7CeuKRW8WHaeNd1Ugj023f96ekIUYOyYOH7XhDdPCFmjGX7q7
	0/cwqLDbRWqB9ZDQ3dvSGvMcuXiqp9ETwjzJXhcgu+uA973HR37gcQhF33rPIVw3
	Egz0TTa6aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nTw
	GQQxjoDrnBjGTQQ4lZfiSRPtzr8Dskd07vc05pDYWs72FF7F2Ka8ni7PgiZqRSZu
	WQFcXlUkiT4jia+YOTEAL/JTlwCE33XaFRdIdJfjotWJv83aveO+jKjxUXqFwTKf
	9w/fbq4MJixeN8qghtzASsQiQuJbsbiTy/ZI1k1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0A18A76;
	Wed, 29 Aug 2012 19:09:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5DD8A73; Wed, 29 Aug 2012
 19:09:27 -0400 (EDT)
X-master-at: 16d26b168b371b2f4f86b1adb61470c6b08b27b9
X-next-at: 9b7ff7f6c17d9531b4ebeb199a70a759872c7d4f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94DC51B6-F22E-11E1-A604-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204506>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The latter half of the second batch of topics are now in 'master'.

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/prune-info (2012-08-07) 1 commit
  (merged to 'next' on 2012-08-20 at 1bc9e66)
 + prune.c: only print informational message in show_only or verbose mode

Teach "git prune" without "-v" to be silent about leftover temporary files.

* ef/win32-cred-helper (2012-08-16) 1 commit
  (merged to 'next' on 2012-08-20 at bd5c651)
 + contrib: add win32 credential-helper
 (this branch is used by ph/credential-refactor.)

Credential helper for Win32 to allow access to the keychain of
the logged-in user.

* hv/submodule-path-unmatch (2012-08-14) 1 commit
  (merged to 'next' on 2012-08-20 at cbe6483)
 + Let submodule command exit with error status if path does not exist

As the title says.

* jc/capabilities (2012-08-13) 3 commits
  (merged to 'next' on 2012-08-20 at 1976e47)
 + fetch-pack: mention server version with verbose output
 + parse_feature_request: make it easier to see feature values
 + fetch-pack: do not ask for unadvertised capabilities
 (this branch uses jk/version-string.)

Some capabilities were asked by fetch-pack even when upload-pack did
not advertise that they are available.  Fix fetch-pack not to do so.

* jc/maint-protect-sh-from-ifs (2012-08-08) 1 commit
  (merged to 'next' on 2012-08-20 at 8b00562)
 + sh-setup: protect from exported IFS

When the user exports a non-default IFS without HT, scripts that
rely on being able to parse "ls-files -s | while read a b c..."
start to fail.  Protect them from such a misconfiguration.

* jk/version-string (2012-08-10) 3 commits
  (merged to 'next' on 2012-08-20 at 6d207bb)
 + do not send client agent unless server does first
 + send-pack: fix capability-sending logic
 + include agent identifier in capability string
 (this branch is used by jc/capabilities.)

(Originally merged to 'next' on 2012-08-10)

Leftover bits from the "git version" code restructuring, that give
us an ability to expose the Git version over the wire in the
protocol exchange. But we do so carefully only to the other end that
understands it.

* mg/rebase-i-onto-reflog-in-full (2012-08-10) 1 commit
  (merged to 'next' on 2012-08-20 at f671bd2)
 + rebase -i: use full onto sha1 in reflog

The reflog entries left by "git rebase" and "git rebase -i" were
inconsistent.

* mh/maint-config-doc-proxy-command (2012-08-18) 2 commits
  (merged to 'next' on 2012-08-20 at a484625)
 + git-config doc: unconfuse an example
 + git-config.txt: fix example

A minor documentation update.

* mz/cherry-code-cleanup (2012-07-29) 3 commits
  (merged to 'next' on 2012-08-20 at bfb0457)
 + cherry: remove redundant check for merge commit
 + cherry: don't set ignored rev_info options
 + remove unnecessary parameter from get_patch_ids()

Minor code clean-up on the cherry-pick codepath.

* mz/empty-rebase-test (2012-08-09) 1 commit
  (merged to 'next' on 2012-08-20 at 53e2419)
 + add tests for 'git rebase --keep-empty'

* rr/precompose-utf8-cleanup (2012-08-20) 2 commits
  (merged to 'next' on 2012-08-20 at a883c2a)
 + precompose-utf8: do not call checks for non-ascii "utf8"
 + cleanup precompose_utf8

A style and code cleanup.

--------------------------------------------------
[New Topics]

* jk/maint-quiet-is-synonym-to-s-in-log (2012-08-28) 1 commit
 - log: fix --quiet synonym for -s

We tried to bend backwards to allow "--quiet" to be a synonym as
"-s" when given as e.g. "git show --quiet", but did not quite
succeed.

Will merge to 'next'.

* nd/checkout-option-parsing-fix (2012-08-29) 3 commits
 - checkout: reorder option handling
 - checkout: move more parameters to struct checkout_opts
 - checkout: pass "struct checkout_opts *" as const pointer

The option parsing of "git checkout" had error checking, dwim and
defaulting missing options, all mixed in the code, and issuing an
appropriate error message with useful context was getting harder.
Reorganize the code and allow giving a proper diagnosis when the
user says "git checkout -b -t foo bar" (e.g. "-t" is not a good name
for a branch).

* jc/maint-name-rev (2012-08-29) 3 commits
 - name-rev: --weight option (WIP)
 - name_rev: clarify when a new tip-name is assigned to a commit
 - name-rev: lose unnecessary typedef

"git name-rev" names the given revision based on a ref that can be
reached in the smallest number of steps from the rev, but that is
not useful when the caller wants to know which tag is the oldest one
that contains the rev.  This teaches a new mode to the command that
uses the oldest ref among those which contain the rev.

--------------------------------------------------
[Stalled]

* er/doc-fast-import-done (2012-08-22) 1 commit
 - fast-import: document the --done option

Parked in 'pu' in case ESR responds with "Sorry, forgot to sign-off".

* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

"git add dir/" updated modified files and added new files, but does
not notice removed files, which may be "Huh?" to some users.  They
can of course use "git add -A dir/", but why should they?

Resurrected from graveyard, as I thought it was a worthwhile thing
to do in the longer term; waiting for comments.

* tx/relative-in-the-future (2012-08-16) 2 commits
 - date: show relative dates in the future
 - date: refactor the relative date logic from presentation

Not my itch; rewritten an earlier submission by Tom Xue into
somewhat more maintainable form, though it breaks existing i18n.

Anybody interested in fixing it up?  Otherwise may discard.

* pw/p4-submit-conflicts (2012-08-16) 12 commits
 - git p4: add submit --prepare-p4-only option
 - git p4: add submit --dry-run option
 - git p4: accept -v for --verbose
 - git p4: revert deleted files after submit cancel
 - git p4: rearrange submit template construction
 - git p4: test clean-up after failed submit, fix added files
 - git p4: standardize submit cancel due to unchanged template
 - git p4: move conflict prompt into run, use [c]ontinue and [q]uit
 - git p4: remove submit failure options [a]pply and [w]rite
 - git p4: gracefully fail if some commits could not be applied
 - git p4 test: use p4d -L option to suppress log messages
 - git p4 test: remove bash-ism of combined export/assignment

Waiting for the dust to settle.

* mz/rebase-range (2012-07-18) 7 commits
 . rebase (without -p): correctly calculate patches to rebase
 . rebase -p: don't request --left-right only to ignore left side
 . rebase -p: use --cherry-mark for todo file
 . git-rebase--interactive.sh: look up subject in add_pick_line
 . git-rebase--interactive: group all $preserve_merges code
 . git-rebase--interactive.sh: extract function for adding "pick" line
 . git-rebase--am.sh: avoid special-casing --keep-empty

Expecting a reroll.

Performance concerns from Windows folks.  Also the series lacks
proper sign-offs.

* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

When the user does not specify what remote to interact with, we
often attempt to use 'origin'.  This can now be customized via a
configuration variable.

Expecting a reroll.

"The first remote becomes the default" bit is better done as a
separate step.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent long time ago still remains here without much comments
and updates from the developer community. I even made the interface
to the logic that decides where to split chunks easily replaceable,
and I deliberately made the logic in the original patch extremely
stupid to entice others, especially the "bup" fanbois, to come up
with a better logic, thinking that giving people an easy target to
shoot for, they may be encouraged to help out. The plan is not
working :-<.

--------------------------------------------------
[Cooking]

* cn/branch-set-upstream-to (2012-08-23) 3 commits
 - branch: deprecate --set-upstream and show help if we detect possible mistaken use
 - branch: add --unset-upstream option
 - branch: introduce --set-upstream-to

"git branch --set-upstream origin/master" is a common mistake to
create a local branch 'origin/master' and set it to integrate with
the current branch.  With a plan to deprecate this option, introduce
"git branch (-u|--set-upstream-to) origin/master" that sets the
current branch to integrate with 'origin/master' remote tracking
branch.

Waiting for a reroll
that tightens its error checking.

* jc/dotdot-is-parent-directory (2012-08-23) 1 commit
  (merged to 'next' on 2012-08-28 at 2f2ae87)
 + specifying ranges: we did not mean to make ".." an empty set

"git log .." errored out saying it is both rev range and a path when
there is no disambiguating "--" is on the command line.  Update the
command line parser to interpret ".." as a path in such a case.

Will merge to 'master' as part of the fourth batch.

* jc/maint-mergetool-style-fix (2012-08-23) 1 commit
  (merged to 'next' on 2012-08-28 at ced5868)
 + mergetool: style fixes

Will merge to 'master' as part of the third batch.

* js/compat-itimer (2012-08-24) 1 commit
 - Support for setitimer() on platforms lacking it

Pieces to support compilation on __TANDEM.

* js/compat-mkdir (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-28 at e92bf74)
 + compat: some mkdir() do not like a slash at the end

Some mkdir(2) implementations do not want to see trailing slash in
its parameter.

Will merge to 'master' as part of the third batch.

* js/no-curl-easy-strerror-on-old-curl (2012-08-23) 1 commit
  (merged to 'next' on 2012-08-28 at 25e2e7a)
 + http.c: don't use curl_easy_strerror prior to curl-7.12.0

Done to support compilation on __TANDEM, but is independently useful
for people with older version of libcURL.

Will merge to 'master' as part of the third batch.

* js/use-sc-open-max (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-28 at 8b9ac7c)
 + sha1_file.c: introduce get_max_fd_limit() helper

Introduce get_max_fd_limit() to absorb platforms that do not have
getrlimit(RLIMIT_NOFILE) and/or sysconf(_SC_OPEN_MAX).

Will merge to 'master' as part of the third batch.

* ph/credential-refactor (2012-08-27) 6 commits
 - wincred: port to generic credential helper (UNTESTED)
 - Merge branch 'ef/win32-cred-helper' into ph/credential-refactor
 - osxkeychain: port to generic credential helper implementation
 - gnome-keyring: port to generic helper implementation
 - contrib: add generic credential helper
 - contrib: add credential helper for GnomeKeyring

Adds a new credential helper to support Gnome keyring and attempts
to refactor to share code among OSX keychain, Gnome keyring and
Win32 credential helpers.

Waiting for test results with the tip one
to decide whether the series should be rerolled or reduced to only
the first one.

* jc/apply-binary-p0 (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-28 at 6fa690c)
 + apply: compute patch->def_name correctly under -p0

"git apply -p0" did not parse pathnames on "diff --git" line
correctly.  This caused patches that had pathnames in no other
places to be mistakenly rejected (most notably, binary patch that
does not rename nor change mode).  Textual patches, renames or
mode changes have preimage and postimage pathnames in different
places in a form that can be parsed unambiguously and did not suffer
from this problem.

Will merge to 'master' as part of the fourth batch.

* jc/maint-doc-checkout-b-always-takes-branch-name (2012-08-26) 1 commit
  (merged to 'next' on 2012-08-29 at e0d0f5c)
 + doc: "git checkout -b/-B/--orphan" always takes a branch name

The synopsis said "checkout [-B branch]" to make it clear the branch
name is a parameter to the option, but the heading for the option
description was "-B::", not "-B branch::", making the documentation
misleading.  There may be room in documentation pages of other
commands for similar improvements (hint, hint).

Will merge to 'master' as part of the fourth batch.

* jk/maint-http-half-auth-push (2012-08-27) 8 commits
  (merged to 'next' on 2012-08-29 at 0ed32f5)
 + http: prompt for credentials on failed POST
 + http: factor out http error code handling
 + t: test http access to "half-auth" repositories
 + t: test basic smart-http authentication
 + t/lib-httpd: recognize */smart/* repos as smart-http
 + t/lib-httpd: only route auth/dumb to dumb repos
 + t5550: factor out http auth setup
 + t5550: put auth-required repo in auth/dumb

Pushing to smart HTTP server with recent Git fails without having
the username in the URL to force authentication, if the server is
configured to allow GET anonymously, while requiring authentication
for POST.

* jx/test-real-path (2012-08-27) 1 commit
 - test: set the realpath of CWD as TRASH_DIRECTORY

Running tests with the "trash" directory elsewhere with the "--root"
option did not work well if the directory was specified by a symbolic
link pointing at it.

Seems broken as it makes $(pwd) and TRASH_DIRECTORY inconsistent.
Needs rerolling.

* mh/fetch-filter-refs (2012-08-26) 17 commits
 - filter_refs(): simplify logic
 - fetch_pack(): free matching heads
 - cmd_fetch_pack(): simplify computation of return value
 - fetch-pack: report missing refs even if no existing refs were received
 - cmd_fetch_pack: return early if finish_connect() returns an error
 - filter_refs(): compress unmatched refs in heads array
 - filter_refs(): do not leave gaps in return_refs
 - filter_refs(): simplify by removing optimization
 - Pass nr_heads to filter_refs() by reference
 - Pass nr_heads to everything_local() by reference
 - Pass nr_heads to do_pack_ref() by reference
 - Let fetch_pack() inform caller about number of unique heads
 - filter_refs(): do not check the same head_pos twice
 - fetch-pack.c: name local variables more consistently
 - fetch_pack(): reindent function decl and defn
 - Rename static function fetch_pack() to http_fetch_pack()
 - t5500: add tests of error output for missing refs

Code simplification and clarification.
Waiting for a follow-up patch based on Peff's idea.

* nd/branch-v-alignment (2012-08-27) 1 commit
  (merged to 'next' on 2012-08-29 at 5c0d226)
 + branch -v: align even when branch names are in UTF-8

Output from "git branch -v" contains "(no branch)" that could be
localized, but the code to align it along with the names of branches
were counting in bytes, not in display columns.

Will merge to 'master' as part of the fourth batch.

* jc/merge-bases (2012-08-28) 5 commits
 - get_merge_bases_many(): walk from many tips in parallel
 - in_merge_bases(): omit unnecessary redundant common ancestor reduction
 - http-push: use in_merge_bases() for fast-forward check
 - receive-pack: use in_merge_bases() for fast-forward check
 - in_merge_bases(): support only one "other" commit
 (this branch is used by jc/xprm-merge-bases-many.)

Optimises the "merge-base" computation a bit, and also updates its
users that do not need the full merge-base information to call a
cheaper subset.  The most important one is the second from the tip
done by Thomas.

Will merge to 'next'.

* jl/submodule-rm (2012-08-27) 1 commit
 - Teach rm to remove submodules unless they contain a git directory

"git rm submodule" cannot blindly remove a submodule directory as
its working tree may have local changes, and worse yet, it may even
have its repository embedded in it.  Teach it some special cases
where it is safe to remove a submodule, specifically, when there is
no local changes in the submodule working tree, and its repository
is not embedded in its working tree but is elsewhere and uses the
gitfile mechanism to point at it.

* nd/am-i18n-fix (2012-08-22) 1 commit
  (merged to 'next' on 2012-08-24 at f8e9a63)
 + am: quote string for translation before passing to eval_gettextln

"git am" wasn't marked up for i18n properly.

Will merge to 'master' as part of the fourth batch.

* lt/commit-tree-guess-utf-8 (2012-08-21) 1 commit
  (merged to 'next' on 2012-08-24 at d16ac69)
 + commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

Will merge to 'master' as part of the fourth batch.

* kk/maint-for-each-ref-multi-sort (2012-08-21) 2 commits
  (merged to 'next' on 2012-08-24 at 28a5db4)
 + for-each-ref: Fix sort with multiple keys
 + t6300: test sort with multiple keys

"git for-each-ref" did not currectly support more than one --sort
option.

Will merge to 'master' as part of the fourth batch.

* fa/remote-svn (2012-08-28) 16 commits
 - Add a test script for remote-svn
 - remote-svn: add marks-file regeneration
 - Add a svnrdump-simulator replaying a dump file for testing
 - remote-svn: add incremental import
 - remote-svn: Activate import/export-marks for fast-import
 - Create a note for every imported commit containing svn metadata
 - vcs-svn: add fast_export_note to create notes
 - Allow reading svn dumps from files via file:// urls
 - remote-svn, vcs-svn: Enable fetching to private refs
 - When debug==1, start fast-import with "--stats" instead of "--quiet"
 - Add documentation for the 'bidi-import' capability of remote-helpers
 - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
 - Add argv_array_detach and argv_array_free_detached
 - Add svndump_init_fd to allow reading dumps from arbitrary FDs
 - Add git-remote-testsvn to Makefile and .gitignore
 - Implement a remote helper for svn in C
 (this branch is used by fa/vcs-svn.)

Waiting for comments from mentors and stakeholders.

* fa/vcs-svn (2012-08-28) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

Waiting for comments from mentors and stakeholders.

* nd/i18n-parseopt-help (2012-08-22) 66 commits
  (merged to 'next' on 2012-08-24 at 2a04ce0)
 + Use imperative form in help usage to describe an action
 + Reduce translations by using same terminologies
 + i18n: write-tree: mark parseopt strings for translation
 + i18n: verify-tag: mark parseopt strings for translation
 + i18n: verify-pack: mark parseopt strings for translation
 + i18n: update-server-info: mark parseopt strings for translation
 + i18n: update-ref: mark parseopt strings for translation
 + i18n: update-index: mark parseopt strings for translation
 + i18n: tag: mark parseopt strings for translation
 + i18n: symbolic-ref: mark parseopt strings for translation
 + i18n: show-ref: mark parseopt strings for translation
 + i18n: show-branch: mark parseopt strings for translation
 + i18n: shortlog: mark parseopt strings for translation
 + i18n: rm: mark parseopt strings for translation
 + i18n: revert, cherry-pick: mark parseopt strings for translation
 + i18n: rev-parse: mark parseopt strings for translation
 + i18n: reset: mark parseopt strings for translation
 + i18n: rerere: mark parseopt strings for translation
 + i18n: status: mark parseopt strings for translation
 + i18n: replace: mark parseopt strings for translation
 + i18n: remote: mark parseopt strings for translation
 + i18n: read-tree: mark parseopt strings for translation
 + i18n: push: mark parseopt strings for translation
 + i18n: prune: mark parseopt strings for translation
 + i18n: prune-packed: mark parseopt strings for translation
 + i18n: pack-refs: mark parseopt strings for translation
 + i18n: pack-objects: mark parseopt strings for translation
 + i18n: notes: mark parseopt strings for translation
 + i18n: name-rev: mark parseopt strings for translation
 + i18n: mv: mark parseopt strings for translation
 + i18n: mktree: mark parseopt strings for translation
 + i18n: merge: mark parseopt strings for translation
 + i18n: merge-file: mark parseopt strings for translation
 + i18n: merge-base: mark parseopt strings for translation
 + i18n: ls-tree: mark parseopt strings for translation
 + i18n: ls-files: mark parseopt strings for translation
 + i18n: log: mark parseopt strings for translation
 + i18n: init-db: mark parseopt strings for translation
 + i18n: help: mark parseopt strings for translation
 + i18n: hash-object: mark parseopt strings for translation
 + i18n: grep: mark parseopt strings for translation
 + i18n: gc: mark parseopt strings for translation
 + i18n: fsck: mark parseopt strings for translation
 + i18n: format-patch: mark parseopt strings for translation
 + i18n: for-each-ref: mark parseopt strings for translation
 + i18n: fmt-merge-msg: mark parseopt strings for translation
 + i18n: fetch: mark parseopt strings for translation
 + i18n: fast-export: mark parseopt strings for translation
 + i18n: describe: mark parseopt strings for translation
 + i18n: config: mark parseopt strings for translation
 + i18n: count-objects: mark parseopt strings for translation
 + i18n: commit: mark parseopt strings for translation
 + i18n: column: mark parseopt strings for translation
 + i18n: clone: mark parseopt strings for translation
 + i18n: clean: mark parseopt strings for translation
 + i18n: cherry: mark parseopt strings for translation
 + i18n: checkout: mark parseopt strings for translation
 + i18n: checkout-index: mark parseopt strings for translation
 + i18n: check-attr: mark parseopt strings for translation
 + i18n: cat-file: mark parseopt strings for translation
 + i18n: branch: mark parseopt strings for translation
 + i18n: blame: mark parseopt strings for translation
 + i18n: add: mark parseopt strings for translation
 + i18n: bisect--helper: mark parseopt strings for translation
 + i18n: archive: mark parseopt strings for translation
 + i18n: mark "style" in OPT_COLUMN() for translation

A lot of i18n mark-up for the help text from "git <cmd> -h".

Will merge to 'master' as part of the fourth batch.

* tr/maint-parseopt-avoid-empty (2012-08-20) 1 commit
  (merged to 'next' on 2012-08-24 at cffa9a0)
 + gettext: do not translate empty string

A workaround to avoid doing _(""), which translates to unwanted
magic string in the .po files.

Will merge to 'master' as part of the fourth batch.

* jk/config-warn-on-inaccessible-paths (2012-08-21) 4 commits
  (merged to 'next' on 2012-08-24 at 7470bd6)
 + warn_on_inaccessible(): a helper to warn on inaccessible paths
 + attr: warn on inaccessible attribute files
 + gitignore: report access errors of exclude files
 + config: warn on inaccessible files

When looking for $HOME/.gitconfig etc., it is OK if we cannot read
them because they do not exist, but unable to read existing ones
need to be diagnosed.

Will merge to 'master' as part of the fourth batch.

* nd/i18n-poison-test-updates (2012-08-27) 7 commits
  (merged to 'next' on 2012-08-29 at 9b7ff7f)
 + Fix tests under GETTEXT_POISON on parseopt
 + Fix tests under GETTEXT_POISON on git-remote
 + Fix tests under GETTEXT_POISON on pack-object
 + Fix tests under GETTEXT_POISON on git-apply
 + Fix tests under GETTEXT_POISON on diffstat
 + Fix tests under GETTEXT_POISON on git-stash
 + Fix tests under GETTEXT_POISON on relative dates

Updates to tests that can be broken with gettext-poison builds.
Queued with trivial fix-ups.

Will merge to 'master' as part of the third batch.

* jc/daemon-access-hook (2012-08-15) 1 commit
  (merged to 'next' on 2012-08-20 at c8f5b2e)
 + daemon: --access-hook option

Allow an external command to tell git-daemon to decline service
based on the client address, repository path, etc.

Will merge to 'master' as part of the third batch.

* jc/send-email-reconfirm (2012-08-14) 1 commit
  (merged to 'next' on 2012-08-20 at dffdef6)
 + send-email: validate & reconfirm interactive responses

Validate interactive input to "git send-email" to avoid common
mistakes such as saying "y<RETURN>" to sender mail address whose
prompt is given with a correctly guessed default.

Will merge to 'master' as part of the third batch.

* ph/stash-rerere (2012-08-17) 2 commits
  (merged to 'next' on 2012-08-20 at ae37111)
 + stash: invoke rerere in case of conflict
 + test: git-stash conflict sets up rerere

"git stash" internally used "git merge-recursive" backend, which did
not trigger "rerere" upon conflicts unlike other mergy operations.

Will merge to 'master' as part of the third batch.

* pw/p4-use-client-spec-branch-detection (2012-08-20) 5 commits
  (merged to 'next' on 2012-08-24 at 08abc61)
 + git p4: make branch detection work with --use-client-spec
 + git p4: do wildcard decoding in stripRepoPath
 + git p4: set self.branchPrefixes in initialization
 + git p4 test: add broken --use-client-spec --detect-branches tests
 + git p4 test: move client_view() function to library

Fixes "git p4" when "--use-client-spec" and "--detect-branches" are
used together (the command used to misdetect branches).

Will merge to 'master' as part of the fourth batch.

* jc/maint-push-refs-all (2012-08-27) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - [BROKEN] fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.

* tg/index-v5 (2012-08-17) 13 commits
 - p0002-index.sh: add perf test for the index formats
 - update-index.c: rewrite index when index-version is given
 - Write resolve-undo data for index-v5
 - Write index-v5 cache-tree data
 - Write index-v5
 - Read cache-tree in index-v5
 - Read resolve-undo data
 - Read index-v5
 - Make in-memory format aware of stat_crc
 - Add documentation of the index-v5 file format
 - t2104: Don't fail for index versions other than [23]
 - read-cache.c: Re-read index if index file changed
 - Move index v2 specific functions to their own file

A GSoC project, queued here primarily to give people an easier
access to the state of the last posted version.

* jc/maint-sane-execvp-notdir (2012-07-31) 1 commit
  (merged to 'next' on 2012-08-20 at 0d76cf2)
 + sane_execvp(): ignore non-directory on $PATH

(Originally merged to 'next' on 2012-08-09)

"git foo" errored out with "Not a directory" when the user had a non
directory on $PATH, and worse yet it masked an alias "foo" to run.

Will merge to 'master' as part of the third batch.

* cw/cherry-pick-allow-empty-message (2012-08-06) 1 commit
  (merged to 'next' on 2012-08-20 at 0dc0590)
 + cherry-pick: add --allow-empty-message option

(Originally merged to 'next' on 2012-08-09)

"git cherry-pick" by default stops when it sees a commit without any
log message.  The "--allow-empty-message" option can be used to
silently proceed.

Will merge to 'master' as part of the third batch.

* jc/maint-config-exit-status (2012-07-30) 1 commit
  (merged to 'next' on 2012-08-20 at e18ddd8)
 + config: "git config baa" should exit with status 1

(Originally merged to 'next' on 2012-07-30)

The exit status code from "git config" was way overspecified while
being incorrect.  Update the implementation to give the documented
status for a case that was documented, and introduce a new code for
"all other errors".

Will merge to 'master' as part of the third batch.

* sz/submodule-force-update (2012-08-24) 1 commit
  (merged to 'next' on 2012-08-24 at f82b466)
 + Make 'git submodule update --force' always check out submodules.

"git submodule update --force" used to leave the working tree of the
submodule intact when there were local changes.  It is more intiutive
to make "--force" a sign to run "checkout -f" to overwrite them.

Will merge to 'master' as part of the third batch.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

(Originally merged to 'next' on 2012-07-23)

Will defer until the end of the 2012.
while waiting for older "less" to go extinct.

--------------------------------------------------
[Discarded]

* jc/sanitize-nkd-lazy-iconv-open (2012-07-31) 1 commit
 . macos: lazily initialize iconv

Teach the code that works around NKD/NKC gotcha on MacOS to call
iconv_open() only when it is necessary, in the hope of avoiding
set-up overhead.  It turns out that there was no noticeable
improvements.

* nd/checkout-branch-name-check (2012-08-27) 1 commit
 . checkout: verify new branch name's validity early

"git checkout -b --opt y" errors out saying that creating a new
branch to check it out and grabbing contents for paths out of a
commit are incompatible operations.  While it is technically correct
(the command line wants to create a new branch whose name is "--opt"
and check it out, and there shouldn't be anything else left on the
command line, but there is "y"), "--opt" is not a valid name of the
branch to begin with, so even without "y", the command will not
succeed.  Treat this case specially to complain that "--opt" is not
a valid branch name.
