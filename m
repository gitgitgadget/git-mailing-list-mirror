From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4151 missing quotes
Date: Mon, 09 May 2016 13:45:10 -0700
Message-ID: <xmqqmvnzt0yx.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 09 22:46:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs3S-0000CT-Vs
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbcEIUpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:45:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbcEIUpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:45:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FB341AFC0;
	Mon,  9 May 2016 16:45:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZRGqQ2PmeUVlhnIZlRz4663j7BY=; b=cRd6KA
	BUVTF3Ge69sfq+36UQ8KmrKKUa2plyClNJd8NQF67BbAq8HcscdrBDVLp9V7bU5V
	YQKoOMYWlnJqB9y4eHoM0tCKZJboWCb5l/LyQxaM58sReVmAtnRHM6fN0PLgV2qN
	0ot9GmXeg6K1JZgkvWZnEJA/emy4CIrtkmjzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsIZCI/KU1v9gwTDG/FwdpXz/xAlW7uA
	WwoZflW06QDfxCNiNuum01thSpa5vgE1FN5CYmzpYLcg0+R39vVily9Y/xyPRzpD
	Bs9dkZb0fi+LnYgJjUD9Z1DksWmZ+TT4MdU0HvurLQTa4txVyEXeEZW+u8b9IASg
	wIFk1gHdvJ0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0795F1AFBF;
	Mon,  9 May 2016 16:45:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84D441AFBE;
	Mon,  9 May 2016 16:45:12 -0400 (EDT)
In-Reply-To: <CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 9 May 2016 16:16:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED348840-1626-11E6-8EEA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294049>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 9, 2016 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Something like this follows Documentation/SubmittingPatches [...]
>>
>> -- >8 --
>> From: Armin Kunaschik <megabreit@googlemail.com>
>> Subject: t4151: make sure argument to 'test -z' is given
>>
>> 88d50724 (am --skip: revert changes introduced by failed 3way merge,
>> 2015-06-06), unlike all the other patches in the series, forgot to
>> quote the output from "$(git ls-files -u)" when using it as the
>> argument to "test -z", leading to a syntax error.
>
> To make it clear that this was not a syntax error in the typical case,
> it might make sense to say:
>
>     ...potentially leading to a syntax error if some earlier tests failed.

Hmph, do we have a broken &&-chain?

If an earlier test fails and leaves an unmerged path, "ls-files -u"
would give some output, so "test -z" would get one or more non-empty
strings; if we feed multiple, this would fail.  But we would not have
even run "test -z" as long as we properly &&-chain these tests.

I think the real issue is when the earlier step succeeds and does
not leave any unmerged path.  In that case, we would run "test -z"
without anything else on the command line, which would lead to an
syntax error.

    Side Note: /usr/bin/test and test (built into bash and dash)
    seem not to care about the lack of string in "test -z <string>"
    and "test -n <string>".  It appears to me that they just take
    "-z" and "-n" without "<string>" as a special case of "test
    <string>" that is fed "-z" or "-n" as <string>.  Apparently, the
    platform Armin is working on doesn't.

Perhaps

    ... leading to a syntax error on some platforms whose "test"
    does not interpret "test -z" (no other arguments) as testing if
    a string "-z" is the null string (which GNU test and test that
    is built into bash and dash seem to do).

would be an improvement?
