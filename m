Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B863D76
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017609; cv=none; b=qVRTmrdbbk8+FP+fuOaX64ZYaoqztu2LxDShnzsfGzXMHCkblH+xU1RCpPPbr9otab/e+XJgCsFMFCPzAOjEI9+nVqqf7Z1xuDa0cGDYapAu+qXYvMo9KIyn2ibP4COcwUx8Ta9X6659d5GAyICWAcncrlbcQs6+VSrO7bOrjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017609; c=relaxed/simple;
	bh=ESFgYgJ0oFJfKUcs1cpTxsFHQycsJePXzG/bunR/9DY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dBFTqYAJDayYbEtvdK+LvDks1bOmsFdY9kpFysEFUrvt/6zGsnCsOmFE1zu+RtrlJCoQubwMjQD59Nsp9El4egeLEykgj6+gNhRNF1SL97u8/Ld6PZxqxk4QH4+147tVRcavsiMrVVeW7o7c/dsmfyoIqRBBvfbZcZh3mCE/8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9uX9Ipu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9uX9Ipu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e430494ccso6073745e9.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760017605; x=1760622405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kMjKJlJHczunz+7xZwmBDQ21GQusHWS+1xdG2y74XY=;
        b=R9uX9IpukV45hLBsHq7+j54o+DuSfRrJUIEkmIhaPj1vW+fpH6bXeXE+KtD1SprOPO
         ugOmK2c8G9AUm0tcR61rRZfO5mn1SaeNFujn2SQpuXl3czy3oR3S7xWAw/FGLfAzcogf
         yiPPg2w0zROXEhe7pcMDFo0OR7xpeAqtFuwMaUN0r2rZ05bOhU9H/4+pNpWj4VMjZhS9
         RGIGy93TENqYtvRzLzHtNg7Wc15mUDZNqcj8jK6+ovAWgr0qxxABEU1OxDIjKIX5Ntjx
         ficNUHgIUSSUXXg//mtNw3CK08qU2dCqAv9DihtHpqepH7v6lhz1im77jF4Q47Dw9P1R
         SWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017605; x=1760622405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kMjKJlJHczunz+7xZwmBDQ21GQusHWS+1xdG2y74XY=;
        b=gtkZBkAJ7XSAJ86Jlx6ONz2jHdVOi7/P2stE3NmebF07yrhr+a3RCIF2qebhv/7odk
         nYD/nWOVeTz2QJhv16qcNYZkSCK93sr0ZvpMMoOu7WY0l70v3hRvmDOlj6ix4PVLn5PH
         8MhHfoX8tvWwe7cmqW40azxG9pgCWR8GONbsfwUkus7vEoObqOVT6J9BPok331lAH3mP
         yHhYGl4yCXj0AcCVVot7gXMPDbcj9ACPEk4pLADABy0HZj3ekiI9FZdkRVw3lvxSStii
         geRwS2S8hqsg++P0xj0qkmFvuzYmoSicT3i6A0Gad3dZ+d4m3VLLAdjWUoPBNZvqWqbA
         WBCA==
X-Forwarded-Encrypted: i=1; AJvYcCWA5XW/fm9gad07+mzeAUidOR0l26JoP1KM/AgWC/XwR42s0icgmsKWgTeTtUKVxOqxRuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1+J5lbijIZ3PIFU5XIs1griLhnHCCXveKS/sMJN5WA2Vu1xA
	EPlvP2d2/M1BqerMj39Sd2EQ5C1rz2uOE5KKurfSS/o7LxfBxPqV6g97
X-Gm-Gg: ASbGncsfWOZSLhBxDIWeU0CM9eZzS94r2VaHxCtGe+BnECm1+sHrHO4GodQnXCQQcDx
	ITOIPKIdn4xE724ndzb59WfwZtda3VvpPjUlqQEure3Ua9cEUPeFytWWFRVZ+NJ6ORvfXINjrhj
	hw4VFuHdvUAiO/2CqC5TbVU/eVpA5lVn4PadsAqZ1aqp5LsBAaLg70iNikJHz2vFlzUYkPAfpa6
	Vp9lU+sblhPUkjRxr9KdKm2Y1229L9zSK5zDqq2oRVCLf21n7r4SG54Kwjm8ni75jXY6wus8zbc
	jcuXedrasQKpkdxObxybgD9wAaA3vQygBg14rCcQG9JszO9pN1knquNnf8Mqp8lZa8g7zgJUusQ
	ZQ+/Cjur6pop1QwQXTtpr8gkI8xyXs/ZwlwKnmke8D3JZWywijp6voi3G3FSDYjWaPEiiY5MT8i
	RhUtTuSkIM5OymoVT+SdFD038o7aLUIODieg==
X-Google-Smtp-Source: AGHT+IGT/Uppu5ptfs0pPjV6uMipAoUHszU7V33Ipe9LlkYSGPd1CWeP1almNri+ZQbiY8K5ICARsA==
X-Received: by 2002:a05:600c:5490:b0:46e:4744:add7 with SMTP id 5b1f17b1804b1-46fae33db7amr36419975e9.7.1760017604436;
        Thu, 09 Oct 2025 06:46:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab656554sm37541525e9.11.2025.10.09.06.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:46:43 -0700 (PDT)
Message-ID: <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
Date: Thu, 9 Oct 2025 14:46:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
To: kristofferhaugsbakk@fastmail.com, j6t@kdbg.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
Content-Language: en-US
In-Reply-To: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 08/10/2025 20:45, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This option has legitimate uses but could create a commit history which
> violates the assumption that commits are strictly increasing in terms of
> commit timestamps. Warn against that in both git-am(1) and git-rebase(1).
> 
> ❦

What's this?

> The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
> author-date option, 2009-01-22). The commit message doesn’t give us an
> example of a use case, but the thread starter does:[1]
> 
>      I've a big set of patches in a mbox file: there's sufficient info
>      inside for git-am to work.
> 
>      Yet, each time I do import these, my sha1sums are changing because of
>      different commit dates.
> 
>      I'd like to force the commit date to match the info/date from the time
>      I received the email (and therefore always get back the right
>      sha1sums).
> 
> So the motivation was to treat git-am(1) as an import command that
> creates the same commit IDs given the same base and committer.

That seems like a reasonable thing for "git am" to do. I'd be interested 
to know what the rationale was for adding it to "git rebase". In 
retrospect I feel it was a mistake to port this option over to the 
sequencer just to match what the am based rebase did.>
> [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
> 
>      I thought about marking it as deprecated but eventually found out why it
>      was added. And it wasn’t for some (still unknown) dedication or
>      not-explained *want* to keep the committer date and author date in synch
>      just-because (as I thought[1]).

We should maybe think about deprecating it for "git rebase" though as it 
is a lot less clear that it is sensible there. If you're rebasing a 
branch then there is a very high likely hood that the upstream committer 
dates of the commits the branch is being rebased onto will be newer that 
the author dates of the commits in your branch.

I've left a couple of comments below
> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
> index 221070de481..c36ae679cfb 100644
> --- a/Documentation/git-am.adoc
> +++ b/Documentation/git-am.adoc
> @@ -156,11 +156,18 @@ Valid <action> for the `--whitespace` option are:
>   	See also linkgit:githooks[5].
>   
>   --committer-date-is-author-date::
> -	By default the command records the date from the e-mail
> -	message as the commit author date, and uses the time of
> -	commit creation as the committer date. This allows the
> -	user to lie about the committer date by using the same
> -	value as the author date.
> +	NOTE: The history walking machinery assumes that commits have
> +	strictly increasing commit timestamps, with some tolerance for
> +	clock skew (see linkgit:git-rev-list[1]).

Is there a particuaar section of the rev-list man page you had in mind 
here? I had a quick look and I couldn't see anything about clock skew.

>  You should only use
> +	this option to lie about the committer date when applying

s/lie/override/ ?

> +	commits on top of a base which commit is older (in terms of the
> +	commit date) than the oldest patch you are applying.
> ++
> +By default the command records the date from the e-mail
> +message as the commit author date, and uses the time of
> +commit creation as the committer date. This allows the
> +user to lie about the committer date by using the same
> +value as the author date.
>   
>   --ignore-date::
>   	By default the command records the date from the e-mail
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a..336ee90f7e3 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -504,9 +504,17 @@ merge backend;;
>   See also INCOMPATIBLE OPTIONS below.
>   
>   --committer-date-is-author-date::
> -	Instead of using the current time as the committer date, use
> -	the author date of the commit being rebased as the committer
> -	date. This option implies `--force-rebase`.
> +	NOTE: The history walking machinery assumes that commits have
> +	strictly increasing commit timestamps, with some tolerance for
> +	clock skew (see linkgit:git-rev-list[1]). You should only use
> +	this option to lie about the committer date when applying
> +	commits on top of a base which commit is older (in terms of the

The comments above apply here as well. In addition s/applying 
commits/rebasing commits/ for this command I think.

> +	commit date) than the oldest commit you are applying (in
> +	terms of the author date).

We should also warn against using this option when rearranging commits 
with "git rebase -i" as well.

Thanks for working on this, it is a very good idea to add a warning to 
the documentation for this option. I'm going to be off the list for the 
next 10 days or so, I'll look at any re-roll when I return.

Thanks

Phillip

