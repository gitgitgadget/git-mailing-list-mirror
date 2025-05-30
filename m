Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2C21CFE0
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748641834; cv=none; b=UUmFgYRN8UsqJAJ54qfFJOm3l8gLJ9oa9lRuNxabIucic3ElonDlUAv5rE0iF4990x5YE4XRDakU5JwSo3LalrOjDB2RJyzaFwpPWkZYjnJHuxxwThkp3zPDawEIUxxqTtTm3BmaejXY6XkgjSDJqRxLBb9xPshnDrSssSzK0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748641834; c=relaxed/simple;
	bh=EdA/Xabm1CdErIRhjkk8hnCspp3mnSKsEKZir+NOlNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD1LnMrVzVDpYW1tjyBeP+2ixGIhA0sDw/qVk0bBDkNSk0urCMr2+sELWCxaOuetNtYUoTCwUxGX10yEb6tnoVLfTL3rBUmrF083WGCDJW69x0jOvK8+MJ1ytzmQgGDeAI9sulzfuSBVtXUOrBaHzvBm1/C8IF+EugrnFQ4IOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5a55bf777so42330785a.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 14:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748641832; x=1749246632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmkjpWKZDmdOiDEZWAM8JOu+CNGZZCri/sSmC8CbUKU=;
        b=bHeYvhMgMFUboN/Zz9AiS6PtsksizRvvSV57AjIeUY+AqGcqxbYBOBliLBiJ1EbJgb
         o2YN0FknR14gfD41YCluKM6IrvoVr3DKSOBhGNAGFyZyEkcHWE/7D0uDaYXbEnJEemVq
         9B2hWo9VndmyoWUFzmmM/FK/c8iVPc3KukxVcmL3NLY3OJMVnhFUPEYRQcB7Gvi8J3hC
         I2T6nfZPEvD1K696vosx/Wf3H9dq3mZO05V+douncK66oocIxDZQlrcNxaUlD/6Kij/A
         d+XJr5zbIiQOUNUezNchtVAdbPQMR+bwbA/x+mx9yNTymscUl4KDIW7Payg1a30CFZRq
         /rFg==
X-Forwarded-Encrypted: i=1; AJvYcCXCqRZ/Hv6mfPUok83SJ+Jg+elqW4XczGgInBQkiHE2MPB/s2CbAFpvxnWGI4ancGGpDNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCUevo1ZmE8OUn26F7pCti2Fi6TTcNheYfxtgLfOtcyY1EjAq
	R0olq6Fm7IIcXHhMxupc9gsUtCtvQqRojwmYnQSO+KE+/GUQ5RqtzEpB27CmP3/jkMcmP60QIKU
	k7/PGTw6OJ3ImzWrvGKKo8B8rhi7gc2g=
X-Gm-Gg: ASbGnctuEFC+RVINXlvm8J/uDaPrSm5b5no/EcFBwmYV4R+NTjIFbOM86Q+R2/Qgzj5
	DGtOj9jmhaPxufy8Z76Jrd6AwCCvpmGRyoz10FjHW38QKXDqJgNVM3chDFryl4SIa42INi1au1a
	Es0J7p9VWCcttQNpNVsaE2vrrVSiMoWnY=
X-Google-Smtp-Source: AGHT+IEyv0SfopfSw/lRCIbAYXHhMhXIXELvp4tCw2GCdayo7C1Dl/qe0BA7OpuhVulbrX/0DRr63ITXAQAtbS/NWjY=
X-Received: by 2002:ad4:5ca5:0:b0:6fa:be81:e18f with SMTP id
 6a1803df08f44-6fad059a7f8mr25024736d6.0.1748641831810; Fri, 30 May 2025
 14:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
 <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com> <56b24d681cbcedaf5c03c89eee582d554a0894b7.1748628847.git.gitgitgadget@gmail.com>
 <xmqqa56tepx8.fsf@gitster.g>
In-Reply-To: <xmqqa56tepx8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 May 2025 17:50:20 -0400
X-Gm-Features: AX0GCFt_iIDhdQVK_eDXU8IgzW6nmIszN0QQNAfGlU4r3ztIQfAG6DA3ffpMzDM
Message-ID: <CAPig+cSv8ADqERwZBZ_7OXnedGPR_iwRa0Z-NtEBHxS2Zc8EjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t5333: test memory leak when use pseudo-merge in
 boundary traversal
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Lidong Yan <502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 5:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +             export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=3D1 &&
>
> The test linter complains on this line for me, it seems.

To provide a bit more context:

    % (cd t && make test-lint-shell-syntax)

tells you that `export FOO=3Dbar` is not portable and that it should
instead be written as:

    FOO=3Dbar &&
    export FOO &&
