From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2010, #01; Fri, 02)
Date: Fri, 02 Apr 2010 01:40:53 -0700
Message-ID: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 10:41:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxcRG-0007Du-OU
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 10:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0DBIlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 04:41:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab0DBIlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 04:41:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A298A7332;
	Fri,  2 Apr 2010 04:40:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=zdy6FEiWJjHwdVGLeuSLTgYrG
	Jc=; b=fVSxRJ/bBHOp9Gx7Z9vdNHDYbWX8BJ4eZzvhtlVFIoVuVLBGLXUUBiplq
	HMBI0FBikTTsELZotRWCphiOwhsge0yp5jwIfXhDvItdQmfn/5NR/LPM3c4gd72I
	vxfe3uU5e8HPoFwJlhv7HjTz/WHSY8666ZOrK3D/N4xTe3yG2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=O31764L1EHhsmwutzuz
	mUJ4hbtU5AEcIFa+ETpw1rvAinp2ZorIYX4W4NpauVMyadJQ/aB01B3iw6dbGNdH
	9ELcxENP1KSF1j6QmLjQG6BSqgk2E4uH3HxAQkyrVbZ0TfJ3OkXPjiH0PCKFJaZM
	q0FdNB5e9Q/d7FjdTkCsJq1Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 183EEA7331;
	Fri,  2 Apr 2010 04:40:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1696FA732F; Fri,  2 Apr
 2010 04:40:54 -0400 (EDT)
X-master-at: a50dec22f2800fd073aa6ca1d112f25b4f667a56
X-next-at: 85b6122874e41c12f0cd6ae4744fb1b856d4a0ad
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74F24254-3E33-11DF-9374-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143800>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

Topics not in 'next' will have to wait until post 1.7.1 cycle.  I expec=
t
that the changes already under discussion will be ready by the time the=
 post
1.7.1 cycle begins, and we will hopefully have a cycle for 1.7.2 that i=
s
shorter than usual to include them.

--------------------------------------------------
[Graduated to "master"]

* sb/notes-parse-opt (2010-02-27) 1 commit
  (merged to 'next' on 2010-03-24 at 82eebc1)
 + notes: rework subcommands and parse options

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

--------------------------------------------------
[New Topics]

* cw/ws-indent-with-tab (2010-04-01) 2 commits
 - whitespace: we cannot "catch all errors known to git" anymore
 - Add tab-in-indent whitespace error class

Not quite ready until "apply --whitespace=3Dfix" gets a matching change=
=2E

* ic/bash-completion-rpm (2010-03-26) 1 commit
 - RPM spec: include bash completion support

This is needed in 'master' by -rc1 at the latest.  Soon in 'next'.

* js/grep-open (2010-03-26) 2 commits
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'

Probably needs to support --no-index mode as well.

* mg/notes-reflog (2010-03-29) 2 commits
 - refs.c: Write reflogs for notes just like for branch heads
 - t3301-notes: Test the creation of reflog entries

Implementation is trivially correct; I am unsure if "notes" tree wants
reflog in the first place, though.  Please convince me and I'll move it
to 'next' soon, aiming for -rc0 or -rc1 at the latest.

* rr/remote-helper-doc (2010-03-28) 2 commits
 - Documentation/remote-helpers: Fix some typos
 - Documentation/remote-helpers: Rewrite description

Although I lost track of this series with too rapid succession of
updates, intermixed with some documentation updates in the related
areas, my impression is that area experts haven't Acked them yet.

* sr/remote-helper-export (2010-03-29) 7 commits
 - remote-helpers: add tests for testgit helper
 - remote-helpers: add testgit helper
 - remote-helpers: add support for an export command
 - remote-helpers: allow requesing the path to the .git directory
 - fast-import: always create marks_file directories
 - clone: also configure url for bare clones
 - clone: pass the remote name to remote_get

May merge to 'next', but I would prefer waiting til 1.7.2 to have
this with a confidence than fast-tracking it.

* cc/revert-strategy (2010-03-31) 5 commits
 - revert: add "--strategy" option to choose merge strategy
 - merge: make function try_merge_command non static
 - merge: refactor code that calls "git merge-STRATEGY"
 - revert: refactor merge recursive code into its own function
 - revert: use strbuf to refactor the code that writes the merge messag=
e
 (this branch uses jn/merge-diff3-label.)

May merge to 'next' soon, but this is more about debugging and we are n=
ot
in a great hurry.

* mr/gitweb-jsmin (2010-04-01) 6 commits
 - gitweb: update INSTALL to use shorter make target
 - gitweb: add documentation to INSTALL regarding gitweb.js
 - instaweb: add minification awareness
 - Gitweb: add autoconfigure support for minifiers
 - Gitweb: add support for minifying gitweb.css
 - Gitweb: add ignore and clean rules for minified files

Soon in 'next' when minor rewording replacement patches come; otherwise
felt solid.

* sc/http-late-auth (2010-04-01) 1 commit
 - Prompt for a username when an HTTP request 401s

May merge to 'next', but I would prefer waiting til 1.7.2 to have
this with a confidence than fast-tracking it.

* hg/convert (2010-03-29) 5 commits
 . convert: Added core.refilteronadd feature.
 . convert: Inhibit contraction of foreign $Id$ during stats.
 . convert: Use the enum constant SAFE_CRLF_FALSE.
 . convert: Keep foreign $Id$ on checkout.
 . convert: Safer handling of $Id$ contraction.

* jk/cached-textconv (2010-04-01) 7 commits
 - diff: avoid useless filespec population
 - diff: cache textconv output
 - textconv: refactor calls to run_textconv
 - introduce notes-cache interface
 - make commit_tree a library function
 - fix textconv leak in emit_rewrite_diff
 - fix const-correctness of write_sha1_file

May merge to 'next', but I would prefer waiting til 1.7.2 to have
this with a confidence than fast-tracking it.

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

* np/malloc-threading (2010-03-24) 1 commit
 - Make xmalloc and xrealloc thread-safe

Still has locking issues?

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

Waiting for resolution of locking issues in malloc-threading.

--------------------------------------------------
[Cooking]

* da/maint-python-startup (2010-03-27) 1 commit
  (merged to 'next' on 2010-04-01 at ca6897a)
 + Makefile: Remove usage of deprecated Python "has_key" method

Hopefully will merge to 'master' by -rc0.

* jc/conflict-marker-size (2010-03-24) 1 commit
  (merged to 'next' on 2010-04-01 at 164b1f4)
 + diff --check: honor conflict-marker-size attribute

Hopefully will merge to 'master' by -rc0.

* ld/discovery-limit-to-fs (2010-03-17) 3 commits
 - Add support for GIT_ONE_FILESYSTEM
 - truncate cwd string before printing error message
 - config.c: remove static keyword from git_env_bool()

Linus made a good point of making this a default, and Erick Mattos
confirmed that it won't be a problem even on Windows.

Will move to 'next' after such a "default on" change, keep it there unt=
il
1.7.1 ships, warn about it in the release notes as an upcoming backward
incompatibility, and then move to 'master' after 1.7.1.

* sb/fmt-merge-msg (2010-03-24) 7 commits
  (merged to 'next' on 2010-04-01 at 5fcbec5)
 + fmt-merge-msg: hide summary option
 + fmt-merge-msg: remove custom string_list implementation
 + string-list: add unsorted_string_list_lookup()
 + fmt-merge-msg: use pretty.c routines
 + t6200: test fmt-merge-msg more
 + t6200: modernize with test_tick
 + fmt-merge-msg: be quiet if nothing to merge

Hopefully will merge to 'master' by -rc0.

* pc/remove-warn (2010-03-26) 4 commits
 - Remove a redundant errno test in a usage of remove_path
 - Introduce remove_or_warn function
 - Implement the rmdir_or_warn function
 - Generalise the unlink_or_warn function

I cherry-picked only obviously sensible bits.  Soon in 'next'.

* ef/maint-empty-commit-log (2010-03-21) 1 commit
  (merged to 'next' on 2010-03-28 at aa103e5)
 + rev-list: fix --pretty=3Doneline with empty message

Hopefully will merge to 'master' by -rc0.

* em/checkout-orphan (2010-03-21) 1 commit
  (merged to 'next' on 2010-03-28 at 86b6a4f)
 + git checkout: create unparented branch by --orphan

Perhaps needs a bit of documentation updates, describing the "going ope=
n
source" scenario.

* mg/mailmap-update (2010-03-19) 1 commit
  (merged to 'next' on 2010-03-28 at 8ac3436)
 + .mailmap: Entries for Alex Benn=C3=A9e, Deskin Miller, Vitaly "_Vi" =
Shukela

Soon in 'master'.

* mg/maint-send-email-lazy-editor (2010-03-22) 1 commit
  (merged to 'next' on 2010-03-28 at 7e8e58e)
 + send-email: lazily assign editor variable

Soon in 'master'.

* mg/use-default-abbrev-length-in-rev-list (2010-03-22) 1 commit
  (merged to 'next' on 2010-03-28 at d3e9f04)
 + rev-list: use default abbrev length when abbrev-commit is in effect

Soon in 'master'.

* rb/maint-python-path (2010-03-21) 1 commit
  (merged to 'next' on 2010-03-28 at 58ba409)
 + Correct references to /usr/bin/python which does not exist on FreeBS=
D

Soon in 'master'.

* rr/imap-send-unconfuse-from-line (2010-03-22) 1 commit
  (merged to 'next' on 2010-03-28 at fbedd77)
 + imap-send: Remove limitation on message body

Soon in 'master'.

* sp/maint-http-backend-die-triggers-die-recursively (2010-03-22) 1 com=
mit
  (merged to 'next' on 2010-03-28 at bf02879)
 + http-backend: Don't infinite loop during die()

Soon in 'master'.

* ar/config-from-command-line (2010-03-26) 2 commits
 - Use strbufs instead of open-coded string manipulation
 - Allow passing of configuration parameters in the command line

May merge to 'next', but I would prefer waiting til 1.7.2 to have
this with a confidence than fast-tracking it.

* bc/t5505-fix (2010-03-19) 3 commits
  (merged to 'next' on 2010-03-28 at 1b097af)
 + t/t5505-remote.sh: escape * to prevent interpretation by shell as gl=
ob
 + t5505: add missing &&
 + t5505: remove unnecessary subshell invocations

Soon in 'master'.

* bw/template-tool-buildconfig (2010-03-20) 2 commits
  (merged to 'next' on 2010-03-28 at 1e6fd8d)
 + Modernize git calling conventions in hook templates
 + Make templates honour SHELL_PATH and PERL_PATH

Soon in 'master'.

* mb/rebase-i-no-ff (2010-03-24) 1 commit
  (merged to 'next' on 2010-03-28 at b2c54cb)
 + Teach rebase the --no-ff option.

Soon in 'master'.

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
 (this branch is used by cc/revert-strategy.)

Soon in 'master'.

* do/rebase-i-arbitrary (2010-03-14) 1 commit
  (merged to 'next' on 2010-03-28 at 5ba9970)
 + rebase--interactive: don't require what's rebased to be a branch

Soon in 'master'.

* ja/send-email-ehlo (2010-03-14) 3 commits
  (merged to 'next' on 2010-03-28 at 00964a8)
 + git-send-email.perl - try to give real name of the calling host to H=
ELO/EHLO
 + git-send-email.perl: add option --smtp-debug
 + git-send-email.perl: improve error message in send_message()

Soon in 'master'.

* ak/everyday-git (2009-10-21) 1 commit
  (merged to 'next' on 2010-03-28 at ae67548)
 + everyday: fsck and gc are not everyday operations

Soon in 'master'.

* bc/acl-test (2010-03-15) 5 commits
  (merged to 'next' on 2010-03-28 at b40fa09)
 + t/t1304: make a second colon optional in the mask ACL check
 + t/t1304: set the ACL effective rights mask
 + t/t1304: use 'test -r' to test readability rather than looking at mo=
de bits
 + t/t1304: set the Default ACL base entries
 + t/t1304: avoid -d option to setfacl

Soon in 'master'.

* bc/maint-daemon-sans-ss-family (2010-03-15) 1 commit
  (merged to 'next' on 2010-03-28 at 305ad0b)
 + daemon.c: avoid accessing ss_family member of struct sockaddr_storag=
e

Soon in 'master'.

* ef/cherry-abbrev (2010-03-20) 2 commits
  (merged to 'next' on 2010-03-28 at eb3825c)
 + ls: remove redundant logic
 + cherry: support --abbrev option

Soon in 'master'.

* gh/maint-stash-show-error-message (2010-03-16) 1 commit
  (merged to 'next' on 2010-03-28 at 61a5643)
 + Improve error messages from 'git stash show'

Soon in 'master'.

* rs/threaded-grep-context (2010-03-15) 1 commit
  (merged to 'next' on 2010-03-28 at 1934af1)
 + grep: enable threading for context line printing

Soon in 'master'.

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
