Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3541A0BFF
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502706; cv=pass; b=dUEESB4ABCHSRQdNwin170nHra+yWnsQiRxHbg4mei0Es41OsPzuKYgWleCfDc7MDdEA1rMLbot5E+Mvksz2vR8csiJS42fib7ZoM2fn+/57gg+xlJ1pSFab0OkHCoogT+SeH+VX7/LU+X1ySmzDjMxyrZjZcFQis8CSfHYZOvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502706; c=relaxed/simple;
	bh=VzyAJME2nEnq6XQiVDmP1zJOCJoUkYsFQClTZLmxey0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QNLwI/B7jsDgJNJzNzO0GX9j6GEMyxRAfxpNNS3LdOJIy9s/nbjbEdee/HYGTvwv2Gvj0NSL2o0sJuxKOyzm0iy6FHSr3QmCG/edCtd78GoG6nUqQqBriEpTjaNmlTvch0Z+emCNZt/xuafHXwH/4a2mEkarFlZ/R1hSPppvAU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kibit.lt; spf=pass smtp.mailfrom=kibit.lt; dkim=pass (1024-bit key) header.d=kibit.lt header.i=monika@kibit.lt header.b=tqamMPRX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kibit.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kibit.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kibit.lt header.i=monika@kibit.lt header.b="tqamMPRX"
ARC-Seal: i=1; a=rsa-sha256; t=1728502689; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XG/5C1Eb4KYCUzWAsWRYkE/Ms1PFYfO9NZB0an7UeXMixQmbyXKSaEMoMCHsE25g62XUVtEWRN8luJXts/TQIk1S98jq3pxJFT/sdPHT4QsSPpxXCqIS+PUvsvwTvA+uTNaVaat1NduOhOmRAsJkePB44YJQl6SHE8DWkDABVvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728502689; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KwdRdDLg6I/JZCBdwVRSbP6L2rj49HOzRLmqv+6JAKg=; 
	b=FZ5yKpNWqx5G160KSAik1pCfX6bgv/W7b1N8pRq365It7NeAPRznqjoPA5HycugMeIdEQ2PxO1xNfoz9mDxl3L2FGFg3TOv7d+EfXMv3Edx5Xog1EJsUt1v6dMJd5FZEAP5EUBH2l97vytRJe0XlCtZ1S2W/eqPBA+eeNZq7laE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=kibit.lt;
	spf=pass  smtp.mailfrom=monika@kibit.lt;
	dmarc=pass header.from=<monika@kibit.lt>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728502689;
	s=zoho; d=kibit.lt; i=monika@kibit.lt;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KwdRdDLg6I/JZCBdwVRSbP6L2rj49HOzRLmqv+6JAKg=;
	b=tqamMPRXMTyw0muhhRVYPA2UBlCDvOoczKZcqoCoUI3TUl7p7tzu47oyml1GNH1T
	LHV/3bqhYXZf6sUMJeP6un/7JMCX5NnEIqn2OGui7bXNfrGAAPFWQU45CAHDtMpVI5O
	RanPq/jKDfCNUIalOmYzoZe9Le3RlqTtynPJ2lRY=
Received: by mx.zohomail.com with SMTPS id 1728502687901608.342862583636;
	Wed, 9 Oct 2024 12:38:07 -0700 (PDT)
Message-ID: <d036a759-dd1d-4d09-8a60-d0a98fffeada@kibit.lt>
Date: Wed, 9 Oct 2024 22:38:17 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gitster@pobox.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, monika@kibit.lt
References: <xmqqy137wtyz.fsf@gitster.g>
Subject: Re: [PATCH] documentation: add missing word "ref"
Content-Language: en-US
From: Monika Kairaityte <monika@kibit.lt>
In-Reply-To: <xmqqy137wtyz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Sorry for late response, it took a while to figure out replies to 
mailing list.

Thanks for review and suggested changes. I agree that it looks better.

Cheers,
Monika
