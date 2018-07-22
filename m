Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5291F597
	for <e@80x24.org>; Sun, 22 Jul 2018 10:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeGVLGS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 07:06:18 -0400
Received: from goldorak5.eric.deplagne.name ([213.246.56.18]:58745 "EHLO
        exim4.goldorak5.eric.deplagne.name" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbeGVLGS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Jul 2018 07:06:18 -0400
X-Greylist: delayed 2127 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2018 07:06:17 EDT
Received: from [192.168.0.4] (helo=mail.eric.deplagne.name)
        by exim4.goldorak5.eric.deplagne.name with esmtp (Exim 4.72)
        (envelope-from <Eric@Deplagne.name>)
        id 1fhAlG-00066k-Pt; Sun, 22 Jul 2018 11:34:42 +0200
Received: from deplagne by mail.eric.deplagne.name with local (Exim 4.69)
        (envelope-from <Eric@Deplagne.name>)
        id 1fhAlG-00066e-Ot; Sun, 22 Jul 2018 11:34:42 +0200
Date:   Sun, 22 Jul 2018 11:34:42 +0200
From:   Eric Deplagne <Eric@Deplagne.name>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180722093442.GK11431@mail.eric.deplagne.name>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet> <20180721235941.GG18502@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FU8v9NgvNgS/pFcX"
Content-Disposition: inline
In-Reply-To: <20180721235941.GG18502@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FU8v9NgvNgS/pFcX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jul 2018 23:59:41 +0000, brian m. carlson wrote:
> On Sun, Jul 22, 2018 at 12:38:41AM +0200, Johannes Schindelin wrote:
> > Do you really want to value contributors' opinion more than
> > cryptographers'? I mean, that's exactly what got us into this hard-coded
> > SHA-1 mess in the first place.
>=20
> I agree (believe me, of all people, I agree) that hard-coding SHA-1 was
> a bad choice in retrospect.  But I've solicited contributors' opinions
> because the Git Project needs to make a decision *for this project*
> about the algorithm we're going to use going forward.
>=20
> > And to set the record straight: I do not have a strong preference of the
> > hash algorithm. But cryprographers I have the incredible luck to have
> > access to, by virtue of being a colleague, did mention their preference.
>=20
> I don't know your colleagues, and they haven't commented here.  One
> person that has commented here is Adam Langley.  It is my impression
> (and anyone is free to correct me if I'm incorrect) that he is indeed a
> cryptographer.  To quote him[0]:
>=20
>   I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
>   K12, etc are all secure to the extent that I don't believe that making
>   comparisons between them on that axis is meaningful. Thus I think the
>   question is primarily concerned with performance and implementation
>   availability.
>=20
>   [=E2=80=A6]
>=20
>   So, overall, none of these choices should obviously be excluded. The
>   considerations at this point are not cryptographic and the tradeoff
>   between implementation ease and performance is one that the git
>   community would have to make.

  Am I completely out of the game, or the statement that
    "the considerations at this point are not cryptographic"
  is just the wrongest ?

  I mean, if that was true, would we not be sticking to SHA1 ?

> I'm aware that cryptographers tend to prefer algorithms that have been
> studied longer over ones that have been studied less.  They also prefer
> algorithms built in the open to ones developed behind closed doors.
>=20
> SHA-256 has the benefit that it has been studied for a long time, but it
> was also designed in secret by the NSA.  SHA3-256 was created with
> significant study in the open, but is not as mature.  BLAKE2b has been
> incorporated into standards like Argon2, but has been weakened slightly
> for performance.
>=20
> I'm not sure that there's a really obvious choice here.
>=20
> I'm at the point where to continue the work that I'm doing, I need to
> make a decision.  I'm happy to follow the consensus if there is one, but
> it does not appear that there is.
>=20
> I will admit that I don't love making this decision by myself, because
> right now, whatever I pick, somebody is going to be unhappy.  I want to
> state, unambiguously, that I'm trying to make a decision that is in the
> interests of the Git Project, the community, and our users.
>=20
> I'm happy to wait a few more days to see if a consensus develops; if so,
> I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
> a decision and write my patches accordingly.  The community is free, as
> always, to reject my patches if taking them is not in the interest of
> the project.
>=20
> [0] https://public-inbox.org/git/CAL9PXLzhPyE+geUdcLmd=3DpidT5P8eFEBbSgX_=
dS88knz2q_LSw@mail.gmail.com/
> --=20
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



--=20
  Eric Deplagne

--FU8v9NgvNgS/pFcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFbVE+yej7DisjVpq4RAoBJAJ4xHSa7h3zs3nJh2/rZ45H9xnLFngCdH3Es
mPpXZ4qGnEeSxuxL5iVfD0c=
=YnxW
-----END PGP SIGNATURE-----

--FU8v9NgvNgS/pFcX--
