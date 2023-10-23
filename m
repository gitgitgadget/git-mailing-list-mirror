Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214F1B272
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GsJf8Xv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9oEpVWj"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4110A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B478B5C00B1;
	Mon, 23 Oct 2023 09:58:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 09:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069513; x=1698155913; bh=1s
	6RJpo7AS434CY2/Yb8dampSW9PjXZbyAEONe8AM9w=; b=GsJf8Xv6Q9mxtmPP9V
	tUEDHbyRTKQYsmnJhN2tccZD6Fz0wcBQ6cWx+pn3P0SJaTvS4qF0II/5Islunzj8
	dLeBLKGdGsvBn631WzXT8ROlPOqFVN5g+j169CFc//TbRGP5QhoQEGhJzwCTsFUg
	Vf1YUjf0Oh3GcqUnMRuQOnknCysVz0MdQc4Ewp3mShIURkN9zujXbxNnJxyJI7hz
	0NzUDuBizQZRwkTGQcDXb0/Re8i6dwYcY5mKEOGdN2xcAPQf55f33KCqPf2FMLeT
	Wv0GJgLpuH4dUmao8cVdlNHf9d5hK2tLDBorxQH8N3q41Rf2T3uRSF7NVtG05ag4
	/zUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069513; x=1698155913; bh=1s6RJpo7AS434
	CY2/Yb8dampSW9PjXZbyAEONe8AM9w=; b=Z9oEpVWjq8AaEN/1pxOsRIY8Zruj6
	RlGXTA7zoUPXAkj4/q/5pj7WIkNF0AYR20sP2dtV4R3J/g6OVR6NGDcsbKbtip3t
	Jrff4WK1gvGfcVw7L0uYBU8oKCyzE5bSHGJ8ykMP8G2pip7Esum+Qm27Fe1z+2B/
	mkVgRR2WnJAsjnU1tzicxH+3jYZkHgmr6TQmjea7FvBnATd/wYPMES2MzZeaKReh
	fkV8IXOpKLM3/JZTL8n2eLvCF0C1YSySgYeG/bUmShR1dbCwcZhw5KoFk2iHXxFV
	/nNDNPI64e+Efocoj8z0hZljfKglLL/1vvaZgQF7AP9Xi25eEH7buBn8w==
X-ME-Sender: <xms:CXw2ZbdvhYPg47cXFP4_iIlMQJKJxuy9rRDHv7T2wyu4PTKwtL9qbg>
    <xme:CXw2ZRMX2djQnUKLCd85bn1f6kTuNQ6VDs3ZOcFad3-Ebdp9ZvD-HKJyLn5UaiKDW
    5JBPxKYITsyz7FH0w>
X-ME-Received: <xmr:CXw2ZUg9DhZA5x8S32PXY-wnRTLNdcShwCGrKeHFUqh0sGGpl4OgsnEPfh-w8aDRD6yFLwCh3XauErCHFG4BOOOKdNkwj-iZo2EO_n3Z34_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:CXw2Zc8zYmJkuqFPU6IiIsoawDxhz77UFUX6MuiXnpeBAw91g3ZsHA>
    <xmx:CXw2ZXvNc5_lNQIY5Wq7MMiyeDuvh7sOx7fCsi16V7GFAeaN4MulWQ>
    <xmx:CXw2ZbGbNYcZPgep-Jo51i_wfih3nNxtjNSmKfBhl7OQUKKkHv38xQ>
    <xmx:CXw2ZQVKGNaR6fAitQNZg6d7p2nVfCuCI1t9SR0WkfoXDVShXmmq6w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 088c6d48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:29 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
Message-ID: <ZTZ8BpK-PV5fdYIT@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
 <xmqqfs27r5ng.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iEJIrpyiEcwJOyFQ"
Content-Disposition: inline
In-Reply-To: <xmqqfs27r5ng.fsf@gitster.g>


--iEJIrpyiEcwJOyFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 02:18:27PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -434,7 +432,7 @@ test_expect_success 'Query "main@{2005-05-28}" (pas=
t end of history)' '
> >  	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
> >  '
> > =20
> > -rm -f .git/$m .git/logs/$m expect
> > +git update-ref -d $m
>=20
> We are not clearing "expect" file.  I do not know if it matters
> here, but I am only recording what I noticed.

Oops, will fix.

> > diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> > index 10a539158c4..5cce24f1006 100755
> > --- a/t/t1450-fsck.sh
> > +++ b/t/t1450-fsck.sh
> > @@ -115,15 +115,16 @@ test_expect_success 'zlib corrupt loose object ou=
tput ' '
> >  '
> > =20
> >  test_expect_success 'branch pointing to non-commit' '
> > -	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
> > +	tree_oid=3D$(git rev-parse --verify HEAD^{tree}) &&
> > +	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid =
$ZERO_OID REF_SKIP_OID_VERIFICATION &&
>=20
> I have mixed feelings on this.
>=20
> In olden days, plumbing commands tended to allow to pass anything
> the user told them to use, but in more recent versions of Git, we,
> probably by mistake, managed to butcher some of the plumbing
> commands to make them unable to deliberately "break" repositories,
> one victim being "update-ref", i.e.
>=20
>     $ git update-ref refs/heads/invalid HEAD^{tree}
>=20
> is rejected these days (I just checked with v1.3.0 and it allows me
> to do this), and that is one of the reasons why we manually broke
> the repository in these tests.

My first try was indeed to use git-update-ref(1) to update the ref to
the tree object, and I was surprised to learn that it would not let me
do so.

> We need to have a warning message in
> comments near the implementation of "ref-store update-ref" that says
> never ever attempt to share code with the production version of
> update-ref---otherwise this (or the "safety" given to the plumbing
> command, possibly by mistake) will be broken, depending on which
> direction such a sharing goes.  On the other hand, forcing us to
> keep two separate implementations, one deliberately loose to allow
> us corrupt repositories, the other for production and actively used,
> would mean the former one that is only used for validation would risk
> bitrotting.

Wouldn't any eventual bitrot be contained by the tests though? As our
use of the test helper grows via this patch series its behaviour will
also be verified more thoroughly.

> >  	test_when_finished "git update-ref -d refs/heads/invalid" &&
>=20
> Not a problem this patch introduces, but I think it is a better
> discipline to have when_finished clean-up routine prepared before we
> do actual damage, i.e. if I were writing this test today from scratch,
> I would expect it to be before "git rev-parse >.git/refs/heads/invalid"
> is done.

I'll fix this while at it.

> >  	test_must_fail git fsck 2>out &&
> >  	test_i18ngrep "not a commit" out
> >  '
>=20
> A #leftoverbit that is not relevant to the topic; we should clean
> these test_i18ngrep and replace them with a plain "grep".
>=20
> >  test_expect_success 'HEAD link pointing at a funny object' '
> > -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> > -	mv .git/HEAD .git/SAVED_HEAD &&
> > +	saved_head=3D$(git rev-parse --verify HEAD) &&
> > +	test_when_finished "git update-ref HEAD ${saved_head}" &&
> >  	echo $ZERO_OID >.git/HEAD &&
>=20
> Are you sure .git/HEAD when this test is entered is a detached HEAD?
> The title of the test says "HEAD link", and I take it to mean HEAD
> is a symlink, and we save it away, while we create a loose ref that
> points at 0{40} in a detached HEAD state.  Actually, the original
> would also work if HEAD is detached on entry.  In either case,
> moving SAVED_HEAD back to HEAD would restore the original state.
>=20
> But the updated one only works if HEAD upon entry is already
> detached.  Is this intended?

Yes and no -- it's a reflection of the state when this test runs. One
problem in this test suite here is that many of the tests' states are
heavily interwoven with each other, which only makes this harder to
refactor without making any assumptions.

Well. Instead of restoring to whatever the state was previous to the
test we could also restore it to something sane-ish like "master". That
of course breaks other tests though... I'll investigate.

> > @@ -131,8 +132,8 @@ test_expect_success 'HEAD link pointing at a funny =
object' '
> >  '
> > =20
> >  test_expect_success 'HEAD link pointing at a funny place' '
> > -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> > -	mv .git/HEAD .git/SAVED_HEAD &&
> > +	saved_head=3D$(git rev-parse --verify HEAD) &&
> > +	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&
>=20
> Likewise.  Use of "update-ref" in the previous one vs "update-ref
> --no-deref" in this one to recover from the damage the tests make
> makes me feel that we may be assuming too much.
>=20
> >  	echo "ref: refs/funny/place" >.git/HEAD &&
>=20
> Even though "git symbolic-ref" refuses to point HEAD outside refs/,
> as plumbing command should, it allows it to point it outside refs/heads/.
> so this line should probably become
>=20
> 	git symbolic-ref HEAD refs/funny/place
>=20
> in the same spirit as the rest of the series.

Yup, this will be adressed in a later patch.

Patrick

> > @@ -391,7 +393,7 @@ test_expect_success 'tag pointing to nonexistent' '
> > =20
> >  	tag=3D$(git hash-object -t tag -w --stdin <invalid-tag) &&
> >  	test_when_finished "remove_object $tag" &&
> > -	echo $tag >.git/refs/tags/invalid &&
> > +	git update-ref refs/tags/invalid $tag &&
>=20
> Good (not just this one, but similar ones throughout this patch).
>=20
>=20

--iEJIrpyiEcwJOyFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2fAUACgkQVbJhu7ck
PpSTrg//WWarlpPrnq9MoFDB/qXsCaRL7RktMrvmyn7It7aIauPWK9DC31X9T5vE
Bi2mFfr3/u6o/kk8HWJqU4xafhhxqiuse17m5jM5g3i2sn3LV9/Hpe1QRKmJf171
KPlxT3JqZ3Xo4PxByBXoIDetQ3DCNXAQZhPB2IOQ7dxHUgNtAKIq0jdafqVX3Csg
TizXCeaqOHoV62EjpXHeByAOXtbEtzizJxxUMCXgEpRSMYzZAnySgEwhJ7c92pS7
lE2mUTbVVnusMBkDoOwrgxy1yzSTfFF7yHtNGeAtXpD3nidDS70QFm0+U/AauH3l
aqsfJjSdVGy8E1ptIuBROi70s7VBxtAcevuqhuh+ZRi4DiZP4ziD+0r8omajk1Bw
385/DplayMhMpR8sOOHEErszK3KJddQHDSK1XJO8c9DvumhQNhCMUQUf7c31jTAC
Kw/yCwDh0Uxdb4eNx/f9x5NXfBRkuHWyk2x5srWPBoE1m1GKoNqdjgBRVgX/zxRI
3XNbdKIQhHXw3sqICsAlPzIPb3YicG/nduqZ0+WL2A02LvGSb764k5X4MXUrn0lx
w+a3JbRYLvaQ339m376mH4efCtxc5EJHX0tDwll6T3mZRoRLdz2UDrY8Z3RpWAeG
5gym4FTjYhrC911xMfh5Z7FCY0lCQSAozNBdnoLGRyItxOFGvmg=
=2Vnm
-----END PGP SIGNATURE-----

--iEJIrpyiEcwJOyFQ--
