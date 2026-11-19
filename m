Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092364;
	b=icX6I+9z5UHnZXb5CYgxa7ddFmYK1UhYf9wSlw6RJlRH6SS0AGdIhYWrnfuBGD4iC1vz
	 XwAX5aChvkwVTJIyahPL+Tr6UXqxbqTfd+0rV64hUmguca8UB91RyypmgpW+0TSRZog/t
	 nkar+C8uSrhRsH08wf3eWTQMt7oqiDRPkFCX8vevF568hfBiuuSsp3vb9s8Rf4fuypTym
	 g2x7dZf5+LqbsnwaPyZxwTG9qpQtxS+mU+NHb+IlgmkFdvYFB24vzvlc7ZFffe+JggMPQ
	 tRBoVM0DFSIvCOx9eFrzw7IBYC/m5x0P7G28exv4Br8JEyKBDiDacwqcsVml22zWBzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=h7sBOQNETXQTKCj27vyO8haW04xjMZDd4+88K6+ZToU=;
	b=dkZ1roR21EwJ3PDNLUImymjZ7rhS2w9QK60EDWVqeoSRbIdut9JmmcyZvhVMDwO/TfaX
	 4EsSOnZhXfW3w4iOROm4BDWr+wUaiftQeLCxMZma7UaKABr1euTQiADdqJcyT0lWhSHx6
	 Iwyb6FAbLOeBbVkRWfkn+D/HtEA9xiESlQGkdb659b5fUHqJgnr6Jr83iGW64GE1NYpwD
	 sRIfmjFMACrGPG0l0yIFHFsEr4lOeEQHLjZ4KGFYthFqlL4RYq+UzXPBDiQD8AyDvSsOn
	 GFplr46KyAETT5kV+WBMA540RKHvbH1ihBXT+VeJZ3HgA6rK1+IB+NwlNOlScWDYQEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yvf6mKvr;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86B60A260B
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A86B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yvf6mKvr
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso1215976a12.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795092362; x=1795697162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7sBOQNETXQTKCj27vyO8haW04xjMZDd4+88K6+ZToU=;
        b=Yvf6mKvrIg4cQh/2D4gmF+RgCg1oYA+HL/rr7/y6JO0XDHaqW62OZ97HXnZH2oUbT2
         FK4JnUhLb1fu2zLQ8NgFibt+lPB6pvcGR8pgi+y8s5+XL9VTY0wBPOpfpQp0Nah0N3zh
         6YD7V2NNoo/wdXdv5B6ysm9AmtoQebK6/Pkhj9w7vZu2168X8tWZohJGD/wBy0EkXJfW
         oHoZjtP8B027Uawmx9Bx1IVu0uIVaK8VFcp50iquXIbpPWsZmr87Np+3YhSG+P1mszOb
         +UeFReq7XrStkMbUTETivdujsUTyOeqW7CiRDLn5tLrCe3W5fTU50IVIlcr4FSuCVh+8
         t5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092362; x=1795697162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7sBOQNETXQTKCj27vyO8haW04xjMZDd4+88K6+ZToU=;
        b=s+Ylf4/a143+ZLsxvnYdi74/B/k7Ox0RjPnHOU8oCE9mIcuDutLQc2fzes0/1rx7wE
         oZ/tVxILq4UhBx455PaArZe6p2kPdI31HwZ/fa3JKLQJMpxhZwmCOK3zofxsVW1EAZXj
         39rhdla1tV+tSAOiwt1ZYIqZqODMGlmNid5SDMEoLkQPtP7u5MVh7ubwDmGB66M5vCOn
         JrFVVTHs0j4/ekg6Z14tIS/PPYnNDxIrEm3bo1FVb7hk3A3396/d+/xAlI9DRd3jrcOH
         zWDVbjoLGzxbzXLYdCYb4KWVeOwuEaUJHRqnvSN9HcarNAGZk+9HnBVY54FfpG/GFZQj
         eDag==
X-Forwarded-Encrypted: i=1; AL+hErFWg/IOwFaQwLjolt2NTmqKdhCC2JtTOy4svXMyqrziN/pv/zzHc9eqPz0/Emnq2p/O0Hw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TH7sK8oQJDt2rsXDIKo74AuhsRdStROelMym9OVJCwNgRTe6L
	pfOd2d5+PVkbHXmUYs9APZ4VYbvIhrzQEwOyfFEv6gfqtpdYrODh49mV
X-Gm-Gg: AZFdTZfob0p7M56vhyq9h0sfZwdxEEafs3wIqV2yBNBjs5c6fjWGeiILitB8DCdjMPw
	hhYiwg0RrL1mHxh6pZxRr7kA6BTRROp8393w7lrGVBloNSi2E1gcCUcFR/A5MGxxuBTg+GE3YI9
	3ZioY6HJp1nt4TdAAYGO+iAb3WUcVjqSLt9tpi/k7T0AlQxZDC0dfgyG1EESmjmojjRXJggYbyQ
	98zbB8jdzOaAiUI/+Vbrkr4NKyfnTEjAWR2EijlBvFNiB6Xopo+kqktifrBfsvoOJBngTz0G8VU
	QhAI9P1UbZOfGF+5FtATN5vFbPlcZtgtAzMOTXhGdSndQU3jhmhuvdPnzsy033VPSWke9XHzy1j
	VOnwLwz+zc6qE4sCcLvV4rc5neAeWnxSngfwJr52f9Rz8MzgcPp8ApkVYFpO44yyTAC/F+HZjY4
	MtQrTvqwKLNTfxHVaHDOAUTf2kURl9tANV5ouN+Mr8Vmr5dTp7vGiok2rKwxlD+kLNg7Ktb1HEI
	RaHKDfONPuTrRjwTB1a9d9pthlLLC1dJrtpSDRzRI1FFxtyZeKrR9WSdLRIV+gaINNjfAQMsKpv
	W30UilK3ecXzddFmChlwvdj92TVQlJha0JczoYJl
X-Received: by 2002:a17:90b:1809:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3b3d07d4406mr4979368a91.43.1795092362495;
        Thu, 19 Nov 2026 04:46:02 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b401f73a4bsm1201934a91.0.2026.11.19.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:46:02 -0800 (PST)
Message-ID: <745fe055-3032-4630-b33f-f215b845782a@gmail.com>
Date: Thu, 19 Nov 2026 18:15:58 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] t9300: make the series T tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-3-b8c3a0ab27e8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-3-b8c3a0ab27e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 23:04, Karthik Nayak wrote:

> @@ -3602,38 +3602,58 @@ test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
>   ###
>   ### series T (ls)
>   ###
> -# Setup is carried over from series S.
>   
>   for root in '""' ''
>   do
>   	test_expect_success "T: ls root ($root) tree" '
> -		sed -e "s/Z\$//" >expect <<-EOF &&
> -		040000 tree $(git rev-parse S^{tree})	Z
> -		EOF
> -		sha1=$(git rev-parse --verify S) &&
> -		git fast-import --import-marks=marks <<-EOF >actual &&
> -		ls $sha1 $root
> -		EOF
> -		test_cmp expect actual
> +		test_when_finished "rm -rf repo" &&
> +		git init repo &&
> +		(
> +			cd repo &&
> +			test_commit one &&
> +
> +			sed -e "s/Z\$//" >expect <<-EOF &&
> +			040000 tree $(git rev-parse HEAD^{tree})	Z
> +			EOF
> +			sha1=$(git rev-parse --verify HEAD) &&
> +			git fast-import <<-EOF >actual &&
> +			ls $sha1 $root
> +			EOF
> +			test_cmp expect actual
> +		)
>   	'
>   done
>   

We lose the --import-marks dependency from series S as the commit 
message indicated.


>   [ ... snip ... ]
>   
>   test_expect_success 'T: empty reset doesnt delete branch' '
> -	git branch not-to-delete &&
> -	git fast-import <<-EOF &&
> -	reset refs/heads/not-to-delete
> -	EOF
> -	git show-ref &&
> -	git rev-parse --verify refs/heads/not-to-delete
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit one &&
> +
> +		git branch not-to-delete &&
> +		git fast-import <<-EOF &&
> +		reset refs/heads/not-to-delete
> +		EOF
> +		git show-ref &&
> +		git rev-parse --verify refs/heads/not-to-delete
> +	)
>   '
>   
>   ###
> 

The rest is just wrapping of test body within a subshell to make them 
get their own repository.

Looks good to me.

-- 
Sivaraam

