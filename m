From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 00:36:16 +0200
Message-ID: <20070830223616.GA29200@artemis.corp>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2oS5YaxWCcQjTEyO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Reece Dunn <msclrhd@googlemail.com>, Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQsci-0000bB-6A
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbXH3WgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXH3WgU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:36:20 -0400
Received: from pan.madism.org ([88.191.52.104]:38844 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbXH3WgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 18:36:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A1B381C812;
	Fri, 31 Aug 2007 00:36:17 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BA1D031098C; Fri, 31 Aug 2007 00:36:16 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>, Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57083>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2007 at 10:14:04PM +0000, Junio C Hamano wrote:
> "Reece Dunn" <msclrhd@googlemail.com> writes:
>=20
> > Why is it easier? If you have a fixed-size buffer, why not use
> > strncpy, which is what a safe string API is essentially doing anyway?
>=20
> I would not claim unchecked strcpy is good -- we obviously would
> want to fix them.
>=20
> But at the same time use of strncpy, strlcpy and friends solves
> only half of the problem.

  Actually, strncpy solves nothing as it's completely broken in so many
ways: it does not necessarily ends the string with a NUL-char, and it
NUL-pads the buffer, making it really slow when you use it top copy 10
chars in a BUFSIZ-big buffer.

  strncpy should never ever be used, few programmers understand it, and
it's very error prone.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG10ZgvGr7W6HudhwRAl9mAJ0XRW1Tm7gXCRWhqzCJ7qRNKPYnOgCeO5Ol
ANt0J32GKbQN/sz/iT/3Wj8=
=CdF3
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
