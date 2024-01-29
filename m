Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E39604A2
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529647; cv=none; b=VYOV1k60IG3wwi6DRp2nqOWEMB5kE+vU9/479ChaI8byfRlm+47ppC/G+OpEC+kebRc/4QEEn71oH9fjy4sjy//W0v6n1UI+65eTIsPWZI3gSW+glpr77HOilNB7ycDH+Um9Spm5h1ycx1Os84EVri0k+tqeBQ8pX03C7SMqryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529647; c=relaxed/simple;
	bh=unEq89xVZDcf5hWZQZ8mTUnA3y0wuYHgZ2+reybOV+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyLGjnvQALIp1cNtMl+hK1dqeWSdkVgGcoVuKUFCuZSHQya5IjsyqSg+pC8mIOGhIk+X3RS1ag8R8xobdNonMkGhYn/ewnJ7wA37ST3jGEqIjw9jiMzJr5aKtFPRSDB5iOWToae3fpdfW1gqwhIVthglGOuvoENWdN/ZGTRZL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMH22Wso; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMH22Wso"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so2458173a12.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706529644; x=1707134444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unEq89xVZDcf5hWZQZ8mTUnA3y0wuYHgZ2+reybOV+Y=;
        b=EMH22WsoUxc/io0IODPN5UsIh72yFgIOYT3zD8z3tbIT0hsk5OMkAmgc07w/lPSJqR
         JM2EeBxn79D5zqnDxROAqosnwd1jai5SQv82MQCURX7lXABcRl0ihgoA7NNkvK5k4l+S
         PUmGD0afT/pf7TEtSNAm6D29MfLHwCPbcIPvQs2rr0eLgnZ+IujioYe42zqwSXfZxsaO
         KNy7s98lCD6cOzyMMpIGybeLOxP8X4+aLpkZ21wJepW336JKoZfPDnhi0U0piqtXEsIv
         on8+M0X1ro5JqSrg3zNtOQmticsrlDA3nGdL5jBR2AlHHOrrGvRQ/r3lY4VuiZe4bGMe
         AkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529644; x=1707134444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unEq89xVZDcf5hWZQZ8mTUnA3y0wuYHgZ2+reybOV+Y=;
        b=GiMUJVT2NeoCtW++2z9CH+8ew2sjO2SfI7ZX8zzbwLzJcGkIHFzff+z35mdwzK2FQ9
         n3PcUHo2+BA3p7cRu2wUrUQXtQzxSp/GamA77awfg2jrNswMKfEFt/EGl9n6lM1Mpdqq
         v9W9Hcg82IgJ34+IwcoO7hNpbBd3l4anG8mt0DB934f/uxESeAsbdWNG058peqI+CcuP
         LdixAzLT3J++V9RlIbYrmoShJfS8WlruWB8rcmZwmY16LOHEj1VHaiP3Rs7JfEMq0JFQ
         u2g5GBhErw27DdkeshCDLKkN79cjBs6qrlF/qN69krn1rKJ+K69wXIyrTlbfnt0oJmD8
         gTIw==
X-Gm-Message-State: AOJu0YzdAgmoEks+S/mMjNRNSAfWS59ejxLxHGLJq09g+CkfkM1NR0Hk
	Cf25ES/kb+3gOGzsUkh6oyvOLDGOiUNbRG2gobAySy7vEjNDEVNG5A72FIUilptA6dGsGxx3l+c
	Zk151J+A25swzdm0AOE2n2ovHZedfbkouWT4=
X-Google-Smtp-Source: AGHT+IFbsDLi4nD7cB91t4Y3WcTbnkhxro9yYQzZaTfQgcaqLM6UxNVfTC0aN8Wp+kszIHhF35sAdCREIOyu5Hxuh2U=
X-Received: by 2002:a17:907:1709:b0:a35:d076:9920 with SMTP id
 le9-20020a170907170900b00a35d0769920mr1035374ejc.71.1706529643440; Mon, 29
 Jan 2024 04:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1706525813.git.ps@pks.im> <80a74bbb567de165a8dadf0664167140e4bf0504.1706525813.git.ps@pks.im>
In-Reply-To: <80a74bbb567de165a8dadf0664167140e4bf0504.1706525813.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 29 Jan 2024 13:00:31 +0100
Message-ID: <CAP8UFD1=yAhv5QKDCYPfTu0=qLCyRUGt3W9y1D9XGjvJbv8wLQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] t1300: make tests more robust with non-default ref backends
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Toon Claes <toon@iotcl.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> The t1300 test suite exercises the git-config(1) tool. To do so, the
> test overwrites ".git/config" to contain custom contents in several
> places with code like the following:
>
> ```
> cat > .git/config <<\EOF
> ...
> EOF
> ```

I thought about using a function that would overwrite a config file
safely as it would still copy the repository format version and other
extension information to the new config file, but a number of tests
even do `rm .git/config`, so it wouldn't be enough.

> While this is easy enough to do, it may create problems when using a
> non-default repository format because this causes us to overwrite the
> repository format version as well as any potential extensions. With the
> upcoming "reftable" ref backend the result is that Git would try to
> access refs via the "files" backend even though the repository has been
> initialized with the "reftable" backend, which will cause failures when
> trying to access any refs.
>
> Ideally, we would rewrite the whole test suite to not depend on state
> written by previous tests, but that would result in a lot of changes in
> this test suite.

I agree that the whole test script would need significant work.

> Instead, we only refactor tests which access the refdb
> to be more robust by using their own separate repositories, which allows
> us to be more careful and not discard required extensions.
>
> Note that we also have to touch up how the CUSTOM_CONFIG_FILE gets
> accessed. This environment variable contains the relative path to a
> custom config file which we're setting up. But because we are now using
> subrepositories, this relative path will not be found anymore because
> our working directory changes. This issue is addressed by storing the
> absolute path to the file in CUSTOM_CONFIG_FILE instead.
