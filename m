Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0A390609
	for <git@vger.kernel.org>; Wed, 13 May 2026 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640975; cv=none; b=W1pDwjZBHm4ypxi1uK7242/YyAkzK8g0UvqQdFy7DvhnVExDF4JzuyhDpHMHBqb5jEO+YQ/hU/1/YdvK0oM29PQFcLBI6PlIcxct7z4l2G3/Dw7nSU4IHlUX6decXUbg+MeWED3KkVsB0gn6VEm0iDBdisVZZhFXGjEx0DnhJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640975; c=relaxed/simple;
	bh=7JTpV/qxMcSh5rx10LHpv4qC4Bxik13pdcK1O7mvfUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awRj5Pk/ZHzhu+/IlxOLYJkAVfbIgBCyBkyu120ctGEELHeogXNaoR52GZ+hJoIQaX4pIy6PpWyqMzenQh9HWsBjtSVJGSGwzSH+HJ2UxZP/zSknObBhfwyYXJg2d2cNScJww0qArOQkqS3wgOflhKZpeG/SIxc+/KsyPXvK/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a860667fabso5609715e87.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 19:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778640971; x=1779245771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ZAvV5lMX+RkQ9kWul51QY0UkQ21t7eHCWQj6w5GwDE=;
        b=qVPj5Q4N4PETlF4HHe5pNyCdGEz05AIKsmY2u+Gscch7XMJfE+XJZrFTrNcQxLKs90
         2WQIJsQ0JYMCeyasTxGrnm0odzz7hhVB1faGiUogaBmJYS9wo8/cQjn8b0vNQNkhg+MN
         yCe3jqwFN+U16gKqQkI0kEMHku9zzN9lpbOBtSZlgIT1/ZvWUcSKXjJXJZEhddqIxSgh
         Wzsote4iHZdgCf7Wa8z7QD8lIGCkn/0k6MgImz6R4PEt/pK1SOy+K8OEhbXYMhB5A8F7
         0d4rVdMXZNL/zdl6qwAN07Hs/K1V7rkksEcIVPbsC98EpmyKirb3/kewKorpS0tLtRX9
         +gKw==
X-Forwarded-Encrypted: i=1; AFNElJ+e8tkVoorlh8UBHOmC6vhY1MXzrKU1niZK1IjMW2Jcqw3WLOIx4y5m8ZBOjQYOGPR3A74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmr7XBGpt8vQRab++i4nSnCIBov0vMlE8b+vxHj4r1vkVaiT8J
	PzQtm3kShXE6vTMQ996kqwP6a9ikkHrU20+4Y0bt4MpL5yNKg2XLItCD++mtO+vgvig=
X-Gm-Gg: Acq92OFdZcXajdcb+IQOjjD1/91iYhTikCCc7QwthRIMSWhnbsVInExSSeynNz380tF
	AIPOo97yAnuspUuAhQ9lWvJchc9RG2zmHa4FrD59UolZf6CBIsmJId/CqnSjrsccLX89ZkiJYep
	8xw4bz4s7jBNe/0aV1Zc9VwBXGarz8bufyBU9OMHCbQSvyEgsmc6IJIFr451cJ5a8mCTdxnRqGG
	br79tFty+KF1GUFvhj1T5kK4cBD6MCwc3P7TGknLRf3o0nNyYonxBhBukMV15gC4d9zh4RCYbg/
	25hAGJc42bHxZyF+Jm6e01EiCNl/LrpI1wwh6wUojaH5yOnH4YmapXp+5SntORC1sKxeNDpV/ET
	nq6LZnydT71IFRPRkoO44EwGvNIXhMAhCQpUdxM6l19gHDVGU3KiSPMtpU5xCMPCL97sIr42/Fd
	OI36Q1QSJK/QoEvIvISWh1VVNXo+UNGGkzVnfts4LiG8N/6Pc8JVtCjsXmaz7O4/aZyNrRDthX9
	6Ig7805NfToIg4K1aE/qybNIv/d+A==
X-Received: by 2002:a05:6512:3f1b:b0:5a8:7bdb:92c0 with SMTP id 2adb3069b0e04-5a8ef9aeeb6mr426667e87.29.1778640970415;
        Tue, 12 May 2026 19:56:10 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955df99sm3812345e87.45.2026.05.12.19.56.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 19:56:10 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso55306881fa.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 19:56:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8qNkWHWD2OwzJQ1ioFR4t20GK8T0BKFzKtB1dPXUAbf4MDp9BTOSqPm0mhdL768Y4X1cw=@vger.kernel.org
X-Received: by 2002:a05:6512:3984:b0:5a8:9909:50a3 with SMTP id
 2adb3069b0e04-5a8ef9b33f1mr477788e87.32.1778640970014; Tue, 12 May 2026
 19:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
 <20260403-includeif-worktree-v3-2-109ce5782b03@black-desk.cn>
 <agLTO0amktCWMsiE@pks.im> <d236de15-f03e-4bac-9eb1-c14e50a271f5@gmail.com> <xmqqo6iklid5.fsf@gitster.g>
In-Reply-To: <xmqqo6iklid5.fsf@gitster.g>
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 13 May 2026 10:55:58 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNAFRp+t+_KRUfV_nUXj6nFBNEHp05odiVXsUOw3+tcrA@mail.gmail.com>
X-Gm-Features: AVHnY4JsTfxdjw6lOsrLDHNn1_BwQSVxKQdW9eGLerSvsfqtykHiKj5ODizWn9A
Message-ID: <CAC1kPDNAFRp+t+_KRUfV_nUXj6nFBNEHp05odiVXsUOw3+tcrA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i" includeIf conditions
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, me@black-desk.cn, 
	git@vger.kernel.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 12/05/2026 08:14, Patrick Steinhardt wrote:
> > ...
> >>> Introduce two new condition keywords:
> >>>
> >>>    - worktree:<pattern> matches the realpath of the current worktree'=
s
> >>>      working directory (i.e. repo_get_work_tree()) against a glob
> >>>      pattern.  This is the path returned by git rev-parse
> >>>      --show-toplevel.
> >>>
> >>>    - worktree/i:<pattern> is the case-insensitive variant.
> >>
> >> Seems sensible.
> >
> > We already support per-worktree config settings via
> > extensions.worktreeConfig, so it would be helpful to explain why it is
> > more convenient to set the config based on the worktree's path, rather
> > than just running "git config --worktree" inside the worktree. Do you
> > have multiple repositories with worktrees checked out under a common
> > prefix that you want to share the same config setting?

Yes, that is exactly why I added this feature. I contribute to the
Linux kernel both as an employee and as an individual. I want to
automatically use my company email address whenever I create a
worktree under a specific directory.
