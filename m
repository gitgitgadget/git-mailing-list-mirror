Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530723A0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712760; cv=none; b=R04ghlBpJjDw9qNGgyuwtouCUugAMusURzBCZUaLzMOk9otIDxH7zz1TS/kbRrGZdogovZ6heLXk49EqfNaehZuLY5H6dXqyC4cxghkb/2/9wLkdScOSeQunSndQBU74B8PiAIJx/cUyzX5EcjLNZh7hMbwLUYQup9+Wc0y5050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712760; c=relaxed/simple;
	bh=/QRfCd0BkHz/bUxZFz/EfKyBvcadwUwW3sqZ17DHU0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZm6qiNYzsk1R6d8d2fIU3myyf0edEtKOTGsfp6QyNbjjQAJUct+wIJ6LMutYEe3pM0DZO3BXUZSo7u0tRP4F7g0cz9rnNdWAkai4kDwh7MoxvUW3QMfHE+IlGOfbji9NMkrQWhko6YDjenJ1BlSDwBwcWuIaTzc17v+cth+E9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azmHimbJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azmHimbJ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso3350906a12.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 01:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737712757; x=1738317557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QRfCd0BkHz/bUxZFz/EfKyBvcadwUwW3sqZ17DHU0M=;
        b=azmHimbJCekFMZuV9X1Xpg70ePV0OZvv9+jpePIkbzPLAgpg0YKG9h/ITUFtnu/Qbt
         +Rb3FXXl3CQcw70O53N7sXZLQWJlIM8w8Pga474K+XpAOIFquMzv65d6X8ZxPXOi3rm/
         ecLx2dXls4XIC+cS4ZFsvUFY9yI6F0lKnm9ql/1qdZIPk/6wbfZl0X59h0NI1W3O8r4S
         8dUAIronMoILqWommrI/5dhNzebPwCDz75U+A1d3VHvJ0PUA3ht7HKQi3YPCwp2qP4Ei
         WC6u7JTdiLfEtOtJVNhjh542LZnlR/lpIOWDI7eYq+2Jg1uMC73+HkHT0Ht0Q/oaOpa6
         E5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712757; x=1738317557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QRfCd0BkHz/bUxZFz/EfKyBvcadwUwW3sqZ17DHU0M=;
        b=nReqhNyutal2crr+wzqVTiaa2cpypPGJKeCPWaeCW8DE/tDD8NXnoadHo2FGiTZ4eZ
         xGPUe8YUT1WKy4VjOy0cdVWGYnLKSN1aoLMVVxx/KVoX+C46DQ80XZRERaBt09EjDSaT
         oopbYEtUjUmob/0xTn8LR89BOcH7Y7QgsSC3N4N8WJVWJRNkujBRaIHuimFFoSaDLSlY
         VWMaSvXQAF3+QEPok5P6P1B5bqja4n5+aDbmzcJs1WgvZavoAApx/C7QYOxwmV2DxEdC
         z+n5bHN+K5kEzov6Q5wew6b2fV30sZV1cZYoRxbTZNtgoqn24wNH0iN5euPjyV5186Bw
         bc+Q==
X-Gm-Message-State: AOJu0YxkzIg5FSRt4e4bR3BzDhC0LNS8PnH3QSNwIgbnNx/A0ZM5eLFR
	pu+4O91cHlXD6T5022XXidmRA7IPr3kKB6KqUDL0LNY5DVkD9nNtmE3qU70gIPkEs6SJz2sX+U5
	IxD+PopwNSP+lPoyBfCLu0Ld4Kdo=
X-Gm-Gg: ASbGncvi0SNS1T1DkNlJWVlr1WEuMMsRfcfmJFG2mfgkEyiTIOecD7CogKqvjQ7vIVq
	f2+MMAknSsHPTSGOwZgQgbyfyy7iCzRI1gpxRv/69W3rtgkMYgbuEuwtPx98IheHC
X-Google-Smtp-Source: AGHT+IHdJzxjYjiztumipMiVklr+KXQY6eQYnWj1aMg+eBTx7dn6MCW+Z6yxpU4ueqzT052YTUjtKJ5odDRIOSD4fWg=
X-Received: by 2002:a05:6402:1ed0:b0:5dc:f48:f01e with SMTP id
 4fb4d7f45d1cf-5dc0f48f23emr3826788a12.30.1737712756561; Fri, 24 Jan 2025
 01:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im> <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Jan 2025 10:59:04 +0100
X-Gm-Features: AWEUYZkJ7WyZ7CBvwrlvXbmwGKNC2ZNIyYFrcaWJfk2yLInQ9opuZqhaImCKMhM
Message-ID: <CAP8UFD0oYM6Cp=NQfN4p+FS3Mfdng1kXQxObtoOG2QuhPN-Aeg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] A couple of CI improvements
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 12:34=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:

> this patch series addresses a couple of issues I've found while
> investigating flaky CI jobs. Besides two more fixes for flaky jobs it
> also removes some stale code and simplifies the setup on GitHub Actions
> to always use containerized jobs on Linux.

I left a few comments but I don't think they require a reroll. This
series looks good to me too.
