Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077DF385D88
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377662; cv=pass; b=hqr86tWWefu0laG+FckLxpGXO6vSpQtSiCL2i40JdGtE1qEiIrSz4wzANjRhtUd4GMDrqvIAMnHtKylORfUOa4HjSll+HgfPyUzCnmGhSM8N33tvtaJoIwibA344wODqBw26WwTaR6W6LG8fnA7oQwGnENszW7DuH3N6wQ2rkAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377662; c=relaxed/simple;
	bh=KyrrKmbO1HMZftBXyCoisIA6BbFwt+/qP0/7eYZgGu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hszr/P/NL2tVVpPK/fIlMNo3kqgKKXYkNNqEW7E0ioyl8cGtHva696GBX8wol9MbgC0NZqZhRGVzz8WpBqf5a0A9MPuYPFolgJRnjFGNeHV+7KnDTcQvRiNpTcxJaoYE5ywifLxoRd0+MtGPG9PPOGkeio1sm8ETAY4MyqUbuS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdpAsiCK; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdpAsiCK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c07ea058c1aso268392466b.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 01:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377659; cv=none;
        d=google.com; s=arc-20260327;
        b=O9qBKAwir1UD+Z45LEYejqbyvM/LICZy88QPmVdndw1OujVd59hJUbaawMCeiVE7Jt
         L6xhXUiEbhN1gu/D4SzSSOtOyNRL7nGulJIXRghw3ATMvLIG5QGEuMhcw5ijhjy57j3P
         e+rDrD/SCe1hXmNU1SFkKMOEE5873X4JA0FEn+P+Vqs1HFKoImORxquImXR3wz8XNojQ
         RxhncIy9iYblRcOgh5qae8D/laKRzrRigcbSY3ur0og5YAuPeiX3pnVa3ejbfozMnzz4
         aQ+YVOs/HEookGVA4LAyEMKmUwceEUVbuxDncRuOqVKy/x//7VxpM4hdKVSEFM3FR9wj
         Kcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KyrrKmbO1HMZftBXyCoisIA6BbFwt+/qP0/7eYZgGu8=;
        fh=8g2E+HBAr7HcGUwnkg2/CGBN2QZLS+BFZ/i6Uix5E1c=;
        b=G8mHOAsa/1yJPoYinCc/pdNwk0lRTvpnWa7VMnLnsnRt+79rc7xpP+J+chfVCu2krI
         Q0MbV3nmN5s34mVjy+40SuAQiL0+oYXL+6P+7jw47ZQak7KEuu003mYMV/0YDHqvGDNu
         4+bLZ5mp/eymx2heOCa++iY5QZv43ODjMIaKVtCeGMu1SqVoTDE88OZdEW6RHzTKQu0N
         QRpHHO2HhzShoqfiGkgwZXazbRBCZeO3jC4ZIA7K2XIyrzelyELu8VCcpuY0qxcb2KP5
         E1dw8JuchJMvlJEVtR/NkxGzitAct03tNJegnKomdnU11g2FFfdEshFNXtbSxcdQsJnA
         5/TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377659; x=1782982459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyrrKmbO1HMZftBXyCoisIA6BbFwt+/qP0/7eYZgGu8=;
        b=AdpAsiCKp0Q2N2w1V9eYxm8RlSbypelnwXpoeZy8Doh+tEnltlZ+iTkSEKL0WA4NFS
         MEmC2HK5cIq1lulEKPtGTluc6xjJhapkAKR7w8N0MWaIl+wgxCpCrZUAa7SBmv9hFzqs
         6Meo5TMSjJSSQRvW3y2o+BUyU92tMT5McuK8Fu5voPL6yq0Gi4Rtk41PeupHdQaUwgWH
         KHau1ioiDUht8BthRB9/0uu2iYUnmXYLWUuN9QvF0UmnJqBYQLzDMRob+a8RpDVO/Jja
         pAiHprVfVH1SUIuWRa5FO8r0P0Oints5nUWah2NfEXodZYM4XCXVUuELugyob16MDlmg
         /0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377659; x=1782982459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyrrKmbO1HMZftBXyCoisIA6BbFwt+/qP0/7eYZgGu8=;
        b=JDsV3qefF6d3FtKl7ufogeqo3EyP0Jo1xGKm36ZBbcDKtS4WCfEFaj/bJZNa4HCoRJ
         42c3D3dNs5KGecJzFJnJCXRkMcs7hfp5Zv2jzrf4n7ZyQtY5QZ2+x3q/y5KLtkNUU2Q5
         7F6DbgMcR7SCaJb/BehwtOmNtSoXWk+5YV3HqfgKaUQHFApdTJ31Rj/M60/7ocL97j72
         g9ZaGgUR5nh1LfvMiMXOyRkgYoViByTJlYQYQVKDB2yn5bMiP0c2hIFQAh+VmQ+6RAW3
         3w+TzRel3fyRaLjjYigAXMarr/dO4pi8/A3XHorsg95LFA5WcM7EPowVVfaFUl6KT5zv
         6Myw==
X-Forwarded-Encrypted: i=1; AHgh+Rpwe6ddyWCKXnTmbW3+Z8KAb3UJEgiL7qQ/nxUZD4WyMNVf0SjH24N+mdaJGjWsBGByYJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xTrWBQtD47JiBmJl+phS6KLP2oQbAg5VDFM98eoRqec2xmg9
	f66jaIVgQBD6S8EaEAhkjklmK+6lEJ5z4+pckv5GoLGlK8H+3W+G9S+QdTibGhOpn0SSUsZBewz
	8+31atmadYORzVi21ZCysqxIUTQI2/2U=
X-Gm-Gg: AfdE7clUu1WsRDTuTZZq5RhKl0L0P5cSqVmusXuYRlbS3VOctzB5pv2rSAj9wr3pcDT
	yUWt+XKwpXcv4VwjEM7GFDUhEF/SMQVUU+fTXBPspxOe5WvVOPB2FbTOrfEGj+DCnq4oXeenofj
	n/0K7Y1siZAy0yIQP5kqxJKheqatBLMlk9dLAQgdZGIVfThNW+uZWGPxqyTC9lOS2EycEzwH/pC
	KOKdZ1DCRYeGMyjnd4DhKAvWZI2jbX3NnPH8ygT92ikIoRlZX+GEMDY/KqsB9Zkkxyti6OZ
X-Received: by 2002:a17:907:25c6:b0:bec:6c5c:ccee with SMTP id
 a640c23a62f3a-c1205eef6famr102200466b.27.1782377659329; Thu, 25 Jun 2026
 01:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5x37h6fj.fsf@gitster.g> <43C04FB5-7FE5-4535-A79A-C35449EB38C0@gmail.com>
In-Reply-To: <43C04FB5-7FE5-4535-A79A-C35449EB38C0@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 25 Jun 2026 10:53:42 +0200
X-Gm-Features: AVVi8CcP2aGthjYeZcWqN4leKClVVF1-sH9RVenf-0eLYGgwoeRAkpDGZPC-qa8
Message-ID: <CAHwyqnWdsYGHMcMT=B-Vdrb_DUK61QBs0-YvWkdeq958v_r35w@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I think you are touching on the critical point here; Git is likely one
of the most ordered software projects that exist (I haven't worked on
Linux kernel but that's the only one I can imagine is more stringent),
and every "real job" I had has been fast-paced and chaotic.

I believe that we must leave the ivory tower and make Git great for
the real world.

> I also fetch several times a day to keep up to date locally

I think this is also something that makes you not feel the pain as
much. As a technical leader who spends time on reviewing, it gives a
more of a aloof/holistic view. And more likely to have already fetched
the latest master at any given point. When I worked as an IC, I forked
from a stale branch 1000's of times and often felt that pain, I would
have wished for this feature.

> So =C2=AB bad workflow =C2=BB I agree with, but am plenty guilty of :)

Is it "bad", or is it just a completely normal workflow for 99% of
developers? Maybe we should cater to the normal workflow rather than
chastising them.

> To wrap up, I wonder if the convenience of this proposal is especially ai=
med at folks like my corporate environment (where =C2=AB build near the tip=
 and integrate quickly =C2=BB is the norm), but less than useful for those =
same folks in a different situation?

Sure, we can say that, but that's likely 99% of all Git users?


Harald



Harald
