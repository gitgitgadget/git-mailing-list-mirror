Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2C3B9600
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896596; cv=none; b=oh/vN1qGPyNXV/E1g3nTnzwIij2mBadzzypPeWsdQ6Nq0Inq7NuQVtBxpL/nUlhlHUMzcoTL+RqlC3D4OXYB4La4lZPWU5zVDd/tJwfVQe+/AF8hwgHaSFghRa1auL0v9mLZf65K1P0MU95FIc9/z3uqXrOdeAW2QRlGOPhOQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896596; c=relaxed/simple;
	bh=QJA2xsxp4+uEFFZnrn/mi7y2wO3VeNWa1jF9IwTrPeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXLNRNN9S+QYpGOaoK9iNaFuCT49yuzzZSdFZ59JqGOk1rmDzQTZRTO4qOnXx7m5dhIEFVJbZ7p6jytNtQtsGfizQB8Wb/+Duv6/Jej23sEFlAdsivlCM6B8eq94grp29mSKctI43SYmClHHLp9JHjGG+zTYVx/J1MjsG5QQxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC/7SoAh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC/7SoAh"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b7ec7bedcbso4511586d6.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896594; x=1778501394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFpf9mEvl7xTZSDYC8EaXaUcl4C9Du2mcb32h4YYyz8=;
        b=bC/7SoAhb7psVkfJRIA2z1E/VkriMBmBCfOeQbGKpaid8Wr8vM82iOwUAiu4Ztx4wI
         II1YUVygb44LUtctw9x63diFb0CcS3nOEtCsbzeyQTXFGm3qccoBrvDSjYHwPBjVnOXk
         6+NKcK2P92Xd1zY9Usri1PQO8FEZMY7ll8v+++Xd9bnpY7p+18lop0HnBdFALWaoT3/s
         kBDFQhdIjbqPHhRyPXtmsXu6wLukS3f9DvRw34C7FNHOu3u9SgzT18jQdNNp4rrglp4x
         7Bk1XM5koXQV/JedjbQgBebDfTReaDwMit9A/vIjeaSR0Pc19hIAY89vWmEA3LUnT6zW
         b1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896594; x=1778501394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFpf9mEvl7xTZSDYC8EaXaUcl4C9Du2mcb32h4YYyz8=;
        b=QUtEK4Wq/NSbkxEFgUlhYs9jzBW9ZIXTwvls6Y3So2FqwCPVGVcaHn4zhJZQzJ3/vS
         8mXQpT+M+Fhl081/5+oerY8eKZEisYLGXeJUl50XcapIGAoKIuw2369+lyZzrwBzMx1B
         l8gRACpVVCUSQQDL+wHabjqPMNUXVkzZk71Zl68kostVLwafZ3STfv0NOW03PpJz0bnv
         KroNdrhWXbzBwXvV/f3BtkPxkBCrLBdNxCmhVJeAqhrh7YG25I659XS/b3FQQSYJam0Y
         sXrmxCqFlVcFbEY3LP9p/8TPuTi0kQlZ2nt+XdbciV1XEPIFrmxAbBlhssc8ZsBGhD1J
         7bvA==
X-Gm-Message-State: AOJu0YxXcLalmSqHOUAnxjOz111UhX+kS9S2O6K8qyxmCRh/sEvUIlZ7
	KiQKhZlEzUG/KsAZpqe0a54HMutrkKTEeJEPN/4/10CymbuOam40T4Iu
X-Gm-Gg: AeBDiesWbLkJYT+GVuXR5oOphyhNdalfyA5v4imMG1SWnULLM6u2NImlYaUtTwsQxgg
	UDw1WN0po2sVVV56baU0l+9nf4db6SX/HG43woiDBgDIEKfky5LjdHsdN8hQ2+NdYws2+SOQWs7
	TG6FoM/jCTWmmepyRy1et+yJ9kXLt/aPT8XhWF0j0mJHeDMMIfySZcLMeRIrO7fj71BPlnuYUc0
	ka7/sEWTLkfLSC3ZPv3zgRLL1XxQqW+KVLXhh6oeNTbgq86LFah6+TC67v8zP09ShxSICDQlQdq
	FexAKITxx2odg9ES7yvex5tUvQgEQdoNUwWrWr6I/UkngZ3TVaINGY+jaw3P0BcAbn/0lTe7I0t
	BNU/o4wipWYD3I2DQ2wsIyNTpaLJ6WrAyCzalhBwBcsP6hw4+u4tzLXiNr//ZCbYRWEANDhlSRL
	ZqsyTFYchx12toJJWsoIuH+9FfV6n0MrbCRw+9d/YbmTLU3ErcUvhYZqagqXHs/YsoNBnMryXDY
	tef2+Xo
X-Received: by 2002:a05:6214:20a6:b0:8a0:d08c:a721 with SMTP id 6a1803df08f44-8b666cdcd72mr180810706d6.22.1777896593690;
        Mon, 04 May 2026 05:09:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b534ac8ef3sm122288906d6.0.2026.05.04.05.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:09:53 -0700 (PDT)
Message-ID: <eb8b4a7b-e241-4249-bae1-8f631bf7bd2d@gmail.com>
Date: Mon, 4 May 2026 08:09:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] backfill: die on incompatible filter options
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <22db528d0c5e6db71664f071dca97ab218f4ba45.1777731354.git.gitgitgadget@gmail.com>
 <xmqqbjewrtek.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjewrtek.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 6:59 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The 'git backfill' command uses the path-walk API in a critical way: it
>> uses the objects output from the command to find the batches of missing
>> objects that should be requested from the server. Unlike 'git
>> pack-objects', we cannot fall back to another mechanism.
>>
>> The previous change added the path_walk_filter_compatible() method that
>> we can reuse here. Use it during argument validation in cmd_backfill().
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>  builtin/backfill.c  | 2 ++
>>  t/t5620-backfill.sh | 8 ++++++++
>>  2 files changed, 10 insertions(+)
> 
> Another topic adds a helper function to check for many incompatible
> options and calls it from here.  When I merged this topic, I made an
> semi-evil merge to move this call to that function (with necessary
> adjustment to the parameter).  Please sanity check the resolution I
> made in 'seen'.  Thanks.
Thanks for alerting me about this. I do think there is an error in
your merge. Hopefully the tests I wrote in this series caught the
mistake.

Here are the last lines in your copy of
reject_unsupported_rev_list_options():

	if (revs->filter.choice)
		die(_("'%s' cannot be used with 'git backfill'"),
		    "--filter");
	if (!path_walk_filter_compatible(&revs->filter))
		die(_("cannot backfill with these filter options"));
	if (revs->filter.blob_limit_value)
		die(_("cannot backfill with blob size limits"));

The last two options are correct, but they can't do anything
because the first one causes the command to fail immediately.

This should have caused failures in t5620-backfill.sh, specifically
the test 'backfill rejects incompatible filter options'. Indeed, I
get this error output when running on that commit:

+ test_grep cannot backfill with these filter options err
+ eval last_arg=${2}
+ last_arg=err
+ test -f err
+ test 2 -lt 2
+ test x! = xcannot backfill with these filter options
+ test x! = xcannot backfill with these filter options
+ grep cannot backfill with these filter options err
+ echo error: 'grep cannot backfill with these filter options err' didn't find a match in:
error: 'grep cannot backfill with these filter options err' didn't find a match in:
+ test -s err
+ cat err
fatal: '--filter' cannot be used with 'git backfill'
+ return 1

This does make it clear that I should add a new test in t5620 that
tests the 'sparse:<oid>' filter now that it is compatible, which I
missed in v1.

Thanks,
-Stolee

