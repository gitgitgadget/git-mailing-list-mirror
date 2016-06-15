From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2013, #07; Sun, 17)
Date: Sun, 17 Feb 2013 16:54:29 -0800
Message-ID: <7vfw0ue916.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 01:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7F0U-0003at-7D
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab3BRAye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:54:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754953Ab3BRAyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:54:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E298CBD30;
	Sun, 17 Feb 2013 19:54:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	t3jFwEmfaXZ/R7ryk6SlqVhrnM=; b=mzzMIteP+knwmAGBMLx3jBz4uD83xdIlY
	IbxTzQvTWh0m7I7XJpgsh2+cKlFCHwu+LH41Jfks8nnzLmif+9dOZuCNtsPKNDhK
	k7YGGg9LefEwApzIDhRfe9TvdW5fteGNBXJeC1EEyEKvLpjsE4dcZZXpSYKMB4lT
	Tq6CF8p4pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=aGv
	EXKLBGBsTEupl0ck6Mn24gVxQQdR9erQpSC6EwdvNxpLV7gLLsaOHuxFPF3vQ5YZ
	ZhbJihm/+qFwH8gZ6+rKIIO0Yg+e5qC7jRDLZTHbrslQLDsxKiGrGi12GC8/dXWW
	UakprOUw7zzAat6Sbok70ptFyAi0wWVdpeMdhBtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D68F6BD2F;
	Sun, 17 Feb 2013 19:54:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99C1ABD2A; Sun, 17 Feb 2013
 19:54:31 -0500 (EST)
X-master-at: 004825d314db4ba3f34ef499e3522ef72792d896
X-next-at: 838f5639caf00f6b9b0bfab81f201c6402762bf9
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C14EF85C-7965-11E2-BCA6-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216424>

What's cooking in git.git (Feb 2013, #07; Sun, 17)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the 'master' is at 1.8.2-rc0; new topics that are not
listed in this report are likely to be too late for the upcoming
release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* da/difftool-fixes (2013-02-17) 5 commits
 - [DONTMERGE] expect reroll $gmane/216376
 - t7800: "defaults" is no longer a builtin tool name
 - t7800: modernize tests
 - t7800: Update copyright notice
 - difftool: silence uninitialized variable warning

 Minor maintenance updates to difftool, and updates to its tests.
 Expecting a reroll.
 $gmane/216376


* jk/smart-http-robustify (2013-02-17) 3 commits
 - remote-curl: sanity check ref advertisement from server
 - remote-curl: verify smart-http metadata lines
 - pkt-line: teach packet_get_line a no-op mode

 Parse the HTTP exchange that implements the native Git protocol as
 a series of stateless RPC more carefully to diagnose protocol
 breakage better.

 Will merge to and hold in 'next'.


* nd/read-directory-recursive-optim (2013-02-17) 1 commit
 - read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.

 Will merge to and hold in 'next'.

--------------------------------------------------
[Graduated to "master"]

* da/p4merge-mktemp-fix (2013-02-10) 1 commit
  (merged to 'next' on 2013-02-14 at c5fc5ba)
 + p4merge: fix printf usage


* ef/non-ascii-parse-options-error-diag (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 10cbdf8)
 + parse-options: report uncorrupted multi-byte options


* jc/hidden-refs (2013-02-07) 3 commits
  (merged to 'next' on 2013-02-14 at b69f9cc)
 + upload/receive-pack: allow hiding ref hierarchies
 + upload-pack: simplify request validation
 + upload-pack: share more code
 (this branch is used by jc/fetch-raw-sha1.)

 Allow the server side to redact the refs/ namespace it shows to the
 client.


* jk/read-commit-buffer-data-after-free (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 220e3a8)
 + log: re-encode commit messages before grepping

 "git log --grep=<pattern>" has been taught to honor the logoutput
 encoding when matching the log message against the given pattern.


* jk/rebase-i-comment-char (2013-02-12) 1 commit
  (merged to 'next' on 2013-02-14 at 0ed2f48)
 + rebase -i: respect core.commentchar

 Finishing touches to core.commentchar topic to teach it to "rebase
 -i" as well.


* mk/make-rm-depdirs-could-be-empty (2013-02-13) 1 commit
  (merged to 'next' on 2013-02-14 at d966248)
 + Makefile: don't run "rm" without any files

 "make COMPUTE_HEADER_DEPENDENCIES=no clean" would try to run "rm
 -rf $(dep_dirs)" with an empty dep_dir, but some implementations of
 "rm -rf" barf on an empty argument list.


* mk/old-expat (2013-02-11) 1 commit
  (merged to 'next' on 2013-02-14 at 5fb47ce)
 + Allow building with xmlparse.h

 Old expat needs to include xmlparse.h instead of expat.h header
 file.


* mm/config-local-completion (2013-02-12) 1 commit
  (merged to 'next' on 2013-02-14 at 26bf6c2)
 + completion: support 'git config --local'


* mp/diff-algo-config (2013-01-16) 3 commits
  (merged to 'next' on 2013-02-14 at cd765dc)
 + diff: Introduce --diff-algorithm command line option
 + config: Introduce diff.algorithm variable
 + git-completion.bash: Autocomplete --minimal and --histogram for git-diff

 Add diff.algorithm configuration so that the user does not type
 "diff --histogram".


* mw/bash-prompt-show-untracked-config (2013-02-13) 3 commits
  (merged to 'next' on 2013-02-14 at 809dbcf)
 + t9903: add extra tests for bash.showDirtyState
 + t9903: add tests for bash.showUntrackedFiles
 + shell prompt: add bash.showUntrackedFiles option

 Allows skipping the untracked check GIT_PS1_SHOWUNTRACKEDFILES
 asks for the git-prompt (in contrib/) per repository.


* wk/man-deny-current-branch-is-default-these-days (2013-02-14) 1 commit
  (merged to 'next' on 2013-02-14 at 6fab9d4)
 + user-manual: Update for receive.denyCurrentBranch=refuse

--------------------------------------------------
[Stalled]

* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 There seems to be some interest. Let's see if it results in a solid
 execution of a sensible transition plan towards Git 2.0.


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

* mg/gpg-interface-using-status (2013-02-14) 5 commits
 - pretty: make %GK output the signing key for signed commits
 - pretty: parse the gpg status lines rather than the output
 - gpg_interface: allow to request status return
 - log-tree: rely upon the check in the gpg_interface
 - gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.


* mm/config-intro-in-git-doc (2013-02-15) 1 commit
 - git.txt: update description of the configuration mechanism

 Will merge to 'master'.


* jn/shell-disable-interactive (2013-02-11) 2 commits
 - shell: pay attention to exit status from 'help' command
 - shell doc: emphasize purpose and security model

 Expecting a reroll.
 $gmane/216229


* jc/fetch-raw-sha1 (2013-02-07) 4 commits
  (merged to 'next' on 2013-02-14 at ffa3c65)
 + fetch: fetch objects by their exact SHA-1 object names
 + upload-pack: optionally allow fetching from the tips of hidden refs
 + fetch: use struct ref to represent refs to be fetched
 + parse_fetch_refspec(): clarify the codeflow a bit

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).

 Will cook in 'next'.


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


* nd/count-garbage (2013-02-15) 4 commits
 - count-objects: report how much disk space taken by garbage files
 - count-objects: report garbage files in pack directory too
 - sha1_file: reorder code in prepare_packed_git_one()
 - git-count-objects.txt: describe each line in -v output

 Will merge to 'next'.


* tz/credential-authinfo (2013-02-05) 1 commit
 - Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Expecting a reroll.
 $gmane/215556


* jl/submodule-deinit (2013-02-17) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.


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

 Will merge to 'next'.


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

--------------------------------------------------
[Discarded]

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
