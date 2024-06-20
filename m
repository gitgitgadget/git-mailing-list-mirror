Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CC36126
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921848; cv=none; b=NJuHoioxrqplBzm0ztQzWa9KDMCmtfbZNz3JlvZplgeHVkD9DJYzcrOi5gD5kBUUTUyWe4EfQG9caQbTrVKfm5cKoN/2nlpjK2Rg8eOHnzEX+ZIIKYrEkiKCM1XM9WXvWrihF69gUGgl5Nv1yHPvw9v45HZeC37+ykz3WxZbdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921848; c=relaxed/simple;
	bh=qBKHApIbRSwIM6/KtEFsdiEzQoiS+Hk7XvndUmMpPZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfqW0xA68o/L8FKGb9O/tjLh0nhoMfXru8PXiF3zEu2W3Fz2Xa1Y4RGUWQGJMh29pPhH+behs7NAhBEDm13+tzeiIy7zjBA9rV9fmqMp6huqEFT2bsQn6uArACphxuEMYwMKBzb5NCOqTP+yzADiccB/ojLMh4e9Ep+Dh+1Gk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4W4vxJ1lQJzRnmN;
	Fri, 21 Jun 2024 00:17:22 +0200 (CEST)
Message-ID: <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
Date: Fri, 21 Jun 2024 00:17:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pager: die when paging to non-existing command
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <xmqqsex7tp0c.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqsex7tp0c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.06.24 um 21:04 schrieb Junio C Hamano:
> Just in case there is a reason why we should instead silently return
> on MinGW, I'll Cc the author of bfdd9ffd, though.

I don't think there is a reason. IIRC, originally on Windows, failing to
start a pager would still let Git operate normally, just without paged
output. I might have regarded this as better than to fail the operation.

-- Hannes

