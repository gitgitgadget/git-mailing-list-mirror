Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C6BA3D
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732167188; cv=none; b=OH6wwiHjih13MM9ZGi5/4KhOv2v9fxL0vfhCDjqCLGV3MEEy2XrI1QgajipyQevzRfPbk+uVHmvHBqiurOgs/CR497SV9EA0vMShL8kv1NgTLidYef/taCn5ZB1PHCPLoP12WTTnFgQR2T5VKg3ggrY0N1nHhBRISnD4G5Z7oAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732167188; c=relaxed/simple;
	bh=4Ktu3Nkxk9aI8GJln0K1/CuC6Mzx7K1lt/qMgPnNOmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TvClgfMq90O7pzifTJU0mcbWHehRNRwf+erXqkrQ1mbtJe+7NO5YIGRCkYj4I010YrTpW8GaI1CldUkIfOrsqnMgs2y4qnxhJUoSPZcCwfLiSej+dTLiv4SyVM0AiB8SB+DEVuRuK6ThdE+S06kVEL8c+ZuuEDMAZDYJIWZf40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:8de:445b:204d:c308] (unknown [IPv6:2400:2410:b120:f200:8de:445b:204d:c308])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 3E7BB3F53B
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 06:26:41 +0100 (CET)
Message-ID: <04783772-8606-4c85-8389-92e68ff50df2@hogyros.de>
Date: Thu, 21 Nov 2024 14:26:38 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: log --format existence of notes?
To: git@vger.kernel.org
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
 <xmqqsersyrch.fsf@gitster.g> <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/17/24 00:11, Bence Ferdinandy wrote:

> On the other hand: would a quick win in analogy to "%G?" be considered? A "%N?"
> that either outputs a "N" for note and a "-" for no note? Or something like
> that. A bit ugly, but gets the job done.

FWIW my main use case for notes is to record build/test results.

Having formats for "first line of notes" or "last line of notes" (with 
newline removed) would be really useful for building a poor man's CI 
that can display checkmarks next to commit messages.

    Simon
