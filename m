From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Mon, 28 Apr 2014 16:04:28 -0700
Message-ID: <xmqqsioxm4xv.fsf@gitster.dls.corp.google.com>
References: <20140421204622.GA9532@logfs.org>
	<20140425182928.GA29904@logfs.org> <vpqoazpdz1r.fsf@anie.imag.fr>
	<20140425201048.GB29904@logfs.org>
	<20140426071358.GA7558@sigill.intra.peff.net>
	<CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com>
	<20140427075640.GB19976@sigill.intra.peff.net>
	<985432164.425366.1398611186431.JavaMail.zimbra@imag.fr>
	<xmqqk3a9s7fm.fsf@gitster.dls.corp.google.com>
	<20140428183244.GA6358@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:04:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeubE-0000Mv-RS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbaD1XEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 19:04:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35421 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaD1XEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 19:04:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0858F8173E;
	Mon, 28 Apr 2014 19:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yER66fhQv3wO
	9rmOsVKQFzKiTzU=; b=o2wZAbG0BjmX/k0LWZ7cYAkUTFNj/679/TYP5LhqJbde
	sPm+8H3T7V3WKYKWcO1/SmtPr/T8f1hPfJWCkxyDCo6VEwIJD+StErY4jh/U6+Va
	jeGeZJiKtl+BE9f6x/FeLmrBFLgYwWS0/G4zYjgeFafiu6dqdAjpiTRAC8ZAnP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WhFeHr
	AXre1b/SahRaXISdGWQ2WbL5Y9r9dNycWLl/dOIWzzAmI61c7qJuspk6YxrgbyzH
	DnDJsTNknYU+8xyLK7c8eUHfzxSKN/zd7VhgfKVSbFJXr99e3vbTELgLIIgLvepQ
	hamu8lyJShY1Ji+H23Q4H/FDYmSuvrKGIxlo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3868173D;
	Mon, 28 Apr 2014 19:04:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7F1B8173B;
	Mon, 28 Apr 2014 19:04:29 -0400 (EDT)
In-Reply-To: <20140428183244.GA6358@logfs.org> (=?utf-8?Q?=22J=C3=B6rn?=
 Engel"'s message of
	"Mon, 28 Apr 2014 14:32:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74071E88-CF29-11E3-96F2-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247491>

J=C3=B6rn Engel <joern@logfs.org> writes:

> On Mon, 28 April 2014 10:14:05 -0700, Junio C Hamano wrote:
>> Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:
>>=20
>> > ----- Original Message -----
>> >> On Sun, Apr 27, 2014 at 09:12:39AM +0700, Duy Nguyen wrote:
>> >>=20
>> >> > The intent of the commit was "that is a stupid thing to do, but=
 it's
>> >> > not so obvious from the first glance, do not freeze my system f=
or my
>> >> > mistake". But if it stops an actual use case, then I agree it s=
hould
>> >> > be reverted.
>> >>=20
>> >> Thanks for the explanation. I think we should just go with J=C3=B6=
rn's patch
>> >> as-is, then.
>> >
>> > Agreed. At best, the commit message could be improved to explain t=
he
>> > situation, but the patch itself is OK.
>>=20
>> True and I agree.
>>=20
>> The patch needs sign-off, though (I am looking at $gmane/246644).
>
> Signed-off-by: Joern Engel <joern@logfs.org>
>
> Or do you want me to resend with sob?

Just the Sign-off is trivial enough that even this brainless
patch-monkey^Wpanda should be able to handle.  The part "The log
message could be improved" is something you may be better equipped
to, though.

I'll tentatively queue this; if you or anybody in the thread can
proofread it to typofix it or give me a better phrasing, that would
be very much appreciated.

Thanks.

-- >8 --
=46rom: J=C3=B6rn Engel <joern@logfs.org>
Date: Mon, 21 Apr 2014 16:46:22 -0400
Subject: [PATCH] pager: do allow spawning pager recursively

This reverts commit 88e8f908f2b0c56f9ccf8134d8ff9f689af9cc84, which
tried to allow

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

and still wanted to avoid "git -p column" to invoke itself.  However,
this falls into "don't do that -p then" category.

In particular, inside "git log", with results going through less, a
potentially interesting commit may be found and from there inside
"less", the user may want to execute "git show <commit>".  Before
the commit being reverted, this used to show the patch in less but
it no longer does.

Signed-off-by: J=C3=B6rn Engel <joern@logfs.org>
Reviewed-by: Jeff King <peff@peff.net>
Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Acked-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index 0cc75a8..53670a6 100644
--- a/pager.c
+++ b/pager.c
@@ -64,7 +64,7 @@ void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
=20
-	if (!pager || pager_in_use())
+	if (!pager)
 		return;
=20
 	/*
--=20
2.0.0-rc1-219-gf8dda7a
