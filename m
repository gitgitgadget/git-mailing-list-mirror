From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] git p4 tests and a few bug fixes
Date: Tue, 21 Jan 2014 16:03:35 -0800
Message-ID: <xmqqfvogsx0o.fsf@gitster.dls.corp.google.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 01:03:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lIH-0000sH-J9
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbaAVADl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 19:03:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaAVADl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 19:03:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 304DC66911;
	Tue, 21 Jan 2014 19:03:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zGLVu3oqXrrF
	3ymEYRA75I95uqs=; b=XzFqMWpZvYd4D42m0Vne4DRfqGelJGxqDuBDPe4B5UIB
	B8pnezrF7K+TVWxppwEW2QHTF++u+mNgFvZwBA+Tb+AIFXtW8pdPqAfhxXVPgqEW
	hDRlqG6+XAH7RDGleDIljjJM+WBKFzRGHgtHrjDxkg0u4mMoIYWxIJh2WXaIHY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ki2pJ2
	TfrwhHSYZvwU5qp2ZMBM3V7yjwVnekRdDrm/LEZ7aPlCu2FvztGTeVijPDs+Vtuc
	7AbuwiDvHuvAoofaR8De8juuqRK2MS7+wtCDzI+3VTkQE62oo9J3DILM93RJ/kG4
	fuHabnq06kX8ey7JyokOP/PspLS8+2wGvKyY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07EB566910;
	Tue, 21 Jan 2014 19:03:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A1F66690E;
	Tue, 21 Jan 2014 19:03:38 -0500 (EST)
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com> (Pete Wyckoff's
	message of "Tue, 21 Jan 2014 18:16:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A572F974-82F8-11E3-BF4D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240805>

Pete Wyckoff <pw@padd.com> writes:

> Most of this is work on tests for git p4.
>
> Patch 03 is a regression fix, found and narrowed down thanks to
> much work by Damien G=C3=A9rard.  But it is obscure enough that I'm
> not proposing it for a maintenance release.
>
> There are a couple other behavior fixes, but again, these
> are quite minor and can wait for the next release.

Thanks.

I am inclined to say that we should queue this on a fork from
'maint, merge the result to 'master' before 1.9-rc1 and ship the
result as part of the upcoming release, and then possibly merging
the topic to 1.8.5.x maintenance release after that.

This is primarily because I personally do not have p4 expertise to
test or properly judge this (iow, you are the area maintainer, the
authority), and I somehow have this feeling that parking in 'next'
for extended period of time would not give meaningfully larger
exposure to the code.

What do you think?

If you feel uneasy about such a fast-track, I wouldn't push it,
though.

> Pete Wyckoff (11):
>   git p4 test: wildcards are supported
>   git p4 test: ensure p4 symlink parsing works
>   git p4: work around p4 bug that causes empty symlinks
>   git p4 test: explicitly check p4 wildcard delete
>   git p4 test: is_cli_file_writeable succeeds
>   git p4 test: run as user "author"
>   git p4 test: do not pollute /tmp
>   git p4: handle files with wildcards when doing RCS scrubbing
>   git p4: fix an error message when "p4 where" fails
>   git p4 test: examine behavior with locked (+l) files
>   git p4 doc: use two-line style for options with multiple spellings
>
>  Documentation/git-p4.txt           |   6 +-
>  git-p4.py                          |  17 +++--
>  t/lib-git-p4.sh                    |  23 +++++-
>  t/t9802-git-p4-filetype.sh         |  83 +++++++++++++++++++++
>  t/t9805-git-p4-skip-submit-edit.sh |   6 +-
>  t/t9807-git-p4-submit.sh           |   2 +-
>  t/t9809-git-p4-client-view.sh      |  16 ++--
>  t/t9812-git-p4-wildcards.sh        |  50 +++++++++++++
>  t/t9813-git-p4-preserve-users.sh   |  38 ++++------
>  t/t9816-git-p4-locked.sh           | 145 +++++++++++++++++++++++++++=
++++++++++
>  10 files changed, 342 insertions(+), 44 deletions(-)
>  create mode 100755 t/t9816-git-p4-locked.sh
