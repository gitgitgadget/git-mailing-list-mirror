From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #04; Fri, 10)
Date: Fri, 10 Feb 2012 15:37:21 -0800
Message-ID: <7vhayyntu6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 00:37:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw021-0008EV-MT
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 00:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761118Ab2BJXh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 18:37:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760438Ab2BJXhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 18:37:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9D77A43;
	Fri, 10 Feb 2012 18:37:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=WMKijFxPZP/+hWp2qKxHfjlgu
	Bw=; b=ls5x5CG6S8R12OaLvRokv/A3o9Q5RKKg7uTJCM1Phaiy81+yxiLijCkwM
	q+pyge9AyQDb6mV4XsOlF7Q8rktYNNXmCMs+G6kSOHUj9+L2B43nYrFA0azz1d+r
	LSOC1gB4H5Ia9jn8cGUdI384aCrf5oPoiqNiTYyT12gCq7aPoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=nN03w1x9nv7imRM5Lv9
	Y9D2WmYoM90Zio3s8i5oLPS6OOIVCHvneLgBFCpXIQvWG+sqfgpC8ZjrhcffAcUS
	8a1HqQ8ce9rYcaelqW4a+9FOHZfsL79maxcD2q9fBlfS6YaVuF4wkmKrL9K3Sb8p
	eyV1Ymd6WmL7AdekvnSOs8pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 632ED7A42;
	Fri, 10 Feb 2012 18:37:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 660CC7A40; Fri, 10 Feb 2012
 18:37:23 -0500 (EST)
X-master-at: b6b3b6a01f357922ccd14f2615accc9bd39fc194
X-next-at: b41c6bb8e2f080306ede9023919c9e703e625c79
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9984D2-5440-11E1-82F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190473>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

This round mosty consists of topics to fix new features introduced in
1.7.9, in preparation for 1.7.9.1 maintenance release.  There are a few
more of them to come.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* nk/ctype-for-perf (2012-02-10) 2 commits
  (merged to 'next' on 2012-02-10 at b41c6bb)
 + ctype: implement islower/isupper macro
 + ctype.c only wants git-compat-util.h

* jn/ancient-meld-support (2012-02-10) 1 commit
 - mergetools/meld: Use --help output to detect --output support

--------------------------------------------------
[Graduated to "master"]

* jc/branch-desc-typoavoidance (2012-02-05) 2 commits
  (merged to 'next' on 2012-02-06 at 9fb0568)
 + branch --edit-description: protect against mistyped branch name
 + tests: add write_script helper function
 (this branch is tangled with jk/tests-write-script.)

Typo in "git branch --edit-description my-tpoic" was not diagnosed.

* jc/merge-ff-only-stronger-than-signed-merge (2012-02-05) 1 commit
  (merged to 'next' on 2012-02-06 at 0fabf12)
 + merge: do not create a signed tag merge under --ff-only option
 (this branch is used by jn/merge-no-edit-fix.)

"git merge --ff-only $tag" failed because it cannot record the required
mergetag without creating a merge, but this is so common operation for
branch that is used _only_ to follow the upstream, so it is allowed to
fast-forward without recording the mergetag.

* jc/parse-date-raw (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-07 at 486ae6e)
 + parse_date(): '@' prefix forces git-timestamp
 + parse_date(): allow ancient git-timestamp

"rebase" and "commit --amend" failed to work on commits with ancient
timestamps near year 1970.

* jk/tests-write-script (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-05 at 4264ffa)
 + t0300: use write_script helper
 + tests: add write_script helper function
 (this branch is tangled with jc/branch-desc-typoavoidance.)

* jn/rpm-spec (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at dba940b)
 + git.spec: Workaround localized messages not put in any RPM

=46ix breakage in v1.7.9 Makefile; rpmbuild notices an unpackaged but
installed *.mo file and fails.

* js/add-e-submodule-fix (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-08 at c8e2d28)
 + add -e: do not show difference in a submodule that is merely dirty

"add -e" learned not to show a diff for an otherwise unmodified submodu=
le
that only has uncommitted local changes in the patch prepared by for th=
e
user to edit.

--------------------------------------------------
[Stalled]

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

* jc/split-blob (2012-01-24) 6 commits
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

* nd/columns (2012-02-08) 15 commits
 - column: Fix some compiler and sparse warnings
 - column: add a corner-case test to t3200
 - columns: minimum coding style fixes
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add column.ui for default column output settings
 - column: support columns with different widths
 - column: add columnar layout
 - Stop starting pager recursively
 - Add git-column and column mode parsing
 - column: add API to print items in columns
 - Save terminal width before setting up pager

The "show list of ..." mode of a handful of commands learn to produce
column-oriented output.

Expecting a reroll.

--------------------------------------------------
[Cooking]

* jk/config-include (2012-02-06) 2 commits
 - config: add include directive
 - docs: add a basic description of the config API

An assignment to the include.path pseudo-variable causes the named file
to be included in-place when Git looks up configuration variables.

* jk/maint-tag-show-fixes (2012-02-08) 3 commits
  (merged to 'next' on 2012-02-08 at 18459c4)
 + tag: do not show non-tag contents with "-n"
 + tag: die when listing missing or corrupt objects
 + tag: fix output of "tag -n" when errors occur

Bugfixes to "git tag -n" that lacked much error checking.
Will merge to 'masster'.

* mm/empty-loose-error-message (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-07 at f119cac)
 + fsck: give accurate error message on empty loose object files

Updates the error message emitted when we see an empty loose object.
Will merge to 'masster'.

* jc/maint-commit-ignore-i-t-a (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-10 at e0040cf)
 + commit: ignore intent-to-add entries instead of refusing

Replaces the nd/commit-ignore-i-t-a series that was made unnecessary
complicated by bad suggestions I made earlier.
Will merge to 'masster'.

* jk/userdiff-config-simplify (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-10 at e9854c1)
 + drop odd return value semantics from userdiff_config

Code cleanup.

* nd/cache-tree-api-refactor (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-08 at a9abbca)
 + cache-tree: update API to take abitrary flags

Code cleanup.

* tg/tag-points-at (2012-02-08) 1 commit
  (merged to 'next' on 2012-02-10 at 4bff88f)
 + tag: add --points-at list option

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

The second one looked iffy.

* jn/merge-no-edit-fix (2012-02-09) 1 commit
  (merged to 'next' on 2012-02-10 at 014eec9)
 + merge: do not launch an editor on "--no-edit $tag"

In 1.7.9, "merge --no-edit $tag" incorrectly ignored --no-edit.

* ld/git-p4-expanded-keywords (2012-02-09) 2 commits
 - git-p4: initial demonstration of possible RCS keyword fixup
 - git-p4: add test case for RCS keywords

Waiting for reviews and user reports.

* mp/make-cleanse-x-for-exe (2012-02-09) 1 commit
  (merged to 'next' on 2012-02-09 at 35cc89d)
 + Explicitly set X to avoid potential build breakage

Will merge to 'master'.

* bw/inet-pton-ntop-compat (2012-02-05) 1 commit
  (merged to 'next' on 2012-02-06 at 61303e6)
 + Drop system includes from inet_pton/inet_ntop compatibility wrappers

The inclusion order of header files bites Solaris again and this fixes =
it.
Will merge to 'master'.

* jc/checkout-out-of-unborn (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-07 at 60eb328)
 + git checkout -b: allow switching out of an unborn branch

I was fairly negative on this one, but Michael Haggerty and Peff convin=
ced
me that selling this as "'checkout -b' that lack the <start point> is
about creating a new branch from my current state" is perfectly fine.

* jc/maint-mailmap-output (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-06 at 0a21425)
 + mailmap: always return a plain mail address from map_user()

map_user() was not rewriting its output correctly, which resulted in th=
e
user visible symptom that "git blame -e" sometimes showed excess '>' at
the end of email addresses.

* tt/profile-build-fix (2012-02-09) 2 commits
  (merged to 'next' on 2012-02-09 at 1c183af)
 + Makefile: fix syntax for older make
  (merged to 'next' on 2012-02-07 at c8c5f3f)
 + Fix build problems related to profile-directed optimization

* nd/diffstat-gramnum (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 7335ecc)
 + Use correct grammar in diffstat summary line

The commands in the "git diff" family and "git apply --stat" that count
the number of files changed and the number of lines inserted/deleted ha=
ve
been updated to match the output from "diffstat".  This also opens the
door to i18n this line.

* jk/grep-binary-attribute (2012-02-02) 9 commits
  (merged to 'next' on 2012-02-05 at 9dffa7e)
 + grep: pre-load userdiff drivers when threaded
 + grep: load file data after checking binary-ness
 + grep: respect diff attributes for binary-ness
 + grep: cache userdiff_driver in grep_source
 + grep: drop grep_buffer's "name" parameter
 + convert git-grep to use grep_source interface
 + grep: refactor the concept of "grep source" into an object
 + grep: move sha1-reading mutex into low-level code
 + grep: make locking flag global

=46ixes a longstanding bug that there was no way to tell "git grep" tha=
t a
path may look like text but it is not, which "git diff" can do using th=
e
attributes system. Now "git grep" honors the same "binary" (or "-diff")
attribute.

* jk/git-dir-lookup (2012-02-02) 1 commit
  (merged to 'next' on 2012-02-05 at 1856d74)
 + standardize and improve lookup rules for external local repos

When you have both .../foo and .../foo.git, "git clone .../foo" did not
favor the former but the latter.

* jk/prompt-fallback-to-tty (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-06 at c0c995a)
 + prompt: fall back to terminal if askpass fails
 + prompt: clean up strbuf usage

The code to ask for password did not fall back to the terminal input wh=
en
GIT_ASKPASS is set but does not work (e.g. lack of X with GUI askpass
helper).

* jn/gitweb-search-utf-8 (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 055e446)
 + gitweb: Allow UTF-8 encoded CGI query parameters and path_info

Search box in "gitweb" did not accept non-ASCII characters correctly.

* fc/zsh-completion (2012-02-06) 3 commits
  (merged to 'next' on 2012-02-06 at c94dd12)
 + completion: simplify __gitcomp and __gitcomp_nl implementations
 + completion: use ls -1 instead of rolling a loop to do that ourselves
 + completion: work around zsh option propagation bug

=46ix git subcommand completion for zsh (in contrib/completion).

* nd/find-pack-entry-recent-cache-invalidation (2012-02-01) 2 commits
  (merged to 'next' on 2012-02-01 at e26aed0)
 + find_pack_entry(): do not keep packed_git pointer locally
 + sha1_file.c: move the core logic of find_pack_entry() into fill_pack=
_entry()

* nd/pack-objects-parseopt (2012-02-01) 3 commits
  (merged to 'next' on 2012-02-05 at d0dc25d)
 + pack-objects: convert to use parse_options()
 + pack-objects: remove bogus comment
 + pack-objects: do not accept "--index-version=3Dversion,"

"pack-objects" learned use parse-options, losing custom command line
parsing code.
