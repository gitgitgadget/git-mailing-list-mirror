Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F70BE48
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rftQqkpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwN9yQBk"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54007CC
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 23:16:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 55C995C01CC;
	Mon,  6 Nov 2023 02:16:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 Nov 2023 02:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699255015; x=1699341415; bh=jm
	5hLJ3o07lciCyzDmEGYypJ2MDHZ4at7/T/Iiy+cQc=; b=rftQqkpjH2n+qHwr4+
	zmrAyUCM611gVA3K7oX53CnM0M0Nv1GjZ90LlxBUUYZY/r0NCV8UOiZ2YMvnFvbe
	sb9jyMIPNSsXc8IBFz37B/aH9coOSODVE9uZxVgTfvezIW+N4Gw+Ke/4uvMVZPxs
	zJRrdCPB3cIiNy67iqKnDPvfU9kO+w3XEQ3jnY6fgKAsNEL1vW0c3H2bXZFtNGvF
	CFUmHTRUiO3vwNWrqxe9UGhhhr9FB/LmqNtU6FlzIacc4CspwhNunO8J6XGDYIqS
	VnetPPERCG1kmO7mJM7gnSlkJgy8VPrkOHVT6Ajl2+/CnfdHcIGDCgDGQebGTBGf
	Lr1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699255015; x=1699341415; bh=jm5hLJ3o07lci
	CyzDmEGYypJ2MDHZ4at7/T/Iiy+cQc=; b=AwN9yQBkAaqIOyx0zXBZnPw+qP8Hp
	HRqnZELuD6Zzv9H2XEo7T4C77IZdpH1p+dbpNG3bJ668F9OOmjMpmalwqP1OBRnX
	gG7AoVy5awwRWcrQiSJVdvM1ZuRM6GuII/huWLQy52ilLikgc821jxBeuO0Fj9Rc
	ssvxqEUvS2KcYO2mXtoRQLJCL5KR0dX55yWRR7cWY3AzAiOAA3sN2FlSK/3xNBoz
	SYq0gJNrKOyfjUfXk273QSkiQRM8POn8MFZzygsbeSfmJJjHY9/k/6k4GJV14op5
	0rG4EYGXTGbf4ebsVghr3T7a2H32dKmcHvNXkyhBxy873YqVwNT7IKjOA==
X-ME-Sender: <xms:55JIZUGKuUcbfEU-3Y9Kv0OP6yjl1rIgxPZ8XOo4sRHqYauIWi_j2Q>
    <xme:55JIZdVfGFadvyC7eg5r5r6pYrpkstTPpij06vXpNG7F42rL_Db5DmP01FBT0_zwh
    eqNCLlKAXEK2YoO8g>
X-ME-Received: <xmr:55JIZeKDNpRU9teyYcCUZsw_v0LRXtth5i21SvjmAAttRKBwZEzFa8d4yp-8FtBl0akAb-Da9mP7lCJDAy-F2jOrSL0rYMXY_zZrQaqet_aUk5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddufedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:55JIZWGf7uoH_62IYS3KJez8m0YlU_0zDrlnPJT0JeCwik7AExWb1Q>
    <xmx:55JIZaXGerKd-24Uxrtjp8xP4Cfh1n8HytEp55kmA10cdnpdHV4tjA>
    <xmx:55JIZZNuwQOhYQV_v8yLUC1Dj4JNZefKcOf0PPgx6eLziml-UkVUmA>
    <xmx:55JIZTd754yY0aE6NfF9TsdOH4JkaITdrGvVegc6XUMMXIihQGxf0Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 02:16:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b512060 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Nov 2023 07:16:32 +0000 (UTC)
Date: Mon, 6 Nov 2023 08:16:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] ci: split out logic to set up failed test artifacts
Message-ID: <ZUiS0llx6juV_1M7@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>
 <CAP8UFD25O9D1WL+CAQOcdqwuPsgdd6qOMNWuVtAw18U3RccYZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWN+gpiHvYcK4umE"
Content-Disposition: inline
In-Reply-To: <CAP8UFD25O9D1WL+CAQOcdqwuPsgdd6qOMNWuVtAw18U3RccYZQ@mail.gmail.com>


--cWN+gpiHvYcK4umE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 11:35:01PM +0100, Christian Couder wrote:
> On Thu, Oct 26, 2023 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > We have some logic in place to create a directory with the output from
> > failed tests, which will then subsequently be uploaded as CI artifact.
> > We're about to add support for GitLab CI, which will want to reuse the
> > logic.
> >
> > Split the logic into a separate function so that it is reusable.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/lib.sh | 40 ++++++++++++++++++++++------------------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 957fd152d9c..33005854520 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -137,6 +137,27 @@ handle_failed_tests () {
> >         return 1
> >  }
> >
> > +create_failed_test_artifacts () {
> > +       mkdir -p t/failed-test-artifacts
> > +
> > +       for test_exit in t/test-results/*.exit
> > +       do
> > +               test 0 !=3D "$(cat "$test_exit")" || continue
> > +
> > +               test_name=3D"${test_exit%.exit}"
> > +               test_name=3D"${test_name##*/}"
> > +               printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name=
} =3D=3D=3D\\e[m\\n"
> > +               echo "The full logs are in the 'print test failures' st=
ep below."
> > +               echo "See also the 'failed-tests-*' artifacts attached =
to this run."
> > +               cat "t/test-results/$test_name.markup"
> > +
> > +               trash_dir=3D"t/trash directory.$test_name"
> > +               cp "t/test-results/$test_name.out" t/failed-test-artifa=
cts/
> > +               tar czf t/failed-test-artifacts/"$test_name".trash.tar.=
gz "$trash_dir"
> > +       done
> > +       return 1
>=20
> Nit: I think it's more the responsibility of handle_failed_tests() to
> `return 1` than of create_failed_test_artifacts(). I understand that
> putting it into this new function means one more line that is common
> to several CI tools though.
>=20
> Otherwise everything in this series LGTM. Thanks!

Good point indeed. Not sure whether this is worth a reroll though?

Patrick

--cWN+gpiHvYcK4umE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIkuEACgkQVbJhu7ck
PpRkgw/+PaDFIupeOTKDodrVQnbjeFz4GXDQ9iJvNVhQWRDCLUIMhuismsmGdZAa
X+yYESPRTPbhWbxQyOt+0shUIayWuHwT2TYjtt4f3uixK6sCSxIa86y4r4qxM+Le
glVKNp0OdUAWSZIHDLlGWigVlwm+4TKRQmM/jDmAIi8ZssQlL1hLqkSZ350umtEm
EGszW7Bvx2R58VlX62cwWFPScK6+iLquLs+eH6v4yXjLMWAHyqAj44S5Nqh9STUq
QNn0ViNsu4wGTug9GsSzxIy+3+8PV2h2KINsoHKpgZ6bd3cEwu8xkWUHaPNyB3tI
z45KYsnsBzyow6A4Qb210BOSAotXhGYhT1t4V2B01oj3mp5UML63M/ov87KRhO9o
oEzXqNi/tnI92cal1WYcSV5BhrAZ+S1ZdMCPiYfAvbfL12aP3PPqVw9Foe8LnyNV
pXMLzZnMzDAVEJ8Xj+WNbiASLaj0lyQlspTZI5dODZOS+VMyVs8KgXoyajDEW/h3
vHJx4S/rgn0Fwu9F9snw8TXJaA3JQDFiKXd0ldzZrgzHnjgCuaOP8UuYoMiwRojU
dExIxkUiR7OeHiT5aDmy4sXDn/MubQT4DOnorlx8GjqL7f+P9RTT3n3SvKgyHsch
Ir0tvd8CC3iYtb71rWQckhShettaZU2mVFx5z137y8hGfpxFGF4=
=TjrJ
-----END PGP SIGNATURE-----

--cWN+gpiHvYcK4umE--
