Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74673C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGXBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBGXBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:01:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC412F06
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:01:23 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EE3015A210;
        Tue,  7 Feb 2023 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675810883;
        bh=6IcBn6y6tMO7JCz0PhMsqOk+e29Vbj36KmK8x7udQkc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KIJe9pq8WwJ0isy71cxM1P81bUPSlKamQqj4RO3uTBI9uSCF5ZnVRHWIkCWIEwrw1
         X8FenQNhbruGWaoyp7g85u8QcbLr+iXNV171wC4pMBqfslExAmIfcZ33pDiSSRjRLD
         HY8ZUTWldzvFidFbNnhEAF3+oh2FYpJavE4/Kg/4e/afhBjiK5FcNZzXH7yFKN7n76
         HWc+4nTCBq1v+4NQb2yJh7X7pcgimNQr767kmhtPuxUW8tL0xo0ND94hZKpUF9SRrU
         yDsclz8T4pEU4TXtzWXkgK27XKWy978y1UkrFNe8HlmAyIk7/hnyFfCIR1k3RIZ4ZX
         1BH7M8ZBTlqOcEsv53XBD39CRRGLitP5jqF6QOrZ9kIh+2OksnB2aQswmeyDLdOoqP
         f9w/z1nBk+zH/jW2miHwzPFom99vVQ6TKlqPqXqYPTbcfYQLjJB+AylddU8TWSggJx
         bHyT5IagRN+SWwITaYJKlXcJIVDU/9ci1p0TwqafNcaUtYok+Ks
Date:   Tue, 7 Feb 2023 23:01:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Message-ID: <Y+LYQYMS7ruvRbNW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
 <20230205221728.4179674-2-sandals@crustytoothpaste.net>
 <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gFhpKMhGWfPlEFNB"
Content-Disposition: inline
In-Reply-To: <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gFhpKMhGWfPlEFNB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-06 at 22:18:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Maybe there are other changes in the proposed spec that put it at odds
> with such a goal, it's unclear to me if this is the only difference.

As mentioned in the description, that doesn't address trees, which have
never been consistent traditionally.  We also have bad permissions for
pax headers (always 666), which is something we've tried to fix before
and is not something we want to carry on with.

You specifically sent a patch stating that we're not guaranteeing that
format, and I agree with that assessment.  I'm proposing a format that
we would guarantee and which does not have any of the historical baggage
or warts that we don't want to keep.

This format also doesn't serialize timestamps; everything is at the
Epoch.  Again, that's because serializing a commit and its tree or even
a tag and its commit would produce different results.

> But I don't see why we need bit-for-bit compatible output between SHA-1
> and SHA-256 git repos for the reasons noted in the linked-to reply, and
> removing this will remove a *really useful* aspect of our tar format,
> which is that you can grab an arbitrary tarball, and see what commit
> it's produced from.

True, but this is a highly obscure feature and I've never used it
outside of testing.  If you want it, you can have it: you just want the
default format, which serializes it in the header, and not the extremely
restricted format I'm proposing here which is designed to never ever
change.  We might well decide to add cool new features and useful
information to the default format, but this one will be fixed forever.

> Even if you want to retain SHA-1 and SHA-256 interop as far as tar is
> concerned, an un-discussed alternative is to just stick the SHA-1 OID
> into the SHA-256 archive.
>=20
> For repos that are migrated we envision having such a bi-directional
> mapping anyway.
>=20
> And for those that started out as SHA-256, or where we no longer care
> about compatibility with old SHA-1, we can just start including the
> SHA-256 OID, as all compatibility concerns have gone away when we
> stopped bothering to maintain the mapping, no?

Whether SHA-1 or SHA-256 or both are present in the repo is a local
decision.  The transition plan specifically anticipates people either
preferring one hash or the other in output.  The behaviour is not "use
SHA-1 if there's SHA-1 and use SHA-256 otherwise", because even if
everyone has SHA-256 and prefers it on their system, some people may
still have SHA-1 for historical reasons and that would lead to different
output.

Part of this is because I anticipate that once the interop work is done,
GitHub may transition repositories on the server to SHA-256 with SHA-1
interop for existing SHA-1 repositories.  People are still going to have
a fit if tarball data breaks at some point because the repository owner
decided to flip the default hash algorithm, and I'm specifically
proposing a format that is not going to direct hordes of angry users in
my direction or the repository owner's in that case.  Lots of people are
going to avoid switching the default hash algorithm if it breaks
tarballs, and I specifically don't want to encourage people sticking
with SHA-1 for that reason.

> This is the nth reference to "the standard". I think this would be
> improved by linking to it, isn't it
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html ?

Yeah, I'll do that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--gFhpKMhGWfPlEFNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+LYQQAKCRB8DEliiIei
gacaAP9adrg/0htwnus8ff02N/w0tDJ8/NnzPdYs3fhDJWqhsAEApGseysTlL4QF
3dWjOzrffa5tEZ+fsmmfjzldDEDGqQY=
=kF7n
-----END PGP SIGNATURE-----

--gFhpKMhGWfPlEFNB--
