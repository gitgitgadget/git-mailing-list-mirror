From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #09; Tue, 27)
Date: Tue, 27 Dec 2011 15:37:18 -0800
Message-ID: <7v62h14mdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 00:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfgaI-0002FW-MU
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 00:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab1L0XhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 18:37:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab1L0XhV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 18:37:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBAB051CB;
	Tue, 27 Dec 2011 18:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	PufufBMFYZZxHtpipjIcfsyN4s=; b=Pg+RS22R+gQjowiFQbiWHKO1rKWO8jDCI
	d4VbquxUmEM5dKV/mMvX3B4Jt7FTiy5knT/5cH6gOk9o+aG8SMYgFKdbWlY2Uaq8
	gzHK1gdVeOS8Lkmf7v2EBtKH35jZ/ahj2GtdQUlqjXJ8R4eNP4DSB5TYct3f0sRk
	AccdpnaOyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qxv
	6HJLQFvYQ5FNfM+4A9G5e8QpvaN+JzLtk/xfTVKz3ilwZppRceYzQoGkykTkIuol
	K5uDIhlN7LwPHrxpIX8RlfAsgPWxH9VYUTS8XM7skVOOhY+Y86aDw0hC/vSUR7ps
	wCL1ahQ2ffaOHurWGPOkJdnpsKSicDOikOSKkF+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AAF51CA;
	Tue, 27 Dec 2011 18:37:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD71251C8; Tue, 27 Dec 2011
 18:37:19 -0500 (EST)
X-master-at: ec330158ec04849fe5ff2cb8749797cd63ae592b
X-next-at: 551ac8f4336eaa5d2cf05fd3dec4a3676b57379f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7EB022C-30E3-11E1-9F2F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187738>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

By now I know a bit better than taking the lack of serious regression
reports during the holiday weekend as a sign of perfection of the upcoming
release, but I will tag -rc0 soonish anyway. As far as I can see the tip
of 'master' is feature complete for 1.7.9, modulo possible bugs and
regressions.

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

* jh/fetch-head-update (2011-12-27) 1 commit
 - write first for-merge ref to FETCH_HEAD first

Needs sign-off. I have squashed minimal fixes in.

* jv/maint-config-set (2011-12-27) 1 commit
  (merged to 'next' on 2011-12-27 at 551ac8f)
 + Fix an incorrect reference to --set-all.

Will merge to "master" before -rc0.

* nd/index-pack-no-recurse (2011-12-27) 4 commits
 - fixup! 3413d4d
 - index-pack: eliminate unlimited recursion in get_delta_base()
 - index-pack: eliminate recursion in find_unresolved_deltas
 - Eliminate recursion in setting/clearing marks in commit list

Expecting a reroll.

* ss/git-svn-askpass (2011-12-27) 5 commits
 - make askpass_prompt a global prompt method for asking users
 - ignore empty *_ASKPASS variables
 - honour *_ASKPASS for querying username and for querying further actions like unknown certificates
 - switch to central prompt method
 - add central method for prompting a user using GIT_ASKPASS or SSH_ASKPASS

Expecting a reroll.

--------------------------------------------------
[Graduated to "master"]

* ab/sun-studio-portability (2011-12-21) 3 commits
  (merged to 'next' on 2011-12-21 at 0cc5a63)
 + Appease Sun Studio by renaming "tmpfile"
 + Fix a bitwise negation assignment issue spotted by Sun Studio
 + Fix an enum assignment issue spotted by Sun Studio

* jn/maint-gitweb-utf8-fix (2011-12-19) 4 commits
  (merged to 'next' on 2011-12-20 at b816812)
 + gitweb: Fix fallback mode of to_utf8 subroutine
 + gitweb: Output valid utf8 in git_blame_common('data')
 + gitweb: esc_html() site name for title in OPML
 + gitweb: Call to_utf8() on input string in chop_and_escape_str()

* rr/revert-cherry-pick (2011-12-15) 6 commits
  (merged to 'next' on 2011-12-21 at d0428dc)
 + t3502, t3510: clarify cherry-pick -m failure
 + t3510 (cherry-pick-sequencer): use exit status
 + revert: simplify getting commit subject in format_todo()
 + revert: tolerate extra spaces, tabs in insn sheet
 + revert: make commit subjects in insn sheet optional
 + revert: free msg in format_todo()

* tr/bash-read-unescaped (2011-12-21) 1 commit
  (merged to 'next' on 2011-12-21 at de865c1)
 + bash completion: use read -r everywhere

* tr/doc-sh-setup (2011-12-20) 1 commit
  (merged to 'next' on 2011-12-21 at bd73695)
 + git-sh-setup: make require_clean_work_tree part of the interface

* tr/pty-all (2011-12-19) 1 commit
  (merged to 'next' on 2011-12-20 at 9b637d3)
 + test-terminal: set output terminals to raw mode

Kept only the second one from the original.

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=upstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

Waiting for a reroll.

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
 - names_conflict(): new function, extracted from is_refname_available()
 - repack_without_ref(): reimplement using do_for_each_ref_in_array()
 - do_for_each_ref_in_arrays(): new function
 - do_for_each_ref_in_array(): new function
 - do_for_each_ref(): correctly terminate while processesing extra_refs

The API for extra anchoring points may require rethought first; that would
hopefully make the "ref" part a lot simpler.

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
series to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

* jc/advise-i18n (2011-12-22) 1 commit
 - i18n of multi-line advice messages

Allow localization of advice messages that tend to be longer and
multi-line formatted. For now this is deliberately limited to advise()
interface and not vreportf() in general as touching the latter has
interactions with error() that has plumbing callers whose prefix "error: "
should never be translated.

--------------------------------------------------
[Cooking]

* pw/p4-docs-and-tests (2011-12-27) 11 commits
 - git-p4: document and test submit options
 - git-p4: test and document --use-client-spec
 - git-p4: test --keep-path
 - git-p4: test --max-changes
 - git-p4: document and test --import-local
 - git-p4: honor --changesfile option and test
 - git-p4: document and test clone --branch
 - git-p4: test cloning with two dirs, clarify doc
 - git-p4: clone does not use --git-dir
 - git-p4: introduce asciidoc documentation
 - rename git-p4 tests

Rorolled.
Not urgent.

* jc/signed-commit (2011-11-29) 5 commits
  (merged to 'next' on 2011-12-21 at 8fcbf00)
 + gpg-interface: allow use of a custom GPG binary
 + pretty: %G[?GS] placeholders
 + test "commit -S" and "log --show-signature"
 + log: --show-signature
 + commit: teach --gpg-sign option

I am ambivalent on this one. I do not desperately need it myself, I know
the kernel folks do not, I heard some other people might.

Opinions?
