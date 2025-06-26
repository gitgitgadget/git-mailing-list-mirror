Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED892EBDCA
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949897; cv=none; b=Nk/0Q8GUMfJyZhzOa62i6WP5oOe74T+PdI8Xe6tZ8F2/Rpj5rXJTz/U/UFfH5JdL8xHe/KAYOXB8W03vURKI7F3YV4644/jChOldjc0wX7Iq7H0svZmIKMKZMoPnwTzaRHz/PFCNTEMx/dJlmK5H1kakkaqTTcFRMCWk/vg4XAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949897; c=relaxed/simple;
	bh=aOfna1x4xxeJ4Zeo++/+E8VQbk5eds0sms3oDYdMnbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ8vTuEWYUffx0AWTiScsVBhLj1KNVSMoU1wZSDKAZH1TLUnHML/3rICmA8u9JwNCzDG+BOsmhc9/Tmh9D+OGboutV7TxZNk2ZorF9yobIEzMVjUtaJ0UlKCJ+iU1onr+agXvseG0Ve+DijUTJ82HM5XRYUuTbW0EyQ5x1Y65cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkGzmWK9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkGzmWK9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235a3dd4f0dso8280015ad.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750949895; x=1751554695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjcygGVFyC0XiUTCPxXIra828NjlHORRz5HhbdFPOyo=;
        b=ZkGzmWK9qkuQX6iPfXaZSaN8DwvVhvWgVRo1mr8lj+0auKk3O62zJJTtR6Cp4ZRFBp
         vWgJjkdOHbY3TokpybOvqvnmXWH1nRhQnsHNuBnonRvhIpMbxlJ3nkhwwltl5bf8VTli
         wPYI1BiPwZD2AGSuJdHvShyCxP1W5ISlyP90xfg1RwVOqEVrjvkVLIq1EPWUtqBUebma
         E5k27ZAWQpuxf6Xzssy8b4h9tFh6rYpSZUKQvpMr5IIMo5NFfzYq9JYeFGlOR/WdrpBC
         t0DpF2MvPrdB1NfZO/Sbd+arJRdwCuwwCdtliXR1W+WIGQKkLqITXlfCuaqrLyM662o9
         Pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949895; x=1751554695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjcygGVFyC0XiUTCPxXIra828NjlHORRz5HhbdFPOyo=;
        b=FLF8mnIIkNk9l5IEH5GrKCubrvsSwRCHfuAYDyu0iZZt9wuUsPXIhN6PNjg6gTk7r1
         +EmpnyUx8RhSzy+B0X147THvR3IEsSz6BoiE40I+JMwvgyfaEI1gW9lGQLHDhumAWa4/
         S1h80KjJ5WIF35j51QT6pMdzB+v8L/nBjW3fQPZSQzjpO+jCks/pB8SP47dFPSb7439J
         dePLf6X80Qp53Db/zfLf/s4Ft2dI0qcq1IIvHEaxpAVf+DMCnderaGQeojY9eKPfLkCN
         yCLzBUGisZDWS/uhirDkryGjXm2zABKkeFT6UeEX6J2bmkEln1tkDTNvXtB3BMra7OZA
         xgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEnAde3wNLfpc66u3s+vHmFwJA+sLJeylDd6ItFbGISuifIO3YsujcUEMsqDP+0bc8LlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfP8O6o4zfqn7b4kovKL2g2QYOQA0Sde42yZA1VC0X4/Cdhag
	uNLC9VqxukBJQiBqCXazGBlhiXd6JFiGXHPxyC68Dw8uXO837vqH1UMg
X-Gm-Gg: ASbGncuifUujtPhlXUHxm0u3WzLAfOzeGNc9TjiRHAel+YrElGM7yn2ntchQxVto5Ex
	JjNyGjfZZ2T5+vOKDyNA/ubEUaczPt17FPMlMDYK44cKlCRkuODv5sxEoMHisCbUuIakqO91b4a
	qmWtD1V6QEuP5AwzY9JbenDLDMiqodK7oFmfkFC44Org+pDZf336d/hVDbq6vzdU3x/5IqFlbtQ
	HCe4kRfLnxOEOnUBeYZS4jO90PLVxWDAcN09x2LLClfsUAKNHVCqbIg0RUEcP/Ln9VtZ3LHA1Do
	Lh4E02RPBqsddOE6pvo/g0++TAqfbWIOFWAnYVR4PugEfgAJvjWiPy2QKWAT1xD8npLvTv6N54H
	FQ3cgAVJVjrrf7ee7zgzHTbc=
X-Google-Smtp-Source: AGHT+IFVpN8o2Hk5vSZjExpt8BI8Bjl4Azs7It+iP4vygwy7CKTQVd3Gh8i8DqIo8tW+4BZkVbFl3w==
X-Received: by 2002:a17:902:da85:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23abe308ed9mr1302035ad.0.1750949895495;
        Thu, 26 Jun 2025 07:58:15 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3f82b0sm194795ad.158.2025.06.26.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:58:14 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:58:13 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
Message-ID: <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
 <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>

On Thu, Jun 26, 2025 at 02:56:22PM -0800, Phillip Wood wrote:
> On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
> > On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
> > > On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> > > > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> > > > 
> > > > A future change will start using sigaction to setup a SIGCHLD signal
> > > > handler.
> > > > 
> > > > The current code uses signal() which returns SIG_ERR (but doesn't
> > > > seem to set errno) so instruct sigaction() to do the same.
> > > 
> > > Why are we returning -1 below instead of SIG_ERR if we want the behavior to
> > > match?
> > 
> > By "match", I mean that in both cases we will get an error return value
> > and errno won't be set to EINVAL (which is what POSIX requires)
> > 
> > In our codebase since we ignore the return code anyway, it wouldn't make
> > a difference, either way.
> > 
> > signal() returns a pointer, and sigaction() returns and int,
> 
> Oh right, I'd forgotten they have different return types. I think we should
> probably be setting errno = EINVAL before returning -1 to match what this
> function does with other signals it does not support - just because our
> current callers ignore the return value doesn't mean that future callers
> will and they might want check errno if they see the function fail.

I agree, and indeed had to triple check and change my implementation after I
confirmed that signal(SIGCHLD) does not change errno on Windows (not our
version, neither of the windows libc or mingw, even if it is documented[1] to
do so.

It might be because the signal number itself is bogus (there is none for
SIGCHLD in their headers, and git uses their own numbers in compat), but
either way, I would rather be consistent with signal() at least originally.

Carlo

[1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signal
