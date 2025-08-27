Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74C338F4D
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282767; cv=none; b=LU/0dwnGuPSeKpoyPsMsaRDf2sTNwE+ms79weFHoiJVQ5VO1nUm9NSqaeZa92qVBGKm9x+pLwq3NvG3gbW46bxAzTFFo9I4empfMtF6kNtx47YkSvHjhW2qu5Ems6hrV/BNvsxTBM9L6LFQnuhM66YNKuqfnZug/CX8EnAQOp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282767; c=relaxed/simple;
	bh=eYX8IGmnRAURiqA0f+fjZ9CyTkfAJEU5WKPDf2/uV1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT4thBluVr5YHeKNQgDCh1vCkXaZUVyAa9j0ciFrZkDLKIQ6TH8aEBP6MGoaJvEnBMkBY4DLjnl+pNmIZoQhCJdqsemibESc3TO/n88uLl0uSsOX7ZPq8mqeLPMpCdYiD6P0QTQ5qv/TrTUA6v9HwVv8Lx0xr1q+6edcZ0L5spQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=JIo7H7hM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="JIo7H7hM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756282763; x=1756887563;
	i=oswald.buddenhagen@gmx.de;
	bh=eYX8IGmnRAURiqA0f+fjZ9CyTkfAJEU5WKPDf2/uV1E=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JIo7H7hMnPgQLr39IUqdx6zNqNjkbQ/qAAP+JdaSc3tIGcQAfTGwYSX++8jHa8qm
	 zJHye2i5KJn87ViMjJOb5i0H3P4dWuLv+L/p+3gyMj9SdU8irQ2cbljw27c81jCMY
	 /No8yDqcqIDRWesJkqob9ygTrsk9p6bbe6NkQOvdhfpxFXI2OhNNz1ZukoiFpoUPv
	 spz6yyvFOPQITNHny/AvpEnedmbpK04CgJttzW+j4ekmCF50dBJeII0t+5+VF8pu1
	 PG7rq7xLQPmZ8GrvhjEq2BFBTaQ2+GUt8XJkQsfNJZ2RCN5NoxLw0gkRFOM0Tp+jD
	 ZeJqy1tDS+eoRIxhyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.120]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1uQ82z0m8o-00tFoe; Wed, 27
 Aug 2025 10:19:23 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1urBNK-TLV-00; Wed, 27 Aug 2025 10:19:22 +0200
Date: Wed, 27 Aug 2025 10:19:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
Message-ID: <aK6_ivfXr7jIbBCz@ugly.lan>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
 <aIzayan9nFZo4XYv@ugly>
 <af0c22b9-5034-4bbd-9cdd-f1f16d933e4d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <af0c22b9-5034-4bbd-9cdd-f1f16d933e4d@gmail.com>
X-Provags-ID: V03:K1:qZk05UiXqpLvn7WW51oqJcsDfJmqwTO8T3N+05EwXj8GdgIw7uW
 c8XVho+c+SBzbrNOG6x0DhcEkZ49EUM+HpEsYc6oDtL9Jq5HISb3RGX13GlHY96IE4BLlCd
 xOiR4Pg7dABlLiyOeBFlPM7kvR97SM7W6irptZrYz9zG5TnK7HepONoH1b4PJkRua1Lznjh
 PuOwT+wvzKqNCcDM3Jryw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QZhJQ1YEyV4=;M7sK6PB9xV8MyhWq8JID0mxNFs+
 xItYv72rJDIKqf0SyWPFMtts2dOfpvAcHf2l/OsjxE/vrvhXaeTeQvbK+aKlawgiYhZYs3AWn
 m/DWIE3lXr8rugZeAKcauHeHf0Pru0jJNiJXVfp0QLpHdXBnz6WTOWgCKMJWLFr83sThtQpnK
 ZVF11TDv6ky4+w23AW1Li39pQsXYebSo6G5gyCqonuFdp1q7lNpJ+JMxiWK+tj7MQcMJw16Bj
 r7TltQc161KxtKQgbSw7aXxusPGacCjHhHyZhXywjhNRBdCHToYNlKEWstkX3lFiqGN6q3g47
 T8Voil+YFEcbKEdGogzmeWyQW9fb/BUAG4zNNcHsHe/Nz+REqLd6j+2lwgIBbmKl+MDsCTXId
 mhyDtIJ+lmWRe0UI0sdk2Li99XrdnZkFskrwr58wHiOK3ka8PC7TuW5bu55YkLWO/3R0PBg0V
 r7aW/EwDNgJziINvHSOyO8Roz24kQbAAlkDGNAOelja983m6CFTenVfV/P9j8xj+Tw0TGpaMw
 xMzA2096MOrc/9QLm+rwYpYtwvBsYRnBLG0SJtqpokjTgedWhaVoaOeX8pVG0S5kiBlxXJ/dV
 I9jmggR7+p53gWdnbVbcUVAzu/0gnUKK8ePBx6dTAaFiE9Ym/yyoI1FsML6m7JYZ4pOSiZ+h+
 s7MDf0VjkUl0/zFN+h+KLcf7+rlqajuq8DNDrbGVcDopNlICjDU6Gaw+6NbbUFfcX++zkR7i6
 IIM2ph6JVBEksIgmq4t8oVmqMutszalt0Dboda709s2kBIqOWZkOvsV74hpqBugRevvNHXerN
 MyU3uTJ6wgFackRSulbaA9XuH51At1Twy9g3uUWVm+N5D1Eb+znfKp3WYsNy5jGINHiVlzw2d
 84DqLw3RxYzFx8dEVsKT1QGZxsl4VoFhmVQUtd3FSuVLGfA1MDzMrT8uD5qKg+mO/v5igJ59A
 s+rUPLyyNzB/WutZd072bE9IO8X+xO1QV3JQc2+mtI+sCpP50W3XRO9gU4Q/F1JFi5bu/IoFh
 I5vMo9F0Btw/MDiYOmQ1Hsc3oQviZnFy0A3VQXqcENlBVP64nQu/ndV3Mgw1vXAjsF4r4uLnF
 t76mJNZM3nnW6Onk/pExg9874FnHzVHi2ZAobTpdcekBboG2EgP1mI4su4KRnYncuPN/Y9d3R
 uydxygI2jZlKsXMEqnOBuCtUt7fPpcELP3deYPTrbYBOM+NOI3L++R7CEbfFVQYVIG9TxLr9g
 07iseRra0ttCQkUTfMduoB8PsY0Pgf414OqyI9DCnki1EbRpzwdjmfXIumxbdrn23PnUVF/hY
 LDdXzPl+tnYD+cHHt1RoxHI9aLv5IEw5/T307wqyr1txeMOcMNpxLhs7cJhcUfYNYPjugcHr1
 zPZyDVsW2wprsmGr/2HtzfR5nFbt1dzyCSnHZlDiL9u1SeQXkd5mlwgsmtkepIWghIdL/KUhO
 oexV5isHasejXeim+y6JxgnwFLhivNHzrFboPxqqur9FXPsqhIXRN8NO9WLIK0z47KngLAsaE
 Elxbh8NSQ2pvCKqyLl5Eof3UbD74f+bG3XGtaBVTM/5qJRHbNElRpcdKpM05lTIwR2wRIV3Jf
 LyEuPFOQt7AGzpT9LOdW5m5SMslrzzm5S4W1C5hV2IIKLBS79OSx9kdzukTBvp/sNhtaK92NK
 FABQg3cMcLr/MPCLMHthnJpsNwmlaEzxlH4QThtWUiAKSGJyeATBmEwSP+xIseEN1bqxaE5G3
 gC2yTrt6TADrtjr5h38BvxJM0zktytuD9q2gx54JpTMSLQ/1lThu5E3Ggm+rW3mpe5mcav/P8
 iJv3X3fyPf4qMQ3IeFaCFaVIgBh7Sg/PahLqhbsct4WyitTdWxMpcW7ge6siCMeLIiiQDT/fc
 0vT/npytU32H9dk+/chy6rA0bV4NFZgEszEoQeqPJIJxmHfRKRSAR+KjgmlzsUHcXd7usNK5r
 9efNljmaeISG77KRNmpq/CG8B+sV6z0NM2hvfzJva4Ta1DQvHpyzBBuq/K8pIS76ocDi0VzLT
 ao3O84NSBxb4DA4B66vb3CwWvUWkpZ80usgDBsdYT6U9lH4hUA7RxgaG7DwgvR/+ExhMlfPe6
 agUm/6v6DBYHWxuIL78zu6oitPK1EhJS6iVXjj88rKnqV2SQWF7O2h4mr4D3JynpMpfF2r6a9
 nMjHlhzWxjhBN1SXTMgK72pBpqDBm3SGjt385aItOcr33szXsKqls+eAf8FDnn1+bspfd5A3f
 JtP4yIUikQNS69LDmy2vebgM853FoPbPEWwzIQZFcckMid08hnDsac7TGCbCsDqGTQJppvXrQ
 fyZmjID7/D+1sx1KIMtkCBZ8lNhp3d0WO6EfMEuwLW1vMXX82JpkS8JxJs9OJiJsuspiOlWQt
 MNOveDGIxPXpX9JPYaTnvHExl3PZCHNL4g9XTskbqJ0tJI6c34db8vc6bqzga1BZVT2TFujPN
 qxsCyB0AfWFkKfun7HbhTpjMhKmyUXnOtFWXPe/e74eU4TH8WkUlQTRvjOnI/1Q5LtN6hwK4G
 FIbMfj/kOelym1FA+pnED+3UX0o21TB8Qv9eiJHHcQKnXEOWb7YRayTJfg3NqYuPpnxsn7agG
 cHJggMY86II+8utpJLBPanGPCLq+2WzWWYTYgSoVhN/suurlIKJDs/WvPyv1Yd0m3vBLmVh8t
 U/KBtmVwW/qJmU6Lhe/sCd9VAd5V4eixupldZHMXm4WlBSXkPJUVdcltJZBzl6r8B0JU97sxX
 ipx8QmnHy4K0pYybmFmhSq3e6qNEO7HqwtVFz2v+WxC0WmTlvtqjK7C16WrJcyzxVO0aopeF1
 fwcRQCEGnBHm3448D2Ak2AbilX+0F+wA1mC55UTRAJM2XrZLqxSAOlGevT4ehsCfBVQY2tQaW
 dkCahF9nYECl/1/i53fTJXNXzHTtCvvwRVsmy251kpDRmiA8ZYndtBP6E/00LGKCw0LtgS09Y
 elg6B4RianMupWvPj9PNlC2avYafU13olOi5UQA1q+E6HKNqM6PzpLCldHcSr30x0gkbc0dw3
 FihteVER747eFqLzA+gaHAqUs8vYWXZyJiY4fhZLxutdQ8BoltAcMM6+cKbGdWMkm0YQRvTQA
 Lv72hIJTeWnXlICy2/n3YF9anrskyOH+To+vsavpuWVatnB0SECeKTD+4axjjG2gPtWZSAjBo
 eqisp50Wtkk9jj0wM+xUkyCk1rlGKGtrNQmNeREPFQa0+C5Y4Mpcu5h6khelyB/Dd7dSIZynS
 KUNF4P3ZYTdiA0RO3SupqkqKBvKEnk3Lw2zBObuSPjYtWI1FzMOeIFEj/hBjz/KL3Y/4iuCMn
 XTgGb7TGTdA0n2O1680NSXisFqa13eausf4hhO+vZb+RGygMxle4+10WAgTEWzOuj0Xv/Oni0
 Uk1Pmx8qlMhI4BTEA4h1kA4gY76fpdd4DdPi4pjK6Z+qtEsQEKg3bS/19Tq5xWInfXiFNBX2l
 WWctE+OO5xaFtbR1GjRXIDrHPwsc7x9lss0IfNBbE+Qt3Dxf1IHMcgUc6G6sht08C7srkOKM0
 zp48P85gFlp+eOtvhIVp69zMWlF6HBeHwL4iCh13Eps1gOcyChKSihQDNsLqOdQCvJXcUjY5z
 DZqvNKpQ3uF43UX56Yt8r3T+BJL5Tw3tN2bWIUcnGTHvaNjvZw0S4mPnmeI2KkpShKUICdT8e
 wP4HGVMF9eWadW/cSz0y461KldX3Dp7vTn0TUvGbPTBCPfie+pyAj4N9/hR/661mH0di381Hk
 UXH3A2jsaLYEKNztgDzShg3yAo5f/IBQkq5x/6v9fshLQwSMp7cW83+k6GrA3aaQKEzaopx1X
 PVEATUQ2heUsJucqyn5zihrKnwU3TwGp5CwtxgtRRxCfXQJUI9O91Mh+/4r7mj+DvPipReK9/
 lUTJuwR1vn8lDCX8KxMFLrNXBJxSiRBK03xdnqJXoWtQAqIsHPnmLJv25BjacoHUxR0w3vIA0
 yzPIw5BZZCj0qe2nQfLXc1BbHedTv2CbDr08v+m4Kx/JlDCnI5lJ8GyeSqSC0YSIy+JRDiWv3
 cPN4SgszQzrJHui5BOEQZl/qlSTgIxbJd11pep2Am+9/zvrol6wLsemz+ebGK9UwDzzrln7hT
 OclHmOtLBykpeRygMC5onwkx+MdQ9uKKxkwdsj4gv8EUMcrum7HYUfkngc9l4hACLtwGtd52t
 qhOlAucw/ZbCDuBdnbaNJHZqlc+sLNZU5YInjKYWuzi2NYB22vhPbueDKsaqpRTDBDCG4m0U+
 zCZnhvIWHFjfCc3fo5NGkFeS/0U0BpwL3ebW651Qud7Rbe9glZEV700MYZDHAr4HXjksLblC4
 0mabvkH9gOsZaBnF9pua5CYY8ekEl8S4UOZEbkOFrpMgGeOYwGgXxAgSq2LHFG8e3zJS/g+lN
 G5Hgh0LjUub8+iKHLsCRVgJQmiQ6J3UEqLdWBB5SObjWxriukPpYFFlFmqLE7aKkc54Sa0R73
 SeXJ5eSbsiMA2ordK2WwcKr1hLc9hwfbZlWbKAlDejaAk1eey57+JJfeccsjJWckHZwOMNFzS
 Bejnios+LMyNh6qNwS4ZjZ+ccRLNjLhHYjEGeBn0JC7OMINbDBuLBjfltDy17bBOc1HqiqfVW
 3Q78vE872v5GUidqbz20syoAofgOa0w/NE+dLGdNUml9TDS16Y7LYQXSJPJUMlhjuOHXDn1sF
 qhElDXz/bRFIWntySsCyxmldi/5Q
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 02:33:10PM +0100, Phillip Wood wrote:
>Some of git's reputation for being hard to use is well earned and I=20
>don't want to add to that.
>
i would find that reasoning compelling if we weren't talking about a=20
case that is likely to affect only very few, and probably rather=20
advanced users (who somehow managed to make the feature actually useful=20
for them - others would have quickly reverted the setting, because it=20
would have gotten into their way).
