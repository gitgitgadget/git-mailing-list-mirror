Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF52314D36
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554735; cv=none; b=eRcNWWTNHkFcy9VyWA6WJFbHmXF05JOLMDJtYKElzWuHpfEX6sVy8Y4gTXMroi8MYOmsxcECl9I3scKe/debcYN5Z46BlxfyJLAiXIUhBA3CyvV3d2s/mXY0MfFUkm2kItmbPRRt3UCuEMTayyP2eu08fc/W/FrZi0yAWhw0hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554735; c=relaxed/simple;
	bh=2Q9frWWJdfLpH0e9TwlGx/OunCKfV1wL9G/d4m02UPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBL4AHv2wjg57Ad0seszaSYRIX2dJH/zynXqIlDYtnC51uwAIFEve+Os+0qMe2FKY9vqtStm/A6jR6pj0FZ4H7zLcCetsB2HFdm/+JyuNrYrUiQjRGPRauy9ydNa8rbz6HUCZq3o7NEZk1+Csr5S7AAKeLeUIpiXCRfi442Qy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGwY5P//; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGwY5P//"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso7553721a12.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554731; x=1762159531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wikw8APz1RMXzN+7EsjosHpcln9dA1xMTRsJPPhdZBs=;
        b=mGwY5P//BMQCSS08zAMoOMP7vKsTVB5Wv1ub5RzYflk8P6Z5luqFsn6ox70qgOk8vq
         hBc4soth0/AQKGMq96QCrzphHjHvx9YMCE9KEqYU0GNwRL01O5JnhDcHGji3MoLdpOUw
         Pzxq7n27yg2b7XqKCEkDwHDFBUcIUdPGc2uE0DasZHjTsXC+U+lFH9rVQ7GTiJ7hjBn6
         anrnldffV6ft8CRy8fP65W/rprq8UaKxlh9fkKeq/vxx/HqqeP1zfgcVthK67JxrbYGS
         ZCUbJV/hsNz/ap3hX+/Th/bABlgWgA4IIRNT41ZT4LWsKxjGvDdAKQB1mrj/K2mWyDId
         F5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554731; x=1762159531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wikw8APz1RMXzN+7EsjosHpcln9dA1xMTRsJPPhdZBs=;
        b=GoLdfR8NBvvXYahHEu6AUBZWm1eGccvNJPkRUzAeaRYXn/0gBQbExYUO8Gp/cPxNpc
         PnV7VPjlO7w6YKY6aKgbXBiN94UENJAWVSZVEsHvfyNb6B5EujZ8TiMQ3NaKyZyydzMD
         7bOfKVmxB/UHT74qXGOWgJDzFHj7EcXpi1bE13nOXpDLkZmIYDQ0Y/7DFNX46AnawGnF
         /KOtA1dGwVL4tqTZwJzKkvT9WQjSX3DnOGN3VuPZpDEFLpxcQtd+FJO9zL2auOSe4jsP
         xLvbt5Uwlg7GghN9MeJ6ToMhYVjdeqySDyUQWLoHNytOWDfIKOsg+141EloI5Tg4P9mQ
         SDOw==
X-Forwarded-Encrypted: i=1; AJvYcCVsrmOZjYNt+v3iIrhqC3XG45wdgmAzLcQxQhb53MSWE0IHt38pVcYlW64Cbb/ERMwfOFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+NeyLHtX1q0L1ek7f/5rQerDjKc4Bq07kStl0weKRkqKkDPx
	nuzPDeX+4g8WanIRfxW7cdUMw7WWHbqNu8ymCr/De6VdQb6RxLpK/dE2dczKtiAHcLeMlIGvCl8
	9Af0O8iE8hImEwToDPpoVNx60ve1UmR8=
X-Gm-Gg: ASbGncuDHXCoAyjSkFUTjst8kaqmrkZ+oBjxSWlq/TUpo/fkvfRauD2JgHtIqJzQp6S
	SbB8V6BVyEKJJcXUcsBxfoLkffYxqninA0b+42/ed9A1gc9vOdM1W7rdzc3fYmjKWLHQd6YYH6D
	aj5Yeyo77JpCHVnQcPN+RrFsUGwcy+qpHuj/Yy3mHtfY85BftCd129EBmw/kVs3WCWJgepOhpwH
	1Qs/fnZhgztiHJL3Lkhm9TvlhsYIYtKUj6lOlIvvv3gLY/k1nIe7Abixupp
X-Google-Smtp-Source: AGHT+IG0xRZUytszm8HgPJkmI+Ouu+c0EtmXxxSa6hB1wtgSwQ7ytEKloQpDCwEFle/jYfhF4xXB17i23MfA5r2MVLI=
X-Received: by 2002:a05:6402:2115:b0:63b:ea47:bcbb with SMTP id
 4fb4d7f45d1cf-63e600037d6mr9677597a12.8.1761554731006; Mon, 27 Oct 2025
 01:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm4kp9t7.fsf@gitster.g> <20251024210433.2033-1-qjessa662@gmail.com>
In-Reply-To: <20251024210433.2033-1-qjessa662@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Oct 2025 09:45:19 +0100
X-Gm-Features: AWmQ_bnMlL-bNc2WEJ7N8gfNp7gwKD25O99yotmKOTSexlywEGa2Wv5aXTHY8JQ
Message-ID: <CAP8UFD0rMxdLN3TY3EACXHG6x40OPy-WYpbhPLx=ouk=6z7LZw@mail.gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add note on confirming patches
To: QueenJcloud <qjessa662@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:04=E2=80=AFPM QueenJcloud <qjessa662@gmail.com> =
wrote:
>
> Add a note after the `git send-email` section explaining how
> contributors can confirm that their patches reached the mailing
> list by checking https://lore.kernel.org/git/.
>
> Signed-off-by: QueenJcloud <qjessa662@gmail.com>

Are you sure that "QueenJcloud" is the best way to identify you? We
prefer a real name if possible, and yeah it should match the name
associated with your email address.

Documentation/SubmittingPatches has the following about this:

"[[real-name]]
Please use a known identity in the `Signed-off-by` trailer, since we cannot
accept anonymous contributions. It is common, but not required, to use some=
 form
of your real name. We realize that some contributors are not comfortable do=
ing
so or prefer to contribute under a pseudonym or preferred name and we can a=
ccept
your patch either way, as long as the name and email you use are distinctiv=
e,
identifying, and not misleading.

The goal of this policy is to allow us to have sufficient information to co=
ntact
you if questions arise about your contribution."

> ---

This is a v2 patch, so it would be nice to know what changed since the
previous version of the patch. It could be added here after the line
with three dashes ("---").

Also it looks like this v2 patch was sent twice.

>  Documentation/MyFirstContribution.adoc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index 02ba8ba5f6..6e7f3036bb 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1153,11 +1153,17 @@ NOTE: When you are sending a real patch, it will =
go to git@vger.kernel.org - but
>  please don't send your patchset from the tutorial to the real mailing li=
st! For
>  now, you can send it to yourself, to make sure you understand how it wil=
l look.
>
> +NOTE: After sending your patches, you can confirm that they reached the =
mailing
> +list by visiting https://lore.kernel.org/git/. Use the search bar to fin=
d your
> +name or the subject of your patch. If it appears, your email was success=
fully
> +delivered.

This looks good to me.

>  After you run the command above, you will be presented with an interacti=
ve
>  prompt for each patch that's about to go out. This gives you one last ch=
ance to
>  edit or quit sending something (but again, don't edit code this way). On=
ce you
>  press `y` or `a` at these prompts your emails will be sent! Congratulati=
ons!
>
> +

It looks like there is a spurious new line here. Please remove it.

>  Awesome, now the community will drop everything and review your changes.=
 (Just
>  kidding - be patient!)


Thanks.
