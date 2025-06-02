Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5572C325B
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840721; cv=none; b=O0FqbKPEOcuFH/t6k64Kope2Pc370573F+CgxJY0w3X62PTK2cdEyxJaOtXg5BFVJM3P4krGn0+rk4vX4X/WTZM2KHYlczKT2rdNXtAbDcCIu3IzlpEAt3lY82USC7ZJ81BQO43t8MJxnyu78IibZCEQoWHsJ9eoM8tFt5Avbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840721; c=relaxed/simple;
	bh=1mtT7SCjng7GEHzqquobkTz2vv1NV3pGTiFKhCrVfAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+UTs/+Gu3SLAsAM48wV6UBb8URp1bCcWqcsuS1SN4ybx3qu0+yB1VQsM2fPtxuMC0knG3PZX0O+rv4C5zIGuF5CEc9e0zEduD5tjn6GX+rCaSGQGVWvcUcaTnN6Stdrx/+XLe164TqPGPojhUEj3WzAGje3X7EcIBhrLaEhDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=lFk/9MdI; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="lFk/9MdI"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4b9hcC39Zwz8PbP;
	Mon,  2 Jun 2025 01:05:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=1mtT7SCjng7GEHzqquobkTz2vv1NV3pGTiFKhCrVfAI=; b=lFk/9MdIMtfz
	3pahp+jaELpywQKX6JuYm1k96R/On5PkNliRk1COSFKFWyYl1xz1QBPfvQW7TbHh
	BxTCzlzpggnk9gwbvQqpP970R/g1RqeHZkSlOhA0ud/R5rQDoDOUdoI2We15zz+e
	OvLKvpOYey97WIe6HYvAQ4vvQUSAbPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=Sp4
	NxAEIdKH7y3yCZG1dMxrkzC979VGbfxcRmeYV9LjZZ6qCtT/KC8ZdIVtiGewhSjo
	TxV9ELpdijbNZSKSjO2N1gUuc94BO9HypG4JopdtG2g/uAg5H7MWHCYMN59sB6Wg
	6On7TWLiUj2B9NvwnhdvHSt82h+UNSSnvGZiJ/Hw=
Received: from [IPV6:2001:470:b050:6:cc31:46d5:f26a:a82b] (unknown [IPv6:2001:470:b050:6:cc31:46d5:f26a:a82b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4b9hcC2bGmz8PbN;
	Mon,  2 Jun 2025 01:05:15 -0400 (EDT)
Message-ID: <3ef13594-41a7-4455-bec5-3da6ff517341@comstyle.com>
Date: Mon, 2 Jun 2025 01:05:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: update settings for OpenBSD
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com>
 <xmqqldqavis7.fsf@gitster.g>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <xmqqldqavis7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-02 1:01 a.m., Junio C Hamano wrote:
> Brad Smith <brad@comstyle.com> writes:
>
>> OpenBSD requires DIR_HAS_BSD_GROUP_SEMANTICS.
>>
>> OpenBSD has never had the BSD sysctl KERN_PROC_PATHNAME nor
>> does it support or use the /proc filesystem.
>>
>> OpenBSD has had strcasestr() since 3.8. OpenBSD has had memmem()
>> since 5.4.
> ;-) Thanks.
>
> 5.4 was from Nov 2013 if I can trust
> https://undeadly.org/cgi?action=article;sid=20131101142807 and it is
> about time we adjust ourselves to the more recent world order.
>
> Will apply.  Thanks.

Yup, that is correct. For us that is 23 releases and over 11+ years old. 
I think
we're good.

>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   config.mak.uname | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index df172d5871..5a0b4200c3 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -301,17 +301,14 @@ ifeq ($(uname_S),FreeBSD)
>>   	FILENO_IS_A_MACRO = UnfortunatelyYes
>>   endif
>>   ifeq ($(uname_S),OpenBSD)
>> -	NO_STRCASESTR = YesPlease
>> -	NO_MEMMEM = YesPlease
>> +	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
>>   	USE_ST_TIMESPEC = YesPlease
>>   	NEEDS_LIBICONV = YesPlease
>>   	BASIC_CFLAGS += -I/usr/local/include
>>   	BASIC_LDFLAGS += -L/usr/local/lib
>>   	HAVE_PATHS_H = YesPlease
>>   	HAVE_BSD_SYSCTL = YesPlease
>> -	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
>>   	CSPRNG_METHOD = arc4random
>> -	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
>>   	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>>   	FILENO_IS_A_MACRO = UnfortunatelyYes
>>   endif
