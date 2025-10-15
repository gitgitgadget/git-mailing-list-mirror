Received: from mail-108-mta86.mxroute.com (mail-108-mta86.mxroute.com [136.175.108.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71060261591
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537880; cv=none; b=a2RTk90nzVYJBCOtDLXSipqXkdajyq7HM/+LtFAzaNPhTRgUzIQgF643EfrK3rFzmdfYMexeTa9BJGHlK0uQS7NnrLX/EiWgcfMu66JhSfV3FMPwUZbspGQbR8TgcDlyJNojYGLLwBe7Y1k66PndCI1JCHsZ7iRWmrxRh5d44tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537880; c=relaxed/simple;
	bh=8YBG0r9vq8s85WzYaJblS6OTXyfn8gV41sgnC+jeC4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TDpcWitgK/LyDQwmU59SBzt20AG9tEaqZsuJuDk/2AYoGZq0wCs2UU8CTMQ1M6dKVIzmgFJiR0dkbsNMzucvUVKS/LoL724AKos2rt2sSdxBAe2LYsw2pPfguPty/gy2FtWr9heHTA7huTkOVZooaptNz829H9ojtFRKvD942SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=qfiixkWO; arc=none smtp.client-ip=136.175.108.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="qfiixkWO"
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta86.mxroute.com (ZoneMTA) with ESMTPSA id 199e8374341000d597.005
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 15 Oct 2025 14:12:39 +0000
X-Zone-Loop: d45b1088e9c965302de1f1812eb516a070d0830ad6e0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nZHoI42vnlVtaPDuvfCH3OO3vINQNAIlDpVdcobK6A8=; b=qfiixkWO6M7YMCCi4uf4RU3kKx
	IW7TCNuaaR0QmQf06XT02v6GtwhfXymH3UhGhg+3yzwCPlsTrFFxqApK32Q9tSUgxvjyeygQBrbEV
	ZFhBLAsuljerWLmxBJ6sJNPO8AFtQMhZOy48Ebu7uBIED0ffv4GpV7n3Z0dC0Sm3U1bYokmwkJxML
	CZTP3d0Q53Yrk4IWqNeU+CfP2oescU9e5Jg2GspZQvzzEGBEayDWBueZgQzU17/MpIuYmP/Tq3SoW
	y0f1JqL7oDfWy5d5HpETH2GCg2Z0IVMaT5wWr9lW+ZexZ4nTymTdx2Kxmtnve9g8isZl5poAsKq3R
	08NOfshw==;
Message-ID: <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
Date: Wed, 15 Oct 2025 19:42:09 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] http.c: prompt for username on 403
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: info@ashlesh.me


On 10/15/25 02:59, brian m. carlson wrote:
> On 2025-10-14 at 14:43:52, Ashlesh Gawande wrote:
>> Scenario:
>> - There are a few pre-production systems that a lot of testers and
>>    developers need to time share because of low availability
>> - Devops generates a GitHub token with pull only access
>>    and adds it to the netrc file on these systems
>>    (Pull only as we don't want testers/others to be able to push)
>> - Testers log in and do a git pull for the latest changes
>>    (via netrc credentials - though testers may not be aware)
>> - Developers login to debug issues and may make fixes to the test repo
>> - Now when developers try to push their changes they receive:
>>    fatal: unable to access 'https://github.com/<org>/<project>/':
>>    The requested URL returned error: 403
>> - The developer is not given the chance to supply an authorized token
>>    and either needs to comment the netrc file or copy the changes over
>>    to their own machine
>>
>> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
>> ---
>>   http.c                     |  2 +-
>>   t/lib-httpd.sh             |  9 +++++++++
>>   t/lib-httpd/apache.conf    |  4 ++++
>>   t/lib-httpd/passwd         |  1 +
>>   t/t5550-http-fetch-dumb.sh | 24 ++++++++++++++++++++++++
>>   5 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/http.c b/http.c
>> index 7e3af1e72f..18959f63b9 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1852,7 +1852,7 @@ static int handle_curl_result(struct slot_results *results)
>>   		return HTTP_NOMATCHPUBLICKEY;
>>   	} else if (missing_target(results))
>>   		return HTTP_MISSING_TARGET;
>> -	else if (results->http_code == 401) {
>> +	else if (results->http_code == 401 || results->http_code == 403) {
> I don't think this is a good idea.  Existing servers send a 401 when no
> credentials are available and 403 if credentials are sent but are not
> valid for a repository.  The former case causes credentials to be
> erased, but the latter does not.
>
> Your proposal will cause someone's credentials to be erased just because
> they don't have access to a repository, which would be bad because it's
> not that the credentials are invalid (that would be a 401) but that the
> credentials are not usable for that repository or for that operation.
>
> So if I attempt to push to https://github.com/git/git.git, then my
> credentials will be erased even though there are no valid credentials
> that could possibly grant me access to that repository (because I'm not
> Junio).  Then _none_ of my pushes work because my token is gone.
>
> I agree that it's inconvenient that netrc credential override other
> credentials, but the proper thing to do would be to (a) not share
> working trees among users (since Git's security model doesn't allow for
> that), (b) not use netrc for this purpose and use a credential helper,
> (c) add functionality to disable netrc via config, or (d) use an SSH
> deploy key for automated systems with `GIT_SSH_COMMAND` and `ssh -i` and
> have developers forward their SSH agent to push.
Oh I see - yeah don't want to erase the credentials.
Was trying to figure why 403 was happening instead of a prompt (as I was 
not aware of netrc file being used).
Thanks for the detailed explanation and suggestions Brian!

Is it worth it to include the netrc tests in git that I wrote as part of 
this

(if so I can email them as a separate patch)?

Thanks
Ashlesh
