Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794088552;
	b=YWE/zQSE5CRTIKI9AKd5jqoeDlXC9Ou+3e3syYyDqfaQomAmkyppRZHgL97WpMzX0O/j
	 NwtngtLTIA9F3fQdvKV/eUiPKYZ2cNZ2sYe4rnkbthg8hXHDtFCE5cBsKcuH6kRWzSW4J
	 9rmweic2ZYEaJzu9jstj00Mr8n5GOVr7BFFn5gYd1dQxWhOmdrqlN65H6r/Dei00+vweR
	 mN/rKrUsVY5EwmvymR9j5YDCyf8dxoZa97nRyGzYacXt5NX+Fy3Oz4e9uZqS+TlyADKgo
	 AJO7bEasPDk5QXMmC+T7m3k+Dp4lOYUOzaciDTnNyLBfreyuL3y1eq4vtB1DM+xJd/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=yuTY/PUB7xFeXj24pkDosQDPidYG1FhhgITID+pcz2c=;
	b=ECabsKbwa00xRRyEarAwDGVBFqRlDH2JrBci1fBgojEhZ4dwlrA/+G2/TMSGJ3MSw33v
	 f0K867zV2qrBMrbaEUkBmNjZvJWHjSEcp/2NqlF+rTaLN9MGOr8Ss9S2IwzJb0Kvp/14Q
	 9S+u8PAvKXpIiwvtA4WzR4kPvc8VJGqOC0+6JSFD8GtuEnEDH1A3yNU7DLaOuzn2yPE66
	 Q0O5DfzQ95I0cTGQMSLvfUccRLyXEMv2QaO2nwdWmWNeRsr9fr+5FyCB+XF6cLqw138Bf
	 bN//Y6M0TToDD7Dr6af1rlZvVpJSxs+xNLLLnM7bvE8YUezA/exKJTXT7lyJipmCNoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NanKFDf9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB54606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 21:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB54606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NanKFDf9
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d290b10a35so1847eaf.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 13:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794088551; cv=none;
        d=google.com; s=arc-20260327;
        b=FP/lluAD0LjgHw6bVkD0PpcuIFP/oYRENIio+5zR6sQWDtJCEscg5u9tV0q930I0Xw
         xzzFehmnyNnq5x0BV2pZHe3d5X4/JRZTbnhp8yKfml/o+Qru0NB9n0XV88RmbGRhRykV
         FSJneL9hZxorkZx2CKPOyAyXIsFQuPoQ+OZAsN4VWJkG58vSofj9nC7Oti9HhJQKzrA7
         PygWp3qxkVgHrJ0TFh+q7thbkGg0SFmXwvFNMT4NzJzbGR8x7+VmzCRinggAe1CLUe3b
         bs8rOkvjObOabOJsu1EdtJReYx/ju6b4FXAhklxLoIpWD9aHq47IG21S8DzrPG3m7h43
         Mylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yuTY/PUB7xFeXj24pkDosQDPidYG1FhhgITID+pcz2c=;
        fh=rPcvE6UxMRKSVuXSfOMgvnxcTNqKBdxDGoLnyxdtiBo=;
        b=flJve3oMpEP9Kp/+1moqq304Rf+SYHG8gItSIy4eLSeMhiPuGLi8B5SQboxEaHVnYR
         Hs2V+npyrV/8cI3zHFs54EUX3DMyQqDyiRHDnhYGqYyoVOJjwjPwfKad0sj5rDHjLf35
         wmp9q0dS02+E/5jyksfiGL7frC6fWSIrumY5w+TemNNyzfcgAs9DgvkKI4G8e7/3CN4k
         TXN0NIB73Kd0mY1E2XE1qWHO2eeSaG7uYBDtEu6zb+X5vuDvjCIPskxyIu+btxRCMuk3
         bZ9YXntx7ai25P6CKy7aWf/jjM3f0WQuDJxl3xSw4IoK5hs1S5sfgabGtc2V7J11BRTX
         LwUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794088551; x=1794693351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuTY/PUB7xFeXj24pkDosQDPidYG1FhhgITID+pcz2c=;
        b=NanKFDf9fLutWxmXxX8lxVv5J49J/AvjU+7qDVniobb1KegxZEBqG//qdkfwhRD1um
         AHk4LCFnS9VvWb+un/S4uTCwAhhWf5Bs/9yv5PMafT5EGQskuTBO7+GiMYcMwIyKhLgC
         ZjoQ6Qrdaznwey3oTSeDUO5P7cIRrXRvFxcwYFBBvGDFndIU2wy4TwbY/UEau/Q1bsCJ
         3eGlckAtCuzQagGnQz5exFrEBaBbgmsnUaGaJks6VlfLl5Ji3Dv4e4gSLvIvShUBxsYo
         O1YgmO/SSo6hTMGg3YGHr93pBLpE7vFy9fhw08lx8EUS+jISKHrYMzIMdN+oEvcmsILb
         NbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794088551; x=1794693351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yuTY/PUB7xFeXj24pkDosQDPidYG1FhhgITID+pcz2c=;
        b=0ghj2qwtIEOL6CIYitsJZZk6+l+Z3S6a9+VNvw0k5BFZnMr8FpvpcN2Pm6vOBRakFA
         yDpfcsPtF3GG8M3V37ZfhPG+dQuJkTgEDjdYJc27utz3+gYILIABGqWEacua9fjtd6ww
         4+zwHN4COrC1aPLnHBmQw2LwrT9WxcL9jYt/++Jue0zPRacEvrEKLoViK8sTUxCBVN06
         u9u0hgD9rSD9nhUTL4GTeuCtcmAPGJuwXlLIiIONuatGETbfUyx3ElSoXbsK+7XYefod
         wKAS24IrSUZW3lJf1SiHTyJuBVy6LugUg2baOKgHyqb92d3Iefe0nITYAWkN+EwvsvEE
         SV3Q==
X-Gm-Message-State: APuU4Z/9uOjjF8Go794xFN183q4D4g8lkoVh87TMftsP0Kkiub3sjSZJ
	06gbtJobZiToQWgRX8R3/MmNLatr9/HUgWAzx1JLKhR51OrzjaF5NC3IDcVgxJPuPdEF3tksnCq
	dA6QydjbGeXtUUwgiWVcDpv5v0Wj+G/0=
X-Gm-Gg: AYBFou0eMe8nHGwTG9+543ZHYIiMc7s4rFzCYlCx/PgM2DdJjow9Yj/Y/kQvSTduA2w
	X1lezlzWIMS/6sOPbdaJL4gkje9kxgeR4xc2Vi4K3DJpUr+rAz4wE7IhEF1lO7nTTFFVuewIDQE
	/QytUSY66bvSje55TooOSYwcVuLgulEL+Ub6x6GYcstmNHqE/hFjmUBuWhlgMoU0Co2oe4JWLlH
	rwpbLFTJI3a+MLsmtf19ksU3aUALyX5rxgEn0ktWMr6ds9XsHTlOApMlTXU0jgcWboVitjFPwQJ
	W3DJO6jRv4wUIDBf2btioTOGM8ubGcaozC/KtCvT3MmQWGABHrqFgXgUsWRZso1nD5ofiu4ENtP
	DVuZgGkeJeybTRUUTcpndS4djka0nI2fNrJo=
X-Received: by 2002:a05:6820:151a:b0:716:f44b:2dd1 with SMTP id
 006d021491bc7-7170f2ac77dmr111774eaf.52.1794088551007; Sat, 07 Nov 2026
 13:55:51 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107121119.2995843-1-andy.koppe@gmail.com> <CAKrRMNpaBrOybe0hw_B+RTZ5GWeUASpR+sRte0OLL2x6xJba8g@mail.gmail.com>
In-Reply-To: <CAKrRMNpaBrOybe0hw_B+RTZ5GWeUASpR+sRte0OLL2x6xJba8g@mail.gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sat, 7 Nov 2026 21:55:38 +0000
X-Gm-Features: AclHuK_tn6NxvSN53FCwUedtV2jEY9n7UKbjSGOS5sEB_GYmodTf1LWJPTI9fSk
Message-ID: <CAHWeT-abY9_OOji+WkL3_Rpnzy0xBh3MGQCnhuUO9Wdr1hJy0Q@mail.gmail.com>
Subject: Re: [BUG] splitIndex with skipHash corrupts index and crashes status
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Nov 2026 at 21:11, Tanga Joris wrote:
> >   $ ls .git | grep index
> >   index
> >   sharedindex.0000000000000000000000000000000000000000
> >
> > Note the unexpected null OID.
>
> It seems to be caused by write_shared_index() naming the file after
> the shared index's trailing checksum. With index.skipHash, that
> checksum is written as zeros, so the file is named
> sharedindex.0000000000000000000000000000000000000000,
> which is the file you saw.
>
> The entries disappear because the split index then records a null
> base, and read_index_from() treats a null base as "no shared index"
> (read-cache.c:2381), so the entries stored in the shared index are
> lost.
>
> I'm working on a fix and would be more than happy to send it, unless
> you are already working on one.

Thank you very much for looking into this! I haven't dared wading into it.

Andy
