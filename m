Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556331B114
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516351; cv=none; b=havSHHpoDLzPZkRbzjg0M9mWHePuagf2Pe3SNEcgJtdbe6t7oQhraIXqGSxzfKIX+LzrDHMKM1jSnTAlpSVqfICrg8URIpv+TRDuOWvD3in65o/cKGWAqbpLYwgbh5iapKryu5jKFFDxBLDyYWFp4cAFYY1yDcQmyOdmUs74nYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516351; c=relaxed/simple;
	bh=+wnqXTmZY6rC0LCzeB7BYnZBfK72ptSY3RBkm2b9oWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzR76OynNXDayPH5kyfRBcnRVLJXtenv2RJkQDxkBvb9PVziEuKD9iVWlGlOZugG5oMfHLDkDLazUF3nObb2TQnii/DlY0qMnbwhyBPMRfd9zTzM9GQ0zwFfgu2Y6dcD9INQvNYQntlEmcppL3QjFvRzgkMe+PO3eyByOrUjBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhMjAzTJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhMjAzTJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso19060945e9.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755516348; x=1756121148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ga62kfAtALQCNVrzQJVWPKfaXJnC6psG5KU7N9eHujw=;
        b=EhMjAzTJpXgmqspTAbTv2Q0SZsX8lKtMz4lF28CJB7TzCvcZAdfidwtBpff3vR/42n
         EUDE0vPpKfo0eGJVJ+DAvA1XN4liuZ/ifSaOo+I6JTbj5Gg3vShm+u9iXVJqhvDVzaW4
         Dyb1F1JwzfovHDEVKuSN6ZxLMYMGaIRF6GQjBF/KPyGRiREW4LUnb/kzB4UlUD/QTcOi
         oTpr6HiCdpctcrDEg4FbSA8XSJpNqY15epqgb0q5FKVKrSh3nX47u0vPvhtc4Dv8B4np
         XtNLh0hl9tMLwz3ZFLjF6u8Ad56VhY8vBUIm02iTDagpzFZuxzh7IzF85TezB6KpevhU
         w6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516348; x=1756121148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga62kfAtALQCNVrzQJVWPKfaXJnC6psG5KU7N9eHujw=;
        b=KL+1/Fela9cTrkGDq3mS6BcNwckqC4hmutWYUoWV2Mt0Llt+3s/O49YAYAvOfDANsU
         HhlJ0RshQSS2uP/ZUXidv1gPw2D9GTpNLhPqWLqWJPliE20xE47TFAALX1b98oIHVjqI
         fSGkWaujvn2SRBVIF4VmzziObq/4E3Ne4N94s9radZ2PvySsZ7po8jt91z1JaFI4EQbw
         QvtIDfpFcLZrTiAViiMcq1ctZQ9qul8t1bi29981osGAl2HAod5adTvbOqvvVpKdlECR
         1iMo8x8YuisF2LhpogURZ/fjOwofAuIB6pS8t0nfQ+ZXAogFqAddDFNPzvLx8pl+EJPm
         YtmA==
X-Gm-Message-State: AOJu0YwFCPCU5GPtrgFtjCMjzOgdfzY/PhNXzFv4CTx3jStQzrZ7K508
	HB8rEvv6afexYpzoi/09ClBUY3uxNWjWa6eVyZV0Dg7qO41LKtpEY9LBh0cIDg==
X-Gm-Gg: ASbGncv4GFmPGgEZv3d4kwWGlXcuhWmqBiFd98oXqhAHE3bfI+GYIhVajzcPDAzly09
	yZx0c5Plg+gSIU/6vZEsjd9Pth7O2fYeMBSoAvYbXS/WNknZh7OnKnI8FrfogKcB09AWykO1PKP
	ZEF22wpvsLTlkJ6eTtSOYzaEG/zFfO7ygvYTeOsvixptD4sJqlHAmH/Ra10O6TCBS9ZVDfUoRb4
	gPN8AFvgOrWvQfa1QMDeWUpwMFjWzQsjkGEiHRsrovAyCaMZd/VpRuAPJ8pkJZD6WuJvCKAnk04
	XU/hBUDvN1DVVmvtpP2mJ1v9lWcGG22PtHaGjg2WE6aIP3MUv5dm4sHZsgMtRH5r1CzCn8I3cBg
	muWCs+2qtmXeWVZORWFQ4ZRDXaw3jIy4U4+Tbpjuo02ks83h7pDr7n1h0yBcm11UoeAIpdBv7Lm
	F7+Dj7YysBYJcm
X-Google-Smtp-Source: AGHT+IHSHs3Uf4fEcoxs9nQIxmAqjxPXrWF8MoGcUkSqCTIcpVs6P8CncJuGvaUeMz4rYEc9GJY3hA==
X-Received: by 2002:a05:600c:5493:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45a246c5ec4mr70932405e9.22.1755516348416;
        Mon, 18 Aug 2025 04:25:48 -0700 (PDT)
Received: from localhost (2A0011100205B3242CE2DE6CDE8A6370.mobile.pool.telekom.hu. [2a00:1110:205:b324:2ce2:de6c:de8a:6370])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm149827145e9.17.2025.08.18.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:25:47 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:25:47 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>
Subject: Re: [PATCH 0/2] line-log: small fixes
Message-ID: <aKMNuxb3Q95RHok1@szeder.dev>
References: <20250818111310.1283932-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818111310.1283932-1-szeder.dev@gmail.com>

On Mon, Aug 18, 2025 at 01:13:08PM +0200, SZEDER Gábor wrote:
> On Thu, May 02, 2024 at 09:29:04PM +0300, Evgeni Chasnovski wrote:
> > Calling `git log` with several `-L` flags can result in an error.
> > 
> > Steps to reproduce (on Linux):
> > - Set up repo with a history:
> >     - `mkdir log-line-assert`
> >     - `cd log-line-assert`
> >     - `git init`
> >     - `echo "Line 1\nLine 2" > file`
> >     - `git add .`
> >     - `git commit -m 'Commit 1'`
> >     - `echo "Line 3\nLine 4\nLine 5" >> file`
> >     - `git add .`
> >     - `git commit -m 'Commit 2'`
> > - Execute the following command: `git log -L2,2:file -L4,4:file`
> > 
> > # What did you expect to happen? (Expected behavior)
> > 
> > Show log with evolution of lines 2 and 4.
> > 
> > # What happened instead? (Actual behavior)
> > 
> > An error with the following text:
> > 
> > ```
> > git: line-log.c:73: range_set_append: Assertion `rs->nr == 0 ||
> > rs->ranges[rs->nr-1].end <= a' failed.
> > zsh: IOT instruction (core dumped)  git log -L2,2:file -L4,4:file
> > ```
> 
> Thanks for reporting this issue!

The original bug report is at:

  https://public-inbox.org/git/CAP9Eqm1PsYBdjoVKgomJZe79_ZCOAtP4p7uvprUOerdjrcUjmQ@mail.gmail.com/

It's been quite a while since I last sent a patch to the list, and
apparently my send-email skills became somewhat rusty...

