Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195E18021
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eIPwEjD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXjAZvOP"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B214AF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:57:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6886032009BF;
	Mon, 23 Oct 2023 07:57:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 07:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698062224; x=1698148624; bh=Tg
	Xh6Wynbima/JHsVWC7x0zRpVZgLynRO6J0R/gaCK8=; b=eIPwEjD7jswYT64T33
	cMukK0xkNPSqEjNIBUcSkAUhB75GQf8rfWJEr/QIO7RKE4YpZLJuCZ0S+3XwF668
	elmWYy+8uLtgth7rE0xQ/UoVUyXMZdGEkX32cOykAPz85+wmUxIBmW4CpoiR0Lt8
	CCkikNITbjY8oUiPJBNhoYr/kVuJKGtiddnqWCV1OItDw2qdaeTAQ6dJJo90jEGJ
	RubgFzn9Jgl63pQa3DUjdCJL+akn15dHy4TP1/jEQfrFzYGlYGJiqWuKAUKLYXiD
	mvPCAyopHGwFy6tGEL802A2Wei8uhwAQHf1WPHdCIc1aXZlZW0EhhNcpDCovmseE
	lpXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698062224; x=1698148624; bh=TgXh6Wynbima/
	JHsVWC7x0zRpVZgLynRO6J0R/gaCK8=; b=TXjAZvOPG05BXvm+p39ksqnwt0dtY
	835IQDQrAu8K7AWB79aUHG5RBizaSR+lk5+GbSdMjrAP2grwt7iYb+GoupajYhpr
	2FRtD9vqtebnLHJ4PMTRmRrqXYOIFcAGrC6ToZ40OBN8Faxf4JJbhl65uPrDhby2
	Tv4dNVY804WM1jgiah7SmxitPb7AHPU6J4nXlJVGAoyrlhjn+/Fx3lmsgVLBTXsJ
	Ri6Hmz/a3XwPfnMkMc6QfhYCsBf6X7NuiewFALMm4HJBi7Lpvnbd2/0RPMUghtHM
	u/co3Dpc1PsydlP0WVNu7uI4oFy146hjwY/hM8Qj5JVZgguTs577XwZZg==
X-ME-Sender: <xms:kF82ZTP2p2f2uAv1C56MdeR0XM0nyhd2bhlERVxDJLk5QcpkaVdNBw>
    <xme:kF82Zd_Br4IiYUgfKNdxRwR4rTKMoKjbL_b-RzAQnMVJfrlCSh3mXIFKFhOBlj71O
    Q6pl4wHLL1DHg1N1Q>
X-ME-Received: <xmr:kF82ZSQ--J-ic6BP1DfmxZdI9j5ycSQanTe4i5LZICd9PZaE0CKkyaN7KD6tHKkM78uUHGFXJp0sXlaYq2DxHUS7kTnq0Qn4q_zMPL4n-B2r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kF82ZXs5muoab8q9v_C2Z-_JDzn4DMHSDzNO7of4VvPB7Ej6zyYBGg>
    <xmx:kF82Zbe_9lYPAsK_tFsAzXwye9xU9r5VTBwNFtkeVF6jh4XEn7sXWQ>
    <xmx:kF82ZT2n6KbTy4yzxWbUIgK4CvHc3ezYibIziCmBSxiWyGjlgS8fIQ>
    <xmx:kF82ZcpsH5Lf9QkCmXRZzff0wI3Ao9obXxyHxToPRUCXARXZ9669rA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 07:57:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f66a9bb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 11:56:59 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:57:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
Message-ID: <ZTZfjPDyw1nSP74d@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <ZS9vp9dnoVVUsMIt@tanuki>
 <xmqqlebzzeh8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ho4Gj8bt7B6Ul98"
Content-Disposition: inline
In-Reply-To: <xmqqlebzzeh8.fsf@gitster.g>


--/ho4Gj8bt7B6Ul98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 04:40:35PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > As usual, I forgot to mention that this applies on top of current
> > master, which is at a9ecda2788 (The eighteenth batch, 2023-10-13) at the
> > time of writing. I look forward to the day where I remember to include
> > this information in the cover letter...
>=20
> I heard rumors that we have a --base option that records such a
> piece of information in the format-patch output (I haven't used it
> myself).  Would it have helped, or perhaps it still needs some
> usability tweak?

I was aware of the option, but somehow never thought to use it. I guess
others are in the same boat as this is a semi-frequent topic to come up
on the mailing list.

What will fix this for me from now on is that I've now discovered the
`format.useAutoBase` config. To fix this for everybody else without
having to go through the same process we could change the default to
`format.useAutoBase=3Dauto`. This can lead to hard-to-understand errors as
pointed out by 7efba5fa39f (format-patch: teach format.useAutoBase
"whenAble" option, 2020-10-01) though:

```
$ git format-patch -1 <an old commit>
fatal: base commit shouldn't be in revision list
```

But this was fixed via the new "whenAble" value for this configuration,
which will cause Git to ignore the case where it's unable to figure out
the base commit. So maybe we should consider to make it the new default?
I cannot think of any real downside. In the best case we simplify the
life of many maintainers of mailing list based projects. In the worst
case where we are unable to figure out the base commit nothing changes.

Patrick

--/ho4Gj8bt7B6Ul98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2X4sACgkQVbJhu7ck
PpSdYA//WK5dIWhDiQGCj5Gl8HFvdOlR9y5Hf6INLiXLhrM4jbB60OGOXWp7U8qw
i9/FyIFjutLv3HrH4cNjJ0WHKnEcNOgoxnI7vWIm9WuzERGsFPTcUQ5tHVu0gy/d
NOLDH64yea2NT0Ff2SOPRxtkOwVovXWH5PLpIZOoocymVeMjQi9Oee7ZKo0fQrwd
6D5L23buItNR0EvbcLEqR0dnvrYtPFhAyKvpMyL/Ho+J58xcPwdeecKl9SZx1mZg
qjIbOqfsbZO0lake53loGpz+guV+kyS0D9qlTijYeqJnHZAaf8krNKMOw2ysrKrb
q5rC/vDEORHCjQjeltmN7vmIMqaSZYX0iKh46yHdTapWJGL2VQRbQmSrU6Bq/NnU
yY6WDAL0OOFeKYsHiUHQhNBDVllM/JvZ9xOKEmywUuCQYDRsQsRMYhRBDQO5efm7
jt/O6fM5tvDd1Hmte4+D848i3QL7i+ScCEVUgmPfUMjN3jrmCiK00KLPqHL1dFO9
k4PlWw9mlmGxUpmLAV2/M8DGut5+G5U0xkQX8W7ektcDr3Ruc2HAQjReFnYiItrH
wmq9MhnXti7+AQ+cy79y5JNWYDmQ8lbHKe0KRuzuGyzqZeP1ftyTubr71WRZB5wF
rtP1V61JcKV6qMJd53PYKwaiVD6ZgNpGxK34dqBjX3DR1WZkQNg=
=q6zh
-----END PGP SIGNATURE-----

--/ho4Gj8bt7B6Ul98--
