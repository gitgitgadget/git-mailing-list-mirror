Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD4174EF0
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742162271; cv=none; b=A6ycbJQgUqZIPqL41kC8wpDu+/c9shl48D3slxLD2ApK8vrGLK+KHz+E/FGSyej04j0+NzsKdcBSuqPbonV0fm5mRQ8XDSdwnXHuO7T0v/g7iKhic3gIFz2iE8s2IWKRZp0VXdr5dPkrddriGn3JqiPVp7Wh2unPfdN68YN88sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742162271; c=relaxed/simple;
	bh=/xH6uUQ2Ps+buX97rjBUHggb1C2U3lf/l/kv31Ksx7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuuIyNmuuePeZjfo9QCJ7TFTspX1wlpVLUVRYMVzF4lAk+aOPGtj1LKgh/7Bru3bkNUWB9UKtxwWeQJaVwchopvprYWoRKj/EPtn90/bnrgB8qA/752lHmABa+C7/LXtc2JHlPJVG2R3Y5nYu23tJcpHkvMIk5xGBkITpeClPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=NAv0o9uY; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="NAv0o9uY"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tvzLtzDYmBiaNtvzMtb0gv; Sun, 16 Mar 2025 21:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742162266; bh=rnj4uNov+NdYw/DsrGTl6VG196sslCcUC4dcJ5d076Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NAv0o9uYjygChmwk/tRugi2YPP6rPGfl/0Zfy5FznKoyvDWoK8i8uiH8n+JZmQx7D
	 1R7HdRjH5XgKTbwphCzemBTavm5jBTaue2tCD2xXzu05OjZLTDwfKNi0pBZnWi3D1N
	 peKgA4tuq6tTWb7tMYAOuzboL6mGm38vG5qUoWPpyrz1sJCdTzVBN8rkcK22LYyUuw
	 poq5MoaRNIg/xnXy8QEaktaQUCeMIumVL1de1n3TZJZCrzOmNNRC1vvbNm1dzNJu65
	 pNvIaRBYEbqNcksiJFyzNysjHNhHa3CeFCMZXjxtTqmP7v2Twdvfu8atdRKMsaI7IT
	 LJedy2fRm45vg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=W8CbVgWk c=1 sm=1 tr=0 ts=67d7495a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=8VpDeP3kAAAA:8 a=CCpqsmhAAAAA:8 a=iKrn8l-KAAAA:8
 a=nUlTXbo3HiVlBCeFl2EA:9 a=QEXdDO2ut3YA:10 a=x58pXJj3Pl9T3GLWE5Uy:22
 a=ul9cdbp4aOFLsgKbc677:22 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Message-ID: <9c815bdc-4cc6-4614-a203-105811ebbb59@ramsayjones.plus.com>
Date: Sun, 16 Mar 2025 21:57:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net> <xmqqr02wbtdn.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqr02wbtdn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC5rKppGTtQcmw1rTh+45ttm2hQR07gNIEl4Wri/PsdMZAZML0r6d+p8CzQfO3NF72kGHjBKGq6t4g43WEkbMyy1ZnJHqe2p29vMnKlRGE4CFl6UU8Er
 Q4ZlOPgfYdG8yUFLrWGoTw3VmnzYVd5Zl6Wn2JfIUqK074cl+CuOQnzk3bu8fmgG607JpXwj7evgoo7IxbDP+d0WAnc2e0eY4vw=



On 16/03/2025 20:41, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
>> argued that it was not a secure approach (I disagree), and convinced the
>> glibc maintainers to just make it a wrapper around the Linux kernel
>> CSPRNG, which it now is.  So there's no actual benefit to calling
>> arc4random versus getrandom, and since it's newer and less commonly
>> available than getrandom, as well as slightly slower (because of an
>> extra function call), getrandom should be preferred.
> 
> This
> 
> https://www.phoronix.com/news/GNU-Glibc-arc4random-Functions
> 
> was the first hit of my search in the area, but I think you are
> referring to
> 
> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=eaad4f9
> 
> that happened 5 days after the thing got in and the code there tells
> me that your summary of the situation is quite accurate.
> 
> So I agree that dropping this patch makes sense, but do we want to
> do a bit more to improve the situation?
> 

Yes, this patch should be dropped. (See my reply to Brian; our emails
crossed!).

ATB,
Ramsay Jones


