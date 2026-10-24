Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792853570;
	b=OONffYb78l4GCH0LhwFlvAk9A3meNh3Rdf3QGbVhyeUga6RS1Zs8b9zufOUS52lWZfj+
	 auKjQRwDM6Wp0Na5yfM/WSoWbkN4JmTxAv+8cOl9AEg0fzME4VrJObo+w0EDoZQLQwOba
	 bSZ5V5nsZDH1ovRx5ghzoHTN7k1B16xOAkEUFsmMjl4U6XmuQa2v6pMFj6BJ5Ot/VoGgP
	 guLYVRZ6aapeLMVF8Gx25b9qXqUGa2MJM7+e1frnOLrCX05kJZH5Lysz5JsuKc/0Q74v6
	 APLfvwSdM7URI5KftnD2jtyILK6tJc1q7ag44Cdhzv95dpItS5Qf5ib2R+I6OMdHQ8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xsEkPBR+/+Unxj6SO2dRRf+1c4kWZr2d0wWr9S3v0YU=;
	b=ZU/uD8LQYRv39ljkp4QY3Pyy+afSbJpPENzRiKVfxhcvoN4jO+3uWDwt0wQmqjBjomlr
	 E8og+uUSOTdWfM6A5HpRcMMBAx2vafExiRelc+2urp5V+AomtBADxxUQCtyBqvvNYB9Ph
	 mS9hnDDrIMvFoF1KVuxyyWg9ixgKXGPpjL9uRJrZy37cP/eiSH4aZfBD1IKQvRVC5Fent
	 iR1apMNxtltSOZHG1M779PG/5iMz1WFsm+J3CV8HUHeXFc1WvbzRCDOpxJuSjfeQNNJ22
	 1k3e2LgHnr7pjsg3udenNzwMesxalXjN696NOLnScutDa4Bb0xh+rIom5rcrUzJ0PVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="X8R8/1jH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BC606A31F
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 14:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43BC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8R8/1jH
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c34bff61551so242849366b.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 07:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792853568; cv=none;
        d=google.com; s=arc-20260327;
        b=CiBSlPO2NBwVwBXAuAdUtNHMV/CZG/SuiZ/P49QiAGEwhoYLZPaj8FAZScKRAt1Adh
         M0oGF6v5hFNv2b6/I/it+sNyY6NCeRMC4g7tkRGihu7Zsr/QkmafO7vvoEi+zNypRhXS
         8VWnYCeNumUrf6RpWH/C6er75ZWsjcGBjWUZbTO1gjWeb/Qy94luqYFVQnADVARRMTc8
         fTtb7BNdSZlECm5OhVUo65dpKW3L4loIU2KRGyTsgDQ/mY3jSbIiGHXQhmPwIYjC0LSG
         sLp/Qhfte9Sd91U/8qpVkGeU0e2hGitPViydQCHU03vIO4x6pv7AZ7bnezhdHVe/aa0Y
         BehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xsEkPBR+/+Unxj6SO2dRRf+1c4kWZr2d0wWr9S3v0YU=;
        fh=/Wb7kEQ28gqYgTv1Mb3ssfHumkkce2cCfqhdb3lrnqY=;
        b=me5AwrVB39Hj6umEl5NlkpP7tzLlsLrjT+ZHxizJC7t6yksPh4TToXm6W+eBiBlS/E
         tECwYrDzphGvbS+hLYdRWpMprk6axPU0TGII+BB1LJ5/ynMVym+WMepUoOMgYg+EMF0P
         TLmcSDT213CWylweSM/upaSkc6Q6tsGCJmhPqwmvqLXAlT/IWqrKmNWcvUxtCQu0ax5i
         s13ntpry9gx+tVEWTcYvoBcogKrKdDe9vQPFJu7SGqa7ApZxdgAI81A2EqAFuKKYZZz8
         JkL9X8wfHrKSGnHJkxLP6h3flW+dY0URmQN5irk7j6FUt3UR10fqrAnXEb5RmmFobScz
         1e1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792853568; x=1793458368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xsEkPBR+/+Unxj6SO2dRRf+1c4kWZr2d0wWr9S3v0YU=;
        b=X8R8/1jH3LfNC+2Pvaean6bjnfDVCdb4f3CapR5x1D9SsXVkjooKc++1on4QXKYcQ/
         Rw14Rse6++kTslg9hgD+8glamEv7leD0C83Xo71BpQpGTv4rg4G9/3libkZH4MpRYY7s
         xB2o9tJ/I8f8Q5f40zYkQ9dxB9ZAj6eutRYNlA8JWKyk00IPWa7p0o58W+b/9/UjB0qC
         Atd8mcgCUT7ugPJ2b88oBira6jUxDX1w8fLxr0/bDAGipmIYlKzEuNtBehupzM+3fuYC
         7QgDrlyTCitAG48PGea5Jpw7VfJLAjElSh74pskPVAohheCH1KdE5gHsanqgl/9loi43
         Q6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792853568; x=1793458368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsEkPBR+/+Unxj6SO2dRRf+1c4kWZr2d0wWr9S3v0YU=;
        b=FZTFZ4hBhLtqaNSv2GfRQMCo/Qol5xdFgVXlX4/+McRm9jRuiuzyC8t99g0yJNPN0f
         dFIxU7V38QhvsXysuXSo+/CjbfemdHzVAOR+54iPOghXMT5uVII4mohqFRjEnGNWQNp3
         K8iUz8YTGzZMP10QV+M1LdkeQV7ccjLrYR8/Y3VhqHO713BYiyLhuQTmC3jpOD1m121b
         w3uPAnbLAYZIkGmns8VRLhN+v0qYD4btv/J1GKdwLpL/nCIJoZ/zY+30er3q6o+qDLAN
         COjEnIdLj2sDhdTj85e9/Jl+HSbEE6RLhnFoJjIV+9RLwwCNlxSIiPSOLrKoHJVp/4Tf
         1KXA==
X-Forwarded-Encrypted: i=1; AKwUvBydm5ODeN7ToUGRdbUhymeLAyyUdjdGMAT93v6Mh94bXR0oFnmBFSTdxFODmbh1X68f+j8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7NgUqQzqn+nyIsGNdSdZuDqf9NmDFpURXwmSRho1CeHxW63hK
	lDikC6iC6w3FKzcXdQBEQdg1cRglqWAID1EC0hEWppe187QAI9esuWx5DUnIEp+yr8gb4v1HpzI
	IX166u4seJ3o6XyRktEglkQ0xFIFdXNQ=
X-Gm-Gg: AYBFou0viow/azV8FuvM1sq4s7lIDDMjbuUiaaNRuPqMvMHPSAoxmzHHYGiUrCUwgqk
	1Cj+Ob26pzo61jqwqxMWigcmcaczy417cMP0AMFpuWhpM0ZV4nxvLpcwngXEGg4UEXa+g1MiABT
	Y/OQbM75Y/PHLdZdJRx8Y0GDWXg+UqgDB4JYRvvXEP0jc2YDPWfQanh6T+ZCldjir9wmEOako5z
	W/8/H9P1zZOixiTSEBEy/K8nqePIRJkIoHnaB29cJQNsVjR3Vc8ebLXaVSTQYeZ3hfj5imZWN/b
	C5MlqkqVM6+9EexrRCNFby2GYZb5TK9i8Lbrv+64NhuYMZYVXHSXqVSdRcT3xG4EwBxzKvLAEzu
	iXRw6nBvog3QZVNecCVIM1k9TyRsyLWut4ZFN6oYF8cF5adzH5xbjNus7QB3tCpjDGSmf
X-Received: by 2002:a17:907:6091:b0:c2e:350b:7220 with SMTP id
 a640c23a62f3a-c46bddf632bmr247572666b.9.1792853567878; Sat, 24 Oct 2026
 07:52:47 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
 <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
 <CAHwyqnWi3MCvAw-sNrn6k3ht1tpUfmNg18BAvEThKthen5Dwmw@mail.gmail.com> <CALnO6CAxzo5gxpWkfjtvskTVjmWWD4oFE2QKyFMMo7JZUCkBmg@mail.gmail.com>
In-Reply-To: <CALnO6CAxzo5gxpWkfjtvskTVjmWWD4oFE2QKyFMMo7JZUCkBmg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 16:52:11 +0200
X-Gm-Features: AclHuK-cFcsoatPMQqIVrzIwyx1GKpkkysaRJAacWUoleiYQN-wnsvBuvVgEKIc
Message-ID: <CAHwyqnVV86Satk=_on=oG6ZVnSF5GdUWmpP0_wE74HRKGpKfSg@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > I would say most workflows are triangular on the underlying level,
> > even if the developer is not aware of it. If you work with GitHub PRs
> > or GitLab's MR, then you are engaging in a triangular workflow.
> >
> > I picked up some important tricks for visualizing the triangular on
> > this mailing list. But most of our users are not on the mailing list.
>
> Yep. Maybe I'll start writing a "triangular workflow" document =C3=A0 la
> Julia's work=E2=80=A6 going on the todo list, at any rate.

That would be cool!

> > But what we can and should do is to make git itself clearer, so they
> > have a chance of intuiting it. I think for example that
> >
> >     push.default=3Dcurrent
> >
> > should likely be the default.
>
> IIUC, the last change in this area was controversial. I worry that
> changes here now would have to get through "scar tissue" (both of Git
> contributors *and* users). At any rate, it would probably want to be a
> major version release, and I understand it's probably too late to
> discuss flipping that in 3.0?

Would be interesting to switch to "current" as default for 3.0.

But I don't know all the history there. "Simple" does feel like a
compromise in that it's not really good for anyone :)

> > And many people would have a better time with
> >
> >     branch.autosetupmerge=3Dinherit
> >
> > which gives you upstream/master as @{u} from the beginning, and then
> > you likely never abandon that if you are a regular GitHub user.
>
> Hm. Since I mostly do
>
>     git switch -c topic origin

Me too (or it least I used to before I started experimenting with
inherit) although for currying purposes I always spell it

    git switch origin -c topic

since I want to have the most variable part last, so e.g. "git sw..."
auto-completes by pressing the up key in zsh to give me almost the
right thing and I can just erase and re-fill the last part of the
command. (This whole paragraph is a complete side-note.)

> or similar, I'm ok with the default (=3Dtrue). With inherit, the primary
> help is to folks who do
>
>     git switch -c topic main
>
> or something, right? But the documentation doesn't say what happens
> when inherit is used with a remote-tracking branch as a starting point
> (which has no upstream to copy from).

It's simpler than that, since you can skip the "main" part, which by
the way I don't think is well understood by regular users.

This is the beautiful part: since you start with a good upstream when
cloning (origin/main) you never need to leave it, *and* you never need
to even specify it when branching throughout the lifecycle of the
repo.


Harald
