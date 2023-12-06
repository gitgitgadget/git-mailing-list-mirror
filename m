Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nededfAj"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD29D47
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701883765; x=1702488565; i=l.s.r@web.de;
	bh=jJ0veS2FBB3WviA2mU9l35Xn/Wn2szTqFnGOxph8B08=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nededfAj3jehd3EQ82Tvt9LwakRHR/NyvrfDwA1cloKOdmYdc1/8QvOJ9U5TXi0K
	 OQJI4N652TLfe+Nfua4l5M8YttZ9fpAZxor4dU26gyogiEw+IX8NAlo/KByfcaWHa
	 DMGv9lvxOUnNNY/QR0weMXEc+gG0alaq/Nsw6kj8zpHstQxbA0fJ678Ok8mKMz9a2
	 g8sZUI7jn9W2oOLjY/Zbz8AE+L4jAMb84CakTEMbAgsrw94bAl8UJCsQyts4VohCw
	 nKyhL+a++2BD6z10IRIbDArFYXSnLfScANDxv+6pgZF/GFx0swiWTzaEgueHGcDT8
	 w5zodM476jklKDHOMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1rYgvi0hfT-00o55t; Wed, 06
 Dec 2023 18:29:25 +0100
Message-ID: <1a165940-56eb-4cc9-b570-e870c2ad97a2@web.de>
Date: Wed, 6 Dec 2023 18:29:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] revision: use die_for_incompatible_opt3() for
 --graph/--reverse/--walk-reflogs
Content-Language: en-US
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-4-l.s.r@web.de>
 <CAPig+cQBKk4PpCjT1RN+puS5vSo8_jZ3wONAgGhRvduw3jZT8A@mail.gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cQBKk4PpCjT1RN+puS5vSo8_jZ3wONAgGhRvduw3jZT8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AcYtb1yo/+2nEZuAR3xlhimvhsWG4ioKUzCRNHxhKIeLzVAz3mw
 CCMgKVhWwkZ3acOLEgqpuD8JmCOzkzyGJlonJlQE7AvG6cCo6FgDY66f2EOOHLf7ZDd1FPx
 HxqUNLzJJGn62JGRyP7NoPx0TdVuhOJ3c+p6WM7Od37WX1l5UbSGI90SwYNhF0+bSdTIIiL
 qu7knRiCF2VAdONtYa4SA==
UI-OutboundReport: notjunk:1;M01:P0:XYTEytywJwk=;GyTXMvPr/nnG5va0i/vTbaPp5be
 BgsYKOIuFu1x1X981FXQbTn0AtzxXCTEWw9d4DZKLfI8ZXACqt+6oGVtCcHdoU7MoxNXCBVDC
 FeTrnqizijO4Ky8Lda9K1e37igdsu6Cjsx8GytxD9vi3bBZJBNcUPvLRI11Bx4pMvs7sUe+dQ
 gzlywcI7QaM75oT/6EPXBUz+R8xzL8yGNMKIwrqwTfg/X86+ZrOqHbujrmV6+JFv90Taoc1ug
 Xto4JM6B9/Y1zinWSr8Q5AeaYMd0Hl3EemKIa+7Csv/aM8dh3kx5a5rqAUsiTdGIA6/cZzBLN
 NvLEeyoS7a/aMRxQUMygwNS/SGHdp/qVF/nJcjhMApzHVlibT/if+hB0G6R0xs1wImjh4ugt1
 yC00QNFt6/E7LFUWyoF4PuErnYN4306uF1+WWqgsO7TWIqm8OugklNsd1y0bGvJdeekO7pyaN
 fMa8l7YnMHu8uPVvLw4DvYql5y0MZUjhBrHUkXalAEzVCW6sHdwsvx/4KsEheaTt0bLi2VZEA
 q4xsI5lOAynpp6u3/riU7vsHj5tHkHnTOX3YbbVqaYK6inpTDuJZ22u70PUIcp2Ow/58M2F+m
 yq4RUqUIa8N5PFWUImPBPlii1kzVSgvjfebDD4CIUqPjTs+VWPvq7joveSMLt/0HtGYxxEhYo
 TsmUuspxmX8sV09TzKtqp/Kum+NymJ4Md/Mn/fg15LpyJqFZpRGJ8rxxN44EFQySbGo6VtIU0
 pi+UrKD4xPCllvSaMHsWiPZjG35J5/dHj8gdcAhTNlNP5J22pJZTwNBCMoeTC8B8wc9iRXRSC
 QhCAScTLzqkRpNz7GrQVrYFO1FLDintqz8dNQ/LUa6ReWKUjj6ScDuBrm/0Y4v2eCPndXP5C7
 3KlDaOGUsJ0QR7c7xtJiAzsy2gktSuqoH5wuT0nUtx3zhxo1X2JvPDanhAn58ayrpUoUK4Wrh
 7LSmMA==

Am 06.12.23 um 18:21 schrieb Eric Sunshine:
> On Wed, Dec 6, 2023 at 6:53=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>> The revision options --reverse is incompatibel with --walk-reflogs and
>
> s/incompatibel/incompatible/

And s/options/option/, *sigh*.

>
>> --graph is incompatible with both --reverse and --walk-reflogs.  So the=
y
>> are all incompatible with each other.
>>
>> Use the function for checking three mutually incompatible options,
>> die_for_incompatible_opt3(), to perform this check in one place and
>> without repetition.  This is shorter and clearer.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
