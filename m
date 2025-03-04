Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BD24C08C
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109746; cv=none; b=gp3sWQUsFBWqutTBnFm+st3gjwPqLAIY7DhzSJWmzww5DDP7Zxb2JU0Rdw38u5HtYXQ7QzMrMzrZiIuaOOApVaMaA3WE36aXgFKtqVOKc/DsPeI09OQAIegArvDk+uVVSqaYfCN97XWmr31H9X4sKVy23w8dFBP70LTHt5SLkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109746; c=relaxed/simple;
	bh=bGlSIpUC1dHtOelWrmkTfb+J4UmiKkhbSWp/91oKkdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IntyrWi/uJjn+Pg7qxd7EepvuKydLFP93Tk4D6iE/hiEpKpuLQU7sF1c5UxlRGdF21PukkC7NEi/toS36Fb+sCV1ijvtNKDHMEP0q9aqmucBdltU1gh7PMLzqn4pzQQx49HJvWySjmUGUI1lGl10UC4A4ob+bAXq8m9VlIcsEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us2//wgd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us2//wgd"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-548878c6a5aso6444287e87.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741109742; x=1741714542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBIS1dVCpbUnZkOinVLEvQN5DMxYs2uxBcE7RkH0r/o=;
        b=Us2//wgd6+02H6NmqZSuYpnt4GFaZXHpFRfJwKE6YRDX9+muF7QMtT95FlVMArRAos
         5qbKZ3bio7+itvBjjyCI/KSmedo/7Bw/x7r0EU3wav0IPn4QOHO8yIQAxKgVD1U9w/79
         1SYuJcHXKyQ1SxZpMNMzqB55iRtbn2ImzMloXvTlayA6B+EIJzK70g2zw8H/qxxrduEK
         2tUMZN8RnQr4wDvApGf2d/p7Y/Bd0IUNRaZyb+RcsueExpAevQkzYEnfqxMGOQn9Qqhk
         DALTawDGb9KpfShgArEiSbY9OgfTcqmkhvc1CJ7Aus+g+J76xB5HTAh0FExHf0W4tU8t
         X3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109742; x=1741714542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBIS1dVCpbUnZkOinVLEvQN5DMxYs2uxBcE7RkH0r/o=;
        b=bx6poXqJXc3yP9BHt3+cKYSzgIwBTik2k/sxjTUuDE4G1UiQfOePhlLVKFpAnD9Kne
         J0bLLEh+G6ZdmG6DFGofwWlsWVV/pUiWRdyNzsjlBSylOt8H1hkxWFAuhE4Kwy958i1/
         SbT6UtV5k3NPCeN7PJ6TJKYOV3nA4mJ0OPHHSwE5ThRiEwQQ2z101O1hA/+V4CcRQrdp
         9b2ur59xFdZW484VDdNZEUFapi5LZ+nZ9b+kaZfx8uHSZ7lwmaN/q0L4EOji6ClhJtJL
         Lu08UE+Oyg94Vg52n8Hp82SOGFjxjws6ceKjGFDhurEO9529S+UDsIgw9bmZW6J8jaO7
         xDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnM9cmd2jNTyrM5lgYeAAntDg0cDsV9UHdkaZU390jm1V99gLl28P84zqQamG4w5adPtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0j5ImzsztK7hiAk2mOAbZv9XXQiWUXPfC9t4Nvo+1dJhzQ0X
	Dc19fUJsqF3trkFsciml9OOsDlFWZMnrjh9KIE2L8PmfDpHf428qeuZa2yuXcGy37oW+UGQmAMs
	s/3Yv21WAvAghgiIUJ+EdNGRFmDo=
X-Gm-Gg: ASbGncuT0YXA/6b6y/IMo1mGEXCRGMTZiQcIiTVoVK3xuBjHwPS0vrSzfGtQYqo4Cod
	++new1NrZm1SOVaEtasirx6vW/w+zazNFGF8lKMkhcIBS1hBt5m3ORMjORnw8kACSlEfbLdXcy7
	DL9/wFOj/TDcxcgdu+dP3J24rgaDqXeWB/+T6AOiPvbis+E4zp/3+dow6fwQ==
X-Google-Smtp-Source: AGHT+IGfZkohpQxbNRF4fZRKRMPW8trM1rXtDc4Xp5qfzpWX69qK7+kLqyTVOEbM5C3+OCeXzLXP5GfR2OdnfYcq3N4=
X-Received: by 2002:a05:6512:280c:b0:545:2f9f:5f6a with SMTP id
 2adb3069b0e04-5497d336052mr6628e87.14.1741109742391; Tue, 04 Mar 2025
 09:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
 <xmqqldtlt304.fsf@gitster.g> <CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
 <xmqqwmd4r9jx.fsf@gitster.g>
In-Reply-To: <xmqqwmd4r9jx.fsf@gitster.g>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 23:05:29 +0530
X-Gm-Features: AQ5f1JoAT1OauKPwXMZmwz47wKUm6FLPlSpWFxIcF3mkolX6JKBx6En7FmxGHXk
Message-ID: <CABGrwBBaHzM9tE6vWkuMSZuUbHVWwCZVTgkvMb04C=NYyGCLAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
> > On Tue, Mar 4, 2025 at 5:35=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>
> >> Mahendra Dani <danimahendra0904@gmail.com> writes:
> >>
> >> >> >       remove_object() {
> >> >> >               file=3D$(sha1_file "$*") &&
> >> >> > -             test -e "$file" &&
> >> >> > +             test_path_exists "$file" &&
> >> >> >               rm -f "$file"
> >> >> >       } &&
> >>
> >> You may want to think about why there is "-f" there.  If we remove
> >> it, do we still need to have any check there?
> >
> > Here, the "-f" flag in `rm -f "$file"` does not produce an error messag=
e even
> > if the file does not exist [1], thus the `test -e "$file"` check was re=
dundant,
> > as pointed out by Patrick in [2].
>
> So what happens if you dropped "-f" as I hinted?  We'll notice the
> lack of file and the command exits with non-zero status.  So "test -e"
> was not necessary in the first place, was it?
>

Yes, due to the use of the "-f" flag, it's not necessary to explicitly
check the lack of file using `test -e`.
But if we drop the "-f" flag, we will have to check the lack of file
using `test -e` or
`test_path_is_file()`.

Thanks,
Mahendra
