Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC06296BC1
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854079; cv=pass; b=jRub4uv+K6Jglfdd+FZj/rzXSJJDH5ZF5sh/IwnmXzh+4GAKyFcbdswj894sQJ+BvL0rdFoNPTdRN1t+qEdD4Z8wJJQPh9/PesBP8/DNntAfm0vJFpWhho/LtJlMiGTaLpywFLcFHAmYKL5utDeTqDAhgFG/7NcRev9wlUXPQts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854079; c=relaxed/simple;
	bh=eydhO54AKkpSQPn8oaw5cjhUQJI91jSCIFBHoYdPruY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deNOkLGaS6IE7Q3XtV/Y4yQfIEsouCa4KT+Hb4UBEj5EtodHDnrrRiuXeLQKixTJTNKclzauwBogshRyrEhsipkhv9W7hNKUxiX/HWoRN0a+83L2m4hvbqOGD13sjqApUcmcxpLUtlfWggV2OoKtB4suzaSuAh7fVuhoY7SEeRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2DPBAvN; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2DPBAvN"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-382fd6cbae1so40130231fa.3
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 12:21:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768854076; cv=none;
        d=google.com; s=arc-20240605;
        b=Shta+xaVyzl8nL8fN2Giz6ap8bYngtjfSh0gDaoN8ePNlriW/lMWO38WGaDJf+MaI1
         wwJwHPZfeNS2zcYrAlrt5azaYd9weFsVp4SkouLvXkJy/ebtGMztREMkC3MxxNl3TbHx
         ZooI4YnCiEc6AJK31icMx20g1fRXPjvSs/kCshyaJOTz3cjWAPyd6SjB2klgplvD3BH7
         +qAe7VQ1tt4+U++5+Q2ggW+MtsfyoT+x+kiZPw7JNszoyrfc5wTuYfcD/MDFcssRkwpu
         yyp9IcCTGTY0FUeO3qoQLmSngATGWuA9FiNoQkLo+XyWF9ZcBhHIb3NGQWs7u0qq7XHK
         XrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cx2dzoTiSqif+O+6GjCTi0I6LPhHDmd/BXkSkG4GmtA=;
        fh=R+i8+oqtddQfii9wD6KHtM2DaSwWXf0A1M3J1Lc5w7A=;
        b=DkRPSJcNog0WyL+OqckE32lLS2nIzSMvVWMCq67ilXGwYErlo+FdaWqHupee4mwBfP
         KGTYCQH8O0xCW1RiHUySPrL/4EkhEhkvY9tObGF6pQ21syVIiXvYsRsWG6rWU7M6H+zL
         EGKBe71YZ6PyXbnBg/g3CSX6AGg0uzUNlSnzmBDYLD9MYNNewSS4zaU8TUA3ZbSeSfxG
         +V8BMdn0giB28nZay01QJ95nuNMO6My+axkL+gVd2l7f+iANCs9fTVD4CYPngEP6op1j
         2icOKFFy0REWu0xfdYA7swNci/3xBNH6ToNZ1TOW8TIIagg4oB4VLik9lXlj0bCUWas6
         Ggxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854076; x=1769458876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx2dzoTiSqif+O+6GjCTi0I6LPhHDmd/BXkSkG4GmtA=;
        b=L2DPBAvN0J77vunuvRY1m4hiCudaBNcpvcdCBndHqH5wh038Z+mrJeETaflAk6PK85
         iJmu+tlG4pOIa2I3daZvSmpuTmWyGQrkW20ONaPf+B0hur0zlabQK7M8n25IyU/IjFDO
         5DeCgBAcrfvky9CRn79xzQFCO35Smp1TKH8oXwpIhrhfB6jEx92iiziBspo+FDOZLRoo
         L+ZTp8Z4cP/qJy0+CEuzJkCaEHcnIBZpK758e2tsRt3pXbMvPDMGNIX/D1L7egiaf5Xo
         1oIAwg1Y/IuCwJtg13j1Hd9kXQPo41BOt6JNbGA7gAbzEBfkS9sE2W5M/RyomxJj/1Qu
         Sh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854076; x=1769458876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cx2dzoTiSqif+O+6GjCTi0I6LPhHDmd/BXkSkG4GmtA=;
        b=Q6ybq9GiWlDaTqjurnQnHpvJJzvTy5sMhlEr7praLhiBjWX0G0kim1SPlf7wJMBrvD
         dsVX31NC2SuxnnFqgIWvx44/HPFgy2RTaw69A1E+1rht5qjjYnhwknZ/+Ng31Ec5Xw0t
         Zmw9BYZbY1NnsYKybahlcxsYv099i7H4UVzG13pBQNfjW9haou+xyQo5W8m9hIQrAGOr
         8sQZaS9DMBJG7BNGjNez9z84oz3qTsUBxpyAbFvKujaDi+EhpwY18osq5mZNyVYvRMJ3
         ri6aUSwz9umQ+GEkg2Fu5rBOyw1dX/BLRGI3Zjp6AeVSQCynUIUOqU5XQ9GjrlZmM4fn
         LSsw==
X-Forwarded-Encrypted: i=1; AJvYcCXjo/DIo1oYZNdLbRRmUj/np0i7yTh3DmH+f4DBXKE1W16z5Fz5CgvydG1tYjtgFlC+WjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfFZGpcQjQUQ6OfX4jXw2jcQexG/fav8rBSU8PuEyU6vl4mnA
	NetUp8cWfUH5s3mRCCIrLkF1Qy0nyecEekDEzHFZdQZkw9xE1yjrj99T78wlqwBT1euWRicazb1
	CePVNNNebRWVZabhd2Bwy5V4rS06Hh/s=
X-Gm-Gg: AY/fxX7cRK/y6hgE7VZ6EkU8qsY4yyR8zhBr+q8/D9+hIKFyOCJGA+DwfGjTCNfDQKw
	pkjSfho4hWue79YF2enbvUhIdlwUgiIHLKQgOEXVbAQFnc2IqfdLbT0pX/ncrkR8rh+73RW6IcL
	9hngPgOdSJfvDVInfchCy5szSPYAcHLScvvZIHt/DQyuws09tGy1VmPBlSZH2wBGGakBEIEImbE
	zKIPD6d3iavQBso0/k42t7K1IgTxiM2Jg9nGU+7DOuW4XIybZ7BvBFmwiuv3ImHpUJVF7s=
X-Received: by 2002:a2e:be0c:0:b0:37b:af2d:13a3 with SMTP id
 38308e7fff4ca-3838414886dmr46302451fa.7.1768854076130; Mon, 19 Jan 2026
 12:21:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com> <20260119055947.GA3100271@coredump.intra.peff.net>
In-Reply-To: <20260119055947.GA3100271@coredump.intra.peff.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 19 Jan 2026 13:21:04 -0700
X-Gm-Features: AZwV_Qjt9MIL-DKeHy5-T9x967TlpA6nQ42QrAt9T4cDjQdVQ2AOa19NhRa3Yws
Message-ID: <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 10:59=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jan 17, 2026 at 05:40:08PM +0000, Phillip Wood wrote:
>
> > On 17/01/2026 16:14, Ezekiel Newren wrote:
> > >
> > > If the size of different kinds of pointers ever differed from the siz=
e
> > > of void* then wouldn't that make all calls to malloc undefined?
> >
> > I believe there are (Havard architecture?) platforms where function poi=
nters
> > are a different width to data pointers, and that's why you cannot store=
 a
> > function pointer in void*. I agree it would be weird for char* to have =
a
> > different width to int*, I suspect the restrictions on casting from one=
 type
> > to another are about alignment.
>
> The standard does allow for different pointer sizes for char and int.
> The key thing is that a void pointer has to be able to represent any. So
> you can cast a smaller pointer to void and vice versa (and the latter
> would presumably throw away some of the bits, which is OK as long as the
> void was made from one of those smaller pointers originally).
>
> More discussion at:
>
>   https://c-faq.com/null/machexamp.html
>
> I don't know how malloc worked on those platforms, though. The caller
> knows that malloc returns a void pointer, so it could cast to the
> smaller format in the usual way at the call-site. But I don't know how
> you would tell malloc() in a standard way what type of pointer you
> wanted to get out of it. I suspect they may have had specialized
> allocation functions. Or maybe it was enough to just throw away the low
> bits if you only cared about a word-addressable pointer.
>
> At any rate, yeah, I agree with your original concern that the two
> structs are not compatible. The layouts could be totally different. And
> not just due to pointer size, but IIRC pointers to different types could
> have different alignment requirements. So:
>
>   struct foo_void {
>         size_t len;
>         void *ptr;
>   };
>
>   struct foo_u8 {
>         size_t len;
>         uint8_t *ptr;
>   };
>
> might need different padding to properly align the pointers. In the case
> under discussion the pointers are always at the start, though, so I
> think it wouldn't matter.
>
> -Peff

Ok..., is there a way to pad a field to the largest size needed so
that this also works on the harvard architecture? If C isn't even self
consistent then how are these structs going to be passed between C and
Rust (which is THE point of ivec)?

Or do we just tell the arcane Harvard architecture "too bad" Git won't
run on it anymore?
