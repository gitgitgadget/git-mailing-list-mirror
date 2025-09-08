Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCAAD51
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299456; cv=none; b=TcBmDB2qbJIMfcEWBZJQqjT+QB4KsJKeUPfQvOVWJBdtfsLjzC/eBYeIPNfcI1P2PDZQiBNa5tu2qaG1HvwSfCQ7UmnOptmSyjAEyuViztMPzQ4LjRTVsts9fclxM+tI20+V31kPPJxFa7/DEci31AroTrHpoBIEJSmwm+jRxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299456; c=relaxed/simple;
	bh=tHw0ZeuFrz7lcaK/1pv29NHHPjxg+iu8GKzMQErfyyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQpphYNaXAxXfwy7wUTHFDQJHanV/locdAG5/b4LET/IMJwgKMn+0kC1o14C0e4VNFyz3SDg7RzEBZ/aqZIHhtpeo8xJDoiH5ua9SVuGkXzjvQxHle3Waa63hurlFszeSlxLw1ybzLkSwbpwAnUf+ikTmyJH5vOKwAymjjMenKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b=1t0ZlqnV; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b="1t0ZlqnV"
Received: by mail.ekdawn.com (Postfix) id ED9B7181A2C;
	Mon, 08 Sep 2025 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=horse64.org; s=dkim1;
	t=1757298895; bh=tHw0ZeuFrz7lcaK/1pv29NHHPjxg+iu8GKzMQErfyyw=;
	h=Message-ID:Date:Subject:To:Cc:From:From:Sender:To:CC:Subject:
	 Message-Id:Date;
	b=1t0ZlqnV97bsU9t5D9Hu8KyzxbpyQSD4AYSoCTqfw21vsljkoNXtJBl06qmdwoKQI
	 yO/F/cD5pWpfdgRvPB+dj4YyeQxT7V2H2YOhWESzea+GceBPKNUJwt1jMLkeUiJyTK
	 +KLCMi6HhhfsxzIlIaroT1M+c0hb+fZ62++4EyXrGyGJjZXtE6PmnXbCxFl9v2FkhG
	 Z1LbkGs6ZCNSt0mHs7G4nHXhQvyS5l4J5bcCpTio2Z7d3Q8LgzaINnYqEqlWYzHnyj
	 pg5b3AIQephHcGZ0+VI0VeZKGrXB+seT86rCg5aDhKTXeKZK44BdttugvTZAsmaPgi
	 q8HVRFa5EtlMwa2jLFA0hFxU2dds58uwT+rPmVveQhS4O8HhKdyrZK0yYkrFH6mO4S
	 Uhs64pLlHnMsFRGnkHHaCxbTi/wehLY5HUcSVlx22tCK99SrlU7JAFufUxMMtrRo5L
	 6WaT/+5uyHRZkx9cnV4UIy4Yh8eSKsSxkCE3M7iOS0q9GYqK4lOY3p3XLH2Py4Irks
	 43T//nFrS3IpyaA3GfmAHEhxZLyhSs5WUdhYK8blgzl0DxfZ0vpmSPE8mu5mBFqvms
	 uKgOhDb5AjoswIi3cNz2b/nEtfnpDbLEg1C/NCf/LPQPvujCXv0sNyKfb1HHaR1GDL
	 fX2Ak04cX/zFQ7oDQzGwcIeI=
Message-ID: <15eac16b-41b6-4bfc-91c7-4997d390cc5b@horse64.org>
Date: Mon, 8 Sep 2025 04:34:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: rsbecker@nexbridge.com, 'Konstantin Khomoutov' <kostix@bswap.ru>
Cc: git@vger.kernel.org
References: <20240708143239.vq47dg7mgh33hykf@carbon>
 <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
 <20240708154457.jpt2aa5orzxy6kqh@carbon>
 <001b01dad153$ba880ca0$2f9825e0$@nexbridge.com>
Content-Language: en-US
From: Ellie <el@horse64.org>
Autocrypt: addr=el@horse64.org; keydata=
 xjMEZov4ABYJKwYBBAHaRw8BAQdAV+B+D8EgzDouy2nDV3ZvoAlfCdXDgPc77jwQv8WFOyHN
 FkVsbGllIDxlbEBob3JzZTY0Lm9yZz7CigQQFggAMgUCZvwh5gIbAwULCQgHAgYVCgkICwIE
 FgIDARYhBDNofAurx9gz4zmiYhX8ptnSOysIAAoJEBX8ptnSOysIVtUA/0M98whfeyLZN1kU
 poSyuIkAy24OCZzEDzk8JhjXunnhAQCGjsO2TdM6tcc5s0e2FqRDFleP0vXBRqUd5vrgNPgI
 Cs44BGaL+AASCisGAQQBl1UBBQEBB0Armcmr+4Ez2zZ9nMioqYvXRVLppRFfo8ATE0A/j7a7
 ZAMBCAfCeAQYFggAIAUCZvwh5gIbDBYhBDNofAurx9gz4zmiYhX8ptnSOysIAAoJEBX8ptnS
 OysIFoQBAPkec14UBSROnDc4wW5eABx1XYWOF7o5A2WTV/dEJOi+AP0eRQ3hxUJ+daiWYxqe
 VmCpAVDV/6jpoEvNZV03nSFpAg==
In-Reply-To: <001b01dad153$ba880ca0$2f9825e0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This has been addressed on Github's side by now, it seems to have been a 
Github server config issue.

Nevertheless, the ability to resume a file transfer remains what some 
would consider essential for internet software. I still hope it'll be 
added one day.

Thank you for the lively debate.

Regards,

Ellie

On 7/8/24 6:27 PM, rsbecker@nexbridge.com wrote:
> On Monday, July 8, 2024 11:45 AM, Konstantin Khomoutov wrote:
>> On Mon, Jul 08, 2024 at 05:14:33PM +0200, ellie wrote:
>>
>> [...]
>>>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>>>> CANCEL (err 8)
>>>> [...]
>>>>> It seems extremely unlikely to me to be possibly an ISP issue, for
>>>>> which I already listed the reasons. An additional one is HTTPS
>>>>> downloads from github outside of git, e.g. from zip archives, for
>>>>> way larger files work fine as well.
>>>> [...]
>>>> What if you explicitly disable HTTP/2 when cloning?
>> [...]
>>> Thanks for the idea! I tested it:
>>>
>>> $  git -c http.version=HTTP/1.1 clone
>>> https://github.com/maliit/keyboard
>>
>> Over there at SO people are trying all sorts of black magic to combat a
> problem
>> which manifests itself in a way very similar to yours [1]. I'm not sure
> anything from
>> there could be of help but maybe worth trying anyway as you can override
> any (or
>> almost any) Git's configuration setting using that "-c"
>> command-line option, so basically test round-trips should not be
> painstakingly
>> long.
>>
>> [...]
>>> fetch-pack: unexpected disconnect while reading sideband packet
>> [...]
>>> Sadly, it seems like the error is only slightly different.
>>
>> I actually find it interesting that in each case a sideband packet is
> mentioned. But
>> quite possibly it's a red herring anyway.
>>
>> 1. https://stackoverflow.com/questions/66366582
> 
> I have customers who hit this problem frequently setting up git. It is 99%
> of the time a firewall or proxy configuration issue, not specific to GitHub,
> and changes to those usually resolve the problem. The firewall and proxy can
> be implemented in the ISP's modem if coming from a home network. That is why
> I really think the OP's issue is the network, not something that can
> reasonably fixed in git. I think the network speed is also a potential
> red-herring unless the speed issue relates to the ISP's configuration.
> 

