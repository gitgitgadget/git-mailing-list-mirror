Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43622097
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782616808; cv=none; b=pi0j0Q95nKDgG4l7G4l8KA4l12Ofknbyct+pP7icCwIAJbqIc0NVzY6xYfl4ubmgB6Q4ZHbKSld2wIbq8yyA4ZU2b55aeezjgRbQTQ+TfiH28BDSFsgbD1TaVvgPfoBio4ZZgcrLTXVHy8BOLPSj9PgOUJLyONCJR0RuCByid+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782616808; c=relaxed/simple;
	bh=ax0mSsY5G9qzQjkJM4IqeXK6SvWT15rCpXlkhZGQZe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlVAJc29iqc4xcvBG+wwg+NRLbuKfNpfp8TSkU2EM/ui83bvPQwxUeaJ2ZDFD+TmC2GHn51URL8cX5N8MngBiKNkghW564wdD0SgQ7C2ln9yf0HP6bX+33V5ERcMCn7bxdw39DmbYV0O49Ie1qH/5aQvyjI+AlhjjvF9/bD8ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=THxK4hsf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=2c5v3e97; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="THxK4hsf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="2c5v3e97"
DKIM-Signature: a=rsa-sha256; b=THxK4hsfUhKlQYKXH8mPq1m4no6c5IRT0iV8a67/9SOYKaZtDOBaXFWdAVndV5nq+kFGiOCYbCE+vePwNN8ZdMe9eTCft2pqFftNkH35li7MvZSw3/Gn6YqGhyswF3Qsd7VjFopFlPT1hHoaPmUpDQ727IIKa7ndTZChCQXQb/LaqnpsIJ5GZO2A/POa9TfV2PIfC3KrEJxz+n4C/H46fF1sXEEISYo7sFZzuRRu5b3mcUjyDgIPNvovhnpY2OeYS7Un2LEmxLCLcfltdVRATa8Za4v3CLXg5eNzBYraFEwbOZWjDCrApMm3n+vT/NU7hbOHd7nG7BEP9Y7VUVCq7A==; s=purelymail2; d=malon.dev; v=1; bh=ax0mSsY5G9qzQjkJM4IqeXK6SvWT15rCpXlkhZGQZe8=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=2c5v3e9702dVFi43Fbp+0+7XOIoisQkJeHxFGbkHyR03VdGmtjcpbBribo6wkQOsnSzqu1+MgRqgpFiZIMj4v5xy1BXoPQ8ZaGCs3zWOuFC8ESPs1gobkw01gkSIlFKVGHNa2kG27i+7lNwxPI51cxb6z+oERgDidcGWfYjuKQbV2XLPK41zh/+F9cbnRaYeZ2Vm8SB98ZUknHafjaMcpl3P2HfD/lb+ZkeMhkiwH9uke6F97NQtq5WscOJ0Y2b7/5QbQ1oVCpEo7tmoBtA8zKqD6hkg1HhBBYutft9MWc0OfYdb/1xitiIe3uw9C35YP0hDcBtf6rYVb5BS6LJJVg==; s=purelymail2; d=purelymail.com; v=1; bh=ax0mSsY5G9qzQjkJM4IqeXK6SvWT15rCpXlkhZGQZe8=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1708330416;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 28 Jun 2026 03:20:00 +0000 (UTC)
Message-ID: <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
Date: Sun, 28 Jun 2026 11:19:55 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260627160813.1074201-1-cat@malon.dev>
 <20260627160813.1074201-2-cat@malon.dev>
 <04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev> <xmqqv7b34snt.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqv7b34snt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/26 04:47, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Hi all,
>>
>> Apologies again for the duplicate...
>>
>> On 6/28/26 00:08, Tian Yuchen wrote:
>>
>>> +const char *repo_excludes_file(struct repository *repo)
>>> +{
>>> +	if (!repo || !repo->initialized)
>>> +		return NULL;
> 
> I might already have said this, but I am not sure why want to be as
> loose as this code.  It is not limited to this line, but I think we
> saw plenty of other "We know we must get an already initialized
> thing here, and the subsequent operation we perform on that thing
> will cause us to die() later, so let's return silently and early
> to avoid hitting die()" attempts to sweep problems under the rug.
> 
> Wouldn't we rather want to try to be more strict and say
> 
> 	if (!repo || !repo->initialized)
> 		BUG("repo must be an initialied repository");
> 
> here?  Aren't all the callers of this function supposed to be
> dealing with an already initialized repository?
> 

That makes sense, but from my point of view...

'repo_config_values()' already has a check for 'repo->initialized'. If 
we're absolutely certain that the 'repo' is initialized, wouldn't it be 
better to simply remove all the checks inside the getter and leave the 
judgment to 'repo_config_values()'?

This also aligns to some extent with the previous flag getters: since an 
uninitialized 'repo' will trigger a BUG() in 'repo_config_values()', but 
"reading and writing these flags when the 'repo' is uninitialized" is 
sometimes a valid operation that's why we choose to intercept 
'repo->initialized' _before_ 'repo_config_values()' and fallback to the 
hard-coded values.

This gives the impression that _'repo_config_values()' is the function 
responsible for checking_, and the way flags are handled is an exception 
to this approach, which I think is more consistent and self-explanatory.

What do you think?


> 
>>> +	if (!repo_config_values(repo)->excludes_file)
>>> +		repo_config_values(repo)->excludes_file = xdg_config_home("ignore");
>>> +
>>> +	return repo_config_values(repo)->excludes_file;
>>> +}
>>
>> One more thing:
>>
>> I deliberately didn't write a comment for the getter because it will
>> probably be merged with comments from the previous several patches in
>> some form in the near future... I'm not sure if it would be more
>> appropriate to write a separate patch to add the corresponding comments
>> then.
> 
> That's very sensible.
> 

Thanks.

regards, yuchen
