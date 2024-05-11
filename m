Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BE1DDE9
	for <git@vger.kernel.org>; Sat, 11 May 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397519; cv=none; b=GM25994NKf4BjfWbG8ZuywJbqYAMpMnB/9jS+UTk9GofSScucP8YxLyocEA8/uqdld/nUax10OZMiQFSuv0EqGuQ4IgL8JC0jgXzXnv/JMOVb7jdIX3laQSd8L054rVrjiPOt1xddDcff6vVrT90uTdfvkrHxLx6KxWqhNQCsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397519; c=relaxed/simple;
	bh=OprsZXIhtUd6/RbdE4Ha0UhKW1wDhTqWWof1i54Bl80=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMht8B4YPohLTkMha2euNju05HK67/RqgmmDK2p4qwJhdYEgk4hQp+udmkeuYICjRg3MJoBM5KI1FZi39RxccDAY7Qzd34erX+1qLNgLZpTJY9fRICA81ym4hIYPYcIfuhxko8nU1C6qtAeTFUZw2WExMKRW5m0d662lW7IVfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIXVt/0+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIXVt/0+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c99fcedac1so121901b6e.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 20:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715397517; x=1716002317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJakr6E2QOVZvmCU/YPz8BQqEZ6I9l8wGlIRWbbW/mc=;
        b=MIXVt/0+QSIl0RIyJ3AmfyNjYvZBKB2b2bBvAtIn/jka2CjNwcxB00+nuxZ9Ft2M5Y
         zjWj7GxW7e9dBgF81Fxn2lb84nRNzuQrwX44ZjACCSv0b75pQm95PzK3Uy8gLaA+M5Ur
         /M6ohAD6mwPEe9vxU6M5goy81nWlc0inhQWslbqe347+Ndg9Q1YDYBRCCwjJQ9LOYGgm
         fsRmIeuTg/Sg+HGvjWu9ABwLEnqmNJaweYPn2QX2KRYoa5pCIe+7BdawY/u/iABQG1md
         TzKzq+Ztdh7EPaX0LpWGf8wk+AVbF5TkjoAB9RYlWdjCIzi+Yft7KiJAzRZQMe7JO0o0
         PShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715397517; x=1716002317;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJakr6E2QOVZvmCU/YPz8BQqEZ6I9l8wGlIRWbbW/mc=;
        b=qMIovw90QP+T24GVC8jwJw1mhDB8IseVX3oouCueaODHmsWODzmYQY7qTK4sKX2/dn
         tJWc2R+oRZNI/0C5jmytl5p9oO4G3VSYnbV0IBBIURZdAAt9GC2w9ThrD0LJxv3pBCB7
         l19l8yGs7UniUtTDRMyxzjdV51M3ovZzwYqmU/WVo6ubonCBR72IKFt63FUWPHpfH4Dx
         1XMUoaZSKoUAoQRMUZh86jadSOXanGT7AGEtTc+GgAg5U0HcARgqiUh3WVlvMLealmS0
         PBz29yDou6exrGA4psEjYI4+YoZW5yaCnpCpo2heu7FXHfXKogb50I2ZZFM6+v6+/p30
         BE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqO/OAI0a1DJd3/3D5NwrubsDWzTSupdh5AoEKF/oErOhRGdqDOEH0oyX7UF75rD3vuIqQ5mM12i/WOhbeH2lYLwxA
X-Gm-Message-State: AOJu0YxmV08Bo1CehLcwepJBSqhD6n7aibSo3bqxkkAufQzgN0HR/pJj
	1fplkNL9u2HdFWKlCgIMHCST0RyVP18SnfucpPj0rXNxdUXE1clCZSEewRo8KAkV3nVb1Qv+/cb
	WdR5kPOFKtW6cUUN8bIVK9qxlYh0=
X-Google-Smtp-Source: AGHT+IHJkA8wRXy1xdVDHG/LrfKJOfn75JhWQaZ+NyRG32Y3x9HBK6VgytGYN/NjJOL7OhhO/Z3gu7VfqR4GhZqYasY=
X-Received: by 2002:aca:2307:0:b0:3c9:9294:8d9c with SMTP id
 5614622812f47-3c997023e14mr4521838b6e.6.1715397517278; Fri, 10 May 2024
 20:18:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 22:18:36 -0500
From: Linus Arver <linusarver@gmail.com>
In-Reply-To: <20240510183622.77750-1-dov.murik@linux.dev>
References: <20240510183622.77750-1-dov.murik@linux.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 22:18:36 -0500
Message-ID: <CAMo6p=GuLtJtwiS+N366ArFB2ejrYxnsy3S9Ud4tCeW=R5R57g@mail.gmail.com>
Subject: Re: [PATCH] doc: git-update-index: add --show-index-version to synopsis
To: Dov Murik <dov.murik@linux.dev>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Linus Arver <linus@ucla.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Dov,

Dov Murik <dov.murik@linux.dev> writes:

> Fixes: 606e088d5d9a ("update-index: add --show-index-version")

I don't think this trailer is a standard one. Also, the "fixes" doesn't
really explain much. Perhaps you meant something like

    In 606e088d5d (update-index: add --show-index-version, 2023-09-12),
    we added the new '--show-index-version' option and documented it,
    but forgot to add it to the synopsis section. Do so now.

?

> Signed-off-by: Dov Murik <dov.murik@linux.dev>
> ---
>  Documentation/git-update-index.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 8c47890a6a..7128aed540 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -25,6 +25,7 @@ SYNOPSIS
>  	     [--really-refresh] [--unresolve] [--again | -g]
>  	     [--info-only] [--index-info]
>  	     [-z] [--stdin] [--index-version <n>]
> +	     [--show-index-version]
>  	     [--verbose]
>  	     [--] [<file>...]
>
>
> base-commit: 3402c0e53fb798cb471dd6562eb5c938885b7295
> --
> 2.39.3 (Apple Git-146)
