Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902048;
	b=cQReL/SAZ7sijf9xuPkHp1VXRUmAG+S18UaysJQMkPk+c4JVKs2la7eoBOyiDFnS73B+
	 Hjyu4OVdBUQVjyp43OcUZnRvZS8R9zQFULRk9GIMqrDbU53e5Luo51a6NPWTyduxSrzZm
	 ADiCHDfraC9EtPy79avu7XzWQ7A1CgxzvUtGcO66gHHyWMJs70oHNWEQN07rkEmxt51XE
	 xO2wbChj2GlxFEj68od1U+EewTmCdu9Ig5ORmkGg3yOekiypDAcdtKyUJ9WnsxZEu3i5T
	 TeEYbB3FDF8wUzy1TBko/J9VQvsh99J0E3IHTTBGam0UKHmwK5NdR9+JainV2ZIVjJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-PGP-Key;
	bh=6/I33OUa1U8xDIJXKnhY8phWZhcDw98890p1Yjm2kAE=;
	b=Cr3lRCpr8++6RsjrChBVEei88OUITVmEO2o0IJdY8+ePf8xcsVeZ9/794BUkeo8noEVX
	 8jV7PI2Egz4U68Rv/ak9mbHuRapMQFHhLgCsY2C5BcAv4pEGu1Vcz/RROvjIxxT9MpORS
	 K3aMkpBk2TAIfJ61f2l3urCqKhfYTUndHd7LwaaOPuNPJbTltlcMJVf0p5cJJ/Jbkodfi
	 y2Ey/kwLJWkrkriVnV4/+qyOeDV7idr6eQKNqbm1BU9uG4EpGQoGT3ULS1Du+NYXnu6WH
	 eyqm2ircWE04xXIThog9irZbqqRvMIM19Bi1SPik5TSKJB3wlb4TOqRrF8nMjqbo2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TrSA4+KH;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44A606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC44A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TrSA4+KH
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f14642adb4so1112150b6e.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 10:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20260707.gappssmtp.com; s=20260707; t=1793902047; x=1794506847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6/I33OUa1U8xDIJXKnhY8phWZhcDw98890p1Yjm2kAE=;
        b=TrSA4+KHaz7/FFw6JD7wqaxlwwR4Lz55Ht5DYlD58JM95grOiV2MVZXqw1cx24hP7J
         t4aJXLS6tjJITOWwDC12e1xTnXGLsdhc2Co86nEozyhWRMFzEDmWlOaooiVmRuq+73Kw
         KCmonJjYb+tYrNSeHT8Ak1NSHxqvGPrG/RNLX40arTFaFOgoMcRZjYy8BfLj9DekuKqp
         Ym3lYD4GHxbbEnxx7DPqq5nQqeFh9dGyxWohCzxn6Yz1HGAhNp/Qg0lwAwd3TAMxIGKg
         dIajRz9gSHRv1IZIYIsgh1FHRtZLWSAFBMb4cbapE0VXndHxDhXO3t5m6TnKxci2y+dr
         rePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902047; x=1794506847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/I33OUa1U8xDIJXKnhY8phWZhcDw98890p1Yjm2kAE=;
        b=0WbFqB+bGC6A5Wh48uU44UTFWkZmPecXGJL4Bol7XErGO7jiDSZ0vaGqcMOX5BQ5PS
         UxCjFG85xSVXmNt/rTEfpDIlmLDaT3/RU5gLOZHY5qtGCzlHlfwYk0+fCp5ubjNxlQLL
         EiENPtmpFlYlrVrsUbe/bg357tZk1PIh8FA0cgxD3ydrS58al42zqi4oFykx8ZhmgrFW
         oBjdlkAbNH9lO6dQbNjHMDvmniZsJspNqqkZOLFZTt5jnrrpeXkn/lLBsRfEiRnAAB5S
         Q4Cr+YLMJey8KAupvq4E4e10YhHz8KeqUvVyE/hKlErVxGmUq/gKAJBG/saz/8WGagYV
         eFiA==
X-Gm-Message-State: APuU4Z9QMQJvaOrxFoSBe1ZbnojPjRl5l7vLasYCyiOPWNMka9+TRjoQ
	5v+likSbu0J5gm+ee2VfugkFJbIf9lmy4cYxK8ZR7CZa5YcTP6YMAQ874iLl1TByVzShybOtRZ1
	e6Pb3
X-Gm-Gg: AYBFou2f7yXrR/BTH3z1bjzz+bIuwBRKI3bK7cib6KxD0orhKEAG/W4+QmV6YG5TCxf
	u56sGtv1pfco/VcFy5p8WEe0y9p4t6mdKW5j8yZdvjp4h3LAH28oRzUHfLQgvBFYeAssyZBY5yq
	93cR2vaNFTY4y+uFigSBrdAIFBdPxyNCQkV+LTYrPz/Z0mKSz0Heykg2VVy6j+imrGHo6Xb4X6e
	6dQY0E8XTFjhRIRzO6PxFLre+N4QY7rv4PxHVRMVBgN8M14E3qD8GUmAbNjvioa8dfCJcQdoJ3y
	gHyS1isRLNBWbMW2m9nCpEQhQSGbx8ZVEVtObFM8plb7qoWQpV+GW90yZQG7VqX3FoSTw1WVBBR
	1z7EX7z+IAk39sZqe0AgRPSaN5OKyQ3c7c8f1aoX0vKV3btJsR3fKf4RxL+EKCvg5R+IRBb7A18
	EE/KiX3xwjt/Qu6Kbqgm/vaRhRCDgcgaDuG+NMDqohej+KivXvKhEj1M4fpou4PIZ6u5kSOw6F8
	t63i52BM3lzhIvDiorrrBXxjLHtG9RrrjicN9HmyoSMs0VC6giK9P0JV4SVZdzCCZTvoa/eNLXi
	hD4AhI6ztXA39qBFi5idJLjYdNojeg==
X-Received: by 2002:a05:6808:c2c7:b0:531:7f68:842e with SMTP id 5614622812f47-5640dbd6258mr13859496b6e.8.1793902046774;
        Thu, 05 Nov 2026 10:07:26 -0800 (PST)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-567a9f4072fsm4947248b6e.10.2026.11.05.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:07:26 -0800 (PST)
Date: Thu, 5 Nov 2026 11:07:24 -0700
From: Tyler Cipriani <tyler@tylercipriani.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #02)
Message-ID: <auzF3FvY8ahutXw7@localhost.localdomain>
References: <xmqqmrroxdzs.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqmrroxdzs.fsf@gitster.g>
X-PGP-Key: https://tylercipriani.com/018FAC02.asc

On 26-11-04 17:29:11, Junio C Hamano wrote:
>* tc/push-force-if-includes-fixes (2026-10-18) 3 commits
> - push: --force-if-includes should allow fast-forward
> - push: fix --force-if-includes non-branch advice
> - push: check pushed ref for --force-if-includes
>
> The '--force-if-includes' protection for 'git push' has been updated
> to consult the reflog of the local branch being pushed, rather than
> incorrectly checking the reflog of a local branch that shares the name
> of the remote destination branch.  The push advice for detached HEAD
> scenarios has also been adjusted to indicate that the remote ref
> cannot be verified locally.  A regression that caused perfectly valid
> fast-forward pushes to be rejected when reflogs were expired has been
> fixed.
>
> Needs review.
> source: <20261018203255.2343005-1-tyler@tylercipriani.com>

One note nit here: --force-if-includes rejecting fast-forward is not a
regression. It's been a bug since the flag was introduced in 3b990aa645
(push: parse and set flag for "--force-if-includes", 2020-10-03).

That is, this has always been rejected:

    git init --bare r.git && git clone r.git wt && cd wt
    git commit --allow-empty -m A
    git push origin main
    git commit --allow-empty -m B
    git reflog expire --expire=all main
    git push --force-with-lease --force-if-includes origin main
