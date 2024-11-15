Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F818FC91
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669003; cv=none; b=niHGaO105RjTZymeK9DAzutAAWnv2yltBPpAJHDvCyyild/6fR7k9jVpKHsSaaR6JUAw3+tnXJtUykhv5BsDbpoS0AGX5cKz41claCRrlo4VXbhtDOkLtxs7valZWiovnTs8JUXb40Z0CRrgUyBSDsUSpFiADQq9Lo+kIYhXEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669003; c=relaxed/simple;
	bh=XASPCJAYmp6EiaWQNRlMwQG1EIGaUNMnCrExPPjbAI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEDqkiEQGvo+R+pJelB7lMutTz+hVrSSiTd/Aq5VkRtR5i/iQVlQx5dSkZfUbd3uQuoQmko7LgGYZFMYsnj1XDlQ8VUcpIWc6DphAH8owE0esY5xblVB+peMmQxS4LvsG2mKik9Mp8ymJC6htyMPhwkxrjHP67qJWe9OHX2Qk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJDRegOR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJDRegOR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so1323623a91.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731669000; x=1732273800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2LHvU+5r8cuGfagQx0b3d/HIdF0IGmrdr25X+OPGt8=;
        b=MJDRegORZBLK84vrVJ0O59mWqh5jilpWOOHCzfGlARJ0L7KeZumjHxrXRcp/BK9tTP
         glMs0HaZhNDFkMQ8W6S/WzarSsHA96veimYsrgeovOrfDOHwFs0XtfKx7h8c8Um2/HKY
         zOZipsF9zBohdhb6vgPY5ygp6Q92Ge7JLuyC8+anEFXC91XGPU+nbKSyXdYYiFDkJ7lA
         C6Girz3G7hCg0QINiMv9R05tnDAADVQO79Zv1QMHzgYsA4QKMss/9lGVhpFVpjLyPwHt
         LverBVnd+1BhNCjNVLEWvgvitC8k3iMiFT7pzp4yBtQjXtqJQ25uyu77oosAcXy80SmO
         b/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731669000; x=1732273800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2LHvU+5r8cuGfagQx0b3d/HIdF0IGmrdr25X+OPGt8=;
        b=YlqSh8noWSyvPt1NnPaTX9hYFcZNPcAlpR40BCPU/iGiUUI0xFUec0bTuiwRygks+g
         OavM9AlUCGlFT9tUtk2etcmSuQff2Igy94P3C6pVO3jYJJ+84n5ZRyVvt6TzW1S6Xwa3
         dSv7gwqTB0pH4qd8QgKgZZ1QNV/dySZ0ZdzqEfyQqGX4GCTs8SDy1Zzdxe09G4FgSpRh
         oe2VyYxquluMPN+4U2/LTPsZ5YvGyXHTKAeRiZ7fi9FOF/0G2qohgyMQ/WB7tV7zFCMM
         cd4xYd4wedhSWJmTgddNh0Cmw2CB8UZffLQ7CGzxYcKmU3SHupCOlH+XxQjuJVSjMEwh
         b8jQ==
X-Gm-Message-State: AOJu0Yxmn4+TlF2zLqLRpTQ2LePB71SwONEXa+joXpJnT2/uXDExwaMF
	pSvSR6lIbFU8Z5StrYvapcpKk8IhHioxnIVIfPif+nugqSG2iYXgdaF3ww==
X-Google-Smtp-Source: AGHT+IH4RGizFYmPPdJRHVsLinZfoKNCmjzwje1iCLjG4q+5EGuteDXdtGbdbAqKFNqPV+kkEMzFAg==
X-Received: by 2002:a17:90b:1bcf:b0:2d8:da35:b4d6 with SMTP id 98e67ed59e1d1-2ea154e4f51mr2721855a91.14.1731669000410;
        Fri, 15 Nov 2024 03:10:00 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06fbc909sm2594000a91.53.2024.11.15.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:09:59 -0800 (PST)
Date: Fri, 15 Nov 2024 19:10:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/9] add ref content check for files backend
Message-ID: <ZzcsC6MHi-BPyXLK@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
 <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

On Fri, Nov 15, 2024 at 12:51:49AM +0800, shejialuo wrote:
> Hi all:
> 
> This new version solves the following problem:
> 
> 1. when reading the content of the ref file, we do not use
> "fsck_report_ref" function. It's not suitable.
> 2. Add a new test for symlink worktree test in the last patch. After
> writing the tets, find a bug. Fix the bug described below.
> 
> Because we have introduced the check for worktrees, we should not use
> "ref_store->gitdir", instead we need to use "ref_store->repo->gitdir" to
> get the main worktree "gitdir". After fixing this, the test is passed.
> 
> Thank Patrick to remind me about this. I forgot to add test thus making
> mistakes.
> 
> Thanks,
> Jialuo

I'd like to wait for couple of days for more reviews and comments from
Junio and Karthik.

