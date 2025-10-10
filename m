Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC753A7
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056964; cv=none; b=s9IKw3mm6xlYqOv9pKpoakxqYsPyzyF5H0uLc9T8iXpO40EEb3VOxqUMODblZ7RYt9jRp7Yq/BUrO5xKqWaJidimwd4eJshrlW8lYwrFM0r/gueAXpGDMocIcdWooRMeQvkdQkdbq14i7/HUHY4vbMNlMRiRpyz9WHSZRrW0o10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056964; c=relaxed/simple;
	bh=XxMfJiE0mPFyNWxFSP8+4zWEwvoZqSB858VE1cVRqi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQCJk1Urehl9ZAikBdthX7xYzGqREPWlXRhcFL9tNFIoaYghL86mIMKU0x7y7k2aNm/krdzBZC7h4Nl7DsLH0eBIb6LJ97l3SYBr9qUMWqtxlztwxnxBLvIai26SziENkTNLYEUJPqun8jnt84BUOT+dxeKYVYmmJTghE/NFHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ7Cdtv8; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ7Cdtv8"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43f86ddb3f4so664407b6e.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760056962; x=1760661762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFEjz24eWwYDOY9R1425InVvpSoh4N0AbpojPeDrw5c=;
        b=LQ7Cdtv8KElT1Y9DuQbBWYxAlaQdW3Cu2ITPnrLj/Q9a2FEhdcgZ6WNofgmo6Yulu7
         dyXetp+gmTwvJN+K3bbg+fRTNlb2YqEBA5jBPDmsudNdbQL44UeO/k7yS1Ev4O6l/w5Z
         a0xgnh0WNtanryZc0MGJRb/DxJmguRPihe2hU92hxGDFc7FccHuyOUVdaek+HfqNReJo
         inE30EOCPS4mNbzz0PFZYYBGj/1GNpUQOJzFXS97ytm8a9aE8krkEvXuaBYm5VsuXmjO
         xOryoHE0E9pW0Ih4edIk0enEKeOuKE8PcVc/8Kohvob5nuxfe3xnr0DNf5Er0X3uyTRk
         OILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760056962; x=1760661762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFEjz24eWwYDOY9R1425InVvpSoh4N0AbpojPeDrw5c=;
        b=XwHhxi1cu8dsaMcNEKcRkQOHfe/cXjgvttoCjZdmAZOreuEc/VyMtsrs9ScSgtJkZm
         ABToxBiQEeVrw4zomIolB5Bqht78LpjP4j7SWcxoaCGcdH+D+mAoCY2DsK7qN+1IutrT
         O+QxhAcomAKhcmx8Ec/Hd3pPTHxepEev1PReB60fisRnWdnh7lpCFl5fK8H9YnE6QQUy
         BcJ2t3WMerBoIJXzDNV5n0qhAgmX8mINGiIBSZ7BBEb+6px3XwN+yS6tafB266HGuxuF
         qi7DT6algsVmj8iAm6JJa9elcNnT0FUhg4udEixlI5DGgPePF8pZNp+emHvyMIi1s/Bz
         nfnQ==
X-Gm-Message-State: AOJu0YxrGY/E6f5pVU3dF2hveasklN0tllh05XZcFm3HgOpyzc3hufb7
	QUrRczGzAil1OdIWfUMvy3sOEsT8v22hN/XHeupOEYEug/PTQQKAr+BtKxIayg==
X-Gm-Gg: ASbGncut88cjJT48s0WNYcDzfRBxdNEmH+emQtmgJq7zxg4PxLKC7ki3v4e+iQBou7C
	9qAk2qzbNxiRvPSdXM/mwMwlqsjzax5rmX0SH//yWGORYn5V8Th/KGnjN8fFqyIXJESteWnPUhA
	B5/4M6xDrH8oEVtncIIRqtUQPcrvHsmHSmOQjBr+GkbPAU0TAPnUatR1FJjvUtbjuipYuqTTIKN
	dmLdds18yrsQalcXA3eUZGkwZQ08lXsqnP8q2atK9Wp7y8AuZx+2aNvsmpdpxuzbni4tE2919eT
	Tej/VqxEg4b0/3n5oMW+W2jNyvJrLEXghy0X/q3KV9MmwU+i0qJAE24Z1qUj02iRXXC+laUDvhf
	Oe50tHI608JAaRoffdwepN/w+aCPEWl9u6gZ4TomS
X-Google-Smtp-Source: AGHT+IEz73lNgFpVerhJT41pvBBcIErr9D+1B+r/Kuj8urVh330siUq2Ab2+334yA4XLNxXe/SzZnw==
X-Received: by 2002:a05:6808:189d:b0:439:b4fb:1d4f with SMTP id 5614622812f47-4417b2d7639mr4803653b6e.10.1760056961935;
        Thu, 09 Oct 2025 17:42:41 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-650181e723esm329961eaf.11.2025.10.09.17.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 17:42:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:42:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Message-ID: <gzjaa3nmv6s44dszregri7kcnfxg6optkycg2wggtib6bxvdgq@elearr6dishf>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-5-jltobler@gmail.com>
 <xmqqfrc797pk.fsf@gitster.g>
 <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>

On 25/10/09 05:09PM, Justin Tobler wrote:
> On 25/09/27 09:32AM, Junio C Hamano wrote:
> > With Devil's advocate hat on, a single command that gives a set of
> > stats that are "key" to a goal of a single use case may not be as
> > useful as a collection of commands, each of which gives stats on one
> > aspect of the repository, that can be combined to help you address
> > various different goals.
> 
> Good points. From my perspective, the benefit of having a single command
> here is to provide a simple means to generate a report of the general
> repository shape. In this context, "key stats" reflect certain
> charactistics about the repository that may be concerning performance
> wise for typical repository operations or just of interest in general.
> 
> One of the motivations here is to enable a user to easily generate such
> a report and be able to share it with others that may not have access to
> the underlying repository.
> 
> I think this still could leave room for more fine-grained commands that
> can surface more targeted information about a repository with other
> goals in mind in the future though.

Thinking about this some more, a single "stats" command is indeed rather
vauge. Furthermore, as Junio mentioned, there could be other aspects of
a repository that we want to display stats for in the future.

Since the goal of this command is to surface info about a repositories
structure, may we should instead call this command `git repo structure`?
Or something else along those lines that in more specific and related to
goal of the command?

-Justin
