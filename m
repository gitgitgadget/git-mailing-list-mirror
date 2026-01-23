Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0D3EBF2B
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154514; cv=pass; b=dfPQ1Yw4E5Iq3IXkBsQDJD/csRRyTjPTMiepT6YfxJJ97pmO/A53HlEWhcT1IWJHGgCxNH2GRUVPuv3arxaTqiOpaqlHXl6FTNVIFyeXExeu3Z/k/tjB3a6UJzQlpcA4qRi2pdrxZ29gMhiLTNF54z8+uSbPx7XMpyfH0LOkDCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154514; c=relaxed/simple;
	bh=gI1A82vlvsb0M9M17OXAZWDqdVXbniSfvMtvDfmgz98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNQXqFjO5oVzQRP/0TZcnzL1EsI2Bv3kGzRiugCZ9lMefzS3PR9mhe5KmpuO0ynfrXGVX6CMAQ6mAsuIHM/NHlgZblQGI22DCaC1JoIq9Hxd5xHu9VxKAAF1BmNMqLHii3lkFqsRFT1ZS4WP/L2eX6sbmgKZ10qdNzodA4jSueQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HTk/Qm20; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HTk/Qm20"
ARC-Seal: i=1; a=rsa-sha256; t=1769154485; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SCD5aG5GdjxXjZuggfEytBtTeCgfEry9pwx1PD4JB9CocHb6MHmN820qJ7IPss04i6AIlW6sLvvelTJ1MyMgihVtoMqPnWFFVnRKPfJkmMmNFV3XXh+kvQct//7zj3TMGrA5VV3hLepNgQGY4Ru4vCBswgX95cBEY4RKmdL05F8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769154485; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1pQ67eZiPzhAAWebJBixUtyX+LQUUTHFbt7U/ftDReU=; 
	b=k/Ftx1MscycAGL4jXsuTibbjaCcoQT0HGCgDXEPuBQUo2bGXCyYcrsvkEjit6amCgaf/Xq9DayrOQjuXOj3tE9SUWO1piZ/yslEh87eSiTAvB5jwsq1LCRXS4vPKxnjOGg0YD01HPjOrcinTWDAO5Dx88L269LlMJk6KAk0HBvc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769154485;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=1pQ67eZiPzhAAWebJBixUtyX+LQUUTHFbt7U/ftDReU=;
	b=HTk/Qm20RrziHdE1Uik6vk2RDyda1HgSCTw5Pb/t1GwV4MFy8NMIbLf1IPXrYlHy
	kqEA+818nOFyFZfSVFxiO6BcSG8Xwr2RQXSzsY2LJDXsJ+LDu7qyC00fm4kj3B/Hcfp
	9ucuyLzL6kXAzddgcNSFxdQ3ZVKhPstCTKv84oHI=
Received: by mx.zohomail.com with SMTPS id 1769154482438233.66041416411053;
	Thu, 22 Jan 2026 23:48:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Chris Darroch <chrisd@apache.org>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 06/12] hook: allow separate std[out|err] streams
In-Reply-To: <aXMg-SKKhYzIXvv8@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-7-adrian.ratiu@collabora.com>
 <aXMg-SKKhYzIXvv8@pks.im>
Date: Fri, 23 Jan 2026 09:47:57 +0200
Message-ID: <874iocrcr6.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 23 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Jan 21, 2026 at 11:54:30PM +0200, Adrian Ratiu wrote:
>> The hook API assumed that all hooks merge stdout to stderr.
>
> Tiny nit, not worth rerolling over: we typically write the observation
> in past tense. So s/assumed/assumes/
>
>> diff --git a/hook.c b/hook.c
>> index 5ddd7678d1..fde1f88ce8 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
>>  		cp->in = -1;
>>  	}
>>  
>> -	cp->stdout_to_stderr = 1;
>> +	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
>>  	cp->trace2_hook_name = hook_cb->hook_name;
>>  	cp->dir = hook_cb->options->dir;
>
> The implementation looks easy enough. We convert the static value we had
> before into a configurable one, and...
>
>> diff --git a/hook.h b/hook.h
>> index 2169d4a6bd..7cbeef0a1e 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -34,6 +34,11 @@ struct run_hooks_opt
>>  	 */
>>  	int *invoked_hook;
>>  
>> +	/**
>> +	 * Send the hook's stdout to stderr.
>> +	 */
>> +	unsigned int stdout_to_stderr:1;
>> +
>>  	/**
>>  	 * Path to file which should be piped to stdin for each hook.
>>  	 */
>
> Another tiny nit that is not worth a reroll: might be worth mentioning
> that this is the default behaviour.
>
>> @@ -80,6 +85,7 @@ struct run_hooks_opt
>>  #define RUN_HOOKS_OPT_INIT { \
>>  	.env = STRVEC_INIT, \
>>  	.args = STRVEC_INIT, \
>> +	.stdout_to_stderr = 1, \
>>  }
>
> ... make the old behaviour the default.

Thanks for the review, your understanding is correct.

I will address all the nits you pointed out in the v8 reroll I plan to
do anyway, to address all the received feedback.

Will leave v7 up for about one more week to gather more feedback.
