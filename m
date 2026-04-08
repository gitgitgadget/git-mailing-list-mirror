Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FB3D8912
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670551; cv=none; b=MTWXk/r9RXYSfEiwGQkL+LDrXah9a8wUHtOic81RJnmXAo7veZpmiz4fLJrJWvQmasicMpq0Ph4Y2aXsj/Dn/d+O0NIsjO3BWhBVCmHu+QNl5sWETWb1rWkpyRN4C5gBYXsOB/GjJEspncQiQhgzf04qAx7c4ukExLnjJVCjywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670551; c=relaxed/simple;
	bh=AyOHVh2IiH0JUXa2b6jSThlkdNp365+00Lce2L8wLAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e6aQFnOEQ3j8LQuHQm0SQjL/tKxs8jSpfvAUp6QnS0Iznr73iq505Wufk6ZVkAqKMrJ2tYi6zcjSqT/yhq9/tZOU/8rvWZg8Nlm/HILskq4/09nHG3L4zX7Gtvwh+6Q3ccGMvYKYvdPA6hTuaVJe4ycHUPCqtl3LoL5MobU9nvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ESEUCo+U; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PNlRXAbt; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ESEUCo+U";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PNlRXAbt"
DKIM-Signature: a=rsa-sha256; b=ESEUCo+U5H7Lsqoz56Zt//R01ilBA02kB9i6twLshXdTMd3rf1I4LFzyILVvGGW+UWIniKUcsgljdXsk2VKCwibMjyjnNwnZfVY1w7A+VbRGp3xvzj/s+PFp03ACzx7cVY1y88Jk3Oe+B0cfaJerBaBFllLkkTQboStsX3qlu9qmgQ/PrZRPY0k0VlmP1a4Z2WxJue2TXVPTq9Ra4DHWnROASqjKUwNZaCrSPUbnUYtzlHM2z7VtnkyvTljCaphFHP5vdn/ZqnT2g2EN7kxJ0uR31pq/hgM1XPddhsjKQHDpShD8RW+SyRZZ/YVd3Q6xU8fLn579h2At0lfuXxZ8Dg==; s=purelymail3; d=malon.dev; v=1; bh=AyOHVh2IiH0JUXa2b6jSThlkdNp365+00Lce2L8wLAg=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=PNlRXAbtpQSQdYP/iufzUQpOIy8r47Gej/QwRVfeR3SbLLWQCsavdtLOa889q6YZfOCIMDxjTXnJXeOcaTs07Q/WDBdbLY6D2N9MSagMGWCBmHdk7sOeb2+rOE6SnBi6QD+bEsN08QSH9uf0GKShJCFxlepH1FEuq61W+FEQ6IoEglp4qrGFaUXtzunZgDXJC5ZK3M1sBqCNXvg/0jk2zi5j3aNgA7Wc8pg2Vbr6SGgtsSzULcQ8pTc1YxHsVnz3h0XUAi+ENJpuZAHKPGvlsC8AMxS7VLIVASI9ByKbG7VtodFAxe04XD1HAg2tEuLk3eHUgJNYW+ZI6Q39xp3cMg==; s=purelymail3; d=purelymail.com; v=1; bh=AyOHVh2IiH0JUXa2b6jSThlkdNp365+00Lce2L8wLAg=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 59422705;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Apr 2026 17:49:02 +0000 (UTC)
Message-ID: <fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev>
Date: Thu, 9 Apr 2026 01:48:59 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260406183041.783800-1-vikingtc4@gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260406183041.783800-1-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/26 02:30, Trieu Huynh wrote:

I strongly recommend you to run a patch locally before sending it.

	not ok 38 - promisor.quiet from submodule repo is honored

> +test_expect_success 'promisor.quiet from submodule repo is honored' '
> +	rm -f pc-quiet-trace &&
> +
> +	# Set promisor.quiet only in the submodule, not the superproject.
> +	git -C super-work/sub config promisor.quiet true &&
> +
> +	# Push a new commit+blob to the server; the blob stays missing in the
> +	# partial-clone submodule until a lazy fetch is triggered.
> +	test_commit -C sub-pc-src updated new-file.txt "world" &&
> +	git -C sub-pc-src push "$(pwd)/sub-pc-srv.bare" HEAD:master &&
> +	git -C super-work/sub -c protocol.file.allow=always fetch origin &&
> +	git -C super-work/sub reset --mixed origin/master &&
> +
> +	# grep descends into the submodule and triggers a lazy fetch for the
> +	# missing blob; verify the fetch subprocess carries --quiet.
> +	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
> +		git -C super-work grep --cached --recurse-submodules "world" \
> +		2>/dev/null &&
> +	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
> +'
> +
>   . "$TEST_DIRECTORY"/lib-httpd.sh
>   start_httpd
>   

Regards, Yuchen

