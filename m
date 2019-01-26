Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484541F453
	for <e@80x24.org>; Sat, 26 Jan 2019 01:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfAZBGg (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 20:06:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34212 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBGg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 20:06:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so12818770qtp.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 17:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ywnzIt1rq5TMK3nXkOe+8fRxFi8bT6yknIbfdkVkxc=;
        b=d/DI0IRA6jcpjOSmIwnhGNagUpwOnmUpaN+2RKtIaa/8FtOrqegwuDxa7bSeN7O0He
         3vYtm2shqQhOw/Y9L1r84kq2X8/+vtmIHpOkaE8SIzX2Y1PpHspYpIBUGcUZF1pQcEz4
         cuWWAmXP0WlBJnVPtKzL6/oZdTYrTMINEJVyqeDU3FCt0nNueo1f3ELLOykmOSo93Obx
         OJ49zQKLrbH/3ZtaT7SCwmNYmx9Qjk16LDCDW9iApSVD0406QI3phG0Dso480SErRCOG
         rehHqXqK3W9ZEwyWQ0tXXPOm7i4cBRz8Xd5/wdObBrtNX52130kFKBBhaPUTXlpLMFwx
         l3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ywnzIt1rq5TMK3nXkOe+8fRxFi8bT6yknIbfdkVkxc=;
        b=bxL9aWHwXUnQLyjXQVjt91DRzbHgmQD6ET80L31nu0bQsvNQAh4U/zDds29VCSzd/9
         giHx80I3AOKm6B9heqkR+tOG2zijbrqd2i4BXNTAYSmezGHcz7ssGlSwmHCMMDTMHe28
         UAgbhW7EiLp8mhlRMOmPBhoeOUTFcjzr3s7Gpuyh1Vbrw/D2RNT5T4SN6Bh+2YugWXzy
         tbEYo2T1opITk8WisIs+tNONfZBAnGcAdkQHpqkewxOE2EOnukczrEBvY3uupIa8ca3S
         qOJf3tV7VcrNPUBAlYWcKN8WC+vZ5xrWQjw0ZR3qjCH13Lz+Iu+8COt7svPK/HoueFpg
         lbKg==
X-Gm-Message-State: AJcUukc0vSAB9sA5DN9WiTwGqdR/kyf1BBM+NlkqXSWtvtFv/E8wgBGg
        VCxpZDx6SE71FWcHbacds/M=
X-Google-Smtp-Source: ALg8bN5ucq0PTgmNR4Vgd8zxalqtlpgZCU1BgnpCBBd4/shKJr2SMgVVkVWdwG1+Ev3hHk/GNx/0Xg==
X-Received: by 2002:ac8:164a:: with SMTP id x10mr13434793qtk.67.1548464795385;
        Fri, 25 Jan 2019 17:06:35 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id v22sm71043291qkl.27.2019.01.25.17.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:06:34 -0800 (PST)
Received: (nullmailer pid 4056 invoked by uid 1000);
        Sat, 26 Jan 2019 01:06:32 -0000
Date:   Fri, 25 Jan 2019 19:06:32 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 2/2] tests: add test for separate author and committer
 idents
Message-ID: <20190126010632.GA4000@whubbs1.gaikai.biz>
References: <20190125215955.30032-1-williamh@gentoo.org>
 <20190125215955.30032-3-williamh@gentoo.org>
 <875zuc49uj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <875zuc49uj.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2019 at 12:05:08AM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Fri, Jan 25 2019, William Hubbs wrote:

=2E..

> > +	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
> > +	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
>=20
> Fine, but FYI sets these variables for the rest of the test.

I'm not quite sure what you mean by this. I want the environment
variables to be *unset*. I don't want them to override anything in the
config file for this test.

Are you saying they will not be set for the test unless I set them,
so I don't need the SANE_UNSET calls?

Thanks,

William

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTVeuxEZo4uUHOkQAluVBb0MMRlOAUCXEuykgAKCRBuVBb0MMRl
OESlAJ9D9LxAfctZfSRciJ2Ioro/3BHUxACfb5hTmNrgsCz4gzNajLvyLV+MJNE=
=JWiV
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
