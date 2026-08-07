Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07833442375
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091449; cv=none; b=RalV2JagG73CAU8qBEk46sAWKgHita9BkavkfNBFHO16XDa6E02iUQE7BOTc3krj6oWU3wGlwjPCsunYGSAr5Zuy8exeCnyAZi2thbIkmZVody5Y1h/JsGyUTCPWmn6EXhjTxD1r5SChEmY4wSNm0DmbViK74oYN4dNpCn/4meQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091449; c=relaxed/simple;
	bh=+00HhpFNn0VqSrkn3qy0bhWPTt0BLnjaXeViCWRJMVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsHzXlRsXp+diKY69MVLx4fOF2hlMq2i58y4oPY3D77KDCvHBVu5glGOVNhmYyjgH+RP18fgrX1dZZbVq9rUTlsAJp6NoiXnfNirf1YXrOpUggRDhMd+22cppsPRk5ZZpEjRhCQFtjoCVtIZTeQIZ7aVQNvhZUfDJVQaUYh1Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=VUQQxZ9b; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dDT/sl0/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="VUQQxZ9b";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dDT/sl0/"
DKIM-Signature: a=rsa-sha256; b=VUQQxZ9b+6CmTpxmwyRkzAxaSql1aaBsAOXTLjBPx+i6w3uqxy+IpkjVCayuwZf9NRCVo9tjC8UhBWpRHcb7DRZEFiYJdVH+/S57AlvulaxycG4hRQ89RUCn1Bsd5QLeMnyl0nVFg3J/MegXeSCdcH97H3STqgdE9PxHiGmNPmDp+filqrjIJtpq6PIbBtwya05/Ki+UxnZMCsjD3np4Cb28PijeTvWmgQhLIg94Bkj+nuk4h0myDcoX5/LO9J89+5Ln275SesFwSxdpZjz/MIFvz4xIbUEBmtCJpFlUkHsPwCCR11qfk+l+BWY1TMevIombHDANrhZxxDb3NaCFGA==; s=purelymail2; d=malon.dev; v=1; bh=+00HhpFNn0VqSrkn3qy0bhWPTt0BLnjaXeViCWRJMVQ=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=dDT/sl0//e1+D0X7xpHAzz2nf4UM8QbB3TSQ2neKbVs0bZ05dyMb9dP4MufXBWrbtfbOpsrqp7FSJ9IbB9vxQxzpOcieMOhV+cJdFaB0bBdgTgiEjqsInJkOZ7DJkD0Nw12n1xqARtgY8BnBm9F/AR1q5JpvZ8Qz4Zco4JN1Rp0A8F60V1KAZyJ5W7MMff9VMOxitMnfqs235onYTdv2TVJu2go5G6BPaE2NSu8NAST/VbKQyxAEnmlY+Rk4R0W3uNgmYg8wLyCsdYe0/K8y25uM/s5GSXbRG1WsXq2epH7+LAlL/CLU4uhN8DiDt5jyPbD9CfosoUBGVTE+lLE6kA==; s=purelymail2; d=purelymail.com; v=1; bh=+00HhpFNn0VqSrkn3qy0bhWPTt0BLnjaXeViCWRJMVQ=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1081639929;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 07 Aug 2026 08:30:35 +0000 (UTC)
Message-ID: <46b0a9fd-ce30-4110-bd9f-b315ab4a09ce@malon.dev>
Date: Fri, 7 Aug 2026 16:30:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] environment: simplify repository config getters
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260806092557.3951208-1-cat@malon.dev>
 <20260806092557.3951208-2-cat@malon.dev> <xmqqv79nkxc3.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqv79nkxc3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 00:50, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Drop unnecessary parentheses and NULL checks in repository config
>> getters.
>>
>> These getters are only used with non-NULL repositories, so the
>> extra checks do not match their current callers.
> 
> You would need to explain why it is sensible to enforce on future
> callers the same rule that current callers honor, or why it is
> unlikely that we will gain any more callers in the future (which
> would justify catering only to current callers).
> 
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   environment.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/environment.c b/environment.c
>> index 76ee65e62b..f5628b6758 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -119,23 +119,23 @@ int is_bare_repository(struct repository *repo)
>>   
>>   int repo_protect_ntfs(struct repository *repo)
>>   {
>> -	return (repo && repo->initialized) ?
>> -		repo_config_values(repo)->protect_ntfs :
>> -		PROTECT_NTFS_DEFAULT;
>> +	return repo->initialized
>> +		? repo_config_values(repo)->protect_ntfs
>> +		: PROTECT_NTFS_DEFAULT;
>>   }
>>   
>>   int repo_protect_hfs(struct repository *repo)
>>   {
>> -	return (repo && repo->initialized) ?
>> -		repo_config_values(repo)->protect_hfs :
>> -		PROTECT_HFS_DEFAULT;
>> +	return repo->initialized
>> +		? repo_config_values(repo)->protect_hfs
>> +		: PROTECT_HFS_DEFAULT;
>>   }
>>   
>>   int repo_ignore_case(struct repository *repo)
>>   {
>> -	return (repo && repo->initialized) ?
>> -		repo_config_values(repo)->ignore_case :
>> -		0;
>> +	return repo->initialized
>> +		? repo_config_values(repo)->ignore_case
>> +		: 0;
>>   }
>>   
>>   int repo_trust_executable_bit(struct repository *repo)

I see, will change the commit message then ;)

Thanks, yuchen
