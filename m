Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AD820373
	for <e@80x24.org>; Mon, 13 Mar 2017 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbdCMXTm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 19:19:42 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36268 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbdCMXTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 19:19:40 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so51835546wma.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2gFl6H7u/9YaRhJD1GC9uZ6FX/KdnLoIBV4Nmjq1h8=;
        b=Pd0uJNTrt0Q+MR/jUHDgl/kl8xAtRE5K/fcOerdfFJghSKE27CI+cqy1nj+Gj0SSst
         wvu+GHg/aYI5Ylg6rX9VIj+oRF/dqxStJHW3fJM5tY/cC54+imxyNbUeM/uD9VpI+uhq
         7g6mhNXdNJnBaurYYDhhqeg4x5ylP2A2lNc/E3Z34uV/OfbLS3rlOn5N1tXtNdho2Hau
         mAcUP8B6ul8o9tO9Cfj8ez64Zb3y38JfGpegpMAEFuzDVhnRqoHjxJ5q9M3WoClcJM1c
         P5WIy9VwyO+jPWdFcc/tcOzYn0kIHGp6NP3NmVBbLWWyXFWNzl8NgfHQYDKkuNJnYRJx
         qNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2gFl6H7u/9YaRhJD1GC9uZ6FX/KdnLoIBV4Nmjq1h8=;
        b=ALe7TaG8yz7S2SUPpxD/OaK+pNCcmqx+EinZWDRr5lLHeEyYehzqIDZ/iiQkKGaHr4
         iTrlno1cc75o2q9O6a3NzcFMPghtFAMbyi58GFxacVc+sfzHZwzFM1UN+lY1UIR8j5QF
         AcegHFDoUj0bFKRscmdwhl4POdT1ZmK6F4mi3kNhrbvEjpt7Q2u2mC1p1E8ymVnG0aoO
         62rjg4xDUvqbD8WR0M5qpagsBYqErGAO507lWHoDGnQ6kqU4ncT3hCNBT9bUNpeg2YuY
         6VXEFUGElQcvx37nJIN0kSud3gNQ1NDOOhYedE3sE16dNBvSRwfuWSzqOue2cDB24qHb
         8xXg==
X-Gm-Message-State: AFeK/H3+sx7ZS5ER4+b5yJpAFh/IuEH7ITUpqLiaeqSDk1ub6n1biyPDNd70EoW9ETcV5g==
X-Received: by 10.28.143.204 with SMTP id r195mr11644370wmd.32.1489447178430;
        Mon, 13 Mar 2017 16:19:38 -0700 (PDT)
Received: from workstation ([213.149.51.172])
        by smtp.gmail.com with ESMTPSA id 17sm26785850wru.16.2017.03.13.16.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 16:19:37 -0700 (PDT)
Date:   Tue, 14 Mar 2017 00:19:35 +0100
From:   Domagoj Stolfa <domagoj.stolfa@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
Message-ID: <20170313231935.GA51164@workstation>
References: <20170313201104.GA32821@workstation>
 <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
 <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
 <20170313214400.GA98717@workstation>
 <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
 <20170313230810.GA80865@workstation>
 <xmqqtw6wlqf8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <xmqqtw6wlqf8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > Thanks for clearing this up. Is this documented somewhere, so that if i=
t happens
> > again I can point people to the docs that explain this behaviour?
>=20
> Is this from "git blame --help" sufficient?
>=20
>     When you are not interested in changes older than version
>     v2.6.18, or changes older than 3 weeks, you can use revision
>     range specifiers  similar to 'git rev-list':
>=20
>             git blame v2.6.18.. -- foo
>             git blame --since=3D3.weeks -- foo
>=20
>     When revision range specifiers are used to limit the annotation,
>     lines that have not changed since the range boundary (either the
>     commit v2.6.18 or the most recent commit that is more than 3
>     weeks old in the above example) are blamed for that range
>     boundary commit.

re-reading it post your explanation, it seems to make perfect sense. Thanks
again for the detailed explanation of the behaviour!

--=20
Best regards,
Domagoj Stolfa

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHQB+y96lmmv+IXofwxT+ikb0YU4FAljHKQcACgkQwxT+ikb0
YU5wQAf/XG85DCqhEs0ME1zcQINleLdc9HtTw4cb2wsBffRC30BiLJZLh3jj5Dsp
dngt6E81C+G169vA1bURWdJn2L5X/E4GpSu/22L3jF+09HFijZkRnQYHfpAmGJle
g3vCPvTNPj/tLE7R6UPGWB0Vn+YyFCbo2HSk3TW24rSK3b0D7GTojnPz96f/vV1p
dTrQlstlABlWMFKGdec7N0jbTdCT4tf7Z/V3RQpdvwawnwnMk/20GXT8Iu8ZyLTL
f8csnxCtOH/GyAtuqaXaOmKSruyzHU7fn07kG6DXZtHdU0LJAfk+SWe3MqN0cybA
RY+dij3L7FgdDBiW1tmWnyNXyaSsTg==
=+czz
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
