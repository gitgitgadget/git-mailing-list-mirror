From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2013, #10; Tue, 26)
Date: Tue, 26 Feb 2013 14:16:53 -0800
Message-ID: <7vfw0ilnze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 23:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UASpw-0007KL-8O
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 23:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab3BZWQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 17:16:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3BZWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 17:16:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F7C2BA56;
	Tue, 26 Feb 2013 17:16:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	2YP8VvQ1XoVxP2KHxzJYr0AQWs=; b=KC7mwr5RNdMZ/ZgABWDC2+gy5QItFSGgh
	S9bVlYD1qLIx9V9vdMcIZRDCiFi7PwNiiebfXzNcI8OZF94ue8dv/md2gPE59Pyd
	A6L9bb0RS3Lb0pOo4LpQ1BjIQWRVhEJQiR0VVH+vLOSJ7+80Px6a5eGf9HbysE+Y
	D+JoaxSa/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YtP
	RJrAhaqK02T89sdnNh2xgLGFHSo9qKkIkCi6PNTlA3MHBX61jLWdTqddOeUR1GaE
	3YRkUAySaWj6VTzxaKl7p11tcGc38L1V3Sjleqoe8gzHNjGkvuky0ne4A8K0anji
	mhZEHovtxQvVo939Fm+oNZE/lV0Ps2GZhzX/84rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8400DBA55;
	Tue, 26 Feb 2013 17:16:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50FAFBA54; Tue, 26 Feb 2013
 17:16:55 -0500 (EST)
X-master-at: 27db5a02c73b35fe6b004fca66a824e022cc3c01
X-next-at: 93ec2c9877fe8e1f0d976afee36dc5e927fa4650
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AA2297E-8062-11E2-A2B7-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217187>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the 'master' is a bit past 1.8.2-rc1.  I am hoping to do
an -rc2 by the end of this week.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* as/check-ignore (2013-02-19) 2 commits
  (merged to 'next' on 2013-02-21 at 27927a2)
 + name-hash: allow hashing an empty string
 + t0008: document test_expect_success_multi

 "git check-ignore ." segfaulted, as a function it calls deep in its
 callchain took a string in the <ptr, length> form but did not stop
 when given an empty string.


* ct/autoconf-htmldir (2013-02-19) 1 commit
  (merged to 'next' on 2013-02-21 at 44f127d)
 + Bugfix: undefined htmldir in config.mak.autogen

 An earlier change to config.mak.autogen broke a build driven by the
 ./configure script when --htmldir is not specified on the command
 line of ./configure.


* jn/less-reconfigure (2013-02-20) 1 commit
  (merged to 'next' on 2013-02-21 at 811e0c0)
 + Makefile: avoid infinite loop on configure.ac change

 A change made on v1.8.1.x maintenance track had a nasty regression
 to break the build when autoconf is used.


* wk/man-deny-current-branch-is-default-these-days (2013-02-18) 1 commit
  (merged to 'next' on 2013-02-21 at e67b15b)
 + user-manual: typofix (ofthe->of the)


* wk/user-manual (2013-02-19) 3 commits
  (merged to 'next' on 2013-02-19 at dbc0eb2)
 + user-manual: Flesh out uncommitted changes and submodule updates
 + user-manual: Use request-pull to generate "please pull" text
 + user-manual: Reorganize the reroll sections, adding 'git rebase -i'

 Further updates to the user manual.

--------------------------------------------------
[New Topics]

* jc/perl-cat-blob (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at 7c0079a)
 + Git.pm: fix cat_blob crashes on large files

 perl/Git.pm::cat_blob slurped everything in core only to write it
 out to a file descriptor, which was not a very smart thing to do.

 Will cook in 'next'.


* nd/doc-index-format (2013-02-23) 3 commits
  (merged to 'next' on 2013-02-26 at 4d3caea)
 + update-index: list supported idx versions and their features
 + read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
 + index-format.txt: mention of v4 is missing in some places

 Update the index format documentation to mention the v4 format.

 Will cook in 'next'.


* ap/maint-diff-rename-avoid-overlap (2013-02-26) 2 commits
  (merged to 'next' on 2013-02-26 at 19d70bf)
 + diff: prevent pprint_rename from underrunning input
  (merged to 'next' on 2013-02-25 at c9bd6d3)
 + diff: Fix rename pretty-print when suffix and prefix overlap

 The logic used by "git diff -M --stat" to shorten the names of
 files before and after a rename did not work correctly when the
 common prefix and suffix between the two filenames overlapped.

 Will cook in 'next'.


* ap/maint-update-index-h-is-for-help (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at f5f767c)
 + update-index: allow "-h" to also display options

 Will cook in 'next'.


* jc/color-diff-doc (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at c37541c)
 + diff-options: unconfuse description of --color

 Will cook in 'next'.


* nd/branch-error-cases (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 1d0289f)
 + branch: segfault fixes and validation

 "git branch" had more cases where it did not bother to check
 nonsense command line parameters.

 Will cook in 'next'.


* rt/commit-cleanup-config (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 8249b61)
 + t7502: perform commits using alternate editor in a subshell

 Fix tests that contaminated their environments and affected new
 tests introduced later in the sequence by containing their effects
 in their own subshells.

 Will cook in 'next'.


* wk/doc-pre-rebase (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-25 at a6ec310)
 + Documentation/githooks: Explain pre-rebase parameters

 Will cook in 'next'.


* da/downcase-u-in-usage (2013-02-24) 20 commits
  (merged to 'next' on 2013-02-26 at 977b67e)
 + contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" string
 + contrib/examples/git-remote.perl: use a lowercase "usage:" string
 + tests: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + Documentation/user-manual.txt: use a lowercase "usage:" string
 + templates/hooks--update.sample: use a lowercase "usage:" string
 + contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
 + contrib/examples: use a lowercase "usage:" string
 + contrib/fast-import/import-zips.py: use spaces instead of tabs
 + contrib/fast-import/import-zips.py: fix broken error message
 + contrib/fast-import: use a lowercase "usage:" string
 + contrib/credential: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsexportcommit: use a lowercase "usage:" string
 + git-archimport: use a lowercase "usage:" string
 + git-merge-one-file: use a lowercase "usage:" string
 + git-relink: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + git-sh-setup: use a lowercase "usage:" string

 Will cook in 'next'.


* dm/ni-maxhost-may-be-missing (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at 93ec2c9)
 + git-compat-util.h: Provide missing netdb.h definitions

 Will cook in 'next'.


* gp/avoid-explicit-mention-of-dot-git-refs (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at ec42d98)
 + Fix ".git/refs" stragglers

 Will cook in 'next'.


* gp/describe-match-uses-glob-pattern (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at c9cc789)
 + describe: Document --match pattern format
 (this branch is used by gp/forbid-describe-all-match.)

 Will cook in 'next'.


* gp/forbid-describe-all-match (2013-02-24) 1 commit
 - describe: make --all and --match=PATTERN mutually incompatible
 (this branch uses gp/describe-match-uses-glob-pattern.)

 Not sure if we should forbid the combination or explain the
 semantics better, perhaps by giving a better synonym to "--all",
 which meant "disable the usual limit that only gives the annotated
 tags".


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
 - Makefile: make mandir, htmldir and infodir absolute

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.


* jk/suppress-clang-warning (2013-02-25) 1 commit
 - fix clang -Wtautological-compare with unsigned enum


* mg/qnx6 (2013-02-25) 1 commit
 - QNX: newer QNX 6.x.x is not so crippled

 Still under discussion.
 Not ready for inclusion.


* mg/unsigned-time-t (2013-02-25) 2 commits
 - Fix time offset calculation in case of unsigned time_t
 - date.c: fix unsigned time_t comparison

 A few workarounds for systems with unsigned time_t.


* rj/msvc-build (2013-02-25) 5 commits
  (merged to 'next' on 2013-02-26 at 7493068)
 + msvc: avoid collisions between "tags" and "TAGS"
 + msvc: test-svn-fe: Fix linker "unresolved external" error
 + msvc: Fix build by adding missing symbol defines
 + msvc: git-daemon: Fix linker "unresolved external" errors
 + msvc: Fix compilation errors caused by poll.h emulation

 Will cook in 'next'.


* wk/user-manual-literal-format (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at d59ce38)
 + user-manual: Standardize backtick quoting

 Will cook in 'next'.


* jk/utf-8-can-be-spelled-differently (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at c079525)
 + utf8: accept alternate spellings of UTF-8

 Will cook in 'next'.

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

* jk/pkt-line-cleanup (2013-02-24) 19 commits
  (merged to 'next' on 2013-02-25 at d83e970)
 + remote-curl: always parse incoming refs
 + remote-curl: move ref-parsing code up in file
 + remote-curl: pass buffer straight to get_remote_heads
 + teach get_remote_heads to read from a memory buffer
 + pkt-line: share buffer/descriptor reading implementation
 + pkt-line: provide a LARGE_PACKET_MAX static buffer
 + pkt-line: move LARGE_PACKET_MAX definition from sideband
 + pkt-line: teach packet_read_line to chomp newlines
 + pkt-line: provide a generic reading function with options
 + pkt-line: drop safe_write function
 + pkt-line: move a misplaced comment
 + write_or_die: raise SIGPIPE when we get EPIPE
 + upload-archive: use argv_array to store client arguments
 + upload-archive: do not copy repo name
 + send-pack: prefer prefixcmp over memcmp in receive_status
 + fetch-pack: fix out-of-bounds buffer offset in get_ack
 + upload-pack: remove packet debugging harness
 + upload-pack: do not add duplicate objects to shallow list
 + upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make
 them more robust.

 Will cook in 'next'.


* ob/imap-send-ssl-verify (2013-02-20) 1 commit
  (merged to 'next' on 2013-02-25 at e897609)
 + imap-send: support Server Name Indication (RFC4366)

 Correctly connect to SSL/TLS sites that serve multiple hostnames on
 a single IP by including Server Name Indication in the client-hello.

 Will cook in 'next'.


* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* mh/maint-ceil-absolute (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-26 at ba83c45)
 + Provide a mechanism to turn off symlink resolution in ceiling paths

 An earlier workaround designed to help people who list logical
 directories that will not match what getcwd(3) returns in the
 GIT_CEILING_DIRECTORIES had an adverse effect when it is slow to
 stat and readlink a directory component of an element listed on it.

 Will fast-track to 'master' (regression fix).


* tk/doc-filter-branch (2013-02-26) 2 commits
  (merged to 'next' on 2013-02-26 at bd4638b)
 + Documentation: filter-branch env-filter example
 + git-filter-branch.txt: clarify ident variables usage

 Will cook in 'next'.


* bc/commit-complete-lines-given-via-m-option (2013-02-19) 4 commits
  (merged to 'next' on 2013-02-19 at cf622b7)
 + Documentation/git-commit.txt: rework the --cleanup section
 + git-commit: only append a newline to -m mesg if necessary
 + t7502: demonstrate breakage with a commit message with trailing newlines
 + t/t7502: compare entire commit message with what was expected

 'git commit -m "$str"' when $str was already terminated with a LF
 now avoids adding an extra LF to the message.

 Will cook in 'next'.


* da/difftool-fixes (2013-02-21) 4 commits
  (merged to 'next' on 2013-02-25 at 687db1f)
 + t7800: "defaults" is no longer a builtin tool name
 + t7800: modernize tests
 + t7800: update copyright notice
 + difftool: silence uninitialized variable warning

 Minor maintenance updates to difftool, and updates to its tests.

 Will cook in 'next'.


* nd/read-directory-recursive-optim (2013-02-17) 1 commit
  (merged to 'next' on 2013-02-17 at 36ba9f4)
 + read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.

 Will cook in 'next'.


* mg/gpg-interface-using-status (2013-02-14) 5 commits
  (merged to 'next' on 2013-02-26 at 93f0e72)
 + pretty: make %GK output the signing key for signed commits
 + pretty: parse the gpg status lines rather than the output
 + gpg_interface: allow to request status return
 + log-tree: rely upon the check in the gpg_interface
 + gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.

 Will cook in 'next'.


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
  (merged to 'next' on 2013-02-17 at b2af923)
 + count-objects: report how much disk space taken by garbage files
 + count-objects: report garbage files in pack directory too
 + sha1_file: reorder code in prepare_packed_git_one()
 + git-count-objects.txt: describe each line in -v output

 Will cook in 'next'.


* tz/credential-authinfo (2013-02-25) 1 commit
 - Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Will merge to and cook in 'next'.


* jl/submodule-deinit (2013-02-17) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Expecting a reroll.
 $gmane/216498


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

 Will cook in 'next' until Git 2.0.


* bc/append-signed-off-by (2013-02-23) 13 commits
  (merged to 'next' on 2013-02-25 at 32f7ac2)
 + git-commit: populate the edit buffer with 2 blank lines before s-o-b
 + Unify appending signoff in format-patch, commit and sequencer
 + format-patch: update append_signoff prototype
 + t4014: more tests about appending s-o-b lines
 + sequencer.c: teach append_signoff to avoid adding a duplicate newline
 + sequencer.c: teach append_signoff how to detect duplicate s-o-b
 + sequencer.c: always separate "(cherry picked from" from commit body
 + sequencer.c: require a conforming footer to be preceded by a blank line
 + sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 + t/t3511: add some tests of 'cherry-pick -s' functionality
 + t/test-lib-functions.sh: allow to specify the tag name to test_commit
 + commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 + sequencer.c: rework search for start of footer to improve clarity

 Will cook in 'next'.
