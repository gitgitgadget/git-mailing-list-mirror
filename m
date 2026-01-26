Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFB33B979
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436767; cv=none; b=iUasb2rhVK43BXHzAD7YpG7wJMfaj8kPIY5/dxQMZuIRNMfZYlGaIAfFmbRsMbT3q6c8pdAcaNYmDH3feYqXlqrlwhL9nXrXFgDQH6+T17yO+G+lCyDP+r7lgFdweDYaFVRTtLzWxl3DxXFCv4BfTzy2OTBZsjBn6LXFXkcwCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436767; c=relaxed/simple;
	bh=/igTTtJAtiv/hkbOqHYc0rpgB131Pm2Z95TFki5Jtoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhYWitCwCzPaqherssb+1V/eSc2BsVu8vuTfTqOKjAGaiapZPSuTTqT44rmPx+tj0PT3KZ/LbiVpGvwKjfvPMbcGEPxY8pz+1THvE7F3qvDUudFQxOZNOpQya4RIrM9DNgp0QmE7SbLQ+ly9QfPYvSz58/OqO8qcJJLZYY/tVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=nEMATuOZ; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="nEMATuOZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1769436751; x=1770041551; i=christian@heusel.eu;
	bh=shOE6LfKovOT9qSEfE7TM/gsL7BZ0e31YB04sHmM6/U=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nEMATuOZaJde98fu7X4GiykqyyBZ5c3zbAmQKBzmE+QeDiZrzpFQP+W5ePZ5IBM2
	 FuGkw3/XaZEzfMhHasCVqP9kfagtx0yso+p+FXyVBVbnjYahTGMvCUtdAOrkMiQtS
	 iAxiLvDK4r/ofQmxUD67w0MNEHionBlbnsON4Ngx+4dRY5KmyQLHdVNaY2DP5FgrD
	 Q2kT6ZvBwPH4cUa0lrSTaq+Z4GLpl1f532oingDEkPiWHYNo74sriGEtozxMWfPeb
	 n6QInVIXrPU8nj7B2JWPF84SgDC58v0/8dc8/GO+tgHo9BOvR/7lNyn9419MMnztP
	 YlpqnXiCiMxPiUJB5w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF2YC-1vZKid2kdU-0029hv; Mon, 26 Jan 2026 15:12:31 +0100
Date: Mon, 26 Jan 2026 15:12:30 +0100
From: Christian Heusel <christian@heusel.eu>
To: Colin Stagner <ask+git@howdoi.land>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Hesse <list@eworm.de>
Subject: Re: [regression][bisected] git-subtree remote desynchronization
Message-ID: <8c588acc-1626-4ebe-824d-319d721537a1@heusel.eu>
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
 <xmqqikcql8cq.fsf@gitster.g>
 <xmqqecnel2fs.fsf@gitster.g>
 <023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="afd3ggm5r3fnxlqg"
Content-Disposition: inline
In-Reply-To: <023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land>
X-Provags-ID: V03:K1:NUXj0SqXHLCwJjGwEzYBQTxbO30XEquJmRk3593IDYjHsprf7PM
 xO5FcGGM2CB/pC2/0DLFKr+IGtigfeR2bOZ6z4wOil8XPVKee1cWNCH1H5+6IWJjJZJ9L5u
 HRkI6poJ6XRpIJpt/KLA4t731m6rtGMn2EXro2tT5VmGmQeSOzA3Ak0t4GcbmTgoy1QtT/X
 xf0xn/AaqZKPTvAFm6ggw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l4XuyNBw8lY=;+w4d97gEAlb9VNRrzuaxJZY/X4o
 YIyiFgCI1HVB2wC21oGKdrD++KXYSC/D2nXlrVlTaqhb9XMcyHtL94tdFiAvg0XS3gj33xbL9
 3DlNQ1gxiM8kREUB67M9o3Z0eIaraBHVpWIQ5ZQeB6yLFxIv1WPIHOAOaeiisXKk/BjwCxNAL
 6+tfGnFaIDW6ckc7T2AqqJC1eZwic9yrgjCywjaFocySoiNOTQHWD5/mEce5Ts/VY9ghl2Unb
 3Ndm3Ld/ewXPqOakO7EHK94AD21EclH+lsPl43WxqU8URvBC2jQm6LStYnuQokxi+8H1HMtzN
 eLGT5ZH77kggXmE3/KgI1cjSiqCfDx5/mUnGBqD0ga2LvvaY6+7qvICbxZJg2A1UVk5vAnp7X
 e0hSBXH9J7gBqJ4l03um/ny4pBvWmsuROsjHh9Vr7feFlzTXfqyymxP4aZ3lPTku3FLVFlI/a
 Wiz+ZOgEx1tSDJZwc6wbzi3P1WP72s3Je67olURHhMeorUQ6IZt51ml/sCFO295mLf03TIpqL
 UcXGvPa3lBiL7VIgPCVY2EsroV2JDWuElkJqCDo7/ssIwVcUi+jkl0+A0v19sI6xv37npw1QB
 ieZwi90wBJi8KmcFmMb0B1lY6jzoudwK1FBYVi/dtUtlNGQHBy2gbQo6ib7hTDFUhnSAR3m+V
 1243BsX0zCctl5QkXlu+rVbRiq9rrSxgAw1J67JAh4QjDVFFaje5iB2Xubak2nFrQQXLPVzbq
 17+Q5bI7E9rOMiptYDPjAW8aMLWeTZ4pgL91m/3kFH8B7s1GrrIiPZKPWsez70lwkF98WfaRr
 rJJ4lUU2eO85dBraZlcxacBTfUj4KxLyQFhwr3yDlfMJ5jD3wBDyfFwk+76T5fs3MYrofuQQE
 vYsrPpVMgCREdgtXLGLnGOiMDZgO0avF7o265X0/K/5TQVB9G4IJYeZXERJW5K33Fd3oLZ624
 6LiQF5SEgbFY3UwFzyONQuvhY8DH8VfIUo8GA7FVaagMoEeNJOUaF1QN+YFY7n3pBocNHH7jZ
 mHv1AkEPEonISmDuD6DPhg2KG7a4L88J6tRi6ugwzKuO9n1Sf2Jejsv9CMZJvVM2t+L4xtzZM
 PZp7hFW9iqtXvc6hRQr3VoElbD/AHt7+yVPsPyXTWhKu8BEh1fFJITeJv/dEQTro0sxPK5F0C
 gm+QtDhEVrg7K9PDzgzn3/G20YvVf1QcFOjeaP55+iLOhwucG1Aogi3SiCjsyCsEnN5yrSuub
 rtNc3JTZ47f5WY53mhu73vvaaWm2f0SYeo1N4xyr0M0XRLn1RbBehniuuOnBt96w3TNUXanvj
 8ajJr2a5ShGG7UsKuHTF8N4W+ZsNkQ6e/pP5hd16AbX2EUdnY7Zp0iE3+rqHijOxPr7QRUkD8
 kPbNqhV+4UJkfk95GYZ2Jhi4ResfPdAI0AZDOVVY3jdZkXLFyvTV3WGAjBeroy4goLiOihTIi
 nRy+5C2WrRMrDYxMe1Od2W8jKvcVuHEnbnJyffAReqbln8ktoXZruUy+Ixi/t0RZpqxXUGNSU
 b+COmDwv3NdCaZp0S5m6JAjSFYXVw1GS8ZKlF8XbcYUCWIQLrG8iHH3BHayoAcu3rUC8GGqgV
 hyddgm7BtlIGsXQxygB4azIExKcyoeSfgjml20zjCgHY3AS96ZL0Ck3Q9rXbkbIWfYk3BGNU4
 5uuIq8NP2SB4bgpPGUpCvzwlKJqZXZndDoPZYQyHQv3zByPlm/sCKQvy1uKHvEKygSi88DgGE
 W6C6GWTyc8+p02djCOVZFU46Ag/+GurJXX4OVxAjwEyX+vyGKGv2zuu6CvprzaOTQlFTCsh6X
 DDrQ


--afd3ggm5r3fnxlqg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [regression][bisected] git-subtree remote desynchronization
MIME-Version: 1.0

On 26/01/25 11:14PM, Colin Stagner wrote:
> <snip>
>=20
> On 1/24/26 05:43, Christian Heusel wrote:
>=20
> > 1. Update to the 2.53.0-rc1 git release candidate
> > 2. Clone my monorepo for packages in the Arch User Repository:
> >     ```
> >     git clone https://github.com/christian-heusel/aur.git && cd aur
> >     ```
> > 3. Push changes to one of the contained subtree remotes (this would nor=
mally be
> >     done via `aurpublish google-chrome`):
> >     ```
> >     git subtree push -P "google-chrome" ssh://aur.archlinux.org/google-=
chrome.git master
> >     ```
>=20
> I cannot `git subtree push` to your remote, but I can instead run:
>=20
>     git subtree split -P 'google-chrome'
>=20
> which happens internally prior to the push.
>=20
> Before the bisected patch [1], running this on your aur.git's master bran=
ch
> [2] generates a split commit with hash:
>=20
>     e6f4613797c0eea5a8939441a1fb58211e9184e0
>=20
> This is the result you expect, right?

Yes this is the result that I expect to get.

All these repositories are also public if you want to take a look at
them, the HTTPS remote is "https://aur.archlinux.org/google-chrome.git",
so you can easily compare the current state to the expected state:

    $ git ls-remote --refs https://aur.archlinux.org/google-chrome.git
    e6f4613797c0eea5a8939441a1fb58211e9184e0	refs/heads/master

This also works equivalently for the other subtrees in that repository.

> I am also testing the other subtrees of aur.git to make sure none of them
> change, either. With the patch reverted, none of them appear to.

Thanks for investigating this, your work is really appreciated!

> I have made some progress on a fix, but I have not yet achieved 100% hash
> equivalence across the board. The bisected patch will likely be reverted
> while I work on a more permanent solution.

I guess that is for you and Junio to judge, but rushing a fix sounds
like unneccesary risk for an optimization.

> [1]: 28a7e27cff (contrib/subtree: detect rewritten subtree commits,
> 2026-01-09)
>=20
> [2]: aur.git@29bfddf (upgpkg: rider-eap 1:261.17801.69-1, 2026-01-24)

Cheers,
Chris

--afd3ggm5r3fnxlqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAml3dk4ACgkQwEfU8yi1
JYWKDA/+N1EZ7FBdpM5kSQxBzaG/L0P6+2+NcGnaKSE30PFWHNOlozSDYAFUDmtX
GAGKPq0u1VFIOd7ZBT/wrRd+NRzOfP1bR3QEbaHCylUK6MpbusysJXb4omfc1Zif
KYMygCgwz/iFsRLDFqz3qdIMoivqEU8kM2TPxnaobTG10pC9VW4/bZ5kOfGbwpWQ
DOhD/Nw1SNN3pwYbtcB3TOt07sSvFwoZGNmPJIhkZr9WHQJyJB8wm2GiPHU8Ohye
G8iI3GJ/rRKLDLay+SsfihRXwDdtqfKFozUYQwK+zzwa0XoDGphUmUn1PAkdjhbc
DAuiT73S51BOUwzCX3sre6mm7BTDt41bzGlOpmnaWNyodFCd9qShAhQ9ZjJXzJ92
c9Edfbc7Z5zMQgoihqd2WAZfLLZkAx+RFtEPYLPWgOBTNRuLMvwCFgTVnwFPeA3/
pu26yxWweh9OvQwGxUqVvaWgUQNanjfhsa9Il6LQLMinmLIk/oyo/1Y1Z9JzYMP/
B5/NfEwNsBckBZCo9UXPSlVPTuDy1pfto5xx3VIgdFUzSRFLQLc+L8EEzfBUptfn
QvJGl8nul8SJhdtiYsaIgUZdwv3faMikBVYzwRHeFLldlLazuhcADrMvjIHs4LMw
jrDf9ZEtCOYx/dcbTD7ZQV7D7SKnhs1mRqgPZ3U1bJGFtGrKcaY=
=XvMG
-----END PGP SIGNATURE-----

--afd3ggm5r3fnxlqg--
