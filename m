Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JSJ0rZlu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2XcRWcW7"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B7D9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:37 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 023C532027BD;
	Mon, 11 Dec 2023 04:08:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285716; x=1702372116; bh=Yz
	L1R/W2WFQalhX4cSabl88/jze7lGOtBBagwaouLyg=; b=JSJ0rZluvveRT9wbDq
	xVwf0NSACHEjMnXVtwut5vESLix8gn93JUTwTZOwuxDdvwAMxeLXvA1WVMwe2Jhy
	zXqmvRskPgk6eJ/hHXI5fzjfRaecUntZWKwYlTTktiXcIBxecuevk+qJXNuDZmdC
	qXE8qxQKU+JA1y3eIo0zkigCg3qksT9M3Ny+8TrKKuQUbUmZiMwJ45b3BtPVhWuY
	r2P8DrFZY4hFlgz4kxHPSh6oMjSZuESb1isBVO9hIpi5yNZAVEIxjd1Ng/Bf0OAp
	2KTUIP8ajPCq8H3OBwqDuAIA7ZQl+opJmB9p8zxOy189ipLdDi4DmhqKiC1/mENY
	X0Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285716; x=1702372116; bh=YzL1R/W2WFQal
	hX4cSabl88/jze7lGOtBBagwaouLyg=; b=2XcRWcW7wCF4JrxabewrYiiUucBnm
	xOhG1kZcR6RijQNzmcAfq8i82KTMDcDhZRwe9vjHIaWF3oeL6rnxueTsUTOQW3rp
	PGSYhj56ybj8RfVrzLsdyEirxmNBowTZ95ya7FSDD5Yv/1hfMEuWlGhIdifNPres
	QaQ89Rb3TfH5pltjulUbpwCrbwJ9NCznVnw6I5j/5SeQtXV0xbWkokT5mdbT+9Im
	DEDTTICmaI6Tg8X3AGq1iDZap3ESX9Dk5OkCK93DQ70phGg/v9ZRBf0dJv6wonbv
	VdW3/b4tPPTN7yfE4ayhV6FcSw1ZgZc+ur3vBfoA6j2Rjrj2PgB7kWcTA==
X-ME-Sender: <xms:lNF2ZbadYu8MlAKrOmc0uLtomzROn5mn9EVMqC-_2VHJVl8T1ENWKA>
    <xme:lNF2ZabGbAZXuqr2W4tqEHBnLc5is0HlzDNVbWtWbbFowFrkLcF_47e80Q0MNAoX0
    uNkQP_tPQ_PCMyWPw>
X-ME-Received: <xmr:lNF2Zd8QMoPDjcKFnrQJmAYpoqsKylufKJMY7MgWOdHWu7C2kWHi0eGfKrnstcHpmKRKlHvZlZVW6ztziEQpQLn80c-7k3p9Tqo5FrgXynde4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:lNF2ZRr18At_OP0x67XRCQS4sa12GfEEv_bQHJMKlqoarhxPYUQM8A>
    <xmx:lNF2ZWp8CU4jzrPDFbjEWvfuC8lb8u4MBNSkOrolL5y6iEm6MHnfUQ>
    <xmx:lNF2ZXTRb96TjcJOt2R4CcODYVFJ0-a4wUR9rBNJc9eIVTF-d7msjw>
    <xmx:lNF2ZZVx7VbvdHdkLrVl14z0IIHGqUl-Hr-QQvz3AnaoFD9M-YbQVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3a8ed26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:58 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/stack: verify that
 `reftable_stack_add()` uses auto-compaction
Message-ID: <ZXbRkOiD80zT7tC5@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im>
 <ZXOML2pcqVnVo0oX@nand.local>
 <CAPig+cRGZvyhSs9=3-tkBKRZDjDUsb-VDs+dzOaZof__qyBjbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z+rH8Yhe+RW9KBAt"
Content-Disposition: inline
In-Reply-To: <CAPig+cRGZvyhSs9=3-tkBKRZDjDUsb-VDs+dzOaZof__qyBjbA@mail.gmail.com>


--Z+rH8Yhe+RW9KBAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 06:46:33PM -0500, Eric Sunshine wrote:
> On Fri, Dec 8, 2023 at 4:35=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
> > On Fri, Dec 08, 2023 at 03:53:10PM +0100, Patrick Steinhardt wrote:
> > > +static void test_reftable_stack_add_performs_auto_compaction(void)
> > > +{
> > > +             char name[100];
> > > +             snprintf(name, sizeof(name), "branch%04d", i);
> > > +             ref.refname =3D name;
> >
> > Is there a reason that we have to use snprintf() here and not a strbuf?
> >
> > I would have expected to see something like:
> >
> >     struct strbuf buf =3D STRBUF_INIT;
> >     /* ... */
> >     strbuf_addf(&buf, "branch%04d", i);
> >     ref.refname =3D strbuf_detach(&buf, NULL);
>=20
> If I'm reading the code correctly, this use of strbuf would leak each
> time through the loop.
>=20
> > I guess it doesn't matter too much, but I think if we can avoid using
> > snprintf(), it's worth doing. If we must use snprintf() here, we should
> > probably use Git's xsnprintf() instead.
>=20
> xstrfmt() from strbuf.h would be even simpler if the intention is to
> allocate a new string which will be freed later.
>=20
> In this case, though, assuming I understand the intent, I think the
> more common and safe idiom in this codebase is something like this:
>=20
>     struct strbuf name =3D STRBUF_INIT;
>     strbuf_addstr(&name, "branch");
>     size_t len =3D name.len;
>     for (...) {
>         strbuf_setlen(&name, len);
>         strbuf_addf(&name, "%04d", i);
>         ref.refname =3D name.buf;
>         ...
>     }
>     strbuf_release(&name);

Yeah, I'll convert this to use a `struct strbuf` instead. But instead of
tracking the length I'll just use a `strbuf_reset()` followed by
`strbuf_addf("branch-%04d")`. It's simpler to read and we don't need to
squeeze every last drop of performance out of this loop anyway.

Patrick

--Z+rH8Yhe+RW9KBAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20ZAACgkQVbJhu7ck
PpScSQ//W2+2BdpGsm0lB+K7Ts//aatMwgtEvMkda8SySKf0ryuJWRgPRsGSUll9
hg48x1aQ2B1Y5EdSR13s5m+fsFOyF5kNEM14aWcwRGPKbP958Yp/LFjaPdJA3+cE
Aq8VJIdSBJWnq4aB5WC8cCYcoiAVZSAB1509fn5l+j9GhsRV9p18xukOLniF48+r
Zm5GAH+Y4BqyAIxGKmZW4j8CQM/ulVGWh6U871UXLhkIWowdDvdkNV0DEvwAi71v
4+vkMyJRpwtgsF0uPAIuWO3v6GxYxseP+d8knnMHrZntjcB48l3c7YHr2deJcE+8
2RovxfGQClgwfiqpX8yXg8bkpD05IYoEgXODuop22y7lBdZbA3hR1adUxDaUBQqt
QVxx/iYJVNeAd+ERK/hzajU634SwqSDC7ZhdwPE6rVomMwf8avG/6KgN2ERekmFN
ZqcqwSY7LeZoDDZsUJKqy6GjCrc5fGDnP0ZQOy4mGTu/GGmdBUXS+sPtLDdfEzGx
KLxaAl1p9m+GnqyiuKJ0OFBUYtr2Yqsvxgx8jaBKQD97NBfUd9ztIxFi1Rf7ANaV
YwUcHfyIgceRWmJAV51WwUlKdvBSGKx6GG+xEvhp1yNWY0rcnSAtGeMHOMg4VbZz
c/pqCCErgXO68Z3EB8/czOUKIsiLrgoSwIbtRVI7R93Anq2skvc=
=hx0n
-----END PGP SIGNATURE-----

--Z+rH8Yhe+RW9KBAt--
