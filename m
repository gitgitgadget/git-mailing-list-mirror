Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F394B1E7D
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571899; cv=none; b=p+zZ1dqmD6T4v5tA4c/3cgxB7pi4A7Vhh96UuwQo395F+70jFQmUp1nV0Ve02IeVQ011WcZQIGAzuIoOMeKxdc0hvmjKp3lEyjLpltr9B3jj3Z39hjq0ld/Dc0fH/92sVSFhulJzhlCbF/2ws5qFZ+eqIgN7si7MF1OfY+Z5f4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571899; c=relaxed/simple;
	bh=elx+SQE5Y5vYzYfajZYUbPN0J5RXg5QQbFBrKFo1PTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjQgrmQgzA0Lhiqck/pTuQLzcFDTgOKcVoqbM2kYYvOa5DS9KAAn+3qadBZUm3OO42dyPnXwlZMIcrSZC5SrycSZopGgmWY1MrkYTrK1jyW262RKyzIYvKZ20g3FFS5MTf3Rj458uZoJg5yvAfAnFYmgBX78nUHi/FPv6LtMT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5a55bf777so46412285a.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 15:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746571896; x=1747176696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH6/f9VHxDH//aVWZ96I4QBOfvl5BU10RjzaGWY19/Y=;
        b=ubMbKyLj9d66FDIzi3G+TFxg+o4T3nHLxnKUVBQ8D//W+g3Vsr7dRJ+7TZqv328dIY
         NC9IcCihTjj2tEfPs3+WjWTOgAiHF/LRxFy0YzOPaAb9ZyhVtkvH3Tu4uIULW+steQCV
         9sa+QDbSgZ9ureZvjktAfbDPjOexMSPKJDgTJxWl0//TOkNdH6ryInVzHiTVMKzG/Ihh
         k3L+EGOzXq+WncBzobyYc7/DO5AiF6w7/1hBtqI7i/9zyfynJYaSdVWlCV1QFXjDFZPL
         7mGoZV7bT69tiu0UIIH3oeLe8SClkNVfPBXp5oLVlZNqlRIBMRVtdvByBB8sJ1slTxrz
         v1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/fEQJtcZmAHXfcdTevXxIn8xmW/4Evo0j49lKuuAwa9O35d0gN9LoMMlYs3tKabdYPeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqLgglVgyakEkF6bFy/26zvBGnuBEwiwixoZqn5AIIr7mChQV
	HTjo6/felZC52B8UZ4dCzRI6DgLr3ee/nmwJZiREsu8aDLEF7ufzOFbsBxJynDD2rQtVmSnSFXk
	LEdiZ6EAjE0DNBuF7kYk1u568WYVI5lIE
X-Gm-Gg: ASbGncv9d2rgd2ffIsXAUmD1AJIYAosPrXWibeR8GlYfxBPOpFv/UgHtUffzp6BHqdq
	Qe0eokoTimvezXn2pxd1ZbSIthsCEZZQ3hE9ViuPaaG7CUEKThwW/qP0Anl7MHDCde0SUJSWFsw
	E9ZE0smm7PpwjINQ+sqq9tuFmBRqBfZ24Ai1/hoqbM8xP7XpUBhcVsl3QXiUKn41rngg==
X-Google-Smtp-Source: AGHT+IFmd/tXvvF78IzznuD6ogFQ2diyl15rqTPAH0CdZm72vLW3p2lVw2lUN4dTpxCpV7ZrclAk9DDdJQRuAb+3qrU=
X-Received: by 2002:a05:6214:4109:b0:6f4:c307:5e3d with SMTP id
 6a1803df08f44-6f5427c74fdmr6961046d6.0.1746571896104; Tue, 06 May 2025
 15:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im> <xmqqmsbph3lw.fsf@gitster.g>
In-Reply-To: <xmqqmsbph3lw.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 May 2025 18:51:25 -0400
X-Gm-Features: ATxdqUH0qrb-PA_Lx_T5_UtKjwDyJ5Ky5iaHS8nnVrU0eC31CEfxkyjfZ9TEtQM
Message-ID: <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I have used the following reasons for removal:
> >
> >   - The tool is clearly broken, e.g. it doesn't even compile.
> >
> >   - The tool hasn't received any updates for at least the last 5 years.
> >
> >   - The tool has a clear alternative or just isn't useful anymore.
>
> I've expressed my opinions on many of the individual patches, but
> not all of them.  For some, it may be better done at 3.0 boundary
> with the BreakingChanges transition like everybody else, and some
> others with clear "new home", we can remove them much earlier and
> independent from 3.0 plan.  Some others with no "new home" may be
> in the gray area, but my gut feeling is that many of them do not
> need a careful BreakingChanges transition as some others do.

Although we periodically hear that someone uses it, git-contacts
probably falls into the "tool has a clear alternative" category. In
this case, git-related[*] is a separately-maintained more functional
drop-in replacement which people could be using instead of
git-contacts.

[*]: https://github.com/felipec/git-related/blob/master/git-related
