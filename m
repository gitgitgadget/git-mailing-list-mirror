Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D119331A62
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031975; cv=pass; b=nq0s+xFOTFyY4Ny3I/GMo3q7xGg10szY9+bXG605p0SPkADr33Fvrj32Aa1IGsNc6z5MNmrxEnvnicPufZknBkWcZtV2uYRjUgDccNwkEJFYPIDqWARrIN6w4tKe7AbxsszDUbzq3uN+rq0wJoBoBSP9uEmw5KRA3s45AH5JnTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031975; c=relaxed/simple;
	bh=jZLl1R1mQc7AnEUNAGCKxDE7sL1qqjSzJldUjQgbauY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3/KDwsHOddzn9uf0P3e1oKZP1vBpcDMwH21U4Gz8ZrI59TK1mvhaWAEzgBMuIEmi29ywduLoxWdve0r/PLMvqMeQk8YrTsriMn15in8IpC+5sQAPSrz2JnSjYNbQwpYnBJGADZWjgN8a2cUr30e4Lozn6vGMu5y9LbuP9+vpx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWOlj/rZ; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWOlj/rZ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso2901301fa.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769031971; cv=none;
        d=google.com; s=arc-20240605;
        b=B8JSTTy/QpAdRfrCKCtRvtAkww3IV3Hmf1H7SHb49zRwyGQ9hXgBa7m50IeINt6vHi
         8Npbl7aiuRPkAKnEUVzRLxId/8+KJ9b7m1rBYwyszWJ+n9CAnqkH2rn8B7cdt75PXKO5
         H/dbwp57sEpyiziSAMTYqrI7BAVVhwsfd3jQwOIvT0bEwFO060SvBVWLSYns2Ym2SXkm
         zShH7G761qqldn84eRPR28PZ7qJSlFv9Xcwj3KbicCczf/JCYAHp09L4QbSZsGFyWlAi
         oNMkjwAeI9GQWgxMlmsFwywRHWSoswdAqxW9clfo/YUq9yhiRIKbBqVB1Uu9OLQuqHRA
         fMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0SnCV1CktXi9BIFoabxClQlvFpxOE6wLKurblFXsDtE=;
        fh=f4B2Dtw+nUS0pfRn6+5hR7Wzalt5ONtR1DBMBp9NViI=;
        b=IEAYnw0gdXxOf6QM7VRR+0ZpxhmzLVbImpxnZ8Vls99L7I6TidynoqD5oQcfteNSQ3
         jTKMpVtEnsPvs2F9XNJS7lUAhwAtlcURUzYlxofgZYRfX3XKaUYzB413FxVyCi9F9qF9
         kKXRNMiJviSzD0pbViBwox6xo/deWrt5rq99RHT4+YgswZeTFrBQvdzzQpOpsShdcUn1
         0dgpDADNyoiL5Lpw8Lgsyuzg4ANuyyIAjEeJg4hd3KwDbFHaPowSBHqMjHAIRrfcy4HD
         WL5aa+EYRyDk7MqDvQHuMK/Ut8npa8noljAXll5+/nkKstGyz/6OU+cNjRbQnm3xo1qw
         Qnow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031971; x=1769636771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SnCV1CktXi9BIFoabxClQlvFpxOE6wLKurblFXsDtE=;
        b=GWOlj/rZdRWRfrOG40DLYGzTkFzesvB8pLaPFhfh/bjYNNs9KFIXgWXCwlffBXMzkL
         K9q8AKppvdGfJ27owOC9tdiyQb4i8plEtmeWeER3aCyFmGaFBi/8lSpvHY+SaXdLVG9H
         g77mTBqKtd3lcjTYEuTT1HxFqMdM8yZJbg636NZpjUTjvrp1Pb6uhBbf82OcLgpHiE/a
         LiuPcourOyjbbP47iXdM6B/gGVPdfXqdJXqDj4AjnhA9Tt5WcEj7M6dKFAFRkheYOcRK
         irgRPSwu7c57sn5zNG6J13m7wWIepkA0/DCi0kCS28DhkWdRUina2HnfMM6HfwDel4WE
         wpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031971; x=1769636771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0SnCV1CktXi9BIFoabxClQlvFpxOE6wLKurblFXsDtE=;
        b=V1A4vpkDilZ38MPkc0zA/l+xdF+8sMDCP+rWpf5puhtDtPnnTLxsNDUkXlv/NIkmdQ
         gJzL73WUFttYBz21HqFkFkWbNZW7LpkPnKYZToI13/y7hzVq8Wfta9pCH9FHYgR7cTP4
         AUfjA1UXYBZkHJjZ6v/0NIrK4ZXPDWGgWZ0VtEuHDvGBNzy7iXv3QrtWU3FHvjoLbVxH
         d7TZ1Itbe2b8USbsnvmcQRYC4xO6YlDxny1SS/huSR0aNqYWT3OpZwbhjkOrfhspe+Fl
         2r/tDqbT7aBE7bXaq9jJyzfWw1qHVRt44xf0BCH0vVqO4kmH895wEgcUjQ2Zz31xunwc
         D51Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdBn6zATJj6Mbhk18YCSmsVFmDKP8eKFohFGYj5uGNV7TDV3Tq1QE6lt4lxUxj0lixGJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTeCxPkLCHsqc/zR5JGmbSsmtEtEg69iW6r6UOU8uZp2a+wNZe
	Gtxo8GKAY/auD7bnqaHR2snfC61EFLOYTjlo0o4Gj6eqOJe6C+dZBTD66DgSctBM+pb0xxFXgpr
	at6VN5hmgyIw3VfSg387wkN6Il94tLqY6vHYI
X-Gm-Gg: AZuq6aJBlup9xKhefp8MXMtycTmlG2BoqXvo1jzD9X73KHzwAfE823FcyjipHb7IO+X
	2N2+aLSI0Ppa7ojchiMGK27RjFxUvAe+Tizxsvc+RksgUwK2s69HrY5tAUixASK35VTKIsYwm9T
	gvvt2Wnb2bM6LrPBEZU+sL0V6BBlXnUKYdGxx2zV1hXFQJsmYIrPNeuXj+7VVIem/GY+toKG70G
	d+3Uhf/Lbm/eF856gpl00G/UFo1IPiSe1hMhfgoktZRZKTHzaC3Y2HwdN0v9Uv838GqWYk=
X-Received: by 2002:a05:651c:4cb:b0:383:723:3c50 with SMTP id
 38308e7fff4ca-383866d040dmr57251731fa.14.1769031971205; Wed, 21 Jan 2026
 13:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com> <20260119055947.GA3100271@coredump.intra.peff.net>
 <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>
 <20260119204010.GA3148606@coredump.intra.peff.net> <CAH=ZcbCNeYATxqAeXcGd9kkHzJq2y5BpMrChSzb215EHAjHsbg@mail.gmail.com>
 <20260121212024.GC723458@coredump.intra.peff.net> <xmqqv7gur6t4.fsf@gitster.g>
In-Reply-To: <xmqqv7gur6t4.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 21 Jan 2026 14:45:58 -0700
X-Gm-Features: AZwV_QgaiRNV9FJOn-xDBScQ8bhYGatZhullKg1D9BpXeNVn_Ok8qi15U5vq5w0
Message-ID: <CAH=ZcbDYjW5=8jNOA1=Cw8eaAuKBMshAn2nAFgUCGHmBC=zGEA@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Wed, Jan 21, 2026 at 02:00:15PM -0700, Ezekiel Newren wrote:
> >
> >> What about adding clar unit tests to make sure that different ivec
> >> types have the same size and layout? e.g. sizeof(IVec_c_void) =3D=3D
> >> sizeof(IVec_u8);
> >> sizeof(IVec_c_void) =3D=3D sizeof(IVec_u16);
> >> sizeof(IVec_c_void) =3D=3D sizeof(IVec_u32);
> >> sizeof(IVec_c_void) =3D=3D sizeof(IVec_u64);
> >> ...
> >>
> >> As well as other tests for ivec.
> >
> > I'm a little hesitant in general to have run-time tests for properties
> > around undefined behavior, just because the compiler is allowed to do a
> > lot of tricky things when we get into that territory. Plus it is not
> > really _solving_ the problem, but perhaps just alerting us slightly
> > sooner than the production code itself crashing and burning.
>
> Yup, by definition, testing undefined behaviour with code is more or
> less pointless.  Implementation defined behaviour, maybe, but not
> undefined ones, please.
>
> I thought you already gave them that having different possibilities
> in a union would work correctly, but perhaps I was reading a
> different thread?  I dunno...
>

In my opinion the proper solution to this is to document that any
platform with different size pointers for different types is not
supported by Git. Which would make using Git on those platforms "use
at your own risk".
