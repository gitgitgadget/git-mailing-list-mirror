Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A72EF65A
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968556; cv=none; b=iEi4XDBmuJDHfcRhytLIVA//kng3n2djOOvrOplzgCxSJASxbSqpp3vdzrHcQuu5WNLBdQx8LFrW5VaiIW6Ip1RUVuDyv/yAetxNpfSBGTUrXSQKhCpu6glwBMnxoS67h0aaUgRBR1oZZEwLHSUcziUmng/sYHj1KForprWeFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968556; c=relaxed/simple;
	bh=8C8t5aZY17GhrlRVLAQQt6s/+tXzH3rt8hoqkaufLJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMe1NqswqlLGMJt3m9ZGCpx3RpCv+jHlnGkQ+RIy3nBQTbdPFwp7d0/Mtecw2iyVAjYUD+X17QB8P41znFy9h8CeqAYnhqMdqgq0N9ZDzulB2VZmBn97iZkVOpYTseu1DKSrfHaONeC5KlqmVkG3dBIovr+3oOOLcuS/J8d1ZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOIytySu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOIytySu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b9dfb842so15457795ad.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750968554; x=1751573354; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wg/oDhQBmvFrfhGRtWKSsigyHlY9xGN9Huh35NDWrzs=;
        b=BOIytySulXAmFT3X0E3ooYO2jznPcmlAkFfmHU4tSvdY1dlSKO65YaafYu+TLXKvdc
         vUPuHgpnFpLQDU/ncX90KG5WeUhbe4jfeBYmH/rKLA/GyuqN19sxp6GhaOCp58VHilGA
         oprT3PHLP1GEWEwWbTE28sF2utHLFLRr3Zh4U0AlL2CrmUv6sCD7gr4tsczUQQ/xPZNA
         TpI7x6LyeO7tQwXRSpHv2Ze6qah0MjFHFxeI/s9pe7WPDJSkElvCUX0dYylUtz7hlm4t
         +gHg8wkLNRvp4lDGQ4qGpVYd8S0oMtW+zVuiGymlqyESl2ni7ihLCm4LmwOuYq6cZMsP
         /hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968554; x=1751573354;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg/oDhQBmvFrfhGRtWKSsigyHlY9xGN9Huh35NDWrzs=;
        b=X/1CWnMdo9Me2LfnTbUBNw6Ceow1gLu/LrcrDbL76CHLNrnd07MXXzrQY262DZ3rYC
         +3h/7nlaUrIHDvU1N6FShcCMabGjUR+BuyWeWCZLIb/fqof2yzDzR5AQn+s2OMfIvldb
         F9P5xMf5yedPGImFWnqj80Nd9r2vf35wkhE9EVF5Vf+HoNSnUBUb5GG1O1RtD/67IeUY
         t6qNyjWQs3pcRUYeI5EmKgEoAukscj+4HWukRSXEjsQ8y/p9qnTFzm/ghnEOQkAO24gE
         CIrTY6nfMPgYaZvmuNkdeQlMlxj6+g7mNgLdF6kl2E/62A+dpV8SNOgj1tGf2fs04HOR
         QYVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1tBQJkYxKnEkeX1p3mNAWBGjxN56+gqGurY5Z/PQBzlRo2dDDYyrB5GWnLJcJ6S7wzRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+sRK36dx5iPURowCpIZRk+U6RMm9NwRLYMWhnGYSQZjUKvJ8
	OYakbaz1NZDy8PPd3XYtmAN8/ukoOzPZ3DTHpOTvbIEpRE4nXs130sNH
X-Gm-Gg: ASbGncsTp6L6UFr64W6HDvTHAhCl085SExXiXbt1Oc0bqdVi35wzmiOGCxpO8s5BUWK
	ACivQ8NMT+K0BwksRtbZeyqiL6h3/XXMytxPoZrPZfCAY0h/h3jZ+wGnUCFi6uLQMcBG3XVAT+y
	ALxUoS11LX3gyJwbPynwJNXWT0XJQPkNVqhdirOmJ+s2sJQlG3RLmHgECOhlB14MDd4R8klYhge
	0zrE9neMdFiw47KVAak9tMoU9bycUep1y2JnL4QbyszUh62i9UHEeCa8iw7NgqNkB7UwZw60ceO
	cojSX/L7dlagoESNeF/NKg+UgPhxPgQ/SYOvpiPdWzkK6EuLl0nIOEohr8rA0vPptGzODk0t4Q+
	l5pv7C+D71lAt20bJ5R28m5A=
X-Google-Smtp-Source: AGHT+IEHvsA78LoaSuagm3els8Ks6BdPhza+Cb9EACPOW8zoyBNs2AhfMuUBAP3VdFyEOHpGK1pOfg==
X-Received: by 2002:a17:903:228a:b0:234:a139:1215 with SMTP id d9443c01a7336-23ac4606519mr8612245ad.35.1750968553865;
        Thu, 26 Jun 2025 13:09:13 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1d3:1456:244b:d366])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe42619bsm4518655ad.206.2025.06.26.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:09:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:09:12 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
Message-ID: <p6xegxqqq4wzi6gnokypy3k5auxk3d2wxmj4pj45ugfomace3q@y5q3e2al42oj>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
 <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
 <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
 <0dd51eab-8869-46be-beca-238a616dd6f3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dd51eab-8869-46be-beca-238a616dd6f3@gmail.com>

On Thu, Jun 26, 2025 at 04:19:11PM -0800, phillip.wood123@gmail.com wrote:
> On 26/06/2025 15:58, Carlo Marcelo Arenas Belón wrote:
> > On Thu, Jun 26, 2025 at 02:56:22PM -0800, Phillip Wood wrote:
> > > On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
> > > > On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
> > > > > On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> > > > > > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> > > > > > 
> > > > > > A future change will start using sigaction to setup a SIGCHLD signal
> > > > > > handler.
> > > > > > 
> > > > > > The current code uses signal() which returns SIG_ERR (but doesn't
> > > > > > seem to set errno) so instruct sigaction() to do the same.
> > > > > 
> > > > > Why are we returning -1 below instead of SIG_ERR if we want the behavior to
> > > > > match?
> > > > 
> > > > By "match", I mean that in both cases we will get an error return value
> > > > and errno won't be set to EINVAL (which is what POSIX requires)
> > > > 
> > > > In our codebase since we ignore the return code anyway, it wouldn't make
> > > > a difference, either way.
> > > > 
> > > > signal() returns a pointer, and sigaction() returns and int,
> > > 
> > > Oh right, I'd forgotten they have different return types. I think we should
> > > probably be setting errno = EINVAL before returning -1 to match what this
> > > function does with other signals it does not support - just because our
> > > current callers ignore the return value doesn't mean that future callers
> > > will and they might want check errno if they see the function fail.
> > 
> > I agree, and indeed had to triple check and change my implementation after I
> > confirmed that signal(SIGCHLD) does not change errno on Windows (not our
> > version, neither of the windows libc or mingw, even if it is documented[1] to
> > do so.
> > 
> > It might be because the signal number itself is bogus (there is none for
> > SIGCHLD in their headers, and git uses their own numbers in compat), but
> > either way, I would rather be consistent with signal() at least originally.
> 
> I'm not sure I understand - don't we want the sigaction() wrapper to behave
> like sigaction() would?

for at least the first iteration, I would rather have sigaction() behave
like signal(), so that the change doesn't introduce any regressions.

eventually, sigaction() should behave like any other sigaction(), but to
do so, I suspect the windows emulation might need to change their SIGCHLD
to match.

just confirmed with MSVC that if I use 20 instead of 17, errno gets updated
just like the documentation says it should.

Carlo

PS. Maybe we should get dscho involved?
> > 
> > [1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signal
