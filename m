Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59242052
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276698; cv=none; b=u1os7ceTwWM9ph44mWkI7MR76uspwkqpJ+g6K+4jmRmE5czOaCrCE5SPyXta5vgIJyeDIINVWDO3vCgb87fPXR5xSsV8XSQb+HKTArJT5JojlJrWD4EfRMQZkiDsMq8bKT4chxybZluH65kOglkxN2cSzjtJS1AJDCvfrqTS/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276698; c=relaxed/simple;
	bh=ymH3fpuVJDOKRjWQNNilCYxmMYiVRXkRVUT6P9hTL7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tqCYqg03JBIQs+Wa+KMNn5x9t1yZovHGD++gstgqYzcI2Xo8eadDIvWq5eWS5j3JG3ja+oSD/hc/YgSDzDWwDPjm7gqSFcpAWfPOF0tF1t8j6nT7VgCq9xAr19MbqxniW5QMI4Lci/2rKPl8C07uYMqtxmebz2YOTdGuYHUtldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=BkKJIm09; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="BkKJIm09"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask@howdoi.land>)
	id 1sUIh8-007N38-Jx
	for git@vger.kernel.org; Thu, 18 Jul 2024 06:24:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=o3WvXpshjiXIoRPT7LBh4m00D5FTaEPkUXF049UCG/I=; b=BkKJIm09osL53YxpXobXUlZipT
	DbfwsVkcXMrQhrZzGsOiSeThChVTJ+aH9txgV3IwbkHHS/mpFBjJMfHlcOjoZGJQ6UcV8KIgpPWi7
	55gqmR6MX7ZSLPUg9VFiHTszllWNQ8ulNMl18lq5mpmCeJOWXiVNAbv4UZG1LMNvt31p+aEI+d6t1
	ASTrGGROv4uHFbUD5tntmLWq9cB/+1qU/k7JuY8+VENwcKWfaImQxkpQHhJ6CLV04NrhblK3PZEZR
	/qISfrsilsiDpU5pSDA/4DEroeXT9pJiw0a8nVvTMiNy1yN+NYrxA14n4nNtdjuXnJzufohjuqzOA
	wfV1MOPw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask@howdoi.land>)
	id 1sUIh8-0006EJ-7M; Thu, 18 Jul 2024 06:24:42 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sUIh3-00CUQo-A9; Thu, 18 Jul 2024 06:24:37 +0200
Message-ID: <984140ad-b2b9-4336-84db-552428071f7e@howdoi.land>
Date: Wed, 17 Jul 2024 23:24:34 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shared bare repository dubious ownership error after 2.40.1-r0
To: Mike Lodispoto <mike@lodispoto.com>, git@vger.kernel.org
References: <dd703bdc-f485-4162-92a5-fd2828b69604@lodispoto.com>
Content-Language: en-US
From: Colin Stagner <ask@howdoi.land>
In-Reply-To: <dd703bdc-f485-4162-92a5-fd2828b69604@lodispoto.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Mike,

On 7/10/24 18:16, Mike Lodispoto wrote:
> | $ git pull
> | fatal: detected dubious ownership in repository at
This appears to be known behavior introduced as a fix for 
CVE-2024-32004. It appears that the safe.directory restrictions now 
apply to fetch and clone as well. See the release notes for v2.45.1 [1].

You can fix this by adding the path containing your repositories to the 
safe.directory configuration parameter as Git recommends. Whether or not 
you should is another matter—this can expose your devs to attacks from 
other user accounts.

I also have small workgroups that use NFS and other network filesystems 
to share repositories. Are there any plans to make cloning a local 
repository safe?

Colin

References

[1]: <https://lore.kernel.org/git/xmqqv83g4937.fsf@gitster.g/>
