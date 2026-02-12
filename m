Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AA42048
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892350; cv=pass; b=E+LE8Kc9CZ0gLj3BvW6G4+TAiv5O2yc0108ccAitW39XxXJ9Ah06oYLMq2BIcrk//De2nQfmcXKssImcR33H4S65+2+5vVg9pi0T49VD8S0NTpbRfSXqLYvP2j0G0rRYSVEfhG5GDspeyGFpOcI3eKMWcrTW7HPVxbtRgoSY+rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892350; c=relaxed/simple;
	bh=X9RWK4hcpL81rSC/jSRr+nx0MerRBKcSS4Y0l7yBks8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpOR+Jf76ptRtpeLj7dHwoBiIlmxrztvCA3/+EB/c/JAB1f8vEznbqVg5vEgyfzOG4VrupejZ8lnIlPNgj0EpgE63I4Hn2T9l6fhQTZra+ZPnW1jfLiiO1EpZc7+7XmUi6jIrHDDRiCun8xQjtVAIS+m3f5tkAk1pU0ij6r0cz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey+GSmP0; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey+GSmP0"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5675d609621so194386e0c.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:32:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770892348; cv=none;
        d=google.com; s=arc-20240605;
        b=C+x2jB8DFY4Iy9atrwRW/ohh+7S5RJi+NF4iqYU4xIL9Hr+4RMhWOp1VrlFEkyXG+e
         Pgp0fAxQWcDhjFCkEsiTkmskpoMypCBKE2wBh7Ae3DSX3Ot5mViok+E3wqWGi8T3Kbsx
         54IuxdESetYKyHBqWE+da259uM9gE47nHyid6iBv0fjZaJ9HBBnE33UFf5XTkBJqH5Oz
         lEBxiLG5/Bme+bzzXpPczu+6506U53yYYoLZj72/llYDujnHWShn1pWo2/jitHeU/lyd
         9iOuscK0Rn11M5UkTl4f+CTLinRxZ4ruems9AdSlYWCZInC1FOaolInXbHbr9PfebL7m
         mNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0izMFzNxkmM7YDx5h4a9+FoDM8ipIeWtfIFfJq/Zf4=;
        fh=392ryK1TiLXjQymH8YuTlaSLgmX4+VbMxfQfkGuHyGc=;
        b=WIAY46ebaNxPi4kkaUE32+GQUe5fR2kCRj+cnA55ngyICKUTRmTNZDIV7oY0xEMqZw
         KIi1GBD9iVQ1WjnGHSr8J+aT3XPDbXuAKyIuZlEOdXwZeAiUVP468oMEgigzrO7OzDlZ
         zGloRXSM+FkqtGhjMPvbPBdRuRLywZIrbnTy7e1tMCPoRMJ99KbitfdifaY+jb3iSsAo
         XPN9n1pgLEFR92qFIO7/C0qlRvMXZMrmTOyA672XQEZXmBz4qLeYcb95ctaSGTNO7HMc
         YueeARsGZ7pGBBbnjVIgMfoT0FUy7ljMhS1SNrJ24qZ2b+lDtnPehc3zwAZxK859RU3E
         6j0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770892348; x=1771497148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0izMFzNxkmM7YDx5h4a9+FoDM8ipIeWtfIFfJq/Zf4=;
        b=Ey+GSmP0+PQSWhTTKyOBs6xIRS4JXp/m6hE9hitaL0ty5IZCVXZqyE+iNkB75FC6LQ
         58QYmenCgt62C62Si7yTzf5py+NTjMbNAum9O6CaJ+BvjH7nNowiE6zr+Nh7UbofCYpY
         NF50hrdqG6WLA2nCBlRZxd4jQY5k73a6cWIF3s25/f0+Q2p7b8fEvFBz5tDohqYGu3lw
         o7/6TZ6FU6oZxiMmRaq5aBD2xt2jrTv2nOcgd0OvveStBIdfycAa6hhVkXHDydsfKVEN
         nVG+l0+jMCziGH9e9Xyo4Ao4Kf8y2hDVB6ndsSSDv1+dSg9Exmh9FluwvO3TMdSAxuOC
         Y6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770892348; x=1771497148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0izMFzNxkmM7YDx5h4a9+FoDM8ipIeWtfIFfJq/Zf4=;
        b=rbKkty5ByCb/VJERlZ5bWFV1wFrhzzaQne8iU4oo/5Gc1IXQQRi/WpjWOIgnW9cP4C
         OnihO+d+u8k1djXdXPB7PIwS230xOWb0ZSlSe/P2EYuEOVPqJ6A148F8dbr3lJkI7H0A
         ZHjSmyo7h3sNOFtIm73VHCcKzi8tf/PPw9DgpjdHpQXECglV+fGt84v0WyYt5EWxM6xs
         qprl27YSTOlv+7nPOCXVsaAF0ykF40lPMMKKlPEmbZqTUAlYpAg8bm18QHEi/UlQ5XRz
         uJBgCHFNfL2RRNHVs0/9bE+lMyUHvz41b4Thfevq1joqLUJd4nAsZxzPt9rqYr4VwPPY
         6mEg==
X-Gm-Message-State: AOJu0YxkiSOyYs1HNEgxZ4GeuhynwoEhg62jORthATt3WpPSINgFmBAH
	aE03ENBgLQYvm5oE+4WOUPHJwm+/KwyUspsY+bBdPGDEDVuldPwNArNHK2S+2sBkvc4Qn+NLdEF
	kph2GufLzgDFb6spzMJp0+JMCgJObULE=
X-Gm-Gg: AZuq6aJK9guvOYID1wlFh7sCGuwnvg7YlIahkhmOmof8KO7e5FWOfJwIoyO5t+PJS4i
	BHYSnJ/tRDLXxjbVBcXcImeix95JL0NgCLQNc0PZ4tCDPKhC1xskNzxrhCCMOHpBh9P+hh/vnB8
	P7cVL6uIBo1Ugz75w8YFWnnTfq5937q89LjTJjRCf7gVdFi0MEO8h0bjX0toaDD2reZDj0bw44n
	B8uWio3UU0puvP4jTp7422COGgXYqelrwSIUnuLIKGFs8Lo1ngpfcN8r92q3xbIQ22hE1c9X1tf
	XQkfrWxzg8/5KBMAlOIlEw==
X-Received: by 2002:a05:6122:a510:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56759e982a4mr488134e0c.10.1770892347762; Thu, 12 Feb 2026
 02:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
 <24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
 <xmqqikc9ekzz.fsf@gitster.g>
In-Reply-To: <xmqqikc9ekzz.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Thu, 12 Feb 2026 11:32:29 +0100
X-Gm-Features: AZwV_Qi4Z9Og5xmvZRMzhLb-3tZit2SwPrVv4IjNqjeNzyVmWSlyhovj0t6OUtg
Message-ID: <CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 8:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > @@ -1566,11 +1589,14 @@ static int patch_update_file(struct add_p_state=
 *s,
> >                                               : 1));
> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> >                      s->buf.buf);
> > +             if (s->s.no_auto_advance && all_decided)
> > +                     printf(_("\n%s All hunks decided. What now? "),
> > +                             s->s.prompt_color);
>
> This gives an ordinary prompt for the hunk and then another one
> after it if we notice everything has been decided.  I am wondering
> if it wants to be more like
>
>         if (!s->auto_advance && all_decided)
>                 say What now?
>         else
>                 ask the usual
>
> ?

Hello Junio
Please just a small curiosity.

If I do it this way, the user will not be able to see the options available
once they have decided on all hunks and want to rework the file.
The options for a hunk will not be visible if they navigate with say K or J
and want to change decisions on a hunk.
They will always be greeted with What now? without the available options.
