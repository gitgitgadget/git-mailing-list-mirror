Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52482367B0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106898; cv=none; b=o/ZWITJHVUybHGUkbhRrRrRnLYuh7ew67oLdceNpLTt8mXQUDs/wMyELSbKsHHV5CLKUCwMmFLhZLuBYZxVh4UA6GamxTCgCjKSS5tQabXgR3qPUn1OYNrglfWw+YRsKC/fXOtv3EaCyhUMMAflTijI6WxmFlND841fljrmhdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106898; c=relaxed/simple;
	bh=q/IxXNJXUZuj1UmHM5ci907JtuZGhCW6hajVSkbe7pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r75rDB7M0oREucsUZ2w4+bqtajPbHJkF7/aGRkTVrbRgw6siaIxmVYvkKTyENdvvk0uODrM6inm6vgDmypi6Lxeqoz2q6qeibqAGuhXSCJTnGVMm1bjhh0pkEe9wjYr61ny5LNKLKbBveisKcR0eHbSl3IDixkn0XbMrU0NbsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT1pPdKX; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT1pPdKX"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7bdfbc6ba5cso869462a34.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760106896; x=1760711696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sLGdb8EurxsGHxUm3MckrqGjSirs/4RmqcjL5lHlJU=;
        b=RT1pPdKXJ0x4w+uWzO5KQSGJscGhrzKvdXT1J6UI5MShlldghMQahiWDUZgYsmJ+jM
         BpFDSynzaC/EwcofOGgmeL90P0aoEHNeXeUdaw0uvVFlHCfYtSy3T7i7PUlmstiTEdSb
         eii9JzR/1sUPvyLDv6UTDwbeyl8gFe8fMr59ffIer14AUZbV93O4zTnvaTn17pERFdI1
         /hXHYWK/59tNNlqILjGg4foDrCkptaFBrVE6BxCbnydNg8wWI5nwIzBaVQGnWuhYx1Pa
         wBL5KnMCnnERs6VUP+GqQCeOYhbvNsda6MbECGaMXx9m6jAu8Q0Nep4Qj3lKnv1ggMrl
         pOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106896; x=1760711696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sLGdb8EurxsGHxUm3MckrqGjSirs/4RmqcjL5lHlJU=;
        b=GhWFmnEcW6Kx67e9Ll4ebv3o15PH5frwH7O7TCey3buDeEgnaUMMuWI9PoR/84Cxf6
         wAJBgefkVW0PpQI2AyqFWhi4S/GaFTZhAEmGLwWS2Lp8hJRtE6DtbDY6XQrwOml6kYaD
         g/hi0H+vcVPQIyxr0eSiWqWJ/JwvN33ae0RQFiXGIM7iPLRaDRMTseHoubg31/qlZ/xn
         qNvaO06t3ymD+wTH9jtPnfV0XN7h4LceydzetsS0OsnL0Z4VwkcTtueV3UfWOtnrDGLs
         WR/cPtjl5N4Z9JI7Ohkka/lv/B0Msocr95bap+kuK0KOsiiFhh0KjuI2mcc+ikwFTT3R
         k2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUXzVscWz1tCvmDv8rNTBVChpEDfMQw79s1vkiEiWXTFeco39LBXx/pXTFlP1v0hamxcjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8teZDYl4wemFb7pzrNYlfyEnI+fgXSuCdy3xRW4LoIcdzu0IL
	MZBmSiNBz4sf5/e2LGmcanq5ciiCjt0hR7PmkbtqL9a+ykKK4St2id56
X-Gm-Gg: ASbGncv5uF+1cwNktD1lj7j8Q/Q1lbKulrxzPjQ9b8gu2Qb+CJl0yclzCvV8lITuK14
	pR76yZQY2KNLeJDUm5zvEjAlFv7ZFK0rrqF/AsLZ2Z+nZ1OSke2Ifp3k4nfEfLoEbJPIR604Moq
	AshSNuw8KD0SYHwEUkR0b1tLySj9lkXWnrAj37eC1UkEdRjzQOvZZqGx4/hehf39tm2DdV4ypdB
	6CpvrFZ22KRu85pVHk0+njMpzXp0yZaoS/5SDJ5Cn7PhE+R66VLMgtDCHuungY4TPrV9ujV1jm9
	nEXRK8ay9CcfmlDcs9VgmKJ1wDuONMWqh2nbh/0BKh2mcYB78RN3IfvRWafXUNPrx5djEtjTGeW
	lPhtN/VXEVE2daEmW2NSUPd5s9AHzAQ1rG54=
X-Google-Smtp-Source: AGHT+IHarfXSI7CaIIWLFuYd6vs0KG1frb70znx2Q/yiExCN31JCcLYHwcSt2Q9Id3G7e1v+r5l5Aw==
X-Received: by 2002:a05:6830:2aa5:b0:747:323a:67b9 with SMTP id 46e09a7af769-7c0df7da742mr7120150a34.32.1760106895639;
        Fri, 10 Oct 2025 07:34:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f8f18f29sm896643a34.0.2025.10.10.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:34:54 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:34:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	karthik.188@gmail.com, sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Message-ID: <lnk4zvu5zgokd3p5lxnl2nwbqu3fi3yer753tr2f2jaknrtb3h@fcbjvvu6irtc>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-5-jltobler@gmail.com>
 <xmqqfrc797pk.fsf@gitster.g>
 <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>
 <gzjaa3nmv6s44dszregri7kcnfxg6optkycg2wggtib6bxvdgq@elearr6dishf>
 <aOithKtHf_U9S_m3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOithKtHf_U9S_m3@pks.im>

On 25/10/10 08:53AM, Patrick Steinhardt wrote:
> On Thu, Oct 09, 2025 at 07:42:40PM -0500, Justin Tobler wrote:
> > Thinking about this some more, a single "stats" command is indeed rather
> > vauge. Furthermore, as Junio mentioned, there could be other aspects of
> > a repository that we want to display stats for in the future.
> > 
> > Since the goal of this command is to surface info about a repositories
> > structure, may we should instead call this command `git repo structure`?
> > Or something else along those lines that in more specific and related to
> > goal of the command?
> 
> Some alternatives that come to my mind:
> 
>   - inspect
>   - analyze
>   - scan
>   - survey
>   - measure
> 
> I don't have any specific preference. What I like though is that those
> are verbs, which makes it a bit more natural to use them.

If we want the theme of this command to be the repository's
structure/shape and have a name that matches this scope, I'm not sure
any of the above examples would move us closer to that. Aligning the
command name to its scope is beneficial if we forsee the potential to
introduce additional subcommands for git-repo(1) that target other
aspects of a repository.

From my perspective, the main question is: should git-repo-stats be a
generic command that can eventual provides all sorts of different stats?
Or should it stick to repository structure/shape information? I think
I'm currently leaning towards the latter.

-Justin
