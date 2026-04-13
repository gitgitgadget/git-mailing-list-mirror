Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124F3988E3
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071298; cv=none; b=UDb9ea8X7hnDgcg3BMF7S8FWXZvh8NL1lXNc0TnbSEHJZvJz7Nr9lVEY/8mfNyKdAus8mz3nkSvZRKohpfEpzpLKwPEinWZ4d4EdhZ9q3dLNK98zpW4I+tu2fzQ2tOfQYopHfy+wOzrrDLxE2zUvVtkwE5kaRj/QLVlmTWey+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071298; c=relaxed/simple;
	bh=mUfHFpHLqspw3WqmeY31PYBWCzQOkpo+YIKzkzSWghQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BX+WUDbMjX5EDryfFRtEUNnpXQ3n66kWGN6B+WRoJZkvPxMx5wuHySp7yJfxx46GejCgVL09zCo1pJm5d10xanlzVL0WeyCDFG86vX7VJIryNrzRhFbANHbvfiGbf0bxR8MzW6ncANLWMyU264n/GrL94UWXyOKntletHoO3/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ9ANUKh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ9ANUKh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39265885e9.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 02:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776071295; x=1776676095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UEwJrkGM4GDSSTiPWU85NlMzOw9c1Hia90AxfT8WoFs=;
        b=lQ9ANUKhaH++1EPSExFHwPeqdc3gdKnIyYUujgmx5USrJI1cuzrPgBqBHucSgmiVTF
         wgbENDtEvaoiRyaZ+z7tQoxgzLIAbvAaQhfUozGxfzci7lJtlz389Vdy5OjeOqVg9aNO
         32hpM0LGTLkZvxPl9CXSWd7UhP/C5Nbq952ay4dD/rW4OqA8yMObYTFlfa7M9WXsZ7zc
         EqsM7BY6sAAw2Y8yQbGSi8JkIr/BgxeAmQiTPtcjRcRhfEWLi2xABEkzEXJuFYClcLyN
         KIgGJfBlGvBoXI9pBmUmLqQEA10y5xshszjqsJMP5fiBA0Me8EzYTZplRtdFm17s1yza
         EJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071295; x=1776676095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEwJrkGM4GDSSTiPWU85NlMzOw9c1Hia90AxfT8WoFs=;
        b=bxoxd8WcSvPcHLX1X9DPxe5GOjc/Pf6zcAmb4KB6VOUdDNr8av+ECTpRGQx3U7aRFH
         sdzis8hESoraIjxvqsl1evQc4uUx47RRv+YSR5xEtJ15ulT4btlPlNh+EP/rBnjsmuLz
         p8BDtAK5RFu3TwgU1x6VBIpoEv/3wiXAicsfRFH2h9/KlKu7DoK4u35tRlRmCbFhL1cX
         ncCAkJdrBlTn8NiCxO4rw9bhyzPpEPCqF5+ulk8N4RA/L6qyxU1FbHtd4dvHwSJdTmVx
         dnpNTMW+Dm1f4aMOwBB5VTIMA2Ou99/TRzUUaBMNzi3bvX6qUoEqvjXd9FX1L6dTmAx6
         XsUw==
X-Forwarded-Encrypted: i=1; AFNElJ/mSUdXb3IvXIOO0OLhnTKM7Ias5j2S801UUeBRxizKo43zHqfw19N+QkXEfLiVJasIKqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmP2lBO/DCyUeD8rrMNuk+A0WerwdeRGtM8W3a8dR2KmHCdAau
	8iaurwbp/KJuocyjSEgfiipQtVeWzBlM7/PcgIIK6Y0kKbYEhha67jY6
X-Gm-Gg: AeBDietgLXMgcUaQR4o77OAJxVzQ2bLQBOPIwZoOBMsc+njjX05d/m3eixoJGZgEXE3
	ljoY8ur3ZqhwA2JSL/8PmIR4xszbVjUTF5LruckC8BH2Tl/HSvxlfCU/Nqk6mp3BafKbKgKzppO
	FeroZniS01/KRkIBFamMOGwow/Ru1/CJQplUtVxCcRPl0j88UuqpElklB7b5fRFNAjNcwWBpjWl
	JDa6YWbbLTFWHwvFgQlE4jCdvJmygYrZdGL9FuXZPAurIlnTZ796UBUtNHhjftDNmhYSTDibGho
	/P0AYVhrJ94y1bsycEvKUaxnfzIkeIUM/G1ZmId2UFhY2TnMIObiF60Vi6XHnl/skWE5UbG+WUy
	Wm+51zKXz708uKoSgyHWVC3QXMwjmFYgXMzsU4eTPcNuN0Ax7kAtfnW5PRFWt8w27Is49KKZ3BP
	LTloK4ZK9qAMFrEJFv4/7mot297gVrF2GfifnlJZ5AolZEYEyMGVDQ6EeVqOfDBgy0lgLTKZvvH
	4o=
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id 5b1f17b1804b1-488d68764b0mr169232615e9.15.1776071294935;
        Mon, 13 Apr 2026 02:08:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488df2a1237sm333101515e9.6.2026.04.13.02.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 02:08:14 -0700 (PDT)
Message-ID: <00b92c0b-8602-45e4-bec3-c7c538bd288b@gmail.com>
Date: Mon, 13 Apr 2026 10:08:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] stash: infer "push" when command line starts with an
 option
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>, git@vger.kernel.org
Cc: ben.knoble@gmail.com, mroik@delayed.space, quentin.bernet@bluewin.ch,
 gitster@pobox.com
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260412195204.4636-1-deveshigurgaon@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260412195204.4636-1-deveshigurgaon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2026 20:52, Deveshi Dwivedi wrote:
> When "git stash" is run without the "push" subcommand, the command
> tries to assume "push" but rejects any non-option arguments (i.e.,
> pathspecs without "--") to avoid treating a misspelled subcommand
> name as a pathspec.  The only exception is "-p", which sets
> force_assume and allows pathspecs to follow.
> 
> This means "git stash -m foo file" is rejected even though "-m" is
> clearly an option and not a subcommand name, and the user's intent
> is clear.  The same applies to any command line that begins with an
> option.
> 
> A command line that begins with an option cannot be naming a "git
> stash" subcommand, so unconditionally assume "push" in that case and
> allow pathspec arguments to follow without requiring "--".  This is
> simpler and more robust than checking a specific list of options,
> and remains correct even if push or other subcommands gain new
> options in the future.
> 
> Note that this does not check for negated options, so "git stash
> --no-staged [<pathspec>]" is still rejected.  Handling negated
> options would require teaching the inference logic about them
> explicitly.

That was true of the implementation in V3 which checked to see if any of 
the option variables were non-zero. Looking below, it now checks if the 
first argument begins with "-" which means that force_assume will be 
true when "--no-stage" is given.

The implementation looks good, I've left a couple of comments below.

> This was marked as #leftoverbits in [1].
> 
> [1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/
>  
> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> ---
> 
> Changes since v3:
>    - Rewrote the approach per Junio and Phillip's suggestion: instead of
>      checking a specific list of push-only options, unconditionally
>      assume "push" whenever the command line begins with any option.
>      This is simpler and robust against future option additions, and
>      sidesteps the fact that -m and --include-untracked are not unique
>      to "push".
>    - Updated the test to reflect the new rule and switched cleanup to
>      test_when_finished per Junio's suggestion.
>    - Updated documentation accordingly.
> 
>   Documentation/git-stash.adoc |  7 ++++---
>   builtin/stash.c              |  6 ++++--
>   t/t3903-stash.sh             | 26 ++++++++++++++++++++++++--
>   3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 235d57ddd8..135719611a 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -61,9 +61,10 @@ COMMANDS
>   +
>   For quickly making a snapshot, you can omit "push".  In this mode,
>   non-option arguments are not allowed to prevent a misspelled
> -subcommand from making an unwanted stash entry.  The two exceptions to this
> -are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
> -which are allowed after a double hyphen `--` for disambiguation.
> +subcommand from making an unwanted stash entry.  Pathspec elements
> +are allowed after a double hyphen `--` for disambiguation.  When
> +the command line begins with an option, "push" is inferred and

"assumed" might be easier to understand than "inferred"

> +pathspec arguments are also accepted without `--`.
>   
>   `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
>   
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 95c5005b0b..be96338d35 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1871,13 +1871,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   	if (argc) {
>   		int flags = PARSE_OPT_KEEP_DASHDASH;
>   
> -		if (push_assumed)
> +		if (push_assumed) {
>   			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
> +			if (argc > 1 && argv[1][0] == '-')
> +				force_assume = 1;

We assume push was given if the first argument starts with '-'. That 
makes sense. If we get on invalid option we'll display the push usage as 
we did before.

> +		}
>   
>   		argc = parse_options(argc, argv, prefix, options,
>   				     push_assumed ? git_stash_usage :
>   				     git_stash_push_usage, flags);
> -		force_assume |= patch_mode;
>   	}
>   
>   	if (argc) {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..88f2b3c86b 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -410,8 +410,30 @@ test_expect_success 'stash --staged with binary file' '
>   '
>   
>   test_expect_success 'dont assume push with non-option args' '
> -	test_must_fail git stash -q drop 2>err &&
> -	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
> +	test_must_fail git stash someunknown 2>err &&
> +	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''someunknown'\''" err

This is based on the existing test, but there is no need for "-e" and we 
normally match a single quote as "${SQ}" (which is defined by the test 
suite) or simply "."

> +'
> +
> +test_expect_success 'assume push when command line starts with option' '
> +	test_when_finished "git reset --hard" &&
> +	test_when_finished "rm -f untracked-file" &&
> +	echo changed >file &&
> +	git add file &&
> +	git stash -m "implied push" file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --staged file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --keep-index file &&
> +	git stash pop &&
> +
> +	echo untracked >untracked-file &&
> +	git stash --include-untracked untracked-file &&
> +	test_path_is_missing untracked-file &&
> +	git stash pop
>   '

This test looks good

Thanks

Phillip

>   test_expect_success 'stash --invalid-option' '
> 
> base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0

