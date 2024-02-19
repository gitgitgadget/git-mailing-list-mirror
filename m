Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951237155
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352735; cv=none; b=i+5vdKZu0vGbErkjcsqqqve8aHDOG8EAbKw0I08/0Oo+skj6M3gLJpagEP4RYa96E2K2GRo0kloFOxDqIqXSeWDP1lRgcuh4sktTeofe19yOHoB1mvrW9atlsLuyME5HuzUVz7olXCR1OE8ninSoto3fMpd3Rggf+bQkKfgDacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352735; c=relaxed/simple;
	bh=anbdT+pQEUB1jzI/nixKb6FXzNwtKpRGr2rudeJPi0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROdIzmHebuvggxj5MqeJBllDT9Q35SErqFFsCDmfut10Njfm7tJmLFB467HxhfENl81Z3pXnLTWf8MkdEGMOv/Fd6mfbYiQJTqG1HVt0ejebgQF7QBze7ZX1D27PCClBoHI7Y6qk8BNV97708QyT6kdQcIX2+oGYKVc+nUrDDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVpXqjTW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVpXqjTW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394ca0c874so2143488f8f.2
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708352732; x=1708957532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk9TCOeePg4oq2gb7Bra8hsY9UaaHbp/rgfMdY7phbo=;
        b=VVpXqjTWmpf/JuSRut7E6G2CJIR3TsT9Rv2UrcyRC4J+m4iJVteE75L88IXKs2QTJc
         rtQlbtaHIN5+uZ85+dgrTkwGqVxg4Y5tNp9QWYicsflHnBO1ityRjdAQ/FYR6i1AIkCg
         8izxn3mC7s0aGm2S8cZCH0grDCCFTxaHvEJPCJQx952v9ORULGM33+L6DEAK/rDmnyZF
         E7MN+5nzgAbWPudNmwOQXO1C+Fmlpeye68Ujg2Rlw+u3Se2GYen6zvJ7uNzwkAVAW6jy
         1/kYUmAlhIJX5dq6FihUJMj8rxc9IIlngFT5Eaq4Lzf4EcZ3gtQBC8Ww7yQXyTJfuXy8
         CAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352732; x=1708957532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk9TCOeePg4oq2gb7Bra8hsY9UaaHbp/rgfMdY7phbo=;
        b=SvP73itf7amm5k9gDCExWGJwv/9PF9qJYKrvuf/1nzGhPuRCoD8Jl9rS0y3n3szsIb
         CcJnUmGSZIXmrWgR20jC5CXZLsj7i5gSdRgPxbr61N8uAF9VfyCGiAFEedD8K8BIg2oB
         Mk+nO64bewrd8mUPVFvjFHCiBCLY0riGtbDV0SFAEyGL0WxGwex4S4zVGedg1XYh/DPj
         ZN9AkFp1+eBPCshSRdcKAA0FX55Ee7ARPF1ElqIIAAsDyJkHGODoFZ9ZMvYgId4zMFy7
         LHQ3ICxh63UgH1yPAp9VVX5cTbwfoWYy4QkrGyx68ROESCKmWVPMvT9LxFuHWjAs+6/M
         KznQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeEXRcAjIS72cWhe5DzOt8yKQdWSWkFM6xv0E43ct1drTV9Qlq5s0lZrhL8Vw0q1rvDle9RoCrZ6Yi4PoJsewQApOH
X-Gm-Message-State: AOJu0YyxgiAE1VlEOpdgTSqoiHuy8mQw2blNmEzEFNGgt+VBhAdxQpym
	CO+l5JWN6Exp8PHvUKOy5cmIiWonUzve157Y5Yd7Dg1GswcvMFdP
X-Google-Smtp-Source: AGHT+IHFtdCpOUXG5ClwkAqO1bkJxxjMlDYImu6jFWILXHDo0J8yDun+PTQt3eFGE3MDGGXNsRTMtg==
X-Received: by 2002:a5d:64c2:0:b0:33d:3098:c1f with SMTP id f2-20020a5d64c2000000b0033d30980c1fmr3978313wri.44.1708352731372;
        Mon, 19 Feb 2024 06:25:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id b4-20020a05600003c400b0033d22852483sm9500137wrg.62.2024.02.19.06.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 06:25:31 -0800 (PST)
Message-ID: <bd340a27-bfb4-41b2-a1fa-356ab7dbbd36@gmail.com>
Date: Mon, 19 Feb 2024 14:25:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] promise: introduce promises to track success or error
To: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Emily Shaffer <nasamuffin@google.com>,
 Philip Peterson <philip.c.peterson@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philip

On 18/02/2024 07:33, Philip Peterson via GitGitGadget wrote:
> Hello all, this is my first patchset so thank you for being patient with me
> as I learn the process and conventions of your very fine project. These
> patches are intended as part of the Libification effort, to show how we
> could use a Promise structure to help return values from functions.

I agree that we could do with a better way of propagating errors ups the 
call-chain that (a) allows us to pass more detailed information about 
the error to the caller and (b) add useful context to the error message 
as the stack in unwound. I'm afraid I do not think that the promise 
implementation in this patch series is a good way forward for several 
reasons.

1) It is hard to see how we can wrap the return value of the function in 
a promise and preserve type safety. Even if we used some  kind of union 
the compiler will not warn us if the caller reads a different member to 
the one that the callee set.

2) It obscures the return type of the function and forces callers to 
unpack the value from the promise adding complexity to the calling code.

3) It imposes a cost in terms of dynamic memory allocation on code that 
is called synchronously and therefore does not need to allocate the 
promise on the heap. This adds complexity and is sure to result in 
memory leaks.

4) If the function fails we need to propagate the error using 
PROMISE_BUBBLE_UP() which forces the caller to add more context to the 
error message even if it does covey anything useful to the user. For 
example in patch 5 we see

     error:
	could not find header
     caused by:
	could not find file diff header
     caused by:
	git diff header lacks filename information (line 4)" >expected

The error message starts by saying it couldn't find the header and ends 
by saying it did actually find the header but it could not parse it.

5) The cover letter talks about adding asynchronous examples in the 
future but it is not clear what part of the git code base it is 
referring to.

I think we'd be better served by some kind of structured error type like 
the failure_result in this patch series that is allocated on the stack 
by the caller at the entry point to the library and passed down the call 
chain. That avoids the need for lots of dynamic allocations and allows 
us to continue allocating "out" parameters on the stack. For example

     int f(struct repository *r) {
	struct object_id oid;

	if (repo_get_oid(r, "HEAD", &oid))
		return error(_("could not parse HEAD"))

	/* use oid here */
     }

would become
     int f(struct repository *r, struct error *err) {
	struct object_id oid;

	if (repo_get_oid(r, "HEAD", &oid))
		return error(&err, _("could not parse HEAD"))

	/* use oid here */
     }

I'm sure this has been discussed in the past but I didn't manage to turn 
anything up with a quick search of the archive on lore.kernel.org.

Best Wishes

Phillip



> Problems
> ========
> 
> We seek to make libification easier by establishing a pattern for tracking
> whether a function errored in a rich way. Currently, any given function
> could immediately die(), or use error() to print directly to the console,
> bypassing any relevant verbosity checks. The use of die() currently makes
> use of Git as a library inconvenient since it is not graceful.
> 
> Additionally, returning using return error(...) (as is commonly done) always
> just returns a generic error value, -1, which provides little information.
> 
> 
> Approach
> ========
> 
> I solve this problem by splitting the single return value into two return
> values: error, and message. However, managing two output variables can
> require some coordination, and this coordination can be abstracted away by
> use of an existing pattern named Promise.
> 
> 
> Promise Concept
> ===============
> 
> A promise is a contract representing "some task" that will eventually
> complete. Initially a promise is considered in a pending state. When it
> completes, one of two codepaths will eventually be entered: reject, or
> resolve. Once resolved or rejected, the promise enters a different state
> representing the result. Reject or resolve may only be called once on a
> given promise.
> 
> Until now, everything I described up to this point is consistent with other
> implementations, such as the ECMAScript standard for promises. However, this
> implementation departs from the complexity of those promises. In this
> implementation, promises are simple and canNOT be chained using .then(...)
> and do NOT have any notion of automatic bubbling (via re-entering the
> pending state).
> 
> 
> Sample output and reproduction
> ==============================
> 
> During an error, we can have richer feedback as to what caused the problem.
> 
> % git apply garbage.patch
> error:
>      could not find header
> caused by:
>      patch fragment without header at line 1: @@ -2 +2 @@
> 
> 
> To reproduce this output, you can use the following patch (garbage.patch):
> 
> @@ -2 +2 @@
> 
> 
> 
> Goals
> =====
> 
> I would love to get feedback on this approach. This patchset is kept small,
> so as to serve as a minimal proof of concept. It is intended to abstract to
> asynchronous use-cases even though this is only a synchronous one.
> Eventually, any top-level function, such as apply_all_patches(...) would
> return its output via a promise to make the library interface as clean as
> possible, but this patchset does not accomplish this goal. Hopefully it can
> provide a direction to go in to achieve that.
> 
> 
> Diversion
> =========
> 
> While building this patchset, I noted a bug that may not have a concrete
> repro case in the master branch. The bug is that when invoking git am, it
> can call out to git apply, passing many flags but interestingly not the
> --quiet flag. I included a fix for this issue in the patchset.
> 
> 
> Potential Issue
> ===============
> 
> There is one difficulty with this approach, which is the high level of
> repetition in the code required. Tracking which promise is which is its own
> source of complexity and may make mistakes more prone to happen. If anyone
> has suggestions for how to make the code cleaner, I would love to hear.
> 
> Thank you, Philip
> 
> Philip Peterson (5):
>    promise: add promise pattern to track success/error from operations
>    apply: use new promise structures in git-apply logic as a proving
>      ground
>    apply: update t4012 test suite
>    apply: pass through quiet flag to fix t4150
>    am: update test t4254 by adding the new error text
> 
>   Makefile               |   1 +
>   apply.c                | 133 +++++++++++++++++++++++++++--------------
>   apply.h                |   9 ++-
>   builtin/am.c           |   5 ++
>   promise.c              |  89 +++++++++++++++++++++++++++
>   promise.h              |  71 ++++++++++++++++++++++
>   range-diff.c           |  14 +++--
>   t/t4012-diff-binary.sh |   4 +-
>   t/t4254-am-corrupt.sh  |   9 ++-
>   9 files changed, 279 insertions(+), 56 deletions(-)
>   create mode 100644 promise.c
>   create mode 100644 promise.h
> 
> 
> base-commit: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1666%2Fphilip-peterson%2Fpeterson%2Femail-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1666/philip-peterson/peterson/email-v1
> Pull-Request: https://github.com/git/git/pull/1666

