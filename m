Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3A1A0BF2
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356838; cv=none; b=ADUO8JpdtXsMNBHRbfO37q+bFIW2zbL7vMFFxSBz3lBGfSx2T6IqkIN2uxObdRhfEg8svq8zVZqEdd8XXsxPBlHUN+gVYQaahFrtjtGg/79O440gQJ9xo1Fb+0L/PaScBt1s+BPa/dMIB3ztVHbrbExp2heE6JRXKF7kmXSKp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356838; c=relaxed/simple;
	bh=yY04Ol82KyyXMBy6GGmXx9KBjYGsAeTFa553CqbAqUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzmXuX0VOQBCKES7FdG4if9Ycn8FnR1puX9NfGl4sNgpQ5+UcdjEfiC196G9RfD6UH6QeVj8BOCw0rnNFwfYzjYusZU9U3QiCLahh8nPcFuD8y4SnRsOvYnrA0PCDX0GXIYkH+0jxDmVdLVg1YGSlUKR/RzKyucVKyXmn/uMFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c35e1e1182so768796d6.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 02:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356835; x=1725961635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Q9z7jZLs4EYzK/pXCyYpMZUUKrQsHiMj24/bucJ9E=;
        b=Z3WBgPxSSk8geqB7VjqE2e86SPCG+83Q1O9M5W3lkw57sHvE5MnF1kJghwbHwbQFG5
         8INFSPlXaPSLqhDLmkkfR+6UEb4T7iuPLSyZRZwehx+KAd05xoScUCexqEF6IlPVdh7B
         EbvCbmcg7O/xmECcoTTW80qiYvomVfLKXUXv0Kj50LGM5IHlgBEvtpjQhW3ONa9avXGF
         pV0+y6iOewP8BvAIk0n59zbGRz0wIgBaMqS5c86A86y+I4aVjf+GZZ7XB58urSTYN9th
         x07poZjAPyOqwGUWg1tcqXdpvzdY8Wnl4YWRZgg/eniohHA29zGCNb4Srz0Td2zZEs/D
         Lgdw==
X-Gm-Message-State: AOJu0YzOhiOXwsZv+BOiYTpk9SRvnacz2FWHCvJe5ajq/km3w7lucP5F
	gbNNtbIbiN1TC3pSKKUc6ebctPDcRbe835foN4/bMubfsm1zxAmfNwM8eGfl3mvEEV5owbKge7t
	fBezzYpUxBWhxlIKNb3XR8xwImIQ=
X-Google-Smtp-Source: AGHT+IGrpkbYmP83SgqHcsi9C2HLvWCJgNFCkTJBGIWzPlLPlhZChkypMo/DJ35BNpb8Gp4paMxmEzhx6dGe6uJaSLg=
X-Received: by 2002:a05:6214:252b:b0:6c3:6f2a:1fe1 with SMTP id
 6a1803df08f44-6c36f2a229dmr19686456d6.2.1725356835653; Tue, 03 Sep 2024
 02:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722415748.git.ps@pks.im> <cover.1725349234.git.ps@pks.im> <55a9b46e65f2072ca7994b042dfe24d1c153c334.1725349234.git.ps@pks.im>
In-Reply-To: <55a9b46e65f2072ca7994b042dfe24d1c153c334.1725349234.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 3 Sep 2024 05:47:04 -0400
Message-ID: <CAPig+cRrwGsGA+2B5+eYpQY-TdGsDspTgviDgwZ+Zx_sAknZzA@mail.gmail.com>
Subject: Re: [PATCH v7 02/14] t: import the clar unit testing framework
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com, 
	Edward Thomson <ethomson@edwardthomson.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:15=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:>
> Our unit testing framework is a homegrown solution. While it supports
> most of our needs, it is likely that the volume of unit tests will grow
> quite a bit in the future such that we can exercise low-level subsystems
> directly. This surfaces several shortcomings that the current solution
> has:
>
>   - There is no way to run only one specific tests. While some of our
>     unit tests wire this up manually, others don't. In general, it
>     requires quite a bit of boilerplate to get this set up correctly.
>
>   - Failures do not cause a test to stop execution directly. Instead,
>     the test author needs to return manually whenever an assertion
>     fails. This is rather verbose and is not done correctly in most of
>     our unit tests.
>
>   - Wiring up a new testcase requires both implementing the test
>     function and calling it in the respective test suite's main
>     function, which is creating code duplication.
>
> We can of course fix all of these issues ourselves, but that feels
> rather pointless when there are already so many unit testing frameworks
> out there that have those features.
>
> We line out some requirements for any unit testing framework in

Perhaps you meant s/line out/outline/ ?

(Not worth a reroll.)

> "Documentation/technical/unit-tests.txt". The "clar" unit testing
> framework, which isn't listed in that table yet, ticks many of the
> boxes:
>
>   - It is licensed under ISC, which is compatible.
>
>   - It is easily vendorable because it is rather tiny at around 1200
>     lines of code.
>
>   - It is easily hackable due to the same reason.
>
>   - It has TAP support.
>
>   - It has skippable tests.
>
>   - It preprocesses test files in order to extract test functions, which
>     then get wired up automatically.
>
> While it's not perfect, the fact that clar originates from the libgit2
> project means that it should be rather easy for us to collaborate with
> upstream to plug any gaps.
>
> Import the clar unit testing framework at commit 1516124 (Merge pull
> request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
> will be wired up in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
