Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF26330B30
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764476; cv=none; b=ec35h6h7n7nfjzSnmqMeioW5ZG5bOODEYfX0Lgw1v6nESrCnB/f2kFFJJ7PWC/ogCJZZxnESprzjUwS7aEdzUUYkwGKYlyjv6Nh+MkAyUf+3BrLbcKOS/qlRUy+19oPWbFZ2GBHq8XLWmrxGhiZZw71IeNGygiMzMBtvTJdhhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764476; c=relaxed/simple;
	bh=WiUEc6wxD5ZqI0qdw0sh0povxFZjwL8OVkN/JB/dXFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=be+bWJpdqNu6bXaj0mR2dK7gLseeW3182GOoCen9pp0rAYT2p0PVe998SP6YX3EUTie/eaQazNksAt/XpviGP67kfsY/o7+toDzrbg3nIu8q7LIl7bEzL5xyadyV5xNwi5AUHHuO8oC7SY0ed5tEWzHOz9iBzlKKhQ7DLPM2Iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hiTXCFlX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hiTXCFlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775764470; x=1776369270; i=l.s.r@web.de;
	bh=ZXp9fCDXwGUAEdmI39AwnnDysxXPP1LgfUGc91x8BAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hiTXCFlXU2XghgG9+x9RxLiReThOTw+LcbOzisDQSfKR0SVElF9P9ovELcA79Fuy
	 XgOVU/QqtVOnW06Pl8K/onZTzlbVT1pwijzSl03O3+CTXZN5a8f8jeUipRZq0UQsP
	 EQ7Dsp5e18YWuieI4EvjNwvEzlMS4Ag5sfDbDzuMcM73iYr7n7pWoPFU1qjqjullj
	 1O4srR6dEPyfucmMTA/BSEXBQbjvdgPi9+4gimtOmEz9U/vDYgn5QNVcEWQqekR5V
	 ZrWSv5BKz68D5w7p6SpG2kmGkdxJB3lT2cBbYKt7Q+Xwbk32jRPoNtniSmHYiOG0g
	 8QUyqOrI9tWr7Gj2Fw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1vUoux47j4-00zaFH; Thu, 09
 Apr 2026 21:54:30 +0200
Message-ID: <1c0e5ba9-9623-4e7f-b4e7-f7e3343ad94e@web.de>
Date: Thu, 9 Apr 2026 21:54:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Apr 2026, #01)
To: Junio C Hamano <gitster@pobox.com>
References: <xmqqikaatfhp.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqikaatfhp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oHDUuMGGWBiqTYoCpkAu7SzkZMMPRW3Y2S0Z7gzuWxSt/TLJ/Nt
 JXtc/qPw/2OAFGi4eofLe2WtFX4OaVSJcaiKvt36K0wbj1EzEKLtmAM+RQZj1cAfQp1/r83
 AmYDe4Tqh/jEYATGJoq5fz9UKjCDeVoLtYDH8PxDEncJooh2rYcSjD3eL2xqIXXAq4L2U6T
 rZuckPpMlltwQ9hQCd2xg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CJNpmR3yMXs=;bA4LowQIfUM/JEVwPmmrLm2Lb9w
 QW0IfwUfyFpVQ6bkX1ogo9KGuvVXlMOT533+b+aqCe1xah8cI8PWjBAcTF6YmGJtPvIiWKCS8
 dUlveeiuCioH9eoxUWnnF+u5N84A6IwqudPkMKSQJlTrnyGqy1YlbE/HfIIeqLgUQZPNVi0Vi
 jrn4chY9oXzP0XQkr7Uie+U9mx3Hs5p/ApywkBtk5OYD5cQjhSNAUiMk7s7QrBOB4b+nGiNiZ
 L3dF2NautEuVMIeAz7hu/nR6gYvsCesoTTzaROuBpA++ZEbGLhTjJQocC0G4OeZml4sCGSbfa
 74SDWHbo+0nj2X+dSRqZAMv03PZ1sMrrFLaebAi0C/OqJjTF44N5nwfiqzDgJ1j/qNlhxdAO1
 EegnZewS2hD2LDU3sTyxp+eFm6LpXbRJKrvB0RRgoNqeXUZUiGq2mdAhwFMovwl3dkkqXOU0N
 3lcIAVeoiaGFEPfDaeJZ8bvGlIf2ldq/qGlrASV6HhFFsHyvkFzTrBxktPRKukGjYUE0C4nG7
 6Mv/aqTINh8oTSPxZAGrn0nIkx0ESqjuhjj+Umyc3cp5yOdwwiyaZERJwigFmrqUUd6YDDXzB
 si+7Dq+a4504hw/86sKpu7ygrg4pS37d+VMEg73Do5RaHIQnEzSBa9MY0TSkuti7TpAVUQ6e3
 fDARPEoY3io3QfrzbHU2So0JrtUV1dBDPpuy6wYpyTbFbxLcB7OyGC+UIZWZ090CghBerHa3Y
 8YFdiFcPSoXrCKldDBgTj3w2p5Ue6DdoxF8fmzqzAlxP0d6YuROP3/F1hFbYy9ByJ3KtyTk/d
 /3lHOUZW0fquY9k4z+6oM2GgJfdp0g7BqMge5U6VWLKz404Zy5Sb5e/sGyecr39nzNZtVEOj3
 CKgFyT+1X1rZY98spGLg2H/bZmfcOYPEEWQgzZjqf9sMkMfM56E9JOnJPfYU/jBvqplx3cB11
 /IZwOSBbl/Fkynbeq7wWHds9KX/qiKZ1sgxVHd5Kp1UqatfatisRB0FgTWVtCLEOWUDcqZ0l4
 6pZag7CR5jdxnrzuK+qtM4qgSieBz63LD5pX3vimojQeeY6quSkEb2CSFOFKl0wLvLX6X4RPp
 mYPnI5f/SiQzNMEmOdHJi4yvEc+y7upEQaWWqe+ynJQEZlgBi14Bvh1zgns5Mzj7caaWgbjjd
 rd3+alQ7NRgUxSls2orqsZBmtunwM6xptTR5GqUhwHl/u7xxI3wQUO/LbdGaDcHn6CPXqCtzO
 woUP8ndCLvOZy4QoCL5zmwHiFU1+HcoESqUYxFpemXxCat9x0om9c/2WBkmb4muE7qmm8/Kjc
 7DSkzD31mt+CEnf7zHaxXa1qPBr96xfIhZ4EQtNk39j6RlAT+q0VJzxTSvMN/U/obvdO4FgdG
 p+IT66uQWAPBuqa8vybgW2fpXeK7LMJXsU3ppP7f6NqxfEH7vNYX7y0FUcehwTXXXZt2fbg1h
 W+hC11hXz5Ir18Cro1Qg7ZDJb9PV6+VYJtTmIaUl/lFQgIA2AWHTEi5gIkwQxd66scuV+KpXi
 IIKer99YXwjlcK3jstGGSVG+bGYlO+PDLoirxcZ6P6Ld8Pch4mJFFDeCGu5bQeWwXWEyfYo7T
 +yk5lNRR8Pb+v/QSPxzT1QxCGGp4LawTy6KELqrjcTO27gnAjQgn8Ty1kv7qD5ei4GN3js8pX
 MfnQRiJTgozJRp/F4zHCOL3LEd/8UX3HLrlPsSLj8oN7LInTK+fY2yczOeb+Y/CbW4Bv7gUov
 r1xeiLt2cHhDBspoDs4N40bk1qnYIjTLLIQUzj7cvsnQgtTy8AJ2EEU4Nj3CAPlOOIm1OH7LS
 8GLQBGhfWyBbwLjDzdYn8U4zwlw3TZI82cnq4jsUicv0KeVILP2Ts60V5q4sbiuDZj9MU6rOx
 1h4OxRVj0cPGxVVU3wClAXX2B3a+ITS1B4pUY3KBHr0eC623xyjoa5QGXlW/ionVJB2MWhSih
 5syuNP1VMdHJXi1z6dtnfD9ChZM/6N5vO7Lxvseyfu48n0V08nfPziouwhwbufdZekhtHFWgT
 FDqQmiTLe6dey57LdSJeL6Vb20IzyLYKkS/m8kBBG+t1ZhQ2cxwH9qRySJvIM9ycJ9whtEU+u
 xTbfnGYlx5B8sQJIRevypil3D7JGIkY3K4TcjztX7nIxSsIxkFEacrHc600xCz3GH/cJrh8qN
 EdCJwluMyD1K96DuM/UgzymYixVY3r7QpUhMJ67aOhNXSF4NpT0bYc3LnSx3qRnxA1p/YQRIb
 GS9zypvUCg+/SCsE/vVcO4QaDKahY+vrnvuRFiTk9r1v6ujSzARH37lDbVeCRXZkpNy+ns/Fd
 b7hcws5/Tj2GC1wTqn8ELrXhig3nKcaYXqC5URN4aChQyGXfgljXJv1mNLG7fgwxk0WYj74TK
 MQpIfM6UrOY6+3hXPSlRa4BVVVTGaEAdWG8GotPiBMSRERh6CZVVKEa7mBJ/f69ysCijBqQ78
 OyE7spSBEd54OS5P9TbN+2XJCOD2+tvaHKczklrdK464tQBVWEYM7gsX5zGBHaVfc5AKV1116
 guvI84Qtb55fS/iYpETb/Vvjsgw2Cr0WAlovpbiR12qGvN3zLPaW87dBFCsd8+6ro/V32kChn
 ep+9e4Y33FPjgFj3MTPyMlQa2Ct41ImojNhA+dMqqhYzHHzF8YcLHNMy2YGgeKZUs7aAJjqvG
 nbTfa4XZF1liLlIrgbACSZEjSHSS/5PpviNIDGdIiOW6HXMrZGsy4Q7W9MW/d9wo/LKmOVLmx
 +IkSosOIPgnS64n5GhGtHFKhJ0SavF1dUdlIXHy98APngIhaWjZdstqng2O/gpxU1f7r74gZt
 6S0LrRjS5dfvaAal1Sh+Z5Hwg2E9lczJFtARVSmOGqGwxYlRc8tgk1MRvHXoGn+OBbtMY+LYa
 8QRDUqaaeteqbUDzBl3wvgOOjhIJw+0WR817IEyMloJQY0nR9UotsqpMCozNNQU1yu/lomwsO
 E4O731bBO7biFQLd3D4gqUZUtKBUe3ixeAOgGo401tOWXOp/Ih9o7ax006Z54GsWJUSC1wIhO
 NJ7rUmqQr+7f55UXnBOp2359HTz6P2agO0TKkZ5n2BI+k2vfun68xWjNiDmPpilLzYiGD3K6u
 xIIr7PUfk6ZkKcnOdjH87dR5az7EnbMWK74D3WvxAsBDbbrQJuigcgSfVcx6rIlBU0zthEem4
 7wfkpCy5M4r0ADyjlH8lwwW1OrWfoqcD95cUGFpXdCxEnuQmEsB6RhZ9UMXhwTwGRdnw0Dr1K
 obqwqndyU6NgkZWlUALoh6JAREqudLzS9DOOLcOwRx5LMf75dTHeZ2OZY7w9qCtUv83zaLm2h
 46SkbvsD6Uyn7fnswRCUflCa+jCmL5UaVgKEcrEzEVmiLyEkQGNIO5USgmlEEeZILL7PAZB8g
 dnoBPnHb3QClRT+bKx5QwBIO4ihEG80GchBLWP2EBS6To8bxLEaAL3V/hEiw9cVhO/CiNbSbm
 Dqz6JxOxpfPsBAFEruEcCiOq9v6c4GBhCVebohNX6PwrQdB8eFJAMb2WYcP5hcUXO8EE74BWd
 gqAh/lK8ZhNvLYr4jbZCZ8h0S7I+uSvvzjvI+l93jdNwsYiIN8Uf+hmPOZlFzd/+JYZxfDE51
 8H/KoC1Ol/BUokWicQcmHXzzvf5DipIWjYTNYaMvk2AFsupFcZtixHWtyuFb9A//1UPCIsrrQ
 +LAdZIk/5QBBBYE3zT7x5/LO5mLL1u4ctScvNNvb2HSO5XLQzWw8hdS7eUF9agZiJ8h7czn7Q
 XylkF5zx2unz4rwzUMy5i1DzGq7vhpujo2VkkRbvj23rvo8xk90vMrh1/iyyFs8FIAigZ1K4q
 pMvrqeF38ii+PPu4H7pPADHDWNK052nrPk5pJA6buwv46wnhsCUUW/DlAu30xCDU2eMIKyCym
 La7Nt1dnvMum/4+RxQE3U9XvH8Y0D7ks2c2R4vtjM9xx7vOEzMV8XNnfAge/WaoOV5wDwWLe4
 gXGM+HStxiJLneVwRjwiAQzWvwCnkGY9CJGUBmIpWIpxgNi/ERPbyrcE4JJCneYFn0inqOKpS
 BjU4b7UhrxFiIJPggqq0tLOOFojy/sn4TmiAkgMp59845My4Ldcvi2uT6+FwI0YO7hXV6q6L+
 tGN6q11n0s0Bqkm3oZxgwpaW23Bx68Py9jTfKEdSQwmkKPBQ9HGig1N3Oskvn8+JT0BOhFTxT
 7Ki10oT0JCYuKLQ5aNBHjx3M4+Cztcbdtxmt95Idc+6bRmf54HCgmgUEFw5O7RdOt6xB1gSOB
 SwmWkEV4WWL5+7oZq2bxWIqSf5230MO8ZE6w49D7An5NqyXvAL1VqBzYcz0djZXyoCXhmdwMy
 5zHo432qL+AHbO7oxxtAvnz+NwkIvg1ByL126xWOH0jsPmxtwSaYpAvVM2+5wZvBUvqBJ60Wh
 2rumzOEUAkgV8UkiTFYCWotNizDhd6YaS2wzdDzN5tTv8t65cr9ktfXDMBFe41GEgjVmtCS6S
 duXvW+coIlmR71xMdmktLe2Z3B87MnisESCITtyJWJT1QXXGpd6KoJ+jU/aq7EurkGIS8tBuy
 sjhGkJJwMEjtuwBQuPTCWdHZij8J3nm3gryJKJJtyz4NAKEhqfwC6Y/PpQf+bGvFXK5ZLLkAS
 0s/JsvEuXH0CbxQxrn8bh86wyYK7FMOVuAm2nPuDQy11E8O2DbZ/96/RC1nRuRjFc/tUiNfKK
 /B18VGfCJ20BPVD0mDdKan9lrzmSZ89U9dsRSNihwqjr4TXLrTRlGn4j93WVEFiAP7dmPcNxq
 u+NvOAwfQJq8kl4voEA3jkG57RCpklf/aGCoKksc4XjlhTQ4Aa24xknddHROBCEAfWVg7piHh
 lcEfGZ+cIUZ6ly+WIAuJulSKhlsOiV7Avo0yOA5LJ4iLbwSQYYvig0OC/TGVWSbH29iY4qOnI
 j9T3gLokFF4+TCe3Z2i+8R3mAOTAlOksM1Sm9O5Kyf1yPIRjUosgacPvDuAcQ2GQC+5TqE81K
 gdR3p3XPF5YaZ7mDfGmMKGNdL9OGZrZjqgdgsDTOtk68RVY2OjFzZY7PeZJQMlSlhPFgiJdEV
 kRNyL4AkE9l67x2QnnBL62m1GXwWxjWNVuxa7j3bQrePncG+KgtQ3Cf0wDNG2Mivs13NgaH4H
 IU1COak670o2W8drZscS1vJqE3Tp9W3pJZkIm7Ti8El7CEi0Rkk0rh3qDYhcSQA48qI6F/Zjt
 IniisFgrJYi2jRTyMej4D1ltiE3ZBs+RpE/BPFNuT7zUAJzuYSlMdiRsLu9F1m65/AGTMjk17
 DbkALXeBzlURrn5YvPnZmLj3+GMNoNI/5BqXaTRqD7H41wuzaSbtR1OZubhCxkC8Kx30xwKBr
 h0lhX6raIH3cqBsekWg11NnZB0BElWULA==

On 4/2/26 1:42 AM, Junio C Hamano wrote:
> * rs/use-strvec-pushv (2026-03-24) 2 commits
>   (merged to 'next' on 2026-03-24 at 7c6487dcaf)
>  + use strvec_pushv() to add another strvec
>  + Merge branch 'ps/build-tweaks' into rs/use-strvec-pushv
>=20
>  Code paths that loop over another array to push each element into a
>  strvec have been rewritten to use strvec_pushv() instead.
>  source: <084f3b43-91ac-4553-8305-03944e97eaa6@web.de>

Curious:

   commit 250e977a2b0aa8cc1c8063c64c44597a166e79f5
   Author: Junio C Hamano <gitster@pobox.com>
   Date:   Tue Mar 24 12:26:58 2026 -0700

       use strvec_pushv() to add another strvec

       Add and apply a semantic patch that simplifies the code by letting
       strvec_pushv() append the items of a second strvec instead of pushi=
ng
       them one by one.

       Suggested-by: Junio C Hamano <gitster@pobox.com>
       Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
       Signed-off-by: Junio C Hamano <gitster@pobox.com>

I guess you became the author when you resolved the merge conflict
caused by moving contrib/coccinelle/ to tools/?

Ren=C3=A9

