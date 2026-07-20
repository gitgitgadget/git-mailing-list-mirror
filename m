Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743422F6184
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537375; cv=none; b=fwzKEKkZ9WEZG/6zNqVArbWUsZjjxmigfJt8ZX+ajkSQHSbQ/bWB/nR+CUe1oHv/acbw668fpDOwdXARIWjin8QfzhcFnIDk+iXgvdprBULcGGjKogY1nntRZ6wosymwg6FUQ8lOCpIll/Uafk/xGKZCHiuIDMwilwgJ7FRIrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537375; c=relaxed/simple;
	bh=rdUvg3/08sOjIvfuFYLadB8Vf0M2J6Y0WEcG9MikCdo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B47+PaOLPS4NcNS9IRF1LFxzC3+Abaue+P3MXPsDnwqtdqwDaYj4dw0o/jbGJNJvC7MSe0u+bWlTG0TRw00c+2yqhmFb/kfM5rx7TKtw9QCYkqOQu6B5kdUvTQfDAeKpO0yhLJoPYIwBNxrnRRXeQsVRHH4SI+zJbi26HEByIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4h3Z2962jFzRpKj;
	Mon, 20 Jul 2026 10:49:21 +0200 (CEST)
Message-ID: <7b541cd5-bd66-4675-818d-8e23eb1c9530@kdbg.org>
Date: Mon, 20 Jul 2026 10:49:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userdiff: add support for Swift
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 "Scott L. Burson" <Scott@sympoiesis.com>, git@vger.kernel.org
References: <20260717140232.6722-1-diy2903@gmail.com>
 <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
In-Reply-To: <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 18.07.26 um 20:11 schrieb Johannes Sixt:
> Am 17.07.26 um 16:02 schrieb Shlok Kulshreshtha:
>> +PATTERNS("swift",
>> +	 "^[ \t]*((@[A-Za-z_][A-Za-z0-9_]*(\\([^()]*\\))?[ \t]+)*([a-z]+[ \t]+)*(func|init|deinit|subscript|class|struct|enum|protocol|extension|actor)[ \t(?!<].*)$",
> 
> This looks good.
> 
> Notice, however, how the regular expression matcher has to backtrack on
> even simple lines such as
[...]
> It may be worth considering to enumerate all keywords and permit any run
> of them:

Let me back-paddle on this one. As I said, the original RE is good. I am
making up a problem here without providing evidence. Modern RE matchers
may be clever enough that there is no problem. If it turns out there is
a problem, we can improve later something that already works.

-- Hannes

