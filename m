From: "W. Trevor King" <wking@tremily.us>
Subject: submodule.<path>.branch vs. submodule.<name>.branch (was: Possible
 regression in master? (submodules without a "master" branch).
Date: Thu, 27 Mar 2014 14:01:07 -0700
Message-ID: <20140327210106.GV4008@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
 <5334606F.5010109@web.de>
 <20140327185405.GS4008@odin.tremily.us>
 <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R10gueRtU1pFqy+X"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 22:01:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTHQL-0004mF-7S
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 22:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbaC0VBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 17:01:12 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:52919
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755441AbaC0VBK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 17:01:10 -0400
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id ibUt1n0031HzFnQ57l19ty; Thu, 27 Mar 2014 21:01:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id il171n00k152l3L3al185e; Thu, 27 Mar 2014 21:01:09 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 300BC10DDBCF; Thu, 27 Mar 2014 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395954067; bh=krDyIOrpE4KukVQZsozc8NWiX2cAwg7ghi78O0vj0gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iU/Qk2Pubsq/kxK7fQ1km2zCEr6fWPh7VOR+cUKR9Duour33sfB3VZbpICOdRp0+D
	 1WhS8zL1RBUDsf4wnq46989VBQjOeWgbo3QATTPIki40N2+4QxLAV9OKzuifoAS38p
	 WmEQhGdAz7yPCgoUlpBBmLeaJ35OsLFrJdH+XCcE=
Content-Disposition: inline
In-Reply-To: <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395954069;
	bh=IgJm6YdbHmEv0N2qiRA6DA+DFMSkR2w1CSBUryCOiOA=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=TdaPU8JFcT2W1QfvSLCWpCUFrIeysjj5oB5OnL+YFP91d3il/JXhxE6NJq1HNW3j0
	 d7V0u70VtMAlrGWYibhYG7paY0QvbJ4/gqlDvTXH4VU5WZMjNK3xmdqLcaX5oNRyWe
	 1zwwii+/E2O6sr3zIvirTULxCPif44jLw9BK/EZ3Z97pkXZUayNNCjconfhaxrfRKN
	 9Szw2ux/PMTw1rFMSobeHhKvfzy9uXnVdGJxU8DH5lIqU8hjQX+SryC8zh1sk0zOBP
	 2sy6UuPXeKA+GvxZjnJN0nW91UQ/0b1E1g9+RxxCpUUdWPeGvrzsKjx4g8Y9mRrXWW
	 qrXUAkvrWih1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245326>


--R10gueRtU1pFqy+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm breaking this off into a sub-thread, so it doesn't distract from
the main issue.

On Thu, Mar 27, 2014 at 12:39:03PM -0700, Junio C Hamano wrote:
> There is this bit for "update" in git-submodule.txt:
>=20
>   For updates that clone missing submodules, checkout-mode updates
>   will create submodules with detached HEADs; all other modes will
>   create submodules with a local branch named after
>   submodule.<path>.branch.
>=20
>   [side note] Isn't that a typo of submodule.<name>.branch?

Good catch.

The transition from submodule.<path>.* to submodule.<name>.* happened
in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
which landed in v1.8.1-rc0 on 2012-12-03.  The first
submodule.<path>.branch reference landed a short time later in
b9289227 (submodule add: If --branch is given, record it in
=2Egitmodules, 2012-12-19), and I was probably just not aware of
73b0898d.  The second submodule.<path>.branch reference landed in
23d25e48 (submodule: explicit local branch creation in module_clone,
2014-01-26), and is just a copy paste error.  Both should be updated
to submodule.<name>.branch.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--R10gueRtU1pFqy+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNJGRAAoJEKKfehoaNkbtrOwQAKPlsY68JPCwDD4SKFsRL3v4
aNLUDnWgX0Ui1LkLDfO14BxLTjoEqr4ocDpJgztGW/rmXqTqCyhnPZqcK2tSBKxh
dhx4AijHu4VD3fvdqyNAKa2OjJl3zqytbV+EUEXIX/psbVJY734ziqnrc3X4+z0p
nQxt3Qt9kBgOLZf/2flv3jSR9CW7K43KSkvDHvC6uV/ptrcmdZbeLwbTAHtfZ1qy
TAs3DJU/TNiI1T6x9+UHc4HTo5pdjoeOlhcte+6uS8QTA1ErrU/1fjBcQMx1BcPM
/XxLpv/1oj/L8hX1LgW4gUcUfXWMkuk5jt+1MTtIkCIvAmfH+PzN9qs5vMSqtBoR
npgl1p3BjBKiuvQSlWbd+dAdmaOPz/7O/y/hI+Sfu9LhbvsQc6QKcvqHPNcx51Cq
vjOEtJ2ObmO0HGDNIL1jqaTrYxZ+QG0xap9bNIAL8231V5U8feU9IlPUOp0i3479
2Cx+pvlpGuau7F4MaSQltPDs/g9cIorzvCPUTATCAsuEvj9iw3sXpKP2DUnrcF1f
UQUZmdqtzPzQ/d9Ld4gILADl16PGiabMUUT+g+etu/TDIvrJca35tFzeg+NRl93v
mEl+KYWUoul30Ga9+ej0fGe4J2sVYOJYuehKqeHtyvWI8fxhZxjlIl123mUyeWFz
h8oY8YqyzNUpy34A4Fcw
=Ma6V
-----END PGP SIGNATURE-----

--R10gueRtU1pFqy+X--
