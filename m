Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D57350E
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240203; cv=none; b=LR1oFiI/wBykS85bUWFV0DD/amdd5cNYy3SBNKiwKvKtXlR3GZFSrvhp9xu3VGAoBuxcE82nbRvp3cv7q54Io4TM/Y7PZTx1bRNfqMmPzx+C0ag+TGP4UK1TjILgxnmUpZr5PEfViw4m/hqawSXcisVwRmLCUAGudk0kvUdg1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240203; c=relaxed/simple;
	bh=VqstWRiV/qwoYTOe8Fct7dy7FyEEToe2fr6U/K7X7IA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P25M37S/k3hRM3tkteykVBk2lXOICxYFcKQNRg+oZu0w3ihQQyAqKhd4TOfQ4+dliawxjaveyfSKsjZZ+Ikc3LxUso8q/zumG990vap1SoeXqOUdmW/bapB2U1BaYhckeOPstz3Q21nAGPl8e3/5lEsB/7N4WXYl6NfTmeLqM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alNyCqD8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alNyCqD8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cc8782869so21984125e9.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240200; x=1726845000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhDYHMvMqeKw/7OCR9gvN5qkK8AumclXvTU91P5GPc8=;
        b=alNyCqD8lPVgPwpISa/7TbfxsK9yzUZ+f38DIrynZ90xCEH4Uru+bYDS+cg7uKg38r
         1L+jXp9EsXNHsk54HlgDzYhTY1y9G4Xs2E9fWd94MvOMpWBrORCu459SqdJxnFskZ+JF
         UiiSSiMZGOC1qY1TYez1kGAHkFb4b75Wmto9DQUgc6Rugp1d5R3g9dAzsay6gCfARDR1
         i+826hnFD8BO8QCbmeIWuAAwgpS8RU1Zqjkr9zKeT919WWNXgcIFzzHZKBeP/gwnpUMz
         mUjVfzbGpL9EBtXaLecrZ9mv6c4USKP6OvVt6qbVsWYLKINBvQ2hRN7PReuwLTIvuIKt
         M0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240200; x=1726845000;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhDYHMvMqeKw/7OCR9gvN5qkK8AumclXvTU91P5GPc8=;
        b=LyecHFeX9qX7bQVDZ/am2oGbS4UgIFsOSIRG0Bh8StkFx8ElJTkDXYOHQFgoCer2qE
         zLLiIcZhHW54zH40eGJ5MeeZg8CL1z3wgPv7IzocQIxRHwc16Oc5UFUP+tea9XglX2U6
         bK0JWGNGQip27I9sqCGLPx+6lJeXuFU9c1F0K75D+UZtZW+X4eFB5Yo7aOkhS5QhikRF
         Jhn1+rx7VZ2Wdrm6CpxCAjcuoCfSQpwGLLt9b+zi9hPmSgW7gMy5bzPrhpp77adaOt8I
         p2P39lFgkPr0WA2kjnIERKGT7YsHp1zuTjIF+31e19zKK9iU3I9WfZCMmNJUOLv3kUef
         Aa9w==
X-Gm-Message-State: AOJu0Yy2R7MjMsWAq2PF+OBFjHP25tIXxCcep6/QhCRGJ7E+Kvwakca0
	gHd5NlO+c7/KFdxkgDIe6iPEzqX+/dRhCaclxkPezniW2de2nsBO
X-Google-Smtp-Source: AGHT+IETGKyELKoozvAFRONXpwYIhkf8g+JOs1kUF8kaQZUR01AXrG6UUaujYZLwBcxLe+KHX8pWRw==
X-Received: by 2002:a05:600c:3b92:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-42cdb56caafmr54102225e9.24.1726240198904;
        Fri, 13 Sep 2024 08:09:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:628:b501:20f0:d089:108a:54d3? ([2a0a:ef40:628:b501:20f0:d089:108a:54d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05a8dasm30393295e9.1.2024.09.13.08.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:09:58 -0700 (PDT)
Message-ID: <4915a1ba-eda9-435b-b615-4f78c7fe25f7@gmail.com>
Date: Fri, 13 Sep 2024 16:09:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] remote: check branch names
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
 <xmqqfrq686n5.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrq686n5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2024 18:03, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> The authoritative logic in the above
> however may further evolve, and we need to make sure that these two
> checks from drifting away from each other over time.  We probably
> should refactor the leaf function in the above call chain so that
> both places can use it (the main difference is that you allow '*' in
> yours when calling check_refname_format()).
> 
>      Side note: we *should* lose "strbuf_" from its name, as it is
>                 not about string manipulation but the "strbuf'-ness
>                 of the function is merely that as the side effect of
>                 checking it computes a full refname and it happens to
>                 use strbuf as a mechanism to return it.
> 
> Something like the patch attached at the end.

Thanks for the patch, I'll re-roll based on that. I wonder if we really 
want to support "@{-N}" when setting remote tracking branches though - 
should we be using INTERPRET_BRANCH_REMOTE instead when calling 
strbuf_branchname()?

Best Wishes

Phillip

>>   static const char mirror_advice[] =
>>   N_("--mirror is dangerous and deprecated; please\n"
>>      "\t use --mirror=fetch or --mirror=push instead");
>> @@ -203,6 +216,9 @@ static int add(int argc, const char **argv, const char *prefix)
>>   	if (!valid_remote_name(name))
>>   		die(_("'%s' is not a valid remote name"), name);
>>   
>> +	if (check_branch_names(track.v))
>> +		exit(128);
>> +
> 
> Seeing that the loop in check_branch_names() is brand new and you
> could have iterated over a string-list just as easily, I somehow
> doubt that step [3/4] was fully warranted.
> 
>> @@ -1601,6 +1617,9 @@ static int set_remote_branches(const char *remotename, const char **branches,
>>   		exit(2);
>>   	}
>>   
>> +	if (check_branch_names(branches))
>> +		exit(128);
> 
> But here you are already passed "const char *branches[]" to this caller,
> and it would be hassle to turn it into string_list, so [3/4] is fine
> after all.
> 
> 
> 
>   object-name.h |  2 ++
>   object-name.c | 23 +++++++++++++++++++++--
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git i/object-name.h w/object-name.h
> index 8dba4a47a4..fa70d42044 100644
> --- i/object-name.h
> +++ w/object-name.h
> @@ -130,4 +130,6 @@ struct object *repo_peel_to_type(struct repository *r,
>   /* used when the code does not know or care what the default abbrev is */
>   #define FALLBACK_DEFAULT_ABBREV 7
>   
> +/* Check if "name" is allowed as a branch */
> +int valid_branch_name(const char *name, int allow_wildcard);
>   #endif /* OBJECT_NAME_H */
> diff --git i/object-name.c w/object-name.c
> index 09c1bd93a3..e3bed5a664 100644
> --- i/object-name.c
> +++ w/object-name.c
> @@ -1747,7 +1747,8 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
>   	strbuf_add(sb, name + used, len - used);
>   }
>   
> -int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
> +static int full_ref_from_branch_name_internal(struct strbuf *sb, const char *name,
> +					      int crf_flags)
>   {
>   	if (startup_info->have_repository)
>   		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> @@ -1766,7 +1767,25 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>   	    !strcmp(sb->buf, "refs/heads/HEAD"))
>   		return -1;
>   
> -	return check_refname_format(sb->buf, 0);
> +	return check_refname_format(sb->buf, crf_flags);
> +}
> +
> +/* NEEDSWORK: rename this to full_ref_from_branch_name */
> +int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
> +{
> +	return full_ref_from_branch_name_internal(sb, name, 0);
> +}
> +
> +int valid_branch_name(const char *name, int allow_wildcard)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	int ret;
> +	int flags;
> +
> +	flags = allow_wildcard ? REFNAME_REFSPEC_PATTERN : 0;
> +	ret = full_ref_from_branch_name_internal(&sb, name, flags);
> +	strbuf_release(&sb);
> +	return ret;
>   }
>   
>   void object_context_release(struct object_context *ctx)
