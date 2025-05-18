Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C9D2FB
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554087; cv=none; b=rj78lSazZv/e5J4fUv2mt+zzlq/Iv3nxO2IcqB00IcP9J6RZn8sqjlKp6iim9AjePh9UhjN3z+INZnDy6zwMrSGQQoAy3xmbXqjiijlZmk0LiRZ55zrZnFltBXaUs4sT50vjK2u3VSKtF5g00ButCfHagqB9QfpujUIhM2ojoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554087; c=relaxed/simple;
	bh=XDk29FqBdjUjLlNm83dsrEOiiYBqeo5y1av/ZyPHI8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBr93rJ4l2Wsr3xWQLlMSA/EwFDO62W/qfI+TQdEeLlykggTTi9fpocl3hArqHLvKsvuTkAEmfJ5k8BKhne+QVYwn5sdV4Si5yV8hmh5MGHWIcIz7+CX+FSPMWZJFV81vW507vOJCmpuy7hl//lFd9DKQ7iIL/9tEO1kZNr1hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4b0Xn50YHdz7QWFK
	for <git@vger.kernel.org>; Sun, 18 May 2025 09:41:13 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4b0Xmw64fJzRpKc;
	Sun, 18 May 2025 09:41:04 +0200 (CEST)
Message-ID: <613e934c-9236-411c-be37-a8db2e3a3b50@kdbg.org>
Date: Sun, 18 May 2025 09:41:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
To: Junio C Hamano <gitster@pobox.com>
Cc: Moumita <dhar61595@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 git@vger.kernel.org
References: <20250511125809.14180-1-dhar61595@gmail.com>
 <20250511141101.18450-1-dhar61595@gmail.com>
 <20250511141101.18450-2-dhar61595@gmail.com>
 <8343694f-6e05-43c5-862a-63702314760e@kdbg.org> <xmqq8qmvs7sd.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8qmvs7sd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.05.25 um 15:09 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> +y=<RED>3.14<RESET><GREEN>2.71<RESET>
>>> +z=<RED>.5<RESET><GREEN>.75<RESET>
>>
>> When do decimal numbers occur in shell scripts? Wouldn't it be more
>> often the case that a fullstop is part of a regular expression or a file
>> name or version number that happens to be surrounded by numbers? In that
>> case, we would prefer to capture the digit sequences as separate words.
> 
> Sorry but I am confused.  
> 
> Do you want a filename "sample.3gp" treated as having separate
> parts, "sample", ".3", and "gp", instead of a single word?

I didn't consider such a case. The cited paragraph could be interpreted
to say that we want the words "sample", ".", "3", and "gp". But the
pattern that we have in round v7 by a lucky strike actually gives
"sample", ".", and "3gp" (I think), which is much better.

-- Hannes

