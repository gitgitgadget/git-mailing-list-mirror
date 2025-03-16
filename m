Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11337174EF0
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742162102; cv=none; b=CpcrCgdTnqfsj/FewJiSlY+gi2bLzHB9UDILdo+DioPn5ofI0RC+gZxfxlki0Os0EYomBktfBrBujbOJDEcjEQa/tkE6OWICPA2Dfktyz+9s962BQ6KcuOnHrihe1/9Odn7kiyqlw+5KzXonWXu4GHtPYOZpuFCb5cClnFRjSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742162102; c=relaxed/simple;
	bh=AKZAdG6dyZbz2dLr9A5D+GkncRKAiUEz670vYELHiPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c4M0ZWpPXENCsaeJcdRGH169wcfJQQlZVOxI8h4C9Okqth83MfhKKWl29/6bOOtAO+gPF839ECG7uaJOwopY9mzja9QJwHvEOSs9ofirhLtQt+bfSxsjhZ2Mkja7X+ggRAL3H/s9quIORrw2ZPhmACOcXk+Z8OWMxADvRtAQbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=osDufZyA; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="osDufZyA"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tvtZtzD1OBiaNtvtatb0Z2; Sun, 16 Mar 2025 21:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742161909; bh=IJDukYua2axzzAiLCXke7o8lwU+nwvRVT/6RsDoq91w=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=osDufZyA8OvIhbv7mvcluqKHvrzUhaq8hAA1m4v9MsxQKVhJ1m4onMcdl9MOgD2uE
	 aHkNxfoG66L1uzHyTQdAiz+5fZDXTnDCM0YtxX0JrqFq1pDH3Zk79QjTLolaNjUuyh
	 QW7BX7Bs8824GDcy47MjZq1OQYV/boQDIaS3WysWqxaGLBr8ltQPv98jujvwjkq4OD
	 UkB8SV6K4vVjl0WT1bwpGzP2HiAPMPp8J8X9VVrzgonTDbVj4zUCl9TeXvkpKka4Eg
	 GKgOOwHnp8iF3Y11XAeaPovu/tbT8Wj/G8+DGWC04qkx29O1BoqdR334uJ/CgGmdH8
	 sFjTipXLj0scg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=W8CbVgWk c=1 sm=1 tr=0 ts=67d747f5
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=myXZRyagAAAA:8 a=w_pzkKWiAAAA:8 a=HgY7LeBcWuHF6Z0jSYIA:9
 a=QEXdDO2ut3YA:10 a=GVE3WtEoFoEA:10 a=d1HSLr3dS4cA:10 a=1M-rvJEN9yIA:10
 a=HLzuktEnZYP5j5lAoacw:22 a=sRI3_1zDfAgwuvI8zelB:22
X-AUTH: ramsayjones@:2500
Message-ID: <654de230-07cb-4ffe-bfc4-ca0e1d6d3572@ramsayjones.plus.com>
Date: Sun, 16 Mar 2025 21:51:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, GIT Mailing-list <git@vger.kernel.org>,
 Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPdBquvLGJiLpV/pdt0E/lQSlWL9x5K0P5P4Q6Bj9oFMNUpI5ufcGDj7wLYLZSD9siOrZNJnU8RXAYCWHI92Y0IsMfcWJkv3sByJrQpmlhLpTX3qMcAv
 9lndZnGCc12z0t4VKCNDlWSigv8dP4Bb5XXk5mhqS9dpRPlWYmIpujKIdXotESAi5ph5fpEW9ui0VT2cfF85Rutl2En6pFH0R1c=

Hi Brian,

On 16/03/2025 00:28, brian m. carlson wrote:
> On 2025-03-15 at 02:49:18, Ramsay Jones wrote:
[snip]
>> If the meson build system is used on a newer platform, then they will be
>> configured to use 'arc4random', whereas the make build will currently
>> default to using '/dev/urandom'. Add a note to the config.mak.uname file,
>> in the Linux section, to prompt make users to override CSPRNG_METHOD in
>> the config.mak file, if appropriate.
> 
> arc4random operates differently on Linux than it does on the BSDs, and
> the right choice on Linux is `getrandom`.
> 
> The reason is that on the BSDs, a userspace ChaCha20 which is seeded
> from the kernel is used, along with an integer representing whether it's
> inititalize, and this state is stored in a page that is zeroed on fork,
> so that it automatically becomes uninitialized then (and is hence
> reseeded).  Because it is in userspace, it avoids the overhead of a
> syscall, and is thus usually faster.  arc4random has also been around
> longer than getrandom or getentropy on the BSDs and is widely supported
> there, and so it's generally the right choice (and hence, the default).
> 
> When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
> argued that it was not a secure approach (I disagree), and convinced the
> glibc maintainers to just make it a wrapper around the Linux kernel
> CSPRNG, which it now is.  So there's no actual benefit to calling
> arc4random versus getrandom, and since it's newer and less commonly
> available than getrandom, as well as slightly slower (because of an
> extra function call), getrandom should be preferred.

Ah, OK, thanks! While researching this I was only concerned about when
the functions were available. I didn't give quality/performance a minutes
thought! ;)

[I am aware, of course, that newer doesn't automatically mean better. It
seems I forgot about that here - my bad! :( ]

However, this afternoon, while I was waiting for the 'meson test' on cygwin
to finish, I had a quick look at the implementation(s) on glibc and cygwin.

On cygwin, the arc4random_buf() implementation seems to have been imported
from OpenBSD, and uses a chacha_encrypt_bytes() function call during the
process of creating the random bytes (see newlib/libc/stdlib/arc4random.c
in the cygwin repo [0]). Also, the getrandom() and getentropy() functions
are simple wrappers around an RtlGenRandom() call (see winsup/cygwin/libc/\
getentropy.cc in [0]).

The glibc implementation of arc4random_buf() (see [1]), as you say, is just
a simple wrapper around the Linux 'getrandom syscall'. In addition, we can
also confirm that getrandom() (see [2]) and getentropy() (see [3]) are also
simple wrappers around the 'getrandom syscall'. However, I don't see the
'extra function call' you refer to above. (Yes, all the layers of macros does
obscure things somewhat, but I don't see that extra function call).

What am I missing?

[I haven't actually done any tests for quality/performance, so I am quite
prepared to take your word for it! :) ]

As you say, arc4random() is less available on Linux, so getrandom() makes
for a better default.

Anyway, I guess that means the meson build needs to be modified, since it
currently selects arc4random() on Linux (this is OK on cygwin, see above).

[I was writing an autoconf test for this, which will also need to change!]


[0] git://cygwin.com/git/newlib-cygwin.git
[1] https://codebrowser.dev/glibc/glibc/stdlib/arc4random.c.html
[2] https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/getrandom.c.html
[3] https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/getentropy.c.html

> 
> All Linux distros within our current support window have glibc 2.25 or
> newer (RHEL 8 being the oldest one), so we may want to just default to
> getrandom on Linux.

So, Yes, this patch needs to be dropped.

Thanks!

ATB,
Ramsay Jones



