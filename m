Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C36FB6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wnMwbZGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFZbte/m"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A471D5C010B;
	Thu, 28 Dec 2023 06:13:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Dec 2023 06:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703762023; x=1703848423; bh=DSXCdrt3rS
	mFVJ9V9LKhcct3n3mi7A2847YS8J7/wmM=; b=wnMwbZGgsLpDytVFWQeWxU5frE
	jpJ1qAjU6c29qCBon+yt7clINCKufw8r4P95NR1x0GdTyYKFNegl24S0jf3KK3Lv
	RdbYMUD5ywZUdEhBshW9BXLeHFwv7V6JIVth4cKz9/wKRdigg9y0Wpf2o+14C7lu
	xrTghznl/63YOgMdsNBddYT//B6hNhwwXzqMGZt93AFqER399UnwuQDwV7Qehp7q
	TGdQmdyyAXcg3emc3zYemvSxOnbNncvObBq0nczwETjI2G3vinZK4dxGKVslPEEw
	7suwHR9nh/0zilfzQq+jLXl6d7Xxxwy9Hodn+azYxp+YKlkHR8ieB85kvquw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703762023; x=1703848423; bh=DSXCdrt3rSmFVJ9V9LKhcct3n3mi
	7A2847YS8J7/wmM=; b=FFZbte/mLt9Gkg8ej5kPsuNpqoP3yXx76AJHRXgiHNwz
	2azxo4gyIO5MYgnU/NcGx+BkNv15nJbYl1qcS40WehfsxYOqwzzCG5OWoRAHpReU
	MRqakgj4iDjbbYeM9miyhi3D7E45msbEbj9++spTpYiSj8zIKv+59DstMKdh4d9e
	b7mcnG+7iJ1Aw5qWK8+4GE6LLPiito03y/lfkRZhXtrCsuvDc9F2sZPttQKUtN4W
	B8JG+a0jIppMOSxfXeSDBclHXec57+OE0tNTk/ZSd7buHlyVs/IWvPF5SC8KXUg6
	4QiM1FKghtCN66npDrvWY7JiMZYtADsuq/wxY1J2Gw==
X-ME-Sender: <xms:ZliNZV7q9Z5w5t51HL0G4m6njdjo7TsXn7rNfEFRTFB-fo_g2vv2dA>
    <xme:ZliNZS5a43kfu6IV_ynw485RE0y3IIMTxUB1XaEe6WJoMBML3_qLg82O9wgG-zqlT
    6H8EB6K2PNDpTH-mA>
X-ME-Received: <xmr:ZliNZccRmyaUytaOuOR9FoUNYnMUcOnKc5gaN1X-VKJcbSseDtqsZ-S-tn7g6smjTKtg0hP-j_7mGHu_S8Zy7lVFcWC7I4mVx-C797JfNE0YjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefhudejueeuleekteeffeehveekveekfe
    eileeljeduhedtgedtveekhfelueduvdenucffohhmrghinhepghhithhlrggsrdgtohhm
    pdhgihhtqdhstghmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ZliNZeLHVvxjj8eX5h97oZ41xwK0Lce_RhxC-0ryvjiFGsjyOAL_TQ>
    <xmx:ZliNZZLrI-Wq5b3GdkvEPTO3oNXy46pALnF8ZTbDdymUge1c-1LBiQ>
    <xmx:ZliNZXwVbx03HGncBGAPdhGUhhdkTkAJPB1-kSWWvsX2fV_w4kGSJQ>
    <xmx:Z1iNZZ0uPs6-4pTcSumyIjFaQa1WP_ScssRUx_3R5kfZPPb3ZLo9Fw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 06:13:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15b5d7aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 11:11:25 +0000 (UTC)
Date: Thu, 28 Dec 2023 12:13:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com
Subject: Re: Git mirror at gitlab
Message-ID: <ZY1YYtoIw4dIpZ6Q@tanuki>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <1D1CDDF3-E0D2-4059-9C9A-796145AB6E24@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqJQGn0piRJOm1SU"
Content-Disposition: inline
In-Reply-To: <1D1CDDF3-E0D2-4059-9C9A-796145AB6E24@schinagl.nl>


--cqJQGn0piRJOm1SU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 03:06:08PM +0100, Olliver Schinagl wrote:
> Hey Patrick,
>=20
> On December 21, 2023 12:48:12=E2=80=AFp.m. GMT+01:00, Patrick Steinhardt =
<ps@pks.im> wrote:
> >On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
> >> Hey list,
> >>=20
> >> For years, I wanted (tried, but time) to run the mirror for git on git=
lab.
> >> Actually, the original idea was to run a docker container ([0] 10k+ pu=
lls
> >> :p)
> >>=20
> >> I initially set this up via docker build containers, where docker hub =
would
> >> pull my mirror of the git repo. My mirror, because I added a Dockerfile
> >> which was enough for docker to do its trick. I was planning (time ..) =
on
> >> submitting this upstream to the list, but never did. Because of me not=
 doing
> >> that, I had to manually (I was even too lazy to script it) rebase the
> >> branch. Docker then did some changes to their business, where the dock=
er
> >> builds where not possible anymore.
> >>=20
> >> So then I figured, I'll do the same on gitlab and push it to the docke=
r hub.
> >> Thus I setup a mirror on gitlab [1], with the idea to work there on it.
> >>=20
> >> Again, I never got around to finalize this work, mostly because the do=
cker
> >> container 'just worked' for pretty much everything. After all, git is =
very
> >> stable overal.
> >>=20
> >> So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add sup=
port
> >> for GitLab CI") landed, which started to trigger pipeline jobs!
> >>=20
> >> Sadly, this only worked for 3 builds, as that's when the minutes ran o=
ut :)
> >>=20
> >> So one, I would very much like to offer the registered names (cause th=
ey are
> >> pretty nice in name) to here, so people can use and find it.
> >
> >Not to throw a wrench into this, but are you aware of the official
> >GitLab mirror at https://gitlab.com/git-vcs/git? I myself wasn't aware
> >of this mirror for a rather long time.
>=20
> Not a wrench at all, and no, I didn't know. How old is it though :p
> could be that git-vcs was created cause I owned gitscm :)
>=20
> I had chosen gitscm to match the official site, git-scm.org. the
> hyphen I left out because afaik it wasn't allowed on docker hub.

No idea when exactly this mirror was created. The first mention of it in
the "What's cooking" report is in December 2020, 489058b80d (What's
cooking (2023/12 #05), 2023-12-27).

> >I also wondered whether we want to have https://gitlab.com/git/git as we
> >do on GitHub. I don't think anybody registered it, but it is blocked
> >from being registered as far as I can tell. Maybe we block the namespace
> >out of caution, I dunno. I can certainly check in with our SREs in case
> >it is something the Git project would like to own.
>=20
> Yeah couldn't figure out who it was either ... hence gitscm.
>=20
> Sadly gitlab doesn't support aliases :) I'm more then happy to hand
> over the space. Whatever name is decided to be best.

I don't particularly mind the name we ultimately settle with. The most
pragmatic choice would likely be to stick with what we already have.
Ideally, all the others would then be created as forks of the official
one so that they point back to it. Like this, users can learn about the
canonical location of the official GitLab-hosted mirror more easily.

In any case, regardless of which location it is going to be, I certainly
agree that having CI jobs running for it would be great. Folks here at
GitLab are mostly on vacation though, but I'll take care of this once
they are back and once =C3=86var has responded so that I can get access to
the current official mirror.

Patrick

--cqJQGn0piRJOm1SU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNWGEACgkQVbJhu7ck
PpQ21A/7BIm/RTqbAwSyMeQCRHwQl6A79PA3M5P2hlis2l30uGttLQpWyzIGKIKK
V2oldtFIRg1sV8tOVPw5t3mP4grlxuOZoKEh5ylHluVYlJYXwWlehLIZ7ENNnbEw
JUGh0SeKrN61ySkg3gay5D+wtw4oyLMbWsfhOsDTRaZbThcNZk4VREMD/oHHPIQ+
ycVP0qNWIEJyTCI6zg/D5QLvwPssrcegn20l28xR87BtPt+hq/389biQEhdgvTrW
M1tdNjtmNSJ49IMmNr4wujwwnqyT37Sg3/sLGaCw7ITqYlMGwx0QwO3j8lxcuy8v
LjYvGETlhkC426TjFYs4BPw2ksSLRtksGPGxepBIK51OKTvxQjP95CdpBwEULdua
kJlfbfZmTE3isMQp26FNKBVdYyZdRtg5gvwKNjX6fVJC/PViFXVlm/iggmd9XLHG
tZ71SAiBy8uy4UtCJ5eXvxfKu0elHWq/Bve5DoAFW2AZLWZ1yckXMCCFXp8GCH6e
SEpwLnuxZ0AIspVSpcU7gwXW3Jyh9v3Z0mhlH3ZDebLTW3K2N0eO0XaoOFcMIfi4
oijkeO3+a9No3QVxO/UHOc7t2fQmjyxrTW8C9yqBGRR1+UtOaVkD5gcJJQb8p9yt
eiQS70y/pk2s/xyyGY+k0iNqWEDzof2cfaxfFoBk8n+Ub4KDfsE=
=BNMr
-----END PGP SIGNATURE-----

--cqJQGn0piRJOm1SU--
