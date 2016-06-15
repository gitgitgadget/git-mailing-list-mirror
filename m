From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #04; Fri, 9)
Date: Fri, 09 Mar 2012 17:35:46 -0800
Message-ID: <7vboo52q6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 02:36:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6BER-0007GY-P6
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 02:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab2CJBfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 20:35:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab2CJBfu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 20:35:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2686468D7;
	Fri,  9 Mar 2012 20:35:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=HAJ7YLpndjtMwbnLLjA1PjAvh
	eQ=; b=mmAmM6WfkuIHIPQiuoiVU+qpOULHByUvtMxQts2tHTLKU70Y1XYLMduSZ
	gAtKuA0HLuwGFT4MW+9Vff84mhBAA1LsljJqadvov7VllwG8lE844DqNLIDzTexF
	sASqGSvBgVGSMqI/2nUaklOxBSvJpVYUzDGBCY4/+S9p0DikRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=B1Bh2P0Uea0EHIxxA3w
	LIGoJY0cu+moRAKZ/TnRxR5OYb3nKmZ+GvBogiOAzHx77mRnxBQq9Cn/mpuSTRZD
	iKh4eR0qkjgvVmf7Z8YlW7Ci0EgfKahH+BX33rcCP5KKI+0Hvsm/o1dmuffCR18Y
	8tSlAaTlgIj+z/cZp0Mx4z0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E6EF68D6;
	Fri,  9 Mar 2012 20:35:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 002D868D0; Fri,  9 Mar 2012
 20:35:47 -0500 (EST)
X-master-at: 745950ce0e7e984158a00cd52c5811918d1f3495
X-next-at: d9e556f99f2727d7117df36b37a2b6c7907f9d2f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CD3E79E-6A51-11E1-AB97-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192762>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

Trivially correct fixes to old bugs may still graduate to 'master',
but otherwise we are mostly in "regression fixes only" mode until
1.7.10 final (see http://tinyurl.com/gitCal for schedule).

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* rs/unpack-trees-leakfix (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 69a69cd)
 + unpack-trees: plug minor memory leak

* jh/apply-free-patch (2012-03-07) 1 commit
 - apply: do not leak patches and fragments

* az/verify-tag-use-gpg-config (2012-03-08) 1 commit
  (merged to 'next' on 2012-03-09 at d9e556f)
 + verify-tag: Parse GPG configuration options.

"git tag -s" honored "gpg.program" configuration variable since
1.7.9, but "git tag -v" and "git verify-tag" didn't.

This is a fairly low impact fix, and we may want to have it in
1.7.10.

* tb/maint-remove-irrelevant-i18n-test (2012-03-06) 1 commit
  (merged to 'next' on 2012-03-07 at 23f2dd1)
 + t0204: remove a test that checks undefined behaviour

I tentatively parked this in 'next' but later reverted the merge.

* jc/maint-undefined-i18n-observation-test (2012-03-09) 1 commit
 - t0204: clarify the "observe undefined behaviour" test

It was unclear what a test in t0204 wanted to check; it turns out
that it was only to observe an undefined behaviour of the system,
and did not anticipate one kind of reasonable error behaviour.

Replaces the tb/maint-remove-irrelevant-i18n-test topic.

* mm/push-default-switch-warning (2012-03-09) 1 commit
 - push: start warning upcoming default change for push.default

This resurrects an ancient patch I wrote during a discussion we had
in the 1.6.3-1.6.4 era.  It also conflicts with the long-stalled
jc/advise-push-default topic and for a good reason.  The latter is a
lower impact patch that uses a more focused approach to limit the
scope to the target audience that actually needs help.

* ph/rerere-doc (2012-03-08) 1 commit
 - rerere: Document 'rerere remaining'

* sl/customize-sane-tool-path (2012-03-09) 1 commit
 - configure: allow user to prevent $PATH "sanitization" on Solaris

Would be nice to hear from people who actually use autoconf, either
on Solaris or other platforms.

--------------------------------------------------
[Graduated to "master"]

* cn/pull-rebase-message (2012-03-04) 1 commit
  (merged to 'next' on 2012-03-04 at 5a6cd58)
 + Make git-{pull,rebase} message without tracking information friendli=
er

The advise message given when the user didn't give enough clue on what
to merge was overly long.

* jc/maint-diff-patch-header (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at 2cd2059)
 + diff -p: squelch "diff --git" header for stat-dirty paths
 + t4011: illustrate "diff-index -p" on stat-dirty paths
 + t4011: modernise style
 (this branch is used by jc/diff-ignore-mode.)

"diff-index" and friends showed "diff --git" header and nothing else
for a path that is only stat-dirty.

* jc/pickaxe-ignore-case (2012-03-04) 3 commits
  (merged to 'next' on 2012-03-04 at 1ad3a39)
 + ctype.c: Fix a sparse warning
  (merged to 'next' on 2012-03-02 at 73a632b)
 + pickaxe: allow -i to search in patch case-insensitively
 + grep: use static trans-case table

"git log -G/-S" pays attention to the "-i" option.

* jh/threadable-symlink-check (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-05 at fdd667c)
 + Add threaded versions of functions in symlinks.c.

It probably is "threadble" not "threaded" but in any case this
should not regress the current callers.

* jl/maint-submodule-relative (2012-03-04) 4 commits
  (merged to 'next' on 2012-03-07 at e020e5c)
 + submodules: fix ambiguous absolute paths under Windows
 + submodules: refactor computation of relative gitdir path
 + submodules: always use a relative path from gitdir to work tree
 + submodules: always use a relative path to gitdir

The whole directory that houses a top-level superproject managed by
"git submodule" can be moved to another place.

* jn/maint-do-not-match-with-unsanitized-searchtext (2012-03-06) 1 comm=
it
  (merged to 'next' on 2012-03-06 at 768ce21)
 + gitweb: Fix fixed string (non-regexp) project search

"gitweb" did use quotemeta() to prepare search string when asked to
do a fixed-string project search, but did not use it by mistake and
used the user-supplied string instead.

* kb/maint-prune-rmdir-closedir (2012-03-07) 1 commit
  (merged to 'next' on 2012-03-07 at 2438c9a)
 + fix deletion of .git/objects sub-directories in git-prune/repack

Call closedir() that iterates over a directory before rmdir() it.

* nl/http-proxy-auth (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at f368669)
 + http: support proxies that require authentication
 (this branch is used by nl/http-proxy-more.)

Allow curl-based transport to use proxies that require authentication.

* sl/modern-t0000 (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at 2cd1508)
 + t0000: modernise style

* th/mergetools-deltawalker (2012-03-05) 1 commit
  (merged to 'next' on 2012-03-05 at 167c74f)
 + mergetools: add a plug-in to support DeltaWalker

Add plug-in to support DeltaWalker in difftool/mergetool. =20

* tr/maint-bundle-boundary (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at c25692f)
 + bundle: keep around names passed to add_pending_object()
 + t5510: ensure we stay in the toplevel test dir
 + t5510: refactor bundle->pack conversion

"git bundle" did not record boundary commits correctly when there
are many of them.

* vr/branch-doc (2012-03-06) 3 commits
  (merged to 'next' on 2012-03-06 at 6be3587)
 + Documentation/git-branch: add default for --contains
 + Documentation/git-branch: fix a typo
 + Documentation/git-branch: cleanups

Documentation update.

* zj/diff-stat-dyncol (2012-03-01) 10 commits
  (merged to 'next' on 2012-03-01 at 79b4152)
 + diff --stat: add config option to limit graph width
 + diff --stat: enable limiting of the graph part
 + diff --stat: add a test for output with COLUMNS=3D40
 + diff --stat: use a maximum of 5/8 for the filename part
 + merge --stat: use the full terminal width
 + log --stat: use the full terminal width
 + show --stat: use the full terminal width
 + diff --stat: use the full terminal width
 + diff --stat: tests for long filenames and big change counts
 + Merge branches zj/decimal-width, zj/term-columns and jc/diff-stat-sc=
aler

Rerolled again and looking good.

--------------------------------------------------
[Stalled]

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts, but it appears that the
approach needs to be rethought.  By repointing TEST_DIRECTORY to a
directory other than $(pwd)/.., an out of place test script can reach
test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
a mere short-hand for $TEST_DIRECTORY/..).

* nd/optim-connected (2012-02-29) 1 commit
 - Perform cheaper connectivity check when pack is used as medium

Cheats the local connectivity check performed by "git fetch"
slightly to gain some performance. This is a bit iffy.

* nd/columns (2012-02-28) 10 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add column.ui for default column output settings
 - column: add dense layout support
 - column: add columnar layout
 - Stop starting pager recursively
 - Add git-column for columnar display

Rerolled; the configuration handling looked iffy, but otherwise well
explained.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so
that somebody new can try to dip his or her toes in the development.
Any takers?

* jh/trace-use-startup-info (2012-03-02) 1 commit
 - Use startup_info->prefix rather than prefix.

I tend to agree with the doubt of the author of this patch expressed.

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

* jc/fmt-merge-msg-people (2012-03-08) 3 commits
  (merged to 'next' on 2012-03-08 at be31aa9)
 + fmt-merge-msg.c: make util_as_int() return "int"
  (merged to 'next' on 2012-03-07 at 76fbac3)
 + fmt-merge-msg: finishing touches
  (merged to 'next' on 2012-03-05 at 38de349)
 + fmt-merge-msg: show those involved in a merged series

The "fmt-merge-msg" command learns to list the primary contributors
involved in the side topic you are merging.

Judging by the rate of "oops, this is better" fix-ups, it was good
that I decided to postpone this topic til the next cycle ;-)

* nl/http-proxy-more (2012-03-05) 3 commits
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not se=
t

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.  It seems the
re-rolling has stalled since the last review?

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
reduce the memory footprint.

* nd/threaded-index-pack (2012-03-02) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Rerolled to fix a bug that was discovered with a trivial test, and
resurrected from Stalled category, but I am reluctant to advance a
topic that can easily break many people's repositories at this late
in the cycle.

What is queued here is a couple of review cycles old; will discard
and replace with a re-roll when it comes.

--------------------------------------------------
[Discarded]

* jc/diff-ignore-case (2012-02-28) 6 commits
 . diff: -i is "--ignore-case" but means a bit more in "log"
 . diff: --ignore-case
 . xdiff: introduce XDF_IGNORE_CASE
 . xdiff: introduce XDF_INEXACT_MATCH
 . xdiff: PATIENCE/HISTOGRAM are not independent option bits
 . xdiff: remove XDL_PATCH_* macros

* jc/diff-ignore-mode (2012-03-01) 1 commit
 . diff --ignore-mode-change
