Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EE4ADD90
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025152; cv=pass; b=M3A59wfMvK9qoVjYJluUR9I2u6VoPSmtjF1EPjiMtxE1Cr8Yzd6ekFOmibsxlIlY6byzOgPkvVfN9wDdADklSuRKYKnXMfY3W3/GUqrEZZKl8zAtViOFTtz8m5vcjAwm/YE8pQP5eNqGlTjIFoeyLh9pLHpK19QUZoz2wxIODh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025152; c=relaxed/simple;
	bh=mEBlybAC/4E3VZATHwyuh5dPKfa1M71McXBrhwmTLuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaVrVFiloUmGnvggG4L7lqWWcVt4mZOgBF3yJhID3cxUm+lhfV8vzvhZJYbruJzgf6ZBlySwnN3+gCfCu0UstaWHNFq93HRifyoMgIUAHa+r/4KuAax0sVoPn/CXbnFiedsgEr4JEEF4MAQ6HcHZbdfLvtB1edTvAc2MzHgrPqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SByc3lqG; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SByc3lqG"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6611669cd16so3346700d50.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 10:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025148; cv=none;
        d=google.com; s=arc-20240605;
        b=F/PHrtzbhTKqyCvA6r5Wu2SmuT5LfazBDw03Agl3JPgi36a7lwLEft8mn93mydd4jB
         lgpQqIb0DYXAgVe6+T6mE6Ek2m0lKdK+WLKDb2YOokjXZOgc3oCrwLNTw4Y4QhnilSYq
         ZlIfz+3kEFKZiq5HsQkyRvfdyAVx6p9E6skAQ1hmNQE4P01Feu7fsahD37ny4VCVBdn2
         EkJwhZq6hIRINwx9Z49QkLg0LYmvMOyVdv2gxSPICAukSGkNF/JXf71YDHZyeyVkcwPc
         tnxf2NF4S6ufmMQnzWw0SBpjbNRsJwSWY6RIO8A43xDGctPs49qSEeEMMIAXraf2+Vam
         zXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ud+Y38jUnB09uwYjDdG+R3Jr16dvcjily0rZLvTrXZQ=;
        fh=NiZXQXm7NXgXE6CrjAMqUjtbDpueHeh0V9rm7ssVZcw=;
        b=I7/rJ7U/7enWcOYZf+X8rgINuqi2Mp6rVtuXpUxmoDe3AvtMWZRsxntlxAPJFQ+nBs
         P6qoU5Gb+Pi6n//IDOV5NGjH8NAcp51NS6GcPwn0jIm0AeTyzJlfM2qpBG8uOqPKwcKm
         yIgxaPa50DeMXCu24JhDm/ha9oOjQT/lcindkwHQ6WO3aikLw8irmEV/4mly38UFWM95
         Fc1+M+mmZhB3dvrxxNmRs+CBPO5g6B5+/A2iTxTOb0YnCXaMrPE8vD5qowOZYAxN4dim
         ynCztGCClEh3bpJeBTdx/1Ttx280NE+NGH3hpIYg1XJb/TbzFzlurccEolEGRhuoHvlc
         /jeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025148; x=1781629948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud+Y38jUnB09uwYjDdG+R3Jr16dvcjily0rZLvTrXZQ=;
        b=SByc3lqG/7yA9CBVFzYL6UAaC2wesVBjWkRFKQX+SsQWiUEDjpnKhWuEgeTQXHy2Z6
         AU8AkB3+5DxvnPp+kbtrwqoCPgh+x+4b3Eayc/RK+m8hd3hEnO6mpy+bcNvMFHyZFyUg
         H/wOgeVqzTlXSTWFbUli5tMV9XKZb9jJ+9jlbDoyr4NHxByriowZn2noH2T15BNO0zti
         hSbCHc6sDVlRExXPujU1Zjr+ZEOG/4GGX64GlEFk33/xjsjxy/jX0+rYyOXNTjQK5F+y
         F0ZQTg6SC/GduBZ0edjJKEZzwbqk5cmZegweRV0sQbeAEx6EUX5dUZDkpS6ffmpDXh9u
         XAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025148; x=1781629948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ud+Y38jUnB09uwYjDdG+R3Jr16dvcjily0rZLvTrXZQ=;
        b=c6nUhZe9rvy82ZOCxVJ8N5XAfE2LE+HN4O7dpLpqgVnpeC2pJg2Ey41XTjvwnQRty7
         avUV3/Kpt5TFvKfQOMvSh/rG9sXk7yOQeGY80MokYiiVMMSjsvNCvqOEER/CnZzUdZIg
         iARaavM+drJkQHjzDvqD6t6k5ivp0csEa1owLzaqlef2tUl3ZjUm57rYi/6tdyIeVf7Z
         cN2OARhRDWADBY08dGF0qN2xhda0+dB5RICsALisNI0UnpNlseIFfSv3hc85PW6oF9tV
         rpaGi1e+YR/O/GflRH82nLi0GcUgaq0pK2u5F5IxPCwPKyEfrv+gtA2a4C6nRJdu8/Wr
         smYw==
X-Forwarded-Encrypted: i=1; AFNElJ9YLd/h5ssVj0Q1SFjsCSax23UqDfdXJpolU6F6hMMhkNjbnQ60HY8g/pIFB4w1oktr2gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK1WmYqsIE/1pVXjhCgo4NZKlrb93c5DkVexcuHS1MEbGDkOd
	4PKAujcoG0nYlFHS0i5j1KiKJDWo6BitgJb6wF6xC3tIaF3htWcA2tlV8I6fdPeCHKPr+PLiZBv
	xwpn2n2PIVIUMfnh9GdCCbzDZ1EIMLjc=
X-Gm-Gg: Acq92OHgFYiTxgx4zhOrGUqQu9qL3VTm4xsPDTokW6p3+oDoed5vRkEFjj4c3mdZyEP
	bycOvRVlZefu++/6JlC/tFhgQHRaOX5gjsMif0YRsuczXCsDajhVDLvEuOzxo+m9fCjTP7FO/d5
	osBPb+xSZjXNsPVBaBU29w51RVbJIuXNw5BTe8VUXnndx99N476QAcqtlqf3gaSDLLaOdaKQSkG
	zTAKFlenGo5CyT5dd1TceQe0Fq/fiGLdPpjDrMAA9B9LY2ex5JIEeKymyGQCxY8yDcODVSkeRT2
	YNaSUfouJuoE9E0sLuQBx/IC8oIhbw+W1gWcAiOOSpDmuJ3sdfkBYgb5l62evssVAX+/HY/MMaR
	s8O53fw6bGb7fIH0A+wpbDxPew1cyQGX9v2qtC7ze0FXtLxeIthMrzpclbK9kDW+Zf2HjhbVvjp
	yBzZSTB/NIqKjJ2wtEfgxPIiM=
X-Received: by 2002:a53:ac8c:0:b0:65e:1bf6:1386 with SMTP id
 956f58d0204a3-66106e4dbd5mr18590293d50.17.1781025148023; Tue, 09 Jun 2026
 10:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com> <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com> <xmqq4ijbsn2m.fsf@gitster.g>
In-Reply-To: <xmqq4ijbsn2m.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 19:12:17 +0200
X-Gm-Features: AVVi8CfmmoJnPgHQYwPavlGhvA9FnEpn3uxHgxg2f0fT9HCevcRbF3Ru3bkMjlM
Message-ID: <CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, cat@malon.dev, 
	ps@pks.im, kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 9 jun 2026 a las 18:20, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Pablo
> >
> > On 09/06/2026 11:42, Pablo Sabater wrote:
> >>   static int commit_tree_ext(struct repository *repo,
> >> @@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *rep=
o,
> >>                                        original_body, action, &commit_=
message);
> >>              if (ret < 0)
> >>                      goto out;
> >> +
> >> +            if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
> >> +                !strcmp(original_body, commit_message.buf)) {
> >> +                    fprintf(stderr, _("Message unchanged, aborting re=
word.\n"));
> >> +                    ret =3D 1;
> >> +                    goto out;
> >> +            }
> >
> > I wonder if we should check that the committer identity is unchanged as
> > well in case anyone is using this to fix commits after committing with
> > the wrong identity.

I think that if you reword a commit committed by someone else but end
up with no changes I want it to be kept as it was.

> >
> > Aborting when the message and committer identity are unchanged seems
> > like a good idea.
>
> I am not sure why it would be a good idea.  The user wanted to make
> the commit have this message, and the commit ended up having the
> same message as the user gave.  That message may have been identical
> to what the commit originally had, or it may be different.  Why is
> the former an abort-worthy event?  A simple note, I may understand,
> but aborting with an error message?

With what you said at [1], having this in an
"--avoid-unnecessary-rewrite" I think that the abort might be too much
as with the flag the user already expects this to happen and silent
might be better.

By the way, I feel that "--avoid-unnecessary-rewrite" is too long,
could it be something shorter? If not it could be set "-r" as the
short and leave the long as it is.

>
> Thanks.

[1]: https://lore.kernel.org/git/xmqqtsrbsvcm.fsf@gitster.g/

Thanks,
Pablo
