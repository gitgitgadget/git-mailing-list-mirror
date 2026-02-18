Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAA2DCF74
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414054; cv=pass; b=EkWZdQYoagkuvQtHVvNdTMDHjCwz6JFZKDvEK3F/pxEZUyaGGIJ8hLZokLoZlPkYMs6L3ajjTnTaHOTRmbm5xlzqWusfn0KKmAanEu1OQ6FgQ/au0+B81kzTgqIHKuvJQ/ZAiTDG2x0aZ6G2lonpjmZ0zV601cu6VTM4jVuNNrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414054; c=relaxed/simple;
	bh=u9ydKjFEgpRW/2FGDSzzhRgNYRKrbo22hVf1peYZrbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qw1V1hasXiSYBqRvBPxxxCXXpUgcSVHyBLH/yQ9v4trHvPHoLLBWvalnLA31inze28TJofyVbJedL4G3HP1tNbKy23GgXP5OMIIKAVJe+FKDz9akSph/5JXee+JqqGIfvcmWFiE7CsIHkg9VrDnP5C28F1rQgYyLQ9xAFK4nG9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZWJt5Ya; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZWJt5Ya"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124afd03fd1so7834738c88.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771414052; cv=none;
        d=google.com; s=arc-20240605;
        b=damlGN1bNfAOgtd0wmZ333spCCCjUaXHUA5HJk8QsrH5l9VVgW6T7RuGUBJ67MiTpC
         Yw9AYxOJfScwfqMcmHmSqqh+M0a/Dkj5QVLh8VjkF5Wqx/hvc8ht6R8DvTXjBDT/PtaC
         YcVHfNogulwVuy/VRUm6DvbjjAgwxuBTlTtpYabJoGb4r9yNVoWCe2yeAFdGKiMKzH8K
         loofMrVzQ8vXqPs8dHsBw2xz7ndc3d8sszBbkxUCAOzOtA/pFqSd6Aoo6s76MX4csBvx
         i95xHwChxD/02toggL6bdVtYhJ8x7xf2613c+e8q+bFS+uyIdmi51Vsj/nxF6QW2AxZn
         d0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eBhcpyzqvdRRkrRQz9+VU0wAadKOf3/SuhS9dRGm6lc=;
        fh=7lPklnkNA2hHc+QI+hjyCKkMY38SHeK1fN0fN/lPYno=;
        b=jsjQH0OrIoC0L6P03Fgmt+a/AxQ8NViCa2xycVQAky+3jmeBEjk5RXhrQGABvHYPYL
         wlCPO4ydhWg9LGPxsziHR+vcilNfzvKQRNhEWyCMOBgGGHdl8q1Js86azpuCiA7qNpPS
         w0N9jpr8srAzhfErSPJeuJV1WEOkKZNZNTbQhS9S5MeIqz/5OCN+sxOxHJhaIHH0/NaV
         tCpIyCNvRWPPlVQ8L/xjALWKg9fFM5FTIAE0ptACs8koJRdFhol6iJW6lcSpTureO968
         NFe3vuX869IuSq9HIsMAdamHsxvku501H2zngGmZ9aII0yVQFlGJPwKCcyO018mNwdCj
         3ogA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771414052; x=1772018852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBhcpyzqvdRRkrRQz9+VU0wAadKOf3/SuhS9dRGm6lc=;
        b=nZWJt5YafY74iklY+AnKAtDOGvW/auGb2q5uiHyNwNBKZwb+hSHR6NwVrrr1zDyaf1
         UD8LoX0BKDPzrG4Ib2qbkZ6k3Sxa6Sx9GvBGk+7GJ6QkPNoJdP9oEkukBAuJn79ioptl
         LtECUY5s6yxNZZkPDARturWpmbTthqF3QYrGNsVN3IKZEa8S+kVKcMARDkoU/iSWJ/P6
         IZ/SZoQh92uqdH5q38qCHaNbZZE6iCWK5BUiyuUmBAnyY6wWOw0wIyQPIxJtK2CQ5Zt3
         7qb8tyvrcPjwh8T0Gz1oz8nFjVn+fnF2JKij9xtWP1U4xgd/pwAznHOu9GXZ+lCZb8sw
         bn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771414052; x=1772018852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBhcpyzqvdRRkrRQz9+VU0wAadKOf3/SuhS9dRGm6lc=;
        b=lQJFoSCUnKubMEWsBDNLcNbqRDXT9Unrgf8MVwjcgAXeOOrZW4hkKskzuHugkTdWRE
         JmjzZ2i05anz9cT2R2cGZHleNylufvKAhxfO3QwA7sdsmUVGe/tKRbSTzGzT2bD/OV8k
         SzDki5w3s24NWGuIyyCM1+j6xHoAczwCahq0fqyVngSd6ENj256oiHN3YsnbB8QJAcEz
         NnnYk6/pmuR8G4Rkpjv0ZH7tGK9HJHyuu2U/EeGOwZf35UMn2juyG9KrCM5hXHE6yNjs
         +8uOkoloI7mgjItNdosR0UERkDjSA9ovgwTsPqVyH1c6bMGIJ6rwo2BIkFAZCNKDN/Vc
         7Dzw==
X-Gm-Message-State: AOJu0YxKCyQZ63KdI0RxxZdAMKfr2rbYf+Xq31uIFovexXetHsNRbMIL
	/M8W+uU/fQsTRhM2J325WwPw+NiNnFdFKWcULLuvgAC+x39KTbUHFrn2jz8GuCXH0F/eJ8q+gaS
	IH/RGQuh9xBvRtGqW8YCq//fi5BtqXBM=
X-Gm-Gg: AZuq6aKQBFB8GdySopB1VXdMRh2hRR3+aP/7gAtB4VgVKPfMwd0u5NMIItu8EuwAoFN
	kJBeYFdgJ7b1ekCcN4sfKx1QGEJS91WvF+BrwzNmdCgyViH1InXP4IUi36pmTHk6R2NPq6l6HaH
	1R6Ke8tsTB+ABvAQNZMVEj5ui9pKw4iOqcxtTmT5TgXt+98TZnVD8ebz+Mg/eJjjqPzEJ9UuYXx
	xmEBy/8exzojJ8RNjbMT4iOwdPmHeG24bJZHGjgJPc//UsKWh0WDoj93ZNAI8L56ZE9ZVMlEnht
	6ov7lKH4nTE=
X-Received: by 2002:a05:7022:41d:b0:11b:baa5:f4d1 with SMTP id
 a92af1059eb24-12741b62a13mr6589974c88.6.1771414052181; Wed, 18 Feb 2026
 03:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769256839.git.belkid98@gmail.com> <cover.1771258573.git.belkid98@gmail.com>
 <xmqqa4x7b0ba.fsf@gitster.g>
In-Reply-To: <xmqqa4x7b0ba.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 18 Feb 2026 12:27:33 +0100
X-Gm-Features: AaiRm51fZ26XzjvtUm1ORiKdQLGDV86pI_N284BOvhxVBwcZfPy-NqCGUqQZjlc
Message-ID: <CAD=f0L-V6bMNHT8=jUDbO3j6mtFjnM97tO60xX9Dwek8AecOZg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v7 0/3] store repo specific config values in new
 `struct repo_config_values`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 at 21:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > Changes in v7:
> > ==============
> > - Added the code to reset the initialization of the_repository
> >   in the fuzz-commit-graph test in Patch 1.
> > - Changed the call to rep_config_values_init() in
> >   initialze_repository() by passing it the repo config_values_private_
> >   struct instead of the accessor function in Patch 1.
> > - Modified the commit message in Patch 1
> > - Added extra lines between variable declarations and code
>
> >      +struct repo_config_values *repo_config_values(struct repository *repo)
> >      +{
> >     ++        if (repo != the_repository)
> >     ++                BUG("trying to read config from wrong repository instance");
> >      +        if(!repo->initialized)
>
> $ git clang-format --diff $(git merge-base master HEAD)
>
> would have pointed out the style issue here.
>
> Will amend while queuing but it would be a bit before I can get to
> this patch set for real reviews.
>
> Thanks.
>

Sorry about missing this style issue and thank you for your reviews and guidance
Do I wait for this before continuing to move other repo specific config values
into the struct since I might need to rebase?

Thanks
