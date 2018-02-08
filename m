Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A2D1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHPiE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:38:04 -0500
Received: from kitenet.net ([66.228.36.95]:38402 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbeBHPiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:38:02 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2018 10:38:02 EST
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1518103840; bh=oo1PkNAlcr5RycBYBkA4kguVRzf1G86XXIW7IKn6rrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPVzGpPou2t0Z+Uund5YP/NtPYM9f3MWtwTtS1fwM4OKIn+Ghx1xmAmQCMlZhVe5+
         IFh1SrJaZBegYvjqNjCUulXQThpvO+6DTEIDhzkEaSt9ogXwucdWpeT/51pBluzqCq
         CJ55fGmq+/mzjNfimYAW1GK5iPUpZOn4oOnIgWIs=
Date:   Thu, 8 Feb 2018 11:30:40 -0400
From:   Joey Hess <id@joeyh.name>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Fetch-hooks
Message-ID: <20180208153040.GA5180@kitenet.net>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Leo Gaspard wrote:
> That said, I just came upon [1] (esp. the description [2] and the patch
> [3]), and wondered: it looks like the patch was abandoned midway in
> favor of a hook refactoring. Would you happen to know whether the hook
> refactoring eventually took place, and/or whether this patch was
> resubmitted later, and/or whether it would still be possible to merge
> this now? (not having any experience with git's internals yet, I don't
> really know whether these are stupid questions or not)
>=20
> PS: Cc'ing Joey, as you most likely know best what eventually happened,
> if you can remember it?

I don't remember it well, but reviewing the thread, I think it foundered
on this comment by Junio:

> That use case sounds like that "git fetch" is called as a first class UI,
> which is covered by "git myfetch" (you can call it "git annex fetch")
> wrapper approach, the canonical example of a hook that we explicitly do
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> not want to add.
  ^^^^^^^^^^^^^^^

While I still think a fetch hook would be a good idea for reasons of
composability, I then just went off and implemented such a wrapper for
my own particular use case, and the wrapper program then grew to cover
use cases that a hook would not have been able to cover, so ...

--=20
see shy jo

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlp8bR0ACgkQ2xLbD/Bf
jzioew/+LHaQHpjBUQ3GkK/UoBjDGh2GjyKo65coBVeY1ixK5Qh2AeKmG0sXP4m0
z22Lq5BxbqbkRJ/Z28+Q32Ih+VN4me0RyHDuIt75+J6E6npHSUGUYm0Sb89prdpz
Ce5dVC9+DE6Cajo5l83EFNjJiMz6tMyI0uLazGiFy4fzGAt4wIKVXJcKK4j4Q7i0
wOf/YmJevbaQqdE36+fz/w1Mu6FAjqXnyTOJNZsEsWDesRwzZiUnNCd4RsF5lko0
ctcPxKU+JeOFDYj6MlDkWhhokM+IJh/Mik7TRWAyGuN3sHJlwml67EToWOCsKEAS
fTjbcsYivhPLGMrm/4gv/9jqvohVL56TXMF8nd4kMUU9/Rn9NrBcH1FfS2eSwc7J
k/24KXwSW3bq3sGXIEVuvfFldjMTaZIZd0NJMolWP4yrJOMJReweS0YZ9SsOHdmh
BNhmEOh5WmBoGtlF2uBpARu24E9U4+FJ3YzY3tii5IqCpiL1gq1+h/Ont0Id+lUe
BoQSu68mtXd2uy6QiO8R84av3KSB3WISBkUEKcWCPiHhZnXta/E5r3gw1POvOxz4
DmzRNQ5f4qA3l6JnUgSDaT/uHCAj2BhkvV7j6L0iMLxVy6sgGcBVoWKIH4eQPrHv
t2QyZr2LQLmcNRv0H1q/B328KOZbNj+08ar5U+nyH0h4w1nYqsI=
=nal8
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
