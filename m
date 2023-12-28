Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5921522B
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VvazWHLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z/YdSXDF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C28B15C0129;
	Thu, 28 Dec 2023 03:14:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 28 Dec 2023 03:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703751298; x=1703837698; bh=Fum3CCjan1
	51vAfJb+fzZNK3L1xXkKOSnE1tzdDlCD8=; b=VvazWHLSvCYY2yCAZstvb4sWgD
	V4sI+FEUCJ3vFxNaBjilArnEFzfwA80iyupZXSJWyfN5diFp8iQLGb+J+eg0z1Qh
	kuh2LZe0fRClzZfj449l3TwmdAW7G4IhE9wt0RzeN8ymT4uKe8cVKczojfMbNaCF
	S4rCaq5McGG5rUR/rwWIpvUey1JvOtK5I41yqJR8jbUfvWK3KsN7SY4KwLAO6xGA
	mKNwHmMHXSMvuDvzc8+R80p3yPjvI2TtTNRd6QkaBv2jPDAZRMqf8zyZ1Himephu
	GyLjhDlSA/U6we8sInT+YgThkn2cugScIn5V1sCdDtpX6GHaD3smq4vlXGYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703751298; x=1703837698; bh=Fum3CCjan151vAfJb+fzZNK3L1xX
	kKOSnE1tzdDlCD8=; b=z/YdSXDFZj3m3JitlhZlrG5Kb8+PNIr8RJHtvkVFLHtg
	MqSpoZGOe+WC4gMvlyz7iEmVZFGyhzc8jY/jVBdcon5ys41w8+CM0Dc2dtXCRut2
	7GaBEUlNFiU9cswIJRrOpV6gxOF1FGqqm4HZtjHOizpCGNfmzm/L6aYiAypvC8xh
	I/hZRspAez0f3giBJUvJF0tI9axukJrGbeNWK7X1qEIhLW9cXWS7GpOFlMUEC6S2
	MecLDhbH9Xmgvyjz9LHbxBD8upFmOm2QYBeVTSBoZ/cYej+WCMjcxXIHrzVguwB4
	P+BmyCDlCL7IM19huOxi3UxScMtRdxjRN6VTlDeDnA==
X-ME-Sender: <xms:gi6NZVwjXGgZBcpmldh7hNAIhffdKB_OBw7b33Nqv0DceVtJZ2iG3g>
    <xme:gi6NZVTSxd-wTpVOK7LajfFM5gEdvPCGiLrNkMvri9XXMufIwHZGbdO-h-h9WLMrM
    8U_RsBT8vmXcqCxLA>
X-ME-Received: <xmr:gi6NZfVdArdaS_c8s2UmhZoBABnCuQ_EPzBtmyX9_S-2i2dACYkf7hfUNLB-B2ruiA49xoDmaYjGgawMtK14p7aenoXR7degWemZXnWeFswKVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetfeetleeiffdvveffgfehhfduleelffeujeevvdehfeffiefhhefhleffieej
    jeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gi6NZXiLK2VFD_enjWq3-ch5dIF0QKpzr9hcUJQGzCr51fApLL8odQ>
    <xmx:gi6NZXD2uxHkrPHFE4nPSYQPCvCNIYerIien_pEqhVBe_Olt_RmqUQ>
    <xmx:gi6NZQIqlzzWRGhy8wLvqSdZEHUZ8-edFwowdHV7i27qM9a_LTGc6Q>
    <xmx:gi6NZeMNhugIWworplaX7Yn18lgvTmqtzNSqDtqQVpRqnI7H7gpTYQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 03:14:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65497b8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 08:12:41 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:14:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Terry Parker <tparker@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: reftable: How to represent deleted referees of symrefs in the
 reflog?
Message-ID: <ZY0ufWTW0W9DSyzl@tanuki>
References: <ZVy0zKcmc8tjmgzs@tanuki>
 <CAOw_e7aDPTjDj_K3yyyatWkw3R-oT+_u1LgZyzQEE=6LnH+pmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YixbWIW1fJmp9fBJ"
Content-Disposition: inline
In-Reply-To: <CAOw_e7aDPTjDj_K3yyyatWkw3R-oT+_u1LgZyzQEE=6LnH+pmg@mail.gmail.com>


--YixbWIW1fJmp9fBJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 08:03:00PM +0100, Han-Wen Nienhuys wrote:
> On Tue, Nov 21, 2023 at 2:46=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > To me it seems like deletions in this case only delete a particular log
> > entry instead of the complete log for a particular reference. And some
> > older discussion [1] seems to confirm my hunch that a complete reflog is
> > deleted not with `log_type =3D 0x0`, but instead by writing the null
> > object ID as new ID.
>=20
> No, writing a null OID (more precisely a transition from $SHA1 =3D>
> $ZERO) means that a branch was at $SHA1, and then was deleted. The
> reflog continues to exist, and new entries may be added by reviving
> the branch. That would add a $ZERO =3D> $NEWSHA transition, but the
> history of the branch prior to its deletion is retained.
>=20
> >  # This behaviour is a bit more on the weird side. We delete the
> >  # referee, and that causes the files backend to claim that the reflog
> >  # for HEAD is gone, as well. The reflog still exists though, as
> >  # demonstrated in the next command.
> >  $ git update-ref -m delete-main -d refs/heads/main
> >  $ git reflog show HEAD
> > fatal: ambiguous argument 'HEAD': unknown revision or path not in the w=
orking tree.
>=20
> This looks wrong to me. HEAD has a history, and that history didn't go
> away because the current branch happened to be deleted.
>=20
> > It kind of feels like the second step in the files backend where the
> > reflog is claimed to not exist is buggy -- I'd have expected to still
>=20
> right, I agree.
>=20
> > see the reflog, as the HEAD reference exists quite alright and has never
> > stopped to exist. And in the third step, I'd have expected to see three
> > reflog entries, including the deletion that is indeed still present in
> > the on-disk logfile.
> >
> > But with the reftable backend the problem becomes worse: we cannot even
> > represent the fact that the reflog still exists, but that the deletion
> > of the referee has caused the HEAD to point to the null OID, because the
> > null OID indicates complete deletion of the reflog.
>=20
> This doesn't match my recollection. See
> https://github.com/git/git/pull/1215, or more precisely
> https://github.com/git/git/blob/3b2c5ddb28fa42a8c944373bea2ca756b1723908/=
refs/reftable-backend.c#L1582
>=20
> Removing the entire reflog means removing all the individual entries
> using tombstones.

Yeah, indeed. I was misinterpreting older discussions here, and now use
individual tombstones which does work as expected. It's a bit
unfortunate that deletion of the reflog thus scales with its size, but
for now I think that's okay. We can still iterate on this if this ever
proves to become a problem.

> > Consequentially, if
> > we wrote the null OID, we'd only be able to see the last log entry here.
> >
> > It may totally be that I'm missing something obvious here. But if not,
> > it leaves us with a couple of options for how to fix it:
> >
> >     1. Disregard this edge case and accept that the reftable backend
> >        does not do exactly the same thing as the files backend in very
> >        specific situations like this.
>=20
> I remember discussing with Jun that it would be acceptable to have
> slight semantic differences if unavoidable for the reflogs, and there
> should be a record of this in the list.  I think there will always be
> some differences: for example, dropping reflogs because of a dir/file
> conflict seems like a bug rather than a feature.

Initially I'm aiming for matching semantics, because this will make it a
ton easier to land the initial implementation of the backend. But I do
agree that eventually we may want to iterate and allow for diverging
behaviour between the backends.

Thanks!

Patrick

--YixbWIW1fJmp9fBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNLnwACgkQVbJhu7ck
PpSq8g/8CzdJ0sGJo/jfz4kpw3kYx9k4jyxmz93WHdL+RyD0YFwfiYGf0EDrDNl4
hkIV/vUfvog9lsMweYCVEvC+O+Tr3dwCrNWrL7tpNQU/xTFuVVIiM0JLyIe7NgAY
RgddG2Sfv7UQewwTer5Mq/5HQeNi565s6HAxU7oX+ekqy1SiOMvWGl0XdRzK6+Nd
Z9m2Bz8ZMdF1fm4l9Xe3ROuMFwjdbYUuOEiMIDEyTpYjYiNqLfnPWPzB6X/Ywu+f
phkN00BHhGWx1qW1UEMd3qzENQqde4Kdmn+GFYFRXqS0AI82n7Y8SsqDwSeyFx2D
G6kHgO8xzCAtB/EGEZQ4W0HpouY4OgZfFozeQwY1bica21gtTW7eGvta1xdHuJ4J
XsFwJVBXBgpWM/YjJjDIrzG1UV525dSjTCVoKNf+anXQF9iYUTdMwywmUJlv6Kdp
kDXeDPXRBn6dJRu9lpa2SwhAu93OJCG2jY94B8fP0tMfOqj4IYOAvbp8bsYQVTor
jJi451InuiKxIRrX9D0D1XwTYOqSgQphSj/J3F7/BRp4Ls2BJc5A20laDhOPQlK1
HbRBvy4M3+XcXFT0eYIdy7E7ZjEMBzWHGjJVWE2VLh91ykgeZ/ZmCbkl1BcmKSIg
sAxFY8TtFvQOtQFs+nF0srkdILhNoV1G7Kf3RuCJn9a8/OGgSB4=
=xfrG
-----END PGP SIGNATURE-----

--YixbWIW1fJmp9fBJ--
