Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560223;
	b=ngeMM8YX0Tybrub3bO8kBsfgL9paJAJLQ3YsL6pfYdgK4G6fQvvV9JsN/D8mfCzlKobz
	 rKb70M12dtHWQqCzZO5RgO6daUXiFiedzttL1oIPxAsSp7mGKL94VH51Pe/d0W+kuFtDg
	 jZGNedbrZOVzCYooIqLj1+0Et+WGQCGvT5f1dgKXa8IHcpLVnCe9vsGW1m8MN4BsYA8E2
	 KlCP8ejFfOKihQxveXPxx38eHRP7gTl6p3Lv6sVqbvP6hgtvkgZslwlU8tcN++kTil2Ir
	 evIYA6nxMIl5RK12YDt27qmr3OyIVN5sZmGy+Ig0o05RdS+Ra8Hw1h75Ht83TMwIsYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nQGt4vOk9JGakHn9vCjvkjc7ZuKvNoo+WrM1oMYvY5U=;
	b=0m0nC0tbd0IW9wEv6O7CES51pkZOuCrk5uiMFq8otNPl0oeIZF+eiAxUFy6+deF/Kvsw
	 VrEEhQ+g3D92QQJz/2CFj24zPLnI4+ECLF+K8mifwEkdW8o4iUYDK3MHxtUaaStvi4jvP
	 a5g+d8/XEup0q2UbxxWf+Yt38jxYKf5Tg4Vc714ZQhpjIn/Su3Q7TCXAbKUX1an42lONL
	 2SCI5OlrTRMaGN7SOJjC3nzJ8MnU/GNG6FgksqznNWtaFpdD04EFdguehNh9E7kJowS8C
	 E35Y/hpcQMzW+VOhhWqZDLDcW92EYRh9fYLuU1X+5lYr6hrWg47kqfGduRxo6tW+khg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AP6hUxW0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B4606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AP6hUxW0
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso6377135a12.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:43:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795560221; cv=none;
        d=google.com; s=arc-20260327;
        b=MO0dwWMUm9gCks6OmyO57Vmy7+EkrYWH0AY7ujKwwg3g/RCyipOupw5TX2mJUxLAkm
         yIaB0o87N/9NsEnX7XpHCgiq1z+MWvZcYu3jviuQXdFfo4n1yY0itiMNd6xf3HmGW2yU
         +ff0sc0kFBT7zcq+pNI8sm+J/+qmykHYIVZMFeSvS2edeYkOBN59sJdwO1yW48uQrPIZ
         wQ3MHVYqIZ3AxZfuy0cFKrwnpLURcJ6qYfiUhNBWimKeoi62zvphhSvX+hR+aaD47uAc
         8rjCnp6RpkYBkFqc0FameyR7Y5Ys4J1dh/Wz3JuJqIeyxNTgouJI5JcSmCsK53ETrHY5
         qLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nQGt4vOk9JGakHn9vCjvkjc7ZuKvNoo+WrM1oMYvY5U=;
        fh=vNr9qSrSfgHpidduVhSRPvKPoYfGoL3STHjVV1mCHpM=;
        b=oeLLGZEWue30qz+kbNf0fTaio3imObCK36G9VFpvRXmd7amrN8+WqU8CEH1nN+ux0l
         nKbFrVG7SljFMGDdhWEy9egssHV2XRMVexoRVM4Fx+VMuEVdlFTjIr+Y1zmo1ZEasQMo
         9dJHWGwJFMQUxkuuymE+KpmKLzNKLP5ObuUaiaEvNMiWOLYyGuvklPbGhq4AQcMCMiLZ
         KQHHSsWOxj4dRHT6GhuwlnTMmmXPpTYIHcbDUyaHbmlkDD9QHJFhp1jfbb7f/6ZE21iz
         PBML4YjyENY3kH7Miro3MGNLey8cCQm7whdLwKjeu6FVN53AyupFxOkFfnc7yUjaAWVp
         +Syw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560221; x=1796165021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nQGt4vOk9JGakHn9vCjvkjc7ZuKvNoo+WrM1oMYvY5U=;
        b=AP6hUxW0VGfHErkxV0kYbQpxKthRRYGKptaXkaTgejQBmcnjg3pGhuao2+I+QYzC3/
         F46v9+ZmIexjsWnlsVhAXgNHvGUlq1lZg3s1GHKBR0Xd1lNeCXv/Rw5vPI7dvQKlPFzG
         pVsQWrrM15o+MVdUvExQrlP/HJJlfrrPUVXpjwC+Fe5aOQrGIt5UA+SWK0d6Z9nWcGh5
         dz3VKIQx189uRyIo0Q54DVmOkgQgP33c+KwClT6eamNE7Yp70SD3zAxLEV0DN9xmnaI9
         CAeeN60ryYLadZ486xceRKwzqw+LO85b3Pf0o8KaVf3vzJ30K4CrShyx1aDsy+6sZKoQ
         a6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560221; x=1796165021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQGt4vOk9JGakHn9vCjvkjc7ZuKvNoo+WrM1oMYvY5U=;
        b=z7S/BVVz6Jcxlagjnxp3w+FAJ4ydiDjvazhRB9URk1rAy4O0JuJmrBQBBgZdXZvsXz
         JhJjxR4XzCP0a2mrcIpObL9KB3aY9te7vQBTeqI4RYctXZxXirScmUjqMcfUjGsKeEvj
         99tUbs80jluBwxH5sCRVLik1+lPpSAsbfpBKe/+6S6oXooMShUHknhj/8+mcINombKAX
         bQ9vLIUgakegoA7rSvy4iDErixUQA3FPfY7jFpFcXewuQtfNsZpJmfAXP/H72F2jE07B
         zKbJyaQe9iqPQScoDHpT/+hKSLkLwhHMfkFvk+8N4ZpZRU036DMejrssr88sotwgQDLD
         NfpQ==
X-Forwarded-Encrypted: i=1; AL+hErEzPsDKc0CN20X0goL+xQEpESCjaoixlvyvn2r2K1LIUepkXebGLQkpvelRAUju9k+cmQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z81++FKxL7VnHKBsk80oZd2Lb2MTFVUBl95H0Ctf9WL5lv+giZx
	KJU55TfgQxgQgJxJkZy7463VoCD2TJ+GdctzF88Oe7UjNdu1Dfp7cqicS0Llnih8N73Za5GkLPb
	ixvl14qO2yyM6n22gqGv6orw0ymBam8c=
X-Gm-Gg: AZFdTZdhAoiSJH9vh6v7uW1328MEKEkwFm7rkDeA5mdD2CZBwd3M1nm7U5cdvZY/aIt
	1B4U504i1cbxFlIH/ruw3EUrv6uOtzemnXD6sI3j1WFufImPzJbV8jyzIwgx9Lzyr6Fb9+nwKv3
	cA9U43GSiexSqNeF7z5FI2yOLJY0nqROI+ZEj8vpDfFIZMBmzu91dekmijnCf2rda3h890Zqm26
	FCdU6HR+V5EhhFcOv7dGSXhJlKFmUcODiq/FVQ+5chiGqOHsHdDzmMS1a+28na6QPqOOvh9aRJA
	Uak4HaH21ZEedDaNEuLeAw1eEko09vWu60BVRMjD+YiX9meszDp/+qYYirLqns7WUUUBPWeI3xD
	U2JxueJsz+F5IwEhKOtqUYQlWcQzDEaOpjO+C
X-Received: by 2002:aa7:c0da:0:b0:6b7:d55:87e0 with SMTP id
 4fb4d7f45d1cf-6ba37e90613mr8215853a12.21.1795560221213; Tue, 24 Nov 2026
 14:43:41 -0800 (PST)
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
 <CAHwyqnXs99Jd5ajrskjpGyVQZmR1DOOPmXturzDxOyWuE9dfBA@mail.gmail.com> <xmqqld6iouk7.fsf@gitster.g>
In-Reply-To: <xmqqld6iouk7.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 24 Nov 2026 23:43:04 +0100
X-Gm-Features: Aa3M54rjK6FU8f4cMuhk6yKOvXrBrkwPr-AywhLC3X6J4ue2pOk-TfFGeYvJmx8
Message-ID: <CAHwyqnW4Exnfd_mTy2XFbATWb3ExwY63_ncZgkJ6_0NH8eaK6Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>, 
	Tuomas Ahola <taahol@utu.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
> > On Mon, Nov 23, 2026 at 10:24=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>
> >> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> >  * New commit: --dry-run also works with -d and -D. It is still reje=
cted
> >> >    with options that do not delete branches.
> >>
> >> Much better than before, but we still have a few operations to go, I
> >> guess.  Users may legitimately wish to try (with assurance not to
> >> cause harm) renaming and creating.  It may be OK to leave these as
> >> gaps to be filled for now.
> >>
> >> What is important is to wean us from the "The dry-run option is
> >> incompatible with anything but the delete-merged option" mindset to "A=
s
> >> long as we add dry-run to the command it ought to be supported by all
> >> the operation modes, but some do not support it yet".  So, perhaps in
> >> the ideal future, we may want to see
> >>
> >>     $ git branch --dry-run test v1.5.0
> >>     fatal: would avoid clobbering existing branch 'test' by creating
> >>     $ git branch --dry-run -m foo bar
> >>     fatal: would fail to rename a non-existent branch 'foo'
> >>     $ git branch --dry-run -m foo bar
> >>     fatal: would avoid clobbering existing branch 'bar' by renaming
> >
> > I think it's a great idea, but I also think this topic is probably the
> > wrong place for it. What do you think?
>
> If dry-run is a wrong option to introduce as part of this topic, then
> yes.  But if we want to introduce dry-run as part of this topic, then
> the users would expect these "I do not support it yet" from individual
> operations, I would think.

Fair enough. I wouldn't name it with "yet" though, because you never
know if we forget about it, just better to not promise anything.

But I can do that after this topic merges: add dry-run to the rest of them.

#leftoverbits


Harald
