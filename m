Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62A14A8E
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771771832; cv=pass; b=SU1fs3apxqBZVVk/JqN1oj/F/8VOmQ4Q+7nYH6XKFwpdHKXUwXsMm/DvKChFqGDjbbVk1Ta9O4BKIgJI2JJFt3UT9Vq51nfE5L8NvZOCeURlPu3T3SbPrDn1nlK5TXYvoEaCJc7hYHBAc6jAWqsTfj6kVc0AJ3IIRdQ/fTWyhqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771771832; c=relaxed/simple;
	bh=yBemny6J/OhgRLbpxpcVhFHKk4WUSUDrzE6SPaqP8V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmPOypvD0JMTjbC7lq3PWDYMdhKCl9CyoZMiQcfDLjLLTtqJRAd02G/DwDUOHiAwA5saNxF7Y+zHC/QQi75VQlYWoUha94QDLrvXFti2oYHE27I/UF0Tg55NOcADp8SEcz/bko41yxLgJZirpA8XMe7M+LWp+9xpV38jKcZwrN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krNNcL1W; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krNNcL1W"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab47d8b33cso19386715ad.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 06:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771771830; cv=none;
        d=google.com; s=arc-20240605;
        b=QiKOkBaUwDkq85mM+f/pxX1iOlY9mqJtpd6Gfbozn1GCak2Y3SlHcIojAP4mtIflbm
         mfxQMQ+cbjio+6U4i2Z0SrRVkocrqXRtTAeUwvvZkVEOfLseaVYipTLk2RjSC/B3DPjL
         Zc/Aa4AGt05h1b5agr6pt3duxlldFaPbtkuK2rg3UUwaQdimfmoFcHGIw19SblNc9exA
         ZjaY3h3f02FIPTK/Lh4PuQv8F+/U4ewVyUomWrKDj0fduwi8+5n5evfmbLwjZOMo7UC4
         kGuvyXk/Hoczu4qXg7QPkqxbV/AeCNUpyLyIM/8VzzVsCvIIlxWQPaY5eAK/5Qkf6iX+
         8xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yBemny6J/OhgRLbpxpcVhFHKk4WUSUDrzE6SPaqP8V8=;
        fh=/2bo4TQ84E4NNbGCxFjpOOLzr/SLggTSNDQtqHHLULQ=;
        b=CrIAShwz5GFkRHxfMxLe8RSNZ+IMIxwWcrkZ5yBpmWD/Y46Lnjj9JN4/Xl3olBHTPE
         yLYsZwvwjnkEYyjHF/ELz7ZBP4YIP2gfIuXS6z+k7xt7dOdNha3rWQvxIh9Gk/B1245f
         9zHKQYaieu4iCksEwan0lrgRegenOlWMkE2kD3/n6tRHglOC1kJkIQfc4lE5+DN/woCh
         HFYlDr45kAcCqCahx5pT2HBeDjef2MNvfAj56ajKxsKEap8t8Bt+2ehAnuguT8F+XHH/
         zFbnW9T2U4DpfpbX0b25n1r5uloOMTu1Rl24Ww9VKyI/vJQMvmhSK3MZXw2iea3/WNYM
         xDPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771771830; x=1772376630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBemny6J/OhgRLbpxpcVhFHKk4WUSUDrzE6SPaqP8V8=;
        b=krNNcL1Wkg4f+oY91qdkq8oWB1FWmfWCCfgITwkKzO0cl9PW8M9PTORuFEhLwnvokx
         Dvxj1gQiEUetO/lulKnXxRtSbAqZU4LSy0v5F//cADCvji3DItV61HnxBH8XRWy9/AVz
         6COt3NRRH8f4wB8I30V6MM32Od6MfQCocnWrSK8tjA9Aq8UgCrlqx1QWl/ZA2nytr7yH
         Fpekr1E4ChGu+4nQAW7s6OoVcXWN6WT6WsRDanUI1KbHvhoQf6t/r2HaSeAa1nJaJT6K
         5UPqFzBQ5emF5V1QbRhhX+J/1rrsjGPBahTcJgskkOYIIQksVskKp84naQww9e5/UOST
         dmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771771830; x=1772376630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBemny6J/OhgRLbpxpcVhFHKk4WUSUDrzE6SPaqP8V8=;
        b=jP+MILC+cX9wZ+bxfO3tjSFFcbhEQFtBb1t55tTzHFGT7QZ5eZFNlkX2gzjaQTaabh
         FymLX++U6uS53S5S1je0XYU+WGtQbSX/S332Ku5m9zvOS+bmGNU4G/TvSXjQNgnu5vVC
         B77PcpTdhurwmkvN/307Br89mWXl0ZlOd6tlZuTS1CLU3brB2oxR8e2zu5ZpLm+Nf9Rj
         uoXss8hsUonaMMa3NhS6FO/2lszuCOvnGaSoRe3ca8foh/FEUdBWVjNouKTMXJGy8Tac
         aIbJM4WrJ8MewXU4Sp2ME9HHF8IQxJrsWQSyeMdTWW3EfUZWKVDw9DaQ0vElP6YiS8qd
         NFcg==
X-Forwarded-Encrypted: i=1; AJvYcCVePNEyhtUj3YW7zWHpLnf148/9nO8tdcbejJZsQn3sdfnNosZZDNKSo6xfqkDzNY7JFH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEeMWpUp4pRFN6eMTDvBWZj8GnzanGZroE2RYU+brpODnS54Tf
	LqsychXRvtsEscV84c/Tfc/MFDQf+gjqhm96umGVEv+NLRLeRW95SXp/vtsczLxT1LC45VD/K0R
	zrstzV3Pt50UkVGy80fufXd+F0vwBDP4=
X-Gm-Gg: AZuq6aIA00LkweCUttgJM1f3mhTDz+OYNwUqz7yGsQipE5W1xmRvBATo772JXrRqZBl
	ApCw0DeJaqxY6MHrQUjdOInB5SllHN9TRnIcNLLwfsjRC3lsQjxo/lk6sfLR5FIzMoTe5MG+l7F
	IFK3l7ySdnrMG4Dxj8p/xI1Okb1+o4EvJ2hhj0vDRkNHpEQ0cQnVMkQ89f1Vf3Zty2mTGtpYLei
	pZX3Eze5mChpqHTooZfifhI1U1hh7dU1pr/Q8HgDJK8u9+ayoacq3x8xwgbuX9y49vgpqs2Jm38
	UMnRiY5Xnnx4XKmLzOmsgD3qsoba2kfj/NV5nb1YKqAtJ6MGDWIIb21E47jJp/RVYDsF61B87oo
	WrA3hFbOqpVBpJx+V5ddviea3c/Ml7Cc+wLJH
X-Received: by 2002:a17:902:d48d:b0:2a9:2942:e15a with SMTP id
 d9443c01a7336-2ad7449f6e7mr43354875ad.19.1771771830513; Sun, 22 Feb 2026
 06:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
 <20260221080201.7847-1-haraldnordgren@gmail.com> <xmqqwm06rp6p.fsf@gitster.g>
In-Reply-To: <xmqqwm06rp6p.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 22 Feb 2026 09:50:19 -0500
X-Gm-Features: AaiRm508pmJdy1A4XcKUqBSQrNuhXuYAkqsXPFb0Lv74fblCC7Q0kDRrCPVKLQA
Message-ID: <CALnO6CD_dCoHCOVAUbXE-5LmgU3tVOhyYchDTpAGO+acYPaqRw@mail.gmail.com>
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com, git@vger.kernel.org, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 12:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
> > Hi Junio and Jeff!
> >
> > I see that this topic has now been marked as "Stale". Isn't it time to
> > merge this now?
> >
> > We went to several rounds of reviews and edits to reach something that =
I
> > think everyone agrees with =F0=9F=A4=97
>
> The entry has been asking "What's the status of this topic?" in the
> past handful of issues of "What's cooking" report and we heard
> nothing from anybody (until you responded ;-)), so I moved it
> together with others to the [Stalled] section.
>
> The topic has been paged out of my consciousness for quite a while,
> so it may take some time for me to answer this question myself, but
> list participants, do you imagine yourselves using this feature in
> your daily life?
>
> Thanks.

I'm trying to run something closer to the tip of "next" at home and
work, and I can see a few places where I might try this, at least.

--=20
D. Ben Knoble
