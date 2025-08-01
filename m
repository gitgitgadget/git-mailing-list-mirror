Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAB22688C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044649; cv=none; b=gIhzMx+Cp1wZmF4K7/RxLppVXVIX3UqK5CstOSRDv867O4lIl9dSmC5mJHWKBsftpmqziNrdlWAPR+WZoxdlIRvKdnbwNGpqILohdoO1r7XV4tW39Js3G1hBP9b/NqqDMHy7X7i4/W/kJ09uTcT3vE10o5weNmkVus/tX5nh11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044649; c=relaxed/simple;
	bh=4WL3hq1caOAvczjBGF+sfDiosTGLyv/SspWn9cuVKSk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L1ZGtkRNR4RQLWSIXD38YkF+2/6XWpGSo9j0PCcIYNyCr4epDOMXJ6iSg6eEPzAonpSHtaEWIwD49w/RFV6V6VNGgZVtv6jlEr2c+AVIwpnnllz2WXwnEZzIhOCsRj4cCXTZRWcDOgg5a4vdp9M/qd//wvjJHEim39Aj+YvATlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKfH2Zx/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKfH2Zx/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so14706355e9.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754044646; x=1754649446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSIJpsHeG+/XGihJyk+5knq5fjKJTpOquGhkoQZULfQ=;
        b=UKfH2Zx/ikhRCZg4jqUHDP69YCI4ojODM1zzVnUndOkxlXBSMCtUhETA3i8kUkf3d2
         YKE6BPTInTgfYooR10aiyjRZtlHI2/HctsktKALxVBxCComG3ECQ7eLwDIWCzunMaKnF
         vagwBzAcNeSkDAJKVu32iDyneQgR+u5K4VT71kn8cTEetrmn1Q8AEPj8n/hawTfuNh2v
         c6WKuFv6rNDOfZLTqxKPawBudjPJJNtsxf93KqcDqDqAb37jhs8PSiUxmWhYKHt/4gFX
         MqEGMxn2IEiZnhJdzPkU3/NesfrQo5EkAmBVELCAhiiquBTw1qJQmZe7DtE5yPsLDImm
         2rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044646; x=1754649446;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSIJpsHeG+/XGihJyk+5knq5fjKJTpOquGhkoQZULfQ=;
        b=SvweUHP/1CVh6rU14qj/9v4SSrG2yOojAjIpzpuVHPneO5+Hu5C6vVLsZHdXrgVTZC
         Cw2gyR3x9trk4zYUXnPdwu+3yEXbHVX8SVcYRTPqqwYOPz4RBRQwwhZ+cF+pdu/BxITL
         qbjIW0grtZjsi9OZ1nrhb8FuKMN6ZNtEiL0gGh2D62wtDdL7KUHvtvNaBG7Bk/aiYYDO
         Rg/ikC9I+X0YheYqxlvC77alxNqB6T2l/au7Qejlhgqm1s1vYwTVw4WVskNtNcua8wRf
         NmWWC2SSFqLxpidgwVyrIEYnIDHvTNZ/UhNLznxdA4VM0u1PAGkbMbc+OPSgzaDt4XrP
         AQvw==
X-Gm-Message-State: AOJu0YwwhOH21qohcvzGQF9UYbf31dJ8LtcE4HDs1FmY0NKBOGYD7jze
	Y1QgOkWzwTSnpNSdZgsmunILaItUd07y9fFFOcKU4xcuJbXIyzGCeCtI
X-Gm-Gg: ASbGncuRFqNO6iJ8o1KTicQfQPRs0qM596SWr3xSpwJw4qleDV8+YXbVNJ0WSagrTv6
	eMX8Rjj2d2JGlPn54J5Q0gCLAHDq13Cje5xCwDVIykel2EiWUXvJwVjCXcVcmeex+8K7Z/P+JZr
	9V3/iEAIhJVMpjTkADWgPvojaZkStxgJmRIXJ8sbnODRk2vtKbRHudhpefwNpAjmepD77/KM5oz
	qX70eEmwn7BpiyZND8a6xSjNnMbQSYokKzPE/77YvTHkTujXh0qZc6IwX/nbT7LZt+QKrTGsGh6
	VbqKuE3BN6Q/g47I/A0nndtKm7VX3vQUFnrA6tGlbMPFKQeUbq3Pjq3aNpTYnrVTchy8e/7YfLw
	U+Dr1Cy63rRbX4qsJulj03DoXIFbL4KR6TYEO/ZbEExbLzy3RDVf1o8T9l9vwAmErpjLHmzk97W
	U0
X-Google-Smtp-Source: AGHT+IEQI5kLcV1PCrjUl87AAGWcKvqcJFS7WHsL2v/K6+5mzyVIlvw7rEeYDU/uHbmAag6ImpiaeQ==
X-Received: by 2002:a05:600c:3ba0:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-458a201725fmr55527655e9.3.1754044645837;
        Fri, 01 Aug 2025 03:37:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcadsm104573075e9.18.2025.08.01.03.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:37:25 -0700 (PDT)
Message-ID: <34905f47-5600-4728-8611-4abc166d199f@gmail.com>
Date: Fri, 1 Aug 2025 11:37:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] config: warn on core.commentString=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau
 <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <8b57598042642dd0c56e39be03c1c45a62accfb0.1753975294.git.phillip.wood@dunelm.org.uk>
 <xmqqa54koyb2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa54koyb2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 31/07/2025 22:17, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>   #include "git-compat-util.h"
>>   #include "abspath.h"
>> +#include "advice.h"
> 
> Hmph.  Do you still need this?

No, it's left over from splitting one patch into two. It should be in 
the next patch that adds a call to advise.

> I do not think a separate advice_if variable is warranted in this
> case.  They see a warning that says that their "auto" will not do
> anything useful in the future.  They will keep seeing it until they
> decide what to use, and once they decide and set a value that is
> different from "auto" to core.commentchar, they will stop seeing
> the warning.

I agree

>> +static const char* comment_key_name(unsigned id)
> 
> The asterisk sticks to the identifier, not type.

Oops I'll fix that

>> +
>> +	config->last_key_id = key_id;
>> +	config->auto_set = value && !strcmp(value, "auto");
>> +}
> 
> It probably becomes simpler (and easier to debug) if you made the
> type of .last_key_id member "const char *" to point at the variable
> name.  You are not switching on the .last_key_id member.  The only
> use of that member is to be fed to die().  And by doing so, you can
> drop comment_key_name().

I agree the integer id is pointless here, but it is useful in the next 
patch for tracking if a key occurs more than once in a given file.

>> +static void check_auto_comment_char_config(struct comment_char_config *config)
>> +{
>> +	extern bool warn_on_auto_comment_char;
>> +	const char *DEPRECATED_CONFIG_ENV =
>> +				"GIT_AUTO_COMMENT_CHAR_CONFIG_WARNING_GIVEN";
>> +
>> +	if (!config->auto_set || !warn_on_auto_comment_char)
>> +		return;
>> +
>> +	/*
>> +	 * Use an environment variable to ensure that subprocesses do not repeat
>> +	 * the warning.
>> +	 */
>> +	if (git_env_bool(DEPRECATED_CONFIG_ENV, false))
>> +		return;
>> +
>> +	setenv(DEPRECATED_CONFIG_ENV, "true", true);
> 
> I know this means well, but it might give users a better experience
> if we went a much simpler route.  In your top-level project with two
> submodules, you may have core.commentchar set to auto in the top-level
> and only one of the submodules, and then you let "git" go recursive.
> Wouldn't it be simpler for the user to diagnose which one(s) among
> the three repositories need fixing, if the stderr said something
> like:
> 
>      doing X
>      warning core.commentChar is set to auto
>      going into submodule A
>        doing X
>      going into submodule B
>        doing X
>        warning core.commentString is set to auto
> 
> I dunno.

There is definitely a trade off here. The motivation was to stop the 
sequencer printing the same warning every time it forked "git commit" 
and to stop each sumbodule warning about config set in the global config 
file. As you say the downside is that it hides warnings from a 
submodule's local config. I did wonder about somehow tracking the local 
config separately to the global and system config when setting the 
environment variable but it felt like it would get quite complicated 
tracking which .git/config we'd already warned about. We'd need to be 
clear about which repository the user needed to run 'git config' in as 
well which adds to the complications.

>> +static void check_deprecated_config(struct repo_config *config)
>> +{
>> +	if (!config->repo->check_deprecated_config)
>> +			return;
>> +
>> +	check_auto_comment_char_config(&config->comment_char_config);
> 
> The handling of .check_deprecated_config flag is a bit tricky, and
> it is great that this design allows us to write a similar
> check_foo_config() helper and make a call to it here, without
> having to worry about it again.

Thanks

Phillip

