Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA47F1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 17:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeIWXOk (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 19:14:40 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:42520 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeIWXOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 19:14:40 -0400
Received: from [91.248.182.11] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1g47zf-0002xf-2D; Sun, 23 Sep 2018 19:16:27 +0200
Date:   Sun, 23 Sep 2018 19:16:26 +0200
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
Message-ID: <20180923171626.GN26251@vis>
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
 <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
 <20180903190114.GC17416@vis>
 <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rzq/nSLlHy1djmXS"
Content-Disposition: inline
In-Reply-To: <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Rzq/nSLlHy1djmXS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Phillip Wood <phillip.wood@talktalk.net> [2018-09-13 11:20]:
>Yes in the long term we want to be able to coalesce edited hunks, but I
>think it is confusing to call coalesce_overlapping_hunks() at the moment
>as it will not coalesce the edited hunks.

I would see it as a first step into that direction.

>I think that if you split a hunk, edit the first subhunk, transforming a
>trailing context line to a deletion then try if you try to stage the
>second subhunk it will fail. With your patch the edit will succeed as
>the second subhunk is skipped when testing the edited patch. Then when
>you try to stage the second subhunk it will fail as it's leading context
>will contradict the trailing lines of the edited subhunk. With the old
>method the edit failed but didn't store up trouble for the future.

Agreed. I guess the question is if you assume a hunk to be applied or=20
skipped as the default. You can still find enough cases where neither=20
the current nor the patched version works. I stumbled upon the one case=20
where I wanted to stage only one part of a split hunk and that one=20
worked after my patch. I leave it up to you if the added benefit=20
overweights the stored up trouble.

Cheers Jochen

--Rzq/nSLlHy1djmXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlunymYACgkQW//cwljm
lDNDUQ/+Nmm864q3ENQx4eZ37GZ/2gUs+Vbea5G3cXUvtxDx+Y5vFR7DcHnX2kPn
gbu55CNDltJVIccLo7UHDGKkOd7MKvUiEIL9K9Hj+Ou7hEQMAAS6cQmzti/zxsgj
OOOyLRXdqmIckDNAvGNigEV+WnVpwidQAjzuq4P/ISRlBDycFaJaaFOOSTD+r/5/
TZK4f0oEK9C4yxUjUeW4UJeTv9pzZHdDy96pw6oOMg2iuFq5ve3UoW6/pHSVdqks
SZ+a7mP91u+wy6N8SpYrtYGey8kggyDbNt4DAP7TXZFOFiiar23U75TG2oDwKVTQ
EtWYkFatm7WVHJoqV/7JZ2DHGz45MqismBGDfBOllX5neGexgmtaTzCS23VuMfC4
p5FvHds7bHisjNAHSpO4ajymcrmqE7SoHzz5hP/HyvjWuoMOx1U0QN/H/6j3AFhX
hcrFzKZtqBPygc8hyfoU9GxyW94cSb0sn7GvLYMC1T89Xh1Wry5ooaqHz/0Lwu2s
EWSovxHUTVGbBcwuOrzdFPvDkCAG0PEXiPOZuICBiamCxPSqP5DMb2cj3ilSM7ox
14xWnjWEia3Fu5Lr5r8eD1yY1hKykepe9LSk24mT4DzxFYsXQnQYMiNHYSw+DB5j
Qjhh0e36u5upMp8SCCe0Zu8bcjs1gMRlgMxmwjHl22EutWwRRgY=
=otEv
-----END PGP SIGNATURE-----

--Rzq/nSLlHy1djmXS--
