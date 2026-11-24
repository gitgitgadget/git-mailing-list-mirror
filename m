Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795530336;
	b=bsbT7Ig6ZWCTMiN8It2DJkax0+unlYn1VNVn2xynYvhOQwvj1VpGKbiM6iv7IOpAVJ5r
	 JBS+xT76t/XODUQ+4q2O23ZNxK/o77WH2zYBrWMEVi+ner78fPKNHzR615JrHm+68FI4T
	 AzyXOnv0WEs8qO4FTgghcdyM/6M5NaMMrOx/v+9kFQFbgwYasGEPVhhIY4hLkaGdFRkK8
	 kl0uvK7NgKxl+wIZmX6fNUyV4mOQcw1Zo35hRk2L/gZ2o2laabCE7YfNrEe6f1GWu5TET
	 C59ArMtEFooJnR7AzGEIuRIqVQrmXDr2DdAoldsPtCdoXbxBga7a75nSdUi8qBJQZag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F0Lu5tJrJiKP2L1sHYdfeW3G0Kwy7+8hWvOWEs3K7vg=;
	b=Ibmyp8inYPjphT38Wwd2KewWsr+HQtIVMkS7aPTghLtaDRUA+jrwzHAo/6KUnvzDCLtz
	 TcDeuo9M/X62Ioed8lfjRJwq66xAve29JOK8ZqOrAAqUp+/I2iVFEuKPaugW7a6etRI6L
	 C38kfQRLaBXqsij73oaY8utdZg8MG3SExtRTss6k0SLohkIVfy+P7gK6+E7S1KokvQUr7
	 2gdrQprk5/4YROoE26d45vdhicUTxyGQPXLn7MbGbl7o4jCq2nQZgsDwkX+WigEKlKezn
	 Af5k0kSwarJNYEZZNSgYh7YNsswnpdZsYcssrQsE/XNh3eXguN2y4CSUdzJ559AU72A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAd18Dzy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44853606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44853606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NAd18Dzy
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so5689417a12.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:25:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795530335; cv=none;
        d=google.com; s=arc-20260327;
        b=nTqy3PWsE2cRToCK98Z2qpkAoyGJ0NzLUkjEpmlZfFeJFwhjVmDM7yURxVTHrX0NNX
         +gTdhgL6TH/95kPLjiXRvP7BXNQ3lANiidXcBPGX5B/L7x2C/osX3OmfBneb17IAX/XP
         YezY2L7OwpZeEdDfkaJY/40gqwRDafNbWzS4hGGDaXAWEFCK48MQ02FaFoRJt+roNrE1
         Bcm7lHYk9rSHvQ1jDyyz+OemdgdJ4oS/rf3avEm82eG8gBXMoAguDTegVhkXsTmz9Cau
         jSv0Y/6XUrUH67nvKGxS+TQoLesYMshcAF9k6w1YPsdsDIzsVMm4EOBws/xo1sdoLHMf
         gmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0Lu5tJrJiKP2L1sHYdfeW3G0Kwy7+8hWvOWEs3K7vg=;
        fh=SmXwHIBRqzE1Ajhh74K7ar9Yvs+AkI1L1VKwN7YbvqY=;
        b=Iv33IyTGesSbRadXGVi6vIdamCumn1Js4Hs1Erd3dBHc9hPjQpF0P5OTOqPiIowrck
         p5kjagLIOkTKk8oro5gF6heuHy+KPgtdofr5CO+lwo8LPLtK5PdfmoizmDRYL3KyJjQf
         I8ZSiUlBKEF4vIhPzWH9FXFB5u4pdYQwOWIpdGNNUcaZsN7hTyB7UgpLB/FVqGiT7oR5
         7IjjR+Wz72N0c+IQ+hyk1VpFkIbsN4Xfmpk+F022lAUWg2hSioWtQq6yxdRG9ywAK7OD
         d5MqC633YEVsm3Uc/D+n+dLUQ/u9lvTp+Kwj2kZt0G+29l3dXi172kAr1+nxSO7I6Ecs
         N3jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795530335; x=1796135135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F0Lu5tJrJiKP2L1sHYdfeW3G0Kwy7+8hWvOWEs3K7vg=;
        b=NAd18DzyR6Dgg9GFV1XM9qhRWXLxCOEJxMy/fP7z5RtxwWY2uIZqB8lmk9INW6VU8b
         eYMBVw4npcfpY8gXCVkKirsXJ3XOIq0SJeqMpnLU/CEx+7vb2UiF1NPhD2Ol4Ig5DNTA
         nKqjqmv7bx9RAYkFl7JjmJAaCsn530ZBL2g8/pFRPddz0MXlGKyrcSheufgj3Tn+soyQ
         SQHQa0cJOcYFzYGIMmytav0R+HNzWv4di9YomxRqBvcNqYLy2PIYuEjbYs3wuD0ArqtK
         h9vUyIbX/NlKnuXnfXuqI4QZS56Y6MYMhJNU82BATUg+PLivBdGedWEjACtKOebfhFHj
         qo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530335; x=1796135135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0Lu5tJrJiKP2L1sHYdfeW3G0Kwy7+8hWvOWEs3K7vg=;
        b=bX6qZbiBf9TAwccdFBIG7JbJDkOYcztPYxBkSWfOFMWnaB/oVUFq2ETLPZyzhfEHW9
         q7ADQQTJnCGU2jdRBP1gv0i5HsfcgSz8lx7ev7GjBlpJ1VJA43DTI7o3jOftmjjXsqZw
         ADo8pg/3mc7eWiy/qqO24d1/P9sDkgpm2Je0L1J3KXAj/3utgyiqVfuJe1WMGTlagdqF
         C9BJgXTJcn1SBjtgN3sUQL3YnXoba4rY3zhCrofCrpEr1Xu/TCwwCpGI7CXBobnJHvww
         SMX1fBdUrnEV/27nxNqrF+sWwqiqQ5wdZjkhtqJZlTO4cHqTQEPG6d1i1EQjX7Kghf39
         KM/Q==
X-Forwarded-Encrypted: i=1; AL+hErGFxQ2chmV9PzDTDLTbPp1NxzTUzVxmT2+I0f9YKhKbPvoPiSWPr2FLETOYDM+bvNnc/tM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HJTOC1eEZUlfcEDOaf1spcmZpwlOJOw7WR/FIVskof+9simoP
	I7HGiws5jaFKKAZC9L/edCQRWsBOxyc79yKQdvm85zymx715zARa4vYvjUFU2BjoJlWD9rK+w9m
	jQKG0Srysm8s8HKlqJ2AFb/ZK8ja9s+g=
X-Gm-Gg: AZFdTZdCLseHLt8lZVt978g7Nxv8cK28T5lSSIviyDVCkg2U91ZfFutaT9nWVZn/FXZ
	gB+p+zTiTjZLWZa7M3dvlohSsE/W2bYZi/bHtzRVZWhWERcGZty+Ns308d+fLpjDmYXFJ8UA3H5
	R5qmy1w9LbeN28tX17nkvO6C5ixaZD2JgBKYY6Zyq2cW26xPc/mMoqOek7cRgU6LMmm47Lr2Poh
	bHqZUiC7i5gBYA96rN4OrZHCmvANXnUbsxhm/Hz5lg1ADI43stDMEvlCd6Yha9pQTtgE/isju+V
	3qNI9B6Hhxzl3SURbVN5BaK+gmJzB3DvJWa1hXAtlbAPf1QDwb9iGLh0yqrnzTG7FmzykAc5CzW
	JTeAm/foTDOhLel9EVUb/YKTBOIqr9aHClgE2h5EIl8oKxDvA0Gt+fxaFUQ==
X-Received: by 2002:a05:6402:1cc9:b0:6b8:8638:4e58 with SMTP id
 4fb4d7f45d1cf-6ba37e977d4mr10876876a12.33.1795530334499; Tue, 24 Nov 2026
 06:25:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com> <xmqqse0r44y2.fsf@gitster.g>
In-Reply-To: <xmqqse0r44y2.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 24 Nov 2026 15:24:56 +0100
X-Gm-Features: Aa3M54qrCjS797JCulDFtgzZKPxvAHvLrZEp0L8XGt4okpghJ8DqiIc-bNIWBJc
Message-ID: <CAHwyqnXs99Jd5ajrskjpGyVQZmR1DOOPmXturzDxOyWuE9dfBA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>, 
	Tuomas Ahola <taahol@utu.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  * New commit: --dry-run also works with -d and -D. It is still rejecte=
d
> >    with options that do not delete branches.
>
> Much better than before, but we still have a few operations to go, I
> guess.  Users may legitimately wish to try (with assurance not to
> cause harm) renaming and creating.  It may be OK to leave these as
> gaps to be filled for now.
>
> What is important is to wean us from the "The dry-run option is
> incompatible with anything but the delete-merged option" mindset to "As
> long as we add dry-run to the command it ought to be supported by all
> the operation modes, but some do not support it yet".  So, perhaps in
> the ideal future, we may want to see
>
>     $ git branch --dry-run test v1.5.0
>     fatal: would avoid clobbering existing branch 'test' by creating
>     $ git branch --dry-run -m foo bar
>     fatal: would fail to rename a non-existent branch 'foo'
>     $ git branch --dry-run -m foo bar
>     fatal: would avoid clobbering existing branch 'bar' by renaming

I think it's a great idea, but I also think this topic is probably the
wrong place for it. What do you think?


Harald
