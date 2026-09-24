Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EC30EF6C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277978; cv=none; b=cafVkNQHg6jG+DKuETrmtfGIWD+m0Y9rJAyG7pUtyHaH3SwSas66/G8slQKneksFDo2dQ5SxuFEHx6VE4/nCasY17WoJf5fhGvRwEvtwwHxhDJXMd1EJro9ZoFGWCzX7hqbWQkdVykqAA73o0D09/8FcXokD5ZRwd/KK5PnRZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277978; c=relaxed/simple;
	bh=PcoQAYtHRqy8SEsrwhqnl9WYrXLOkoznTJtoxQx8YNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OI0L8lXO9bRviLENae4Z+vzHNC8z3T4q1T/rjpI+QCtTrORiBQI9JF0d82hWzNgADj8XXwJPSOSnyw9GtNmDkDmUTYkdgBAxrYOnAXyum+appGQhROPdDC1diNJSDCVLEWHubqj0FrNAMZJ0Ru7TEptnPt2sz5heSD/G9L2hQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PVay6dw5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PVay6dw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790277968; x=1790882768;
	i=johannes.schindelin@gmx.de;
	bh=KyTsoX9H/jNljtrT0rDr7/pswsW+/rRVYpV3gqM3zv8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PVay6dw58op8XxCxkjgnsDl/lWzquYR0KpXV+2ChtkDLJAGSQKPwjgD3lcYrIZ0E
	 EYnNXpfuTn6wktm9ztQTwrLj4lIerZNSZd7KvDBWMTt/L/zeF3JbqO3PAPOjmxCxW
	 3OJHLtn7uRzD73APitH05P4/kIjicO4JHfdo6WAiMZxxLiutRpDQN8zV2h3AvblQN
	 MEIFC365KcOKGNped4pALoqtcR1fa8RWeJM/Z2gPO7LzScb5hqVeiJzBQYK2pFffQ
	 WbkM2wrT35i1Z2GBTApwoWpw5g+eWSy9yeQ9xvE4LfljiddJha5LKHRO42BPY+AIh
	 RS8McEt7PhIDHaLyqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1wRvgu1FYm-00kSWu; Thu, 24
 Sep 2026 21:26:08 +0200
Date: Thu, 24 Sep 2026 21:26:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 1/4] ci(gitlab,windows): provision GNU Rust for SDK-based
 MinGW builds
In-Reply-To: <arUHyjHAX20ovmr8@pks.im>
Message-ID: <e58bdd38-59df-5fd0-8c80-e9ab9714dd97@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <6a389b2bad1653175bde2a767ffbb5b672e324e2.1789819933.git.gitgitgadget@gmail.com> <arUHyjHAX20ovmr8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:6Lr/KlaVOPOB+6ntGHvIqEQvtB/GSXTq5xQ9Pqegsf9LBgJAVs5
 gBQd8yOD+idKlJ9JfVaKRfcgKy1wPWID0ojFYEWQYLg9rnxyMmxdtukVJymDmJx8ZBp4Hy7
 UwZ6Ouw/oCm4M+jEdYNYi9mf28Fap6KJfjwWyzMdMHVNCCOcdMsvBrtD+V/mbZqKE5DS7Y0
 gpB7DTUtkpFP3PyuUWs/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P6cON8rI7dM=;i4EdHELuQ1Rhr9HrAtlr29kkeCq
 hdQdroRU2yVfZjzXiOUmchveurrWir3MHiogAAe7bfnxGC8qJUY9PzruAGJO95BNT9gTF17kj
 6bG4gzjGCbt8WVE3Ot1BUPGqGVLmxn5Z+wMnpaEqXOhvX4MuTR2VGjeVOabDW3MT4Tl3bS12f
 xhyWHWn4dHDW0aESioasweHcx2ipd9DfPj3nrZujiyylxF0Gbusaan2OE8LEYIIAbXpFJqC3o
 EMoD3cTL5jWsGHN5xBrlFNfqVE8jY05bkLV1ccGkoWrDR+yY2nl6ee42s/cCicKWcALvKwHKI
 mu42AHfsKjWkUU8OJUSa4C5av8O2qclmrIbU7WFuoTjhp7nHnt2IU/0DiUrK1ksyyXHTxzmnc
 rWm/8N7FzjxDVUEF7Xpo6ErjOz5gCPscveiUBA2dQ3BcKsyRFFhzI0x9FAthLUme8Mr9xt8vr
 1Tda0p2LfUfTX3FolIBkt7f+asYRic2NGXEqoJoVF5cG81BcUGLtFO9dHfZxKDZoPky0D9HR8
 CMohCRgTKXGt0TUsNrba9vyPZ8r6l4Rd7XWMX6Sr8sVNW8eMSXAbYU/gRXQaT9VTta/Qsskzj
 jjczt6VStWVtpseR/WEbmXLXskpyRQPGpl6ZtwmPdRBmpk7HhKSxLFrSnO7wRPx6qRu9Qm8Qp
 6y/s63BgcB68XDUi+Jo+bngxsaAM+i3f47GVTnrxx00hZWM5gGtvs94qtrMXT9o+KKOwnGdKy
 LgJs/jm7d2fd2IcN/sZwQqv5GHUfmory4hgiEUjPkS5wB6y8Pp+l9Gia6fZjeOklfCsw0EqWy
 eSmRTOKZAZqwgtvS6nt2ZCQVUyXfZ3gXoKnmS32lQFNdNd5ev74Is54x13lV/FArTPHeUzT2q
 aD5qDAGzETCkGeWmY3nnvO3Z0Dl5rofr3pABoCUbAFNOYuTISK4QY0Kqk7eoCqvg1vVsoyyta
 5XMGwhqfhB98Saj5aAaPUV5VCyZPosz8sfR7X+bJj2dKNnvKEdqgbv0EmxdsT8mQLsCAtKHkj
 EHb0lc6XDFPRSCDWvTxYtl90uI3+HGsoWrEhvJFfvDv/ccGAxdZi70wFDxS2/4ryxk58+DQ3e
 xwJnd4Ptpv0gAXT4njj/O+coaHVgYcySJxkQ3rdbyAXChF8WVo/b5ZpltVRludTsFtqfzbxyW
 bKxSu8UFc4G3KlE2GhOqzSrPj5pXCUxK9XCftv/TrTy8226yrzcblgEaqDXvH2iSkbLwCPJHs
 9bnpDhNCj/Do6O1/ibNBAbwYkHIOfpwFb1aWjjfFxpDUR+foXE9WKlcdZ4y852hGIkqjXpn9p
 sNx4wZ5ys7fbh3ORgeB9UwxlaZXdaiE/vBHPBIFhIEMFFwHmEo0YO6lbvJkBhmCClkxjw316t
 iM6uv5rJjeHW+U4gkSUJxK5oyZiPWe5AH6D/5Txq9UzrjrK+kaeGEZkkiBYTL48NhqQC5x/Wb
 FBLbWyyP5ZG6AZn258X9Ktrydkn1/GHdiFJ4lhD+i5+hob5spg5Nm6xcc5gSjAfnbSsYCG0w7
 Lg5HzT9GBt6ZFHvhesWjn53VUS5nWwaVxz7MntolX7pGi4IutmSlizLXLtGUf1lBk2F3Wignu
 nbnU8KgOv165mk2d+0/6SS6ekiFtXbVGKqM28eDAKA39NTo7jkLrYHAQRNDFGJgsXXdunD/QJ
 4VjtTglh9WH8CgVCjMmY2/y00XqEGGs4QqsIyuhgEIo7TM7Vfyq9YSJv2xWwVxcQAbodRmz6V
 ZgbntsQwelD4TUE0fP1lo4MFv3J3nXGYu76JmMzGmOjJQTW96IfgFRAnQkxsM+uDS627L7DP9
 E2ETcrzMRV87iuaOXhGBw1nKpXK1xtdfJWZi5zH3ndiiT7oefOiIS87Dfoa5CXRUtcu/alooK
 K0u7Aj/2x+N7iR3tu+G9V5cl5U7oXXKyc3fu9m4zBQPcub3Is6TsWXuQfntH4oK9f4EopfRcq
 wJ0h3yrb9fIOerMQnc1TFjpWG3q9t1HuwWizkeksG+4GpLiWlMzckae5x0G9wrgoh3HaxXqyk
 i+TuTucd08mSpYqcJ8GSed5aspFDiIh8W10IYEn1heyB26gy78wzrXhuzCnn8p3WIjtvhaND2
 Z/+ZM3wV+YgtDgcusciGdwh/lZX0USL+kWzBbJ0a5lvskeohLZ58xBTfOkEQTBDj9zu54eiZk
 PIKGBx/8UK52RvXnS6hOKPOegwYlDCkyWLKq6aDMtfcst4ICOMSZ4okK61vtW9XaCNHhLEI4L
 g/mC4A8n+UvhqUyt/kZPu4ZybLAVi0LXhFPruTZrEQNCtgW/jbQsGNfjDdoOwv/V4YcLPjqRo
 Ppd3BifwnAbZE152/kWFxzFKVV/15YcxQ9ef3qbH1fyz7QVQQD+URyTLOgAFwRH6Yb4zqBEmQ
 eyp2MWL4v02RreIkuQw93rIRaAw+MFlZxPksj51Si15Wr+/FtxYsTxEfupOVzVHUMPJVZw4p8
 ZFASPyp5w1ZfezzluNWtafShbKyJnl4oM2GmFhFH3RUIq5oyZZBmaW00v5LpDUjTw+XuZ1THA
 uI6S4ppY4qiVTi9mEyBofg2sgokfuhljgWNv2kg1jqQKKSRV9AjNu5BzR3M3q9BAqSIX92JPC
 CnbERUVoMZHs1J43efeXiIR6SeLxyFPH/WUSpYf5HXfBgI2HU9M1NCan/0+Lq4cb4UJFRd/HI
 G20Wgqe3uxUDZG6QVmkJIuPtVO1JbFWw9FSyU8FIY+vGEdNqodEJgfNevqb2HDghExQF5KGIt
 4q5vAbs/bXvALoyZQa8RI7yKv9j6G8uQDQeozUuDE+R6XMD6IlQSHaSapozaVckdghSNarG6f
 nT+1jRj5PjQ+uLKxe5OaV2FnOMN63jECEDMKtcTKIXaKTCNfSz2QBEM22YXVqpDRW5cdJySWQ
 mtDJGQbAlmeuW+dfibzhdnjyvXDylLjHvobCAtkZngUYg4maN+4NjxOaO3jBIaM3uKBfTA/Cu
 Zj3uqgu4Ki9mwI4GqPCDiQVvV7AN3jRUDYmdppnhr4XCmNehA1GWjFTyEsCqK8gNzy3tAedhL
 sntu2ot2ebwY8ZY2BrrzuvcpDkOLVXEg2lECht76AxnweZF4aCSne67O4LsxkDUgfiZ9bp/SE
 N6wXwIDmQQSV5Co7Mz1GykXnpJvlbR1r7tZdMHKGpKVsLpFBim0Wif5vb/O9AEaJq25UY8SZH
 DXau4QR6f6AHqghCdUMjCmmhC4TcsDNNIhwZaJ1SmaYtqHXPEBIxuXpeJ6e2tAWg5KLS2w1cS
 oUKwEJdDbv7DvYuMxte0Ff9q5fsYtlPur/vPnDWmkcsRd++2Z1DcomQOx2oBuFScSp+sAegdz
 kR+ssyY6mARTx87bs2z/GCccIdgBHJhU3+KoYMh+oeN1Y/49uiEq95Jh31yl1EoUa0784DVcX
 tqZoF0EVqlDHmOsMPhKPAGusmY5atSr1mEhp8dmqkAFWaoPny/j0dJFkJ9d12dWPqnOGZ8I/5
 wBcUwiIIYeRp4PXxzZJQeiAs/Rflp3oNvCN4QFcb6e/xqi1c6c1tdU4rzSKwwkijJJ0/Lcgoo
 mXsezx7q1Cj1gaGWwVSkkmKKnI+CGXl1P1fe3FG5dasJJqxrXppijJ+KKiIruV3OVLkhyWXcb
 aEX9/hgvxBuUCMC4pEhblRYN30AohXbcunZ9hus0A7wJt2vCeFLlVCKlEekchu2QoQ83FFRV0
 wjoE/HSsHcOTXivvuFFm4Zlt5qsdf6cMlOhi/kJTIjM6AH1ZzNx+NRJyHzr7BUr80l6EQDmGa
 x17IwLf6B/oMDoaj+X7BCve0VFa+Wf2PsLgaN7IE5Xv7+wnQzwT66HPOOFA5pfGDJc8BB4Z/u
 qRPlPuVu2U+XhjmC9TTRkVxJGDow+0+sXh9QtXp60Vp6k7lNH/LXeUd40WMqqj5dk86MRzqgn
 /BIHx8QSJ9ltGbCSmVgKu1Q7JjSfioKi32q9Fu+Eg2xRYwsC5vM7xCSsnwN7a7P/4uVLg2w1T
 EwOGKRg1WQFMJXJ77mrArJkWvlCd3IcW0ftsLPhavJMjF8gzmdzkEHTtPgBZBTzm8VlGXMvQW
 tcxH2z9UvR72IzHIousa2a2T87Ji0qfaNIEAIel2Z3NaSsIOaVII7im54Rvv0rMi6goAGOI9p
 Pk4Q4uTTo1XHa0Ydud0qCYKERM+anwfrrT5YGMuCv67MpRg2pMhecdYIjMNcbIccR2Y2TOV6Z
 Dt6NHPsIMGhsU0EpDHk1Kz860aPkKaXmvsHdfhJzKqwJVT6kzAc9a1E6M3jZMdrr7znsYaErg
 QkxO5T9M992CzJZRElMOXKsS0Y2EQR2srzf3i+QaYrA+8+2ml9LifdV11rxPOIMlZORkXh1ip
 lbby6MFNCvPGOQGdb6hQ6Gp2SM33KiHlju+8qXmhUcv3jbwPcHcEJgCkYJ3tUd6Mti4JzmOzR
 tLTXrPXcuy7+mRUjKKpqijdz4fDEhHMeSBVeQoXxfTIvN/dHnNZJ2EgjfLvkr5D6hENwcvj1M
 yQ2atuMEP9c5UGueJEsonvwdA/NgJrGrJsYG22lnFpR8NTjkoS3Q5Z7woFLKesqaiPL11hn1S
 ajOe5A3hfkKjJLLeTehJPPtcBDtHJmqu7cIGoG0GpJAH/+vlc1o3pWz8z5sOLZ0A59JkN0aBW
 cfzJkcWf9TAL2Frct1PNgRd1DL4RVAbyz74ht2rXD+ojb2VNXc3R93abiAEh7aC9SxP2Y/6Ij
 MJ8CcoNUor5YHy6GrXfmYRHAlnhcUnKZL4/A0w3WQZAhqGPRz4sJvsgt1bH4BUCwgM6YBJcrJ
 vRJSRMqZoX8mzlFFHOhmRH6K+gcP+fxjBloZci8b+di+GIQY5TbqTSSoDJew/Q3h/Earikdso
 paEY65loGQ/MSYTNrzaxxi5Ecc6BuF3zJnrqwQ0lcfejjr9717VaPM61nSi63fXrsp1IvQj7u
 JVWkRetwh3hIbocf4nytKz1unbQnNUQb8DA7FAzzAelzecwVBQrgXfNRdYk7rcyHBflp7UIlw
 mLN6NVooYqDEDxIU1X4sFxKQ7GYXsaVfvQU5fPrqzcYvnujMHZbLn3fH89pUC6fl9ZoibRjX8
 wj0neF1C7NTSAn5p3CUXf2nxIGxeRTyXo/u0WMd8rt6QsjX/sPsNhVEbjE3UACtvVMfGrvVef
 krbFHM16FsuX6t6nRxXaLmH/WeEx944O6q0smnyKaWEWfKP/WDX6jmimi/0+vgpd3R3ce8BLe
 N8ibQiGJB+NrMq87OZ9F6nrmTe/MMfA+0DqPwiBCjI9uUMXMbOV/KivOSzkCqGzw9H0bhDAdK
 zVVettpJRGW9EpUBnsJvr6J7hxkYl3tWrRIb2FykkXd8LVtm4nsguM87cAcl+ZwzaKRRuW/J0
 JCQjkH8LUQ8uDPJL1XrYpm5wvZ8F1RRyOGHF3aZQxlnsBJ7P8W+2vxyiR3P/or6bP9AYVfUO0
 3yJN9P4z0+kzgnLeFkKO2UTuS/U+hGFNx3gNmSbABShtbOjzkv5gi7o4+qBGPxr7ACp5cRzvf
 6tQTDYKH+TKLQJhC4gySNms/5bl7ysz0u7BULaEVjQt6Lhfcsq0PGEAbnMuKq9vRATqzPHIqV
 JcKh4SrmVWJld49ZPcZ38qZPDfi8IomiDtIIPmN8zZJpMTHGUjrLDpirS6EhkdlX684u+/yqz
 G+dpwG5x9mzwEsbIaxKboZA/phBc45pkJ5hZ05OpBE3KvE9FF7F9qiV4T1lYMqy8ksOCnnYtP
 avIVCZjlGRawXmmGhtVekIkQl8yAjGJP/W7PDN/7bR5rVjfk+D28Q9mh3lPdZzS9TQZGiO6hS
 zY2GRQLLlDkZuEl6N8GSOxbwYWLgQa2m4JEehNvczDYYX7IfkEcpLoWRH3XTC5fQ0jtZeVfFD
 T1fMwKDIGWoMB9OjCPp5mwbW1o14T/Qh6L6MSmvcf6yesKU+zydWZZfaUATPd5dPyTyN0NTlo
 Qg2BgX91Ugid1N9PxdmTsMqsKAAhousYV+jYuMTIa3WV7VKIPJstGgmDfLnnLZ6GW5ZrwlF5m
 pGTnynJyq62dhHTNwcfYwCgWXtYT80ycZkBhRk98GF/bzHHazdB6KtiT8+AtJS70eJcRdO1VM
 gygpSZaGQGXZLWctA8x6udiHHpVoFkLRqu78T8ni3GGkvqexp+0SMlEAlZr7+Bv2kJMv7uKPG
 7UQ1zntyZ+3zuZxUDY3nFMJRrtilWw9LST16XuteA8Jcrb6+7h5j4/AwLhInv9KXxo7IIoAa7
 M2sQqkl6akG8YTj8u9LPVSPhlfSk/wRY3hOQPEbgW7MqwLSU0C5OZMYiXxE9T++YIGo2tntbd
 c5qWOSgoSCPjEh5kE6B4uKj3EAv+z8sr/j+VyMH70zaeNuOkmu9RgA8htlzlPQ5pfT2I7F0dq
 40vN4RGqpEle/WsRluPECn2a0s+49VydSRg/FePtvEj7HfC54/HeMDGg+OsAlhW2SIm0jiI0A
 QVShcwDThr3pTbDx+eBnGzExR+qlEBaslW6VzT93RXj8I1zaMSBhgTEmM3JYd+Ecekhe
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 24 Sep 2026, Patrick Steinhardt wrote:

> On Sat, Sep 19, 2026 at 12:12:10PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The minimal Git for Windows SDK already supplies Git and GCC. The
> > MinGW Makefile build needs the GNU Rust toolchain, not another Git
> > installation or Meson.
>=20
> Huh, what's GNU Rust?

Sorry, poor wording. I meant the Rust toolchain compatible with GCC (as
opposed to the Rust toolchain producing Visual C-compatible libraries).

Will reword. Using `git history reword`, thank you so much for that!

> > Let the dependency installer serve this configuration while keeping
> > the existing package set for MSVC builds.
>=20
> Okay. What's implicit here is that we in fact don't use this script at
> all at the current point in time for our MinGW build, we rather use the
> "install-sdk.ps1" script. I assume it will be wired up in the next step,
> so let's read on.

Correct. Will clarify the commit message.

> > diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> > index e3b367fa54..8c68fb0cfc 100755
> > --- a/ci/install-dependencies.ps1
> > +++ b/ci/install-dependencies.ps1
> > @@ -41,6 +42,17 @@ function Invoke-Installer {
> >      }
> >  }
> > =20
> > +$rustTarget =3D if ($Mingw) { 'gnu' } else { 'msvc' }
> > +$rustMsi =3D Get-Installer "rust-$rustTarget.msi" (
> > +    "https://static.rust-lang.org/dist/" +
> > +    "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
> > +Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=3DC:\Rust'=
,
> > +    'ADDLOCAL=3DRustc,Cargo,Std', '/quiet', '/norestart')
> > +
> > +if ($Mingw) {
> > +    return
> > +}
> > +
> >  $gitAssetVersion =3D $GitVersion -replace '\.windows\.\d+$', ''
> >  $gitInstaller =3D Get-Installer "Git-Installer.exe" `
> >      "https://github.com/git-for-windows/git/releases/download/v$GitVe=
rsion/PortableGit-$gitAssetVersion-64-bit.7z.exe"
>=20
> Okay, so installing Rust is the only thing we will want to do on both
> MSVC and MinGW builds.

Precisely (or as Claude would say: You're absolutely right!),
Johannes
