Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696F1AE87C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006689; cv=none; b=aGODckwpTjJww3BmS9KWmY0ZcjalnvXChtk0NAm/a0KlvJ3zm5j7nflN9i38l+2TQmSxie2BfnhWWoeHp+arww45jGCW9wooclVyxlhI/ldMWcgJ4OXo0AZZ6t75zkgsTjok/SHDTmOIckwDpp9Nk7oPVNOygC51O9c8R1VxzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006689; c=relaxed/simple;
	bh=Xux/6y4fiMX7+D/O3ezGHmiIlRD6I0MhLsEUfLXJ9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAOS58fGGhuK2ywkEinrz89Vl+H1WZ42LAal6fWrWpj6CoqnkXqdcLsnAbmCY76nSUx4Rul6t4rpohxr9WYOF4MF1XV5PxUL55+qp3Ag6XNfLId8mAnoBrwuzQjs8WFTvDV6S7/wT/+9JNlHZdl1r6Q4dG47CagFbIS79cJVoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c352e97ea4so3481946d6.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 15:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006685; x=1726611485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPdXjx5Ui8OC3osqSP72V4RBlD8LuWtgFy7UbBPPYRs=;
        b=Wl4cX4OhGzbYa6DC4rxXv5PF3hK9TmoQouPa1A6xuERrgqHM5q9N4c2TMu4z3APbta
         3sAsNtBRktW9QPA+6rOt4nTGjyz+bC7C/9KykaRG1WyEunKoTH0uxCOF7vg/IxTH63JI
         dqJyAUNv6UExlO4/jUbUvbxrBKHgW3/zH0HMrBnoQIWn15h9+PIsPK2AW7rBBcTsaAlU
         TzgDeRpkjZ/To9vXMSFS+OhQ21YeQ64ebCs4DGGwMHIWJaHK7uZwFoRAxCahKodAGClH
         QauIoFzZdsbCjuIzVB/Cva5Mpqbc/lfRzexSTqMv407cCSquu814JhbuOl+i91nedtht
         uIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPFRRxBxg5J+E3nj/LpIzvHvUi6eax3XIwjAIeY8J5SnoA9ArrsMMRvOLqYRpfbyxMSvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMzcuiASZNUyK5RJg1fnPuwpWZjEyU7kLT2uHYDXMomSgNnaQ
	4fQZuMi7GwKkdXuQ/WQx7/HIezsqssEvxUTpsStWwr4gvcQXfsoGU43pegbVfr6eh7CbK3E4J43
	ikH74zsxe2qvdG6QlMcRUzdMBc/s=
X-Google-Smtp-Source: AGHT+IHo72j9ohLzhE9gB0oZyf+RcdX8Uquj7Z2iQ480zq5UUEODyQQVPNDWnRkPitJ5VpTZ72nBPMQ+KOrgzZHdt1I=
X-Received: by 2002:a05:6214:20a1:b0:6c3:8fad:ffc9 with SMTP id
 6a1803df08f44-6c528512220mr97713336d6.5.1726006685240; Tue, 10 Sep 2024
 15:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net> <20240910041013.68948-4-ericsunshine@charter.net>
 <Zt_5zMiu4QRka5x3@pks.im> <CAPig+cQZhrG+0BJkDbmKY11jxSspod2Xp8tSQq-DGOO9qMbR_w@mail.gmail.com>
 <xmqqjzfjms6j.fsf@gitster.g>
In-Reply-To: <xmqqjzfjms6j.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 10 Sep 2024 18:17:52 -0400
Message-ID: <CAPig+cRuAVc=zzhbXFx0LkO6Q93fMEVyMiJxJ41eVAp48iCX8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] chainlint: reduce annotation noise-factor
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Tue, Sep 10, 2024 at 3:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> >> One thing I don't like about this is that we now have different output
> >> depending on whether or not you happen to pipe output to e.g. less(1),
> >> which I do quite frequently. So I'd propose to just drop the markers
> >> unconditionally.
> >
> > My knee-jerk reaction is that the "?!" decoration is still handy for
> > drawing the eye when scanning non-colored output visually (not using a
> > search feature), so I'm hesitant to drop it. However, on reflection,
> > I'm not sure I feel very strongly about it. What do others think?
>
> Unlike ERR, LINT is distinct enough, even when mixed with snippets
> taken from the test scripts that are full of words that hints
> errors, checking, etc., so I'd expect that new readers who have
> never seen the "?!" eye-magnets would not find the output too hard
> to read.  For those of us whose eyes are so used to, we might miss
> them for a while, but I do not see much upside in keeping it.

Okay, thanks for weighing in. I'll reroll and make [3/3] drop the "?!"
decoration unconditionally.
