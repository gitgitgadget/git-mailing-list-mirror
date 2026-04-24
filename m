Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165E372690
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045976; cv=none; b=mhhZbxo/GhkrqpDjuGq11uNQUDJSdG6uD9RnfQX3CuA+kMq4NTSnMDELWiGeDUnlUjeSTF9EAAeYRjPbn5mWcQbiNzGX+gZMX9FqHsPDoBs6tocRLw6pRIXKSoDf6tudky/K6m4NRg7ZHoYVOnOsG4TrhDDTC0SsCTwhDtnan3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045976; c=relaxed/simple;
	bh=QKK5IMazjvnB841Im5/F/Qxx4PoLz3S8ygSc08VQAEs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qjVbv63zHqkBnohPxJqUl+0+rgDYFFeqsCK75f6atM9fiyNMBTwDutVd16xlErdUfZJR/KwXFB7ELNK+cp+9Vl6qKI/TxVu2fYV68g/GH+od/f/svxiroVh9IZc9UIlkYNh5oM34eAK2ix6uP+NEE1/4QxBgRx6LiDNIrwAyzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW6UHS6z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW6UHS6z"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso79006805e9.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777045973; x=1777650773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++2MsAkoz6FBMVeCAqXMHRUzBUKQRAbz/9Mgsu8IqQ0=;
        b=eW6UHS6zYEAtDSGoOpYyZc7k0Lt9k5ddXda7JDqRiW+IKN6sLohjOBkeziuLFMEm1b
         NjyC/rnWLwSZ/JP4Rr3owq5KSB6lywd5tEgwc0SqFJ49MtBN6Lpus3B+QmXTKN7yTnKR
         zq/YZnQl37OfwtBLMVWWWIgFZyLQiNkRTiwerkhu8q7PYnWqJEs/QcBzMFQfmvtIrGnx
         xqLT7qKkQqRShzrbEPnGORkSANk+WM44WmAdDz7Kw5vQJhsE/04yOhl3DKwzK33MAF31
         0m1huyMTqQreFnOdnkKnOyeMHRbvOahx6s9hE6Rg1mvK5P8m6W507S0zh/CrMeJilBX/
         T5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777045973; x=1777650773;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++2MsAkoz6FBMVeCAqXMHRUzBUKQRAbz/9Mgsu8IqQ0=;
        b=fETLA3N5MN9zOSdftfhxo4ocqzT+bBB+WVn74l1TA3c7q53tu/YKxRyPOxV05YKO4Z
         T9K5OfJb62Kuy7LeLbOUj/eVBeUibTD5MZq5GUrpKAyCOZ3JCLSEDzw2LyeckEvOUl0W
         OPX5I+Y2G/8+ntywMTk3S7S4+UK5G1zqCY0gy/t0TbyQR/5gT/aOTc27ceXDx3bsq4Io
         xaPVTr0WgsFGX3xRzxUlonT1Z/JwAbfAnusBrJnVgmEOvXomU2iQrd49LLcEGE7sMkvs
         uk98vuO1FlRXCvhaAHgZHAuI+6smy16A9DkQf81/+axVuF6JqrRn3wS4FbJnpzn/UWT1
         uWnw==
X-Forwarded-Encrypted: i=1; AFNElJ+wFm8g7tNEGIdzKCI+RH7ZQx3kPTtSFdGmRNRMxkxWDyS7Pi6mJgK3wDXUdb1UIOkAvzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj87owlB0cIUsAegWFhMiyqXOzqWGG3A4su2MALJv/bwEkFxFY
	zkhtbWuxbARkd+N536YdABeODwamSaTbfL/YSndIBr3ThhyFzAtHtUsz55ASIw==
X-Gm-Gg: AeBDieuB61XPDzuyREW+RoBXaKHqEI/zrmDPm7fCXk0O/3xoIhKT0sNlgUTYrkleQYr
	hMTRtYLnP1C/x4qwcidNZQEZ6g8SuQAgJ4S2Q4uPid4WQYdxdKccGwFfQAvFwI7bypU4oeHHs60
	U/TMDSQSaukV4iEnjUCz1Xd6StxTxCm7EcO4vFv2G0z4VCvsOw61L28I2FUBUtkU8l5g9sLgBWR
	jLVWYAoOQazD7J7ewl36tvC90VA7+CTS7ihTpbFbVjBCRDiypxRarHkj26CmaQFJZkUUpVjDwEn
	Tm4VNcMUOWHww3HIWCHsCKEmtd/9wxgM9Nu99UuGlZ6Lx9H/9ILbcNyT+L8p0kQs8DaDIY4efcO
	DavZPfuej1Do9woVDCIAxof6HrcH6OD70ICezSWhwq6pDkWc+Onx6keLTxGly1OvPGEM5aj2g5B
	K/mytXnA00ValIc2lc+AZuDcyGapWU/S4YZnCXdvmabqqP1GcwgHgPxN6G2IXrpBaPLQoqLA/ry
	Whh2zkfzTzndQ==
X-Received: by 2002:a05:600c:308a:b0:489:6c22:e081 with SMTP id 5b1f17b1804b1-4896c22e217mr207945055e9.0.1777045972755;
        Fri, 24 Apr 2026 08:52:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm112077645e9.10.2026.04.24.08.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:52:52 -0700 (PDT)
Message-ID: <04a16996-0ce2-45b9-af54-87c9d44659ff@gmail.com>
Date: Fri, 24 Apr 2026 16:52:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 0/5] checkout: 'autostash' for branch switching
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
 <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 15/04/2026 17:24, Harald Nordgren via GitGitGadget wrote:
> Simplifying the tests in t/t3903-stash.sh according to Phillip Wood's
> comment. I believe everything sound be fixed now or responded to.

This is better than the last cover letter, but it would be helpful to 
describe the changes you have made rather than just say your responding 
to a reviewers comment. Junio has given some suggestions for 
coverletters to take inspiration from.

Also when you reply to messages can you try and keep the subject line 
please - nearly all the responses from you have the subject

Re: [PATCH] checkout: add --autostash option for branch switching

regardless of the message they're actually replying to. That makes it 
hard to see which message you're replying to.

I've left some comments on patch 5, it is definitely looking better but 
there are still a couple of things that need fixing.

Thanks

Phillip

> Also rebasing against upstream.
> 
> Harald Nordgren (5):
>    stash: add --label-ours, --label-theirs, --label-base for apply
>    sequencer: allow create_autostash to run silently
>    sequencer: teach autostash apply to take optional conflict marker
>      labels
>    checkout: rollback lock on early returns in merge_working_tree
>    checkout -m: autostash when switching branches
> 
>   Documentation/git-checkout.adoc |  58 ++++-----
>   Documentation/git-stash.adoc    |  11 +-
>   Documentation/git-switch.adoc   |  33 ++---
>   builtin/checkout.c              | 149 +++++++++++------------
>   builtin/commit.c                |   3 +-
>   builtin/merge.c                 |  15 ++-
>   builtin/stash.c                 |  28 +++--
>   sequencer.c                     |  73 ++++++++---
>   sequencer.h                     |   7 +-
>   t/t3420-rebase-autostash.sh     |  24 +++-
>   t/t3903-stash.sh                |  24 ++++
>   t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
>   t/t7600-merge.sh                |   2 +-
>   xdiff-interface.c               |  12 ++
>   xdiff-interface.h               |   1 +
>   xdiff/xmerge.c                  |   6 +-
>   16 files changed, 483 insertions(+), 171 deletions(-)
> 
> 
> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v14
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v14
> Pull-Request: https://github.com/git/git/pull/2234
> 
> Range-diff vs v13:
> 
>   1:  43bfdf2136 ! 1:  e18c25599a stash: add --label-ours, --label-theirs, --label-base for apply
>       @@ builtin/stash.c: static int branch_stash(int argc, const char **argv, const char
>         
>        
>         ## t/t3903-stash.sh ##
>       -@@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit conflicts' '
>       - 	)
>       +@@ t/t3903-stash.sh: setup_stash() {
>       + 	git add other-file &&
>       + 	test_tick &&
>       + 	git commit -m initial &&
>       ++	git tag initial &&
>       + 	echo 2 >file &&
>       + 	git add file &&
>       + 	echo 3 >file &&
>       +@@ t/t3903-stash.sh: test_expect_success 'stash.index=false overridden by --index' '
>       + 	test_cmp expect file
>         '
>         
>        +test_expect_success 'apply with custom conflict labels' '
>       -+	test_when_finished "git reset --hard && git stash drop" &&
>       -+	git reset --hard &&
>       ++	git reset --hard initial &&
>        +	test_commit label-base conflict-file base-content &&
>        +	echo stashed >conflict-file &&
>        +	git stash push -m "stashed" &&
>       @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
>        +'
>        +
>        +test_expect_success 'apply with empty conflict labels' '
>       -+	test_when_finished "git reset --hard && git stash drop" &&
>       -+	git reset --hard &&
>       ++	git reset --hard initial &&
>        +	test_commit empty-label-base conflict-file base-content &&
>        +	echo stashed >conflict-file &&
>        +	git stash push -m "stashed" &&
>       @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
>        +	test_grep "^>>>>>>>$" conflict-file
>        +'
>        +
>       - test_expect_success 'stash create reports a locked index' '
>       - 	test_when_finished "rm -rf repo" &&
>       - 	git init repo &&
>       + test_done
>        
>         ## xdiff/xmerge.c ##
>        @@ xdiff/xmerge.c: static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   2:  7f3c32f5e9 = 2:  ce29b10264 sequencer: allow create_autostash to run silently
>   3:  b279d1dac8 = 3:  73051d1762 sequencer: teach autostash apply to take optional conflict marker labels
>   4:  04869314ec = 4:  191058d8e3 checkout: rollback lock on early returns in merge_working_tree
>   5:  4b3c6025ac = 5:  86f33df1eb checkout -m: autostash when switching branches
> 

