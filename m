From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Plans for 2.7.1?
Date: Mon, 01 Feb 2016 11:24:49 -0800
Message-ID: <xmqqvb68utby.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1602011740540.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 20:25:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQK5v-0003x9-KK
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 20:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbcBATYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 14:24:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752875AbcBATYw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 14:24:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87C7B40E1C;
	Mon,  1 Feb 2016 14:24:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2iQ8chkHKksU
	5NJzxyiCSP1ZF9o=; b=rmDOmYQBUhrEQzER6k9RxQ9E4IftK504G8xBYSWpZcY6
	NWfcS/NHuGARhPFLeE6QrKRadAkPBlZDh3kj8CPtwOko3mhrFCBz9d3KKyLoxeMi
	vlcjTwiHcUK9qyBaWniifLAfgWE9qOdzXMnwLBu+j8qYh/Ul5R+uGRD+MSAHpH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d80Vrz
	5FbB8+LAhEdHHYt8qlEit/OQSAtiZrUdbIC3SfB1UHge6HOc4Ioq72yowiYD9mE7
	kH2dTHcKqv/n+hbmpeNtSj5sXlBwjgBDzb4ry0iL6nfYyJMHbX4DgWklFP1ZwR+J
	zygavdzW5kk2AsNM4RBL96WIYWubF2UqInv90=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CF9640E1A;
	Mon,  1 Feb 2016 14:24:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D59A840E19;
	Mon,  1 Feb 2016 14:24:50 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1602011740540.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 1 Feb 2016 17:54:05 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76C8F90C-C919-11E5-92A8-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285210>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> at tinyurl.com/gitCal I see a pretty timeline regarding 2.8.0, but I =
do
> not see 2.7.1 planned anywhere.

Yup, because maintenance releases are inherently "not planned" ;-)

Unlike feature releases that are largely time-based, we cut
maintenance releases only when we need to push out fixes.  We do not
even know in advance what breakages we would have in 2.7.0, or what
fixes we would apply for them, and when these fixes would happen.

> Due to signature problems (I failed to realize that SHA-1 based
> .exe signatures are no longer considered valid starting from
> January 1st, 2016), I got a metric ton of private and non-private
> bug reports regarding "corrupt signatures", and therefore I would
> like to prevent those reports from taking over my entire working
> hours by simply issuing a new release of Git for Windows.
>
> Is 2.7.1 around the corner? Otherwise I'll just make a 2.7.0(2).

Let me see what are slated for 'maint' in the current draft release
notes.  This actually lists what could technically be merged to
'maint'; some clean-up patches may not be worth merging down.

    $ Meta/ML <RelNotes
    ps/push-delete-option # 2 (3 weeks ago)=20
    nd/stop-setenv-work-tree # 1 (3 weeks ago)=20
    nd/dir-exclude-cleanup # 1 (12 days ago)=20
    nd/ita-cleanup # 3 (12 days ago)=20
    ew/send-email-mutt-alias-fix # 1 (12 days ago)=20
    jk/clang-pedantic # 2 (12 days ago)=20
    dw/signoff-doc # 1 (12 days ago)=20
    dk/reflog-walk-with-non-commit # 1 (12 days ago)=20
    nd/exclusion-regression-fix # 1 (12 days ago)=20
    js/fopen-harder # 2 (12 days ago)=20
    ho/gitweb-squelch-undef-warning # 1 (12 days ago)=20
    jk/ok-to-fail-gc-auto-in-rebase # 1 (6 days ago)=20
    js/close-packs-before-gc # 4 (6 days ago)=20
    jk/filter-branch-no-index # 1 (4 days ago)=20
    jk/sanity # 1 (4 days ago)=20
    ss/user-manual # 4 (12 days ago)=20
    ew/for-each-ref-doc # 1 (12 days ago)=20
    sg/t6050-failing-editor-test-fix # 1 (12 days ago)=20
    ss/clone-depth-single-doc # 3 (12 days ago)=20

I think we have enough important fixes already in 'master' for some
time that we should merge them and tag 2.7.1.  Tentatively, among
the above, I think the following might be a good set of topics for
2.7.1:

$ cat MAINT
nd/stop-setenv-work-tree
nd/dir-exclude-cleanup
dw/signoff-doc
dk/reflog-walk-with-non-commit
nd/exclusion-regression-fix
js/fopen-harder
ho/gitweb-squelch-undef-warning
jk/ok-to-fail-gc-auto-in-rebase
js/close-packs-before-gc
jk/sanity
ss/user-manual
ew/for-each-ref-doc
sg/t6050-failing-editor-test-fix
ss/clone-depth-single-doc

And here would be the shortlog:

$ git shortlog ^maint $(cat MAINT)
David A. Wheeler (1):
      Expand documentation describing --signoff

Dennis Kaarsemaker (1):
      reflog-walk: don't segfault on non-commit sha1's in the reflog

Eric Wong (1):
      for-each-ref: document `creatordate` and `creator` fields

Jeff King (1):
      rebase: ignore failures from "gc --auto"

Johannes Schindelin (6):
      commit: allow editing the commit message even in shared repos
      Handle more file writes correctly in shared repos
      fetch: release pack files before garbage-collecting
      am: release pack files before garbage-collecting
      merge: release pack files before garbage-collecting
      receive-pack: release pack files before garbage-collecting

Junio C Hamano (1):
      test-lib: clarify and tighten SANITY

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      Revert "setup: set env $GIT_WORK_TREE when work tree is set, like=
 $GIT_DIR"
      dir.c: clean the entire struct in clear_exclude_list()
      Revert "dir.c: don't exclude whole dir prematurely if neg pattern=
 may match"

SZEDER G=C3=A1bor (1):
      t6050-replace: make failing editor test more robust

Sebastian Schuberth (3):
      docs: clarify that passing --depth to git-clone implies --single-=
branch
      docs: say "commits" in the --depth option wording for git-clone
      docs: clarify that --depth for git-fetch works with newly initial=
ized repos

Stephen P. Smith (4):
      user-manual: remove temporary branch entry from todo list
      glossary: define the term shallow clone
      user-manual: add section documenting shallow clones
      user-manual: add addition gitweb information

=C3=98yvind A. Holm (1):
      gitweb: squelch "uninitialized value" warning


I would want to see jk/list-tag-2.7-regression and ew/
svn-1.9.0-auth topics also in 2.7.x track soonish, but they
currently are still in 'next', so perhaps late this week or early
next week?
