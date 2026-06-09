Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772822689C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981235; cv=pass; b=Iho1KfRdCOiFZTRR8WS/8dSEkynGqrmMBDy2Ej8rCdLmVUZKDLk6VhwoTe5mnrOH9oWumi5rTOmWBoWjI0is4O59J4thLo7jQ4+7YpZxKq++QFM8FrBvy0NvqpeWzkpLKkgzwtdGdVTqQwY7O5s3ZQFTZDFwyYHQ0Toye8VHuXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981235; c=relaxed/simple;
	bh=mIjlJJv3GG9H342BpDdcd0tKKf/BIOn32RrKBo/haIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oucGmgQAQLl8Mv2WP4hfuyMKGjyGXtZrWTCE0ZAUufnk9odh5tUoJJAmJJ8NoEDUwbWFih8u7i/0I6YqCfnaf01TDs9B+1QzVJJ3ZFKxAhyAgOghsm8cBUNlfg4+SrEDeiFGOCHiaN7c0M02HIfoYV+DvHqRZGmqXBjjInM7YTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlhzox+B; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlhzox+B"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39676ff4674so46584741fa.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 22:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780981232; cv=none;
        d=google.com; s=arc-20240605;
        b=hLAm7zQ86zc7Itv8JfOVL0yo6oWPK+le7tmlYlFHP7mkhDwQlqF/qfHF0hJpx4b6B6
         1895gGNsENMHNAfVv6tNQz5EVY83b1mKi/XlRwS4eyvJyqzwVJFehyf1GbQGvQ71X6k4
         Tv75VZKaVClBGZkcXBJb1H1A22i/ZT2ScDiMjI6bOelbyFS8iQV5o6w5GPGT0QMMY+VA
         aZYncZG1gcJHnbIjEYAR1fQIpLl5nlVkPgeQEKVliq1ZPu3nd9WFCqfQGMISsQjGMwXp
         49IiWr/EbgQ5JK9StnskaglwZKaA2/WXJMba3qv/IY0sA6np9vZgnwZeuURdp8zFlwHB
         LjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VK0gnbnEPdT3CZ4+ThSGTD+IHr7icFrGMDVUOJQKB5E=;
        fh=DjLjxEgSCSZxqJLqZAUOo8au+fhQopJmqXzDOyWh4Hs=;
        b=GL/Dfw3U3vluyLSaxFXWiTtc7cX9k4nHFsnj71ITIRywSwkR8GXpPu49xjB52T++5A
         bhWQqmopb8tsdtPuBvB6r4/S0CUCdjNlE84kr1LaC6ZjyZnWgYBYN8bMozCRTWFLsQl9
         GhgPYNvA2cs1zwLAP/BacwY2KdkZlpZB+5I9OiWsVo5/333SyY4ThBi3QfVYTw7Qv0lU
         wP97CqAoIpbb+JUoQoNRdgM8M2XwmTMNbMCKEAVg30WXGV9KXwPiA2g1WjX/m4q4CQUX
         MRTgPJbj+Jj9srqw5+hQ9jTTukXge/knRG90mkRxfolsTQFRDYTAnn96ke7Y3C2GMZ8p
         22cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780981232; x=1781586032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK0gnbnEPdT3CZ4+ThSGTD+IHr7icFrGMDVUOJQKB5E=;
        b=Jlhzox+ByW8Lu8H9YtcDDAMgIuE8isg31ExvEEuuBhcN4R4RsLkpLmluj6OgOELafI
         99mX5A89jd3fscvcvPL78j5ozbMR5yqhqNYDnpC6BPSBdkrnjLTxolUUAHyd2VGR0Tjr
         mB3DzLSYbPai1mvxbOqZXBUX2Nz7Wp8v0TP8I787Thg6a21JuCINTK97CtouiZtZtF1f
         d9WqauixT6b+YQU1TMvc9NR6znIoo6SApa25ZrH2T/RsEVKU9kMq357FUy5TQLfUq2ty
         C0oaHVUlOSeTz43LLIJgSzFMYktObzOiGl/GuDhNTBgudtQjNo5iVprW4tSG8YVoHSW0
         v/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780981232; x=1781586032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VK0gnbnEPdT3CZ4+ThSGTD+IHr7icFrGMDVUOJQKB5E=;
        b=nHumr7E0I0a3g+kTkuGNNn9ljO4GIqlaQUh3kBOzJqSeRol5melsGzvsCk+9nmkCtL
         nEwTxZWyWdoACVhXANk/EdrXtVIW8kxUqWyrZvfgn8aNcqRQP1sKM9hEC1Vtp5bPLcPX
         COMOqH4T6bWFHA+vbBAETRoC4RR7oZ+e32tMHRWggsQTsNdUT8zpSihIKXQJR65O8vYe
         1DOoilMTqpIly/m3QWrSTMEHip69nHUG2ZgV4ht9xBl1jNw2XkpTRoNfVIaC1f0UWKrE
         ZHg56aN6z3ABVhw8cXS3v+qWm19Bu+/DK7auot8xT16w8xQbZGCi4AEWRQttPv4cqueP
         bTjA==
X-Gm-Message-State: AOJu0YzpypEMqNjO58EZGze0CtZ2Xz9DAmXlv9bVQ/aN3K6qIlTAcozm
	zAGmddafIHEiDtdusWJC4XhiDIKMYpcev80S2MobEdfRz6N9oqxP6BEcUSR6GRxoCq12gzdOPsu
	sgAUPO1UrmmCRviHCNurHz97oA+IiR+IgPdT7
X-Gm-Gg: Acq92OGb1IBAFTD7vqgmlaDaQQbyEsMZa2wNNFTAFbyWZZljgUdROoQGp6A1QK2Wdcp
	tpmLDEKVj9Kcw5J9fSXgNdx0BvwNXdgAzJJrzQQ8XdQjCJfS7zbb+NFThJx2EwYjsNwFjG0p0h+
	PkZYxYYAXwafaPk1hYP5voOfJhARUhnwbB7Di05ifMaMWj7MZz7ohelo9ei8xAFOi6gklDHr7N4
	t0NJGtQFM0XL6814b2ypN+Dx7uJPRwuZIXFJIAmIf3X34DIFKEHIpStrdSKmio/EK/tVP8OiT5s
	MhdhcwIfx+GkVn06xIWFCOLnexkIGqL+/SEN2DcQRMnqYD1VUyEBEp4bsexq6MZRS/TjPqpwYKl
	YUiznl1X5M3LSbseMyJbezK8WVheThiE2gZdM
X-Received: by 2002:a05:6512:668f:10b0:5aa:6c2f:2a36 with SMTP id
 2adb3069b0e04-5aa87b8be39mr3987709e87.4.1780981231869; Mon, 08 Jun 2026
 22:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com> <xmqqcxy0vevi.fsf@gitster.g>
In-Reply-To: <xmqqcxy0vevi.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 10:30:19 +0530
X-Gm-Features: AVVi8Cf6zwj8isqGgAS0WELJTGyjmgaNf1t_rE0DjptacK7G20ocTEmmJGCQjFk
Message-ID: <CA+rGoLf39iQH9X-xKW7HeTS3sMv-N-QzGiqm0Y=RYGOAqDcaoA@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, jltobler@gmail.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 4:06=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > 2. Should we consider a default option?
> >    Currently we have path.gitdir.absolute. Should we consider an
> >    option where a plain `path.gitdir` returns some default?
>
> Probably not.  It will invite folks wanting to tweak the default
> between absolute and relative, rendering this feature useless for
> robust scripting.  You do not necessarily want to save typing in
> plumbing interface.  You want to reduce ambiguity by reducing more
> than one ways to do a thing down to just one way, and as long as
> that one way is not overly verbose, you are fine.

Makes sense.
Explicit keys like path.gitdir.absolute and path.gitdir.relative are
unambiguous for scripting,
and saving a few keystrokes isn't worth introducing a configurable
default that would make the output unpredictable.
I'll actually drop question 2 from the open questions in v3's cover letter.

Thanks!

Regards,
- K Jayatheerth
