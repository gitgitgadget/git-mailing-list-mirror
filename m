Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DE26CE2D
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304535; cv=none; b=a7sA2EoYf5Bx41W6YYVwIT5XkI3cQ0ibH7wqRokQuDZSXKcV3pkjD9EpZE2VtG9H4vLodRrTCYRTUZh0fUQYOwYmjeYyAG4iSLJk5ERKcti4uZ3zict1skSdlskE1TNpijHNpM3ruTAqOFcRNKQkokU2ERRq1ERGV9SXNw5KMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304535; c=relaxed/simple;
	bh=klfQDfgfLH4fBOIyeGbOIQ0Ty/NWn1MzXp8ps0qwmsU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cmafOZ7VOJUNLgrx9ymof2xgncGgmBksBe+AeuzMgKAhPdgj1Ddn2ImIDWvAqfBmI3wmbS1oTZS8Tl2eHBV2NsgFtPO45BiEFPdV9YvisGI69BZKEsnfILISRIJSamPR7gxHQK1JR2DT98t7GmBCjYB1w+JePY0ifYIzCWeVxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYHmiSE+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYHmiSE+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7ff05e5d009so8526767b3.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304533; x=1782909333; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peDWbj0UU6F7ZBlJMlPLrmjl6qpLiukh4mqScmdAli8=;
        b=EYHmiSE+YtKB03fTEeVexD6ufKt5RcBxfS937sOPWw71qoyyYslQ01yqousLKQB9Lt
         Zj2hOfYrVfj2Lwdewh/jbliivXQtjIeRjvqJ8CVd6HsfUQTxm1LY5XWezsYwS6H37D3T
         ZsgJzeC1em9K9zz26WNzvNSfeg41ueR5kt2v57tLAC4o7vBA0qjQ6c8MjA3na0j1tR8z
         k62Ik8Z1sZ6Ce+oCAGo/KpdSggNh4GRDQH28qZQLcFjh6Q54zCC/zMao1KtLRCHhx5Oy
         r3h11XNsSoKwhj7zu7HVIlNk9byXrNCMI+L8487I32AhPRF+QRSwSqj5WhvTxEjgTyNT
         IuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304533; x=1782909333;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peDWbj0UU6F7ZBlJMlPLrmjl6qpLiukh4mqScmdAli8=;
        b=tPqTL6NmHThiPG5xrFCJtS4nLs3akry9tKfhF1CA22J6Ix0XTGk0iE8kHNpgyjanfP
         vvubqXS9E5Ap1W6czFgYZBibs637UpLKBfRu2aJpb9xvlpd8vVZy5aEpoOAelCUZBnKM
         FR4yNWEpaOBB81T3qOfEDP6D910jDkwyInZYGLG0C5DcaA75i1YRFK0yPQHkPmVq53hd
         B2EdGtJYarG7ruRmSDqzpw/XFHPUZ3EnVAh+AMZchxup1fl+EhiLYiF8LD1Lqp9VmPt4
         OJ9V5yHNQTi6UhQ/pdLmEUAH7t56AbIbBmnHhLQ/a92nuy95DqTJVndYsdWAqguMivP1
         Bxxw==
X-Forwarded-Encrypted: i=1; AHgh+RpAUjV0Kr/Slwmr2pCmQ+KeVIZOM/jqBx2vrsqhYujqJVoH6P4C48rGhdJBZdP4w1qnkJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfOe6ahga7mzCQfmsFfQ4lHUteGuFKFeroD8xntbSG2qcVBXXZ
	+0AwX4r4GNpoXbzGkob07npOTv7d0o5eAMxtAbqZh4ZNM88Rh0mPENiQ
X-Gm-Gg: AfdE7cnIv/qEjz8Draj2im5ZyjS6T7Sug6yigDRx8fqe2CbVwwjyUpQlGTlSd4dGmpU
	6OY0VsZ8PWnGXACCQ6aosAcKvo9s7sNLY90OiGb3/43+i5FzyTHJvrxQEj3SMxag/1bB9zGpqHY
	wT65V59Pihdoqr8lw0S/q7a8NX4VV6nkz6A+BtYj/ntycWgjPUv0fWkAQfqbanfkD1zqyZkuiUC
	kRE4409WjEb0frHQngC/AKr0zDIegilG0fWoYFOjbKgB8zeO5fmPtOeprzNOlxVx7MkRti18mU/
	qqCsI63oAjST7+XqkiicVRmkBzyXXZFjYnGauitgQT6ugCLxmbks/aIdczhrcC1gZv0u0f13pJI
	gMPJcGzyubZpenBTFvqzm67EnKTMVfAFGql1yotNW6v9ta+kANLgDW1X9S0YEP7TPItcukVgOG6
	3J3fe5EgkV3z5fScue3+pY489W1HGwXRMHEAX1vyfbe3CegFSNkMEdzeRtofuL+mMD5kgtQpnl7
	M56T/RNXDEQz2mfpDEYETTPNKeDZBS8lCc=
X-Received: by 2002:a05:690c:c0b:b0:7f4:fad5:2084 with SMTP id 00721157ae682-806c1e70628mr65676887b3.13.1782304532971;
        Wed, 24 Jun 2026 05:35:32 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:b42e:a656:86f5:91b0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8da5fbsm57571257b3.30.2026.06.24.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:35:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] branch: suggest <remote>/<branch> on upstream slip
Date: Wed, 24 Jun 2026 08:35:21 -0400
Message-Id: <0F1878CC-F982-4CC3-A2A7-D670C36515D1@gmail.com>
References: <xmqq1pdytkmj.fsf@gitster.g>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <xmqq1pdytkmj.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 22 juin 2026 =C3=A0 15:58, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> write=
s:
>=20
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>=20
>> "git branch --set-upstream-to origin main" reads the trailing word as
>> the local branch to operate on and dies with "branch 'main' does not
>> exist", pointing at the wrong problem.
>=20
> When 'main' does not exist locally,
>=20
>    $ git branch --set-upstream-to "$anything" main
>=20
> would fail before even looking at the "$anything" (which is supposed
> to specify the new_upstream for the named local branch 'main').  The
> operation is to set the upstream for 'main', and if 'main' does not
> exist, doesn't the user deserve the error that says 'main' does not
> exist, no matter what "$anything" is, whether it is a well-formed or
> ill-formed remote tracking branch name?
>=20
> So it is unclear, at least to me, why "branch 'main' does not exist"
> is an inappropriate message, mostly because these three lines does
> not clearly tell me what the user _expected_ the command line to do.
>=20
> When 'main' does exist, but named upstream "$anything" does not, we
> get
>=20
>    $ git branch sample master ;# make sure the thing exists
>    $ git branch --set-upstream-to origin sample
>    fatal: the requested upstream branch 'origin' does not exist

Relatedly, if memory serves: when origin/HEAD is available locally, this wor=
ks to set sample=E2=80=99s upstream branch to whatever origin/HEAD refers to=
, right? So it may not even be a mistake. (I=E2=80=99m pretty sure I=E2=80=99=
ve used something like =C2=AB git branch -u origin =C2=BB when I didn=E2=80=99=
t give an upstream of =C2=AB origin =C2=BB to =C2=AB git switch -c branch =C2=
=BB for various reasons.)=
