Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C237AE5D
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414387; cv=none; b=AyGpiQuonGbxzKLeTEA/oySe3YpuTT52xzFS1A+oaze83O/DHL+rOgBxWOXE/U0xd8n4KsCIg/Ybylc7Q8Clsj3UiS26r9pbmgUycDLAjEyO0kK9pOTXr+XJpmAbizh3P2/zN8vVX0z6AJhAlI2KcBI+jMW5b8CbDZQI6Kr1Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414387; c=relaxed/simple;
	bh=6hglDkGxrVmgIXcU0VH2iAB1Bp2mWZb5pA6Qe4pkS9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEF+iciHgyoS57+y4PgQwKjrtLACBzRtOSe36GD44JBpdWzmuzgF6FitS9i9rIgDhS6dC0QZczqeBkAvwrGF8WxAMVwK9/BH76PVhU3Wfjp0nWBXYE/vf0jFDsyQqoDrvb9og/KjlLt9thw+ZlKeKQnVUt8QW4kV+yGZxDJSOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=yehrQXzA; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="yehrQXzA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eEgDa8x5MGJz5cr/V85RjpEylHZAzvazvKt7irUcrig=; i=tom@compton.nu;
	t=1716414385; x=1717623985; b=yehrQXzAkPkL4xJcIrnTt8YZnolmAZwx1Ic+CnKAY0kANM+
	N4xVum5Qr1IRyTrcGckKXQYInitTgk04Z6bJ8QbE3voH+UG2xwkz6DqVJPECAYY0y4mERNOSC74xz
	rn3pvBT+GTy7+zbPmGfD7tK3hIaBNm1ULK3X/c2f/D04mqZ1nOzOY+JVX24ceOWcuJOlYua6Ff/sI
	TSv5jLI+Bsu+g9d3tx4b0Crt2G3jVqqjXxsWyrmcTTKd6Fox288GK7N3YwG3XSON1t6nKE9LazJJ7
	gK2FyXbXlBxzzcuI+LbjS+TwRSCiiPbXJSMEJ7Cecn1nvIzXxIdi86Hxnd2F9brw==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:50684)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9tmq-000000080xT-2X2G;
	Wed, 22 May 2024 22:46:21 +0100
Received: from arden.compton.nu ([2001:8b0:bd:1:9eb6:d0ff:fedf:c161]:34318)
	by bericote.compton.nu with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9tmq-000000078ZF-1oJb;
	Wed, 22 May 2024 22:46:16 +0100
Message-ID: <8f2ebf1b-050f-476a-92d4-dfb06ad04f8d@compton.nu>
Date: Wed, 22 May 2024 22:46:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] push: don't fetch commit object when checking
 existence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq8r014pyn.fsf@gitster.g>
 <20240522201559.1677959-1-tom@compton.nu> <xmqqed9t36sn.fsf@gitster.g>
Content-Language: en-GB
From: Tom Hughes <tom@compton.nu>
In-Reply-To: <xmqqed9t36sn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 21:55, Junio C Hamano wrote:
> Tom Hughes <tom@compton.nu> writes:
>
>> +test_expect_success 'push should not fetch new commit objects' '
>> +	rm -rf server client &&
>> +	test_create_repo server &&
>> +	test_config -C server uploadpack.allowfilter 1 &&
>> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
>> +	test_commit -C server server1 &&
> 
> OK, we create the source that allows a partial clone.
> 
>> +	git clone --filter=blob:none "file://$(pwd)/server" client &&
>> +	test_commit -C client client1 &&
> 
> And make a clone out of it, without blobs.
> 
>> +	test_commit -C server server2 &&
>> +	COMMIT=$(git -C server rev-parse server2) &&
> 
> Then we create a new commit that the client does not yet have.
> 
>> +	test_must_fail git -C client push 2>err &&
> 
> We try to overwrite it.  We expect it to fail with "not a fast forward".

Well that is what it would fail with at the moment, but it's not
what would happen with a non-partial clone - a non-partial clone
would fail with "fetch first" instead.

This patch makes both cases consistent although that wasn't the
main driver - the main driver was to stop it fetching 100Mb or
more of history in the large repository I was working with when
the upstream has one new commit.

>> +	grep "fetch first" err &&
> 
> May want to use "test_grep" but this script does not use it, so
> being consistent with the surrounding tests is good.

So here we are testing that it's a "fetch first" and rather
than "not a fast forward".

>> +	git -C client rev-list --objects --missing=print "$COMMIT" >objects &&
>> +	grep "^[?]$COMMIT" objects
>> +'
> 
> OK.

and also that it hasn't fetched the new commit.

Tom

-- 
Tom Hughes (tom@compton.nu)
http://compton.nu/

