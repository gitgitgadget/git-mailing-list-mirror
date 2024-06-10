Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601681B5A4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046283; cv=none; b=ggdaKQrFbBKK7pg0NxqS0uoCPoOWRbGZJhP7hKhTYt3kMKvbheVdsXN6EGsqNXyUiy8mb1IwjfDO4jdG7YZR4RoKqAZTKnTGeaAwfGMCmcI9m8LpbwQfEMcFlv3AJ9suiy3p3oFx0+uQfq9BMAMQW/6LXewpLV1bPBQ/xZi5P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046283; c=relaxed/simple;
	bh=567uYo2OHkdE7YRqumZlnZDn43eNveyuB//P30K+kVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlDVHOwCidgBH6XkrMw63dZpUw+GZ5x5pXMwIWXTEkQpalJ9RFQDm1G9KI7AJzOsklCA4lnVLjgFk+h+FaWAj3kkGuHJ0A/Ws4RzzQJGdNOmWsYWJcONDd0D9mM5eN0/568Apd1WTuWO3l5+cb1Tnh5EuaJz/qEr5rpkCAHM7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWZAsxds; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWZAsxds"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405dffca81so31411cf.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718046281; x=1718651081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=567uYo2OHkdE7YRqumZlnZDn43eNveyuB//P30K+kVM=;
        b=RWZAsxdsXPav/Zhl0sEaWNvNhvzJuO3/b2+5jQ8ZfYqrEyS6bHm/dI9HZVDAdtTicW
         AkmmR8Pcys5+eqbNPnadBRYT10DM2IU9wioialG2hm4ZmDsS8ajg/3FC4BVuCfQ7C1YM
         5vrw5x1HYDb3KFBIyODWntLGEhKjpx6FJZ/iV67gsF+SvhF1kw8R2lsl92swX84GKfsg
         GZ7adxxrCjFviUVgMez45BpvFOGqJX8tVJOp5HIE0eYlA/TRutRE15JWKST8HD7/q51y
         LwYj+LWGKhz0bbUryCUThB5AZufT8XnnzbOaU4Eyb+jUUZEdGav3owonkDlQ5qDS8U2n
         2GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046281; x=1718651081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=567uYo2OHkdE7YRqumZlnZDn43eNveyuB//P30K+kVM=;
        b=Z8xWiA69KMYh8brl35CcYn08xYTw09L3ao4KV2lBuB0rv9Bnum4nklGVaBltFmyX8G
         WOZ0hKXSSzdFzwOnGzcNSPXEu47k2gKCg/+9xh/8BxecAmNJaNnuEHFR4ziWsZ7a8KyN
         JdGWahoj4t5glbd/spOXLSn3wnM+18lk/egD3/7w7e80g1qKUzE9GAYsQ9nAssBVsM+Z
         k1eKeNfyvXlJmm7C4aQlEMhxv4LyxE47QsL0cOF3RV13eVxYXBPStyT9QGv7A09siX+8
         2AE6pQJWoWiw4BPW83ne7xVlUA8+yDOy6mMG/+HFEp+YETshqQrKYyKc4KzJZS0nfmpz
         fkWA==
X-Forwarded-Encrypted: i=1; AJvYcCWLPp52TkCQb4yYT8+xcqehmyIf7jVmlGNz0Zd2sq3RUOjAQDuFD+t+hsFEt3PjiemsTLB8+2gO0Au8LJpBGSBDQnca
X-Gm-Message-State: AOJu0YzL0NGMRQsIbAkZ3zhctWt5hhzFGydbh8U8LB/dMnrdEQE5s96q
	yA2hahV0eifsYNWTs1iyXonMUXQ56tPjtQtEcN6EMSQar4eaAWiwwE40mqsnPZo6k6XYdLZE5zM
	X+u7P9mNJ+TMcQVlI3ybnyZCkDgqKeq8KqbvR
X-Google-Smtp-Source: AGHT+IH5YDoKRGlsqbFqLpS9wCSeLBI+jTUWG+P5M3YcO8J7PwTRny8LE9P/2q2dtDyZjieq1Cqiu21/QXuZNzFlMPs=
X-Received: by 2002:a05:622a:5a89:b0:43f:fbb0:b74 with SMTP id
 d75a77b69052e-441416a108dmr337281cf.29.1718046280917; Mon, 10 Jun 2024
 12:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com> <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com> <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
In-Reply-To: <20240608084323.GB2390433@coredump.intra.peff.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 10 Jun 2024 12:04:30 -0700
Message-ID: <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: Jeff King <peff@peff.net>
Cc: ellie <el@horse64.org>, rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:43=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jun 08, 2024 at 02:46:38AM +0200, ellie wrote:
>
> > The deepening worked perfectly, thank you so much! I hope a resume will
> > still be considered however, if even just to help out newcomers.
>
> Because the packfile to send the user is created on the fly, making a
> clone fully resumable is tricky (a second clone may get an equivalent
> but slightly different pack due to new objects entering the repo, or
> even raciness between threads).
>
> One strategy people have worked on is for servers to point clients at
> static packfiles (which _do_ remain byte-for-byte identical, and can be
> resumed) to get some of the objects. But it requires some scheme on the
> server side to decide when and how to create those packfiles. So while
> there is support inside Git itself for this idea (both on the server and
> client side), I don't know of any servers where it is in active use.

We use packfile offloading heavily at Google (any repositories hosted
at *.googlesource.com, as well as our internal-facing hosting). It
works quite well for us scaling large projects like Android and
Chrome; we've been using it for some time now and are happy with it.

However, one thing that's missing is the resumable download Ellie is
describing. With a clone which has been turned into a packfile fetch
from a different data store, it *should* be resumable. But the client
currently lacks the ability to do that. (This just came up for us
internally the other day, and we ended up moving an internal bug to
https://git.g-issues.gerritcodereview.com/issues/345241684.) After a
resumed clone like this, you may not necessarily have latest - for
example, you may lose connection with 90% of the clone finished, then
not get connection back for some days, after which point upstream has
moved as Peff described elsewhere in this thread. But it would still
probably be cheaper to resume that 10% of packfile fetch from the
offloaded data store, then do an incremental fetch back to the server
to get the couple days of updates on top, as compared to starting over
from zero with the server.

It seems to me that packfile URIs and bundle URIs are similar enough
that we could work out similar logic for both, no? Or maybe there's
something I'm missing about the way bundle offloading differs from
packfiles.

 - Emily

>
> -Peff
>
