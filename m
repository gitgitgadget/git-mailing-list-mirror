Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C117C215
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381066; cv=none; b=GJcmlww/7ciIkdjPPrd1yS2/zJmArPA4guIIbVCuGPdz9OaxbT1HTSMptbVBqd8XaQ79yw6JQT49puUpfwtAj/gQB4bZZklFOnue/8fgNZ7wFE1VcP9ER4OWZoUVyKv0Rb/IpS5V/JiHXRdC20Xmu6ZlBbt/OlwJ79ZyWa1Lkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381066; c=relaxed/simple;
	bh=iDTyzKznScwI/9L7bdE1QWrg9Dasm2cVk0+2w50KATo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkJrgTLd6+4a+IO6Etu13DUAA7GI0jxUB6sqR+3hbY71dBlQhrKB9sEZlQedFAWx9/Sh6UlamHUTnNKqybocEeXmIhyhwSvGs1qWLhh73VOkkLCGbSDVNyJkGf7eUlMufCHqu6v9d/VGa9c7/24GCzQMzJpatIJzBBPXc1p6RQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsDlHXAe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsDlHXAe"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9950d27234so302475466b.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381063; x=1728985863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GOFbRMH/bHdPuOm81oN51bMHbmjQeFv2b/lYt9Aw4JI=;
        b=LsDlHXAeNIQX0ACL7TQTVtBQkV/BFQf0HGZxFFvJbq28xKVFQQj3PCuSt9lZThYF8M
         JVxjazFOCB0nn/gwrydam6GsuC7uAr42iNBOfo4/a3X2alLK3gasHXStQKH7+VNjZhSz
         zrNNHqBEfGyN8V3jc2hPJ2wbyocjVM4rMzDNb8pklYSPCfWQTI0t15xN00eUCuwqIfCW
         fVsrCJleeYv44Cd1LMEvhUGprRhnDt0RJ4oymeP0OhkMY5aIRo89leK5Z980ToT11KjE
         Y94xi54iR6nuYfql0MuuJNJ1fTHnH9thI1yEmczFwXb/4IgJNocoCIDTSfwz3nYH6e6S
         QknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381063; x=1728985863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOFbRMH/bHdPuOm81oN51bMHbmjQeFv2b/lYt9Aw4JI=;
        b=Kj7bkAC1eqW5QB3FtDf/HRstOTzM7RXJEMxdYSPlvN8EA9Xte6M5zvlFq/umUtw7AD
         LBTw39kNTtO64iO/DEMLprfGriuaRIbXVNhqXCHOMMr/vhFbzhb8FPu83RpCbJcdzf+2
         dxKeF6GnHHzH8X3EOIlUERxCb2CI1OyMYo8cOPfWQTLooUKWcDVgAxPU4WTuIk3PszOp
         QLfc8cxF81kf8/Fs2N7sx+AmGlf9XB52Lcv5Ii+Zv4HMy+H2u5m0mjkp10AR5STnYVbf
         tw7OaxYEKLeyBRIyRCLp+N8pjqQ/dhoXOonT44G2A6FGiizoGR7JAP7tLu+OTGhcLV8Q
         wt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6gnS5AekI9+ENNtqO+rvabjXiFJxrfmsB+76ikD1qTPveg0aAtea2qfeyW/ojoWZW4Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNKB1RYLUJa/PI0rGjRBrEdT1nOnSMg/ehWJzZBSE0vad9oRt
	eCBhJX+uTJHmKBmUDNRdGQ3Xt/kO8ktQG7gsLSwzalkWBMFWgDoJ
X-Google-Smtp-Source: AGHT+IHqVvAzOPIdfuQGIPXLU3reWFI2huarBJt6V9zTXPKYcNopKMYENtwLrnTlMR9g6pPGABYGmQ==
X-Received: by 2002:a17:907:2689:b0:a98:f6c9:fa23 with SMTP id a640c23a62f3a-a991bd0574cmr1595480566b.10.1728381062748;
        Tue, 08 Oct 2024 02:51:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9958ffdb2dsm221505066b.12.2024.10.08.02.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:51:02 -0700 (PDT)
Message-ID: <8d27ea8e-4562-4fcc-a7b3-399abc42135b@gmail.com>
Date: Tue, 8 Oct 2024 10:51:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
 Abhijeetsingh Meena <abhijeet040403@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Abhijeetsingh

On 08/10/2024 08:01, Abhijeetsingh Meena via GitGitGadget wrote:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> 
> Modify `git blame` to automatically respect a `.git-blame-ignore-revs`
> file if it exists in the repository. This file is used by many projects
> to ignore non-functional changes, such as reformatting or large-scale
> refactoring, when generating blame information.
> 
> Before this change, users had to manually specify the file with the
> `--ignore-revs-file` option. This update streamlines the process by
> automatically detecting the `.git-blame-ignore-revs` file, reducing
> manual effort.

As Kristoffer mentioned there is a config option so that the user does 
not have to specify the file each time. The decision not to support a 
default file for this feature was deliberate [1,2]. It is possible that 
we now have enough experience with the feature that we think it would be 
a good idea but any such change would need to address the concerns about 
ignoring "cleanup" commits that introduce bugs. If we do decide to 
support a default file we'd need to work out how it interacted with the 
config setting and make sure there was an easy way to turn the feature off.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/c34159af-f97e-82b3-e2a1-04adae5c10ac@google.com/
[2] https://lore.kernel.org/git/YLfe+HXl4hkzs44b@nand.local/

> This change aligns with the standardized practice in many repositories
> and simplifies the workflow for users.
> 
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>      blame: respect .git-blame-ignore-revs automatically
>      
>      
>      Introduction
>      ============
>      
>      Hi, I'm Abhijeet (Ethan0456), and this is my first contribution to the
>      Git project. I currently work as an ML Engineer at an early-stage
>      startup, and I’m excited to contribute to this open-source project.
>      
>      
>      Why the Change?
>      ===============
>      
>      I came across this enhancement request on the bug tracker and found it
>      beginner-friendly, making it a great opportunity for me to get familiar
>      with the Git codebase. The ability for git blame to automatically
>      respect the .git-blame-ignore-revs file is something that can streamline
>      workflows for many users, and I felt it would be a valuable addition.
>      
>      
>      Feedback
>      ========
>      
>      While I’m confident in the changes made to builtin/blame.c and the new
>      test case in t/t8015-blame-ignore-revs.sh, I welcome any feedback or
>      suggestions to improve both my code and approach. I’m eager to learn
>      from the community and improve where needed.
>      
>      
>      Community Need
>      ==============
>      
>      There is precedent for this functionality in other projects:
>      
>       * Chromium
>         [https://chromium.googlesource.com/chromium/src.git/+/f0596779e57f46fccb115a0fd65f0305894e3031/.git-blame-ignore-revs],
>         which powers many popular browsers, uses .git-blame-ignore-revs to
>         simplify the blame process by ignoring non-functional changes.
>       * Rob Allen's blog post
>         [https://akrabat.com/ignoring-revisions-with-git-blame/] discusses
>         the need for ignoring revisions with git blame, and a commenter
>         specifically suggests that it would be helpful if Git automatically
>         respected .git-blame-ignore-revs.
>      
>      I hope this change aligns with community needs and improves the git
>      blame experience for users.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1809%2FEthan0456%2Fblame-auto-ignore-revs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1809/Ethan0456/blame-auto-ignore-revs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1809
> 
>   builtin/blame.c                      |  8 ++++++++
>   t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
>   create mode 100755 t/t8015-blame-default-ignore-revs.sh
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e407a22da3b..1eddabaf60f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1105,6 +1105,14 @@ parse_done:
>   		add_pending_object(&revs, &head_commit->object, "HEAD");
>   	}
>   
> +	/*
> +	* By default, add .git-blame-ignore-revs to the list of files
> +	* containing revisions to ignore if it exists.
> +	*/
> +	if (access(".git-blame-ignore-revs", F_OK) == 0) {
> +		string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs");
> +	}
> +
>   	init_scoreboard(&sb);
>   	sb.revs = &revs;
>   	sb.contents_from = contents_from;
> diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-default-ignore-revs.sh
> new file mode 100755
> index 00000000000..84e1a9e87e6
> --- /dev/null
> +++ b/t/t8015-blame-default-ignore-revs.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +test_description='default revisions to ignore when blaming'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'blame: default-ignore-revs-file' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git rev-parse HEAD >ignored-file &&
> +    git blame --ignore-revs-file=ignored-file hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame hello.txt >actual &&
> +
> +    test_cmp expect actual
> +'
> +
> +test_done
> \ No newline at end of file
> 
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2

