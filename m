Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4215D1
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112738; cv=none; b=LRERmx3oPeSoIgasGAsOs5zyY9mg0VpI8NREvD/4DeZaAdteHZeQnSLGxo3KgOMiVvWtgZm/NloY2+daXS77TF1W6l1GAnyS++uM4MVhZ4ke3bv7oj6Ld1xWIeBg8GZ7R3llUOO9HsMnrktP5GA0ijXpxT9xzfGnuI7bNhFmFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112738; c=relaxed/simple;
	bh=MsqSW8m4dmwfDrWA3F85MhEKb8tS4LGD4D4MbUFOm1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSIUKzMV3xNu/CF/CVa6MyWQE2bOO0XYypwaQHTT2fI+1CptUVSEWS2HCnJJwlvYzLUCtCZ0IX17qB9EYtj3G+87jnJSw2FlJqemI3KjOgLCmBEEis1dqoW632tP2JzRXPCvWdgDv/HwvWHNo+4i/CIjwX1OGbgMrvuFI/rlSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c362879f70so5847196d6.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 10:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727112735; x=1727717535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuXU5tEfppF9jNcGEpO9Ol3Py1uHgLwGDNZ8BT0X4/o=;
        b=brvXy0egjMa65FAbbU8stYwTOe0+uqvGb03xw4sLns7UUhlMMXhK2KTyLf0nG40olL
         8iqbOSLNi3VzZsP022GmKfEk4k2SjrQfFQsdFJxn/HKng8LhC8W44UPXLf8suqPkTkd4
         KyURTXpJ/WtutNjgVjbY4GQrvLXiEObSvCWRPGdwAMYzCTlQRdt9Cg/K8/Q0C14nrVg8
         OZAp/wJhKfddY6AbU4NfCBv0gngqJa/40Rouz7E7GIQh3qxpUzx9HR1+8SNdm87/GFuB
         9DYUlyarcGRmagMMg1HVbcnBWpER4VAaihuXWi0OE4wqWlioc7h7ERBPlMSXgAMQ7yMq
         P/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9C1i14cqiOp4nudxj2E8TRMzoKuFh1GSlGREqxgrpHApbN4CncTSdvr4yrwL0k6/PmkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+j90iZLz/dAljtZIHBxz+jm7VtyqH5BVM6fwcwf8Wbu0jyVz
	yGO5HcNe67gLVrQMhxtoFebrif01CY7HxtP2d+tJiXgajpwHEfFgL3H3bdcZLcwT5oyYSKiWngw
	ZfdMWWxi8vpqB3CdIurHF6sXGgWI=
X-Google-Smtp-Source: AGHT+IEHOXXa9gGX7rv2FtSQh4eyWVqGvzqYmG9Ljm/c5+PpPjTWCPbcbKwLd95iFGgaK47jN+4vXyu1BfejZvY/bh0=
X-Received: by 2002:a05:6214:1bc6:b0:6c3:6d44:e839 with SMTP id
 6a1803df08f44-6c7bc751c28mr91088216d6.9.1727112735525; Mon, 23 Sep 2024
 10:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920082815.8192-1-algonell@gmail.com> <xmqqbk0if5jv.fsf@gitster.g>
In-Reply-To: <xmqqbk0if5jv.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Sep 2024 13:32:03 -0400
Message-ID: <CAPig+cSis+QYgkPM2pFrEpEWOyny3XpMJpgYbGbJu2ZL5SBmow@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/technical: fix a typo
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 4:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Andrew Kreimer <algonell@gmail.com> writes:
> > -Since there is no publically available VFS-related code for folks to t=
ry,
> > +Since there is no publicly available VFS-related code for folks to try=
,
>
> As a general rule, unless we are doing codewide sweep to use a
> single word in our glossary to refer to the same thing, or
> something, we should honor author's preference, when it is already
> written and it is not blatantly wrong.
>
>   https://www.collinsdictionary.com/us/dictionary/english/publically
>
> I am inclined to say that we should keep it as written, but I am not
> a native speaker, so please cite a source that tells what is written
> is blatantly wrong to help me accept this patch.

For what it's worth, I am a native speaker, and I was taught that the
correct spelling is "publicly". Indeed, my Webster's dictionary from
that era lists only "publicly"; it does not mention "publically" at
all. The modern online Webster's still spells it "publicly", but at
least acknowledges "publically" by saying:

    [variants] or less commonly "publically"

The modern day built-in macOS dictionary does not have an entry for
"publically" and goes out of its way to loudly proclaim (in bold in a
standout box) under its entry for "publicly":

    USAGE: Note that the spelling is publicly, ending with the suffix
-ly, not publically.

The word "publicly" is, of course, so frequently misspelled that it is
not surprising that "publically" has been accepted into some
dictionaries as a legitimate spelling, but, as one who grew up
understanding the correct spelling to be "publicly", the variant
spelling still makes my reading hiccup big time, so I found no problem
with this patch.
