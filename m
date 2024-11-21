Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E36F06B
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221745; cv=none; b=bNXJvYQ41ALskI4t4ZX6IcCqWEZCeQpoL28wbUZJzcd0QiZ10ZCbpvVMVJWdncd6YQK6xdX1vD2g7sYt7FmQjOpyXT/DecFtTEj4M2L6o0RZqwVFkJB2xXMpslkQVujY9+Da3m4+CYMDIBvkb651l9Lnueccoue5jR7eYMKVhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221745; c=relaxed/simple;
	bh=4t6UKHtyYhLQQMAHBJDpVY+aHRy5E22I+rVBC5QoDnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4XxOXuV/ke6DGxXbdmT5t1ugAV8GnzdRNev4wir8aAd7TT5sTCIiNH0K2Qs1tNL1V/QmBqvbO1289KaD374EKcruAZqmW8g1gLsg5a98qJrI5tfJ1ZwVZyV1zwKGHls+4DKKCQo6gVxJHvcxwEePRCwlyThHKzd/UKMBh0tr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZSg3Tf/g; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZSg3Tf/g"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea0b25695dso11707777b3.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732221742; x=1732826542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7ilEZLkA89X2nUuAdLc7YdsYLcbdXIcnS+K8FlQAYo=;
        b=ZSg3Tf/gBxpuQS934HHshr+aMEMig2ihTQoclNhAwXv4+xMxbQjCuu19qkOxWtjpIV
         tJNtJGhDug4jud5EUKiActN+GmZ75vlqWg0pUSfpzI+vC2Tz3euObmZxzki2BBz3veJ6
         9YU0YlgtLbkfSr/f01L8/ryRe8HyCnaJsWBzqUUWinVyXyBUTnYsEBPX5UrCD/h3OfBJ
         xNG5iHwrQVc6rrZxCuXY80mLsNrYZmgLsnCyitXED5HKM2wJsvX19xxlm4Huh9RUQr8q
         wum3LbFNFy945HOkRy7kcOGig0uFouZfqfP2rl/5mgmSleaWWZXT7M8m30VRcQWla+YN
         OjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221742; x=1732826542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7ilEZLkA89X2nUuAdLc7YdsYLcbdXIcnS+K8FlQAYo=;
        b=fZ0+5UveI4J5M3RVnTND4ERrh62q5LEcAGbf68YsKOi+EpQBVPeWlmv+r6S1lUC8oN
         upHmncp/oJsS2dAsjC2wjGonubD1ILxF3yBWsidLwDAUbqCCe8sculckhe3LxFc2WO/n
         NzWRoifYDwl5uz8Va9kaAi5ZQ1n0ee46t+rEl7txdusF8FdxRVU7Ez8/LgwmjLk7trOt
         nYuwN7A0lQ1sR4Bftjo3JFQ4i/+yc0AuBUJmHQ4b4pibrjmZme9HVE7gxC16pcj5XQUW
         EsJmKCRgjlX87YatooJz3b/clUdd2FHdQdSOFtQglOOu0q5IJJEZA/oUPiwjgpOPXNcO
         eB1Q==
X-Gm-Message-State: AOJu0YzKCMjjX64XZ0Ox+UuRIhu4HDL2cioCb4sdtRshIpaOg9Utgt5T
	zz9LFAxSxNJFJBJvdTjjWuNdYtJb5/gIM2h394V+tG5xYA1orI8MlQXeGsqo6KU=
X-Gm-Gg: ASbGnct2ISS8BVpzxj/EGI1RNS0RC3v4MnEHcEl5gyaz4JIILmA8mIyDEKT/qR3PI96
	BHNraSR7vH5xaZDFrf55AEwGpBgXqIc0Q4DDM4xk9tYh1MOL+3oG/wvxO0srqkFcp+uHrfH1+SH
	5qPt2NjjkOce6C2qCierPBN56RDYEn7kKJBkjtpm7EqHmkJhlohFbCs5ytYwxyuAhQbU9fTBJLi
	iB3IF7qj0jM3wkuO2/F912ve6cGj7x5W2eeU1KAGLJGWMhjBvk1KoJbNAqKAeiYRvUCA68GQdgz
	t/VzcPsxDfuAZ7HtEn0lvw==
X-Google-Smtp-Source: AGHT+IG08JPgivyQSNpcjCJf/nWO2MRqGO6MysEv4+UFxcTXjP6XzMMP448y15YpIghESJAMmm9b/w==
X-Received: by 2002:a05:690c:6e0e:b0:6ee:8451:d902 with SMTP id 00721157ae682-6eee087b7aamr7259697b3.4.1732221742363;
        Thu, 21 Nov 2024 12:42:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee008007csm1145767b3.88.2024.11.21.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:42:21 -0800 (PST)
Date: Thu, 21 Nov 2024 15:42:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 7/7] test-tool: add helper for name-hash values
Message-ID: <Zz+bLOi6DZoD5CfI@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <ab341dd0e58f77b3c7c6f5765d9e34cb02bef56f.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab341dd0e58f77b3c7c6f5765d9e34cb02bef56f.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:07AM +0000, Derrick Stolee via GitGitGadget wrote:
> Test                                              this tree
> -----------------------------------------------------------------
> 5314.1: paths at head                                        4.5K
> 5314.2: number of distinct name-hashes                       4.1K
> 5314.3: number of distinct full-name-hashes                  4.5K
> 5314.4: maximum multiplicity of name-hashes                    13
> 5314.5: maximum multiplicity of fullname-hashes                 1
>
> Here, the maximum collision multiplicity is 13, but around 10% of paths
> have a collision with another path.

Neat.

> diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
> new file mode 100644
> index 00000000000..e4ecd159b76
> --- /dev/null
> +++ b/t/helper/test-name-hash.c
> @@ -0,0 +1,24 @@
> +/*
> + * test-name-hash.c: Read a list of paths over stdin and report on their
> + * name-hash and full name-hash.
> + */
> +
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "pack-objects.h"
> +#include "strbuf.h"
> +
> +int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +
> +	while (!strbuf_getline(&line, stdin)) {
> +		uint32_t name_hash = pack_name_hash(line.buf);
> +		uint32_t full_hash = pack_full_name_hash(line.buf);
> +
> +		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);

I'm definitely nitpicking, but having a tab to separate these two 32-bit
values feels odd when we know already that they will be at most
10-characters wide.

I probably would have written:

    printf("%10"PRIu32" %10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);

instead, but this is obviously not a big deal either way ;-).

> diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
> new file mode 100755
> index 00000000000..9fe26612fac
> --- /dev/null
> +++ b/t/perf/p5314-name-hash.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description='Tests pack performance using bitmaps'
> +. ./perf-lib.sh
> +
> +GIT_TEST_PASSING_SANITIZE_LEAK=0
> +export GIT_TEST_PASSING_SANITIZE_LEAK

Does this conflict with Patrick's series to remove these leak checking
annotations? I think it might, which is not unexpected given this series
was written before that one (and it's my fault for not reviewing it
earlier).

> +test_perf_large_repo
> +
> +test_size 'paths at head' '
> +	git ls-tree -r --name-only HEAD >path-list &&
> +	wc -l <path-list
> +'
> +
> +test_size 'number of distinct name-hashes' '
> +	cat path-list | test-tool name-hash >name-hashes &&
> +	cat name-hashes | awk "{ print \$1; }" | sort -n | uniq -c >name-hash-count &&

In these two (and a handful of others lower down in this same script)
the "cat ... |" is unnecessary. I think this one should be written as:

    test-tool name-hash <path-list >name-hashes &&
    awk "{ print \$1; }" <name-hashes | sort | uniq -c >name-hash-count &&

(sort -n is unnecessary, since we just care about getting the list in
sorted order so that "uniq -c" can count the number of unique values).

> +	wc -l <name-hash-count
> +'
> +
> +test_size 'number of distinct full-name-hashes' '
> +	cat name-hashes | awk "{ print \$2; }" | sort -n | uniq -c >full-name-hash-count &&
> +	wc -l <full-name-hash-count
> +'
> +
> +test_size 'maximum multiplicity of name-hashes' '
> +	cat name-hash-count | \
> +		sort -nr | \
> +		head -n 1 | \
> +		awk "{ print \$1; }"
> +'
> +
> +test_size 'maximum multiplicity of fullname-hashes' '
> +	cat full-name-hash-count | \
> +		sort -nr | \
> +		head -n 1 | \
> +		awk "{ print \$1; }"

Nitpicking again, but you could extract the "sort | head | awk" pipeline
into a function.

Thanks,
Taylor
