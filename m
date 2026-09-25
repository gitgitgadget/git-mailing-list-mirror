Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE0486436
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352285; cv=none; b=tsturXrnnLKb1aSCKxQANhLsQwEGqNSGs/xQn2hxXuAFwwvBS/g+9lWTDsHWjVMfww08qRLzFQZuIqFluzlMLW1CQX25ivJk/87p8ujC4jI15/KuZT9sCABRczngkgs/CK/LxQJn/tNDcorNinBDBnZmjh4PgovoQTep3V8kR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352285; c=relaxed/simple;
	bh=ugrvO9oDSZicxIeUh2opSwBVoo+Njr5bkpBWYJJGq0Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYElX7ujM6Gpfkq1IRLK294ZkYD/bz62kbnNTW2LxGxQCdpxRCdrSxtKIYnPuFd9WO9z4xcu+o2PnnW/+CXopC3nzqbTolZ50FbibGejG27RKqAZ5rcIT07LJ9uwpGgNkRnCbvUgPdR6df2BSYxIY96VJ3+/Ymbgakx/1MBkbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MilajYXz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MilajYXz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so6480145e9.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352280; x=1790957080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=seQA8yHbgSOssQt5Tz45MUbQ3UkHHUww8SDobX9gyAY=;
        b=MilajYXzPREEmsppBCpCsTmalFiYJCO9p/cW0apMtftxbtm5VNpd6vQOwtDxDHlraS
         3zMwnOanb1+oNXLP7oJoNpIkhi5ILGdS2dtci82B+z17+zjLCi8BOgPBE+Rli+CM3QN6
         qmbOxZ6zz+dD/hJWdnxOGA37SCpUNECwrkFxlW+LKGDcOWaoap1RBnMaNb87drmxG/TK
         U3A+2anb3GsyG6FqcjHd9YM/QuAfhkfm/eTYCqFi2YmY2taCHvMt1gpXpttaO0v7/GBj
         vGz6NQzyS7th7NK20gAZE5vJqOIEAhrwa75VJM0uhMiXAyEgsWwnSIjrf99LYWFcUxUL
         DvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352280; x=1790957080;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seQA8yHbgSOssQt5Tz45MUbQ3UkHHUww8SDobX9gyAY=;
        b=jUfg12nFokiT45+KHJ/+EQpW7tzHXb6m8Sp1KrVmpkTENCOpYWV7dBZpxN6Pw+zg8O
         K5Ib15YeTCGBKYC8oAR3RxowRBrOUg6pYE/a5O647IJeO/9eCAf7MUIi29Kt+QtDC7Pj
         NNXp84oiF+ksYLeJ+D9kKhYr/35WmoC87phTXYZeFLnJF3cshUnMtravH70MSNejWOxe
         ly1zZ2IetLcR745bU5EWQm9QN6+AOGnfDJUQlwctLWr4TXRBB6nh1Q8dABxVijZtc+QP
         9yJ5APEGhkZywGQjG3viKb/CyHlStphNk3npup3QLmYLMDLQ2AidtLfnV3iUQk/5adoG
         2e9A==
X-Gm-Message-State: AFuF++mpATFqS4mppeu3KXA1rnDVMnEcwGE2I+T7PzSXTLqBnLcO7BUl
	oSi8Nm349BNydODUfqRDNuV1bmXqGtbQAUun7FvYNjoyiNiciIsqL+09
X-Gm-Gg: AYBFou133ejx67GduGjhG9rMCxaSiL2/ZvysVWjYnSr38d0Fslsg5shVTsx8qCv0zma
	AOrmQvOlK+Ln0JOojfzFSKZEXZNnqUr3NCvmIOYbiIE93kgb8N4Td67oXtCgvq8CsTfULNu/aD9
	8lOnZ5LlFFblJMo9aVoY+xGRbs9ytaBBW1RjKpPVmQ+dtwBLUCAgnykBkYdk/HlcSHtSxj2Ie23
	lXSvH8JisovlasySnLn33hSO0JooFk4L1I/eRpIfyHf6hWDW6VYfQt4rFMXisgdp8tiwpKJLgGb
	g1+BMkVpC4hE0khAvY0UMmPZlqDpDj9Nm6QudpS5Tp0Ocoq68NZi5TQQT7ySbGoOH7bHjgQWfvx
	JPghJTtsgX1pS5KfppEkH3869/o8pph0Z1l2SmjF0XcggPtXijRh6gfMKALICMYIbOAeVY6/FfM
	yqfOK5oVBckeFQQ7LkYwrKRff3aDil4hs9V2AnPQuY0PWEB5nSnklWf4dJZ7A3dhrNNSkBGwG5o
	caCtwd8ZhvlIcbq+VOo43wGOxsahzudMfjSQAwaoCL5Imxu4vrr3Q==
X-Received: by 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr126747515e9.3.1790352280229;
        Fri, 25 Sep 2026 09:04:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff069d071sm85049485e9.5.2026.09.25.09.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 09:04:39 -0700 (PDT)
Message-ID: <6e6420e8-3cbd-4975-a781-645e1ffbc1d2@gmail.com>
Date: Fri, 25 Sep 2026 17:04:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Adam Johnson <me@adamj.eu>, Victoria Dye <vdye@github.com>,
 Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <xmqqse2yz4y4.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqse2yz4y4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 24/09/2026 22:59, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
> Ahh, or perhaps the trees are indeed given in a wrong order, but not
> in a random wrong order.  merge_ort_nonrecursive(), which is *not*
> the function you are using, takes head, merge, and merge_base in
> this order, and that order matches what you wrote.

Ouch that's nasty. Well spotted, I missed it when I read the code 
(because the arguments were in the same order as the call to 
merge_ort_nonrecursive()) and the tests we have use the same version of 
the file for "base" and "stage2" so do not notice if they'd been 
transposed. It is rather confusing that two functions that are so 
closely related take their arguments in a different order.

> Perhaps the true culprit in this confusion is that the order in
> which merge_ort_nonrecursive() takes its three trees (head, merge,
> and common) and the order in which merge_incore_nonrecursive() takes
> its trees (merge_base, side1, and side2) are different, and if we
> fix them to match, it would make it easier to work with?

I think it is definitely worth fixing them to take the trees in the same 
order. My preference would be "base", "stage1", "stage2" but so long as 
they match each other I dont object to "stage1", "stage2", "base".

Thanks

Phillip

> The new test in the attached patch will fail with this step but if
> we revert the changes to builtin/stash.c in this step, it passes.
> 
>   t/t3903-stash.sh | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
> index 3958ab3c8d..0a87e62b11 100755
> --- c/t/t3903-stash.sh
> +++ w/t/t3903-stash.sh
> @@ -374,6 +374,38 @@ test_expect_success 'stash apply -q --index refreshes the index' '
>   	test_cmp expect actual
>   '
>   
> +
> +test_expect_success 'stash apply --index does not revert unrelated upstream index changes' '
> +	test_when_finished "rm -fr playpen" &&
> +	mkdir playpen &&
> +	(
> +		cd playpen &&
> +		git init &&
> +		echo "base1" >file1 &&
> +		echo "base2" >file2 &&
> +		git add file1 file2 &&
> +		git commit -m "initial base" &&
> +
> +		# Make a staged change to file1 and stash it
> +		echo "staged1" >file1 &&
> +		git add file1 &&
> +		git stash &&
> +
> +		# Upstream advances by modifying unrelated file2
> +		echo "upstream2" >file2 &&
> +		git add file2 &&
> +		git commit -m "upstream change to file2" &&
> +
> +		# Apply the stash with --index
> +		git stash apply --index &&
> +
> +		# Verify working tree and index state
> +		test "$(git show :file1)" = "staged1" &&
> +		test "$(git show :file2)" = "upstream2" &&
> +		test "$(git show HEAD:file2)" = "upstream2"
> +	)
> +'
> +
>   test_expect_success 'stash apply --index leaves everything untouched on failure' '
>   	git reset --hard &&
>   	echo test >other-file &&

