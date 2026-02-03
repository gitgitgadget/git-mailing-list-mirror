Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85A396D0D
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112540; cv=pass; b=T1dU8l/kXfI2uG3/FmLNtdBYYYNlvdX/stYvslZWbQL1jfHlkDsJIGn/ACOXPYJgisH8k6XjFcJdEynp8U/guXwwgUGs2PPK0tM5fHJEiy4j2i81MG8x5gSXWJai4lEF3yFQdWofQ2BfUnGKt6DYATQjmergDNFF9pDfC4/CFcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112540; c=relaxed/simple;
	bh=lK8L/a04UE0UcwrzaAwuaCDGzTgCh+pGLrK1XmQdH+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM2YWvszOH4V5D+nHnZihaIDwYsypJc4At6savSlIvnXVI4D0O8d2Vwmj4Adib/KOpkBZQGTcmS7RQwn7uhxfAQkudBkieOMiTxGIhxPzGMJEnw/7WQvvqCvqn/apA0J6pnrnE46ukIZ05EJNRkyWb4cGzM5gkYdFx6yN8iebmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpAQVXB8; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpAQVXB8"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5636274b338so464585e0c.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 01:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770112538; cv=none;
        d=google.com; s=arc-20240605;
        b=hwguqZJVgpVxHrTQTIKpEE4YomJaagOxZfxMoxU8oi3HLGmywXr2bn/6VeVHTdFh//
         yOhtwymo05fkhtAmUNApnjmKRffeJvArJ0TZ5DYhX7kzW1EWqsv6Y0D+Y4lMdubev4OX
         cWzlCS3oZKxBOPfryLI0998Xbd1gw3R5+tB1iyfXqXiWqjEFJJKINQbBDkyfWvUpu3WE
         M81/ARe22UoVgtRK7jzNxEM42ylPwjvqOlqxXibcbN1kSfJgoCN4UYXn8bsU33Uht4eq
         zVHHk0o0NY2Qtb3va+q+0owtJHZR16oKvJY5IdKprmS5zYYzg1nDB0TN/GxCQbQGyD4P
         kKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=es58V2keZOoa3RS5mi0FcVg0Nw7qszkyHzRwfdIMMDc=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=TR1wuDlPSXMY0aFUidi8eQR/UhQUGqqifUhrihABHbQ5Mw0gjhXn8F1nxMiK1GESUh
         Iud3fiBnANTEQhQqCOikQmAq8HOzDChPjwG0N3HBiRmsWpXceKQhTvghFY4nMTEzIl0L
         mmI8U646v8RMQXvlbqb3AK/Uqpt01SbCsXIkBCIy78krwq5/SI0dofAIqKOjqNQ+F+gb
         /vBAfHywj66ew1JNQhcn7AAalqRAucVuQxeitOAHKsS9Nmt5QpzH6nNEFWEvXA569dYs
         U6/vgDPhK1RvfdDtNdMrzlBFx2Ol7YyF4bM2oNCcY+xskS0J2G6RadjYu4GbRzSlFAIg
         /PYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112538; x=1770717338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es58V2keZOoa3RS5mi0FcVg0Nw7qszkyHzRwfdIMMDc=;
        b=bpAQVXB80PUmc03Pm3aE69KIpKfKKxIvlcHtEj1yXk75L+MmNlP3RbW53yHtUbpEdk
         TKyJskc3QR2FBkUbsXe27PHXDzU9xpdHyfLrpKZK8uXUqXFqzAPYlez0T96KMa/1gWlX
         5owd5A4tLR1ZyZmki+/GiK8vjIjVpBde5BjBQ0VNNmHj2z7lvL9eBY4S1xYVjCK68G1S
         WNU7hLHQbCG4fxKeAmkHONzb4VA9xYuQFuIrcGnjFM4VMH/agAFI+R2C/wHpmOO1fEdr
         8Zq+sKImegt60deRL0YEHIGx/leHijkIAZ+IErm8t5zFRNH3ipNuVCyr26L6OvLYuPhd
         F/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112538; x=1770717338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=es58V2keZOoa3RS5mi0FcVg0Nw7qszkyHzRwfdIMMDc=;
        b=LO3ny7ua5YqNba439AmY/a1hrXyfmEu0aX1UQOaztaHWY2DNEmxiSNKzS0l/3q/8iJ
         Vbds71ntsSdgFKzRkKxWm7SLNPYPRDABUbGXYuAks7o0MPJ1VwiOn3uuWZqL9ekmXUV4
         ZwZkxKK4LLAhcwlUpR0YO7oov3VnVEFl0wce34cC19Utlkvq2l6LrMdtlnUoADeCKeUJ
         Z/52+7W9b4Mmauk5P6F3W8y5+U4PnBDjiaVzZ4RpGFLfs7q9olTSqzWnq6rkGfkrDKak
         sKDfap9ac0oZ8g00G8P1dRngbI0o5p3eV35RnVm24EKpaDYgDXVbv+sg/3DvEym9uRtS
         K5aw==
X-Gm-Message-State: AOJu0YyduhdjWTIl5HMQbhQoT1bNaUn8vleo+ZU7yaoyZsIcCs1gE2ps
	bRM3MVTvbUkrZp9oVtam3QClV+Oli7AhpfYKyJRWnFWOedqtkKrehUdXGWjTfp5xZYlGUvORejx
	l55m73X00+WpAa+EartMlsJ3HwU4pWT0=
X-Gm-Gg: AZuq6aLCqleKq1K4WzZHLeLxeoV5frWLeO7nBdl7jLQQKKXGoJBzZ3qmYrbqbUOTeFD
	3ae2fNj+tgggDj7lJoIFRNFrcRAXeZFY6PtBLJK7vLFrwH6Hl9ah+AwnHEC22ghZxQBNAwePR4i
	kCforkG+O/HjdXhFMRdOsVaBs1eaYSmJG1bW6mZF37FE3I++fM78QWQeqFHaeOdlIAndKy2/55M
	1ah8QHOsBnG46Y05Afk3c4dDjBQh95g2rfiC9HRwyGO9/CGEuqR4xiIs/zKezRZ4MYO5DQ=
X-Received: by 2002:a05:6122:4b0d:b0:563:45d3:9b1d with SMTP id
 71dfb90a1353d-566d8594fc5mr777021e0c.9.1770112537916; Tue, 03 Feb 2026
 01:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
 <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
 <xmqq7bt2g4tl.fsf@gitster.g> <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
 <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
 <xmqqqzr54mam.fsf@gitster.g> <CADYq+fZFuvCRbFf=-XUR8TJsjW_YtjNdiXMzPv0mjMPbWcLO1g@mail.gmail.com>
 <xmqqzf5rys3f.fsf@gitster.g>
In-Reply-To: <xmqqzf5rys3f.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 3 Feb 2026 10:55:38 +0100
X-Gm-Features: AZwV_QjgiDBMdpn2-7k4oxEhEi2QXp-QbzubSg53H8kAhpmyrfjdHI1iCu4wHSI
Message-ID: <CADYq+faasM8h0FJjop4GJeo_6fw-=_VXRZeqYURDbQFuR0CK1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on all
 its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Samuel Abraham <abrahamadekunle50@gmail.com> writes:
>
> >> I am not sure if I would like the end result or rather prefer your
> >> "all-or-none", so please do not take this as "here is a better way
> >> to implement it" suggestion.
> >>
> >> But you should be able to keep the current semantics, if you wanted
> >> to, even if you apply the chosen hunks when you switch files, like
> >> the original code has been doing forever since it was written.  You
> >> know which hunks you applied, so after applying before moving on to
> >> the next file, you can drop these hunks from the list of hunks to be
> >> decided for application.  When the user comes back to the current
> >> file to decide on other hunks, you know that the already used hunks
> >> would get in the way, so why keep them?
> >
> > Yes thank you so much for suggesting this approach.
>
> Not so fast.  I explicitly said I am *NOT* suggesting anything.

Yes you did.

>
> And thinking about it more, I do not think it makes any sense to do
> anything other than "all-or-none" when the command is working in
> your new "you can move to different files before you decide on all
> hunks in the current file" mode (which I think we agreed to make it
> an optional mode).  Why?  After deciding yes, no, no among 5 hunks
> in the first file (leaving the hunks #4 and #5 undecided), you jump
> to the second file, do something there, and imagine that you come
> back.  If we drop the alrady applied hunks like the suggestion,
> which I did not make ;-),

:D

> we'd then give you four hunks (as hunk #1
> has been already applied), and even though you have already decided
> not to use hunks #2 and #3, you *can* revisit them with "J" or "K",
> change your mind and use them if you wanted to.  But it is too late
> for the hunk #1.  It looks utterly inconsistent if you cannot change
> your mind on hunk #1 but can on hunks #2 and #3 and it reduces the
> usefulness of "you do not have to decide right now and visit other
> files before you do so" mode.
>
> Thanks.

Okay yes that would be very inconsistent.

I briefly thought about this.
If a user decides USE on some hunks and goes to the next file, and we
apply the patch, the user comes and decides SKIP on those hunk(s),
can't we "unapply" those hunks using "git apply -R"?
I have not really thought about the complexities but it seems to be
something that might be complex.
I just thought to share to hear your thoughts

Thanks
Abraham
