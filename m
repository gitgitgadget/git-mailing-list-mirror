Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C90189F43
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047363; cv=none; b=N5450JXezt4mDZRl828/vKfKaRxylWrsNujMiPyLDHDRoasZXIqH2ivKwwqNZkcAw0W46nO3uH4XnTeVcSuzRalPgdigEMQVgWpaQnYEjaeDKaiGjR6DCZR4lWZHayle7gRGLrO8lOfX9zRwzf6PfxyDhq1h6YaBtIckxAiYe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047363; c=relaxed/simple;
	bh=knqY9IfBmSAga0MD/ZxDmpso28OBfQkyQlZZzVZ1L2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUJgYmtWXtxrXrtzhbpg0sOJ6fLurFmo9TulC7Xx/lF/VCmbaddwohvTXu0SCtN8HYoSyuTPEpe+VCe4MuHW8FBCX3+9jaOrS1LH3UP0gHUX4eEKBDP7gV5qM+8GIkrt1XrTN3LVZfucCybFkDiu0ZhXaza9GJ6Qhzi5uPHvMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=qAQEEcs6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SdxJXSgj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="qAQEEcs6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SdxJXSgj"
DKIM-Signature: a=rsa-sha256; b=qAQEEcs6CXTvJk+ppyQXEJxtMGgNQ7UJs2SMmy8w5qDkZGFsGSr3a1e0U2/7/OMvs0m1mZaRwE6KhgmVys1U6ZYA+6tHFb5DBQCmX+2Z1S+jz6EgLJidQZRQ4M65RbfsMRgXsY8/R43sZX0d3LVVvlZSyCe64pDinl1tvSpBwgThY/5rLq55o9Zvke6vk91cSS3Iy8ioDRTTSGTRIVXnuskAICosdof2stzpsAClpep5Dj0ZzYVyze8dZMOLBZCGFWpe8ii5PXXv1G9tGTlg3Uk5ea7ca9dah9aW3pkIUT5vKk4cp8zpOPouBuy9EVr1S+JFrTDmYsCrNTuw+V8aCg==; s=purelymail3; d=malon.dev; v=1; bh=knqY9IfBmSAga0MD/ZxDmpso28OBfQkyQlZZzVZ1L2s=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=SdxJXSgjJSxZzafO7dI0O8+sVAGNCZLUUvVacsR0+MdDAU9Jlxt9AhecXrwsXqlRRUs/IPHVxsdVSTbVWBHywAOlsqNDtieY7EgEQ4WCTCOzEf7q5guZsprVaTnfucy6+A8UeD4p1VwGlsMaDpKhh28R1EbCrxQkNwALxClpu5qhnnfLSU/sai6p95CgiBJWJ8xiootUYT+kInY1AWoehZ5OTx2hOJsIEsv+PifAIApnbMXGDTVHZuDeShDRa1pZ8YamK6OnBnDZ9Y/CbqTJzny68g4FSKfyC0BzJZYNqp2wk8B1brinI+9r9mSY9E+SKSbc88476hBExdtlOwL/ZA==; s=purelymail3; d=purelymail.com; v=1; bh=knqY9IfBmSAga0MD/ZxDmpso28OBfQkyQlZZzVZ1L2s=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1586991208;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 26 Jul 2026 06:29:13 +0000 (UTC)
Message-ID: <ab900bd2-0524-4122-8bb7-e3f57b0a86fc@malon.dev>
Date: Sun, 26 Jul 2026 14:29:08 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] environment: migrate more global variables, pt.2
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, newren@gmail.com
References: <20260725115428.2214202-1-cat@malon.dev>
 <xmqq5x23ypcf.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqq5x23ypcf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/26 01:02, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Hi all,
>>
>> This series moves:
>>
>>   - (1/3) minimum_abbrev and default_abbrev
>>   - (2/3) pack_size_limit_cfg
>>   - (3/3) assume_unchanged
>>
>> into repo_config_values to continue the libification effort.
>>
>> Note: in commit 1/3, we need (repo != the_repository) checks in the
>> getters, because some subsystems where the readers of _abbrev
>> configurations live forbid the use of 'the_repository' and only accept
>> 'repo' [1]. We have to explicitly intercept those intances that are
>> not 'the_repository'.
> 
> Sorry but I am not sure I follow.  If a repository that is not
> the_repository is not yet allowed, shouldn't the caller be flagged
> for passing a random repository that is not the_repository as not
> conforming to the API (yet) with:
> 
>          if (repo != the_repository)
>                  BUG(...);
> 
> rather than papering over the issue with an unconditional
> 
>          repo = the_repository;
> 
> override?
> 
> If the API that deals with this 'abbrev' setting needs to call
> another API that only superficially takes any 'repo' parameter
> without supporting anything other than the_repository, isn't that a
> sign that the other API needs to be extended to work with any 'repo'
> before the 'abbrev' part of the system can use it, simply because the
> former is not ready?  Futzing with the 'abbrev' part of the system in
> such a state piles on more unfinished work that will need to be fixed
> later without achieving anything, except for the superficial "now
> this part too can take a 'repo' parameter, even though it does not
> support anything but the_repository", no?
> 
> Puzzled...

I was also wondering if doing this was appropriate... Since that's the 
case, let's not migrate the _abbrev variable for now. I'll expand this 
series, migrate some other variables and resend it when ready.

Regards, yuchen
