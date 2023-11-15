Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1B1C693
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="akMrQ/ya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VnijiRCs"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CAD122
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 05:35:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EFE895C010F;
	Wed, 15 Nov 2023 08:35:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Nov 2023 08:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700055321; x=1700141721; bh=11
	qjxQhjIg4pNiDolA14Xz8ExfCJr3Gy9J0/ORdhGjY=; b=akMrQ/yaic75EbPkMc
	qLXzEK5hSbr5EsRWMuRGYiqJlZXHBdohLwdArfmRFucjZMEWiuS7bQyMns33ZyDu
	UaxhSHP9edfXD/ieaAZscB5m5GKYPXtay9Mr6xrwf5bhEaW1xqpUN8g4DWv6OKII
	RX46WHATClo2Do/JCQKXXJZnOihiKfN4OHzz9Mq6iWfRAddagUAddPZTwwbEtC49
	iiP4yS9sCwJQYDa0iTo5quW/X+8l+u+9iQgoCGrGUpwYEgghTxa6hBb/cepoislU
	Lw81rVRtzikj5sQBs2a45DjIcqARv4OHxCzbfpNwPFE2+LVxHUVINMC18VaeBz6w
	J6Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700055321; x=1700141721; bh=11qjxQhjIg4pN
	iDolA14Xz8ExfCJr3Gy9J0/ORdhGjY=; b=VnijiRCsWdOxMNAyjkz3Da0E9WIPz
	iNgVQEgl19wEQNnjOf0FT57H22kMbWS4JYBeEvBRLdv2Xs6DtTJViTpROGxPbOH1
	k7jM85q1LUsbjOMGqUcvvEAXmDx2fJdy3nTsb7je9oTUhfwhnvEKpbqBHP+51AU7
	HWUQumNeMq84Qj2PI8BSwqjt/UC9Sg/B8IDLpWoYtMZXt1gwuqYdG6PPUjXJtGh7
	NxBsNjL6sjHVloXnh0J4ArGqi/9Fyp8o5WVBWXn4M6agJJq2VPWzfBnQIitPfCyo
	vCBwd5ypVJ7HZ5WlLYysW0roYAHd/UICca5YJjIrcZIwgrMHNO/2i/fdA==
X-ME-Sender: <xms:GclUZQ8n3Jaks4hchv5mipPRn1NYwnHMgPG8grrC75tngXBb7oxVQQ>
    <xme:GclUZYs3nlImsZO5a1lRoiGdbFKtCOvdz9Z7wsBMluLmWp5C1WUIUVGtJuw8ggl1c
    zWVkYXHt7QrHmenYQ>
X-ME-Received: <xmr:GclUZWDgyAiy3_JAwY5a95WVALZkFRILx5Hj8K3udecmfiapuDFhK3Md7_o6O_y8frVXPgFt6-kHesrVbISzrEj7iPdzmn8QDGcGmZEihWeKrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GclUZQc1gZTbjmk0wVIqPphk68Z7sfhADFu6z9fRP-V9LaUSF9DISQ>
    <xmx:GclUZVOiX4GI6U6_3iIbCKHW8AHZm_nvxZUOe2dYVBzNz5kghwFlUA>
    <xmx:GclUZalL-SBRQAH_xm9KWvS3exNQAQS7Nfm9TBadd5P_EvJpR261eQ>
    <xmx:GclUZeaG79JvuW1TYnLB6JVsDTewntXp2hfwi9gRv7ICxGJ-zsjqyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Nov 2023 08:35:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c1baeb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Nov 2023 13:34:37 +0000 (UTC)
Date: Wed, 15 Nov 2023 14:35:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <ZVTJFOSnVonoPgZk@tanuki>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
 <ZVNNXNRfrwc_0Sj3@tanuki>
 <xmqq7cmkz3fi.fsf@gitster.g>
 <xmqqzfzgxops.fsf@gitster.g>
 <20231114194310.GC2092538@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0tkC3jKZ4NkLXz/"
Content-Disposition: inline
In-Reply-To: <20231114194310.GC2092538@coredump.intra.peff.net>


--Z0tkC3jKZ4NkLXz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 02:43:10PM -0500, Jeff King wrote:
> On Wed, Nov 15, 2023 at 01:51:43AM +0900, Junio C Hamano wrote:
>=20
> > >> Both of these are expected failures: we knowingly corrupt the reposi=
tory
> > >> and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs a=
re
> > >> updated. If we stick with the new stance that repository corruption
> > >> should not require us to pessimize the common case,...
> > >
> > > Yeah, just like we try to be extra careful while running fsck,
> > > because "--missing" is about finding these "corrupt" cases,
> > > triggering the paranoia mode upon seeing the option would make
> > > sense, no?  It would fix the failure in 6022, right?
> > >
> > > Thanks for working on this.
> >=20
> > Just to make sure we do not miscommunicate, I do not think we want
> > to trigger the paranoia mode only in our tests.  We want to be
> > paranoid to help real users who used "--missing" for their real use,
> > so enabling PARANOIA in the test script is a wrong approach.  We
> > should enable it inside "rev-list --missing" codepath.
>=20
> Yeah. Just like we auto-enabled GIT_REF_PARANOIA for git-gc, etc, I
> think we should do the same here.

I'm honestly still torn on this one. There are two cases that I can
think of where missing objects would be benign and where one wants to
use `git rev-list --missing`:

    - Repositories with promisor remotes, to find the boundary of where
      we need to fetch new objects.

    - Quarantine directories where you only intend to list new objects
      or find the boundary.

And in neither of those cases I can see a path for how the commit-graph
would contain such missing commits when using regular tooling to perform
repository maintenance.

So I'm still not sure why we think that this case is so much more
special than others. If a user wants to check for repository corruption
the tool shouldn't be `git rev-list --missing`, but git-fsck(1). To me,
the former is only useful in very specific circumstances where the user
knows what they are doing, and in none of the usecases I can think of
should we have a stale commit-graph _unless_ we have actual repository
corruption.

In reverse, to me this means that `--missing` is no more special than
any of the other low-level tooling, where our stance seems to be "We
assume that the repository is not corrupt". In that spirit, I'd argue
that the same default value should apply here as for all the other
cases.

But based on the discussion it very much feels like I'm alone with this
train of thought, which may indicate that I'm missing a quintessential
part of your arguments. May just as well be that I'm too focussed on the
usecases we at GitLab have for the new `--missing` behaviour around
commits that Karthik has just introduced.

Oh, well. I'll wait for answers to this reply until tomorrow, and if I
still haven't been able to convince anybody then I'll assume it's just
me and adapt accordingly :)

> As we are closing in on the v2.43 release, there's one thing I'm not
> sure about regarding release planning. Are these test cases that _used_
> to detect the corruption, but now don't? I.e., I would have expected
> that disabling GIT_COMMIT_GRAPH_PARANOIA would take us back to the same
> state as v2.42. But I think it doesn't because of the hunk in e04838ea82
> (commit-graph: introduce envvar to disable commit existence checks,
> 2023-10-31) that makes the has_object() call conditional (and now
> defaults to off).
>=20
> What I'm getting as it that I think we have three options for v2.43:
>=20
>   1. Ship what has been in the release candidates, which has a known
>      performance regression (though the severity is up for debate).

This seems like the best option for now in my opinion. The new behaviour
is not a bug, quite on the contrary, even though it is slower.

As Junio once said, we are not a "performance is king" project [1]. This
has burnt itself into my mind, and funny enough it was in the vicinity
of the change where I originally introduced the other object existence
check into `lookup_commit_in_graph()`.

[1]: <xmqqr1i1t6zl.fsf@gitster.g>

>   2. Flip the default to "0" (i.e., Patrick's patch in this thread). We
>      know that loosens some cases versus 2.42, which may be considered a
>      regression.

If we consider this to be a regression then I'd rather want to drop this
patch completely and leave it be. Ultimately, the question is how much
we trust our tooling to keep the commit-graph up-to-date, and whether or
not we need to account for corrupted repositories.

I for myself do trust the tooling, otherwise I wouldn't have sent this
patch. But I'm also happy to accept the current status where we are
being more thorough at the cost of performance.

>   3. Sort it out before the release. We're getting pretty close to do
>      a lot new work there, but I think the changes should be small-ish.
>      The nuclear option is ejecting the topic and re-doing it in the
>      next cycle.

I would be comfortable with this option if we simply switch the default
without adding special-casing for specific options like `--missing`. But
otherwise I'd rather not rush such a change.

Patrick

> I don't have a really strong preference between the three.
>=20
> -Peff

--Z0tkC3jKZ4NkLXz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVUyQ8ACgkQVbJhu7ck
PpQHLRAAksjP/gwdSds4b/aTbWmN9y7t4uXDZAKjgAGNhgubKYgsJtgUVkjfxVcK
ce1+t3FlcsnS+mhWGL/u2je7Dd6HJbi9wSXHRztM/m59dmnkut50p76uMRB5Sy5y
L+qqGfxwICfEz82rpVDeWT7vuTH5IoUBbWoG9jc4LFV+ws1lJuynM/Q0Ilmj3hmy
OhjhfMfOdOK2qJ2BSYZmxPBgcOxrhrBsRoWTxWc7JTCcheb0IvNAHAhEhedpnyAA
KYSpEVe/JF/8yLekLHRYbLyiaDaNYY2fQtlnRtB39gDdl0VuTeBSi8Tw2wd9S8++
OL+xF6fGLouQdgIfl3vNfdq+Ul3qCWOBW/y9pN0jxb86ez5kJselptSNwHfqwGob
cvkBMSdR15wRuRzpdDmTKp7KWMlKwq7VYayIEQJa+yVSeBqMO7dd+vfNvvUp6Sc8
HU7ygrlkL2eO/VWbRPmhYrQkOJ0HDEVpJW+GLXzGG0UmEFtvol1OAR/yznUU0nJp
fmcC6osKHKFpbADzoxA8yPR523mkNLOTJMJJBSWpq7ZY9lG0taT/KraNGe4UPj7X
WW0Qejs93dnH+ma9talHgaHCVwzqNcI3M+THTm7NknrTz00B/z0LpqJ7SL6yzJLz
KBcH7EOJyoAw0+TErd6hgbOm1JlH85ONWBWzwEfWXqCnjLR00r8=
=Nv8c
-----END PGP SIGNATURE-----

--Z0tkC3jKZ4NkLXz/--
