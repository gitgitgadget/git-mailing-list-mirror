Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF21DD0FF
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734823441; cv=none; b=pjYcvQcqRs4HsH+74bWHy+uOOvZq2QrDOKTnudjcprQklMrIeeK+B47SDYbw1XtH76G/2leF9IwYd37yECGU9z6bz6pbcuY6qDO9fegJ4xs1OM5f2vNaIiRlXSNq5jRQp2gRy5CUQGRETeNXVKImU+lfG48fTCnm6AzleP1/DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734823441; c=relaxed/simple;
	bh=7egT7ryguz8vZ6h5Yf+DY+662bfayGITib0pIFgBw/Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EZIBwHDbpabV5n2GfAT6F9CBHeL2zGQ/ruRIcMWyu5DAIq7nmXwiMgnhcEEh5gCEpFXC7aDlsh1mZ/jaiw8CquG5ZN4unFgKoUYOFZ7cMZwMH5LgN3lFDpialUkvg0TFFav1qqhHtMqsuVD1nSFoHzCwvSPwVYkH1Zt+oeAIXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shortcircuit.net.au; spf=pass smtp.mailfrom=shortcircuit.net.au; dkim=pass (2048-bit key) header.d=shortcircuit.net.au header.i=@shortcircuit.net.au header.b=d7ahQjhG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shortcircuit.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shortcircuit.net.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shortcircuit.net.au header.i=@shortcircuit.net.au header.b="d7ahQjhG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e2766994bso1570940a34.3
        for <git@vger.kernel.org>; Sat, 21 Dec 2024 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shortcircuit.net.au; s=google; t=1734823435; x=1735428235; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5kyzDMexS3ELbp0D7Ssf+d2X6PqBf7iCnbO9ACmOlLo=;
        b=d7ahQjhGg/jxJCpIPLOe9YhSlB2g9HmW8NS5aQBt32gR5XQw4bpoP6AaDKvT2TRWx3
         TDUuzyLil3fT2I+VT8PcsIIIegeJgC9lr7poO/HoZ13Zlkzl963tFqXIOBQR6KHDfxxt
         T9jtCJjR++W6iCrEsireQb4wUJ+so8YN9xy2Vuv4JDpxB3PzKPMC9JfJ5ky2zXknIJJ5
         ALlUgjRdaNMW+vXpZ1UnCbo/r/SwXwiRQnUP9R5SG2/culJFUGeFOntU8ASbFMd9++MB
         pcPcqOwqOrmzVdCsG8kOY1HiYCVDYwN2iYECDs3CY9sT8AF9tqNdLCEhOOZdugDfDCY9
         NJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734823435; x=1735428235;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kyzDMexS3ELbp0D7Ssf+d2X6PqBf7iCnbO9ACmOlLo=;
        b=aKi9kpfKKVYh6tJsf4q4/wbJXrG9adsYh2uZUBWQeFA8A/cLCAvfJ4oNrt2YVr/Nhk
         KM+NQlQaxeg1DCHPr2DgsTW6iQfC4BVoanlkEH+YVjBqZzifgkgZOtXff+lNn/KOFnxg
         BTvQbMwIrDrGHX3C0eqyVwrh9tsZ+F5Br0ZHqDOWu6XIGppgRmJ+hEoRnuT9qPEGCx+h
         FNpTvn9kv4VJF5TiQwiMqYxyhXVEfC80dMg5wrdwyPJEyK2af7im+LET/18sknwjSmBF
         9OY42q13xF0Df4m8LrGHmGpalroqRuHfGygePcsGQtIOPTpKhB8eK2SY6nvShQdkFYJm
         P/rA==
X-Gm-Message-State: AOJu0YzGnwKy6EXVWSvrIVqKMKRPsbXYaCOKtnmZ152vxJsGLYPM5pJC
	LIW2SaA9ql6vTUcm1g3uov3K18/b8Noek4XZgkKR4wEwx0nttnGQ9y2biFnEzeEESoB0mZLeZSZ
	fKzHebdCotRoIVZkcESplOMjrq/MDHzGHrxwdQzI/V2YgBvXhngoNYg==
X-Gm-Gg: ASbGncv4E7CQ8FlI5estZjha4yEbzhIA5DNIypt5v2SiC1IshTb2N3jpXdMJKZfU8t8
	ULJ6o9+dAUtW2vk7tSwDE1Voq/29dlmIo/2biYw==
X-Google-Smtp-Source: AGHT+IHZ6DQ78epWl1GizvAmSSQqMpE5n9oRBjd9g+mOYDEgcHdqPHdEs7NARt+rle3v9NrRYZYlhWZMnYEStupmr4k=
X-Received: by 2002:a05:6830:488b:b0:718:d31:feb8 with SMTP id
 46e09a7af769-720ff6c9bcbmr5887892a34.7.1734823435100; Sat, 21 Dec 2024
 15:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Mills <prologic@shortcircuit.net.au>
Date: Sun, 22 Dec 2024 09:23:19 +1000
Message-ID: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
Subject: Git v2.46.0 and --allow-multiple-definition linker flag
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Folks =F0=9F=91=8B

Been a while since I've emailed one of the large(r) open source lists,
so please excuse me I may be a bit rusty.

For some years now I've been building a very tiny custom LInux
distribution called =C2=B5LInux (micro Linux) over at
https://git.mills.io/prologic/ulinux -- I primarily target the x86_64
architecture and its intended use is mostly as lightweight VM(s) that
boot really quickly but are otherwise populated with "just enough"
UNIX tools, a small package manager and few other bits to get
interesting things going.

Today I noticed that when upgrading the zlib (=E2=9C=85) and git (=E2=9D=8C=
) ports
that the latest version of Git v2.47.2 does not link and I observe the
following linker error, mostly what looks like a missing
capability/flag of the TinyC compiler that is used as the linker
(LD=3Dtcc):

tcc: error: unsupported linker option '--allow-multiple-definition'

I bisected the Git releases and traced the introduction of this new
flag to v2.46.0

I can't find any details of this flag really or when this was
introduced in the GNU binutils and so far I haven't asked if the Tiny
C devs intend to support this option (yet).

Just wondering, can we consider backing this out? From my very brief
research on the web this seems to allow the linker to permit multiple
definitions of a function. I'm not even sure why that would be
desirable to be honest (but I haven't been a C/C++ developer basically
ever, I know enough to be dangerous!)

Kind regards

James

-- James Mills / prologic

Join Yarn.social today! The only decentralised social media that
respects your privacy and freedoms!

E:    prologic@shortcircuit.net.au
W:    prologic.shortcircuit.net.au
Blog: Read my Blog
Yarn: @prologic@twtxt.net
