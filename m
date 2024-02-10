Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EA5BAFC
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581188; cv=none; b=FOGe9fNS+YWdlxBdyu2Yuw2k9OxV0jele2pRz2tuUVmIx23Z8dMcevIP/SbX8L/nVDAlk4yg5+3VrElcobWGCM95tZ7tEz72GwxpfTXm1FZgHIing2saz6pHVsePMVYs4iUHxUapPtbenGvdxfZNyPK8V/sw2AUE0pDkWfMCW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581188; c=relaxed/simple;
	bh=HgdyxmF9dInB/l1qRVgtBI71VPC3zXWgnbIG8ZCnUAk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lEFm8mRQXkRuAFDnPLOlJcKzDjIc0g4YbmbBY6oUOBopTwS/P+A5qEi46rgCqvJWEPf3u43BT/hG5fzWgvKYFhuqjKdqgc2HXgvEFMQsyVO0x2yNL39lw0zFyTzP84LOXKJ73bZyE00mYcMmsNaDaycx1PN6ZoQ1Ig8nWblfr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAGynuld; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAGynuld"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c6b6ec76eso2978751cf.1
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707581185; x=1708185985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14AXJXA6M3IiWkL94zHR3hSbXRvybwnpYjqCv51rAgU=;
        b=cAGynuldmJP0vKKYM3ezKfERnO3uQ4mT/GwWt0y+9Dkn9/B/fVmXRZ7xCS7oQXPMIM
         WsPrRvN783hK/itoeqDr2yMHV2kbLPdV77TGZKM2GqUsj4GUPW4+GUWqV6ud929gKOQQ
         e/P+BoMVsuHImkzX/MPmmUF0TQCM3P2VH41jGZgvGOWjA+/YZ1GAfiHzA6B/mPBt0A1m
         /bE/kE74CU48ZQpNFO6xdhZDCHQuMFZA2OqwaWm6ZRORrUSgXR1A8QKUZFiXqLDgrOtA
         7VhKPRQ0TuxWa35gC83E7Y8Jl4XGh1NMHEOEVlJ3BRCOrLq+2yRDUifIlMCb7B2ZCCRt
         MakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707581185; x=1708185985;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14AXJXA6M3IiWkL94zHR3hSbXRvybwnpYjqCv51rAgU=;
        b=YTFIYeQ7NgNR4azaJCOSHMfOjq8yPv4leSgAaPUOY/uRdBtxZj3mP3dLLJTORV2KQB
         X6K1keMSR0+u2UEjfcFbu/XFvu6NSD3R911RCq4oa+NJy6x97lq3EeX5YuSsFx35NW2F
         YvEMWC1dqopdxjsSXjt3XW4P0T6RXN0j0FJuKfigRn2Gpn7puQfV7oLizHD4XlbpIjlc
         GFgMz1UHoJ5cwBLK2ty2MigQQkRcoXvBBC05vvRaVPZKIMGdnbtSas0dAkx/k2uJERHZ
         KHRbmjERE5dIvkk8voP/Yn8OSRRWyki+s7sP2J42pxQ9SOfz2cLyVGQOpSfAlsdcIP7U
         6aAg==
X-Gm-Message-State: AOJu0YzIa6zoY/UwSypHacxzNuVAw/RZ6ZunH5gLeKEkEhYmUFacylI/
	zl3fFYl2kzR8LweIwMAFm6W+OASX+MJoi9UmCPn9GIaXS5F+3jyf+F5bOQh+
X-Google-Smtp-Source: AGHT+IFFG6uKNtuuCX1m9hZIw+8q7+wbMGoDv+mmppuEErSkI+8/2qxnAa5ql4wwawAZtFfvp/5h9w==
X-Received: by 2002:ac8:7e92:0:b0:42c:595b:dea8 with SMTP id w18-20020ac87e92000000b0042c595bdea8mr3189085qtj.47.1707581184773;
        Sat, 10 Feb 2024 08:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcgak7RHsZMpFEj4dgGXu1vNCYCSOeyCERSZhCEx+sicHP18PyTAZPeGW4TWk6oVNMkXJBn+7cCP36kbvEbnvr44DBD5fG
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id d15-20020ac851cf000000b0042c22cd9880sm1615172qtn.3.2024.02.10.08.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:06:24 -0800 (PST)
Subject: Re: [PATCH v2 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
To: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
 <ZcSF1mJ-JXQLmoZ5@tanuki>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e8642ad8-bdc9-00d6-39b5-81dd399e60ec@gmail.com>
Date: Sat, 10 Feb 2024 11:06:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcSF1mJ-JXQLmoZ5@tanuki>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: 8bit



Le 2024-02-08 à 02:42, Patrick Steinhardt a écrit :
> On Mon, Jan 29, 2024 at 01:27:59PM +0000, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> The function __git_complete_config_variable_name in the Bash completion
>> script hardcodes several config variable names. These variables are
>> those in config section where user-defined names can appear, such as
>> "branch.<name>". These sections are treated first by the case statement,
>> and the two last "catch all" cases are used for other sections, making
>> use of the __git_compute_config_vars and __git_compute_config_sections
>> function, which omit listing any variables containing wildcards or
>> placeholders. Having hardcoded config variables introduces the risk of
>> the completion code becoming out of sync with the actual config
>> variables accepted by Git.
>>
>> To avoid these hardcoded config variables, introduce a new function,
>> __git_compute_first_level_config_vars_for_section, making use of the
>> existing __git_config_vars variable. This function takes as argument a
>> config section name and computes the matching "first level" config
>> variables for that section, i.e. those _not_ containing any placeholder,
>> like 'branch.autoSetupMerge, 'remote.pushDefault', etc.  Use this
>> function and the variables it defines in the 'branch.*', 'remote.*' and
>> 'submodule.*' switches of the case statement instead of hardcoding the
>> corresponding config variables.  Note that we use indirect expansion
>> instead of associative arrays because those are not supported in Bash 3,
>> on which macOS is stuck for licensing reasons.
>>
>> Add a test to make sure the new function works correctly by verfying it
>> lists all 'submodule' config variables. This has the downside that this
>> test must be updated when new 'submodule' configuration are added, but
>> this should be a small burden since it happens infrequently.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 24 +++++++++++++++++++++---
>>  t/t9902-completion.sh                  | 11 +++++++++++
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 8af9bc3f4e1..2934ceb7637 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2596,6 +2596,15 @@ __git_compute_config_vars ()
>>  	__git_config_vars="$(git help --config-for-completion)"
>>  }
>>  
>> +__git_compute_first_level_config_vars_for_section ()
>> +{
>> +	section="$1"
> 
> Section needs to be `local`, right?

Good eyes, I'll fix that in v3.

>> +	__git_compute_config_vars
>> +	local this_section="__git_first_level_config_vars_for_section_${section}"
>> +	test -n "${!this_section}" ||
>> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
>> +}
> 
> I've been wondering a bit why we store the result in a global variable.
> The value certainly isn't reused in the completion scripts here. It took
> me quite some time to realize though that it's going to end up in the
> user's shell environment even after completion finishes so that it can
> be reused the next time we invoke the completion function.
> 
> While this does feel a tad weird to me to be stateful like this across
> completion calls, we use the same pattern for `__git_config_vars` and
> `__git_config_sections`. So I guess it should be fine given that there
> is precedent.

Yes, I used this pattern because it was already used for other variables in 
the script, __git_config_vars and __git_config_sections are some examples,

    git grep 'test -n .* ||' contrib/completion/git-completion.bash

finds also others. I think the idea is to cache these lists to avoid 
computing them everytime they are needed (probably most useful on Windows 
where process creation is longer). I'll mention that in the 
commit message.


>>  __git_config_sections=
>>  __git_compute_config_sections ()
>>  {
>> @@ -2749,8 +2758,11 @@ __git_complete_config_variable_name ()
>>  	branch.*)
>>  		local pfx="${cur_%.*}."
>>  		cur_="${cur_#*.}"
>> +		local section="${pfx%.}"
>>  		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
>> -		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx:- }"
>> +		__git_compute_first_level_config_vars_for_section "${section}"
>> +		local this_section="__git_first_level_config_vars_for_section_${section}"
>> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>>  		return
>>  		;;
>>  	guitool.*.*)
>> @@ -2799,8 +2811,11 @@ __git_complete_config_variable_name ()
>>  	remote.*)
>>  		local pfx="${cur_%.*}."
>>  		cur_="${cur_#*.}"
>> +		local section="${pfx%.}"
>>  		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
>> -		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
>> +		__git_compute_first_level_config_vars_for_section "${section}"
>> +		local this_section="__git_first_level_config_vars_for_section_${section}"
>> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>>  		return
>>  		;;
>>  	submodule.*.*)
>> @@ -2812,8 +2827,11 @@ __git_complete_config_variable_name ()
>>  	submodule.*)
>>  		local pfx="${cur_%.*}."
>>  		cur_="${cur_#*.}"
>> +		local section="${pfx%.}"
>>  		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
>> -		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
>> +		__git_compute_first_level_config_vars_for_section "${section}"
>> +		local this_section="__git_first_level_config_vars_for_section_${section}"
>> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>>  		return
>>  		;;
>>  	url.*.*)
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 35eb534fdda..f28d8f531b7 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -2583,6 +2583,17 @@ test_expect_success 'git config - variable name include' '
>>  	EOF
>>  '
>>  
>> +test_expect_success 'git config - variable name - __git_compute_first_level_config_vars_for_section' '
>> +	test_completion "git config submodule." <<-\EOF
>> +	submodule.active Z
>> +	submodule.alternateErrorStrategy Z
>> +	submodule.alternateLocation Z
>> +	submodule.fetchJobs Z
>> +	submodule.propagateBranches Z
>> +	submodule.recurse Z
>> +	EOF
>> +'
>> +
> 
> Shouldn't we verify that we know to complete both first-level config
> vars as well as the user-specified submodule names here?

Yes that would be more complete indeed, but it would then make more
sense to add that test in 2/5 since __git_compute_first_level_config_vars_for_section
is not involved in determining submodule names.

I'll make that change, thanks.

Philippe.
