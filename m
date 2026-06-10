Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A915277C88
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112958; cv=pass; b=hO/VgOUsY52HzQ7l2nEA9thLlk1Bwe0uY9PsiKMMtH6Ce1POBD9W2TP4Nhl5EtPVUyJ2feSlBKcbakd6+04uwDqU8gc9hMI7sV0GjE3QWijBgU32vi+prjJsYfJ0iQb8R2O9dhdMrBFrAhQzeBcOHVRcUe9jgPRhrMn1oEeHg0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112958; c=relaxed/simple;
	bh=TCiWFdaILX5fpEUZ91AkYXqqW6WPY4r5HvGPiNWEdhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6IE4YFf8vrgzalybPB08kpmtm2fr6b/Pj3Nga9cEW0RoBOQEBO5K4/dzEP5M5y1C4UT2t2WEKc+HSaWXjsybILX5bn+k4eUEOe0LHeN3sK11UqIqYGT3aJaNVoosp8VvUllXpoIhR8L8IzabHmPenbvHN5csYHFWS9rP23GCRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LohPwq7H; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LohPwq7H"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6919f40a0c8so7944897a12.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 10:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112956; cv=none;
        d=google.com; s=arc-20240605;
        b=KswKQ9b9ec2GW/5Igu8wHClkrYwlQira49LsAnIru2RVrhTCpTWKsIOlRZKwrEICRZ
         dl91hw7cLtjK3yRhm+/0lvhKfi3IAA6/AVVAJ+orLe89VPGfcA7DWiwzm4vWvniLJKAv
         fpXbzcTZhwmbXyf1AVwIWjJh649YUomfARrj1W84dytL/5boZWOS6JoPfHv5l2fMzpKk
         1p8kIFp66oYfBZ08+UvRLW599sU/gQJXfdD7+EncRNT2EjHdPzQOLbqKVHXzJsOaL1BC
         9IilYYAzTVD9dYKduSs9jSKJaqHolWLpvJ3EJT4ZFducdhieQtXjex5ukGNK0tar+5i1
         Bs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4hZYJU8/BVfnlbTdWGIm6FAeMzdXVvIcbfGROGRj7gg=;
        fh=0mqDsaHy7l2kGXWU5UQI1fSOAkWf0pBN5ZJ/T7pqUvg=;
        b=iRv/F7SoYbRDA69Qm5+Cf8OxLAZwcErgbXtiGpFvdrk8gL+49z0Cis7u0ctkPpGKx+
         LYR5q02K8XUTzKSnGiyY3eCq5si72QyzqeR85dMzvIxx7Ng6NJ1uwtkPoCtP/Dcjf+iM
         sXzKKWnZfRwdU6qk4cUupULJmJBvW69SrHMMuZ3AmgKkmJGThvsSQK988fCwBLRr7FlH
         kL6G3pv7y5f8AIu3Q24V/cHCgL/KkGhcOiy+FmxpfBAlrnwx3ZAQNNnJoGlpiu5mONie
         z6q7EiNHJ9ngvq+OfmOOkbei4QeyyN22qUEjLBKxMDN5BG230YXwT5geD6cJ/tevKZas
         RzGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112956; x=1781717756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hZYJU8/BVfnlbTdWGIm6FAeMzdXVvIcbfGROGRj7gg=;
        b=LohPwq7HyQHQN8U37I7AylbKw9TV56cMaiOpD6xABatZQwpUI0ZAtLvvNZl4kDQOAh
         AIFjuEzT1n1RXb43swN1KTvveiMmr9QPxTNl0sQ1QuwdL2fTlkRusClKR3GGyQ7eIS7O
         buEcTXwmYtHRdtOHUMBOn9NWYVWwTbW6tMfC83Mm19bqcPcgw3JwKkxiIP5Fqkn173xy
         IY6VYBC3ZfymGLZlMUpaVe+7bINL+1P1ddwifCImIGiVBGSPnxTfHiYB9wmIrD3glMnI
         8mzwHDtmn7k9+IxrrMBHOZ3t0g4RnCvEK4zvd+G2q7agrJAQICMIYvsRd8e79hB2Xk/r
         KMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112956; x=1781717756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hZYJU8/BVfnlbTdWGIm6FAeMzdXVvIcbfGROGRj7gg=;
        b=W5Fn/Ou71oRMlw3NYsL0g7vVsoo1xSpHMqQxfD8s0JXVQj8x/gUi7eBsDH0Q2yj2pf
         Vun/hLO2c1/RXANdwd6rU7KzCZDINX0zB+1x2JvVb+pV/m6NE5CnaJBMcyFfsl2KcQgp
         l4ixEHp8oKR8lCIMjmmLzg8v0SIdSFb3QffFbYM0GipwlIrCcDMKMO0prjJoz9fVikjo
         5ffPRqYeNbgQx4llE/YNq7XAMr9OjydG+8nc3xxFm9/W/dASxr1EsTOriNGAiougn1NM
         FWPyk8XDykS9BBLkMyloZE2BsNHgfI+K96nUoc/bAFjlhtaXV3ih2CQBmaNqVwWcV22l
         5W5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8o3BjAZeaRU+Wmmp3ok8gimkdJM8g28Rj3Fond32WupCDYIpcQGRNtEWPFpKyi0a8kwnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YNHfvdpK7m/9HBywsCYdbDtBOeGTUrog+f/3nWUaTm7cSkas
	/6qe70W/mXMol9eroqXB0Q+6evcDp8wTGTEIcgZuPklsf9J3kKqMuuXauYk/3MAdoErcd422+j9
	WKWcF9ypF9cMSaFt9k32TQfIh3Rf/KvU=
X-Gm-Gg: Acq92OH7X7Q0K5OPDooUBMXY/TUIAfgUKET/w60FRz/9v+wBLk2Qk3MSdvytIwwrPy4
	uxmfzv4JRhj+IPfZXTRQCRoTCB1qis/+5CFat+u0Uzs7lg+p6qjETNkTMli0kchmwbpgV60qOmo
	C1rsvd0PSqAHj9BfErRx++dnVbhWQNHzr2FfdQM5fsCpqsLaTETRz24RMsWsQ6lEvGIBT4drFQ/
	UK7YVovjt3LTga+w03lqa3vuo0atHrUp59QfVsKC7g/WQv59PKrBd2jSp+C23HpRIkGK/UMAj4+
	WwYlOeqf5WSpkmPe8A==
X-Received: by 2002:a05:6402:448f:b0:691:ad66:25f with SMTP id
 4fb4d7f45d1cf-691ad6606damr9034407a12.7.1781112955470; Wed, 10 Jun 2026
 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
 <pull.2301.v4.git.git.1779372367317.gitgitgadget@gmail.com> <xmqq7bo6xuok.fsf@gitster.g>
In-Reply-To: <xmqq7bo6xuok.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 10 Jun 2026 19:35:19 +0200
X-Gm-Features: AVVi8Ce3DBQyQbgb4G9DodVjghNhO0SA9f08YVZtIaxHjQFnfoOov2_l1d8xKSk
Message-ID: <CAHwyqnXei114KYmbEOvMEYSkbrw0VHgrZJv52Y3qAhJ+Yq18_w@mail.gmail.com>
Subject: Re: [PATCH v4] remote: qualify "git pull" advice for non-upstream compareBranches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >     remote: qualify "git pull" advice for non-upstream branches
> >
> >      * Don't suggest git pull when we have no good command to suggest.
> >      * New test for this. Asserts the behind line shows with no follow-up
> >        advice.
>
> Very well written.
>
> What does not happen in the "punt" case (the first bullet point
> above) may deserve to be given in the commit log message, but
> otherwise it is very clear what the change wanted to do to the
> future readers of "git log".

Thanks. It's a good point, but maybe it's implicit that nothing
happens when nothing can happen?

> Shall we mark it for 'next' now?
>
> Thanks for working on this.

Yes please, thanks for all the help!


Harald
