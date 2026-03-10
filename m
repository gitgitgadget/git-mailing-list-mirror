Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D7313293
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134166; cv=none; b=EefXCGE3+dF0Gck2C+s0X5DifZAn0wkohR6qU3N9wIgCtmZ9m9VCXLRzeCGW7D1StvVcS7P0xGdHtYzYRIRgEHoR5iTdtiSHQ4uvOfhWx1rdNTQ0ukq/EHOlSW3HoLRO/+rQ4FCzL1jnVNjp9m4EPSiOe4ZHeOxqZXflLDcUysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134166; c=relaxed/simple;
	bh=bq2969D57UdQLP1A5PBG/0ApmsJWVPPbbTwezx2QwGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcWxoMNeZ3E26lu2DnOWNfpd8vGs4c3RpXtSdLGpbaO4FhvvVZcq7BoEhbQdGsj+qqzhw0xqIqQ4M3SzQNCjTwB5nZyeh21pxAJbK/Jq7ihbCHqPFYTOyqW/bE/+/pVC2kSsjyEypnVgku/5wi256675Oy0llW9r509Lc0gtg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=MDlPjkLy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="MDlPjkLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773134159; x=1773738959;
	i=oswald.buddenhagen@gmx.de;
	bh=QtFEIBONDZcIx0Vq9X1Qu+jm91G+Thj9wnwali1nc70=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MDlPjkLyPlGNCt9HTzjIdVrAAzbW/ukn6t+TRKWPRRBwBpQg0T1QDAhWIZ7hq6jZ
	 S0m4NtNbRELsMyAG1wr4ilfKUbd6/JYGP5ESyLShy8kWz6Gt01UFY3yfigWq34fzO
	 pKDH6Z4QoS7fYXQNwivww4QIX/5sA5nB4pKjofimH4FEhMV3BKrhVDYQHBbG4Naq0
	 MzXegJbLv0W4i0CnGGkI7Zv5uZDpn9205zyCKVud5P1+I1wTQFJsf8V8vSNY5Gr5m
	 eq2ES/2OLkT+bq0zbJ4eO0+AKo3SBaRsATuJ9+8IRUmq05R3xAaQHSmNlBkhWXkZc
	 Usv+OwB/heHb7Ycrqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1vkJHj0pfU-015OYP; Tue, 10
 Mar 2026 10:15:59 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1vztC2-drP-00; Tue, 10 Mar 2026 10:15:58 +0100
Date: Tue, 10 Mar 2026 10:15:58 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, gitster@pobox.com, ben.knoble@gmail.com
Subject: Re: [PATCH v2] diff: document -U without <n> as using default context
Message-ID: <aa_hTifKYZ5KYREv@ugly.lan>
References: <20260309172719.125419-1-cat@malon.dev>
 <20260310053032.129327-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260310053032.129327-1-cat@malon.dev>
X-Provags-ID: V03:K1:xczm5Raev6+mGQ6v+69vw2NjGi7FudrWEYB7YSTeF/7RFffVunm
 WioweKLvHFzEL/ECMHdr3UtkDdY/nz8k9M4EAnjgUecGli6f0ycRP/JDE70p5heoiR+3IwR
 lSVNC1DETxI4NoL7cpGo32hmHIjOAzmW1GWiU3RWTFof6u9Zl4R53aa7Xg1pPsDy5nGaLZR
 wdOcSF9Oohiz4l05+dQXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hj62g0oPMg0=;xzpe5jOmP36xcZovmicypYyqo9V
 Emtc5JyRH5VvbGxZdnv6qkmM04W5shJdqIyF7f8e84xPoe4Gg/nhWp3omVirnedzu6NhPYN/t
 uc4SF/ajD2K0LjZcMOT4vBI38TkiILHQzBLx/qs7Cg5R+U048LmI+1H92bwH0K7OzRh2HyxIq
 TSBxeBAy6XtKXf/nKmgpLHIyPpoXobynXN683MrHRwMicC77CNRw/c/CIUSUGhg8GC8i6CRau
 pOpHIEewtK8wfuxR6rS/hNSYIfp3R0arz7F5xCltJAMEkNcyG5UjIFC3REW7luqav9ZJRh5dG
 VU+dXSTZcDCzKppVbf1FZWzINQ6+Z75sYLwi04hzXiyDwmnDgyWOTd1+5loUrEX30OEzp9Tq4
 NPUxuoQbP31WhXirmm3voExO5LV4c40GDJOtapKbD5sGj5PL0QFbNTp2M6poOaz0Zew/rqXEo
 BRQ9j2cMLGpB8q7PO+ko1Rqt5zgDLZ1ElDNigmL1T67t0ISRW0rYh81vqwZNSI4cSfdQmXnF0
 DvOLy8ODxmc4BmcFUZGU3tbevymtdYO6qnMuBQcvDkojI2kDl9heRDIcpLKAyNJkj7w5HgDmu
 cmdDxrnP98z2NoGFKcRM8qklETC2sTkPstlXAWIimMDcgbOl5XFA3b+RblCNeL06FnWWNIupF
 Ewa3aWyDazo3RTKLOnAJwCiwV5cOc/cgNyGQA//1yR1kER1UNeJspjHdc8aNKp1gtauBbX3gi
 DqgRNq6KlCCEP4RYTJbYO4FK1lXeK6XnmP9XQS2UKJvAWCDxSA1W5lKSv7eLbvU7ww5aVGpy8
 usVdCsIPK6AO8WBtAzKuM4K+gRCs2VC9OLB9VEeledXSrUtdJwDjSbeluAPY4fWe3osb+8Me7
 W7uZxLL6ZVL2wU3XQQqfVo/DZ/K4yaXBkaoVpdfP0FeeqqBEWlfjjd3+vs366H5Bo4w51zjbm
 n09Bt2YDb84+lqjBRRZPI5uTP0fIMH61sspcLdZ/NXenNLIspqmfwzD0jE/WTP4rF/x+7Q5un
 clk4ideObNkSA4KOmRd4u4UuuhhDUea4rkhBkZoDmr11711znDNpJl9vKXb+nFabcLSyh5HQQ
 gCPUrft9R8CtLhQYcUoc/C9L07da7egLFp6iUjX9FVIkaxgt+hn6tBD5togNNCrEgAWgdDxNC
 PvLXer0n0eg0/NOc7Q4agzNBJLiuFWsLxizuB0v67oWaioXb6sfjuJK5K3dSA0mRjeXIBdfth
 v3PBJXLiQ6AKZG/Q68Ks4syBlwiDuPmDINjTELN77fZfvmZISV9U0/paBXCE1ulGzG5qnohd6
 rOYlw/ZLsPQq+lpdZAU81E2nSX55OR1jxielXrGHwR6i/auOhF2aQaGjx9qFlJNvGs6kTDSZf
 Iy5QZFfL0pFlKW5FS408v4Na/BleAesa0ZJlTNHo7dMCFv2EPof5iZf5XW22joD/nifHjNdgE
 +vQjH6aRPkE+bDoKprkKx7t9Hi3AryyDW3ZebuVnSrjWXA3xYzAH8rqYeJnFN137ERqiE/htv
 NMVUxII2hAi9xMjjfA1f1A0tU6TAIMErafeoJDR60U2aS9xm1+UsQlUr6bGCfgpsRFKwiqGYm
 FBWj+1hYVqlhI6OWT+ofrnO7nRS4vt1l/0atg443cBqe38GJLZuBHpFGQgTc7LSzPYricFws5
 HMnSuP9+odfjvoM7y+2AkjjD5J/TDkocMoplJcP4NmICa021jq03sDYk6oSwPmrc8yZc3GQ21
 Sixq+Dw2DDgkFvYaQnJp5JqTpnlgfV6HPZ9ic+l7uws8fd9dp7LfxBjjcwKqUrMniu1tNlTuS
 MJ/xRuOvvkXbRod1ApF0Zt9ba6NDm7VH+IORQd6HsY8Swegv2LIh7QBNsnB06PvJozT4kuFHC
 x7Wo/ttypzp8m9fxRpPZdMZDr/CaevWhCuFevYYRNaFwYzXPCpvK1wBSeee9XSmQf7zDqWddw
 pcENZDsZ4JGmMpy0XTCsdn2AtwxyTJHnoXvxH9OgzISrah642dKfhg4BTZugIJeHDXjJT+1ij
 W53LEVvGFI13R1awWTaMQm9y/RwF6hpWd7+MHMIx6Z7gjNRSaAtmku8iomdj7oPpZ6hsKr98V
 jSxueRkXKP3EbFoamiIr5o20rtN96qQDKj3kI85ZI/wKcDPmD9ZiV/2/2mM4yDRVQZZp3CW83
 rt8MXHCv+Pj3Of3ikOKzdeK7pRWIfeHBDbn6IBj5QtU6jJxD3azDbZ/L/t2vOA1LlgOGf66xe
 kiH4uMqYRLuEItT00Avme9eT3O12vqp5YZdyZ1cVjGgaC8PD6tq+IC7I4OesY+o1HQzusimnY
 N814ogi9FzmUBr8qqyXhSFcoof7yq9ziSO/y4Y5Pm1XOnci2t7/C6arm1q5mkH2OOT4OHyD/L
 mEITXZ6fSYPSroMHqoKVjYSnDtWcbaHC6lN9Yf2/OkfFkK88xurvh4fsiVN6kkU+ejnlTYf8O
 nvkjbzLQ7rF1Swq9Z5EdygehTWV6EHX/Kbq+k4EHlFfdCKv6DBNAHyA0cNXS6MTqmG15cb+qb
 TVcQuazKmyAJYFukoN/SEOwDpSsNCNw4Go7+L7DafEY9ubvunP8jHzVsdetSutFo4X4wZ24yS
 NmZgUxkKEADJQpOAqGw3chjBACvgh85jFOhGMS7fVyUgVkSkAVrsBjlp3/aB/wgs7p/3TwnNW
 VFcImrRRnk/E9hhqAaV4iguikjfilo4iRlqH+cBg90uTU33twf6vOFYvKjd+AiW0gNJ0DLpAQ
 ooh9eotfpJPQq9DspWrxZLOX51PIoCZ5w8YS+IJ7jfAD6T1zTlWd9h0XFrvsAz5nRfnqAmeju
 OfFHCHxbq/ay9NmccsA599UzEAlb6x8GIi4ZdImMwM5TeDV6cVLZB5C5kyfebB1nTfwo7fX+y
 9cBEF6Jn0KxjuPXjMMFGlworZ9i5UU4iRP4+v2ft/Tw0Ppf+wr5SZmzu78WO9jHbZcEZCsiH0
 FfTxn9kOzu/xFAvVJhzTVSE3MF3AsFgtMOtsFPdisGWxnQQ+4XXGTmI9N32nkLGEC5Lhr4+n0
 N89DB8qqzFG0lCfiA57L8unOMK1Y2pRtMYEBZpLIKI7TDkUFLEjvrQNu340tD7nn2XluEv26z
 2ZH8nzx4c3WYdbetw7YTXGMWkmDU+rul1E2ImzkD5e8s7g1Te5weLkjNH+zH0SldI4eKBTa+M
 2YWlyeu5r+aTmnFXHB/LlJa2I8BtxTJz9HHM2VoRwqTT3AQV2xoERm6WxltsZMCXNX/yTQ2lF
 NjYH5TeAOAPI0cAHjVn4McfsZSPaCxqI0VryLWPXM+6WgmuHxTOqQWH2E0Jo85fRA3yyiiRc3
 2VR6pqPjPx/9aGQTllUJ0hdlfCo2zH3x5mQYd611lpQJuR50vDDjHKgQ8mmwe6iM0L6ITGYz/
 5OYY9tNOdD8eXeraaPb39J2sOofut23Vm5PDxQYnCpUlEhDFItK4AAE4R4VG/JWvZNJKqwiRY
 +xzL1yyD+FuyoTxp/rx1o3+kV/PKpS9rI1wZi/f0GYZ18xnW88wUDZ/d49W3ocRlrgQNf95Hs
 9p68bSoOM3eeyiMppIr4QLTHnfKG0NZ22qJv7WF9+M5Ut56u3CQosbqhFjLV6oLKZDGa/FIRn
 GjEZR6wV9UYRuqO9TF98V4zybpon7nG5py31+sWlxpZsV+bTWlqlDwZ+daw4ulLnc/YYO6pNL
 wCAhKUoaxFJpq8vblYacLkD+ZnyHviEsNz4IUKLLDCwaMKsyoFqV1ng4H1KOui9Z+OS8pS+nr
 PPdC5Iz8MlgNFBQCnnL1SiEs6Td4I6ESvGsDgDy7E9zAruGqHg3NtMuwVpJta0XPHv2G1goeI
 J8Pmnngdtos5GsG24526epP4oyyhAE70wKWNcvkCSZqe+nAg3yc4WnLfkF6aMOJ6Xzpug/UUr
 obRi+70qvG87NslmoAIHCEVE+vdZIc4pevKLN9Cq1SvO+y6zRJ62KiHNhNxBZgZfletZ7w/Kr
 NbSupul3DXB0aAsWGUaRUfh16ssedQG74AOCGlFGtpz/vJfemcchJtjHqYaZ5f6CXCzcWUT0x
 BfGY8NMSn9OeH5f8WSbe9Jq2ag/aHzru1V2gY/1jz8XbHXkOuhKAru8bquUxZseNUrVwo/HtS
 8fVieVJXKVZw3SLpcMbYkMptxmsNs+dUt5S2FluT1NqpwptHu8dO2Vq7k00k2ppza+0GGWfPF
 gzROU47k/N4ua91WaW1hm34gz15ryYIzy5F17CMag/K5L38h5jUZn0OEjWimZS8Yy7uhENdvD
 d+uxVBnS1Igrmvdb71a3e2IU2XlP0mhRWEbxzEXFnA8qLuOn05KqhA3fEYZPk96dU8MKyMaFJ
 GDqzjTBVpxWU+myb6jJKhRt9wwHDqRJrTURuDuIB0mmShSisA8IvWGCRGZVwRhBFjrLr4LbGD
 leG6CWZlR1Jke6gDzPWGMpOOiMTePxpg0jHGJuTB1UOg8dWvhsxA4woZrYiULCE24PaGPv86B
 A1qwvh7Xnpn5jGsgngBTSi/HbJzKHymwN5/pZZSX7xZZBE2FEO6qcstESV2wgCCHEnDNaH7nt
 wLgAql/zosE3qEDmyCAFfxIC0cCgVDiKhuTWsRIGLVQxYeIYzu1b2RhEA/fNLAbRq4dPX8SJM
 TcGxeuhNuUM12j2JnEXIJu8KKvg7LdMpHefUEpzP7wM89D5+h0nTWA+gN2N8DS3IYTbigdvt2
 qs65nES6zZFT8HS1IKKgdxXAtUq3Jvw7sUnz0EVue76N1WgwG05ihCjq9R+GoYVKu7YRhxHif
 8KSQoYV6eIwOlRnPGIbj8XTyC9/m5L/dNiJaJ4D95cGsGR/gjOW5MuA3i2+AViABAeEHdcjEM
 sZqYjIE1/mlx6T6NLwQF+RBWpR3H3f8alc8J4EhAfaE8Qi7pRr7s7WlkFNGEY6oELeDF3ALG4
 x8gcxE0t+ihb63c83AgelzPPaj7lvnr8oZiIx8QuG/otYz0hMTX+w0ShXNg3cL/Uwn4Y0G5Pg
 zxJ8iSd1VEUKyCfs54yIkTFREt3umsjV6rCAjD/u9Dm1eFe32n5t/9emxnZuqUeYYsqBdzwaU
 ADaFP/ZDFeRNTTEX6CwrM4cA3zGcnNxlXwaBPDk8Pu5dau5apalvoGyqGNhIZfrjM93YY6Jor
 KAMk5LpiS80VHwtDQ20pfG9lDzIq5yeNW/n36IntvcWUIvXJrnluJGEutMfmMf238D08nJnVB
 Oo/VlFhg=
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 01:30:32PM +0800, Tian Yuchen wrote:
>The documentation for '-U<n>' implies that the numeric value '<n>' is
>mandatory. However, the command line parser has historically accepted
>'-U' without a number.
>
>Strictly requiring a number for '-U' would break existing tests
>(e.g., in 't4013') and likely disrupt user scripts relying on this
>undocumented behavior.


>Since we are retaining this fallback behavior for backward compatibility,
>update the documentation to explicitly state that '<n>' can be omitted
>for the short option '-U'.
>
i'd replace that with:

Hence we retain this fallback behavior for backward compatibility, but=20
document it as such.

>+	(`-U` without `<n>` is accepted as a silent synonym for `-p` due
>+	to a historical accident).
>=20
"silently accepted as a synonym" would be much more natural.
