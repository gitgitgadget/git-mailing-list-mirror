Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295ECBA26
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217159; cv=none; b=B1iTE0iJZ70ABhmk1BNghHL68e6STEvR36496IyJKpt1TU9xw/Jjv8gsIBKfZbYEafnqdEvREE/CNZG0FqnYlIVgAxzGgzHKm/KZAE+o4K78LCJsZHK6m1jFeZyr95bAxosXtXogcPpBqShHuKoDz66u4tS5UouslWXP0rnwBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217159; c=relaxed/simple;
	bh=mxR2CXB+iXQBnljzmd4Lx6E+qFj5HMXHwLciAklwSwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFQ629P2FmpUXBvgFxxMYh6S+uhFwXK3xcys0cLJGOX8d29O8/wOjJMmJ4ZJy0Go/OsqAQNH28osC3zxgmoWYZoGyfCqkUuOKaAoawa4qCQhOilTxqRAtXibvWphrG6DKbK5XDTr1TVtQ2PLCMFhalyf7E/3ynlCkV0hpk9sqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnK6bwIA; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnK6bwIA"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7dbc1373c8eso1373892241.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710217157; x=1710821957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efqL/FHkSK75dxpn12n5thYW1dm0Pa+AVjGeljw7BCM=;
        b=lnK6bwIAo/Q1NKmA2bpvpqHVe81n+r4WoU1z6/fMQfJfohuhHNEOt5THONya0Y5gpn
         83ak+ALnuC22W0jpgyguRWP9w1LBgnpy17wshjROxRlbq/0bkNCy7PNdw+Qde3ZeOTon
         rS/UdQmXjlxPmacPbZtD0JEuogbNuSyg9+24JcdfKKy02T6mg23U4HYLRiuTsVQvg38Z
         CJslYpVuBGplooIbjzx2ArKxSOeMERl+Z7TF4khNEIxssJk8hEBN76wA8Rz+vzHICGvW
         +zlFOXUhAVJGhlW8X3tI8S3UMeW50D8lK3wpzDhecHmdyg8MhdMm8Ba/Ie4ajV/toB+E
         /93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710217157; x=1710821957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efqL/FHkSK75dxpn12n5thYW1dm0Pa+AVjGeljw7BCM=;
        b=AEbVq/snZeEv+oF0uEYOinNUfbuFGxwwSTPnNTLrABqmVhDV+BAa341n4RQHjbHzOB
         asUya2hqSaUOCuw/hIpzTvlFUq7Mf5gIT81/sO75NYvgCvXbk+j/P4AJbBEQtHnFFKXB
         gFw7CnMY0ulo8PkLDyWtChsqrMHJpVbAjzFgx+DpdYymrOsAEEEHdpHBFkmSz/qilk+f
         E4CO7D9pu+SdMSyIShzrSDSFhUzs6gG1u6LF8b73Tr6j6JNQBukl+neCfq3TzPSrqpqU
         yuTr4TwlN+aCVhpISMB1DJyn06FGfqvZyCEJBqazS0m+lsBFcbF8ftfJFIx+5f0P9LAk
         AjgA==
X-Forwarded-Encrypted: i=1; AJvYcCUmmxq1glA3v22zhNBORWYaI1XRFzYDxfVc/rdBkoZvMmLyvcBc7Vf2+XeJsmr/nhzeTaDLFC6YlPMlOXzU/uceEFU0
X-Gm-Message-State: AOJu0Yw+bOK9v7BMLiSvhiG/1qG8t8cSSyHJhdspJdzA0CFkcG5l5dzp
	xoDd2NB5H7Zzs93IbaWi09fQWZ+pVHnTFPecNM1QTDuBaTRY0dh99TTchRo86dqHv1rqRxUoXZY
	G/YNtiLXWW6jheVk2pp21g52vVks=
X-Google-Smtp-Source: AGHT+IFYOAHARrwDJKmnOoMICvvWWRLHI34Xi3mtXN6+3S759Bijpe4hef0YD6L7ZHYNVS7j8WNRrRUvNny7HiBMxdg=
X-Received: by 2002:a05:6102:2a76:b0:472:a0f3:9c5b with SMTP id
 hp22-20020a0561022a7600b00472a0f39c5bmr5888844vsb.28.1710217156826; Mon, 11
 Mar 2024 21:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
 <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com> <20240220025722.GE2713741@coredump.intra.peff.net>
 <70a81f5a-32d8-4517-83ea-8019be5f97d5@gmail.com> <ZdSYxF3Hd6Zqt3Wd@tanuki> <20240221180354.GE634809@coredump.intra.peff.net>
In-Reply-To: <20240221180354.GE634809@coredump.intra.peff.net>
From: Philip <philip.c.peterson@gmail.com>
Date: Tue, 12 Mar 2024 00:18:40 -0400
Message-ID: <CAJ6X7_VsZ2EytWCcpYRqFtG_f+Tx-UXGR4XfL6J1sNhemfG84A@mail.gmail.com>
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for the feedback. Reading between the lines, it sounds like we are n=
ot
quite happy with the flavor of the approach. To deconstruct, so we can eval=
uate
each axis:

   1. Canonical indication of pass/fail (as opposed to implicit rules about
      return value being negative or positive or nonzero indicating failure=
)

   2. Coupling of control flow with result reporting Bubble-up functionalit=
y -
      Essentially a convention for handling die()-like functionality withou=
t
      calling die() and ending the process

   3. Further error context via breadcrumbs (Foo errored because Bar errore=
d
      because Baz errored)

   4. Error codes - Rather than just -1, having a richer, named space of er=
rors

   5. Rich error data - void *data attached to each error (not actually pro=
posed
      as part of promise but may be relevant)

   6. Async-capable - shelving this since it may require further justificat=
ion.

First, bubble-up functionality (#3) seems like it will be critical to suppo=
rt if
we intend to stop calling die(). This can be done either exhaustively (by
manually checking each error to see if it is fatal, and if so, invoking a
control-flow action), or by a macro. I couldn=E2=80=99t find any establishe=
d conventions
for doing this in C, and the original patch series doesn=E2=80=99t really a=
ddress this
well either since it requires a manual `if (...)` check, so it is an area f=
or
further exploration. (Actually another proposed alternative was `longjmp`, =
but
it sounds like that is a can of worms to be avoided.)

Back to the overall approach. To contrast to one alternative, error reporti=
ng
functions a la the intriguing thread by Peff:

https://lore.kernel.org/git/20160927191955.mympqgylrxhkp24n@sigill.intra.pe=
ff.net/

With that pattern, there is no concept of an overall status, either pass or
fail. One must assume that if there was an error, then the operation failed=
, and
if no error, then it passed. But then there is a question of whether an err=
or
was fatal. We know that some errors are fatal (meaning an immediate halt of
execution is in order) and others are not. If we implemented this approach =
we
would probably need to add this bool is_fatal as a field to struct
error_context.

Also, unless a macro is employed, the reporting of errors is not coupled wi=
th
control flow (#2) unlike promise, since PROMISE_THROW() invokes a return
statement. Of course, Peff=E2=80=99s code there was just a sketch instead o=
f a
full-blown patch, but not coupling the two could easily lead to bugs in the=
 form
of accidentally-omitted return statements, so perhaps a macro is in order i=
f
that pattern is implemented.

The lifecycle of anything in void *data poses its own challenges. While pro=
mise
offers macros to handle the strbuf release at EOL, special handlers would n=
eed
to be written to free anything stored in void *data. Which brings me to thi=
s
feedback:

> 1) It is hard to see how we can wrap the return value of the function in =
a
> promise and preserve type safety. Even if we used some  kind of union the
> compiler will not warn us if the caller reads a different member to the o=
ne
> that the callee set.
>
> 2) It obscures the return type of the function and forces callers to unpa=
ck
> the value from the promise adding complexity to the calling code.

I should clarify that the promise concept is not intended to expand in scop=
e as
far as the return value. It should remain as `int` and only ever `int`, so =
no
return value would be anything other than a simple number, meaning AFAIK (1=
)
should not apply. For (2), if auxiliary data structures (additional ints, o=
r
structs, etc.) are outputs, they would need to be via "output parameters" p=
assed
into the function. Those output parameters should not need to be unpacked, =
since
their type is preserved in the normal way.

However to return to void *data in struct error_context, the unpacking *wou=
ld*
be necessary since *data doesn=E2=80=99t have a concrete type. Therefore, i=
f we go with
struct error_context, the *data field should be omitted since it adds compl=
exity
without need.

Since we are dropping async support, I am going to rename the topic from
`Promise` to `Result` as well, since the idea is equivalent to `Result<T, E=
>` in
Rust, aka `Either a b` in Haskell.

Regarding error messages, totally valid criticism that they are confusing t=
o the
user as posed in the original patchset. Eventually perhaps the messages cou=
ld be
reworded to increase clarity, but to avoid scope creep, let=E2=80=99s just =
not show
them. On the topic of scope, I agree with what I believe Phillip Wood impli=
ed,
that excessive refactoring should not be required to adopt this pattern. As=
 such
I will keep this in mind in the next iteration.

There is more to discuss about strings vs error codes and the future of err=
or
codes as well as memory allocation, but this is probably enough for now. I =
may
be interested to try out the error_context as well as a concept next just t=
o see
what it would be like, but do people agree with the differential analysis s=
o far
and changes proposed? And curious if you have any other thoughts?

- Philip

On Wed, Feb 21, 2024 at 1:03=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 20, 2024 at 01:19:16PM +0100, Patrick Steinhardt wrote:
>
> > While we're already at it throwing ideas around, I also have to wonder
> > whether this would be a long-term solution towards computer-friendly
> > errors. One of the problems we quite frequently hit in Gitaly is that w=
e
> > are forced to parse error messages in order to figure out why exactly
> > something has failed. Needless to say, this is quite fragile and also
> > feels very wrong.
> >
> > Now if we had a more structured way to pass errors around this might
> > also enable us to convey more meaning to the caller of Git commands. In
> > a hypothetical world where all errors were using an explicit error type=
,
> > then this error type could eventually become richer and contain more
> > information that is relevant to the calling script. And if such rich
> > error information was available, then it would not be that far fetched
> > to ask Git to emit errors in a computer-parsable format like for exampl=
e
> > JSON.
>
> I think what I'm proposing (and if I understand correctly what Phillip
> was thinking) is somewhat orthogonal. I agree that structured errors are
> nice for computers to read. But it does open up a pretty big can of
> worms regarding classifying each error, especially as root causes are
> often multi-level.
>
> For example, imagine that the caller asks to resolve a ref. We might get
> a syscall error opening the loose ref. Or we might get one opening the
> packed-refs file (in a reftable world, you might imagine errors opening
> various other files). What is the structured error? Obviously it is "we
> can't resolve that ref" at some level. But the caller might want to know
> about the failed open (whether it is just ENOENT, or if we ran into
> EPERM or even EIO).
>
> Or looking at higher levels; if I ask for the merge base between A and
> B, but one of those can't be resolved, how do we communicate that error?
> It is some sort of "cannot resolve" error, but it needs to be
> parameterized to know which is which.
>
> All of those questions can be answered, of course, but now we are
> developing a micro-format that lets us describe all errors in a
> standardized way. And I think that is going to put a burden on the code
> which is generating the errors (and potentially on the consumers, too,
> if they have to decipher the structure to figure out what they want).
>
> Whereas what I was really advocating for is punting on the structured
> thing entirely. We keep our unstructured string errors for the most
> part, but we simply let the caller pass in a context that tells us what
> to do with them. That lets us keep providing specific error messages
> from low-level functions without printing to stderr or exiting, which
> higher-level code (especially lib-ified code) would not want.
>
> I think it could also be the first building block for making more
> structured errors (since those low-level callers are free to provide
> lots of details), but it doesn't have to be.
>
> -Peff
