From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Sun, 04 Mar 2012 23:55:07 -0800
Message-ID: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 08:55:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4SlO-00020e-IG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 08:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330Ab2CEHzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 02:55:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325Ab2CEHzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 02:55:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE8B51A5;
	Mon,  5 Mar 2012 02:55:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=zI86TYPkjJwPBUvwJR9gLC6o2
	5I=; b=yfO21Oe56pcaa3VcAMKoPKv21HGPUaKqh3AzJUDVV6PKL3D9GR04RiUrq
	duXUhdZgt/KNisfxOmJGPPdl3xdScaaODZ+s2GYPVeKsSleXAgQ7pZRf3WtzdVCe
	MIMdEtJbVQitEokEvOKrZ/UeUk/AgPCCNe6d16p1dQWuJeHk5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Id7hThjpW6nl8R/9mUM
	ZHrR4UDXlvoGlD+AOdQZffbe7dZhUjLTrtDsIkS8m1zFD6Rbxdc+2fboNPr5nv2n
	sp22gVGIZabZh1buIu7QoAlPFqHlK4FUBDJ3cckByyKZrpxfOgg/NRLAU1Xo4znD
	do2hNc8ZQPoA3mj2eEHOaF5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FFB951A4;
	Mon,  5 Mar 2012 02:55:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F14A51A0; Mon,  5 Mar 2012
 02:55:08 -0500 (EST)
X-master-at: 4a92a1721483d6a109cf0993843b20159f8d3387
X-next-at: 2cd1508a8dbb08e076d7fa1a12757da6a0d65d53
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 872AE8C4-6698-11E1-BF6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192212>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of 'next' as of tonight is more or less how 1.7.10-rc0 will
look like in a few days.  I do not have enough confidence on other
large-ish topics that are not yet in 'next'.

Small, trivially correct topics that have high value/damage ratio
however may have enough time to go in 1.7.10 final even if they are
still in 'pu', if the owners put enough effort in them.  Otherwise
let's throw the rest into Stalled category and leave them to the
next cycle.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* cn/pull-rebase-message (2012-03-04) 1 commit
  (merged to 'next' on 2012-03-04 at 5a6cd58)
 + Make git-{pull,rebase} message without tracking information friendli=
er

The advise message given when the user didn't give enough clue on what
to merge was overly long.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts.

* jh/threadable-symlink-check (2012-03-02) 1 commit
 - Add threaded versions of functions in symlinks.c.

This does not look wrong, but is not urgent either.

* jh/trace-use-startup-info (2012-03-02) 1 commit
 - Use startup_info->prefix rather than prefix.

I tend to agree with the doubt of the author of this patch expressed.

* jn/maint-do-not-match-with-unsanitized-searchtext (2012-03-04) 1 comm=
it
 - gitweb: Fix fixed string (non-regexp) project search

"gitweb" did use quotemeta() to prepare search string when asked to
do a fixed-string project search, but did not use it by mistake and
used the user-supplied string instead.

I would love to see this in 1.7.10; what I queued for 'maint' (that
does not have the lazy fill-info stuff), and my conflict resolution
into 'pu' to adjust for lazy fill-info, are both correct, I think,
but please double check.

* nl/http-proxy-auth (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at f368669)
 + http: support proxies that require authentication

Allow curl-based transport to use proxies that require authentication.

* sl/modern-t0000 (2012-03-02) 1 commit
  (merged to 'next' on 2012-03-04 at 2cd1508)
 + t0000: modernise style

* th/mergetools-deltawalker (2012-03-04) 1 commit
 - mergetools: add a plug-in to support DeltaWalker

Add plug-in to support DeltaWalker in difftool/mergetool. =20

Waiting for a few details to be filled in.

--------------------------------------------------
[Graduated to "master"]

* cb/fsck-squelch-dangling (2012-02-28) 1 commit
  (merged to 'next' on 2012-02-29 at 9057e12)
 + fsck: --no-dangling omits "dangling object" information

"fsck" learns "--no-dangling".

* jc/am-3-nonstandard-popt (2012-02-26) 2 commits
  (merged to 'next' on 2012-02-26 at 62a6ddf)
 + test: "am -3" can accept non-standard -p<num>
  (merged to 'next' on 2012-02-26 at 1363bd6)
 + am -3: allow nonstandard -p<num> option

The code to synthesize the fake ancestor tree used by 3-way merge
fallback in "git am" was not prepared to read a patch created with a
non-standard -p<num> value.

* jk/symbolic-ref-short (2012-02-27) 1 commit
  (merged to 'next' on 2012-02-28 at d00f766)
 + symbolic-ref --short: abbreviate the output unambiguously

"git symbolic-ref" learned the "--short" option to abbreviate the
refname it shows unambiguously.

* jn/gitweb-hilite-regions (2012-02-26) 4 commits
  (merged to 'next' on 2012-02-28 at 3244f30)
 + gitweb: Highlight matched part of shortened project description
 + gitweb: Highlight matched part of project description when searching=
 projects
 + gitweb: Highlight matched part of project name when searching projec=
ts
 + gitweb: Introduce esc_html_match_hl and esc_html_hl_regions

Project search in "gitweb" shows the substring that matched in the
project name and description highlighted. The highlighting logic is
meant to be reused later for other kinds of searches e.g. grep and
commit log search.

* rs/no-no-no-parseopt (2012-02-28) 3 commits
  (merged to 'next' on 2012-02-29 at 94e60d0)
 + parse-options: remove PARSE_OPT_NEGHELP
 + parse-options: allow positivation of options starting, with no-
 + test-parse-options: convert to OPT_BOOL()

Options that use PARSE_OPT_NEGHELP needed to word their help text in
a strange way, and this gets rid of the uses of them.

* th/git-diffall (2012-02-27) 1 commit
  (merged to 'next' on 2012-02-28 at 4ba7a15)
 + contrib: add git-diffall script

A sample script that drives an external tool that compares two
directories, by populating two temporary directories with contents
of two revisions in Git.

--------------------------------------------------
[Stalled]

* nd/optim-connected (2012-02-29) 1 commit
 - Perform cheaper connectivity check when pack is used as medium

Cheats the local connectivity check performed by "git fetch"
slightly to gain some performance. This is a bit iffy.

* jc/diff-ignore-mode (2012-03-01) 1 commit
 - diff --ignore-mode-change
 (this branch uses jc/maint-diff-patch-header.)

Will discard.

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

* jc/diff-ignore-case (2012-02-28) 6 commits
 - diff: -i is "--ignore-case" but means a bit more in "log"
 - diff: --ignore-case
 - xdiff: introduce XDF_IGNORE_CASE
 - xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

"git diff" learns "--ignore-case" option.
Will discard, as nobody seems to need this.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so
that somebody new can try to dip his or her toes in the
development. Any takers?

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

* jl/maint-submodule-relative (2012-03-04) 4 commits
 - submodules: fix ambiguous absolute paths under Windows
 - submodules: refactor computation of relative gitdir path
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

Rerolled and resurrected from Stalled category.

I would love to have this in 1.7.10; a couple of Acks from different
platforms and success reports would be very helpful.

* nd/threaded-index-pack (2012-03-02) 2 commits
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function

Rerolled to fix a bug that was discovered with a trivial test, and
resurrected from Stalled category, but I am reluctant to advance a
topic that can easily break many people's repositories at this late
in the cycle.

* jc/maint-diff-patch-header (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at 2cd2059)
 + diff -p: squelch "diff --git" header for stat-dirty paths
 + t4011: illustrate "diff-index -p" on stat-dirty paths
 + t4011: modernise style
 (this branch is used by jc/diff-ignore-mode.)

"diff-index" and friends showed "diff --git" header and nothing else
for a path that is only stat-dirty.

Should be safe, but is not urgent.

* tr/maint-bundle-boundary (2012-03-01) 3 commits
  (merged to 'next' on 2012-03-02 at c25692f)
 + bundle: keep around names passed to add_pending_object()
 + t5510: ensure we stay in the toplevel test dir
 + t5510: refactor bundle->pack conversion

"git bundle" did not record boundary commits correctly when there
are many of them.

* jc/pickaxe-ignore-case (2012-03-04) 3 commits
  (merged to 'next' on 2012-03-04 at 1ad3a39)
 + ctype.c: Fix a sparse warning
  (merged to 'next' on 2012-03-02 at 73a632b)
 + pickaxe: allow -i to search in patch case-insensitively
 + grep: use static trans-case table

"git log -G/-S" pays attention to the "-i" option.

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
