Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388021A08B9
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348021; cv=none; b=O/xRjwbvtLZzbjnFfzHaB3sT4ScfWwOMvSr5+LpMIV3L/eR04YsOd+Z7Rd/6Im2D6DhguTYi62FHCxyON+nOTiQOByX08w4KCGuhbUp6jA//KsFWAhu4sS7Y3sQDG2DM4vfbMsC2bDgB269V5eQ2Ru0mNFX5r/cURwgjvc9HPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348021; c=relaxed/simple;
	bh=uXx0DczLYnke6KqRglsr5xBdO4RPQqBUr3S4aL4JLoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJP0BTGLa25mnZOExd0t530fcaPJSykvGyOEK4kDAVM/8wgfC1OwCQnCr6P0JvlSlcUzjasqjzqB6hgME/76vKvEEMpnAOQZcxmm2RUo7xasl+k/Mf6Kn+XIqatRUGX4FcK45GjMjRwl3pGhbe4nwBpjPsr9LqnBbKMY43mfLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wJ/Yqy1q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wJ/Yqy1q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348001; x=1722952801; i=l.s.r@web.de;
	bh=KzpDg+QIYMSO/bBryTTNU89Xz+G48aIgSrGPNBiaers=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wJ/Yqy1qYDsmu40cl8tuRWZ6+apfHdODedhManKWPlhmq/KgCLLKv3WEbZlpzYxY
	 wwy/BdCeN7X+XhoG10vPiai0WdsOCUj4eGW7lYxHWmv/tvfCRUIbRXcVbkqRKvCYL
	 zMb5CuabTaCpl8mAoyF8FdnGlKnHXSBlw/WexUgVD9gWtcs+rxXahwTNJ+X4hzALv
	 UxvXeKklHSWenLV/YqUNrChKTqxKTeDLupfpq6HMYY2ft3blvAn8Brqd+L08adoOl
	 C+uQb4Y80GHgglzUVwIHI72zRZJgsqjBWqkp92q/ZR8HppqsZOKgBGIL1Q3PdJwT3
	 5UW3xFSemIYJ1ScKNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LsH-1s6n501qo7-011AGi; Tue, 30
 Jul 2024 16:00:01 +0200
Message-ID: <ce00cc56-4671-4ef6-9a43-db13acec3e46@web.de>
Date: Tue, 30 Jul 2024 16:00:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: phillip.wood@dunelm.org.uk, Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <b4cbc8ce-5e39-491d-a6c9-627a7fd97c8f@gmail.com>
 <c7d280d5-6bc8-41c1-ae85-418e20b38a25@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c7d280d5-6bc8-41c1-ae85-418e20b38a25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:suJ04P8CwfcNJ/KJgdfOZuS9nCxQ9TNBGLOzCYl0/H5eCTtE9Kv
 ox4iT4LnmPqLyh2vE3tebjUQguW9UpmHPUj+JI7sebZbUuNy09/SXCAgeGSdgfMyi3PX5h6
 s9ZoY2ePxAYg8kDa+HkTnMH2Lu5bBEPTdfQgQD1V64N4qSV2n9gZcE+/xA4imB3hgTUTdCu
 1haeJTd1gkgKjlIJPY6bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:paqM5bXO2XQ=;nPuGok/8lsuigP0KldzF2IaDGEJ
 91XjNO7H6YTlOQ+/TPoaFhyPtZvG8dxyVuw7HnISZmAUQYswLXbVXrCrYB1pTdQuBgSR+ks8N
 qhHSm7510vggKt2DSnvG209MjIyIqM+DcgEym8JlkSwi2+neroXG1Jn/RBUf0lRxgAzT6D82U
 Geoo8Rpx675KOod8gp2KvAZbzCZmwuEcSttdt1FxkwDWGOb+zvqBI6ILP2I1cQbcYvpBwdlhI
 ABHAQMG7X6thCBNoFf/gJR+eNsStNHMp3VvsNja91XPfd/K8QODC/b83roYkQAidoMGYucYc/
 nkq5GuHL4R4IKltso0KHtD+Zje/zLdisQd9FURq6QMKJRR1tlFKbJJrMbpozv03Y1byOZXZ7q
 chuiisYklWN2JFT4YwoV/TAT8o25DaaCTYG0FFtdXuFIBk13n+8A35n+Xt0G8K7uGKxMKCwI5
 NCs5AAUn20zGBX8wxeQ8Ok2wSdYEnFD5UmzqXOeEbZtrYKSTKm7hO3ZzwT3slDJOiY5K37/Lg
 bucQ5dhAaWhgIhu+2s8XjeSWZLSsp50E6xPssMF8YJ3kFPyV/mU1nrIiBUDHNdMO33Qrb4cLr
 CZCGwgy3Mq6FUKu3J/W0Hnzdu5ys1piL1fWE309145dXrRVvZuPblkkXD2ng7a1QauYRB2Hg1
 e81VQPSVPr0qgve9ltSee+RQRv9RYtgfEZ6ZKRsOc1HWYKui4B/vtfUQeW+H3c7iIuPcJQtwz
 sMZNhYjegFPgcu0nMH08DNOZOG+DDfu+srjgf++I4YhDXDjf2Qk/WEcwVTzfRB4dmXj+4Ocxy
 DptO+UBauYsDqRb8AEnDELqA==

Am 25.07.24 um 11:45 schrieb Phillip Wood:
> On 23/07/2024 14:24, Phillip Wood wrote:
>
>> For example in test-ctype.c where testing the ctype macros leads to
>> a lot of repetition or a giant macro with a function based
>> approach.
>
> Having re-read the history of t/unit-tests/t-ctype.c I don't think
> the repetition in the original version was really that bad. The
> objection to it seems to have been that one had to write the class
> name (for example isalpha()) twice - once when defining the test
> function and again when calling it. I'm not sure that is really worth
> worrying about.

I can't see the purpose of requiring repetition like that.  It's an
unnecessary obstacle, small as it may be.  In the case of t-ctype it was
a regression to the original test helper code.  It's easy to avoid with
existing functions, except that those are off-limits to allow for future
changes.  So it's just a matter of packaging them nicely.

> So overall I'm less convinced that adding something like for_test()
> is necessary and I'm very convinced that calling it for_test() and
> using "continue" to exit a test early is going to confuse
> contributors.

I didn't expect anybody would want to use continue or break in a test,
but that's probably naive.  I got carried away there by the prospect
of a trivial macro-only solution, but alas, it's too clunky.  Two steps
back..

Ren=C3=A9
