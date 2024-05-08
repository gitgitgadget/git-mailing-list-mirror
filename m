Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4181AD0
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168937; cv=none; b=WiBCi9FoVeNmYhejqWpdGzCi70DqMyI2D7YYZecTSkuiz37VoqZ5zp5pRSl4TmjD05U1F8O8cbaQruJJqx8VTfLAOleNqzzk4VuaVrqlHwuk/OA+C+mK9bBPK3mMJi5xJev5xk+m9eHA09JfXpS66IP506+GwbGau02h6KsUBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168937; c=relaxed/simple;
	bh=fZYI23e1lGaCiDRYqaI250SnC4MoF2mr4cMnlMPcoHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLjW1/3EK42CrVUb/csJ7peujN6HCKPDpN+QXKmwV0Lv2MDWARCobIW7z8Z//NCqmxM+PoYSWmhRKK5qAjS/jpmgxK2RY9mdlEN7JW2INGTHpR53H+YjyVSm37u1V5cKMdQJuLMDSN6L83T12Hy4VOQVvTwE3d8Ff35jZ7MTfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLKlZo02; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLKlZo02"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36aff02f998so10678385ab.3
        for <git@vger.kernel.org>; Wed, 08 May 2024 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168935; x=1715773735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYmtmKl05bCl2n+9NxgP0y9da9p2OjOtB2mdMJrQqC8=;
        b=DLKlZo02BTdcXGr3UIgt9lVXLZasHytGvHFJDgBHnan5s889e7+xGReFjD7NQkq3o6
         NQna6mmunEXBsWijkgRuy4fFMp0n92yZDZMkLnN80HYBAijE8ihd76VKRibYp4fAKBkv
         FBzbJL67XqcRS1Nh75gVcOqxZxyO4KIvZlUWFe/3Zh7IN2dCX87ywOWqn7vCKOW7uit5
         ojazM5WQhlFC3lEH+7SM1f9nk5KI2R2HNxOn24H9m8pVDiOfPPQ1AFwb+So9cvLVk7H9
         xvg37D7uObTfoaSy4fnseZc4DFbLN88OGED49sqyeWfKL0K9hm9o3lvo45hZ7sB2HevC
         3XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168935; x=1715773735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYmtmKl05bCl2n+9NxgP0y9da9p2OjOtB2mdMJrQqC8=;
        b=xCLWzL19US39lSLkaP4tUwNNFpjxDZ0V0wyl9NtKOyOjTFcq3HTAAdviJszn5m+ecr
         Y6YbP8JvVGsO6heecYvk1Ez0tBwePsKWl5C0nyyv/NI0lv8m901D4Y8N0BrGGS1Q63x0
         SoBfARTSM8BY8el4FHxuPdp9t3eh1J5PutB/wxy36+v3IyQgtTgWB3kXkU9b8JaPQpKY
         gf+fhFNC536eGQ5fMat7Y7iMekyh4q+CXiRfSzYE6egxmfkNpFZGpKnhXbjnoUBb7v9C
         e/X+gJ7vfx1imIQq3OtrQ3njc2Q8VwTxMMUYQ6MD4KE+E3c+AF1A/eez8oOZnq+QdOi1
         mxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHCLeoRRwyM7yG1L9sKKXsE1IJ8f0fU6skukA89tQK6e5A7Mjde0d4W5nQ5qBdVY6jLPjCEJdHRwUzd83O5/xg75lz
X-Gm-Message-State: AOJu0YzGwhilAF/1BbQv90psJbwTreeWdV6PDl3YLoGr4rhUFlv3gc3M
	WqDCJ48koNhYpdJJbOGDZ6ZMa8USUkVQo3xLeXr7sqlJH+pYxspi
X-Google-Smtp-Source: AGHT+IGwUquDnSem5wSEFuQaoGHUs/IYwQFeifs7KWGySPtDYucAlOVH2EVdQh2fC2L3Bsyp1Okhiw==
X-Received: by 2002:a05:6e02:18c9:b0:36b:80d:b930 with SMTP id e9e14a558f8ab-36caed5a227mr25122365ab.26.1715168934711;
        Wed, 08 May 2024 04:48:54 -0700 (PDT)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id e14-20020a63744e000000b005f77433b4f9sm11404219pgn.81.2024.05.08.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:48:54 -0700 (PDT)
Date: Wed, 8 May 2024 19:48:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] Welcoming our 2024 contributors and thanking our
 applicants
Message-ID: <Zjtmo20z6APPcKyb@ArchLinux>
References: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>

On Wed, May 08, 2024 at 09:31:32AM +0530, Kaartic Sivaraam wrote:
> Hello all,
> 
> As you may be aware, the results for GSoC 2024 have been officially
> announced[1]. We have 3 contributors contributing to Git this year[2]. They
> are as follows:
> 
> 
>   - Chandra Pratap
> 
>     Project: Move and improve reftable tests in the unit
>              testing framework
>     Mentors: Christian Couder and Patrick Steinhardt
> 
> 
>   - Ghanshyam Thakkar
> 
>     Project: Move existing tests to a unit testing framework
>     Mentors: Christian Couder and Kaartic Sivaraam
> 
> 
>   - Jialuo She
> 
>     Project: Implement consistency check for refs
>     Mentors: Patrick Steinhardt and Karthik Nayak
> 
> 
> Let us welcome them and wish them a good summer of contributing to Git via
> GSoC!
> 

Thanks, I have already created the blog post which would record the
journey of the project. For everyone who is interested, you can follow
the blogpost for updates about "Implement consistency check for refs"

  https://luolibrary.com/categories/GSoC-2024/

Thanks for my mentors and community for choosing me. I will try my best
to finish the project.

> Thank you to all the contibutors who applied to Git this year! It was tough
> to choose from multiple potential contributors who all were good in their
> own respect. Hoping to see you around continuing your contributions to the
> Git community in some way :-)
> 
> 
> [[ References ]]
> 
> [1]: https://opensource.googleblog.com/2024/05/google-summer-of-code-2024-accepted-contributors-announced.html
> [2]: https://summerofcode.withgoogle.com/programs/2024/organizations/git
> 
> 
> --
> Sivaraam
