Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034E745E4
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894974; cv=none; b=s/URW2Jl2E8iHswhNZOs0H3NrxHz1YaUKARfmLwmFOVPemo1N45fK1b7c5040OAAghbod2yiGYPMIFtUcZMJMeu8bKJDgv9UkrtXGnEvmYCq/1M5NOjzsnUtc6zfkH76pwXYAgRXQONTCqSnN3IZlVnicrX/2KplahQXbDFHY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894974; c=relaxed/simple;
	bh=4pNPjhXzcwOUy+xCPJdOrKLXO81Q4VMEg/QL6UEsUdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSjFaQkWXWF7UMCQ65kc9nL1PtokKCZppUQ9QSbSArFHUy8vy6PG4h/TjbTKlfdSHddZG5QE2syfXbhCkMETDJFtNrWw6fGEFvl4fRezE2e7rIR9MQVAzopkqjAMCfffLXskR6S4b2KOr90vZIcag7Pz9ccsa9NamcZ/XoEqu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C22SVyl6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C22SVyl6"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so13245901fa.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725894971; x=1726499771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rvEFVG0HwcvLaPf3HofOHWRUEuDoUhRtxv+7dOv+n8s=;
        b=C22SVyl67Z6wqdS61e8zq5L3RgaQYTB1fUGlFnouwnPbTLSoOoJPKo5lxxz3C08pur
         KNcDIZvswa+xTfQFfIojJmHG3gWTOJunqMRGSZ+OK5hGcxrFph43b90K67YER8KXEdvT
         VrVob7bTSf0DVcJom6ofzpIehmVCUG1ImB2bLJeOl+hi4czc3bBURf3ugFBvvUf6FHqS
         1327i/XC0JkmW1t3HfV5t4rbjX5pac8Or1jsnTpJDd9eVa9PWHaqUaioPQGpXK5RKfhA
         GYiUpf/h/rHAZQefJCTC2zPR108PgEBWwj23dbn9quT8cpG89WWp3+oioxL8QUR043s4
         hSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894971; x=1726499771;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvEFVG0HwcvLaPf3HofOHWRUEuDoUhRtxv+7dOv+n8s=;
        b=UZ/q85CZQDIjl3oNXsMFSEtE44f4wShcsh4adee3CQ4UlMR0XILep9oErb58b9yzrl
         A4jPo4PvYTtmzSVRhZsgvw4mHo2mSTJCQFwEkf89BzLV/pUlgA/vyi3l5NOLXXo7rHpf
         2rzgFdPEbBlXGCf0JUiiqb0q1fX3U1cTkAI7tYkgIP8dOd4ar1B22kfrFezvgHqmKcnl
         oH119VesjiSoRG5LqPldRWvZjDpRsTQdtJIRESnUZB4tXs6zsXyQm7x4NV9EBRZA/nQT
         9Pvmc1Rg2CROgauKGfdcQH2I+h/sOF93RWHLn6vo64h1Gcd0mOXLhxbUfw0JIMj6GTwN
         GjTA==
X-Forwarded-Encrypted: i=1; AJvYcCUI5eiGCfoQHh+cYB4nLRKXXAqp3aKQNBtGctfzU5fkx+IRdltyBjNZxzN5arj0/0jKULw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OIBXQICAckodb2Vac7JCiO3aQQAE5hewKW7M816+nk74rXbo
	fq3ltdhTK1Dap08bxJ5XNOI1S+YRLOhVnfOPOaZuoHut5KatrjOoT6ksxg==
X-Google-Smtp-Source: AGHT+IEnyLLey2ocA4oE/ifWCgvgniBK2LkY/0ja9FufO28pNxR14zG2YBLKggEJkj6wwXZWpm0lbg==
X-Received: by 2002:a2e:5159:0:b0:2f6:d5e2:7889 with SMTP id 38308e7fff4ca-2f75232593dmr53832321fa.19.1725894969718;
        Mon, 09 Sep 2024 08:16:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b2a8csm7853191fa.140.2024.09.09.08.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:16:09 -0700 (PDT)
Message-ID: <b4ce7873-3dfa-443c-847c-64200fd065cc@gmail.com>
Date: Mon, 9 Sep 2024 16:16:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] diff: report copies and renames as changes in
 run_diff_cmd()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Jorge Luis Martinez Gomez <jol@jol.dev>,
 David Hull <david.hull@friendbuy.com>
References: <130d4803-2818-4611-9258-951a18dd5717@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <130d4803-2818-4611-9258-951a18dd5717@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 08/09/2024 08:05, René Scharfe wrote:
> The diff machinery has two ways to detect changes to set the exit code:
> Just comparing hashes and comparing blob contents.  The latter is needed
> if certain changes have to be ignored, e.g. with --ignore-space-change
> or --ignore-matching-lines.  It's enabled by the diff_options flag
> diff_from_contents.
> 
> The slower mode has never considered copies and renames to be changes,
> which is inconsistent with the quicker one.  Fix it.  Even if we ignore
> the file contents (because it's empty or contains only ignored lines),
> there's still the meta data change of adding or changing a filename, so
> we need to report it in the exit code.
> 
> d7b97b7185 (diff: let external diffs report that changes are
> uninteresting, 2024-06-09) set diff_from_contents if external diff
> programs are allowed.  This is the default e.g. for git diff, and so
> that change exposed the inconsistency much more widely.

Thanks for fixing this - both patches looks good to me.

Best Wishes

Phillip

> Reported-by: Jorge Luis Martinez Gomez <jol@jol.dev>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>   diff.c                 |  3 +++
>   t/t4017-diff-retval.sh | 16 ++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 4035a9374d..1d2057d4cb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4587,6 +4587,9 @@ static void run_diff_cmd(const struct external_diff *pgm,
>   		builtin_diff(name, other ? other : name,
>   			     one, two, xfrm_msg, must_show_header,
>   			     o, complete_rewrite);
> +		if (p->status == DIFF_STATUS_COPIED ||
> +		    p->status == DIFF_STATUS_RENAMED)
> +			o->found_changes = 1;
>   	} else {
>   		fprintf(o->file, "* Unmerged path %s\n", name);
>   		o->found_changes = 1;
> diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
> index f439f469bd..9a4f578614 100755
> --- a/t/t4017-diff-retval.sh
> +++ b/t/t4017-diff-retval.sh
> @@ -143,4 +143,20 @@ test_expect_success 'option errors are not confused by --exit-code' '
>   	grep '^usage:' err
>   '
> 
> +for option in --exit-code --quiet
> +do
> +	test_expect_success "git diff $option returns 1 for copied file" "
> +		git reset --hard &&
> +		cp a copy &&
> +		git add copy &&
> +		test_expect_code 1 git diff $option --cached --find-copies-harder
> +	"
> +
> +	test_expect_success "git diff $option returns 1 for renamed file" "
> +		git reset --hard &&
> +		git mv a renamed &&
> +		test_expect_code 1 git diff $option --cached
> +	"
> +done
> +
>   test_done
> --
> 2.46.0
> 
