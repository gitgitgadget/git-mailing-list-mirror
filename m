Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032C32FA2E
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780738703; cv=none; b=rK4k8ONfIR4ik1fatCHj7tG6U1KnWNLiTxQDHsAPzsYerBR0nA6ZI/fRjyx0wFUK85MISAOb3x5KptQUF/66ZQ9JQQyRTeZCq/S0xR8oifuQ90JqJW1acqbAJBOOLM/gEx249f+eR3xRK8VEZtJ8W4sxz6PGat1ued2uzQ7RtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780738703; c=relaxed/simple;
	bh=XF4NeioGAq+eS+uTHI7XwqwwKA2ktgTNHPycICHafbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wj0dbRWxLhsh8J99dKLuOtCaVtIy8qsPvzMBtLmPf+anltv/gbSL6eTJmWUNbml30tI5IJIHBdN2OlADM0+quN6rfUrwgntoC/v1EfD+Ac5v6PatJ4yVD8Ig521wUbg1wgKpaPnECXmbtx18YKyVCQ1woOheX++eoAihxqan6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gXYBr3QBNz7R62B
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 11:38:12 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gXYBf4pBTzRpKJ;
	Sat,  6 Jun 2026 11:38:02 +0200 (CEST)
Message-ID: <e717e5fc-b9c5-489c-b018-4b747a5378a9@kdbg.org>
Date: Sat, 6 Jun 2026 11:38:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] git-gui: silence install recipes under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
 <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.06.26 um 08:48 schrieb Harald Nordgren via GitGitGadget:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Several install and uninstall recipes embed "echo" calls that fire as
> part of the recipe itself, so the install banners (DEST, INSTALL,
> LINK, REMOVE) were visible whenever the variables expand non-empty.
> 
> Guard the whole "ifndef V" block on "-s" so the loud variants are
> selected only when "-s" is absent and V=1 is unset. The existing
> "-s" check also had its findstring arguments in the wrong order
> (needle "-s" never fit in haystack "s"), so swap them while moving
> the check to wrap the block.
> 
> Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>

The new text looks good. However, the email addresses of author and
signer-off are different. They should be the same. I notice that you use
the gmail address in both places in other patch submissions, so I can
use that if you agree (and you don't need to send another round).

-- Hannes

