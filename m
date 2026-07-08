Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B22D23B9
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532898; cv=pass; b=e5RQ7V4v4PdBNfWsyxAZtt5ZtEDIMIRkFgm8cxtFyQ0Q3scv4iLP0PcprBFUFoP6cdQkByvCvggEj0TCQJq55wm5BvyUxSWNVV5IkbW5xm2v6E2dlk0hSWGJVIB+iHbxIengGdX9lu3+SoY7qNQBZnuwzgS/hUkkaD5dux9kFFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532898; c=relaxed/simple;
	bh=Npg2Y/ReVD9ZHVOm3MooFOZEvGo06ykv5O6fkydRNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0bH6HEdROPDPf+XGGI0VUWLy2wj3CwH2hH5UbAHc4J9lfkITfaM6NCO58nNzHuVx3qvKTj0fqKzMTynNJILOs7yOpGz9gfhNihcRcOpja6EJ3gbOp6rR8zv9TqSp5MivW4I6FLK0XJGXHOZ3/piJM/p13thiCqX94O+apd7Lyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHwD0loT; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHwD0loT"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-667a0f55a59so1077873d50.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783532896; cv=none;
        d=google.com; s=arc-20260327;
        b=oDZ93uazW4hbVxlMrDF9or/U8HCAnWSNoO8sNnEq1syRXe9NXMdxrba433MLjiIaJW
         ZuGdVqgWcCqUNE0+bxhBQAUbgYLaO1ZKBGK8dCrvuz2CtHEhfOVR/bGWGudQ/ZFtdWql
         rdyOsTNX599MbeXsLX5ofbXOoiSD3ugNJG0VTHmfUsuLTLPJuMqFeflkPwCnJ4HN0Kff
         /QK/wiPJCRAmVEzUbbOEoHivjA4NmTDZndwfhLz7eavoSvs4C1Qc1UMf0xXp8vd/gKwM
         OxeGLlOp09oJDcfcsaeVTKYxmkMjPRGz7mTyFKAHxQaeSN0PUcCE2vyd+jqf5JC0bmVn
         r3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Npg2Y/ReVD9ZHVOm3MooFOZEvGo06ykv5O6fkydRNmI=;
        fh=18rt1HRHtAao7RK+1Gab/yx187vXUyvKNanx6W6ZTJk=;
        b=mgIVhkot0XdjJfDFyKKFyENu6+/FzIQ1rtBKZNtDfIOccLtth01XoAgJEwGE6+XMPH
         BxXuAX5J6iBtj9kN8nV/hRg4eRxDCcKOBezULOwZNDIZ0ZeWTIUADesmgX4z762jDrnt
         K9sEZla7IsG7Js5JcgHkjvhfb1EEBHsaG0XzQkwLOJePMaW99Zc7OCpEAc0tqltz6rM/
         NMrBpzURP/JXDLx9ed5/ELV46WKytFh+3yk7MX6gq9Ojj+X4mDf1GhIvzsEdRktzLzPp
         vhtD6Swfzn4OeLMHjOlT4e0i58Ch42xk1UxWzwbwcSZOv+OoWXYiRHBuoagmqLqqfY6w
         H5ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532896; x=1784137696; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Npg2Y/ReVD9ZHVOm3MooFOZEvGo06ykv5O6fkydRNmI=;
        b=AHwD0loT7ZCZlyjHqe5VZ0vSGvBqaVykacHSKGTTLF1EEf76cNR4ycu4he8Ad2L2KJ
         eHCnAXdtk3fbVH4NHij9/waYU/dnkGxv3li25pPnw15D6UeYvYVoOfUcApQbqbQ+krWK
         0SGEtLjmmq1eOF059Q2lxkEV6cZFIVxyoeH3MECgOKTo+wwrUNZfgVxyYCWHqL3ZSssP
         GnUisdkPbRcdBK6sOPLDqPI6jcfVqwsrPnCoEPOjQzM2HxxshYocWdv08pTxP5TsUGok
         gMpm/2CXwaYSqqyAsC8s78XqmRm7eNLV2FrvpO0ylhaqIixRXNEKdXEQIHmKuarrUWdm
         NE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532896; x=1784137696;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Npg2Y/ReVD9ZHVOm3MooFOZEvGo06ykv5O6fkydRNmI=;
        b=RPOjFboqIsAWT2emfq3B0kJJs3MeNDL9xN7Moe+0wG9cuW7GIT6CRd6pYCKe9X3DKQ
         5lnv9p8Vq8MD7MVsnppE3TsyPyXFf2PH79Hd6No3aZoT/xeTWZt8PcOVSeqrK1i7UYgq
         2NBwctdwLK5eSYw0TKKiXIrU0qYJJtLfXxslSytVqvs79U14KxKKtJjuX+fQGWG+Q5A1
         4yV5kqDRr4gFnjK/jq1+Yi3SmOfHIZhGJvfq4HG4i5I2B16OZh7C2Ov9wpFh3Gg3mREy
         BHhHRsoRpxAjNHOrRLpdafL7BzjuqpnWkam1CFih+ACKfp60HPW7zCDhPoJO3ajPawm4
         fi9A==
X-Gm-Message-State: AOJu0YyFZr9afT/liXb+we7QK9OvDfeP3mNQS5NQ++/nWwHrUKi4rfEE
	idz2v7QGXHfM0SljjBbvAqYXAzLqoEOuYft7unoGYT/Jt0VTKGHY6MtgaBRc2zRiAyP8wR95lZV
	2eeDSfurZQNnP5CFc3QtBxjJ8pJzo6FZ5t2fd
X-Gm-Gg: AfdE7cn8OZeZ5TaXvthi3dev265JD83uGYTnyHLqMEOFFiUPg85DEc3SIwenKco+Tuq
	/29dVJxYCCB061Jb0NIro2uADE74xlL6zufdcmP7omAC/FxqKfj7CK2ZRHfvLGuAitzfjvGohcK
	t3LwUQkmy/O/N4Fx+LNGzEclYCfE1nA11ijPmb83lAMcQCIAgR4w23Xxv/+w3JSxrctdpKLIaGu
	s1RWGIawmllpawZCO2SOpht4VYDyecuQum/2GDHwJJyWuky8KmGzzr1zV6nACJLidCFpyVBb6Ms
	Fqeo3cZ3SWdmwhD8UJKqjrH3f5L6ohEb1CVnIDFtcvnmiQzhRgjw
X-Received: by 2002:a05:690e:b85:b0:667:af58:8d6d with SMTP id
 956f58d0204a3-667af58aae7mr1467091d50.12.1783532895882; Wed, 08 Jul 2026
 10:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>
 <20260630053235.GB2495216@coredump.intra.peff.net>
In-Reply-To: <20260630053235.GB2495216@coredump.intra.peff.net>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Wed, 8 Jul 2026 23:18:03 +0530
X-Gm-Features: AVVi8Ce7KUk6erOAEvLJ0ur7BAgtbn1O6BTqRc5shqjz3TMsGKeuMr-AE09B65Q
Message-ID: <CALE2CrRGvVmAKuhhiv5x-89TqqzA7PrgRANmWQv5NoV7gGVYbQ@mail.gmail.com>
Subject: Re: [RFC] clone: allow sparse-checkout paths to be specified during clone
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, ps@pks.im, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jeff,

Thanks for taking the time to look at this, and sorry for the delayed reply.

> IIRC the sparseness is contained in a patterns file, so I'd have
> expected the first level of fix to be "you can provide that file at
> clone time, rather than afterwards".

That's a good point.

My thinking was mainly from the perspective of someone using the existing
"git sparse-checkout" workflow instead of editing the patterns file
directly. Personally, I've always used "git sparse-checkout set" and
never really edited the patterns file myself. So I was thinking of this
as a convenience layer over the existing workflow rather than exposing
the patterns file itself.

> You might try cc-ing folks who worked on sparse checkouts, especially
> Stolee.

Thanks for the suggestion! I've cc'd Derrick here in case he has any
thoughts on this :-)

> One final thought from a non-sparse-checkout user: you're coming at it
> from the point of view of ergonomics (it is annoying to clone and then
> set up sparsity separately) but there is also a performance question.

I was mostly thinking about the workflow rather than the performance
side. My main goal was just to make the workflow a bit simpler and more
intuitive. Internally, I was still thinking of it as using the existing
sparse-checkout machinery after clone.

If there is a way to make use of the selected paths earlier in the clone
process as well, that would definitely be a nice bonus, although I
haven't looked into whether that's practical.

> Like I said, I don't have any experience. :)

Even then, I really appreciate you taking the time to read through the
RFC and share your thoughts :-)

Thanks again!

- Pushkar
