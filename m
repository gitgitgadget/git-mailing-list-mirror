Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5F364BF
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581990; cv=none; b=Cik+9Gju10vg8zwxXxO+qNlKNU7HwKbUTRFwWSJ3cmlDfxbjxLjSA7v0p+rRWB+aOckZ/PgrxtW8e49tUVkxxC0huzYNcPe3Qx4RLZD/Rq05NmdrdODKoMuApCpmUrVe0ukrfF17GD6kC5gpSnFmAK5lTWa+O3I7iOFyWyT6syA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581990; c=relaxed/simple;
	bh=p5bu3sbgiM5T7YFhNscxU+0IVhv+nN/SXtvXphaGi9Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bqM1xEbmutH4+4JUxK6qxICvtwzIWMGW4owkTbpAFwmGCm4xBGUbITuxpe0dWCjwOWYvquBJfLAmGCTO2QPNcv8uj7EBvUGHw4v1MfhpozzZHClHrK/MijA318F+2Iyws4V554VCC2ZSr9FbcY6i/+gNaurNCI85rVHmy7t13vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMOsPEY/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMOsPEY/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso9828726d6.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707581987; x=1708186787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ8fB0vTlD4Jqr6+vsqjcGPokhSiQpwtNtYpJVjQ65o=;
        b=bMOsPEY/Zs3M85+ySIfIWTyTNCCJf63pCsiKoz2TOHl/HRddP/EPTfhVwWm05bJWID
         p1Hkcu/Gauvtpd04xt29cm2K/EQJeb939eLzyNexwtS8sw4LM1krsn31ekZMZ1/+LGw2
         WaqCyp/ahfJZY8UQ5nb2qTsIGzmRndRchvN0j3TX3M13Pla3OUbN0mXrbEXM6RRJjNDL
         QsBjl/TYktp0Q/0wO+ScZLu69DWHvidMceApPJBXaH1BgO4jvVJMHaCWEwuvigfLkOGX
         f4IzR5iCYK4ZjC+l3BngctRa+czJgxKmCj+hUjdeu6Aa7nEr75hFbAf5XY5WAt1d9SOJ
         F/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707581987; x=1708186787;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ8fB0vTlD4Jqr6+vsqjcGPokhSiQpwtNtYpJVjQ65o=;
        b=EV8nOoDTfihhYvLegvYH2XfumJvJw4frgerqMW3hGtA4lUaj49Fvcp+0et4eUHGk8q
         W6ovX6/eU2cLcjTZX4mgPpzzVEXAP0/2tUTE9nb0uh1CpMu/9kEgZxGK0Q07PRxJJf8v
         hLPL5SicONAE5+LgPsQcJkzfZTl1k9zau6KVwKSZdbQTz256PLaOWcle1fXVyMb45xSv
         cljwF0XxOwzfAd+DFsQD7O8qT7wJaA2ifaYuTF5rVENtWURmxvvudj7ubAYzclg0Aewh
         6Rx4rTjbDeNCtlYv6Q2zK1bZ2IqlD2Z2QnJ2Vmbo0Jr24nQOe4ysH4VTDdqH8ryVplZK
         Mm7g==
X-Gm-Message-State: AOJu0Yy4p3j8C77NZ+bIP4fGD+R/vII6UTOMer76G/4IV+TuY4p46BCE
	MgDofJc4pPRhVNOlPBen912G+OE/ce5XY7ZqmyYvNqKXsWzMKRQaTB+njkDu
X-Google-Smtp-Source: AGHT+IG4ZOcVdDw9CRYrLeTi1EkmsYsfrY6rF+B3hFcx2KGGeRMp6snTp/Sn/2xDlxiWcRHJ0Lusvw==
X-Received: by 2002:a0c:9e8a:0:b0:68c:7c38:6cd with SMTP id r10-20020a0c9e8a000000b0068c7c3806cdmr1882173qvd.36.1707581987093;
        Sat, 10 Feb 2024 08:19:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9+f7YeR8C6UeHYb0mxZHHMLKkTIPkJSMP4wy3hSPHKuKXE5/sKsn8rsv9snKN73B5j7LHzz23QUsU9z2JJSvzw8lZre3M
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id f26-20020ad4559a000000b0068cccc1a75csm1894633qvx.131.2024.02.10.08.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 08:19:46 -0800 (PST)
Subject: Re: [PATCH v2 5/5] completion: add an use
 __git_compute_second_level_config_vars_for_section
To: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <a2e792c911e1b9fa77d27ec327f6a9dfe06d4de4.1706534882.git.gitgitgadget@gmail.com>
 <ZcSF4fv_a16Ziwyy@tanuki>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <418cb344-8e8c-9603-6e3e-d9fb23ac6141@gmail.com>
Date: Sat, 10 Feb 2024 11:19:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcSF4fv_a16Ziwyy@tanuki>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: 8bit



Le 2024-02-08 à 02:42, Patrick Steinhardt a écrit :
> On Mon, Jan 29, 2024 at 01:28:01PM +0000, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
> [snip]
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 2934ceb7637..0e8fd63bfdb 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2605,6 +2612,15 @@ __git_compute_first_level_config_vars_for_section ()
>>  	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
>>  }
>>  
>> +__git_compute_second_level_config_vars_for_section ()
>> +{
>> +	section="$1"
> 
> This should be `local section`, as well.

Thanks, fixed.

 
> [snip]
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index f28d8f531b7..24ff786b273 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -2593,6 +2593,16 @@ test_expect_success 'git config - variable name - __git_compute_first_level_conf
>>  	submodule.recurse Z
>>  	EOF
>>  '
> 
> Missing a newline.

Fixed. 

Thank you again for your review Patrick, much appreciated.

Philippe.
