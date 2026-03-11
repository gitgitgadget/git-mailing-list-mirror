Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197562D94BA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270934; cv=none; b=epqNKhi7jiZ64qrUqU9mq6yGzAj374nJeBKGfXl45eYzPWUVEu/2islmY9RzEsFiwX0zHMplx/1StVpWEIlHXnkbTQcMzLh0O+Rsm4J2uuFTV2O/Ifbk7Yhe/TMOaw7o8noYEt/zCu6zG7bp2xE5oCj+q/8aARJ41qr2KAGWJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270934; c=relaxed/simple;
	bh=zmOhdg3A1qGRQ3B1YQus3DYQIXxN72WT9w2bwQtji30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcBmG1A6+a4TFZg0OSo83tERpX2SKSMIDDuD4kh9lWmmK7KeblbJO820T/c3PSX09tNeNQMY7BXDN8PZg3j6/jdIfsjORNhdGlvgtl0S5V/k4eaAVSXvO93hchwTxGjhkTitVV7HD0OWAQf/TD+rzpIhkaVVEuxHL/tOPjT4e9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=fail (2048-bit key) header.d=plus.com header.i=@plus.com header.b=knbZXlIn reason="signature verification failed"; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plus.com header.i=@plus.com header.b="knbZXlIn"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 0SixwKKhJkMb10SizwuORo; Wed, 11 Mar 2026 23:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1773270742; bh=qdzBRbfWEoj92/UhCnpr3nIxeD7YGhKNkS39j+lL/Hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=knbZXlIn1IEgD93ypIGOEl4VWPxpjUmzCwB3J3i68IgZZY9S4chImK9jSYS5pzhZz
	 wjUGggwjvTwXqRLwpBQYq5uEi7InAUu5/6/68PGk9WRB8W7RfpiG8aocil7KdOwJ73
	 Byuuoik0NDMG7uxmbx6srhVqFuCY3TTIDaf/fTdx6yGiwvgs0dxtuO8P2U0XqoIR7u
	 tZIQT1EwbxeCB23iZgynERi9F9iY9nQdCbYyEhG6imNyJy/DkHEGD5Wx6e0JzmpnEU
	 Ak96UvycGn3SxpQZ75926SP9ieLPGRiZpHnpfrJMCKF8MmBRcATex5vrSM6+ELmEa3
	 s8+UMC7sMTVdQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AMGJABRe c=1 sm=1 tr=0 ts=69b1f6d6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=uWSZVa7dp0Ps7Ir8wwIA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <77fce76d-07e2-4586-bb6c-f0043d171591@ramsayjones.plus.com>
Date: Wed, 11 Mar 2026 23:12:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] t: allow use of "sed -E"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <xmqq5x72m4lu.fsf@gitster.g> <xmqq1phqm4ca.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq1phqm4ca.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfASG2EAyMV7okrvXHRgUJR/Z+KAv/sGDhI6Cwz52sZ/2uwLMCVyA5Q7YHKhSLcaFWtKqK1j7Xy/FQjbCgO56qH88ZLl2Xq+AG4zbWOwS4KgjQZnUwvRC
 dmiiihcd6cIxFagQsc3sLNxvn+L4cBsEAJ4uxYMbllT3vU8psbsXkZuzIAVH7WQqX7V1p4D5rqZBUFA/WKXGVXUR4XIKQLnEcrU=



On 11/03/2026 9:41 pm, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
[snip]
>>
>> Let's change the rule to allow the "-E" option, which nobody has
>> complained against for the past 3 years.  We rewrite our first use
>> of the "-E" option so that it is caught by the old rule, primarily
>> because we do not want to teach our mischievous developers how to
>> smuggle in an unwated option undetected by the test lint.  And at
> 
> "unwated" -> "unwanted", of course ;-)
> 
>> the same time, loosen the pattern to allow "-E" the same way we
>> allow "-n" and friends.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  t/check-non-portable-shell.pl | 2 +-
>>  t/t6030-bisect-porcelain.sh   | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git c/t/check-non-portable-shell.pl w/t/check-non-portable-shell.pl
>> index 6ee7700eb4..dd8af6d08f 100755
>> --- c/t/check-non-portable-shell.pl
>> +++ w/t/check-non-portable-shell.pl
>> @@ -36,7 +36,7 @@ sub err {
>>  
>>  	$_ = $line;
>>  	/\bcp\s+-a/ and err 'cp -a is not portable';
>> -	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>> +	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';

.. and, perhaps, add -E to the error message?

ATB,
Ramsay Jones

>>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
>>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>>  	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
>> diff --git c/t/t6030-bisect-porcelain.sh w/t/t6030-bisect-porcelain.sh
>> index cdc0270640..1ba9ca219e 100755
>> --- c/t/t6030-bisect-porcelain.sh
>> +++ w/t/t6030-bisect-porcelain.sh
>> @@ -402,7 +402,7 @@ test_expect_success 'git bisect run: negative exit code' "
>>  	git bisect good $HASH1 &&
>>  	git bisect bad $HASH4 &&
>>  	! git bisect run ./fail.sh 2>err &&
>> -	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
>> +	sed -E -n 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
>>  	test_cmp expect actual
>>  "
>>  
> 

