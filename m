Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01672C3248
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649212; cv=pass; b=mWlKNG0EHu3+FDPRPV6/S9cX+lsx0+jew/JssCRLsEI9+o+EmjfvWzvKA9mg0a7/w9/z/lqJJx2XmgUQOZjDwS7T8b/3LHyJ4B6ft62amtFu7vpnDV6/K+/8IGI3ew0AmbOtPttbWzBalxiIjvPRCixjM9ryBjjVyLbB+97zvME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649212; c=relaxed/simple;
	bh=xsdVZLD8x3DyBd7AcTZ+01tktS6T7F5qnnQ4RkVO1As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8g4bdR+JNTSP8jLQRwiUiGHLRkh8DTZSXGuyxDS5RFkLV3L4eaF99dr3xIHrjh1F8KGzcbj66xGNQXvWrpCwQQiAxi4/DqX5R3XXefy+Pg9wEh0X6As2XAlFwIB9PeJjz8zCn02jFT92smIldWGZ7aEhPoPV0+zHUa8CAjkW2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Khku6EKU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Khku6EKU"
ARC-Seal: i=1; a=rsa-sha256; t=1775649203; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RmCJ20Uu1JRe++KCFVEq3egEKOsA/k0mPQzkAt3dQSc7HYvGanfo3FdE420bLv9ZKzr3dxwchpunj4MOM7/bjDm9jLPp1DgNPBxYHdp0mR4PAlHEZMZ72L47JbEs5niAVhE3bO1HqmpnY3EpBbJZUFnE5rIpTA0eF60phLhOB5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775649203; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=66BCz+E42kI1S3hydmD4Q1JiGKcBZR06Xr/W0vG0ZyI=; 
	b=JPS9RnYCGzCsiyZzTIBKS6KYbUsTjt7Im5ft7oGpY0TJbRlPFijcnF3x2H6CmwMbcLxdTQsrYQFXOcIoG0nTGv7FjP32YZtPtzxnt9uWk4gLbWot4duKQcUzepbq0vEIPEMSbRDvA8uz9vjyR9jCapVTbS+FY32HyHb0iAVRE9g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775649203;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=66BCz+E42kI1S3hydmD4Q1JiGKcBZR06Xr/W0vG0ZyI=;
	b=Khku6EKUGThbNbbz7ejfOJztOSOlOHPAMsu4eJYH4enNAO/o0+43QMTr1PLMiYHh
	3kDnaz6cH6O4gbF86gJT7BclO+fiZani4OxyKpsbUQ+7bPp/fACFDkCE7TdMYqEFjXt
	gv2Eli+aI1DbYSIPUWRoXliRkjVuYMkarKOUErtQ=
Received: by mx.zohomail.com with SMTPS id 1775649201182453.8092905544304;
	Wed, 8 Apr 2026 04:53:21 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>, rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
In-Reply-To: <20260408054347.GA2284358@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <20260408054347.GA2284358@coredump.intra.peff.net>
Date: Wed, 08 Apr 2026 14:53:17 +0300
Message-ID: <871pgp3byq.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 08 Apr 2026, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 08, 2026 at 01:20:31AM -0400, Jeff King wrote:
>
>> I suspect we could construct a related case that does fail on Linux
>> without the patch above. Imagine we actually have two hooks running in
>> parallel. The first one is fast and does not read its input, and the
>> second one is slow. We'll get SIGPIPE writing to the first one, and then
>> kill _both_ children. But that's wrong! There is no reason to kill the
>> second hook, as our intent was to ignore SIGPIPE.
>
> This would require running hooks in parallel, which isn't implemented
> yet for v2.54.0. But if I build on top of the ar/parallel-hooks topic,
> then this test:
>
> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 44ec875aef..97257763d3 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -139,4 +139,43 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
>  	git push ./victim.git "+refs/heads/*:refs/heads/*"
>  '
>  
> +test_expect_success 'hooks in parallel that do not read input' '
> +	# Add this to our $PATH to avoid having to write the whole trash
> +	# directory into our config options, which would require quoting.
> +	mkdir bin &&
> +	PATH=$PWD/bin:$PATH &&
> +
> +	write_script bin/hook-fast <<-\EOF &&
> +	# This hook does not read its input, so the parent process
> +	# may see SIGPIPE if it is not ignored. It should happen
> +	# relatively quickly.
> +	exit 0
> +	EOF
> +
> +	write_script bin/hook-slow <<-\EOF &&
> +	# This hook is slow, so we expect it to still be running
> +	# when the other hook has exited (and the parent has a pipe error
> +	# writing to it).
> +	#
> +	# So we want to be slow enough that we expect this to happen, but not
> +	# so slow that the test takes forever. 1 second is probably enough
> +	# in practice (and if it is occasionally not on a loaded system, we
> +	# will err on the side of having the test pass).
> +	sleep 1
> +	exit 0
> +	EOF
> +
> +
> +	git init --bare parallel.git &&
> +	git -C parallel.git config hook.fast.command "hook-fast" &&
> +	git -C parallel.git config hook.fast.event pre-receive &&
> +	git -C parallel.git config hook.fast.parallel true &&
> +	git -C parallel.git config hook.slow.command "hook-slow" &&
> +	git -C parallel.git config hook.slow.event pre-receive &&
> +	git -C parallel.git config hook.slow.parallel true &&
> +	git -C parallel.git config hook.jobs 2 &&
> +
> +	git push ./parallel.git "+refs/heads/*:refs/heads/*"
> +'
> +
>  test_done
>
> fails reliably. And applying the patch I suggested earlier fixes it.
>
> So I think it's probably a good idea regardless, though I'm still
> curious to see if it solves Randall's non-parallel case on NonStop.

Thanks Peff for the in-depth analysis, fix and test.
It is very much appreciated. I missed this case.

I agree with your assesement: this must be fixed regardless if it also
fixes Randall's case or not (might be a separate root cause).

I would proceed like this (obviously crediting you for the fix & test):

If it fixes Randall's case:
   send a standalone bug-fix patch, then integrate the test into the
   parallel series.
else
   integrate both the fix and the test into the parallel series.

@Randall please let us know if the fix proposed by Peff in the other
response works for you.
