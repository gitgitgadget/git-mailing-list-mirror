Received: from outbound.pv.icloud.com (pv-2005g-snip4-1.eps.apple.com [57.103.66.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A773C2BB0
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440492; cv=none; b=uihAmkOr5tJInUKTO0o+fOOYw4Uq5oO0Vr2HYiuepWR52/toh2T/QuVbFEZZ/IfcBBM2TCR+6uhH7jAe69jITY39eVa0vLwu3lIy8HZRIqE3sgReHBxuf2jHXqPfOH42VhFjW22Ft9NFOB8idzkES369VUBRWS7oOEFeMMj1irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440492; c=relaxed/simple;
	bh=dqAXnZbX9cLdhWcuC5/VGpJFJDLSU+Bez3b3ckQ9Rqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYsJ3+3jzIvr/0tZ9PqTwhphsszCAmYwg6fUJmqVxgBpKYhaGcZ2RNVZn/VpC98rLNpoji5DMLx/JIDHxrSuCO2JdjaqFO35I5CaGckUj+wOrPjPVydqRK1xPKJ6hVPA2/kINp08RLGp3IRxM1e/ctfrDx3fB/cifwl8Qimg1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NS6YOO0V; arc=none smtp.client-ip=57.103.66.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NS6YOO0V"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPS id 752E0180016E;
	Thu, 08 Oct 2026 06:21:24 +0000 (UTC)
X-ICL-RepId: 01a11a2c-7843-7a0a-be1b-a04c1df2a70d
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQFIHVwPXBxIDFYFWxcOVk1KHVEMRB9bEVdWRwVeDl4wUBtfAkIPHBNWFRMLU1ZbE1UXRgkZCF0dGQpQUAJLWhVVFw4CQh9QH0wWV0NHHRwZWhRcGFNFUR9UWEMZRVZpQQtPHV0ZWxxCZFhXCQoCURxWDVdDVARfUFQRV1ALXAsRXE4DW1VGURYAQR5ZD10FXQAcUV4aCVEUDh5VXQRdAEZdOFoOWwRHFBcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1791440485; x=1822976485; bh=Cw+nPPAPlqMw/Kno350KkeX/OuLESqLL6S/LetJHRJw=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=NS6YOO0VDbPzJjqK2V61y40+tVO9wIXMhyRbgRHIctS0tH6ib3vb8ajc2VlUY2wLfRKKpx/V2BKDtnHbdlEgWCC8ZsQsVwQDTjVgig/Qvq/r4DwFixdLl+Of4GOjdEOw3vCdBAOvo9cCCdL426JX4J9k7i1F0bfs5FpGmMUSti2YKYTC04UCwEAVjLLSlXlZufehtI955ZCr8rbw1l0el8v/2enn9ZiwBzB3SmTUvxOAMWGK/6ubx2JhX/nBcycnJPzhWFtfcuvj+ccDRMqb4XN3TO4q9TCrErBxBJA0vEUYAuW/m2k052YFvNlzHK30TXPHToCDzg64molOMq7Exg==
Received: from [IPV6:2a01:599:117:a94a:6df6:9d68:f6e6:e3f6] (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPSA id DF2D91800125;
	Thu, 08 Oct 2026 06:21:22 +0000 (UTC)
Message-ID: <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
Date: Thu, 8 Oct 2026 08:21:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Scott Chacon <schacon@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org,
 Sam Reis <sam@opencanopy.dev>
References: <20260929112544.86511-1-scott@gitbutler.net>
 <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
Content-Language: en-US
From: Sebastian Thiel <sebastian.thiel@icloud.com>
In-Reply-To: <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX9x8rgVplY43V
 ZTFd922FMofGz68If+UfgP7mL3KBdoTADB9r05o1D2FxpT6/HjtX1gXOv0KXxxqilK5cKrGG401
 25DGNw16dZvDCx7/rs5SKFlqv7o0gNc0Kd0y4huHQvVZA7GRzh9akwYHsSkLm2IAop8OICCzKs5
 2jR0i9oZuQZsQu/8tPZNWwleLLt0cmfGxHcs7VuCHF2KmEB4+Q2SAhkKOEw8yw8VdezSya4iznm
 0lfHIk0Qr8lkxdrgJohSVIuULq8CGlovhsYy6IruL8V/vORwMkEiP5ajtWGYkfsdIWwDFd5Uhbg
 TKlh+6FfPy1hlyRw5cgzppMxaYh77AtRVHhQkq30ES+zuZv72bS5PiWmAHBJno=
X-Proofpoint-GUID: -f9a_HsztUXZOVkptg9myghYH4zRdJ1d
X-Authority-Info-Out: v=2.4 cv=Pf/yRyhd c=1 sm=1 tr=0 ts=6ac73664
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=zqz4MmORN-0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iuz-Q6SNAAAA:8 a=NEAV23lmAAAA:8 a=ybZZDoGAAAAA:8
 a=3MHYrfD4mWe6iT6ZG4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=i-ZYw75UE7XCnyHD8pkS:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-ORIG-GUID: -f9a_HsztUXZOVkptg9myghYH4zRdJ1d
X-JNJ: AAAAAAAButpU6XZccVkITGIMyNYQX5QrRXZUJgUNfrXVDMol7Shu0D9RHq/yXR+wF8KQKAP8pXrtfiLvNppfWjsuUKv5u+FotGDEe4o5nFkQXQEo2myPJ2n4GKCt6dXemA9yQlMwNiJFVOetYgxyp6A+aoMZ/HGupRYEmlCjtLmsJmXKOW30S7X8j0huZF8yI1jcL/tvbeF7eDVl8iAawT/X0moGT7MN2ug/dwzq7F5V6Hh8QkA0VUEGzzFRfVtnnG8TjiicuexFlmedOA0/IBRwFKcxGBbnl77U1kk2Q3vTq//DVp/sxQygZNmM9hhQNR1oj10mi7dxte/nng5xY8SE3x6nnGuf9LUwjdTheR0Ilw7vWx3ykUBzDvtF9BYqxvhof0X0UL0Z8IIYpIZj2UwzPpLHGx5FNv9+fZEwUl126n2wcdVrGKKVD87qJ7xjl1fiUk9oX5NkzFkF94IkrBlltCjj+cCm9X/Nb3n0gMf7tOlJjIxbiJPaWBbX9xYTdrWGR99/DPhjteRvjXGIUa14rwmta/lsAOwnHBeP8HyrMbgJLSMGqnc9be2xY2fgQje+EQBYL4YwGFussv3j2RsmeuT3wrhPerTWtUEyWxrqs8O3zSe8iLE9l7hVhbL/lQGFeGMp7ocoWWWp/JBH6r+2Kif6uBAvMPJUyKLxISSpPTXgJKQcbXRMFABNZkoge6OwXwVSLXmth4bIbeIH7KM4/exgWkvJXIJ2BT049jmuOAbMOc4paZztyOavvjhbNdFri1JvzrHKWxbacERvTEOPt1J1KYovIZd8rcypB3yJLWF6IpMXSv3JUC9ktmZa3B5RxLhNgQvEJHMDaLuqRkQ1ThmYIZtuvWwPj4R3kGNaLnouB55Ddc3N01EpmNnlO1/6HnXIkBze8swb5FCL/Q4hT5jUMwFnWkaJDiLDeu7mQlJGdwCfScbmsPO5qPlHOjY5eEsSdPD6ZcT2pSGR2xcwlEt+4hP
 zVGLKK77LmyVSznrpBZTau8kZY3SK3+iwY6OmtM35afGeJynYf/7zt3ap8/QQ0EdLgnDIxtfcWotFwg9ova1w0q81PlbIeqQ4g5bS9W6Sb9hYOaGUTItq86SrXOOYyIwau+emfxnxu3qUS5RpKgtVofSxTdE8kLhd3tC2UzjGIrk+a/TXs6rZxsx7TYSnCPnhX5Xrmio81d4ZkZHgR1B77x7ir5NYf4c9JGsSYrBjnv+rqs7hvsBOaZEyxepgbXwSeiqTedron/UpAL/90GC6ibY6ngY2xljrTxI/n+nkiCypTTPltRbD

Thanks for reeling me in, Scott!

First of all, I am very happy to see that overall, everyone here is
making an effort to find a way to speed up SHA-1dc again.
It's so impactful!


It really did hurt when I finally had to add SHA-1dc to Gitoxide and see 
the performance of clones plummet. And it still hurts me knowing that
an incredible amount of CPU time is wasted doing something that we now
know can be done much faster. At GitHub scale, this must be more than
a blip.

While it's my dream to one day have a GitHub action that uses `gix` to
clone and safe even more power, I think Git is in a far better spot
to achieve significant savings much sooner.

On 07.10.26 20:13, Scott Chacon wrote:
> Hey,
> 
> On Wed, Oct 7, 2026 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> This series ports the approach of Sam Reis's sha1dc Rust crate [1],
>>> which gitoxide recently switched to [2], to C.
>>
>> Which means license-wise the original is compatible with us, I
>> presume, as they are "Apache2 or MIT, your choice".
>>
>> How can you/we be sure, with respect to the current AI policy in
>> SubmittingPatches (which by the way was vetted by SFC lawyers), that
>> your "AI generated" code did not "borrow" from places that gets
>> you/us into trouble?
> 
> It's a good question. I actually just submitted a proposed update to
> that policy based on SFC's updated guidelines, but either way, I
> learned about this from Sam and have talked to him about the port and
> he seemed excited about it. I can triple check, but I'm fairly
> confident that he's fine with this and I am fine signing off on it
> under the terms of the DCO language.
> 
> Of course, he in turn used AI tooling to produce _his_ library, but
> within the guidelines of the updated SFC guidelines. Johannes's
> alternative series is the original Rust code of Sam that my agent
> looked at to produce this (in addition to his blog post explaining
> it), so I'm not sure how that might be materially different.
> 
>>> The end result hashes roughly 2.7x faster on the Xeon and 2.85x faster
>>> on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s to
>>> 12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.
>>>
>>> Hashing throughput on the Xeon, in MiB/s:
>>>
>>>                                  16KiB    1MiB   vs OpenSSL
>>>    OpenSSL SHA-1 (no detection)   1234    1129      1.00x
>>>    sha1dc/ (today)                 435     450      2.67x
>>>    shani+avx2 (default here)      1002     901      1.24x
>>>    shani+sse2                     1075    1008      1.13x
>>>    portable+avx2                   553     654      1.96x
>>>    portable+sse2                   603     681      1.84x
>>>    portable                        466     565      2.29x
>>>
>>> In other words, currently collision detection costs about 1.5–2.5x on
>>> top of the hashing itself today, but only about 0.2x with the series.
>>
>> Thanks for these numbers.
> 
> It would have been better had I provided the same relative scale (it
> should be 1.5-2.5x vs 1.2x, but whatever, you probably get it. It's
> 20% overhead here vs 50%-150% overhead previously).
> 
>>> [1] https://sam.dev/blog/faster-sha1-collision-detection
>>> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008
>>
>> And the pointers to the original sources.
> 
> CC'ing Sam (sha1dc rust guy) and Sebastian (Gitoxide) on this, just in
> case they have an opinion but I'm pretty sure they would be more than
> happy for this to be integrated.
> 
> Scott

