From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 15/18] the beginning of the signed push
Date: Wed, 20 Aug 2014 02:48:01 +0000
Message-ID: <20140820024801.GA198803@vauxhall.crustytoothpaste.net>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-16-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 04:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJvwa-0001ro-R0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 04:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaHTCsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 22:48:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49648 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751967AbaHTCsH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 22:48:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 936872808F;
	Wed, 20 Aug 2014 02:48:05 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1408485987-3590-16-git-send-email-gitster@pobox.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255548>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 03:06:24PM -0700, Junio C Hamano wrote:
> While signed tags and commits assert that the objects thusly signed
> came from you, who signed these objects, there is not a good way to
> assert that you wanted to have a particular object at the tip of a
> particular branch.  My signing v2.0.1 tag only means I want to call
> the version v2.0.1, and it does not mean I want to push it out to my
> 'master' branch---it is likely that I only want it in 'maint'.
>=20
> Introduce a mechanism that allows you to sign a "push certificate"
> (for the lack of better name) every time you push, asserting that
> what object you are pushing to update which ref that used to point
> at what other object.  Think of it as a cryptographic protection for
> ref updates, similar to signed tags/commits but working on an
> orthogonal axis.
>=20
> The basic flow based on this mechanism goes like this:
>=20
>  1. You push out your work with "git push -s".

You wrote "git push -s", but the command below only seems to understand
--signed, not -s.  It should probably be consistent.

> diff --git a/builtin/push.c b/builtin/push.c
> index f50e3d5..ae56f73 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -506,6 +506,7 @@ int cmd_push(int argc, const char **argv, const char =
*prefix)
>  		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_=
PUSH_NO_HOOK),
>  		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
>  			TRANSPORT_PUSH_FOLLOW_TAGS),
> +		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_C=
ERT),
>  		OPT_END()
>  	};
> =20
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT9AxhAAoJEL9TXYEfUvaLLDYQAL+WwOd1ImyN4Fn5MkSBDqkv
BsxtMQbnROnqKLEgkne63jAqOZvsrrNhmYKK6EylZUQwFIlWPQN8AkQhFkzrlBu3
YmA3R9oHAGgvwD5MtEKBTMKb14aYxuiwYFO3IwbuoAgyy6/AhLHirOw1cQvbm10V
qMoXpP/tn3TjwFJ96fNjIY0cxYBmGKSkHtNzc7/nWbMFyePmDNgvakrddHNZPmbj
9cPbZWbluDwxQoWe70lH2mcnIb9NndhVhbb984QHo2xdf20c0+gbSVUvldXhMp7A
8nenKHVw9cdDsiDAHvxA/fx0UxyR3oIHyDh6oTMjO93RY6tLNLhY12KB7rUKzXLX
I4TDmFecXwNgcRGK9NDAP4+SSV/BzKlMixHFHE10hASPlFksKlF8qQeQtrUCXpwg
5fVW9fHFfEtqL78JVEYGYcTudgmN6GxGlvVGacxqSDJPBjkP2/wtaP8WjnOgZrp1
xaM0yGqxcQh1ky4Wy1bg5rX5drLv3UIXK40rCwWQh89mMNhazjgzBT6t/L386A+M
nUkWuxbrMQoO20ITiOzD00kNharPjpclB5r4sT9w4U8SBEiGIhLzfbLXoCtevDap
zej41ZOiaYrkKB5EXJJxN5/DF2zowjiG9yr/yO9TvfFpARZL88N/2PLLCT1QmdNP
ksB+R343dzS/e8tTmkaj
=T27u
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
