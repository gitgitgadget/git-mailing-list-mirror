Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA51527B6
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971660; cv=none; b=tTx4V8J0wx14Y0n+R1QxaiErDAqzcMBBuPaJAImVz63aGPv2uBX7C355nX8c7jNvoZN9xhqEcyojJxAhJp9mN8fGxv2kCYgrwgXoOEEQ88J8mrJiNKPJa7R6SOXzVwALIAmlhHWJyyZHAnzupFSldMT258yfJYh3mlCJ+FdbpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971660; c=relaxed/simple;
	bh=99ud2qMsnfW9LGEEvYPdw4AubnaZWEDemlEe2KEeQMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3NehHLPFAZXy4Oxsh73VDHLshTcpuVZTpdQUK0CvOPPKS8jmBdnFHdUavaV4rgoagSvQQdWb8aTqpwWMZXs8AK7/JZRZHJUL2NsFHsRgpkaWm+j3ygRc8jWHDMjBssT92eOSkmKm9wQx6LrfmQ80ZXSxjobA52SzqcgcDNcsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=B3Tp4VhR; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="B3Tp4VhR"
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 75CDA11F744
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 14:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 75CDA11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1718971649; bh=ZTZO7k43KTnd0pmv68DXFQlVzrgfPwdBISsP0652fcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B3Tp4VhRDOZUdzDf22VkPzIFqhIMDwhmLxpUXXxL7nCLZlizx1b4Px/fI9Hg+x0Ga
	 perfzP+OtvB1tlXqjEdjXoKpcx9yqz6FfkUZW3N4/7NTC/6Sxa8yaZ+skOq0Yw3AtS
	 Muebpk0vCTMxfPEvAcScsDyRYOxfprRwXaqj6o+I=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 6A6ED20038;
	Fri, 21 Jun 2024 14:07:29 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 6096B40049;
	Fri, 21 Jun 2024 14:07:29 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id EC934220043;
	Fri, 21 Jun 2024 14:07:27 +0200 (CEST)
Received: from z-prx-6.desy.de (z-prx-6.desy.de [131.169.10.30])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id C36CD80C63;
	Fri, 21 Jun 2024 14:07:27 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by z-prx-6.desy.de (Postfix) with ESMTP id 9E735240109;
	Fri, 21 Jun 2024 14:07:27 +0200 (CEST)
Received: from z-prx-6.desy.de ([IPv6:::1])
 by localhost (z-prx-6.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id iCN_Bz0xlesZ; Fri, 21 Jun 2024 14:07:27 +0200 (CEST)
Received: from [192.168.178.50] (dslb-088-070-180-117.088.070.pools.vodafone-ip.de [88.70.180.117])
	by z-prx-6.desy.de (Postfix) with ESMTPSA id F3AD52400E9;
	Fri, 21 Jun 2024 14:07:26 +0200 (CEST)
Message-ID: <c4f5ae01-97fe-4e3a-94e2-72da75b9df83@desy.de>
Date: Fri, 21 Jun 2024 14:07:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug with git describe --dirty --broken
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <0fd230f6-a5c5-463d-8584-651ceff3cf99@desy.de>
 <xmqqwmmjwnzs.fsf@gitster.g>
Content-Language: en-GB
From: Paul Millar <paul.millar@desy.de>
In-Reply-To: <xmqqwmmjwnzs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for your quick reply.

> 	if (broken) {
> 		run 'git diff-index' in a subprocess
> 		use the result from 'diff-index' unless the command
> 		aborted
> 	} else if (dirty) {
> 		refresh the index
> 		run the equivalent of 'diff-index' in-core
> 		use the result; if the in-core diff-index aborts,
> 		you are dead already.
> 	}

Great.

This matches my intuition from investigating this problem: the --broken 
flag triggers a different code-path.  However, it's good to have this 
confirmed.

> I _think_ the "broken" codepath should be taught to also run "git
> update-index --refresh" before it runs "git diff-index" (both in
> their own subprocesses, or run in the same subprocess sequencially,
> as if "git update-index --refresh && git diff-index" were run), and
> your problem may disappear.

For what it's worth, I agree.

Also, just to mention it, fixing this problem isn't a priority (at 
least, not for me).  Simply removing the --broken flag resolves the 
problem and I can live without this functionality.

Cheers,
Paul.

