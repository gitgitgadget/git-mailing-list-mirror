Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942C309F14
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298082; cv=none; b=Njh/foLD94OA+3tIt0dXNYJCLoybF0OKjpzfIFbmqr5TCjWuNlDOslqDxGVWHg3RmL1lrP1v/GpElboeBLPHWjwCxNYUaF5KeUNeuIsvUcnqEimY4r2fq1pLCi5+5aQuJkpYeLeRZnwFKbBnka7kasuXtX2uNiXzXL43wIPEE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298082; c=relaxed/simple;
	bh=eeQN6wCntIoa2az1I26oZGnL/s6MjadFqjPa2gPdrB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDGo5f+xreCsQA16qvjfmitZHI7dqxtCzXrqER18Y3X05q3nmRHhh5ZwsOp88zsShA1ZXKbnEGqgKKUhOTOiUSgkVFU8NKOzTP7ee01xu1/BMiLku2BUAvb3QKsPpJoPI++a/QJX3ZXD9awleBLIkA4QxC3olqIL61qLPbnaXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkPATT+U; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkPATT+U"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d78062424so51750166b.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761298078; x=1761902878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkOymqJCJg9BieLRXkJVFu8D1XOLKSO6DwosfCqD1IE=;
        b=jkPATT+U+/2kysIRAUWhUJxEX0XsTe4YHtthihrgZftABg2rMaUnw/EbSuz3hd3k1y
         RHYnv0fdFngK0R151uGQVmFtW2ESjneBRGvQJYk39YMBkm3Oaqo5+Qj/nzvzodg7ZB81
         WNuceHMPOEdexavrBvNsDsXjtpKjEaFz907M+6U8eLBRf/6jvXzw5YGYszGQ+v2joQs6
         5Su26/usnQHqe8cqz/wivpBSiCOhz24LCzqeKC7VEm6z3/lIKotAwW7tQ/uyUrVPBIuY
         dXrHPm6XQYTYalzHCztn+LBpsAPdkOev8Em0CLX4860LVWae9dBwEojnG04cfyMbanlA
         MipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298078; x=1761902878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkOymqJCJg9BieLRXkJVFu8D1XOLKSO6DwosfCqD1IE=;
        b=C4IlKsUp0t3SrrX6WiuNYphau9tmt52eFz9eGihzCej2Ln4/UqiG8gNZVrU5yeDTP7
         xExJff7SsZuLOfg29/WeNjwitVxHD/aqQPbtv5ApCJkmJCkhcud0eUpF7bRS+ARASYFv
         FK0w627VUlVDrjMnyA48g84Xi9WSTwGPMd1tqK3mw3A33xFeoBjdrPg4+RkkjHNXZHKC
         dWfo6SFzaml67UAHM9/BkEfT8XiJu7M5vPXZOuFXjUBflg4g7y9rezs+ri0V03fFSu0J
         lUF3mn/I297Sb+6j5Oh6Wm4rBQVWzsFZJuKUdaHZJ+UxAo87Kgxz3KX7jIsj1Xk4XzKA
         tfYQ==
X-Gm-Message-State: AOJu0YyALFg/fdWrHcPuyf05wym2GWGoUOjnsllq3iwLqPtm6hSDkaOb
	YdvlgGlrWgpiHZ5YdyscKeIswL2q0UrBtSjq4pxMNwXPjTmdjkAs7nSRfCS+DMO0CQGuWmNMm2g
	acID8btospat7BAUUXrnKwhlGW+gKzCs=
X-Gm-Gg: ASbGncuovo2DdDGrl/qhYSm+gNCvWTLancDad+t3aRTOud4ajNQ4Uxe/PpRBy5XED1c
	ENb8qnn9btTuKL1q21imiVYZViZLJmYXkvOR0pzxyOSqcvdfmz8OZXEPtv9V1gBIQoAgQ4Yw2bB
	dSSmfzB2qBG+2Pd5xI9rh2E+YI42OJ7ZYw34FpFHIgDZknPCik17O18p6wMir4FSt8imiY6RH9w
	iY8oAp3a20PqOHeOJDLTdGfTPcJ2Xgj5bddmScBMU8TALYKigrk/lkY5fjb
X-Google-Smtp-Source: AGHT+IH0FQvf9Ab+TItFY+oWNxsYtpFkbgtBjVoplxwhZhDwQZ3WuVX3AZTZ9yAV6dbR56AElh3Xw9StDQS7cxDudZM=
X-Received: by 2002:a17:907:a0c9:b0:b5d:7a22:ae41 with SMTP id
 a640c23a62f3a-b6473245835mr2991893866b.24.1761298077806; Fri, 24 Oct 2025
 02:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <20251013084857.1646783-6-christian.couder@gmail.com>
 <CABPp-BGQ=3Tuik-PCerkaK4R0b1roSVLXLKs2-+E11vDrH6WaQ@mail.gmail.com>
In-Reply-To: <CABPp-BGQ=3Tuik-PCerkaK4R0b1roSVLXLKs2-+E11vDrH6WaQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Oct 2025 11:27:45 +0200
X-Gm-Features: AWmQ_bmUrnWgfQjsf2qW6piopCn-HTzFHNhJi6s2uEdbuxeDwuN5YMBCAS-1TIc
Message-ID: <CAP8UFD01-JDZisaqMUEGd7-WJ29r0eLcXuV3RjqeWNtoJ3-QmA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-import: add '--signed-tags=<mode>' option
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:04=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 4:49=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > +--signed-tags=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
> > +       Specify how to handle signed tags.  Behaves in the same way
> > +       as the same option in linkgit:git-fast-export[1], except that
> > +       default is 'verbatim' (instead of 'abort').
>
> Sorry for not catching this earlier with the --signed-commits series
> (was otherwise occupied), but this worries me.  If we ship with this
> as the default, people will come to depend upon it, and I think it's a
> bad long term default. Long term, we'd want to check if the
> signatures are valid and keep if so and do something else if not (e.g.
> re-sign or abort or strip).  Maybe verbatim is better than abort out
> of the options you've implemented so far, but I think setting the
> default now to verbatim means people start depending on it and we
> cannot change it later.  Could we change to 'abort', for both this and
> --signed-commits, before the 2.52 release, and then re-discuss once
> you have the other options implemented?

"verbatim" was already the default long before this patch series. Any
tag signature was copied as-is, as part of the tag message. So it's
possible that users have relied on this for a long time.

For the --signed-commits series, "verbatim" was also the default
before the series. Even if importing commit signatures has been
implemented more recently and even if this is marked as experimental,
it's the default in Git 2.51. So regular users could already rely on
it.

The --signed-commits series has been merged to 'master' and this
series has recently been merged to 'next'. They aren't part of a
release, but at this point I think we should send separate patches to
change the default if we want to do that.

As I plan to work soon on the new modes that would check signatures
and do something based on that, and as you say that it would likely be
better if such a new mode becomes the default, I am reluctant to
change the default mode right now, only to have to change it again
hopefully in a few weeks or months. If you want to do it, then feel
free to send patches changing the default though.

> This all looks good to me, other than the default as noted above.

Thanks for your review.
