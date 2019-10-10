Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E501F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJJXkt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:40:49 -0400
Received: from ozlabs.org ([203.11.71.1]:58193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfJJXkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:40:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46q6z269tRz9sPJ;
        Fri, 11 Oct 2019 10:40:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570750846;
        bh=Wh/KZduuV0aLLrNwhCSz4a6q+cCzTbE5J18ATHvcIHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAggjMItP7cCnLOSDqbYpwHWSBLSMvUjjUYVdn9uhIvcKmblTNQEQj+6wjXz23nAK
         r2TF0w4LRIkGew/lObDbkjRnGQujYd7wyO7S/yn9MCSz/2vzrMUYkF0cMBp8nNk4/M
         4V7ax9rbuKbIle3nB2Xf5cKpn6PyW1wLIwW6IT9l9jZe9e8Cmu3ljPMMmEcKDunf8Q
         OvHlCM0BIxBX0z4F50tNGfX+Iov+cQI4bMcvW2q45oCJoJoHl/n91f8XSxLk9/Y3bf
         RmG6LnFTXwNtnEfKNXPvb+gQLib6oDLYyfMtO72oKSK9Ds1JsI9VytkFBrbIxShBDg
         G/L+xE3EEtt2A==
Date:   Fri, 11 Oct 2019 10:40:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        patchwork@lists.ozlabs.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
Message-ID: <20191011104040.0dd8db07@canb.auug.org.au>
In-Reply-To: <87y2xstcmf.fsf@dja-thinkpad.axtens.net>
References: <20191010062047.21549-1-ajd@linux.ibm.com>
        <20191010194132.GA191800@google.com>
        <236b9c32-b501-79a7-8366-26d64ceac24f@linux.ibm.com>
        <87y2xstcmf.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LeV4W_dou+N0pHMD/uoYB3N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/LeV4W_dou+N0pHMD/uoYB3N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 10:16:40 +1100 Daniel Axtens <dja@axtens.net> wrote:
>
> Andrew Donnellan <ajd@linux.ibm.com> writes:
>=20
> > On 11/10/19 6:41 am, Jonathan Nieder wrote: =20
> >> Interesting!  I'm cc-ing the Git mailing list in case "git am" might
> >> wnat to learn the same support. =20
> > Argh, that reminds me... this patch only rewrites the name and email=20
> > that is recorded as the Patchwork submitter, it doesn't actually rewrit=
e=20
> > the From: header when you fetch the mbox off Patchwork.
> >
> > Part of me would really like to keep Patchwork mboxes as close as=20
> > possible to the mbox we ingested, but on the other hand it means the=20
> > mangled address is still going to land in the git repo at the end... so=
=20
> > I should probably just change it? =20
>=20
> Yes, I think change it. If you're worried, stash the original one in the
> headers.

Or add a From: line to the start of the body (if one is not already there).

--=20
Cheers,
Stephen Rothwell

--Sig_/LeV4W_dou+N0pHMD/uoYB3N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2fwXgACgkQAVBC80lX
0GyAmAf/UsxNP94W+GWd/KOIWgK/6csvCUDXEv23zfSFUCYsMhat8POYtbVF9S0V
YV0rCpA66ri18pZASxs+jgXwVxEERYDxnmeTtJu4PYuj3Da8mH+D93IRp9MSzeMi
PWEj031bKK5NvmzGBUMugrQpSuQ94STB+p2usr10qDfsd25XQDb+VMBke6VRgulx
cqFCcwdszaWCU9DZA6y7PuHdtPhZ6Ccvfe+oy1uP8t3xJbc0sxEgNUGVl8+lOhWv
EzJf0WH/7JGiTDC/uKYqm0ih++XM/pQAXPmA/BXCGU88U87X/SE53IM5UZwktyUb
D1Isd/T7mFpR4Q1kNNp3iDxBNl7O2A==
=ly7x
-----END PGP SIGNATURE-----

--Sig_/LeV4W_dou+N0pHMD/uoYB3N--
