From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #08; Thu, 26)
Date: Thu, 26 Jul 2012 23:09:18 -0700
Message-ID: <7vy5m520s1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 08:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sudjt-0004qO-1i
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 08:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab2G0GJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 02:09:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2G0GJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 02:09:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BADDC7116;
	Fri, 27 Jul 2012 02:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	IevcR7xtCRBZhFei9W5w7dWjRo=; b=h2K3fMxNPJlDaNDy5LLdBfD6a3aye9H7i
	+1gtBcRaMnSNL4/J6EKDNKxBeSnV6VnrMiZEPKwoPIgVkvC0v9zDG+LcQFq/jolH
	HKMRMAGMufZUrM4zAwxozUBY66zj3Um+KUgkzY0l/Hx3eVa0hlamNZhihocvm4tZ
	muLDWKpfWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VyE
	6KBYINt2gPdO2LLbOFaT7XUcInYZmnx8DEHgbgEn1ulQAZhkB8dPDQoCOPEzCMl4
	Q7V7yI3jDjh5yiDNyBfJuUKfr7UzXVbErASJHc4/7FK2ULMyBSszs+uohrHFwpxx
	oyk2PPU3GtN4Ac6a1aJ6mqNOqyZ8dSISQBZL8cPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8B857115;
	Fri, 27 Jul 2012 02:09:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86A457114; Fri, 27 Jul 2012
 02:09:19 -0400 (EDT)
X-master-at: cdd159b2f56c9e69e37bbb8f5af301abd93e5407
X-next-at: f358a28daf9cd64a842c5aac31fa79dd40c72ecc
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A4A7836-D7B1-11E1-A027-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202339>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Please consider that the tip of 'master' is more or less feature
complete.  Topics that are not in 'next' by the time I tag -rc1
sometime early next week will not likely to be part of upcoming
1.7.12 release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* dg/submodule-in-dismembered-working-tree (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at cfa16c4)
 + git-submodule: work with GIT_DIR/GIT_WORK_TREE

Will merge to 'master'.

* jk/help-plug-memleak (2012-07-25) 2 commits
  (merged to 'next' on 2012-07-26 at bd57cb8)
 + help.c::exclude_cmds(): plug a leak
 + help.c::uniq: plug a leak

Will merge to 'master'.

* jk/maint-checkout-orphan-check-fix (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at a513c5a)
 + checkout: don't confuse ref and object flags

Will merge to 'master', later down to older maintenance releases.

* ms/makefile-pl (2012-07-25) 3 commits
 - The Makefile.PL will now find .pm files itself.
 - Don't lose Error.pm if $@ gets clobbered.
 - Quiet warning if Makefile.PL is run with -w and no --localedir
 (this branch is used by ms/git-svn-pm.)

Will be part of larger series around git-svn, so I'll most likely
drop this copy and wait for Eric to feed it to me later.

* ms/git-svn-pm (2012-07-26) 4 commits
 - Move initialization of Git::SVN variables into Git::SVN.
 - Extract Git::SVN from git-svn into its own .pm file.
 - Prepare Git::SVN for extraction into its own file.
 - Extract some utilities from git-svn to allow extracting Git::SVN.
 (this branch uses ms/makefile-pl.)

Will be part of larger series around git-svn, so I'll most likely
drop this copy and wait for Eric to feed it to me later.

* sz/submodule-force-update (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at 3bda2be)
 + Make 'git submodule update --force' always check out submodules.

We may want a documentation update and a few tests on top.
Not urgent.

* jk/autoident-test (2012-07-26) 6 commits
  (merged to 'next' on 2012-07-26 at f358a28)
 + t7502: test early quit from commit with bad ident
 + t7502: handle systems where auto-identity is broken
 + t7502: drop confusing test_might_fail call
 + t7502: narrow checks for author/committer name in template
 + t7502: properly quote GIT_EDITOR
 + t7502: clean up fake_editor tests

Will merge to 'master'.

* jc/test-prereq (2012-07-26) 6 commits
  (merged to 'next' on 2012-07-26 at 0e21c36)
 + test-lib: provide UTF8 behaviour as a prerequisite
 + t0050: use the SYMLINKS test prereq
 + t0050: use the CASE_INSENSITIVE_FS test prereq
 + test-lib: provide case insensitivity as a prerequisite
 + test: allow prerequisite to be evaluated lazily
 + test: rename $satisfied to $satisfied_prereq

Teaches the test framework to probe rarely used prerequistes lazily,
and make use of it for detecting SYMLINKS, CASE_INSENSITIVE_FS and
NKD/NKC MacOS x gotcha.

Not urgent.

--------------------------------------------------
[Graduated to "master"]

* cw/rebase-i-root (2012-07-24) 1 commit
  (merged to 'next' on 2012-07-24 at 01b7c29)
 + rebase -i: handle fixup of root commit correctly

Finishing touches to the "rebase -i --root" (new feature for
1.7.12).

* jc/mergetool-tool-help (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at ef256fc)
 + mergetool: support --tool-help option like difftool does

"git mergetool" did not support --tool-help option to give the list
of supported backends, like "git difftool" does.

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
  (merged to 'next' on 2012-07-24 at 97078b5)
 + test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

* jk/maint-advise-vaddf (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at 5b13a77)
 + advice: pass varargs to strbuf_vaddf, not strbuf_addf
 (this branch is used by jk/maint-commit-abandoned-message.)

The advise() function did not use varargs correctly to format
its message.

* jk/maint-commit-check-committer-early (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at a2c7133)
 + commit: check committer identity more strictly

"git commit --amend" let the user edit the log message and then died
when the human-readable committer name was given insufficiently by
getpwent(3).

* jk/maint-commit-document-editmsg (2012-07-23) 1 commit
  (merged to 'next' on 2012-07-23 at 06307fb)
 + commit: document the temporary commit message file

Document $GIT_DIR/COMMIT_EDITMSG file.

* mh/maint-revisions-doc (2012-07-24) 2 commits
  (merged to 'next' on 2012-07-24 at d5e286e)
 + Enumerate revision range specifiers in the documentation
 + Make <refname> documentation more consistent.

* mm/config-xdg (2012-07-24) 4 commits
  (merged to 'next' on 2012-07-24 at 6ab5783)
 + t1306: check that XDG_CONFIG_HOME works
 + ignore: make sure we have an xdg path before using it
 + attr: make sure we have an xdg path before using it
 + test-lib.sh: unset XDG_CONFIG_HOME

Finishing touches to the XDG support (new feature for 1.7.12) and
tests.

--------------------------------------------------
[Stalled]

* mz/rebase-range (2012-07-18) 7 commits
 - rebase (without -p): correctly calculate patches to rebase
 - rebase -p: don't request --left-right only to ignore left side
 - rebase -p: use --cherry-mark for todo file
 - git-rebase--interactive.sh: look up subject in add_pick_line
 - git-rebase--interactive: group all $preserve_merges code
 - git-rebase--interactive.sh: extract function for adding "pick" line
 - git-rebase--am.sh: avoid special-casing --keep-empty

Expecting a reroll.

Performance concerns from Windows folks.  Also the series lacks
proper sign-offs.

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Expecting a reroll.

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

* da/difftool-updates (2012-07-26) 10 commits
  (merged to 'next' on 2012-07-26 at 3263461)
 + difftool: Disable --symlinks on cygwin
 + difftool: Handle compare() returning -1
 + difftool: Wrap long lines for readability
 + difftool: Check all return codes from compare()
 + difftool: Handle finding mergetools/ in a path with spaces
  (merged to 'next' on 2012-07-23 at 96528a7)
 + difftool: Use symlinks when diffing against the worktree
 + difftool: Call the temp directory "git-difftool"
 + difftool: Move option values into a hash
 + difftool: Eliminate global variables
 + difftool: Simplify print_tool_help()

"git difftool --dir-diff" learned to use symbolic links to prepare
temporary copy of the working tree when available.

Not urgent.

* jx/i18n-1.7.11 (2012-07-26) 7 commits
 - i18n: merge-recursive: mark strings for translation
 - Remove dead code which contains bad gettext block
 - i18n: am: mark more strings for translation
 - rebase: remove obsolete and unused LONG_USAGE which breaks xgettext
 - i18n: Rewrite gettext messages start with dash
 - i18n: rebase: mark messages for translation
 - i18n: New keywords for xgettext extraction from sh

Is this ready for 'next'?
Not urgent.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-07-23 at fe59cb6)
 + pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.

--------------------------------------------------
[Discarded]

* jk/maint-commit-abandoned-message (2012-07-23) 2 commits
 . commit: give a hint when a commit message has been abandoned
 . Merge commit 'b2eda9b' into jk/maint-commit-abandoned-message
