Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC622D792
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748207; cv=none; b=Y86v3DDcECR9ZzQImZ0lnxgAOJGYqs9qRbfWwKkD23bwDVcn2+AdbSEXAGkPuFo5Np5RbLPxz0s/bmutAyrckDyobokHIMj+cwTRxpAT2WMasGvGGbmibDv3vYbuJkK0F16HwK21y7PRlJ3pjFRS869+XpgDhFRRruOaNAcOvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748207; c=relaxed/simple;
	bh=vhjBOOyLHGiEElUhCAyqlzBgkTE3WKskN0I5Q9jZcbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ5HMx841hMH2pGVGdXNG9Q+Ysl3GEDlo0rpSFYQ6oeMzZYW04+jeQ2kiJQ7+USq61H/MOn9Ma8laALa7TWFjFOTMKTyIkpg3/aLBVSjEWXJ4WndTrmWZBg3pJhEiqk9dk6fHE2cyb4UKM3ZqG0dOK2+vQzBpkMUP0FvSLsmFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqbzuVbF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqbzuVbF"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so5992095a12.3
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748204; x=1762353004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlIUbfhiBxH27y3m9uqg9Z7122T3aU0A5oG4vNTG7rI=;
        b=VqbzuVbFs2NXrF5DdQYao+TnysrJUxYu01RWhykZyCf+N1/QfRyA11QGqPxDlOOBka
         pT4/gU6FguDvWVkPvjAOl6JNPs/oqfAl8DCWXhAGlSUP4Sjkt6gOwfugHOu7/GuCJzk4
         0y3/nlcc/Wj2NE8WdkB5Lqdd9nrY9NoEATjByjlPlxdD414Z4oDIBllQVOWtSJq6erpk
         rjcL3bkCsB/3xC7913eM53xipHgPAGl89A1dHvok6y7eN6CNGmUzlRaXRSby9zEPNSwz
         tEgAIvYMuVvIriVuR828bGpsOy8fGZGr2xBLe68RSg0y4pg0urN9PdlnsM2lrVnHXqlb
         8Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748204; x=1762353004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlIUbfhiBxH27y3m9uqg9Z7122T3aU0A5oG4vNTG7rI=;
        b=IMmq+PQ2Kzp0I2kIvb2g7yEkbIfH+0Q2jeAxCCPfwQOKCindumvH65zW3nHu8uQGyB
         DbDFMy0A3iAx2rAceB1nTYNIrNTWR4BapGuSBZ2qPW5Uf4knX9R2GnNibl2CSSDLkrbR
         5v/N7PXlc7//E6QOMo316kd8oJ5CORAvmYsxoNytbdMrprNkSN65hfY2bPIEYJ6wKKlR
         Ac8x2bzYh0/lmcwh1lQvXMftjgX08HLHXResKe6mClkezJ4m9Ub7WPcGaBXYbiG9kK8n
         DpxrqEpJ+BKwyFZjGGz1UNYEbtllG5gNiVfImHIIWG1djJmISPFwztyE3Y5qlaU1Veu2
         dHWA==
X-Gm-Message-State: AOJu0Ywcfj1UmRI6870vOQ7vGhpAj0q2aBsGMVzMOlK4RrdT9pvEDLPk
	B/kQ7y1e5IS/al2R0heyDiaV7y0eKo4Uduf1x0sjjsDmeDGBENluRnY3R/GX5JglAUhCpct4x0E
	FMgd6STRKuSvbLKfJBNcWZwVjbtggD6s=
X-Gm-Gg: ASbGncsnNKAcKk9+74XNONbZD61u+ofX30QS5UMr5DQ9ul5OBNSaMBxZU5dqPCxBNyN
	3p72L8hr1ljrry9RtDmMAhph2rCDanSPvQmngEurmlva7ZzzKNeC3flf17DA2it68QAQrpJvG2+
	QtttmUMtBHutTYzMRJwfqo8GFmJIWyT42Wx+D0BKEe7FDhVTFNA75Ia4myFTl5l3s/25Vk7SJuF
	AJPozh/XLJGPjaRdV+nftU7ogcFXWxY1vUrDOJXxG0+rkq8tLYfiIlelhodMwHByujcUmxBpDvU
	arbZBSoUh7O75vdp7nbsLquxqO8H
X-Google-Smtp-Source: AGHT+IG3oYjfkbMz5t5wtynui5L7CJRxAMVaS4I1AqiyguTFCo0lJre4Hemu4SIgKj78yxU6E8d8eQv6e5cIElSsOHM=
X-Received: by 2002:a05:6402:440d:b0:63b:e822:ac3a with SMTP id
 4fb4d7f45d1cf-64043f42d6dmr2591388a12.0.1761748203583; Wed, 29 Oct 2025
 07:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251028081232.3068147-4-christian.couder@gmail.com> <xmqqv7jzdtvl.fsf@gitster.g>
In-Reply-To: <xmqqv7jzdtvl.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 29 Oct 2025 15:29:51 +0100
X-Gm-Features: AWmQ_bl5zuLiOLU_DLBNzwskFj8IKrCUhy8QcytcWNk44CV8Y2zCWYs25sLe17E
Message-ID: <CAP8UFD3S1s3_p3m-ZzRO=B7nQwJvbYMBew8_MZWJwSJEm4oFTA@mail.gmail.com>
Subject: Re: [PATCH 3/5] fast-export: mark strings for translation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Some error or warning messages in "builtin/fast-export.c" are marked
> > for translation, but many are not.
> >
> > To be more consistent and provide a better experience to people using a
> > translated version, let's mark all the remaining error or warning
> > messages for translation.
>
> Makes sense.  Should we also downcase some Unknown and Unexpected?

I am fine with doing it as part of this series, but I wonder if it
should be part of this patch or in a separate patch.

If it's in a separate patch, each patch might be easier to review
independently, but a number of lines will be changed several times in
this series. So not sure what's the best practice.

Thanks.
