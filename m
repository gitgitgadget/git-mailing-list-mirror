Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5626137776
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832717; cv=none; b=ilnpbHxlcbxnEBF0T11Ifk+9aVIo0P3zYCNBXspLlQ6wNInM6j1ZOxEpoRX6ZkQNyj433/Nqc+xkJYl2E0C1zaPQj+7cfsrjQWeFWCkvMArufNjl3nqV81rdMlDJlmCXKw0hz1TrSYQ4QmfYjc1cFVzSZ9KoW5jNDIfM3WIKWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832717; c=relaxed/simple;
	bh=vDayRoLHccJeUJflMctNG0Z/aGlNEyrmPeVy7JMVz5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4alw5BiSNmJ4E8xSPgQa1xDwYbJhHuKijcsat+ILcbA0PlGYtIsPvVoOCR+Y8NLYBx8dFgTPGYcJCbFOy7ahOhK7+Oz1IyUrHQhR3MurvIlj7pkgYO0XyLwOQ5Nt7FJ6gMRUIH/GU+MEBz8DSsXuIt2EWH70daVT+cVJ3n09wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoJjLqf0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoJjLqf0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4305724c12eso25672485e9.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728832714; x=1729437514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae6mOFB0JP04Va5Zv1NxB8E0Qui0B8TML778Ijq1rpc=;
        b=JoJjLqf0RMMwxtHpZ8qflVqsYQICWfeG1bhnM856Cm8e8iBEyy81zkWUZ/VvnhZc0m
         X9mEFT7iKan2+cWBRGiV99Hl1FxRiHMmy2uF3Cptf5dA8z9e8gYHxheW5aH6DAKWekLZ
         Elh2fd0Gk0qv+sjft6UsuEQOb4gP5QXifeZ8iH4Z6TfAFxu7TT+M69tFmwQC3ma0BRFc
         2zsJwSt/VkU65f7PTnUMT0XeZCPr6O1A4naOHENWs+dSslZ8vdxGnOhCsAqNNLZQ9o/t
         PN/Pi8AKMz3WbX9so73fjuJVEMzgVQEFQiWH6pfgR8+kh1FGO4ixhBI9KdGqnz6qekl/
         7XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728832714; x=1729437514;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ae6mOFB0JP04Va5Zv1NxB8E0Qui0B8TML778Ijq1rpc=;
        b=g5P5UHjIzsBZROHcme1VF9scfmOpiNi6GRkV2/nSwQio3sLWez0OIBb2MUlJg9ubFl
         YiBlEozXYoOyJQs6itvz/zUYgyDb0xB+5uofiR9fb3BdIMq1VEnv/Ncm1D0vIqSiR+KV
         BULTGdQl2tjpjxogARZzBOc0HJZWrmjVJsW09Rg+fq736wvg3Cw0LghytUDWlvCRiINh
         yZ3g0+pS0PIZetHV0ariFIzQ/QJWQDi30NcJkV9AlCA6VjjtcGuUvFAzPJ7ddE+nM+jT
         L/OEhlvVQoZ++mmHULi1E0p3HSdzhL0WwJ4mbbLDCZJ1iMwpC0xuLNjqzVgE3JJHKvlx
         TlFg==
X-Forwarded-Encrypted: i=1; AJvYcCXdyF5LDHB3fZdMReUaku6czI9mNz/RTreLvjD1Xl1cGC5gp49zKdNLiY9+FBTY/d6MOwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbCwl09dIj/AKKevxujDSMBCwIDUh5oKlaYcBWvsShfUqjlAd
	ZO+tQdInwp9COctoKMNO/MiCEiFI/FRS/F7WL8FiwwaSiC2/J841KUX4tg==
X-Google-Smtp-Source: AGHT+IFeJXyJPdv5/NW7dPoH+I7apvIG9QmEvQ/Cxb5Z5MjKkrlJlrwLz6ZDkNo5BYaSzWzQiy93AQ==
X-Received: by 2002:a05:600c:1c9c:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-431255dcb1dmr53419895e9.13.1728832713843;
        Sun, 13 Oct 2024 08:18:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf204f7sm128867295e9.2.2024.10.13.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 08:18:33 -0700 (PDT)
Message-ID: <0ac9d9a1-cb91-4b1c-bba1-022ecc485684@gmail.com>
Date: Sun, 13 Oct 2024 16:18:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs
 automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
 Abhijeetsingh Meena <abhijeet040403@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Abhijeetsingh

On 12/10/2024 05:37, Abhijeetsingh Meena via GitGitGadget wrote:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> 
> git-blame(1) can ignore a list of commits with `--ignore-revs-file`.
> This is useful for marking uninteresting commits like formatting
> changes, refactors and whatever else should not be “blamed”.  Some
> projects even version control this file so that all contributors can
> use it; the conventional name is `.git-blame-ignore-revs`.
> 
> But each user still has to opt-in to the standard ignore list,
> either with this option or with the config `blame.ignoreRevsFile`.
> Let’s teach git-blame(1) to respect this conventional file in order
> to streamline the process.

It's good that the commit message now mentions the config setting. It 
would be helpful to explain why the original implementation deliberately 
decided not to implement a default file and explain why it is now a good 
idea to do so. Supporting a default file in addition to the files listed 
in blame.ignoreRevsFile config setting leaves us in an odd position 
compared to other settings which use a fixed name like .gitignore or 
have a default that can be overridden by a config setting like 
core.excludesFile or require a config setting to enable the feature like 
diff.orderFile.

I've left a couple of code comments below but really the most important 
things are to come up with a convincing reason for changing the behavior 
and figuring out how the default file should interact with the config 
setting.

> +	/*
> +	* By default, add .git-blame-ignore-revs to the list of files
> +	* containing revisions to ignore if it exists.
> +	*/
> +	if (access(".git-blame-ignore-revs", F_OK) == 0) {

There are some uses of "access(.., F_OK)" in our code base but it is 
more usual to call file_exists() these days.

> +		string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs");

If the user already has this path in their config we'll waste time 
parsing it twice. We could avoid that by using a "struct strset" rather 
than a "struct string_list". I don't think we have OPT_STRSET but it 
should be easy to add one by copying OPT_STRING_LIST.

> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&

test_commit overwrites the file it is committing so you need to use the 
--printf option

	test_commit --printf second-commit hello.txt "hello\nworld\n"

> +    git rev-parse HEAD >ignored-file &&
> +    git blame --ignore-revs-file=ignored-file hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame hello.txt >actual &&
> +    test_cmp expect actual

I have mixed feelings about this sort of differential testing, comparing 
the actual output of git blame to what we expect makes it unambiguous 
that the test is checking what we want it to.

Best Wishes

Phillip

