Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC929CE5
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579140; cv=none; b=L+4ieVUlPbYi6+9TOuuaOoX54P0hFu0wLFoiItJzX5Zutl9tD7OfUVM4lMqjG5iTvdChtIBvI4btz9jLQu+4DMwXqoLxBZ0YwU/vlmIaPm2LRg0WYy7oZcjFWjxT1JTErdPGi3VUzTfJwkDNC4aj1bEoefzTaosQbwSrmErCnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579140; c=relaxed/simple;
	bh=xeT9yeTYoZnXr29AAFy2FxgyznXzqBkmd+jR6m1iNOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVNiQIwrv0M5FOwcQbZ0QnAdmp+8HkR6Vd8cOuS8XgTTJvNkIaCNQudE0rIZtQRlRppvJzwfuVMXgrRPcOAgz9QVqiuZTE9TDrnMy9BZOFac++QcXs6DugTIue0C2K0sI1s0g/azOx/A+CtpOUFtg+Vp9FkkPgrHqJ3QUjpLMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5db7936b3so31611446d6.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 19:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720579137; x=1721183937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeT9yeTYoZnXr29AAFy2FxgyznXzqBkmd+jR6m1iNOE=;
        b=lIQUHAPl6U/Wrrz7K0YPdX3k/kI8b9LPrKST0YMeKtfU/Cmj5izRMFUtAogWWeYVCU
         yBZcXEcr6Ih3GhzVnFTaqU97V3V/O4zhtVOwDmoXzvskqwC+HQmVmSBfN5yEet7RgCFV
         R682vAX+FbFBOk2rnxdwdNrjkGYtCx88fxdVxy+M7bTPy3dpS4zRZu9NVYaLeuEneRlo
         6UKJAvFI1QGxik0yM53OjtMjKNA9WWilGV5aPz6kS57U7JzrGOWYkdIOpPHyAWiccUCx
         Dw/xmnfqXO6GpCyQHOrj6ndc2VfFxmDWKwO2qLtPMFMywJVDw4oYzxLjp3AwFn+llokF
         Aviw==
X-Forwarded-Encrypted: i=1; AJvYcCWSPoc2+WtsH85BgjFa54ffAiR4IRDHnM4i4QOw/sIblrGP3fO63dyQlBhX8/bFkwNTZqc69rUpkp/dUwQr69I9vDsG
X-Gm-Message-State: AOJu0YzkFZZPjbWmHHfSgjHJ0XFrwXznAbp/3fDchn93vgJx4b2nLzx6
	kyzpBiUTc9kMIxAln8WVU9kmc6jm1/HnwY+p32vmU0xCr37RMv1oYUzCo21SSXdLOh/lPLv6rwA
	EmZwSglu61wluY9FFqGXhld6bAKo=
X-Google-Smtp-Source: AGHT+IG8XdWDkgBDrS1bj2z+uRT42fNvhKkI3ZAii1kgi7r6COsVrJeEDjQOhJIaC2qvDB5DetB3PCv4UsTZ2xZm9NA=
X-Received: by 2002:a05:6214:f0b:b0:6b5:26f7:76b5 with SMTP id
 6a1803df08f44-6b61bc7f069mr48405616d6.7.1720579137415; Tue, 09 Jul 2024
 19:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com>
 <20240708090530.GC819809@coredump.intra.peff.net> <CAPig+cTFZuU7zM7poqk4HeK09zn8bFrO37eUZiaGmeJ0yecpiw@mail.gmail.com>
 <20240710004817.GB1526498@coredump.intra.peff.net>
In-Reply-To: <20240710004817.GB1526498@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Jul 2024 22:38:46 -0400
Message-ID: <CAPig+cQ5FgEADF+v+TAY4aqg-rC1OAx_MzuqK=a7MJDYDLLEPA@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:48=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 08, 2024 at 04:06:47PM -0400, Eric Sunshine wrote:
> > One thing we may want to measure is how much extra time we're wasting
> > for the (very) common case of latching heredoc bodies only to then
> > ignore them. In particular, we may want to add a flag to ShellParser
> > telling it whether or not to latch heredoc bodies, and enable that
> > flag in subclass ScriptParser, but leave it disabled in subclass
> > TestParser since only ScriptParser currently cares about the heredoc
> > body.
>
> I doubt it's much to hold on to a few extra small buffers.

I was more concerned about the extra substr() consuming additional CPU
time and inflating wall-clock time.

> So it does seem to make a small difference, but we're within the noise.

Okay. Thanks for measuring.

> > In the long run, I think we probably want to build a full parse tree,
> > attach relevant information (such as a heredoc body) to each node, and
> > then walk the tree, rather than trying to perform on-the-fly lints and
> > other operations on the token stream as is currently the case.
> > [...]
>
> Yeah, all of that sounds very sensible long term, but probably not worth
> worrying about for this topic.

Agreed.
