Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDD1C8633
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604643; cv=none; b=QhvNGU9nCmYkXgXeKgysO1N2NadA6AuK7jaPtk22h7vq7vBXn85vxNLCyay/eg2a+a+9iN+OanmDF0F+dJQW4oTv91jk68ldUF/rHUVdwTvipnqs6Tv6QwvBv9xeO8cpPRThTx0N4+NEZzS4nTA9zCNwyOXWsCiV+QdEFaHus+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604643; c=relaxed/simple;
	bh=N9NgjcIhiihfcExtXcA+fn2I6O7L0LGkKKNe9Nuamxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omjMtR0uVR2SGMxuWDe6cPgzm23tFwG7wSlYc4ncNZOh/yfVAqsNSS9TyzFd/3T7KlnKezi5+zawOi1jK4pugIncSD6L+npn3QakGEr9Ttv/KRR4ddUb66jCVHm6JisXxm5crevgrunpz/jebWE03rHeJjlTO23iCiPIEOy3SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VTTZAcE6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VTTZAcE6"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e52571cacfso6229445ab.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754604641; x=1755209441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1anu3gCK1r0iw/roKIP3cwHtxM5d35WgGnFze7b3s8=;
        b=VTTZAcE6mfB/FkvgQ3/KWZsZrife7NjQB6zZOQhW/48Hw1JjKmfFNfnbIdoteDeJMs
         wV8cLr5/EjJMtYC/YdZ8wP2kXTZ2L9Zd1dihD/Bhn6iPAPMT5+h7KNg1PrS2i5Zpm1Yq
         Lj9AgaP3EZUIGcjkq+uf3DIOqJAqGOPR+v5FptzlufXaajxn4/li3hKAofjoWSQ5b5cZ
         TptQ0mnlLbLM85H0oTXmcIdUqXeK/QkmzTinR36jJifOwoj/uOTEBYxLUJlhIkbdA+Bd
         dEWOmzZgpl7NaInXVwAW9RJkAkdkqsqL23GBAJG862jG4LHL8vUS6UbsFi8oUPiNWc4c
         hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604641; x=1755209441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1anu3gCK1r0iw/roKIP3cwHtxM5d35WgGnFze7b3s8=;
        b=qWD7a51pJ9eclclhP94hqNgmz9eaovi9o7WpxfDkvU/VbQiKVDET/Jj4SUjMPLTwQ5
         oYsm6lPASw005C0pOdqyFhypLpEJy7pBomUbQLaPLP3eTdwlPROJ/UXNXaBmv8qBqQH0
         ckYWhvEhdm38YeCbXmY+oqMivD74TpfXcA2AO6s/hWc5CBp7Vj14QMRo86HdXHhI8asU
         SVmkMlI0dlwV++PipxNK75U7MeqnZtb1ybpRB22PhyJSMPMGiVPByYm6H1/aJ9YJRJcM
         OggMebnnH1MJap0wPD1iBi/YW5hRKCU3t+k4eT9PrRkIzYS1bp9h/heFVTMuqTYE1x92
         jmJg==
X-Gm-Message-State: AOJu0YzU4xNB3kDuNu5hzZV1SN7yu/wsLCYz8lhx1r0Dzpra6G6fVtrX
	WzVjJLtiDyn+fMqFspmZ/T7FluOAOM1mIKq1mn1psi6DaAFvEf5KI3ErOUzbxEbsn5CWc3umufX
	Bbasu
X-Gm-Gg: ASbGnctlnko9ZbtaEjYacLvKBU47eLKYQtqK1P8N58Wdk/p8xWIyOjdQla6KmOOfRuP
	XM2BTAW4+EpF/oRfC1ZMNuTY1h/l8qNUPBI3+GcdU3byHsIbKjgLzEaZ4Dbdjc1i2w8pvSIKG5k
	8kYKQwpMroVq5bTHwUkASww2CFVoGYRQfn8JBE+VkRsLD6GUED05jlfBMQlZsejvxRDzPNuU0pb
	9IBt1oHu6WQ/HXw3AlTP1m43iWGVe1hyx1BVrmu9xYDlbXTGR9eRQC95hNn/DwoMOTYK9hJc5hW
	DVo837+qt9lUVM0i9ESyB5XomkQ/kBy8xCXfb/gFbzRSGW/YCZFYsP3t4NKJh9pf8tfpaaWwX69
	dosMAvLziLKEvB/kQH5e2epR65C6nfuEV34Xrvd3HqGrs+T3E2ThWsMjDm1JFvCCsvwOW0w==
X-Google-Smtp-Source: AGHT+IFbiK9jFK8Q6y6FkMvVQ01h+HW6thvMDWdJzWu60445LESb4qoedBWz/Zq5CoAZyG1dYxHWhg==
X-Received: by 2002:a05:6e02:1687:b0:3e3:fd04:5768 with SMTP id e9e14a558f8ab-3e5330b5bcdmr14625235ab.5.1754604641348;
        Thu, 07 Aug 2025 15:10:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae9bd3286sm71842173.64.2025.08.07.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:10:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:10:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 1/9] odb: store locality in object database sources
Message-ID: <aJUkX0SRmBWLS6rQ@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-1-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-1-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:51AM +0200, Patrick Steinhardt wrote:
> Object database sources are classified either as:
>
>   - Local, which means that the source is the repository's primary
>     source. This is typically ".git/objects".
>
>   - Non-local, which is everything else. Most importantly this includes
>     alternates and quarantine directories.
>
> This locality is often computed ad-hoc by checking whether a given
> object source is the first one. This works, but it is quite roundabout.
>
> Refactor the code so that we store locality when creating the sources in
> the first place. This makes it both more accessible and robust.

Looking good. The only caller here is packfile.c::prepare_packed_git(),
which passes local when "source == r->objects->sources". Assuming that
->local is faithfully set to true in that case, this change looks good
to me.

Thanks,
Taylor
