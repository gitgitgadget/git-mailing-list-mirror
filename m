Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2ED143747
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535980; cv=none; b=R5EPGTDbyJjKWrU6pN5oCw8hLGdJp5k8jQduVnGjAEodNMaIodX8rHswC/CCnt2YWmUNGM6mLTAQpIkC09H/hPpAS8UVbL0tXix4qTB4pQK1yyWpWMn3/RoXFaBNU8h1jAL4tDwm8aU69arETCxXs0exWYACQVOrG6yu9NitTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535980; c=relaxed/simple;
	bh=xZ6ayqCxWBxLO8Q1lpmiQmkZ/d/bSNV8rGwO9++IGhs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iXZBEToPy6OV8K9o78J8lKNJ61jyv4IYv2pSGmCtbhfJntPcAqB6cgx39MHcJsWEyEe+Gvc+j21K3/DPUOEMtc2JZO67nhQ2SzxWZhf6h11oY8lsxWsLVXKuOOXxVOvsfSyZicM7BC/DH13wKcwwH0aI26ETEK9flq4pbDFcaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RVnlM99y; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RVnlM99y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722535953; x=1723140753; i=l.s.r@web.de;
	bh=xZ6ayqCxWBxLO8Q1lpmiQmkZ/d/bSNV8rGwO9++IGhs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RVnlM99yd5VgwTNzuxErz6kphrHfvGjBMYU+oEjBbqq6/GpMUgf/OSTjIU0rFniA
	 A+11yS76FQgPMKfW7U8iFCKuuc6dDnZYRFHC1yHDxJAUjhHCnGiJzSi5eKLhdktjd
	 n1zGNcaPZG9YyvjS2igiDlpu/UTUGuDAGh5Ii2SoCzteBxWKIyuhxquhyKhaEW1lv
	 Dw1+xJ0+5K2vwZBJR0GQuG1bowX10cOvtOpGgNpq9ClNmySeU0yUD0Z5KnLC4fLpg
	 tW9p8H2zVZR2+PvrNdpP9drEZl13TNucPWummW2AbrQpU1M0aQOFiQXcaNZ2wpSoc
	 xYEy6DqLigtva9Ojbw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.155.134]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sc1-1sZrny15CJ-0097aR; Thu, 01
 Aug 2024 20:12:33 +0200
Message-ID: <3e31de95-dab7-4552-9a39-1266879a1f86@web.de>
Date: Thu, 1 Aug 2024 20:12:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework (better
 one)
To: rsbecker@nexbridge.com, 'Patrick Steinhardt' <ps@pks.im>
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
 'Junio C Hamano' <gitster@pobox.com>, 'Kyle Lippincott'
 <spectral@google.com>, 'Phillip Wood' <phillip.wood@dunelm.org.uk>
References: <00a801dae384$de2780d0$9a768270$@nexbridge.com>
 <ZqtWDtqkXzjz2A8u@tanuki> <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
 <024601dae411$faab2cb0$f0018610$@nexbridge.com> <ZquPfiAWgYjIPGRB@tanuki>
 <025f01dae419$636bb790$2a4326b0$@nexbridge.com> <ZquSkkR_aw2IUdX2@ncase>
 <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com> <ZquT0B-UXy73x6QI@ncase>
 <028501dae41b$c277ec20$4767c460$@nexbridge.com> <ZqufLYWnj75VeDXB@ncase>
 <02cf01dae43a$61e95a50$25bc0ef0$@nexbridge.com>
In-Reply-To: <02cf01dae43a$61e95a50$25bc0ef0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YIKmePfye9PADsc3lq1ovYX4w1yEedeUS1bVEJiZJHr8S6BCeUb
 9D9nYvmuCun1a5HfFGA5yxioySoHCpvFdqkjGjMZCYWzgtVn4chqROtKHi9cD6Yc0vPqSnf
 jij2Sqquq3IUqK5uLLyOVxg6JNarzgMGI+u3aspUwD+aYIulHtaBLQpYFRksyP7+gTBtH1S
 4T35MUrhStH3rvfkWfGnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:34wxVr57gNU=;xzpOSuCoHojW2+obB5ZYAoVAnmq
 lRr+iFcod5fh06eLZklBo9MQIAIKFkMb/Jx555SdJ/Tx+lwMUkTGovN/550ahrG9NzwS/XUrY
 f341cjCi7WScWbVfZlML3VzGrzqXtpQb3TKMev2dxHITpjxvbcY8zX9WDG6SjiYYj+mxaHsER
 9wLAbk/9jWp8fwqbmb/lb0B3CL0QsH4VugmRr86EOL/p4rsU4ntlBLoUqXibMKw+ml+9cDBCu
 vjF2TUlh4cVaPWJQ+O+zq2RhSsN9L5H9P45hRX+SlvDgz7PW4DLGh96ZqxByi/9nMMKw8Wkfs
 a2mvfqExq3YE6Ufe5JtzNIvZ6TlsIjl7pBT+F5T2pfsTa6IXR55ybMyY9OtMYvvx5MeESKCDQ
 auBD+sByi7PmVh4gu/mZ00AFonxnpPw0w8vLtdFKQVqHUc6aT9+0SCI75aZnexOyLtzkgwKpx
 +Wcae7vYVQXL1ZnDe+SrKNVZtfG0nU5bbjddllDpWHVxQWUnK9faETQGAy/0n/TqjBXeM2QQA
 zhiwUuqtceOzs8QTQeUZXPkHkjGwsz/Tpj6SBWDw4DCLkWNcyg2qJHhDvORwcQ1dUt0nNltY6
 jMdVTFCAe0ZRMX6kWWU4vW66VuhtGzyLU/xDX0SrSRmxjBbsSCFpyTAXxlYO+Zvi999qayOZU
 3zfeVHLbDoZR+TBEHxyPHkcGHBUsmHlWPUL60Gu4OwD8333oBVjmg9UBqrpujzEoWeg3prYh0
 ppSbrjH/FcqYk6H1tExIl4QMJGaz5hOiGGmWBODjtTtlZVuiYUJmxSiB52kq3wSKbd/9cs/LX
 kC+oqdSHrYKFV3HlCveQOvgQ==

Am 01.08.24 um 19:43 schrieb rsbecker@nexbridge.com:
>
> I'm running the full test now and may report more or success.

"make unit-tests" would suffice.

Ren=C3=A9
