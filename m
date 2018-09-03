Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29D61F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeICXiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:38:14 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:64715 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbeICXiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:38:14 -0400
Received: from [91.248.57.150] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1fwu66-0001CY-VQ; Mon, 03 Sep 2018 21:01:15 +0200
Date:   Mon, 3 Sep 2018 21:01:14 +0200
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
Message-ID: <20180903190114.GC17416@vis>
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
 <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

* Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
>When $newhunk is created it is marked as dirty to prevent=20
>coalesce_overlapping_hunks() from coalescing it. This patch does not=20
>change that. What is happening is that by calling=20
>coalesce_overlapping_hunks() the hunks that are not currently selected=20
>are filtered out and any hunks that can be coalesced are (I think that=20
>in the test that starts passing with this patch the only change is the=20
>filtering as there's only a single hunk selected).

Agreed here. It would be enough to include the first hunk in the test to=20
make it fail again. Still I would see the patch as going in the right=20
direction as we need something like coalesce_overlapping_hunks() to make=20
the hunks applicable after the edit.

>This is a subtle change to the test for the applicability of an edited=20
>hunk. Previously when all the hunks were used to create the test patch=20
>we could be certain that if the test patch applied then if the user=20
>later selected any unselected hunk or deselected any selected hunk=20
>then that operation would succeed. I'm not sure that is true now (but=20
>I haven't thought about it for very long).

I'm not sure here. If we use the same test from t3701, do s(plit),=20
y(es), e(dit), it would fail later on. Can you come up with an example?

> We could restore the old=20
>test condition and coalesce the hunks by copying all the hunks and=20
>setting $hunk->{USE}=3D1 when creating the test patch if that turns out=20
>to be useful (it would be interesting to see if the test still passes=20
>with that change).

We set USE=3D1 for $newhunk already, or where would you set it?

Cheers Jochen

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAluNhPUACgkQW//cwljm
lDPgtxAAkQQhUV/NRlvFA1mRldx3nifhFfOOQ1Lvq9DH5nRO9KDVbGQNavbsG42s
LueZqhjNC1hqbsCtluYnd2lHqtk04U60SQxOs8xaiztSx+I/ujlnW7qqTe8I3w5v
Wf5qky1eDg5M16fX3eqYiUNZXoLXOOsfX/Sutyuvwi4Nlghw2vip6jUPfI6T67m5
l7uTYtEbCMhBMWuEvuoMO6bI/YwcoC3QGkMAaDHEPs/WZLQWzq+HHNBrdz2XEVRw
Cyycnb9LFFaMQBWOwD1OeYKtOMf8MFxaGKtdTpdtobaO+TEUiFveDlMwInEkFbw6
nQ2SiKOl1+mE6V50dKw/FBPcMdkLmYC+bMK16wMxUnP13/97CDkwH9jJUBokd+H8
SHbr8HIlj4HrSp400CKRU4FSmIFVE8kX1SxqCvmnqXqK6CugR24K9SfWW0Xk8X5e
6lCC+ysHybB/baTBaw4VqgX+b1idWbm3B+7cRtEYAiWsnUeD0VrDvBeND5SKcuaA
kJ6Ml+YZmx4P5jPVQy2TXngjLAO3jZmSrIHg1ytQEPqQMxtMOxpI0gGByPNPh+p4
ea2WU0nrebVA3KyIPgqhflr23mrEbkbN/wkiihQ+c0pzrI9q8x7sgTviDspwlf8l
ZBG61z/zNhWRx4CK+hBJOiLBdl98ydn+ZvmwVM4XbnjfbwZ57GQ=
=RFw7
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
