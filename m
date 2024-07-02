Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178D205E01
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953734; cv=none; b=Lt9ytBfrJ9c4D1bl4VWLoEao+PkaTsMHIasns815QVyVHbbLws84FkeeYra+qtAWapDU6UobGmZIcaWDJEQWfkYii0zFiTfm5Nf8HVZ1dR5i6xDQi1phw7BjIm1Z5Y05BwdJcB8qOrQl2C6giDsK/0V79cKictTgp3YIyJD5SrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953734; c=relaxed/simple;
	bh=92/D5NhAm+eVYL5Iircrh0Xk95uk1PJkvP7MfIlQ5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WVvOwRubdXdQeBarKxs9H9M7YMS/v4WtvbfMPgurGTOpptiqcy1WiE2sYrZRLC/iaZ7YDzYhklzrTvfk3FUXJNLw70AGlwc3UKcQwlHVz/Cne1YLRODuVT1QxiKP8SvnoAOZSkjaqaiEau5NG32BBwG4xQ5yoqC8g+fmTKHf+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DYy4+jES; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DYy4+jES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719953724; x=1720558524; i=l.s.r@web.de;
	bh=92/D5NhAm+eVYL5Iircrh0Xk95uk1PJkvP7MfIlQ5dw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DYy4+jESHksXEuSXzCMJeX7AZqW0j92LxkpQLMkodBTSzqopQNWkFqobrIuWNQ+Z
	 q7M4L1AuL6ed+gR3WyYmAYQWg2XqJpGaFXx0H5YVPJO2pFdjfQyfe14tPVULkGSa4
	 B1TA0Hpzhx4iM6i0D2YmrqGDxrJrWfrA1HoLil7tTbYZ1zhAsiY8bXb4rVAWY/fmI
	 tqLuVRjAhZ3eTANlb9YiYJt84JWrQi3MTaEgHRaeCl/eOyw0YPTHZamyacntSauvR
	 PSB89vE1FoaO3ktNZ+5ANEtRarAcZMN0qFtlBgoSStPki6eFnfYasSP+SoaYj23dn
	 BHQTWGXJERIFIRNR3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1sVuSs1xwg-00DZAH; Tue, 02
 Jul 2024 22:55:24 +0200
Message-ID: <a0fdf91d-ebbd-4391-8076-f2805e083e1f@web.de>
Date: Tue, 2 Jul 2024 22:55:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] t-ctype: use TEST_RUN
To: phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
 Git List <git@vger.kernel.org>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>
 <eh556xjlxipeyumm3gchiiggyogpcuznil5kwvudcpyecj4uxq@uy5tk66blzsl>
 <1a9c7351-68c2-4f2a-b00f-b4c8422ebe08@web.de>
 <eae0ccf4-8747-400c-96ab-b7fc7a51beb9@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <eae0ccf4-8747-400c-96ab-b7fc7a51beb9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WmFHAZmO+aFWgwe/9HyKm0uFsbYCGndP5nqvoGrKTEl/U2cRQGX
 Jg6Ph48c6nYNNqRS/phNf2jaKb3AbAvOA2i21P+zPtgolSeJilVFdk+X6fjqWOdAUwIiVn+
 jWqRc3BKq7rxfj5BJ0ZKG6cQ0Jd7Xf6olvMbxNSbihjsHUKTgBlcT83np3c+J5NdQxSWEIJ
 eGfaeSSVwal4KokjSX8jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gfPmtF9tx84=;2Ronpv5uolkZDZEk8KONym4tRx9
 hOuahRIb37mm8LMl9ZMGDpYznK/hQw90YR4HuRS3p/esD7jmCLozIOXwQWrY/xJZltFDJ82Sq
 RfnOfCPivzwzUMFWOmPZIoroEm5Zf6Gjnm0Si4ex6kC4/3E2THWCpOuCI2J1+tQe5wzrfvyXK
 yZdUX1KRo6ZjYIIieti3hJF6Y3f4bi0HtXscM2BTjIaRBB1jQ2t9jbWS4k+sNzqsSp5pwSRZl
 EW6J72JkoNd2u/2Sgm7qtGDOpdm1l3sTC8IAK2CRsYPtoCFiS9t2tLd6iPgpb+5Xs3k6SDM6+
 gJOYJtmRnpHAVpNRNdlRK1F8BSMjnVUt/SfhKPLVkvF1kvRuyaIBIRVd4xeVzN4gWt6Xoj9MZ
 i26V9JRl/Yp82yseK6EB8o7vTSw8br82CXjLwnMmfb096KZUStbovqZBEtoQ1npzZPdGA04Mo
 ZMbrJJBSYmJ9sdeJXQ9v1/OjhuevAIUdVbmYBr0GugkOoIGfxAMZJak7f1PZYdME5+FnX0O2L
 /5P9oFrfnMcFxLZnQY7a2OBVEmLuXaynSpRWRLBB1rodaPiAyydgPC/T6L1CXElY7rSvgo6A8
 3gAClidePLZO0Uuq4UUBaip8mHTpMHrdEhwfXqmg/IWGnrt8ysxLjd8g29a1bcd+IAdRse+D0
 Sj48CnUhOfps0vUAUwNtS4X6ZECttY3MS4xgAnDofF2VTkvO3zUW0CiKOIbFR73S9lWgPt2Ly
 SIf+0MgQ6abDtCWJCUC+ZvSsu/i/ddSgAxaX0ZQTzQJhDs1GC6RMoOM0/jmbSKecjwqwqZYc3
 0iQKQC/snqOwO9vX+5DpOlm5rN/6ICeymPUfgCaRz3x64=

Am 02.07.24 um 17:14 schrieb phillip.wood123@gmail.com:
> Hi Ren=C3=A9
>
> On 01/07/2024 21:04, Ren=C3=A9 Scharfe wrote:
>> Am 01.07.24 um 21:49 schrieb Josh Steadmon:
>>> On 2024.06.29 17:44, Ren=C3=A9 Scharfe wrote:
>>>> Use the macro TEST_RUN instead of the internal functions
>>>> test__run_begin() and test__run_end().
>>>>
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>
>>> Nitpick: please expand the commit message here as you did for the
>>> following patches.
>>
>> There is not much more to it: Use of internal functions is discouraged,
>> so this patch replaces their calls with the new public feature.=C2=A0 P=
erhaps
>> a "Kinda-requested-by: Phillip Wood <phillip.wood@dunelm.org.uk>" would
>> be appropriate?
>
> Perhaps something like
>
> These tests use the internal functions test__run_begin() and
> test__run_end() which are supposed to be private to the test
> framework. Convert them to use the newly added TEST_RUN() instead.
> would be sufficient?

That works for me.

Ren=C3=A9
