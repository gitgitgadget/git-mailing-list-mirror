Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95D40B373
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466744; cv=pass; b=AnxUwgy2YFDAhWzxZkW58wk1kyCMwTjbO8ACyVIZirQeiDgwrX7uPHoJYMcz40vvTQB5R4P7s8i95eFUs/jZtgOwIyK0v9htfGvRbR4YwdtzFUV2huMmA/0DJFflfWLGQbYqHX2/9EkCIGRj+rIF4afltJ53G/gVA0IcK360chQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466744; c=relaxed/simple;
	bh=dQKYbK5tVFUE8Em0RKA4/It6oBx15kP+EQFN83LQV8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IL0yO65xp46IxoUf19XwrTEt/s6i/BOpzbaSdDWTJ0QK34hZSy79Mx7rsUndxC0EdBN6j4Vd5RuDFHqVZU9Xh6HqLr6L9O5eSrORG7bQz954r3TKal1z+Xw3Ghkdan89kGNzjHu+oQ9wkue+f9R0m7ZOoHHVJwgeOd1xAUzkKxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz3RaBAb; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz3RaBAb"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c74722e27so1416791fa.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786466740; cv=none;
        d=google.com; s=arc-20260327;
        b=EE3lsn4w5iUrnGgvsTQgT+5bHBmi0gFzecFWXxOOpPB5X8F8QeuvBdATKqvJqvShoE
         /YW1HjA+Yu59fojamw99WMoRTyXS2xELNEQuoJ5gPE90yomgDqrzFY7GO4DGqa6Ze66t
         8yaLEdWDB/KhClMZSn4ku40a2y8f1iA9IHHyNXHRMCyu4Ggf8bFWDB3edR27n1xesLmI
         IaLbC5HWAHFL/BAc39GtgevqRszsbRTKmcVSARAT4Q6sWIeAM0w68vqog1lDqpDQV1yw
         SZcjplip/fh/Q3X6lNcs5AhLgBXfb/bFZJa9PYuY1+9MG6pQTuQtyZz9hk4Z+MrPnNVh
         aaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TgNpJXuIVOW6CVieEPWzhi1nUJnFnaIUIaMQ7A2f6pU=;
        fh=Cc1QAY/lqSqLHUUWWo19PrvfUiGowsOMgKPJQ9CIkE0=;
        b=AFyT6cQ5urGzzH8h360L0Pw72WvGefbzf3KFggfRF7HGlGOPfePJc1BklibJHln4S2
         LHxpSyB5JLGIezz1Y5+eltnw4Qd1Gjh+fPGn3jCf0BX8dbMSXqq7MHxHST/yRJ6ePq4Y
         fyKiUknjAXtk7ZhrafF0k9buPT6nj4yf/j5TTQEFMT4uGJiYjPVYTkBn4PjCWLuBoZLK
         DVIGtpnnGOh5HzYynE8PIQ2GYv7F8sW8EP8637vdwhx8Ak2FRZkurRvdKGvaKPUCBTjx
         kO9XzPASKmJ3yHaP43nq61VEP1pfTXv5rKbYoqFz37o4hSxab+0DOKP1g2BErItw8W3B
         C/wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466740; x=1787071540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TgNpJXuIVOW6CVieEPWzhi1nUJnFnaIUIaMQ7A2f6pU=;
        b=iz3RaBAbJ2axb3z1qH+2c2dMM/mTbBvMB192t0fjg/sRHluUmvR/Sfyl0CTumfKtJA
         E30lBuxEKtTd7CQ/WH4NHfo98GNwgXV6KkSAFtZKt8bb6BcBLcf6TFELHmVTCwjVfedl
         qCCWfN6VW6To+jf2xXzV85UcE1tc9UG6LvV6IB/HXVs8VcSg5cvpjiPHIaoc0C3j+7cM
         MA1EPIy2h650exJjWUM3/wSK+x1FDFDvJNviPq8yMv7/rdKD32tw4XAP+vv7+vQFZC/c
         I34sp66Coy74ej2Yjo0TiR8C6cRqVGKDy6f7bksj2nGxjitP9OLD9DxiiBWlIPzZUQYX
         nRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466740; x=1787071540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgNpJXuIVOW6CVieEPWzhi1nUJnFnaIUIaMQ7A2f6pU=;
        b=YSd3xOF4RNYCQqUXWL9f9pW0EBTFwyGyWT8urkuz6hBrsEnopy7fwRBlNHbtL9yYgj
         lsV60CTZYlAexcKvnziuGj9oKTrWwEe8UigSRCS3pROzVHHlleXqMGcrb6d068bp9fp5
         ZHtONu4vru39eWvaAXf0jNskPqvxTUdXeV5ccVtiDSIosiDCPLQYzxxRokaHoOfsiDlD
         SJwNHChjsMHQhXEa8vBWWxa+hTEB6/UMV8k3J2rztaPQuVKu0C0sy3QzeMZ4o/m/vT2d
         ESsovaC8Mpu0NX3wWeJqMfEkZZK7eDXfGLKhV1e8rg5gSWvYPvWxze/4gjLDqXV1gvET
         UWtg==
X-Gm-Message-State: AOJu0Yx30BAoNAvBQamw0fisuEyE7a5n/0/EsMemMg468xrJ8Q3ZC/5e
	6O0IzJsW+c7ratO/4vF9nPjV5Fd6ihI6u2HW3e1YLlDwJ3pQyWQuwYOJ9ZFZXcDOS4soa/H0C2a
	S6nq0QPT39HfuT3Ay1rPiO73OEtS5ZYCfLI5n+X59uA==
X-Gm-Gg: AR+sD10yhaGmKej1CV2s09AeA0//7z8fX9xkBi7jiGPaaqxxtkfS4ovit8KeQvxFHZg
	wjmmy5fn8UMKfQ3SScrtSxfjG0NqMFKLbdahRS1ko2twuCJphTNEHOJm2MsHSVz551FHS038mmL
	QMoizLftN+gp+Oo2Jgzv3HRbCtYyY3Yrsg+rR195AniAwWPm4oMSMKW9EAcYyMD/L31xwz9u7MT
	3dF/sh4PSwNP9vTqyG3g2yuiUQsr5f3gEchGsALhFvr8AzdcNgsFopyi+fe7smXX0XZVFmCBDV4
	kgqqUF7K2hfm4NCpG+KFkBmnOsk0vo75FG3TDBpcyAzZc4zkBYvRF7Svp0+BSHAzg+JOO2rYrou
	BnqDvm864APjPH43pkrGVA+bYtIqgbTWJprc8cIFdmQXkn0WKtiucokxdkg==
X-Received: by 2002:a2e:a9a2:0:b0:39b:11f9:6132 with SMTP id
 38308e7fff4ca-3a102a5d000mr2426511fa.1.1786466740144; Tue, 11 Aug 2026
 09:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
 <anLtSOKqgcCrrNHo@pks.im> <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
 <antMfAYVSPX9QAk1@pks.im>
In-Reply-To: <antMfAYVSPX9QAk1@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Aug 2026 12:45:03 -0400
X-Gm-Features: AUfX_mzHzx3L4R1YAzOQBTuL6w-xMPW4-jB38PFmUtnilKkzFMzc2lS0OVh_2iI
Message-ID: <CAJ-ks9=oV4SQSjTHNEOGBaQb8Rb4xBqVSp4wYum6yzU-zx3YtQ@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>, 
	Paul Tarjan <github@paulisageek.com>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 12:23=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Aug 11, 2026 at 11:22:01AM -0400, Tamir Duberstein wrote:
> > On Wed, Aug 5, 2026 at 3:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > On Tue, Jul 21, 2026 at 05:04:56PM -0400, Tamir Duberstein wrote:
> > > > 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
> > > > 2026-04-15) limits the cookie wait to one second so that a filesyst=
em
> > > > which never delivers events cannot hang fsmonitor clients. A client=
 that
> > > > times out receives a trivial response and scans the entire index.
> > > >
> > > > FSEvents can defer delivery while it batches notifications and does=
 not
> > > > guarantee that its queue is drained in one latency interval. A load=
ed
> > > > macOS system can therefore time out even though the event stream is
> > > > working.
> > > >
> > > > On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, tw=
o
> > > > worktrees with a 1,001,178-entry index timed out 484 of 545 and 297=
 of
> > > > 365 fsmonitor requests. One status call performed 934,519 lstat() c=
alls
> > > > during a 47-second preload and took 52 seconds overall.
> > > >
> > > > Ask FSEvents to flush pending notifications after creating the cook=
ie
> > > > and before starting the timed wait. Use the asynchronous form becau=
se
> > > > the client handler holds main_lock, which the listener callback als=
o
> > > > acquires. Keep the timeout and the behavior of the other backends
> > > > unchanged.
> > >
> > > I cannot really say much about the FSEvent interfaces, but to me it
> > > feels quite reasonable to flush the queue when we are waiting for eve=
nts
> > > to be delivered. And that's exactly what `FSEventStreamFlushAsync()`
> > > does: it basically overrides the latency we have configured (which is
> > > 1ms) and asks the kernel to flush stuff immediately.
> > >
> > > > diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemo=
n.c
> > > > index 4161dd8282..8e32b5ae5e 100644
> > > > --- a/builtin/fsmonitor--daemon.c
> > > > +++ b/builtin/fsmonitor--daemon.c
> > > > @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_l=
ock__wait_for_cookie(
> > > >       close(fd);
> > > >       unlink(cookie_pathname.buf);
> > > >
> > > > +     /* The listener callback takes main_lock, so this must not bl=
ock. */
> > > > +     fsm_listen__flush_async(state);
> > > > +
> > > >       /*
> > > >        * Wait for the listener thread to observe the cookie file.
> > > >        * Time out after a short interval so that the client
> > >
> > > Okay, so we've unlinked the cookie file and the next thing is that we=
're
> > > waiting for all events to have been processed. As said, it feels
> > > reasonable that we're flushing all events before we start waiting for
> > > them.
> > >
> > > What I find surprising though is that this is supposed to make a
> > > difference at all. The latency we pass to `FSEventStreamCreate()` is
> > > 1 millisecond, and we wait up to 1 second for the cookie event. I wou=
ld
> > > have expected that batching events for 1 milliseconds should be total=
ly
> > > fine when we're waiting for a full second anyway.
> > >
> > > So given that I cannot verify this at all and that I have no clue abo=
ut
> > > the FSEvent interfaces... do you have any explanation why the flush
> > > seems to help regardless?
> > >
> > > I _think_ you're already hinting at this in the commit message, where
> > > you say that it's not guaranteed that the queue is drained in a singl=
e
> > > latency interval. Is there any documentation that tells us what the
> > > provided guarantees are?
> > >
> > > Other than that the code changes look sensible to me, thanks!
> > >
> > > Patrick
> >
> > The following was generated by my coding agent and fact checked and
> > edited by me mainly to address you in the second person.
> >
> [snip]
> >
> > Hope that's helpful.
>
> Sorry, but that's not quite helpful. The questions I'm asking are to
> verify whether you understand the consequences and subtleties around the
> code area that you're proposing to change. If I wanted to only learn
> about this myself then I could simply ask an agent myself, but that's
> not really the intent of a code review.
>
> So what I'm looking for is _your_ explanation, not the explanation of
> AI. Your explanation may of course be informed by AI. But if so it's
> your responsibility to double-check its assumptions, build your own
> model and then share your informed opinion with us.
>
> Right now I don't yet have the feeling that you understand why this
> fixes the underlying issue.

Got it. I agree with you that the flush call feels unnecessary under
the interpretation that passing 1ms to FSEventStreamCreate is the
equivalent of asking it to flush every 1ms. Empirically, though,
that's not the case, as described in the commit message.

There's more precedent for this technique (found by agent, sorry):
watchman fixed a similar issue here:
https://github.com/facebook/watchman/commit/d1795de4ecab33672a89802318fe6f0=
122462194
and the documented it here:
https://github.com/facebook/watchman/commit/2f80886991ce81585ac0679c2b019fa=
0e4d9e9dd

I agree this is unsatisfying.

Does that help?
