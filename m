Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8537F015
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594293; cv=pass; b=KBeYTvabH5bfBIqNLSozag7vKvHSrW9b8+zHGN2VgFwAZBLmcVbtJ78R4iJKV4v0LTAFuQBN8jRFqoJ4uZVsMex9VtQCYtga5Iwgbx4qPtpBKqswrvtmpBuk4BT9mXFhBlcgfiD/LJOXF+nbkcVKK5CJairsybF5dDXs8xnyBMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594293; c=relaxed/simple;
	bh=P/+jgk9E/FM7viB21YYho4qZpDKOZYHjv+1Y54kKOO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPhkZJqEsTH+njC52F2r7OoNY2inN4LXMiJO2vbkndVzAOVttnj7qyDKlQu67UCVVUN9eZI0CwW/zdg355KRGxcQtBCcsnV4o4QRGMR5AvLHOzPPIExpUJEzLNqi0EAHomD8NmFgneLXUr75TaCNTArX5fXN6337XKh2kOgLM3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuUcHdAr; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuUcHdAr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66388bf3793so2259986d50.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782594291; cv=none;
        d=google.com; s=arc-20260327;
        b=RD3MsIMgfyiojPttZAycNpIQFutGJ0I+Mv21/jB4MO9CM8nJq39wCfxn50JpG2g/Ni
         YPQAr4NEU3VKWhzaaF9rYfQoWuGMPZRBO4MS/wuTt08JmF/smU+R5wPckZz0paO0URhD
         ssn07GWZkppnY79RKHIWhaJ1CUKxQLSxoaIk3/e/XQ2M+jdGULZSB//JELlItMKcl75H
         SMNCF9lJYeUdK/vKJ7U9KV3by/ocI27uWN2oggiUGKskO7nwJ2PFmn1lzkO6ag1BmVGq
         PgmSa3rBScQIgm9WQ8XcXYm9Ajua5YamNwvzfoQeGQw1TfkUxgqoA6YIiaXfeaXLCxxH
         GmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/+jgk9E/FM7viB21YYho4qZpDKOZYHjv+1Y54kKOO4=;
        fh=XvEMCcMsZaIQhi7zcFaiFvid+wsdKjMhyp1f3jI+fkA=;
        b=j8cJoL6HB48x/R/TM0wSiVkJcqmOZLuG3H5WSsYxjv75+8ZA27bhuvrnWsN23DFk6o
         EzlUrlsMHZ/HsZ6/FRkDyuUilasIpfhEUHw9/OXh0PBnL6d92nlJW07+R5J9CozBvrg+
         FtHwkxDiBN7sa/O/Qimla2tfZ2y3iafmuxBtgONEYTERiJmoOsHb7YTpmplY8LVE0jx4
         a47vjOkjUQ2IBdyVIpBatZtKwmdipovtf4aguXLoa3WieRxPpmIw5OLwasR84WabH9Ye
         qho7bPh+9lDqQaZHS7WhPBNn3WAUscF9ch6B1tE2wQdLzgmQ37EqztrG7xVXwEYcKR72
         +R2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782594291; x=1783199091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/+jgk9E/FM7viB21YYho4qZpDKOZYHjv+1Y54kKOO4=;
        b=BuUcHdArJ3qzL0lWj5GQqK9jA7S4JIaSy/6WIM0vr3/eymnJbg/4W2Xzf915NmYAzb
         s93hN6gcqfsGuB7+qRXRhCTfJ+b8ftagMQNPNn8MJABVdiAac7HCgG9i1VrFjOXI4Nrp
         dHjXU68+EJ4mqDf/1KeH4SQ2cWqBglubSD5hRbu3gZXbCPkp1KGG0BhMJJAo2GsbKhoy
         jPIGEPJd/wtrFPXunQh4ub8wo8yH6B5l5376/T0wnjh3liwelnnUGjNYhMHs/W+7qXbn
         hPB8ajFUpkDiw2dcddIBCR03fQgFEtFevddV5OAbI7b6c/rxFmkYrrsWoM0xn2XEDy2a
         MXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594291; x=1783199091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/+jgk9E/FM7viB21YYho4qZpDKOZYHjv+1Y54kKOO4=;
        b=Lb4SrN+1mLaItc8DSvusnXYwMzxlO8LENbJ7++C9tA5hTRcjWVtYG6l+62uApt10HO
         +hF+YprKL+NDbwJcP7h2/TjAehVFeJ3xzvQCmDPIzYWjXeaKRGm0E5qnShB1NwUaQjVp
         4CFsH9ssN6gXxQ2dZiBNq2Q4gCk5/POFSTjdV7ujY2U41BeHblrci8Ai3mjanyuHv3/h
         ubjE8aLsr9fvgQWQRf1l5cz64Xhv1cy+kgXyLlNEsUBSEGPvnptwUCt1lbR8/cKZ/4Tl
         EGExbxpDUt7Di42P/1Ga9bn8vjCSCP+fw+AdZXszChhpMjDDOBQgneXxx+CYRg60XjKG
         qzPw==
X-Gm-Message-State: AOJu0Yyhz63LF25Q7YcxTSrHvDgNYMRao0njJFYjb/z5CnmJbbiXePF7
	EqcxxLXUFDHIQ5pMMj/4wx1mJ5iq7/gNZPVqvhdLmUF1Wt/HGiVoCNEcuEg6dqLBaC4wHUQOnWT
	1OFoOgOs8Md65IPDlOLP8JvC0KzRBQts=
X-Gm-Gg: AfdE7cmyHOgn+yvvu6BYAUG9X/oqvGGBG5Rr9b5tJTIYJUj+P9/jc+nOEj7ga98hs5p
	/VvvicAqxbGPL+JZrg2fKL6Owmh7GXKpzYMa+uZkzo443yXtOfy4smVACkZS5afLetBS/KuA18p
	MhVEyWYeaDl1zQr3NGeaHewzGUiyGxb77GRBZX8hNPZ5zH+76EM3AodEha/+8VD8hh24+EOD1Y0
	BbJmlL0qko4DQ+ofB9dhUULt/WF2mtDD6AeCS1jJ8zw98NnUKWFjgDuAm1t39tX+xDEeNhfdydy
	VJW8foayhk6d5BapRGCUV7DlotsxVPVxiAmnAOZdZIGCXjuu5ACq6GOCYRlGqHqZuw1ZdSa05nc
	lEV8R0yiLtQffiNAB5Ad9Cepybwm87Zd80fnADNb/oFdsi8oBJtJ8aaUeGDF0ZL1/4Qij+w==
X-Received: by 2002:a05:690c:3603:b0:80d:7292:614f with SMTP id
 00721157ae682-80d72a1a7b3mr26080847b3.10.1782594291024; Sat, 27 Jun 2026
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-6-09f7ffe21a53@gmail.com> <CA+J6zkRm_F4MQ2K8Ayv8PGJOx+pNAg73+p-4VdOgkxeuKAkKew@mail.gmail.com>
In-Reply-To: <CA+J6zkRm_F4MQ2K8Ayv8PGJOx+pNAg73+p-4VdOgkxeuKAkKew@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 23:04:40 +0200
X-Gm-Features: AVVi8CdA7hYFLolwwr13GzMQERw9YYJkqnnjzVCPelPgaFZ8FNqg2vKMyEZz2js
Message-ID: <CAN5EUNQzwoZ+v1cCZSWkdJUqqgQBVzLNUmyDsz9jhuKK42Q0Yg@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 06/13] fetch-pack: move function to connect.c
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, eric.peijian@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 26 jun 2026 a las 14:14, Chandra Pratap
(<chandrapratap3519@gmail.com>) escribi=C3=B3:
>
> On Thu, 25 Jun 2026 at 17:43, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
> >
> > write_fetch_command_and_capabilities will be refactored in a subsequent
>
> Nit: The paragraph below and the preceding patches refer to this function
> as `write_fetch_command_and_capabilities()`. It will be nice to maintain
> consistency throughout this series.

I'll do that.

>
> > commit where it will become a more general-purpose function, making it
> > more accessible to additional commands in the future.
> >
> > Move `write_fetch_command_and_capabilities()` to `connect.c`, where
> > there are similar purpose functions.
> >
> > Because string_list is only used as a pointer, use a forward
> > declaration [1].
> >
> > [1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> [snip]

Thanks for the feedback,
Pablo.
