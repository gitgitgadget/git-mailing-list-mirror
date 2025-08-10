Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B114AD2D
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841981; cv=none; b=eu610rXqBp7Vi3z8+5cbdgBEf5QCEx7Mkn6nZOfORtB+SDaUFPepJHW062HCe0BHj5o7ibNf3HNkCpbvXnSNi8+nW37GsBeYOy+T496qacKu0JksnC8t59IxbOx1LQ6k9pCsvPiNNiKg4JI3eC2x6lpMsVqwz9mCV5L9if9YISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841981; c=relaxed/simple;
	bh=65knznNM2cZLNgMkhMjQgkbYH/Ouy8RDxCWVoMHcdDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PK7PNoP7aya2jyFc0kpA49EveaZXLY+Cy8uSr1hpETFHDLGCh51eytepknfVsNh5y1ySyiYtv8T5FfrKiw49yf5hDZCwiMoK49lJCu0zrxEWfN+oRIZ1VxqXu9SYP/yoGnNr+EdGRfC9EDICzSAike/5fiH/+TIFYLXPAmOh1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZPf06WY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZPf06WY"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adfb562266cso499786866b.0
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754841978; x=1755446778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruqRhvdBgcUD6BCZN1Wpt83H9FBNbqSnv05hRwR4ks4=;
        b=VZPf06WYX7SJdZE0X+eEoezjkzUd3Yl6KZUzfBfWf5BDT7I6XiK+Ckunsubjt/3XgG
         VxkOO6jEwblFR2bhYa4BsJ+2NAfEC/gAn2K/ZykCUwqJM6jXxSzsGTu7fMxGYy0lgnV7
         i6vD4bzCafHgDpdrizoHOD77xp9sD/Ix7n7pVqotYvnArzconLxal4URvP6O6UamqFFV
         rnwR+Z4GKHHUxfZULMc/7/0iStyrhWLkrDGWNg3DBgxVpqGp8eS9G+K/WesS5qtRsYvT
         nr14o+gjUXbjqSKY9Mu9NgsHPBjksAuMknUccUPOWzQrxOf1qxn0qLJ4wILmH/G9VkzI
         07rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754841978; x=1755446778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruqRhvdBgcUD6BCZN1Wpt83H9FBNbqSnv05hRwR4ks4=;
        b=jpJIBt2SfXDo3i+CxMzcerpLZOdwCHp9WC6Snys8Qn1crWNxarl8BDfOIONWCOBOIj
         US27AyD/VwbGN6ClyAEE4c6Rjw9OGm9YChiKlSe33VgIiol5m6aFGyidWl5ZtNdOGURB
         GvkxJdjRYSkp9X9XVHBpRKtEWI5STJzgEY5j99kGlZ8OMDHBujOxPgBKTvWEx+803X5l
         r/NwW9B/VFYLFZHFErEEXNRmSOE4Ci1GltrhQR0sH5+lqtJfOBs8y/EiIsCerAd65QT5
         Na0FSisTsqg4wPF8DatI9/0C/Jm+DKItqkA3IAbQGjhqfMysThq5jjyMDklFghsNlMJ8
         bUHQ==
X-Gm-Message-State: AOJu0YwvvX+uI+tngh+gnyIZKPr9XiU15C8bNqotrqKwGZal1M8LGsh4
	0iNAsd6KngY7+YpZRoS2pfpvnN48o6lnhqjFlWMIb8HuiYmKxxlqwVya5fZqLQc/gcP6SbfJELV
	tqPltAmjPtNQg+VAQT3KJ3katK3qoF/og3JjQ
X-Gm-Gg: ASbGncslYMYzjfkmaPRHSc7nRS2MxZVCQIXAUClXUc97HdmijorsyS1ZrtOvx8zWCPo
	HIo/33iFisGP8gbY/URsB6f9cAoe16ZPmaUIc+knSwHq0/IjJAhiejOu9Cz1vchY5mleorzq/9d
	0EYd2+XqRKU+SGyGNT3NK4hkfVlAyynDAuwr8votvC2Khd017nBJ1l16d2uMh/QaOtt357DqcXa
	NMVvpG8VL7vyt516wtS7N4pMk/LY+qHPniKNty8vW4l7uP3b7rd
X-Google-Smtp-Source: AGHT+IGHOoe6CQzfPqWwdLoVcuN+n3/sRKoYS9wXi1UkEI875oxfS5ZF2CkwWG0J52ibOJP1EWw7XqoIMnzHGZ81n04=
X-Received: by 2002:a17:907:2d93:b0:af9:1d21:65a1 with SMTP id
 a640c23a62f3a-af9c63308b6mr907306966b.11.1754841977712; Sun, 10 Aug 2025
 09:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520193506.95199-1-ben.knoble+github@gmail.com> <20250810160323.49372-1-ben.knoble+github@gmail.com>
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 10 Aug 2025 12:06:06 -0400
X-Gm-Features: Ac12FXxTNLUHtdIbXKpoxCd-kdIb4qluJhHjWxRFHyg8Kb7XXZgG1jtSAgodYU0
Message-ID: <CALnO6CAQNF2gD5BWvm50LN2D6mAHNRxdzeZ7ZQhvt-Gr3oHumg@mail.gmail.com>
Subject: Re: [PATCH 0/3] clean up some code around editors
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 12:03=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> Changes from v1:
> - add a prep patch with style fixes to t7005
> - rework the environment munging to use subshells, per Phillip Wood's
>   suggestion

Apologies; this should have had the "v2" subject.
