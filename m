Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BC201253
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953730; cv=none; b=bdnQ333QM4cyHoTIoojJNYavK9ZZJWlytmDU1IfS3j8c2OhlEZk+qS+xiTj9xs7VxG6NmGGC29lDIjelsnkhh3RW/vMNVm1f/ERkW9IKs3m1+Hwdv+ne/nqj1SysnG0kB9NfjWuvnPadQ62LLDckblntUgCnqOCtw1N86F+/TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953730; c=relaxed/simple;
	bh=AEVON5SdaCJ4vCkHt/m0mSkPfO4gkuWSD0IANdRbKMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWvISuRIXUoYF3gxS31Ua5WCIQa5hJkgJ6UfJ3ephSSZ4QZ/It0PvQB8kJS+YiPs/mWyU87fPtPqKfa8eMseXVAPi6lrMSQTIiZ/uFdETfA1YnJzscOon8TlgcgO80v8ZqIUJ1sHGJaYL/16f++GgIGP2bbM56kG9fXwzMs/yD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Cfb4kzFB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Cfb4kzFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953712; x=1720558512; i=l.s.r@web.de;
	bh=Pe9529MGsjECTiYB7/H+ke+tZ8HNu1oEa3RqIhUjEkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Cfb4kzFBgRLR7gYMaSHv/riWIQFRcxXxEiTnjpHOIFSc9ck9kwy0Y1JuY8KVM6QK
	 yECEGYjlgC9IssxHd6iHlqk8pEpytO8QK6N4UE/SoX0g9UwObZ1v8QTO4eBQBeNQ6
	 56hDj19LStod4VFTUZeoWXD2wDe8k7vLbxv6TD8vnkhh3Wq6C7qT+pI76yOitZcN0
	 NNIoz1Un6fI4Sr62+CMMErfNZ87+vvpCva4EVd0THb4jygXiZVvx+BqjtLtR5iF3Y
	 SdmbkgScR8Ntt1jSq3IAWQss3vFA33s9XEZfv/Kl4n7DpCfgWSJSn5C42UlZLa8Ez
	 T6oJF4pw0WhRLLY4vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1sFz8Z3a5o-00u0PD; Tue, 02
 Jul 2024 22:55:11 +0200
Message-ID: <332f0418-98eb-4254-b714-cde461f6852d@web.de>
Date: Tue, 2 Jul 2024 22:55:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com> <xmqqle2jssfs.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqle2jssfs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9EZMh4bcI3dmJgmGEOcbfDIe6w0P86o3uO2SwHcJ52iMipq1nNz
 KGJ2QZcQyFpYW8F/5Nrh36iRwNsYptT7N020qDEJtM2HMu1bDHi3miJOpQL70k8rmF/7L+z
 mg0WWsWrxyqOqM4qXe0z13k3aLubQmUiwYUfj4xcn/nM77c5sIXsBqAbCJdwUgED/xMb59G
 Am1Swt0aIzogSvcuWGGXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tuFMXow/hgw=;V1hST9obNS4krh8tWSxAHRaIXP5
 O+L8BLCwkLmc7q7wDWidxhajIlkbcHn/9i7FFVi1u4yIeTgzNOt4PUxm8oMHxbLK+KhEFiFbI
 F9TpFjbQyHudjiONKTWZs6LWHKzxiixRY6AQZ7m51EmlGBQLuS6RyaVsqHklN2UbFGTWlbbf7
 pEIGwC+qa9G/0JaplnA/I/RIQvi+cCvfH4M5WIzfJh4g/Vo+PIJd5l923z5Bb2ME6TndfNJUX
 EYVF9CZUXcNIyNks2Jircv6DNnHWJWu6jLlNT3LmbBR4126Jm15Hw0Vjx+kbPRYN5HGEprBuK
 sZ5s+LOXlIKp50SoPoHpFgAbaXXJYepTQbtDk5TVcq03CqbviDcH4kva2EdbWyE2fP9TV6Axz
 zv+KqQTZ19Al4PhqPDVA8v+2rO7SgYEhtS7XJMcnudpAEiSR53EA9vmVynFvrNsrI5K/YMHkn
 VqT0WTvZxGM5IzTjhFv4ulGyAMJ2XalqXm8vp507BwXQnPpy3Y1YYx4KPxkir25iLCf7Iuc1y
 e7ns6JLaP1OSCWFqoOup3UasObLxhPGeJDK6m3WQ5RcVJOmoZm2PqKdJqVkfpj6fxkfKN7oSz
 iUaw6c8hTE867bRushEuun4H5I9IYZosJvxSatsNuclAjvRHc9fSQCm4SZAZgg03vUXm3+LCj
 t0M05pzam9g94qvPdDmNAVJqDfX3IqMQNW4khMBexQrY/lWi96TtPidQCTm0pvsQfqkNogryb
 eJP95hpm6XMSzWp6WOfJCnAJG7zKMwOrKIGhqH9SMRBju3QzKCUZ9fHCkmsfeMMSrsmbuwH9s
 pibgaCedD5rMiWHaAhgNpdSglC2DIuRvHQvrJP18gsjYw=

Am 02.07.24 um 17:51 schrieb Junio C Hamano:
> phillip.wood123@gmail.com writes:
>
>>> @@ -156,6 +163,7 @@ extern union test__tmp test__tmp[2];
>>>   int test__run_begin(void);
>>>   __attribute__((format (printf, 3, 4)))
>>>   int test__run_end(int, const char *, const char *, ...);
>>
>> We should add
>>
>>     __attribute__((format (printf, 2, 3), warn_unused_result))
>>
>> here to catch any errors in the format string / arguments and to warn
>> if TEST_RUN() isn't wrapped in an if() statement.
>
> Nice.  Especially the "unused" check is valuable.

This confused me for a moment.  I assume you both mean the new function
test__run, whose addition was cut from the citation:

   +int test__run(const char *location, const char *format, ...);

For that one the numbers make sense and the idea is good. :)

Ren=C3=A9
