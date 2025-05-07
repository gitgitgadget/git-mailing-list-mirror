Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20376410
	for <git@vger.kernel.org>; Wed,  7 May 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611479; cv=none; b=S5ySTLxEswtA9IlKb2h+jMNOCYs8DguDNzsZG7Pek25/bs4nnO+jEJ0Jqsj4MC81ZJgddHA5op1oDBfWmfDJ5SFDsiIeL3btqTI2Ett6KGygmJi7+cf8ChMPt0N/FfpE4ZQaRxU0/17gxRlBLSlhna8L8sMHcMp6Iobsauxe31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611479; c=relaxed/simple;
	bh=Mh4mF7QNf1S1MIHlDvcP735kYaSZA5qeEp5/+1royJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn3RT2h3zF1xyoo6ff4d3gJ05ctg8wSEJgVMyPTxXy0280XKVcwIBSVdu6DeGZzKwch0PeDSK5p7dIcPJtQgE4saogLAtsPg5qmO+wSTvi4fIKaVZH1O57e7V4LtiUSA0tW+i3BQBRutCTMJSUJKjABCwneo7T5dizwW6IgHra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEakCmyD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEakCmyD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so27238935e9.1
        for <git@vger.kernel.org>; Wed, 07 May 2025 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746611475; x=1747216275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VOYSv3PtN0h7HP/otjuHOnA4fnl3uVIwNKYmsZkO1i4=;
        b=ZEakCmyDPXlafE5MMCu3oeB0zHxWpHx9YJQQVH+vaGcO5iZwhTbQt2FvmNwzXRnIS8
         iblt7VhS3BURMUmVhWDD8fWcyomEtlMR+3/gUZ362Qv4LpcsvjrtDeDPa6kxnY93xezw
         ZwoYFv5OTkeNop0+vghmXmsbxrKjXaoZG/4OxfDCxfeslHsD31zq7d7xfUbLMDI1M7fA
         HDjy9h2QXIeMnBHKgwP7CU8l25FFOrak3c3YbpOoWG33f7GTEZNOEO81zNjOh41ccK2M
         hjgGPWWO3ICCJmI44sK9Cakrblm5xF7KLxYyuhyfsGqRu3qo+w5x+TkZm15KSVXyrf1p
         IVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746611475; x=1747216275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOYSv3PtN0h7HP/otjuHOnA4fnl3uVIwNKYmsZkO1i4=;
        b=qdovnoWdPwMPmD5lpPJd7TLvXbgOPfFlEegj3MGOLGTxTBDNOzZTDvV7IC0mQaafFY
         SYk0sWMkJ10LqIIHZ6EEy2lLeDFdu6QC6jqvi1FOl4SuIxETPixMH/F1IPSI179vPcra
         gB7+FZqPiGGlxtSa9gkKScOXpT9//MkCejkmX7uWZxz+hspAkwZE/xezKt3s+GKy+LKf
         tow3a4MkkdnATDygnH2AkEs+vtstfZHByS2LpuWG1XcQRmd5anPMoUue6QY3rM5I4b1x
         febwx2TTRgvzwly+l9OViIheYz42wnGdM0UUc0Meefx6Uian8rOxL8IVdf8gT8jm/sf9
         uNuw==
X-Forwarded-Encrypted: i=1; AJvYcCWMnvqo03uWpRey3xNtZ5WUvAM0n88jXuQC4bJVAAp2M5VzdExnKN9FDCBKLs2JI1vut+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIYy8QFP8HSNoxEbrmb31YWTf3Mk/DFOAsVPr8YXyDZTlPbbs
	XVFyUVSjZ87BPA13186ggz24nPsrrxFTPq7vRnsO+PBjqEuE7zS94nCPIA==
X-Gm-Gg: ASbGncvQdQ4jJe9kZI7+BXVe6RrU5xVQJ2ZcnYheIaK0Bk75lwbIUt7SYALI+DntWU3
	0A4FjE7HjLEPz1TOn7ZFrjxvzGSKSeYmEZ2ONkI20170IT9ODrtABwpTS7P0N/f1/bw/g+PBlVe
	F7wHdMU24HjLNbbDuhAxIWXxLnKUj8utMitnt9wfwP5oCjaEBVSuMwLE9CCDrfMuyq0mGGGMy16
	g/C3rnwyloA9JwIS297b46i4q7HjtD9/IOsDgZM+eNrq5Z9Oyd0O+ogfA7pMK9wZcfdpuiGigPX
	DuuTwXoSGiDJpDEgHtNSvLXK7Hzqt0vFodvEGQB3DypvQQ7XxpAwORdhc6k7iypkg2nCVnUgDCQ
	lkx3hjk/mbWgLcAFk
X-Google-Smtp-Source: AGHT+IH3FKHW3DHaON/PLy4hZ3EetLpkUqVTMUABL4X6W/53r0ARWy4gIFMxvyERWMREgN+QSToUkQ==
X-Received: by 2002:a05:6000:1885:b0:39c:1424:2827 with SMTP id ffacd0b85a97d-3a0b4a0526fmr2521303f8f.15.1746611474965;
        Wed, 07 May 2025 02:51:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17260sm16798183f8f.98.2025.05.07.02.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 02:51:14 -0700 (PDT)
Message-ID: <61fe7690-87af-4159-be87-cd39c09475fe@gmail.com>
Date: Wed, 7 May 2025 10:51:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 05/05/2025 10:18, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> This patch compliments `8b91eef812`, where builtins that accept
> `--patch` options now respect `diff.context` and `diff.interHunkContext`
> file configurations.
> 
> In particular, this patch helps users who don't want to set persistent
> context configurations or just want a way to override them on a one-time
> basis, by allowing the relevant builtins to accept corresponding command
> line options that override the file configurations.
> 
> This mimics `diff` which allows for both context file configuration and
> command line overrides.
> 
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>

I'm somewhat torn about the name "--unified" as I don't think it is 
particularly informative - it only makes sense if one knows the diff 
option and we only support a single diff format. Having said that it is 
probably better to reuse the name from "git diff" for consistency.

> +`-U<n>`::
> +`--unified=<n>`::
> +	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
> +	or 3 if the config option is unset. Implies `--interactive/--patch`.
> +
> +`--inter-hunk-context=<n>`::
> +	Show the context between diff hunks, up to the specified _<number>_
> +	of lines, thereby fusing hunks that are close to each other.
> +	Defaults to `diff.interHunkContext` or 0 if the config option
> +	is unset. Implies `--interactive/--patch`.

This documentation is repeated for each command. I think it would be 
better to put this in separate file that is then included where it is 
needed. That way if we need to update the documentation in the future we 
only have one copy to worry about. The syntax to include a file called 
diff-context-options.adoc is

include::diff-context-options.adoc[]

> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -86,6 +87,11 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
>   	if (s->use_single_key)
>   		setbuf(stdin, NULL);
> +
> +	if (add_p_opt->context != -1)
> +		s->context = add_p_opt->context;
> +	if (add_p_opt->interhunkcontext != -1)
> +		s->interhunkcontext = add_p_opt->interhunkcontext;

This happens after we read the config so the command line option wins - 
good.

> index 693f125e8e4b..653f07a917b8 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -3,6 +3,13 @@
>   
>   #include "color.h"
>   
> +#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }

I think we normally define initializer macros after the struct they 
initialize so the reader can more easily check the fields are all 
initialized correctly

> +struct add_p_opt {
> +	int context;
> +	int interhunkcontext;
> +};
> +
>   struct add_i_state {
>   	struct repository *r;
>   	int use_color;
> @@ -18,14 +25,17 @@ struct add_i_state {
>   
>   	int use_single_key;
>   	char *interactive_diff_filter, *interactive_diff_algorithm;
> +	int context, interhunkcontext;

Should this be in the previous patch? It is a good idea to run

     git rebase --keep-base --exec 'make && cd t && prove -j8 
tests-that-you-think-might-fail :: --root=/dev/shm'

before submitting a patch series so that you can be sure the patches all 
compile and the tests pass. Running the whole test suite can be pretty 
slow so just run the tests that are relevant to your changes.

> @@ -169,9 +170,10 @@ int interactive_add(struct repository *repo,
>   		       prefix, argv);
>   
>   	if (patch)
> -		ret = !!run_add_p(repo, ADD_P_ADD, NULL, &pathspec);
> +		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL,
> +				  &pathspec);

This line could be unwraped and still fit within 80 columns I think.

>   	else
> -		ret = !!run_add_i(repo, &pathspec);
> +		ret = !!run_add_i(repo, &pathspec, add_p_opt);
>   
>   	clear_pathspec(&pathspec);
>   	return ret;
> @@ -253,6 +255,12 @@ static struct option builtin_add_options[] = {
>   	OPT_GROUP(""),
>   	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
>   	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
> +	OPT_INTEGER_F('U', "unified", &add_p_opt.context,
> +		      N_("generate diffs with <n> lines context, implies --interactive/--patch"),

It cannot imply both --interactive and --patch as they are two different 
operations. I think it should imply --patch because that option is 
supported by all the commands we're adding -U to.

> +		      PARSE_OPT_NONEG),
> +	OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
> +		      N_("show context between diff hunks up to the specified number of lines, implies --interactive/--patch"),
> +		      PARSE_OPT_NONEG),

As these two options are duplicated in many commands we should define a 
preprocessor macro for them in parse-options.h. If you look at the end 
of that file there are a bunch of similar definitions.

>   	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
>   	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
>   	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
> @@ -398,7 +406,12 @@ int cmd_add(int argc,
>   			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
>   		if (pathspec_from_file)
>   			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
> -		exit(interactive_add(repo, argv + 1, prefix, patch_interactive));
> +		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &add_p_opt));
> +	} else {
> +		if (add_p_opt.context != -1)
> +			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
> +		if (add_p_opt.interhunkcontext != -1)
> +			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");

I don't understand this - I thought the help for --unified said it 
implied --patch but here it is erroring out if --patch is not given.

Somewhere we should check that the values given for the context and 
interhunk context are non-negative. git_diff_ui_config() errors out if 
the context is negative and we should do the same in add-patch.c 
otherwise we'll get some wierd error about "git diff-index" failing. We 
should also think about -U0 as "git apply" rejects hunks without any 
context unless by default and I dont think "add -p" passes the option to 
enable that and I'm not sure it should.

> +test_expect_success 'The -U option overrides diff.context for "add"' '
> +	git config diff.context 8 &&
> +	git add -U4 -p >output &&
> +	! grep "^ firstline" output
> +'

It is great that you've added tests and I do think we should test all 
the commands here as unlike the previous patch there isn't a common code 
path. My other comments about the tests in the previous patch apply here 
though I think.

We should have a test to check negative context values and possibly zero 
are rejected.

Thanks

Phillip

