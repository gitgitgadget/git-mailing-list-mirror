From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #08; Thu, 28)
Date: Thu, 28 Jun 2012 16:35:38 -0700
Message-ID: <7vhatv3t85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 01:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkOFY-0006W8-M1
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 01:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2F1Xfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 19:35:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab2F1Xfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 19:35:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5FE89F6;
	Thu, 28 Jun 2012 19:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=K
	gTiBV+ye1jzG9cpYlTkM698L9w=; b=aDOgXfSdmnLSIezuxqcu9yIig4G0OrzWF
	IS6a1LZB0mn0va0m9Facq1YRIVhrh/l4QYF2QaRbjPWDvXmwc0MPVypgklH3MnOF
	GN4rtXE+/DVwL4XbRDUwE26sZB8svxN4e82nooGe9cHhcAfQUGipGGqfwi3sybjN
	LljJl+37Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=oyd1aTjlt6l7zXxpgBd1GDXmy2PHi//BavKfuOz7J/d9U20IY1KMiFYQ
	rN4XTd+bPSqmtvBeZVKYOdX4uB9qW67cP8YPwwaee1TS4umqT8UX1y+G5Ukeg7wu
	iufR5h5C861eLB3e6TeAOM9BEjBDuTl7pJUC3tH0sxeHNYdl+WA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1D4589F5;
	Thu, 28 Jun 2012 19:35:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC90C89F3; Thu, 28 Jun 2012
 19:35:39 -0400 (EDT)
X-master-at: e7b44f182bc1b2ac32eadbc477a76a185f49ac88
X-next-at: ce5f79f7997da38c414b6b9006eda871419ecfe7
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F83E159A-C179-11E1-80E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200799>

What's cooking in git.git (Jun 2012, #08; Thu, 28)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The third batch of topics have graduated to 'master', and a handful
of topics have entered 'next' for developer testing.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* fc/git-prompt-script (2012-06-19) 7 commits
  (merged to 'next' on 2012-06-25 at e690a02)
 + completion: respect $GIT_DIR
 + completion: warn people about duplicated function
 + completion: split __git_ps1 into a separate script
 + completion: remove executable mode
 + Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 + tests: add tests for the bash prompt functions in the completion script
 + tests: move code to run tests under bash into a helper library

Split a rather heavy-ish "git completion" script out to create a
separate "git prompting" script, to help lazy-autoloading of the
completion part while making prompting part always available.

* hv/submodule-update-nuke-submodules (2012-06-11) 1 commit
  (merged to 'next' on 2012-06-25 at bbfcd02)
 + update-index: allow overwriting existing submodule index entries

"git add" allows adding a regular file to the path where a submodule
used to exist, but "git update-index" does not allow an equivalent
operation to Porcelain writers.

* jc/rev-list-simplify-merges-first-parent (2012-06-13) 3 commits
  (merged to 'next' on 2012-06-25 at 4c5ffbe)
 + revision: ignore side parents while running simplify-merges
 + revision: note the lack of free() in simplify_merges()
 + revision: "simplify" options imply topo-order sort

When "git log" is given "--simplify-merges/by-decoration" together
with "--first-parent", the combination of these options makes the
simplification logic to use in-core commit objects that haven't been
examined for relevance, either producing incorrect result or taking
too long to produce any output.  Teach the simplification logic to
ignore commits that the first-parent traversal logic ignored when
both are in effect to work around the issue.

* jk/diff-no-index-pager (2012-06-15) 2 commits
  (merged to 'next' on 2012-06-21 at e2a2562)
 + do not run pager with diff --no-index --quiet
 + fix pager.diff with diff --no-index

"git diff --no-index" did not work with pagers correctly.

* js/submodule-relative (2012-06-14) 5 commits
  (merged to 'next' on 2012-06-25 at 310ed77)
 + t7400: avoid path mangling issues
 + submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
 + submodule: fix sync handling of some relative superproject origin URLs
 + submodule: document failure to handle relative superproject origin URLs
 + submodule: additional regression tests for relative URLs

Teach "git submodule" deal with nested submodule structure where a
module is contained within a module whose origin is specified as a
relative URL to its superproject's origin.

* lk/more-helpful-status-hints (2012-06-14) 4 commits
  (merged to 'next' on 2012-06-25 at 6502d4b)
 + status: better advices when splitting a commit (during rebase -i)
 + status: don't suggest "git rm" or "git add" if not appropriate
 + t7512-status-help.sh: better advices for git status
 + wt-status.*: better advices for git status added

Give finer classification to various states of paths in conflicted
state and offer advice messages in the "git status" output.

* lk/rebase-i-x (2012-06-13) 1 commit
  (merged to 'next' on 2012-06-25 at 8252da2)
 + rebase -i: teach "--exec <cmd>"

Teach "-x <cmd>" to "rebase -i" to insert "exec <cmd>" after each
commit in the resulting history.

* mm/verify-filename-fix (2012-06-18) 2 commits
  (merged to 'next' on 2012-06-21 at d03dace)
 + verify_filename(): ask the caller to chose the kind of diagnosis
 + sha1_name: do not trigger detailed diagnosis for file arguments

"git diff COPYING HEAD:COPYING" gave a nonsense error message that
claimed that the treeish HEAD did not have COPYING in it.

* nd/exclude-workaround-top-heavy (2012-06-07) 3 commits
  (merged to 'next' on 2012-06-25 at 08429bb)
 + exclude: do strcmp as much as possible before fnmatch
 + dir.c: get rid of the wildcard symbol set in no_wildcard()
 + Unindent excluded_from_list()

Attempt to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

* nd/stream-index-pack (2012-05-24) 4 commits
  (merged to 'next' on 2012-06-25 at 3084674)
 + index-pack: use streaming interface for collision test on large blobs
 + index-pack: factor out unpack core from get_data_from_pack
 + index-pack: use streaming interface on large blobs (most of the time)
 + index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

* nd/stream-pack-objects (2012-05-29) 1 commit
  (merged to 'next' on 2012-06-25 at fa91345)
 + pack-objects: use streaming interface for reading large loose blobs

"pack-objects" learned to read large loose blobs using the streaming API,
without the need to hold everything in core at once.

--------------------------------------------------
[New Topics]

* tb/sanitize-decomposed-utf-8-pathname (2012-06-25) 1 commit
 - git on Mac OS and precomposed unicode

Teaches git to normalize pathnames read from readdir(3) and all
arguments from the command line into precomposed UTF-8 (assuming
that they come as decomposed UTF-8) to work around issues on Mac OS.

I think there still are other places that need conversion
(e.g. paths that are read from stdin for some commands), but this
should be a step in the right direction.

Will merge to 'next'.

* cw/no-detaching-an-unborn (2012-06-26) 1 commit
 - git-checkout: disallow --detach on unborn branch

"git checkout --detach" when you are still on an unborn branch
should be forbidden, but it wasn't.

Will merge to 'next'.

* cw/rebase-i-root (2012-06-26) 2 commits
 - Add tests for rebase -i --root without --onto
 - rebase -i: support --root without --onto

"git rebase [-i] --root $tip" can now be used to rewrite all the
history down to the root.

Will merge to 'next'.

* js/fast-export-paths-with-spaces (2012-06-27) 1 commit
 - fast-export: quote paths with spaces

"git fast-export" produced an input stream for fast-import without
properly quoting pathnames when they contain SPs in them.

Will merge to 'next'.

* mm/mediawiki-file-attachments (2012-06-27) 5 commits
 - git-remote-mediawiki: import "File:" attachments
 - git-remote-mediawiki: split get_mw_pages into smaller functions
 - git-remote-mediawiki: send "File:" attachments to a remote wiki
 - git-remote-mediawiki: don't "use encoding 'utf8';"
 - git-remote-mediawiki: don't compute the diff when getting commit message
 (this branch uses mm/credential-plumbing.)

"mediawiki" remote helper (in contrib/) learned to handle file
attachments.

Will merge to 'next'.

* mz/rebase-no-mbox (2012-06-26) 4 commits
 - am: don't call mailinfo if $rebasing
 - am --rebasing: get patch body from commit, not from mailbox
 - rebase --root: print usage on too many args
 - rebase: don't source git-sh-setup twice

Teach "am --rebasing" codepath to grab authorship, log message and
the patch text directly out of existing commits.

Will merge to 'next'.

* pw/git-p4-tests (2012-06-27) 10 commits
 - git p4 test: fix badp4dir test
 - git p4 test: split up big t9800 test
 - git p4 test: cleanup_git should make a new $git
 - git p4 test: copy source indeterminate
 - git p4 test: check for error message in failed test
 - git p4 test: rename some "git-p4 command" strings
 - git p4 test: never create default test repo
 - git p4 test: simplify quoting involving TRASH_DIRECTORY
 - git p4 test: use real_path to resolve p4 client symlinks
 - git p4 test: wait longer for p4d to start and test its pid

More "git p4" tests.

Will merge to 'next'.

* rj/platform-pread-may-be-thread-unsafe (2012-06-26) 1 commit
  (merged to 'next' on 2012-06-28 at ce5f79f)
 + index-pack: Disable threading on cygwin

On Cygwin, the platform pread(3) is not thread safe, just like our
own compat/ emulation, and cannot be used in the index-pack program.

* jc/refactor-diff-stdin (2012-06-28) 3 commits
 - diff-index.c: "git diff" has no need to read blob from the standard input
 - diff-index.c: unify handling of command line paths
 - diff-index.c: do not pretend paths are pathspecs

Due to the way "git diff --no-index" is bolted onto by touching the
low level code that is shared with the rest of the "git diff" code,
even though it has to work in a very different way, any comparison
that involves a file "-" at the root level incorrectly tried to read
from the standard input.  This cleans up the no-index codepath
further to remove code that reads from the standard input from the
core side, which is never necessary when git is running its usual
diff operation.

Will merge to 'next', and later down to older maintenance releases.

* mz/empty-rebase-test (2012-06-27) 1 commit
 - add test case for rebase of empty commit

We did not have test to make sure "git rebase" without extra options
filters out an empty commit in the original history.

* cw/help-over-network (2012-06-28) 2 commits
 - Allow help.htmlpath to be a URL prefix
 - Add config variable to set HTML path for git-help --web

"git help -w $cmd" can show HTML version of documentation for
"git-$cmd" by setting help.htmlpath to somewhere other than the
default location where the build procedure installs them locally;
the variable can even point at a http:// URL.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Hopefully it will be rerolled.

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier
 (this branch uses vr/use-our-perl-in-tests.)

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

Needs to be eyeballed by people who run tests with exotic options
like valgrind, --root=/dev/shm/somewhere, etc.

--------------------------------------------------
[Stalled]

* db/vcs-svn (2012-06-01) 6 commits
 - vcs-svn: drop no-op reset methods
 - vcs-svn: fix signedness warnings
 - vcs-svn: prefer strstr over memmem
 - vcs-svn: prefer constcmp to prefixcmp
 - vcs-svn: simplify cleanup in apply_one_window()
 - vcs-svn: fix clang-analyzer error

Waiting for Jonathan's clean-up offered earlier.

* jc/apply-3way (2012-06-13) 19 commits
 - apply --3way: tests
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: --3way with add/add conflict
 - apply: move verify_index_match() higher
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: move "already exists" logic to check_to_create()
 - apply: move check_to_create_blob() closer to its sole caller
 - apply: further split load_preimage()
 - apply: refactor "previous patch" logic
 - apply: split load_preimage() helper function out
 - apply: factor out checkout_target() helper function
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

Will merge to 'next' after reading it over once again.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

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
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* mm/config-xdg (2012-06-25) 4 commits
  (merged to 'next' on 2012-06-28 at 57049d1)
 + config: write to $XDG_CONFIG_HOME/git/config file when appropriate
 + Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
 + Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
 + config: read (but not write) from $XDG_CONFIG_HOME/git/config file

Teach git to read various information from $XDG_CONFIG_HOME/git/ to allow
the user to avoid cluttering $HOME.

Will merge to 'next'.

* mm/credential-plumbing (2012-06-25) 3 commits
  (merged to 'next' on 2012-06-28 at 6e6fe9f)
 + git-remote-mediawiki: add credential support
 + git credential fill: output the whole 'struct credential'
 + add 'git credential' plumbing command
 (this branch is used by mm/mediawiki-file-attachments.)

Expose the credential API to scripted Porcelain writers.

Will merge to 'next'.

* th/diff-no-index-fixes (2012-06-22) 2 commits
  (merged to 'next' on 2012-06-26 at 450e781)
 + diff-no-index: exit(1) if 'diff --quiet <repo file> <external file>' finds changes
 + diff: handle relative paths in no-index

"git diff --no-index" did not correctly handle relative paths and
did not correctly give exit codes when run under "--quiet" option.

Will merge to 'master'.

* nd/clone-single-fix (2012-06-22) 1 commit
  (merged to 'next' on 2012-06-26 at c9fff5e)
 + clone: fix ref selection in --single-branch --branch=xxx

"git clone --single-branch" to clone a single branch did not limit
the cloning to the specified branch.

Will merge to 'master'.

* vr/use-our-perl-in-tests (2012-06-24) 4 commits
 - t/README: add a bit more Don'ts
 - tests: enclose $PERL_PATH in double quotes
 - t/test-lib.sh: export PERL_PATH for use in scripts
 - t: Replace 'perl' by $PERL_PATH
 (this branch is used by jc/test-lib-source-build-options-early.)

Some implementations of Perl terminates "lines" with CRLF even when
the script is operating on just a sequence of bytes.  Make sure to
use "$PERL_PATH", the version of Perl the user told Git to use, in
our tests to avoid unnecessary breakages in tests.

* jc/sha1-name-more (2012-06-23) 9 commits
 - sha1_name.c: get_describe_name() by definition groks only commits
 - sha1_name.c: teach get_short_sha1() a commit-only option
 - sha1_name.c: allow get_short_sha1() to take other flags
 - sha1_name.c: restructure disambiguation of short names
 - sha1_name.c: correct misnamed "canonical" and "res"
 - sha1_name.c: refactor find_short_packed_object()
 - sha1_name.c: rename "now" to "current"
 - sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 - sha1_name.c: indentation fix

Teaches the object name parser that a "git describe" output is
always a commit object, to prolong the lifetime of abbreviated
object name in it.

It has a handful of tests that expect failure and show directions
for a couple of enhancement ideas.

Will merge to 'next'.

* jk/version-string-dependency (2012-06-20) 11 commits
 - Makefile: move GIT-VERSION-FILE dependencies closer to use
 - Makefile: build instaweb similar to other scripts
 - Makefile: update scripts when build-time parameters change
 - Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 - Makefile: split prefix flags from GIT-CFLAGS
 - Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 - Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 - Makefile: apply dependencies consistently to sparse/asm targets
 - Makefile: do not have git.o depend on common-cmds.h
 - Makefile: fold MISC_H into LIB_H
 - Makefile: sort LIB_H list

Will keep in 'pu' to give Peff and Jonathan to work out improvements
for a week or so.

* jn/perl-makemaker-leading-paths (2012-06-15) 1 commit
  (merged to 'next' on 2012-06-28 at 286d854)
 + perl/Makefile: move "mkdir -p" to module installation loop for maintainability

Minor build tweak.  People who do not use ExtUtils::MakeMaker may
want to test this before it hits the 'master' branch.

* tr/maint-show-walk (2012-06-19) 2 commits
 - show: fix "range implies walking"
 - Demonstrate git-show is broken with ranges

Fixes "git show"'s auto-walking behaviour, and make it behave just
like "git log" does when it walks.

Note that this is different from Thomas's patch.

Waiting for response from original author.

* hv/remote-end-hung-up (2012-06-19) 1 commit
  (merged to 'next' on 2012-06-25 at d3f29e2)
 + remove the impression of unexpectedness when access is denied

When we get disconnected while expecting a response from the remote
side because authentication failed, we issued an error message "The
remote side hung up unexpectedly."  Give hint that it may be a
permission problem in the message when we can reasonably suspect it.

Will merge to 'master'.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Hopefully we can have a solidly tested series early in 1.7.12 or
1.7.13 at the latest.

--------------------------------------------------
[Discarded]

* nl/http-proxy-more (2012-05-11) 2 commits
 . http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 . http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

* jk/no-op-push-message (2012-05-30) 1 commit
 . improve no-op push output

Rewords the status message of "git push" that pushed only one ref
differently from "Everything up-to-date", to give a bit more help to
people who get the message when their current branch is not pushed.

I had an impression after the discussion thread that a redesign is
coming, but it hasn't happened yet.
