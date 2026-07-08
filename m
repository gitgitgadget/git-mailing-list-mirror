Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D243F4B4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514660; cv=pass; b=cyWR7mj5tzI0b4v1XdKqKMLW0aTbvG89QAOgia3lwhoNj67EOBxPuGMDUil/Wn3HZBQhpqjNWABp3TITuKtkCKP5yn7yIxL8afJ/uP6zX1uZ1kjs2VxSKjMJz5XuKyOiITyT5SnfoK1I7hszVccMbrECrPPkJKuhihil55ZL8EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514660; c=relaxed/simple;
	bh=rrlpGXM1nnF/FGwhjDA6CSG9vLxbVb38CbUpmnq0ZNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib6lxQ2RuPsw4cZaZ0KjD3T0gfZGuvgErbvIA5B/atRMuAf4A1+Wp/4OyMVF9mMZKzkjizOiwtl46JNvl+06N+GNas6WINYconXerNp3Tt2gMpgFLLhY70F3PPSTSB2ffo7FNrp7hgMirOIokNsLzt6ABa5XtlHLEkB2Dh448KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=jufxgDK/; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="jufxgDK/"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66766d649fdso854854d50.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 05:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783514658; cv=none;
        d=google.com; s=arc-20260327;
        b=nK3KwRXo8HNveqb2Yam/HqB1yYKbDdbkOcCq/rdfFQWs7C6Y7GPp4rjt5QSFaKh+DS
         S5D0B/oZG4f+gAawei+HFIV/AFjT0ZYn7putanGR5pK/YjU4tQWRMDpDkE5FFcxYUoEh
         O8+YLe6Zr/bBoVtPKt53w1+UM1JQjxevKuF1FC/jYUm+1iCwPN15Qll3GI0oSqZpmVse
         EHHo0tXO8RMYrSB8ib6/VmYs8ypcph4aY6CMVdnByuD+ZumjV/ZzvregchV2LquDNo41
         j/+Ki+aUqxRXicITMAnb6aKW0lDEB9Hz+JYbZBlPVkUrUH7sSlWcq5GNZg6qbGYCcuAq
         5UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/oSL/SjCDEPTR3nkUHwLEm36PCG7d6RowsgYViek0dM=;
        fh=L7Ta5emwMMZES9a/tzaaxA5cQ0hGkWBM73liWZJuGK4=;
        b=VIvdooWnmKz6L9Um1U2Z4C/Fg9zRbZiwnv8oI975cwOof6803hIMmsNx1+hQePDl5g
         PCmWUHI5Urcu3sb9p+7HZiuG406fSiIV0nAD7DggqN6G6Z+VPJZtmcnibbLJ7l7faRmu
         zuiOi1kBbcClmVl4J/TYNrad+hDzfWUkBo6OgB1UcL+MOghDUUm9kDxQ6RukVjl87JRk
         tba9w/dvzFB7dG2HawWZGhakzvTZ9DGyknGPQsji4BpY0fpf/JDzopelzg5wBzmeQkMY
         EX1Np/h3uUxlu1kW3B9csYq+3EkG0q13EJjeKsnTJZxZ3itmfUJfLUQLyRBJ7NUJPAaH
         BiBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783514658; x=1784119458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/oSL/SjCDEPTR3nkUHwLEm36PCG7d6RowsgYViek0dM=;
        b=jufxgDK/2hXx6TqEGgwAOKPe6WlvLMKqZXS7N+wB3eDkSmR/moiXVMF3kulCGlKD5T
         s7TYs2q+rpXiRvKMetPsB/zulqsanwGmrfj49jSDLKdt85qbCwH/YijENOENaZSoaksl
         xF+Ip4cFxSVKNnOqeDrJDTogNxfD48IcIE180=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514658; x=1784119458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oSL/SjCDEPTR3nkUHwLEm36PCG7d6RowsgYViek0dM=;
        b=f/vnvKdpwVlsOGVJzG/7aqs3xL2AWfxMfzuAflJbpHb7gp9XHN7EWeE810j/O4cNkl
         +j+XxMj9QLsFT+JICR9JVXsWVe/cLQZBzI9+oisopT0Nnnc1TT28YxuIHHgWrUoMm29U
         LxbU/CdGf0M7Z5wg+srKor483G7XYNc8S4TVOS3+W1+b4q2PuAo+gvFWKzFUzErxZRF+
         2pdZQmpo8ZBFLjBnH95dna3I4A8x1ZBgUoWWVTVuA/WThhES6ulaGZk5Gn+xKD2bcK3z
         tQc8RK3Fgk4dKOmJuv+3LDf8pT8/eg5adSWN56TYg8nSeHG7Kaw2awGXgk3WzYRUpmZ9
         5xDw==
X-Forwarded-Encrypted: i=1; AHgh+RoBbkKgNzDg07ijmYtvvpLmtKuYKkunXnwg+6U5MzvxGnWLGkg7fCNZwNl9RRajdlbsFus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo24iV10vgib+iZpkGBHQsWkp4cH8lUs357uPwiBOjCLJvNtYh
	nu+4RU9GQzSK5PWjtDBk3AtkIxuzeQsYJHsdKxB8NxJ+gV9dAk6DOdLcTVTtEpzzagP1nl2zu1J
	CWyw436XTGa9Xtpdxa2u/ZARDyUOsAvzT+sQygySyLQ==
X-Gm-Gg: AfdE7ckoAg7x4h2RJQ8GcV16W7NcX+5L6zvjlgnDjEjvVo2mGPUDQQSvioG8WYlxJRp
	oj3LNxDce8CLTJRHDyA5aGSWO2kzELMJR8IJ5TlqEmIrd2EXu4qJCPstJKmyuy4EAlnL6TDPfMS
	iZjwtUorhgqpe1kCXmwC0D55fyrOyZE/O9vAALmdixJcB/aW0CYqPBrYji5khMl3EU/XBlTxmbX
	DQOvVAuzDRbG4hMUFIv7RQFmdQdIckp1JtOdJ09F3M77FJV9eQTsWAvCOHGeN9gt6zJJ2uVZQ==
X-Received: by 2002:a05:690e:4514:20b0:667:8b9c:e6b5 with SMTP id
 956f58d0204a3-6679f2ab570mr1229940d50.89.1783514657862; Wed, 08 Jul 2026
 05:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
 <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de> <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
 <57bb0e9e-221d-4234-b5bc-a87610e8263c@web.de> <CAL71e4NiSSRgxO_L7vb5=ohnchOCvuhEZwMc0Ls+Xu-Q+YytDg@mail.gmail.com>
 <15fa1b16-b911-47b1-a843-400e320d7e4f@web.de>
In-Reply-To: <15fa1b16-b911-47b1-a843-400e320d7e4f@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 8 Jul 2026 14:44:06 +0200
X-Gm-Features: AVVi8CdqHfRONmdgSmkGXmutObGsSH2niiWhOtL7W31hu6pdMR_Q-2Hhf9OzQnM
Message-ID: <CAL71e4NKcCBs-UjF3ZxOGrTbT_TUAumZV_G2PAfyf4JgzCm+Cg@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jul 2026 at 13:55, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> I meant that I didn't find this optimization in other priority queue
> implementations or papers, but admittedly I didn't do an exhaustive
> search.  Given it's benefits I would have expected to find prior art
> on it pretty easily, though.

Aha! Got it, I misunderstood you first.
It's actually described here[1]:
> Bottom-up heapsort conceptually replaces the root with a value of =E2=88=
=92=E2=88=9E
> and sifts it down using only one comparison per level
> (since no child can possibly be less than =E2=88=92=E2=88=9E)
> until the leaves are reached,
> then replaces the =E2=88=92=E2=88=9E with the correct value and sifts it =
up
> (again, using one comparison per level) until the correct position
> is found.

It's for heapsort, not an interactive heap, but the algorithm
still matches.

Also, your idea to split out sift up/down into helper functions did
work, and was quite clean - will share patch shortly once I have
cleaned up the commits and benchmark data.

Thanks again,
Kristofer

[1] https://en.wikipedia.org/wiki/Heapsort#Bottom-up_heapsort
