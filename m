Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28E25783C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999187; cv=none; b=J6SCAcHVZ7qUpBS62J4IPkA6NksozM6/uTIrVB5+FTJ5l6MXihQXT5ZxPTL9i86JtYa9Q2zYK2v8hX6wZJjNh6EEwzuwWt2VRhK6A0KJsFhIJYF4pE2RyEG/TCO71qVl5rJA5pzDpAp7+VJ2YseOTJ7dauQrYrVWHkriAln0OZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999187; c=relaxed/simple;
	bh=87UUNd1qQyCK/uxyENhbOHQac8cs/jlNwb7xJtDPYHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPdvaUVqkiZGXYeIcark4NKORnFaTrwhYCnGIaqIqxk4swGMJ0G/wxliP1ljaqeNYhUFoJQLdOE+EVhGKI3Ytp6pSBiTO7oGRfjeqJi+24yi23p0BwttkuGYXMvO3PRWU5uFy1t/+EeGsJSirWeRwav1L6af3sESLcioOosw9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=MnqJ9yK0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LE4yHduE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="MnqJ9yK0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LE4yHduE"
DKIM-Signature: a=rsa-sha256; b=MnqJ9yK0zOxq+f+PasLMUgc05t6qKGriXI64Aj4fUnPOs+p2sTIf0XnCmVE30IEajn76XMSxJgZDmIUhzJJNkfBf+A/NkBccFAn9uvBFpp/vo+FyQh9C5fgb4KhQ7GmrMUXWCR5GbinpM4Oi3VLmmjih8E2tnoW5YOgahmrIiBDVdUAUU9OcbDCmpwhRArtP8M8679bSCOPXPrrJ9/gIbHBnXjRs/MAdTVfS3Qk6uSWIcyhjrrdkl18CTp2p4bfjDpfxTK1tFnsSbINHUercxRJACDnZ0mKoQGcapZrb74yOjDtZOJqflyDvl3OyqgdvWwFz2j1CCi8mG2hrHXq1LQ==; s=purelymail1; d=malon.dev; v=1; bh=87UUNd1qQyCK/uxyENhbOHQac8cs/jlNwb7xJtDPYHQ=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=LE4yHduER6gioWlfetAD6QOyy8ki4u3+speWIWsuoP87fu1K2ymZMUpBZMxBZfbe190w2QEJqHrwwWwrX44xjz9ka4sBqURm22qxd4B6/qHG9e6WK8Wf7ClbNpJLyOsjIIekI003NQw+tNFqMIhJ7dcR6sXZfshKAvkOklpqtJ7djQr4nnh2Dnnj/27H65CPTCZxKfzbkSp1itkCXbYANJBDsueqZX3rmziB/uyerpcblgjREwrCPZyoUkSof5JmPWwj+OJ3/mRoXTfNDGcEzwCo2wHTGcLz1gq2BSJlYJ4Ym7jdgBcKzFXZJVhbylmuWT9jCraIAfCOxZhLgMzsgA==; s=purelymail1; d=purelymail.com; v=1; bh=87UUNd1qQyCK/uxyENhbOHQac8cs/jlNwb7xJtDPYHQ=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1097288267;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:19:42 +0000 (UTC)
Message-ID: <61ef1b0a-72e8-45b3-b6e8-46eb5b34ea91@malon.dev>
Date: Tue, 14 Jul 2026 11:19:37 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace
 and apply_default_ignorewhitespace
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, pabloosabaterr@gmail.com, cirnovskyv@gmail.com,
 szeder.dev@gmail.com, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260713035738.1606138-1-cat@malon.dev>
 <20260713035738.1606138-7-cat@malon.dev> <xmqqa4ruyhbh.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqa4ruyhbh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 00:39, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
> 
> Are there patches 7..10/10 posted somewhere else?  I didn't see them
> in the thread (neither did "b4").
> 

Oh, I didn't notice that:

	Died at /usr/lib/git-core/git-send-email line 1665.

Will resend very soon.

>>   
>> -static void git_apply_config(void)
>> +static void git_apply_config(struct repository *repo)
>>   {
>> -	repo_config_get_string(the_repository, "apply.whitespace", &apply_default_whitespace);
>> -	repo_config_get_string(the_repository, "apply.ignorewhitespace", &apply_default_ignorewhitespace);
>> -	repo_config(the_repository, git_xmerge_config, NULL);
>> +	struct repo_config_values *cfg = repo_config_values(repo);
>> +
>> +	FREE_AND_NULL(cfg->apply_default_whitespace);
>> +	repo_config_get_string(repo, "apply.whitespace",
>> +			       &cfg->apply_default_whitespace);
>> +	FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
>> +	repo_config_get_string(repo, "apply.ignorewhitespace",
>> +			       &cfg->apply_default_ignorewhitespace);
>> +	repo_config(repo, git_xmerge_config, NULL);
>>   }
> 
> OK.
> 
>>   static int parse_whitespace_option(struct apply_state *state, const char *option)
>> @@ -126,10 +132,15 @@ int init_apply_state(struct apply_state *state,
>>   	strset_init(&state->kept_symlinks);
>>   	strbuf_init(&state->root, 0);
>>   
>> -	git_apply_config();
>> -	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
>> +	git_apply_config(repo);
>> +
>> +	struct repo_config_values *cfg = repo_config_values(repo);
> 
> Doesn't "-Wdeclaration-after-statement" complain on this, declaring cfg
> after calling "git_apply_config(repo)" on the line before?
> 

Nice catch, thanks!

Regards, yuchen

