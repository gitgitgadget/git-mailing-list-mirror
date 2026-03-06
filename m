Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84136B078
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818609; cv=pass; b=Sq69b/DhLRE1OZH7PaVgXX+rBNBlKJD141Z5RB8ONZ1B/WkINkDm0Yi/Eqz0uTahsNzLLq8qMVuz+vN36f2IQlpO9O3AxLegRSvj0LF8Nog+I4MIR201ehL7h7IoPxJmtWuFeoJzQM5Xs7RnjhRh1ISxV+jkr+YicapyD9/4S8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818609; c=relaxed/simple;
	bh=UfFiGL6yt3ZmZp6h8Z64AaaOPVOQJgEKGHIVuv4rFko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiwU5iQaoiyt1D+Gu4df0b0zk+AmDdU8kGRInV17JKgycVFmypsEfInUa9E86XGq44bn0KH4eXlNaxlT/3UwS4ann9Wv9Ltqkzacl2Hk03uEsr6suPIJHRSlbok4dIPzv+fFa1LewnaptNVHz2UNnYbbCAuAX0AqiYd51qx5Rx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oky9Di2P; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oky9Di2P"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso729538a12.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 09:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772818606; cv=none;
        d=google.com; s=arc-20240605;
        b=cD+Ay3yVXkJkN5WWglTeC1wC0yt2jcG3rPYSwX+44X48N6KUsixShLi97gBp7gywDx
         bYixTTWi/fTGqQfebMeIURA9CqL+P1Q03bd+PTguP6o298z8jCx2kEu2/lZo697GY7cl
         mtXthhwm9yPuOUIl4H6EtcMfu2LzOHUOJngy15n6M6CGR25kM8wwV9kkj3P3oR174n6x
         uesq14qPE1ln/iTQzXtScz6//sUPVlYr0iWuNFjYLbO8KpMLh6vHudM53HeKTiJxmTGc
         ygyTAwELclr8MaZpbBL989HxNGfrvmReKMMde4w1zUhn8HHUdUmNyi1rBSeqDsr2KnOu
         0p5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfFiGL6yt3ZmZp6h8Z64AaaOPVOQJgEKGHIVuv4rFko=;
        fh=hynwBwfO334+aoCkoWHcPMy5yaDKMxbTDnZpse3LlGs=;
        b=Bxd67cI+EMZtenaHsHZ5cOmcG6K6qCz/J+m0bBHt+u/WdJ3rVO6tVCeyAtxCmzKlNk
         40vIgFwJBRIQbyvm7Zi05xBtpi9BlE4SgrwwxBWQnNb0ehfMXKKEEzdBxscjId4qKinp
         F/rxHw94VQ9Dgpjth0w67ZTrNPhiBgxsYg/vM3wODPYKIpvA9qGQ+PNCb+gPyuTf6N5y
         Iw6jTn9Rnmqd3t30IW7JqnLsxRiJNJcPUfJLCIPgGs0DHhUy6FTpCEu46n6NyGSjKgcw
         qSisbGQgAubXIgjSg0fi4aQnExNtbOkczy4Kf5rzF4apXM9GIj91Kyl9SheuEPMHKT+Z
         MSkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772818606; x=1773423406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfFiGL6yt3ZmZp6h8Z64AaaOPVOQJgEKGHIVuv4rFko=;
        b=Oky9Di2PjVVXOrh1Mel/X1U6WXAAX1YtmOYvQft1WFfa/WBJXh+uRm70kaPLdiq1B3
         WQWGdC4lf1VQ5nBz4Gp3t3+i19C5ejHhwFawgCRS4mHPzx/jOkel/12lxBSuVimL4sT1
         miJ8bK9i2hZS3F81lC5pFiPBtpLIB6wZeUq+DPcCRjfJygB/G0iGHTGgl5HfD5rz6WE+
         EVPqS1fUEK8ahZk7MnaqyudKT+Jm5VxNhl/yGcC5ORbyxdpuWL16xxCxTIGvFuWCwHsa
         Ia6MeFwMgCbGYylREhFz8VixJeBu/cXwYPGvcqdU1Yx6wWizYRi+mO8Y3XfSjHGwUV7I
         +9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772818606; x=1773423406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfFiGL6yt3ZmZp6h8Z64AaaOPVOQJgEKGHIVuv4rFko=;
        b=QdINI7h6lyG6Jt/aUCk4b9I/u7/WEndardAFSKi4y930Yq3wDlHN2KQ/PA8DhCKuqA
         75MabtjmoX4FiwHBxeo7GYIaSsJHtKLnS43vSYiyoWSOcvYRe5uW5gWChrHsX7lzbxDU
         BFqmMwph9moctRagI0gmCKoDtbH19G+uO6feFri6aRAGC2GavR9ueUnI3NR6Gh51qFaa
         TD/3bfttxPErWizd+Hk7icntDxiNrenH81LzKwsyQn+yWHUxtSceX30++KWcZYvPiHeu
         dvg4p/7m63X7PCpcBpleErX9pHgaC48Ok9bJfj0ABEmFoJZxW/mYKWCBYpgdj/YKR6/m
         ahHw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTGmv8V3gg71b7qwInaBp1yCwJfDIMdEWsCmKizzhBcx1S1sEIdCOwQKV/5p/bkXo1dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrTd4ZbZtF+PFLjO1Es+EejXTB1gyCQ4c5Ox3cfHOeYbAbv3p
	LycSmIGjI0tAjLLTNWfbGN2nUARl1nBbapR4M1508THhqtD3qyvmb4P4PksDh/Zah4oDI+sOpRo
	ciK2vOBIqhCJ5McJFbUgYVlUOB6DxjS8=
X-Gm-Gg: ATEYQzy8DDnG/ejps2SVSONVeac4vtrXNrCPHyl56y3nd/dqsHiAacFMxjqxk6JAHdf
	sf19N7/FqvYhS1W8o1EpiGebB4no/RxzH+vXlDuAjOBhqQRTvjOFBQRquMQFneuGZhgmP0ERgyF
	XoU6LbbsYdcFu1IhdJpc6jwhkmhoVWIaUZpqHh1qmNLqsinloCnSmjmCRCgwlY/wo30C64tocX1
	ndKBPOA3k+XkHbmhOi5Bl7WozIpO034sfEJ7iKMG2dOsSN9/4rHOjLu+sARpjR7zfi2CR2q4LJj
	UosU5NlL5LBovJ64g6IlKr3LlceSaAfMO1zxNFViMiQyEjcs1qKOlebn24Y2u8KQ9WENI+YpHVP
	O+qwTvPf+aSu0PQLzHjSBJWoN
X-Received: by 2002:a17:907:a42:b0:b8e:a142:8366 with SMTP id
 a640c23a62f3a-b942e01be32mr167929966b.44.1772818606229; Fri, 06 Mar 2026
 09:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net> <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net> <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
 <20260306043821.GA3465674@coredump.intra.peff.net> <CAAaskFD7wmtqppatb5T5GMTviieR0Ttk9y4+c3khuF3bZBfE=g@mail.gmail.com>
 <20260306160131.GA3577004@coredump.intra.peff.net>
In-Reply-To: <20260306160131.GA3577004@coredump.intra.peff.net>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 20:36:35 +0300
X-Gm-Features: AaiRm509Yrwu7Kgo4_VT6UoPQ6ChUc9vsRtHihvbaBxR8w2UONWyTZtp2tf1SLM
Message-ID: <CAAaskFBNBEiPW4tLRtPQqkntHFpDTgjwrx8Lqg-qax1Cb_mEhQ@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds reasonable, but - if there is only an issue with askpass and
everything else is fine, couldn't we just execute askpass from its
origin - instead of copying it to the destination ./git-test/
directory?

On Fri, Mar 6, 2026 at 7:01=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 06, 2026 at 05:14:45PM +0300, Ivan Ivanov wrote:
>
> > Friends, thank you so much for your kind help! Indeed: it turned out
> > that if /dev/shm is mounted with noexec then "--root=3D/dev/shm" is
> > failing. If you would like to ensure that the git tests are succeeding
> > regardless of what are the mount flags on some system or what some
> > distro's packagers are doing (more portability), maybe it is possible
> > to modify the git test system - to make it so that "askpass" always
> > gets launched from a native original directory, instead of being
> > copied to some "root" place where it could fail?
>
> it would be possible to do that, but introduce a lot of complexity.
> Right now test scripts are given a single temporary scratch directory
> with a repo to do whatever they want with. If we gave each one _two_
> directories, one for putting executable things and one for repo
> operations, then the latter could be on a noexec filesystem.
>
> But why do we want to support pointing --root to a noexec filesystem in
> the first place? I think this falls into "if it hurts, don't do it".
>
> -Peff
