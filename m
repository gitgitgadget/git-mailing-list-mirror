Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2E25A323
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117396; cv=none; b=cNpaKtJvit7hAeiRoVOK/30V5xC7i84ZncDyY+uHxXR3fzKjyrDuwcV1tcld20iOKegXQCozXPDIE/2cdyqyG5A6bv0uAWn8+Me10nbt5oM4ZvawoQrTEkB+QWynhO+jQxJw8Tvf66dWkZsK5Is+j9zTadOsPu4deR8bSnM8mmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117396; c=relaxed/simple;
	bh=9GgQXiP317PKCeTJSOniSDk8A48Fearb0GEY4DhDT7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP0TXGCKVQSQjgpLyknYkaBPg/fTmeJKRfO1nBaHdCYaB59u3B5rhIY3loFkAflUoN5aP6NsiTL28Mxi1KAADG4pE8cAJy51+nOykTDtQm+hj6sP5mdiSqTkn8fymL1Nbg41FDUvs0K9NK2W6v+CRf/gJaPAl+6JXysjH6kUPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLxnwar/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLxnwar/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so85221815ad.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761117394; x=1761722194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9GgQXiP317PKCeTJSOniSDk8A48Fearb0GEY4DhDT7c=;
        b=CLxnwar/rnwNH8ZXbPx8dp/xF9lpPNBjoztpet8zOSoyahw2nRyF1y9RW1OXnGY7X1
         eMDvbQ8ZYrBmHmeu5YmUMJ2nbi9dRiTCbLT+1DCn0RS9PYftEcK0xWvPP729NfSl+gfa
         R4gOBp5L/5gSY48xFfgtEKBvkDVKb/xG8TvImiZVPKOFMv3FvtUTb8KOxdSBWEnkVNHR
         sLHcipC2JWssFIjqwiEPpVaQ/UauQYH5u910kSTpE15687bsIy0gD8OL9Y15ziFlFt8c
         ODgQ53aAsD6e7UYHe1OFm8kWDSPKv/bs0uQ7YQ/ZW7F2ng0o9wmqkKB23eRWyap66V2E
         H6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117394; x=1761722194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GgQXiP317PKCeTJSOniSDk8A48Fearb0GEY4DhDT7c=;
        b=dcyL/YDAlsD89OeB4EbrbB0AlpQEpb2Szi8iGt5oUyAbFdLJYPoQ0KPC98Xd4MGrAu
         VjZsd2W3neY8fSngYseTla/U33h0efuEunMzgChOehpQUooo0zXVgoYXV4KnfGGYSwLW
         TK4ugw2l94IiRcbYxlNzmJWT8jwFDTvtVRtBG+JIoHnHb46dWc+pTlQsU6Mbz7uzaYr/
         1O19MshYMWPzZmEBBsX+Ftf48lmLlRhdv+AoujoU+aI6sY/D4bbfzFp3defGjwr7O74k
         uYZW0iVFe9NaF01IbmUAfwitNa/39V3asTzXs95OjlWtYQ8qiWW8TeV6R748qfoqu2gs
         IGRw==
X-Forwarded-Encrypted: i=1; AJvYcCWSTFOppFLCWUaWqXTAJbLYaznni/Om6Nyc40bHEjoHUIljtmGrGUyIEJQqoyWhqr0my3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhipL4UNNPVZMAOCOteB78d/f4jCtK85QnekUNxIEm4n4ng66X
	VLYqMx/YCZqDLUb7UISAAqB2ilY8xMMnjlqZUdpTvRER2JEVzdVCnaDOI3qalCHIrm7R6r44IoC
	rcDkzzgtc4ZQhFLBDZ+C2e1ptAHfe4iA=
X-Gm-Gg: ASbGncv2fsDJEC0iPfElodHaNqiCZwdAeHU++LGox9Zo2IZUk98KdQ5PC+3p1gPfCw8
	tPQoSC85jy3pk0FfDkspyQgpAzxyhVA9B1saT9k51I6LeXF0TIeE09tGbLb2KSMhewPk3/M8Oej
	O9rOI1NvkPTEieBFrGK4zOfjInsYf/uIoX/eL2NCK6tblfmBvcOJOG2u1XvVyhSfDsC3wmUGmdf
	wi7QaP0nYM32FsToIouhPolcT/Jljur4YkRSuIR2hXpfuAKczyclC4YFqp2zGGl
X-Google-Smtp-Source: AGHT+IGkMuD4D62jcvbCoILeiD7i4hpupUsJAr1ExO6jH09nBdmR5R83brKNthqm+fu4t2nfiYJHzPUqIs98VpX5BGg=
X-Received: by 2002:a17:903:1a0e:b0:270:ea84:324a with SMTP id
 d9443c01a7336-290ca121a70mr252398825ad.38.1761117393610; Wed, 22 Oct 2025
 00:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <CAP8UFD3sxU=r-zVmM7xL84qEsDL6cFUceAV4np6uLxFTVOnWXQ@mail.gmail.com>
 <CAD=f0L-9e0uYv-T6HYkCFAWPa57y44PXV0Xi8S5MfHQVgnYUAw@mail.gmail.com> <xmqqikg8w53j.fsf@gitster.g>
In-Reply-To: <xmqqikg8w53j.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 22 Oct 2025 08:16:20 +0100
X-Gm-Features: AS18NWDWVWznO3_sNMRJLPlL2nxcA41AE5m_BOKSH5C-eZPfokM4jV0zZWq1gVI
Message-ID: <CAD=f0L-VOgbY+W4pNrj+JaDNm4XPQ_LnHSA0SKyaTvv2t6GP7Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 0/2] do not use strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	usmanakinyemi202@gmail.com, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 18:13, Junio C Hamano <gitster@pobox.com> wrote:
>
> Bello Olamide <belkid98@gmail.com> writes:
>
> >> > Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for example,
> >> > in the series, notes that abbrev_oid_in_line() takes one line of rebase
> >> > todo list and splits tokens out of this line using strbuf_split_max().
> >> > However, no simultanous edits that take advantage of the strbuf API take
> >> > place but the tokens are merely used as pieces of strings.
> >>
> >> I am not sure taking this commit as an example is really useful now
> >> that the string_list_split*() functions are not used in your series
> >> anymore. Maybe you can find a more relevant example commit in Junio's
> >> series?
> >>
> >> [...]
> >
> > Okay. Thank you. I will take a closer look at the series and look for
> > a more suitable
> > reference.
>
> Thanks Christian for lending us very sharp eyes.
>
> What we do in these patches now is closer in spirit to d6fd08bd
> (sub-process: do not use strbuf_split*(), 2025-07-31), I think, in
> that we do not split things into an array of strbuf, and instead
> parse things out in place as much as possible.

Thank you very much Junio for pointing me to a suitable reference.
Makes my work easier :)

Bello
