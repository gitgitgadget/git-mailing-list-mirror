Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB61ABEC7
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735666050; cv=none; b=cux5EMEs8cJs7+PNya49VtWz/7yhreWlqZCDVlcoODmPWpHzAoxHrv4PstkC9DONCz7n+AxI90YCf8rfx4zWXrZeMcchasonKs/z+Wp8KophXHy3aBYJwWFtGKKe+4CbLvxS3Zhx7Z4CmQkfM4DlGH76RgPdNlyw3Ww+4CeWMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735666050; c=relaxed/simple;
	bh=Z+FfzMbHLTnAYQ9JuwSwn7WyUHJfD3RLuvJ9PW2xVto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=decKfvgYNRkrUT/bbUPaG59b6HBUaj+sSQQwrsw5UP2r47V/j/LscieGS3chkIFvtE/CLst9CxSlbRo02F4GeSglKgUkWIMeRHYV3zoReFYC4bJm9FE0DElVFd5zaPz448FZwd9iliI2Wy5Wf2GYudK5RTDwKXo6UqOYqqhp9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=uTfoQgH8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="uTfoQgH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735666036; x=1736270836; i=l.s.r@web.de;
	bh=ORXbtJ/TqnKQwEExUJcHKBfEam+mg2iTJm2gq5MQkBA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uTfoQgH8JLCiwzG9rAXsZqkjP9yYfMsGFO5eomagwIYT/QO8MtCDR69uAqcB6C7U
	 E1EsTLLnWymLxpwpLBTV8lKz1LygCn1x9L4PlOTpt2zIQ6TuCqqg1dx5CQz+1tW/U
	 a/YYxq1BFXJh1lf9idct32guZ8sFcSch/mv6GRluWxtB5n9f6j5+VfGeuA2froCUx
	 rwf50W+u3UCFZJVAPATHfB71mXn4/ggeNH6a0wCnLGKJSDG6A7reyX0lE0tEQsu/0
	 XW/dWtDhhLrQ58xrWRggmlwdROYU3lXHxHhL4U3TnLIklRq+wZl3dCAyZOZc1yOhv
	 ND39cHS3a91nmSIoYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1tzoyq2vNo-00a2FR; Tue, 31
 Dec 2024 18:27:16 +0100
Message-ID: <003619a3-f544-4b20-9685-866fd2ed1ae2@web.de>
Date: Tue, 31 Dec 2024 18:27:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2024, #11; Mon, 30)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpll9xehr.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpll9xehr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZSCyilpX1U367fqtmqq42aqf8V+jSNUfOkyCagfnEvt16PcDVLp
 uxN6NLO9SxssmQJhHkYcZeAOB6FnHcnlyHoButebCzzQakZakcAYfhtsJDpeexkYv4oF7vD
 PkFuYTdldhmnM4yklYEwIJSrloXwkJMxvRDVice9FMy6VXhGIbcI27AQkFyldH7Ps1j9DNC
 xZQx0sSGmJ0wAjTTIWHGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:263knr0Fius=;mvYe4YPPRnMSuqqs6j7mkxVNz+o
 G36KqyGyTjmWCmDU15aikHz5MTaR82z83ChGmFAiZpRSMqopNegLM6YGXX3+X6bA/OQstqQFB
 0/Ko7CFZGO61UbBtl+tZD3G9SUYGiu8ltnLkDt7mcJAzOhZewKn5pB/TEQPqzuEmvFWiUnHS2
 L4YnRo7Kt+ZAjpG0AysOAcn5yiJAn2wDI5zomtOCY1mcYR96QP8hN56ZUEX5kDy8BaoGWYZ5o
 AG+mvEpf5yWQKXge4ojdAW4SFdHzP4AlkHjsyIfpqFOqQ25wq5Y4OJmb5pEdKlSfSmPeXtdLU
 8vZaOgkEu4qOo/yIg3XmZa89k5INW1SuORbZheAXOI82Yk4UIKe98DE/G0bXtVuXAS2CT/3GU
 0kykKmJOgHYea7C1QfX9mzz5ktD4ERgWwBxlz7n+V3QKMKKBU59wjCAxjRkrC3dYRMJNZoXRV
 s6tjxaUsh4qAGaNW4T7tNPtTphClZ/ngTJTPopwklVJMZ1jW9/g/cL2de9Qe2YdEivLYtNAiR
 +hhd4nkqhIo49Wm6STBsnmLKbhOCYAeuDuSAl08h12YBDn2yQNPEE3/tSbk2AR9SBwY0BYpmi
 oKNl6VCz76bKZBl4lWWzrC1Cu0raAOU9VKxNKVXUJPkho8REPsb+ZevRY2gwsEdAExqSGgasV
 z+3aAOYLHHWIwiNbg7gKpM5SWev/p6XnGRyO0gFXK4MZt0AajcWfZEuUUEnDoC+393Qzqqa/f
 KCOyM7CgRZ94LE/HmPDtP3YJtMjgqYeh+eZzG0hM7CTx+2i9FTrCBk+FAn/kAnPauC4Fp35D5
 LmadPtctTFd+rymXmKEh0kFDTQ+Aoe4D1fIT9FUTibipw29V7x8AMOOOCUL1Wb291nJY77Xkz
 FFlot/tE4cABbVUhQk2bqZYyvW6Am9i/ZZYPqXEY57EwU3PHSZ7FHLeBdhUZ4vNce7bLpiU5u
 nTK0PBtlafJgLpPW9W4YTGx5tPYMzCWARAEWRot6Da2Ql+lzHsiZFv7PQo1Xqdbua38sRUKT4
 /jpv4w3gRF5auMFiAa2j2RKWSq8DHL4d0fFlSgsMJJcu3WJAe5B2ei0l0F1ByVuC2I2YiPaWC
 m4kvZRUVU=

Am 30.12.24 um 18:33 schrieb Junio C Hamano:
> * rs/reftable-realloc-errors (2024-12-28) 4 commits
>   (merged to 'next' on 2024-12-30 at ebc9625a4c)
>  + t-reftable-merged: handle realloc errors
>  + reftable: handle realloc error in parse_names()
>  + reftable: fix allocation count on realloc error
>  + reftable: avoid leaks on realloc error
>
>  The custom allocator code in the reftable library did not handle
>  failing realloc() very well, which has been addressed.
>
>  Will merge to 'master'?

Reftable allocation error handling was introduced by bcd5a4059a
(reftable/error: introduce out-of-memory error code, 2024-10-02) after
v2.47.1, and this series improves it, so I'd say yes.  But of course
I'm biased.

>  cf. <Z3JLdIG4C9D2-1ZT@pks.im>
>  source: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>

Ren=C3=A9

