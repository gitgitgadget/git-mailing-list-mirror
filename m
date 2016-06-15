From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #06; Wed, 14)
Date: Wed, 14 Mar 2012 16:19:42 -0700
Message-ID: <7vwr6mn52p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 00:19:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7xU4-0003mI-AL
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 00:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972Ab2CNXTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 19:19:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737Ab2CNXTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 19:19:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD9C61EF;
	Wed, 14 Mar 2012 19:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=wGxmnplfnY7RJ4kO1yA+wn6eC
	bc=; b=W341kzqU/H5RrTVFnFo3fRUpK3HjOG43chonI/qblXXXQArth41v5E+/z
	npAxV5kKuiTid8yHYEkDzfs8ZzeJLON5wqJUELzPTIKCagmfvAkkUg6L+OxQRK8N
	nXrulfFmTcxgfyPBhoB/8lGaMRDAMI9YqCES20dfGsweSNXvkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=YDUgNljuHoTS+cvmi4p
	C46igKrrG33kbHc6nJatJDojsZ8WEf0TimYDpSkF1JnNBvUFI3Pljwm7Ue7k8GRS
	CDHUbfeT8o7dzsYDizAh0rHqR40rtp2lyiWEbZK+n3uS6UuePLeyQqPQ3Xzr2LhK
	rmHMst8fHNf0JmTAugsnuqN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5781961EE;
	Wed, 14 Mar 2012 19:19:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 824E561EA; Wed, 14 Mar 2012
 19:19:43 -0400 (EDT)
X-master-at: 0e2d57fd50f61e668be3180bc8f25991ea88aa8c
X-next-at: 38e1251a4abf75d6f2ce839f27cea2f57690fd15
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E7DB8B4-6E2C-11E1-9C81-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193169>

What's cooking in git.git (Mar 2012, #06; Wed, 14)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

As of tonight, the tip of master is 1.7.10-rc1 and I'll start ignoring =
new
feature patches out of blue and low impact fix patches that are not ver=
y
well cooked, expecting for them to be rerolled after 1.7.10 final.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* az/verify-tag-use-gpg-config (2012-03-08) 1 commit
  (merged to 'next' on 2012-03-09 at d9e556f)
 + verify-tag: Parse GPG configuration options.

"git tag -s" honored "gpg.program" configuration variable since
1.7.9, but "git tag -v" and "git verify-tag" didn't.

This is a fairly low impact fix.

* jc/i18n-shell-script-gettext (2012-03-12) 1 commit
  (merged to 'next' on 2012-03-12 at 1326b5e)
 + i18n: fix auto detection of gettext scheme for shell scripts

The auto detection was testing if a fixed string that is known to be
non-empty is empty by mistake.

* jc/maint-undefined-i18n-observation-test (2012-03-09) 1 commit
  (merged to 'next' on 2012-03-12 at 42aaabe)
 + t0204: clarify the "observe undefined behaviour" test

It was unclear what a test in t0204 wanted to check; it turns out
that it was only to observe an undefined behaviour of the system,
and did not anticipate one kind of reasonable error behaviour.

Replaces the tb/maint-remove-irrelevant-i18n-test topic.

* ms/maint-config-error-at-eol-linecount (2012-03-12) 1 commit
  (merged to 'next' on 2012-03-12 at ba17441)
 + config: report errors at the EOL with correct line number

When "git config" diagnoses an error in a configuration file and
shows the line number for the offending line, it miscounted if the
error was at the end of line.

* ph/rerere-doc (2012-03-08) 1 commit
  (merged to 'next' on 2012-03-12 at 2456f65)
 + rerere: Document 'rerere remaining'

--------------------------------------------------
[New Topics]

* jh/notes-merge-in-git-dir-worktree (2012-03-12) 2 commits
 - notes-merge: use opendir/readdir instead of using read_directory()
 - t3310: illustrate failure to "notes merge --commit" inside $GIT_DIR/

Running "notes merge --commit" failed to perform correctly when run
from any directory inside $GIT_DIR/.  When "notes merge" stops with
conflicts, $GIT_DIR/NOTES_MERGE_WORKTREE is the place a user edits
to resolve it.

Not urgent.

* jn/diffstat-tests (2012-03-13) 7 commits
 - diffstat summary line varies by locale: miscellany
 - test: use numstat instead of diffstat in binary-diff test
 - test: use --numstat instead of --stat in "git stash show" tests
 - test: test cherry-pick functionality and output separately
 - test: modernize funny-names test style
 - test: use numstat instead of diffstat in funny-names test
 - test: use test_i18ncmp when checking --stat output

Some tests checked the "diff --stat" output when they do not have to,
which unnecessarily made things harder to verify under GETTEXT_POISON.
Not urgent.

* th/doc-diff-submodule-option (2012-03-14) 1 commit
  (merged to 'next' on 2012-03-14 at 0e1d755)
 + Documentation/diff-options: reword description of --submodule option

Update "diff --submodule" documentation.
May want to ship with 1.7.10.

* th/git-diffall (2012-03-14) 5 commits
  (merged to 'next' on 2012-03-14 at 38e1251)
 + contrib/diffall: fix cleanup trap on Windows
 + contrib/diffall: eliminate duplicate while loops
 + contrib/diffall: eliminate use of tar
 + contrib/diffall: create tmp dirs without mktemp
 + contrib/diffall: comment actual reason for 'cdup'

Update sample "diffall" script.
May want to ship with 1.7.10.

* tr/maint-word-diff-regex-sticky (2012-03-14) 3 commits
 - diff: tweak a _copy_ of diff_options with word-diff
 - diff: refactor the word-diff setup from builtin_diff_cmd
 - t4034: diff.*.wordregex should not be "sticky" in --word-diff

The regexp configured with wordregex was incorrectly reused across
files.
Not urgent.

* zj/test-cred-helper-nicer-prove (2012-03-14) 3 commits
 - t0303: resurrect commit message as test documentation
 - fixup?
 - t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER

Minor improvement to t0303.
Not urgent.

--------------------------------------------------
[Stalled]

* ab/perl-i18n (2012-03-10) 3 commits
 - fixup! de1e4ae
 - perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
 - Git::I18N: compatibility with perl <5.8.3

Attempts to help installations with ancient Perl and/or without
MakeMaker.  Didn't quite work for me, so I tried to queue a fix-up
commit, but an independent confirmation report is needed before it
is squashed into =C3=86var's patches.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts, but it appears that the
approach needs to be rethought.  By repointing TEST_DIRECTORY to a
directory other than $(pwd)/.., an out of place test script can reach
test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
a mere short-hand for $TEST_DIRECTORY/..).

* cn/apply-fix-ws-can-lengthen-lines (2012-03-11) 1 commit
 . apply: reallocate the postimage buffer when needed

Attempts to address an ancient bug that dates back to the addition
of an oddball "tab-in-indent" whitespace breakage class that wants
to have longer lines than the original when fixing things up.

Needs more work; results in double-frees.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so
that somebody new can try to dip his or her toes in the development.

A rework is being attempted by Christopher Tiwald.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments
from =C3=86var. The second one needs more work, both in perl/Git.pm and
prompt.c, to give precedence to tty over SSH_ASKPASS when terminal
is available.

* jc/split-blob (2012-02-23) 7 commits
 - fixup?
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

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

* nd/columns (2012-03-13) 12 commits
 - column: support grouping entries
 - column: support "denser" mode
 - ls-files: support --column
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column

Rerolled again.  Modulo minor nits, looked nicer than the previous roun=
d.

* nd/optim-connected (2012-03-14) 1 commit
 - {fetch,receive}-pack: skip sha-1 integrity test on objects from new =
pack

Optimizes the local connectivity check performed by "git fetch" and "gi=
t
receive-pack" that is run in response to "git push".

* jc/commit-hook-authorship (2012-03-11) 3 commits
  (merged to 'next' on 2012-03-12 at 05ca7f8)
 + commit: pass author/committer info to hooks
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/run-hook-env-1.)

"git commit --author=3D$name" did not tell the name that was being
recorded in the resulting commit to hooks, even though it does do so
when the end user overrode the authorship via the "GIT_AUTHOR_NAME"
environment variable.  This is a simpler of the two approaches.

Will defer til 1.7.10.

* jc/run-hook-env-1 (2012-03-11) 4 commits
 . commit: pass author/committer info to hooks
 - run_hook(): enhance the interface to pass arbitrary environment
 + t7503: does pre-commit-hook learn authorship?
 + ident.c: add split_ident_line() to parse formatted ident line
 (this branch is tangled with jc/commit-hook-authorship.)

Addresses the same issue as jc/commit-hook-authorship, sharing the firs=
t
two changes with the previous one, but uses a more complex approach, wh=
ich
may not be worth the complexity.  The third patch is a prerequiste for =
the
fourth one (not used), but is independently useful.

* jn/maint-fast-import-empty-ls (2012-03-09) 2 commits
 - fast-import: don't allow 'ls' of path with empty components
 - fast-import: leakfix for 'ls' of dirty trees

fast-import did not diagnose "ls ''" that asks an empty path
as an error.

* jc/diff-algo-cleanup (2012-02-19) 2 commits
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros
 (this branch is used by jc/diff-ignore-case.)

Resurrects the preparatory clean-up patches from another topic
that was discarded.

* jh/apply-free-patch (2012-03-07) 1 commit
 - apply: do not leak patches and fragments

Will defer til 1.7.10.

* rs/unpack-trees-leakfix (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 69a69cd)
 + unpack-trees: plug minor memory leak

Will defer til 1.7.10.

* tb/maint-remove-irrelevant-i18n-test (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 23f2dd1)
 + t0204: remove a test that checks undefined behaviour

I tentatively parked this in 'next' but later reverted the merge.
Will discard.

* mm/push-default-switch-warning (2012-03-09) 1 commit
 - push: start warning upcoming default change for push.default

This resurrects an ancient patch I wrote during a discussion we had
in the 1.6.3-1.6.4 era.  It also conflicts with the long-stalled
jc/advise-push-default topic and for a good reason---they address a
similar issue.  The latter is a lower impact patch that uses a more
focused approach to limit the scope to the target audience that
actually needs help.

* sl/customize-sane-tool-path (2012-03-09) 1 commit
 - configure: allow user to prevent $PATH "sanitization" on Solaris

Would be nice to hear from people who actually use autoconf, either
on Solaris or other platforms.

* jc/fmt-merge-msg-people (2012-03-13) 1 commit
 - fmt-merge-msg: show those involved in a merged series

Rerolled.

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

Will defer til 1.7.10.

* nl/http-proxy-more (2012-03-14) 5 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not se=
t

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

Will defer til 1.7.10.

* nd/stream-more (2012-03-07) 7 commits
  (merged to 'next' on 2012-03-07 at 7325922)
 + update-server-info: respect core.bigfilethreshold
 + fsck: use streaming API for writing lost-found blobs
 + show: use streaming API for showing blobs
 + parse_object: avoid putting whole blob in core
 + cat-file: use streaming API to print blobs
 + Add more large blob test cases
 + streaming: make streaming-write-entry to be more reusable

Use API to read blob data in smaller chunks in more places to
reduce the memory footprint.  In general, looked fairly good.

Will defer til 1.7.10.

* nd/threaded-index-pack (2012-03-11) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Another reroll after a bugreport on pthread usage discovered by
Ramsey.

--------------------------------------------------
[Discarded]

* jc/diff-ignore-mode (2012-03-01) 1 commit
 . diff --ignore-mode-change

 * jc/diff-ignore-case (2012-02-28) 6 commits
 . diff: -i is "--ignore-case" but means a bit more in "log"
 . diff: --ignore-case
 . xdiff: introduce XDF_IGNORE_CASE
 . xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

* jh/trace-use-startup-info (2012-03-02) 1 commit
 . Use startup_info->prefix rather than prefix.

I tend to agree with the doubt of the author of this patch expressed.
