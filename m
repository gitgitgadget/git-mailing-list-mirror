Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874914B086
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956112; cv=none; b=QwYDEq3eHHqyPtXjwijdnBbbI9rqMLXkZoTPS8LK5MM1U8Z5lVwg/55V4oX2rjeF/k0rIHbiGa6gqRoQA1SGgLFa7wmZ6C8qc14j+MVbKM34yi0HkWfpphLTsxHQJJ4nBzn4enMB196qO/tGUrmUKGwzJlYKg+QFVJlZSiAmB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956112; c=relaxed/simple;
	bh=2QAZs6EOF8u1gXEZ7zcK0Sm5Uzmw9jkyVCv5pqGnfKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPAdAjRIQ9i8H1xS2catdGhChCFIrWxm0au+QImcKqHqyoF7eaJTsS/K6IFe7yzUklM0zLWHZlpwO/yt080u5k6yfKJ+3Fe+oP1YAh2708dSmOhXEZxF0ah4V18NqIlGVEx5iDbuPxWsSiyrCOMbK7K9Ewl8YDCS+wE06VbihDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-456874b6cc2so808681cf.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956109; x=1725560909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QomfNWXlmbRbN18xLmXbBIrU27PXeS+Ez6oc5uCCsF8=;
        b=T7K24LQc4TQCtpn3d3ZWFVQ5lmQxNx1FBBDN/zfhaJKEe8TXlUw4238JRmEZHQC5fP
         X8WImQumv1YOT9kTyGKY/wnvcBZpoT50SssO7zWfpI/izLxxHtB9sLRB1GAAtg0eGhBP
         daqvumuQVbH2ffjfn2YbVvyOJ3X/3a/i6opOLR7hsS7cnaDhjNhGFT30MREhY96DwBU5
         0DdM9L+raQpjHy6ApjTqHC2nvkSU8q8NQ4l0T4cnjPnDs+3nBX3tng6/7PrG7cdsnNNz
         bCxMEQyk3DCL4zMaNijBlmx68WEUDypVWrcBzbzLx9ZlPLebXkX/J9D+SYLKVBpMNXtX
         9wrw==
X-Forwarded-Encrypted: i=1; AJvYcCX08b7Ht0aGZJkL3UX+XwhHYRxGmbUkH9NDz+EFO1ro3yUiIkSxs66pwmyEgGWTltL68JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnAmm1BlTSDc5/hd80WFd9c6HLu6Wf94YGFtqmsfa+B6qC8by
	GlfPwSwvbOPfF6wONCRGRxujDuNSHVThHSykQlyzMED/G0IXrnKs5O1YpAHMCCnrRCNvl9jf0/h
	FRg6tpAiGE/jZc/nu/Quk3Ii4Too=
X-Google-Smtp-Source: AGHT+IFeuo5GowOHhFY6QFkQrepikiwh7+85F5kuDk4jL7ITIQL2TRScfJqXUcibwp2VBc1Iv/JDWkQytO6j24doNxA=
X-Received: by 2002:a05:6214:d6d:b0:6b7:586c:6db with SMTP id
 6a1803df08f44-6c33e7e2162mr23872326d6.9.1724956108607; Thu, 29 Aug 2024
 11:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-3-ericsunshine@charter.net> <ZtBHecRkFQkSAF6C@tanuki>
In-Reply-To: <ZtBHecRkFQkSAF6C@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 14:28:17 -0400
Message-ID: <CAPig+cTTXmaAjJrOOSKKDKvMAE+yD9wfoYii5C21jGpq=sqtyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, Aug 29, 2024 at 05:16:25AM -0400, Eric Sunshine wrote:
> > Note that the preceding change gave all problem annotations a uniform
> > "ERR" prefix which serves as a reasonably suitable replacement needle
> > when searching in a terminal, so loss of "?!" in the output should not
> > be overly problematic.
>
> Okay, now the "ERR" prefix becomes a bit more important because we drop
> the other punctuation. I'm still not much of a fan of it, though. Makes
> me wonder whether we want to take a clue from how compilers nowadays
> format this, e.g. by using "pointers".
>
> So this:
>     7   fish |
>     8   cow ?!AMP?!
>
> Would become this:
>     t/chainlint/pipe.actual:8: error: expected ampersands (&&)
>     7   fish |
>     8   cow
>             ^
>
> While this would be neat, I guess it would also be way more work than
> the current series you have posted. And whether that work is ultimately
> really worth it may be another question. Probably not.

Interestingly, I'm not always a fan of the sort of compiler output you
suggest since I often have more difficulty interpreting the output and
locating the actual problem[*] than if the annotation was merely
inline, sitting immediately next to the problem itself.

Also, the vast majority of the time, chainlint will be flagging a
missing "&&" at the end of line, so with the inline annotation, it's
very easy to see (especially when colored) exactly where the problem
is at a glance.

Hence, the cost of implementing "^" doesn't feel particularly
worthwhile (and, with my limited Git time these days, I'm unlikely to
do so).

[*] This is especially so when dealing with foreign code which is
wider than my 80-column terminal or 80-column editor window, in which
the source text and the "^" may wrap over multiple lines.
