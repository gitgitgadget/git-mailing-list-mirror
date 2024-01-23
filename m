Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE525EE8E
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019859; cv=none; b=ZgU72U72iPiCZcHF15ZFOqCcwHvH8m7l10IW99JvuFC06XOV1BGVHeql7yXcbLIPxkGgU03lIU+JKJ6EKhUl6HYDgufl/fMVltz/BmBj9Ri38Im8U1rPxcsnjXAaOyNb+KBJFd8fIAW2Yi3ehQueQa0+R3Y43UNhlPqvN5TLDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019859; c=relaxed/simple;
	bh=aPT8lACAl39EUjEraR4c3CGq4M0Hdm6VflMzNFtZZqE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OCZ6gk86pvI46t5Oix8EVO58U4UCHV6w76S4tVqqvBIg8UJNCcX2a9jrZsA4G8TW3qlSEavLT1A+Yr9yfViJn//MOIrqM3wRdFscrsS7342xMMpH415IT8JczeDj9l7tN+euZSGm4oRrj3pgrWBiXrvWCbbDuvv1O7oxLgty94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxA9jRlX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxA9jRlX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso52393955e9.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706019855; x=1706624655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FA8H1MLR26NcokQV1EWNMlXtLsBiVsYmUI0U+sN4ELA=;
        b=GxA9jRlXCI57FbQWxmzvMBJYXL33b2giooYAegMjcVCnvxhXDzXZyt5/hfvqxEET2q
         rlOPsLxkEwSAFp5rURVmyLebyUGPZkIxVPoIklvmxtmwQTaxwSzLUlL1xuJV4Wc50Is7
         r8bDAYCKV13ZP54V2jZypc097vrvILefNzpUhPM3zBBQPkwbqbarp3jYaZrmZAK4QOWc
         ixc7oOLwd6WVppEvPjF5+jIiR2Vla2+b2TW+uSMPHvSMBP/1tkWprjUCAVG9v5+tYHsf
         tqgv6PL6NfzknscBZ0UY7+AO2foC4yKyA1gTsqRj37y8U0YCPbBXBQzTu6TUbS7+qAYE
         GF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019855; x=1706624655;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA8H1MLR26NcokQV1EWNMlXtLsBiVsYmUI0U+sN4ELA=;
        b=gYoQhYf3aOu0gy9Lxbkdy8hb/3+cSHPLx4OLbU0Cp/XFqaO8m5ypvVHGkNzSSS5BR/
         KkmTYHW2RXwXO++l1xPbh4A6iKgd6Hp/3x19E1y7dYWqMpeiT7Cd7h8EjjbmPOK9uY3p
         9qhBPUIW6aNAVaGB/HAZzdlo24AsdMaPE+s6Xvrz7ES4/3BghcYmthtIDL5wzzZQF1Co
         NGr4ymR/z3Izk+ZEqnEpNLbSAfp1jdKjQx9GqxllcRZfV4zNteZY9jLP7wHHKVTRco2L
         HGb3prZ9u1fGu1EZcDiPvQMzFUyY3NjVJNRR+nBeKffvVwmTUcCCZNlNyLQ1Sq22yUQG
         y/7Q==
X-Gm-Message-State: AOJu0YzVfGwpVnCjaZi7iW9lvSP/tXduM3g8I+2s2cse8SNDAlwegHYm
	L5Js1skyrn2rQS17c2eo5RQcuk4PxfR6Ce637iRcqCYMnWcOlfnm
X-Google-Smtp-Source: AGHT+IFB92LBvbAps1C7+ETNIxRafI79nd1tczJvvgLh9FmDy55ovJIB9n3P76vxMUthA/jYMltDvg==
X-Received: by 2002:a7b:cb95:0:b0:40e:b0ec:e980 with SMTP id m21-20020a7bcb95000000b0040eb0ece980mr330608wmi.268.1706019855488;
        Tue, 23 Jan 2024 06:24:15 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id q12-20020adfab0c000000b00337d8c40ff7sm12505590wrc.3.2024.01.23.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:24:15 -0800 (PST)
Message-ID: <192892be-262c-487e-bb1d-6e50c01e2d66@gmail.com>
Date: Tue, 23 Jan 2024 14:24:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] docs: Clean up `--empty` formatting in `git-rebase`
 and `git-am`
Reply-To: phillip.wood@dunelm.org.uk
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-3-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240119060721.3734775-3-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
> 
> Both of these pages document very similar `--empty` options, but with
> different styles. This commit aims to make them more consistent.

I think that's reasonable though the options they are worded as doing 
different things. For "am" it talks about the patch being empty - i.e. a 
patch of an empty commit whereas for "rebase" the option applies to 
non-empty commits that become empty. What does "am" do if you try to 
apply a patch whose changes are already present?

If you're aiming for consistency then it would be worth listing the 
possible values in the same order for each command.


> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index b4526ca246..3ee85f6d86 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -293,13 +293,20 @@ See also INCOMPATIBLE OPTIONS below.
>   	How to handle commits that are not empty to start and are not
>   	clean cherry-picks of any upstream commit, but which become
>   	empty after rebasing (because they contain a subset of already
> -	upstream changes).  With drop (the default), commits that
> -	become empty are dropped.  With keep, such commits are kept.
> -	With ask (implied by `--interactive`), the rebase will halt when
> -	an empty commit is applied allowing you to choose whether to
> -	drop it, edit files more, or just commit the empty changes.
> +	upstream changes):
> ++
> +--
> +`drop`;;
> +	The empty commit will be dropped. This is the default behavior.

I think it would be clearer to say "The commit" - I found "The empty 
commit" confusing as the commit that is being picked isn't empty.

> +`keep`;;
> +	The empty commit will be kept.
> +`ask`;;
> +	The rebase will halt when the empty commit is applied, allowing you to
> +	choose whether to drop it, edit files more, or just commit the empty
> +	changes. This option is implied when `--interactive` is specified.
>   	Other options, like `--exec`, will use the default of drop unless
>   	`-i`/`--interactive` is explicitly specified.

Thanks for adding a bit more detail about the default, however it looks 
to me like we keep commits that become empty when --exec is specified

	if (options.empty == EMPTY_UNSPECIFIED) {
		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
			options.empty = EMPTY_STOP;
		else if (options.exec.nr > 0)
			options.empty = EMPTY_KEEP;
		else
			options.empty = EMPTY_DROP;
	}

Off the top of my head I'm not sure why or if that is a good idea.

Best Wishes

Phillip
