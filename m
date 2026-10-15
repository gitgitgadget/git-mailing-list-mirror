Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49B4A4995
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095100; cv=pass; b=QNa2OswBsOzy6o2ajwY4F+Mg7xuIIexaQDPsJIy/FyZa0m6RCXnyQRnfZLhp/DJpTvkJRZHTqE6/plZMWTWCz33VFMNB0Nc7zy+lq2sRq+eONOCzIcMXHTA5EAwJUIiDmU5dpH7PczDvDoj3P+y43eko/S7/Lo8/Ks0/kYp5tfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095100; c=relaxed/simple;
	bh=zK6l61rOvO4vu/QlHWgux7CqD0RMcAm1Oh7Ja9DHfQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0Xo/CnC+7uQxc9LB4M/nrEv7uNIVIJDkRtg6XKvvRzGlSOK8wmhg5BPRr5tQ74va/eNDrS9Mm6wwJOybIuROcjL8RqpX54Fu8EeRQLCjLZdodAqtybaqO9sRzjJc5h6UkOHO8SrkwvwxkVeCzhfocGpvClTty3hIqf3zJeJcBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0NISw6M; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0NISw6M"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso1809155fac.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792095097; cv=none;
        d=google.com; s=arc-20260327;
        b=c9DZuzn+chgg2dx+EKu0n/xv2hUKt79HFCNM7VizC9trNO8EF9X8zXKR0T5PhYPNKh
         INUATRenXpgXMgHORZq4JSri9kI54ST3lQCuIm8LXPUHfnlWWr7Xf25Xb2nMyhgWmDa8
         vb00qdkg39do6odEiWczatkF8qxWbunW141EfB5I+SeJCttmcu5hS6IqkkCDvZxzp2J0
         2QfdlJoKjco5FcDxaoGFI+zFqgKCz+Fv8CAIHUU/DLBTlhNaC5TAbybtr4+slPS/6H8d
         P6dvHnKBzHGmbE/JHB5niN/fBN8YIBU0pQFjMSpECOUFImZl8PF1pYkrqoAWJtnTUzZU
         EXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FQGbu2Me2oNxjDNNGX96xSy45bVD9NN3XbIXrGoG3/E=;
        fh=2PECsuwM2P+0HCuPJZggfx7emUJu8zadisJj0up3YuU=;
        b=DS8hvrLX5pVznNbrt83cR9sscDjxs+5x2T07Zy09nLXoXkEJUKyPV0fcwy1RkaIxIj
         /tcRe0qYU7CKcu/C+H3be5+lOUkF3r2D0fuvk8EVopQgr9u/CnF7lshS1FfmMzVQWyui
         C8t/bWyvk9QrIz4VoMieKlsoNxJSnCeSH8wdLT5Zpt+Mz6txyV5k71ObX3+xBvQfCord
         DYoDi/zcUElNdm5FVLjEY0gXkseQzD3VHrTXvpwAQE5KEsBygVANb2Zy3uRaKE98H1NC
         bGyAWz48YpfGwQNevsiV0yQwLL+7rMtGH8Wgp8GOwSfMiu8wAl21iTZKn5vrpKpxK95c
         wKCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095097; x=1792699897; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQGbu2Me2oNxjDNNGX96xSy45bVD9NN3XbIXrGoG3/E=;
        b=B0NISw6MafMUy9NQDWRemHUAT05M74SGSg2y+d6/1XuYZbVct/RGf1y0CC+dx8mSk0
         4vfTJsftoPRZRgU82HPHlV5A1ZNrUgooeduEfu4OS8zizlBVx50+U8XR+zJNRL347UVk
         B7/VWVUCsrTOqKu1hkm2aNXN9xsN3SmuW2Iwlcl2WbcJjFGiU4cUZWuKpfvSwIwIoRrP
         bmJtLuzMdUHpQPzs9zdZctyOKS72gINMwNFRqIf5EnU3poRSV6+tXBrxYIEwO9KGaGqC
         twZlL5nT7sAK44qlUFySdUAsX8Sp47whethvFgRV4QajTDkuTr/PjLL7EATY0on1KHlO
         toog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095097; x=1792699897;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQGbu2Me2oNxjDNNGX96xSy45bVD9NN3XbIXrGoG3/E=;
        b=s838dzmtEgNcENGzcjqInyLPOxxSMyZU3BgEXO6v6esMMhavW8XMHsJVTJW/RTxXzd
         B9jtmKxA2TtaQfuPB2usi8TUa/lQOibqgrJeOpNK3QqBr/fOXwI++OFdr2pbQ3FZzGKv
         kFigxRZbcfMETjYPgVQ5Fcb5pGrMIFxpNfNCnY7txVix616TMI7Zc74GnWpK6Pe04djA
         zvVs5HTRc1ObsLol5ax1yRgYE6ghB3QJH4Rmr7FY0gbSp2CMVRhVrhH+JbyUszuk95vo
         MIrDhAn8jMKMy5m1yQ1TiXppSl+GiGcZR5v+0wvlxMtvdcd4teuDcYmsMJQFXRQX5XrG
         NLvQ==
X-Gm-Message-State: AFq9FYL+EdLhrE62H72fe6TArzotqEsaxrTdXWK3RZ8+3x4gnCWTnnJl
	kThggnF2BdO0iAOgHkENVkWzPBRG55ca5ewZrxuTufQq/w+ZwkxkEPxS+ctYhSg9FvXNUOmVMxg
	mkzloduLItnJdGmPVuIc+kr1PhtSw/WglEbGxa1w=
X-Gm-Gg: AYBFou2/4H4fJETaC+Mn5MwpqqA+IRhumBmvwnxN0A9ka2oDFOZzR5At0auP3KS7dxL
	ej4VUgYE5u+vaxSc0CwCNOwW4OAXsHfPb16S9m6VshJPPuoNEwu/duxTqEHv9tNUljhk1U8ktM+
	419jf1uUCnkTbVt768O9UBIq92TAFcA30ClWq4ebGzYim2/47zjOSldomM5EOz8EUe6LjMu7OmY
	GXAngsYHeDSm5tHd5/3kxVT2F3UmHDc7kB4fnjEqUrFfFwjjBwHuUWvFMQdgQNsQmlPUjJNGbWO
	bkKzP3pJrhkaOsuLRw9arwgbT9zGQDnc8nlQ05D5hyTrJiTiOwy/RQ==
X-Received: by 2002:a05:6870:b009:b0:48f:e0e5:a1ff with SMTP id
 586e51a60fabf-4a2a8b30b3amr16124428fac.51.1792095097367; Thu, 15 Oct 2026
 13:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014172333.2224123-1-andy.koppe@gmail.com>
In-Reply-To: <20261014172333.2224123-1-andy.koppe@gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 15 Oct 2026 21:11:24 +0100
X-Gm-Features: AclHuK-gO0hjOulnVWY_DVtHtAziVKsiyR3wzVsS6lduSmr5xFy23mRMfPDcKz4
Message-ID: <CAHWeT-ZuZ8ScKpdiV94UjvGNJmsv8vwy41Hm8OSCSETciFRh8g@mail.gmail.com>
Subject: Re: [PATCH] pretty: fix lost indent after newline in %w()
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

Andy Koppe wrote:
> After a hard line break, 'space' already points to the first character
> of the next line. If that character is whitespace, it was wrongly
> skipped, so the line lost one column of indentation. For example,
>
>   git log --format="%w(11) This is%n  the %s%n  commit."
>
> printed " the ..." and " commit." rather than "  the ..." and
> "  commit.".

Admittedly, that's a bit of a silly example and test, just to keep it
small. My actual use case is "%w(72)%B", because I often have to deal
with repos that don't stick to line length standards, which can make a
visual mess with --graph or with wide terminal windows.

As a better example, lists of files and their changes like this ...

- foo.c
  Frobble.
- bar.c
  Bobble.

... lose a space of indentation, thus breaking alignment:

- foo.c
 Frobble.
- bar.c
 Bobble.
