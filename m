Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389C72018E
	for <e@80x24.org>; Sun, 10 Jul 2016 15:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbcGJPK5 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 11:10:57 -0400
Received: from kitenet.net ([66.228.36.95]:42228 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757176AbcGJPK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 11:10:56 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=C6qJ3hOO;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468163446; bh=ik/6d/mKGwpOir8XvSfwzPOhJeGbPOCq8l4ng3AkiA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6qJ3hOOV5WDerbBfzAVCZ+18z5/KJCfXp2bMi6Fjk7G+tm073DA8+gMEzLzTLneQ
	 Hhu+j++P1VgOSriQcelI71/NPsIgRF15MS8FZCeu5ES2abGgJP0RmkGKju0diFGkA8
	 1ghxXM5317vue6oBB0PmLi4GToy4I0rP01lr2000=
Date:	Sun, 10 Jul 2016 11:10:46 -0400
From:	Joey Hess <id@joeyh.name>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, joeyh@joeyh.name, pclouds@gmail.com,
	Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: Re: [RFC] Long running Git clean/smudge filter
Message-ID: <20160710151046.GA7306@kitenet.net>
References: <1468150507-40928-1-git-send-email-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1468150507-40928-1-git-send-email-larsxschneider@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

larsxschneider@gmail.com wrote:
> (2) Joey's topic, which is the base for my patch, looks stalled for more =
than
> 2 weeks:
> http://thread.gmane.org/gmane.comp.version-control.git/297994/focus=3D298=
006
> I would be happy to address Junio's comments and post a reroll. However,
> I don't want to interfere with Joey's plans.

I've been on vacation and plan to get back to that in the upcoming week.

> @Joey (in case you are reading this):
> My patch changes your initial idea quite a bit. However, I believe it is =
an
> improvement that could be beneficial for git-annex, too. Would you prefer=
 to
> work with me on the combination of our ideas (file clean/smudge + long ru=
nning
> clean/smudge processes) or would you prefer to keep your interface?

Long running filters mean that you need a more complicated protocol to
speak over the pipes. Seems that such a protocol could be designed to work
with the original smudge/clean filters as well as with my
smudgeToFile/cleanFromFile filters. Assuming that there's a way to
tell whether the filters support being long-running or not.

Note that the interface we arrived at for smudgeToFile/cleanFromFile is as
similar as possible to smudge/clean, so the filter developer only has to
change one thing. That's a big plus, and so I don't like diverging the
two interfaces.

So, I don't want to entangle these two ideas very much.

--=20
see shy jo

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV4JlcMkQ2SIlEuPHAQKEWA//VfPpiVOGyxZemJhpsPWI1HJJW3dDcPiQ
Bsa+v6XjkogCHvyeb3o39HiDnyoSdGCTPSZJcvWdpqADQ73yjlFV6JhtMr87C/p2
IBy0AZchoTeNJ5smPnj+YlHlseEMZH18xZUOOCcoNyYL/15xaXe0L+jwKVinBKDb
FeiLcOpVVU0+CfPjj1hTOxvt11tNBv+k7FCy9Q4C6G+yL6R/wM18KLZU8dvhQxrN
a4R5x001NsFQXDrEyCbEe6HZ8ijMWV7QO5J5p/akeZLp/pZcS7remnXFxmd+7MvL
doPQ+wgZHh+YaGwjbhUxn5vQblEb0Can764+ftc7CY+5kt6KdfKqkOLK+1kUQpXr
1UWDoGSESQFLCh+KNRwzVcUTMo1VBeL7MyPJY8Pjo0QQpsr41sIxl9n3y13l59JA
W4zsswQNbB1YR+hoGHGYGIxm2O+PDBepC1GFfgWDxws2/p4Vrz4vKagobL2U8IMw
/dF5WPFiQemHFBVXdY1Tr4N4PrvGtfam77y6PM+wZz9Y/+h+0gACi8PeumoBMDce
iliRvddu7iNS1MgLQAIhFV4G2DHF1fLgt68pv7cZhWnuDktiKYAm64iy2QOaAH9u
N7yI/VAh+PzK5gJZYz11VEatMz9Q2D95Y65aG5/tXIJbm7SNvsRmLHKw35p+U+UC
AzIC1MrWC+g=
=uP2C
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
