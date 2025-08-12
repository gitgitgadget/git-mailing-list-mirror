Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCB2FABED
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017946; cv=none; b=Cnr42vfBJRPzEXCR66v+JyFxvceEluOEcOiS5vrqzdrjd477ky8GXV6Oln0VcpXk9LICU8+HA4dwt1zJ+cnAmb0YCPh3QZ0ix+JtLHtZ7hSspdt068OafrHQLcLDW2xHgESumWGxzueN2LVwHpUcxTeGZuXnRNGphcCUNPb+Loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017946; c=relaxed/simple;
	bh=QDTPNPcr1ni3Ix0D/qR6MIGmkC6UkyrCirbtKz9FWyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joiSTPpHGYB+9v4oH95x6Z6Sit5FTxceEJV50Fd+fNEElynV1beuw6MGgICczoHhAv2aDSV/zE2MW7/2qkcrdLmzJbCxKRiX6mZ0Al8BYBIeE8SWyik/FuudstlO42BmUMeAa8i5+pPK+cldl3/8BNj2fIMAIQ5ewyKjQJ2ppWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjYB3W1l; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjYB3W1l"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7430835ec28so3661647a34.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017944; x=1755622744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZR8tdyil+/TllDAsZLGe5BAbHokiM8nHDIIaGS7Me8=;
        b=mjYB3W1lHI4Ut71J1zycKIs3k51ZMLQkdGMzM4vx40k5BpiH+u25sIOsKui+YLE46/
         Q/SZ8ESxX5GcTnB/55Qrvd7ZPwAD+9QirkrbEKJRx9YCDFlqT5+qXOKbqL4B4FGcP5zr
         06c0ToXRNZAg0O4BFBTBPTVdud8fgv/HW3VWyRiWZk9f1RGwh+Hy1VNAKi4ZDTlVrQ+a
         YNmlLFjHCAMyGrIX4pU3x5/bbkdTfXc7nm6akepzk896K91pM2gFg5RiQZ954x+58QcT
         ycm4V+GkMQaDOR998wbiJelUd6Bf9dx+k5yv7Wt9lcYPGDLMR+/j//UhXlo8X3QROmj9
         E9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017944; x=1755622744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZR8tdyil+/TllDAsZLGe5BAbHokiM8nHDIIaGS7Me8=;
        b=dd0HuXkvCFG8bd7U6RtMBapQh7fwEISjsW63gs3zvmNgU74fTSnfXzaQlShVoyv6Ey
         aL4RMWkUcLF+4RKHrQUwnZR9wiUje3DTDJSi5gE8yf7RLdsVRO3rOlYqxmntXY2EMpyP
         BtalX64dfhyPtzOyyG0cR24YP6Nkjz9mlpIkQmgaGQ2ehKxy4Oe6TLIt2RZ4EtydpJVM
         5iWi+o1zNGknlrEsmyWtSOBo+dHoYwSxWP3RfSF4zgEbqRmw3lissliJrLt44sHmib7V
         jEB504Q2UZEz4E0DP/2qj7nTf6cuBbDeIzJxTsEd6WflZp0z3b4y9sPKjV+TbPD3bG+L
         drAg==
X-Gm-Message-State: AOJu0YxxpH1JqxqnkJpqL+Hq557r6UGafVUnz7vu34bwFuTpKF6YmvY0
	aoTPBOtslZwBuf6MF48WM9AMnO+n2wmZu+yfEhFTP1F3GxNef45p4pqe
X-Gm-Gg: ASbGncuf7WRM9/i60hssWLxG0c6+8jHb8v3BbWnkc0zeX9jczZrNjAD0Sxgg5TdDnJS
	DhcB0jxhNJSlm3VaBsQJEPv8xVm3yXzs5V0hKdkiniyXsGHHejU+kHkAfP8ou3Ni5jb4UoEPdlB
	XU0oY5rTx6D0dZ8SSOT01KdsFpqQmsOAfH8IkSCfFXWViDIoHe6t8j18P2vnUYXRq9uCZ2dkemB
	aYEk0zYxyGJF77YSg3u0j8mkjclO1dOy0/a7+0sIP4g55nhumLhEZKRD8XPTrmoz9Yc3IswgnVJ
	i67AUsLR5XTeK36YNoq96w/daFqkdTvtrXh8bPA9PWFys2lDutEUpNQsY5GKU4BnMsfU4k/yltN
	a/EGOuSranqmnoRo=
X-Google-Smtp-Source: AGHT+IHq7h3ntMo5Mlsy9+0x/j5cc9utwU5KWR9A8pkzAgtdcizvhc3uvvkN6yF/iQHA7/7PobowLw==
X-Received: by 2002:a05:6830:698b:b0:727:439c:d18b with SMTP id 46e09a7af769-743754773b5mr22225a34.15.1755017944178;
        Tue, 12 Aug 2025 09:59:04 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7436f85fdcesm328661a34.7.2025.08.12.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:59:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:59:03 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3 5/8] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Message-ID: <dlqh2lcmz4kh7pvwwwfj2cewaqqrdnmixfwxey7u6xxqjy35yx@apdcts2rtyc4>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-5-cf3b2267867e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-5-cf3b2267867e@pks.im>

On 25/08/12 11:54AM, Patrick Steinhardt wrote:
> The `reftable_stack_add()` function is a simple wrapper to lock the
> stack, add records to it via a callback and then commit the
> result. One problem with it though is that it doesn't accept any flags
> for creating the addition. This makes it impossible to automatically
> reload the stack in case it was modified before we managed to lock the
> stack.
> 
> Add a `flags` field to plug this gap and pass it through accordingly.
> For now this new flag won't be used by us, but it will be used by
> libgit2.

It looks like we will use the new `flags` field for
`reftable-stack-add()` later in the series though.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
