Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FE6DCE1
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323538; cv=none; b=B1GfBWSGKpmD5au7Osfq2zadmDB2gUCUDafgOTWIA4jHp/MebCjON2vfLjv+NFhca6Y/cT+Keg/H0NUVr8zXDNgkHk8WKyK3ZtcyuVADmABsFnxU0xEpRlOt5LGjeXfEzmc9GAXkIRsRLsclqugXpvfHQJebBEBYUVmaKO/a8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323538; c=relaxed/simple;
	bh=sQe8wubVsxvWPhPjJ/riuJYYMxRYuRu2jIfXCOUNEG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SmTTrBKenGoEuTIJfzSECgU2b7+HkfNAKVzhCWFXfTA6z5nZwqbfCnP4DmYWY17TAcsDEA3z4b8XNItln/4s/z519Rjulj0VDwUtkpFXSqK9Bg7dMoaI3QeL8ArzOkYaitiv9GJdVviEFKQ19Bd/nWDLvOHOaaFphwgNaEckWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZQSDT18t2z7QWW7
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:32:09 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ZQSDJ37SYzRpKr;
	Sun, 30 Mar 2025 10:32:00 +0200 (CEST)
Message-ID: <644ce9b5-755c-4faf-aaf8-b0383e12ff64@kdbg.org>
Date: Sun, 30 Mar 2025 10:31:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
To: Matt Hunter <m@lfurio.us>
References: <20250330055809.1019090-1-m@lfurio.us>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250330055809.1019090-1-m@lfurio.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.03.25 um 07:49 schrieb Matt Hunter:
> +	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"

Process substitution does not work on Windows. Please use temporary files.

-- Hannes

