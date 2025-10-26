Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F941367
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495075; cv=none; b=W2jtLBxmzBsca7zhmDsUAG2aizWwLZf5A3YpazW8HSTMPsAK/8O+xA3lY6uqaLiE1RqyihgnjLQ3xjD+LcMgddprl74MfdyF+jkxFKAtxVBTdTiLXmf8JyPObr++vxdrlK81TyRXfFLJ9vhekjSMtnoWdRQl25E9W09ZLu1DkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495075; c=relaxed/simple;
	bh=SnUw29kIWYowEDNFWA/jKxqYVKrNECTOAk3e0kYxab0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azJ6yUsggJRJiCzwE8xQFphnHWZrG7WSXBuV0wwHh0mMvtog8SkhgINLfFGwbTVU71/UIh5pLc0ox0MerjTsIvUWeVuLeWksjl+YorF2A4WFRLWg87i5BunnjC+EAp3W6YBnDPSeSUHmJ8I90FsL7Nk039ykSIzjTP61Ozkeno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UhoqensZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UhoqensZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761495065; x=1762099865; i=l.s.r@web.de;
	bh=O4xgc26bKTByuFkbS6jNSpjklBw8XRjYq2TyCjHWh84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UhoqensZfN4DKbUKZJyS41dJBEYaWbTR5RM/c3V4MsH05Gjzmaqb1L9UERBYoInE
	 ektuFXlKQDLfhkOHxD7mcOfHS64W4jfReI5RDrHz82DMPYP8K+hYKJywl6f2Wpfxl
	 1eN/pijZ3QysdEgqXM4B5x0hjr1EKcBDMsEEGT/2xaOikEjtsnrMkdqCKffYKBaiu
	 7eP31E8bXPDJFQW6Sg4TuzBmkVxCcT2qszVx1WpaN9X/rIlEjZcClg7dfRHEPpUpc
	 +gC3G1WJQThmU5744rKaJk9D9POld7lEmNMvk15+z9WbMmv+Kgrhwcwiq5P5lsTJt
	 PynxT7t2hlZgfvZQ+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1uj2pS0lmJ-00Jbzo; Sun, 26
 Oct 2025 17:11:05 +0100
Message-ID: <01fb6bdc-7a42-4e14-b7c7-16860ce8af00@web.de>
Date: Sun, 26 Oct 2025 17:11:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] add-patch: quit on EOF
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
 <13529bee-1e02-4c20-9461-6569312bfe4f@web.de> <xmqqfrb6mqv4.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfrb6mqv4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hnVDP1mr/ESG+r3uzxRxohR4VO+HiVQ0ZGB/13zVRUH7HnJdTga
 K/2tJkt2y/umkUQPOuAg5SglzKZirdaG4mgDaIZoIk0400FZJ3cZ/da+ZsoHEEM1SDZImbR
 6YES94EIdUjert8MVJLOeol2EzAecdM33ANh31SqBQxPgAZQEeU4+SDQyE6ViUTgD6RcRo/
 4hgSy8Iq4fZKzNjt+ZfRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IxC42GtuIW4=;Qi3SsWOjKVHgjOInZQvUgtSJpaY
 tLOgmQUYk9C0CeTowlcEB+8XZ1gx/aBugfvDbSAtVXvpqhxBqlcvqjoqes67PwbOHn2PnQO8L
 vQxANih9lC20aKXBGNTEg6EeJqp/IUmBs1ZzL8OleYEY3DkVyWQnzn9OEXB4KJguzwpKLOdFZ
 9vMa0FJUq/vgXGLGfr/HgOIlG5vIABswMh4Dg2ODeCVCM7Ohun9JT1pSrpou0mcs9E7vb1Mjr
 i3FUAPImeIjdI6LeHXuZZ/bWLnuYnqFyeU+OvSzSxSiZc9tYGfaDizESmqB/7AhE+NB4WodO+
 eM++jwQJk/Pu8/BxARZKOzFb0IbdDDb0Vl7RfFBHzbPbveDIe/NgUO8RJzu7NYvaBbYoaOAvf
 crik1BVFNKj9BsbkfEuUNhiLOExBAB9NpNl6M7sLx5dJbKkvg8I6U7dPFCgCbOjvd7k8q67TT
 JqR3zd0c3RqHS2TSbG/JK7k3j4GEUYS1t/3Pnokptf5MRafh+MCmTDAk6RJVt/9/sWvzNToYW
 dgXF6OCib8sED/ATUsCmKdoQUIdxavFfGOuTZJN7Iw+m+P6vqWdVANtcUFNzAjTMDUtPgkF5T
 km94jl830IL1LfnK9v9SIm8jTl/S1tHv8gnJWWSTzxLgVxwoZsOwaFyGfDcW2yF1B/tNb/i7n
 Wmnq5/cTkmCY/ZZmnKqRRaQICMDH9ZKVGZZRsHgF9fKwx9h9dMu3NZCdQ8+TfEDfc9E3i0pt6
 fq2y9M6eIKSZcv7JLY8QLW2dx+o9526e19imGBSmBLESTeiYbX976QbiLGALiuEEQ5coFVwPK
 +HHtFvVoJP4WogysURmVA9I+elTJpsiE7MuaW0O2PJq8lfzMNQ/IyQAAmNfgLxr3AP0+Pntoh
 hrNuHqJCncF4V+r2iEGb0Arw7DfBlsMnwKaQTC9ONRy6jZKKaFChO4DmvD4X5x3DL6zwydtMR
 GrFlS9xTcfP/jWPzIvgjUNn63YSX7hMyBLp1rTpmMJEWkKEksk4de+SF6Vx9cXfsrbAaB7PvS
 K4RK7QdOl0YAr4zrOR7uwoi1uqztXLTSPqZBMm6GEFev9BgS1n9KtzF4bVIWoJUzZ+uu4F5LC
 cCx6fbMUsSKx7EqgGDLM/2ne8vuNSl4YFA29/GJxZFYx1jehmaFXlDfX+tgjaYgV5nDYuIi1w
 MqzoRXuc0yD23LiT521zB2omaJtAHvWl2g+9f9lNL53kNGZvs+a8RwNgm1bMG4Pr/CypZpbQz
 xhJ7YIMjBhdfFkPbEmVHBKwlvoiAnquR3BaCMffHbUC/GTNsNUm2pPdCPuqoI/hB7Q+9HQV4h
 2LzlCuUSmqi1UCr/5HkekiYbd1i+vjYkNk4rPVlN6ZjFJUctj4YxCT8RsC4cnIKnPEpQefkLS
 X1oPphZmVGciQD6l5aARgf9hH/HNEkRR5R8Q/QoBFB8IPRt9M6EBmMXIH0wVssVSaPHzIIPYA
 kdygVMsYQeo+ip4HTwkBY2NNXmbRzdq9IyW7VSsgxgAZeJvvZnMcXGZTeeHTxV1y6luQYxu7Q
 EUsbrpi5gbXHhXI4vggjdw+aeWW7lLY+sw8GN6qKZd9OH01FkkxHPWr6folm1ZwPxkJJuo3Sb
 RuMa0Awn1fbrHYBi8p9ynONavNKBxRLlL3VWn+/z8PoHywhLXOD0XqfS/tRPETlQBp0WqhWsD
 /ALFSp5QuvO/LYd4eVeHK6MYCsQKQHkKFBlsxA+kR1gXWHMt0YFso+gZ85lXvgg43aL0Djpyw
 CxU+2JRq0O0cBmt+oC7GU5Y2joXlDkubcwWlrapr663QEMn7JCVyQMLbXzZWhusrfutWOyhpZ
 QuuldwlD+kfHJTE2J6OEJJlq/zoBDU0JVCyQ8oh4ALujnNhWuigQGDrd1HemnWvAxUBbAeKZr
 8OyStHJsFOwZ60iunAFJLOvKPzJCSwL3LcbVeokPmsw2u+JMgjjoPToBzLG5UwsTvdhdTSx+1
 LjEykbPaa3J/1z5nZdwbIN4r7YtWrQ8BNhdWuTkmFWuqiZkFcOS5xnIEN9QEe0TV0b+0lDbSv
 LAWHx5Ki+eU/HwpoLjA6TSZMamATWLim0tFn8Q0I1L+ChtICqsu10do6Kr/1H5v9c7HCdhv94
 hVGybcHFloeC1yPIN9Or6eMd6FK4f686gX1d8r2lZXXIB9EWRtOeGi4U6QMYyWd+g8HJPh1wr
 J+Vf2jylJ73D2k+SGVsO7WxJzYHbfvbuzueEZ5h8FNffN9BHynGBXmG/gMHeJXh8cBmpKVWJo
 0RXBz45tFkfW90BXxggpR6BFNWYh0CLsb0TGE9xgp8Hq4OWhktSTJBtdcMLSAkYSr8dTnxKey
 kImeXEXG1Tm22n55cVYZtH/QEZuW7EWAcIZBhsYWq6Drqvb7WC35pwxW/BIKm18T+8qNGyTnv
 WOwvVDLWzKy2W6GG7tABukRZNFvd7Mkc4DGmuEJIZ7zvrqCvP6Wgxx8kw/XnRM8Cfa1VmKNLG
 EzYxlQjeIUJQv3py8RgEr3sQBXTWljXDtLD+AT6yJDzPcq4xhNYd6V0xFFLlovnS5urLDHALU
 P1Up6B52EK+iIkIVX5dMS+T+HlW/QjrG3QANDKJhbI5V1dxiaWc3fuRdrHO88LNnhSst1N8Zo
 7gHuTQ4DpSQryF82fvvJuIUXXlPSW9Xzf+3VW57Ucf0bHTzDEQ+95ZgbMEaqVCpKlbWhagtiJ
 rWGQ1IKAoZ7lCsAKBHLK4LapLPqhmUthZpu0Iis0LSC72cvxU6wR7s8fmylfXv0EqZhdVAlzx
 x4zOkd8g2aLa6vw+QSiOlqfMYgsMNvNf8t1nyZ9era96mvzKSJkp8qYmMN+uT0wsiu0xdeXMR
 Ot6acWcotX70wiY4Djs17L33CRc4tlo0ziVVPnTEJHeAhHEZh5I0aiYwlMOzK/tv89/J/jMbG
 JA7/YwPErSidyzjZtXvqo38YGSIpvYqW4e0Qqmg0RmQFTeLEV7WZlguTkZ2MgIg0JDQWu5PQE
 eA9z4sVqLpsp5Cg+25D+Q96cduTVXUMjy+WYjDCEMZYZuRiZQVeAQHmwNcFKMI3bzuY93JWar
 19oy2rxpQ+2ezguTacnqWxu8jGt04mxhWA4vFSYZ/7GbkVmfm3+TCIrMrVjo/tM2gbct7NRrV
 /KxpVHeXkQ/kiB6TxI1XqxFH+62eVxreNZ5y3d18CwdqsspDdJ4i3jN35o34XdwHeO4mpHTBr
 RP3veRExyBgQzRGwBOwHMfDShp8vy/PHsXhAYVCD7T24UNikf3rSElZ9BKuoIeFRSN2xepmTX
 GuZs/yvbZLAUPP41kqTPQm4yh1j3fb09S/T3vkSqVX71dVHQ6DLlC49CJVjOxJXESUeC8Fyo1
 +jkRUaJg7fcE1afZrM6arKogTazMGpxVth/MXBwLcDvnCOUQx4hnuUgQQWUVODalBgq/eoKpl
 82xOlllTu5QG9ey2bXPvq1NQwaitboIMZrRPqMzQvDLShoZ1I1CWC2ltNng55J5MnyntUMEdb
 MohjyWS5BE7Ckf6jB2GwusLQsrzRZhKe5au5cFvO7nO0TSB3ElBy+HpJZs8T5qKgthRKwzTQw
 ktC4MOk+/13/Pa4puzFtBi7HLIMfNy8OQhfj617tMTXi23/wYl/FgR7mCqS6EGZYWCoiRCP61
 5m1cXmaaYTG9YhD52yZp7+agVnxnysxLeuUTmis3Xu2o4kh0fzYPERtHFNCqyVhFoKNmUIH10
 7/ja491rq2KvnJfJaqysT+JaZOfNBkkng4dFJIM0hRrPJsOcN/tZRj0xvWwsyHNThDyWFbyQY
 MxdCDOvV6o7BPy61Wz/SAjHiq81uvfG7k7SvDE7LGS5V5O0F6XpQh7vIQ1ymA6P6boHB/f8cS
 2Cee5AJzBjQRRTZ+Ml8g7vkZSs1Agm/GGgM7dKEctf2NXt8lrNAVSEsXknkjo6FUeC+P7cXVR
 PB4gS+sNDYGj61+g1wt8zQLV1+3UZI8rouP7X+6en7b5anT4iwQTa0Sx/hDfpfx0K/A1J0iCN
 fZjH+JRdbIMxWpt/VSMJg9lMsep5B9xe2EVhhw68OHMCtyNcba5vLKa88IwM4hAJ3oOsN0sAk
 SUHahDVqapHGfvMuPxh2ZHNg04LDIErSf14tfw09xVbv9QpyzmRv2pZU+UG4AWWBSf0UGK9jJ
 UdHgMmmGtfBnIW6EmsaqO35ou5pverlp7ijND+mX11hR2g+N0wFZWiZH2pjnmxt8hmjjKo7jq
 370VLsNO7F/8EOWXsqzV9WadAChFzEbdhGxlgJRN7j+klTbpT9vygGEnGVgwVMETkX5dDK0oT
 MJZLaiHeVqTlYSDN3qmy8ol12/UalMkn0GFGuYJluGASigTMTw6L+UBTmVpeY90d73MBkmXOl
 UzghUh6g5MQaSLXsRHKzOrkc7nOJ4WJypYHe8EHKG8hd3bDI0lBuIgmrqSSiOikoScU7zU6Vl
 AqrxSbFXwRgwOGsO3TFFwGdYqocHVN0/2gwkN2NNrNoYRS7J/IkNem/rSzC4T2IT+pAHOpx3C
 UhIpLl4SlKBbULXR74nvweCN9anW1ISFfrg7OtNEpjsSbMmlJEKuP82Q+JYzBM54JAklha07l
 4KcwoC3YGvDchbOATIxVF3lzweJuFQzri8v+NrzvAuVFu5dukcCNbxvSypPNbf0eUYePkgEm/
 TIHyP+/3m98VW7yraHaNpuXum8xYNu70gzlGJ084muQQ6qWb2StBbzb7nR7FS5h490kTZs3Bq
 OemFPPNXEcRWYJRh6bQ//bTeU0RzU+RxSNku2Z0eHfeofQVYhQ6bKSpu8vTQLpJIEJeT1A4sk
 WI629fgAaFotpH+YT/PX2L+BkJQdpwS7zbJNJt/zZUW2Og9jhVvSO+f3ar36t2NsOZhlgAyoC
 D8cJSWPqMcqvVTBHcninzbRew259jt5kdAItjurmy+PD4TQncIrIN3ZH2XjMrnXuoDQ+Q8dTs
 9IyKsboOn8jr0AX9FOnz3tcFZ7owGpJLcd4gLEN++/qUQgy8hzeF3+4vYYkIdYAoXIItcWAGd
 3AOwPgB5wEgJTw==

On 10/26/25 2:46 AM, Junio C Hamano wrote:
>=20
> Let's do this squashed in.
>=20
>  t/t3701-add-interactive.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
> index 071b78c355..4285314f35 100755
> --- c/t/t3701-add-interactive.sh
> +++ w/t/t3701-add-interactive.sh
> @@ -1438,8 +1438,8 @@ test_expect_success 'EOF quits' '
>  	echo X >file &&
>  	echo X >file2 &&
>  	git add -p </dev/null >out &&
> -	grep file out &&
> -	! grep file2 out
> +	test_grep file out &&
> +	test_grep ! file2 out
>  '
> =20
>  test_done

Good idea, thank you!

Ren=C3=A9

