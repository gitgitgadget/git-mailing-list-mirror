Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19190513573
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680736; cv=pass; b=Y6do93yZE65MVp4BZ7LQG8BXedhfJSqNJxj7nTEzlIaR9dEkdAnrDEGgymV1b1tVpFrAPxtuqXPouSxoHmt1Dlve3XGIE9RT7jTSrmj9Qv5827h8ONHPt+B9hkwVOOcZfPZSkpBoe8M9fdOD0V61pHbad6qQR8CCO9/N1zR2b/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680736; c=relaxed/simple;
	bh=kKf4JZt6I3XN8GxDWBCNA2yGPNMKrdZmAO5WZw31PdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muSdV+X0j5OmDfYb9kNJwkPc69ipldiW7CNm2wONEJvW+DQeeqAaIqMn3Yzy1dYJYi+E2y0RLQ35qL7a59j8j31Lis7tytbGAPjxyCdK2+4nxXAd570HQIZp7Yd3JCSHDE7rgawK3YHNYNZQ48GSMuomfktoH1iQnCixb8Kv684=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmuCi4rB; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmuCi4rB"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8804b59404aso1900176b3a.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790680734; cv=none;
        d=google.com; s=arc-20260327;
        b=CyFh6H5BwHLjgaORUG2w3VegYV18myvdvCCoKgqCnhQB8+L/hyRegPYzVNbaMETeUc
         2mX8FZIlnx+VyxEe86rYb+YJ6mJ8xsoG68EsQCIbJZLcF4Qrg/Dnto4nNsywo52lS5eV
         UbDHqdKMFeVN0HvOFskl6LyUAOV+PZpRTJo1Oj+3eRR9JN9DAzs6XLFIcbGOSDqQccG/
         UmKawQrXw72tuNcAoC6vM1E7sz5NpXeBiGbzewJs2XJmn2Dhj4+Xft+9aPw03YpflYZ+
         V76ZPXagDB39jcZGQqyeT7AZwmNcvw0sUkhMWNEP3fmx894QBq9U8S12fi+/P5rSD7JO
         JYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WT0JwGEoE5IU7+NGhtZ/wEPmQ2MkX8rCLjBjEe91iVI=;
        fh=BZRgnIxZwFgOmdrErMgURulqrcE+WglDc8Buq8qKmE0=;
        b=WKudSdwwojcyhL+1IbYVycWYyDJYYnJQmeMFehs6c29uihTx08IZKSRhz9PRve08IR
         idHFvrVOhEGUZfUt9CqUXnzdQyMt+quPCdapoCcXJfX5p2qhTovaEznBKk114RNRAzHz
         yQzWmDKajJnwf5USb6EpFYHtiLdqc6ICm2wBe2Z0po6FPGxy7AgBIkXwoq2XtiC66JqP
         7WeKiwP2J7TT3IftGJmmAEE8wIpN+QsgeOjxSL5oOx6cMlvn63ibsef7ivLtdbBFmtsB
         ZhSr7GA24qlawuBGNODRPqDWdrethyx+HuC3ejcHpN6pZYc2JZjzRHXoHqpIe2RZnbQ0
         DX7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790680734; x=1791285534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WT0JwGEoE5IU7+NGhtZ/wEPmQ2MkX8rCLjBjEe91iVI=;
        b=GmuCi4rB+dpn6dhoXsDysG8xOCXgEy8L2Mwpb1v/KFgODfOIVvoAqMTrp6r78Chx6y
         cI95ZedihlMQsiYoi9UuT7ANVEHgrTDUJ/sj3YlQWrBS53ho88k7RElFudDmWKf0Jjny
         2eAC3WTVtGIjkCxIEZMAiAPpv7QVDf1cTLZ9cvMNl9a0ByDHh8wVDCvX38/sgq/uk7za
         F1pKhxuJXMxNQT/xLPRYiKU1AgAFx+QkSGVm0+JaulXsaHtLsNu1RgBkdZgNAXMl5s4L
         h/U3WERXsVXnOBrOCpWIsB3c5OANO3iG+qRxi80KRFcnxamRr07jT1TSpqj/wZnkUZPN
         VRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790680734; x=1791285534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT0JwGEoE5IU7+NGhtZ/wEPmQ2MkX8rCLjBjEe91iVI=;
        b=KhY6PBPIHPQv9GWWAjPpqTbrXL49kENUbXkKST8juYzx00fnu/CCwSPBjnSI3xKmi2
         VFd5qYm9dQ87JKnyhquRlloA/a94qCB9byYGv0jCQ4iDl3J7uiqQGQanp/jyHJLQNH2t
         jtplN2xwdKzW5iyReOvAMmDZX9M1SD87FF7wry5YOpyiQIXU1bQcGtnzrrHBHdJT1kK+
         5mTMfLm2rrUumjuO5Ji59cB5VUbuA7EmHkdsniwsfBPtm86TGNec4/kzJIUESDq/hDCp
         a7jMGAkxIdCDWZ3CzVYUfj8560SkiAElFNI5dLJ5NyX8nH8Q7R1T+g7MWR92D1zqRL4I
         b8EA==
X-Forwarded-Encrypted: i=1; AKwUvBz0ojPi6RUWmMgSQt2EUeVcBaYnOoR+R4BPg3cbyXvZwW/QI0E2N8ATq6eAN6VaUxBWEaI=@vger.kernel.org
X-Gm-Message-State: AFuF++nFYyCxOfmFN9dv3bzj6yI9qBF4XBu12QZXY1uw/s7tkauDs0Rn
	oSGBQ5lsOcXQFPE/nYcpaqZ5w/cmqrlKMQnuQI8zFxZH7WM0qMQ2+iUJcJBIaCFZD4699XFv7TC
	Bljx9d56leSbcwY5gFJtxtZKX3iGyuOI=
X-Gm-Gg: AYBFou3kEZOKDL2R8+1F2zjc5WTmo8hn2OJp2n2zZUZ3UiAgpfe19LKgDxWZ8YNWJHP
	4ECZZqHm6p6UdjKhVXMintXoXMpEmKw6uYVm5HwesmiGnqgJ+rzE/e+6nG91re/Ln4oFmd18CnH
	rfJi6cWFRzhKnDLDa7Jer8h0uItwYrR3JtHh3nG4Nww7ZKygmRhynXn9SBpqLB3RshlcQZOrnao
	kB2xc9G2wTP2wwND1LWuct8E7/2OaiSZ+7CvcjNYLkeV3UuUHFYjo+yu/dg5EFSK4mNG3y2i+8H
	9pTKEZwtKQSZL326rL4in+POjeN8MUEhKb6KUHOVM2m2tkjxSOEjSzLBm30+Mil2zTrVJvNVoAa
	kVl33hy5vkOUdJTk/G4FubHg8oM25Z4p0yEjDguC5KFxCUMDe4cLdRzHm/21EBiL+lFCXswO25b
	zG/8GSqaaO
X-Received: by 2002:a05:6a00:2d99:b0:874:708d:b61f with SMTP id
 d2e1a72fcca58-87e9b69f768mr12135938b3a.29.1790680734143; Tue, 29 Sep 2026
 04:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <9a6bfc3c-8759-4fbe-9e90-5dec9d00e278@app.fastmail.com> <CAHwyqnVf_D3qV1OVYiCnLz2tVteRXdWYTGBaNTJpkVtDwCC1vg@mail.gmail.com>
 <d4fd92ea-b1c5-4528-9e9e-0b1ab600891e@app.fastmail.com>
In-Reply-To: <d4fd92ea-b1c5-4528-9e9e-0b1ab600891e@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 07:18:43 -0400
X-Gm-Features: AclHuK9ij_I9KcXHu2YV08ELZ21j0aJSQr8HXs8vR5MqFErjLK5fWPbLfVsjl_A
Message-ID: <CALnO6CBq5Udc1rbk6efRj1q5pJNUDt-uvmSGDDen=CMH0dFOHQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org, 
	GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 4:17=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Sep 29, 2026, at 09:52, Harald Nordgren wrote:
> > On Tue, Sep 29, 2026 at 9:47=E2=80=AFAM Kristoffer Haugsbakk
> > <kristofferhaugsbakk@fastmail.com> wrote:
> >>
> >> On Tue, Sep 29, 2026, at 09:30, Harald Nordgren via GitGitGadget wrote=
:
> >> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >> >
> >> > Branches merged on GitHub with "Squash and merge" or "Rebase and
> >> > merge" are never deleted by "git branch --delete-merged". The upstre=
am
> >> > holds a rewritten copy of their work, so their tips are not reachabl=
e
> >> > from it and they look unmerged forever.
> >>
> >> An example closer to git(1)=E2=80=99s home:
> >>
> >>     git merge --squash
> >>     git commit
> >
> > True. But likely it opens up the question of _why_ would anyone on
> > upstream be doing such destructive actions? Well, then the answer is
> > of course that millions of users (including) me do that via GitHub all
> > the time.
> >
> > Maybe I should include both examples in my text.
>
> My *guess* is that `git merge --squash` inspired the forge squashes.
> But the forges popularized it.
>
> The apparent `git merge --squash` approach of using `git log` for
> concatenating the commit messages isn=E2=80=99t that nice in my opinion. =
So I
> wonder how much it is used.

The same behavior is present in GitHub's default squash merge message,
and almost no one I work with bothers to edit it.

It's really sad to lose the opportunity to have good commit messages
when using squash-and-merge on a forge---not because we *cannot*, but
because the defaults do not *encourage* it (and we all know how
defaults affect user behavior!).

Anyway, see https://benknoble.github.io/blog/2024/08/02/github-squash/
for a distillation of my thoughts from working around folks that
squash carelessly.

So, anecdotally: it is used widely due to defaults. Blech.

--=20
D. Ben Knoble
