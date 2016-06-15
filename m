From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2012, #01; Thu, 1)
Date: Thu, 01 Mar 2012 16:03:29 -0800
Message-ID: <7vy5rjkgxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 01:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3FyG-0004jk-64
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 01:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab2CBADe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 19:03:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab2CBADd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 19:03:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040D26F2F;
	Thu,  1 Mar 2012 19:03:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=H3sAP+8hhOo4inEXYyok7CbSd
	70=; b=ZFmkFv1EOnUJMzCCJOio8Zzt2cjgGAUWpm05/HtqfPPXTyF8YxAYNB6Rf
	j1km4pwxjDl/4v/YIpMbKxmL3E0YL66Vhz4KeZ5siPwWGcg6xKGpfoDETi73XDur
	o8R2oD0k4pwzH6LVOsAiRjHrZNobBxm1tqYwpk8vXLOY66eU90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=iPgT+zk+ImUknbFQNU4
	kYeyA/bhwkIiAlqmDFO9V6+mfw7by+GXd1t+nPVJtbO7Ao4lmLrr214Z6cv1fDKW
	yG+6gc7CydFK6fVkf/4qIcGnYYNmPx6X9MFF6YFx0DTbaNSza0tXVu2kzqWWlyKY
	7I0Q5BSyao1gTGfCbeC9T3Tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE6A56F2E;
	Thu,  1 Mar 2012 19:03:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABE46F2D; Thu,  1 Mar 2012
 19:03:30 -0500 (EST)
X-master-at: 797166cfafb516a713fa442bfc0411a7d2e131e3
X-next-at: a05ebf3088f87d3d8ec8c7fa8670b525d16eeede
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2530B788-63FB-11E1-9125-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191989>

What's cooking in git.git (Mar 2012, #01; Thu, 1)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

In a week or so, we'll hit 1.7.10-rc0 and the upcoming release should b=
e
more or less feature complete by then.  I expect we will leave a couple=
 of
large-ish topics behind, but in today's list, I do not see any particul=
ar
topic that cannot use extra time to get polished to become usable while
waiting until the next cycle.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/maint-diff-patch-header (2012-03-01) 4 commits
 - diff --ignore-mode-change
 - diff -p: squelch "diff --git" header for stat-dirty paths
 - t4011: illustrate "diff-index -p" on stat-dirty paths
 - t4011: modernise style

The last one is entirely optional as its utility is unknown, but
the first three fixes a long-standing corner case buglet.

* jk/symbolic-ref-short (2012-02-27) 1 commit
  (merged to 'next' on 2012-02-28 at d00f766)
 + symbolic-ref --short: abbreviate the output unambiguously

"git symbolic-ref" learned the "--short" option to abbreviate the refna=
me
it shows unambiguously.

* nd/optim-connected (2012-02-29) 1 commit
 - Perform cheaper connectivity check when pack is used as medium

* tr/maint-bundle-boundary (2012-03-01) 3 commits
 - bundle: keep around names passed to add_pending_object()
 - t5510: ensure we stay in the toplevel test dir
 - t5510: refactor bundle->pack conversion

* nd/threaded-index-pack (2012-02-28) 2 commits
 . index-pack: support multithreaded delta resolving
 . index-pack: split second pass obj handling into own function

Produces a corrupt pack.  Will discard.

--------------------------------------------------
[Graduated to "master"]

* cn/maint-branch-with-bad (2012-02-27) 1 commit
  (merged to 'next' on 2012-02-28 at a37929e)
 + branch: don't assume the merge filter ref exists

"git branch --with $that" assumed incorrectly that the user will never
ask the question with nonsense value in $that.

* cn/maint-rev-list-doc (2012-02-28) 1 commit
  (merged to 'next' on 2012-02-28 at f21c627)
 + Documentation: use {asterisk} in rev-list-options.txt when needed

Documentation fix.

* jb/required-filter (2012-02-17) 1 commit
  (merged to 'next' on 2012-02-26 at e9ba88a)
 + Add a setting to require a filter to be successful

A content filter used to be a way to make the recorded contents "more
useful", but this defines a way to optionally mark a filter "required".

* jn/maint-gitweb-invalid-regexp (2012-02-28) 1 commit
  (merged to 'next' on 2012-02-28 at 6789570)
 + gitweb: Handle invalid regexp in regexp search

An invalid regular expression pattern given by an end user made "gitweb=
"
to return garbled response.

* nd/maint-verify-objects (2012-02-28) 2 commits
  (merged to 'next' on 2012-02-28 at a5e9b09)
 + rev-list: fix --verify-objects --quiet becoming --objects
 + rev-list: remove BISECT_SHOW_TRIED flag

"git rev-list --verify-objects -q" omitted the extra verification it
needs to do over "git rev-list --objects -q" by mistake.

* ph/cherry-pick-advice-refinement (2012-02-22) 1 commit
  (merged to 'next' on 2012-02-26 at 1c930c3)
 + cherry-pick: No advice to commit if --no-commit

The advice given by a conflicted "cherry-pick --no-commit" told the use=
r
to make a commit after resolving conflicts.

* pj/completion-remote-set-url-branches (2012-02-22) 2 commits
  (merged to 'next' on 2012-02-26 at 0062008)
 + completion: normalize increment/decrement style
 + completion: remote set-* <name> and <branch>

--------------------------------------------------
[Stalled]

* jc/diff-ignore-case (2012-02-28) 6 commits
 . diff: -i is "--ignore-case" but means a bit more in "log"
 . diff: --ignore-case
 . xdiff: introduce XDF_IGNORE_CASE
 . xdiff: introduce XDF_INEXACT_MATCH
 . xdiff: PATIENCE/HISTOGRAM are not independent option bits
 . xdiff: remove XDL_PATCH_* macros

"git diff" learns "--ignore-case" option.
Will discard, as nobody seems to need this.

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

The second one looked iffy.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

* jc/split-blob (2012-02-23) 7 commits
 - fixup?
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in 127b177
(bulk-checkin: support chunked-object encoding, 2011-11-30), these are
still early steps of a long and painful journey. At least pack-objects =
and
fsck need to learn the new encoding for the series to be usable locally=
,
and then index-pack/unpack-objects needs to learn it to be used remotel=
y.

Given that I heard a lot of noise that people want large files, and tha=
t I
was asked by somebody at GitTogether'11 privately for an advice on how =
to
pay developers (not me) to help adding necessary support, I am somewhat
dissapointed that the original patch series that was sent almost two
months ago still remains here without much comments and updates from th=
e
developer community. I even made the interface to the logic that decide=
s
where to split chunks easily replaceable, and I deliberately made the
logic in the original patch extremely stupid to entice others, especial=
ly
the "bup" fanboys, to come up with a better logic, thinking that giving
people an easy target to shoot for, they may be encouraged to help
out. The plan is not working :-(.

--------------------------------------------------
[Cooking]

* jc/pickaxe-ignore-case (2012-02-28) 2 commits
 - pickaxe: allow -i to search in patch case-insensitively
 - grep: use static trans-case table

"git log -G/-S" pays attention to the "-i" option.

* rs/no-no-no-parseopt (2012-02-28) 3 commits
  (merged to 'next' on 2012-02-29 at 94e60d0)
 + parse-options: remove PARSE_OPT_NEGHELP
 + parse-options: allow positivation of options starting, with no-
 + test-parse-options: convert to OPT_BOOL()

Options that use PARSE_OPT_NEGHELP needed to word their help text in
a strange way, and this gets rid of the uses of them.

* jc/am-3-nonstandard-popt (2012-02-26) 2 commits
  (merged to 'next' on 2012-02-26 at 62a6ddf)
 + test: "am -3" can accept non-standard -p<num>
  (merged to 'next' on 2012-02-26 at 1363bd6)
 + am -3: allow nonstandard -p<num> option

The code to synthesize the fake ancestor tree used by 3-way merge
fallback in "git am" was not prepared to read a patch created with
a non-standard -p<num> value.

* cb/fsck-squelch-dangling (2012-02-28) 1 commit
  (merged to 'next' on 2012-02-29 at 9057e12)
 + fsck: --no-dangling omits "dangling object" information

I've butchered Clemens's patch and added "--no-dangling", and reverted
the part that flips the default.  I also took the authorship blame, as
I do not share the final goal with him, but our first steps should be
in the same direction, which is this patch.

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

Rerolled, but the configuration handling looked iffy.

* th/git-diffall (2012-02-27) 1 commit
  (merged to 'next' on 2012-02-28 at 4ba7a15)
 + contrib: add git-diffall script

A sample script that drives an external tool that compares two
directories, by populating two temporary directories with contents of
two revisions in Git.

* jn/gitweb-hilite-regions (2012-02-26) 4 commits
  (merged to 'next' on 2012-02-28 at 3244f30)
 + gitweb: Highlight matched part of shortened project description
 + gitweb: Highlight matched part of project description when searching=
 projects
 + gitweb: Highlight matched part of project name when searching projec=
ts
 + gitweb: Introduce esc_html_match_hl and esc_html_hl_regions

Project search in "gitweb" shows the substring that matched in the proj=
ect
name and description highlighted. The highlighting logic is meant to be
reused later for other kinds of searches e.g. grep and commit log searc=
h.
