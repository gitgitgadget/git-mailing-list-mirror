Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E13AAF65
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180109; cv=none; b=W2t+JYe735FkP8MfUXS8BBuqZ/F0WkdG5RsmqJmUAvXly5tXM+IRoFS74/rlg1GHGW143V5k0qtDMXAluwaSvWy2rpdJ0uHmWA+SWvcoSSHQ6xUAz0j4QxsISazGqpKyCleU0bVwhzowBdDKyr7sC3FcLwCKponxLh+sDcej7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180109; c=relaxed/simple;
	bh=04T84HLsJfADLui761OQqZrNqyAFr1TvnH0FWFL1vhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcJY/aOt0ViR7D1voNowIhvj1OFBvzZrE9na6J6bNwU6GrK2TOQ8i60qfUspkjkZSIp8Vpz9wkqA6eIVGYcWxlPj8BOkfkw6s9b7UQmyRVbveiJRMrJvdPBUgMkiG2blW41qWBBzFyr4MURCT8sNPo+oACwPqrkdGqKKVCuXm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5dczgMo; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5dczgMo"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2a449c57so34344861cf.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180107; x=1788784907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMVb6S9cqRF3LwjvRv1jiKF4NZ+GESrqmNh01BoE1kY=;
        b=S5dczgMo+nlyyxywGSs5IwrsTBc/HAnYcjQilLsYmpWqOZO5OO//MIlORxSVEMeQe2
         F4rWTvbdWcnA1hbye+ami1sQpw6a7W+GxcYdfj4E+xGsTergsvbGzNNhLE/o2OAovc4y
         pvLXCwLnRNBBRYqZ0LKnlya8uMV1f8kJVcdntCgwKHmhq/Yw1F1Q1J9QDohxUx4YRiMy
         2+hu81JzMamg5NrOrQcgmxoQY2XVJhfPg/6RKGDIPCbjb9eEiE2yZq5rvbqVLoFh00F6
         +v0W18FhN1pKfJoo8sJdd/19EU3rytvUw9/d+EPKL2w1pXW1dETtuh+SZDTutxhC4T+U
         bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180107; x=1788784907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMVb6S9cqRF3LwjvRv1jiKF4NZ+GESrqmNh01BoE1kY=;
        b=fbMdvvE+r2Z8/tk5iNrC1jDegxlhYVVGfKQLs7T9L4uS5sE+VlOF06JIlP4N3Is8dv
         B56dvcI5AFA8YxJS3Y7fGF3GPoZxw1z2yGHw081aE2ipTnl4HT98FpCwlDc7lPxdPvvF
         Qjt/gh9+CcJV71d9gfppVnPQeSdvQrRa9eDU8IcOn1uaKAMCxSuduCaVKXmjv+yUteA2
         wpFW6v3kQYgVT/LocueTww68pkl9Zltj5IHJODijGJnuraqc0MAZZHW85m0Jfa/KvAP3
         Vgp8WbAKxY/tcy8co9vtxTfKlKxNXOBWTmVK83YtsOTBsjUUgcZ2XOy3dgkG98jSx0Jt
         W/hQ==
X-Gm-Message-State: AFuF++lP9xvzUHF4glcKYfz2dYtVY3ZCu2vpU1+od32f2/zXezm2rP9V
	FIgbQlqCer0pH9AKOFgGbTOJ2h3ydJEchgJNfiGdY9MC8Aftmah1jbp2
X-Gm-Gg: AR+sD13ywgacvm+tQgrf993lxV7sV/RFDxYRvdEjazO5YLmTVaUP78F2378uBOcGQ3i
	vxr1ONs4e68vmISb7oRZ00Itn49EKDV0RWv4seLJT4C7pzdw1Dzj8bAAKzjQAo103J1AXPpZAdY
	199QynzSoGekHGqTGs6GNYFTGP55ClVK9d14/3cBWOAROWwVVg3I6FaYEppmjmWTESzBL2PFzaK
	VZ1p6xePHC+cKR2aDrMWwI+hiHtgflwAr6Oe9j4AVi2Ar7PpnF2jQ4eyXqATPXRsTKHqMmaokmg
	8gYVerKzgQIZ/OM8tJZVSTpabuR0uge2jkauKOoOVahCD6GGNmBz7cmYuokddJ4SJeqYW/vbU0x
	c7COqEaCFAu7YW3pjGbIcZ2aBRFmpghabA9C5i8txzJODra+ZCHtu7M0LdvULPgqsSJsFADlH8H
	yvl19a5sT5DQpP0oPhDdi3epF4BWA84+dQjgi0Kq4bj6Hnd8FCM4jeXsek8zTQqpbnVWpvLi84O
	/4+nicKwrM9ijvoXWA4FTQZX1UQ1bNurxhLE6t0jd0nTIQYJ3wyRcujfduAGaqVrvV2F8Cmjlv7
	lJ4mtQ8DImzu9c8=
X-Received: by 2002:a05:620a:ac19:b0:930:9585:e08e with SMTP id af79cd13be357-93947fd165bmr99076185a.10.1788180106690;
        Mon, 31 Aug 2026 05:41:46 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93932135248sm367194985a.39.2026.08.31.05.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:41:46 -0700 (PDT)
Message-ID: <2eadc838-9d47-442d-a94a-efc570624489@gmail.com>
Date: Mon, 31 Aug 2026 08:41:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] trace2: remove use of xstrdup()
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <ec447a6a778a5c49344346df54b434a96c792082.1787684181.git.gitgitgadget@gmail.com>
 <CABPp-BH1TeDTeqddZw+cvzou+3PRgw+HNpYF2JnhMTSBp9qfbQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BH1TeDTeqddZw+cvzou+3PRgw+HNpYF2JnhMTSBp9qfbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/2026 6:14 PM, Elijah Newren wrote:
> On Tue, Aug 25, 2026 at 11:58 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
> [...]
>> For full defense in depth, we remove the xstrdup() calls from
>> trace2/tr2_sysenv.c.
>>
>> First, in tr2_sysenv_cb(), we need to handle a failed assignment of the
>> value with a negative return to halt the config parsing loop.
>>
> [...]
>> --- a/trace2/tr2_sysenv.c
>> +++ b/trace2/tr2_sysenv.c
>> @@ -74,7 +74,9 @@ static int tr2_sysenv_cb(const char *key, const char *value,
>>                         if (!value)
>>                                 return config_error_nonbool(key);
>>                         free(tr2_sysenv_settings[k].value);
>> -                       tr2_sysenv_settings[k].value = xstrdup(value);
>> +                       tr2_sysenv_settings[k].value = strdup(value);
>> +                       if (!tr2_sysenv_settings[k].value)
>> +                               return -1;
> 
> I'm not sure if this matters, but I think the call sequence from
> config.c to this function is:
> 
>   read_very_early_config ->
>     config_with_options ->
>       git_config_from_file_with_options ->
>         do_config_from_file ->
>           do_config_from ->
>             git_parse_source ->
>               get_value ->
>                 git_config_include ->
>                   tr2_sysenv_cb
> 
> and the -1 unwinds back to git_parse_source, which breaks, formats an
> error message, and calls die:
> 
>    error_msg = xstrfmt(_("bad config line %d in file %s")...)
>    die("%s", error_msg)

Thanks for the careful read! It's particularly important that we
don't suggest that the config value is bad because we couldn't
allocate memory.

> Am I reading this right?  If so, the -1 actually triggers a die as
> well -- unless the allocation in xstrfmt manages to kill it first.
> This isn't a regression (the old xstrdup() also died) and the die
> isn't inside the trace functions, but the commit message might read as
> promising more than it delivers.

Yes, I believe you are correct. We should return 0 to terminate
early without a failure.

That said, I think that the die() in the config code will remain a
"safe" place to die(), as we won't re-trigger this config-parsing
code during any tracing of that die() message. But it's best to be
safe and have the tracing continue to be "best effort" when system
calls fail.

Thanks,
-Stolee

