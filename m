Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D21E527
	for <git@vger.kernel.org>; Wed, 15 May 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792729; cv=none; b=tzM6ogn32gZ1zBFYosXNwyhGaVL9gY6qoqhgk/UqXkOZEMyTsjzExTNFextZcXXmopPBMjJbY//m6XjFUE8G/gX4TFPnCyWk90IqW2DcP4xbMwOdIfvb3WZU4lvefS4SjhYoKgyr5lRGJcgTm+fPsIO19jHozJi1qjGVZJ6meBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792729; c=relaxed/simple;
	bh=Nh7S+o7skLMnvPFzR2g1Ap9TDG+wKkAHzMci6qE7zqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIdRN6Gmddxlsoh/8AGNW+VsSAFX2dSZyA6/Q5rn3SZlM6Ex2nxq9E25Jtt12mJias0HuIxlfHOoA5NWf4eaekS2u1rIzkyUElBT4kHnPi4dcz9irW/Ac1Vih/a6IeOCbYeRJhPUF7Lp/vfQ7dO1fnkKbdz5VPfIgmudIkcYKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 85867CA1259;
	Wed, 15 May 2024 12:59:11 -0400 (EDT)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 2F09BCC84FC;
	Wed, 15 May 2024 12:59:11 -0400 (EDT)
Message-ID: <fe76b111-f080-5d1f-c51f-591e9381c116@jeffhostetler.com>
Date: Wed, 15 May 2024 12:59:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: t0211-trace2-perf.sh: typo patern -> pattern
To: Junio C Hamano <gitster@pobox.com>, Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <ZkTIPlTS4jcQ-rHX@telcontar> <xmqqjzjvxbk0.fsf@gitster.g>
Content-Language: en-US
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqjzjvxbk0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 5/15/24 12:52 PM, Junio C Hamano wrote:
> Marcel Telka <marcel@telka.sk> writes:
> 
>> Hi,
>>
>> There seems to be apparent typo in the t/t0211-trace2-perf.sh file:
>>
>>
>> --- a/t/t0211-trace2-perf.sh
>> +++ b/t/t0211-trace2-perf.sh
>> @@ -233,7 +233,7 @@ have_counter_event () {
>>   
>>          pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
>>   
>> -       grep "${patern}" ${file}
>> +       grep "${pattern}" ${file}
>>   }
>>   
>>   test_expect_success 'global counter test/test1' '
> 
> Ah, indeed, there is no assignment to the variable $patern so this
> grep matches by looking for all the empty strings in the file X-<.
> 
> 

OOPS.

Thanks for the fix.
Jeff
