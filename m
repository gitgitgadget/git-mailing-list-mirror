Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C720FA81
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032622; cv=none; b=rX0LuiAOOEoCUaIpB/Dj1cBEqFjvtipWvkkimGFAf/JiCrS/YgoxRK/iCGiFfQ3QE4cjf9NupQ2n7gYRWnUQJIgrdX1oMGZEy0isDBxRkA8phSgcvGJ3K2SM2bL3tSp7F0DqtUxXU9dX4hePbEV8XA6YGHYZheMspMgFGu7EHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032622; c=relaxed/simple;
	bh=TQFchWiLzeVZvQJt3k/a3Q0gNaWUj3NAy0u7h/ugLM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhXDFmP5rzH54GUloYbCwaISgS77BcP3b5M+v/rX5uEPjVtYvxRuJOHvaJdSgMl66yYW80j1xinNoykv7LLnLMe2DjLGItyKb1CjmKuqNBVhXoBlNiW/spquI+edGN9BwArmNKPFfIpqIAOy3FNsmruYylQ6z+GyW0dp5J3Tuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kz1/oyyx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz1/oyyx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49ff680331aso5779665e9.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791032619; x=1791637419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3WcLx4K1x7QSVvVXEE31px5YxriaWrR+AhETtoawQs=;
        b=Kz1/oyyxHpCb/ds9+0I9gl0jOwug+Y338HlwJG/7SJ1Mim7f5INGTfZVZhYSLUJkmM
         i0+1JtlDZtgePNwl+4MPaUs5utX24DdMYO1k5idG7Gcwz/Y6f8WPTKeXi7J8zMBAgRLw
         xr2MlXlB/050rn02WzL3nIZSsHQ7/pWbV5WEGiedjkxZy6XhJ+ar6qJ4vNuuvJfPFi8V
         +Caab1st+OtMnp3IEz4+qGouBCvA64nw3P9x9nAFgIpVm64FAUwvgqOpxtY30PQrgBuB
         7EimnSgcyVssTxcP10vy9f5cg3tQj/8ofLty1SIENPmCpG5W6waKx61ri2GMrBzPRMpe
         6klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791032619; x=1791637419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3WcLx4K1x7QSVvVXEE31px5YxriaWrR+AhETtoawQs=;
        b=noIcUL46XyIX2oeQyD3KGADIAi3j1vd0LVrckuAG6xaNWwCAQpXQfz3hA0hJoiXWSl
         LWB7Srqw2uJNP0x8YzAnmvQED/PI+cQF22O9WK/K22NPMrY8ZrZfTZqO2B4mk1HOyTiV
         0GJCp38NrhPARshl2cLRUt89czqZBY8EmaaM1O651s1zzhZQDoyj7SEGuJrlK/U6OetK
         yqDFdEWUJCO1OAmc15Z3oydt/q74W0l1SBvQnaw+T+JBw9f2d9Uzyn2rQNLaDyaO20BK
         UglGf5nI/8ntqxdp0zJzPNd6FXVoLWWForkrPS7Yhdw0s0rJA0dxfapO1qlFnkAz5XvS
         ypmQ==
X-Forwarded-Encrypted: i=1; AKwUvByRvn+NmGAa5baEGGmltVjv/fnQL0TFVx1/z3jVtD5CW48ECOqAaOn0izYZ9Uzi/boprHM=@vger.kernel.org
X-Gm-Message-State: AFuF++mMSG+ph0rYFnKuwdW1NdfUfE73e7ncmFlpR+kH9OzE2J7b7Pil
	2mPp8h+euRz++4DSbvyBLFUStBT7m0S12Oh1i5tKx8eMZchnYgCkl0E3
X-Gm-Gg: AYBFou1e4H8b1RGjZjoLOef0m+Oz8F2BXtrCoe0gqGsU+KgcZt110PR5c728NFkgcS3
	O0JbHSbRLKfFYMzRo6N21oVaV0MQPnNkaP7iKL48TZMH/jhlRBxEbyOclySixP5Mdvm6mSfhPyd
	o2IJP4O+QaKO9NxlRd8UKeYQoSJLoUEpMbaDAzQeAtmHaJyAnAKthhWXNnLzRwAfy1rVVxaft16
	j0xe/tLXv238ycA7Adsiu2iAXVX59oSDi7h2KQlJUAUGDUCrt3rpr1ACGSm2z3/KZwbwgBdwovZ
	l/kfs1mHUGxqlesgzOzTG0Qy4JPDfvuW6aIkbxX6dhAagyd0QZpFeOmwrDHyRCk0yf6jRfPe9wU
	SuYwTHIXw4Rj60zQ/H4FiKSJZmDccvg2Z0S0nF4FxP3bnW7UWhnvpUhQMobyvI4Xya83aQjCT8V
	/LBGcaxIuo5vH7q7DvQtZqw6bRZLLYPcEN3JFmjtYFuhZer69yy1/OiSS9kgixyujdINYN5y1dG
	S8Yo4yQUiWNu18CBXr7S3gqoPaudEVFro+hudZVGHXHUj4ZH05Vb3xF+1s=
X-Received: by 2002:a05:600d:82e6:b0:4a1:6c48:c789 with SMTP id 5b1f17b1804b1-4a16c48c849mr13563885e9.2.1791032618977;
        Sat, 03 Oct 2026 06:03:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:8594:4f6f:5dfd:ff78? ([2a0a:ef40:724:6601:8594:4f6f:5dfd:ff78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm131647255e9.2.2026.10.03.06.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 06:03:38 -0700 (PDT)
Message-ID: <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
Date: Sat, 3 Oct 2026 14:03:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test
 script
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/10/2026 09:11, Harald Nordgren via GitGitGadget wrote:
> Link failure and leak annotations in CI to the test script, so both can be
> found from the job summary.
> 
> V5 CI Job where failures and leaks are reported:
> https://github.com/git/git/actions/runs/36979818141/job/110752027863?pr=2426

There does not appear to be any output relating to leaks in that job. 
The first patch hasn't changed so I'm not sure why that is.

> Changes in v5:
> 
>   * Removed % escaping entirely, verified on CI that it isn't needed. Every
>     existing test description that uses % renders correctly unescaped.
>   * Rewrote the file/line commit message with a concrete example (failed:
>     t1060.17 partial clone of corrupted repository).

You have added


     When a test fails, GitHub shows an annotation naming it, for
     example:

         failed: t1060.17 partial clone of corrupted repository

which shows an example of the current output without the filename or 
line annotations. There is no example of what that output changes to, so 
there is no way for someone reading that message to see what has 
actually changed. After spending some time clicking around in Github I 
think what that patch changes is not the test output of individual jobs 
which you linked to above, but what is displayed on the summary page at

https://github.com/git/git/actions/runs/36979818141?pr=2426

That page shows a list of annotations with links to the changes in the 
failed test file. That is a useful improvement but how you expected 
someone reading the commit message to understand what had changed when 
you did not give an example of the new output, and the changes are on a 
different page to the one you linked to in the cover letter is beyond 
me. I'm pretty exasperated that I've had to spend time messing about on 
Github trying to see what has changed because you could not provide a 
link and write a couple of sentences explaining it. After asking what 
this change did in v3 you replied that the commit message wasn't clear 
without explaining what the change actually did. When I asked what the 
change did in practical terms in response to v4 I got no reply. As you 
already know reviewer time is short on this list, so please, when 
someone asks a question answer it rather than replying with an obtuse 
comment or simply ignoring it and sending another patch.

Both these patches are useful improvements, but trying to get an 
explanation of what they did has been like trying getting blood out of a 
stone.

Thanks

Phillip


> Changes in v4:
> 
>   * Clarify commit messages and simplify escaping logic.
> 
> Changes in v3:
> 
>   * Fixed bug in the --immediate exit ordering: the --immediate &&
>     --invert-exit-code path called exit 0 before the test's annotation was
>     written, now a single unconditional call covers both exit paths.
>   * github_escape_message_ no longer relies on \r being a portable sed escape
>     sequence (not POSIX-guaranteed and BSD sed implementations can differ),
>     it splices in the literal carriage-return byte via printf instead.
>   * Reverted unrelated test-tool line back to its original form.
> 
> Changes in v2:
> 
>   * Split into two commits, each explaining its own reasoning.
>   * Leak output is no longer capped or embedded in the message, it's now an
>     uncapped fold, so multiple leaks in the same test both show in full. A
>     second leak in a different test still won't show in the same run,
>     --immediate stops the script at the first failure, but it no longer gets
>     buried under every later test falsely reporting "not ok" either.
>   * Drops the giant unfolded message that annotations used to carry, which is
>     what probably caused the scrolling behavior.
> 
> Harald Nordgren (2):
>    ci: annotate leaks and stop a leak-sanitizer script at its first
>      failure
>    ci: point test failures and fixed known breakages at their file and
>      line
> 
>   ci/lib.sh                            |  1 +
>   t/test-lib-github-workflow-markup.sh | 46 ++++++++++++++++++++++++----
>   t/test-lib.sh                        |  6 +++-
>   3 files changed, 46 insertions(+), 7 deletions(-)
> 
> 
> base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v5
> Pull-Request: https://github.com/git/git/pull/2419
> 
> Range-diff vs v4:
> 
>   1:  138394b48b = 1:  851efeec8b ci: annotate leaks and stop a leak-sanitizer script at its first failure
>   2:  8ec2b53d82 ! 2:  46f93a9e16 ci: point test failures and fixed known breakages at their file and line
>       @@ Metadata
>         ## Commit message ##
>            ci: point test failures and fixed known breakages at their file and line
>        
>       -    A test failure or a fixed known breakage gets an annotation that names
>       -    the test but says nothing about where it's defined, so a reviewer has
>       -    to search the script by hand to find it.
>       +    When a test fails, GitHub shows an annotation naming it, for example:
>        
>       -    Find the line a test is defined on by searching the script for its
>       -    description as a fixed string, using the first match. Fall back to
>       +        failed: t1060.17 partial clone of corrupted repository
>       +
>       +    but the location GitHub attaches to that annotation is the CI
>       +    workflow file itself, not the test script, so there is nothing
>       +    pointing at where the test actually lives.
>       +
>       +    Find the line a test is defined on by searching its script for the
>       +    test's own description as a fixed string, using the first match, and
>       +    attach that file and line to the annotation instead. Fall back to
>            line 1 when the description is not found verbatim, which happens when
>            a test builds its description at runtime instead of writing it out
>            literally.
>        
>       -    A GitHub annotation is a single line, so a `%` in a test description
>       -    has to be percent-encoded as `%25`, or GitHub misreads it as its own
>       -    escape sequence. for-each-ref's format atoms use plenty of them, e.g.
>       -    `%(raw)`.
>       -
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>         ## t/test-lib-github-workflow-markup.sh ##
>       @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
>         	github_markup_script_name=${0##*/}
>         }
>         
>       -+github_escape_message_ () {
>       -+	# % has to be escaped or GitHub misreads it as the start of its own
>       -+	# percent-encoding (e.g. a literal %(raw) in a for-each-ref test
>       -+	# description).
>       -+	sed -e 's/%/%25/g'
>       -+}
>       -+
>        +find_test_case_line_ () {
>        +	# A description can contain characters like [ or * that would
>        +	# corrupt a regex search, so match it literally and take the first
>       @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
>        +	esac
>        +
>        +	test_case_line=$(find_test_case_line_ "$1")
>       -+	test_case_description=$(printf '%s' "$1" | github_escape_message_)
>        +
>         	case "$test_case_result" in
>         	failure)
>        -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
>        +		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
>       -+			"failed: $this_test.$test_count $test_case_description"
>       ++			"failed: $this_test.$test_count $1"
>         		;;
>         	fixed)
>        -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
>       @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
>        -		# Exit without printing the "ok" or ""broken" tests
>        -		return
>        +		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
>       -+			"fixed: $this_test.$test_count $test_case_description"
>       ++			"fixed: $this_test.$test_count $1"
>         		;;
>         	esac
>        +
> 

