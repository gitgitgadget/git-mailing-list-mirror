Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E63F1678
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153334; cv=pass; b=SeQBHWBl49GmdeOZXxnh/OC0n/T3Zcw5pd+1B1wgpaWIpZ7G3fjLK0YKTiOe6Ph7Vg1aqygTBz2fBpUO6TeYamg/1aJqhrY8sSn/4m9AQ+NKsJf8QxLhG386gPC2T1DWlbZVG523g1tcQr8MIZrZd52jg6uyEl6FOmCqjSYgxnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153334; c=relaxed/simple;
	bh=CGI+RLcT2N4AlwLLvuPxVrk7mSHti0u713wBSIlnvdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FB9Y6gu2GCCYnHSek7erVqQftIRcMf4JF1JIN5ECNFW0uVn22miFaFtqsfSxGI3Z3i76SvWcRR4yypG42LgS0OM1MtS7ThjMg7ho5GG0aqgVHq6b3//7tzTw9jy7DcuCHLsnQjy/kNN5hxr6xnNTwTA/V26a3svNIKUCWe0vrWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbEj5wb2; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbEj5wb2"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a9879ada9fso2222545a12.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789153322; cv=none;
        d=google.com; s=arc-20260327;
        b=RyCSiQzEoeLvvd/jBYYMTISgnFMMD7WuKzi9jiKSR5s1GdCG97Z3Sw9QkTOTAr9WMd
         7jWagxJ676Ja7MkzaB2toUjF5n28Cxb409XdNuX/N396DFKA2u5lUegALohBXy2DSOxm
         b2LXIuIf9VVSy9rNk45knH1WN3n0OSCoxRm+e1JmHTF4UG+twRD9DxEZ3gSJAQ160s+r
         l4qUjdVQbgKOI3Z+1msRuGuJ2R8TgaYr+8McY8AAXFceVjEMQugo6QUydxMP8CcJ0BzW
         nuPR58U3ccwuUJcsKfHp4EReVTu9U69HP76JjndvG9j+tIZdOl7BqMN7w/5QSt/wuUXW
         gimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DPGuLwOvIENBb0uirOsqWTXKfCU4AJiYe7Xia+ky/pE=;
        fh=G3qPaPj3R7fS8Jhw+It1iru2gjkTKFU7qXokvOCGpKc=;
        b=RidAKzSSEpQcuyd3Y5NDQ2s+LFKZYHjJ/fo9Il2j9PgZZ8PIW5bsz9JtuJcc4DxJ1I
         wvvdBfUGGrnar4pJQvBOSaZYp2Q3Go05qrIa1o5SR8qgK7orNTom0/DRlKrWxkABrMU4
         lI+D6aNUYwFCIMF1Tfng8Ebjl6tSEHyCECtmmneUyqab8bvo/bmlUTk0Kj4IRx0wD4Np
         OcqSQa3koimK6IVqe3gT9iVEvZergE1OjEeNT9RYHuE2J2wvwo8i3ioZY7Wx9ptTaV9t
         k4f9jZ743TpQ+7BXmRGpOZvUON/BBce5kBVnd5u+Lg+t0q8mIGOc+GqKA0TGAVRM8blQ
         FNbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153322; x=1789758122; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPGuLwOvIENBb0uirOsqWTXKfCU4AJiYe7Xia+ky/pE=;
        b=WbEj5wb2SRi/fjLPZEKQohZVWgi6JOKwSKwoBohuXqVEMeObOKreTVXhIMU2iHkfng
         sdHIQiFVptWQ0eFK1MNgLfUAEC2ZEhdcPSo9M7U+1Fi3QWoH1VBZaHqrroQNPwbLJilP
         XUQF4B+9FH1/fxclIY1n/Q+gwdxjrj35kT8rHmN0K0TYoMzvqv/nnhH6Ly2nwvfr2bM4
         dL2R6M3uF1uvXZqk0jdqDWaJtS+JXR+r3Dq0JW8bC/jI8NVoaZQ/6KhjPClGi+8cjH0O
         yI/YlamBpFPLcx0Szcpc9VmZZYn+Yh/UAU73l5MFst4VVFKClDVXX92lV2/XEdi92mqh
         Ggpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153322; x=1789758122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DPGuLwOvIENBb0uirOsqWTXKfCU4AJiYe7Xia+ky/pE=;
        b=c9UQXHszmhZCFPj9g9Wfw0Ww8fiCz6cBWP+fTp/1ImynlizEbstt7sify7cCRCmEAP
         uUUSmaqBZck2xk7z1rYgs/L/rV3rhG7zFs02DtcMd9HcwI/R7OdnYlwIhfp/5Khff7Hd
         V5rAWzXVw/Umt/oo0t1jfPFAZhjEjKPbqOMpUaffhluEr5fegc5RgrJFeQkW2lGbLX7d
         9aF3kjO2NQwIG+/AyIDnS8T+QO0SboUsAXr24kE7pzB/Og5c8D9hrhR2arABIcmLCI6X
         CKL9IxZn3d87917MuZAQT41KtZrxTmR8YsceNlt+eQQxAKolTv1Z1Rj5FjdJFXp1ulvE
         3PYg==
X-Forwarded-Encrypted: i=1; AKwUvBwkuMWcBBhnvTcfzuagls7JpeaFoiPlFWM+a8RxfPdDe7Cz2RcMON13HE7vlcT0UzZ425k=@vger.kernel.org
X-Gm-Message-State: AFuF++kTehs7uJ/yQupwiflMXG3FfcMsY8tvI8vJUMGKGnlMVRVkYtxx
	tmdu8R/Bt34UeA3qFWGDqiTE8zjjKlvO0ED58+FpH0J0IdprJ53HDyQSJdv9a7FYSZfWOjSs4EM
	AR3xFfS3bxYLaD0Tc7SmHIkSsQi/XIzQ=
X-Gm-Gg: AYBFou150e1nQgNsep8r3nyXuwiDmsCyhkOZ12+uYR0wA9IWZBWPxO50FquTR9bzdUJ
	3SctsAoZ3fIsdE/DZnv0aFnMmA4AKFDBjduEMqKrz7GZtuz5rE1ajvP2HDApkcCXIZ1qmmNLsmN
	d2XtA4Vj6QWEl6c648D3Jd02l5XuE68NLkzoycYG7+rolkbIa9nNH8PHo9jNJDl8ygOfYo7g1MD
	VJEFZHcqGzNV8lfoftioC/y3y9iEkjTfsVm/vpghLuruMaRgVQUalfQQFvSK00Hfem2hghTL9I0
	4ZaaE5uYaiRLuo6IbhJ+PjKKK7x3NHHBeGnu5qgTYKV8KN8ZiUH7Deo=
X-Received: by 2002:a05:6402:360d:b0:6a7:f2d5:dfcc with SMTP id
 4fb4d7f45d1cf-6a9b56b28edmr2334843a12.36.1789153321936; Fri, 11 Sep 2026
 12:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
 <xmqqik4bbt9c.fsf@gitster.g> <CAHwyqnWkEaQHsp5GtYGL9qg-FYA0Ngt_+omdh8jmw4KfqfX6Uw@mail.gmail.com>
 <xmqqse3faadj.fsf@gitster.g>
In-Reply-To: <xmqqse3faadj.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 11 Sep 2026 21:01:24 +0200
X-Gm-Features: AcwNN1WG3ED097aj7YP7XJRktukAlbc1U1tsTh7xNxLhe-rY6tKiZagv1_kujIM
Message-ID: <CAHwyqnWVXuDMAonj1jK9687xhjiT4h-0E2qzhjwPXOTKfMhoGQ@mail.gmail.com>
Subject: Re: [PATCH] range-diff: add --matched-only to skip one-sided commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Seems like a big change, and deprecated options are a pain in the neck
> > because we can never actually remove them.
> >
> > If we decide to go this way, we might name them "--hide-{left,right}"
> > and just not introduce a condition that makes them incompatible. Then
> > "--matched-only" would be pure syntactic sugar and wouldn't even be
> > 100% necessary to have to achieve this.
>
> Or we can just keep the code and fix the documentation.  I think
> that would be much less impact.

I agree.


Harald
