Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C94AD4AF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211732; cv=none; b=Li4bixne5L7UsEug3zkCLz4NofMXedESP8zI6isBxBExYh7yPdNyc8941uylra5VrQgrKDGHCHmFLL19+i3yv2fPc64SrtzyOrpGBYX6JxYr/yQuwccVcDC9TYZhc5HLTGFWOrsQjZ/raygyy85r/uBjlgPOvohaq9TH/DN7hHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211732; c=relaxed/simple;
	bh=0DX55E/ypqo75RwmPDMVOCGRqxFLJGFl+nAp1SbH1yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtWJiqMbDyF8sTase1dZIDFvCqn9lHiQ27zDsNHoC1TqEcOzy9MXLCWFAUH2x19juHq1J2QVrfBfisJoslsuQPPR2e+8zHWjlnh+Ex6UxvAhulLa4QewmPWO6WJ/EL0ouiHNaGEAGgb9zwg0kvUWSFCOqVvDQfygAY+zNbdyo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hz2MJ1DyCzRpKh;
	Mon,  5 Oct 2026 16:48:43 +0200 (CEST)
Message-ID: <b2f86941-6ae2-4105-9284-e5e4d530b965@kdbg.org>
Date: Mon, 5 Oct 2026 16:48:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] checkout -m: recreate conflict labels
Content-Language: en-US
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791206658.git.phillip.wood@dunelm.org.uk>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <cover.1791206658.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.10.26 um 15:24 schrieb Phillip Wood:
> As "git checkout -m" is recreating the original conflict I wonder
> if we should remember the conflict style as well so that
> 
>     git -c merge.conflictStyle=diff3 git merge topic
>     git checkout -m <unmerged-path>
> 
> would recreate diff3 style conflicts, instead of using the default
> config. I cannot decide if that would be convenient or confusing and
> am interested to hear what others think.

I think it hurts more than it helps. For example, I usually get away
with the regular conflict markers, but at times I might decide to see
the diff3 version. Then I could change the conflict marker style with

   git checkout --conflict=diff3 -m <unmerged-path>

It would be disappointing if this were not possible.

-- Hannes

