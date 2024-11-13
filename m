Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC918A6B6
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488362; cv=none; b=PG2BoGQLoRmWI6Vs+dfae3DNUqkcdasHOR1r6qH2LJV3qQc3yg6dFrdB8GjZaltscgp6MJX+/Bzg7RMgO0gI7UYSku9V8wZQWkXwJcF3O75R9Rlq1nz0NdLrYabtxrVnqsvSPJKrtyoQEVWvkkEUYnWRfM6Z03l1ardNmZkn/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488362; c=relaxed/simple;
	bh=SlIAAWotsXB4Iay4lgxEaIsmVA42o6qJkIhSFpNAD6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f82t2uxke73Twmvaz2tBKkgHhxO8EbB5wQipXQUZ6e/DTN5JKcI0pImq/95PtA5LggEjrie95hWhNHNy9QQoCqwLQCT9PFsm4tMtrD1EfuAAu+c7Tp6wPEwI582FppxRXoyq7ID5K3U0arYOYzki4HqHHxc/0C3/XbeUIs48SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=BKvSuXdd; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="BKvSuXdd"
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 8D0606013F;
	Wed, 13 Nov 2024 09:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1731488352;
	bh=SlIAAWotsXB4Iay4lgxEaIsmVA42o6qJkIhSFpNAD6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BKvSuXddAa44jDpdtHQmq4L30VqkRKT86T4iAXrT1SlwuQQRB5oRW0AL4M5NZu4D0
	 XJhWHXNjcsidDO5o4Z+ypFMC8lWOKT/jsr0gduC2YSP+Nbx+xET23R6Y0Ix0yyyd0E
	 6WVbrzngRJf7t5g7VpeSqXyYk7u0RVVVwVA1pYO78xbnawnAfPHBCJbyHCi9hVugg+
	 GuYljgZiuw+VS6aBdJAUSjxZHB7vn5iBRR+qtDAZMYIBpov6tvBekU3Dso3LhN9fdv
	 HvMfniIyTj/q4UWpGtg9EWLK7A1M10k0R59P24EA8M2qWwjNgHd59u+s3FFV9a3jDq
	 tQrwfMhrHdrtQ==
Message-ID: <4ad6b044-5eec-4d46-a862-20f374ede527@free.fr>
Date: Wed, 13 Nov 2024 09:59:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
 <xmqqo72l8egu.fsf@gitster.g> <7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
 <xmqq34jw6ci7.fsf@gitster.g> <45211c3c-e077-4de3-a167-0fc973a78dba@kdbg.org>
 <xmqqcyj03vlk.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <xmqqcyj03vlk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 13/11/2024 à 00:01, Junio C Hamano a écrit :
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Does
>>
>> `-1`, `--base`::
>> `-2`, `--ours`::
>> `-3`, `--theirs`::
>>
>> not work? (I think we agree that grouping synonyms should be done and
>> not all tokens moved onto a flat line.)
> 
> With the current
> 
>     -1 --base::
>     -2 --ours::
>     -3 --theirs::
> 	body text
> 
> these are coalesced into a single header and get rendered as
> 
>     -1 --base, -2 --ours, -3 --theirs
> 	body text
> 

When I first reviewed this part, I interpreted it as "there are 3 forms,
made of pairs of options used together", which did not make sense. That
is only after reading git-read-tree, that this explanation made sense.

> which reasonably shows that 1 and base belong to the same family
> that is different from 2 and ours, etc.  With an explicit comma
> in between 1 and base, would we end up with
> 
>     -1, --base, -2, --ours, -3, --theirs
> 
> which may be worse than what we have currently?
> 
> Thanks.

To be consistant with description of option, I think the 3 alternatives
should be split into their own items.
