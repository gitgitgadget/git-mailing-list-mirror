Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343817260F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964057; cv=pass; b=P4WsAHJeOvEeAbFTi4wcgw8moXhaT8w/yrTbEzeVD6H9czhgjvzYJZnfN2ZKdWrSb6hk2ikOlnHnYvoTG49ERGLgLiMIvSqsqOrZEa/mE9u+VkcdSbF7pk8SkzC7rmUZipEB6SIOBAWcRfiEq0AOOLDrMaJqlyhJCvG/2533PtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964057; c=relaxed/simple;
	bh=/tXgsZVI89zdItBdHOKqkGBiS35rWtgAk0ouY5632eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkKjqYcep+QtqLHqXEtpbJiQhpqsACZ/nEEVXjUwRX4SUe45h9ZdOow3CvC6wa/BWvioXT+AtwCleGxEyw4QQH7nHEKjxW8fdccAOE0xL32lFznSuGaNpY1jcK8h3v7V+rGLwAOr2i0O/O455v+tXcRAQQAmPxIYBW/SQTWXpQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhI/Axw7; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhI/Axw7"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3966388b388so44071911fa.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 17:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964054; cv=none;
        d=google.com; s=arc-20240605;
        b=i7MlRjXvq+a56rc/z/Dk/JOf+2jr3z2G4tJQ/a3RaHQWZRRj663IcNPf35rFJhaV4Z
         C8TFCzM+LoOeceKwdGGPtme+nJL4krpZQzjjt7YqJS0DHMA+yalmf8CusUdKWfKdojN3
         5rAl4Pd9e1fgYn4pxtNviOUDSslb2VgvRftSdMNoOCpvPtSOlCLMp3wHR2VNEoZUPYtg
         zZXx9avUdOffo4PvBWLYDGjlt84/N/KqzyBdxxuf47yqyln3IDBh+LMih52205icz71k
         rrwVGjI95BzrK3gqUf++v4ZakTyi/q0PGG4qK+Japmh/LoCLTaElaPDo9ig4tyV7E4nl
         wNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l5WKGtlUHw5agbe55yS1tCusyIU8kIU0hTgrqfj/6i0=;
        fh=IfzZ+ZnGoDMAD4FxmPWAyUlby5mzaCWISjWMwbDp2tM=;
        b=kGfFh9gTS+fifisVRsRpCAJjnJXTljdYQJ9gqZLQWNTBNgiwEEjikH9G0dYcGu28oj
         Yn2cvF8EIoljYySd4Gf4zeaPwgkT5vWPgCF0QUJIhlwPAMnA6nho8wtP6bTrHVnqWh4F
         ac/pW1QyMC9YDGkcxRv/p09+1jB+W71G1onTq6bRqjBvb3IXd4WiRVdwANQ3MQRPHXRz
         eqRHZDoV1nBUi9UmEbzeqc8r4JUBctUJJoDhUBSI55j3i1U64kLVDoksJwLFH12cuGJ/
         6ibBg6e+FC2b1aYkkXoTjS6s69kj7803FkZYSPRnFrgfMY1hrO0Y/oohuPSiknRuo1gr
         4zSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780964054; x=1781568854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5WKGtlUHw5agbe55yS1tCusyIU8kIU0hTgrqfj/6i0=;
        b=lhI/Axw7yzzaf6Lgu1UzxKRJLGYiV5k8qQb8BUA42OQnFnDE5K10M8NgXhw20yF5o7
         BtAkSMdKKNCTujbowImtzIu1o2+mypiqBtKO4HgNKBm3Bq/l/JhuHqqwOUtA3ODaTaSa
         gAWS88h8acOcCv3lgeNgDD35M4GSuD01Io1j2ge6FWccLm+023Myzdn26Hd0wxIKrLcw
         S4MX7uwaT47t4SDYNeA/wv8mq4lO6rSTqkWDOrU4Fd5QJEnWJI2uM9MwFwjnqS0r9Iai
         3P8hnVj11VfQi8ahHhRnVgU1Bu27+hZIhMsLkb+D3yYzna00JRpLwxWeuz4LrLZL8O0y
         4H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964054; x=1781568854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5WKGtlUHw5agbe55yS1tCusyIU8kIU0hTgrqfj/6i0=;
        b=jm7qp8zeGADPJwWodSUSdp1MNYRxnLXpT06u734EFep80YhiG2I/9FdTdznGvJ8XMN
         +O5JeFq3IV2T+4JmvXubJZe1KSmrZd+y2V9TR8/osgFeyLuZI3uH8yzZeMBoYsCSgU7I
         EcUFnlEqR1vN1mj//DIr0y54s5uzuTXRg/1ziDPKr7sfLtKl9eWUTZBxmSR0fD7yywg0
         ibmawZSPYsMKTIFU82dsTitk+7EDh52lJge0g4jzgc9GDYwA3B8fIkqwKn9eiDHK39Op
         FKJ6VMQ79yHigGchzbPn/TFe0eyb6beBlt1poodqCnOGDPP4nzWyoOq7ZQJTlFcBl3zR
         p6mA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZKvFg3HdbF+SIyH6XK8HkrbqpYahzUGzrfRT2auWtfksjmKY9OZAE9wQjwaYY/0+nFiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmXGu2az2WSAgPiQFYtR3bjLK3FHxSKyLnAzZZyAMF4Ppn1rB
	2kCxIulSp5gCtGWqFIEwjzBbAw2ZHQpe5ih4il3TyovF+VGM9S7DoTUiv15AwyWoD5V2Dxd4Dak
	Y5Thl4LFv9qDsd14koU+86jC9N5t7KPUD2IsSCp8=
X-Gm-Gg: Acq92OEtPLL5OtVFqiQc5YSDbzx5vKvCc/DVXWeNssgYqp1flg6E6CDzyrT6qtU6d3M
	i4gXrQx/d++qhCOEq/ZqK8ixErBiRjme5u6O39/FyhaLxn9c7EYaZtlCoGrG/Ak6WwZzyrk9uhe
	OaXfPBZq+hcb3ogxYceWAN/wFeWn9eH767xJWYVnaeetaXziWTAG0HfLW7m1rSqce3skukc/mmh
	qUtuRsZk7s+5+uwp8wECxm9jwgxnG8E+uOqvoDFNqShoUk/pwf5zvrrIDjezFZTdlMaITGGcRDY
	bYrMRAYhajq2QujUqzkKpizNL0wjq5bKA5kN3B2ehacjtpe2An/RDQo8rO1XpkCywkKkLK1jlMA
	pMLgb3i1dcjYEZx+IxWgi6IhyljXNQHI=
X-Received: by 2002:a2e:b8cd:0:b0:396:a647:76f5 with SMTP id
 38308e7fff4ca-396d285f55dmr44210241fa.5.1780964054089; Mon, 08 Jun 2026
 17:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com>
 <xmqqa4t5yyee.fsf@gitster.g> <20260608230315.GC340696@coredump.intra.peff.net>
 <20260608232516.GA357822@coredump.intra.peff.net>
In-Reply-To: <20260608232516.GA357822@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 20:13:37 -0400
X-Gm-Features: AVVi8CflX_dNuTCGJndzH9ukVcs5iuxfeqqaoigb_c0w6n-f_yA2_ckykh8BWro
Message-ID: <CAJ-ks9k5ywxoAuobQpjLUyKt9QJQjkUhfbdwEr2s_yQLVEksDA@mail.gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:25=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:03:15PM -0400, Jeff King wrote:
>
> > > Adding an extra early `match_pathspec()` check before making slow
> > > system calls like `lstat()` makes sense, especially when most of the
> > > index entries need to be skipped.  But if most of them would match,
> > > then we would end up doing the same match_pathspec() calls twice for
> > > each path, and run lstat() anyway, so you may also be able to
> > > construct a perf test that demonstrates a case where this approach
> > > is not a clear win (or even degradation), perhaps?
> >
> > The patchspec matching is linear in the number of pathspecs, so it's
> > easy to get quadratic-ish results by just asking about:
> >
> >   git ls-files -- $(git ls-files)
> >
> > So that probably provides an easy regression demonstration for this
> > patch.
>
> Ah, yeah, it is easy to demonstrate. Making a repo of size $n like this:
>
>   n=3D10000
>   git init
>   for i in $(seq $n); do
>     echo $i >file$i
>   done
>   git add .
>   git commit -m foo
>
> If we then run:
>
>   time git ls-files -- $(git ls-files) >/dev/null
>
> then n=3D1000 takes ~15ms for me, but n=3D10000 takes ~800ms. So that sho=
ws
> the slowdown of the existing pathspec code as the number of pathspecs
> grows.
>
> With this patch, starting with n=3D10000 and adding in "-m" (which
> triggers the code in this patch), like:
>
>   time git ls-files -m -- $(git ls-files) >/dev/null
>
> the time goes from ~15ms (without the patch) to ~800ms with it. Which
> makes sense. Nothing is modified, so the current code which puts the
> lstat() check first eliminates each entry before we even consider
> pathspecs. So it doesn't hit the slow case at all.
>
> But after the patch, we do a preliminary pathspec match and
> pay the cost.
>
> So it really is a question of how many items are actually modified, the
> cost of lstat(), and the cost of pathspec matching (which varies with
> the size of the pathspec).
>
> But like I said, this is kind of a silly case. If it actually starts to
> matter in the real world, I think it may be more productive to make the
> pathspec code scale better.

Yeah, agreed. Still, it exposed an easy-to-avoid downside in this patch,
so I limited the early match to a single pathspec in v2.

With 10,000 clean files, hyperfine measured 112.5 ms =C2=B1 6.6 ms for the
parent and 494.1 ms =C2=B1 17.2 ms for v1. With the restriction, the patche=
d
version took 104.9 ms =C2=B1 2.2 ms against 110.1 ms =C2=B1 4.1 ms for the =
parent.

Thanks for pointing it out!
