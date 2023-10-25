Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A12770C
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rfyw3mk2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+po0Wr2"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8B130
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 04:51:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B4E365C01EF;
	Wed, 25 Oct 2023 07:50:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 07:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698234659; x=1698321059; bh=We
	BCfV2ILlfHAkI4xpEL7lO6C2sL6GrzsGfN0rdURcg=; b=Rfyw3mk2jcwrulzgMD
	uVzS59tNV1LlGhoyrfC290IZD9OF2AU7BKO/DpNBxVJCDOvrFyPaxmT71iZNwFlt
	0FfmoNIw07+tWSZKlg0wW0diN5EUkXR0uhhZYr5IIczIlnbEl75npg6qmTypAnQy
	Ts9R8ykuLoJV9GcQdI+J2Iiws2j0AwWBP+mDlm+EJeSULpEu9IbtSrDAoZC26eqd
	7yfKzpZSMup9dq+amvUHRXz7LxoCjvugyn2oeKIHZ1PcmBuLx2r7ogsOfLRYJksD
	4GrmCBAdu3NL64sph3n8hnsoq/o0pnvAjICgAVWS9F/w6Bzn0foRMCoagzB1B0s2
	afsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698234659; x=1698321059; bh=WeBCfV2ILlfHA
	kI4xpEL7lO6C2sL6GrzsGfN0rdURcg=; b=q+po0Wr2R1EWTKJJHTEHdvEgGuwRv
	lIRhpRgpRLftRUW88n19USF/JaeGQ5TjM8ko5VgsuzTFV1fTFtySAn1eSOIQBMEf
	6QDMGbnzW0GWlSN44tdvzblxprs3/E7GJyom2EflTJicROKE2GE5ubaWE4YUULKf
	Zj9LOccBhlhlFxa7+fg4SKWArlQdtQfpimLdMMTlAsF6k5pwrfP5u01bEcZcIWDk
	M9mo+U1BRT0437bCAvs0qFG4YzGAiyF+gpTVxeQrbbt4yn1r5ceAtUnDdtCpdMSx
	YpjsU5ncz2cq0PaJ/UMnTcmhfzO3fdCqWzNIivjZtwnffqLUC7uRZyeGw==
X-ME-Sender: <xms:IwE5ZcOR8RHuWp5D-I6UJHE2JytY8Tco0X4hxl2xCRrNanCJniIReA>
    <xme:IwE5ZS9eim4PYcTBci4zYkB9R1Kfdmd2IYqtjC6x8v4F5Yl2wMWNQ2N2h-4E_PYdN
    gwejVYcVJL8xhu3Ag>
X-ME-Received: <xmr:IwE5ZTSsPO5lD0Mc6zlYSRJqN_So2dSrTb2asmn-vNV8sr-abtJB6sS8_H8mbJZPb_k8PntsOGpCGk1IXGrT7SgOD7Pp3DN_LsubR3iKlpqfOQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:IwE5ZUt2Xw-OLu4bxBqwTn0j0aWTgNWzHWYSo54llxBrLyGNKWCSwg>
    <xmx:IwE5ZUeEVKO1np3uFU9nPr_WXgsYrNR2js-3Fnu2FOF5MvYhq5XNPQ>
    <xmx:IwE5ZY24Ln7uJmdEBUCMx5mc0uc6tNR16lfEaUozEFM7YgiSXqaHlQ>
    <xmx:IwE5ZVozG4A8npCMzaPdBdeH-fReQ-y7jU1aEFmFaC9ZhKToosM7jg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 07:50:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id baece706 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 11:50:52 +0000 (UTC)
Date: Wed, 25 Oct 2023 13:50:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 11/12] builtin/show-ref: add new mode to check for
 reference existence
Message-ID: <ZTkBIVODFzX8Jr5P@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <2f876e61dd36a8887a1286bb8db9fb6577c55c9b.1698152926.git.ps@pks.im>
 <CAPig+cRTOMie0rUf=Mhbo9e2EXf-_2kQyMeqpB9OCRB1MZZ1rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T9aCewfOR9lF6f+z"
Content-Disposition: inline
In-Reply-To: <CAPig+cRTOMie0rUf=Mhbo9e2EXf-_2kQyMeqpB9OCRB1MZZ1rw@mail.gmail.com>


--T9aCewfOR9lF6f+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 05:01:55PM -0400, Eric Sunshine wrote:
> On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > While we have multiple ways to show the value of a given reference, we
> > do not have any way to check whether a reference exists at all. While
> > commands like git-rev-parse(1) or git-show-ref(1) can be used to check
> > for reference existence in case the reference resolves to something
> > sane, neither of them can be used to check for existence in some other
> > scenarios where the reference does not resolve cleanly:
> >
> >     - References which have an invalid name cannot be resolved.
> >
> >     - References to nonexistent objects cannot be resolved.
> >
> >     - Dangling symrefs can be resolved via git-symbolic-ref(1), but this
> >       requires the caller to special case existence checks depending on
> >       whteher or not a reference is symbolic or direct.
>=20
> s/whteher/whether/
>=20
> > Furthermore, git-rev-list(1) and other commands do not let the caller
> > distinguish easily between an actually missing reference and a generic
> > error.
> >
> > Taken together, this gseems like sufficient motivation to introduce a
>=20
> s/gseems/seems/
>=20
> > separate plumbing command to explicitly check for the existence of a
> > reference without trying to resolve its contents.
> >
> > This new command comes in the form of `git show-ref --exists`. This
> > new mode will exit successfully when the reference exists, with a
> > specific error code of 2 when it does not exist, or with 1 when there
> > has been a generic error.
> >
> > Note that the only way to properly implement this command is by using
> > the internal `refs_read_raw_ref()` function. While the public function
> > `refs_resolve_ref_unsafe()` can be made to behave in the same way by
> > passing various flags, it does not provide any way to obtain the errno
> > with which the reference backend failed when reading the reference. As
> > such, it becomes impossible for us to distinguish generic errors from
> > the explicit case where the reference wasn't found.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-re=
f.txt
> > @@ -65,6 +70,12 @@ OPTIONS
> > +--exists::
> > +
> > +       Check whether the given reference exists. Returns an error code=
 of 0 if
>=20
> We probably want to call this "exit code" rather than "error code"
> since the latter is unnecessarily scary sounding for the success case
> (when the ref does exit).

I was trying to stick to the preexisting style of "error code" in this
manual page. But I think I agree with your argument that we also call it
an error code in the successful case, which is misleading.

> > +       it does, 2 if it is missing, and 128 in case looking up the ref=
erence
> > +       failed with an error other than the reference being missing.
>=20
> The commit message says it returns 1 for a generic error, but this
> inconsistently says it returns 128 for that case. The actual
> implementation returns 1.

Good catch, fixed.

> > diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> > @@ -214,6 +215,41 @@ static int cmd_show_ref__patterns(const struct pat=
terns_options *opts,
> > +static int cmd_show_ref__exists(const char **refs)
> > +{
> > +       struct strbuf unused_referent =3D STRBUF_INIT;
> > +       struct object_id unused_oid;
> > +       unsigned int unused_type;
> > +       int failure_errno =3D 0;
> > +       const char *ref;
> > +       int ret =3D 1;
> > +
> > +       if (!refs || !*refs)
> > +               die("--exists requires a reference");
> > +       ref =3D *refs++;
> > +       if (*refs)
> > +               die("--exists requires exactly one reference");
> > +
> > +       if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
> > +                             &unused_oid, &unused_referent, &unused_ty=
pe,
> > +                             &failure_errno)) {
> > +               if (failure_errno =3D=3D ENOENT) {
> > +                       error(_("reference does not exist"));
>=20
> The documentation doesn't mention this printing any output, and indeed
> one would intuitively expect a boolean-like operation to not produce
> any printed output since its exit code indicates the result (except,
> of course, in the case of a real error).

I'm inclined to leave this as-is. While the exit code should be
sufficient, I think it's rather easy to wonder whether it actually did
anything at all and why it failed in more interactive use cases. Not
that I think these will necessarily exist.

I also don't think it's going to hurt to print this error. If it ever
does start to become a problem we might end up honoring the "--quiet"
flag to squelch this case.

> > +                       ret =3D 2;
> > +               } else {
> > +                       error(_("failed to look up reference: %s"), str=
error(failure_errno));
>=20
> Or use error_errno():
>=20
>     errno =3D failure_errno;
>     error_errno(_("failed to look up reference: %s"));

Ah, good suggestion.

> > +               }
> > +
> > +               goto out;
> > +       }
> > +
> > +       ret =3D 0;
> > +
> > +out:
> > +       strbuf_release(&unused_referent);
> > +       return ret;
> > +}
>=20
> It's a bit odd having `ret` be 1 at the outset rather than 0, thus
> making the logic a bit more difficult to reason about. I would have
> expected it to be organized like this:
>=20
>     int ret =3D 0;
>     if (refs_read_raw_ref(...)) {
>          if (failure_errno =3D=3D ENOENT) {
>             ret =3D 2;
>         } else {
>             ret =3D 1;
>             errno =3D failure_errno;
>             error_errno(_("failed to look up reference: %s"));
>        }
>     }
>     strbuf_release(...);
>     return ret;

Fair enough. I've seen both styles used in our codebase, but ultimately
don't care much which of either we use here. Will adapt.

> > @@ -272,13 +309,15 @@ int cmd_show_ref(int argc, const char **argv, con=
st char *prefix)
> > +       if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
> > +               die(_("only one of --exclude-existing, --exists or --ve=
rify can be given"));
>=20
> When reviewing an earlier patch in this series, I forgot to mention
> that we can simplify the life of translators by using placeholders:
>=20
>     die(_("options '%s', '%s' or '%s' cannot be used together"),
>         "--exclude-existing", "--exists", "--verify");
>=20
> which ensures that they don't translate the literal option names, and
> makes it possible to reuse the translated message in multiple
> locations (since it doesn't mention hard-coded option names).

Done.

Thanks for your review, highly appreciated! I'll wait until tomorrow for
additional feedback and then send out v2.

Patrick

--T9aCewfOR9lF6f+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU5ASAACgkQVbJhu7ck
PpTYSQ//SaH7RxtEYWhmeOztOnInUHKPES4ZkDIfkePnVBw9znKLR0LH170mPuUy
KUKLIW4TfxbM4/lpM9YE9erPGGJJaLXepV2oaZJbcIJ8r6LoxDz4LIXP4Pup2lWh
cIoheIe2kqu0ZPr6xUELoZxn1gxVCymy6CgvHbHBwbPZDYYY9OvQ7D3k/fSEpSA9
yrDZfHWJU19m6YnAmqBtA0wWn11L285FMcysxAS1mo8T+y5eAPB9WzMXUBnj8SIv
881xfTOgRAz+uI35CGLanDYGmWQG8pd7JmdbFzGWsndITGUgWAntIDxC9rS4mjNc
bqNRl4pSoIoPC2J1WWdoEQ767mJOMmyNm9pA4G1KN7CgTmXGMM6/QVtdF3MBlCOi
VoEmTv9mKwsZZorbhrEXx38cAflhz7zj6XOPwKt47vDDP2xZi5ORGHmZ4w7JlJXy
bXfwJISu7o8EDXzudiR+tK5Oh/Lly1tlYDLQMY6gw2D9g85gMOWteXffK9bnYrxS
5P1HYuFXTCvLd0D5zv4M57+hpR4Cl72NFZPFBM3gCC4LaLE2GjZnM5axWk5A31cp
4PbCdR9sSL5H16HBm+NMHwVQ8e3pPtMj4EHQSglRf2KucBnQ0Z6KnAQTCuorWAE0
1I+JCaWBmuQ6X33t5lzq/SH4RZ8ITRxfUCEXsPYFRrbClD7ubbM=
=ynoW
-----END PGP SIGNATURE-----

--T9aCewfOR9lF6f+z--
