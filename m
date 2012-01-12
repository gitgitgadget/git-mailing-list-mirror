From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2012, #03; Wed, 11)
Date: Wed, 11 Jan 2012 23:02:39 -0800
Message-ID: <7vk44x2yk0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 08:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlEgU-0003zg-7v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 08:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab2ALHCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 02:02:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab2ALHCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 02:02:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28ACC7CC2;
	Thu, 12 Jan 2012 02:02:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Wqvz9cFz+Ll1QAoQZUTa5MtWc
	Mc=; b=hzE7R9ew0VbNSlsAJJv9sXTQue7Dxd4QtJBYcuclxY0GdZ9ifOMmh6BWd
	3yMVbhS3X0dRB1dGWbFb/7uSsfrQuHL9V6g0gO4RGquYsgIGbuNKrp941HYZFx8K
	tmd8C2EXNAl6n7wY+h8fUdKwSQZJ62GPLrwz6zFdp+gAnig884=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=hoGhmBY4nldoCT1/jcQ
	9gXDsvUwRZoBGFQ5MwyfMJmLAetXUmG5Yqftjx6OoLOmI2PWfVI8/MW5gGm7mEjd
	APVNa4en06HRHsWZvLrB9So7hcysTn3+XDd4U1r/BtN5UXRGOgRbR6sw3rg2kWRM
	N91wZh2zZTQk79SeO/n6s/Aw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EF157CC1;
	Thu, 12 Jan 2012 02:02:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42E607CC0; Thu, 12 Jan 2012
 02:02:41 -0500 (EST)
X-master-at: 0e1cfc52de002e2d9b0e6562e8672fee3bf45a67
X-next-at: 5c0bfa96c2f67a7ac76afe5096f622dced39734f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B4A5A26-3CEB-11E1-ABFF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188432>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

I plan to tag 1.7.9-rc1 sometime on Friday this week (see
http://tinyurl.com/gitcal for a calendar).

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* jc/pull-signed-tag (2012-01-11) 1 commit
 - merge: use editor by default in interactive sessions

Per Linus's strong suggestion, sugarcoated (aka "taking blame for the
original UI screw-ups") so that it is easier for me to swallow and acce=
pt
a potentially huge backward incompatibility issue, "git merge" is made =
to
launch an editor to explain the merge in the merge commit by default in
interactive sessions.

* jc/request-pull-show-head-4 (2012-01-10) 1 commit
  (merged to 'next' on 2012-01-11 at 8d98a6b)
 + request-pull: use the real fork point when preparing the message

Hopefully the final finishing touch to the request-pull script that was
updated during this cycle.

Will merge by 1.7.9-rc1.

* jk/maint-upload-archive (2012-01-11) 1 commit
  (merged to 'next' on 2012-01-11 at 5c0bfa9)
 + archive: re-allow HEAD:Documentation on a remote invocation

Running "git archive" remotely and asking for a partial tree of a ref,
e.g. HEAD:$path was forbidden by a recent change to tighten security, b=
ut
was found to be overly restrictive.

Will merge by 1.7.9-rc1.

* nd/commit-ignore-i-t-a (2012-01-11) 2 commits
 - commit: add --skip-intent-to-add to allow commit with i-t-a entries =
in index
 - cache-tree: update API to take abitrary flags

* nd/maint-refname-in-hierarchy-check (2012-01-11) 1 commit
 - Fix incorrect ref namespace check

Avoid getting confused by "ref/headxxx" and mistaking it as if it is un=
der
the "refs/heads/" hierarchy.
Not urgent.

* rr/sequencer (2012-01-11) 2 commits
 - sequencer: factor code out of revert builtin
 - revert: prepare to move replay_action to header

Moving large chunk of code out of cherry-pick/revert for later reuse,
primarily to prepare for the next cycle.
Not urgent.

* ss/maint-msys-cvsexportcommit (2012-01-11) 2 commits
  (merged to 'next' on 2012-01-11 at 007aab1)
 + git-cvsexportcommit: Fix calling Perl's rel2abs() on MSYS
 + t9200: On MSYS, do not pass Windows-style paths to CVS

Will merge by 1.7.9-rc1.

* tr/maint-mailinfo (2012-01-11) 1 commit
  (merged to 'next' on 2012-01-11 at d9e344a)
 + mailinfo documentation: accurately describe non -k case

Will merge by 1.7.9-rc1.

* jk/credentials (2012-01-11) 3 commits
 - unix-socket: do not let close() or chdir() clobber errno during clea=
nup
 - credential-cache: report more daemon connection errors
 - unix-socket: handle long socket pathnames

* pw/p4-view-updates (2012-01-11) 5 commits
 - git-p4: add tests demonstrating spec overlay ambiguities
 - git-p4: adjust test to adhere to stricter useClientSpec
 - git-p4: clarify comment
 - git-p4: fix verbose comment typo
 - git-p4: only a single ... wildcard is supported

--------------------------------------------------
[Graduated to "master"]

* bw/maint-t8006-sed-incomplete-line (2012-01-03) 1 commit
 + Work around sed portability issue in t8006-blame-textconv

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

Waiting for a reroll.

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

At least pack-objects and fsck need to learn the new encoding for the
series to be usable locally, and then index-pack/unpack-objects needs t=
o
learn it to be used remotely.

* jc/advise-i18n (2011-12-22) 1 commit
 - i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error=
: "
should never be translated.

--------------------------------------------------
[Cooking]

* rs/diff-postimage-in-context (2012-01-06) 1 commit
  (merged to 'next' on 2012-01-09 at 9635032)
 + xdiff: print post-image for common records instead of pre-image

Looked reasonable.
Not urgent.

* cb/push-quiet (2012-01-08) 3 commits
 - t5541: avoid TAP test miscounting
 - fix push --quiet: add 'quiet' capability to receive-pack
 - server_supports(): parse feature list more carefully

Looked reasonable.
Not urgent.

* nd/clone-detached (2012-01-11) 11 commits
 - clone: print advice on checking out detached HEAD
 - clone: allow --branch to take a tag
 - clone: refuse to clone if --branch points to bogus ref
 - clone: --branch=3D<branch> always means refs/heads/<branch>
 - fixup! acd8f20
 - clone: delay cloning until after remote HEAD checking
 - clone: factor out remote ref writing
 - clone: factor out HEAD update code
 - clone: factor out checkout code
 - clone: write detached HEAD in bare repositories
 - t5601: add missing && cascade

Looking good, but I may have screwed up the merge of this into 'pu'.
Not urgent.

* nd/clone-single-branch (2012-01-08) 1 commit
  (merged to 'next' on 2012-01-09 at 6c3c759)
 + clone: add --single-branch to fetch only one branch

Looked reasonable.
Not urgent.

* jn/gitweb-unspecified-action (2012-01-09) 1 commit
 - gitweb: Fix actionless dispatch for non-existent objects

Looked reasonable.
Not urgent.

* nd/index-pack-no-recurse (2012-01-09) 3 commits
 - index-pack: eliminate unlimited recursion in get_delta_base()
 - index-pack: eliminate recursion in find_unresolved_deltas
 - Eliminate recursion in setting/clearing marks in commit list

The first one looked sensible; I am not sure if the second and third on=
es
take the right approach.

Will defer till the next cycle.

* mh/ref-api-rest (2011-12-12) 35 commits
 - repack_without_ref(): call clear_packed_ref_cache()
 - read_packed_refs(): keep track of the directory being worked in
 - is_refname_available(): query only possibly-conflicting references
 - refs: read loose references lazily
 - read_loose_refs(): take a (ref_entry *) as argument
 - struct ref_dir: store a reference to the enclosing ref_cache
 - sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - do_for_each_ref_in_dir*(): take (ref_entry *) instead of (ref_dir *)
 - add_entry(): take (ref_entry *) instead of (ref_dir *)
 - search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
 - find_containing_direntry(): use (ref_entry *) instead of (ref_dir *)
 - add_ref(): take (ref_entry *) instead of (ref_dir *)
 - read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
 - find_ref(): take (ref_entry *) instead of (ref_dir *)
 - is_refname_available(): take (ref_entry *) instead of (ref_dir *)
 - get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
 - get_packed_refs(): return (ref_entry *) instead of (ref_dir *)
 - refs: wrap top-level ref_dirs in ref_entries
 - get_ref_dir(): keep track of the current ref_dir
 - do_for_each_ref(): only iterate over the subtree that was requested
 - refs: sort ref_dirs lazily
 - sort_ref_dir(): do not sort if already sorted
 - refs: store references hierarchically
 - refs.c: rename ref_array -> ref_dir
 - struct ref_entry: nest the value part in a union
 - check_refname_component(): return 0 for zero-length components
 - free_ref_entry(): new function
 - refs.c: reorder definitions more logically
 - is_refname_available(): reimplement using do_for_each_ref_in_array()
 - names_conflict(): simplify implementation
 - names_conflict(): new function, extracted from is_refname_available(=
)
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs

The API for extra anchoring points may require rethought first; that wo=
uld
hopefully make the "ref" part a lot simpler. And that is happening in
another topic (which has graduated to 'master').

Will defer till the next cycle.

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
  (merged to 'next' on 2012-01-05 at 954f125)
 + perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

Will defer till the next cycle.

* cb/git-daemon-tests (2012-01-08) 5 commits
  (merged to 'next' on 2012-01-08 at 1db8351)
 + git-daemon tests: wait until daemon is ready
 + git-daemon: produce output when ready
 + git-daemon: add tests
 + dashed externals: kill children on exit
 + run-command: optionally kill children on exit

Will defer till the next cycle.

* jk/parse-object-cached (2012-01-06) 3 commits
  (merged to 'next' on 2012-01-08 at 8c6fa4a)
 + upload-pack: avoid parsing tag destinations
 + upload-pack: avoid parsing objects during ref advertisement
 + parse_object: try internal cache before reading object db

These are a bit scary changes, but I do think they are worth doing.
Will defer till the next cycle.

* jn/maint-gitweb-grep-fix (2012-01-05) 2 commits
 - gitweb: Harden "grep" search against filenames with ':'
 - gitweb: Fix file links in "grep" search

Waiting for a confirmation from bug reporter.
