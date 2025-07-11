Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724A2EF667
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262540; cv=none; b=TNOh/g7fPEfMXmG1ljrFqh/DcyWcWhptGtcy6YgO6EB1aNG+u66zNz963jZ3gVXRYg2WoEBPt89wiJVzytgZwbAqL2cHvqYxzdM0Y1GsryY1gyUb1FLucLQc+OPEzAJX1qZ9ti2TgDhPO6zIIqwwfnWMcsIXduEIhEXUoeLGN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262540; c=relaxed/simple;
	bh=z2b+NPFQWDOz/0dz7YFHZqlf6yCx49eTh4QP98l73MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV35HOqgH0W4XE2sgqo4n55/y3F/GWd/gk0/T9q4fHn4OD08jCI1/u6EK1Twvml5CWkqPY+I9Roh5nGrfk4RQiL8l9VXIJLsH89UmEpUS9CnaH4L5peWwPOxFgON0RJ2afKgcrQ/i/4xpwzFK/QByfsfecZ1amfGA6CcrzblUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUG9CFF9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUG9CFF9"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1615713b3a.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262538; x=1752867338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5JXIhyd4x9nn9Ft/fRHZA4iGsknKZQEZBdaswinGV0=;
        b=gUG9CFF9ys60afE/mqC3vnGdsbfCCfap91pM+rX2GNuCvDVvToEqPfmf75VGS9R8kM
         EHgTpEIqACBp83gHcbNnEhruYXbaMVQF2c9dfFvDtxHJfU7XJg0zj8PkkLhaotzDWAjo
         ZPCJHKjYZu053ElKjbIYaoMD+NGmjz+C1UHrB3qz+oaZE4qzjLsSTIf3GhqOP6zs3RiC
         WITMBcyHRNwtJJ1gqZqHuN4x8Uw1CmuYoYbmXRdTQ361N2Qk/uRPjYDbFxiS23V/UP47
         L2RHVe23cFIYOj0+HC1AXBi0YIfA8UKnK4JgUOaXsUHtDRAT/BsC09ezImooXHMa4XE0
         EjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262538; x=1752867338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5JXIhyd4x9nn9Ft/fRHZA4iGsknKZQEZBdaswinGV0=;
        b=YRiUqyHc3CpV5PkKWkKiL9nAK92wDtnAzwloAt8/Zu6MOqDFp8hCUo3QvzSjBuTPy5
         mZnsxMFp2IsQmhmrIEdTOQz8JVlhQxe+yXJDyiZBcBZuvmkB7X3O8eKV9mFNTFFD1ReF
         poRhkv7UC4RMqHr58/t/pvivEYQkjeME7Yy7hUCYbFXxnO4uNxGySYiNgCaQ5v4OqSx6
         i8g7FstZiOn/BcFUket7fARo2iViT9wzjuC/QGlfp+40aJmSUM/4h8VQ/PBhB0WL7VPY
         kCEdoeTVbVyKEeLUbMbz/wI+BElqzKSqR7V078B/Rqjtptj3XI/+ATyL5C8thXlenAOO
         tJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUupD+hKYONeAJA+IfCYeZNr6vX20gv8p22ukOl5SjNYyzN2/NxcvW6tQ94kU5bE/+QDyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglY1I3/hZePP2bDUbyWSQ4WNDFhxXre7lCj3RZynh3uygfyKn
	AR1mVz9LOa+75JxiW5aJxFJz23lCDi1RdyyLcLgVzKoiPG3qMXCob+RyM7ZTCTif323jDAcmuGU
	XPZzLpmOR93TxPr0+OKjI+TQkYPKirdATVk0H
X-Gm-Gg: ASbGncvsAi7IQ/jjiyAnj4+HQFON6KotJyOZ8PpBSEUwp1jSDDOcurr5PYfuLRFScc5
	s30YWWRLGfWlJvgMdjWFMoZos9jyRCVhlflv3bRvQnQH7iBu2VVAvWZzIWaG5zJi4HjL5Jlr5jE
	NL6wj5yEVXetHQdB5NdtFaPunhJ2kZgH2g96V00O6xK4qg8JTDlnxa3xSv/KwewVsNrH9zHTnyO
	/Kx8bLP1V6353WcN1DQ0ez2ldYKozVH/yB9R55Dj017RqWthjND
X-Google-Smtp-Source: AGHT+IEp4Jaq2kzo04JUKQzY5dvQDEr14FuPojZ0CewtIAG2+jgOC2Pw5/kWI1ndgP451eDz48kfKt7hYKcqlisF4xA=
X-Received: by 2002:a17:90b:5287:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-31c4cd65970mr7512741a91.17.1752262537890; Fri, 11 Jul 2025
 12:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751309770.git.ayu.chandekar@gmail.com> <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
 <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com> <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
 <xmqqecuzeynr.fsf@gitster.g>
In-Reply-To: <xmqqecuzeynr.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 12 Jul 2025 01:05:26 +0530
X-Gm-Features: Ac12FXz7IoTcTHDrw7ZyEsv6a824oXgLMXyMXthOfwpmYfZTwH9CZs8meSFi-rk
Message-ID: <CAE7as+Z5ihQThZ5cXax44XNHoRzqdnZpRTrDdKKGz86cM_BgYw@mail.gmail.com>
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com, ps@pks.im, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 2:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > Yes, I get your point. However, if we look at settings which are
> > shifted to `struct repo_settings`, the behaviour is to set a
> > fallback/default value in case of an invalid input, instead of
> > throwing an error.
>
> So the user will not be told about misconfiguration like they used
> to?  Is that an acceptable way forward, I have to wonder...
>

I was actually mistaken that `prepare_repo_settings()` does not throw
any error due to the fact that it sets default value when a config
setting is not set. So I thought, if there's invalid value in the
config, it would just set the default value, but I was wrong.

Thanks,
Ayush
