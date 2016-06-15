From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2013, #06; Thu, 14)
Date: Thu, 14 Feb 2013 13:51:50 -0800
Message-ID: <7vpq02y361.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 22:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U66j7-0000ky-CD
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935014Ab3BNVvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 16:51:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934983Ab3BNVvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 16:51:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB32BBE0;
	Thu, 14 Feb 2013 16:51:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	1akWA+AnN/eJ6+XLQzfRgxaWGk=; b=mThIsPNpD9HPQJ4pSGP+F518F51qaOzoF
	MRwczIjjt+kLK+ZVKIpsx7XOs6M1wOBJq/vw4pHtMu1NPpZFvdKYICT2VvaDilvA
	smWbvT/ToRPBCnURZ3qMaHb3PzfpfMCW+EiENEdKXMAi+4IaaoF6R8KKnF3TRxG9
	OFEJR9vPpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ok2
	62Lj6Nl7Z/i1eZAbK+W/6Pi4bAflTuVMihyaKNhdPltz6dsQFIMSmbmtIm/e3DT+
	onzS/zv7FgLpwXUEp1hORKTSM+bgX40+KolTOmTdu1pG1lqPIv7C7pweidx2RPbK
	gS1NUNcFzdoMeVyHXHpU/2QvYpS63n7ePRfPYbzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03AEBBBDF;
	Thu, 14 Feb 2013 16:51:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6C70BBDA; Thu, 14 Feb 2013
 16:51:51 -0500 (EST)
X-master-at: 02339dd5295d7add78ab409300b985e5888af0ee
X-next-at: ffa3c6506ad4ad51b33a54dee5c10a07cee019f0
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD8C94DA-76F0-11E2-A2D1-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216336>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

A preview of the upcoming release 1.8.2-rc0 is expected to be tagged
late this week.  At around that time, we may want to discard
long-stalled topics that did not see activities as well.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* al/mergetool-printf-fix (2013-02-10) 2 commits
  (merged to 'next' on 2013-02-11 at 5f9bc4e)
 + difftool--helper: fix printf usage
 + git-mergetool: print filename when it contains %


* bw/get-tz-offset-perl (2013-02-09) 3 commits
  (merged to 'next' on 2013-02-11 at b9c8893)
 + cvsimport: format commit timestamp ourselves without using strftime
 + perl/Git.pm: fix get_tz_offset to properly handle DST boundary cases
 + Move Git::SVN::get_tz to Git::get_tz_offset

 "git-cvsimport" and "git-svn" miscomputed TZ offset at DST boundary.


* dg/subtree-fixes (2013-02-05) 6 commits
  (merged to 'next' on 2013-02-09 at 8f19ebe)
 + contrib/subtree: make the manual directory if needed
 + contrib/subtree: honor DESTDIR
 + contrib/subtree: fix synopsis
 + contrib/subtree: better error handling for 'subtree add'
 + contrib/subtree: use %B for split subject/body
 + contrib/subtree: remove test number comments

 contrib/subtree updates, but here are only the ones that looked
 ready.


* jc/extended-fake-ancestor-for-gitlink (2013-02-05) 1 commit
  (merged to 'next' on 2013-02-09 at 2d3547b)
 + apply: verify submodule commit object name better

 Instead of requiring the full 40-hex object names on the index
 line, we can read submodule commit object names from the textual
 diff when synthesizing a fake ancestore tree for "git am -3".


* jk/diff-graph-cleanup (2013-02-12) 6 commits
  (merged to 'next' on 2013-02-12 at 6e764c1)
 + combine-diff.c: teach combined diffs about line prefix
 + diff.c: use diff_line_prefix() where applicable
 + diff: add diff_line_prefix function
 + diff.c: make constant string arguments const
 + diff: write prefix to the correct file
 + graph: output padding for merge subsequent parents

 Refactors a lot of repetitive code sequence from the graph drawing
 code and adds it to the combined diff output.


* jk/error-const-return (2013-02-08) 1 commit
  (merged to 'next' on 2013-02-11 at ba8dba3)
 + Use __VA_ARGS__ for all of error's arguments


* jx/utf8-printf-width (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-11 at 968b4e2)
 + Add utf8_fprintf helper that returns correct number of columns

 Use a new helper that prints a message and counts its display width
 to align the help messages parse-options produces.


* mg/bisect-doc (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-11 at 6125304)
 + git-bisect.txt: clarify that reset quits bisect


* mm/remote-mediawiki-build (2013-02-08) 2 commits
  (merged to 'next' on 2013-02-11 at 4ebb902)
 + git-remote-mediawiki: use toplevel's Makefile
 + Makefile: make script-related rules usable from subdirectories


* nd/status-show-in-progress (2013-02-05) 1 commit
  (merged to 'next' on 2013-02-11 at 5ffcbc2)
 + status: show the branch name if possible in in-progress info


* tz/perl-styles (2013-02-06) 1 commit
  (merged to 'next' on 2013-02-09 at c8cff17)
 + Update CodingGuidelines for Perl

 Add coding guidelines for writing Perl scripts for Git.

--------------------------------------------------
[New Topics]

* mk/make-rm-depdirs-could-be-empty (2013-02-13) 1 commit
  (merged to 'next' on 2013-02-14 at d966248)
 + Makefile: don't run "rm" without any files

 "make COMPUTE_HEADER_DEPENDENCIES=no clean" would try to run "rm
 -rf $(dep_dirs)" with an empty dep_dir, but some implementations of
 "rm -rf" barf on an empty argument list.

 Will merge to 'master'.


* mw/bash-prompt-show-untracked-config (2013-02-13) 3 commits
  (merged to 'next' on 2013-02-14 at 809dbcf)
 + t9903: add extra tests for bash.showDirtyState
 + t9903: add tests for bash.showUntrackedFiles
 + shell prompt: add bash.showUntrackedFiles option

 Allows skipping the untracked check GIT_PS1_SHOWUNTRACKEDFILES
 asks for the git-prompt (in contrib/) per repository.

 Will merge to 'master'.


* mg/gpg-interface-using-status (2013-02-14) 5 commits
 - pretty: make %GK output the signing key for signed commits
 - pretty: parse the gpg status lines rather than the output
 - gpg_interface: allow to request status return
 - log-tree: rely upon the check in the gpg_interface
 - gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.


* mm/config-intro-in-git-doc (2013-02-14) 1 commit
 - git.txt: update description of the configuration mechanism

--------------------------------------------------
[Stalled]

* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Stalled mostly due to lack of responses.


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
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* mp/diff-algo-config (2013-01-16) 3 commits
  (merged to 'next' on 2013-02-14 at cd765dc)
 + diff: Introduce --diff-algorithm command line option
 + config: Introduce diff.algorithm variable
 + git-completion.bash: Autocomplete --minimal and --histogram for git-diff

 Add diff.algorithm configuration so that the user does not type
 "diff --histogram".

 Will merge to 'master'.


* da/p4merge-mktemp-fix (2013-02-10) 1 commit
  (merged to 'next' on 2013-02-14 at c5fc5ba)
 + p4merge: fix printf usage

 Will merge to 'master'.


* jn/shell-disable-interactive (2013-02-11) 2 commits
 - shell: pay attention to exit status from 'help' command
 - shell doc: emphasize purpose and security model

 Expecting a reroll.
 $gmane/216229


* jk/read-commit-buffer-data-after-free (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 220e3a8)
 + log: re-encode commit messages before grepping

 Will merge to 'master'.


* mk/old-expat (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 5fb47ce)
 + Allow building with xmlparse.h

 Will merge to 'master'.


* ef/non-ascii-parse-options-error-diag (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 10cbdf8)
 + parse-options: report uncorrupted multi-byte options

 Will merge to 'master'.


* jk/rebase-i-comment-char (2013-02-12) 1 commit
  (merged to 'next' on 2013-02-14 at 0ed2f48)
 + rebase -i: respect core.commentchar

 Will merge to 'master'.


* mm/config-local-completion (2013-02-12) 1 commit
  (merged to 'next' on 2013-02-14 at 26bf6c2)
 + completion: support 'git config --local'

 Will merge to 'master'.


* jc/fetch-raw-sha1 (2013-02-07) 4 commits
  (merged to 'next' on 2013-02-14 at ffa3c65)
 + fetch: fetch objects by their exact SHA-1 object names
 + upload-pack: optionally allow fetching from the tips of hidden refs
 + fetch: use struct ref to represent refs to be fetched
 + parse_fetch_refspec(): clarify the codeflow a bit
 (this branch uses jc/hidden-refs.)

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).


* mn/send-email-works-with-credential (2013-02-12) 6 commits
 - git-send-email: use git credential to obtain password
 - Git.pm: add interface for git credential command
 - Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 - Git.pm: refactor command_close_bidi_pipe to use _cmd_close
 - Git.pm: fix example in command_close_bidi_pipe documentation
 - Git.pm: allow command_close_bidi_pipe to be called as method

 Hooks the credential system to send-email.
 Rerolled.
 Waiting for a review.


* nd/branch-show-rebase-bisect-state (2013-02-08) 1 commit
 - branch: show rebase/bisect info when possible instead of "(no branch)"

 Expecting a reroll.
 $gmane/215771


* nd/count-garbage (2013-02-13) 4 commits
 - count-objects: report how much disk space taken by garbage files
 - count-objects: report garbage files in pack directory too
 - sha1_file: reorder code in prepare_packed_git_one()
 - git-count-objects.txt: describe each line in -v output

 Looked good, but the handling of files with known-corrupt .idx
 counterparts could be improved.


* wk/man-deny-current-branch-is-default-these-days (2013-02-14) 1 commit
  (merged to 'next' on 2013-02-14 at 6fab9d4)
 + user-manual: Update for receive.denyCurrentBranch=refuse

 Will merge to 'master'.


* tz/credential-authinfo (2013-02-05) 1 commit
 - Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Expecting a reroll.
 $gmane/215556


* jl/submodule-deinit (2013-02-06) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Expecting another reroll.
 $gmane/216276


* jc/remove-export-from-config-mak-in (2013-02-12) 2 commits
  (merged to 'next' on 2013-02-12 at eb8af04)
 + Makefile: do not export mandir/htmldir/infodir
  (merged to 'next' on 2013-02-07 at 33f7d4f)
 + config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Will cook in 'next'.


* jc/mention-tracking-for-pull-default (2013-01-31) 1 commit
 - doc: mention tracking for pull.default

 We stopped mentioning `tracking` is a deprecated but supported
 synonym for `upstream` in pull.default even though we have no
 intention of removing the support for it.

 This is my "don't list it to catch readers' eyes, but make sure it
 can be found if the reader looks for it" version; I'm not married
 to the layout and will be happy to take a replacement patch.

 Will merge to 'next', unless a replacement materializes soonish.


* jc/hidden-refs (2013-02-07) 3 commits
  (merged to 'next' on 2013-02-14 at b69f9cc)
 + upload/receive-pack: allow hiding ref hierarchies
 + upload-pack: simplify request validation
 + upload-pack: share more code
 (this branch is used by jc/fetch-raw-sha1.)

 Allow the server side to redact the refs/ namespace it shows to the
 client.

 Will merge to 'master'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
  (merged to 'next' on 2013-01-30 at b639b47)
 + simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0 ;-).


* bc/append-signed-off-by (2013-02-12) 12 commits
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: require a conforming footer to be preceded by a blank line
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Waiting for further reviews.
 $gmane/216327 may need to be addressed.
