Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C21A5B96
	for <git@vger.kernel.org>; Tue, 13 May 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104818; cv=none; b=OGVNPlKIutk8JUcEoF1bNqs5xJlMay5+Yev5+SqtYTff/kqI0xdUAaqhGST7JK/U2BrByJrcXcgMd2o775pjq/nftO0QMPF0Nz/+g6J2ioHlpZ3tBUxAZF5G8sRTGs+pEDz4Yf6kzEe6rALOk1UqnpQ46Hhz74oiykIowx3Jyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104818; c=relaxed/simple;
	bh=aK01FzhLmLl9TPEGt0mFSa3aNXSr2pQTV1xNztmeAD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVa7nOQLU6WOnU+NVJdMZNFyWZcw/JOO6BZ+mZRK35JoVIYn4tSYCIg05dk3S7FNRWwIg8gn/SH/HL1VmMYgY9ti+o2gfTvYSRaYUPqHYI01EhaUz4ctbYABWWesVgnX06zRqlVAFZ8RiRUfuCoFljcchaQAuZzktCJbkDCYzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFD5jPb9; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFD5jPb9"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d96d16b369so49298805ab.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 19:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747104816; x=1747709616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvqRdFWI0IYuzc0ybjrbsqtb0dUfAkZUruYD8rYjmAs=;
        b=hFD5jPb9q88+beae6cb1HtqbjQQzckKkZ+rz/wuSW7NjSlw4DYZ9JCpqrWqPDTe8ib
         oq9DoI1VZ8NFmlDbmvGO9ezta2ZclzKM1qkBuLRNXszz2DVtRYYGOygIDYoDlP+TSjTE
         HHLM/5NATn2+zPsd2pqNP7fVA/9y6Iafrc+3XzwCEP/YgCdGKhHfHafaOhHzJCDrMMmz
         JCioH5Rew++6waWC8F+fRBzImbfHKyy0HAsHbvy0v0ayoxNjH6aX/FNsY50BwVrDJMD+
         bSxy2mqvY0P3oXAaZWDsZoOfD2z0j8xnrS/FlZu/xdcnUynu1DL9SR/vLzy3/kxVgpEL
         APMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104816; x=1747709616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvqRdFWI0IYuzc0ybjrbsqtb0dUfAkZUruYD8rYjmAs=;
        b=DYP1EafHCJf+dPbwgw2K7FevIwKx2hP1LEPd0gFi5BHmjzApXCC+z5aAjjvCa6EYAz
         UiAEEvhsNNDnxRiEMVxbKkGxE+gfFDDIusDVxm100yEkS934Xl8A6DleFOTsUEGfvjmf
         Yf7Ge/hS30bBpFJ7xd2VL3hT2q3ZuUH4h3uE8NrxfOt6lOXtzht8D4n4CiaFpLJDc1Id
         +Qateh4Jyn7JEk32yq5fDjFwKEeLhqvpIx/k82UBudRRoXykNnhRzeCPlj0V+sXExQuF
         YmlA1u8JunPLkd7TClzf516+7D7u/1sSU1/NYjtVfLbcM+KOeH9v/cVOQpqRenUbUAz+
         VJdA==
X-Gm-Message-State: AOJu0YxlTr/j6VpM2iTSlnNLTv+zgG3YLOg/Ij3HcWGqQNn55mBNc1JK
	DY1Ti1eDC2J8GnGNCQaG6xMsGsSufO8MwlsmV/JJSsnWWVL4CRIAcI0nrjCvWcJpcS8T0/+AhUK
	bB1OodjnrA2XY4Ay6lOoUC/qo04U=
X-Gm-Gg: ASbGnctRw/dy48Ct38QWjbzLZcYNXVxMNez5w2YZp+CrkvsC1aOwS8ABpPalb4c8V52
	nhTSHaakVR+DiIMZ6zNQxRTvfdbykevQsbzSZBxcDmlVZoQ3GuxQd9SN1n33EjGXilkf4joH7GQ
	/pVH9J1vV9vXzswIeSqLFplxRzdzlfop8Oc6YrMpFgSho0BJ5aaV3feZ4NfSchjdzOJg==
X-Google-Smtp-Source: AGHT+IEPtvxwS6aixZoN//mfZ7kGxSkyKohXDLwtkNXR4vEWMwYI1I8zgQHfjL+jOPSF12ox2CVaFIgsSPRo92H3WdQ=
X-Received: by 2002:a05:6e02:3e90:b0:3d9:2fbe:2bb1 with SMTP id
 e9e14a558f8ab-3da7e1f1d23mr178322955ab.12.1747104815929; Mon, 12 May 2025
 19:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im> <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 19:53:24 -0700
X-Gm-Features: AX0GCFuCAw8E1d1A68ujMdw2VAjZXI5aGgLnTsX0sa0mJ9zi8ZzU03e47lXjUnA
Message-ID: <CABPp-BGvhtoN-NYZFrodxtBZppuHtujo93=dKjdxOHHiiAr7tw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Spring cleanup of "contrib/"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> as I have lamented multiple times multiple times already (e.g. [1]), the
> "contrib/" directory is a bit of a mess containing many bits and pieces
> that just sit there gathering dust, without getting any maintenance and
> sometimes even in a clearly-broken state. So I decided to finally bite
> the bullet and do a spring cleanup of "contrib/", which resulted in this
> patch series here.
>
> I have used the following reasons for removal:
>
>   - The tool is clearly broken, e.g. it doesn't even compile.
>
>   - The tool has a clear alternative or just isn't useful anymore.
>
>   - The tool has already been removed, but we still carry a stub.
>
[...]
> Changes in v3:
>   - Adapt the cover letter as well as commit 4 to clarify that a script
>     not receiving any updates is only used as supporting evidence, not
>     as a standalone reason to remove them.
>   - Don't remove "contrib/stats/packinfo.pl". We don't have a
>     replacement for it, and its functionality is useful. We should
>     probably add this functionality into git-verify-pack(1) itself.
>   - Link to v2: https://lore.kernel.org/r/20250509-pks-contrib-spring-cle=
anup-v2-0-14e20d95ec68@pks.im

Thanks, this version looks good to me.
