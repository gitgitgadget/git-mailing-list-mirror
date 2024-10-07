Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12613522A
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728268941; cv=none; b=eBnYFk3E5b/tDXnKX8T7x93hEozMdPytsW5PX4EbYnEklygSJuXzalXNQFne+4kuZXBoUEQ//hSXNSKdBZs4lk9IDlrqRWOwYtf+2qQ8w9jtDKfEwIZ9Apu8vAbsaTEC922wI6oQnzY+aXc5O/0AguMZklU2WLmK24I+7oygSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728268941; c=relaxed/simple;
	bh=E0FSOaAubbqNNtbeqCaXiCZfBll/IzRlXK95UD07r/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZ0bxs8vsfH0J++EfcvFbrUK0qFeV97Nhz/qHkmk/2FH6rWWvJKUGAMGO3g0y4Nm17vsfFRlAlGRRo0gIYhUF6JjJHSbsqqI2aCFV2zGTrW63UHk3s5btjSiDbKBpeLqhwUXCB2wpX/Rle4ZEf7ZaQjj7L5Pi7sEkSLkhAyQJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NvxfuJkG; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NvxfuJkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728268937; x=1728528137;
	bh=E0FSOaAubbqNNtbeqCaXiCZfBll/IzRlXK95UD07r/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NvxfuJkGw8+1uzfpGH0ckaGWNRaiDGjHDgwNdhCK2diCA3orjT+Hq8sIoJcH8R+G9
	 P29bC/c/4DrIb0COE0/3andOOebOSN5hjs3SqpUl+uPwhvm1zGCz1aJBHu3SnwzyIi
	 vCC8eKUVyA+UX4c42onqhSbo78CnhPgMg5Bpc9VRua6j5QvT+ndsspXUFTARWrWqR/
	 V1K9j1DECpVM7mGi1oV2qXfYFCwOcVwtxse/IaRK1d8hUdxIKdwrCRh89cheS0gIFR
	 QpMWnjLQhnZ32/cspFwC1fKoBaTH18cB7XaGLcgePyycoU1vlSdPIbA4KLEWT/nLz/
	 fdb/X1b0f2/Iw==
Date: Mon, 07 Oct 2024 02:42:11 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <LyrqJt-X7sHVSKc-97V4-hTsDiIuz8ucEUMDtLCPWAN15k31EBjZnbeuJ2PldcCVvZaPyudvgb3H00T6uZQsI-XON7Ku8jNFjkfRCgrdr8U=@pm.me>
In-Reply-To: <CAPig+cSe0ykN=Mmb8Nwp112ROOCuhzzP0jofvL91PsVi8W4dHg@mail.gmail.com>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <CAPig+cSe0ykN=Mmb8Nwp112ROOCuhzzP0jofvL91PsVi8W4dHg@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 1b25ab2c25db35714e4e8f8424aa873fa0a2e1fe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------d8808f14ccf9045aa480a06f5f5c7ccb4f578cc24637157343d49d9d9df88692"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d8808f14ccf9045aa480a06f5f5c7ccb4f578cc24637157343d49d9d9df88692
Content-Type: multipart/mixed;boundary=---------------------b51895d4be0fafe112cebc4dc3ad24c8

-----------------------b51895d4be0fafe112cebc4dc3ad24c8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 13:16, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> ... it's subjective, but I find that placing the strbuf as the first
> argument makes the purpose of the function less clear. The direct
> purpose of all (or the majority of) functions in strbuf.h is to
> operate on strbufs, thus it makes sense for the strbuf to be the first
> argument (just like `this` is the invisible first argument of instance
> methods in C++ which operate on an instance of the class). However,
> infer_backlink()'s purpose isn't to operate on a strbuf; the fact that
> the original signature neither accepted nor returned a strbuf bears
> that out. The really important input to this function is `gitfile`,
> thus it makes sense for this argument to come first. The strbuf which
> this patch makes it use is a mere implementation detail (a
> micro-optimization) which doesn't otherwise change the function's
> original purpose, thus it belongs in a less prominent position in the
> argument list.

I can reverse the arguments.

> ... this code now becomes more than a little confusing to read. It
> says "if infer_backlink then signal error", which sounds rather
> backward and leaves the reader scratching his or her head. ("Why
> signal error if the function succeeded?"). Hence, infer_backlink()
> should probably return 1 on success and 0 on failure, which will make
> this code read more idiomatically:
> =


> if (!infer_backlink(realdotgit.buf, &backlink)) {
> ...signal error...

This was my first thought, however, on unix it is fairly standard
to return 0 if successful and a non-zero int if there's an error.
I don't mind updating, but I want to follow what makes the most
sense and would be most expected.
-----------------------b51895d4be0fafe112cebc4dc3ad24c8--

--------d8808f14ccf9045aa480a06f5f5c7ccb4f578cc24637157343d49d9d9df88692
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA0p1CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADBNwf/fxjdvMC3A3smmz5H6md8FMMTMF2KrctL3ysto0WT4fUn3BNt
t0xQq9+5J+CG7mkDlTSHfiqTu2gHuRkXkLsaDFJCtp0aYTB0wKUQqChefrfR
POw8Ev1U43jiaB9Wsvb73WvBa79avywq//HYn3a08h+AdCl+UFxttNvq9/wg
2yRiL05EsHCPbgkNrFhR0hiRFYRBo9sfvQdtJvCe6slrJZDzg92+jE/W1Oiw
1bB647/mFsc58m16FVwxCCGp3Rrmpm9PCKwcuXWYSNVsilGkUyoAYe365x12
WTWC2WDktRSQqo2Ol+gxbKZBza32QY/tKBbFq1hxEgpqKaasK5W6Kg==
=NMXf
-----END PGP SIGNATURE-----


--------d8808f14ccf9045aa480a06f5f5c7ccb4f578cc24637157343d49d9d9df88692--

