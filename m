Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A847184D
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446814; cv=none; b=CwynnwUwCJC8s6GlPDebqVM+HFL5mOGQu7zf6SX7zwENpqtZN8JvwUIwY7q/ypIs0Xm1gwgSUBfryOO5YrFZCF1LiUdF/vJcwyBmw+upWltDuP89AU/tSH7OdcrHjHTmAMcudaUlOQv32A96Bpgi3vpnz6IUZ9IMfENcnDJpuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446814; c=relaxed/simple;
	bh=uUe+amIg+uEaXpnvgfdzSBCALwzIG6OmN6RhbryL6d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7MmKWTYyf0q3GFgbumlvTPPhRUgVLZ+e48xu58RyjUolKfGB8qvDjOUhrfxDeb23qL2ZAW2CXuJ3eXMkOJ2Po6ju1S/j1MoOSJ1w9JF5R0WSAPQFZb7i7uWg/+mlEaG7mpaY5+Z1bGlYYedP7JuObDmCJrN2ZKAQuv/r6RaIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=AufIQUFB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="AufIQUFB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d95d67ff45so3691275ad.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 18:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1707446812; x=1708051612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1TmJQbigyl2yPqmufw+zPmz24FwMH2GfB87Pxlu/DA=;
        b=AufIQUFBiaR7pRlYN+v+c8YnrPydymNy0r/q8mLOLl7HD78DOgI0+teWsJ99gdk8Dr
         7lXEqVVT6swemKPj0fzUAXbms7GKbkNb9hTOZIPqg74yu/rVgRJ2wUrSTgSIJuym6zb3
         L7olcXa2V9B3SNYXjw/j61I3Dwp1FqrWNaE0oJY113wO2VwRVX3h06dHFOf5DLGFdZ80
         ti/lQEUMsg6HFRRUrAHAy8TE0ZeGZG5NeRDM9YaIk1olM84Uhx+rdaF9aqQNhTje3QbZ
         0nQ0gmcOo3yYW41yb0hvIgpNUk/cQw9no1wkcJ7PZsMDnI/74UovrXfnux7jsk+0FcOh
         kCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446812; x=1708051612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1TmJQbigyl2yPqmufw+zPmz24FwMH2GfB87Pxlu/DA=;
        b=O+qOYS9PPd9LGQHl9RpzO7Ty6no4NC/qYhbRF8ksmY0V13jAkj7A3fpSbShIQJ3xJ0
         nEEfAftHgwNxFd66Acju8WG0q52MB5SqgCpkQutxBT4RZUzJm7XWom0tlU/Z+1C5P+Lb
         sUEiY1oqByno7V62cYHjPF7sH1OkIj2GkSkllH4y1SteulfEaAiVzoSOVplcCP+9EifB
         jI3YPD7xJoTHqpfjszfKNOfRDpu7rIgQd4l/rLrCNAIOItGuyxs8Ai2s7JZcw3yDL3yD
         hsNmKxsefrkdOAzGrg0gtIVT48RtAGNX/foIO0ynFSUNETkZBEHicVTJVMS4o8JEkDIQ
         Payg==
X-Gm-Message-State: AOJu0YykNRp/bwIO1Tirgf7K/q0GwocC3g1PpX4U5gDNmuMT7vg36U9E
	bYkaCJ4ProQ7JqOXm6QXFVC+0M41zgLlAMgkLMRYOrjw/aJE380rxPyYDPaoxi635Jk9/Ryrxg=
	=
X-Google-Smtp-Source: AGHT+IHv1Dgs4GBKVOerCRc/6qorSMJyW3Wqbssbz4/6iPN39qW2CmfJSI0naH8/cbmX8PoTMiwVNA==
X-Received: by 2002:a17:902:ea04:b0:1d9:f313:60a2 with SMTP id s4-20020a170902ea0400b001d9f31360a2mr401243plg.38.1707446812463;
        Thu, 08 Feb 2024 18:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUq5Y3JT6547UgTD4q4kh1w3f0GpCCGhxsD1B3NfsNyGw6uimdM/Jv+pnMYp4x+EHbWba6+KORysJof9TzVlAxL9ePYdU8G
Received: from [192.168.50.41] (172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902e04500b001d9641003cfsm465327plx.142.2024.02.08.18.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 18:46:52 -0800 (PST)
Message-ID: <5ed018da-2150-42d8-995e-59a35a2e3821@github.com>
Date: Thu, 8 Feb 2024 18:46:50 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter.c: sort formatted dates by byte value
To: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1655.git.1707357439586.gitgitgadget@gmail.com>
 <xmqqzfwbps43.fsf@gitster.g>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqzfwbps43.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
>>     I came across a use case for 'git for-each-ref' at $DAYJOB in which I'd
>>     want to sort by a portion of a formatted 'creatordate' (e.g., only the
>>     time of day, sans date). When I tried to run something like 'git
>>     for-each-ref --sort=creatordate:format:%H:%M:%S',
> 
> Hmph, this indeed is interesting ;-)
> 
> I wonder if there are other "sort by numeric but the thing could be
> stringified by the end-user" atoms offered by for-each-ref
> machinery.  IOW, is the timestamp the only thing that needs this
> fix?

The only non-FIELD_STR atoms other than the date ones are "objectsize" and
"numparent". "objectsize" has an optional ":disk" modifier, but that doesn't
change formatting (just the value of the integer printed). "numparent"
doesn't have any modifiers, it just prints the integer number of parents.
Otherwise, everything is sorted by string value, so I think only the date
atoms have this kind of mismatch between formatted value and sort value.

> 
> Thanks.

