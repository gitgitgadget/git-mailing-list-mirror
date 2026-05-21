Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBB3176E4
	for <git@vger.kernel.org>; Thu, 21 May 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372405; cv=none; b=DzG9vRvEJcVUJ0e1tnhJCUBzgl0OB8MH2UtMoGRgc7/07RVbCQyplH+Ual9iGBDFs1lMtvFhHLjEepv1auQzYSv9XsdVyxdVf13QCBDr/2NSn6k3qZF1H3dZRrUCUdid6qRgPJuenvxLe8GsAQpDFu3wbtU3d38jIUBTVd4lkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372405; c=relaxed/simple;
	bh=qGPSMGBI4DFS0ofmGNYIgM18bFE9ZjmAnr7PI5+kPpc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLbp6/2gMgQDWS6fCQoXLrZRB9rto/94Njs3xVC7GODiWRu0OK5h5KpsN6PlbdUh2EDDLHbomrkJKZkRJWxmSI0GKeS0vvUtr3XEPpTUYHUGPpkV18HKOBc3xbChyl+di6C1h5nvi7qoh+DhPfDz+n+KsQMMSQ61K5TRduuYnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVeneUTC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVeneUTC"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd0209f25c1so1043293266b.2
        for <git@vger.kernel.org>; Thu, 21 May 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779372402; x=1779977202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u20HMPoVnEJkHbBwOkKn4XWPPKcBklI6MKdC2oqUtNY=;
        b=AVeneUTCpWqsKfkXt5r2qjM0I86ikdEjUBDelAVkdQnp4lIb5OEk/GhtBjKWu25Nki
         ppihXk7jErkF1DUweqcTec92euD6X+0Ari9jnQFk4UUFt6rzL4x4I/kbqQ1ZCO4+t5iY
         uDWLxwzkqL1g5kZ82XE+Lde0Ic/TVtyZA7XR8MlsxiURmUI0KJmkWbkcQuaiQdQEGStr
         zJE8JU1boSLqTzOfVQAAWQenUhIneIrtCd9IvXI/RgEvYFI8MIdvVynsNHB+YSF28uan
         /AnuEw3ygh9zSeALgyWDVZT7xYt+D3+rc4xWZ3N4fN0axGVQQwFwlULUa2Sb+bqUSJuX
         hD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372402; x=1779977202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u20HMPoVnEJkHbBwOkKn4XWPPKcBklI6MKdC2oqUtNY=;
        b=S7sY5YIh8HYttZXqMJJJT4IYQymLBe0BbBNi7c9O+OLwa5Ksh2pz0S3SD6Aop2Er11
         f5hcJmYp7egfx34zxmKfI1B7TjShCQJ2eIU5lcmBRQ6F325EeaB1Np4p+xA2LbJFKQWn
         DCOJ/xo45Y4ir3YPSSZGD523AFKVdoiDmV0eL9XG5Y2ubn7kh9jFiczq5jiuI0J+vnF3
         G65lzprl0xKZS9MA170w1wRZClGDI5qyjj1y0mMxHjOohHXSno+yfghKeVh+UdgF0CBU
         gF3eaOGHb1LdYb5Ls+cn8koxck5wSxfwWj8OK5PE2ScTwkaQB8t3YPlXuxJBlPiEnmcp
         xfxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sPA2N6uBrUIvCthTAXrXLzMNDbXK+6j1jklhxwQ5tGfZt3XjbnLyBpQf01tOJfPuVVgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0+wkErX4ltHMrnCWu0aclJabOPAyX0ImkijJCSVAbXmKTdPD
	S+PmFpVauJ4Aus6skamel6oIBYduA/35WfclBF2fbfdAIpyzGmxy1Vmc+lJgAA==
X-Gm-Gg: Acq92OFHpYKDxownql7QpwgRUTiPIw4dyuXvIl5fzbjwYvBabqe/9nRp8AAJIXa9dMu
	9XC6wacSC7UmPXPBkj1IlyJhjPPDLShkxtNxQVNsZlGbXo9sEOr1rPhdtxX6QapC7f5Dg5dMWuP
	YydLvUIheYpLyvcXmue3Q3RA6+b3Q4kBhtg+GkcEjQoGPAgVdE9nFf368yhrxrroFZb+etM8hZb
	e0OCC167mAQEgaOPteqpcpW1jlUlTslyNVwPpUQvn/6XlCkovAQDZDYpO/g65aJnjOg5O8EExwt
	4tCkhv+VHQQs9589BUS7FEKLhvQ27uoNJ6Z9l53mMf9wgW1glHJhHW9ZXfc1KfmU9dDAmhBP6eu
	0/IKaVl1bgUbdvsagnmVtkQawTZgNbr/YZY4HL4zjhrtV7iLvvzA53jtNg8t4QvlxJhWUaM65cH
	xAQ06zFFDbmHDiSwruDAYu4TLPExNUxeaTqhnl6r58JbT4XRsKr+xSWnBtB55pQdzSZJ5OH3gOT
	n0=
X-Received: by 2002:a17:907:30d5:b0:bdc:6e26:a90 with SMTP id a640c23a62f3a-bdc6e355899mr99464666b.2.1779372402146;
        Thu, 21 May 2026 07:06:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8aef3e2fsm50073566b.57.2026.05.21.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 07:06:40 -0700 (PDT)
Message-ID: <01526f43-86aa-466f-a1e8-054284e1a2e1@gmail.com>
Date: Thu, 21 May 2026 15:06:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
 <xmqq1pf77kml.fsf@gitster.g> <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
 <xmqqtss02a2o.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtss02a2o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2026 13:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> One.  Have you considered the case where the remote-tracking refs
>>> are overlapping, e.g., where "origin" and "upstream" point at
>>> different URLs but they both store in "refs/remotes/upstream/*"?
>>> Perhaps their URLs may textually be different but are pointing
>>> logically at the same place (e.g., one ssh:// the other https:// for
>>> example).
>>>
>>> What should happen?  What does happen after you apply this patch?
>>
>> It would be worth looking at what "git checkout --track" does in that
>> case and seeing if we can share the code.
> 
> It always is a good idea to think how we can share code for
> different purposes to solve a new problem, but in this particular
> one, I am not sure if "git checkout -t -b topic upstream/main"
> codepath has much to offer to solve what the new "before the
> checkout, update from the remote" feature wants to do.  To the
> former, it does not matter how refs/remotes/upstream/* are updated
> and by fetching which remote at all.

Don't we want to avoid creating a branch with an ambiguous upstream so 
that a subsequent "git pull" works though? Looking at 
branch.c:setup_tracking() it seems to reject upstream branches that 
match more than one remote.

Thanks

Phillip

>  The only thing it cares about
> is to leave the record that this new "topic" branch works with
> refs/remotes/upstrea/main.  But the latter needs to be able to
> compute which remote it should fetch from.  It is a problem that
> existing code had no need to solve.
> 

