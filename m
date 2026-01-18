Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0132F75B
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741812; cv=pass; b=Jy3FyNeeDCwQs/6i6l2Rh9pLEiGGPo9sJL/KVjy7g/DI6dq3EbRY+MGBDSZbSVJXMLCzLR2C2Sra3lrk8k6jccJMDQ2jJFqwmxXTBGUH+jNG4tPHPnvH0VBD1BFFnHW2mm7PPHdwm/AtTf536N2sV+hFbn6UCxPwC/p6FI80uto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741812; c=relaxed/simple;
	bh=Mz4r2oZ/iYmEAthlnyOPCeou9CoqJhTJFvbXRuphk4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzBns2qvBfl52/yrdfatQPaxvV3sr2d7w1GIw31WRXzeAMspVkcsk5ICSs/t3TclOmWZ19fdUFrCFzCgf16OTzjcYo5xmyErN5dE6FbrqGyzrMbir5+HD6SdePM4SnF/jGhgSMHr0mvm4TFrcmWvYpzinvsRlQvbF5cJ1dS8GGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fba4xQYL; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fba4xQYL"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-644798bb299so2966085d50.3
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 05:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768741810; cv=none;
        d=google.com; s=arc-20240605;
        b=O36CVN1jiLolitecz8zeAVYLhp3MEWDgxsASZSICjVsCQFi2QynXphb16OsY/OIQjp
         g9+xghYSAjvnh1b0ZS3yMTMcYc7grjLf8r6KZPNijq3I1u/qaODEJ9vO2O77SYe3OIXH
         DXelnK5FE1eYU6aXrVRqWTEtHo+hDllsjaE6kGBFoEVDkIQBtI7f8sVXXTyqcZ/1pYIY
         UKbnrTNov6ibLr9w9j/ErxYgYAZDOIPdc60zFgwxcww5kcvLY4AUOvz59J6zgWk9wrrO
         2QbBsF+qN4WDebqcbKKRqEcnIqBClCQAqtjeIUkdf8IIgQPhmuu06vzR0fDKNkGgcEtG
         yuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gKYG4udEIVP3opFlFsqlaq8tol2rsjTcZNjQqAs8CXo=;
        fh=Gt9EA1Wx0JUNmOfPAYhUGSHdygBlorOkQ5ZMIk7pGIY=;
        b=R6EkXzrDlRMTMPw05R2/pzKBsQqTd+7Wl5MhVojXRApEs/s+QqaYpoyIBTR6mnP/5i
         toadje3RUrAidtiEnd0iqd/wnYTYI5R7JHEjlRoEuIyDiEgdMry08T8QSXscriYoqqdp
         hiUXN4f3TZkls0aQ4Bx/c8qOiGvyLOudpXUfRCAlzBXPsG4DuKf99dXtPXu316aMl8vJ
         NSiYmHJKN/SaL3vkr3jBt+BHsJbweEIq+GLI4gGIoXnBloOI/9f8LHZXDjspa6yRRu1h
         EPdARQBYW5SKfM7RGUpw2LNT/R6legwUlAB2QVhT0R5wMxA0zsGpEgMenZTpB4TfHZzI
         am3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768741810; x=1769346610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKYG4udEIVP3opFlFsqlaq8tol2rsjTcZNjQqAs8CXo=;
        b=fba4xQYLMOWtdSeXbuB5eglAGB/swbXYE0zsBiH08zcrXKqTykRbMnr2XmvamBnfPc
         r6Lg1xPDjemQ0pr+cn1MilV6hp2z4rPsjd5cFh7DdKjM8vUzhbxSX3gZdTtLIg5RKYdG
         LNBGCDZiWNvUUQfPoztPYh8ERIzMRJ2HOGPKzoKt0c7HMXnDp+2UNolhCmz/Y1rX4YXJ
         AYsQLEzOzbWJpjERye/lMid6KwWXpka/U7Uqcexy29sinoLamIGSJpRmyOy5PPLNYdkT
         xRNEURI8seafFl9jY3DH7Xs5dgPID/r8CymXDUisaGEV0AzQUdlGWPDUM7mhtTQTKJoz
         XTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768741810; x=1769346610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKYG4udEIVP3opFlFsqlaq8tol2rsjTcZNjQqAs8CXo=;
        b=S0ChJ0UOeTcH0/lakFROyleOqTBFRpJ3BelU9VLVz2fe+O/z6w3sZNim0tIv+osjxj
         eRszw6OtQefLUMO0fdWGDgTrWa+I0QSWrTQxIhIsddP0O/Mp123epQM24UmxtsjOQmMt
         0TpEUf2FWKKgZn8bSt0sjSWAg6u/jIugLNiX8fbbzXwLa3ap2k7nNCkfKmweTGLcVJKy
         Jt+DAxGsmH0XdifXUEDxyx62KNzI/N50lpwES0UcasCfuWPQSEgaizXetKcYrmAg0tNx
         +lf3kTXlEw1UraMQRYsznJFnc6/xDfqzOjk1npbCkO23akPUkecaaxqnitbonDNAeINJ
         pI6w==
X-Forwarded-Encrypted: i=1; AJvYcCWffUCA1/VpqXhUoSF5zXduoje6G1NsZd3nTqaUOV5h7xtNdBuZntPPdDkBKMwgPTsW3S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJ1YP8Ut90NrqT8DbfVzwZer3gUVZPmXbKQVqFnDn49NlDyb1
	BU/RBHZyR2AwmfipvMU7Zj20sO+qNtpuV/EH8MQ5pzJiYEKzfBpNJNh3iZxrXQOrxlO+aXi1H46
	pce2FmK2TMgWewgYVl2OBleMDH2DBqx1pyLVX
X-Gm-Gg: AY/fxX7ucmBHSJdbV9EVG6+ronjX94lzFuMfVJYFdhM7/iinhZzN9IMM3pPU0vtatPo
	lsbaBUJV7rP9pW4DuXqY9gsMZu14ywABfMwPg9ue7Wsp4iDA2sdvApD+FCuaEaU9PSuc479zlgH
	+q8tS3LKpVDKXviKtiWHuulzBb/l9Ctmwu0x5r7eOEu0XTz4uQj2IZ0jQ1eRuC31B+RMExohnWz
	pJW+mYj0DT9452mgna8XbQtebXAn5PiGIwF3Fnl0J6Ln/A8pIRllZbDQZ6Nhs3Gh4v3EYSA6pew
	S7qzyaeY+fZnA92+U0p+7gJSFyjG
X-Received: by 2002:a05:690e:4183:b0:648:3d3:7902 with SMTP id
 956f58d0204a3-64917730dfamr6018503d50.97.1768741810082; Sun, 18 Jan 2026
 05:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
 <fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de> <CAPvEtrdQ7LB4p0_yCg+ef6fsWSHwxA8C1uX0SJbfnV3vfQHD_g@mail.gmail.com>
 <xmqqy0lx8ojt.fsf@gitster.g> <c5631f7d-72ff-4876-9b68-ea4a70fde501@gmail.com>
In-Reply-To: <c5631f7d-72ff-4876-9b68-ea4a70fde501@gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sun, 18 Jan 2026 18:39:58 +0530
X-Gm-Features: AZwV_QjZ9UBIOY3XOmXGlGL4-KM6P11su7Xe9Gf3yhTPKmIqnpW7R2NPw6lI0B4
Message-ID: <CAPvEtreFgpVLG7WsJsJLjSA0_x0S3vh=PXa+VqmVnxjRTJ7WGA@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	git@vger.kernel.org, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Jan 2026 at 08:16, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/16/26 12:17 PM, Junio C Hamano wrote:
> > Amisha Chhajed <amishhhaaaa@gmail.com> writes:
> >
> >> It was assumed to be safe under the notion that our entries are not
> >> duplicate but as already pointed out, our entries are not unique so we
> >> need one of those two ways either insert or remove_duplicates, this
> >> can be a trivial question but i wonder how are the tests passing by
> >> removing these lines, i was actually researching about it.
> >
> > ... suspense.  And the result of the research was???
> >
> > If the answer was simply "we lack test coverage", it may make sense
> > to add a test taken from Peff's earlier response to increase test
> > coverage, perhaps?
>
> In addition to adding more tests to t/t1091-sparse-checkout-builtin.sh
> to cover these duplicate cases. To demonstrate your quadratic perf
> improvement, a test in t/perf/p2000-sparse-operations.sh or similar
> would be good to add.
>
> I expect that the test you would add doesn't matter too much about
> the data shape, but would look very different from most tests in
> p2000. You can make use of the constructed repo's directory structure
> that has nesting directories with name f1, f2, f3, or f4.
>
> Here's something to get you started that I haven't tested myself:
>
> test_perf 'duplicate sparse directories' '
>         (
>                 cd full-v4 &&
>
>                 for i in $(test_seq 1000)
>                 do
>                         printf "f1/f2/f3/f4\n"
>                 done >in &&
>                 git sparse-checkout set --stdin <in
>         )
> '
>
> That should test the logic with 1000 identical directories, which
> should be enough to have the quadratic growth show up.
>
> Thanks,
> -Stolee


Thank you so much for pointing me in the right direction.
