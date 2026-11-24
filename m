Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511758;
	b=MSef5Bq/WYbRmgMXEJ/JNrbYUA6ULiP1K+XjPqsR3h9pWdKghpCLNPgzxyBP8w4nJm2r
	 iLnUxiyviPTxaRLs+Uvw4nDVH0MNkr0ZusPqMZP5nwql833Z2FszxJVu+pKXskE6tBx+q
	 2aHNWZSIbAguxFWPghSX+0WWmCj5j3Gk6ZQoAKYHJSRggt9hId5d3R8Ewtw/9VXwnLO+j
	 3SrYhdCKCvGvyVhWVyahFHf70uRpwIFIyj+38nVxQUbLmuACidVZnxisreNG3R0NzKv9R
	 vk6O/G8HpT+m0xX0DP4Y6EOaCjv1PtqlVM0c/J38awVKsjQJYOq1iUtf940qvtfvixw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511758;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=j90DkcYcVvTSQ90DiOEntzzvbxcfyaIaWaHM9MQ1mng=;
	b=g5E3ViR5GpCiBItz1EFCBS5GrWLrX1T+i2RpkY1IamEM8Aro8Phl6hb0U4nY68my69Ic
	 tLqFTFFv3APSzxv+Yuys9l3er5A4+BanACdx2KumMBzzkCwbpCInC5I+DOYMm6cl8i0c8
	 1aB3XkMlnEycg9uJ2X/VYiCZQXkflqcPypJEj7Hmr8havw7WnLJMOXd38wxpiApFieX/Q
	 vRvzrpVH0EF75Fp/ZUv9ScD/cledc3H2EhvcSCmAAexAja+gqfBSirBpTfLm0wNY3ufe/
	 99uLSx4o5cR4fYZmF+eJ63dxUGyTG1boCFWYBOmI9AtWnPu8cii3fL6UK8Pe51nQKmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ixgw6XGa;
	arc=none smtp.remote-ip=212.227.15.14
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C22606A32A
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C22606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ixgw6XGa
DKIM2-Signature:  i=1; m=1; t=1795511750;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:XuiOMQMHO6l1tVtbvWPV35cl2gqU
   fmW5MZaK2O6d4edZ1CMKf1UHPAUqCaYDF4K7QtNdCMQRCBcRoly9E0C2bt5ryO+VE8vjoZsATuI
   EAWpfGyJoFGyFXO9oWaA1eZEeNrY4r/vuFxhABjJERFCQhpFcctsyHdj95nymmsGjvuxtVlwAKx
   Xl+9AdTSJOqYHlSy641dkawBjW9uTBvPBvsmvo6l4KQBK9criVALfcMY2ACW2bZqYY6GQx7BHAf
   HW30Q8O3BRJOS67N/Ss3QSJISjCsnajeST0aiZ6P+0a4Hv38roO+gvPdJT3hBQ3k6EMJ0kS5J/o
   OuHXC9VxR7kYAQ==;
Message-Instance:  m=1;
 h=sha256:
   KkA9IOlVWvuzhUWeK3Hs99adsUb8DRd4BQKn0/umNzs=:
   3SltnnSYakHcTj9oEBhNOSlkjJg/MpeGNesuYKe4YaQ=,
  sha512:
   zfmtN3HSx6ar7Bp2KzlIVGoDeSRr3S4CQ0q3uxulDKkAZHPOgKKrcYDxQUw3r7WfNikEx0ieZLn0ZobrK/ITHw==:
   tnZvWxom88WYR5hh3QrdzqshJO+NdR9BMBqRP6HZp+mHlZ7RnIT+c7o/BMT6vbouXVJq8KHKzXScwgnh28HCBQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795511750; x=1796116550; i=l.s.r@web.de;
	bh=j90DkcYcVvTSQ90DiOEntzzvbxcfyaIaWaHM9MQ1mng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ixgw6XGaBTouoCZ/9It57Mx1po1C0ApAaSMat4QVLN2SEdpkjcgpgbm50JQxIG/c
	 05ROwQQLYY80LGfnOzz2ndBAWYANyPbf6cDa4ENKXKGH31MwMUdthbqbl8HonSzhV
	 r+VUylY/s1x/cOUetr7lM8/e7L8wRaEqUf7RfKpO8xJXeUW6JPnAHUviNVE899dP5
	 cfI7r3JGyUqg0x4rwvwJpW0Fs+3dQ449M5xtcqHdIvjLdEvVsHQBdkrtkkDgpzC/Y
	 fP0SMdOWSab1sFY4Orq/SgubjDwHc30Wojk0k3gQL2fwNFrBCjBILYBUxlsbaugHq
	 FTMaj7fDgrT6kV2ApA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1xfinK15bg-00BbbM for
 <git@vger.kernel.org>; Tue, 24 Nov 2026 10:15:50 +0100
Message-ID: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de>
Date: Tue, 24 Nov 2026 10:15:49 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t1501: don't reassign EMPTY_BLOB and EMPTY_TREE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s+72CNfyE1GRp1JczgGVcbFDu1HsBG6CnPP7mi0DXkqnJbAZIIn
 onr6ALKgVBgGDsx3zyKt/QIxrzm0q7YPNSY8XFaYqtomL4oIWCse4Wv8ykvAcIIcDkSdN1H
 /G9WI817mR+koCOS/1d3TtEnmoUutwMXyhw69D9+Yl05Gd7BcLOVIRfFKFXAG9Y+J69BFiv
 QGo/YtLqAvyOU9Nz4edZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IrzQWiTmG8c=;qZRFM/8NW8EWeINCv4KsE2b5IrM
 jbbDV+m++fnXPBLUCoAH8IZQhbfur+hp8Uk3THbZPAy+eog7QlgMktrkU8nDbocnLqO1vs4Xl
 Z9Vy/dDJihFvit7vKLW7RSgN5uVsUzR7sCewGJugz8it/pmIzxDpMnF/7rWp8SYLeYQqcnajI
 OkBUZa6fdFRk0iyQeo0JvqKBxJd+YSJwAdpfq+S/gU95Oj0xaU+ndK9QGEclgqJZ8y2/WP9M9
 onwUgvsBPHgtwm9qGWH5RAq2c61DJFiIqpLDpriY3fC1Vnj8aZtVtdl8qX3MSvHJeyMLXTDzh
 D/KGi4Tmt2RN/m/ZtsJox/3H94HJwKbPkBGmSx7MC/XmyYDWdv5u+13fETmi3cRkqF9Xe7C8O
 HHjsLE+zzGCFzb2g0OKK3ddy8PloTaRHlLp+4YHzLazKJAcpgRUxTXbkltb0SZE998GG8QrK8
 lJCA2norHjTnnB0R8PJnhjp2DU9UzjnJZpvmlTecOgLor+d9OQCOiuUFxBUIXqRyZBUBpl9SX
 pCh5iBiWLIDL8+Z5UiuW7CTpzeyOKy0LzrMGtkfn/s5aAzZlPN2mvsSY00A2oWekyrnW036Lm
 kyOLqomm9GwL5a7KDxv1NL85zOwl7xr+s2B/Cb9r1Q2ySojmLzpgy6z9AdjfWfn+MliNaEiIQ
 YWcHvFsiqn4JSVmhAjA7+ofNusADccGE/ytJ1Gc0dwUlr8I6N1pIT7uxaecKcPDvoJBRBZfF8
 2eM3sCB5vlv8ogK1hbAeDot9SnVt0mPtvIzNerYaJU2Gs4t7OcQ6hXHxmbn0PLQCClTiaJuQz
 r+sq/NBnDVDL2K0ykZnp7HklGgst5hMokj5ErSvp4+mptEmTGNqPaC5YD9rNIcUDpjg3vcoOM
 /q6wSVAvCqHxFS+VWXqJ7gUo7k51Yj/e4uiae2ijg0dG+gWDmg5dqKO7LP4SJUGrigU8Dj6PA
 zwFhHKFih3ZfuNCDqaCmqhRjiodw68LpRMAeXygrCpWGX7AhrKy4qrB5+X8Pwe1M2JtyXjVBD
 8PV2ZzyKlu2ruwD6mNQKd2QxFcve/TdJ07vyqA5Mrdl+KoVZQBLZP5mMWhGn/512iZr/Wi1iV
 UfR37cjwXRozFlnrmGVUe0nzN1cRjGXKaC1yAZF8QvmVpdH/Iw7XBuRd5EsexAsa6WeDjpp7K
 cjuIL0fudT25miMILIrN/xWhv4EDz31JOVdQFa4gHIYyZkrxW5ixlBOTNJssyWIIEm9fDLmOy
 UMh48NoqwtcjUjViks8Oe/mX++FoxpBmzw5I50Ic/WiYNBGSwFV1ksnGVNCTV0TnZHEilzEHf
 C/SfvdLk47j2ejSU4hcrRiGoeR+9tcuKQ4av6OlC4sxZNpZ3+UPx6EI4EgZ/sJHgRd2HNACKy
 +stodN61Nq2rWJM251RJfq6B33riFL5Y+3Yl4zwEBzRYx9LacdT0JgCJMYD/g0XZPWHIqvhum
 k76PvpDxam0dZ0/T3ZwWNyi+q4mK2gnzE+8FbNQ9Q1OcW4gP/9AKhYjK0ZHmt131xHlcaXKLr
 YdNsaXvQmZUomKX2v7kkeuYVCSkxEdjpvVK8izJxJWLxBIbUMzTaPU3mcHUVbXM3wsg4KrgSX
 iiIHkA/Nstpqv3klrXmZgKcbk3KBnVRkEwrkoZOWkUugt3u9HNgrkSaM8x9Qlivs+/x9qG1a9
 4Xz4XhqUAq8bgwF6hbH8yjNGQCqYy+qXYqqK9ljsF+FDVfIP4K7VQjZqVIGPBidBfOR04YlFo
 5yNWl7BFBOILJVJ+Dah/F80pztNH4D3UNSwW32fZ+RXcmCZ55LjNXtQS1ZHEb0T87iY/jFC4z
 KoZ2AQ7nMNMF9zsudL7SYY1ohGJoB86YEGoiZOniYNhl5E87F5xLcKe51Dwv+hkctxxMMLNHH
 uQkdVQiir/dyLDyHHuOxn683znagSIg1ZdhN5RHkX3WBUU4TFfBNmafYybEKaAuJVn/Guc0MA
 onkHe+YYJ4qfuTbGeqWNm9Odae9NeMixnAAQkP9sdZxT7r1OO9Fs0dNCMKsUnGBaQ4GX4QC71
 zSPyBjfeFqyKA0jyyCn4a4zwL0p8cvxFyRu5JLPchxY/JPqWDX4VckwTphJINXgyjDO6HMoE4
 sVccJVxcpN+a34H50pszN28w5vRp2DdBq/yfGMXpnemi6tAdeA1eoc4UbFEwYvi/T+M9pflbW
 0QM5mjyh1IORTUrfdnivvK+QOwePWbBx+IrWkIgWPzAoAzAJrFbonOdD/DF8aK6sB8g6FxZiw
 ovCkWcKiwsP1ErTAFgRNjqhADEGt4k9nezSMmMhe8xaWJvrogP/8h2e1F8EVGY2uok7yVxUQP
 N2hk8YyYwUYpEuus7QdwHU9Uz3TLpiM6icQ/mNEWd/1N0KdIq5va0vAR3+jBhr1shBMMM7Epu
 1Me32PnGjtWhN2rO3r2KgCHLAADRXQHzdG/YXby8y3/Ct+4mbeoB/GUiUs9iKWkT36fKVAnaC
 a7yePCRmBQCy5hgfkqY/19j7Pvi8Ep/I3+TWf7zGOb/TUc6oPqwCUPwXiChAXEj6C/YUzTKTI
 rOK6qEwiJEy21ubIcM+QdTR+A1ojH4mq9cek7wZrXZ/UGbmiC8YmhLVTs1ThQm1/TyiJir0i2
 22lrv0tmBejpPW33Bckb7pm5KOO/WhOLLanINMpb3pIpJjMxvBRW0NvYKH3yUu1B2dgc3kzlM
 0dVO5UImmrZbFUozSVd6PzvF5l35KXaaaOxGOG98rVXYsh89TkP9lZLV5ozDtinZjgm2Hkeg7
 sqAER/nzrkCM2kCjOFruaTZgRkPNAa/rCFDN18AoiYQAgerb3aWShxDvRMPwbM/gIpTN/cLDd
 c7W2MYWkIBNiw7CozsCKcgpuAAvsZlvKHTItNHGB5n5dsLnDKgGshG9F8QuFY9IUP4iuJqRtm
 ZVT26XH+xgdGnZZFk0pjdnhThZg1e0/SXVeUuUOyIJl3vqLkA+NsYOerxrXWChr5JZuAAr97r
 ++P4DSI9iUQilcXiSYae8EDahZpOblnIhEiYL1TJh9kn7u5pK1mCZWxlwiB72lf99KxeImS9a
 LsCEPU3snfEYwkQ4mr5NNY1x8AZuGaFGZbI+fH64cMspVveOe8XMuJL/iIuuEurnU1dJtaETf
 sTnrjiyXkb/rroL3DtI9cRk8i5vZxEfI9mrCpbEb+Jr2dDNg/EkA5ei+JMuGWa2zN395/RaH9
 iRG/5+22wkZVdCEoLLM/nvSraOWqchXaBjbF101tp4p4zEFpfaN0u5QRSeQnoyK6yTwtCNL7q
 CjXbx8x6fSn0SCCkam79H085CD71BGDmPYUx/ntRjdKacnj9ERRE10Fs1v+yiCSy6hpzNCHOC
 C2bRvyIRUML723I81GE+uVzZfqe59LpXEjwHO6L/l/Cb+mTa5X7M/8Si0ObYjnalJ3R/m7ur3
 Gv4L3uD2z//FXp+b1Wsw2NII56psfQmpHxcIQA8+6H2YMf+WkDhSnzbIQJ5E9TsaOS4xhS3PN
 JodPli/tU3kPBDjIBhB9LS8BGHZUmp7OMQkHuMgeglR3AfgERxhXSIfQUW4tX6p8N6VD6N5m0
 n/hBC8kH2Htfb6KF2lJok6om3GcQ6cOi4e5ISzMVZ3xmp0Msxqy5fKvRxg8Oor5PaxOb/sk4V
 JhZN8ODBeFuY6mOZmQ4dGAe3r/cqga1bOgU9MSjy/52A5oVRAD20WxTolryAXxDxRMBoz76rx
 7LZqz3gUobEikAawZVdgWWxZ1uc3OnT1P+i6E0+THr3B1o0OBm1VWMG88EEaidtN+NeXeA+nc
 Qp9ZkrZ7QP67JADjYBsyXQxjjcsUsiNVsO5YE+JWIJmWnD5tKzYF84CtvzK6dwtdJcepxA+iP
 +y4aCIxg4vy9mNUr7gVTA8etqhc3ErxegJNDaE4VZW5svDisnH8NfTD+ZDgaoU0DdolMNBpND
 n4rUe3XOTKtLIEO7eC2s8ZhmTQxQWIutvFbFtJfiyls5uaR+IDKW7lQGdvekFochbObgMP42m
 kpSNh/kUESq+pnub9yjG0hIphUwDa/q+bKlli89+5tPV5R7cDpFY1PEPq/pEmGcLhCBP8ZCIP
 kqjj2Y5ztJmXvow4jCTxF3cyS33g6cQIW42DRC5Rj4xPrEAggcdE29PLznxZ7E8TSNoiVD1dZ
 UOgappAndEdsnYGIAXRZbHPvfRmAQUkBJRW3yIaUFR7Us3BU2z28V77zscuNDZTfTGc/uSVXc
 Xg4002VjCg5iwFNQAz+5XQEHeTAEAHVfKjfjbDEg/paJyODsd8TQTjMdGuDJoRy9/Rc9YB+ji
 grA+w5t3DmuiaeLs+75TjV7mB0/IGxzwkkUqsvW0bZlfBqj4PPErurRdYdQQGiC/yr9RfYGOf
 ipRonrOIazLPOpHS46aIkY/1Lq3zX3v6aagOkhKkg4WrxpuF5VPQ4XeMJC6ZMA4qmlC1VYvZL
 vqA/sLLoA0JgSYgSMlijBB+lN2yQdXTNPcwIWU8torlMIkHz/E8OdP7E/0b5b8SjRFicATGsW
 G00jfw9tNtqpaS7pqqpiV0762lP47fZV6oJtGzNSsQjc1a3kJxDItVAWVze2sxsZlrT4u3Hfv
 hdh2HE+zVXZMTN0wp5yjask0r6xcD5+VQFHJPEW71OV6VikgzM11x1J4Bjwj3EcVV6DfN/cCp
 YdC1UyTZzvWWeBIZgYNBd4/dX++KnAn8ncyiDyVzgS3iY4wPy2wRfIMUGtteImlGxkqoNyPMA
 Ul+FRavpMzbZVwyNbPqE1X/+eIOuBQQi7yfJqUxg0i9Hk++/RpMRoeguxNkrahRxEeRlMQn52
 g9zW+x9Ob1spNA7jXoUh1llr5Xw5h6xoQ4i96EO9cuqEVGskhOsqMspKWPT0SmRKtqpZz8hi8
 6fGufb1RnaMKUeLuSoLhREEmsO7OohsgHT1i8A1JUYrTPKqux+qG0bR2HapTSRGZ6QXa4ad4/
 lx87+f6FFU4zb82Bqg1uNdTLJz7SQQgeyVe51GxJXp6t+/Z0FtZR9nPgsu9fRyfV46MdlwEoP
 Ql66FMWAjG21xqysEMUNqVyzrUDIIG8qw1bNvfmMdILHBAl1roaM5d6DlLPtIBD2SVb3HeNjO
 E8MojTvTDheOkw6szBgWF83sMMF8FIRWP2nZcRl2ZnXgiSdqPupf6sDZoJL5pUHgptx7HqOUP
 hxUNy1CTXj4C0vTDhnLBWaFce1nuVWGgqeb4XY5FDS6rZ4Ho9GkdeXLuLBKrNy9sG3EeZ1iW7
 du8iUlsLLG7BladPAs7UdEHvRq/CQgdlmoB5VkPtRPskQ7PCsFiOC9bJlNcqtKTzKQJaNscvr
 LKvwIiaqvK+7atHWkN0V6H3a311+JShss+Pdo7jlvPYzuamU2O3xln4k0Yy1QSRi7qcZSD/Df
 yRjSvL2LXEAYsgHXT0cngsPAsJOBUgtWxpp0xLTIjPdusnhrHfwL5tBKco1gnh89rTH+th/N8
 sjnvrmYnwnxnKtai+yFLyjHBiztkOndP2YXd7Oh6iFjNWTQYdRuz/JqwMrn892jtlt887A2eL
 6Wyk+IhVJ4XujizoD6ymJh0TU0BrHEgnBBObJAYYrGzi5E7Gulo3IYHP8FJavM8HlKoTJhcHi
 nMExGRsBOK4RPOknHJub/eRoOf4+ob3Wht3E2mU7GUMi5+d4cvsBj13VLkJtcbZ7shW0nWyDC
 hx8YNHlhiMS+mZEzqi79vy9DHsA/Fhp0WDi3xBLteYg7kNY6HPqAQBpo6VXBjls2fVIkiuTRF
 qnGnU4oWT2Q4CE6AZ7jRfF8LXgr/B/s3OO5o26NFtqw81M/G46I+Bj6DE3JRQ6kQ3MsQEqw5D
 N290ZHPxp0FwJUJBZEQbhLeA/jzOD/p7FnARc4StcHIY6gJUIMKo8/DWnCiMwkRGM6NG+Fzep
 9VPMXe3d1FFoVHz/qnMnmblcAmfPsCT/skhdni9WqgQv5eN6xRGVYv95ongcpRqK9Lc1eO3Sk
 MKsovTJl1aTXRF7jcWSVXpsTOqxlKeFJQYG3Bt489d9dx7DYJVWCRqNbDDr02pCXI8A3Ulf4W
 I4LZ2MFhVp4XhrLlOJXWtFPbOiBi3dl3od7NFSASIYsajQlvgtASxsePAKGTFLqsF9aShniq1
 m2s11e3NphO5F2lv3xXQl+5r4+cmtDUr2P0Pc60DDq4AVbRdmrNUGKmifSSdSHzGUnjKuEUee
 5j1wKnTFPa8crquc4jJEqNWjsHhtBgvZ/WLPIXTK4gcdjSgf35hZP+MvbQ7ZZySKRL901dxxl
 FeAymifT3Fuw7jh/6JRJJ1wW7CkAt97nEkPbA6shd2/9qomuO+WERPadPYYh5IcI2nl67wYuc
 D20TXhKBfw9TM23YwxbhON4aqeloLcO9NqvtdqmwbIRMq2Rbp2BGJ7Y7AFiK0jlK2PMasxaLr
 oafjUIr3kPoAmO77WAWTHNbYiqBI6yPInr/Wp83lS/UIWX6hpGu8gqtDkyjKAuNH4iUJ1E0KQ
 s+AOVXNtG7jD0in7AK13WEICfb0tXOiz9wuMHoLFP3OoshoXweNPr85oHEqDbF3/PdT6Es7gY
 UCLrJZvxIdSdenzqANm5UgGGl2ZLP6CMoLZGJ8zMzZFU40UWKw+7KVjRLbRVwqPz1dfpXK2vw
 i0H/6zlGIjJlf9OZhpOC5/g43lA3Ml+rm2RIrf8bOwM7/DnBurMrQYZNyfZb2er1GncFLrJba
 BRILyDDvQpPwbzXBR1gUk6bN3Vt2YOh4O5t1s22NVRAGB9cY1s7xofkAfznfzq59lwOiNJWda
 aMVTOpCpu1mafldivQgSePXTD9p6I7qynRSQ9fpx9gCc0Dp91y+oo/pmzIkr/xkdh5PnuGsNv
 p96MPYHSaAEeOjgmUFKrH1phrZ5/CDxSuJ26EQuhBUAyWNxs3JyDMoQho1QydOjBg2cimv8lU
 QR8YGQ7eqty1Vzz3+Qxau0cXEd5uetAPHrsODYPowx8/H6Mw4wSvXjey93uGEdaQmEc/Pdkdr
 e5fUEuvzPmg9c+h5tbDiv/pXj9hDMuZamkA1goVr+riCwJiUzk6mL0FVoejp6MCjx9FgSjwTK
 VprX4qams5hZwVQ18lA+pFV9oZvoE/V8qSs5nkyDUy4Lk/9XA8QREhdFFV4m7SH5Fa+wW44g4
 rTclNO+MeBaiYiAD+On1yEeM78acpeW2mck1ifEoU5bdjQsRkQo0yrScjXIIw2cI/A1wV9fh7
 x2WbeSVkVX1vKIUNK79SekCOQ+ll8z8zj+1oz5gT0E

The variables EMPTY_BLOB AND EMPTY_TREE are already set by test-lib.sh,
so just use them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1501-work-tree.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 8c94ac2e70..e6f43b0fb8 100755
=2D-- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -5,8 +5,6 @@ test_description=3D'test separate work tree'
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
-	EMPTY_TREE=3D$(git write-tree) &&
-	EMPTY_BLOB=3D$(git hash-object -t blob --stdin </dev/null) &&
 	CHANGED_BLOB=3D$(echo changed | git hash-object -t blob --stdin) &&
 	EMPTY_BLOB7=3D$(echo $EMPTY_BLOB | sed "s/\(.......\).*/\1/") &&
 	CHANGED_BLOB7=3D$(echo $CHANGED_BLOB | sed "s/\(.......\).*/\1/") &&
=2D-=20
2.56.1
