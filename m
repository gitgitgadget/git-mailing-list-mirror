Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2126ED2A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887620; cv=none; b=MDWdVd9eAMfYXR+wR70W4zmiuI0KYph22qAsTBhVIrtDsEpSN/gyx8p+LGzLhr05sK300ZCuVq/0OMYt21oex4Dv7RNlB4ePqfzXQSXSRYCtsk/eqicMDsEjuFeIeGzrs3EYkAspwi94wY+/VPDdO/3Rd5GKApByX/qa7v6gmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887620; c=relaxed/simple;
	bh=v1GYdXJrkl+UrBA3Qb31u1pWAmYQwr5cm9fpSiRkVso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmgsbiPcB09/qvSdb+s/2PZq+KJMRAPyg7FZ+BonOYwY0BgO6Pg5WuCfDUqaiWeXBmeaRz3efodcVZG3vqHVhSZplRv5RZueQUHD4TG+tA95sv9423NVsF5lBL4pfIQpiBJzLu+rR3orq9PRhduxegblagI9o0EW+aMWhj/svJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcXPLpvZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcXPLpvZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295548467c7so364145ad.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762887612; x=1763492412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1GYdXJrkl+UrBA3Qb31u1pWAmYQwr5cm9fpSiRkVso=;
        b=FcXPLpvZVzX71unL2DGaFq2Boh2mCPGKM8LmHDx7/v27ZQz0EqxrzRmfKrs3C2P/RK
         e9u0BJWuWxjFwW2zasXyK4aNjr7P9Hxe+vHsYErOVRvBNXSUJmiBLPURsfxzWfC8Tv7F
         ylEUMuyzSVgVlG19ARYFBeIx7tpMRruo/TV6ipBu0V8w8FZ5NmA2ydHpAlCMwjufsBD8
         MyK58ReUSSc6wtZ2RXHXUqgtyZIT8UrW90rWm+fKHNHOJhkdIi6e2K09hlGuDblSzWso
         fZKSRQgEn9Qn9o7UiCaADdVWk2qNIqLJnYIIHNkzkXfZhltft3NYjTvq2VWitBUT4Au1
         1EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762887612; x=1763492412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1GYdXJrkl+UrBA3Qb31u1pWAmYQwr5cm9fpSiRkVso=;
        b=tJEhbB/sWlMfy/JdCJmDLky5dscGrKZ6qBhQirgzQIqeH1j+0pQzNk1wy3XZjuBezV
         DKypP15igCYt2P0UZhpI7tZhcGoYpBu8zTDSHRbdCSSuB93AhKKF39w5zQpjGmQA1/Jb
         ezORJB6Tqf1KsIXDFBp1nZcOhRIId+bTiiZbipiAF/gzA32t68cV2w1Knn1TQiR7NkF3
         fF9AwmHOWZtJxYQZhJRKBldoUGfrKXvNLS0d5AIn7ey2ITY9ZjZUWqofdPcuTrIxPn/e
         18Rpef0B/h3v3ZHgFsk6nvbudp1GdeLSrFH4lfbySa1NJavFiTEt4JXhsokuAs0Dcjd3
         RILA==
X-Gm-Message-State: AOJu0YxZ/jOILwNOMsJR1ZkZvUg9u7w+OPU1xHBXAXQMofuXNN93TzXt
	zRp7UOb+hMyyV+29jV+kvpMzsv43ZeNj7f4Cd6H/rLBUg0Mjjsss3IfYkUCbr6kLeHUmzyaeehl
	FP2EPMPI10iNT3PwnzJkcc3H4kn1rkYc=
X-Gm-Gg: ASbGncsivr+/3wHndfywA/lja3QGq97MIUYrH3vvWl6vRHmKWWpR4OPUvBdmfrm6n9I
	DYsY4bl3lLSmN/S2tQryQkeZXeYDUi5MH/dB5wlyxUEwhghyi+vFQrBserSTS5nftljaZfnKEuc
	QXshnmHYMaFhTLdHmPR0AhBzJo5x5of7m4XYdUPblJhR4fsLBco8BPmHtkTKThlCIm98m8v+vPW
	kO9Z8JQz0akus4r75bdv8JjmiFdxQunJI35o0Kaq2PndCrNOpvdTQ8qRotTCnqPvYW4eS4g
X-Google-Smtp-Source: AGHT+IE0WrnenDaxxHvdgR1b5jf1F5GCBfr57Eec1IwI6ccWUVyHFY4j2s+bTxIOrR+wVCSqyCg2oAUJtlasmEl5+eQ=
X-Received: by 2002:a17:902:e849:b0:295:8db9:305f with SMTP id
 d9443c01a7336-2984eda99acmr4371585ad.34.1762887612058; Tue, 11 Nov 2025
 11:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
 <15f07afcb66a900e5391e6b07e0701ce84236f04.1762820188.git.ben.knoble+github@gmail.com>
 <xmqqqzu4wg3u.fsf@gitster.g>
In-Reply-To: <xmqqqzu4wg3u.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 11 Nov 2025 14:00:00 -0500
X-Gm-Features: AWmQ_bmuDAR2PtJloEeOpti-8JjDKogsGTVPax-agGhTd3lLyihcbv77Gi0A-u4
Message-ID: <CALnO6CA2uLjWg_kwbaEGd+TZP4qQEBMus6HRVbo7Bz9oHdoYxA@mail.gmail.com>
Subject: Re: [PATCH v2] perl: also mark git-contacts executable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > When installing git-contacts with Meson via -Dcontrib=3Dcontacts, the
> > default Perl generation fails to mark it executable. As a result, "git
> > contacts" reports "'contacts' is not a git command."
> >
> > Unlike generate-script.sh, we aren't testing the basename here; so, glo=
b
> > the script name in the case arm to match wherever the input comes from.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >
> > A small typo fix for the commit message, thanks to Patrick.
> >
> > v1: https://lore.kernel.org/git/7fbb341e8f05fcde3a1543e3bb4e5a3ec110169=
2.1762280097.git.ben.knoble+github@gmail.com/
>
> Together with the html one, these patches match what I have already
> queued with local tweaks, so I won't replace them (they are in
> 'next' now).
>
> Thanks.

Ah, sounds good. That was one of the things I wanted to ask by "shall
I send v2 or does Junio mind the trivial fix," and I should have been
more direct.

Thanks.
