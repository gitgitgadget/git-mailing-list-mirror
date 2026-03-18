Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640B184540
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875609; cv=pass; b=t6EZPZIdmlW+PM1YziBPKY8bdHj61t1SZ71ieRJnEygeb0j7qPSfHkckk8W8IBEvciq77Y6NT/KUw+Q0+qDws+inhGirHxjyoOMpNtytWhT7AZnVaqEPz4SU/inNbhi9IfwH7NGBu6Z4JWRnUzDSmLYxl+LGmmHzEaF+Ppxqcws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875609; c=relaxed/simple;
	bh=GDe/TkXtwIU9XtKMF+Kd4Wkjdvrn+wtn+21OIPe++fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFMJhDWyGS8oPzT3/i9js0EsD44jlDT7Eiyfw3qrvOUiN3pE4eiTXydBAEJH9b1tVr1nHqW7us/Z9Tm6dT4CpLm+97OrR72JilHwxJi6cw9ofbpMGRzVbcRu1nRojVPZgf5Wl+nN5v8eu/YaN0fGO7MPinekgsoke9maLG9aePI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS71t7Ti; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS71t7Ti"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fff52ab292so115608137.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875607; cv=none;
        d=google.com; s=arc-20240605;
        b=jpvFIt+y/IJGzINvDYm3QvDJT9ZhVSwc2zNBEVpO9x8YH5RbZjiK9kdR6qC6i40yj7
         1qiMV8824AFuWdaeF4zHuPP+04J3IRRzxdOUr1HzWGVqdssActbqMKF04b5URVCS0ZZL
         XTxfRI5xBNF++L+PMArBxjiQwWWWz2TgXftn884hfZ77OvlWag76YoKQNTOE3o9B/+p+
         Fd5CD7QM2uamGa5XLzWFegdaGgwhE2YGlr9nHwmU+dXoV4IbsSPaLig7W2wEvGr/aA4p
         tNDN0fkNw4LwrVOwqfqm+V/Jxm1ftTmlBuSrZ1Kq5Ov8OREjqtIPsvpaPtl1XaLwpu8k
         ij+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aJzSBJd+qrA2p61iB8TbK6+ASYZD2S8HOdNb2kDvogs=;
        fh=l9w/CK7gb8pPgxsIND20cpOgEiDBd+vkaJjFjHCeOFg=;
        b=L10JIddXL1Q0/bK1ESSuQrccreds8RZ17eKb4vavW6Gv4PKoB5NtKsy+z0krEorGFl
         bobOBL0fckMWIjJrr5Xlxk/jIXbPzlpWuif1BlYcHxIbCIE+RTzetllgC41utH4GHn0o
         c19wiq13aUZvaRHWsHH0A6BGetw36up9PMDegGelcNO4hhn7QmTfUYX0NywL7hw0iZIO
         0cFgQkhM+fNl+STS5O1C2XgYLF0zkyA2rkF+B5s+Nj/R+5SxBQ67SwGNnubksjsaJQfP
         uMSWNe4WhZ1f8AkPVCuC0RcCQaOyvtWzWjREGy8sSEhPBxGbjMOyAUXVTkxM/hScMH9J
         E2xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875607; x=1774480407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJzSBJd+qrA2p61iB8TbK6+ASYZD2S8HOdNb2kDvogs=;
        b=IS71t7TiRdhuSRWISr635USaL+xt0AHkF1gwfkrfqs7HGjXj+uOdoMJWG3YCH1F+xZ
         UEaOaLTL2DIJI5FvKKlgtTobIBhIUT1MRQN8EenVVHw3Mzgy8LQbcgIvRGkOBH1vxNnO
         raDcqufb0AJ5HJKcvoPWaRsPSPccD18Z4+JpMHNURjS4xBWBbMfbZ8tphVqdUiTd3m+m
         reSPfmbHcWHWD/K9ovxSwvB8fG/bfp1NTjkvzBikdxrdmuovuXPvEiPHqJVrCZftc49z
         MtpfSyVIK5cPuZNPTQhk4kFH4D09LJWBKApVfbT9Ukyjjn8zVS3hp+EFkDRfyNlKWyVO
         z1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875607; x=1774480407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJzSBJd+qrA2p61iB8TbK6+ASYZD2S8HOdNb2kDvogs=;
        b=K8Xaeeb8/vdPE3msDFbI7RDy2P+SonSEzmDKNkzFwwC0qvUYVb10bKx7rAQIq1D9TA
         s0Y/JzcbpTjOkiFglFFqrPkRicVYmBNIUrLzlUl2xO18RoLAWHgb+z/liIFwWr94+3Qe
         UUn7V81+td/+D+Tit6bl7gXPA3Oh+xT3593A7DQyXzUVIpcIj7g3Cpj5so7jxGMq47+i
         wPE6iGlzXqxyXsAXUbuOrVZcFZ3ntL5hPb6XBkyDNmoUXAKvGxbiUnmwSX4OMWeqLx6D
         f7GwDTlgWrJJ+zIbUHQpkGH3anAXpUOX5+dLZVml8BF7QASJQJwQYCLtUnvRwFmOFJaW
         87iA==
X-Gm-Message-State: AOJu0Yy4DOzRgqlYz2sXpOkYdc8E3QZhl5yEwf8FKyW3CC4qVSmQXQ4n
	h7jacAbbA95mUS+0NgXORsbZgMBrUOBkrUFrjatPdcq4nXqVIhE2WlEwzWKZQ42gVe3LoyLSOQG
	KiMSwDw56e2zCnC3AR4Fixi8MfBB6orU=
X-Gm-Gg: ATEYQzyGZM0Ql0UsuNyE55awgAe0nf4JgdtAV1G87TxHKmNkZDPEoY7d3Mil0vEXBva
	jw8TW+DOdJVt/O87P4ebAXXGLb1lu06nkz/fpiX2dka7u8e/oqkx0cn1pJbML5GSpLhGgGMySNR
	pkbGMy+4XKdgPh3dZfhzR+B/QS1fq522PXZderAtHZ8lY0/9xCBrG2nOxv5hBx9RPVISJ1ROFV/
	bEEnF5dONqoF+GkGT4OVS/H4XeicxQZj0+095wFnOxhZzJNmp6hMvHm5kyKhBeM3FIanNgvFhBZ
	GID0gcA3vtvzUMNH63DA2Mp57LFOiRE3pj3G8w4=
X-Received: by 2002:a05:6102:84dc:20b0:602:93db:7fa with SMTP id
 ada2fe7eead31-60293db343amr640621137.33.1773875606909; Wed, 18 Mar 2026
 16:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260318204028.1010487-1-usmanakinyemi202@gmail.com> <xmqq7br8pzr2.fsf@gitster.g>
In-Reply-To: <xmqq7br8pzr2.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 19 Mar 2026 04:43:15 +0530
X-Gm-Features: AaiRm50D5oXFme33TM0fQYzUkDdJ7LJxs8KOfSujo6BmxOl9ZtGDv_l9S7v0ZaY
Message-ID: <CAPSxiM8cFLXNQfVx1V5djHD1MOzAJz83LEWKZJ5znXTO9zfngQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] push: add support for pushing to remote groups
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

>
> >   - The current implementation pushes to group members sequentially.
> >   - push.default = simple interacts poorly with group pushes when the
> >   - force-with-lease semantics across a group push are currently
>
> I am indifferent; comments from others very much welcomed.
Yeah.
>
> >
> >   - I will also add the tests and documentations in the next iterations
>
> Hmm, is this still valid?
Nope, I already did that, this was from v1.
>

> >     continue to work correctly after the remote resolution
> >     change.
> >   - Add a test script t5528-push-group.sh covering the new
> >     group push behaviour.
>
> I think you added 5566 instead of 5528 (the latter of which is
> already used by another test).
Mistake.
