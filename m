Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77426E6F4
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771189576; cv=none; b=D4lhIh9kXq6hIZIwvoACMp1tbSqTPyJmdL66E9UotUxP7OYgz8FmL82DYmaDkP338mc5OlvDnxvrVNaJmLvR7agxc8qXFVTwVSg5GxBr1Ovl1WgsWW/cbuz+S3cO9BxHHH/X2kVSFXC7fCIjMJkiJO1CXMQpHfBuPcBjDd72bwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771189576; c=relaxed/simple;
	bh=h6fnYW20B9j9OQoK/vayesWw1ldvVagUKv6DxsB+MxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIKtjPDaZzYuxjc+gYO/f/X2dmGRgEHWGqdOL0TcI/pHIklj0UXpZ1Wqp9Ba/dq5oVWb+v6bOPP5JWKrAOgqtbpFi4wcmi+PMb+BE8H32nLD9E+xtdt1OKi0r0vw0rIUZdYc28ZMc9rLNJR2hjgvnjOsZOn3kM4IjSWf30aJRK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=LZRKi89T; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="LZRKi89T"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vrjJj-008ILh-AM; Sun, 15 Feb 2026 22:06:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=fhhC3mN39mS4ZLPuvPWZdE5WPf+UuovooD1OK4t7y4o=; b=LZRKi89TMFGTbigXyZFns2HWmr
	FiwD/PB9kIq9l7ZtjtxPzDcGd5pBdtKrF+7mu5jNjsGzh0B4nPwHnFwppBTVgtztgibBKeyYJiGrT
	TrVmQrrKB8xMOR+o1YyR3QiMuxu0k9deP6FsVrQExEEQc/Sp743ZPU9+JCBfhMJ7FopwDAfcAlkYI
	4IkQJdKCEF3NTMoeA7nFnAwJtbqxn9ieTcjxTk1yNwdfNerG43ZNLLC6mJJg73xDFIr/1Y4qhnSmd
	n2Z5d2EW6IabRV7SYchghtTlXMc/XTNTLisi07zJ76M+W1BVCkYbl8slGHACaS5Fj3+ctuLkk+lqv
	MftwLZCA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vrjJi-0004kP-Sk; Sun, 15 Feb 2026 22:06:11 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vrjJT-00E9P2-8Z; Sun, 15 Feb 2026 22:05:55 +0100
Message-ID: <3e8b0ada-2fd8-497b-afde-5e02fe78a2fa@howdoi.land>
Date: Sun, 15 Feb 2026 15:05:52 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression][bisected] git-subtree remote desynchronization
To: Christian Heusel <christian@heusel.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Christian Hesse <list@eworm.de>
References: <755578cb-07e0-4b40-aa90-aacf4d45ccaa@heusel.eu>
 <xmqqikcql8cq.fsf@gitster.g> <xmqqecnel2fs.fsf@gitster.g>
 <023ae712-8f67-441c-aada-fb5b097ec617@howdoi.land>
 <8c588acc-1626-4ebe-824d-319d721537a1@heusel.eu>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <8c588acc-1626-4ebe-824d-319d721537a1@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/26 08:12, Christian Heusel wrote:

> On 26/01/25 11:14PM, Colin Stagner wrote:
>> I have made some progress on a fix, but I have not yet achieved 100% hash
>> equivalence across the board. The bisected patch will likely be reverted
>> while I work on a more permanent solution.
> 
> I guess that is for you and Junio to judge, but rushing a fix sounds
> like unneccesary risk for an optimization.

Chris,

I've CC'd you on some proposed changes to remove the git-subtree 
"should_ignore_subtree_split_commit" logic.

I have tested both of my patch series [1], [2] against every 
subdirectory of your aur.git repo [3]. I checked the split of every 
top-level directory as follows:

     for d in *
     do
       test -d "$d" || continue;
       echo >>split-results "$d  $(git subtree split -P "$d")"
     done

I compared the results to git 2.43.7 and found no changes. I would 
appreciate some more eyeballs and testing on this series to make sure it 
doesn't introduce any breakage.

Thanks,

Colin

[1]: 20260215201748.889866-1-ask+git@howdoi.land

[2]: 20260215201906.889951-1-ask+git@howdoi.land

[3]: https://github.com/christian-heusel/aur.git

