Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84B274B5C
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966180; cv=pass; b=MuqQzkbznnjDQXrxy4Bv7i1QisdyBMJI05DIc8P/xZMBNIABh6vQUcL+YIw/Cw1Ge0sydnEXP/1XpUYpMldZMzIT6q2hwn927DI6pxhrciBZCU1qu6et1BEP/0tgoQHyrkQq48rzfqCAzI13+Z4JZJOjP9ZBMNtK9RGUPgTashA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966180; c=relaxed/simple;
	bh=dziWu7sqC+HFbZFv9y5Ddp4Hc84sI72mmUVqbyI1OXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnvHKnZM22cuGelZG11acvAcj8oS4YVNXXC8ScISYzVKA2dageNLSIF/Q/kKOCvSnswoLBPvCIdAw10atLqKa//C3WDe59/8dT7oHMK1IAZoJ386c7o3zboyBDxMrBZShHJ/aeb/Ro6lpB+QQfKx4caYpbr4oM/GfRtQQGliBUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMjM80Ne; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMjM80Ne"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso5648946a12.0
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 09:16:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769966177; cv=none;
        d=google.com; s=arc-20240605;
        b=Tr1BQErkoNG/FTG/ekdPxdLu+ml9IqriE4iLkC1iv6bnsoG0wggP6xMHEo0mgqFod/
         XW84O1Qiy2G/P+I2qXSwDDGi1G/kxE3oX5VzUkfKphDDDdRTaxbKHeVdqw6JITmkZXtO
         eQzEdMVwXr9J3ST3jniAsd/JW0exBLpzcouZb8z1GDhCONsB/f48pMwonXUF2SQlYCUx
         oVk1EmWHLHRxK8leFPffKlkhSdZvqd5qYeztMHBxVaOn+EarlfgI8+wUBCXvahTQbLPy
         dO3LDeTRlYbKJaS4q6qxwMvIrdriMdjgAHo25x9zVbvOrXTwXWqPYDQou07kBrC3S8Sy
         vHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dziWu7sqC+HFbZFv9y5Ddp4Hc84sI72mmUVqbyI1OXM=;
        fh=kikuiWm6vlYYtZPyiCkN/c/KXzEet/LzM1OON7IFHHc=;
        b=FmfJmyXE/Wr5FriX7QZcv7RNvzRPInXFEJYI1PRKnokmpkooAQUEVs///4kNsISe6u
         dwGgmdfmZ0n21FzrgbKtYdaZuO4Ums3uSKSJhVygmFcr9HMdEpsfMv98/vPjfN8olf/2
         cXDT4qJHDD0Ekx/jMYs8b9/Pat6cIZ25+qIEKR6ld3zjLFWamVtrt/eyYkra2Fr2yRqN
         BmJprZesqEpdJus+IJKn1jW6gKTMMgrsvuEYB1TwuNsV3dZovUgT1uflwuvuc+FK45m8
         Jv9GUln2nmtCp4lupiPBrxoIvVL7ushDGKVfuPhIjry7US7aEMMJRnZ1bsVCVdq3hCz9
         cjNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769966177; x=1770570977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dziWu7sqC+HFbZFv9y5Ddp4Hc84sI72mmUVqbyI1OXM=;
        b=hMjM80NeHMPyR9UIR4V9M6pc67K4qnzN+ScGMxYUWs1I3+jMhDYJzvr42zX0PuA1Kr
         bHXrwfU8lbJ3y4xqHrYujXWV6FErH9r4WnlHS3zlzZoEZhZS2k5YeJFoUVzXCSxaWwR3
         L8ENIOC47PjyUmFa5cjlYjoiU/k0zaFUqJRAPy0hAP9ocyTbU0yAzkvakKrpWTRvwK6x
         SbpMSj3bYwTYVAxdkQ/SwAUvTtNtVfxb6G/mYZDm/NtrZ0rfUPnQy5WDvriaLELGAAUc
         9YhY5+7g46Gmmx1uKR8H2+ozl/eg4W2rzjRbag7IUkZwx7yFvxXiCKfwos485JTWO2mu
         2cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769966177; x=1770570977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dziWu7sqC+HFbZFv9y5Ddp4Hc84sI72mmUVqbyI1OXM=;
        b=nM4/ygtMXmxhhXIwAGemjYtcknv/1RuLgirYcqWFnT9zZqZ9eFhw8Da/md/FRw1Iuu
         lKYYdLIuTBnXWEZ1wPbJpWb4FHhzyR4T3Kr4AgXXTYJZSRkHEX7OlUZWom09XH9dsum2
         sOv8TsFKPNWlwBz2Oe5u3oKgiiiaMlkkXZ3/U5NZlOwDFFE0KlWApU/D7HxsFMMkIxQ+
         Spj7FCdnpKd/LMNtwoF++BpsV2R4k/8hcvM8vd1sNE1pqdFTUgE0mm3clyKQJEQAG8jh
         hTgo3GV2JjVyMBmAeXIr5GniFqJwK5dhjHOdzQ58RePCuLC6UekhxBu79tgvqq9sV9z3
         UvJA==
X-Gm-Message-State: AOJu0YwGnCEdFVI5p/lbrW+meeRF/W/mEnH7O3/5OmLbtueMLgcnEbPj
	TNs4n1LM6bBJ6+X4fVN52QVKfhsqqngr1lfM8WC/Fh4Vcye5W4sfur8JGPMEKMdCGRDf+EWZZ0v
	btfDsy76FATQBxu9LfUHEjp2HegKDO7U=
X-Gm-Gg: AZuq6aKW+UVPQoRRDJhL+n8sUqhwOjJk8rJUZ+dmRLGc5WuVcTaYRTU0/5oZAdzm4SS
	Pppc51EJYgI3UbXqzdKKmbkmh421KnxnHFSpMuNl7wzITsxk0yKhU4jsvHueTRJArFRRrKNpmEU
	0VOa4MCVFYfjSJxo74IdI1DBCcvX0VzOTPx1vUEGzxCykU+XyuG+8sWI7UZ1oAK5L/9K2e/uPdQ
	YQjGmbqbJoFBD9WglrZ5Gt3DJS4YggmTHdmtppQdlCCXPusImJ1uWuRpEpfVM2vBi+PiqmcN90W
	bOIRkvcqvyYFxJhD40wiEsClD98A0G0hsXUS5pjmb7oDB/QxQIZkmtuw6XeIai0WI1VD3I36UUS
	qaNoUjyOc8VQxFVPsw/7aTI98
X-Received: by 2002:a17:906:9f91:b0:b87:39d:2bb4 with SMTP id
 a640c23a62f3a-b8dff881933mr595385466b.59.1769966177151; Sun, 01 Feb 2026
 09:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG7UgERzxKzaqAS1upF6G7NHneoDNbfQYkpyAsGRBGXtdmVOxA@mail.gmail.com>
 <CAPHqhPn0e2Ccf1tF3JokkEqi=ciGiGwG+GhTabDE+KB4b+FGpA@mail.gmail.com>
In-Reply-To: <CAPHqhPn0e2Ccf1tF3JokkEqi=ciGiGwG+GhTabDE+KB4b+FGpA@mail.gmail.com>
From: soutrik das <valusoutrik@gmail.com>
Date: Sun, 1 Feb 2026 22:46:05 +0530
X-Gm-Features: AZwV_QiSjvYsUhEQeNI_wCW4bd783naB3e961gTZ_E-f2G-xdtjXVucvQfwkL2I
Message-ID: <CAPHqhPkuCLS4nndNe+2Hib_Jipb06t+mSFMiON77RHMDxPY31g@mail.gmail.com>
Subject: Re: [Newcomer] [GSOC 2026] Introduction
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you greatly for the direction. I did check the microproject
page, and the first contribution page. I haven't fully gotten all of
it , but I am making progress.Right now I am trying to understand the
first git commit's code by following this :
https://www.freecodecamp.org/news/boost-programming-skills-read-git-code/
, ie the initial 10 files. And from the microproject ideas of Gsoc
2025 :

Add more builtin patterns for userdiff

The idea stood out to me , since we are being taught regex in our nlp
class. But I wanted to ask, is this even open ? like are there builtin
patterns to be made for any languages or has all of them been covered
? or is this idea being worked by someone else, I checked the mailing
list but ... I am not that familiar and so many results had builtins
in them, I didn't really get an idea if this was being worked on or
not.

( Sorry for the double mail, i forgot to add git mailing list in the cc )

On Sun, Feb 1, 2026 at 10:40=E2=80=AFPM soutrik das <valusoutrik@gmail.com>=
 wrote:
>
> Thank you greatly for the direction. I did check the microproject
> page, and the first contribution page. I haven't fully gotten all of
> it , but I am making progress.Right now I am trying to understand the
> first git commit's code by following this :
> https://www.freecodecamp.org/news/boost-programming-skills-read-git-code/
> , ie the initial 10 files. And from the microproject ideas of Gsoc
> 2025 :
>
> Add more builtin patterns for userdiff
>
> The idea stood out to me , since we are being taught regex in our nlp
> class. But I wanted to ask, is this even open ? like are there builtin
> patterns to be made for any languages or has all of them been covered
> ? or is this idea being worked by someone else, I checked the mailing
> list but ... I am not that familiar and so many results had builtins
> in them, I didn't really get an idea if this was being worked on or
> not.
>
>
>
>
>
> On Sun, Feb 1, 2026 at 7:31=E2=80=AFPM Deveshi Dwivedi <deveshigurgaon@gm=
ail.com> wrote:
> >
> > Hi Soutrik, welcome to the community!
> >
> > Completing a small microproject before applying to GSoC is strongly
> > recommended, as it helps you get familiar with Git's codebase and
> > contribution workflow.
> >
> > You can pick a task from the microprojects list here:
> > https://git.github.io/SoC-2025-Microprojects/
> > If you are unsure how to begin, searching the mailing list archives
> > for the microproject's keywords can be very helpful. You will find
> > similar patches and discussions to reference.
> >
> > Also, these guides are useful before sending your first patch:
> > https://git.github.io/General-Microproject-Information/
> > https://git-scm.com/docs/MyFirstContribution
> >
> > Best,
> > Deveshi
