Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB84A15
	for <git@vger.kernel.org>; Thu, 16 May 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877268; cv=none; b=phPCnCk699PCfLWXC99lSkOMqgcIX1MBxv2nVNyExPSABRQ20gV6ds6r0OjMPrWt6qi4/NFEnjEuunxh1qfOyz3r2XncaIKz752gas1XfzIC6jwFChc8gp0ijugjxXhSJJP8QUT+LqymHAI73t2ayIAGvKuZf/ZzXbEeakGfpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877268; c=relaxed/simple;
	bh=VCO2kC6eWxgM5eny7B4EcPD8jupR5sq9aesMPWIBkVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euiJ0ZNszOzwAbtpuKsGQyDLwByChRQkKXKDSciOuG9TkESA4zi21G6olQC/a1EKrKyvL1YtMoEub589XwWvIV+GNffrHTFnIjMs2hgoeJ+iYdaN+bayUQZU3KGxXRTJh/eBXUnSq+LLmlpVy5JNLpFZXdw4kvaf17sYdWeTYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jdNHyi/X; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdNHyi/X"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 56DE826EC2;
	Thu, 16 May 2024 12:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VCO2kC6eWxgM5eny7B4EcPD8jupR5sq9aesMPW
	IBkVc=; b=jdNHyi/Xut21W9tG20ZoWrFUtQAaswVhM6VMAcqS08iZipCys3ifFI
	tzRClF8mUWc4L7Ur/X672JqTQ1aYuvvELcCQ8P2ZlrOTQFmDfTWqmgcN6JG7sfgE
	ZTqCxysQbxyoGNBmTaFBttg3E70ZOKsqh2lRJJqMfeZQ0o1vnSyio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FAEC26EC1;
	Thu, 16 May 2024 12:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D80EE26EBE;
	Thu, 16 May 2024 12:34:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t/t0211-trace2-perf.sh: fix typo patern -> pattern
In-Reply-To: <ZkW5ggOVlglfi64u@telcontar> (Marcel Telka's message of "Thu, 16
	May 2024 09:45:06 +0200")
References: <ZkW5ggOVlglfi64u@telcontar>
Date: Thu, 16 May 2024 09:34:21 -0700
Message-ID: <xmqqseyhra0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26D63A5E-13A2-11EF-96C3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> The bug went unnoticed because grep with null RE matches everything.
>
> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  t/t0211-trace2-perf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  Will queue.

> diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
> index 13ef69b92f..070fe7a5da 100755
> --- a/t/t0211-trace2-perf.sh
> +++ b/t/t0211-trace2-perf.sh
> @@ -233,7 +233,7 @@ have_counter_event () {
>  
>  	pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
>  
> -	grep "${patern}" ${file}
> +	grep "${pattern}" ${file}
>  }
>  
>  test_expect_success 'global counter test/test1' '
