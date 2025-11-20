Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE25287258
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622469; cv=none; b=gS9L5/3ytVQVcCDwfuWHd4MXqnSU0ETuX7g9zZqiHm2hKCeiQFwt4d2XKZgIKMNtOmH3b3tUC3NSjqWCvSvcv/07Kun/Arcehxlwu51/4YJu5ytd88O9de4gcYUgV6iaqQ5LvF4vJwvEWp3sUH3q4B0etbdtf1lBp0QyI4f8M5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622469; c=relaxed/simple;
	bh=yMIZLKPyhO21YLnakj5erPXj1TfqpHLXxuCa/42i+aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoxTbTlybvFLZLgvOXujYtFnmrwbaowVISRwNdZbcjlNc3Y8+DvrbRvsA9rgYwwa0EIqzpJUMBlz8D8eOd1lnF4d+ktNV25TSr56Rd3OQoK1wjGFzjmMxzDapatpJvKa1UjUhk3V9qfGAEQmyxJnlG7iv4SR6wTlylD3SVZwyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu/RhDvF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu/RhDvF"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9491571438cso26475639f.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622467; x=1764227267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04eJWfUOZmr/VgeA21pcInb9u8cF9CzaTMYWKZIGTV4=;
        b=eu/RhDvF7jTnc7Pg3WwDzgsVGQzOoO2c5mC8+S9ECFoqXdWqhN5KnM2Gg5t0L60T6d
         VRxxQbidDLwyhIz8xIBaRIbg7pF6kHHEeYCHBPvr0Z4UOvfFSqQ0FKVzZhPevkqrQIMg
         6cFgXm9gQbEAFdNsrg1N1s1toc0YIx/fcXYWiDxR0L1VgBkwN9qbkwWzJUdqakVi9IGg
         sPEF2lMnVCES03cmNv7tnLTZ48+cjCSDc1Jjnl6EW/yMwmaohtvhNaE4B2JovN/O4Xrs
         1CKodSPbJjyj0mSCVhL6vHYVZPnE/0TKPW8sMijoVIhERjgdgll5mbVBG8CX78J3YpZx
         mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622467; x=1764227267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04eJWfUOZmr/VgeA21pcInb9u8cF9CzaTMYWKZIGTV4=;
        b=iGd81q9L7DqFmtucYWgB1HACeTmm4hXtbXoGWnNQgBjIzhK4R1mUp3yGr3OU8yK1T7
         YJJWnpxMottxkDTlEN5G4QRBoKB19d8Mq3yjlF2uWSTK5d2MO3UAuzsot27yZ3oghMIm
         ELkZyL5AlW83dP2gerVS4b4huesNCS4r3tnsu5uPUCpjMvh7OGmdKTqMkq9zNczCo4yc
         XiT4NCwQkUsc8ympChJPKhhUkh40UxJEe+vUEDp2EgM3AtqeT9dHK0NpQv2jrgKUOtrg
         gG9j/dVgI8unQArAp4PLghNO1/YN0dtQMJroP2K4jSFXx88QP4K9feX//7rKLRxNmSuG
         30Hw==
X-Gm-Message-State: AOJu0YyZljnhY9OrVwCxJKyjzCZhmfsDO6GcheIKksus/8I+9qoqy732
	4eIv7edmHyVkhnYulCUQVAZkhZ0sWdEodPNfRHNESrVaSSQ3/xIzb2H6+/JQsWTq/4uZzHBC0ik
	3Cnszq26Xa6OvsWGHH8calz3wUkPx1YI=
X-Gm-Gg: ASbGncunyAxBAxcGH0eyM8NyNfWptvIHhMr7Hz6qDzUfSfdzc623zN6s9tbkEhYeDPh
	10Ls3sIDcvM8LE47RmIlE0ccgFRr9LdQufxFzhIbwz7pFIQcDS49bR8NbXeZ4958mEni8F7nh5I
	16sEXgkOF4qTUNPa94yATjBoXMgpiV1OWYtoxA+9Fk9vbc6veufXTUwSJjfbMWGI9ENWEjWZGFH
	UYXBTOAgkZeqjBLwz1Dfksb/U35v/wsAInnIKLp9Fd2RE6AdQSYy5p0qZo9W90kh6LtK2qLS3oc
	t4yzAYOiuSPkB91OPss8co+Y/NALnMPBtXxl+ps=
X-Google-Smtp-Source: AGHT+IGUGh0hLBw41EahCsKnOO6LOHaKIOVKgxFivpUuA+BxLq0PHDI6dospGjVCR5loKr4f7eePkpM+cQ6oJ+tvr+0=
X-Received: by 2002:a05:6638:164f:b0:5ae:a07c:7842 with SMTP id
 8926c6da1cb9f-5b953fd3216mr2171226173.5.1763622467024; Wed, 19 Nov 2025
 23:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:07:34 -0800
X-Gm-Features: AWmQ_blXQTzUgF4AyJYNWBNS7wWUIsSEAdSQG7pCFemo1BHAx0dLzQyReJn2ziI
Message-ID: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
>
> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.
>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.
>
> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> This patch series is a starting point for such a command. I've
> significantly slimmed it down from the first couple revisions now
> following the discussions at the Contributor's Summit yesterday. This
> was my intent anyway, as I already mentioned on the last iteration.

Sorry for taking so long to review the series now that it's based on
replay.  Thanks for working on this!
