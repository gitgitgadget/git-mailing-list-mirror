Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782214D2AB
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738273; cv=none; b=hKrd2aDtWj79uLkPe8mlCTfVBsWgr+nr9WyzrPp6daJnURsLl1gt1zj6pWQGPrBUcD7wmj5y1aZ4OiRzL6PC5mEPGW7lHGgKEYvpJIRqkGqKn3K6RGLu0HZzyTpE8N+UZBe8wGohbJxzVvJ+VMjV+eaRXmuhHhlKSMvWTd+hq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738273; c=relaxed/simple;
	bh=GOS0HYk/3EiL8ue2aQlGES4UPnwLPWQAVJl+mW966lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy7EeAAHOzcrapf/gNGrFLV4XuZKOHh4zMT+qyMkwEyASOT68De5j0ZMqgUW2NzoskWMwL1I2ymjq8BGZQQINocloel8Qy2odvRh1/hlm7VTudik+PSDPXbWKbVHSCESqExirbh3mOwGhsV/U4p8sm49acO5IRUVlFbIZl3wmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZZZ0fDVi; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZZZ0fDVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721738256; x=1722343056; i=l.s.r@web.de;
	bh=DggLYDOzkNzYojyXuAvkGIP7INCo/XxicW1GmVk8t6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZZZ0fDViKQh4c06GZ9W9Dj3+a3nWt7KM6zXiBl9/KLr7ielWUUvsPtvgjqLLwHnm
	 R5wzyOmxY7hKQ1g6huDO99UlUKqOBTvgwea0WM2QgtI8mJruKXcP/HTMGhlv6o8gx
	 /vA6qFLvAqHggrtf5qrMrg0WVoa3uQv1PAcdFjS9NvP6lMsf/W3czwo3ck2njaY4u
	 ajbc3y9CCOCGUltvF/Xf+yfBVaWwtfYt03EhMNkmF1DFKp0M3MRXb5pNVn7QeDFjh
	 MIVbagaQ/GDZTQbM6e05LSndCERvecu3DXkCwummtycWOSSksa1x1507T0Q97D203
	 5aU2eRb7z64k0RO5xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1s4qW31UHL-00lmVc; Tue, 23
 Jul 2024 14:37:36 +0200
Message-ID: <0af06e8e-e1d7-4cf6-b968-5dad5f4fef2e@web.de>
Date: Tue, 23 Jul 2024 14:37:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>, Git List <git@vger.kernel.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <Zp9PfdZtWJBp2xgl@tanuki>
 <71aa553e-9b10-4bc7-9c7d-5414691db79a@web.de> <Zp99icyrc0rdxg9a@tanuki>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Zp99icyrc0rdxg9a@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YLKX5lgn+Zq548BEzqPuPZ72rAPVa0+TMT3tSB8PunsnTnDebI7
 8JXNsX8R5TnRdYsO5jtyZ6/E3x101czC+mCmw0J7wY6tuL3JXbDWGSKfd72XDLheJQUIQpm
 3CWnRIxvoul0NGTrDai8TTl+jXZj5CpeQwsHDQS3+HzqRQPxP+WLwuSixkTGTTwX0d1v2np
 JBUu3qGWwszL+I8Z2iiNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+1lxiX6xy4=;9X253lQkkaV9XttPvLty5eLIOpW
 VBI/16OqdE4lBXYvSBKWk3xBED2Bk/6ogpprjRv6DTQe3gortyiFLkBVKP6w2VUn5P4gKZgEt
 SgTKFsnX57/lJJ+N4T1h9esnZxCFhNzRIpoB0d73idQimI7ANb4vwXdEMIYH7OKuaaPLM+72f
 MBQcMotuHVcUbpEcl4FuAghrfJ98cEPMXf4omy8pcYx5lv9PLumAEH+ipAHjNm501ds5Vm0XY
 /LqHdhju31Ot8PhJtVTUQ4nCebWJ/YpnJnKm4eUmgF8RGcWlXm6GN4/KOngjEMwJP3nfzLC9Q
 9ilCGeGTMy8VGzFxRSu/6JZBJ6Shkry1cWbhpGBTRj8ILxPYPSqV2brGaAyTN0pXi+Yl801Rq
 YwRs07T4c3J7GoLYiEAMYpheQ7lYi5I4lADQG/mFzaWwkEwlfsII6N6hukIXkpTbPsZteqDlI
 1nmxeViuDm/QzgkH4Itmb6VuL/I1vIGkyUvescldO6BZ+n+HIfBinuDZOHhl9roX3qIjBnt0c
 y4l0f5oYau7ZJcPckcFkmgpX+0gPlaPrM245Kws/p6shWTpPRiFigQJd8kUU3zy/qguczdVs1
 n8GSazscO8YmXLkjP9M4tPe0AXmrMwbjDczKtHNQynGco1K+1jS/x2aUOgp/Mo4uKV86/fBH7
 6PefqPtsjyjODd9iNwZskA+5iiwmfChWcD4GomXkoSa+lM4xnQvdCXlfOm83Tkui8gwQcFHPe
 bGCHQ7EF2Iv+DO6m/GwM7z2aZPO0HKZawVEaWKnrV7TtTf+kaIwsXTXe6xIPiPdopzEcTbl4Y
 EN9q1sflFHJwjEXhOLiVrq8w==

Am 23.07.24 um 11:53 schrieb Patrick Steinhardt:
> On Tue, Jul 23, 2024 at 11:25:29AM +0200, Ren=C3=A9 Scharfe wrote:
>> Am 23.07.24 um 08:36 schrieb Patrick Steinhardt:
>>> There is of course some magic involved with how we generate the file.
>>
>> It requires magic function names and generates code using a different
>> language, while for_test is a just single new control flow keyword,
>> like the dozen or so we already have.  So the magic employed by the
>> libgit2 system is both broader and deeper.
>
> It is broader, that's certainly true. But it feels more self-contained,
> less fragile and easier to read to me compared to macros.

In which ways can for_test break?

>>> But I think that would be quite manageable, and ultimately all that th=
e
>>> developer would need to care about is writing a `test_foo_something()`
>>> function. Everything else would be handled by our infra.
>>
>> With for_test all the developer has to do is write a test with a
>> description, no extra infrastructure beyond the existing unit test
>> framework needed.
>
> True, but it feels like it is an invitation for writing unidiomatic
> code to me. Unidiomatic in this context to me mostly means code that is
> not self-contained and thus cannot be run standalone.

Partly this is intentional -- I want to do something that the current
idiom (the TEST macro) doesn't allow.

It's possible that reducing friction will cause more sloppy tests to
be created.  I hope that the bad parts will stand out more when
there's less boilerplate code.

Ren=C3=A9
