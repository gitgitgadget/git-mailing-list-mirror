Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCD224F0
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403408; cv=none; b=oKFhz/chqxgXKPY52RlNmxUdRBJ6CnKiCZozNgvTcz5+RmgYdgslpmgaX0f3NfCLXJs+nbjGxQq7p8PpAzuSNF5eerhG34HteyqpamNR9aqe9wBznugSo8WFfQPSsl7sbkrYH6VXgJng4Z7RGuq3b/1aWPYRrmzVF3ytlFRD204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403408; c=relaxed/simple;
	bh=BR4JHUsjWA/IsLYfkeex8VhIgtRp9mmi76S1jSry5zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRg4VaqcyUZNoHw1jc5EGzeKRgydJpVpsvRCNrD+joTwBG9eQ8Ug56l65RTcXLF2AzfRVRSLhqKwphB0wHzJN6w1lmzrWYyUuhMeVgtC0tVSEn7P9mlCZ1CQ/CwicAGGmtYJIwXbbTjYVT5W1cPOXEqAoMK++3j+zbnSiJngz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=spZlmkV4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="spZlmkV4"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e4244413so30515727b3.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728403405; x=1729008205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR4JHUsjWA/IsLYfkeex8VhIgtRp9mmi76S1jSry5zk=;
        b=spZlmkV4NWE/u4M+xyA6fllGbShUDMPutCImQUWJ7yXHN7mqztOvBJXof1aPi9daCQ
         3q25Hgf+Hxda7DGs5FOO5Gz8643fyAvPGFy/MfVZ1PALqR6kQto0zaGn0n/6RxwZm8wu
         e3r2ZPpDpI/0Yy8p/eNZmNpyZyNC1IJnDo5WeEOWXFRQHAYprmUiFKcWeT9kq0+Xm2Yx
         ERrHWI+AT35mCCEINIgtsOddYm8Rk/Lm+Q3aadrQOg8uXU7Cm6m/rpKaqgpeW57NSTvq
         IoMYdF+WAmfplPzCIMkxToTj3rx4aiTXyAM7FNdCdAYUcpSSy9YjAXkykertRlLIDaPI
         C1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403406; x=1729008206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR4JHUsjWA/IsLYfkeex8VhIgtRp9mmi76S1jSry5zk=;
        b=Plxsy+mdvOxv9XJGYVCg0Y0K8VW+QVAeLgy5p941dHFGupvaPhSQbFDetYp3sgH3lR
         /Ung/eT+HiXJRUkeQp4oRMJs/lgES/MN9PhGlKBgOBulIWKWId3fY7upbggdSBlVZlZW
         HM8vSFyLE246V1SQPgIa0RIcmYP7Tu5QhsnBpicUJdvKuxh9Tin5PzOomlQ/FghVK0OF
         /Uo9F27p+XofiJax7zYNKxxoh7UGcQ2jfAaS3RIAW6LrDIPvQ/5qTAx5pv7zvAZKit4T
         15BBngh8r6dxceV/TXqlMwstl9bRErFlAJZHGb8JH1KrYPYUBqanWEi1KfF5xomubVln
         pCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJrLtNhOtj3aB3f+pGHyr7l/HKx5qKXocrPXC6/FeoTDVUfah4ryr7WiQN4ePAq+rlJ84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSOz9UT6nWQJ62FlmwlW2TP84BmwV4SY1P85cLI6veCx5VAc/
	Tg99efaaN32ZjIV8eW7+3FPxuVexrhIp6iePIgPBCe+btimNiRroyjIqzuLHzMwe3B9r/r41Sh3
	u0sjtQsDRMQcYBjEJ+VfkHz1A/JSkvWqpuSuTlBT45Zqs7YBWcPpgZau4sgkKja0s0VgdvJTbHk
	zWzhx26YtJTJZxPrnVFaiCHcWbWE4y+GKF8RoGHAMsMybWGYzUVhmnNgEtJplK+xnwW3MOnhA5i
	SxnUL7FbZEiJPl86JQVrroRFfeMQpIxoXVN6aEaKuNx8htqLvI5y+133/8c/IlI+NQIZaLyhb0y
	15jeiFuLLAw=
X-Google-Smtp-Source: AGHT+IEzeNJdV2+chR6U9zx2jh/JkV9KsSotIhbHAZDBSNaK43gQuzQojzCALPfqh2s5XdkeJK8mwlJN0JiBb/KgfSw=
X-Received: by 2002:a05:690c:f13:b0:6e2:1545:730 with SMTP id
 00721157ae682-6e2c6ff1688mr150689497b3.2.1728403405423; Tue, 08 Oct 2024
 09:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
 <20241007055821.GA34037@coredump.intra.peff.net> <20241007060813.GA34827@coredump.intra.peff.net>
 <CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com> <20241008083121.GA676391@coredump.intra.peff.net>
In-Reply-To: <20241008083121.GA676391@coredump.intra.peff.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 9 Oct 2024 01:03:14 +0900
Message-ID: <CAOTNsDyxmRZ155vV-Jh=1obMnR+F4ExY9B136fiGk0Vd23-zrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] alternate approach to fixing fsmonitor hangs
To: Jeff King <peff@peff.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:31=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> I've added in the necessary Windows bits, along with smoothing a few
> rough edges. Especially with the extra Windows changes (which I mostly
> had to guess-and-check by pushing to CI), I'm beginning to wonder if my
> solution isn't getting a bit too complicated, and maybe yours was the
> right way after all.
>
> But I've cleaned it up for presentation here, so at least we can look at
> the final form of both and see which we prefer.

Thank you for the new patch. It prevents to start accepting requests
until starting fs event listening and simplifies the code flow. It also
has sufficient comments, so later everyone can easily understand how it
works. I also tested it both on mac and windows and it works correctly.

I think this one should be adopted :)

Koji Nakamaru
