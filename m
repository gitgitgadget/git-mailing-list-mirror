Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECE43933E
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562374; cv=none; b=PJUO75orJUcN4CL5s7N/lsNfOK6pOSLQgDS2+QEncvGNBXgNZNtO+7VExsUiw2maF/dbLDNY8GNuWtzj9yjfX8YM2icJ712LuNSi13Zvr/YckIrELH+ifXQQBQxoxkQ+Pfc3/rtJCiQxU1KOC1fwwYPHItHmrukL5lsGEvDvU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562374; c=relaxed/simple;
	bh=amh/Sj96/Zl8XAANoVzt4YXRVrUQZaI9Wr48AqnIytU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cvWNcCzY7ePXdC79mJTZ/Dr9em1VNk3astut3rTydZxklmbw5WMoJ1yJglJ12+1tx0jjgx2JL2/Ry9qHg/Ezm/r5faBnXOBsUrGRrkA5zALuoRfux1nTANyAkvl52ZpS146FM9EUN1nRxtSjD//NTjtQF7Vk/AlapNEX9ROYtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=hn7jSdQV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="hn7jSdQV"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1whe2z-001Mub-Nl
	for git@vger.kernel.org; Thu, 09 Jul 2026 03:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=qGMfB7EPbGNxxRfMUyIjD36Q9kZF8v78F5gP+V44V5M=; b=hn7jSdQVppnEmr7nazcKrwqLEi
	th8vEjGy0kT0/MZQOp7Sj2nBxk5+mGmdYNzxQR1mfs0rnybTTVaM5Zf87xOxW2b9j5fZhhD/UbUbK
	iUqkw0EjZbrlaIhTwBFVmO1mjV4pFgBXT2DDdOzQ9elgahydRfAY4g8vu376HmGR4XIW9kK2WMSLE
	AdYTk0v3q1SpLoD36UxKwdK3qxSazPxgGYlArG7hBdCGHPJ5l6WaCtV77e9FeatkFSdkrjPZMqcNz
	2M5JjPQpkzOG75HlxV17ZTjpNm+lnNs80ix+qqXnWK+LOIioN+etb1bttPBcZsg/3P5LwmYxg9txb
	KzBUf7eQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1whe2z-0007vO-CE; Thu, 09 Jul 2026 03:59:29 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1whe2o-00HOPB-KK;
	Thu, 09 Jul 2026 03:59:18 +0200
Message-ID: <9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
Date: Wed, 8 Jul 2026 20:59:16 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] git-subtree: Bail out if we find output from Rust
 rewrite (test)
To: Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 06:58, Ian Jackson wrote:

> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -439,6 +439,24 @@ test_expect_success 'split sub dir/ with --rejoin' '
>   	)
>   '
>   
> +test_expect_success 'split fail on RIIR git subtree data' '
> +	subtree_test_create_repo "$test_count" &&
> +	subtree_test_create_repo "$test_count/sub proj" &&

It may be slightly faster to create only one repo and just make orphan 
branches, like `test_create_subtree_add()` does.

> +		echo "# sabotage" >.git-subtree/config &&
> +		git add .git-subtree/config &&
> +		git commit -m sabotage &&

`test_commit()` from test-lib-functions.sh may be superior to manually 
writing and committing this file.


Colin

