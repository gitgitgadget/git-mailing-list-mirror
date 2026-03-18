Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A83EF677
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860615; cv=pass; b=m37lvH2FS+5SMtgb0WF1fx/BSGr/trC29BB1q8SJ441FfyHeWuSApqqBg2RnYSOfvpmhu2VHyEJ/3R8vgM1pJq5TzrUJqXG+klQmXEgdbDtr3LhmtBTP+12nSh3550FDUcVPyp0YN/I2lTy2p4f6h/PIBbbrMrb7efOfrITwdMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860615; c=relaxed/simple;
	bh=06JZQOoXLzsFfYeob3uwXMIErwzmjGym83HKejdzYNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sENOdAwbgScYzIkmc1cZAa5mIkGp2vQJa0znJwwDYt8ZDlSvF7SiSQfNwlHEhW+pOwxJRXT1WS1r1HHI35N0tm+NybGB61ADn0Mn91E7PDWf8A+lL7Om9yfdHeNcjMR6WfoM3HuoQT6PNomTQ+msLbZ/EgrGPHBhm4fqLEYbbEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1/W4JPf; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1/W4JPf"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79801df3e42so2017557b3.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 12:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860611; cv=none;
        d=google.com; s=arc-20240605;
        b=N1qyVHXmyvHKs49d12Vkdfxk7vHrLgPbhbQrLw7NsMc+WjrgQTAnWf+n0Lu3RG22Bk
         ZNlhBiJja9oOX5t1OhnouCdBMjk6/dOEVPlyFrq4zxf2sH3ejZe0OXtGEyAf4Gz4eEJQ
         wPjxex2DNRHSlSqxfnkGGh/3XOLeERxS4t9M2vj1pq12URuQoytJ9Z7C3BbLGBIctLcf
         vPd2M48+AJXiDF7cF9d72A0vqaDxwGqVrpiUCqbKPDQxCHqLQvn7gkTihQpZVjTiTtIC
         ZH5g2mesz+RhKkYOTdFyouWqHZyrOGw3miUdFL0wj2zPE3khaotdTiJTvDW1mN9C9g9h
         AmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eH8REMSslVrUAqjgEFEDirQgb4W46UHUGU7twaOwvDc=;
        fh=hHqhiOrzf5xE5jmmOz6TpY2jYLs2fWP96Cdd+HOHyAo=;
        b=Ub6PH0eU97nzl2Nm/fC5PWnG30ki2sNoDmh7ErIDAqkRGorJHPogvwoMa9lXyLj4eT
         dvgmFFTDQ359DEWG5tcA9ZW9Nq8seeBzyBNMUZVD+9Gj5c1Z0sz/9t6TJ5IqUNg31OLG
         2fwWXdtk/g/xnmv/eDZoWVz8PrHqcT4KzGKgiYs3gFgINpVEw3cxHoRl9OdWDAuLP0Eg
         SWYejfvJEkDSZcrmQiygX6PGGBI7Np/7quMb2PkYZeRDj36xHvqdfUNZca8WaRfkYD+D
         n047eUQAMA+NbCvFw+Pj4cMeTgPITFUfgsNcDzFE1T3KP1bCMBxn0q988bCrFLGFTSrT
         iUgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773860611; x=1774465411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eH8REMSslVrUAqjgEFEDirQgb4W46UHUGU7twaOwvDc=;
        b=K1/W4JPflqxmgKAZe7BN9cLlnPEioGmRhPX1i+YZ2/C85kV/qbyprkmbdHC8aAFdb9
         YMgmUD0KZTQE6tJJ3NdCvoeEZFWO4v2IaM7Pny0L/ZFSsMz2636kM0WRBbEc1LCkeQOa
         /WHQOrawzH+hGuGz3jYIdbDEWwEiRiPyhM9RH/h67TpJRS85WUhyjKbZTeY3btk5hRa5
         S42MgN6AmaLglnFLbvvDDylTymIhRxEa9bbbMo6AcFiCAZyMmHUnVcvZ/bcjkpB8VrRG
         Vcv3QZSGuPjwu6NNvGndyeVpWbv+6OZ/14apRYxVtrBSHJsB/A2ofGvROXSD1wHvkVXa
         7Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860611; x=1774465411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH8REMSslVrUAqjgEFEDirQgb4W46UHUGU7twaOwvDc=;
        b=jmtOjq3q0VIguu7fAlxW78AIp9Q3El1vPxZ2j50bz99jdctJlf+TNdTzHpGvDz2QSS
         3wQVg08XbrbHXG9TNQTlNpVTkxrzD2ZgN1UrYwqlFR3ydhvGxRf7o6ae7z6veowXQwfL
         vUOdz2lU0+HovHWGEdVAsVMR9/6LcsHn1Lh1FYdWYuu7W8uMjuwkFrZzLow42wWmGbzi
         HRnOQByzhE+KdaTfNhOzrVkahlC6wf46fPCU18AtDtYj0se3XvRMdVZT2dPGDVcmpGUb
         H4KzIaV654CAUD2q53W/FnUC/4BpPzw9kqnuIW23AsPNv77tOkYD6LcNNf2noNKhyxsK
         iTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ67OcotGFW2GZuxN11v92iD0C6bKUYJqy2X1NFq6ianOE4t1mf+gbZwkNhZfv5XWj3dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EhZk9AMvY4hWWwF6VP+k7Gvy10Evtrxwypl4ycDFbNCb4K+l
	8UfsK09UC8zRRFW6yfCVq1+KoSXf49fcn775pfvVHlhnTQyi/6WJzJDWNNIBHu1/XxAjvhauFTg
	U1dqzj2cYGwfQ3HR011WWQc1gYaEGFoI=
X-Gm-Gg: ATEYQzzRljL4zgo0brE7JKKWLVLweoMo0dRi+gdv/8+Sbmi17x7s8cnnW/ynVuQbL1+
	xNbGxBbMgbJSt2VZ8UgI67+CDnqxnka7wVchu1APEmba7K1bf4m9SnbnnWUzbRooXwbkN/FqafH
	aYs3uA++Ah8Fs+mGjKs3jP1im0EOhkWGGH0ofpo0onwPVMCz/RY66uDMphq3XktREiE39ptGjPt
	sdR74XXa7gGYPWq8A9K/+IlvBRflQ1Ld1a6PUdkToEfHme7LKOBavEm8tb5amxP5oTfr4+H+7GB
	nGsSMaE8stMvtl4lL08x4L8ujgecSDUO6oIRG384MRcMu+ZgfDuB9BazqXmf0NgMClt6ViS0JLj
	AE0MXYtRZIBv9f2xiXRo21cc=
X-Received: by 2002:a05:690c:c247:b0:797:e635:697a with SMTP id
 00721157ae682-79a81a2f077mr8637567b3.1.1773860611327; Wed, 18 Mar 2026
 12:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com> <xmqq7br9q8d6.fsf@gitster.g>
In-Reply-To: <xmqq7br9q8d6.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 20:03:13 +0100
X-Gm-Features: AaiRm52VfVYmLKPvfA7P4J_bGFBRYla7oWnn9Hp1aiizFvaLYmx1kweJmFLzYV4
Message-ID: <CAN5EUNQOrBC9o8go=Vehzyzt4R_1eN2Hn5Q8t+E7am9fRc8_sg@mail.gmail.com>
Subject: Re: [PATCH] t2107: modernize path existence check
To: Junio C Hamano <gitster@pobox.com>
Cc: QUANTUM via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	QUANTUM <adityabnw07@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano (<gitster@pobox.com>) writes:
>
> "QUANTUM via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Aditya <adityabnw07@gmail.com>
> >
> > Replace '! test -f' with 'test_path_is_missing' for better
> > debugging information when the assertion fails.
>
> OK.
>
> > Found using: git grep "test -[efd]" t/t????-*.sh
>
> People seem to add the above to their test-path helper patches, but
> unless the coverage of the work is fairly thorough and you want to
> say "all the similar issues should be found with this command and I
> addressed all of them", I do not see much point saying how you found
> one of them and addressed it.

I think it is because of how it is explained on Ideas for microprojects [1].
It is written:

    Steps to Complete

    Find a test script using old-style path checks:

    git grep "test -[efd]" t/

and later says "Include which command you used to find the instances
in your commit message"

[1]: https://git.github.io/SoC-2026-Microprojects/ "Ideas for microprojects"

>
> >
> > Signed-off-by: Aditya <adityabnw07@gmail.com>
> > ---
> >     [GSoC] t2107: modernize path existence check
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2071%2FQuantumDev-CERN%2Fgsoc-microproject-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2071/QuantumDev-CERN/gsoc-microproject-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2071
> >
> >  t/t2107-update-index-basic.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> > index cc72ead79f..3bffe5da8a 100755
> > --- a/t/t2107-update-index-basic.sh
> > +++ b/t/t2107-update-index-basic.sh
> > @@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
> >       # the_index.cache_changed is zero, rollback_lock_file fails
> >       git update-index --refresh --verbose >out &&
> >       test_must_be_empty out &&
> > -     ! test -f .git/index.lock
> > +     test_path_is_missing .git/index.lock
> >       )
> >  '
> >
> >
> > base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
>
