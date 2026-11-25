Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F334606A330
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 16:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F334606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o2Rt0bdz
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so58531085e9.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795623599; x=1796228399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HlBowunefpQ6amcun3267LGWHyNLMwzIHLbwoqQte2c=;
        b=o2Rt0bdzfr2ZTGlJnWc0KJYwpn2BI28rji/nITrT21p0fFCNN5Ky1xkRV9Wt4wVaPO
         rwdH827CBAl2/GxERy3S4Db7OSrjOGFde8I/OO/oZso8iF0W5Z8GYz6hceEVh6rEWhWi
         iXioNhgCchoEUEOYhZamNNS7UFtuJFTjgaUM1fdB2SeIyGr+SK344uqb7uG0myNfKnvP
         RFxoDkhz1cAf4tuFlcfaIOdbFMktEiNw40bCXPGiB2tQ3K/Th/+2Tz6ImNKPNjQ+5Gc0
         kvAuw4GoJs44UBGhcW0VZyHRIMK5lskSPmMVnsgBs4bR0SRttdLhp3A0i7nZPIcArt0J
         0Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623599; x=1796228399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HlBowunefpQ6amcun3267LGWHyNLMwzIHLbwoqQte2c=;
        b=WqBiyQt8t8DvZ9BbgyLjNwVUQQdN6BQugjgS285+tY1VsYSiwe06q3UXDz9clD5RaV
         CrcM57sd0xR+aSHJ198+X6oKHojun/r3yKCt6QYabRLPFSMDfDT57EgxipSZCGRpoy4Y
         5avdnx0BgIc1BRKfwlHC0ptL5Qq28xoKn/c+EhaQTBNEJYQ4LtkPvXuGZooNAn6+R3De
         itI/Z3eg8BbzdMNc1qVJwNx7vdCqwoSkCnC5WxybGlEuqfGHFQnWP28djC1ty59cwUW9
         VyoO3hW2pirGJkw/N/xCtqlfsSD3MJQUCkxFWvBfc9WLCxafGqWgPIrdMQ9NSuzxoyC8
         Sv1w==
X-Forwarded-Encrypted: i=1; AL+hErGWedgr35xNZnyNIp1KGNvDb4oOf9NMlwqN0WhsMtBRO+lUGSesjOUGnVevixgFL9On6Fs=@vger.kernel.org
X-Gm-Message-State: APuU4Z97t1UcR3o3GsRwXjxvMlUloG1zRY4ii5CsYtZIldYwK31RQ9wM
	ZRqr/Kd/9t/u2Yp/uNS47Skx2vKjWlHSZD2TMVyqvygBxtousIJn7QxZ
X-Gm-Gg: AZFdTZdp1Gxn6Ru81A1ahVW0autEnUJiKkgHbf2VPVRWDptcCOHp2Gcn9frBxi/7lf8
	YryHOGPgSzeRnwsq0T+Ekn72j5YEW5KoKud+84rIINi393bS5C1btmfwEdzaiMN8dASEAyVNDec
	5zJe/Z1f4y92nIuN6kv8l8yQGabtMdZgZn2Wfn1ssy5nJii4Q/3gzBICG4qAGeI2qjKp3q9/L4Q
	IUSBAc0gBWgLMxZfvFjeHMg1KLnFH6VXa21Z7bFw5dZn17muOVpygwCLTb8/0OaeV5erfYt8xpB
	7Z9+d8VsKvNTWhjLPzcNpsQo7KDkWuNDfckNGzS5k4G6K0iTO79etD2lvICZkrM7A80tGsdPYhu
	anEJRk4wc1Yk5tc+rIiiusZO92qIvoD2JJ1zLQ+VoLMFvl0ZX4c0Tkt2dHbjY+w/nSKKAiKLSZR
	vyQQcOMmnc8VFcgEwafen55NqR5JZLv8vFNCZIJXjvZUwmr0n2kDvTYFSOOlgcBiauZsHAYUqjr
	3fixRLHcF3fWUBy5Jg7mXj7Qmf60311BNPMb+l8xzK3zPUAPvxeb3RJdJmZ+l2nS4eXzuDVrrzf
	WQZBz/1s3hAofWK/usQ9F4moxSzsOklOy0uQ04qRZruBJAlsN8aPISe1Z9Mhnh7PI2+BS/06m13
	eUGWj5uo=
X-Received: by 2002:a05:600c:4f48:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4bb8893ab9cmr392800365e9.29.1795623599257;
        Wed, 25 Nov 2026 08:19:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm528598055e9.15.2026.11.25.08.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:19:58 -0800 (PST)
Message-ID: <608b25cc-6ec8-4f0a-8eeb-863ed44bd0db@gmail.com>
Date: Wed, 25 Nov 2026 16:19:57 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] var: add GIT_COMMENT_STRING
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
 <b8c40805-90f2-414c-ae70-e2f79a19170e@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b8c40805-90f2-414c-ae70-e2f79a19170e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 15:02, Kristoffer Haugsbakk wrote:
> On Tue, Nov 24, 2026, at 11:37, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
>> determine the comment character.
> 
> s/determine the comment character/determine the comment string/ ?

Yes, that would be more consistent

>> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
>> index 5f240eb56e3..04aeccd7aa6 100644
>> --- a/Documentation/git-var.adoc
>> +++ b/Documentation/git-var.adoc
>> @@ -130,6 +130,10 @@ endif::git-default-pager[]
>>       The path to the global (per-user) configuration files, if any.
>>       This variable can have multiple values.
>>
>> +`GIT_COMMENT_STRING`::
>> +    The comment string used in template commit messages and rebase todo
>> +    lists etc.
> 
> This could also mention the config variables and git-config(1)?

I had decided not do to that as the point of GIT_COMMENT_STRING is to be 
able to query the comment string without the user having to worry about 
the intricacies of the config setting or what the default value is. I 
guess saying "see `core.commentString` and `core.commentChar`in 
git-config(1)" doesn't really do any harm but I don't think users are 
going to get much additional useful information by reading the config 
documentation. Perhaps saying "as set by `core.commentString`" would be 
more better as it does not promise the reader that the config 
documentation contains additional, useful, information?

The documentation for GIT_PAGER, GIT_EDITOR and GIT_SEQUENCE_EDITOR 
mention the relevant config settings when describing how we determine 
which program to use, but the documentation for things like 
GIT_DEFAULT_BRANCH does do not.

I have added a note to the documentation for `core.commentString` that 
the comment string can be queried with `git var GIT_COMMENT_STRING`

Thanks

Phillip

> 
>> +
>>   `GIT_HOSTNAME`::
>>       The hostname of the machine, as reported by the operating system.
>>       This is the hostname matched by `includeIf "hostname:..."` (see
>> diff --git a/builtin/var.c b/builtin/var.c
>> index eb85a985b15..6dc8ec4ba9f 100644
>> --- a/builtin/var.c
>> +++ b/builtin/var.c
>> @@ -188,6 +188,11 @@ static char *hostname(int ident_flag UNUSED)
>>   	return xstrdup(buf);
>>   }
>>
>> +static char *comment_string(int ident_flag UNUSED)
>> +{
>> +	return xstrdup(comment_line_str);
>> +}
>> +
>>   struct git_var {
>>   	const char *name;
>>   	char *(*read)(int);
>> @@ -262,6 +267,10 @@ static struct git_var git_vars[] = {
>>   		.name = "GIT_CONFIG_GLOBAL",
>>   		.multiread = git_config_val_global,
>>   	},
>> +	{
>> +		.name = "GIT_COMMENT_STRING",
>> +		.read = comment_string,
>> +	},
>>   	{
>>   		.name = "GIT_HOSTNAME",
>>   		.read = hostname,
>> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
>> index 883a45399e2..f228cb5bb6f 100755
>> --- a/t/t0007-git-var.sh
>> +++ b/t/t0007-git-var.sh
>> @@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity
>> components' '
>>   	test_grep "^GIT_COMMITTER_DATE=" actual
>>   '
>>
>> +test_expect_success 'GIT_COMMENT_STRING' '
>> +	git var GIT_COMMENT_STRING >actual &&
>> +	echo "#" >expect &&
>> +	test_cmp expect actual &&
> 
> This tests the default.
> 
>> +	git -c core.commentChar=: -c core.commentString=%% \
>> +		var GIT_COMMENT_STRING >actual &&
>> +	echo %%>expect &&
>> +	test_cmp expect actual
> 
> Then it tests that `commentString` overriding `*Char` works as it
> should. That makes sense and seems to cover all testing bases.
> 
> This happens if you have an invalid comment string:
> 
>      $ bin-wrappers/git -c core.commentString= var GIT_COMMENT_STRING
>      error: core.commentstring must have at least one character
>      fatal: unable to parse 'core.commentstring' from command-line config
> 
> With non-zero exit status.
> 
>> +'
>> +
>>   test_done
>> --
>> 2.56.1.576.g0cfbda1d5c7.dirty
> 

