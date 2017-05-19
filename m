Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13F72023D
	for <e@80x24.org>; Fri, 19 May 2017 14:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755037AbdESOhb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 10:37:31 -0400
Received: from kitenet.net ([66.228.36.95]:41184 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754058AbdESOha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 10:37:30 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1495204647; bh=H9uPrJt5bptlEkE9s1VFfqkeB2W2hGEGNVUSvMD0J8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQ3+o4C8amcxhj8QitqAQwxcM9UVBtCGjPwnnT3oKP1ruJx62jrNbY4LAccVJoX/N
         zAthsDt8CAP7qf2QSjvBjBjeFPTB9CYcL6vq09kS6kfEDsM+aLtI8AlMsoSmW5Cezo
         W7ggTeF3FWxBb1wEXxfWeOoKWwdp8ksVBk6pyg4o=
Date:   Fri, 19 May 2017 10:37:27 -0400
From:   Joey Hess <id@joeyh.name>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Peter Simons <simons@cryp.to>
Subject: Re: reversion in GIT_COMMON_DIR refs path
Message-ID: <20170519143727.edi4ni7v5pywm7dk@kitenet.net>
References: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4rushcifptuz6g4v"
Content-Disposition: inline
In-Reply-To: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4rushcifptuz6g4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess wrote:
> Bisecting this test suite failure
> https://git-annex.branchable.com/git-annex_in_nixpkgs_fails_with_git-2.13=
=2E0/
> I landed on commit f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0 to git.
>=20
> It seems that changed resolving refs paths when GIT_DIR and GIT_COMMON_DIR
> are both set. While before refs were looked for in GIT_COMMON_DIR,
> now they're not.

In case there's any doubt about whether this is a reversion or an
intentional change, see gitrepository-layout(5):

       refs
           References are stored in subdirectories of this directory. The g=
it
           prune command knows to preserve objects reachable from refs found
           in this directory and its subdirectories. This directory is igno=
red
           if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/refs" will be used
           instead.

So the documented behavior is broken.

--=20
see shy jo

--4rushcifptuz6g4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlkfAycACgkQ2xLbD/Bf
jzjNrg/+IvpdO0l7xi3JqYD4nQYU8OE5LWZB11H0rxV6G9ZHFiuf7tKB+Msfefi3
kepKc5pLvuGGGhTfB/oxUTaHlKVGK33GTrT9mbJXNOhU9cmMaWedgDXLES/wKhat
HrqjoOfVF/+uN79dcX9NsoSmirH36QbK8VbdwnRCL6UdIQA0PeUPszQm7iTyTAKJ
8E/mQ4Dh3+VFrVxCbrLCwm9lXZu+FTY8PPS2us9jAEAQxNFkpj6b9NGyUi1PeeLV
zldikSNZr3M2UR4kawo+50HIjJzN2iCuuW17k/ceeI6wZXmXgAnO7kZanxkWPSdC
jhSvWSRCR8KN0ptkTwvDEC7s3X5jhep6zpctSzosm46HWoYXEdTW0JHKLPHLmNs9
LlPpFxFOOq3tsbwtGntVO3X7u+0C13LrmkFary4ssPrMWtqsvlM438tQDxMR9Nvn
bY3oljoSHeGF0oKvOclpJ8e0cc+TrxIGsqtUMUkSuffhjYj3JH5NTHxMd5pnGTZt
GwxsCv1oLToohD/xrLjAKl3gRyWmoh+Oi2XfwWbrmgPMBIW+tHJP2QJcwFBome0Z
uGpeepsAP/J2+p0ckyniGbXhFqGqy8qynKxcIknFbN6mbgwmOgT0ZIFl2TI5tj28
2Dmo4N+brYciwAefOFtsyQ98Ay79/RlBbr2duyK4Wv/wTfLuysM=
=Gicv
-----END PGP SIGNATURE-----

--4rushcifptuz6g4v--
