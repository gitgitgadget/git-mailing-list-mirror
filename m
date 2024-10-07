Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0921E49E
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313141; cv=none; b=Xa9+Mv1uTqm5E5eGSUbf5+K+yESNWhv61DJ8ck9mzWvt5tfpevBRwqTmSVucco/uGYJmGlbF/idq7g1EjT4BO3J6CAWvyxUNEHnbQCFsiVTtyfxjntvi6UZkXdYYocjOglwhg+aT0Qf5ThcKlqLnscSH1yidGSnmK/xOSqqjyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313141; c=relaxed/simple;
	bh=vH9c3OWM3kIEhid1rwF3ak9EB1F4yKphSkwNKDBWc5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9PWcyjTl0xISqpRzPSJILpA7apu4rgODBAmUSnw8Q0XGVYXvqs9mU4Og77qq8y0QWo+IRKjfJvJO0i98XS1Jr+ILDdwP4s60jONo0QF9LmRdUku34BIyiwGydtNy9SuzRv69orA7jgiz9y5FAtZ0Z2ivTGTXH0D1eLiRdS3T5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP2pyKgu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP2pyKgu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c90333aaf1so325395a12.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313138; x=1728917938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s0mm+nsc9RV5otyK2wMfItXK5X5goe/DzAtFifiWd7Q=;
        b=HP2pyKguFz8GUKjB76yEBCGeH66m7yspeavXg3M+Y0GJrbSy6qrYi4KPCYD+4F7qix
         /QcjcdoXzArG5udnR4IamMY8/JLH2Mm8z4VEx9ISiKq67zZDStk3iscdjY5Qk607rulT
         HOP6rijps+qFd8+yitOD2M02dCHuRA4Fz3Lb89PDGPyLw/CDmTF7uinTZuqVWu6kOOQn
         A6tQXowqZ8xie2vQEkQXDjsY7LiT6fym2DLwj2QM1KOgfn6CbbxdxgORwwTSoEs/xluV
         IxI8iI5y+a35g+SuwUBD74S4ofRyu3EIEIkC/64yVP0OIBqPuP8Dxc0tLDR0STnwfr93
         6CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313138; x=1728917938;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0mm+nsc9RV5otyK2wMfItXK5X5goe/DzAtFifiWd7Q=;
        b=wv/rFH/TQgyHA//cTpL7Q9V7MJfelYukyDws7WAPcfoMKrvtpwneTjPVQvVrAuH62v
         gER827ELE5AQLlZxOl0vQMFxsOm/RIPguZ4mYYbRjRljOok8X22eu/4Yq84aGXA8+5od
         TIhcY29XrWYZBFDB+4GhDDzHRGWz23Z2pZVuYLlHay0f5YtuaGJSXfRWFFGHE3YnO0YQ
         hcIPr0qIOYDgXpcL/VGhOis0P6vnXyNKoPQ24o/ht0U8wzoXkQuYsZiuHOEFGmTnVWs7
         U2VEww0MjK3SBJqvu+lkAWx+J4aniGcossYCl/R3X6YD87hhVQT3dU2mGsH1lHMB0FBl
         XFmw==
X-Forwarded-Encrypted: i=1; AJvYcCWEuJtl2HlPiMazU7b4SZ4RpZFT7mvgfaVNQLGQ1HXWsG4rtxCiIHWn/Sv457zX/0o7xq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGySR8Wck8QVCo3VElHiqYxXPgiDZYCNX+QYURWLEmp3sb97qF
	jH1KJFAHbCoXPsWvuAbk3rPJdbhxI9PUtlvx02kJfz3d9lfVzqik
X-Google-Smtp-Source: AGHT+IF63BJPI1pGrjI0fwvVVTZjjFIY9naVw2DKJme5y8s/OO3qyip7/viF6Yl9uRCYqnq07gjWlQ==
X-Received: by 2002:a05:6402:358b:b0:5c8:a01f:bfea with SMTP id 4fb4d7f45d1cf-5c8d2e47de4mr17127768a12.18.1728313137848;
        Mon, 07 Oct 2024 07:58:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05945c3sm3273904a12.18.2024.10.07.07.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:58:57 -0700 (PDT)
Message-ID: <d18f6fdf-d0ba-40e1-a2b9-2fecfbdadde4@gmail.com>
Date: Mon, 7 Oct 2024 15:58:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] doc: merge-tree: use lower-case variables
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, newren@gmail.com
References: <cover.1728298931.git.code@khaugsbakk.name>
 <97f16cb68e059792ddc7d1897ab6e93d536fe19c.1728298931.git.code@khaugsbakk.name>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <97f16cb68e059792ddc7d1897ab6e93d536fe19c.1728298931.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kristoffer

On 07/10/2024 12:10, Kristoffer Haugsbakk wrote:
> From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> 
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This is easier to read.

I think that is a matter of taste, one could argue that using uppercase 
variable names makes them stand out so the user can see which arguments 
are parameters more clearly.

Best Wishes

Phillip

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>   Documentation/git-merge-tree.txt | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index 590cbf5df79..10f8ac7f80a 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -211,12 +211,12 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
>   linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
>   used as a part of a series of steps such as:
>   
> -       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
> +       newtree=$(git merge-tree --write-tree $branch1 $branch2)
>          test $? -eq 0 || die "There were conflicts..."
> -       NEWCOMMIT=$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p $BRANCH2)
> -       git update-ref $BRANCH1 $NEWCOMMIT
> +       newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
> +       git update-ref $branch1 $newcommit
>   
> -Note that when the exit status is non-zero, `NEWTREE` in this sequence
> +Note that when the exit status is non-zero, `newtree` in this sequence
>   will contain a lot more output than just a tree.
>   
>   For conflicts, the output includes the same information that you'd get

