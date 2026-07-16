Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AA3587A1
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185628; cv=none; b=BmuHrWvzgVPChkRNfyWZ5al+4a4zvhttBR9kgCpTeVsOri6Zds2lkZqXwCrv0jYBzWc20Vl6/Xlt824ql9XNXw4NL9mDihWTSGqZpqlqrJ6GNljSwXAs0wszmYyQ1+gk1nTGnOJN8cykPKUovau+cBCYT4c8P8q5ARdo3u4h5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185628; c=relaxed/simple;
	bh=bHuqowIYJPccidTY/3CTnHfSwsIRgXXjNFqjqCQR9Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD6cSbs0xMXCpMasrQt/xBDsA9RLCSiVBhCj2A38HHweMxdMFI0H2BtexyYkso0dv1dWXuN/BBc+H3DmWMSYhmMRzI2u3FUDHjMJOLZm20MnGLWv2/nK4PybeUXAwAKG87XrGah8YMFxSdgPY48zhuGM48OHFS4sYY4Hd6o693k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=m0DfptGE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=oy9Bx9z2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="m0DfptGE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="oy9Bx9z2"
DKIM-Signature: a=rsa-sha256; b=m0DfptGEsP6cot+8mS4PXLe1w+9Ot3fMdGQuM2MdZMdA1mtXSyTA6+q86O9QjSUirnXDD8SZzrVb+2R2Q8ImqQQ3KiTo9T8RYQUR/pwnum/F85Lar7FZAJUfmuhwKckgyLkthdLjDutmcDfjyVxjVE1i8xiFFHHJldKKzuVlB4y4SJ5gaOOI8oMNw+u5pGOvaP8D8krz98tgCUwgj2EPI/KA3kx7Aol47lTV0IhbHfysBoM31TtsfnBoad6rgjLoJqFCmbn60Sh0/OKsBKOwZF+ym+2CuHSdM/kuqPTb0SvIObODzifavOUdGg3zut0PQsZF7UK2FGOsQ/lxaR4EBQ==; s=purelymail2; d=malon.dev; v=1; bh=bHuqowIYJPccidTY/3CTnHfSwsIRgXXjNFqjqCQR9Ao=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=oy9Bx9z2fD40+PYsh5VdfUukTbr2pQ/UH6wRcFMkGjbDhWE4EOYUqckV/6/BfdnNV2NON0usZBWN+RKDKF8gIo/HC66E0fqr5Hpp97VZKLrh05VdLPFbgnHA6jkUitBhn5Gs+47qupA/4ImqciklqMbJ78kEK4FNfl0vRslSgDcQ4aUwUFry7lPfYY0hYVaY/Vj4Ya0bai8dUISpxdWzz64xd7d1GihztOo5NIRxHNACScSFOXV9ir1YG9+OdOcv9FUInka3VSLbMRHh7tVhVt2IGFgXirhUM21WYjPGYuKcqsZJb54Qh3743/XScAqJe8xL8WUgHoCtnFEj9McYKQ==; s=purelymail2; d=purelymail.com; v=1; bh=bHuqowIYJPccidTY/3CTnHfSwsIRgXXjNFqjqCQR9Ao=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -430532840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 07:07:02 +0000 (UTC)
Message-ID: <ceb95555-d2fa-4877-9e46-eccac5db61d7@malon.dev>
Date: Thu, 16 Jul 2026 15:06:56 +0800
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
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, five231003@gmail.com, hariom18599@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260715011850.3181131-1-cat@malon.dev> <alcqQp0lkwRIIE1t@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <alcqQp0lkwRIIE1t@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/26 14:35, Patrick Steinhardt wrote:
> On Wed, Jul 15, 2026 at 09:18:50AM +0800, Tian Yuchen wrote:
>> The global variable 'fetch_if_missing' controls whether a missing
>> object check should prompt a lazy fetch from a promisor remote.
>> In order to continue the libification effort, move it into
>> 'struct repository' and initialize it to 1 by default to keep the
>> previous behavior.
> 
> Right. I was also thinking about moving this into a non-global scope
> multiple times. I was approaching this a bit differently though: it's
> ultimately a property of the object database whether or not we want to
> accept missing objects, so I moved it in there instead.
> 
> I don't really think there's a downside with your version, though. Quite
> on the contrary: we can really only perform the backfill fetches with a
> whole repository at hand anyway. So conceptually your version might even
> be more sensible.
> 
>> Subsystems that already pass around a repository pointer, are
>> updated to read this flag directly from their respective 'repo'
>> instances. For the rest, we access 'the_repository'.
>>
>> Note that in builtin/fsck.c and builtin/index-pack.c, when running
>> related commands with the '-h' parameter, the 'repo' pointer is not
>> passed in. To prevent null pointer dereferences, we defer
>> operations on the repo in until after parameter parsing is complete.
> 
> s/on the repo in/on the repo/
> 
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 0793dc595c..721d576938 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>>   	int report_end_of_input = 0;
>>   	int hash_algo = 0;
>>   
>> +	show_usage_if_asked(argc, argv, index_pack_usage);
>> +
>>   	/*
>>   	 * index-pack never needs to fetch missing objects except when
>>   	 * REF_DELTA bases are missing (which are explicitly handled). It only
>>   	 * accesses the repo to do hash collision checks and to check which
>>   	 * REF_DELTA bases need to be fetched.
>>   	 */
>> -	fetch_if_missing = 0;
>> -
>> -	show_usage_if_asked(argc, argv, index_pack_usage);
>> +	if (repo)
>> +		repo->fetch_if_missing = 0;
>>   
>>   	disable_replace_refs();
>>   
> 
> Okay. This command can run without a repository, in which case we'll end
> up just indexing the pack. My assumption is that we'll probably end up
> using `the_repository` if so, as we still use `the_repository` in this
> file. So could this here cause a change in behaviour?

Hummm...

> 
> If the answer is "maybe" I'd propose that we simply continue to use
> `the_repository` here.
> 
>> diff --git a/revision.c b/revision.c
>> index e91d7e1f11..bb645654c3 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2714,7 +2714,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>   		revs->ignore_missing = 1;
>>   	} else if (opt && opt->allow_exclude_promisor_objects &&
>>   		   !strcmp(arg, "--exclude-promisor-objects")) {
>> -		if (fetch_if_missing)
>> +		if (revs->repo->fetch_if_missing)
>>   			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
>>   		revs->exclude_promisor_objects = 1;
>>   	} else {
> 
> This one here also makes me wonder whether it could cause weird
> interactions in case a caller passes a repository other than
> `the_repository`. It ideally _shouldn't_, but it's hard to tell because
> we still use `the_repository` in lots of places here.
> 

This makes sense to me. Let's use the_repository then.

> Thanks!
> 
> Patrick

Regards, yuchen
