Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35963A29A
	for <git@vger.kernel.org>; Mon, 20 May 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193276; cv=none; b=HGd4tIBKxrhXxBp3bhti5hUGhvzTS7r4RKqYLPtnOuDG0wHi+lRyd+N6zOxFTrHuo3hJ1YyLbNZIZZAMgJaayxCbPt/dqnlwgLOuFfsVuGeE5ky1YEszsCw2EofMOJ3+5VrkleSblAtDmTOuUwOv4vNpiqqyT7bYqd2Lglhsqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193276; c=relaxed/simple;
	bh=vDEkELtvSbXga6PYf5TRxcODVqLtOPRSUUMwbqUbYbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7AIAp7ct+6RzSJaEAcd2eHMFtN2jpJvJ+6Gy5DgJVLLcG3hBVes8QCev/fjnYVFSHZUxyI6IwWPddh83sA9ysEyaVlta1QO0Vpo8XVqER25LSEgtHT0oEeEgMiO33xrm0x5OtHsw9A3AzCs4pBAr/FZVYgVPAEoAKiKXCCdJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a3652a74f9so12972806d6.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193273; x=1716798073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLfxDdSSNhOy4Om9zxz+729Xk/VQeWSMGTRn9TqRSJ8=;
        b=BBainRbaIsb26Nk7+1R9wukqQZ8+Cfr9lT/jX59sENov/1HdNUAGeQACrO/IvUD35r
         ElJrt+Fuqa//lpEyQt5UNTtCHl+lddFphP68hZB00GKmiycUfjQB1hT/MIWXMyqhMrQr
         qZZxFMQXRkWaLvHHQbBphYAUHPuG7RT0vpHaNOHQIaMElCE+py4i7mIMiKlWQ2L2/Hq8
         Csa6N82SqmORoqm5GVO7qRmjNV3g2lvRyvvupCJtXuz5yX+aSETdcXwK4xj00wGyRVjq
         zT2E7vw/RIohkCIiREpzowAJdr4ouW0e/GX3jXXZLfQdeKxckV/Zb9EfEY4kYZli6bxt
         l9Pw==
X-Gm-Message-State: AOJu0Yzj5zdRyp5h0tUpMV1VngfLggoCEhHCCAZsFPVUpI5L5MEltrPd
	fyMxKPJqdDcVXbRO1ac9YkkmNNg8Xa1IZzZq6gu6GP3rm1BBWb5r6LTTYtrte3FbM+yfrG1KAU4
	11/hCgNtYgHWb2aSvrtwk5lmtzJiKWgOP
X-Google-Smtp-Source: AGHT+IH1Xtl4cMIbJkh8rnW+W6YJoVrZZWmpwAXOTF11CFMRidQpLD0N57kckyPnEa3MSGBlWNxJuQT3pIfwO0BhH10=
X-Received: by 2002:a05:6214:3b89:b0:6ab:428d:188d with SMTP id
 6a1803df08f44-6ab428d1946mr7122396d6.6.1716193272795; Mon, 20 May 2024
 01:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
In-Reply-To: <8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 04:21:02 -0400
Message-ID: <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
Subject: Re: chainlint test failing on Linux sparc64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 3:56=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> the chainlint test is failing on sparc64 (see below) and I'm wondering if=
 anyone
> can tell me how to run tests manually. I suspect there might be an unalig=
ned access
> which causes a crash on sparc64 only.
>
> rm -f -r 'test-results'
> --- chainlinttmp/expect 2024-05-19 12:26:50.051507198 +0000
> +++ chainlinttmp/actual 2024-05-19 12:26:50.051507198 +0000
> @@ -1,955 +0,0 @@
> -# chainlint: chainlinttmp/tests
> -# chainlint: arithmetic-expansion
> -(
> -       foo &&
> -       bar=3D$((42 + 1)) &&
> -       baz
> -) &&
> [...snip...]

The thing failing here is chainlint's own self-test, which you don't
actually need if you're merely building Git. You'd only care about
chainlint (let alone its self-test) if you're modifying tests or
creating new ones. You can bypass chainlint altogether by setting
environment variable GIT_TEST_CHAIN_LINT=3D0.

That said, chainlint is just a Perl script, and you can manually run
the self-test like this:

    cd t
    make check-chainlint

The output you posted is coming from this line in t/Makefile:

    diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual

Based upon what you pasted, it looks like the "actual" file has no
content. That might suggest a problem with this line which immediately
precedes it:

    $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
        sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \

"actual" might end up empty if the Perl script isn't emitting anything
for some reason, or if `sed` isn't emitting anything. Presumably you
have a working `sed` installed(?), but do you have Perl installed?
