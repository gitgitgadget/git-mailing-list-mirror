Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456532EAF9
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579578; cv=none; b=d8FrJ4Df4mJIr8Li7ooosW9MaVkFEiDNW2tz728+nzol2lCuPg2tlxBLie6J1WJ7A8HVFuMfdW3ifND5/iq/TlGIFCw/2ynmPmYrir0fZBt7F69SHE3xrI7+tsF/XFCwDqyoL7BAY06kfJBVNehiBoyVGflGMK6pHr1wwvLgwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579578; c=relaxed/simple;
	bh=LqAZWo6wLWVcqASgx6f2kDBecYlDlAU6ct0LIWmQvgc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fquJogpnFwdEnDbvYewS0zl+E/ZiSacp3E1IvIk2qSq9cKqrwIrhX0mxBuvUaoS62mw3tkGgKaqUnFaAqdYkUZc52U5WXphhsKX96H+rLVwH0Gbf4s/LLuibzyK0KltdhhcN8FNDD/kpx+Rf/m7qv9bhUPVOAOvjQyZSulcsMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luusyFH2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luusyFH2"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42c6b6ec76eso2835521cf.1
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707579576; x=1708184376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+aeq43P15LFsNikD8u8bBTaZJ2JWw4s8YbZoJUVKb0=;
        b=luusyFH2vqX8M3LTolZsyzaHsV7M1vYvVUJzMlV20Mr2kbBDxfMzHFsIPIYEnNWCeg
         J8+Qdpqk3RHqygjt/lKFWuoMSUrI9S8+hP52jZgZIFELGKsS/y79jcn4BdxmM+F54siF
         jy9gY5hID3CnJgpMbD9Wa8GfQiYUGEaoWNEndzt0ESzep6n3TfauKJ73u1FeA6EVrl31
         LL1ugnWMqD/dUMUXnpBKBj40YSpPW+XcC1qUe1V2FeDMhqNlwv4WzzBGrV0+VKqcpOvX
         urSNcA9+fa3yePpxzsk2+4f++tD2xxi0D4CfDSpGS3du8ZupeTlaJlgpp/Wbw9X0Q+u3
         q09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707579576; x=1708184376;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+aeq43P15LFsNikD8u8bBTaZJ2JWw4s8YbZoJUVKb0=;
        b=nuLcrtkPC1+lh33fIc3sfdzqKva9feAMXSgzf4jds9U4jQ3qQnJ89FXAlUTYVPkbCK
         fh2/t5/0qwZG1JBAOeMfmaXWWUMtthG+3krZbBtRnLqSZUfXSvVsSKAR4LAxsIP/KdZc
         J0KLKHsvK6gBuCE+vKqKHm2cHp7303f/a3meKcoWFk6Czcn9SEznZ8q9oLj8iIq7SwOB
         CsvEfohPulb42UPd003ckjV92lMCSFTr7NjujITQmKLmu06YYeBlSma/bsm/B4eGExvs
         3NC3lx29PQ4Vl1X4BUqD2ECPj7/9LmNmZtBwxGi8i7TskeAT/I1Yqkd4oAUbDPTdShiY
         O05Q==
X-Gm-Message-State: AOJu0Yx76tEyNyAZEqx75tEFIId9CXtEy2ik+4HDkNLB3j8P1o3hPG8X
	Ry+Y3tPL7wmtXh0h9DPbpo87JI9guDUK2juRPAj+iQ5njJatp03g71U3Ezy/
X-Google-Smtp-Source: AGHT+IGW3D5Kr8qIHNRJJU1FqOxsZ4NbEuEvGHpvJEjkduPNk8UqCBvZsKdJjm5lO9C5grSBObohGQ==
X-Received: by 2002:ad4:5fc7:0:b0:68c:af0f:c377 with SMTP id jq7-20020ad45fc7000000b0068caf0fc377mr3711807qvb.2.1707579575927;
        Sat, 10 Feb 2024 07:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5abG+T+4lB3PHP2N7XINniPV/sj9TGZSmcklnWG8pyDpN+GdRdTtZqxrOMzbZ2Ar8d46ZKi1NP+cVjki2vfu4BgF0b/Sx
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id lx14-20020a0562145f0e00b0068ca3929a5asm1863920qvb.85.2024.02.10.07.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 07:39:35 -0800 (PST)
Subject: Re: [PATCH v2 2/5] completion: complete 'submodule.*' config
 variables
To: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <426374ff9b3820512f73ef094f9533e6a1ea5cad.1706534882.git.gitgitgadget@gmail.com>
 <ZcSF0Uw0xxlJXRlH@tanuki>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <14b31a82-6c16-025c-3a85-41424dd47417@gmail.com>
Date: Sat, 10 Feb 2024 10:39:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcSF0Uw0xxlJXRlH@tanuki>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Patrick,

Le 2024-02-08 à 02:42, Patrick Steinhardt a écrit :
> On Mon, Jan 29, 2024 at 01:27:58PM +0000, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> In the Bash completion script, function
>> __git_complete_config_variable_name completes config variables and has
>> special logic to deal with config variables involving user-defined
>> names, like branch.<name>.* and remote.<name>.*.
>>
>> This special logic is missing for submodule-related config variables.
>> Add the appropriate branches to the case statement, making use of the
>> in-tree '.gitmodules' to list relevant submodules.
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 159a4fd8add..8af9bc3f4e1 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2803,6 +2803,19 @@ __git_complete_config_variable_name ()
>>  		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
>>  		return
>>  		;;
>> +	submodule.*.*)
>> +		local pfx="${cur_%.*}."
>> +		cur_="${cur_##*.}"
>> +		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$pfx" "$cur_" "$sfx"
>> +		return
>> +		;;
>> +	submodule.*)
>> +		local pfx="${cur_%.*}."
>> +		cur_="${cur_#*.}"
>> +		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
>> +		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
>> +		return
>> +		;;
> 
> Hm, it feels quite awkward that we have to manually massage the
> gitmodules config like this. But the closest tool I could find is
> `git submodule status`, which would also end up describing commits in
> each of the submodules and thus do needless work. And second, it prints
> submodule paths and not submodule names, so it surfaces the wrong info
> in the first place.
> 
> Ideally, we would create such a tool that makes the information more
> accessible to us. But that certainly seems out of scope of this patch
> series.
> 
> In any case though it would be nice to add some tests for these new
> completions.

OK, I end up testing them in 3/5 via the __git_compute_first_level_config_vars_for_section
function I'm adding. But it's true I could add the test directly
in 2/5, if it makes more sense.

Thanks for your review !

Philippe.
