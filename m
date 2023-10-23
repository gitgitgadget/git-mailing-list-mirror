Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1451A722
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i+lP9jHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SH/NjNtk"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF89C2
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9C7575C024C;
	Mon, 23 Oct 2023 09:58:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 09:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069507; x=1698155907; bh=lI
	PiLf19AFJnVDP57IIGXz8LB1M3TI8FN/StUAGZEQc=; b=i+lP9jHTZ4Ujs7lXzP
	Sb2S34CosUkRCZAsbU95MN66pTg7unEGvUcvjKyoibBiJCCaIqdpPWNBGYM0RXv4
	1V6rcSQ32Cyj2/ZKNaPKqBuO8Mx5kzu9/afsn0oyT6GfSkBN6HDDcdVwhW7qSknM
	ZSpB1EbdBKz7ZDwIazo/gpgB75aGxsBxRhSsM7DLEsBroFU97MEgBdpa79r0V5OT
	o+JIPEoGaL/uuAqEDP2HpofawggOLev2jyby8QK/71zGkhy6PPHAfqJrmDXVIzeo
	7fK6hpl9mXhuR72rLekFhGmOtpeIazylsS5unYWfVz/e7rsghy7PjBe8hwH71+7O
	k7dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069507; x=1698155907; bh=lIPiLf19AFJnV
	DP57IIGXz8LB1M3TI8FN/StUAGZEQc=; b=SH/NjNtkrCs9D4SfqOWtZzJgOQjQ6
	KxFcVwnZHgVnQqn2qx6Q5TZDrogoLE6rn5obRyQe84pGAM8IH0X7Sw9iEwBfNM2P
	aarKUZUR98UWMNSuOKz2WCHL28ABIHi2UfaJxR8oe5fPOvM2lAXdTBzo9V7+wH8K
	eMm8CaC4x102AiiBLWxupJQbRsHbS23ymt1umegNmzihMCNBJPXj270akL2mUH2Z
	T7AnVQ3Dxg16GqAzfyKE8HJbp9xWoWBIFD05IU5mL9lcUwXcTZ7Nd69OmHO6cCQv
	f16UEGuF/wkSGQxmaOxPn1tSSyhn3b61qkUgv4nL4VXIEaomfmGe7XmTA==
X-ME-Sender: <xms:A3w2ZfJDnUe8h9169QluTKK03NxVGMXovi7j-Xz4NpquCt3p_TJOQQ>
    <xme:A3w2ZTJ2D5De_Ck5lylmCA8e2owZEWi4w1tt1iQRJGQruZjEJrHG63Zq45H6mpIgf
    Nen_zeC5S4AwaedLw>
X-ME-Received: <xmr:A3w2ZXuXPoRTR9tBWTgmaVqm_jirGFl1if-avEbpcLlMbZo3zsmAtTMeH3w_ZlePNPOj0t85FcO-Q-th0keQKHsZMMQEWjPKzDN-XB9SEvGL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:A3w2ZYZtBh_DlSD6fXhvkk33nAFJbbHdL0jDNWniUM9_27OCzZd-0Q>
    <xmx:A3w2ZWbK7mOt8SqLnLkMcVK14Zo42CPzltpEUbxloqIwD5aw1lGvkw>
    <xmx:A3w2ZcBtcqEayocPxRhGsRnFwTeJcn79QC22pBeqCCL2AwODO8s9Zg>
    <xmx:A3w2ZZxjjyeYvyWidt7HN0L2lFxc4rPkyt2qu55QuEQfHREM8PChXA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43de4124 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:24 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
Message-ID: <ZTZ8ATohRe7GVu5D@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
 <xmqq1qdru6ds.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="16yQxMqwE1ahkwQl"
Content-Disposition: inline
In-Reply-To: <xmqq1qdru6ds.fsf@gitster.g>


--16yQxMqwE1ahkwQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 11:34:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > -test_expect_success "fail to create $n" '
> > -	test_when_finished "rm -f .git/$n_dir" &&
> > -	touch .git/$n_dir &&
> > -	test_must_fail git update-ref $n $A
> > +test_expect_success "fail to create $n due to file/directory conflict"=
 '
> > +	test_when_finished "git update-ref -d refs/heads/gu" &&
> > +	git update-ref refs/heads/gu $A &&
> > +	test_must_fail git update-ref refs/heads/gu/fixes $A
> >  '
>=20
> OK, the original checks "if a random garbage file, which may not
> necessarily be a ref, exists at $n_dir, we cannot create a ref at
> $n_dir/fixes, due to D/F conflict" more directly, but as long as our
> intention is to enforce the D/F restriction across different ref
> backends [*], creating a ref at $n_dir and making sure $n_dir/fixes
> cannot be created is an equivalent check that is better (because it
> can be applied for other backends).
>=20
>     Side note: there is no fundamental need to, though, and there
>          are cases where being able to have the 'seen' branch and
>          'seen/ps/ref-test-tools' branches at the same time is
>          beneficial---packed-refs and ref-table backends would not
>          have such an inherent limitation, but they can of course be
>          castrated to match what files-backend can(not) do.

I think initially it is beneficial to keep any such restriction and cut
back new backends to match them, even though it's more work. The main
reason why I think this makes sense is that hosting providers are the
most likely to update to the newer backend fast. It would be detrimental
to the users though if hosting providers that converted to the newer
backend were able to store such references that would be conflicting
with the files backend because they wouldn't be able to clone such
repositories anymore. And this isn't only true for hosting providers,
but essentially whenever two repositories that use different backends
try to interact with each other.

So even though I wish for a future where we don't need to care for D/F
conflicts anymore, I think the time isn't ripe for it and we should for
now aim for matching behaviour.

> > @@ -222,7 +220,7 @@ test_expect_success 'delete symref without derefere=
nce when the referred ref is
> > =20
> >  test_expect_success 'update-ref -d is not confused by self-reference' '
> >  	git symbolic-ref refs/heads/self refs/heads/self &&
> > -	test_when_finished "rm -f .git/refs/heads/self" &&
> > +	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF=
 refs/heads/self" &&
> >  	test_path_is_file .git/refs/heads/self &&
>=20
> I trust that this will be corrected to use some wrapper around "git
> symbolic-ref" (or an equivalent for it as a test-tool subcommand) in
> some future patch, if not in this series?

Yup, this is getting fixed in a subsequent patch. I had two different
options to structure this series:

    - Either by test file so that questions like this don't come up when
      a reviewer sees in the context that there are still tests that
      exercise the filesystem directly. This was my first approach.

    - The alternative is to write it such that we address common
      patterns globally, which I then rewrote my first version to.

There were two reasons why I didn't like the first iteration:

    - Commit messages would basically have to reexplain the exact same
      thing for every single testcase as the motivation is the same
      everywhere.

    - I think it's easier to review when you only see the same kind of
      transformation per patch.

But yes, it does have the downside that the reader is now left wondering
why the other call to `test_path_is_file` still exists.

Patrick

> >  	test_must_fail git update-ref -d refs/heads/self &&
> >  	test_path_is_file .git/refs/heads/self
>=20
> Likewise.
>=20
> > @@ -230,7 +228,7 @@ test_expect_success 'update-ref -d is not confused =
by self-reference' '
> > =20
> >  test_expect_success 'update-ref --no-deref -d can delete self-referenc=
e' '
> >  	git symbolic-ref refs/heads/self refs/heads/self &&
> > -	test_when_finished "rm -f .git/refs/heads/self" &&
> > +	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF=
 refs/heads/self" &&
> >  	test_path_is_file .git/refs/heads/self &&
> >  	git update-ref --no-deref -d refs/heads/self &&
> >  	test_must_fail git show-ref --verify -q refs/heads/self
>=20
> We already have the "ref is missing" test here.
>=20
> I'll stop at this point for now; will hopefully continue in a
> separate message later.  Thanks.

--16yQxMqwE1ahkwQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2fAAACgkQVbJhu7ck
PpSbQw/8Cq53OR68y6be4g8udlIXQZDxiaEHzPYS+CLTI7yvYGig/Z/v3/kWgQvc
ZD9gRGxU3nlFtCrwUh0vAaX/H9GoQP10CJvI+kTWaWfE4eosQddPgQ5hXk2MaMJw
48oOTpQa9tGHTeGPWJgwsRJsxP4BUUnJSNzVQ5NWnOT+urS1Qf+BuGxqnsKCZTsp
2DGEXgFgpxcHK3VdDFS+Nsho47Hpa21kiibMh9pwvxtWqQWwUDssD0mG3YtOH5Wh
UlpnQSSduLwxVZh4pqocwchNXLQBO5lQvYEOQUHCu9i6CNod+xFNZmcRh47rlKXI
R5doIf5H7pwbkXhy50xJe4MlHmfb6HKav9sEVJR86VxSu8Tb3gZ8RS4Rdrp3mjcj
GcBrqQVT50ds6jeZjN6Ub1EUmAQThk9d1FP+l+wL6aDfcOCdCpwePYMLfFoyfUA9
8xSnjFT49xNefnEPI5mLwAwA9chSGM4oORE17xtH/OTDbdmrDHSfjMQ8GrKEjwny
F39oGFuxVAktiUr0mnlZACIaJkl9SfI/br/1+Ib9aLiXPaE8BsPbswZx/cFnDJzK
rm/4G46f4Y9u+PChRMHLq841mHYB9iTFvwC7G0FotU9oH827j5Dxr0r+VRiuK2dU
xLyHd5qsrziI+pJ24fjwj4b5EsutDSNAnRR7e1rQVcNls2ovjEs=
=7JFZ
-----END PGP SIGNATURE-----

--16yQxMqwE1ahkwQl--
