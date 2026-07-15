Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EA188596
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784091494; cv=none; b=PRCSyq7QjqWvl3ndOkjeY8gvwPXDIQWmCF4xnaSPLx4cFeCgO1LQxU/DZi7Efi7EQjGGRGh2EXXnspgdlxKyho9zaueg9CgMkF57Mb0015KSPar+5fRdAlSJYdwJ6wSxwGs+JNrnpgKUPHA721jV3hRSCuNJ/89UqsXAZr3UNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784091494; c=relaxed/simple;
	bh=3OP+8PHvhRF3fDtqKx1srVVeO5NZT07fg8t1NWCDKZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ4yVVwu/uTWogy6ITzFc2gPiN+ToIq7t6ezu3B6yRdO262eyKZsV0nSRodphYYpRUdSKcfq75Gbrecd88ZqaUsutmn3PXIE6fudOiK5Uix1vtr8EjWpKMVl9WSBIAa7aHuIOeCXHMGClwBjrAdDgxxVE5WH2VAb6S4+qshEeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ZCyjmrG+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Ey2Y5g7i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ZCyjmrG+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Ey2Y5g7i"
DKIM-Signature: a=rsa-sha256; b=ZCyjmrG+747koM8fg02L6189VXkPVgcJJkqmhP0VhKVhXtlDxCNxLtDUubOzrSzooVNrjxlZMbJJH26Vi1NTCrslJuVppjx3kedUHLMdnEDF5KizWa+/53ztwd5Ii92TuiSgclqbtCYF6e3WTYcf+pRiJz67ewbBxGGv0LW/3kkfuYQEToZmLwxqcroz7zU1mi2SCR/yrsnt0329/AxwwFnyLgFEkv+W8QMHrqshg6kZLePZPgyQXLBRGWLHy1dHUrBGbyglTIehMUAplJAMjrYPTAobzMB1i+cD3MTg4XkFXmphvbiasjkSp+t2kwO9IaOynZEZMN5X73yzWxtxDQ==; s=purelymail1; d=malon.dev; v=1; bh=3OP+8PHvhRF3fDtqKx1srVVeO5NZT07fg8t1NWCDKZU=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Ey2Y5g7ifSIIRHhlkcbMYvcb+pXoHpFzNaP2LeLXMFkoSf5luUT4Y7KfiKEj5s1gJfqL/iPzZi8zy0uKV1NOTFG0M1KR+15v6YpBLQNd+75Knl4PxiCcHgbJIvRx6Hp+y0VKG+TziB3DBp8oHVkZdbWmAAVwufPHxZrIzYZfW7KSYN69FrO3TxzcgMVVwNYuJlQ4KND7814RdYOqSAiBKxshzSlLAOL20iIteFzCKqNPhaR6RuU7p/RqLNUEM0yLkLX4q2u8wZjKETtDCqML12gwHG/QFCQINNzEZDelNpWCaUtlJvSySCM+E442rLaKLyv6f+OK2E16GIbe58KG/Q==; s=purelymail1; d=purelymail.com; v=1; bh=3OP+8PHvhRF3fDtqKx1srVVeO5NZT07fg8t1NWCDKZU=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492688028;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 04:58:09 +0000 (UTC)
Message-ID: <9914b6d6-9876-4c81-bd89-0f6eaf070e9d@malon.dev>
Date: Wed, 15 Jul 2026 12:58:05 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, five231003@gmail.com,
 hariom18599@gmail.com, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260715011850.3181131-1-cat@malon.dev>
 <xmqq5x2hq6eb.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq5x2hq6eb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/26 11:27, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> The global variable 'fetch_if_missing' controls whether a missing
>> object check should prompt a lazy fetch from a promisor remote.
>> In order to continue the libification effort, move it into
>> 'struct repository' and initialize it to 1 by default to keep the
>> previous behavior.
>> ...
>> diff --git a/setup.c b/setup.c
>> index b4652651df..ce2a80ac31 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct repository *repo,
>>   		set_alternate_shallow_file(repo, shallow_file, 0);
>>   
>>   	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
>> -		fetch_if_missing = 0;
>> +		the_repository->fetch_if_missing = 0;
>>   }
> 
> Could a caller pass a "repo" that is not the_repository?  In other
> words, shouldn't this be
> 
> 		repo->fetch_if_missing = 0;
> 
> instead?

Thanks, will change in the next reroll!

Regards, yuchen
