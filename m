Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4E47A873
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117030; cv=pass; b=OKVSA2Y3VDTapuORZBY1Ke1Qd0G+gLeLWLKIf3Kc0h76PW+JlZ0T08yO6p4I/mZj2FHibwH9lf6HGIGz/N4Cs+u2o0cyHGPHQ8dfTP6SO22d/wnt19qnHHW55Z3GJEOaTdfaDVMEhGJ0l0dICl5s5ZY8/TjkSD0T73A/hiY6Z7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117030; c=relaxed/simple;
	bh=B0lrQhGreZbxiDQ4jWab+fvwfWuW4pZsLKYzlM07sjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zz90mc1i62LiJvO5KuyEnl04FFj7fGWlYFGGTVDmYgPnAYncG0qFdQwHoJ2Z3fd8THz9IGH+X4txLGnfIbTZ7EoTZx17sdDDF4dyp9L+UQNnlGr+MtIFHC/QHlP5DKa2AsVWFlytvYdDa3SGotPzkH6AUL5FgrKIWlAlKh8p964=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyzHcego; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyzHcego"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-495b27007d0so2115226b6e.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786117028; cv=none;
        d=google.com; s=arc-20260327;
        b=ZkOsPkR/rz7IXbGE2JPbI1Rxb2S32KbklOdfcMHrqItpI//09gc/eV7nIUIuadUNj5
         cmvHZLzkAPJfJHu2gyTQmOJw7Xna/vcs1XPf2aIReJzWMXlgLLP+4epKK9h9x1kisINm
         flKX3p4l2Q6aVJ0PyCtuN9mUINZTes/TGFunKmeQl025VQiRG5nd+es1y8v4HRDjg7Q/
         FBYWZL0iJCN5xkVQnZvkgyNG/yGM3GGdijtAWp4aXiFHOeKJHRreRVgqOHYESl2NEFEM
         J532tO7Ol22ObaCBvgGoi4d1U18juFnXnW8X7+uoAhAAHc+6vqbIOTpEDqloKZ7c7d+l
         hypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqcZFcbhxY1vI11nYbjvzTeiusXZosHKxh7e6KvVvkg=;
        fh=6kgF6f86q/MaGTxmVt55E+SsQPZ3gwWAPTZHo5+Kcjs=;
        b=ifZESYDGMyzQF63aX3VKbEQg3vVV1+MgIdiiGv4x67erylnLHWZ8pYwib9hS405tDs
         +oVWX8FZQYUukD4tAn3a2VW5Kkbdvfs12GAvLWuATHIyNQJBHPr6TlKAevKDnr1uqoxP
         WO8iCxanI/o9LK7AWGypKjGUxfsfDmst/zPZi1HfOCw+07E5IFHW4RKo8tOyHYsI+Cn1
         d1V0CpRcri1dt0PHksCTzyFirl/gUYPHsVXo27EY93r33xNdu6GaR4IqMDICLXyixH3e
         ER/hLQHBkmhdeCXUD1MaO37lmGcCXTnJr/rmHFdPVu0rJdtazD1uRtrmBr014B7Gp1+C
         f4Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786117028; x=1786721828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqcZFcbhxY1vI11nYbjvzTeiusXZosHKxh7e6KvVvkg=;
        b=SyzHcegouz/1uDEXMuWCPRG7fak1qGd+xUwAN6EUhaOYHBWOzbnwWvWTD7TSSZOQSt
         g7zLogfvBL+z4E8p/w7AuCsbvXjsFFmIAIOpdXCAJlcjb+x40ZNe8qAbYTNnRn63TTdK
         zwNzTsZdBUuj9dKF4hzeaenBAl8nneWpbHXeyEA2KR1Aw2zj1BqbCNiPPpxcN9vkCHIq
         CoPja/+qfuSqgv5MiMeYAORzn5D3r+2yyFJQ9cJ/Kvj4l/0COdl5aTiuH1Y+B7W4O2b6
         YoOwBHKCeXO2s2cx+HtXwE6wrvAeEOdaYXljaXOaiLcJwnNYrkMOv4ODO7rq6aZ0h5zc
         UXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117028; x=1786721828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqcZFcbhxY1vI11nYbjvzTeiusXZosHKxh7e6KvVvkg=;
        b=aHGBHdyrAWIFiZqrIUxSA4PP+KNaW55SYqTb1/aG3NBv0q5uqbgmXQRepUSheaVRZp
         ic3UijrVSIpI3GM1lzLcu46W4fwwVlYfaR75jd+nZ91kUT4c63vPc4ZbOuryoAVf5uLk
         CzxCEm5FtCQtn+1x3LIYZ1IRBfgUGF2Lq9JZMFD1+21CHIaiR8n/8TQZdqaiD1gecIdX
         2ylwYJpDKAveWyDm74Bq/cjy9rpUOuZ87mrQx0w5ey4JO/dc3Im8+W/T6Uozml51E/7L
         X/ehC56sJ2r5n6bTmXmJ0l0CfIQFPEKp8cC1W1ibf0x3I0OrxapvpUYfDX/DsJ5zJtzo
         0V6A==
X-Forwarded-Encrypted: i=1; AHgh+RrBVuwl2M6kxHnuI47Ivc42FyHhs2DVa774MHr28tRuiuy6CEqcUtxPIOXme5IZBrPJt+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzts2okDYSlmwKCVmhcuEdKG9azX7d8ANQEDkg0I3ir9egNdEhR
	eKNzS1RC0VAphCHmleMCjLm59GF2mzDDN+xO+p8soskexROyTegT9PJbE5Ct3H+z4F1p/yW9lsb
	xFMp6oVbB6FH8b/xukMXO6s9OvfU2P2z3Jw==
X-Gm-Gg: AR+sD10kcE8eDX7EBD+rfI12TCGkqI2hXYzOR/8MQySZhtKJ3h7SsiFLtYynVPdPD1C
	jthm5dFuJJx0aTnefaT3DrkNjq/f1+XETo0MlsGZgXnOAaj3+kbhGWAs6i4a7bHGkviZJToAxTy
	SKVH+YXFqUQTLiigq2ozW3HW1Ffg+/1HYuwNao6wIsHClLyY0kWEB0B8iDAOY2wkraVoQY30Wst
	biyP4vbk+1jknzywzqvK7+KibGLjhgGlbHDKz+S6u71j5quoALRABWTXdBtbjz93GvWCEsZf2Pz
	2kxR4YBApzqjEEp8h7EXTmYOB1QOzqynDOpriNElxiVNS6N2CGcbmu6H4sHToWNb0iEVnEbt3NG
	qzxyz1+Tna0zzn2ZHoT2h/Ft/Rd2zk4HldF+h7WEGx495SvhCfCUEB/jiIkklcRE=
X-Received: by 2002:a05:6808:ec2:b0:496:892:c58f with SMTP id
 5614622812f47-4b13317e801mr5057466b6e.2.1786117028223; Fri, 07 Aug 2026
 08:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <f857577e0cedc11f8db614b4ab2bf9217652a312.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BEV=u82AV=bXoHN9N+iNOrBjAig=1FY0sxiQNusrNGUbg@mail.gmail.com> <CAL71e4OZwDzZaE4kfZTcBy8wtdeX2Y8H8XM9x12qH8TaUkVUnw@mail.gmail.com>
In-Reply-To: <CAL71e4OZwDzZaE4kfZTcBy8wtdeX2Y8H8XM9x12qH8TaUkVUnw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Aug 2026 08:36:57 -0700
X-Gm-Features: AUfX_mwOKzX9lIIkgnHXdT-M7kBnS_ktdq_BlxYlECcVpoZtUIZG9dhZS_Y0GII
Message-ID: <CABPp-BEOR2rPVH8Uc446rhAATBUQTX+o3YELeV2jU2isnZwnCQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] t6600: add test cases for side-exhaustion edge cases
To: Kristofer Karlsson <krka@spotify.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 4:33=E2=80=AFAM Kristofer Karlsson <krka@spotify.com=
> wrote:
>
> On Fri, 7 Aug 2026 at 05:01, Elijah Newren <newren@gmail.com> wrote:
> >
> > As the author of these tests, and as my Signed-off-by attests, I can
> > confirm with the full weight of my authority that these tests are
> > good.
> >
> > However, I would be remiss not to note the perfidious destruction of
> > my two spaces after each period, cruelly collapsed down to a mere one.
> > Have you no decency, sir?
> >
> > (Kidding, of course -- I mostly point it out so the next reviewer can
> > appreciate just how little else changed from the original.)
>
> Oops! The irony here is that I tried to be very careful to not
> corrupt your changes and thus the attribution. I was already
> somewhat hesitant to even modify the patch to split out the tests
> from the code changes.
>
> I added my own helper script to check and correct patch series
> and I had snuck in a double-space remover for personal preference
> but I think I will actually get rid of that since there is a slight
> preference (but not enforced) for double-space in this community.
>
> And since I need to reroll _anyway_, I might as well repair this. :)

Heh, I don't think it's worth the effort.  I really was just trying to
throw a joke in there for anyone reading the archives to enjoy, but
the patch is fine either way.
