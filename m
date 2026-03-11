Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB753C3426
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225175; cv=none; b=NOzCfBFcNX2Q7z3OEufL1jsgOSb6xOCHX/sPN6Wkn3PNYME3+7IxCHyg2sSqVQuLMJzLMwRGUVieyYQWsTWGe3LB7mH8kpiaBGHMIveXMZqH/ob+XVceNA1BAOwHVzpHWKBifodklqreSrKxVLCduiNQO1WXZicfdpUXwElTJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225175; c=relaxed/simple;
	bh=3+XO2imiCB+ZowkhvlyarXn0ieyy221F8lyKaMsYB3E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M2MuR6a6fYxjl1muE4V3VyZPc39hRxeEzNi5QLp1Or61yVq10iaJwEudvjOvEjIPzj7/Ej/C2cy1wAYhWFexFkaBR3ddQcTPVDip/EpxB/BoJi+cMWWJDpU+BWdGHHmECUEd+NCr3bvO1MwGYfwm4OYyWSwf76h6yJN2s9ZTiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxXP9Rbw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxXP9Rbw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so42873455e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225172; x=1773829972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zklnu4fmt1vkjaVD6IP9TM4tZfBNpFqhS7jXyK8+gyU=;
        b=JxXP9Rbwl0AJVCyOMHkBukazgqn5vbpHHap6ACicrm336ckLpPrMq/zBwNPvobR5B9
         BT+3VtyL+aNCpT24SOathY05rSuoDG5e/Xe1Rtq5Juby3HjTW7U1BVt6tenGLUyi3FxJ
         MDSzIg/Oz5qetESEw/bpPb1VF4sOz7EURA8XMpKtzFFusWy84ZWBMbUtRqREBTl+L0Tn
         YeVfszovT5XStH5IDuWLzOPXHFTcFrekr6B13wmZxyGiQ/B20vv6arSc6i1lQXFGvidC
         AIuMeeaSyg8wEhhnAmU9FRUuXkWKvMJUjXnAABIVZV7mlox8zQWQqkL//3XwS405ksFE
         bTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225172; x=1773829972;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zklnu4fmt1vkjaVD6IP9TM4tZfBNpFqhS7jXyK8+gyU=;
        b=byIbka6V8t1rT0eUJZy6gqmbWVSAPDIv8XoHrH3P0/Zag08U+OoUB3aI0qWn0100uo
         jQcTjJLIbbsp0lj8wvfbg3DfULHbdGX8LRqLpzRa/4fGPWb72X003YYJQ9p8c+oqINo3
         w+J82yoPhWgFm0bGgkv7jk/lxVG/E8T2UGaAuL5aYwXJkZCRgzts4jndnommI1PRT/A2
         ASnYnInmCUdNtpuLcKOdRTKd+E8kGU05uCAiIPqQqx8nmZ0zD54Uiv0xf3tuVids6yfs
         QULC/wWUO69gVzWvNaP+lKitI8RYFJA1ptzgyM0taPDHU/fgzn3L6bCnSmRydLh13CIT
         5PPg==
X-Forwarded-Encrypted: i=1; AJvYcCXbo7Ql4jB36pcqf6aQlNwR9q6awGIOraX67fyLJMlm9tmAZO1kzIXmxiZmGL1Z3f5fYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDT2ePGeyBAeaU+rkRqti2EgOAbt3GI04jk0DZlJ3YzrPN4VD
	ViMN+4P1V3RBFdi41W9L753g1lbQk8mT3zv8Pys/X9Ha85Vlg3Pfvyl38CF9wQ==
X-Gm-Gg: ATEYQzzOOlVe3EWTZ4UPNVU012GFe5YIDV7nAaNkCAHWaasDfIEyLT1tQblmqWpsp5d
	fF+t0kxn5ztWxcCCrVelZnekEMZZKp3bmwYfRmATmCm8jyiKQUoHYlTm2trCJKqPIf9wPsrLAt5
	CMtKhY42ffj07eJsYrYooulH0SN/ofUlX+W8w5ot8hhryueng8wQRuuik4E0irZfrplt41ILBz0
	CapbfFNOeantbunN3mdYua8mBFgyxXh/pH5l2e9FL8XDxwnl16ZIdPzLHNeav8vvmU8xMCI7Vj2
	dN/NCzAJiOsBU8WhL1dD11oAvDd23czzarRcmqu9VNNDj855Z95SIQ75f3Vz+kev9ahNY4Z20QO
	kobndY5/8qgSJNkisQDRplsL5cx7oomA2fNTFtZ8M68GAVWeH8XoVhpdopy1maDYKFAKnd54j7Y
	Hthp/AL2nUwxhhsmFg9LE5+LIVVdsds1q1qFYtKdNS8zq1Ui4WHkqYG8YdVOuRX0l0hRAgFJ5oT
	BYTLA==
X-Received: by 2002:a05:600c:800f:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-4854b0fb09bmr30286105e9.18.1773225171746;
        Wed, 11 Mar 2026 03:32:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm10512265e9.15.2026.03.11.03.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 03:32:51 -0700 (PDT)
Message-ID: <3fb4baf7-a820-401d-815b-a0b7c11fe6c3@gmail.com>
Date: Wed, 11 Mar 2026 10:32:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
To: Junio C Hamano <gitster@pobox.com>
Cc: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
 <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com> <xmqqikb3ws3e.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikb3ws3e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2026 16:45, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> Possible values:
>>>     - commitListFormat is set but no string is passed: it will default to
>>>       "[%(count)/%(total)] %s"
>>
>> It is unusual for an empty config value to mean something different from
>> it not being set. The reason for this is that it allows
>>
>>       git -c config.key some-command
>>
>> to act as though config.key was not set.
> 
> That syntax is the same as setting config.key=true; disabling the
> feature triggered by config.key is quite counter-intuitive, isn't
> it?

I'd forgotten about the boolean case, I was thinking about an empty or 
missing value clearing multi-valued keys which is quite common I think. 
Anyway we seem to agree that we don't want to use a missing value to 
signal a default here. The suggestion below using true and false seems 
quite reasonable to me.

Thanks

Phillip

> We are by default using "shortlog", but use of this configuration
> variable is a sign that the user wants to use a more modern custom
> format that is not the traditional "shortlog".  It would be quite
> natural to invoke the modern default by setting it to "true" (i.e.,
> "I want to enable the new format.commitlistformat feature, but I am
> not saying which format, and the "log:[%(count)/%(total)] %s" format
> is used).
> 
> Perhaps "format.commitlistformat = false" should disable the modern
> format and fall back to "shortlog", setting it to true (including
> the use of "valueless true" syntax) should enable it and use the
> modern default "log:[%c/%t] %s" format, and non-bool text should be
> used as a custom specification ("shortlog", or "log:<format>")?
> 
> I.e.
> 
> 	switch (git_parse_maybe_bool_text(value)) {
>          case 0: /* false */
> 		fmt_cover_letter_commit_list = "shortlog";
> 		break;
> 	case 1: /* true - use the modern default format */
> 		fmt_cover_letter_commit_list = "log:[%c/%t] %s";
> 		break;		
> 	default:
> 		fmt_cover_letter_commit_list = value;
> 		break;
> 	}
> 
> Hmm?
> 
> 
>> It would be nice to support a default format on the commandline as well.
> 
> 
>>
>>>     - if a string is passed: will use it as a format spec. Note that this
>>>       is either "shortlog" or a format spec prefixed by "log:"
>>>       e.g."log:%s (%an)"
>>
>> Having the config value behave like --cover-letter-format=<value> is
>> sensible
>>
>>>     - if commitListFormat is not set: it will default to the shortlog
>>>       format.
>>
>> makes sense
>>
>> Thanks
>>
>> Phillip
>>
>>> Signed-off-by: Mirko Faina <mroik@delayed.space>
>>> ---
>>>    builtin/log.c           | 21 ++++++++++++++++
>>>    t/t4014-format-patch.sh | 53 +++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 74 insertions(+)
>>>
>>> diff --git a/builtin/log.c b/builtin/log.c
>>> index 95e5d9755f..5fec0ddaf9 100644
>>> --- a/builtin/log.c
>>> +++ b/builtin/log.c
>>> @@ -886,6 +886,7 @@ struct format_config {
>>>    	char *signature;
>>>    	char *signature_file;
>>>    	enum cover_setting config_cover_letter;
>>> +	char *fmt_cover_letter_commit_list;
>>>    	char *config_output_directory;
>>>    	enum cover_from_description cover_from_description_mode;
>>>    	int show_notes;
>>> @@ -930,6 +931,7 @@ static void format_config_release(struct format_config *cfg)
>>>    	string_list_clear(&cfg->extra_cc, 0);
>>>    	strbuf_release(&cfg->sprefix);
>>>    	free(cfg->fmt_patch_suffix);
>>> +	free(cfg->fmt_cover_letter_commit_list);
>>>    }
>>>    
>>>    static enum cover_from_description parse_cover_from_description(const char *arg)
>>> @@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
>>>    		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>>>    		return 0;
>>>    	}
>>> +	if (!strcmp(var, "format.commitlistformat")) {
>>> +		struct strbuf tmp = STRBUF_INIT;
>>> +		strbuf_init(&tmp, 0);
>>> +		if (value)
>>> +			strbuf_addstr(&tmp, value);
>>> +		else
>>> +			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
>>> +
>>> +		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
>>> +		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
>>
>>
>>
>>> +		strbuf_release(&tmp);
>>> +		return 0;
>>> +	}
>>>    	if (!strcmp(var, "format.outputdirectory")) {
>>>    		FREE_AND_NULL(cfg->config_output_directory);
>>>    		return git_config_string(&cfg->config_output_directory, var, value);
>>> @@ -2329,6 +2344,12 @@ int cmd_format_patch(int argc,
>>>    		goto done;
>>>    	total = list.nr;
>>>    
>>> +	if (!cover_letter_fmt) {
>>> +		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
>>> +		if (!cover_letter_fmt)
>>> +			cover_letter_fmt = "shortlog";
>>> +	}
>>> +
>>>    	if (cover_letter == -1) {
>>>    		if (cfg.config_cover_letter == COVER_AUTO)
>>>    			cover_letter = (total > 1);
>>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>>> index 458da80721..4891389a53 100755
>>> --- a/t/t4014-format-patch.sh
>>> +++ b/t/t4014-format-patch.sh
>>> @@ -428,6 +428,59 @@ test_expect_success 'cover letter no format' '
>>>    	test_line_count = 1 result
>>>    '
>>>    
>>> +test_expect_success 'cover letter config with count, subject and author' '
>>> +	test_when_finished "rm -rf patches result" &&
>>> +	test_when_finished "git config unset format.coverletter" &&
>>> +	test_when_finished "git config unset format.commitlistformat" &&
>>> +	git config set format.coverletter true &&
>>> +	git config set format.commitlistformat "log:[%(count)/%(total)] %s (%an)" &&
>>> +	git format-patch -o patches HEAD~2 &&
>>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .* \(A U Thor\)" patches/0000-cover-letter.patch >result &&
>>> +	test_line_count = 2 result
>>> +'
>>> +
>>> +test_expect_success 'cover letter config with count and author' '
>>> +	test_when_finished "rm -rf patches result" &&
>>> +	test_when_finished "git config unset format.coverletter" &&
>>> +	test_when_finished "git config unset format.commitlistformat" &&
>>> +	git config set format.coverletter true &&
>>> +	git config set format.commitlistformat "log:[%(count)/%(total)] (%an)" &&
>>> +	git format-patch -o patches HEAD~2 &&
>>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] \(A U Thor\)" patches/0000-cover-letter.patch >result &&
>>> +	test_line_count = 2 result
>>> +'
>>> +
>>> +test_expect_success 'cover letter config commitlistformat set but no format' '
>>> +	test_when_finished "rm -rf patches result" &&
>>> +	test_when_finished "git config unset format.coverletter" &&
>>> +	test_when_finished "git config unset format.commitlistformat" &&
>>> +	git config set format.coverletter true &&
>>> +	printf "\tcommitlistformat" >> .git/config &&
>>> +	git format-patch -o patches HEAD~2 &&
>>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
>>> +	test_line_count = 2 result
>>> +'
>>> +
>>> +test_expect_success 'cover letter config commitlistformat set to shortlog' '
>>> +	test_when_finished "rm -rf patches result" &&
>>> +	test_when_finished "git config unset format.coverletter" &&
>>> +	test_when_finished "git config unset format.commitlistformat" &&
>>> +	git config set format.coverletter true &&
>>> +	git config set format.commitlistformat shortlog &&
>>> +	git format-patch -o patches HEAD~2 &&
>>> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
>>> +	test_line_count = 1 result
>>> +'
>>> +
>>> +test_expect_success 'cover letter config commitlistformat not set' '
>>> +	test_when_finished "rm -rf patches result" &&
>>> +	test_when_finished "git config unset format.coverletter" &&
>>> +	git config set format.coverletter true &&
>>> +	git format-patch -o patches HEAD~2 &&
>>> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
>>> +	test_line_count = 1 result
>>> +'
>>> +
>>>    test_expect_success 'reroll count' '
>>>    	rm -fr patches &&
>>>    	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&

