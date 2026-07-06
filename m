Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08083A9013
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376406; cv=none; b=k+b9qpRvAbzBqWsee5tFM6qjdMa0IYYT76g1C2mpDLYkGHJG1YxLj+F3aat8Jnp07zh8BwUek6OX/3lKusMe8ZlcxYSODYfHjD/JJZCMJGtjH3Q3RrBC8RIloTwsEEv2WvX9KUsyC55Tj6Orsigbgu9b65GMsnCJPHgBRX09z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376406; c=relaxed/simple;
	bh=zrSZ8ISDHNl3SK0aQUyhVFOFS+85Xccul5Xc1aj9Etw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIFW3XsQACGtEjH8DyArjxwGzevVO+LKbsGTRjR44sCDhQukZZdagxbNT2zLLBhxXqC9KY8s2AXLh9sU6h7Iu8v8+v2QjfcTL/W+HSPoeNWjQfDCBJUz5EKAYGsMrOV382WACrVf+a2DebJG5SZoFwu5XPRd4D/2MdaZL83yIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgJeqh9Q; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgJeqh9Q"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-448cf99c133so21372fac.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376404; x=1783981204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLCwSc3K2XNvdlif3HKKYYNzywvUdhUzfqsScCtACxg=;
        b=UgJeqh9Q5IYBt4AaWUIGE95p+CF8STMHHWf0MHuwN+JMBYiP8C5TWHFs4ZdXsGt27w
         GahJAoK60C0jXwQ3N6jn3UF9Hk863g4FE53hcY2E+Ba4arm66ZajCIUAdki11rU9qgXD
         lZf7PkUx1XUG3/FZHolR8eUZECxygAdSxsWD7SD3OVRALrNn0RdPzEjHWzQX0mI0yatD
         26RVe/QjIvVh8ZDy9I07tToYhh9ki2PS9GUgdu7GcSRKEB1JnzN4pVxYQaWna5aT0QKf
         J4v81edNj9zUl/1ADJfTrDozMQf12O7B8e83h7F3ZJ4XH5MTVGbeOnJrZE6/ioZXScQQ
         goQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376404; x=1783981204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLCwSc3K2XNvdlif3HKKYYNzywvUdhUzfqsScCtACxg=;
        b=S7P6w9qPOe/BAgxp4hhH7vEO6NPYyjhM7VajO9bcQj4MgWCJVIoOkCLEF0U8vGjmM3
         1J6DZfj5ISyqFTEUpIAZK4xL3ZeFkZ6qZKDIVUe4IDjpO6qmZCpYqWIQX1k5MetxuAHN
         hDsuWmCAWnQY7+DsZJspdaZypva53d5w4avCR0hjRv72bDxMqdRXY8FjHqCM1UYStTWd
         g/O13DAS+yIujER5XkXwRJHqoxndNhZ9oWs0exCCzVILdWm1THNlSC0bp28kcUANUpRp
         w/F+sUuI2DPrB/jBWPAzWhQAavBt4Ha++MYtnBoKQ2pbgcya5pHJkGEq2edKY5YZIvtO
         7bLA==
X-Gm-Message-State: AOJu0Yxu4MUYHZ1gDB9PmoQFAxzDefCjjjp8z42J6/tKMdeQSzVkL7tj
	qHLO17tH2n9Of1oB9Ufw3Ka0mCs5KB5Jjhakq+nBx85JKjbnGc092tKKHt4Twg==
X-Gm-Gg: AfdE7cnBlc1gcTDmY8smCyL7RpWvu4a5yfgbLKUjnlXbqbe6ObOeQL/EGCiLL8qSj5r
	QYkFtvVPXxc320kT942ELPBDpyt9f/1ZxktXNmX9wATRhIwxtSO4tuL/7lkE9ur8X4QRU8OO0En
	FMKK096FSiWyeR0Y6hi1Zp4J+leOjDMHjPWgStyASCpByPJlbo0/VMX2Vvcpzv5xUsJpE+r/HGG
	B1HzDr6xMurdfRBIfuyKC9Mm6QqXgTlc58/FRA7bPi4asDL5M4JxWDsdWHEPyShq6QoAIN159V+
	aVIQxLKonQP5/6uteslfo7Nk1fBN52h1GF2gCTYUJIWFk/T9TBuKW0mrkFE1cenZPUdpXuR2nBo
	sksHYe4KZRwFZi2/rx/8gaCN3ZtHBd2yNRBuIJgBLRQOMwc9JPQINmFnRgAbVH/t3ZpR8X7Fntm
	hDtqtaJw==
X-Received: by 2002:a05:6871:408a:b0:448:6cdd:3bfd with SMTP id 586e51a60fabf-451189138ffmr134504fac.10.1783376403628;
        Mon, 06 Jul 2026 15:20:03 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb5db92dsm11618483fac.13.2026.07.06.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:20:03 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:19:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] setup: introduce explicit repository discovery
Message-ID: <akwocdrzeu0xBLQZ@denethor>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
 <20260630-pks-setup-split-discovery-and-setup-v1-5-13864eb5a032@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-5-13864eb5a032@pks.im>

On 26/06/30 01:47PM, Patrick Steinhardt wrote:
> When setting up the global repository we intermix repository discovery
> and repository configuration: we repeatedly call `set_git_work_tree()`
> and `apply_and_export_relative_gitdir()` until we're happy with the
> result. The result of this is then a partially-configured repository
> that we use for further setup.
> 
> This process is quite hard to follow, as it's never quite clear which
> parts of the repository have been configured already and which haven't.
> Furthermore, it means that the repository configuration is distributed
> across many different places instead of having it neatly contained in a
> single location. Ultimately, this is the reason that we cannot use a
> central function like `repo_init()`.
> 
> Refactor the logic so that we stop partially-configuring a repository
> and instead populate a new `struct repo_discovery`. This allow us to
> essentially split repository setup into two phases:
> 
>   - The first phase only figures out parameters required to configure
>     the repository.
> 
>   - The second phase then takes these parameters and applies them to the
>     repository.

Ok so `struct repo_discovery` is just an intermediate structure to store
all the repository configuration so we can apply it all at once. Makes
sense.

> Like this, we'll never end up with a partially-configured repository and
> can eventually extend `repo_init()` to handle the full initialization
> for us.

So IIUC the expectation here would be for all configuration of the
repository to happen prior to it being applied? Would it be a bug to
attempt to apply configuration to a repository more than once? 

Overall, I like the direction of this patch so far :)

-Justin
