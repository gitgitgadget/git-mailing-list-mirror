Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB543C071
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991891; cv=none; b=Nvw8yKUGd8eeFiTnTndIx7tp9I68WLCs/+ZvhBM8N69bZLhc+/fnQFUokRPj2fRgxMnXL/VrkCVkB/H+oNlf/SXyYOHAFm/maHXnjgBisSh10fuRXlULAAbQA6SJ6TXtN/r59FrmVTGXlOAYNdmylp+R8PvgI09c089bMDsblZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991891; c=relaxed/simple;
	bh=vXUqOC3DoctlPtiVx6bNwIOgmamwD9VAtlNfYFubnFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQlEJvnZl5Xj6T1J74eSJrqZqIURB3xINH/vM/0ggDwuVf6IBwURwF+L5v11UeQ+EggBuHdJG6+/8Q8mMQbjCIMz8RNy9BsLh7ZNbignQWTqz/ZTlTmsToVzyD+uQo7zol0hiGgh/EwmbGSoNXMOlBwXVyauMIJkj45GaIK3+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=B/up/7/J; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="B/up/7/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774991887; x=1775596687; i=l.s.r@web.de;
	bh=WVw6XymyY+lqwTWQGaTjABINnrgYuVLVcw1ha9R6fp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B/up/7/JyP6RbzJHHioxo4ct+W49q3ZHPJ7Qmykfi4FaE7aJlytx8jvBF0bpuYXs
	 JCDYsS/qUw2G4LFFcolcRt2qmNfH3m4CODq0t9dzQi0HbuCqj8AHtsjhITCYDyBPf
	 C3NAVXd3u9oXThwG8q+jcBDVk0JdDtnBcLub4H/TdnL7mEjY1YNAsj1Ru5XMVMhKZ
	 ypER82bIo2YFE5PabfqLJi6HCnjL3Z9pS7oCCY2ecajct5ANs60GFSk95QMHAuy8N
	 O76DnYQCl9qA+DMvMNlkXO0lWyHScbK7mSKKdu2ZbdxX4TyC4CqjG3VhPYAQ+5D8J
	 tuvLE10lGYbXhfLKMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1vng0C2zIF-00Wetv; Tue, 31
 Mar 2026 23:12:51 +0200
Message-ID: <054e69e8-3dab-4321-b68c-a48d43dc052f@web.de>
Date: Tue, 31 Mar 2026 23:12:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbKOhw+6JI6338Go2+1pleXwJCFh7yFiboy3YsOMCrGbZq10smy
 DT1egeO0o/RCqkBcT3qNebvRLdXgn9dqBj8e+f8YPbIEDhJDjq7PEYzlc43MXC1yhFVXRgM
 1dghGZx3gGnxp5vEQU6rWnh/SQ6F0v231/oXGQVwB1XLmYPGOuny1LJ+04iJOexCqOcNsco
 M1IkTXv1Tq6D5dFxLnY7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZoIiPpCXmPk=;1TeKkBHVsvG10WYXjAhzpopL0hQ
 VAk9GNdO4/PdgEUC1lH7zws+5rlT5J7/v/I3lQpFg0gnmGrptDMG1MB7nyGtEih0qUfcmrRdV
 xe7Lr9+0P8QUlwCN09Lf9leKoQIL/DjJ6vWwLzKb1dyS8z3gc2IXxaYO6no5naILUwUf9R833
 KCtVMjgWbIxHOuWVPBr3le1J/YhPC2S/ZQUpSV05FQwQ7amOHjwrEMllasoES/vbX2Z0abdF8
 oyCd6R4lpKJ5ok6kxkyZt2CuQjvcvk4UBudJEp1fd4cEgY6rVe0Z4uMaJ7vGe58udiw1gp+Eg
 6YL3c05mPw8kWziPrb5WmUelaT9z1RhAJCn2UA8ap0g1cytGh1ecZnIV6NexgXzegc8Y14Nrs
 yF5LVExWSgyGL2+HXyQcCp3aKEWNZHoyEHMHqGM+gm0es21Gm24SDdPgalKXxSYjZu59NXE8w
 +/cHTU5W+XL3AgnURmk2iY1ZrL/GXz77SI0E3ZEuh2PNKeg0pJHaB1RKA1yN/Z5oXhUEkxKWm
 H6u4gSxn7r7BtgymCvWLh8v2euwoq0+/tTDTvGflotR0r+DNOQCDmO4RT10HAJ8a/y24OPz2H
 +PsABf/SCPvF8GwwBXt2dJei+5OQDsD2uj2YfjukrkZfbs7G5eB+C0Z7d79VeJGllp+YQvqGx
 RH92HuCLTgKBoAVjOt6BP5pn/ooXtLo6UMfIN32IRPSs6CauIEqS32A+R076hGvnTEI7pUTTM
 1g0eOmWWVL0XW3pq4dcSOccAXYQC5e4r/TfqYSr70LqIVw5PsxfFYTVa8I72iCoxD6kGncc1C
 CFk1h4nm9e3OjFUKpzjfpljrU/mpk8PEe5qKq0sVVlTGFi0px0lzCwVgZZ/Ns+r5mZPQlc32W
 sk1zmBnOd6k2kABPgqcYNAD1pcq5XM1+oq+x/nPV66V1nhNwqbQlHoKdUYBGb1b+M6KsJe2m6
 duKOqPkps1EbJLn1P0NKf6FvWdkdffCVONUuggynaOfmj8uz6DpjOfmzZB0eceCMXWk4XjbVB
 MXGPtYLMCs0bPNHz6IZpjVndn8B61SFWrUrNEaKlQfyCIQd+poj7VYKbe1UnpJspJrxvLoaOU
 pxbhNbzYH0WaJt/2RriVJC23nm9NT5Ur2kFhDYDSG5HlLBV4WDO60SZ2tKqHr8PPPvYHSTPRT
 1qndJLxsIHDvt92hNebFmoGAaYkg0ODzKBMo+P4HniI0dQWi7aOgk2/o/9SxBigL6dLkvF7XT
 Zi03qcqoSEGFhj00WLDcj+ltC2diy/8TEeNypCAUPxmqUDkXew/QizWs1G6PoVaR47wqphDCF
 xlH3mbIRxmpMP+Igk6+pLYrrmrcsNfU/q2DB0BIRnyKeZAlc7Yr573MMeCu9Oe02TQtd4U5w3
 6Ek62pWIk+l+MLlka6Cw6iheequJJPd16pnQzYjDAFv/zNwWniWep5FYGwCGrwxNx+aG3VhqG
 mGUFp57X2t0TG69YgLQrG15u/xa7qURjAXkrKNcLekHk503HozTiaJF3WNiWETYUBwO7S4c8D
 neIzBIi4Cpx3qAKY1ZsH+YRvPq+ACORpYBAEFYowIE4NM79fq2jvcEAxY6lAOM1ovQwZjegIe
 MyD6y7lKl58RWV3lEIh03mpQ3qj3iY8ZipPB8/ok0HJh2ZWyI+MbiAZBbCmW82R/PULA+Fvnp
 N3AdQ1imkTvZXfGyXPsCzJk0vm8ovPQsujQr1WYZqsh6EavowHZZuuQ/QAGYcwW+AVW5Tb+59
 mkH0hPnVBcDViDm1PtTkQ+vNhST1PnfPYU2/dyxSijTZFNyLPx2BnfA3/D5t6x8JXyVtkI4Ev
 IaLW2sA2gB81jSjXYr/RQxD90kWL6PpCXluh8M8nWbb8h2EX12oGk2ucEzQ0WjWG8zlLhyTXS
 KVmUO19VJKFjEWBnQgWrDAm2gFLvJNqxKt/Y+7ZeXoUsV1P/Z14Q3BFPNlSpm6s4VA4Z0kLlX
 F9FA6KN+ATLQ5z2C4FoomC1/yr7e/64ALJJnTFHW5XukIR02CXrQUls9CslvFCpHbaQ8xc/qS
 C/qx36ELIyjwSt4wr1S41vh6cxSt5+GukR+MuESv/hKhDeqDM/6SFWE341+2fodsU91R4tSEC
 Y5bq5oJjX9BT7tmNimohJGeNFIWMz6w6a4jXVcQqBVGXMjyTfxdmyXkGfMS4Pjj+dB8IJ7FD8
 F8QmkIr6vWlA354JSdJJyHiWZkS4I3ciCFu8Td+vRdJrDHZTqS5Fa7BBgjgQ7IldPYwnvKS2S
 7N4RgGQOC+IEbEEmVN5eU/8gN5Gs42i7DdB7WkX/2YvAzz38seKFlmee/U4zRLtbiDYFJH2f5
 bHEclR2jaXrUCeywaMpwEWPxGeb0d9TP5tQ1X5xQZ013AeaMVkuMk1/2AYZJvD5QPOIUBm04t
 hmt9Q7WpqhVFO97wCA7VaBLge0SL0yMrPmmGX1wUrtM7Uc435HW/IM+Q7bbuzAnVGluX9mK2R
 oqgiNfFDXV8ei0XFdyW8T7T2BJmT8d/GYIGpewiWh/Rp8wlEFgLmlNjXPQFoa24t7xOXT33FS
 cBwDJ4oRf4fInq3Jhj5k8bepym3dIgKMtDDKtEJAwgeQ2VrJNGr+4+5xEaq96OAtQj783y7QR
 dYqtjXDBuZ8va7syFgxuGH5oV5tDaMFNYRkL2tvDWo3xglp/kUffsherU/ph73MBsp+x74ihG
 3dmYblEmfa6Y8kfCth1GbfE6yc7i+mIceGsvAaXi0jOfMYaIubyaf4P/G2rFf5EvxCF0jmYkm
 a1FzFSYZEsCZ9s6jx2mqZ7qm4xTA57XZLyvr9dH/qlpOUewDMFKIESKpGcixXYEASG8O7l6DQ
 OceJeKfwnPHFk6NOdDe2G50egbkrXeQciT8kVY2HAc0K834+nUScuCfXjh9OoGBT+toARjw2v
 hF0W2AlHHzXy+FpbNyJPzN97wDWN4mz0Nh29hZ/aac5SNik4JqzuWe2oiqnOaU3sWsESZnuf9
 NtbsKW6MTelaH0EolGk9l2ide2X+Wiq7JOtaXYooHw8Tsrzl+ya4lKaHn9RGOjp32VmJ/Nl8r
 oDrcL79q4oP21JDJDhmWi29Nkuw8CvNbvN6mseDrQ2i7IdR2OSjqoKNCSp6ZY1glKF881nGLb
 zWWr3W9NqqM87uz6gLce5oJcSRDdKJrPDmxxMQnMponVSt95utz4uCabiHN1kzZCtWyXdAvdY
 ho1b31P2/sxCIUdazzxuQSouyhlm1jqPW19y9POpKrSNvUQhGMv4Pkbaefd1k/BvIcOpzcxFd
 R/BPUlnn7sD5nAbDiPXU13VqOqUqcdfBoD+iV/qT6iKPG/AgIi2KrQxDlktG8JnN5oDMw01nk
 gXyIgKNHx406hcDqNrX6ynU5pJKL/zgFOjQvf27OYj8VlwUIJjn6YPTKJW8ZKTghAAk/GYF1/
 v7lz8SPca/aPX3emT/HcidFYmDbJbJK06d6ibUAj2e+8ayGuxuZReV7GDmCrKSTtOVtwF/DW1
 INCc5obExIkTde3VbZL4CxR4qgLRX1FZL+foz8j78JohQnnhoPo4dL73zKiyJVtsmcOwdr0s8
 7LtLRhumXQV8tps3poJNq69BKFdUEY1CXLH6wRJMTGbx1JWmYCEwl85LUBVUYZ5XhLlvv9d5L
 0kZn26Cw/Clq/4cnTGYFjjE+HC2r7W1QqwILZQxobzUExuygwSDid9WFQ08NJaHaJkVdQhg/c
 1Tty+2RrZKbt99Xa95lDbpG0p881Mc+Vjog2kyjz18zPCnrr7ROYPqNDxJ0o6KnYTQG4A+krg
 sCn6ElqsfJFqawQZCxt7FB8pgkLei/5mOxKTu0Gi2stcWKdMkaDxPnS2XK984Xxu02sBAYtBw
 7k+34Ri6F1IiH19/ZJIa+frdA8036blGePE67XFgvsrx6Wi0g0X74nsIfhPReK6wfVBitjHO/
 8CzENtqqsHa/56GRWHqQsygkol1erKN60Xh72vH2TY8a9yT2wvresEbHNep1i5CUsu9baSglf
 4Y3nPO/DsCB6/ox3rYjcGJs0ov2Rhrr31jI8YNXvQgJnsRrYBhUwUzZ2frkB891F2mElqyZUK
 g9gN/sxV6J5LjD5jstAE1v87+PGOHuD16AOoeMlF4TseZHVvK32yQy5B6TwRxJmLdEvdsT7Bj
 o0a8vv9BK76ZZRmxrg42hglnk/6+oyLWSUwDKkIdnvLBy/7QCYMdCmodlcb/yr1mWfg2aiKEy
 jOxff9TKu1ir33z0V7SuKNfA/lnXXilgAML8pjMf61UVXHSHqQTU2SWo9+5FEQReeoH2cqUde
 +dAYgfdZ9NXLLkjIbPrL5kqNBsf7u8ZTXz794V2u56XnVcpkU3xZs+vfGUaIY8CdGl5oLLAVu
 E+vkRwtIzoPFw1VnUU8tEv4EqI5PoMC6xa81GemxrKmwKoGtgl20Ng8pq5yRaiunY/kMoQMbk
 97+JtHJ8Snn5N0rhB+i2QylbhSw0eYpWCIfgKPAu4eDhhjuxPqtj9YLeN9rALVhiTquLk6cdn
 hxEl2nKPGBgR/Aw8LBcoXXvKuXtI2RU62ASIwOCxihjBFnIvZLbiFfGwgoZ96rlYQluSMWzDH
 +IPbkR+hpkrAHz2VvGSSK2FUeNDsqo3ah0YrihRcDXqCiv7Pj+Z1Mt8+ld5K3n8s2VnqO4ond
 2vYmPtCnPEJKnft1gbVeTpWK+YBwG41s1QASz0mCPWimVkBGGR75ngcm/aDZzYieHoRPXkY7u
 upU7w4xINAnDrtqN4tbyTPd7bAkLEvBpfEOFArX4IxFr51jtw2kxjr4ZqJtnR6cj6/+iqQQ86
 g7SFZZ6sz84I/x/zwYVhyu1IgtfJPGx1kDw0/kVwM8K3HCx8jrpcc4cfdzQrM+1JPHiVACcRw
 hK2ZibV6wcrqEj1vPqiBECyXwQsx9cCN+pXS6UCBJFObBvhSzWqzMoQsfYf0UIE4cP0nww1t1
 iivv0zxDXnw/OQJEPb6s6zVI3PQEuYWj7zHFkcwCob7fpDb8PErWmQP2Eo12tznsEvwcbfzDa
 sS89putclPLIdOZ6utwnI4ouUc3WLc6DyOOCy+1l3Vact1Fg+bKKoVxHVefnLF6y02vPcwQnA
 Ab7uzL6luRZqpiTG0mPutzocVKKTXqECRNuHvBrTCqys/ifrt3qT/O7DpbU6DeidnLoaJsrVh
 zGzTR+5JRd4ffdby6BUpgZL8c00t6Zz+8LImeIRr/wCpqDUjwuaH5CTnIo5/PrPq1fXoXyNmx
 /T350PrrsbdB7KWR0zIi2ALUn27nR56JN6Pcq+B9Qcs95RuY8YA+Kf4GahYpknWOTN8ZlnZK5
 cJ2AGcXyF3PXxmBaDIwQHpuPbHkLXya5cuRKDWJryg==

On 3/31/26 1:26 PM, Patrick Steinhardt wrote:
> Not every compiler knows about the `inline` annotation for functions.
> Consequently, Git knows to define `inline` as an empty macro in case
> it's not available.

Does it?  Only in compat/regex/regex_internal.h, which does not leak
to other code, no?

Ren=C3=A9

