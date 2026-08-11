Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089F3911DF
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461762; cv=pass; b=rthGEaFOJLcmDUlo+zdkb3A9nTj/J0+FcdO55V5k2BzhZX5KxrAAQl/PkOLEQMEfG6Tu91VuJPgSUw4cQoWMwEMOHi8IH6uy+M0tBTiGvqeN1Ynj7lXtAvADsOrULK/Cl8pmyrxjzOaGITaKz5xDvx03n1M8UBoHCGfSPrr42Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461762; c=relaxed/simple;
	bh=K96aRWjyP00mCvpk9hvqIpIBpvvKT7xz9qCKI3eW7vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQwBZ6MKDL250WJFO8G/ve6gHaKGj551402VFuq0d3hg7XzPyMYRDXoGvw3FzEGYaJ3zdd80z+azUi53MoESorLIbSLxB2vsAEKgPmk1AM8iVRfAb4AAnZw0XZEf9i510W2JrmbJgFz67gx8E7gbseStbhF67fF+ioLGsgksl3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUCAANXD; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUCAANXD"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39ca0a30148so137301fa.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461759; cv=none;
        d=google.com; s=arc-20260327;
        b=LyRsndx4EzRqspF54u+1ROF9CuoG37pHv4QiOIsd4TaFetShlfbQZvhRnYLjMlbVG9
         a/GGjta5p2eThfNrptZrUWXMv5L3as36ujprhwcG9fhME++mrwuP78dkiEv0PayEgJoV
         t+gwXYI+efb3C6SF8yoUBdMPkAQ+zmKYODAP4JJG6Uv5crbHDaC7QwhA2yvnuZo8+4bI
         W14mcLACL8x89pNNc19wE6pX60vSz3+KC+8p6w+NRobtVC7vIZ/sXEkEgHqM0Pb9GH7N
         60stZwSbS0eKPlsuKg4gv67gJMfeHzgvgw+BogAoihztWXD9B9gYY3s/YfzIiuC7JTN8
         7jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5/hnT5dDkfBhmIrIepITlnQSpLxXa2Wg3VnbfM+v1Q=;
        fh=Cc1QAY/lqSqLHUUWWo19PrvfUiGowsOMgKPJQ9CIkE0=;
        b=mUmrqqr+vZbH6DOS+bqz8MxY1RfycqtSezGoZJ/PDeBmhzCbGMJcmcrxcz4t1JYS6o
         8gN+JVjLNcpW+rwa+FY797GwxiCcn1G8V2847GfgqAfqd59fW4TSNa6rOUf0wCpU1bWm
         ZP5fbFK+lzGx5XsuBFosBMpH5usZdKB18EzmFYog2Wr8+Zaw3quhhifxDeMsMNp81DIS
         gf8Aey680O0xZ/6NR9MkxbzieNUdWYAZXB+jBnOZHp8yZuPQ6OmjTv9zrHVX4N7z5Z4u
         LG0pcaC34IbiV2sXen1rrnqXHgq/UwozwNc1otgeXiiREztZGKIXlXEMe+DFq3xzqZ7b
         IwAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786461759; x=1787066559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5/hnT5dDkfBhmIrIepITlnQSpLxXa2Wg3VnbfM+v1Q=;
        b=rUCAANXD293zfRvrre5xTgWQ9xBLcGOsbMcaQfv6AqwE9f0DSSz4QMFtYigisHfWE9
         icwDGWGZw+aQnR6cgE+OWibfFJvgHm1DCKkfLdyoA3ibZ/n0tkOxD4E30yXRunfYs5x2
         aDkW7Ue81n1hL0GDEbIPIkxSfaAlbCwcgXdJAxkwlYZVVSIX8eg7d1OHXFSvIrcVeEiP
         A7KbUHuYprzONz7DnGUed2oSEtls1g2aggbPDkjnLfWvQeCWKjs1zwYznKb67KpnbfQS
         NLRby78ow0FRXEv+oa8NxnxZY/3yMS3Gy/Mo2Hq5Rsr0yEH+sXnKktPk5zQ8k7Dt9qa/
         kFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461759; x=1787066559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5/hnT5dDkfBhmIrIepITlnQSpLxXa2Wg3VnbfM+v1Q=;
        b=VSq1h/oWFl+LX4rYiLWn3CY4h2eHTW5CzwNWOI893EV9McnTRlmCByM4GIB0wJzMXX
         oUKR8RahMHRKrtYlNyXZseULdwnRyi2Z7SyQeSWmrdBfWiu82veLwOcl/YwDkEmScPr4
         j+gAqIIhucWirWrpi2kk1sgKtO0egBNzkfBmb34uTstGbvnSWl3ewxQ8LhQdPP9leLR/
         60qG1+rj+0NC4gBM700kA1n1YeMLBkUCL30dE5U/CzM0VNZSds39TQ2IGPWGF2vXB5tt
         yy4jhFqBcEYUoYJEGw3U/HyU3aTLlDDJtqK7EdLvW+dQkqd0h+SKB9hQycKCoOZp0v3E
         0bOQ==
X-Gm-Message-State: AOJu0YzHuY4QWMHdmVUFy07mQlk6LUVvWQkWmtCKqxzj+yVZqSqmsI8q
	KGvQgREJ+JhbVzqU5/AFb2TghLp1stqs++RtmiByiUCPkKgG6myL+iQuUNIcxP+KpnJGOcVMF2A
	Y6u9GBcepsVo2LXq3Qo8xNpvvvyqe/5o=
X-Gm-Gg: AR+sD11hAl1OVnVEUI2Qre3AUFH7FjCdU+Ol2TbAZGIUKfb0OECZsIDI4TpdftgR3kt
	wmh+g3erRQpEna/13gNsDK7Mbumi9bhHsXW2p74MoEvK18qAZzKa6oly0a4/dR59+yU85lBLYD8
	+3h5X77nSkUlsv+BeaMHIUMYgw6djnE36kG2wGpc3rgXZ6S4kkoyaI1/RxxGKHbFJ6jQX6Rzyyx
	UuWfBlzhe8+C19Qo2f487uItLHNWcoLHQesJDeXhZI7PwxZgvNMpDudtYxwSvQKNeOQSZ2H/pFW
	oTxduLe5moW4zYKcdB5qN3QzQSk/W8c2HrXZ28Wc1RhZuEeyJ94Gca1HqhJfkHHQTPXyEkJB9qh
	MJydmsO3xvle8s9CMiUQF435ghhIxOhVQBRODQcSSLC4OZN/K2Xss85FOGw==
X-Received: by 2002:a05:651c:510:b0:39a:e9c1:5809 with SMTP id
 38308e7fff4ca-3a0f8c4a2bamr5906111fa.3.1786461758325; Tue, 11 Aug 2026
 08:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
 <anLtSOKqgcCrrNHo@pks.im>
In-Reply-To: <anLtSOKqgcCrrNHo@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Aug 2026 11:22:01 -0400
X-Gm-Features: AUfX_mxFbnHGLX5OUChfkqfmzyfk-DeAq9uQHaMBr_6KC_0ROwDVHjsxu-UeC9I
Message-ID: <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>, 
	Paul Tarjan <github@paulisageek.com>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 21, 2026 at 05:04:56PM -0400, Tamir Duberstein wrote:
> > 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
> > 2026-04-15) limits the cookie wait to one second so that a filesystem
> > which never delivers events cannot hang fsmonitor clients. A client tha=
t
> > times out receives a trivial response and scans the entire index.
> >
> > FSEvents can defer delivery while it batches notifications and does not
> > guarantee that its queue is drained in one latency interval. A loaded
> > macOS system can therefore time out even though the event stream is
> > working.
> >
> > On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
> > worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
> > 365 fsmonitor requests. One status call performed 934,519 lstat() calls
> > during a 47-second preload and took 52 seconds overall.
> >
> > Ask FSEvents to flush pending notifications after creating the cookie
> > and before starting the timed wait. Use the asynchronous form because
> > the client handler holds main_lock, which the listener callback also
> > acquires. Keep the timeout and the behavior of the other backends
> > unchanged.
>
> I cannot really say much about the FSEvent interfaces, but to me it
> feels quite reasonable to flush the queue when we are waiting for events
> to be delivered. And that's exactly what `FSEventStreamFlushAsync()`
> does: it basically overrides the latency we have configured (which is
> 1ms) and asks the kernel to flush stuff immediately.
>
> > diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> > index 4161dd8282..8e32b5ae5e 100644
> > --- a/builtin/fsmonitor--daemon.c
> > +++ b/builtin/fsmonitor--daemon.c
> > @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_lock_=
_wait_for_cookie(
> >       close(fd);
> >       unlink(cookie_pathname.buf);
> >
> > +     /* The listener callback takes main_lock, so this must not block.=
 */
> > +     fsm_listen__flush_async(state);
> > +
> >       /*
> >        * Wait for the listener thread to observe the cookie file.
> >        * Time out after a short interval so that the client
>
> Okay, so we've unlinked the cookie file and the next thing is that we're
> waiting for all events to have been processed. As said, it feels
> reasonable that we're flushing all events before we start waiting for
> them.
>
> What I find surprising though is that this is supposed to make a
> difference at all. The latency we pass to `FSEventStreamCreate()` is
> 1 millisecond, and we wait up to 1 second for the cookie event. I would
> have expected that batching events for 1 milliseconds should be totally
> fine when we're waiting for a full second anyway.
>
> So given that I cannot verify this at all and that I have no clue about
> the FSEvent interfaces... do you have any explanation why the flush
> seems to help regardless?
>
> I _think_ you're already hinting at this in the commit message, where
> you say that it's not guaranteed that the queue is drained in a single
> latency interval. Is there any documentation that tells us what the
> provided guarantees are?
>
> Other than that the code changes look sensible to me, thanks!
>
> Patrick

The following was generated by my coding agent and fact checked and
edited by me mainly to address you in the second person.

Your question was already answered by the original Git implementation
- and you yourself predicted this exact regression before it landed.

In March 2022, Jeff Hostetler introduced Git=E2=80=99s fsmonitor cookie
protocol in commit b05880d357. Its commit message explicitly says
macOS =E2=80=9Cdoes not guarantee that the kernel queue is completely drain=
ed=E2=80=9D
after one FSEvents latency interval. That is precisely why Git
originally waited until it actually observed the cookie. Original
cookie implementation
(https://github.com/git/git/commit/b05880d357c6dadba8d1d7943f4782fc25e06999=
)

Regression timeline:

1. February 2026: Paul Tarjan proposed replacing the indefinite cookie
wait with a one-second timeout to prevent hangs on Linux filesystems
that never deliver events. Junio questioned whether one second was
appropriate and warned about expensive full-scan fallbacks. Junio=E2=80=99s
initial concern
(https://lore.kernel.org/git/xmqqzf4w8r20.fsf@gitster.g/); Junio=E2=80=99s
full-scan warning
(https://lore.kernel.org/git/xmqqfr6mt9uk.fsf@gitster.g/)
2. Paul=E2=80=99s assumption: He argued that the timeout would trigger only=
 on
broken filesystems that never deliver events, while working
filesystems would respond promptly. Paul=E2=80=99s explanation
(https://lore.kernel.org/git/20260227063118.9069-1-github@paulisageek.com/)
3. March 4: You (Patrick) asked: =E2=80=9CAre we sure this is always enough=
 on
a loaded system?=E2=80=9D Paul responded that even if a timeout occurred, t=
he
fallback would simply involve some additional work. Patrick=E2=80=99s earli=
er
warning (https://lore.kernel.org/git/aafifU-befdZW4O0@pks.im/); Paul=E2=80=
=99s
response (https://lore.kernel.org/git/20260304181745.25673-1-github@paulisa=
geek.com/)
4. April 15: The one-second timeout landed anyway as 56cef9cb1a.
Accepted timeout change
(https://github.com/git/git/commit/56cef9cb1a083c47b12b88548bf2126af8bfb263=
)
5. July 21: My (tamird) measurements disproved both assumptions: 781
of 910 requests timed out on functioning macOS worktrees, and one
fallback caused 934,519 lstat() calls and a 52-second git status. The
result is this patch.

Summary:

The 1 ms value is not a delivery deadline:

- Apple defines it as the delay the userspace service should apply
after it hears about an event from the kernel. It says nothing about
kernel backlog, service scheduling, callback scheduling, or complete
queue drainage. The installed SDK spells this out in
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Framewor=
ks/CoreServices.framework/Frameworks/FSEvents.framework/Headers/FSEvents.h:=
763.

 *    latency:
 *      The number of seconds the service should wait after hearing
 *      about an event from the kernel before passing it along to the
 *      client via its callback. Specifying a larger value may result
 *      in more effective temporal coalescing, resulting in fewer
 *      callbacks and greater overall efficiency.

- Apple explicitly describes notification latency as =E2=80=9Cinherently
non-deterministic.=E2=80=9D Apple=E2=80=99s FSEvents programming guide
(https://developer.apple.com/library/archive/documentation/Darwin/Conceptua=
l/FSEvents_ProgGuide/UsingtheFSEventsFramework/UsingtheFSEventsFramework.ht=
ml)
- Apple=E2=80=99s kernel independently implements a 10 ms event-batching
timer, demonstrating that the userspace 1 ms parameter is not even the
only batching interval. This does not itself explain a one-second
delay; it disproves treating 1 ms as an end-to-end guarantee. Apple
XNU FSEvents implementation
(https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d375=
211650a4c1ff8ca1ea/bsd/vfs/vfs_fsevents.c#L1479-L1525)
- Git=E2=80=99s original Darwin implementation chose 1 ms because 100 ms
caused dropped events in a 100,000-file stress test=E2=80=94not because App=
le
guaranteed delivery within 1 ms. See
compat/fsmonitor/fsm-listen-darwin.c:437.
- FSEventStreamFlushAsync() requests delivery of pending events
without blocking. A synchronous flush at the existing call site would
deadlock because the caller already holds the mutex needed by the
callback. See builtin/fsmonitor--daemon.c:247.

Hope that's helpful.
