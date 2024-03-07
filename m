Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7043A8E4
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799768; cv=none; b=gajm8u+dcWDX+YMCsroAONALAf9m7OQbhltnOTwjyAlZNgln3//eSERg3QkRWeCE8X24f7r7afOCDolAM8E2brYCF5uFHqIU1yQJv0WY//MGrmG016R+eso0JjRNSnQM0cMnc6QI6SD40gdAkPWuZGZBVDIFp3vehk/jN1kxjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799768; c=relaxed/simple;
	bh=i+XPtjBLWdB/mUH2+x3uGEkpFmhmTtEke+T3BOgfuGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iidv3/yPN/S7mo2Gy/Q+h7jEuah9Aek3J6S/DSFViEWhxLUoi7EDAK8LcMisBxgZW4W5krEhLNOBEPUsfkqISG4FiARs1lGj8QoazPVh7i77L421nzExPzmrx8dgK78DkHB70wW9+b2ztn1R2TJFhD+y2I2I8M64dHKn7wqdtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+7W3f9V; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+7W3f9V"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso535569e87.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709799765; x=1710404565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEsikK/PMj5YxDZUOtbsrgPiFSyz1UST5o/mRNYq2so=;
        b=d+7W3f9VuwpWKHHTKZ2KrbL9UgRGicw+nwrQoa3+UcqHIzoUyDkBLU1lTYUULynt8f
         Nn/RQamqg+j+GoY+CsgJfXrasjuzLyyj1P9IEAvG5N2RWjxcbuuJY9UloXxlcgxNCaxe
         gf3fGQmmUWgOyWj148pAa12Rx03VlMnl0HbkwDu485vJx4+bgjnWwVJj2R6IxfSTJfVs
         Jxeci9Fd2seqwA800CPyIfh9JQ8Cvq3ZqMypn+8qq3Svibi3AK81bKEKitKbfXIu8no7
         PoH8bAqGaVtcIFnQ+NIflgEBHLmKJyMbhbksL7jrIfw/b0+MHnCZCmGJ76No1KZ4m4BC
         H10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799765; x=1710404565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEsikK/PMj5YxDZUOtbsrgPiFSyz1UST5o/mRNYq2so=;
        b=otC/5IgX7YupeZ9mmWcvOHojhOpbnnIgHT+ETlM1X0nQjg22r5lRmYjN2LMgxSw4k1
         +rWM/o5Ko9Y+lX7vyGrbaR61NyRe8vPxcDBJNteBkDszk/tdRKrqyNZA1r5aHTTIvBZa
         54590dZige9We/CQSr5No/30cjtNUA62ccc7R3VqOh90agCEqeBZu8h3RP7vXu4Vtl+L
         1+A086bQSIx4V2FdeDFFbMNC4AR6rpo64znYeAhsDGYvvdyTqSpWh/02QwU9WwKzB2ch
         TKxYApZ54XkkHi/MM9ICS1CKt9soqF/IEtE1kRx1IG4t9dGoo4J98KfiWElbqMSAIqV9
         aSlw==
X-Forwarded-Encrypted: i=1; AJvYcCWhB2NVgx7MU/wT4lQ6bNXl6byhYxSpU9vK5bIIGpLPLXjXuc7Vm1XD15WR+irRybQIadccOOVxJVjURe+j39UHV2K8
X-Gm-Message-State: AOJu0Yxtu/QL2Jmd7p3v5wmAEzNgbcBshnPzpP6tGDvepjAS2H62EJm0
	ZOOrNZZsXtvKMI1fXvm97UuAQShoxZhiTBJAJA9GlB/bR3+bg1+5E4mLZY/72N5r4t9CeexWj9Z
	/mm5R9C/mBt79D2oN7TM1ZSkN9r4=
X-Google-Smtp-Source: AGHT+IFMrQCHCAHg8/MZl/0p5fq+m8xbiYt/ie4fJ4MPuBnJJA7IKpQb7XfGzgHbNJHeqqS7dxDxFGSW/eJAvtFSAQs=
X-Received: by 2002:a05:6512:31cf:b0:513:3f2e:aaa8 with SMTP id
 j15-20020a05651231cf00b005133f2eaaa8mr1097696lfe.36.1709799764496; Thu, 07
 Mar 2024 00:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de> <25aa1b8d-79f6-4b33-be22-735a867367c0@app.fastmail.com>
In-Reply-To: <25aa1b8d-79f6-4b33-be22-735a867367c0@app.fastmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 7 Mar 2024 00:22:31 -0800
Message-ID: <CABPp-BG6FZkiiFAT1YC_POqeWrKESmh5a1Sf1vUUQ2QvBYL8xg@mail.gmail.com>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Stefan Haller <lists@haller-berlin.de>, Derrick Stolee <derrickstolee@github.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 11:59=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> On Tue, Mar 5, 2024, at 08:40, Stefan Haller wrote:
> > Coming back to this after almost a year, I can say that I'm still
> > running into this problem relatively frequently, and it is annoying
> > every single time. Excluding refs pointing at the current head from
> > being updated, as proposed above, would be a big usability improvement
> > for me.
>
> Sounds like a ref-stash command is in order=E2=80=A6

A what?

>     # I want a new branch
>     git checkout -b new
>     # But I don=E2=80=99t want it to be affected by the next rebase

This doesn't make any sense; rebase always operates on the current
branch, and Stefan wasn't asking for anything otherwise.  He was just
concerned that with --update-refs, one of the other branches it also
operated on was one he didn't want it to operate on.

Perhaps you meant
    git branch new
for your first command?

>     git ref-stash push
>     git rebase [...]
>     # Now I=E2=80=99m done: put the ref back where it was
>     git ref-stash pop

Leaving aside questions about how ref-stash is supposed to interact
with each and every other command out there, and how it's supposed to
know which branches it's operating on when you do pushes and pops...

Why do we need to invent a new command, when we already have the
reflog?  You could drop both ref-stash commands, and instead just have
a
   git branch -f new new@{1}
at the end (assuming of course "git branch new" was used instead of
your "git checkout -b new", as I suggested earlier) to put "new" back
to where it was before the rebase.  That's fewer commands.

Or, even simpler, drop the initial branch creation and both ref-stash
commands by just not creating the branch until after the rebase.
That'd make the entire set of commands just be:
   git rebase --update-refs [...]
   git branch new current_branch@{1}

Plus, either solution works today and needs no new changes.
