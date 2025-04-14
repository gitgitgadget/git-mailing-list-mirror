Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D444DDC3
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661526; cv=none; b=IdY/d66N5EY7fCNvaW8RddrRjDRG28w0VVLV272Hb0WKU6YXj0Ic37VUp8AwBk3Bc7guUhSH92wiC/iZAVqz5pPQbDxC9xzQFzBXL97A1b9MYh9m2nnhIvSjFzpJrGkCLgKnV1JPDa6B4qnnKI/EoxMjGRDRjFpaQWRymcC6YXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661526; c=relaxed/simple;
	bh=cV5fq3Of7FZj/A91kqhkmg/H4/JBdGKZSNrxpDLF4Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR16rAhBiPKjp8jJcOiq1DFYdcgLrj/MKTQp9NvLgvfYR9yR00vilXNehmfkcuXlkCKGB4Xxsj5LAd2TzIE3gX+oM4nlWLLAADN5LbQ94JGhEJj4UuVcKgDnQwVDMVCy9Jr+xfTjxrPJd4CLR7LjYjC3/Hhn9oiNVsrt5R3ARHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=c/LtLURQ; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="c/LtLURQ"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4Q9vuHxQTjZe54Q9wu7zaO; Mon, 14 Apr 2025 21:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744661521; bh=rzfCWcRIFQPvQcYrnJHbuNupdxhg7yEFICYo6S+LzDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c/LtLURQkiEE84XSlhQRcoon5tBV62ejwiXxPRgBfoP1ZHdjDnrcO+qd7eQgitaRT
	 GjIhQQN5POzQWUB2NVg98DuygYMSU1xSVLS9hIjEJmeKwVaBJCtIcSgd8OrKLcbrnH
	 TV6tbM7TlJZ0btVonDf7qgnI9dY/atzhupJixVlCLruG9NecL6XJOhJdl7Iy32SWqu
	 5Mu2Doe/DU5dQUZxQoQ/8omJb2K5yxPphs7qWJ3SStUKOLp/WvNs5wfyItHbGKPT22
	 WC5EIfuV82weqw8fh9CvSRIWqFwty5Q6/E4ourq5JONe4TAmYa1c/Fnl1pEUUuhZl+
	 SgdDXFAT2BXbA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=67fd6c11
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=HZnylHsdgAHxP7k-kBwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <fb967067-ece7-4791-aa43-65b95ccd4cac@ramsayjones.plus.com>
Date: Mon, 14 Apr 2025 21:11:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] Re: [PATCH v2 10/13] builtin/gc.c: correct RAM
 calculation when using sysinfo
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <a2eb9ab117c9a7ea8723c166739b30243388ea77.1743859985.git.ramsay@ramsayjones.plus.com>
 <Z_y_XL2C_Za5SB5m@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z_y_XL2C_Za5SB5m@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBEUkyzVl1ei5jRq8EnMW6Th5gcvjMpx/rm+jgLrsU1uo2MpI7oh8aSXEedx0fkWc/sHjYkUV58wn5R2Iwr9ygY2OFvPSGvKtENmcUU4sX1aDV2os0xL
 1XoSZf2VZtABzstt7NzIqZGYAP/lwIqIB+Zsub8bO/UFrKzoq1gaRXeiX7XkZJBdHhyFpkueSbBlH/FDSsy4/J/IMtGZwsxty3E=



On 14/04/2025 08:55, Patrick Steinhardt wrote:
> On Sun, Apr 06, 2025 at 08:38:36PM +0100, Ramsay Jones wrote:
>> The man page for sysinfo(2) on Linux states that (from v2.3.48) the
>> sizes of the memory and swap fields, of the returned structure, are
>> given as multiples of 'mem_unit' bytes. In earlier versions (prior to
>> v2.3.23 on i386 in particular), the 'mem_unit' field was not part of
>> the structure, and all sizes were measured in bytes. The man page does
>> not discuss the motivation for this change, but it is possible that the
>> change was intended for the, relatively rare, 32-bit platform with more
>> than 4GB of memory.
>>
>> The total_ram() function makes the assumption that the 'totalram' field
>> of the 'struct sysinfo' is measured in bytes, or alternatively that the
>> 'mem_unit' field is always equal to one. Having writen a program to call
>> the sysinfo() function and print the structure fields, it seems that, on
>> Linux x84_64 and i686 anyway, the 'mem_unit' field is indeed set to one
>> (note that the 32-bit system had only 2GB ram). However, cygwin also has
>> an sysinfo() implementation, which gives the following values:
>>
>>   $ ./sysinfo
>>   uptime:      21381
>>   loads:       0, 0, 0
>>   total ram:   2074637
>>   free ram:    843237
>>   shared ram:  0
>>   buffer ram:  0
>>   total swap:  327680
>>   free swap:   306932
>>   procs:       15
>>   total high:  0
>>   free high:   0
>>   mem_unit:    4096
>>
>>   total ram: 8497713152
>>   $
>>
>> [This laptop has 8GB ram, so a little bit seems to be missing. ;) ]
> 
> Interesting. I can confirm that `mem_unit` is 1 on my system, so this
> does not make a difference here. But my tests on Cygwin show the same
> behaviour as on your system, so the patch looks reasonable to me.
> 
>> Modify the total_ram() function to allow for the possibility that the
>> memory size is not specified in bytes (ie 'mem_unit' is greater than
>> one).
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  builtin/gc.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 99431fd467..cdcf1dc6e7 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -373,8 +373,13 @@ static uint64_t total_ram(void)
>>  #if defined(HAVE_SYSINFO)
>>  	struct sysinfo si;
>>  
>> -	if (!sysinfo(&si))
>> -		return si.totalram;
>> +	if (!sysinfo(&si)) {
>> +		uint64_t total = si.totalram;
>> +
>> +		if (si.mem_unit > 1)
>> +			total *= (uint64_t)si.mem_unit;
>> +		return total;
>> +	}
> 
> I expect that all systems have a proper value for `si.mem_unit` set so
> that we could unconditionally multiplicate the fields with one another.
> But it doesn't hurt either, so I don't mind the guarding clause.

Hmm, you may well be right, but I prefer to be cautious here.

Thanks.

ATB,
Ramsay Jones

