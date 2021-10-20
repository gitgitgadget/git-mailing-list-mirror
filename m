Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED9C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F2E60FC1
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTB3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:29:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37052 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhJTB3s (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:29:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D91C160473;
        Wed, 20 Oct 2021 01:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634693254;
        bh=VpyoT3YGaxOAqbBMV4w6zvxCTlldsh/O9PkntRU0iis=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RvFTCmYQHeOjtHRQ2aXReOalkR1IC/LalL+Rkd6eK2UWduz4ys9yXaMaS0PFMliIt
         3TUN6OZBxVjMBWSygjIo1aoeyPy2bk6fdM2lnFoL/OaWG+O8i0yP8EML5+UB3n8po4
         u/MqmjaJKCIGUNt01MbygE6kqj3sWhuIsu9XQpf5JOr3KbyCFTkmBvGLdcKCE+Tvda
         I/bz2lcdYwSZA/4eCyoMiUN18Zs07P90iAtCVr11p+POfcbm1ycpRN0vM7VSmCH55V
         4XWXSzU83d01usThsckZU8JqN6unwRWEvii2pQcUbJ4/SQdhjSCP6DSX99W1y/qDE5
         PSBiaq4nyJBgeIMiLrSDRaIqjThuxpizlf3Asi24YQ4kyZSur5Htmy9VfjD1Pq4ROH
         dfgRmStbQAMLau3DF2v6XYDcVXqSKbu5sbiHQcKhiCcrbKjNBohm3p0EctT98uLvOE
         oDNt7QQxlCv1zAEZXDp8UnLJb8nBfQ0yFcVJixoyLksabZzn+Lu
Date:   Wed, 20 Oct 2021 01:27:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] gitfaq: give advice on using eol attribute in
 gitattributes
Message-ID: <YW9wgbN/b8NkVp4z@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-4-sandals@crustytoothpaste.net>
 <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zAa7wiQDgf/4YCNx"
Content-Disposition: inline
In-Reply-To: <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zAa7wiQDgf/4YCNx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 01:21:40, Eric Sunshine wrote:
> On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > In the FAQ, we tell people how to use the text attribute, but we fail to
> > explain what to do with the eol attribute.  As we ourselves have
> > noticed, most shell implementations do not care for carriage returns,
> > and as such, people will practically always want them to use LF endings.
> > Similar things can be said for batch files on Windows, except with CRLF
> > endings.
> >
> > Since these are common things to have in a repository, let's help users
> > make a good decision by recommending that they use the gitattributes
> > file to correctly check out the endings.
> >
> > In addition, let's correct the cross-reference to this question, which
> > originally referred to "the following entry", even though a new entry
> > has been inserted in between.  The cross-reference notation should
> > prevent this from occurring and provide a link in formats, such as HTML,
> > which support that.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > @@ -464,14 +465,25 @@ references, URLs, and hashes stored in the reposi=
tory.
> > +With text files, Git will generally the repository contains LF endings=
 in the
> > +repository, and will honor `core.autocrlf` and `core.eol` to decide wh=
at options
> > +to use when checking files out.  You can also override this by specify=
ing a
> > +particular line ending such as `eol=3Dlf` or `eol=3Dcrlf` if those fil=
es must always
> > +have that ending (e.g., for functionality reasons).
>=20
> The first sentence in the paragraph is unparseable.

Yes, I think perhaps I omitted the word "ensure".

And I should reflect that they should have that ending in the working
tree, which I neglected to mention.

> > +# Ensure all shell files end up with LF endings and all batch files en=
d up
> > +# with CRLF endings in the working tree and both end up with LF in the=
 repo.
> > +*.sh text eol=3Dlf
> > +*.bat text eol=3Dcrlf
>=20
> Maybe: s/end up with/have/g

Great.  That does read more clearly and succinctly.

I'll include those fixes in a reroll.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--zAa7wiQDgf/4YCNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYW9wgAAKCRB8DEliiIei
gXplAQDg6grLN1zxlGOiLypMixfgBD8qyLmVAaXd6m7L0WxddQD/biV20W3uEk5f
3rX9H15Th4dmSL/SXI/0LQ874F+iVQE=
=Cgp5
-----END PGP SIGNATURE-----

--zAa7wiQDgf/4YCNx--
