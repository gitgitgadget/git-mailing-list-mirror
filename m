From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of .git/modules/*
Date: Mon, 08 Feb 2016 15:50:33 -0800
Message-ID: <xmqq4mdi69ti.fsf@gitster.mtv.corp.google.com>
References: <1454790889.23898.225.camel@mattmccutchen.net>
	<xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
	<1454971010.2511.89.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:50:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSvZo-0003sY-6j
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbcBHXug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 18:50:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932481AbcBHXuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 18:50:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB9CC433EF;
	Mon,  8 Feb 2016 18:50:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OPwhHi3iw4km
	L+wu8JSfjFjVE+A=; b=jqRtW0PZsFN97Qh9ptnGLqCptyWqQmtQDYhrSSCorUm2
	bKq50Ui0QZIuKvBBJY2Ywy+Bh7NwR0XGy2S3q6CZz9WT7u57/Rgkk7wAZVvw8Gko
	N8Ll0rEsP+Qkl1WIoEZawsvoohJFagwJgu8buZgcE1kJqM8LhM8m0124YYCOjVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Pv6fwr
	8dfedUFGmlNkkjHi/PR3Ur8I51PlSXnGJFO6KlT8sojM3HBoJT9EvF1+rCxNP6QX
	xoLko4tm1nhyLiXGTeauAbSOkj+T+bTvMO4X3q9y/y5hY/5SA5ThvLZxMZTesFBb
	H35NiJ/B6rkm4+nnwLQjZXIuD8Je348J7g4ZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2705433EE;
	Mon,  8 Feb 2016 18:50:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2EF9A433EB;
	Mon,  8 Feb 2016 18:50:34 -0500 (EST)
In-Reply-To: <1454971010.2511.89.camel@mattmccutchen.net> (Matt McCutchen's
	message of "Mon, 08 Feb 2016 17:36:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BEA1D15E-CEBE-11E5-91F6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285827>

Matt McCutchen <matt@mattmccutchen.net> writes:

> On Mon, 2016-02-08 at 14:22 -0800, Junio C Hamano wrote:
>> Matt McCutchen <matt@mattmccutchen.net> writes:
>>=20
>> > I found no evidence of such behavior in the source code.
>> >=20
>> > Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
>> > ---
>>=20
>> That was added last year at bcd57cb9 (Documentation/git-clean.txt:
>> document that -f may need to be given twice, 2015-02-26).=C2=A0=C2=A0=
It would
>> be better to know what got changed since then--that is, was the
>> additional text unnecessary even back then, or we made changes to
>> the system since then and forgot to remove the added text.
>>=20
>> Mikko, is this need to give -f twice still the case?
>
> I know you probably want confirmation from Mikko, but I'll offer my
> understanding. =C2=A0There were two statements added in=C2=A0bcd57cb9=
:
>
> 1. -f may need to be given twice to delete nested worktrees and
> embedded repositories. =C2=A0This is still true.
>
> 2. Deletion of submodule repositories under .git/modules is condition=
al
> on -f being given twice. =C2=A0AFAICT, this was wrong even back then:=
 "git
> clean" has never deleted such repositories under any conditions.
>
> My patch is only removing #2.
>
> Matt

Thanks for clarification.

"The latter half, the removal of the submodules, was never done with
double -f back when the sentence was written, and we still do not do
so." or "Back when the sentence was written, we used to require
double -f, and we fixed that at commit X but forgot to update this
text." are two possibilities, and either one explains and justifies
this change even stronger than "There is no code to do such thing in
today's version." and that is where my question came from.
