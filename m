Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999629;
	b=iSLE2zzlkMTBi/s9e+f7NCBUE1S+7lJqgeYltiTsHJquVyf+Fb5iwnS+ePh045DD8fMq
	 FEn0AGI+oJlq8P3SrvfISzoBIQ5AYqERHY9jflQYB2yyiBFa3RedPvc68t6pN49d/lXPr
	 /AQr6qe2pe/sxCx+ck3mhKzpi/Qwa+sUz2DYjKYJ1jJWpFXRTm28rfa1WJzBoR82uYk7l
	 ztx2zjQ1cofgVNVqNqmcF3XU7klJ2yt22DYumlzvjO202MpUtnpA8tvxJUTkeNK/PQgTO
	 cF9haiAT5Jh3g3z6BJlkX5w2ypRuZzmBCkcgOC9o9eYmCmkq2CPIHxwDb8HpUGlYODw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999629;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Subject:MIME-Version:Content-Type:Message-ID:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=e5/LkA4rJbshljquLwr6XMc6P85JWTOEZ71NH1YOEQ0=;
	b=IHMeKTomuxMBkPWms1jtzBA8A0Oix+jcm839cVDB8AFgsyQKa9HTPRGt3ocEkHukq48R
	 iU6wPmkiI7DZTWiQ7kU3rEEOVV0aSplhS2+b2fgj25tfdcD1QkWCOowd0EOiajfdHYOAe
	 RF2bepJgLPbF9X++8tTJeH2JRyzWpaBxUzm6vlBeACwv58j1I7YioLlf5up3eD3hTdAza
	 Ql7GUpmnxXIqBAHqj137IRTUzxZYFIBQHeXqZc0IyX8MEyotQoDErH+ZIwkX0qUEU2Wbw
	 zjW1nSk3hDze+hD2mTnZFkgyODxIiIiazgjEuIRvJaVMugqoYu7eWAtUi79Y38MdbhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="YPzw/3YC";
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D73606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D73606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YPzw/3YC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792999614; x=1793604414;
	i=johannes.schindelin@gmx.de;
	bh=e5/LkA4rJbshljquLwr6XMc6P85JWTOEZ71NH1YOEQ0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=YPzw/3YC09U4C8srQIP7xjhGm7K3xFHWWFBKO9D+yS69Ta34XVyBkqkcz9S6avzz
	 FfOEMDbLlFJdAf/wmNdVgAhTJKOx+1PCAHTeXV1tEZWlE1Dx1luwkdUCr9PkcQb/L
	 iWkCO14C8azqTmjz9DnYKzBricUpjEujloTOWN9dGyHd7kcaCX5b0/mJN3bf8dhO6
	 YWMxUVFUm1f0NHVRok5+xmEXK6z1vve3EviR0HB92Yzih3YadQ44pYrDINI74W5vJ
	 U/rTMNeaL2mhkp/J1aZWfgTM6TkXf67Sj3Oh6rBXEWtsJX2Vl5kRTaXDrhTyUN4DB
	 TAGsRAX5kaS8KDB1pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1wxgdf3QfO-00Sd7k; Mon, 26
 Oct 2026 08:26:53 +0100
Date: Mon, 26 Oct 2026 08:26:53 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.56.0(4)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <1MulqN-1wTpXS3ljv-017idF@mail.gmx.net>
X-Provags-ID: V03:K1:B+rpK4v9Xaq9dIbOc9BmDUq+HjPjCQA1oar558DxTlAuUZhkvMj
 NnHmNBz15r+U1XHNK3+R/d2JJheBXLpNQrfNGyemB5A9Vyr+otArUVtB4oDUEhTTN2YmyFh
 aWG6wEbhypTXQ+pB9gWRy3/a7j+kOs9cx/nGufUFKhmxkJvK7I2Reo/tx5TymDyzNJWUmWW
 nmtb989/QFHgpvOXqqC3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/I6R4BPIrVw=;UY4UMQtTcr6kZVTPQCzPT0D7LM6
 oMXMN51wkrmVMNvQ2MA30uVjPbO8iaGu1xaiWNoGjOHO523puvgYCiiZbn+Z1IBAfY8Yr9e43
 5HYSEAqyAjxxkYWo12biKUYNemTeDBL9IKMQscv07ijVtFwmUvQ0TA8+nSAVPmHjZHPhXNGkp
 E4WMYMTE5mw8F7XL6ml8iMUW7XGT0QZtKfpSgoEWteTIRf+ZI09nq68TZJ6lGMNhnGoUpSfAI
 MlKeG4Jaud+GnzWLUXH5mnHZ9mFd5XHSR1vv/erGkZjGXWEchRJ/Io8rGBJio5a+0vr9Mdqe4
 srbmz/TUkXvgV+HQ/1ojkjVPFQFYWsShO5SZgbLRgn2FxZG6YXdlx8e/QWv/xmrYEXmGn6RgL
 fbKdxEFN9GBAoMw84Zd2+ccuvBPbQ3tpSOILQUcuIRJkRa77CEc239ykjOuflwS9eUxEzLVbN
 ZbUcbTFiS29QnNXhP5ibCQqyCKkhCe3Hfn66Ae//bjt7xZZhjhWcuoqAa0sXyX5vTvwyuRgt7
 WmQwFdjm8331VwEnszJOOQ/i5o+seAuRx2YTezYbtWm5xMM+zD/A/WgWCpM/eJhMkLInyMZqi
 ea4a09xC8VE9zQs/11Uyo5M+y0iFtqlLwwP/x1CQqYfnHAVzsfUyNLzUy/17iKCuzSascnyh2
 DVtmiH5WF92Kno2WZBNJbraNRZ3fF/JmGON8gaVXZtFWBXs56D3XMaLPWkPyGd9isvRuRM0JH
 xQrOOeZCYlGTX5AF7eWI/7Ux/DJsAwyc54JJwxYiyKHbXiprwfrlqYTtrWODRXcfg50BsyPka
 BCee/KqCkHNXZy0cDZ+ompwoYjgUno8TiQsu4bVlNj5pdVPZpMTviHqUTqhvf6NAoYElQGlA3
 xN6P/CcBoIJJe8smAh6hia208tv0Sx4b1H+FMytBs+f/Dnvqc8/95MCasvTTFXQZv2njDPA43
 rPcAYR4IVt3uFvNirTwiMx+1WTUic4Ra6ldwnIqL7x0FkFGC9Q1ORuBb/Plv0zNyo0pT8GsOZ
 Cl1Min6BRZp1fhOtcQ2Xdiw6w6b0vfExnMGO1ITWAfl+ECX3QJBp8+vasHpa/6Qh4NXYaPb5O
 1WJCw+//TYDoq7YwDyqYSXgSmJgoMmMgNZf1n7lWjKC+ML74PvfXtUN4W81xiBMqEwV7UIrYp
 uQYS8rEbpKdSrf/FFA8yWSA1SE7iIKod6HKpMEm74OQI1Gdg04pbuPFEv+HAXRLNS6G9BFRY2
 fpuAsVuMmw/LEzZXEZ3EV8+JqRWuAtheO3MTS2fmwri015sHBXjuB4p98wWUiLU13jF2dnKoJ
 TH2xLdc6f6BnzGqAqUIWhVYtjDSmwhKbRAlqLTBuEVp9NAcpyhT3hs9AZC6vxXrX6gJLQhNoO
 lFiNO6MhLGfMlNFMsAaPzLr9vVos8yS1mDTF/4NpDOJ2ff1muNHUsbMgBXgFTZQ2f0QdfsqPo
 kOqqvRS1dEueCxUe2sh8w69lPF9/EL/yVM2VpBTMbKmlDw0NrUwOtFOokXb36dnpOPyE3KO+1
 Agjd7NGcSR3i+UJnEbJkvkAjjY0S/fNMZhJcGfV5z9EEXXTwXNoIXxLqlfeyrtwWHDNAPNX7+
 ICpDSFhC+uUwvL3VsAjLH8zHF4UwYPPJfmzBJI1RvyzelCERVcY2xbViBvpZW6tTqGQ7YF+vj
 g5LA/rt9Nobs11NhiiQTAJkyjWHQNB6SFn2M/qhMnPifp+Db5A2ZQXnC1Y/i/w3ZdNHKG55+1
 JcmST8DnlSyYNwrRy9qRhoSuVtvnMPSPwz30/iutljbiSc638RPIYA+ldPFdpo1vfJRDM+0/s
 QZZDccUInmI8nFMMnhCMFRPZ7dR2VM2D+aXCt6U2egxcFOLJyfqKIhyn6A/c4FYQ5o+aiCZId
 DUKbvXlCxR+Y/uwEbhq6vx84Sf1wjAs7Jb90/00vjPRDou3fYQWCYoEmLDgmiH5MEB1bTDEcG
 6dpuC1DwS0T4DLil1zvE1mH+lGPO6n9kioqWA5cBthMfTPVhVwVamxeT15asx/NDD5V9t9AWl
 1NKJLzUghD1iQLre+anfzhApd642Da6UT51IRsEwPUAwSl9qWu8DzLOQNqfVxDrhNW/CMIQFA
 hurwPBW8UyoA0s9IcNOkmpNSbh1GLqPLI/zZFq3bSTevJxHmpnDDz0LpjyVwfd7fNw2bZ+vnJ
 SnLmqZVch8sId4NSlxtWrLfaExLhadRtcJK/7/jTiUmquT+7kRH2+S130RayPpQVbJ4cJrgIL
 66dc1hHinV5U30H3gvysZYR8jV7EWBXr6OCDCqPy31M2+C8tsw19P72nVqZZmXyngA6iMwybZ
 rnu69w18daiU7ioLsnwAQDF05GgbQN2JGQmavNzTsrI+AhI8WkZClXh3BEf+tMBP2HzW3iF9C
 I8i9jCMmJR4vyKC8VBrc0p+/RVCKkkh3mow5fXISqoM6DcOqu6NSXKWn7rmtpzXXIjFX/VJq8
 ZKTbM4r+1lsSdjKPXLsEsQQlDueF1giokzW2AZiN1cO2eWzV99hx/tXPjy04suaLFAnHDQzYV
 ZZAtQVumalY1iuCmqmbY9nUxyXy4G9AxCE0RZ9Sy8L8npyIZVLbwqk5aSa8MSWHpYsCrrRsfz
 uoiMHWa0bhOZcKSpzy+Zd1yd3hGthIcKn2FBvYeT+OWQLOQoRuvofS8Wuh5PdFV6cSqA5EZ9+
 HyRV6N6ke2TW+YBqSHZQX6HJLyv0h5pY3GdjA4PzUfhjL0akFbT/KQzyG+GSfRuYCd8G4rA7Y
 prCI4INuHZi1ll3bxhWghZr4IfWFnaQ1U0Va9375g/4pKvDtH0nMx/awyr0Kry3jqsFfNlSux
 apYNz7gFGqeznH+IUY3AT/3sTzmsoJBr/IHV5uwjy91/6e95kgzzCN0M31vWoCsFg7K4zCTgZ
 On6JTeRSle5cmhPuFatTa+JcwmQGuHht9suSURF5mM9gDKee92L9VlqY2INL2goM9qBF29nhS
 WxojRV5pomR11H9pnY5bgzxoWu1hFvXd6gjS1nuzGZoH6jUvmL1VnI9lsmqHTxXOvnWPOHAIn
 7AN49NW7tyFHKvIw21fO4B8gVnoCTNJTGHIZby+NViAc1QcpEQcw6cnzakEaWwbK3zxeNCCp+
 CmC7r+4MdK1tzUF9qup99L1HZ9ewr3GUI6EPZ8UHp2K9NyC9xpdhDsyF3DotfVNGz+gQjb4KI
 WQ0Dxiw8DNhsW730C/i2fKuwCjsUNdIx5qz93wA88+y4FszlyYFSLSY+3ZjG54UNXPx/s1n5q
 6VYm6CyWx4WqFor/ip2evUXtJL4YNDPfo4GFkjB8TyBQJYCvD84S2SsTeM86PM1HRmZqD1FQE
 EVfUCYRSXEVhLYVmw2qh+HyI+EH5uCO0yB0338Q209YCRtupK63BUJ44kDbtffBD6BcuWviFx
 GZM+r9W4rZ/ymC+GYohDglbJ467vi4WeiTFO0MFJVYPiwWMNTD2soXOD7H3PJGm9QJs6sSbPb
 O21bDDqjx0x4X6QwO9u0XGr28kevLLwXNWyp6uBK/RX46giqsOn3NfGOkKo+ifWVZgmm+cAw5
 xsWMYeSHBBsQ0aRYhhblHAaYmx/9Nuz2IBpfVmymZv2fHWIhl5+lMznhCafhdwTsG8oc9oEqT
 F8zTFBn6UPKelyFuFUPPK+XQWkM81Wpx1jVgYjN39l5s9E2f8EXMroJ16/Wp8qQaQvDqzD0I4
 tR39IUeie/MdcQaHilsdXUkmNUzYnXHYmzD3jaiNahlw/6fDXjgI9n+RfmU6It0Fl9QBXPjYI
 ChCEWvfxC/JgDb91K47j+gwXXf1PgkQgRwL6j5DYR5EsKSeEalZgvbrAYPZ9jtmI97ricqZ36
 XJWzdF95GXKqtW7v3RrDbSSBUJ6D3ptV6Q0iH6reHxl1PrOv+HG2e8Rg3BsZ6C5CwsuAtaepC
 sgipUfzqh315459eIKUI64vQCzeR/Jdin/zJeFhGBDZnwR8SP0e6NRwosBlyw77479ajdcHqx
 HUdbszCdFbmYY2FD9+DeFLDy9vh6hG0cSW+nK8jWZtQRbu4+DtS/1AVH/ShPJvxqlfBatQGAw
 Jv9n+NA6dE/xdvyNRZHq9O9stT9Jcrt5MmlGTGdUm6nOXjxLvrFD5mMkm/Pg1HmT596FLSiZu
 XfntZ8x0J9RlAzXUhDzYCjas11Tw93CTl+yio8KfH+Pe6Zd221a7jfTjHuzmZbDfYkDavTnwV
 aeMOBK7/VQEamdbxi22HJWlo49CcM79uu6Rxp59CK5bMPdLsaXS0gUwPcDZ0QQYGs0OIkHF1M
 nWnQgVZ49urSnS8GTC2oJjLjTu/Ng/b2qOrl+t4JbnXse7+GZvnsgW8NRdsrW1zu4SzwYuzPe
 JENiOftokUcsmHiZtPzICx0weaxyBBNyFqKL/SwiSVq5GG379pOl6PiSjP7wo86fyPFQ0K8z7
 8sZuJ9YKfgnsAcwOHFQ1vJc/ltcYIYUbVimWsJVhYHv1hZ4DCR+7avLl8Tk7owqcyS5Lab0zN
 wR93CyVHcX6E5Iz6kgKytTwcH9/mdHzaIgg6P+2yeyFY1BD2f5NHIKnGtYh3o87H8Fx6V/31u
 Xh00iH40Z0V22AOnMHhVY6oNrmWxJuKxf0AmWc7iWbS6e8RZLt14vN2QRDIJv6q6rB/A3JAWE
 PEnbgb0EO58gU1iarXCruDi21MOfyX9KHvOoepPRbJikCAgC5Yow0z9W4sM2t/wtMHGVHCSt+
 auWAp0+wtxqAWZialQSG0B17WELA9pu71ATzTPnh9gR5l9WhoiUQhMcyEsApHZ/yX9+nnegIZ
 rbEEdtmdlsZInoEB+9yMucQHzU4aUMDr4gYhaPDuIRjk9VwSxFeAMCIA8298IqfElFLOj117x
 B4lljnDIIhArW4A9Ovql0ie1UtVLyAKAIyfqypTRyU7x0rG+X8D6ejBkVK3H+AbUvmHpmj1xZ
 r5vUVDcYGb+rU7NHsLlGzUY1rc9HbM+JOsqsLUwA1YmfcrWIXww5f4env0DzfY/fl9cBfK8HX
 7j4IC9lp3BVPQaPGomQ8Tva2TkNHOANM0t75P0RxMn3caurhoSPZaQG45c9r08I89HIE7tYLO
 2n2AVXegkTInMjWPEDLUalObbpVxxs3VoMY2YYvUYOdW/5o9LIfW8rdrizIKxiaEm6cZtXqJU
 G1ZIhcFB37PS3n8UBLzbUZgZirinPsjwT1zk6e39kqDXxUA8QZCr1tNCYqkleLullLS12Bb2z
 CeiWKY9tPZJ8AP8hQd8vZ+VsUK+6axhvhJOuGgEVK65cc6pSMazPF9Oz8JeauXMMZxz1Gb4uS
 hvrqKjZ3XWjG0VyrhhTa7IxyCiPJGkQDXwpAuFM1cNeHA3srWMH5N0gFrsJRrCuZNPJH4LSpU
 ciOJb7hY6sOuiWwdNKPk3TfLSvFnIISh9n+kWaIrtokhn1fuz34EUUmwKj9pAGD92oeyDooME
 D2g+wvmAmlc7Vnc6HvL+3rNkzyEsp8LBFk6bjHpf8EuVSX3fB5c/g4JyIsL3Kin+jUXj1ekVG
 SaJp6uWpXzQ54x5TDa04P6ayAcTU5UBS2qgrF5Nd64so7G0Qga/7+8wpC0t1NWVdctWGVQbuQ
 sFuaoGASxOal98X1ahLmC7AhkK5LBkA8Ek9X69enveaLKK0+vZwInknfmb0kgZzU53owb7hIB
 gqI/x+o+d9xMITIJC94+6m3aKC4X3mxWsng48nadmQr2liGu2fikYJHqi20QeNtM3FAh4FguK
 YNU6Z82ix6y9sftsdsZShEhTnFZ9wT1qiJ01xc6Z6uItfnTmAYjnRtOdMSRO3diXoIE5fHgmf
 30MJEEh7KVpYbtQI8X+bzoZHveJyKsJ2PSzSg8iPJA1TN7IxnmgUyrQdLCSxpxYgLJKd+uQnz
 QX2+oUunIuJLqEpQYZ9152zTl1n/ChR27YsOh+d3R2J/BKc3fMEsJZsAcmf63fFltSm6ZvPHK
 NH1033z+yCGPN1noNSRBAvmnlXCqvSXftzEd6wlHEOvUXdwdBl4OoxB80CWK5CDs2Csp4f22e
 bNJDEQIlRXJEjfgxT4gMfXRIwQSaGJyd0Zaf7MQLf8vnwzISLOHd8rRwjONGFHCiqZQ/J3BIc
 CZbct5sUeQr+VG1uDHoiHTi4QxwKgrxE0bOQHMb1JqwXqeh0BGYuwVoPwSbcTFIHtkO1XXiI2
 mPrWFeJXT/494CkPQx2yEkUyqk4MnGuJH3rPvUbhESDC2vekRInMXyn2ajQpTSumeF3BPs8Da
 vmvjzB87QfAZVuoLaEDFTyFYI70Ijty6W64yiyrLVBzG28QAXDuVLg6Tq9HStdZeZUk5i8nCT
 A3CUIRnEmSkBrCULO5EyMq8Cu3M3JwsfcGN6nyw+E6W6aZ6Qd2xxvIzKZ0Can4z67bd0DaYvE
 9vGtRuHWbyP5DrcWVGyJnf1bAfEXM99uWW2WncCp+43+WrpHzVZrZZxI9IhSvMPjEppYnSuWR
 vECov0raiQ43QsJbzwp/Lxs74ePYYeU1f1cajqT0c4bUfkdcbg1LYl6/i4xmSNRIx5mLvis0/
 HoO7B6ygizvRhJ32vfRVCNNDVbM8Ujqu+8jFTjLCuUnS3/GMV3aYCFbA9iITIcg8mSaD4UGvh
 Sobjy52BO4F2/rfhBCEyS2F67c/jXsQAoAGBLYTGYzc+ZO9kbsL7VoZt2u4c+397DeMIc6OQ=
 =

Dear Git users,

I hereby announce that Git for Windows 2.56.0(4) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.56.0(3) (October 22nd 2026)

This is another urgent security bug fix release, addressing
CVE-2026-111497.

Bug Fixes

  * The executables included in the 32-bit MinGit had corrupt
    code-signatures, which has been fixed.
  * Upgrades the included brotli component to v1.2.1 to address
    CVE-2026-111497.

Git-2.56.0.4-64-bit.exe | 4961a4a8cc778d8b6e00a5819e5fe4d078b754555aff7aedc2d77a5d74c2de80
Git-2.56.0.4-arm64.exe | e7dcc4adbb0eb373064598cd18bc75e60128707d816ead51cd9bd98e356f0075
PortableGit-2.56.0.4-64-bit.7z.exe | b1f3e52216e2ed6882d1bebfd4d3fdf319bec40d2edbbf9fd26ec4fd3fce7ed1
PortableGit-2.56.0.4-arm64.7z.exe | 044110f9d951858452ddb5e4b5415ea0f2b5b2598e794d6fec77fe28b9aa8cc0
MinGit-2.56.0.4-64-bit.zip | e3bf78351fe777fba47ddee5950082f8a98bb0f02604fdc7ba3ee2cb68ffa877
MinGit-2.56.0.4-arm64.zip | 70f7649f78088c1db1d2f3571ca46a04d5bef06e4e9d56d8ed7f9829e8c6c4db
MinGit-2.56.0.4-32-bit.zip | 6b3d71c7536d3c85baebaeb26d461e74c755895ccc1f4c817d0e289470419ccc
MinGit-2.56.0.4-busybox-64-bit.zip | c4f27d9356ef471dd9fea1f89e5c176cfff7c85b29912a00f3cc7fb59197a39f
MinGit-2.56.0.4-busybox-arm64.zip | 90f882fd91398dc2bd00f91af32401425815dd2f049a95fee68c9e783c311c7a
MinGit-2.56.0.4-busybox-32-bit.zip | 62dc9ff7c421a0742fd6128d91e9ebb2ec035fa21db6a6a2de0f2a018ca7831b
Git-2.56.0.4-64-bit.tar.bz2 | 0dae059764ba7c447c9604eb6cb0f4afaf2d90b003ecf1c8cf2dbe5a13e4442c
Git-2.56.0.4-arm64.tar.bz2 | e3903db2fea42263b4df0d2f581ca8e07ec1c7c9f878156a8d01284f35011642

Ciao,
Johannes
