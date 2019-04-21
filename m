Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3200F20305
	for <e@80x24.org>; Sun, 21 Apr 2019 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDUVSk (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 17:18:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35542 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfDUVSj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 17:18:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d176:57d0:c3ac:defa])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A49AF60FF7;
        Sun, 21 Apr 2019 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555881518;
        bh=QuOlNmQr3aRV6LmCn2a6sAOASpvn/t0ZcJcxa8pmOdM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=U6l1T5qJ/aEnkjrMmQ6EooCd4IiwZEgAZvPhMjbrrH574o6Sv+oP9l2MClEvIEGkB
         JxITe6bq+C8NFFWrHuMENy4dF+MYWUezmCEMdVi1aSMTUJwuDF0W3aVW+i6+x04wy1
         hT0rpE8c4fFjx2Erj8BheLdX1E3jFrGnPB7z6FNXhhYBYsxBYjc5npjqq+rvaq0CJf
         SA/XS+S4GoENr3fH7qtFf7ZdW/3hhpgD10MAIn9DxqzhzAJPrq6cCNMjc9KA1C+VH6
         cw7+y5XJkUtG2oCHwp24L5iSCdbugod2wGE5MV+yzC6FNwYVEEs/ifnI1+Qus5Qtip
         tm7OIKSCPMITaJfn/gAg8Idjw1kbI3mxQpKgxyWD+kDPNVBouXkCJdlLy0FHjMWCwq
         /ZETjFGmIgw+Tl76DFMjVwIhNJBTp8ueJ7baNSLL72R4kZ7QCMBJii//Fqub+fDsTO
         S5i2EUlDrPeZ0xaI7zq/fITIOoueN/gBeP8yQBGLeAEQWBozQ03
Date:   Sun, 21 Apr 2019 21:18:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2] Give git-pull a --reset option
Message-ID: <20190421211833.GC6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
References: <20190421040823.24821-1-alexhenrie24@gmail.com>
 <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2019 at 02:38:38PM +0900, Junio C Hamano wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>=20
> > A common workflow is to make a commit on a local branch, push the branch
> > to the remote, check out the remote branch on a second computer, amend
> > the commit on the second computer, force-push back to the remote branch,
> > and finally submit a pull request. However, if the user switches back to
> > the first computer, they must then run the cumbersome command
> > `git fetch && git reset --hard origin`.=20
>=20
> Doesn't anybody sense there is a larger problem if such a workflow
> is "common" in the first place?  In that sequence, when you come
> back to the first repository there is no guarantee that what you are
> losing is exactly what you are willing to lose and nothing else
> (i.e. your earlier WIP you sent to the second repository, which was
> further polished, making the earlier WIP you had here irrelevant).

It may be helpful to point out that this is essentially the workflow I
had before I had only one computer. I would make some changes on my
desktop, which was my primary computer, then need to travel somewhere
and use my laptop. I would want to go back to my desktop when I returned
home, because it was far more powerful, and I would know that I was the
only user of this branch.

Now, as a contributor and a moderately advanced user, I would likely end
up using "git commit --fixup" (or "--squash") for this purpose and
squash only before submitting, but there are situations where fixup
commits cause conflicts and it's necessary to do a rebase and force push
if you don't want extensive pain.

So while I think that "git pull --rebase" or "git pull --ff-only" are
probably better options in most situations, I can see the use in this
command, with appropriate foresight and knowledge. I can also see how
it's easy to blow away data with the proposed option, especially for
novice users, who are likely not aware of how to restore it from the
reflog.

I'm not sure if this email is an argument for or against this option,
but maybe it provides some helpful perspective.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly83ikACgkQv1NdgR9S
9ovBJRAAwKF1bGBAzyZfleF7oXPwnsH0N6qSSNc/+42CRaGDOsUSxZGgOpUSZ8v3
uFtyPKHCz45pmWpd3/JPgwsiTibISVnJHStcWeP7Gbo3rkFxeMu1t6supuwpRA7T
RLRmkxhL0hhHP3PByctDIZzohg2+XWLflWYpqJSB0xqAlf3muwmCa5akvxwjcW4g
Q254EZQm2RDfar1xz5JlJwnbLBfpItaaQ1ZKyqy6OBHOBiOcmW3507IXwp8k709z
2tqJEZyH3+1dpU1AE7JaJwvMUk1mGnEjEm7e+kiu3POhcuwoi++6fJ0y4DKhYj6j
DUaVmY6beQAGorc8yWwbTGXEMVvJekPH+bUKjAvoOqk5VyVzsZNs4p9Ac03sV1G6
cuj3p8GforuMgd6BlSeQhmyNMtPmeeGSlkZNp2cXTWsny8HBigorxW8JelxGgygI
39pX3mSx/0GQd2stCCIEdssDRzCrf6Tl/RFMMcVQadHBCnptLNNLJspfvNAXKotp
DvxYT9NxDij7vhkciRfU03u/dzyCZY9LpAc8MfS8TR6YTswVKsybUEh0iZGhxEPQ
7hvxC7wtTeJ/GSaxaTphADdA9gP5ObNSSndtAeRmoX1cScwxlP464ExnSCuy1j4O
8oXXf4CGxvhLJQLWP67mwFWANgDv1443XoW4oS/K+skXubVcgzc=
=qLS6
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
