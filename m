Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A39839F3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384766; cv=none; b=XEy1qOcUNQs0s9udh9gQ+3XFC3oocpBYL1hqZEhLaLR6vRYUhlqguWsr8qqIfqDNjM7q66Rx3JZ5iNQ2hbX985RqLAzEFrOpMFYOEXC0blvfBsc/O8OXVnOdWuUazxL1JW1TDTs3Jo/XS9Lr1MatlJEqpDs/FSjf4qSDHSrA/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384766; c=relaxed/simple;
	bh=pwk04OGdHEdLL9PnfU1ywCtmt+l25csvwlZJ0x1neUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ff8kbXW7ns6VK1NCGcSe6jM6FCQG7SkK93QcBfi2+y7X4PJbnDK79dfGyK2p6BmOT779tN7qbOFxX9hfLoN4WXjaTH27H3md4Ydfiz1Dc/u9FwoMJxzTCGHJMVo8HdX5M2760KTGabbLoPuLBMMVXGYzna3zd/8wZin5Fj2HSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4kgFvdP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4kgFvdP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so602599066b.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384762; x=1711989562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fR0XNNeG57qBfl8PGOxudTAFCaPlOOZqIt9oy1BxM3Y=;
        b=d4kgFvdP00O1qzkkkAus7zNFZLLQIADp5BXnA7b9ue/QdYVpgGjPqWMciIkTzue2Gk
         xmCJg0SEmc2X4hGIwy9FG62bxApdQr0kyYmg2UZ++M+fL7EP8mLecR+i2o07HEx3V4on
         UCMaGDcq95pTdwuH3LhmY3qPUfarGkCxmsFwajd2yx8q+n1coC//SUFlEhTIqHyH9qGo
         5il+R0g0SbiICvgNoQwskD7jap2Umip/aoFpBqWKPr2/NmhDv6/tLIG26jbsdEXV8hpW
         zc8MiY+5qVm1qLRIAccwygzKFGQ7jECe5VR4wXIR+hChBtfJFn2lBCFJfQ3w2E8iQBY+
         VnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384762; x=1711989562;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR0XNNeG57qBfl8PGOxudTAFCaPlOOZqIt9oy1BxM3Y=;
        b=ItN0fXEy5IqiCTSL/V+CfYYbEYtz7VdOPkLwGrASgYMhGN6emo2c5d29Qj6GYRhvvn
         ErySATSA+hR1nZQmqSeaZ7ZMP9Z+YKfDhVZ/JYhc4Z2dgJRXKy+pCly/bbhni6M57Jii
         4aRhZu5nMjC8w7q/7Z2Ogr7qFBaDIL/Xg648bPzyNGAvNmOtxPVm4VFZqdpG0xlHV6l7
         wJaPDAnS9FUCEgdzOcqWMgAv3lE6GR5dHYxISw3QorS0qKBKotV8DncddNOZ74GSubu/
         i7sb1NTckTZEDYBsy0rLvin5iOdWPcJZOM+wMs3Qqq6FUD6RpVe6/T2ljL2Fno6ck1HM
         hxGA==
X-Gm-Message-State: AOJu0Yzm8e/WoTlqafuJ9jOcuDjrTS6XvfF5dX348EzC2wfiHs1umOSH
	qFA4Uaz2VnU7wkD8ZrvyUAJAACVkn5Z/2aWQS3+N/cnCXlOTFvg0
X-Google-Smtp-Source: AGHT+IHZURZK+Suc7vmLMDsqEfsQdWDlKutU+LIWS6evnvktMPtboBOn8l1iT3uQ4Z1UFc/LUyVJlw==
X-Received: by 2002:a17:907:a088:b0:a4a:3414:d33f with SMTP id hu8-20020a170907a08800b00a4a3414d33fmr2551218ejc.37.1711384762430;
        Mon, 25 Mar 2024 09:39:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b00a45f39b2d16sm3220130eje.200.2024.03.25.09.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:39:22 -0700 (PDT)
Message-ID: <cd7bc865-4a01-46f6-8d68-24f02fdabcb9@gmail.com>
Date: Mon, 25 Mar 2024 16:39:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-5-mg@max.gautier.name> <Zf636bsHs9woXRAS@framework>
 <1cce271f-c3df-432b-94ff-bf7b11c6924d@gmail.com> <ZgE3mHsPfKbuQLQP@framework>
In-Reply-To: <ZgE3mHsPfKbuQLQP@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max

On 25/03/2024 08:36, Max Gautier wrote:
> On Sun, Mar 24, 2024 at 03:45:45PM +0000, Phillip Wood wrote:
>> Hi Max
>>
>> On 23/03/2024 11:07, Max Gautier wrote:
>>> On Fri, Mar 22, 2024 at 11:11:09PM +0100, Max Gautier wrote:
>>>> +/*
>>>> + * TODO: in the future (~2026 ?) remove this cleanup code
>>>> + */
>>
>> That is rather optimistic - users only run "git maintenance start" once so
>> any unit files that have been written in the past will exist well beyond
>> 2026.
> 
> In that case, should we hook the cleanup (in it's final form) in more
> place ? `git maintenance register` for instance ?

I'm not sure if that is needed if we leave the code to delete the unit 
files in place.

Best Wishes

Phillip

>>>> +static void systemd_delete_user_unit(char const *unit)
>>>> +{
>>>> +	char const	file_start_stale[] =	"# This file was created and is"
>>>> +						" maintained by Git.";
>>>> +	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
>>>> +
>>>> +	char *filename = xdg_config_home_for("systemd/user", unit);
>>>> +	int handle = open(filename, O_RDONLY);
>>>> +
>>>> +	/*
>>>> +	 * Check this is actually our file and we're not removing a legitimate
>>>> +	 * user override.
>>>> +	 */
>>>> +	if (handle == -1 && !is_missing_file_error(errno))
>>>> +		warning(_("failed to delete '%s'"), filename);
>>>> +	else {
>>>> +		read(handle, file_start_user, sizeof(file_start_stale) - 1);
>>>
>>> Actually that fails -Werror because I don't check read return.
>>> Alternative below (on top of this one), with one question:
>>> Are VLA using size_t const OK ? It's folded to a constant array by gcc
>>> but I don't know if that causes portability problem with other platforms
>>> ? I can always repeat the sizeof expr if it's a problematic construct.
>>
>> I think it would be easier to use strbuf_read_file() instead - it is only a
>> small file so there is not really any advantage in just reading the first
>> line. Something like
>>
>> static int systemd_delete_user_unit(const char* unit)
>> {
>> 	int ret = 0;
>> 	struct strbuf buf = STRBUF_INIT;
>> 	char *filename = xdg_config_home_for("systemd/user", unit);
>>
>> 	if (strbuf_read_file(&buf, filename, 0) < 0) {
>> 		if (errno != ENOENT)
>> 			ret = error_errno(_("could not read '%s'", filename));
>> 		goto out;
>> 	}
>> 	if (starts_with(buf.buf,
>> 			"# This file was created and is maintained by git.\n") &&
>> 	    unlink(filename))
>> 		ret = error_errno(_("could not remove '%s', filename));
>>
>> out:
>> 	free(filename);
>> 	strbuf_release(&buf);
>> 	return ret;
>> }
> 
> Thanks, this is exactly what I needed, I looked at the strbuf API but
> couldn't find this somehow.
> 
