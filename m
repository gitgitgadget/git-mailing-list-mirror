Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D740188A39
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225476; cv=none; b=Mt4Vk+Np8fBBrD1AgH+tPYFo+/DObm0OiheSRrGNsUNddiU/Uiwon8YEjjyq3k22HlxfCXO0ZszEicY18EWR3AqQdsltGkd8NRKM+uP++1fOsurtc/AtUvvQw6qN1PJ7i7BSTJV8MGKE8hZw9fkWzJu8bNpoAiYToMcn7RkWuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225476; c=relaxed/simple;
	bh=fHYeFhCCwDeAxwjmhqZR3EWqvXEB+ML2lDcpJfDNLu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2jKj71qVEUwyTWpUSnVNC8jU8UzBz/CPzWJlD9ZwgGdi+K6Xvf9dsFZVDAenwqbBvpcW5jrQuLH5qsiiTXKz8EHsW+5ACbYvUuCluPc5LYV8ZVbf0/B8WtNHRmaStCVuN08p5yRbKpm0M02bYVSg/V899wQS+xysEUJMeMNkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf743ef85cso547076d6.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 00:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225473; x=1724830273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHYeFhCCwDeAxwjmhqZR3EWqvXEB+ML2lDcpJfDNLu4=;
        b=p441gDwaIbGD98YYN1E9HW6Tp6+0UdCofApuVxTvxZevO9rOO7FfP/UTf8qAj9uIeE
         hSP7rqW1sxnzWY5vM2ek8A5K+0upoQJWyDaNPTWvGUZeZ4ui5TKiZSRw6Eb3KtTxsPhk
         EJNTEVkJVQeks1JyLV0kHXfzMKSkKVh2cDc4USp/q5zYoMdNLmHmxJemzZ3vSrTQy0KT
         XEmms14bssC2qx66u21tbPNcZTcMerLDNfCDWGVvUenp2x6HDk3nL5N4SZZkt8CTWcrf
         /RUM8UOAQXFXDk/dnq+cIrsy5KYyG9jtZPfaj+gkPJL1nl9OoA7YSgHkznARamWPhj0x
         fgCA==
X-Gm-Message-State: AOJu0YzT1FvECT89JnTnVDTKmnCwe0ohJRpRu6wQ+5ubBqVETYBP8iOz
	P+cNbghgZRjcnXDD+udYXRwByvsFICB9izbAYrfDaymTbpmzSEqsx6P96nhTR3HWdx5tKL1jkCd
	2teJI5mP6F857ZW51Tk2eMCVZfOw=
X-Google-Smtp-Source: AGHT+IEKCRdrKxffrSFcn5XMGiz4m8ABYeG7ncD8wIqqkhgmgtI6/70kTa+FbltX3MYvyPVKuLlPTe0T634X6RZegxo=
X-Received: by 2002:ad4:5c49:0:b0:6bf:7d3c:a24b with SMTP id
 6a1803df08f44-6c155f5f31emr10451856d6.0.1724225473258; Wed, 21 Aug 2024
 00:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net> <20240710083416.GA2060328@coredump.intra.peff.net>
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Aug 2024 03:31:02 -0400
Message-ID: <CAPig+cRiVnVX=7y_ZnornQabOh8TaCCud5T0=ynY1+BZEYYNFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] here-doc test bodies (now with 100% more chainlinting)
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:34=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> And here's a v2 that addresses the chainlint issue mentioned by Eric.
> There were a lot of patches flying around, but this is only the second
> posting of the whole topic. This can replace all of what's in
> jk/test-body-in-here-doc.
>
> I won't bother with a range diff; patches 8 and 9 are just the original
> v1 patches verbatim, and everything else is new.

Sorry for the late response; I only just got around to reading this
series (which, I know, is already in "master").

With the possible exception of one question I asked[*] about patch
5/9, the entire series looks good. Thanks.

[*]: https://lore.kernel.org/git/CAPig+cTACjostXvjJMnLEpgbnfat9cjM63pLXwNJm=
1=3D2P3gq8g@mail.gmail.com/
