Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A73148B2
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555242; cv=none; b=MsF3D5tumOrJjTdRNeewNrfkfj7SDyqo01b1yFp8LD4FCGrVdn3UvqGrI3H/EYn1LY76oQjmnFAbWrLLwnrGDVcnfjAX6gzfb8SLNhwttNMxm/csDuipGtSTUXeao6Gvt3PeERnMyP+DYmhqxuJJ7CluVozp4d2JWOh1e8bTB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555242; c=relaxed/simple;
	bh=Tw5EPfbd0bqX/XpX2f1H50+ofJiaNcKF8o7ZMKmXZwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZJGziASQ2Bt4AeDjckowlB1zzx9yiPUo7nkmCDhPmTEhPfmf4AwlfnNQyFJzkKe+h0SSp/DF/NyVFXwh1NxnXn2YX28l7t8tNkWf/UV7s7YKDX54AAui+NrAW+jCZqW2xbjsex6FodlZoCGQuVA18uGnZbYmwjsrGl9gkSh/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwW58Xtx; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwW58Xtx"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9486b567c18so48141139f.0
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762555240; x=1763160040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPdtsExAde+4nIfXUKC/rTmhcAs+FofWIxXhujJmSEE=;
        b=hwW58XtxYqvh8DMbbTEw8h4cLcUgqS5I66h61oj0/CNcZrIaGjoalRvz1JYZRQN3Jk
         vZ/gw69bj9/OKMkVEzMnC+NLAUacHgWKWhPwuSpxLBTDm+QBPsvb/yQCiR6qXoW0EffB
         YY//ivBz2Av20eXPfERagR3VkP1V5q1n9aR0cXzSuPq8/jKVInpffPRC/pMm/Ddcbd+w
         y+2sQRiK8VRSPfRRA0oibhuSmEZPIng7FXasZM/UY8D7QSCL56yLDtT00izBJGqmUTD7
         US/d1k/mDYaY8BL5wedRDg3NBB4dLZsVZGVX1zqWZOL3lQFqOGl/djQmTeWV8zJK3aQS
         MuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555240; x=1763160040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPdtsExAde+4nIfXUKC/rTmhcAs+FofWIxXhujJmSEE=;
        b=cVG495OAcQ2ya+lpRxo/1161TGl9zylZgkPv30/aFjlQeJBrCxuYTh2lNICHqJOQim
         FV81KPx21EELW85csZj+Mpi7soXj7m44BYl5Ihb0qzHmXZZ2ax7JSbr2xoB0dVvqVpAK
         /k1xRFll1xrgf3QlKYHtNCKaZdJhybOj1zuNiKnAa1IjItjwHAUBfIczY+a5Pf1UVyGX
         NCduKGEEXbzAf3Mp9P1G0DRQ1lpof8SsvshnCW7Xso6CsQjF1VlZE8LfCBSAWYb0Gr1D
         RcHHTilPEAgt/hM8m/2+xWkUtznatMXl+nnh8snYtRkNcYD3QXSZIxIXmy9l0oGuqlXz
         WdDA==
X-Forwarded-Encrypted: i=1; AJvYcCX0OEXSphS0LPm2cZIIBqsuS9e/Flb0R9hUlDrcwe2VJAIZXGrN1niWkqIbmmG3PgzwmHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VCMmhhZwJB+BTsSgn6X4SJrg9vBGSiPoaBZYvFbDrD4Psueq
	icdfZq24Mu/80u+581/DFDUN+vxJ2zInvd2zPtzlk2OHKpRKzQCKoYn5IUKQSazP0UYgEtzFuUP
	eHr83UGjtf04aryKQdaqhunbYrPfeRrkJqA==
X-Gm-Gg: ASbGncuilHYBEM1iV9V40aqOxr3cJAEk9N//OveppRJqm+Kk0domZzJFfcTEXkg5e95
	rmBx9xRYt/KtVl9egQNyc3Dh6/xPVjZ5D6IuwvUn8JBrmfzc6KLQ4rZQgEolysTtcLMQNwF8OuL
	irffLgy5LhemP3fvV2kNoeF/9AqeLN1W1fAlQUOJx/6ph544BQDjN+lN2B8/SqxIvcp8ilAv0RA
	rQ7Y1xr4BteWl7PinTjNxnpQzVHamdsgVecN/GzcfZZBaQ9JlgRh/PMKmmGVo7ZRxEG12xRuA0=
X-Google-Smtp-Source: AGHT+IH0T706VsPTUgixxrhvtQx4SpZ802Wr9zrOhcqukc1b5CUTZVuEMBv5/BYBFLV8XbbsOxht3cgI62+0yek5Ic8=
X-Received: by 2002:a92:611:0:b0:433:674b:35ef with SMTP id
 e9e14a558f8ab-433674b372fmr20485775ab.0.1762555240043; Fri, 07 Nov 2025
 14:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
 <950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
 <2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com>
In-Reply-To: <2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Nov 2025 14:40:28 -0800
X-Gm-Features: AWmQ_bkx2X2ql4JWKDUj7KfJmMC_zyQf4-4Hai3m14ZQhNKu0Yz2--rmHa9HZlU
Message-ID: <CABPp-BGchyC6BB2p7p-6qHvwcu5AV+VCAdTeR247F0VamsJkbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6429: update comment to mention correct tool
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:36=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Mon, Nov 3, 2025, at 19:01, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > A comment at the top of t6429 mentions why the test doesn't exercise gi=
t
> > rebase or git cherry-pick.  However, it claims that it uses `test-tool
> > fast-rebase`.  That was true when the comment was written, but commit
> > f920b0289ba3 (replay: introduce new builtin, 2023-11-24) changed it to
> > use git replay without updating this comment.
> >
> > We could potentially just strike this second comment, since git replay
> > is a bonified built-in, but perhaps the explanation about why it focuse=
s
>
> s/bonified/bona fide/ ?

Yep, good catch.  Got it fixed locally; will wait to see if any other
feedback comes in.
