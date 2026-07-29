Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42040B38D
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318762; cv=pass; b=ofslUt4oEYj9eF6wbKW6+vOpBBR5VGcgfHkzFfISPBFRyZ1Quv7RLCP5zfnE7UYbF47gz7htYNkmozPGKk588F6HkisH8OE8x4rjwHNG4Ii0+RklVf9lPTW74QLuVge+PHoscaTJAsa7gS5u8Ox+leSsXrcHKZQr8KyP9pN7DUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318762; c=relaxed/simple;
	bh=fUN2DLAxL/X7qvBc3L7GHSTdI9Tx8hL7ZrBVrg6/lWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/st3hNFcWEPjNNsVizqp/nJQdt1ug7kmaYIYxVZLTedojsA0cUIpOJg9UbFHlkToM9icla8RdjYjpQUM4Wi408xafz/iZCdAZfAUufGei+w04PjT3WsHalKUQrpzBero/SUXIZSxe2Ke6PaO5OknU7Ej79hsrTOKSzKG5NAcrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPYh2VKW; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPYh2VKW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so612833a12.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 02:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318759; cv=none;
        d=google.com; s=arc-20260327;
        b=lpxC5jP6TylH6AhB05sZp8b/Tg7ClNdM31E5ibBMoyMtlj4mqICnxGi7ygOHmFDIve
         YgFlOUda7HRhIenbhVU5Gna6xKC0IAGIpP77yV02f8wKtUUV8jEt92TJJEQ6sYlTYQOU
         K2Q9VYu7vBa0+uWobwXalrrW7ONY2QtMQfLUFb/Ej+pXIXaWFLnOW55mC31mT/+z+Ttf
         uSAWTiO7r9M4/+TNTvvFqq7uHr3ahIkt/xzzTFJ2xzw0dzHrR1Vi9YWEkQ0TR9uKZE+W
         pX0J71fy7Mm9S29PWi6m1OCX8wu3bjFA9XalDHcHjuAomVUZyoGem4uBNvTKL73xzs7O
         FYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lPfVPjFG9EGI4+iL+Y4PItsaIpBZqWagvOm2QsFbL+s=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=Byopth7ffJs958UpJXZgMnfaKJXK6hKw5LdRB4OModA03xxbVrpc5Tl/7XS9Xm9lNg
         cwHZzdj1GHT1YQbdpn5BbIg6QX20+s17XzuQZZjl9rq5/r4MGH1yBOUKRRvq1pPyOcy2
         Qox+7zitPkVQR2Yy8kM32FvsHx+iafagVxoQAtmnjDBNvK1/dVMfUnahILXpzfklqIWg
         63ixbb9vHYZWTu4jFrSc8HwP90znzAhUe6SszYpUGniORyxN7doHSmXsQlB23HvIf/BB
         AE6yJLH86axfuPIMNvAyhn3ufTv2IqMPr+6u3YgP9fF2aprYwKfVJqDewsqdaydvm6eZ
         D9Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318759; x=1785923559; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPfVPjFG9EGI4+iL+Y4PItsaIpBZqWagvOm2QsFbL+s=;
        b=rPYh2VKWcn5PiQoXgQp+qD/82snRK05vqJHyGl6nvYsnr0LJdZal7Tpwmf90ZFxrat
         w568MuUbFu1L62tRwT4OdY1cvnmSU3f3vRvxrfU+iSxJXuYgsz7IV9grIkomZ2f/qzDL
         Z9Mtm3LV65ZEvL10rQ7Rq3vnL8dZaNDJd2KrBYGMsfu63YzxCgIXh4H9d0a04VefsmHY
         7gM+aP0U7Te4V8t7qWmFABiRV8z9+1+TBahOBQBDZ4cysUF+q8CsIvOZ6NWyFuEH7ZbV
         YEuLepr9dRrrIkEFoVk8PmajAsmq/5UHLE595eaM1AVWkottL8KiDfO9vbbNUmrc8BoO
         RcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318759; x=1785923559;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lPfVPjFG9EGI4+iL+Y4PItsaIpBZqWagvOm2QsFbL+s=;
        b=KRlyDIzBFt0ndvFPMfAP4TCRDh/4EtFVeEek48+GlzxJewLLSzbO0bYV2ByD/3yF9f
         DovIiGPQVc7G5ul58an+B5Qa7pEYGhvj4bZpsIvX2etc/HZSeeKYxcMsF9KnAWqILE33
         zB5mpzO181DZImtbhY2WKZwlTAagUpS8T4wq6YUm+4aq+Ax9CgZefM5KVaphk9r7d38X
         jXwX4E9PKeU6juHrz2Mwt5967TtZrib/X2KUoFFz1ImG8cczw+hbsK11Osy0lLOd+iv4
         szGBd56ZMkNxjiQEmW5HHSGQXzhsOUshyPARyVXmQu/+Q6prKiKDmcgizxqtGK5Z0oEG
         Nmmw==
X-Gm-Message-State: AOJu0YwaiExcCseOlQJiPn7yc+GoV+LUxucxVUn40nB027wLvluEYOEy
	dnbTdSAufST/Yuv8bI3T8eILr5MakdjvijDCdf3t20FppGO4CCOkcakO5k4C4msnhWXy+3ccltE
	HcUCYhIdeBsq/hLPbE34OjHLSFgwrXzA=
X-Gm-Gg: AR+sD11CHnRm/en8qQe/FI3sOw/tE0EJgW9dLQNvCJvs46dZ2AZ7XgErmFNLmK7s13W
	bM510FxzwxJ8WGCgbFkQmHmXKFJ+hWT8E80DA5dKhgwB5X01A9bx4rwsdFWfE5D1VdFOjN4Kpgl
	jYqTb0xRWDyYcKu8/yJbNuvZZvL3UZ9JWgDjQxJR2ANOvm9Yu5aD502xxpAj1KZ4XOk2YjInQ2x
	6Ye7HkOhiJysyEQtjjXMz/Mo8izYphZWkYtHtAyYmZyHnRJpSKkwRjBTECgrxp/L0aFJORBl6Ql
	xE+WpveR2G8GvMe8cB4LMpNfifj1Ij4NmviWtzp3ftnyPTlnUt4PY1boC4nRfp+jvhNJhK5CQrf
	ewDiEjL1bSHETmzwbzCGmo73E67KJ2mvdAGoMhiS3ry75jDVAoFpCBkLvxA==
X-Received: by 2002:a05:6402:501a:b0:69f:f8ac:5fd8 with SMTP id
 4fb4d7f45d1cf-6a034a6221bmr3067189a12.17.1785318758716; Wed, 29 Jul 2026
 02:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 29 Jul 2026 15:22:12 +0530
X-Gm-Features: AUfX_mwWdLjpgmbx35s5QE4kPrK2337VZwaZO850ikOfhoDFdl42UjjTzuOTetU
Message-ID: <CA+J6zkSvwqy4QdL16oQ_W=Noi81i-dLtAdAQqU3u9A1mQV3izQ@mail.gmail.com>
Subject: Re: [PATCH GSoC 0/5] cat-file: extend remote-object-info to support %(objecttype)
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 at 17:25, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> "%(objecttype)" is already known by the client's allow-list, but neither
> the client nor the server knows how to handle type. This series continues
> the work for git cat-file --batch-command extending remote-object-info
> to support "%(objecttype)" end to end. It is based on its predecessor
> series "cat-file: add remote-object-info to batch-command" [1].
>
> Type is the last property that is identical on the server and on the
> client once fetched.
>
> Whether to support more metadata such as:
>
> - objectsize:disk
> - deltabase
> - objectmode (needs context)
>
> should be discussed, unlike size and type, the rest depend on how things
> are packed on the server and on what the client already has, so they
> cannot reliably match local once fetched. IMO they are not worth
> supporting, I can't find a use case for them.

Makes sense to me. The metadata you listed depends on the local packfile
storage where the repository lives.

`objectmode` depends on the tree pointing to the blob, so it wouldn't be
accessible using the current infrastructure anyway.

> Adding new placeholders has become trivial.
> To add a new placeholder, follow the steps in this series and add it to
> the client's allow-list at 'builtin/cat-file.c'.
>
> Based-on: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
>
> Github CI: https://github.com/pabloosabaterr/git/actions/runs/30155586279
>
> [1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Pablo Sabater (5):
>       protocol-caps: add type support to object-info
>       fetch-object-info: parse type from server response
>       fetch-object-info: request all supported options dynamically
>       serve: advertise type capability
>       cat-file: unify default format

The current incremental approach is safe and ensures every commit
compiles and passes tests. However, from a storytelling perspective for
the reviewers, I believe it's better to do any 'preparatory refactoring' before
starting the new feature.

Patch 3 (dynamically requesting supported options) doesn't actually depend
on type existing yet. I suggest bumping Patch 3 to be Patch 1 in V2.
That way, the client is already dynamic and ready, and the feature patches
can strictly focus on adding type:

- fetch-object-info: request all supported options dynamically (Current Patch 3)
- protocol-caps: add type support to object-info (Current Patch 1)
- fetch-object-info: parse type from server response (Current Patch 2)
- serve: advertise type capability (Current Patch 4)
- cat-file: unify default format (Current Patch 5)

>  Documentation/git-cat-file.adoc        | 17 +++-----
>  Documentation/gitprotocol-v2.adoc      | 15 +++++--
>  builtin/cat-file.c                     |  7 ---
>  fetch-object-info.c                    | 23 +++++++---
>  protocol-caps.c                        | 21 +++++++--
>  serve.c                                |  4 +-
>  t/t1017-cat-file-remote-object-info.sh | 80 +++++++++++++---------------------
>  t/t5701-git-serve.sh                   | 27 ++++++++++++
>  8 files changed, 113 insertions(+), 81 deletions(-)

This series is definitely a lot smaller than I thought it would be. Looks like
most of the heavy lifting was already done with the previous series.

Good for us!
