Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5842D662F
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719075; cv=none; b=NUovjDGZ5HZyTrJXOfuVREcVHy1oc/guyurLSfeU110Pc4lDQB9ASIcTyQRpPpBbfMno4CbFF3tcRin3AtQqZqNynOuh6D11UxruYqbP9xST7+AVOZQ0YGLeCsuio7cbSSsf6p48cHOLKlWsMJm+w5I/ySyph5VczSpJCVJ8L0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719075; c=relaxed/simple;
	bh=bvtvSr+GCwW3GRhbMziFdzKvE9Ed/olAjwK/X5IIEdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qecbKX6u7p0oc7Vmp95QdRp8PEHnExMujBxRJ+vmGPtGxkL9d3Xu1mIrFw9wXJP6S7mjYPdifsoV/x8zv0u0o18JcNB+JQuPByZ3IF5WLKvnYDbJECCDtntl1sbg8PCvE8jimu4bicPUKXcb5dMXY0NM4HdTu6vH7sPPs5csnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=kE/dLeBh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kE/dLeBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787719068; x=1788323868; i=l.s.r@web.de;
	bh=KrEL4XWQ1CuO4QeH8g3CjXN9HcEjSXtFHfihbNj12Mw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kE/dLeBhgobIF9iOnchfdrIN5UnlCQ+7vxBLAV6A8JrC80HCMw9CStlfBA9zl8cN
	 +gjCfofB1zvxGdL6hiGGVXUlbsW2Y/jkU6UmsSyTf/9nS1K2EN/gwJDssSRQUSM7o
	 L8wkvH5RZyWTjd2bdm6y8vt3Y/RZYTjgn6e4DMSjdAGlb8/uNvEdWSiluekRxkP9T
	 AjXNzms9ec03xII0NkKRB2HQx8Y4mJk3wukQYxvcn/vVflg8BmEZDvP17+PfaKsnu
	 rhiyvYXefF2XsRQkXk53AB1XvWI1Snl0ymt0ACVALnOSyfjgpvMhqy7lox9hjGZCV
	 mWvEAeEIV6xdxLix4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2gM-1xA3kq1T7Q-004LZ1; Wed, 26
 Aug 2026 06:37:48 +0200
Message-ID: <18e65a59-2d33-4f47-a5eb-ca5971cec482@web.de>
Date: Wed, 26 Aug 2026 06:37:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] worktree add: let worktree_basename() return string
 copy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260825180350.2099-1-l.s.r@web.de>
 <20260825180350.2099-5-l.s.r@web.de> <xmqqld9uklud.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqld9uklud.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F5B7FbMqtZO7SDP9cpCDUKnSSl2QsOV18lJ8vvmkBdPwCPzXhaS
 kz2clieGWLwbXBIfZyP6sfH1RIFhMy0l0362FAKh6gQUfWprli3fAQvhIdwspZu9aN70ILa
 NSRiULhe3afUrSASPtiviQfpkhlokvllaKzD9buKQ0TMO1Wivrgb6g2PHof1n3gHvb6xu1u
 ckVZMk2ZtiHQ3kBP1BpTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GnBEViIfrzc=;oA2W2ueHekspXJKzZKc49WP8UBf
 WMYtdpy9Pcxm1mVxiuVyuDkh9q0WIr1wZSa3mgwlZQOubwYDlKzioMI8qhT/aWQbKaYsTVBSQ
 ncYiPRK6coEvjZxUTO1sVEV0akjzk6ttuPVPKqlNpIvnr0iqDfIq9s6JChnmet+uhwv/JzD4P
 xlwSM/Ud9jezLc07Y+BZGYhqbpAxEbsYY3QWZRHnErn88ite+qGtKQ84u8YMYD42s+5NxAQTp
 UZZEzOAt5vLElb6b79qnsMsGbE2ePPRp8K+rbsLRgIeCxQkYuAw99LkUAWGpfg8avVymdwd/k
 5pcrRltARHX9bON+Q8P7zBgZxp5vOQmc0IgwKdktf+EwsxhjxSz3N6qzp8V5248+IBnsSOCph
 fFTWfMduiDZtD0C7i8rDbpu/Y/+3et4a97XHtOd70v5+n2vhhFyPAZkkrEB0NJwrMVcA2QT+A
 GmlT5gpkZzcBlhDxPF/+BlWGxSfr2Gd4cwIM0OP3OzwN/36PNvgtRiO3Pb/kKfmyE5jm02f/A
 q8ynELpfU+Q+P23Z4UzGvgxYEzmr1hcHIt/OfSQUrslEPKB44TlCGak0JfuaUDV3mV1t49lR5
 SM8g7dZkVphG2LvFhgkkQEISZu/Bh870GW0KwTjCPONgGVgI86ZkL7kwX2eQQ5BaqJCbAD1JR
 xiMvY1C/3Oes1iUnSv0qWZ2UIzymhfdsX+tv1pweIaxbLqNWKaPv4WMnjy97Mbekj8pmK/Nv5
 Ggy7SNzpAHoFpy5Lq13+0hfKMJ4XgxvCPjCIUjDoUx7qYSfQRRGJJjeHKDJU0Ltypt1XpqqSQ
 Kl2xOfRRbJ+CoI/po+rwlvnbsJeTqRExaS5ofog439yoEaXsSykUONOChwPGrKuR2Ope2eoCm
 hdvH6of8vNQTBgU56wuWSKjMP0A42vUXyS81v9vSqdIz02DXlkc0UxT+RoENLD1YeTnd4QPOZ
 bQLdfRQjCGvO8XQ7gdoOn3/tiCwh2HwhfJUhxEtj63okKu9WuI3+xWiHWcQoY+Z549rE0GL5G
 SIwiSs5pHKLgLRi+da/5EV+37y43eFcJrvjsTDM2Ml3k/OYky+EPZmk03XyM1J/EI4FN3aCTk
 pSco8uSfDDm9G11cGg0rfEwdTaaJSSACd2C2LAhhmBBANEMom9JV3iIw7AHgqF/D4LM4594gl
 xa89FP7Dx3X1Bh0mUPKUORjKmoa4CTu/a/TscGuw8n7TWyEEgPjT7DmwVWvOXuQ+zpmHvkGR6
 WB15n6n+D9z4ddk4V3L+Bmrs/pZ+BUYpeTC4a8Bu9QM75WpN/Mva9jXZX9r8mgHLxjnU4tSmU
 qmxkeYvQy2AaC9/q6/agCYpNr6VGaxIJtz8Ynx86QqVH3sx0T8/L2qBGh3/95p2bHlOaO4oYE
 WMkA85/OhJdcEPn5GsZhq3P2CX5o/xa8iGNtyHMB7o5sFsDb9iGViqS6EvT7K6VttyM2os57I
 4xlZK4O+bhmh8CxAFyvFjS/+6dI01+zObyId4DFvAx++n7FclpOYtNH7j9BB5GyyihNOekgQ6
 rhN6duAP0Fmp5lIVBCFojA32RyPaL0fPvkwYRpEU2j693KdbMMhRSnlNCoYNBvzkoNw12OeS5
 PUr5GNyPKGHbJx8hHt9wBiGOm6l65NUegcTvoh1n5UyZVTxqfeuQYpizx0ShKtQFTVGe9zZvm
 oR9wgi921Cx20hmE8Opp3o7J6+0eYgjCyHPW5Lq+C0OIanAjkqPaUwuh9onILPGzFtGGCbpS6
 GGgaKath6LfhotV1KHqqBVPcKyRvKLUJ96jx8fooMJX1LprkRbRExXsOC35leV2jwrkyk6rfd
 xSCGsspPM9BQzk7Ecv1hj41g/cEjX+9wWnrPBcLQYJLy4j/xgOQEj0HL+49cXAsAGbfQfyHMw
 LRW9IAaVH9+SXDYXddEe4cClL3n9+ohQcYcn7vBNPXbbcoYFUYdYZUTH9xYyZjV0lO/cmokJH
 kfLBhNtsU6Tmkcz8rY7+R3qiYhIcIm9GXv8b695WOdusuXO/P8+XLJJj9kFyLKW6Jl1dcFTA5
 nrEue26/J2Mwrc/tBNZ5TRSHt9r/zI7QRQ9cj0JfvT5+I2OkhrRgr3VS4owBUWKUsjSeuIab5
 3PL+nf3la54+q2Z7ElhkdyeJXtzwymdlOBreLOQ1rW1CJ8u0H1R39RQsf378o0jimIWdnvpU6
 GixzHQcezjfgvbbxAAFHmQorjaVHyyGs2Sa4ih/gxYon8WIqVLnRKp41AHAPhF7PmEJZ+8YHT
 f4qb9Pj0ISsz9i03ZS0iD44aMXZ0PZONUxQi2yF+me+gd4V84aq5vKXXCLwRLbZBQcGiYsDmT
 F0QUjKuINkzLybEaZYfVfGYVQomXasym7KR8qGNqQ9DHq7M8pPPJxyP4xqrQIhcY04oitL64g
 VVUko4dusX6Bhf/4BfbYG3yrZqjpTMHTjMU1AE5PzWySigFzQmMDCSGi0zwrDnUn0hlOG1knw
 c33MNfURDWtYly076k8FUAm5reYTD6Ys6E0k26iX9D5g+syt7pcw21r6cG0/hdDq2cLu/7HTC
 12lDGKY/ek2gV8wQ8u7zZN/o4Mp05mP4CCN0uVP6lll/eg1bQ8EBfr+hlwnmE/0v2O8adgZTh
 hq9B7/ofXzrOz2jQZMhqLFofNoSapEckFzmjXV44nds83qeHfZBFl5fRgCSEv0JqxWhkKjVpi
 oSmi/837W7kG8Xv1I+Wn2M1pBhVey6ojQZUKKysj2Ujc3aUDxk7lozgNMNpEOMAH84weJ6MVn
 31jWetHs3JeTpzImGWlA48dDxSj7Z1ccYf7QoYRNLlQV974egYbDeD5ZX6g8lUrNBKW2sxiN8
 6k/5CA/2zamP9fm0FW3q66I40BcY62NYZSeq3twDvCsPNco9Sv3CE7/0GxzDXrzkVBA7Xi8/6
 Ucb50eld+AqD239BVCnqveqPm06pc5Noa82AkcM2orp7UcSOTdaVLh/LxR+3NSjRGe4r+4l+Z
 91O3Xic8BOWAI0I+t+JBsmProSFNopEHwOpRh56YmPe9IZYoMS09ebkGcgv+NTEePv2kPVw0v
 7sO/IB7HNroW9IWozCSkmrFsgqi/CCNHdYqlq4Sqp6PGQq5jiYd7DrJBrQ7Dw7do96Rg9gniV
 3Wl9Q9rOjrL6d+NL96Abz4LawiGfAeH741hkmPiXITrQFtasC7amAHfo5AZWs5HhCSX/nuwEV
 QfcGjdMrHmhwQFVxiMKGsluIJmUa4N9UcNy52A2UOnXrknqW/1Pn92gD5eUzI5BaAU9yurw4+
 bXau5C7HVyn4hbEOQmUxJ2KdCut7IYh/5zbPfDw1m5GUVTWm7lcFuuERJc1DFkTr0qxNlylJ2
 1Oww7oprg/6L/xpT//2LaRCL/WUefrWWJC/9UXiwsCxVOGlDARBuXGhr9SUTL5RB0XtoxPrvQ
 +YpltahpwX/1+qKsY1PxWoaRSO5lRK//XnyinyMxezrF/rf9NW4B4EvH22TkZmxnP0uyVFQUd
 kR1oxNtG3aipQEYN7uSU8HGrkeriFI/pIHff8oGXybypu6nh15JQoPQp+WLFqIMaqzIcM23KQ
 q09CxR/Ug0ZflFh4W+eASeSHiUNGmxHKcommplyLzLcPkaIitGHQ/C9FhGNlxffcsF33iV8I4
 vOLpDZCVi6asFrMEQwY/xo9BD8E4XzKAUcvYC8Tct1g0SDkUdGfFTgNI7cmWcp+o9GOgKRaCO
 Hwku2dgNdrZes3oxY3ywDv+obSdmYdzf2OQ95Blf6vJMMezHUkM+xncig8Czbf1sqhmLX9SaW
 gTtO3U7zUQv64KXbAftdzLKrGkFugxN4iy6IuYLb0WzaNqQQmjqc5ifuSG75Yb7PkMcYv+GRy
 pYO6lI+PNukC73VcfPFCGZ8GVq9+xis6MpjBE+9PNTtqL4VbCDF/hSZtyc76dStr7zsZ3bN3b
 nqAOXocQH8OfG+WeFptJSiZ4zX55DSj0no+vqCAl0h01kb5JM/cfkPcUnPTFlY1z2WF+iP16V
 F56+DZQcLzxtdpbA43pYGr5rRgSPG1vX6t+qYbx6DOJiJvXlUBtUHk/2nH/XW3WHuUkFI1l8f
 I+Sl2XhpmkpigKGFXNsTIe1cmAdsx9hSOoG8w2CUvewqBM8k0fXqFYCFY2jbnOeQoqpFq14pO
 u5MUwaTn+AZ55dw3Um5nAHN0rBl3gqxjqnhonvoG6rr7FlTkwqN0qGryc6qXpOC9nqRBHDwSC
 xf5koVceBKZ4eA9AXxL8E5Wmm+aYlc01rfXyoXubavTHU9UOGo+Uv+POix/J329IBZrBajJEU
 KJ1CRF/QhNgfs0M1kl/tUEAD29WB1FyS8guF7LD1duSZFj+qQpkG2P2Ti2kL0HY+0VTn4m6mb
 eqADNG2f5eS+sJH7uo9g4YZ6hG8vg/b3g65gqQvMS6Je3BUAiLX8QW7e2JqP8LFywTeci15zF
 7jdkOkLfZ3JgWKz7bn/cKorLeTVhkrobMRkI0pWJbWkbRKHCsdy+3NNh4tWee13nAu+Yz8Qk6
 jl7j1+0PQSlEDMGuZlsZJf1Nk9NiVhpJ5a6ifysmJe8os8BeoiF1Qrfn5Z5Z4OUsW4qyw/pGA
 bJ0etMA6CYCBe6XYyRh340n5uZQfyK90p21D2TD3eTjV7aORwg5uEzW5Y3D6DDu9JCNZAiemH
 2ZJBrajtgB2E26Q3fYuDYZwmgEyJCLnTKYAPxPQ5YK2j6kviZ01rDqFu15BCIKa5jpDL+Lrzu
 MAMpIGbvWW9Q1lji0ynGkKgjuvxAKIkWGIOKnIU8JUnExSwfvCfYuU7zIz3JHfmjDCJ2oDLyy
 xtj1VpveI3ITi4rzswYRkU/MjntZy4k6+KKW/hScRVZVMBVnwa9M4/oMlknmlgVrBqWgNtU5n
 p1o+zHFTSi5CFVVs0sPb5jjbM/x0zeY0Yq5sFsCs3o2v4beFiFwObeBaPpWlvB65JB1RAIdF9
 58sL9YC+MQIBpNz3O842brr7sXip88P+jn6u9rkFj1bQMyR1mzNglR9fRP8W6e0qLZpcXDN+A
 3TxHxxkqrNQzn39y/Xodq/mXxfd5NVaQ0wuqUzawxZ7wkaa2xZYRFcE8f0fkFN47wOCPLmmJk
 JIyC8c8KJdyf22IB5eIwy3bvIBlv+6iOfnHTxnzSDdsIAaeDirqzUuNva60MZVEzzY5c+yhoX
 zyOS27g0LxPGTL8CkvZ8WBACmJf78tpUJnDJUJjeaXwPXbBhQONADxoDSQzsG40SG0XGF/sMu
 jUuSWsr4YncBtsDO9mcTbCMKCemJjwn1WnZYuAGuEZ98fN2jm3fykr5xJYIjqD9mYs3V4dDQ5
 hqcQ+LNLUe5E4rw33j0Metx3dsMpJMl9QqceTgywuW7Kk4vn6pZGcicAxp6G2iHvautkJbga1
 BS3EPQtf1CDCVEArTtjGMTf+TCMPbRXv0U0HAEEwFkjG+WwfOhTQWKZjZIRTPkGMoG2aF1IzI
 vnXrUBX3CObIwNOUsEUUPv8QF34VPKSRezPavaXgmhFhM2fZGnVMor9AKZNIE+1++H5/vR9Js
 yN/GNIpcyoSPwLHqxQR5uGgl1ADOfqIaNxD0qgyqhS+DE6ssqzDxtzXDe7B1bSc2EKdo5vOIs
 XN/LGw7dIzSbNOXJ8iL8zMjKhPyp3QftmTsj52ahyhNQiWg9yeu3t42Cz4i4E85G4IBeJqYqK
 qf+V7fXD006kf/7+0W40DedVZvZxxhOg3WPf7xb57/fidMelDGfCb37/5RXQqKzd+YJwc4xmp
 SSakA2R6OBsVNFJbNSStmLP8tuEAEIh5sKhOXYh1MtH4kMyXcUuCXLCxgBExyqdD8sXrFOD94
 Ny6xnsDVRnAXVg5xuxsetBG+Tv5omD4Qa3FtWFhy3/XTp/wkHWrN6BTidmM/QlWnpJGEtjb2B
 c98VdRBsvxqxwxfHZrYXQ6q/TEANRLiMXp5uCKxsh90AS1E3VCvXBEFDczWe7d5GaHo6q23pu
 GGLh4ICK/2za+mlpL+HfeSei6POX8v9fDta54BCK9ljpgCO2u+nMt2CKfDFjH6a1JvcXrJWH0
 ocgiKQNlNQL1DOFprARKtxRB0HK3UFJjqc14qoDN4t+7S0YdRiJ4Z3/qbZzULcJj3G/526czm
 uWxPEn5v1dd++8lVwYpqTDGaOowZEX1U2MBQv0lpfC7wqp6RIk5vgqYMrpLbaA4YMEz04WNU2
 PfcvDXrMhXRTsirZQJL3p2KYS0cXzYwktoMYMhVhg7H/aCveURrtIIwywgAJkJsZc0/TRb7e7
 DhdCboR/S6BzpT766w8l9DShmY+R+WbtJ+5cYTaFdFee6fSTHnj0Zb2rEkC2GV/oXYCsJZ0aD
 eliiIgSyDsfdn5GIsOKVEP8BWXhw1nhvR+W9b7Hf27yttSiElrApn1ZLRSt2lnbzCnWJOVMVb
 1n6uyndpvszNe2xNJTM1mr2h2uCF2RwtjmBjbY25uc3JrRjjuO3R6hdOybO5zTuml5J2wIsxT
 mUxKMmpkIdc1RLy0yJowHLb8BZFQG3YBC5DcZG3CGZqQ90CTOQEMpOMftAWE2RdWLpoDvVmpd
 KnUe78krRtV1O2z0lDRZXWH3oXBVE8m3tS/dRKhCpOJRFjNp8tNg6hfp7eYGaK5PYLTxuHkkA
 o2zUHbUX2IQm9K8OBKCxHDzgFquWXU+SjOGWrdlQNFu0K6Wpnf

On 8/25/26 10:04 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> worktree_basename() requires callers to do pointer arithmetic to get th=
e
>> actual basename.  Simplify them by doing the calculations in the
>> function and returning a copy of the basename directly.
>=20
> OK.
>=20
>> Remind programmers to free the result by renaming the function to
>> worktree_basename_dup().  Two already do; convert the remaining one fro=
m
>=20
> This is a bit surprising, depending on what "do" refers to, as I
> read it to mean "Two callers already free what is returned by the
> worktree_basename() function", which cannot be the case (or they
> would be segfaulting already).  So I must have misunderstood this
> sentence.  I count three callers of the function, so two do
> something while the other one that needs conversion does something
> else.

It's confusing because I changed "callers" to "programmers" last
minute and forgot to adjust the next sentence.

>> resetting a shared strbuf to freeing the allocated string, which
>> requires the same number of lines, but no arithmetic.  The added
>> allocation is negligible because it's small and there's only one per ru=
n
>> of "git worktree add".

> So going back to the confusing part of the log message,
>=20
>     Remind ... to worktree_basename_dup().  Among the three callers
>     of worktree_basename(), two immediately make copies of the
>     returned string before using and freeing it, which makes for an
>     easy conversion.  Convert the other one from resetting ...
>=20
> or something like that, perhaps?

Yes.

Ren=C3=A9

