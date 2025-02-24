Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB162571D9
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406607; cv=none; b=m0MUYaiaUcVF6oQ2qoIIPTIE3ACjfhWOgVI6pMtgK8DNpAElTcS/kpqKX/bZ1OXrR9oMX9+TJQEFZROxlqoxLN8bs1aaG4QthSMIl4NmUZ7CzXKVp1JnDyIBhMIceP0rG18mb41jymg2nEJ3G57F/Yw8bDvsGSaJ6nUO/Oo5sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406607; c=relaxed/simple;
	bh=CjHujqEkSB0MWXS834xG2phmeSFgUpilRSNsCCXZDb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMI6UX2/DoFaCoeVg9Vb/PQXupYuPNAplbvd7wxLGO/E40ZpoG8kP1PqZZWqY9WhRoL7LsWC/1fXMa8zgL4PkBSNGcHzHYE5gvTs/YhhlD+ToI3EQQXyPg4QTAtvze7X3AovHijXssNTnAYrBXhadXzcidahZK4dlXisJy7wEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.178.87] ([91.64.142.246]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MacjC-1tBqVw3JQA-00izJq; Mon, 24 Feb 2025 15:11:26 +0100
Message-ID: <5f312413-0b7d-4bcb-b180-57857afa3898@anselmschueler.com>
Date: Mon, 24 Feb 2025 15:11:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible bug: Empty magic word list in pathspec is handled
 differently in short vs. long form
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
 <xmqqr03tg8q1.fsf@gitster.g>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
In-Reply-To: <xmqqr03tg8q1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MPD+arrBKWDab4mbiVZRY3/fhdni9T17JK6KbDj68Kd5jBFyT3n
 0JT78uvvc8tcHl2CYoAzpr1i4UXnc0BrquFXZER6qdHZmVml9belQHClRYdC/NDC0yd0dub
 vPaJg/b0bvDmwIqW1zClt6WKvmcof0m8iNO9mGIzAZmeFDJjwY8tE2a1+gv9dBZmKbS+VR3
 XQWLtqOqId/3sxf7BLCXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3kPyH8qOxlo=;w+jo/6t15sDjnxwjq1QrT3Drzbw
 roA1TAPe+P+wF889/Codi0Qq7yJZZsxLvuzBt+G4Ly6hzv3qEa9pCEv23TmiGAVh8O/5SeIJB
 JKrvPwwsVY150hQPGbR7tjMqp4qVLhfIR84Wi4s1ArpoIBmo0UQDiXtTWbzcDYEWY4YNCd5D2
 dQIlq0bzutznYYXpnPT7b+99nig5FYxbzzMdGVbi3HsmvWqQbuycilYemDuYg59BW7losf8T3
 XPs5uyFWMOfDyn4Jm7dyh2/ERh0rRYTjyUbqq2L7C004iWUbTXMT4QxZyrA305GBSY5jbJ5i9
 +St9eBxcEAmcBKBLIqSzRi813JqalP7k2ySL9D0KO38Cey9C0Zhaq6hlQex+YyMONVkhuGfR0
 xOq3Fv8C298wlIs2rXgn3aN0zXaz5auuo8ze1UreSbcaIH68Ag2mEQyPr0T3/YQiuUKA8vsHA
 zQq8tpE+Ou3hisYaR18O3j7ClmfAFB+UvnXjLcP+DWwTNETqGPCXvbleiFYDcrJKNeZiczYQr
 05b2EfGul7sjE90pvFb5D+lmh+uE1pQt50l3HKorbNqZHxJJ7h6w8LzWCdgEzaxLwjlHThZxJ
 +zqD4zjZXPrZjK/lJn/li5rLd33xlaVNGh69n9E7MSFlH4iEoXISJl4E1DyJeYWoHzp6relFa
 t6L0JSryLEblkWzm6wEn4sZGQf3u5ZjWl2LuOE4BEntBCbwK1ATkf74ZpeUow7CxNe6yS52pr
 zbT9Cp09whDhptekQPXFqYPQVcqOAwAPJSIvcSGeH8PYUbUI5NYSjg+YM9HkpGzoo/I1ij/E1
 9H4FAvfmqj5ysIk9Dptea67ilKBzGl6gNgu82C2IzFbVx7RZlmlvWq6Fu0uuDqwQbVSQ/xg+X
 oOlXYetNXLn6J8CXN9/650zCEWSMILSmBnSSnv7OBoRnNJ9G/1VVa1/swQZFyvko+iIdeBRSN
 hoHzAyJPnZQCBio+vOUnQrfuJYQHtph4fD0ueukkxLU7Xdp0H3tIBl8M4dhWtU/IiRUTIeihI
 f35Lb9lMNg74wSlh4RHN3clT9UvtMRMuax65ycCJpAAQhFeJpCik6xXJZOSZorxuW5Sv1Fh9R
 U028tg5exktTEKTKF9OApECxug/AhsFHI4obFIsQ9xlgkEszME9m+NnLkWJw/vBsYznQH2yh+
 BxdNZIw8/ww5jHljX6zQiv96kTV3wwgD0sSrnGlE/GX+fqy39Bi4+2MrA59Vpf138fgsqOISH
 GfXAmhjyv0UggmXOZZK+jAaeFDJeouN2GnK6Kmh1qz++4GIj0LnoDEsyCsbuT/G88WtFTJjbf
 dQibEzwJLpWjwvwtL8EptJq1hBFp13gZPG3ikjjYgwEQV3KORGfxocINFaPbmqrMt7k9gFioC
 AvUv/y3egDJp+Fcw==

Thank you and Lucas Oshiro <lucasseikioshiro@gmail.com> for the 
clarification

On 19/02/2025 18:11, Junio C Hamano wrote:
> Anselm Schüler <mail@anselmschueler.com> writes:
>
>> ﻿If you run git diff for a pathspec with an empty magic word/symbol
>> list in short form (prefixed by ::) and in long form (prefixed by
>> :():), you get different results.
> The short form is prefixed by a ":" and optionally ends by a ":",
> but the optional termination may not be required when there is no
> ambiguity (e.g. ":/!path" is "from the top, not matching "path", as
> "p" cannot be a magic signature; ":/:!path" is "from the top,
> matching "!path", as the set of magic signatures ends with the
> second disambiguating colon).
>
> The long form is prefixed by a ":(" and ends by a ")".
>
>
>> Here’s an example use of git that illustrates this:
>>
>> ~☭ mkdir gittest
>> ~☭ y gittest/
>> ~/gittest☭ git init
>> Initialized empty Git repository in /home/anselmschueler/gittest/.git/
>> ~/gittest (b0)☭ uuidgen >file
>> ~/gittest (b0)☭ git add file && git commit -m "$(read)"
>> read> initial commit
>> [b0 (root-commit) cd3bd43] initial commit
>>   1 file changed, 1 insertion(+)
>>   create mode 100644 file
>> ~/gittest (b0)☭ uuidgen >file
>> ~/gittest (b0)☭ git diff -- "::file"
>>
>> file
>> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
>>
>> ───┐
>> 1: │
>> ───┘
>> 66d18ffa-1128-42a5-8d4e-f9d75eb86b92
>> 9acea2b5-50a6-4f87-ae1a-64019a93e55e
>> ~/gittest (b0)☭ git diff -- ":():file"
>> ~/gittest (b0)☭
> Doesn't ":():file" ask for a match for the pattern ":file", with a
> leading colon?
