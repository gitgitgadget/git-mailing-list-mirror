Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D83FBB50
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425354; cv=none; b=uTwnRO3qYVfR509W83TxAd/q3RJmXNStZgPFLlxoUcFGLvXYIQSzrkYdE+w1DHxs6YcbeBpw2XOT+OI4qTnwuolq4rCz4GMDsroyEDGjasFRSo3vghwiR1MLaWCaBJL3w0yp5i4+vGSGIrlVJWjJkJKmkk6TsuNwl2/M1THLEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425354; c=relaxed/simple;
	bh=x82Q9KuLLJHu/h9RHp8KgD+6NWAYPpxa3OU3xwoH2nc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WuvyoN+wJorx8XC9PDFluqD8uMu4hxlkAubATqlrvhp4vvv2TZZctwM3EDT8LeIHzvN4W30SEzJ9rEwrp6yQUJwN4OjaxeZB1II8ncJ1v+RtyZk8VhywNaObybGHrYclP4l9lk3NHxW3Y0K/sT6yVu1WfLHgCNH67EXE7rfdkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fKu+ddwH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fKu+ddwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783425349; x=1784030149;
	i=johannes.schindelin@gmx.de;
	bh=+Ibw+frDzMpeDAecUiR6fSJnajwu/TBUVrcYlx52PXQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fKu+ddwHNf8MAegGdQ2A1FNwr8/TZ0nNeteQWtOa91/sWuStjL/v9k12pAYb1c2a
	 8ZgrRcVPIqUh397hU5F2wOIWb0uh/tpb1qjK9H2csKVObGxUiGFlOqsORtbJfavLe
	 rpTCE5Fu54wC2EVn4HsmtjMZz1YtcSp1brEp78ZV9M1UTZbqBZUctq80K476G/8jK
	 36d8RjIHWxyghCK6Zga7puOeYjoz8ObdG0HYWqaeysxbTFbx/zoqoeBndTYSdqnMY
	 Y3dE3Xe1HVxpnyfxM/+8Wjunx85v1fKGGSD0J4gnbbnaCMrwlzHzLs57i71cxuDuC
	 TbCmRhjpuHzrsY/O6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1wjYJY2pDt-00AZJY; Tue, 07
 Jul 2026 13:55:49 +0200
Date: Tue, 7 Jul 2026 13:55:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Berner Martin <martin.berner@qualitasag.ch>
cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: CVE-2026-55200 libssh2
In-Reply-To: <ZR5P278MB19814B2CA717210492C13A73F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
Message-ID: <26531fd0-4a21-c8ef-84a9-25c871cde303@gmx.de>
References: <ZR5P278MB19814B2CA717210492C13A73F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:TjLGYIeuAiD9+gauZxAX1RWEw9OTkZoCGxmBRns2bworGCYYuQU
 mjuIo04/TPgSw1Of7yemCx9sg+0qIdGpbcBjl5x9i3PF/bhk51niVl4jrka9DhHJvqNoRWx
 maKGOmPX7+vaiXLs1ZSqrlViIkz/Q4o4FJ/UNO6z5fsIVr0y3GTg4tpMoklNWbRFppIlUg0
 sSX7AAppF6fwBTyhke3Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0RY0VCH+tiU=;RzVMXcT6hXXEyz+XdiR/7H0RLXG
 B2tMiJy8a22rGjrilozVtDVvMqmCRy98XoCOcWxTYNLJot41/CcEdt+Ztk4lj7ZUWU2m9T8jc
 HDUnFEByUPZ2TBoGYvbiYoJrgk6gjRQpDmqsLuEGFmLEwb+IlG8Fq/Q1NMtLmA3ZLCyEBwpkG
 Dbb19SL4K2DufN1txfzLyP6sfzh9MLnFHWTlqVFkk7fR5i1W8Cwp7gsGiNuCqTMu96g3uNcLZ
 AQZz0eN/0mlV8TroyOR2Ndcq+eT8EkP3gGa3jU5iPI3dYQyyXZt5ajNQlwvGGUCiOfAlo1s7y
 3EKL5SpXTsNrcY9K488ae4g8VFDcD3k/a5CmmfFREcVceZiKoHKyPdm+9F11LLPXXENsobLGu
 /gFpsBM55BMxPox1WUhzK0waIWKVFNJlAXJ9q7HbekUPknquY7ulzexmMY89ZSkvMmZb7k7kS
 Z7UZh+AYD83yGOKNHf9/sKjrWLT1BOUbF3yq2RwqrqvkPpFE0zlGWxw3NZRCOlNtgLj1BXH/S
 MFhiq0OLDIx5iKNNiUmu84wjLNc+nIDstYUAXMu1uM0vdUHJIph8a0pOPBZGZqh9TTYx5ul0l
 5eX1yFPe9FmJRPfY/55CWeyBPSh76APJsNjgGIQgHmvQ0ZM9QQRgYkl1cOww+8D5KMPkCAJYR
 Z7LcBI6Hzk6Cmjmo5AlZJBZYyDx2rOdyG1RFdfqgGZLHGJBwnTGN0Z2o+raCJoQWDu2Zve9x2
 gOeJvZX4fsH6QldleFaVxaSWsi/ilDy5rg4WoV/Cc/wH8jreYCG9lxsUpwiNv62TR4IDV63fK
 B4Ckck9vcbWVvURVKKjwIi7YFEG2YN29ZSThHkMFl9Jtv6fLkNF3geJU+uatR877II2lmswvg
 svdby0UhlPQ1maSGUE6mTzwcBksu3YwC4ELGAvQRe/n1f0jvCfVxdV8AlkqZQ14C2755AdWsu
 sPNFWwUNohYSzJsHnFDT2s7No2q9UUzzKxCV8iEp9JwSPCeYOGRCE01SKuFuYUrLlCW+mZZNM
 dxDqk6JYG3JBUj5e0GZCYhlTocg1sVVc3pBOf74sg/J3annRlUyU5ygcyRgY84JGUzze4jO4C
 KLlH6wmeY5JcAvDpMMe+13vdytMApAk4nENWH0letKIMJRhPglFOigMR2iCbAAlIoyPSvWZaB
 4ZiYz/T4uJvHAszpHOQzBWdsiBFuSHnQ5GR0VnBfy3vOrc6hb6dat5Il0PEwl9hCQ5sTO9U7l
 xwDvnWOTQGGgBdyFXtc5X4WAWJ/rVkSHiWJP8cwzHixrcZmEl6nnZpSsXyEipyEn8RkP3Nlkr
 3LYQ4LL45lV8laYtI/4e5oo8jpWsfPn7Xnyk/RyK3X27igBC4XbyscRcefNNpX0VhPL9Qsgi5
 XqwqX2iseb0DXTgePU7/SHyUqjejwq91tDSX2qETZXBXhJvPWlOimzRvVXa86/deY+9U5E3WG
 ALZ1O9tlmfXgH1tSthk4xrvCbsLqGc0tmT5rV0z7BBKAWew6p8h6nOWK3EeBTZgNzBhONSq3W
 AqtjD6vajYKVmnC98fNbrK5CrtzP2aia0VJKiZ69dWhM9atErcfdoyMxtUXCZj/PJbxBVcIo3
 et08fLqsjzCz7hFbQVILyNsImWE4jY3nGlDpsED4VWW0etm/FBXE2lisfbMzyY/tZHiWXbuLL
 yZjAO+lTpm5xi5FzXRM/uYUcVomoODIdmJbUW+lKTTSJhJh3gz5EBCkMOl0veWT69qFw7BybF
 mozYod0b5K0NXy5ohbq6ARCF9Cfe3niS16VpfSAyLx52+yyvn9nZOaMdpf5VNRyOLkeR76FPz
 IfqiuaxogLDIxtemERACKlAfCkkNFcfut+WCL7FHUiNMc/sgFSTBB8dFYU+v/A8BuZbYXP/MJ
 Jn67Pi4IjKFBtgQtrHE1ezQ5HGakF568QtbWCpo7pyqO7WCtIAbZB4iOFxLqCygE7AY65Fbcy
 7fix88SJ+PSdLxz4jm84+fTF0Y256sG1j26OP0dZQMWKYJ39Pda8j0j9wM8UqS4zOuvOppqID
 xYfpZJtzB5N+EGkjaiK4dH6Gbf7JkM1ynmkIc6SssGOqxAOgLviWqwZFtWR6bfMQjPzhKDCE7
 AYFkIe4zxc+xPuWgy0oa3azRJB0hVrXhnVg5MuZ+Yy6CK/t2GVoquK/ZaJmsLrRJG5lONKCgK
 WT/V2V9F7cG2vznfR8KOqtzcJws1UBDqWej/4unnapf/lWWRAF8R/tMRZ9KckvnktLYU/tFQr
 VljsTC0R1i6gcDmnKob5nBwJUQFnENoKYzzG/Efr3cgIl2nbFiWw9ilPDkfB5KSf7eMzD8Kvr
 K6ofj0PqO3/D7V4uTkaL9fQieY26YLtyw2kTwnj+zy3HFYgg8CNFu4U3+sNEFdBHFBkyimkSm
 KCju6wHimoEqfW9SORCjlGaqQEfd7LO5DxCVp9oSycg1wfKuPlK7DSE5GOLVLgFBG1hdZ7Lo/
 Q3DCI80Ou3Lm6PMzxnPeM2B5aJ8EstPnqzf9aJBBmAj/l+HyEfX6V6tugyC0y02GJ1UBkKEFb
 3nGHopGCGCgpPWbbW/VgqH+vgbsdXrOUpv/POvha1DhOhoLESLBRIM4vs2QzGe8Lu1AHLARtn
 6t13bo6SoJNSM+PEgc9+cSDCgvjOy6UKZbO3gVmnw1FpRKUjX7PYLNUcBoA0XcGLs+dRmD667
 UWfowVjWw6n8SkI6TYWJBGAVuxxu1uj1ZH1q/sGF8qDXzQhYo8AnLlhHmGGm/2OHZy1x9HRve
 8w3NsDCP8GC8Z4Sxino2AP9693Q1pku2mNCJsbuZ0euDj66Yteug0Nt2vENyqKD/75/VCjQGY
 KmYJJuuh9lBRv5cvqaKISmbNZDifIQJVsZ34J0Jj+BN6fjPql+VriIxp5KgtoXOVyhGAUXokD
 sehm+qosFweyi7TcjTW7zBCefLWpVYasYfygIj/nctowcKMmKbvjLKEUTY2J3wbHB1OHrU6Y/
 8K4o+vJ61yO0pztuTqlZKpd+JLrIv12k4kUhUlLg2TfRQ9L0cA1BSk+W5jeNubGUVNUWVK9nN
 LwsSJhXsi4CxKsqav8jGkj5dtacGQz3fspVXs//W99Ug+x2css1HVmW8jX/olfw+AAwjXWDzT
 AvRMY1j/r68IWFwmlHoISsNylISIRthYcc9Tu3KUwR8OuIzTA6aq8KHB9tyfIyn3u1BBBZYVp
 NIqbZJ6jNcP3LMy23x5w0T1YiOYTw7zNei5B1P5YTN7qF6Gy4utNDnX00hfkANCUUuObotz1c
 FsFllEjHkVQZVlW6JXYlMxYF7NlWw0IP/f1dAvxoGooePzncEcmhB1gMY8U+GOx8C6Jn0g5FD
 oCyQtS0IJoJpL3qgPfedcDhL4DGS4rgz8VesojXi4f5VjYg1NGrVtnyhxZh26FzN3wRsUbVa4
 6zJ3feda8I6b74Dnxqr4ce37OCPh81O00SyO6A0BXng9Lm4z084q8qI5SRD6hsLTPaRBzMLaA
 MUtQawAUWeSmLhdZJ6MwLYTPXv2XUGU3KtefuaZfnNEdZ6b6mqcmUIyc2BNVSv53VSIFKmwX1
 vKZLTxznW4yj4/fGSjSc9CVckZgXPOHyPNnnuy0DvB1MZAC9DlT22mjsCNp3fj/d0HRTiQjd3
 JBiMmu6+fzq6ylnSKW978aHxDYa/Xj0Fk8QlFNwejl02DFGqmFbyxdikx/gR/pj0Q9QHQzonI
 y9l+Mt8TB3zdPz+jSlFq6whrUh1sAhQ8xYOlRZSiOMZgWZE+zh+uGmEyf1GaqSDZ3SiKB3beS
 MZmMB48Nk84pkY7UEC0wBW23NRgcX6oL+i5ws2bauLuUs/xiqUD1rUSTojUr5klA4M229lnJ7
 gOmHXIneoXXZSoHVXr4vSMoZN2/BZIJhmQBMU3Sa4pqs7aF3Gj4mSYi1CW6Zh5sCSZXHeylIC
 Ggl6i0iuvJUkZDxiYWqblxShARu9FPnhiJzVCQT45OGMnjoTI+Xon/1qv/JCmUCnBRq4KpIwb
 Saxhs9T0W088b2A7WMm8SBQr6dlB0tUa3nJNQ+gppqEx+yNpUUvqFgA3EAvwEdM/3qI+HQiOr
 XL1ZgPwZxcFCa2tk97SIqxkwP5jW7CnykivNZAYjqBSBZMH7HuFGTCHpoZcBdOAmvOEcuGcB/
 ndHqJrMMn4mcqG1ne1iAtXf05/47sMwrJJ8XGEAbFKNX9tx/V4KipUN+VZnFbDuqfxzKtaw3h
 AFQqmul6WbB+kM+N7mZtv2V107XYhorFv5PxvLu0SlciQ/RmOHnr0ECw2KVpJ2djZf7/wWzAr
 Fx0PkYDaMgm2MUpedbzVafwK++TIJopJoYnRNJ5jCkHgjckyK/gownfmOpv/peTsPqqcXm71l
 wT/aHSqqOs8QtAg6fgCFLPy3AvR6NOWc8Kwx4kUggsyD8RhBG68skXmXljXY9FUEYPYU7wQ2z
 DGgv3QijbK0efmVYXIsmnA4SmMJoHI1FTOgTti1O7hBYX0JiDMJ1FzQHi/Eu2GfUL9vnW1BTp
 vaV/bT52A2kFPcmcHGZWBN1IXKBM8Npv/KHWtijuNy1I6OxdKxe6oUV07Dnf4TDL5ihqlouS+
 S0FCttYEye7sL7Ghp4z2Kb5ZC7SW0izZY3oImHwRMBzON60EK7slfL+uOQKcGrfpnvV9v3qzU
 d6EbcZ302E7cygaUXAcmK/YC32B+uJX4+Vt3dGnx1EnXfNguYEV1grDwf0W7W+nhF8PtkDbxi
 BgnIArEiBmV73C3+eNCCus3Vwj2h62N7e/JmmOVIPqGIJ3wdOoDNrF8b0O73p3PspLt4ZGPOu
 uKbtX4lcgX3Gz42bsDp2ZbxnxMt0S7v3Gfuhon+kfzwRsde+r9c/UB+vvnjAyhO0yoHW+CdQj
 AZW3Fd2LaPXkCVMC9cixLL3D4fdQhA423/jrZWzy05s/lsmQOA1R10SxHDeHy6F9SMI9Z6jsF
 6FrLLtAfYTYK/Mz6lj9fXzR1zJe4C1QD8aFRB9GyCsxrjEervPm8/ZwwbAmm+yj/Sd5IhK74h
 SrrwkoMT4aKq2qEgItE8ue3OOluGIgZNfdOe1daACW993Q8R9yLfHE1entOKokSmBW/guCOLQ
 0H/1jEZA4aiusNI4/SHq9CLZmhvtCxEgGaIRhjNEvB7mjv99anhtBLBFjDqplIw0DQgQ28Kp/
 8X6liehDTIEEB1LhfcZ1CdzQT5XNopwkKf3774MOL+2QMok1h5WkqewdkVstMLRZws7Eyt1l4
 +Grkfm7R+FW5G4+7L2Jnq0/sYysdQfyNY04WVvffr3qL7zt8S2v+RFIE+jx6a4lfuxhC+XLaZ
 hxvM+U+lJq9ymH2VccSmvCxVcY11Wdrj77fqZx37Mv3e2Rb7o8Tl/xoOMkCWFBF6fkCLVf4t7
 7FUCIlYAb24JyYhYgv1yXiUxAk3KN6e0Dzp3diljhUDTOvCkJwXAkuzvXj/6VXitfxcLJEYg9
 SjsPzUTNC9VRBL20RoBPmu4w2Kf6HUABb5LIPvj3YIBstGKXaGuWBRdCJ09jPGANy4vzAHacG
 pZm/QxG9MdT8RzuqIgHmv9P0OkI1XpEyJG9w=

Hi Martin,

On Tue, 7 Jul 2026, Berner Martin wrote:

> The libssh2 library appears to be relevant in the Git for Windows build.

For some definition of "relevant" ;-)

In Git for Windows, `libssh2` is only used by `libcurl`, and the way Git
uses `libcurl`, there is no code path to using libssh2 functionality.

Therefore, I do not consider this critical enough to rush out a new Git
for Windows version with a fix.

Besides...

> Git depends on libcurl, and libcurl in turn depends on libssh2.
> However, even in the latest build, the version still appears to be
> 1.11.1, which I understand may be affected by vulnerability
> CVE-2026-55200.
>
> Is that correct? If so, when can a patched build be expected?

That language "when can a patched build be expected" can very, very easily
be perceived as quite entitled, and hence have the exact opposite effect
of what you intended. You might want to be more careful in the future when
you plan on not even offering to help while demanding work to be done in
an Open Source project.

Back to your question why Git for Windows still only includes v1.11.1 of
libssh2. The answer is rather trivial: MSYS2 (on which Git for Windows is
based through a healthy collaboration) includes only that version:

https://packages.msys2.org/base/mingw-w64-libssh2

And the reason for _that_ might be rooted in the fact that both the
repository as well as the website of libssh2 list that as the very latest
available version:

- https://github.com/libssh2/libssh2/releases/latest currently redirects
  to https://github.com/libssh2/libssh2/releases/tag/libssh2-1.11.1

- https://libssh2.org/ says:

  Download
  libssh2 1.11.1, released on 2024-10-16. *link to Changelog*

Easy explanation, right?

Ciao,
Johannes
