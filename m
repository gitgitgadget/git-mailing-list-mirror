Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F4B652
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753497640; cv=none; b=r+sNR7rchJgQg2dnHtunmt1NrlyG2llgn7R+YqZVPnMfNoKY2PTBBCp/33gCK7b/Y5prtBMo5Xvs/eUhptjjsfHv5Oxv6SZEoNbegB5LjWUpkPwz3BwnNRNZa0pMwOc9miBoGPD9le4+cESgX1xKgeY409WJ0J6VKiG8TNd7fTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753497640; c=relaxed/simple;
	bh=qnPUB7bYORL8HG9VcxAUTXWlkL1WZrhgJ8+pOoXCqNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqW7ul/7+Z9thIrE6LRdHrvsDxUMNmk3+2cWltZvpObKFKWtublsNm50dMOf1vDn/Japa1rxnbFjmRmKqwWltsjeUaLierNsL5Lu/dyILGPf+W+jqG+FjhHDtoS9Kt6GrQx/CSHlilJJe0W7YegSK8RfFovyDGO/dl/vqooetUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaOdBXgD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaOdBXgD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454f428038eso25509645e9.2
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753497637; x=1754102437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnPUB7bYORL8HG9VcxAUTXWlkL1WZrhgJ8+pOoXCqNs=;
        b=WaOdBXgDX1Nn3UWgES6g1XIi/4PXG+VU6Impo0fzeAW+8J8uVmIAznjsqIvZ0LZjmj
         fgHpfi0ZX0rsBC8GbEgq5bzr3fzcM12V/MifzxC6nybMjUWVWx2s+QDT/vsHSK8midUg
         7RdLkYmWnk2noEFjnWvPfQPsYYvpnERRIMFud9kV4Ymn0DHfwEbSJ2IirP0W+pN1sc/w
         yWvjWo4ZlbZGsQqhzrGr0hZFeBJ/c/+1UE/206G6XKE1qAoPL1j0q+fFfh/x/jqDL4OJ
         zE8RERrmwzmc8vEyvoa7nRxvz5kLyjnSB4AUI+0mBC4Bx6347U0gHHJClJe61QnAo+hd
         qOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753497637; x=1754102437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnPUB7bYORL8HG9VcxAUTXWlkL1WZrhgJ8+pOoXCqNs=;
        b=Y2NUlCJomPRFWR32EzUwOexvE+rdHGDK0L+8b6SjJXl6IvTk2BXtWlNhbMMEX3GyM0
         eX2ymAHHDNOe4nLyQzfeXffOoODpeLywuBi3BqgrZs/XDwq1O+nUMCYzZsWAkVSObymU
         zsHTBoOXtD5ivZ/Zu/6q2v/nLOtaMa0ny/h99rbbM63tCVv2hMo5jHNonp429huY9gs2
         g2qlfnrNZdHXXn93vMRptd7BbvD5Gqj+D/LzAZsXA0CLwjT298WAo3oj4FQR/po66Qsb
         B7bC2sntuJyTPAcJFBknR2yLyP25Y1ZXus2yi7s7/Xf/aemWaVO3nQIM7oBqV1t1/uzt
         e3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjh9nwTQu1o9irDBMMfuJ2vB+Xk5uSIqE0cyiiJY0xUyfBlIq4LvkUDq0sU2/opVIz+JA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90+tz7nK0Rn2mD+olxVdQV6KBHo9WzFO+VeKwvdl6seIJVndm
	9fMFNCGxrvQjt9uq9W2S1FLk8gzUsaStT79fv/89EhDCmHfNWoyAblvbqlYrJQfTzTLSahlaiI7
	xuvkJuQYm7txWHfa5sWKXSETnnYfhrCM=
X-Gm-Gg: ASbGncu3d0Eq8N4sp9nFvdJ4j2foe7WsfNiL23IoiesFYYAKJwWlA0qNwrcXQS0zO6x
	IRb70MpkCJS/oh572Vd8L7UTmuOoasyt272kv35n2diA6sR+uDYjVKXOt1QMF7EOR2vMs4ovHAt
	tLjtgmjvBYMRetSPd82p86z4XRPkiZANQxmZHrDhh7MuVC161IdOd1sXkrhXSf4RFTpzBKXpbNp
	NxAKKpQ
X-Google-Smtp-Source: AGHT+IGetWAyBet0rkehlnc5nxvVImt4+KdhRFQ5cmCSExBnsdur+khJHEwfXUifjr4e2gCxEHPmCt1YVzr1mLBmxWQ=
X-Received: by 2002:a05:6000:2c0b:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b776726b24mr3435901f8f.1.1753497637001; Fri, 25 Jul 2025
 19:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g> <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
 <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
 <xmqq5xfg5o5j.fsf@gitster.g> <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
 <xmqq5xff3jhc.fsf@gitster.g>
In-Reply-To: <xmqq5xff3jhc.fsf@gitster.g>
From: Cameron Steffen <cam.steffen94@gmail.com>
Date: Fri, 25 Jul 2025 21:40:25 -0500
X-Gm-Features: Ac12FXxyebza2_J-ovstkSiK_Wutl2Z_bTm2elqi_AJzpDWCtu9k7FY1WHjeGtI
Message-ID: <CAAVFnNmqGwGEddSv9CbWQGx_pyhY4aGMWj5fKN+7TQo6N6CyYQ@mail.gmail.com>
Subject: Re: Show skipped commit message after rebase conflict?
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see what you mean now. I guess I did not consider the meaning of
that message very closely.

On Fri, Jul 25, 2025 at 7:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Cameron Steffen <cam.steffen94@gmail.com> writes:
>
> >> But only if we can positively tell the reason why there is no change
> > relative to the parent commit _is_ because the commit we are
> > currently picking has already been applied, that is.
> >
> > I thought we merely would need to see that there are no staged changes
> > to be committed, and there is a currently-picking commit that will now
> > be skipped? I don't need to know whether the commit was already
> > applied. I just want to know that the commit in the rebase plan is not
> > being committed.
>
> Then your earlier idea to reuse the same message
>
> >> warning: skipped previously applied commit <hash>
> >
> > Potentially we could use the very same message.
>
> would not work, would it?
