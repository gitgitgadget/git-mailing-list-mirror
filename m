Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F434CFC3
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690522; cv=pass; b=Lq1wWiRmRsHF3w92rYm3olzrlv+YRwYGY00zILaMbqqIJVycyeXbviBkpZel5INDnNyMYy51HviwWACd+6bITQ4pykJNx1JYMk0drqVMditqxaYSTDahkkcOT+s8nrb6/tv5TF1593rljO3Lv3iceMCgLcEYponAtBD/dFmTFs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690522; c=relaxed/simple;
	bh=8zOXwnoxe+JGUMN2/+zjAxI6/HxxgWnDlMQ1k4ALfwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6Pyy2PyI6sUNxu1RmP5PaLn4w58Wuzjm0xaok47b1K4lu/0u7qsP1h2Lg/+7hNzUcDpuxSPPUPDmXUPe/xoQIC1xhOP8hsDX4NL4je3nya5qiJm9zrXxTn29Wf35BpZYgRZE/OlwyVbT0mc3OVCbvyaRYdYSVfFiqnZjW2u1FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEqaAVDa; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEqaAVDa"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4675826d50.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773690520; cv=none;
        d=google.com; s=arc-20240605;
        b=VFS0LybG3W8Q2RAmZJdJUbltGWE/WeJPYmv/dM1kHr29LImUdEeryIU3bu2dtVBexO
         YOPEvAeB2q32i5NKxCgUJ6sP43Ov8ZFkw4vZB+okcyr3B6hC3vqMmhYkz1ON8jDxqHJR
         axZ2A2zJl4wxnvB8CDvCG3B4Z3xUaA4/BEneOOE17fwMTkt+RWI8UGxA8jOcwKwJ2Tum
         1pWvxWMD9JDMEwPWwVRdRAna9nbBtl/oajZWRZ1lR+MEQwBd3IYXr0rlZ9GMYjMwcWBW
         +QaE0sDdpPx6/EZfmsGJ8V6Ynm2yv5j9UJCHqDMq15PLNo1DqoSnc5NlgtEl1Q3Q7Up+
         r/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wQ9jXIZilkrqO6u+qBkEpz/0794LiruWwSrXkvG0i6M=;
        fh=PJ4cSlM5fVVOmIG8qghF43qISNOehmz46SFrnCp8EQM=;
        b=IvDzto4qEItM9WTmLeXeUNnUZToEglEsFQmHCkBbWgW9Kdxwa7TJp0yJ5y+xXeLKky
         YkPBYs2iccf3cyoqWfti3nikJrp7FEuMX+ij/NPSwTdpOk6pqwWj/AcY1PISf2G1ixs/
         g5UrB7CvkZTGErMVM1yBpPhJFTXpYTwU8usw67on7Il+IyLjbaWNALbm7FdRsyFTEY1M
         dbEDmmupHh46S7gBcWkIqAQ5eSfydx96/RoXe6XZTjsQB9ilvbUHP3zqdEABk6x++Fbn
         ph1EVFpVMclh1tkvBtO2H7DWXcLFitRYFxD/KS45kYjqxNFH4VVTP7wyU+mDZKjF95EU
         +gcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690520; x=1774295320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ9jXIZilkrqO6u+qBkEpz/0794LiruWwSrXkvG0i6M=;
        b=SEqaAVDaloAnvWlz3RVZPk1jhD12OhI5XBJqqYb20+eNS5KbNhML7iuoC7e4bnw8mP
         g/ZOM9FnVyELlBw1D8Hyj+HU6oHX81OQRDXB3w02gaP8uIK3eMJ8fPcN5LqYJ5BY3hXk
         uPrtdFXfSca3V6IPAr9hauZoTwTpDv7eEJY5SL/jeOTsROi4y0pHslfG5RjvOR5IK0E+
         IifTMGZOW85R3F1pGdXaUnxS+0UN4JprUpRo8vEkY43MKCjCAi5RXpi2E4N478arOy8v
         upTO0iVltcTuBMTLtKPNUhTwQTA3zDbN+9hqT9R7+xVcp17mqA/uGWYPagL5s4xy9Vrh
         6dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690520; x=1774295320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ9jXIZilkrqO6u+qBkEpz/0794LiruWwSrXkvG0i6M=;
        b=gw7SwnfV94jPegp0FDQhx38S8q2z4OnMC3lyPZvnwafvWn1t4PqLh06up2Pv+MYnXu
         4oxYijVJd1JPRQJTlaBQXWIJwpGul9+UMZlLX88z0Vi77TsY2KyvBR7uAMYzyD6Ivt4Q
         b29Jls+bqw6DJh21YddSpVFaH8x9TuzVRaJ37S0obS9PNjFrriGy8sE9uRst/RA2nDNf
         /H5A2dLHCryUDJJuTCqy82xh0k7XDR9slH+0cfkUT+yc2yKERsg3C32poTHJymDcCu3V
         Jwm7cRAa56axTq9pXQdbGOBFI+k6UxBsnAtOf/bPteEDmQsA2qQEaqdFz95K3MSQbJxg
         zDIg==
X-Gm-Message-State: AOJu0Yz4x+O+hgsxIcGdA7svU4015aG182ZdewI0zli8H1pWaCjXYpkI
	bpGeLvtFrR574i6SRCMxVOfdAcFtIfznIj3XLtk34+SkFjevuddwsALF0NZs0aJ91QwisW3ahr1
	ewuDEUpkiEMjqUn65xocApyVqK5PMVt4=
X-Gm-Gg: ATEYQzw5vHDd5eXlAJ+VO1Sk0WwXy0JCKN6ccILnMhJzEQ/XmVZA1/O/XTdZNhoo2v+
	aCfIzgkiYDtujL0qIH6IdqPMWdxEQZx49d828LVBGDylw+RLHMfWbBPEXk2XixUHZfzVc88pkkp
	w2xkJYKtNm8Ca9BlH3ZXAwonXYodDaJLz4M6ugxZuFy/tzG44yFrDnedQcw4uapqAbNe26QRGoi
	MZe8+0dThosR/+45OyPgLNsCLjf+Z1B6yzavdiuVtOqkqMaavl9VPZopra4nnmWdTUbjNuuyhxV
	4nd7Syi8EAs4GxYGjuTilRrwiPh5WoVAX5zJAq9SYSxxXxhE5h7E81WFteUfOzP76HUrUiF8IVX
	wlAB8sbVohp11I03O3rqcwk0=
X-Received: by 2002:a53:df4f:0:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-64e6306d33fmr10453119d50.61.1773690519635; Mon, 16 Mar 2026
 12:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316133426.117684-1-pabloosabaterr@gmail.com> <CAOLa=ZSsC7zpfpRx8pShcqGEv_2_NMrKzJHCgTSaO=0Dg0xakg@mail.gmail.com>
In-Reply-To: <CAOLa=ZSsC7zpfpRx8pShcqGEv_2_NMrKzJHCgTSaO=0Dg0xakg@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 16 Mar 2026 20:48:25 +0100
X-Gm-Features: AaiRm50Uyuz9ysPWyWxO3NGtj2kNFUVsjqHlUvNIutgxq1XxvevYKL8Wua_0jgg
Message-ID: <CAN5EUNSzC9C3Sn3OP3df7Hur-S64khV7VVJoas138CfD4dcKpg@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH] graph: add --graph-max option to limit displayed columns
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback,

> Do you think '--graph-max' signifies that we're talking about the
> maximum columns to display?

Yeah, doesn't  seem clear enough, but --graph-col-limit seems too
verbose. What do you think about --graph-max-cols ? It's just one char
less but I feel it is more readable.

> One question to ask is, is this even needed anymore and does it really
> make sense to add it?

> The TODO was added back in 2008, that's ~16 years ago and was not
> touched till now. So perhaps no one needs it? If so, maybe the smarter
> option is to simply remove the TODO?

> Or do you see a usecase where this is useful? If so, it would be nice to
> talk about that in the commit message.

I've run 'git log --graph --all' on the Git repo itself  on 'next' and
just scrolling a bit
down up to March 5 there are already +35 branches, which isn't very readable.

It's been 16 years but I believe that is still a good thing to add, even if
a lot of graph viewing happens with third parties, adding this makes
Git a bit more self sufficient. This is even more useful in a case where the
third party is not an option.

That said, if this still doesn't seem useful I would remove the TODO
to avoid further confusion in the future.

> My preference would be not to have implicit behavior but also at the
> same time guide the user in the right path, so:

>      $ git log --graph-max=4
>      fatal: --graph-max used without --graph

Ok, will add this to v2.

> Trying it out:
> ...
> So we still keep the spaces, but only remove the column indicator

Padding needs to be adjusted to the columns truncated. Will add it to v2.

> Isn't this more of `graphs_needs_truncation()`?

Yes, I'll rename it in v2.

> Shouldn't we allow users to set 0? That combined with an unsigned int
> would:
> 1. remove the need for MINIMUM_GRAPH_COLUMNS
> 2. allow users to specify that they do not want a column limit

I think it's better not to let 0 be a good input, it's the same as not using it
making it redundant. Is set to 0 by default from the memset().
Other "max" options I've tried that allow 0, don't share the "no limit"
behaviour.
  git log --graph --all --max-parents=0
  git log --max-count=0
That's why I wouldn't let it be valid.
The unsigned int is better for clarity.

> I think overall a little more explanation in the commit message makes it
> easier to understand the context and also helps reviewers!
>
> Shouldn't we also talk about the todo and the commit (c12172d2ea (Add
> history graph API, 2008-05-04)) in which it was added?

> The first sentence seems to talk about the option like it already
> exists, when the second para introduces it. It would be nice if the
> first para explained the problem we're trying to solve and why and the
> second para then dove into the solution space.

My bad, I'll improve the commit msg on v2 to be more clear about the
problem, what it does and where it comes from.

> What does this mean? Validate how?

It validated user input to avoid them to set 0. In case of letting them
set 0 (no limit) this would be removed.

I'll wait for the decision about whether this TODO from 2008 is worth
doing before a v2.

Thanks,
Pablo
