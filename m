Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A63537E6
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213014; cv=pass; b=Cl1I51RyK3C3nD4REkoZl3/fjEblqTt5DzHU7W0zbR8GRtigBnVep8qCBNxUeJovmXq55At7bnzF2p7F5Qg/vbhz4DZr+3OZgM4daFNFahM1eRnXTBw5nWU2qE850eA8I76I/SzLB7CVgCPyV97kM/6dAyZcyU87m8CrKARGuBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213014; c=relaxed/simple;
	bh=CMGepadcvNaBbLNko0NmfQkvQjDkEemzQaaLqlnfiA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZpKFoFN6ZuLCwp7gyqI7t96djppqCkowiOYx4PNyGSKA2x4FjLCqxKl8uErYKa+IV8JCMCmqdFvSw/+f80Ot6JobfzArRH5ZAUkRV6ePZuYG9fbT85VkenJNokX9XTQxxKBkhUgwHVVsZx3yZBe+FJqMjhqA8LdO5QfLYDUZuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdgZ2+YR; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdgZ2+YR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b2ebca625so17063231cf.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 03:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775213012; cv=none;
        d=google.com; s=arc-20240605;
        b=WHjIWhn0uLOTOB6TFu2QIsU4fRe4Gtnam3bYaTLnR/6TE0V5AxJEFetrvGXcK2O6+x
         AyFT/tzFkjSc5D2XY6m65ZMibToGt6ccZwHXxpyqhpisVy3d15wWoc5Sph0YB/9aL7CI
         h6I57CmoQjHCPcqCtQVSmehQWHwfapLEYMvmFr8NVc33OBtX61btEOyk74jnMn54a6co
         vSZFkYWPwQlGmaqSK4/vskc96BdbrufvKDiImFvnarJQ7mNzboPFlsxVk9u38otpf4Mj
         CCvp2pmwF//OPypgJrcbVFjnGfw0sAS3oPOIV9U1u0fIt5WKELx1ms4m8Z9ayC/RX3Oj
         bjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMGepadcvNaBbLNko0NmfQkvQjDkEemzQaaLqlnfiA4=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=EDYt+eMioxRXPFfzjBMuhnDago+h1a1+jvFM0Hxg7iyYwi48uibofe2pNvHT6KBlhj
         V+0MQLEoI2XrGFh0WHzU+vqL5cHT0dT67XroDox5MMYGslggR2ghCqlQjK7WeRm7myh/
         YxDXjb6bRVjL0RCUR8CE/OSJlCRnmKuSxb+yLZoIvwP29ukhZhigHMbywgOPSg2u8hw/
         D6XDs2DHx6zxhf2TkKVIc2CDjVazHkVgw648qzD7E3e4YPP+AWe1CwtNRHJe4EQRq2KV
         OFr0tIZPptJarYVsdbdU+hNiOJ0Y6iw8qHHcxAqsShXVoyRKn3XfGh/96nhQac/DwYM7
         gjSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775213012; x=1775817812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMGepadcvNaBbLNko0NmfQkvQjDkEemzQaaLqlnfiA4=;
        b=DdgZ2+YRTt5ZkdVQxLgDxmJisAlrtKSg1eAStRkLy5zmBFswDcpNvhd9pDk4aAo9LN
         bPf8N1OYUfCWQJ5lkQJQQSaf4Vk5DHLCoNXWAnzR24aX8eaKF1UHnL+uojl9D3AcYpfV
         N9NYWWSsi5zElE7hYxwXH8nqHgUsZ2cfMDhvgN4KtLmqt8w9e+LdYBHOui5bVTvGP1OZ
         sGQ3mYB8AJrlahU8G5fg8T1fus1eZBcRPl30fUgjaP4mi/Q52HBS8PJcBWSUtaHQcdkP
         +csA9Npkq2lEd+mwWivTHi3DZ5c9pGk5mo+gCKqGebu00Sz/SG7D1zUa7FqIawN9+Pxj
         iy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775213012; x=1775817812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CMGepadcvNaBbLNko0NmfQkvQjDkEemzQaaLqlnfiA4=;
        b=jS6t4HhVGvj+VpLV3MUCxUS4mObyVdtReBu4M9S8GEf9KLDF8ARDaZf2DDqns3zJt6
         VDBO9waOuKYm1SytU+DesX5j/XnMA93Ac7Z4eCGLoVeGBBqvLv6UrqLqqQABjq1mtAIb
         kvApVY1+R7YueVo1ZWyJdfPIf3MApJRAKQads1fYmDangwUnrm71+nXSOkBVEA0gM6Xm
         mDUP5nTitl+zH3Sg3N/NfkjQ9VuB9u2bk55ZCPDcC9XfKKjOeZe9G+xTh7Lw3Q9+UvLY
         pCNQYZqhZbYhkaOY9opjyloHDjiMNM126gxZzPi0TWmtItfOi84z6NTDZL2faYsRm7ft
         G6lQ==
X-Gm-Message-State: AOJu0Yx/CdXnYmn2npo+0JZZO4NdlRWyHjbtfzJFvNARuydsza7S6/bQ
	ZuGHzsAk390jWOL3nHTdWOFvME2H62o1TQp6bHbB9W14e3ecqyYMV4RGaQyVu/GTOLk+BXuiNVJ
	UeCqFmUSiMr0xn9+3UvF/TdZ8DGv1XneLEzUt
X-Gm-Gg: ATEYQzzMm2GHbz6sbfXbeUPxjXBBwI7JeTdoKNxTZW8LVhMN/MON3vRXFPihksj7fii
	C+A+8yfNa4ofdObFB5+OhrYDlEsNsIuBmnyAWTGbE1t77bytRA8Nf47xGH0ywokD/abuDbBTZEe
	oxMRuGUdUytFGUhWQB1aOeZfh5AW9qQGVaNko5MAAPBOOP/qhCwA8YfDgRxWXiQAj2OU0fFNkIH
	pjUPnrlGLjQgSwKMf6484qFzdafA5zV0OtSNg+2dWhV59jNaS1p99bXmikzvGcyQEUIJI2B+wq3
	PGj+N7aukwg/DZeg5/MA2pevG/la0/cIu8nBw9BQ0Q0/s8AQAz9T
X-Received: by 2002:ac8:7fca:0:b0:4ee:1dd0:5a50 with SMTP id
 d75a77b69052e-50d6325138bmr28206041cf.17.1775213012027; Fri, 03 Apr 2026
 03:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-5-shreyanshpaliwalcmsmn@gmail.com> <ac4aa-qLWwoZ9uPZ@pks.im>
In-Reply-To: <ac4aa-qLWwoZ9uPZ@pks.im>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 3 Apr 2026 16:13:21 +0530
X-Gm-Features: AQROBzCVgy4WvtuNF2Wndp8sxDyyUdKCtY6roGpCrH5fW32NpBJsTs1UOc4RxlM
Message-ID: <CAPYXD64sR3D9Qhdf4a2O91ENwFO+dLirWRrneG0+ykoUexEGzQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] refs/reftable-backend: drop uses of the_repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:57=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sun, Mar 29, 2026 at 03:46:42PM +0530, Shreyansh Paliwal wrote:
> > reftable_be_init() and reftable_be_create_on_disk() use the_repository =
even
> > though a repository instance is already available, either directly or v=
ia
> > struct ref_store.
> >
> > Replace these uses with the appropriate local repository instance (repo=
 or
> > ref_store->repo) to avoid relying on global state.
> >
> > Note that USE_THE_REPOSITORY_VARIABLE cannot be removed yet, as
> > is_bare_repository() is still there in the file.
>
> I've got a patch series cooking now that'll eventually de-globalize
> `is_bare_repository()`. So there's light at the end of the tunnel here :)

That's great to hear, thanks for the heads-up :)
