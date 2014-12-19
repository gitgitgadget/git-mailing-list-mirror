From: Beat Bolli <bbolli@ewanet.ch>
Subject: Re: [PATCH 4/5] update_unicode.sh: Make the output structure visible
Date: Fri, 19 Dec 2014 16:43:51 +0100
Message-ID: <549447B7.8070602@ewanet.ch>
References: <1418999971-21548-1-git-send-email-dev+git@drbeat.li> <1418999971-21548-4-git-send-email-dev+git@drbeat.li> <20141219152211.GA16967@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PBTEUKQOs60UJxVTNvtXOIjrcMiInbcHr"
Cc: git@vger.kernel.org, tboegi@web.de
To: Jeff King <peff@peff.net>, dev+git@drbeat.li
X-From: git-owner@vger.kernel.org Fri Dec 19 16:40:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zfE-00012L-82
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbaLSPkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:40:20 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:59268 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaLSPkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 10:40:19 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 7B9E1C343E;
	Fri, 19 Dec 2014 16:40:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 55D57C3447;
	Fri, 19 Dec 2014 16:40:14 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141219152211.GA16967@peff.net>
OpenPGP: id=506A903A;
	url=http://drbeat.li/pubkey.asc
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261564>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBTEUKQOs60UJxVTNvtXOIjrcMiInbcHr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.12.14 16:22, Jeff King wrote:
> On Fri, Dec 19, 2014 at 03:39:30PM +0100, dev+git@drbeat.li wrote:
>=20
>> By using printf instead of the echo/uniset sequence, the final structu=
re
>> of the generated file becomes obvious.
>=20
> This whole series looks pretty sane to me, and the result is easier to
> read.
>=20
> I did wonder if a here-doc would be even easier than a PDF, like:
>=20
>   cat >$UNICODEWIDTH_H <<-EOF
>   static const struct interval zero_width[] =3D {
>     $(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD | grep =
-v plane)
>   };
>   static const struct interval double_width[] =3D {
>     $(uniset/uniset --32 eaw:F,W)
>   };
>   EOF
>=20
> The nice thing is that <<- will strip leading tabs, which means you can=

> indent properly to match the surrounding code. I don't know if you find=

> the in-line $() more readable or not, though.

I think the code looks much nicer with a here doc.

Checking in t/, it looks that there's no consensus about whether to
indent the content relative to the cat statement or not. What do you
suggest?

> I think either way it is an improvement over the current state.

Thanks!

Beat



--PBTEUKQOs60UJxVTNvtXOIjrcMiInbcHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlSUR7cACgkQMEuTz1BqkDq5IACgngm3fHayAc/LJxal38KV0ogE
7toAoI0BXbHa79F8hSY3dQMDQg86APTw
=vraU
-----END PGP SIGNATURE-----

--PBTEUKQOs60UJxVTNvtXOIjrcMiInbcHr--
