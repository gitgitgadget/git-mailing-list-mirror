Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427C3A3E85
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934800; cv=pass; b=pc38n5OqIQQiJxTbGYt72s7RnpIIdDbmn9XzjRav6w3AQQXOaIY8hjyMrOT4OvYCOmGmoBfsR+hQsTrLWu6+kpj5G7hmNQcld67CPXat+QogthLTt+fFlEjcM6Yb6iERKNvNvbsmmaNt4fj0l3GIbUKU7whrRSdx3QBjMZP111s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934800; c=relaxed/simple;
	bh=mjmsrIn4ija6e1JvsWZdBcbboHVd8/sOZrPXehe7M0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI3Yqj4xIPbDCEkBLfhWVjJV/ZqBZUKeVLJwZInrZ9+8fTk5H7Lxz76QudokV2dVzbxrz+7eDpP1/x8hvFbphXSklm7WuvHeukjxXKOb8qA1WIj6h6w9FZ5SBdLzkJGTzoSBqP3CqPf+Y4wEFH3Oc2yOA3C/H/05vM82iHVpiIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1QTxrHA; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1QTxrHA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486507134e4so13179785e9.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773934798; cv=none;
        d=google.com; s=arc-20240605;
        b=AqaVRBk1QrbS44ZZqhj73fTD9Gcjcv8JY23tmf+NGsg90l79iiMFaHiHu0kqek0niQ
         lXS5fWodoNBV3ZHI0nPD8f++SjQo7D7h8S7Jbj8LNMSu6yF0aDGN8ss9LAmB1daifery
         EENwO2nWXPY+C9DuxTlv9oSlgF8Br+6GTg/tR/wmBpuRf7oX+uBNEo5NaNAyf1S+NaLI
         /JMeBxhY1bc4b7koXzl2FemPGkb/xdHJMeEvUdBbIvo2AkFBSQmiuFzBhcRK6ls3JCxr
         91mpy+uRoCi5LR/dD3nlPMc9Fh0qD4FoXbjRv78i7f+WnCtuhezWLLN3jmAY5sWh9X//
         NH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mjmsrIn4ija6e1JvsWZdBcbboHVd8/sOZrPXehe7M0o=;
        fh=WfDbG+elOVIQ7AVAaqP4B2uCB6NOk0kRoI/2wQjT4b8=;
        b=XcU1U9k6whA4IOPTkjKAEG/t1Prn0GBxwaE6uEJq2KScJLN1O74LxywlwgCXge+Wn9
         1TMTitlKMym4VVMNxGqwx/qq1VvM7+VO3kbypgC7t0Wg1eyZ87xCSDWxuaZF2x5ir/9P
         NWymCoGUGXF2YGI9hm0tL4tURv6nl3HFLKuwTyNjN6+hUJXDwIcMBU2S7/BrbMMHY/qW
         FW25DKLw+ri+di3sSU710R0dNfsGMkk5TrH5rMbnapTO6Ik+q0IRweN+xoIj0Ig7WUaN
         6Dq+EtpBtqzBVNLgH5z72fCfa3NY2HvYsX6ixe22KfbQN/IkEyFevgcYGPfJh8p1GokK
         5zVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773934798; x=1774539598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjmsrIn4ija6e1JvsWZdBcbboHVd8/sOZrPXehe7M0o=;
        b=V1QTxrHAfOfDY8REpN1euQkLhfeYO16ykcO4YxZ5ptmYO54JgGNK1n95DBsV5wSbTv
         vmyeLOrnk0F1ZrQJq5qaGdVPWvDCnTInLaeIeZScyNFlMp1v3i/8IGAU713r36mhh84w
         hy0NLEumHWwevKaD55I/jTHgAt2P1U5LP0igw19c7uRaP22LiHR4QF9HV0sT+zeLykNh
         aW6/hFMcGXy3roLkepPSKHtTBTNsmH3nv5iRGFjyX608a2OEsdMHHg9/mVVrVQ8yTGiQ
         HecRMaSjmxjT4UhTZVIR1UNqEEHrFC7lZmN6QGMT0KhBlDaCxU/W9OsFeo3PwcGUZ6Lo
         xJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773934798; x=1774539598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjmsrIn4ija6e1JvsWZdBcbboHVd8/sOZrPXehe7M0o=;
        b=GmJnO+t89eXVPiBu/b/v18MKfDikhUSZ0B4s84ZETjYMqjOf8CLBwEKINdqf2AtMBv
         MFgrdYQTcipQntD4vtvOxbmHfMF73IZjtGn+PM3MHIr7dOcuuAxXkY3b/59S2L/wy14u
         fMSawRdzaFPPCe1EyDem5k2+OfpDuxf+peLAF+P5OEmaPozNPLSW1LBbtwdEVkv2AGwY
         v3cfNcyqYTEp9awYUKOO2Y/p4eWrOH0IgT/z5s+CDwAntpIbjBTIt7x4ZyFwIQZJuur9
         lBARiy1aKg3jE1Cy3U5BcOJTEdh8neme1wD4BD8aSU00li92EXbDYlB2wGgsztFqw313
         hzCA==
X-Forwarded-Encrypted: i=1; AJvYcCUEX0DL6UOHDSRZAxYVR4Y7exbmiC+xvwbYpg/0OkJOFgHh/G2KbMrgTUuI7nR43ZLAnvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFtzU3oS+OOYZ5koufCwPu4uBq0WXDIl1EUsFtJN9ja8ijxZW
	S1/SaIuGm4zEOlVZZJr6u7w8FkJmtoQJrIbpDZxi8YqKLeZgHQnS6/eCOiMmWw2kVa96rOiuuzu
	7Ex3yQmZI8IypsOt9+Mtb6sfi9mCSMFU=
X-Gm-Gg: ATEYQzwCfW6HTb6JphXmb0KhBusx2GL8k6xGxJ6S3xY2tRc47rGYjwtt0l5XCuSxe5W
	PqXtKKxsLd1OM9kK5KChq3TLxbfYkKQnzFtnQxKWgwxB+MgcrSe/SjiS5mkikXSR9wZTljQT4rD
	eKtOQGtJtqjLDr7IgSN5h/oQwUyKQVgxRoUvtDO6GZjy5yAf0jzE93QEtXVE9nOrtGZgFgMb8iM
	4H5xAjtZIkVW8UcatlnS0wtPF8ewEhGCVZAEbQL1AVj8HNzY+d70eaJo75QMiXOALvTMa6BxxLu
	nQeAAB8kdunBay5E
X-Received: by 2002:a05:600c:5303:b0:486:fc3b:3e61 with SMTP id
 5b1f17b1804b1-486fc3b4071mr36954935e9.18.1773934797306; Thu, 19 Mar 2026
 08:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
 <pull.2071.v2.git.1773864455956.gitgitgadget@gmail.com> <xmqqtsucq4l2.fsf@gitster.g>
 <CAP6n+1Uj6sd75ENFY8=7NtcOUehTjY86YQV9YOWgdOqfmFHYPw@mail.gmail.com> <CAP6n+1U9UHp8B_DXLJu6d1tsSo1qCuKXdH0tQjXXj9wp01iHtA@mail.gmail.com>
In-Reply-To: <CAP6n+1U9UHp8B_DXLJu6d1tsSo1qCuKXdH0tQjXXj9wp01iHtA@mail.gmail.com>
From: Aditya Indora <adityabnw07@gmail.com>
Date: Thu, 19 Mar 2026 21:09:45 +0530
X-Gm-Features: AaiRm52tq6duznoZZ71ymII60meF-sfLd6p27FsY605ZdV8OI6d66FGLotdbKaw
Message-ID: <CAP6n+1W2tr-WW401MkVTE_tEHnp4Cabe2EOb9=pwjRWraiCRWw@mail.gmail.com>
Subject: Re: [PATCH v2] t2107: modernize path existence check
To: Junio C Hamano <gitster@pobox.com>
Cc: QUANTUM via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,
I have submitted my patch v2, in this thread please tell if any other
changes need to be made or is it being queued.
Thanks

On Thu, Mar 19, 2026 at 11:05=E2=80=AFAM Aditya Indora <adityabnw07@gmail.c=
om> wrote:
>
> > On Thu, 19 Mar, 2026, 1:43=E2=80=AFam Junio C Hamano, <gitster@pobox.co=
m> wrote:
> >>
> >> So we've seen you identify yourself as quantum, aditya, and aditya
> >> indora; which one do you want to be known as to this community?.
>
> quantum is just my github username inspired from steins gate anime, my
> first name is aditya and last name is indora , i want to be known as
> aditya to this community .
