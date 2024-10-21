Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C814A90
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527499; cv=none; b=TskESe8y0NzJ3eEwT3NIEwCu1z5XJDpTLhFU2F8wlWp7lWNsNIQ/NbaL9Ph7oebViiXOkGXLtLzYMyQo43iwuK/YlNods3j8BzYi7avp0XHajc+gFPIw4uiS/MVNBLPvebHR2X25f6PySowi/qCDff1bcrhcU1I/a+sjMybKYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527499; c=relaxed/simple;
	bh=e+w2lg4bfBgrfLVOb8YRz3hYWfPo93oBC5K1eTroAlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFe/lf8Q/BoyDclg/nCwigiTTA5Uw2DtauLkbHsyd4OspvFYgkGWSxySx9syTjM5cW7VisLtLxR5JPqoq1jrisJQriiAQWILc5SkPtj2bj0ZOkhXRt8wMW6jK5zu1B+nPrX/0wzFUF322k/yX82bul3rI/IApOJtXuI2Go9qr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lGqs8/zk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lGqs8/zk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3881042dcso41394267b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729527496; x=1730132296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFn4KakdROBM9Vzh0TISwEbnonoVlLrSDqWNWKOoOKg=;
        b=lGqs8/zkHRX3v7GGrLeQnA+anJfKwNTWwthG3laitrmtE7mZ9w/WrEV9SLq9CvsE0E
         hoRTf57HV6nnEeUt12IF4Sqc9tgkAFT3+aKltzQNGRkChKNJExeaQ7e9BltKUEff6JRW
         Vkt/uA+xWEEVHL5cCE4cXDv5cU+yvGSoEv+Ists4F9s6Jd2CPA++GpemTY26f9pkumJm
         uPJIEuxna1z9+WvpQr6xcxC6vWxUTN7+U+aoLToftuPp6rpOgDCyVO4ljAtWK927BAfJ
         TQjunrRNf8yXBkXxR26d9sVtpr2ldSK7O+L9a7iIg1FBDMOGf47OlMA65N4f8uQaF9Wt
         NlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527496; x=1730132296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFn4KakdROBM9Vzh0TISwEbnonoVlLrSDqWNWKOoOKg=;
        b=qUCVU74jAtBf1joXrfvBAuHj1KzhHSSS9vT9I4hkg7I+d+E5CqamhgJVg7ZH46hVUk
         fYdN8O0wjQcG7t5ce5aelmm9pw755Wz8GRjJyVigvyg6IfB+iiHlTRNp9rLBd1VMYgUu
         BdXpMEO/emK3+JqixJmP3HnqHUEw7+//fPJ9BZv1kmg5lQdw3m2zilyZCqBesedsd+VG
         46fQWqj2C/sKeyRJDObIKIoHgO/pyI0CIn/wJHnHgTjMk4jEKB6wit1zj7c2n/jGfle0
         WP8GpInXuP6sGL2dovbg+f6U1smd5hlUsF6ki5nS1/xzI+q5du8ntJtbGrfVN9igcdKk
         VIxQ==
X-Gm-Message-State: AOJu0YzEkFAbO+MHUQSqzpvjXCJJ6aeIBfB9VGw3ssLLBYTBSlbsGe9r
	KorSYzKeSqrMCiAcZJDGQwk0LvTCdLYHvp0wHgJ99BeM1RpMDRH1J7dDri0S0x6pJV9gREG3CIY
	s
X-Google-Smtp-Source: AGHT+IHPkBmvPrEcO+8JTZkGxg25BfTqEISaol3sQ7H0LRm9/xr/cmg9bBkaDQCKHq/hEio5/E5ePA==
X-Received: by 2002:a05:690c:d8e:b0:6e3:3c7d:31eb with SMTP id 00721157ae682-6e5bfc419c8mr92692617b3.5.1729527496275;
        Mon, 21 Oct 2024 09:18:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acc3d2sm7161357b3.58.2024.10.21.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:18:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:18:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/9] add ref content check for files backend
Message-ID: <ZxZ+xteOnm0im5vC@nand.local>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

On Mon, Oct 21, 2024 at 09:32:20PM +0800, shejialuo wrote:
> shejialuo (9):
>   ref: initialize "fsck_ref_report" with zero
>   ref: check the full refname instead of basename
>   ref: initialize target name outside of check functions
>   ref: support multiple worktrees check for refs
>   ref: port git-fsck(1) regular refs check for files backend
>   ref: add more strict checks for regular refs
>   ref: add basic symref content check for files backend
>   ref: check whether the target of the symref is a ref
>   ref: add symlink ref content check for files backend
>
>  Documentation/fsck-msgids.txt |  35 +++
>  builtin/refs.c                |  12 +-
>  fsck.h                        |   6 +
>  refs.c                        |   7 +-
>  refs.h                        |   3 +-
>  refs/debug.c                  |   5 +-
>  refs/files-backend.c          | 187 ++++++++++++--
>  refs/packed-backend.c         |   8 +-
>  refs/refs-internal.h          |   5 +-
>  refs/reftable-backend.c       |   3 +-
>  t/t0602-reffiles-fsck.sh      | 457 +++++++++++++++++++++++++++++++++-
>  11 files changed, 693 insertions(+), 35 deletions(-)

Great, thanks for the new round. Looking at the inter-diff, it looks
like this round also needs a fresh review. I'm catching up on new
threads from the weekend, so I'll put this on my review queue. But in
the meantime, if your mentors can look at it, that would be much
appreciated.

Thanks,
Taylor
