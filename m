From: Junio C Hamano <junio@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #07; Sun, 28)
Date: Sun, 28 Mar 2010 21:48:56 -0700
Message-ID: <7viq8fg2br.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 06:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw6ui-0007Tl-LL
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 06:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0C2EtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 00:49:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0C2EtC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 00:49:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26707A6185;
	Mon, 29 Mar 2010 00:49:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5PjGtRh2qUlVxtpmxyG1u95nV
	To=; b=XbyTkkZgAlerYHC6kN87eAJ/aZpSghPr1U3KwARveMwujypjDRBBkwuu4
	NnT7A1TY4rIiUjaiNcylEaFd/u2J/7lX5DKRLfWo4HBeE4l+Cx3Y57tS1+LV3P+y
	mQh5dXEmbF8GkluU569tTZ6+FbQL0toH4r4J5kv0GRfvb25Cuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wL4ATLck6SnzkeHzv8V
	l4NeQKpIqCjMN2nGH8kzMhKhWua5v5X1QboA/EbuP6vSKUw1tNkBzFl+OWhtfLP/
	eIHEh8lErTrWUXeyx2CfChwhlXLJqe2jdQ9Y056vDKpFbae2DHbQQpAgF9BHHrDt
	OgJPucygPpG0Y2g9Cbls8FAg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F005FA6184;
	Mon, 29 Mar 2010 00:48:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A09FEA6181; Mon, 29 Mar
 2010 00:48:57 -0400 (EDT)
X-master-at: faf752693abd0a891a9a47a2d398353cc59ee93a
X-next-at: 133563ba0a1cd78841512283a1069b49bf69373e
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 640BED48-3AEE-11DF-ACAE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143436>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

As it has been about 6 weeks since the previous feature release, I'd wa=
nt
to start making noises about feature freeze for 1.7.1 in a few days.  I
expect that the changes still under discussion will be ready by the tim=
e
the post 1.7.1 cycle begins, and we will hopefully have a cycle for 1.7=
=2E2
that is shorter than usual to include them.

--------------------------------------------------
[New Topics]

* da/maint-python-startup (2010-03-27) 1 commit
 - Makefile: Remove usage of deprecated Python "has_key" method

Another thing that this fixes is not described in the log message.

* jc/conflict-marker-size (2010-03-24) 1 commit
 - diff --check: honor conflict-marker-size attribute

* ld/discovery-limit-to-fs (2010-03-17) 3 commits
 - Add support for GIT_ONE_FILESYSTEM
 - truncate cwd string before printing error message
 - config.c: remove static keyword from git_env_bool()

* sb/fmt-merge-msg (2010-03-24) 7 commits
 - fmt-merge-msg: hide summary option
 - fmt-merge-msg: remove custom string_list implementation
 - string-list: add unsorted_string_list_lookup()
 - fmt-merge-msg: use pretty.c routines
 - t6200: test fmt-merge-msg more
 - t6200: modernize with test_tick
 - fmt-merge-msg: be quiet if nothing to merge

* pc/remove-warn (2010-03-26) 4 commits
 . Remove a redundant errno test in a usage of remove_path
 . Introduce remove_or_warn function
 . Implement the rmdir_or_warn function
 . Generalise the unlink_or_warn function

--------------------------------------------------
[Stalled]

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to =
GPLv2+.

Ack-collection stopped at the last three names.  I am hoping Carl can t=
ake
it from there without my keeping an eye on it.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record origin=
al commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* sg/bash-completion (2010-02-23) 4 commits
  (merged to 'next' on 2010-03-08 at bc59860)
 + bash: completion for gitk aliases
 + bash: support user-supplied completion scripts for aliases
 + bash: support user-supplied completion scripts for user's git comman=
ds
 + bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* sd/log-decorate (2010-02-17) 3 commits
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

Needs squelching the configuration setting when "--pretty=3Draw" is giv=
en,
at least, or possibly when any "--pretty" is explicitly given.

--------------------------------------------------
[Cooking]

* np/malloc-threading (2010-03-24) 1 commit
 - Make xmalloc and xrealloc thread-safe

Still has locking issues?

* bw/git-completion-rpmspec (2010-03-20) 1 commit
 - Add a git-completion rpm subpackage to the spec

Shipping bash-completion as part of RPM package; since Todd Zullinger w=
ho
packages git for Fedora joined the thread, I am hoping that I can defer
the direction of the final version to the discussion between Todd and B=
en.

* ef/maint-empty-commit-log (2010-03-21) 1 commit
 - rev-list: fix --pretty=3Doneline with empty message

Looked reasonable.  Soon in 'next'.

* em/checkout-orphan (2010-03-21) 1 commit
 - git checkout: create unparented branch by --orphan

Looked reasonable, except that we might want to come up with a way to
allow people with core.logallrefupdates set to false to still override =
it
with "-l" when switching to this new branch.  Or we may not care.  I du=
nno.

Soon in 'next'.

* mg/mailmap-update (2010-03-19) 1 commit
 - .mailmap: Entries for Alex Benn=C3=A9e, Deskin Miller, Vitaly "_Vi" =
Shukela

Soon in 'next'.

* mg/maint-send-email-lazy-editor (2010-03-22) 1 commit
 - send-email: lazily assign editor variable

Soon in 'next'.

* mg/use-default-abbrev-length-in-rev-list (2010-03-22) 1 commit
 - rev-list: use default abbrev length when abbrev-commit is in effect

Soon in 'next'.

* rb/maint-python-path (2010-03-21) 1 commit
 - Correct references to /usr/bin/python which does not exist on FreeBS=
D

Soon in 'next'.

* rr/imap-send-unconfuse-from-line (2010-03-22) 1 commit
 - imap-send: Remove limitation on message body

Soon in 'next'.

* sp/maint-http-backend-die-triggers-die-recursively (2010-03-22) 1 com=
mit
 - http-backend: Don't infinite loop during die()

Soon in 'next'.

* ar/config-from-command-line (2010-03-26) 2 commits
 - Use strbufs instead of open-coded string manipulation
 - Allow passing of configuration parameters in the command line

* bc/t5505-fix (2010-03-19) 3 commits
 - t/t5505-remote.sh: escape * to prevent interpretation by shell as gl=
ob
 - t5505: add missing &&
 - t5505: remove unnecessary subshell invocations

Looked reasonable.  Soon in 'next'.

* bw/template-tool-buildconfig (2010-03-20) 2 commits
 - Modernize git calling conventions in hook templates
 - Make templates honour SHELL_PATH and PERL_PATH

Looked reasonable.  Soon in 'next'.

* mb/rebase-i-no-ff (2010-03-24) 1 commit
 - Teach rebase the --no-ff option.

Looked reasonable.  Soon in 'next'.

* jn/merge-diff3-label (2010-03-20) 14 commits
  (merged to 'next' on 2010-03-20 at 26f1805)
 + merge-recursive: add a label for ancestor
 + cherry-pick, revert: add a label for ancestor
 + revert: clarify label on conflict hunks
 + compat: add mempcpy()
 + checkout -m --conflict=3Ddiff3: add a label for ancestor
 + merge_trees(): add ancestor label parameter for diff3-style output
 + merge_file(): add comment explaining behavior wrt conflict style
 + checkout --conflict=3Ddiff3: add a label for ancestor
 + ll_merge(): add ancestor label parameter for diff3-style output
 + merge-file --diff3: add a label for ancestor
 + xdl_merge(): move file1 and file2 labels to xmparam structure
 + xdl_merge(): add optional ancestor label to diff3-style output
 + tests: document cherry-pick behavior in face of conflicts
 + tests: document format of conflicts from checkout -m

* do/rebase-i-arbitrary (2010-03-14) 1 commit
 - rebase--interactive: don't require what's rebased to be a branch

Looked reasonable.  Soon in 'next'.

* ja/send-email-ehlo (2010-03-14) 3 commits
 - git-send-email.perl - try to give real name of the calling host to H=
ELO/EHLO
 - git-send-email.perl: add option --smtp-debug
 - git-send-email.perl: improve error message in send_message()

Looked reasonable.  Soon in 'next'.

* ak/everyday-git (2009-10-21) 1 commit
 - everyday: fsck and gc are not everyday operations

Looked reasonable.  Soon in 'next'.

* bc/acl-test (2010-03-15) 5 commits
 - t/t1304: make a second colon optional in the mask ACL check
 - t/t1304: set the ACL effective rights mask
 - t/t1304: use 'test -r' to test readability rather than looking at mo=
de bits
 - t/t1304: set the Default ACL base entries
 - t/t1304: avoid -d option to setfacl

Looked reasonable.  Soon in 'next'.

* bc/maint-daemon-sans-ss-family (2010-03-15) 1 commit
 - daemon.c: avoid accessing ss_family member of struct sockaddr_storag=
e

Looked reasonable.  Soon in 'next'.

* ef/cherry-abbrev (2010-03-20) 2 commits
 - ls: remove redundant logic
 - cherry: support --abbrev option

Looked reasonable.  Soon in 'next'.

* sb/notes-parse-opt (2010-02-27) 1 commit
  (merged to 'next' on 2010-03-24 at 82eebc1)
 + notes: rework subcommands and parse options

Ready for 'master'.

* gh/maint-stash-show-error-message (2010-03-16) 1 commit
 - Improve error messages from 'git stash show'

Looked reasonable.  Soon in 'next'.

* rs/threaded-grep-context (2010-03-15) 1 commit
 - grep: enable threading for context line printing

Looked reasonable.  Soon in 'next'.

* cc/cherry-pick-ff (2010-03-20) 7 commits
  (merged to 'next' on 2010-03-20 at a1ae16b)
 + revert: fix tiny memory leak in cherry-pick --ff
 + rebase -i: use new --ff cherry-pick option
  (merged to 'next' on 2010-03-07 at 5589b26)
 + Documentation: describe new cherry-pick --ff option
 + cherry-pick: add tests for new --ff option
 + revert: add --ff option to allow fast forward when cherry-picking
 + builtin/merge: make checkout_fast_forward() non static
 + parse-options: add parse_options_concat() to concat options

Ready for 'master'.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-03-20 at 9939243)
 + Dying in an async procedure should only exit the thread, not the pro=
cess.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

The tip one will be soon in 'next', but one step at a time.

* nd/setup (2010-03-25) 43 commits
 - builtins: do not commit pager choice early
 - builtins: reset startup_info->have_run_setup_gitdir when unsetting u=
p repository
 - builtins: setup repository before print unknown command error
 - Guard unallowed access to repository when it's not set up
 - alias: keep repository found while collecting aliases as long as pos=
sible
 - Allow to undo setup_git_directory_gently() gracefully (and fix alias=
 code)
 - builtins: check for startup_info->help, print and exit early
 - builtins: utilize startup_info->help where possible
 - run_builtin(): save "-h" detection result for later use
 - config: do not read .git/config if there is no repository
 - apply: do not check sha1 when repository has not been found
 - Do not read .git/info/attributes if there is no repository
 - Do not read .git/info/exclude if there is no repository
 - git_config(): do not read .git/config if there is no repository
 - init/clone: turn on startup->have_repository properly
 - worktree setup: restore original state when things go wrong
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - worktree setup: call set_git_dir explicitly
 - rev-parse --git-dir: print relative gitdir correctly
 - enter_repo(): initialize other variables as setup_git_directory_gent=
ly() does
 - Move enter_repo() to setup.c
 - index-pack: use RUN_SETUP_GENTLY
 - index-pack: trust the prefix returned by setup_git_directory_gently(=
)
 - worktree setup: calculate prefix even if no worktree is found
 - merge-file: use RUN_SETUP_GENTLY
 - var: use RUN_SETUP_GENTLY
 - ls-remote: use RUN_SETUP_GENTLY
 - help: use RUN_SETUP_GENTLY
 - diff: use RUN_SETUP_GENTLY
 - bundle: use RUN_SETUP_GENTLY
 - apply: use RUN_SETUP_GENTLY
 - verify-pack: use RUN_SETUP_GENTLY
 - check-ref-format: use RUN_SETUP_GENTLY
 - mailinfo: use RUN_SETUP_GENTLY
 - archive: use RUN_SETUP_GENTLY
 - builtin: USE_PAGER should not be used without RUN_SETUP*
 - grep: use RUN_SETUP_GENTLY
 - shortlog: use RUN_SETUP_GENTLY
 - hash-object: use RUN_SETUP_GENTLY
 - config: use RUN_SETUP_GENTLY
 - builtin: Support RUN_SETUP_GENTLY to set up repository early if foun=
d
 - builtin: introduce startup_info struct
