Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B41CEADB
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927620; cv=none; b=q69Y9c9oZQA6iNqcI8jYATaZvWjsY0cgJPfvNCSyjL3nuEbqIF2visNRl5E40Q+LeZfwo6Ly9lsZ2VGCjIF58kNKjapTEb8dSKYBFWmcDF0rkbEJB8MJ/z1NkX6JdhziMt/1efpx4sxfgT56xlPL6tuhxZc1snMevmV6iB0j/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927620; c=relaxed/simple;
	bh=ZmeCB7K3+V/5gg+jwYICE9eddpJ9ae9mEJO76yoPAls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKvtNBWFwoEIYYt6m7v513rQysdzm93m9ZkX0YayuG2cqHdOZRzzvxZMyUvYxJY22rys4AYORyir3pbEVYU+Pf90QqxKj1lh8EZAj/hl+/CR33CLpjd/8/K7bbtG4PZLJgFlQzxcKivuPCM2AXrQa4N5C5I3H6xQuqAU5YHCE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=tYCHukGc; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="tYCHukGc"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5XNkuNtBgjZe55XNlu8VYK; Thu, 17 Apr 2025 23:06:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744927614; bh=eoddGVsYBib3cmil7HB5wQe4qBOPEcwW9HHuON9Cilw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tYCHukGcgrS9fgcx6fOw9E+AAmQu3q8dWE+Dg44/T81wzPL26D6CDPaNrobjGQRNH
	 cma7Nlj0X315Z1Znsyee40qvvHw1TA+1saIvBPRvHCSKLVr3O5Rv/oobLCb6ytrbIO
	 5TrIKQ2yg+tHEwDsKtjqs7nD/eUkvRreGDFqaB6UhMTLBpSEG/3jIFzogNHp+mCE0k
	 YP0I2AVTZz44R5p5AKVebYp6W5U5NqGYgEP0nVvWztdp80pWwAZHKuLdXEE5AuF7Z8
	 0FiwfJXHPODgLEVn6668o4L5e0kw8tzypgJfFbkxLnx5dsISV3pWMVBEEyLA2i8/C4
	 6jFio+XLYD1Zw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68017b7e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=v-zh1cwYEqECcaWVATsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <4d4ec104-392b-4630-871c-8398dd12d6f1@ramsayjones.plus.com>
Date: Thu, 17 Apr 2025 23:06:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] config.mak.uname: set CSPRNG_METHOD to getrandom
 on Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-14-ramsay@ramsayjones.plus.com>
 <xmqq4iymgadz.fsf@gitster.g>
 <aee15694-6a15-4409-9854-dad5f511dc48@ramsayjones.plus.com>
 <xmqqr01qeebx.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqr01qeebx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGln430253a/fp6JdkjNQIuzJq5+11aXBgoRFUlAgYjeLt/PUhNhxvcMzSDkj2Zd8KnNCWoSQJOoHoI1bmYHSV2lX4aO1mCCk9wmoqKtcyEjZ80v3Jbp
 2nyfu3si3vQqL83sjY5EimdhZWJK+vFk3UvG0zbwToeaEsUCPmfXgCA9lzI+qFCK1yHqwsl7gi3sJF5fYgaF/cpIbVRP64kgF8I=



On 17/04/2025 21:13, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 17/04/2025 14:55, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> [snip]
>>>> The arc4random routines (ar4random_buf() is the one actually used) were
>>>
>>> arc4random_buf(), if I am not mistaken?
>>
>> Oops, yes ... an unfortunate tyop! ;)
>>
>> Do you want a v4? (The cygwin v3 'make test' has been running for under
>> two hours, I could Ctrl-C it ...)
> 
> Nah, if you send one I will replace my copy with it, but in the
> meantime I'll locally make a typofix myself to v3.

OK, thanks. I have made the change locally just in case there is
a need to send another version. Hopefully, that won't be necessary!

(The cygwin 'make test' just finished and, as expected, passed
just fine).

Thanks.

ATB,
Ramsay Jones


