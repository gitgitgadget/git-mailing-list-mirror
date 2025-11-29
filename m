Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92536D51F
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764392575; cv=none; b=ah+rT66UtWSTAGHL44aQfiLifZ5wIp/4sEUv+6gQOQdJGsqfbycxWK+PQK+Gj9SERKFpaYogPitHi0bBfj47BBY4XfDInAIacJDBflFcvm1/qw7QHN5MQ0afQR02iKARD/aNqGxQ++rKy80KVxhZ1LXPWfQM3RoXEOIARvHgBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764392575; c=relaxed/simple;
	bh=urNPqJzwzBZ29jZx1fkHJpHVzRJonVYxHCW1NZSN+5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrbvZrfYelklv+aW2JBl6NtIKAoqett25t77GHdATha3GCxQuYuPjjzpbYCMqBfgTa6v7zhUTJCCZaYqhFhlpXdTVw4iCxXuE15VS0mjSkN83G8Hc4lXT+pXB0cFgErUdAo9OTN08smnJJacBSMqk+6XjZ2lStuBA7CZZ2nUdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7gmp6TW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7gmp6TW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso2262656a91.1
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 21:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764392573; x=1764997373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s0mtgX6opYHU2hkYJj0T6WPBLMAFno+D7H4lpMUHog=;
        b=X7gmp6TWwaKpVxa/C4oHd+Ok+w6GrvL+uS2EPYxiLYPRs0xlr8nBWltOM267X8aTgt
         sQp+XjZgrcpW3Ask1qKYC1F+Mfryh4SeZPjWPnHMc5ZaQmGR3va4t4rNzF+E0BhRyplj
         Q52Q3RrymJUiIQoFDAJBkvgHUxSUP7BSrV0ZdlhRTvb01Ld3NwxbIJRgfDydEgKLmmwy
         5O98zTn/uZtLFQzRc0wxsqU0mxKsPQ5D/PI0nNWxsnGQE3AFnZqDQMnPulepVqNg3t5A
         HdAp0LL+oQCvxtliTFi7RWFXqu3htsq/gjlcLU2FeY7zVsKiskOA0glmd/aXx6ItTQ6x
         nuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764392573; x=1764997373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8s0mtgX6opYHU2hkYJj0T6WPBLMAFno+D7H4lpMUHog=;
        b=ZGWVy7y7P6iVknYAA/gBMzX4j2SWVvhEoRt03mDWHRm5oGTUt0UqFxkrNCEX2HDE0m
         svXw+9t340Bq/Lsh9HWV0H7nzogEI0CTXktfuSAaBA0EO17yIJu92HM0ZM4QeN9FtzSd
         v82e2qRhDPfWBvW07Xiqf76PoQswVJL4/sCuPBLmFZp/Y/9RJkqRZIV/puxs+Z1zcpWI
         wh1gTFwJ41cXlfpooLtLxh897OvoEzzaqFbrVWYi1qs1sqjdgvVq5R99yR4OUPnVg8x6
         ikNUmLnTxZAijAjm9NkLymtagvP75lglSp1FRwrSgfjHqzNZWesLnZBCZ/O0BzMcCgo6
         KSnA==
X-Forwarded-Encrypted: i=1; AJvYcCUFKGskNtRVEQum3p2Db1zuV2ym75+/pke3BEl5+KThOsJ4wyq66qrwJpMCg3RuKFLqfSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99h/hwE460ebvgvt8hPzhB2cd8dsqEW46zDdR4lPxoSVj6P7o
	zjlZabXiSlKBd+TTk1BWXPPVtWy1IZ9Z6cWUOXKqWXHpN9UnKb9vz+lmUluB7BuxslFUtnbHuaD
	PGoBCrW/rRKR2y4tfCI8viqlCu2xXSli8gQ==
X-Gm-Gg: ASbGncuZNYx1YPPQ1PK4ClXexQuoyOHDWLh4VmCpASuNwvTRliAcy/TvYCuVtk2ukbW
	EtIaWnRECos/LuvZ2RQSyG1v6Reb/uwLQbLBk78gNSPfL7kPR08TKizSTaCVrTtJXKL8azwordy
	kjLFfTYsRftoTpu0MucN6WTzigZG0uHPAHS/yga7wtfErRuMJ5pErpLKL+7HHEOht682tB5yMuH
	Y6e7dVVCD9b/TfMREm11pIMAi/jUh81SumMIfphc9rdAHosQsn7blNQXIbszoRaBXYbT5g=
X-Google-Smtp-Source: AGHT+IF3JbdxzxznQyrAMN4oLoTFp6QBX71g5mnqqmksx32/YY2aN6M4mcrGftRNEJCLN5oK63qRNxL2u8Xe7UaTN20=
X-Received: by 2002:a05:7022:24a2:b0:11a:61ef:8491 with SMTP id
 a92af1059eb24-11c9d60ebedmr18117934c88.3.1764392573128; Fri, 28 Nov 2025
 21:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANavNqpHqVgHshUaToS51OGVuvx5FqxROP2PssHW9OELMLeBQQ@mail.gmail.com>
 <20250918182545.GA1184978@coredump.intra.peff.net> <xmqqwm5v7btu.fsf@gitster.g>
In-Reply-To: <xmqqwm5v7btu.fsf@gitster.g>
From: David Goldstein <dgoldstein0@gmail.com>
Date: Fri, 28 Nov 2025 23:02:37 -0600
X-Gm-Features: AWmQ_bm8TdHCTiopXZgPNol5a4bo1D8-MJZcAH_sDlPdSGVmOXyJtxwem_8yTN8
Message-ID: <CANavNqp4ot=tNFWLfsK3Jy1RBVA3+SrkoKNm9f54a1QvhC2vXw@mail.gmail.com>
Subject: Re: [bug] git check-ignore returns the wrong exit code with -v when
 only a negative pattern matches
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I meant to reply with some info about how I discovered this and just
realized I forgot.  Anyhow I don't think it'll change how yall
prioritize.

I was reviewing a change to swap grep for ripgrep, and was trying to
understand why we got different results with ripgrep with and without
--no-ignore.  Hence, I was testing some of the files that showed up as
differences with git check-ignore - which didn't really answer the
question either.  So I ended up using git check-ignore -v and
inspecting exit codes as a way to try to verify my own sanity, trying
to understand how a file could be both ignored but not ignored, hence
stumbling over this bug.  In the end I figured out that the
differences were that my repository had tracked files which matched
.gitignore patterns (which therefore aren't ignored files), and
ripgrep doesn't know what is tracked or not, just what matches
.gitignore patterns.  That fully explained the apparent misbehavior
(afaict ripgrep doesn't call git check-ignore in any way), but along
the way I found this check-ignore edge case.

On Thu, Sep 18, 2025 at 3:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > AFAICT it has been this way since the inception of the code. I haven't
> > ever used the exit code of check-ignore. I wonder if the current
> > behavior is actually useful, along the lines of "exit 0 if any output
> > was shown, and 1 otherwise". That would justify a difference in behavio=
r
> > between running with "-v" and without. But again, I've never used the
> > exit code so I'm not sure in what circumstances it would be useful.
>
> I very much agree with your assessment, as my understanding is that
> the command is primarily for debugging your .gitignore pattern by
> eyeballing the output from it (as opposed to a serious tool to see
> if a particular path is or is not ignored), so I am not surprised if
> its exit code handling is buggy, and I am not suprirsed at all if
> nobody has even noticed it is buggy ;-).
>
>
