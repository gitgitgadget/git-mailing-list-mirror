Received: from mail.rackland.de (mail.rackland.de [212.86.200.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A02222A0
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.86.200.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846418; cv=none; b=AkfRCG5quzMPGPb3cghs5IFmenM5+jMF7OBTc3qlIFxJ1V4GbfuujiJ/AppSsp2u4IYxEiF3N7YsC6XHyj186sNlzVxVFm+dEZJjsdzaCI6OZBsq/PeqaNpV1HWxWPZsHuCdZy6W+dzUNYC5p+DdmuQiB+tafyyigp+RpRxhh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846418; c=relaxed/simple;
	bh=wZuJTTE/kFZDkt9hpBNWgYS0vjMymVfXGBCz2zAH/Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFtOjM/uaw55FsiL+TAhLZ+9SuUXXr7kFr848dMxmCbz6JuFs8Hf6ns3F/w9sssGQT70TqUse6+1yPUoGhskT2dWAggTND8e2yog9zow2eX83ovxJi0b1IdcG/5xtzxMJePvUI4Tj1Lo9iOSSDtfoBqgieowxSlJHTONTpSgdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de; spf=pass smtp.mailfrom=danisch.de; arc=none smtp.client-ip=212.86.200.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danisch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danisch.de
Received: from [IPV6:2a02:8109:d486:800:bf55:d1c5:9d:df8b] (unknown [IPv6:2a02:8109:d486:800:bf55:d1c5:9d:df8b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id 1536060312;
	Sat, 27 Dec 2025 15:40:11 +0100 (CET)
Message-ID: <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>
Date: Sat, 27 Dec 2025 15:40:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git destroys u+s and g+s directory modes
To: rsbecker@nexbridge.com, =?UTF-8?B?J01pY2hhbCBTdWNow6FuZWsn?=
 <msuchanek@suse.de>
Cc: git@vger.kernel.org
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
 <aU_lqe2Z47STv68O@kitsune.suse.cz>
 <008901dc773c$f05508c0$d0ff1a40$@nexbridge.com>
Content-Language: en-US
From: Hadmut Danisch <hadmut@danisch.de>
In-Reply-To: <008901dc773c$f05508c0$d0ff1a40$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 27.12.25 um 15:27 schrieb rsbecker@nexbridge.com:
> There is an option with ubuntu: Access Control Lists (ACLs). These provide
> override security for directories that might assist in your process without
> having to worry about git security settings. It might be worth looking into
> this option.


This does not solve the problem, since ACLs do not propagate into newly 
created subdirectories, as group ownership with S_ISGID flag does.


Please try to understand the problem before trying to solve it.


regards

Hadmut




