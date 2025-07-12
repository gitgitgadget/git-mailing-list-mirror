Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B192BE6C
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752363255; cv=none; b=KH7+eYeYKfYPLSWRD2u0M8+lbsEAHY6I5xTwsO/QsET+nzu4oKD0mFs3jXFGK5yjPvKLs64aqayZplSAGj23wm54yLf2s/Ggtt6OlaBhELum9hKW3jMWGdtbzJZv1AAWMPN/sWjTTQ1HIyG67EwWRwHVsYMQg/uP5fgkTLt2Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752363255; c=relaxed/simple;
	bh=0cyxM+fGyuKTBeJUJN/Y2DXFrdwHXaTqvndxS9andJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=udynD7Pcd6afTaPHqKoMO7R/LRrZ97nhGw7mSbVKZkNihgx9AFon6XtxQ7aw8FhERjYeWLXS8RW4zmknm00yy4A6N2x/QPXFiE80klg7z49KzpE3Id1XRzUrdYvD6wJ5UPXeGg8t9M0bnygrJC2MzZqoC1pICMhxjOnQIqhmrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=mZNZEzf8; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mZNZEzf8"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id ajgJuKNQsbccrajgLubznO; Sun, 13 Jul 2025 00:31:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752363061; bh=rn+dOJ5cMEI3itlJJVn4KhzJOrjFC6Hw9RsWse+YeoA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=mZNZEzf8BfR4qKQCAbbMli8JKiOeTi8KadIkYPagVkDfjpminwZSJTQ1tty0oUinp
	 Gu0McA+EYn9uLBipvwkTXjP0xj7zccMj7C6ESIvOHccdbRcQgdewr8QXCATOVCqnq9
	 Ci4VKd0EwM+E9rOjbZmJf2QXpadJ0AJwp2uNmrZGMGr/QBvDcbO4n38nPXtX3c2iIn
	 CklLCP6vaNDW5f0/EDUy9EY2U3adDeOgNrMhKK7xTFTZjxkt/vYl/19kh9i8VeCPRo
	 wQgF1Z8SEaaJqZEoJmRoR2LmojWTw562b51StHmgNT03Ee8bebbzSlg414QJOEL5i7
	 oCSYVMJz6IIHw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T54vTOKQ c=1 sm=1 tr=0 ts=6872f035
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Wed4BQyx1IgEMDnwhcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <24c4c6f4-00bb-400f-b315-bbc5e81983cb@ramsayjones.plus.com>
Date: Sun, 13 Jul 2025 00:30:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git 2.50 and 2.50.1 src fails to compile in rhel 6
To: =?UTF-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>,
 git@vger.kernel.org
References: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net>
 <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com>
 <8795721752334860@mail-sendbernar-production-main-77.vla.yp-c.yandex.net>
 <1737451752344703@znolar4klagewshm.sas.yp-c.yandex.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <1737451752344703@znolar4klagewshm.sas.yp-c.yandex.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGenBmiw2VMetUbG5zHxqgsTZkpuuS2KkuKGyKZpBPHvF8Ao6tpuYNp/hNo0s9xqLUpexTrgP3UDb3Rt4JvoCxtow6d3cubUMOTyQ5xGvjyUdpu4aQ5E
 +freYOITeP/9/wtfq7Hxi8uzHJResjEliDO6EKHQ4PW0YWtQHc8gKKKasXwL/Yf4bm0h8tLBppngHiG1jymBnbbwMj1iARi05lk=



On 12/07/2025 19:25, Азат Усманов wrote:
> I was able to apply the patch  sane-ctype.h  make did proceed until it stumbled  again, this time probably related to that path to random.h file I substituted earlier. Any thoughts?
[snip]

Wow, RHEL6! I think the oldest version we support is RHEL8.

[Moving header files from a newer glibc to RHEL6 is a definite no-no - don't
do that!]

Here, your glibc version is too old for getrandom(), so you need to build
with CSPRNG_METHOD= set either in your config.mak or on the make invocation,
something like:

    make CSPRNG_METHOD=

> wrapper.c: In function ‘csprng_bytes’:
> wrapper.c:782:23: warning: implicit declaration of function ‘getrandom’; did you mean ‘srandom’? [-Wimplicit-function-declaration]
>   782 |                 res = getrandom(p, len, 0);
>       |                       ^~~~~~~~~
>       |                       srandom

HTH.

ATB,
Ramsay Jones


