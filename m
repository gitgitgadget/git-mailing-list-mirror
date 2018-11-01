Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37491F45F
	for <e@80x24.org>; Thu,  1 Nov 2018 00:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeKAJ66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 05:58:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52906 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbeKAJ66 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Nov 2018 05:58:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:293f:cdba:df65:a13e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 273AD61B73;
        Thu,  1 Nov 2018 00:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541033896;
        bh=n39iL7NYKZ0gZLFCYO1yl8RxLU+gtHn0gnoW+sbNu1c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jpbHxxziKQoNvVZTzqXcXAHVcT1KakUnCYSH2cJPHpHWLP1WIhnJR7tWvdVNK/ees
         dS2fgVXWc1noENbit9KprZuiZs7MZqeuQSmhurVTOEf2WQZz8MCW6hHqOQglT0GOZZ
         M2E3k5wQvCBn3dC5tiaKnzGmDAY6XIi2qG1AThwnDrZZOpgbt42nnD1PPJ+e/ZlQME
         kAk3Hr+n6LhcaIVEDzsikM8gKQVJ02KGswcAkE1zeIYKZ2khw2+Uj1ELZt8/v7WQIx
         1ptVsxIdaM/5XbGTIon3DA6JlqWQkemH5cAv1o50jZfLMphijVSY+UGDrl3AbnSfQJ
         v6C4JpqUo31UihJH1kDYB7spCBa1k54A1ez+Tu8pnIPC/V3F03+eIRtf3Eq2iPO5mo
         58i8jo0d2FKp0djN/hxd9yYrPulJeqWPCPApWMSq8Ztfa03JNjW6HUMXC2tbJllrTM
         IA6RjdUb/7TSwAbKQn5n00XV/kSk9yRhyWlDDp0LGSQeJuzDgvh
Date:   Thu, 1 Nov 2018 00:58:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: using --force-with-lease after git rebase
Message-ID: <20181101005811.GB731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
References: <CA+KyZp5Zv77idtpu9jtxDUyE9zPP8UN3LsQBG=M5yM2cnMFgVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <CA+KyZp5Zv77idtpu9jtxDUyE9zPP8UN3LsQBG=M5yM2cnMFgVQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 12:13:06PM -0700, Alexander Mills wrote:
> I have been confused about the need for --force-with-lease after rebasing
>=20
> Imagine I have a feature branch:
>=20
> git checkout --no-track -b 'feature' 'origin/dev'
> git push -u origin feature
>=20
> I do some work, and then I rebase against origin/dev to keep up to
> date with the integration branch.
>=20
> git fetch origin/dev
> git rebase origin/dev
>=20
> then I try to push to the remote
>=20
> git push origin feature
>=20
> but that is rejected, I have to do:
>=20
> git push --force-with-lease origin feature
>=20
> why is that? Why do I need to force push my feature branch to the
> remote tracking branch after rebasing against the integration branch?

When you perform a push to an existing branch, Git checks to make sure
that the push is a fast-forward; that is, that your changes are a strict
superset of the commits that are in that branch.  When you rebase a
branch, you rewrite the commits and their object IDs (their hashes).
Since you've rewritten some of the commits that were on the version of
your branch that you pushed to the server, the commits you want to push
are no longer a strict superset, and Git requires a force push.

This provision is in place to prevent data loss.  For example, if you
and a colleague are both collaborating on a branch that isn't rebased,
you would want to avoid pushing changes that overwrote those that your
colleague had made.  Git making your push fail is its way of helping
you realize that there are changes you have not included and making you
decide how you want to handle them.

You strictly do not need to use --force-with-lease; you could just use
--force instead.  But using --force-with-lease over --force when
possible ensures that you are overwriting what you think you're
overwriting, and not additional working changes that someone else has
made, so it's a good practice.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvaT6MACgkQv1NdgR9S
9osycg/+IoRshqwWwFC0Zul+aUMbZqY0mzYYh7cmOieztGKctkUuEqKDhPnRVs6E
CM10qajgUFhD7FFJLhiH2+DI8YXw0pXKZeDY/NmygqgGQrQjAQ39Uc/QxozC8nPi
cIY9b+U34ZLJhSRw4iHEwWLHhWxpkVC2Ty8nf1ywuOekor8UdLi5sGZGlMLYS9HD
9PFYvEOA6CK4iS1Zr/Uvgoi2qQ8qKD5JnE9iHPUtqf+eK8TvfcPWHKaQHhan4VMA
ovJvpKJTt1to2tzV3vp6DpHcBmMkrwkvntCN1LdeRi5dZl+b5EFz+Nzc3umF+1eQ
JdTG03j6g/ZB2cWCykiV49S0HdETMCWohBMSoqvNbkz/RrCZ4fYBh4Cp/tqnNNAY
GMI+YPbd7eLmCYk25q1iZnIDrwZp0ixWy7yJzX2JM4piX8AbHy2ImgYw0GFY3RnO
6EQCt0QlBVB0Da+b2fCTaEyVwbs5AEgD8BftedjkS9i1lS9yNQQbGN+7Kn0BWk2D
U1/M1USLRcteXxWLrf6O8DpJltoUJTPm2zkRBXVBPOHnu9zQ5E5NNnKOBSiFedwR
MJ5jjhi+LQD0lRRgx4J1vxi0Y4Qj2TXSftOz41q+Em3CGs6TEvRTAs0EnjIo7NQI
wZEov2oWJDpfLYRGStpPH0vmPiktRKRqyaCfoW5UHHAsPsGZoN4=
=IqWa
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
