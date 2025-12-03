Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96B2D7384
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759191; cv=none; b=XdGs+E/OCHXOZHr2H5RsI/Ca4O7OOuO7df6Sy83SZHjqYpXuyPModkiDN5X1+D9B79RYWuF+3693cQggxTv+pDX7iha77vxTukUdKd6PfraHQmbu3ZHnPJ5DrAJH1HajLqdTkUzH25UgGSrDpYeT44TBNT/lCbFs2v3jQbItYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759191; c=relaxed/simple;
	bh=7Y1BjzHiYOOlAzzPNdZNZVL4TY/nPAHejxJFusgUjls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LO36yqEc+oOdv9z1GLKfk2iP9EKimIYdZIKOER3rfYf3izF/M4z+7ymBzQApfQfX6UK/JkQSLXqASg5Ds/2OE0ZRE+rbmpNJSueo+FIHI9Ikky31TiUNQayfbWaUKccK1Hm9I8b5U/MB1qh6eb5PT2x06pgA0rzRdXd7P5iM2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eSpmoEPi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eSpmoEPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764759187; x=1765363987; i=l.s.r@web.de;
	bh=nChqxmNh0u/pRNHz1ono5dzQ+Ho02LkB4x4XmpYx9Tk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eSpmoEPihNFiHPvruvH/VNETj2hfBO/sqqq6ZZXnMDY3PfvkhVhaRbrFI1txkZyR
	 tXXmI+IvDdM2tkqHyvMfm2YHquz+8UeFTXtrrWjnOC3jSMAE2Zup3TLntXPDd01/B
	 J5Vf15MGImQirs5h665mBam+uTXxXjIXV+ScoFo32OB9meA0pI5inWioMQsRYVicn
	 n2idQl8fuink3BGLOkXMQM/mr2ULDpKJc/qA7aUWe+xSY+uW7t5UH1cR1BN07JeSz
	 GUGnazLtSJxfVriDSfaalCCcm1ixlw0c4DL7x9yYN2Z4evKF8HGxxbGlehV0jTizB
	 IGps4ZeF7RLVwWddOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1vOofa0c25-00ECKa for
 <git@vger.kernel.org>; Wed, 03 Dec 2025 11:53:07 +0100
Message-ID: <37a36748-f357-403e-9a98-21d0f8a8fb41@web.de>
Date: Wed, 3 Dec 2025 11:53:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] banned.h: ban mktemp(3)
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Language: en-US
In-Reply-To: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a1liBR1Yl6VUZXX2BsDVOc97JFkmDN8LkL9YRkaUOP1sflo7Wlg
 kWInl0JDdCfYhq/eRvEJn65eUlyBHPvpnS08z+2giH+NvlS/YUNXoLwqLAIiTbfVdv2+Jlk
 9FKxy/XwNLhOH+eXofLpNpKYp86BB/UhOz77cBvdhIbUNOIb+LVXSaKDu4wbL0gZWaHHpbS
 7EXdk0M7FxTlKvKVI+oyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:toyz5JUIb0U=;+kp6JMivW/ebNc10gbABM8oL8s6
 Ch2XBONmX/GWbyDarqXCdOI4lySLhUfKafawNxfOfndGdqYja4sYVGrnCj9h1I7p2a5eqQxIe
 zCoA1ZWOzZtrgNR5zpg7iZh48vvUp33BsAOj0aDIiMwEte72dHZCVPpaMKIzVfBzIRETa/uiH
 a+w34CNDcJvnyfjT//WS5PzIYMj2B1jx8wNyCTWM7n8sUJcQWiN7ov7+iiGVIuczxsg5rbs11
 wnKbfs7TXbuUg7UXN0wLSR23MGmidbwKGyP1Bf7IVV+4Hb0lElVOn6Xr2TZZO/KFXqsbI8ytR
 vKHiVSPAK5zyH1LNJ03f9AUwvHXcs/vyN+9xam71CmePZR0t1O+RD7isSDvS6/QIPT3EVQEhw
 ZIYDp48sfvXZhs7X2ZGfpXb3EX3ZBErxlNU4sHGWfLH44KWVvz64qBIiOemT7MvikfsluFI36
 NRQhSWRlrlJ5QVhevOT3bes5GC++8ocsu39k/lMM8s6zh0uwSt4EEYi5P4VsodeuRIHelnKKE
 UDgepsrfe77YDo7sBhw4x6kcTWxLMja0EAjQM5RJAMdN5vBF7fj7h7MmA1F//20r5KrRfEU0d
 GzK/eMBxkGwzDEnYHcUNC0x00bGnE4WLtwvrPBuAWpS/IFsuHdzRy5f96IwXHJfaKsGBf41rg
 M29b049M3AT0QPtHU47fpZ8FSfddLoCVdavTmpMZVgZx/QCBRtsFSnpFYB+PWSvl/6CpAGfJq
 6uTyahAUSa7/Sutuu6GPlCDvKlevnoiDKZZKK5Aj6q4lMbkNNuAOQAN0dzqYYc5psI70dpxd2
 jfm2QHWzFa2uUbSv2mUX0Y0pKGy94LX79NbdcOhPPNezabMa5iejWKkj3qEE85SVJJAIp05RE
 nahYUw4FSjGxwJZlwlSOONSTRfWve1Kk7eWtg65F4yc8lARsuX44d8CKTa7TPXVnc8NmHx9gz
 VYP3C3ICEN2UpAoV6DdMMxfnjHZ163cu2S69wtey1zV7cU8AdQc7SXU47qWtTz0VaMZwlv/8j
 vM+VS2RNKV+VmDcuJrRLCPrH7DxX8ihc9sIfPBtbticX/c0tXUSfVixEPAVMe/ubjRXobSfm4
 PxkFo691Yypa5qj9DWP7Ol7N7L7Hie6oFU9QJXhYiof8vtNZNtPIjJCaiwPVeGJxz9PNvEk9M
 jydWmYg9sbZCJXY/IgXNUpbnXUHsm34L52lampTaHgzD2Xe0zziDVHM65x1e/PEHAFbRuTdha
 zo7q6khPHSExVwdMsoF6fe3b+byTNrE+ovb5VReaKMJPITb6DTwFG390nMPfy6uytHQFT5FKp
 n+FJhyGOQvREoFIcGVT0E2mhIv39V42WlsUpgIe+Gat70p90a5yy4PwIv1s2zq1JTBsV0ue/h
 D4d5xEEOuAuaUtBWz93QDVexRD5/leKKfebOMJC22VP1H7CvEmpX5qtf1E7NzMeVHcwrw+EXG
 xNSLQ3IMfbDQEU9W7y+r4uvrAu2CFu+Y+bmg1cx0wjCqBN9yf4LLRibTps1s4i4Taj6Z5CQL1
 1/uXwVJLUvjvcrBolclmtSOYH5L+yl85wIeHdIywlSy/uJeowma2lvdvkz4soEKmt4XNoCWP9
 vOdsuix/Wlp2MjLKyYomlsOenhHyHtBdLOiH/xcdX2C2CmRicn1MMmeYqwpPUGb+j6UNW7lJr
 RwHoiVzwBgeMSPB+WbA02CFH4p0xqmpkLcaDFWrN9/3OUTkFEzCb6NjlNxrs7FIQMj3FCa+xz
 OhtK1LiUkzXvl3pDwoNN+5G+xg/QfQ1qOpOepXr0WiJjiZlX0I4i3/xwLyhkvvdBDe1ASAiay
 9UjNTPY+A/T7tj7epw7j3XWGmwx0auHSs89smwtrZgPsa/cGvfvEeVvSDw3EMk52/jMrvuD9p
 AkN/su3Dl6vDvqXmndRvP7/voVc/ZgpVQKT6Gpb7TAevqkAzArtRsMi3Bd9yL/HVHP2C7DpWC
 EkYRYKkjQra0SHW9AlCuSVKkBHR2jefLMPmEWlSzEP13KHpBxaC0RXgwYyuszqqAuEqvtab3A
 bz6I3v0kAGeaF4wZRRD3721JxMIl0isYdZ+C3KB0DpmG3gRP7ymeaCjhV8uKMB5DiQ0b2bfa9
 3fg+tVfFlOKqGBVCB6LfCNZUXmMSgU6erBNYAhJ0RDZGD+O/EKaw1EWPdvDnJb0R8Km2R2OSd
 n4C/YVxpYjq+W/MB7uVaxyOFOe8BsR/XCYBjJsI6WZPuQe4XrBk6ug02zQZ3wk395K4R3wOKJ
 aNfaGz21uo0q+guGbruITq2eTm2NNjehQGACs88gxqDM+yAqtQ59MwacFT0bjM2y5g3sXL+q3
 xu4+v8mUSUHwf0dcjCAnOViJg2JeHJQRfMyjzOSSVSVf2pSi9K45ozDRRBkW5BW0E49Ailfvz
 Z4+1iIe59/OLHPF0FymUOyxJ/dTd1cX4k1qyZgQtmULjHWn5KThma867uyhl0gfnSqDjRnCNe
 l4VKLBFmpxWYk4vpVUXD+maei9XR2dbwxssUCF5BR2CFUIXij3KjCbEVKHxoEv2nTCGPEcpJv
 M5TGX5PE32J871yTTZw3CmZso87y7UqsRYyzborOoCdxjMTGlF4VBnlQWoIqWBpAI04soZgGl
 gqZzj35gjV6Gm3K9xya7nDJyLUpbsYGnFhJ4ANzAFHjlRAOEPqnVLdiBJkSj3Oem145auOJC9
 rEI6zWb3p/Peotv12OtkSqJXZdKSSPCMN8H6NR7yGkSIlDIH0ZtZN1UEECSwV2FCtyk1Str3A
 Cqr/Aa0hc0YXYyl+GVcrdLRlvBEHxSK046TGJzY8fQ47j+jIOxrf1FtcXL9Qy1i3c2+kZueN6
 h6k/5mltmqO51Kj1tcEjHJw4dWqx+5d4uRaSXkjMbtzCQJKnpD/qGGeprS7KtyPntk8+Zk2TJ
 lOxOBgq5tcXVPxGzIVaubJo8BwNKrVPp/gjxIW9dopuT83FdjZG5dVJOzC6yOzgP9faSICrrd
 pUClhAorbEEwLXR8g2zE8ZzkUrxS6XVPQ5wsTmpPXJGaEB1+Y79dWul2fJ7oqXAZ7h6VoEDtb
 wZAoLIJSAoJlYFZ7TvgqN2jXZ2JkKedq0aL2nr3Zo5f4AIIAgHiaNakigPLBCVKi3O3iQGr/X
 R+eCxUM6e6EYtXKWzdGVF+q8FW5eVFkkvQf5hbnec1Rf2ZGjWZ5mzlewzGi4sfNIMj2Fafwyj
 TY/pv8MPOOzp4VID1/t6S8/VBo6aMGrfsM5F3ExRAUTEIPvxofzNKw4RoUPab1MkI3SU/S0lL
 vBTfgW2Ol8Nhf2Omwl73WG7fYh55w3z4cE5u4RqI/q8zmW/188FKrr/wSLz0WnCbJAMW28yTw
 Fs89fHFPAk61SJBo2UAfy/ZMNybV74ecBlDETberj7dqLnEcvT+Iz4KNaRA2BC2Dr/M002xUL
 /7GYAF80lwR6wx4UD+tNEn/XOa6cBTBEcDpQ90jUdhjl38oNSQ6A3PGxAQ7cEFnLx5n4lJeJp
 ROHrX6AWvOyCmzZv1bOxXmQh13kjgNdI3HPnmbjzvKdY3baQeKssmzb5s7SPK300rpml4fE3E
 k5njWhrOBQcPLkC5IrlbUNJ8wFPOHFcxp5laHkXuvHOzPZy+TvDn6kN+S9iddT4MWC1pcz7fY
 72ams5kqSP6b9ONbLKYz695sXrKMAejpyTCE1PFmpri1ON8vqJYknhw43KRuBwe8q2qarbdT0
 ToCMtnpEKnc36TCo3RiWzrtT14filquEoDLLG8P8Oa0lNIOVQwrktfwFoyeY9cz8P3j415uJ8
 r7rdyGtz/U8I2DCylwjxQJjlHFO56M55/C1Ihw8+C5uKsQpOxxwt1q5lEYLqVIm3UM4ASPdL6
 ptWd9trXKlRkRgJVZHN/YAzjy5ynP4807MtdyratEWvDPCmoLNdzu2ypVC43hAIm/wHFUKaIE
 bs0eLEcBy4YmBZ/CD5KNOl0mnxGsnEQ8bmAFdUdBeALaj7HjMuaz1Bwao0bSMWs07fKwXwOMf
 xsWdd1PZsw2TBY+CZ+zXTGjQffTcKigmo2PfBztWePZPOFLOxZdczlqv4SbSmgnyBC/uYKCC+
 38A/aI2IxSLx0fPKP3LDzSUQrFy6z/ker4+P3dAcECp333vvo1i7rx8013QMnZMa/KwiiYfQr
 LESowpCdexzL4CL0ZVTtRIehv8zQCLT70y0s7w9n5au4zibB73LCJO8qFezCms34X7Qq4ee00
 5nfiY3k9loQITrHsjU29jI2N4VOYzzma8q0yjN4PoDyEGcxd3HYapI8H+hCQR4hmrEMtK1JRh
 OMjGLtXMUy76H8e11+U+BP5WWK6LQBZ1wSODSj4SLfNssW3WAXf4KUFpD0JHNiRv9T0oKw5YE
 IKyx6fj6jM9RKE7yN4y+PQV3GmyGpNeTUROeZosp6icK3CEFuTXuhvkPnkNru/VKtD8abvWh1
 RlnHpGnvnPP6kCMmtxHQy+u+EWm3+jh/Cih3gOlFn+pxwMaYCXny77MQ1lz1CpRXO2DV+Y5sK
 LsMTvk7KUFHqncvLkuwOsq2dQrZ4/BE6HDm2CPfUBD4FJ1WZxorlWHre5KrDtlJen/ZBpaj1h
 kMJ9p4Hywpk5jsOSopxAK/mjt9K48jcsQo3jUCt6wq8/q9xQtE6UfvBYk/XSvhdP/FLHt8y6Z
 DeU7CNE6W3Ll7Tn2WNoUVtV9bkRZgdmCFlE65BfCxhpRzApyMOyvHL+Turk9x7vq3tQ5Bm7SL
 /t2kWFm1LeEbGKdAF7FgFg9Ljt6Jauw6E3DXVtEqQDjf1otAELeqQEOzZKgSjBZU4Kywt4scJ
 PodjuUpCPSwcxr3/U5JMh2UZajGGN3/vbkvlsVoNCwcYbfI8b3pEzpsJGN9PIkr8tyCrJxrz3
 Vjgr6FjfW7PJzUHdes4QgUSkNx9EL981T9iq5D+LPhbVxUfsB055o8reYMEa5w5MK8tNYNc49
 MAo2s8XnFIDXw8rE92CheyNj/NkjgsM6OKo7oDFwiZF5b3/PlTK3YqD8nT8UiQDnJK7QcyGGJ
 cvb3BiZCb7BlOY0iFSYGDrwUDBwgqCPlGz8L4x6vm2bj75BQadJo2QMpFljdtFh0uvyQyp1bh
 9k1Ug==

Older versions of mktemp(3) generate easily guessable file names.  The
function checks if the generated name is used, which is unreliable, as
a file with that name might then be created by some other process before
we can do it ourselves.  The function was dropped from POSIX due to its
security problems.  Forbid its use.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 banned.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/banned.h b/banned.h
index 44e76bd90a..2b934c8c43 100644
=2D-- a/banned.h
+++ b/banned.h
@@ -41,4 +41,7 @@
 #undef asctime_r
 #define asctime_r(t, buf) BANNED(asctime_r)
=20
+#undef mktemp
+#define mktemp(x) BANNED(mktemp)
+
 #endif /* BANNED_H */
=2D-=20
2.52.0
