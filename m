Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214043624A9
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849601; cv=none; b=HT1oP9JBWds6W/N85N66kzf6V8Gpc6d1ORUTdn7Icusnr7BtxpjH/aJkU4lVUDMmWbVA0ElMt3u9sY+fb5H1rPysyTixrbUmFGZwRl0y8cOTcAuDLqa+4RZq0RbibsbG+H6SrUUmk+OgsvWIKSCqdwuEcUYDMpk2z0L1OeicY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849601; c=relaxed/simple;
	bh=8M0DlaQgj0fMpGjJKu83OomfKAY7QiSjH5nB3yYdyAc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F6x5PqgKdXGftTeeVCuw8ZPmBi4VyKk3v7np03LVbl/jh7akwy2iTXE7Z+1Uc3SMpeKWvqV6UlzJx9wwHOGKJ1mJNRGXN2h62Gmwj0gRg4dXi6mrmtkDPcr46j29npx8Y8NB63O192GurnSQ0NV8YFHovi4CEG5xUYY7L1VWB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUJNqL6n; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUJNqL6n"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so621487366b.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785849598; x=1786454398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KA8/+18oYPOEoEr9tDPwA64lNQObhFGKNASWw7I3WnQ=;
        b=PUJNqL6nFIkrN+WbDSb0xGP9e+v2m4LWcxV35eDsVlYAXo8xnxx5pIQd4Kz6hTBSzS
         gzIB9a8Svi2wC7+VPg8QuTtaU2UiUDewd690cXMDj5o0iEhFZl9512VX+ulPsYp46msa
         WPC7f9Y0/9H10rK50Fq+bz6H+3PWNCeanygo3pBVWnkRzjAXT/nJA5kNpqHYmvtfLYO8
         JqLOJirZQvqqRvGstjYQCgaDHDzsinCVWPIFaY2jS2qRDQN7feAXwlLKFFk8GganPPOb
         oy7K2PWAGFO6o7HW/iqanC8Dg9wyRltU1UbRi1L1sgUbcyI/DDz/jhoI9CWNYZbba6MU
         +QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849598; x=1786454398;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KA8/+18oYPOEoEr9tDPwA64lNQObhFGKNASWw7I3WnQ=;
        b=BD+xDVblNQyA9WkwEf6crQ7NF/02u9k2J2g+yWBrK67c7M4eDEnnX0ZZL1phnzShXq
         w9zfD+taKbQXJCqGB4BFc3arUhz0mmZkahWPKPtdwmK1tjiyjkgMjsRcamzeG3kppsFE
         mnUwEIZIxA07CxPxXDuVspFbpTsjk16fQgfzFSxpp24YxamrUN+bfZWK6cMMLO7npbKc
         td92Oup/A3YMcTacR7QmoWyXs1Gc5Qasd5OxTQIO09GnD8CZAHa1/9x4EP9FrzKZKytV
         s+lABPTQ8mT9SvBJwCfyamjneiFgaphing+Xc7RbY76D+YGmWFZ45jnFOMn7YKpUbo3a
         MVJw==
X-Forwarded-Encrypted: i=1; AHgh+RooEJa/fVV1CZmsmoUIvJQPa0/ZZOe8164FAIRnCvOkRkxNvWMCu1eSVYpz7/KsxhTfh9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbFM4j4Q5z6EBavmWPTkHv6y0MYim7T/vTGSlMLUk3/Jd6QUz
	YFVwpeFumO13FKJS/6l1bSxtBKB7iIlaZuo1GZE9beAjRwGJCJX2atOC
X-Gm-Gg: AR+sD11eQ0mDEjBQEkVRz8suZChfms/OXbFshMHWO8OHL9dS53BWnbfTl1y/wgqWasU
	PqkAjWjhPIX/mNkX1jqgMPHXkc9FlckJsztGrhSj74vmg0OISXVyGAOVrB6HCxMNoA3X3k9SrlL
	NRZYgL/Wnr7ekt3vAwVGpy1bAcddwVeXkbzKT7AdvmbTu1WWPUu+TcYJxly918GpfKM1EgQgeXv
	tBnCzVJmf5/TAufIp9LzHUyjm+2YF8ZsqsQW2R1uaJWINOxr0sW0r1VnBLRyc7O1hKLkuHXgSEU
	PFX1eZ7o5NIhdI49lVRgQHL7hSBysHnoG3z2SC7JhkGupnIry8pJ9FOrdcRf6BIai0rNvBBxJdb
	KKn4YMzvmjcb8gPqjYRKfMxU6fk6AxcyB5qfkCpP8l6seHan6L6aNOH04l560lW6cxGwifbpLGU
	1Ez+7rLrGNhcoWxOrvgJWmJTXmHDn70pBltP5Het40iXnBZd1sA2nWnQb8lOGKTecIDzAhMydwV
	R003xM0LhiBhe2X9vVNd1JOvcEleUEaHtIkP4Eb4Cg=
X-Received: by 2002:a17:906:5498:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c1fe7eec317mr912640566b.17.1785849598097;
        Tue, 04 Aug 2026 06:19:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036256374sm11853466b.25.2026.08.04.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:19:56 -0700 (PDT)
Message-ID: <97c244f4-52d1-4d59-9ced-6f2dbe14a2f6@gmail.com>
Date: Tue, 4 Aug 2026 14:19:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
 <DKCKB3HW6VJA.19CQLPOHR6WTI@lfurio.us>
 <f00673cc-afc8-4a4f-a668-e22c53b46181@gmail.com> <xmqqfr0vyyxm.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfr0vyyxm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2026 17:02, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> If you raise a point and it is dismissed without a convincing
>> explanation then its fine to raise it again asking for more details so
>> that you can understand the reason behind the decision. That often leads
>> to a productive discussion and an improved design.
> 
> True.  But because "convincing" is not black and white, we need to
> be careful a bit.

Indeed - what I'm really looking for in a discussion is to be convinced 
that there is a reasonably logical rationale behind a decision and that 
the other person has considered the counterarguments. Many decisions are 
trade offs and different people may quite reasonably place different 
weight the factors involved leading to different results. If I disagree 
with a decision I try to only keep pushing back if I think the logic 
behind the decision is flawed. I also find such discussions useful for 
improving my own understanding of the problem and sometimes change my 
mind as a result.

>> Having thought about it a bit over the weekend I wonder if the best
>> solution when squashing is to default to looking at the commits being
>> squashed before deciding whether to open the editor or not and allow the
>> user to override that on the commandline like "git commit". If we're
>> squashing a bunch of "fixup!" and/or "amend!" commits into a single
>> target then I'm not sure its worth opening the editor...
> 
> Hmph, a base commit with an "amend!" (tells the machinery to use the
> message from the "amend!" commit only, discarding the existing one)
> is clear to me that there is no need for further editing, but if
> there is any "fixup!" (code change, for which need for associating
> log message change is unknown) or if there are multiple "amend!", I
> am not so sure.  It does make it confusing, I suspect.

I certainly don't object to always opening the editor, it has the 
advantage that it is much easier to explain and encourages users to 
revise the commit message when they are squashing.

Thanks

Phillip

