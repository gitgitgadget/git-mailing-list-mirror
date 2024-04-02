Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594E80631
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064099; cv=none; b=jqUzhKyU8CfEnh/uEEYCxJU3D2rcsSFOaWriJpVHP54G/zbBzU30TkKQ0I9Ie+Zd68nHIjTVsadQEMrRLp1MyutxuzNxxL2oEQ2zhLGFZn2D/Fh9xUHWFvzAimDw4rmtKBX5+rfVec6oAcZogDcTADXLE2YPugQGqxuta4exuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064099; c=relaxed/simple;
	bh=UNGP3J306Vu4saQgE4rDQw9Pqn3iMD5slyoFZufmWIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVDXp4AEVKI8BqC3yTj31QAEwiyZetsAQgYCHHPafYj/8mpNoQUd8ChZ6Ysv02UombOeoBejzV7y+o1d+dpM1BhrGjeWzKPN9vD7r+VuIicRpUDCwI+5zzt4/4HZRBZbFfTGeikHeszFXwAhUdzg2cupg+8Ns0GWlPvGLRpwN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=zzqroSYi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="zzqroSYi"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a393b699fso778227266b.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1712064096; x=1712668896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ+R8lpSK8WhdkU5y+Z+6a7mJSVGErZg8hpyIglOaCw=;
        b=zzqroSYi2527KxGU46Z2QBv1RoNgiyCy9iCze+2+iEghHzAnZ3kQsUmC3gzzG9hD+h
         ijzlNV/Ky1jBIgV72wZy3kP0dRU3dlJQlfrWrZ3TKOlbmttPvq1OMq8wF8WGHcR6iLQl
         pcJsvPyfAHHPfOyYFPRs8TBYYNxIjkZ8AIDpJnn+xCnQjpJj1oekl57+TOnUxgE4QJSM
         Z+QXnY1nrzD1QEf/XHWA5r8/Hbo5lV4N6ez9D/WsqF0/B77OSLjRRE/iNOCT39XAbM3e
         WH3XC4m3x2FiVV45NfDHM6FuhbYFQ+F/SJUo60Sdc5yblB5dBR96DXph1R0OHRYZiDpz
         aa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064096; x=1712668896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ+R8lpSK8WhdkU5y+Z+6a7mJSVGErZg8hpyIglOaCw=;
        b=KcY8kQQleR8xXI8/8Bl8m4AM0fRHVGxceTMgeHMOfG4BmeXpd3OSL6k0RUXlr3tFOg
         K99Qoevo2pcVHa/RQFhcpmv3zOc2FhgNUcjqTLUkZ7vB0r6O/Nl5a4xgJ/EgGKrWAXRS
         xpL0VheF6WERsOd7FCxgLH/CbIiU7uSqev8uCNkiiGrxhLWl5vwzbe9QI0Qjy+Vghx0P
         DFNSetrtBsOKFz8z4aY64/YQ+jVQh+dJcFXmCV5BwSaq2medHpheW6Pgbhc7nWOE/FJo
         SmyrYZQE/tUtmRuV6P9TKkPoc3eDOwoDjGMePkl0dHS4OsoMKLmJlJbGO8ApZ3PogIfO
         cRxA==
X-Forwarded-Encrypted: i=1; AJvYcCXLz1Zmy2L+LceSgYA7eWboBurIEISZFXXiC/u0McOcaDk/KDlK+e8pNE/XXNWUbEdCZWA+ruf1u262hRbZbn4LCv9V
X-Gm-Message-State: AOJu0Yy7mt9WViq0qavUjKy2LCa6SPlNGx3k3gcnSKDSecmhDXTy8Hkw
	7rEupGLMk3n28ML+YbfUGE8vhvrH6r6ByEb6ZXTpb75K/gKURWI2fdpGc7jDvTORgpsztXycv5c
	tTCeeFXr756C/dUMOyKCz8W7nL4pr/bk+lSsiZA==
X-Google-Smtp-Source: AGHT+IG0ZZ0jtLNlPp/Mb/X8x1D4kd6cT8qAFLJsrFOfiMLk8q3nSXgDwFtzn5/U8Aw0nszXUNgOWBFGpReKuINAG9A=
X-Received: by 2002:a17:906:5614:b0:a4e:24e6:9880 with SMTP id
 f20-20020a170906561400b00a4e24e69880mr12478539ejq.33.1712064095579; Tue, 02
 Apr 2024 06:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com> <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
 <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com> <20240307094708.GA2650063@coredump.intra.peff.net>
In-Reply-To: <20240307094708.GA2650063@coredump.intra.peff.net>
From: Robert Coup <robert.coup@koordinates.com>
Date: Tue, 2 Apr 2024 14:21:19 +0100
Message-ID: <CAFLLRpJZg3UhBRfihtjUsXcGSod4FhDCs8fD1k-=5SLnAdHeQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
To: Jeff King <peff@peff.net>
Cc: M Hickford <mirth.hickford@gmail.com>, Bo Anderson <mail@boanderson.me>, 
	Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

> All that said, I'd be surprised if testing osxkeychain in the CI
> environment worked. Back when I worked on it in 2011, I found that I had
> to actually run the tests in a local terminal; even a remote ssh login
> could not access the keychain. It's possible that things have changed
> since then, though, or perhaps I was imply ignorant of how to configure
> things correctly.

I have gotten keychain working in Github Actions before: there's some
helpers for it, but you can also basically do it manually via the
steps from [1]. Basically anyone who needs to do Apple code-signing in
CI has to make it work.

@Bo, how are you actually testing this manually? Following these steps:

$ make
$ (cd contrib/credential/osxkeychain && make)
$ ln -s contrib/credential/osxkeychain/git-credential-osxkeychain .
$ cd t
$ make GIT_TEST_CREDENTIAL_HELPER=osxkeychain t0303-credential-external.sh

I get 'A keychain cannot be found to store "store-user".' in a popup
dialog when #2 runs; then similar for other tests in 0303. For #14 I
get a slight alternative with "A keychain cannot be found". There's a
"Reset To Defaults" button, but that wipes everything. AFAIK I have a
relatively normal setup, with a login keychain as default. macOS
14.3.1; arm64.

$ security list-keychains
    "/Users/rc/Library/Keychains/login.keychain-db"
    "/Library/Keychains/System.keychain"
$ security default-keychain
    "/Users/rc/Library/Keychains/login.keychain-db"
$ security unlock-keychain
password to unlock default: ...

I don't see any settings or code for setting which keychain the
credential helper uses, so I guess it's the default one?

Cheers,

Rob :)

[1] https://docs.github.com/en/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development
