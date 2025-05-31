Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42F4C92
	for <git@vger.kernel.org>; Sat, 31 May 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748653424; cv=none; b=niBLMgK/o2xR9rQETT1ZW/xr04UdGg5Cel72AqtZ4IpJOzTaS6H1madrIZ2M9x+O8RPCaOe4b66ZawaudskMFcOTnjs5nNnZhyJubH+ZnpTOiaLCsq2RCpDFipu9t6YxTnhdXUXDHsXj+KrOpar5JvS76bECOwHkOay3zzJT2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748653424; c=relaxed/simple;
	bh=WW4BYXxYL2Tvzg+jHd3yknyKINSXUe2+YrFwU00SMB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERlwkop2oPA14rbqrOXuIlhdfhHuEPlvRYGAT6GqvaMmjt30WVFmW7clJ/HjV+HoPIBfoQezUZfVIOUk0yAmMyBXGfCotuctoJgu6/e8FvbFrJGjFS2E1TJB39aYCD9I3/V7rh2CN4B2Kbr0RB7hMWiQrFh79vw0kuzn8Tsd8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7mFpI2W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7mFpI2W"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2930073b3a.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748653422; x=1749258222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2c7nSi+vNDxN1iPw3dg8RkG/9s+UkDIP3E+U0VT/yI=;
        b=E7mFpI2WrqjhRk02IYvL0g4aV0JvgL1rEQxXN0JElYDFws6JRK8t1e/8/Ukqt0RRVK
         AQbfzWz8PctM2UcmHSzTBAMC7S0vB6sJxQiJ2Y5PREDZ7Hsjl0neqTaYlr2kchaEUXrh
         3DmCdq9S2AXnW/Ms3AFAPcQomuj6tI46UtDB6mwgxsnd5M6ZDqRQBQVMs4PdOmJy7SJ0
         //N0Qur1G90WYtGNWTvL26IaaL0A8LbW5Ijr4nR2R+FbHs5CZ4hBb5xaiIR+Gb20GjPz
         +KoSNNDGDOBuCuzP0Pw7va/3+ePChW23feXEYXdEduPaP9Kbc7i2EjuhtuS8q1GCzYWl
         +N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748653422; x=1749258222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2c7nSi+vNDxN1iPw3dg8RkG/9s+UkDIP3E+U0VT/yI=;
        b=ZMewpLN1IKF7yuVlqJOA8ouZ1KznRj2j41O7yaOsR8mMBm3PepTPSR4WP2SWV+0XbP
         j25ReOm9VPdYdW59gwtzd6lxDiGpQDVSFplTWMlG1alyVKubHhTvZu0XoNfjsXAZDIFD
         u4y57HFl7bCsrphSul5AB+Tbgv4WIlV/XfLtxqY2yvZ+W1AcN5QVl2PtJ3ktdyoBYapy
         4YAo6+YLKUVSyyfw0gshP6s5E+yTVHSUfrXLLKmdHjLmnvR3P90ebVMZ+5Aw+Cek5Eme
         Go620pz0kThMQJS3uRcJ16rMY215ZwBD3PDAnsOwzQys554F/yP6yGZ4rIRoG6jRh04n
         fLAA==
X-Forwarded-Encrypted: i=1; AJvYcCUL0eNJy0iTNVSRVdFuPRPab9Ztz2QBUHm1RG2E30oKnoz+FMC/jzNohA1a2cL0bXb9Gy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKL/fA6SsNVW9TW3Cp7UGEZkBz2Xc73Lqt5CHKdT4fF30Ws/+
	YKPpDH8Z1tSCr5CpMLjWY4sx3ejYcpOO/SCNbHxP8Cv3BLuSzZJX0kJz
X-Gm-Gg: ASbGncsS8pmsWjsJ+R1ElkYD9D74gx9X3IVBHXsghfrYChswzdoigbZVhB+G9mTiWLE
	w5YbcS0YtmqhGuUHhg+lgIEqlM6Q7bsAL5PZR5ovNnqI+6J3hBEeNyEtPvpiaVEDS0VlpvgcR+4
	FXgLoNzguX6n3ZqJReaiYQPp/BGVXVAzTAlchZEFhTCR+UCGz3URNvIu1A9S1wiR5uJM3WKd8AK
	dk9M0lQh0jVNK+4ut1Qh/+FAuCrkz6qC1rcKkOtMwAPidFc9cH0eRkEOlnxGp4SXOY5CHfCiyQG
	GRamW9A7djY1IMHH9ZevxBXTh3zjMMV00MOsgXb5oMkmhh0=
X-Google-Smtp-Source: AGHT+IHWI2Eadt/JVim3LdDDXUgXbQs/RYgPaSU+KZTQFAxl9MhzE0yyKjXcPgwtL0Recex/LORoEQ==
X-Received: by 2002:a05:6a00:14c2:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-747d18210f0mr665477b3a.5.1748653422405;
        Fri, 30 May 2025 18:03:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afed34fdsm3627911b3a.75.2025.05.30.18.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 18:03:41 -0700 (PDT)
Date: Sat, 31 May 2025 09:03:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [BUG] refs: verify does not work if there are v2.43.0 or older
 worktrees w/o wt. refs
Message-ID: <aDpVd8J-TfhvTyA3@ArchLinux>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <CAPig+cQiw03qfwwE9Md+LdKeS-6BGx0M1+0YYDUDXO9UPVo+wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQiw03qfwwE9Md+LdKeS-6BGx0M1+0YYDUDXO9UPVo+wg@mail.gmail.com>

On Fri, May 30, 2025 at 06:23:25PM -0400, Eric Sunshine wrote:
> On Fri, May 30, 2025 at 3:00 PM <kristofferhaugsbakk@fastmail.com> wrote:
> > git-refs-verify(1) checks worktree refs since v2.47.0-111-g7c78d819e6a
> > (ref: support multiple worktrees check for refs, 2024-11-20).  This
> > causes the command to always exit with code `255` and stderr output
> > lines for each worktree created on v2.43.0 or older that does not have
> > worktree refs:
> >
> >     error: cannot open directory .git/worktrees/<worktree name>/refs: No such file or directory
> 
> Interesting. I didn't follow the topic which introduced 7c78d819e6
> (ref: support multiple worktrees check for refs, 2024-11-20), but I
> can confirm that this is a problem.
> 

Yes, I didn't realize about this. Thank Kristoffer for reporting this
issue and you for confirming this. I would write a patch today to fix
this issue. And hope that this fix would land in this release.

> > This is apparently caused by worktrees created on Git v2.43.0 or older.
> > Apparently these worktrees don’t have this directory unless there exist
> > worktree refs:
> >
> >     .git/worktrees/<worktree name>/refs
> 
> Indeed, the "refs" subdirectory was not present by default in older
> Git versions. Were you able to track down which commit is responsible
> for that directory getting created automatically when the worktree
> gets created?
> 

I find out that; in 8f4c00de95 (builtin/worktree: create refdb via ref
backend, 2024-01-08)
