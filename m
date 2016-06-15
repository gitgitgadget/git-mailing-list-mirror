From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #01; Tue, 3)
Date: Tue, 03 Jul 2012 16:19:24 -0700
Message-ID: <7vd34ctoub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 01:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmCNc-0003cd-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 01:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478Ab2GCXTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 19:19:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913Ab2GCXT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 19:19:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E73FE9B7A;
	Tue,  3 Jul 2012 19:19:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	eqVOEla9TY6tdAa5jGUn5tGEVk=; b=V9p6/gZrlA33k6el4vBzHxfipoH69IJPQ
	YemXld2hiIOeDdgzO54xdC8Fst8Y5JJ3oqnQAlWmAm3VA1o6wgfJELm0kO7GG2k3
	NOXNsJ/t/40Q5aJbJw4qpl8d/0e9daIHvNkhm3Wz78EOCTDC8QCW8OCiwQn7Y4Qh
	4q4rhWtGpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pwh
	E3x5AKowx8sG1fnCVvESgx+xSNuB2F6zc/AOx6U4UGFPlx38qWT7cyHvT8fQnjqe
	URDOEhbi6TE8mRL/ifUUza2irg0qBwvS6tV0n2KHlJckzT1xvYF9XUGrn1F3GDfv
	d6P8KH0HVZNv/sya5W/834QB2Ft6tod12SHvPqpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE729B79;
	Tue,  3 Jul 2012 19:19:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFA3A9B76; Tue,  3 Jul 2012
 19:19:27 -0400 (EDT)
X-master-at: b12905140a8239ac687450ad43f18b5f0bcfb62e
X-next-at: c7ed6b9aeb316c5c29cc1de761d47bbd184a3884
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88F76E76-C565-11E1-8B8D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200975>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/maint-blame-unique-abbrev (2012-07-02) 1 commit
  (merged to 'next' on 2012-07-03 at c7ed6b9)
 + blame: compute abbreviation width that ensures uniqueness

"git blame" did not try to make sure the abbreviated commit object
names in its output are unique.

* jk/push-delete-ref-error-message (2012-07-03) 1 commit
 - push: don't guess at qualifying remote refs on deletion

The error message from "git push $there :bogo" mentioned we tried
and failed to guess what ref is being deleted based on the LHS of
the refspec, which we don't.

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

* tb/sanitize-decomposed-utf-8-pathname (2012-07-02) 1 commit
 - git on Mac OS and precomposed unicode

Teaches git to normalize pathnames read from readdir(3) and all
arguments from the command line into precomposed UTF-8 (assuming
that they come as decomposed UTF-8) to work around issues on Mac OS.

I think there still are other places that need conversion
(e.g. paths that are read from stdin for some commands), but this
should be a good first step in the right direction.

Will merge to 'next'.

* cw/no-detaching-an-unborn (2012-06-26) 1 commit
  (merged to 'next' on 2012-07-03 at 552c5ca)
 + git-checkout: disallow --detach on unborn branch

"git checkout --detach", when you are still on an unborn branch,
should be forbidden, but it wasn't.

* cw/rebase-i-root (2012-06-26) 2 commits
  (merged to 'next' on 2012-07-03 at 231c0a4)
 + Add tests for rebase -i --root without --onto
 + rebase -i: support --root without --onto

"git rebase [-i] --root $tip" can now be used to rewrite all the
history down to the root.

* js/fast-export-paths-with-spaces (2012-06-27) 1 commit
  (merged to 'next' on 2012-07-03 at f9c23e9)
 + fast-export: quote paths with spaces

"git fast-export" produced an input stream for fast-import without
properly quoting pathnames when they contain SPs in them.

* mm/mediawiki-file-attachments (2012-06-27) 5 commits
  (merged to 'next' on 2012-07-03 at 90f2f45)
 + git-remote-mediawiki: import "File:" attachments
 + git-remote-mediawiki: split get_mw_pages into smaller functions
 + git-remote-mediawiki: send "File:" attachments to a remote wiki
 + git-remote-mediawiki: don't "use encoding 'utf8';"
 + git-remote-mediawiki: don't compute the diff when getting commit message
 (this branch uses mm/credential-plumbing.)

"mediawiki" remote helper (in contrib/) learned to handle file
attachments.

* mz/rebase-no-mbox (2012-06-26) 4 commits
  (merged to 'next' on 2012-07-03 at 5bf5c12)
 + am: don't call mailinfo if $rebasing
 + am --rebasing: get patch body from commit, not from mailbox
 + rebase --root: print usage on too many args
 + rebase: don't source git-sh-setup twice

Teach "am --rebasing" codepath to grab authorship, log message and
the patch text directly out of existing commits.  This will help
rebasing commits that have confusing "diff" output in their log
messages.

* pw/git-p4-tests (2012-06-27) 10 commits
  (merged to 'next' on 2012-07-03 at 9bd9cda)
 + git p4 test: fix badp4dir test
 + git p4 test: split up big t9800 test
 + git p4 test: cleanup_git should make a new $git
 + git p4 test: copy source indeterminate
 + git p4 test: check for error message in failed test
 + git p4 test: rename some "git-p4 command" strings
 + git p4 test: never create default test repo
 + git p4 test: simplify quoting involving TRASH_DIRECTORY
 + git p4 test: use real_path to resolve p4 client symlinks
 + git p4 test: wait longer for p4d to start and test its pid

More "git p4" tests.

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
  (merged to 'next' on 2012-07-03 at 1e7de3f)
 + add test case for rebase of empty commit
We did not have test to make sure "git rebase" without extra options
filters out an empty commit in the original history.

* cw/help-over-network (2012-06-28) 2 commits
  (merged to 'next' on 2012-07-03 at 99e8d28)
 + Allow help.htmlpath to be a URL prefix
 + Add config variable to set HTML path for git-help --web

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

* mm/config-xdg (2012-06-25) 4 commits
  (merged to 'next' on 2012-06-28 at 57049d1)
 + config: write to $XDG_CONFIG_HOME/git/config file when appropriate
 + Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
 + Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
 + config: read (but not write) from $XDG_CONFIG_HOME/git/config file

Teach git to read various information from $XDG_CONFIG_HOME/git/ to allow
the user to avoid cluttering $HOME.

* mm/credential-plumbing (2012-06-25) 3 commits
  (merged to 'next' on 2012-06-28 at 6e6fe9f)
 + git-remote-mediawiki: add credential support
 + git credential fill: output the whole 'struct credential'
 + add 'git credential' plumbing command
 (this branch is used by mm/mediawiki-file-attachments.)

Expose the credential API to scripted Porcelain writers.

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
  (merged to 'next' on 2012-07-03 at 90dfcf0)
 + t/README: add a bit more Don'ts
 + tests: enclose $PERL_PATH in double quotes
 + t/test-lib.sh: export PERL_PATH for use in scripts
 + t: Replace 'perl' by $PERL_PATH
 (this branch is used by jc/test-lib-source-build-options-early.)

Some implementations of Perl terminates "lines" with CRLF even when
the script is operating on just a sequence of bytes.  Make sure to
use "$PERL_PATH", the version of Perl the user told Git to use, in
our tests to avoid unnecessary breakages in tests.

* jc/sha1-name-more (2012-07-03) 25 commits
 - rev-parse --disambiguate=<prefix>
 - rev-parse: A and B in "rev-parse A..B" refer to committish
 - reset: the command takes committish
 - commit-tree: the command wants a tree and commits
 - apply: --build-fake-ancestor expects blobs
 - sha1_name.c: add support for disambiguating other types
 - revision.c: the "log" family, except for "show", takes committish
 - revision.c: allow handle_revision_arg() to take other flags
 - sha1_name.c: introduce get_sha1_committish()
 - sha1_name.c: teach lookup context to get_sha1_with_context()
 - sha1_name.c: many short names can only be committish
 - sha1_name.c: get_sha1_1() takes lookup flags
 - sha1_name.c: get_describe_name() by definition groks only commits
 - sha1_name.c: teach get_short_sha1() a commit-only option
 - sha1_name.c: allow get_short_sha1() to take other flags
 - get_sha1(): fix error status regression
 - sha1_name.c: restructure disambiguation of short names
 - sha1_name.c: correct misnamed "canonical" and "res"
 - sha1_name.c: refactor find_short_packed_object()
 - sha1_name.c: rename "now" to "current"
 - sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 - sha1_name.c: get rid of get_sha1_with_mode()
 - sha1_name.c: get rid of get_sha1_with_mode_1()
 - sha1_name.c: hide get_sha1_with_context_1() ugliness
 - sha1_name.c: indentation fix

Teaches the object name parser things like a "git describe" output
is always a commit object, "A" in "git log A" must be a committish,
and "A" and "B" in "git log A...B" both must be committish, etc., to
prolong the lifetime of abbreviated object names.

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

Will keep in 'pu' to give Peff and Jonathan to work out improvements.

* jn/perl-makemaker-leading-paths (2012-06-29) 2 commits
  (merged to 'next' on 2012-06-29 at 0f17059)
 + perl/Makefile: Fix a missing double-quote
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
