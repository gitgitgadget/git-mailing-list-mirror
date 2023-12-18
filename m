Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22161111B9
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QX2OkDDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2vD0yjz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 0EA345C0078;
	Mon, 18 Dec 2023 03:41:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 03:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702888908; x=1702975308; bh=B3kke9JY7p
	t9Ac5zAHxTILKCMTXZp0UWlWa51x+icII=; b=QX2OkDDeNGCKhzNYsYMbCTMh7i
	yTKjKH+atVEo1pS5Zm9Gx6/7qwKYWi1OpwuWVlnvj4GA88ST5rd4jGvd7Yu7Nsvs
	pfZzHb+ut4o/b6Nych0fkiLvsxPWUgVft23kHgvu6AkP+AMtq+ElRf2CxrMLiSRd
	p1x21Re5a4IVkP2ojIjWEJ2R3kcQ5EtlEWnJhxG67kYZlOQiaJszOI9ZIzasPG/g
	ctd8Wmuv8fwAlF55rgHnsT1d1PRRuIxJwN1RdpE4yh/hhGBT++zPeBQTNSZHMdOF
	vavYUZO7HrnAV1KEmsUPqlxwxX+9Mm8sbWVEFh4KgFb/zuoV0obMEsympx2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702888908; x=1702975308; bh=B3kke9JY7pt9Ac5zAHxTILKCMTXZ
	p0UWlWa51x+icII=; b=K2vD0yjzQoOhikpiSPji9e/h5kFfDvyZLQAsFJz31Faz
	e269UUuzh42nQyufnfEZ1zXoi5CkHdCxByuHWhgkE6fCoLTFkWN1+k7LGqYbdV7P
	vnDC0M7Kzr8rPh+Npa5rY1snjWN5A+GeDIUfjwUaLGtGGCZtBCImXVUWTfP2Ry/A
	b9UCDCCJo1KW1QNS/+AnDwduNksQVp+fre9J0lQrCTexDIZ0HL3OvWcDPNhWWND+
	EYUmaUSY5E2y7tIQv2wAD2K6LYOkoCSvjJ9q77q+OvjqgF4+uvi2U/Dog8UxvAJk
	B6K4t0Q8erxKLmDkTiqWwm5tvyoL72ThyrcwczWeTg==
X-ME-Sender: <xms:ywWAZYaIxg37lwkANnp9z30ZiMGHK2Ut8LKhfH-ANBtb8ktAdDsQsg>
    <xme:ywWAZTahrpNZgUI_dtE_ltWpkD6M57cbrwqx4LiNqaV4kqqBob_CCwGuy77bo7vVe
    YxeBD5avhRbUS2iKw>
X-ME-Received: <xmr:ywWAZS-AWS8wontefzCccU_A7w0yfY5ZxFfxVn_1CE1EHVtan-VKD_bevWtYpajXZ0VyD_rTMF5CUPi1kpeOanZQBkVLRiunM2Oo0GloLqez4Bk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ywWAZSo6fcRDMxHX1t6UxEmpxHx0ykb4WUXwUovxwBO1KyQAq_FZyA>
    <xmx:ywWAZTpEj3Kjcjl1IBA3xouWX5VY010tetyuzUzzTCKJPeOjzXs5qg>
    <xmx:ywWAZQTFqjCxhuC5s6zZz-XoFGXtuvXf5VAzox_ScWLfLl-1XXTAFw>
    <xmx:zAWAZa3eBF84RdtDVuZjUTpkdETLFumF_5VLnfmjTTF_hKYH-hSYgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:41:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce4912e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:39:54 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:41:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH 0/5] make room for "special ref"
Message-ID: <ZYAFx9gfppkS2Oey@tanuki>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <xmqq5y0zkvqx.fsf@gitster.g>
 <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
 <xmqq7clfj7r4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B05OqX5ZiDVPJLhX"
Content-Disposition: inline
In-Reply-To: <xmqq7clfj7r4.fsf@gitster.g>


--B05OqX5ZiDVPJLhX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 04:44:47PM -0800, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>=20
> > Yes, I was going to suggest exactly this, after Patrick pointed out
> > that there were only two 'special psuedo-refs' (I had a vague feeling
> > there were some more than that) FETCH_HEAD and MERGE_HEAD.

I don't think there are more special refs than those two. Andy pointed
out CHERRY_PICK_HEAD and REVERT_HEAD, but both of them actually get
accessed via the ref backend exclusively and thus cannot be special in
any way. Also, the test suite of Git passes with only those two refs
marked as special refs with the reftable backend, which is another good
indicator that I didn't miss anything here because we definitely can't
store special information in the reftable backend.

It's of course still possible that our test suite has a blind spot and
that I missed any special refs. If so, I would love to hear about them.

> Glad to see that I am not alone.  We should be able to treat
> MERGE_HEAD similarly.  It is used to communicate the list of "other
> parents" from "git merge" that stops in the middle (either for merge
> conflict, or in response to the "--no-commit" command line option)
> to "git commit" that concludes such an unfinished merge.  Many
> commands merely use the presence of MERGE_HEAD as a sign that a
> merge is in progress (e.g. "git status"), which would not break if
> we just started to record the first parent in a pseudoref MERGE_HEAD
> and wrote the other octopus parents elsewhere, but some commands do
> need all these parents from MERGE_HEAD (e.g. "git blame" that
> synthesizes a fake starting commit out of the working tree state).

I would certainly love to drop the "specialness" of both FETCH_HEAD and
MERGE_HEAD, but I am a bit pessimistic about whether we really can. The
format of those refs has been around for quite a long time already, and
I do expect that there is tooling out there that parses those files.

I would claim that it's especially likely that FETCH_HEAD is getting
parsed by external tools. Historically, there has not been a way to
really figure out which refs have been updated in git-fetch(1). So any
scripts that perform a fetch and want to learn about what was updated
would very likely resort to parsing FETCH_HEAD. This has changed a bit
with the introduction of the machine-parsable interface of git-fetch(1),
but it has only been introduced rather recently with Git v2.42.

> If we cannot get rid of all "special refs" anyway, however, I think
> there is little that we can gain from doing such "make FETCH_HEAD
> and MERGE_HEAD into a single-object pseudoref, and write other info
> in separate files" exercise.  We can treat the current FETCH_HEAD
> and MERGE_HEAD as "file that is not and is more than a ref", which
> is what the current code is doing anyway, which means we would
> declare that they have to stay to be files under $GIT_DIR/ and will
> be accessed via the filesystem access.

I'd like for it to be otherwise, but I think this is the only sensible
thing to do. I think it was a mistake to introduce those special refs
like this and treat them almost like a real ref, but that's always easy
to say in hindsight.

> At that point, calling them "special ref" might even be more
> misleading than its worth and we may be better off to admit that they
> are not even refs but a datafile some commands can use to obtain input
> from, but the phrase we use to refer to them, be it "special ref" or
> some random datafile, does not make a fundamental change on anything.

Well, the problem is that these do indeed behave like a ref for most of
the part: you can ask for them via git-rev-parse(1) and we'll resolve
them just fine, even though we only ever return the first object ID. So
even though I'm not a huge fan of calling them "special ref", I think we
should at least highlight the reflike-nature in whatever we want to call
them.

Patrick

--B05OqX5ZiDVPJLhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWABcYACgkQVbJhu7ck
PpQxdBAAi9Z5oSAgIKSUiH0PWO0pp8s6tt2wVyjOrlkNBflyQpu247YD7Ynqce+8
R0Jc+O59kpBUDcq5Egr3O1ihjve+unqt4EBtf3vSXbFr4jjI5Ulm4mDw0jhigLXk
Jw75L617fUd16TsQm4ewx73Wmm5L8QkNcpmQBdd2TRe1E0GMdcMJOpiSlT4iXIwx
W/es22vOqi2mJZ/O1KDWIMfMaonbtvaYu9L6N3KWJAFHmXIx8ELLZnj89uPe6kk/
5n6PUeIzSVJrz5E/vpMkuhirxVnPoKnH19S6NzOOPKA4HmlQTrVtOFOBQ/GTUAWu
bQhiWAmaymRhjZcJKju1x09ZJDdYW6lzIB7vAWO3fYjzxWY4nmRnyRM9ubRLoqku
hB8yx0Yqu/d1YqLzZ18VEBU5uwEkMjckei0URk1S2c+sq6Ahl2xbGb1r+1x+JaWw
k04RYzkNxgqlQ54w6k3zWe5KPV9K2ZV27Uk9wXFlVhjmfhVISmOY0M+DI2plJF4l
faioa3sQxLty9mg/3FhRa4bWr2sRb8ZmZ5InhD3oRHudOSMCjoBqycwHPR/fwOTC
KJfmbsXSjhN83Dg+OVM6XcEzXJJvaMx7ykO8Gj2+IPgKmVcYHnxdM7ZmW6Zqjk7N
DYtmUpOYROSy1l0Asewp7+WpiAxDtFoTwV3co7xMUTQtRosduOE=
=ACGK
-----END PGP SIGNATURE-----

--B05OqX5ZiDVPJLhX--
