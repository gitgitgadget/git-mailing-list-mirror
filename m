Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC18472798
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146416; cv=none; b=nOKtLqxmDEzf3Fy+qe4m2o65VXtBTQSd1fiMXUy5iJ+xTz1baKkM/r3ymgNG616Da6c2GlYld9gDheFsJcOUxkXHBrZzdoXi7OIHz7W/mvGTRHuVXLwOj/EHiCNrhc8/geOU1Jn7GghGrDvXbfjJ5P6Y8TNJsnGfO54NtVsms8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146416; c=relaxed/simple;
	bh=OYXSEFkZJw1sLqZSY9LXdYz5CKMVEW1olamFnc1Kd4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9eQd8tTgcRjOvrq7ZeSSmKCza1CiNIzr3/JTuTXZbxQZLz7lnq6MJ7ctIcg6mtOiYaR9SCdujlM56X0Mv0I5Yf1e3qs95xucb6u0WQ0Dv+0z6cIL6YW/ecClGBoOxownPhv0il3NeChMGnhRaRWC5Z2g6QqMgKZiThgHhvLsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=6y44jmla; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=eA6lpsU4; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="6y44jmla";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="eA6lpsU4"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:
	References:BIMI-Selector; bh=Z1wNN+M56jaY2tw6W/2PQzaFGE1luKCBBX4NARMlif0=;
	t=1792146410; x=1792751210; b=6y44jmlas1eeoxsmoBq1GASdhvH/V+wOw/kxWf9D8o/M2OW
	oWrSIOnEuPRZ9pY3MjF+XHCRHhpQV/BZHIR29AQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:
	References:BIMI-Selector; bh=Z1wNN+M56jaY2tw6W/2PQzaFGE1luKCBBX4NARMlif0=;
	t=1792146410; x=1792751210; b=eA6lpsU4AxilM5DHw3czLHHzQeCzTNhNRgV5S4XfrttNSiD
	Yktwwp8gzYtmaiiGhOeRsUeIdSFIMKFYuz+l9kjCya81xXBa5FwaLT/GCRybvn9pGceW8vadguXYt
	VyqC3+mRV4GVVv4hY2up76nam8oPUAzzCcalTx9smxW/O/a2elWeT0P6Zq/xRAYGRz+VOG11FYSV2
	XeQC3XhkH6dODYjxEuWP/13lmnSPs7/D6KK4qdRQshizLNwuuSGBxFDv+ksqmFyufH8euJLfv11sK
	Z0jWZicCj4ULVJELCkMUAdKgIDD3qzW0w6vdNICmXVEhWotOSmhlvirFs+FVfyWxlKBz8lp7g2ZNY
	fQISB0GYPu0O0+ZacvP5/zN43l6z7Z+Hv2P+RyR+xvRKvOY8kE0e+IsOtOko5SAOzHntesAsO7Qdb
	qOd1KQ2BUyHz1zLvsTTDPQvkjW8DQvWfuv9oflI6f2n8Btzt/wsRTxKrrNZf2ZHRgD0IpMLuG5fF0
	IPA;
Received: from [103.167.64.98] (helo=[192.168.10.129])
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1xHf97-0000000044U-3Mk1;
	Fri, 16 Oct 2026 18:26:42 +0800
Message-ID: <e4c6ed6c-a9be-41b9-98e3-2882b6b44102@csmantle.top>
Date: Fri, 16 Oct 2026 18:26:39 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] fetch: fix --depth= and --unshallow for multi-remote
 fetches
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Rong Bao <baorong2005@126.com>, Tamino Bauknecht <dev@tb6.eu>
References: <20261013144441.1632978-1-rong.bao@csmantle.top>
 <xmqq1p9qn33f.fsf@gitster.g>
Content-Language: en-US
From: Rong Bao <rong.bao@csmantle.top>
In-Reply-To: <xmqq1p9qn33f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rcpt-Check: Accepted by authentication
X-42: Don't panic! 
BIMI-Selector: v=BIMI1; s=me

Hi Junio,

On 2026-10-16 04:03, Junio C Hamano wrote:
> Rong Bao <rong.bao@csmantle.top> writes:
> 
>> When running `git fetch --all --depth=<SOME-DEPTH>` or `git fetch --all
>> --unshallow` with Git 2.56.0, the fetch isn't really deepened:
>> ...
>>
>> This is because the parent process doesn't pass the --depth= flag to the
>> fetcher subprocess.
>> ...
>>
>> Fix this by passing it when specified or implied by --unshallow. After
>> fixing, both flags would work on shallow trees in conjunction with
>> --all, as demonstrated below:
> 
> The above observes that "--depth=" given to the outer "fetch --all"
> is not propagated down to subfetches.

That's correct and succinct.

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index b2decc6cfdb8ae86b8b1e92caa85f4961ffc47ff..a110a2dcf09c7e6764eb232bff73286753b27009 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -2247,6 +2247,8 @@ static void add_options_to_argv(struct strvec *argv,
> 
> This function is used to prepare a command line to run a single
> fetch in a subprocess for 'fetch --all', and also to fetch
> submodules when '--recurse-submodules' is in effect.  Does the
> latter case share the same problem that '--depth=<N>' is not
> propagated down?  Should the depth of submodules be controlled
> independently by not passing '--depth=<N>' down in the first place,
> in which case, this patch may be a regression for users who depend
> on the behavior?

This *would* change the existing behavior when --recurse-submodules, but 
I beg to differ on the "regression" part. We have [0] which says:

	--recurse-submodules[=(yes|on-demand|no)]
		Control if and under what conditions new commits of submodules should 
be fetched too. [...]

 From the documented behavior, I don't see any specifics mentioning that 
options like --depth= should not apply to recursive submodule fetches. 
Besides, we're already passing other fetch options like --[no-]tags [1] 
to recursive submodule fetches, which dates back to 85566460897e ("fetch 
--all: pass --tags/--no-tags through to each remote") and also has an 
impact to the local submodule tree similar to --depth=.

And, personally, I would read commands like "git fetch --unshallow 
--recurse-submodules" as "unshallow the tree, including all submodules".

>>   		strvec_push(argv, "--tags");
>>   	else if (tags == TAGS_UNSET)
>>   		strvec_push(argv, "--no-tags");
>> +	if (deepen)
>> +		strvec_pushf(argv, "--depth=%s", depth);
> 
> The 'deepen' variable checked here is set to true when any of
> the '--depth=<N>', '--deepen-since=<TIME>', or
> '--shallow-exclude=<REF>' were used.  If the outer
> 'fetch --all' was told to deepen with '--deepen-since=<TIME>',
> without using '--depth=<N>', what do we have in the variable
> 'depth' at this point?  NULL?
> 
> In other words, shouldn't this be written in a more obvious,
> simple, and straightforward way as three separate additions,
> e.g.,
> 
> 	if (depth)
> 		strvec_pushf(argv, "--depth=%s", depth);
> 	if (deepen_since)
> 		strvec_pushf(argv, "--shallow-since=%s", deepen_since);
> 	if (deepen_not.nr) {
> 		struct string_list_item *it;
> 		for_each_string_list_item(it, &deepen_not) {
>                  	strvec_pushf(argv, "--shallow-since=%s", it->string);
> 		}
> 	}

I will revise in v2, and ...

> Propagating 'shallow-exclude' would probably not be a good
> idea if this helper function is called within the context of
> recursing into submodules, as their history and refs have no
> connection to the history of the top-level project.  Please do
> not blindly copy and paste the above to an updated patch.

... I think I'll choose to limit the scope of this patch to --depth= and 
--shallow-since=, since the former is what I'm originally proposing to 
fix, and the latter looks minimal enough to implement.


[0]: 
https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt---recurse-submodulesyeson-demandno
[1]: 
https://github.com/git/git/blob/f57c9a73884400380bddd172acc88b569834f909/builtin/fetch.c#L2246-L2249

-- 
Regards,
Rong Bao
