Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862F11C85
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XkNmZyXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpr0MZQA"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5C6503200A5B;
	Thu, 11 Jan 2024 04:21:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 11 Jan 2024 04:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704964900; x=1705051300; bh=WO/y38iJ4J
	s1ysnAigEnZC9mYiFkkarpMozdKboPK2s=; b=XkNmZyXyJKofGiHNPBEttMN0Kx
	Clos8RAc1PnCWTNaa8A1YtXCmIwm/T1GjwvxPmn6AJ+cj/tiTpLyV3lcawXZnUhL
	xaBOKrjrGp5WIa24snbrEUsrY/+9n6leUBsBh+07LsR/Q3jSsfF7+U6gXj9vvIQp
	CgDL8iKZm4M+WcfHwHaQzBfnoeQdn6WdJdTGdW4RWm9i//HDnmXkkOj+OzyCehNc
	Ot3USkJ23qgXpwKIEiiR+tPK0mxjeb/q7uy7w+3OrDif+G1tsoKlxtARhzz+zSvz
	2K9bQ7thp6gO516kV4oLG1m4ilOyGWW2IPjAElguCNm76RNBqyaFQango7wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704964900; x=1705051300; bh=WO/y38iJ4Js1ysnAigEnZC9mYiFk
	karpMozdKboPK2s=; b=hpr0MZQAZgFJP8tCDF0N1JK5ckKKZAJUIzQ775W7qKbn
	xHgv8/ysHB2CgjeZc75aNbMfee5BlDuTItacFfqppq5AcmoguO8ChNzzKfSD58jI
	xnaWLyGB9ziqjXVo+dNcWlOYOh8F0QwsaaSi9xBdR7zoMQvrmaiamJwe642AHCTW
	h/nePAb+DPqDTCdOEjYjWLpMj2L1zET8GiO6mZ7fQbF3wj9YijxlkTbxNA/xO8nc
	Z2PPJe4GFsa+afjdyqyi/esEyJWSKL/U+8mfoK0xCGmnr+FPpt4F5pTW842BWuAt
	XzUIQ7q6ioAHRtORal0GBkBwVrlJwpUDTZ/nErTRDg==
X-ME-Sender: <xms:JLOfZTFYuMhJvdAGHZqSkcQDap0UqtixlhcODjcMogHbL2PAZJMp9A>
    <xme:JLOfZQWv2ygZGwW8DAA9zI9WD3NQGqv7kdr6dkaLaSZgk2BDv4FCc2Jv3UP9w1ZNo
    hNiNsIeOJpKFKVHRA>
X-ME-Received: <xmr:JLOfZVJbxGqjsOJ965HsnklrlWAcqSQxRYu2IRyOhbOAwX-O8G_A0uZNiLuma2G-dwI13dYmDUINuKU1zp37HcWyzqdMcLGqZwqLVa3_K97obA0yPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JLOfZRH6IXDbmKQhHGJXQdJ5yHpt2PvtYe5Ls4fVFxCtNkHWWF6Mmg>
    <xmx:JLOfZZWDEseWDrmjip6t-u14WtuuMUx_GuVC3w0F_sNDgeMvqOVkGw>
    <xmx:JLOfZcOAXGlpoYVTivZfrJ27N7O6cwS1nQTGPTJm2tMqhOJcOWwEPw>
    <xmx:JLOfZYfWfV1k3gDa6tYzZjDlxZPkdoLv5YcaQT69XzrmbxrnOasVBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 04:21:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 364809bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 09:18:56 +0000 (UTC)
Date: Thu, 11 Jan 2024 10:21:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 4/4] reftable/blocksource: use mmap to read tables
Message-ID: <ZZ-zIHOQfU_llj4u@tanuki>
References: <cover.1704714575.git.ps@pks.im>
 <a23f38a80609a5c5a6931400ffd28a92b33838bb.1704714575.git.ps@pks.im>
 <xmqq5y00anlj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9UNmmjb5KXtofsfd"
Content-Disposition: inline
In-Reply-To: <xmqq5y00anlj.fsf@gitster.g>


--9UNmmjb5KXtofsfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 01:24:24PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Using mmap comes with a significant drawback on Windows though, because
> > mmapped files cannot be deleted and neither is it possible to rename
> > files onto an mmapped file. But for one, the reftable library gracefully
> > handles the case where auto-compaction cannot delete a still-open stack
> > already and ignores any such errors. Also, `reftable_stack_clean()` will
> > prune stale tables which are not referenced by "tables.list" anymore so
> > that those files can eventually be pruned. And second, we never rewrite
> > already-rewritten stacks, so it does not matter that we cannot rename a
> > file over an mmaped file, either.
>=20
> I somehow thought that we use "read into an allocated memory and
> pretend as if we mapped" emulation on Windows, so all of that may be
> moot.

Ah, you're right in fact. I missed the definition of `git_mmap()` and
`git_munmap()`.

> > diff --git a/reftable/blocksource.c b/reftable/blocksource.c
> > index a1ea304429..5d3f3d264c 100644
> > --- a/reftable/blocksource.c
> > +++ b/reftable/blocksource.c
> > @@ -13,6 +13,12 @@ license that can be found in the LICENSE file or at
> >  #include "reftable-blocksource.h"
> >  #include "reftable-error.h"
> > =20
> > +#if defined(NO_MMAP)
> > +static int use_mmap =3D 0;
> > +#else
> > +static int use_mmap =3D 1;
> > +#endif
>=20
> Is there (do you need) some externally controllable knob that the
> user can use to turn this off on a system that is compiled without
> NO_MMAP?  Otherwise it is misleading to have this as a variable.

No. The benefit of using a variable instead of using ifdefs is that we
know that both code paths continue to compile just fine. We do the same
thing in "refs/packed-backend.c".

But this code is not needed at all anyway, as you pointed out, because
we can simply use the emulated mmap(3P) code.

> > +static void file_close(void *v)
> >  {
> > -	int fd =3D ((struct file_block_source *)b)->fd;
> > -	if (fd > 0) {
> > -		close(fd);
> > -		((struct file_block_source *)b)->fd =3D 0;
> > +	struct file_block_source *b =3D v;
> > +
> > +	if (b->fd >=3D 0) {
> > +		close(b->fd);
> > +		b->fd =3D -1;
> >  	}
> > =20
> > +	if (use_mmap)
> > +		munmap(b->data, b->size);
> > +	else
> > +		reftable_free(b->data);
> > +	b->data =3D NULL;
> > +
> >  	reftable_free(b);
> >  }
>=20
> It would have been nicer to do this kind of "a void pointer is taken
> and we immediately cast it to a concrete and useful type upon entry"
> clean-up as a separate step that is purely clean-up, if there were
> many instances.  It is the first such one in the series as far as I
> remember, so it is not a huge deal.
>=20
> > @@ -108,9 +119,7 @@ static int file_read_block(void *v, struct reftable=
_block *dest, uint64_t off,
> >  {
> >  	struct file_block_source *b =3D v;
> >  	assert(off + size <=3D b->size);
> > -	dest->data =3D reftable_malloc(size);
> > -	if (pread_in_full(b->fd, dest->data, size, off) !=3D size)
> > -		return -1;
> > +	dest->data =3D b->data + off;
> >  	dest->len =3D size;
> >  	return size;
> >  }
>=20
> So, we used to delay the allocation and reading of a block until
> this function gets called.  Now, by the time the control reaches
> the function, we are expected to have the data handy at b->data.
> That is ensured by reftable_block_source_from_file(), I presume?
>=20
> > @@ -127,8 +136,10 @@ int reftable_block_source_from_file(struct reftabl=
e_block_source *bs,
> >  {
> >  	struct stat st =3D { 0 };
> >  	int err =3D 0;
> > -	int fd =3D open(name, O_RDONLY);
> > +	int fd;
> >  	struct file_block_source *p =3D NULL;
> > +
> > +	fd =3D open(name, O_RDONLY);
> >  	if (fd < 0) {
> >  		if (errno =3D=3D ENOENT) {
> >  			return REFTABLE_NOT_EXIST_ERROR;
>=20
> This is a no-op clean-up that would have been better in a separate
> clean-up step.  Again, not a huge deal.

Yeah, fair enough. One problem I have with the reftable library is that
its coding style doesn't quite blend in with the rest of the Git code
base, so I want to refactor code that I'm touching to match our coding
style better. This means that there will be a lot of such smallish
refactorings, and I'm often not sure whether to evict them into their
own commit or whether to do the refactoring in the same step.

For small changes like this one here I think it's reasonable to do so in
the same commit. But larger refactorings like e.g. the introduction of
the common exit path in the first patch of this series I of course put
into their own commit.

> > @@ -144,7 +155,18 @@ int reftable_block_source_from_file(struct reftabl=
e_block_source *bs,
> > =20
> >  	p =3D reftable_calloc(sizeof(struct file_block_source));
> >  	p->size =3D st.st_size;
> > -	p->fd =3D fd;
> > +	if (use_mmap) {
> > +		p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> > +		p->fd =3D fd;
>=20
> This is a bit unusual for our use of mmap() where the norm is to
> close the file descriptor once we mapped (we only need the memory
> region itself and not the originating file descriptor to unmap it).
>=20
> Is there a reason why we need to keep p->fd?  Now the other side of
> this if/else preallocates the whole thing and slurps everything in
> core to allow the remainder of the code to mimic what happens on the
> mmaped block memory (e.g., we saw how file_read_block() assumes that
> b->data[0..b->size] are valid) and does not obviously need p->fd,
> can we just remove .fd member from the file_block_source structure?
>=20
> That way, file_close() can also lose the conditional close() call.
>=20
> For that matter, do we need any codepath in this file that is
> enabled by !use_mmap?  Can't we just use xmmap() and let its
> "instead, we allocate, read into it and return" emulation?

Not really, I'll update the code accordingly.

Thanks!

Patrick

--9UNmmjb5KXtofsfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfsx8ACgkQVbJhu7ck
PpSKvhAAmOQUT6GdcKd01JySCaVdq1At5/1K3lIZaIjfxVd1+KI6X5uLtgtu3yS9
UWfCj5Tgwl/nGTBWkeBO6juM/iaFr5JgD7z/k7c+ZsBcGYXZRCuNwWXGVZMN9ZJL
scuda2DMWe57OEWIfNCtSoLPDbhapYRmTn7n4dSUoNaXTAC+9dDeL2zS7nRwRN70
oMZaTJTX1fPCIBmpTd6VwH3NGBwE2ogDzdpCjpYBxjgHVhLprSW6vg1GyTi2EwbF
TEGeR/OVpqX9I08nxdADQX9JHN9nZLw7kNbDx08CHQT+nDv6W8/6BVckuPN5sHNy
Ab5qCmGcr3Y6y62dONIbhiiQErG/1xZEp3Q/ri8yFsHw7zRMmEBYvsxnnDILq5ab
CNpBupcvxFuLdh9IBw4X3idumeL+/WKTXEJnwzPAZGivdRUWkFQceyNzNn88wl5k
NCzz7lmK4OX8gsk3F1gL71ieolfeTXUjh6ksHJgHRGUa29TJd2Xw9Izvi7QNNRzj
+uyzL3T4aMHzmVfIyAdE3FNDs6UWhOIeLhNT6ZfjL0+LkUD1XZGywBw+jhKiZdxB
vIupdzdqtmJrHMISRxAWfIAWuJTdDPnHxAdqeYfeeCo+mTQLvJrA9TEfYVi/fymv
VlwQUhETuSkdoPNhnKh3G07Z35HdEwbJYma0e2ncnODY1sWmbIQ=
=6VLM
-----END PGP SIGNATURE-----

--9UNmmjb5KXtofsfd--
