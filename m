Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D3C1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 23:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBFX0s (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 18:26:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33764 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfBFX0s (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2019 18:26:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5B0260129;
        Wed,  6 Feb 2019 23:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549495606;
        bh=UB6t4SZCZotDQg+ufWXLGmTnS49zdVHF9Ct8xcob5wk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lzWmhHHHM+VlyuYaS7VNrWt2O4kgV/utMahq6vXG5A4vuHz7ykNqZXMddvu3p/DN/
         hdEewryNvpIlkuVvEiiiixPOZMsBx7blBiFhL6Qd8eHOzJttuGgzQpuacZjN6SLAa3
         0Gjg0qpvgznepPe87+GT179hhKsaeYnvjeRjtEIR3mLuGoKcfPvv/iCfcsR0vjnEMR
         cR3BCqSbn+M1oZpZD7bWbVNYbnffpSE0TYW08ksYP8lIz3sYqVwm6rQLHPapE35nlM
         t00Pxbmi/f5NUIMGsKd3oGFfFlNpVZd02IvV9wOTUn+jLPwIsZeKDRlFL+Y2MRpQcI
         AgrBYACji4Ud8lZh5MAsrULnmvZaFj+E6smksJfj5AhuK57YQRo03pv2t1I4bfATCs
         tWnbseZuO+WsUKUcLyew5bM7fEM6qx326WFFodbdbu0QgGh/uUpKFDzFmumJOvcADy
         V27PlEOLw7g4o5pkD8IqB4H1xNSUPET6IxvhBI8J6GR8p17dbzZ
Date:   Wed, 6 Feb 2019 23:26:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     pclouds@gmail.com, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: clear alternate shallow when complete
Message-ID: <20190206232641.GE527887@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com,
        jrnieder@gmail.com, sbeller@google.com, gitster@pobox.com,
        git@vger.kernel.org
References: <CACsJy8CvVPr+OJ04aLGDeAS-o5__x1+3cKQNuq2+qba5gw5W+g@mail.gmail.com>
 <20190205162636.128901-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <20190205162636.128901-1-jonathantanmy@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 08:26:36AM -0800, Jonathan Tan wrote:
> > It may be worth mentioning bd0b42aed3 (fetch-pack: do not take shallow
> > lock unnecessarily - 2019-01-10). I believe this is the same problem
> > and a full solution was suggested but not implemented in that commit.
>=20
> For reference, the full solution is [1], linked from that commit's email
> [2]. (Looking back, I probably should have included all the information
> below the "---" in the commit message proper.) The full solution is more
> related to shallow locks, though, not alternate_shallow_file.
>=20
> [1] https://public-inbox.org/git/20181218010811.143608-1-jonathantanmy@go=
ogle.com/
> [2] https://public-inbox.org/git/20190110193645.34080-1-jonathantanmy@goo=
gle.com/
>=20
> > The problem with dangling alternate_shallow_file is also from that
> > commit.
>=20
> You're right - thanks for noticing this.
>=20
> > When line_received is false at the end of
> > receive_shallow_info(), we should clear alternate_shallow_file. I'm
> > still debating myself whether we should clear alternate_shallow_file
> > in receive_shallow_info() in addition to your changes (which is good
> > hygiene anyway) to keep the setup steps of do_fetch_pack() and
> > do_fetch_pack_v2() aligned.
>=20
> Clearing alternate_shallow_file when line_received is false at the end
> of receive_shallow_info() sounds like a good idea to me.

I'll reroll with that change and a commit message update. I think it's
important that we get this issue fixed for the release, and then we can
choose to implement a more comprehensive solution later.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxbbTAACgkQv1NdgR9S
9ouQTg/9HXwG4PQM3Jcps4+IEG9upEZy2dAFDJ18EZzqkSPLF+PT5siIaSkjgVCl
+cbwMq3go3wOsQ8K2FXCkcxvZRY71IOGW7oucTOCUxt/1gmA3nOJlRoVMQE5OhWR
MjglVtbyT1Vc0PHwjrxCUxLXYrQ1KuB3YCrUE9DiBuJ8S5dYh0j/ZtHcplJq3Y9g
2itS2w3R33sgzbCx8t11pyO8qFRMnTOasSYfXCrCAbo1QqQS4AOIelf3rwFjUZo1
93lbin7JlsVizgjx5z9FsqBpEdI3xeYiSc1ctgGD/gQ/X90T3QSaBm+mTt7/1e3Y
q+0V50E73LiGikI1uW8Eal3W22iwk6AFXJcDKaRkcUDWsVskPHvzSL2bEN0YvBpl
IfuHjititHSAQyozKCkKjvLmYQHDu/CUsBhEHWzBYBnoiRdXOFtz4gZtThJAe4qL
+mp424FNyHFBhyaB7XJTHe0butIKdD1hSTEYhnB3l6+UWfEeVj9AlvVm4BlJciC3
J03F76Q4DJ5m8eupAeexH1qfPypQy/ZsVyQds8uT+LnHTMRDumnoeniqxkYve1NX
Iejbv9Refns2oPWeIv8cjyO6ORkIMXJGAG56HTxaCfH/WMaj1nSD8aiT8khzLHHH
kgQ5IkDtBtR7mPV6A4KGCo/dM/v2HZseyWUuIuJiQ8ehHcE3fFg=
=3Igi
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
