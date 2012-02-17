From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #06; Thu, 16)
Date: Thu, 16 Feb 2012 18:42:17 -0800
Message-ID: <7v1upuw586.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 03:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyDmE-0006At-J3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 03:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab2BQCmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 21:42:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab2BQCmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 21:42:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6EBD75E4;
	Thu, 16 Feb 2012 21:42:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=HEAfWFPhAXw3+Zx8pBtm9gmKu
	7k=; b=xTA5JjcdM6Zm45SgtkWc8RGaGM8OJ9PNvfU8ZuY0v+WYOYkmwslTgjAZN
	VQdMhLHuRSLFqTFnanndB1EjKaGSIPjBlWXgjTgXHlQyGmMERImgxHbgmrsjMP5s
	yY+LlXMeyOFvnvT5EvLiC4dDhhjfUoOp8knB956ZXRpJuNQAgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=FhQ2WDTrPpLVyMAeUV+
	Fi8HAdGYQqwk0gHqvg5Czq0+2HxPYaHvc4Y5Q/qG0iWxcgkPnsiQPtBSb7YCCWCT
	HrOjlbBeEOC/4AwXy+76mGP4OqlfxG+lIQgPoQxSBTmpIi5kVI/5UlbyYoGi0ekZ
	tUapoHeAmpR+I0AeSvRNUJ2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F2D175E3;
	Thu, 16 Feb 2012 21:42:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7A4575E1; Thu, 16 Feb 2012
 21:42:18 -0500 (EST)
X-master-at: b0d66b5110faaeb395610ba43b6eb70a18ab5e25
X-next-at: a9004c5cb2204cf950debab328e86de5eefb9da4
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0269A9F2-5911-11E1-8AF6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190931>

What's cooking in git.git (Feb 2012, #06; Thu, 16)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

The first maintenance release v1.7.9.1 ironed out usability kinks in th=
e
new features added in v1.7.9 release.  Topics that add new features and
fixes that have been cooking in 'next' start to graduate to 'master'
again.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bl/gitweb-project-filter (2012-02-12) 1 commit
  (merged to 'next' on 2012-02-13 at 35366b8)
 + gitweb: Harden and improve $project_filter page title

An update to the new feature to "gitweb" to show list of projects for
intermediate levels in directory hierarchies, already slated for 1.7.10=
=2E

* dp/i18n-libcharset (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-13 at 528de77)
 + Makefile: introduce CHARSET_LIB to link with -lcharset

Some systems need to explicitly link -lcharset to get locale_charset().

* jk/git-dir-lookup (2012-02-02) 1 commit
  (merged to 'next' on 2012-02-05 at 1856d74)
 + standardize and improve lookup rules for external local repos

When you have both .../foo and .../foo.git, "git clone .../foo" did not
favor the former but the latter.

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

* jk/userdiff-config-simplify (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-10 at e9854c1)
 + drop odd return value semantics from userdiff_config

Code cleanup.

* jn/ancient-meld-support (2012-02-10) 1 commit
  (merged to 'next' on 2012-02-13 at 28aca31)
 + mergetools/meld: Use --help output to detect --output support

More reliably tell if the given version of "meld" supports --output
option.

* lt/pull-no-edit (2012-02-12) 1 commit
  (merged to 'next' on 2012-02-13 at 352f0cb)
 + "git pull" doesn't know "--edit"

=46or 1.7.10 where "git merge" by default spawns the editor when it can
automatically commit to record the resulting merge.

* mh/war-on-extra-refs (2012-02-12) 7 commits
  (merged to 'next' on 2012-02-13 at adb7353)
 + refs: remove the extra_refs API
 + clone: do not add alternate references to extra_refs
 + everything_local(): mark alternate refs as complete
 + fetch-pack.c: inline insert_alternate_refs()
 + fetch-pack.c: rename some parameters from "path" to "refname"
 + clone.c: move more code into the "if (refs)" conditional
 + t5700: document a failure of alternates to affect fetch

Internal API clean-up that is very cleanly done.

* nd/pack-objects-parseopt (2012-02-01) 3 commits
  (merged to 'next' on 2012-02-05 at d0dc25d)
 + pack-objects: convert to use parse_options()
 + pack-objects: remove bogus comment
 + pack-objects: do not accept "--index-version=3Dversion,"

"pack-objects" learned use parse-options, losing custom command line
parsing code.

--------------------------------------------------
[New Topics]

* cb/maint-rev-list-verify-object (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-16 at a407b9a)
 + git rev-list: fix invalid typecast

=46ixes an obscure bug in "rev-list --verify" that skipped verification
depending on the phase of the moon, which dates back to 1.7.8.x series.

* cb/maint-t5541-make-server-port-portable (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-16 at 762eefb)
 + t5541: check error message against the real port number used

Test fix.

* cb/receive-pack-keep-errors (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-16 at 9ff846e)
 + do not override receive-pack errors

Sometimes error status detected by a check in an earlier phase of
receive-pack (the other end of 'git push') was lost by later checks,
resulting in false indication of success.

* cb/transfer-no-progress (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-16 at ff17092)
 + push/fetch/clone --no-progress suppresses progress output

The transport programs ignored --no-progress and showed progress when
sending their output to a terminal.

* jk/diff-highlight (2012-02-13) 5 commits
 - diff-highlight: document some non-optimal cases
 - diff-highlight: match multi-line hunks
 - diff-highlight: refactor to prepare for multi-line hunks
 - diff-highlight: don't highlight whole lines
 - diff-highlight: make perl strict and warnings fatal

Updates diff-highlight (in contrib/).

* zj/decimal-width (2012-02-14) 1 commit
  (merged to 'next' on 2012-02-16 at 72805c4)
 + make lineno_width() from blame reusable for others
 (this branch is used by zj/diff-stat-dyncol.)

Refactoring.

* zj/term-columns (2012-02-13) 1 commit
  (merged to 'next' on 2012-02-16 at fe70c88)
 + pager: find out the terminal width before spawning the pager
 (this branch is used by zj/diff-stat-dyncol.)

=46ixes "git -p cmd" for any subcommand that cares about the true termi=
nal
width.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained.

* zj/diff-stat-dyncol (2012-02-15) 6 commits
 . diff --stat: use less columns for change counts
 - (squash to the previous -- replace the last line of the log with the=
 following)
 - diff --stat: use the full terminal width
 - (squash to the previous -- replace the log message with this)
 - diff --stat: tests for long filenames and big change counts
 - Merge branches zj/decimal-width and zj/term-columns
 (this branch uses zj/decimal-width and zj/term-columns.)

* jc/diff-stat-scaler (2012-02-14) 1 commit
  (merged to 'next' on 2012-02-16 at 404d336)
 + diff --stat: show bars of same length for paths with same amount of =
changes

The output from "git diff --stat" for two paths that have the same amou=
nt
of changes showed graph bars of different length due to the way we hand=
led
rounding errors.

* jn/gitweb-unborn-head (2012-02-16) 1 commit
 - gitweb: Deal with HEAD pointing to unborn branch in "heads" view

"gitweb" compared non-existent value of HEAD with the names of commit
objects at tips of branches, triggering runtime warnings.

* tr/perftest (2012-02-16) 3 commits
 . Add a performance test for git-grep
 . Introduce a performance testing framework
 . Move the user-facing test library to test-lib-functions.sh

When merged to 'pu' this seems to break quite a lot of tests.  One way =
it
does so is by removing the write_script helper, but there may be others=
=2E

* jb/required-filter (2012-02-16) 1 commit
 - Add a setting to require a filter to be successful

A content filter used to be a way to make the recorded contents "more
useful", but this defines a way to optionally mark a filter "required".

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
 . column: Fix some compiler and sparse warnings
 . column: add a corner-case test to t3200
 . columns: minimum coding style fixes
 . tag: add --column
 . column: support piping stdout to external git-column process
 . status: add --column
 . branch: add --column
 . help: reuse print_columns() for help -a
 . column: add column.ui for default column output settings
 . column: support columns with different widths
 . column: add columnar layout
 . Stop starting pager recursively
 . Add git-column and column mode parsing
 . column: add API to print items in columns
 . Save terminal width before setting up pager

Expecting a reroll on top of zj/term-columns topic.

--------------------------------------------------
[Cooking]

* jk/config-include (2012-02-16) 9 commits
 - config: add include directive
 - config: eliminate config_exclusive_filename
 - config: stop using config_exclusive_filename
 - config: provide a version of git_config with more options
 - config: teach git_config_rename_section a file argument
 - config: teach git_config_set_multivar_in_file a default path
 - config: copy the return value of prefix_filename
 - t1300: add missing &&-chaining
 + docs: add a basic description of the config API

An assignment to the include.path pseudo-variable causes the named file
to be included in-place when Git looks up configuration variables.

Reverted the earlier round from 'next'.

* tg/tag-points-at (2012-02-13) 2 commits
  (merged to 'next' on 2012-02-13 at a8f4046)
 + builtin/tag.c: Fix a sparse warning
  (merged to 'next' on 2012-02-10 at 4bff88f)
 + tag: add --points-at list option

Will merge to 'master'.

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

The second one looked iffy.

* ld/git-p4-expanded-keywords (2012-02-14) 1 commit
  (merged to 'next' on 2012-02-16 at a9004c5)
 + git-p4: add initial support for RCS keywords

Teach git-p4 to unexpand $RCS$-like keywords that are embedded in
tracked contents in order to reduce unnecessary merge conflicts.
