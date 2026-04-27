Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1E3C4579
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295824; cv=none; b=CZd+/CZckI69J103wtlUDL64wSTTqLBjrldrcMLeXI7qJQWQQGSTB71k0WB4t8vX+77G3j2hXYGClxepFMv02iUyuG7zg1Ix8pC3Pfr8q2wN3OcxIUBtLijXFOjoiifmA4YmLLaS4NIxEM7QztQmfXOri2YciznJwdJzNlC3W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295824; c=relaxed/simple;
	bh=+OwpM6efLq7wDuG7BuYvnzF3WvQH3NXohUWom0vOQdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBD8shlrepDKWhR/yvkF+iLCnSbW7tuYuVAlw/SmslqcVtJ7WEuJtRKGX+eLWAeMO5HSGexE9OqxI3v0BbRMjg1JuYF8Tvc9YezVhUhmY5Q++HAavvP6rKxyEwsfTdfZSiBt1ASixhYisUYs1wdH7xvvct0jBR61FVuzz0jaaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2DmOcKR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2DmOcKR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eae9229110so1370678885a.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777295822; x=1777900622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mK9kcgZxYgXhou5Tah5DNqqTchBZ3Uu8dpVGheSGpg=;
        b=W2DmOcKRkHCDZw+Iv56KAuLUg0v5JcDDqXlPaftadbj91kgG2Z9IpTLoOd2KbU6X+L
         EgstBe30FOrevMQ1UdQdDedYJHL0t7qISbPx+PNTjYU8nLUCbZZEJOw2wVqpM32Pdhgo
         iN+JOfTykgvzDLjLra3b5qGdd1miJJjYJD/wxgXxAg3++wg8jf5EjjWtzTcA2TiKRPaH
         42ouZe++EuSeKaVArIgOVoEoq9HbSJjTKt8T0EbLYQRGa/VuHLWaPJTqXE9tDn3NJB9/
         eltdktBM2yLk8MoilaKXvkOUUvRv0TdVY8QroXFaa7G1bcMbgH0ET9fu/lvtLxShlLhR
         jsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295822; x=1777900622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mK9kcgZxYgXhou5Tah5DNqqTchBZ3Uu8dpVGheSGpg=;
        b=B/yX/wkaf/IUgNDIqIyw7LcxJgWlSo410vmTzzjOZcF0cWj3l6Ug7dILj8OtihYrU0
         d2imMgP7AJCiuURaHchH3mPEdi+KuPIxRx4EUdDOeYLePIroIqTuIc7rGNqBSpMFC6df
         M/W5Z/nfn8a1DHlZJsi3N/52ZGeNqdsHHxdbxx2Lg8d85aRzu2dJtPyTwKz4Wn44ngR5
         35b/FvOHfO9b4k7EJhouvc7bCmRuYFPBzm7ZH70x2HfAzODDR4seqU2x1KVEnmzRYyry
         Av2o4tZGQNfdGeWPBXPsN+l2stMNQ/GKOvDUYRAjrRItVRw/g9okHwyqk8Kn/G0nBkDg
         TeBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ea32Eg42Sed6ibs3R5eDNeb1fKxi+uZlBfGAGlQ9i1yrTGpo1PezUk2hz8TMeyy7Ua7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAakgAjTTDgggVi6U5tUPZln5sqHdhv0C8OXXvw7kGK8Ez9/nt
	84CkSzcx/e9h2GvjvsZjRd2YXZG41cZgNga2zb6lQaspKQ12BzX49qg94P4s+Nib
X-Gm-Gg: AeBDieuyYUyy/0y1vnHFojD+zzKJeSbUv2LJ19Y7J06n5gpZ3RXiy0zm/XvnMMmB1kC
	WlgRhFpuFHF584Qgmn96oCwcljGs5WfpRYamEZ05RS9j2p+uX1XXWFgB10YZhYtlxe+0IZveRIw
	Ve5dHYTk+JWj6PX5uh23siN8K4tgCpStuDCVE5TeAepPZQ/KhE+/3g45lRDDanPiSM4r569nuEP
	saXfC9cXhCPxsU7XwNuBnnPg8H6imkVwvU1QOb3B7u8iwunpenVK12sDkixJzSbQHqNt1aUoEwy
	4lHxuu1JQLaFBlEer3U62n/V53oFeNr+KeHb3QN51diDCflSDESwlomphnFBi1Qzda/SLbSzGcW
	HvwvgmSHm/o1fp8Niro2dNPb3Qc0HifiuXYJzynLM4qMZcweMHHFMb5mwIT2Fxygest5B1m4TV5
	8zVI3z/8UBynaznZx62LL8QGdqS9x6BRcu09Kn8vMjgCl0kSXyAQ6CsgFAe+znk94JsFyijRWJV
	e3+9I80xfe0ARsyHwI=
X-Received: by 2002:a05:620a:4692:b0:8cf:ffee:c616 with SMTP id af79cd13be357-8e78f0581ecmr5929529485a.7.1777295821467;
        Mon, 27 Apr 2026 06:17:01 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb734sm2960703085a.29.2026.04.27.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 06:17:00 -0700 (PDT)
Message-ID: <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com>
Date: Mon, 27 Apr 2026 09:16:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git
 cherry`
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/2026 8:32 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

(I'm sorry that I'm reviewing out of order. This reply includes my
feelings about patch 3 after reading both.)

> +/*
> + * Enumerate blob OIDs from a single commit's diff, inserting them into blobs.
> + * Skips files whose userdiff driver explicitly declares binary status
> + * (drv->binary > 0), since patch-ID uses oid_to_hex() for those and
> + * never reads blob content.  Use userdiff_find_by_path() since
> + * diff_filespec_load_driver() is static in diff.c.
> + *
> + * Clean up with diff_queue_clear() (from diffcore.h).
> + */
> +static void collect_diff_blob_oids(struct commit *commit,
> +				   struct diff_options *opts,
> +				   struct oidset *blobs)

I think that this is generally a good idea, though I worry that
having this hidden in builtin/log.c may not be the right long-
term home.

I expect that we'll find more and more examples where we want to
prefetch blobs in different operations, those that exist now and
those that may be created in the future. It would be preferred if
they could automatically take advantage of the logic already in
diff_queued_diff_prefetch() within diffcore_std() in diff.c.

Ultimately, _this_ patch cares about a diff. Could we compute a
"diff prep" computation using the core diff library instead of
inventing a second queue of results for diffing?

Patch 3 cares about a "scan prep" which cares about loading all
blobs for a given tree with respect to a pathspec. This is very
similar to what a checkout would do, though it ultimately uses
a form of diff to find out what change should be applied to the
working directory. Perhaps 'git archive' is a better matching
example.

I don't mean to make your series more complicated. I value what
you're doing and can see how your current attention can be used
to make further improvements later. By implementing things in a
common location, then we can have later integrations add to the
confidence in the feature through tests covering each user-facing
use.

I'm not sure if it makes sense to attempt to create a universal
library method that would be used by builtin/log.c _and_ diff.c,
at least not right now. I'm most interested in having this logic
be more reusable in the future without needing to move code
across files.

Thanks,
-Stolee

