Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC23B4E88
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308637; cv=none; b=ZiLYUsyJpq3SBO+CTeOWN/Uos2Ai+Dfeu/ZLryDLrRxS/j2WGJjNbqdOdct90YjTY6ZxOJNSs36Jy4S6CQ6IGRoJO0ReE2kzEEFwq4SVb6/q1fVXOhBCqIUPVVu9Mk7BbZ1TXapPk6YeFCqRliQpH7WyImWxp8NYdXVAM44huhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308637; c=relaxed/simple;
	bh=5G85mDaG/P9lbhmDdzddb76YCLcCJQ73muLTxHZjFwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXpTqe7BbBJx559zTeQR0lJKXB+GkqRcZsHL4dn7si09n27RXYLkAm6CTSfLXIBXoN4ZxX3v55yzewWQfNXSPF9nASWO/Wp2f0mmGiCOc+Y4P3LoNOO4BgHvto6Cz5FDXT6+W2JuQWtiBoE2WIrAXpv0dTrIMAkMnjt/bTD2wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfmvwi7A; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfmvwi7A"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so13615476d6.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782308635; x=1782913435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0GJwKL7MjibUmN+ppqScC/uZj8fx3bje10V1KnGyjM=;
        b=dfmvwi7ATvwe2JUkZZOduuUbibnzzXsTLSx1z4KuP/e6CUSfwWW0/Q9rwk5lWn9iTO
         l8hDB3H8sWQkZk31l3IzZF1yS4xZMr7hLR7405eO5r09etnCg1njKhbxvX1VgWmv/LDP
         r+ud9VeJdFcROnJoPBnUqwJuPyQU3qozTb1qy2J2Hm+psLIFQxCQwuCF2dJQ82HahKdp
         9A8wh6Q+DYGU4cTC7REXJFG0BkZzIRRKs4z7nz4gTv/ZZUMVttYfwoIkvni5JHkht9XW
         1Wu2qJVnExrN7u8F+W6vNrRqAJQvpmUqLmVAPud9GL9gGB5h7mEMYz6/nQVDVgWEQx5W
         sJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308635; x=1782913435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0GJwKL7MjibUmN+ppqScC/uZj8fx3bje10V1KnGyjM=;
        b=pojXp9Io6VwHUdh7Prc3MsDswdOmBmQzzf54PYFoRapRaazDqSh9nj4bw2WeGBGvYM
         /vHZdOw+yA8BavD2vc5NNDP2MyY4WjkR0oHTrmO2b/BV42Is4fXtw+WT6TqjghDObHna
         U8BG4iiiHAXwJKiLDCKVKjuc+Vcdn64kML5eAzld3KUDflPcmGE/18j0Vhtf4Y59y8pr
         vO1PaCaKw4nOx87UEidMOzdFrDoBvCI3X0NiRPn64Tv67ScVQSfUPlAJOA9QqTYO4zv0
         ooGwqFSqmlOAmSDBSzD3jRYEAx32rzrqDrKrJncY2F5y5SxTx4pQqOJbum3EKSaoarOm
         5pKA==
X-Forwarded-Encrypted: i=1; AHgh+RoFOSuTkc7x79Hq97LZGdJsArwG5IJJG2Ytd1Lw+Vn5XnsCAFktGAGdFuKyhJWvWbAzSx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JfmHoaNfPlmyAjyU6/G3rLgtMejgMuh1PLBx2zAGi9ajmXyZ
	IZdwws83pz46g6fhUg/uTwSuS5oFDxHIj0z2wib5a9PQOOyaHR6dDnI5
X-Gm-Gg: AfdE7cmQSiazC/MYOmck61riPU0S7KWS734gezCSe5SWauyQCbCof2cdylGs/xknEXj
	0hdp5d22aXAdH6zL/7y6uct847BF6QG4zMC0yBQNJ4XHpDBSIYouHLIBzV6EYK76QXDqi2FcYR2
	ygH4ah16w/VhgpW2b2A/eswmaMvHx3zVhdnvkH7/EvGKfeZQ3AexTWYR73wCy9bZrMUgqhC2DIW
	GuuzqKGefQ7RvUSqxqrK79YUJLLZVIe0yhf1kmx5CI7lvp948+lOpu6fb6nfCdJvD6mYFuDbgcy
	8Vu4nfyl0meaDBrHktXrkfVjBJ8ysJqmhv4tIhlNeZDNC8KV9okZtE0WJIU2qljfkn5PNkHLv17
	Bcbc7HDvU6SEa+PUU8/oGF5h8meQyubrjWEcJYfhTSkg7sql4hS/7NKiLjNI0nxBOtBRZcr+08J
	2pXxs5eTb1JKRhHHjXjR01naO+gKofGpoevHFE1CGZcjeaGwdGV8R0ZDvo8Q==
X-Received: by 2002:ad4:5b8f:0:b0:8db:ebc1:7ae8 with SMTP id 6a1803df08f44-8df8ffd3a14mr324137946d6.19.1782308635054;
        Wed, 24 Jun 2026 06:43:55 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm160477846d6.30.2026.06.24.06.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:43:54 -0700 (PDT)
Message-ID: <b4b33635-1279-46c0-819a-d29cc13921f5@gmail.com>
Date: Wed, 24 Jun 2026 09:43:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] t6600: add test cases for side-exhaustion edge
 cases
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <6151b8e0a3989a51e6d9717e0ceac439f26f1c1d.1782303254.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <6151b8e0a3989a51e6d9717e0ceac439f26f1c1d.1782303254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Add test cases to t6600-test-reach.sh that exercise edge cases in the
> side-exhaustion optimization for paint_down_to_common():
> 
>  - in_merge_bases_many:self: commit is both A and one of the X inputs
>  - get_merge_bases_many:duplicate-twos: duplicate entries in X list
>  - get_merge_bases_many:pending-stale: STALE transition on an
>    already-painted commit (ps-* diamond topology)
>  - get_merge_bases_many:infinity-both-sides: both tips outside the
>    commit-graph with non-monotonic dates (pi-* topology)

I'm happy that these cases now exist.

> +test_expect_success 'in_merge_bases_many:self' '
> +	cat >input <<-\EOF &&
> +	A:commit-6-8
> +	X:commit-5-9
> +	X:commit-6-8
> +	EOF
> +	echo "in_merge_bases_many(A,X):1" >expect &&
> +	test_all_modes in_merge_bases_many
> +'

and using 'test_all_modes' is great to get coverage of all the
different commit-graph states. In reply to patch v2 4/7 I ask
to see the results of the traces in these kinds of test cases,
but each of these modes will have different values.

One way to make these tests have potential to check exact stats
without too much extra work would be to update 'test_all_modes'
to run each command with GIT_TRACE2_EVENT set to a known trace
file (reset each time) that can then be checked after verifying
that the results of each command is the same.

Then, these tests could have lines such as

	test_trace2_data paint_down_to_common steps 20 <trace-full.txt &&
	test_trace2_data paint_down_to_common steps 30 <trace-half.txt &&
	test_trace2_data paint_down_to_common steps 40 <trace-none.txt

after the test_all_modes line.

Thanks,
-Stolee

