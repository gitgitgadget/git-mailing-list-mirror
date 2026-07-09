Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294D2DCF74
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613571; cv=none; b=PuhLRsSkG+qbjD0DPBLeXS0Sa5wgLnRBgpZMA+RPENT9ghuRUX5lYrow/8v0I5XaWEL1vg1vjpbIGFZI95TJMuS3FyjGd4FYI39lCPsoTWArmR45uQ5Cv4/01E2teDC12wBSQBOllER4CNBJ9umMpMCZmQtnJqLys3HVRam2nJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613571; c=relaxed/simple;
	bh=UnhqYWWQSBr1GerGDsjddfiBy5h/ZG6+sFE9E1MgdMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ituolAH1HkzgFNbkUsvgwCNCoURFyDEqHCsZRc5z+rhj9xUCAf7cnDMZSHI86PiHeJ+RfD3aWop3TFq6XFpt+l/wBuIUdpF9f1H2+lhjvBc7sXXpQQYz00CvDUGKXUttsB87uczHkI01bWqvgNIEiM5QLNX7Gqpiy55DOTWURos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=LbLoylK+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=X1Yvkn9i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="LbLoylK+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="X1Yvkn9i"
DKIM-Signature: a=rsa-sha256; b=LbLoylK+inW1IWiHiWTMK4hf9aEcRmJj/9besgPtzvmIj7KN8p0NkjNYDJY21Xwyy5R/juYaEgFj8zsIhtbQ/MQh3aqF337VftfVP4erQYZFVuMjqRyZqin0XNft7z73aVKTUNbE9LD8X82kPejsx2SNWdQUNyrP5pqJeF5UBNvMA2PyHtDGj4z2I2QAJrxYYBFgpUJKk73Pyhm/u9yKpxK6NFBN3i+rIspTQwijyX8miOZGDPsAlk2f5NlJx1dE5llDqDsCnyvZ4cTYq7rYnv8NiiWyCarDUx6g2+ITb7oOdI7CpkBzZUHg4X/3IhMFrcioj37vU3PdprlzwHKcOQ==; s=purelymail1; d=malon.dev; v=1; bh=UnhqYWWQSBr1GerGDsjddfiBy5h/ZG6+sFE9E1MgdMA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=X1Yvkn9iQai9MBKSNSQuCd+liQPyQEZuLp3XKVPv9X9HGQ91+9hpBjJo/7cllmD1HIpMclEUgvheP3LUj0KkHRHQA+I7Jo20evvX7A/drLNeGrKXbvcLiqjtsr2Lw3gn7zSKDBL5gm/qR6rmf8klahmB9Z9fWeAATUyrk7zQrz+v0MrEXAQEzK/GKLIImYmF3b5UdlHOIPAx6WYjaTOUq0/wdIDIiJrHgPXrbwnwA0AzFRgOiki2PkGxQJb4eeGB1dOjWMKCtkvUXi51CncMZk06ANS3oJA9nnOKnr5a50QYOu/KMgMH81EE/QXU4jdo9tEE1mirRS85YAdho0a9Zw==; s=purelymail1; d=purelymail.com; v=1; bh=UnhqYWWQSBr1GerGDsjddfiBy5h/ZG6+sFE9E1MgdMA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1595543774;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:47 +0000 (UTC)
Message-ID: <0da20189-4e5b-4af0-b504-e99ac16d40af@malon.dev>
Date: Fri, 10 Jul 2026 00:12:41 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] environment: move pager_program into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260706142530.3681520-1-cat@malon.dev>
 <20260708160300.8852-1-cat@malon.dev> <20260708160300.8852-5-cat@malon.dev>
 <xmqqy0fkq0nw.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqy0fkq0nw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 11:53, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> On top of that, fix a memory leak in pager.c while we are at it.
> 
> Hmph.
> 
>> @@ -75,10 +76,12 @@ static void wait_for_pager_signal(int signo)
>>   
>>   static int core_pager_config(const char *var, const char *value,
>>   			     const struct config_context *ctx UNUSED,
>> -			     void *data UNUSED)
>> +			     void *data)
>>   {
>> +	struct repository *r = data;
>> +
>>   	if (!strcmp(var, "core.pager"))
>> -		return git_config_string(&pager_program, var, value);
>> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);
> 
> Isn't this still overwriting what was in the .pager_program member
> of the config values struct?  In check_pager_config() below, there
> is a free() to avoid such a leak, but wouldn't this have the same
> issue?
> 
>> @@ -91,10 +94,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>>   
>>   	pager = getenv("GIT_PAGER");
>>   	if (!pager) {
>> -		if (!pager_program)
>> +		if (!repo_config_values(r)->pager_program)
>>   			read_early_config(r,
>> -					  core_pager_config, NULL);
>> -		pager = pager_program;
>> +					  core_pager_config, r);
>> +		pager = repo_config_values(r)->pager_program;
>>   	}
>>   	if (!pager)
>>   		pager = getenv("PAGER");
>> @@ -302,7 +305,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>>   
>>   	read_early_config(r, pager_command_config, &data);
>>   
>> -	if (data.value)
>> -		pager_program = data.value;
>> +	if (data.value) {
>> +		free(repo_config_values(r)->pager_program);
>> +		repo_config_values(r)->pager_program = data.value;
>> +	}
>>   	return data.want;
>>   }

Nice catch, sorry for missing that!

Regards, yuchen
