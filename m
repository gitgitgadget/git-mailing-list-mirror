Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E472C21F4
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300248; cv=none; b=k+jqR+XIkMXIg1xKK3zC3W4M2VHxptEghjVYzQDEa0kGdmLNIoPjgNFax38rocMi4XitXAcMsOjJoERBeU0kuE1v1onnDYgbljw8LSgorTwkKAq9CPe9VTADREvaUtBb9WBBRiLFSuMOQJAj5DH6PRaUS42QT1SDYMTq2NXCJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300248; c=relaxed/simple;
	bh=kPZnzpzTYn47DzvY1WVm/bFR0iKQyQc++FsaqjQ6K7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVWwRXuWqG7TEEWwmP/5hel4ZneHYrfkSCe3Any45IO7RXYGGRB88Kr8T6P3Sw2VHD77rpAaigB1E38CMcwsBgVXk7zSAfwuqKNVb+SjQpHwTNZm/8dm3xzq6KRBrffsOkn1qfwB/VzYuyPbRdwDPUbfo7zADG2StWHtPMlQG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=YeC/3Irg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="YeC/3Irg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782300236; x=1782905036;
	i=oswald.buddenhagen@gmx.de;
	bh=kPZnzpzTYn47DzvY1WVm/bFR0iKQyQc++FsaqjQ6K7g=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YeC/3IrgOc/upgGGwPvSoWmMkU6ETYKw7iMQ/4umeJN8QHoKdJ6h6f9wI0iLZ2s8
	 pFRCPRwFrLNoLvTOq+unKBgThannsuZtIpAyfjkcXoNvPXO7Iosi0iHyEXwzxxD26
	 VbV3V8yJZc4w29ZNboMVBLAfeQqtjgK8mRHqBI7Uo8TkggOGG9bVfRHTbUScAOeEz
	 FCvUdp1Z40blMFWLeGTIB8mtktqD5r2zYnpfeYtGW+czlKQaTbhxTtlExvUkofhHj
	 bYV2fUR+PDFqJl5PYTgEgSTskj7qYWvFZvAgPa7wLgD/bdBy+cuSPpFseWqCcmN4e
	 PQWY6NywSaPW/CY0Ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1x1BoH1jCP-00Zd27; Wed, 24
 Jun 2026 13:23:56 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wcLhz-Wo7-00; Wed, 24 Jun 2026 13:23:55 +0200
Date: Wed, 24 Jun 2026 13:23:55 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aju-S7ewwrFMkfJa@ugly.lan>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <xmqqcxxi3eov.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqcxxi3eov.fsf@gitster.g>
X-Provags-ID: V03:K1:y04qYqGGRHiNdkFkZnzF1W8XPk+N9VqwsLynJJ7OdcBAThQwm2I
 6+yfbHNV9pPtADksIz2keLVP/IkcwPDLkzQqxLBS8vgD//vXqr79+GyNRiShTU/QSqhzljc
 YMe5oEpIZ+Xb1zz1YUmy7q6qZ0pLizIKDe/oS04qsmAbh6lr9YdQchWAuI7INNsSxUMvaln
 Q1gKPxSADRRCUV4NPzsjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rwrooIYQnmw=;OZst0AbKCPesAjTjODOV5h6xcw8
 h+HNO7hxhEqsf6NDQSs/E6/kMYQqy+FQv2GWlUk8x29pcJ5252wcx3I04nC7q7OIGzFXxXOZ3
 VZvQ4s3ESeSbsxxI2dNEpP/o+HbofXXGZRhFyYVjr0dgAHWRY3uDRnw28tJUDfNJ0P2pFPJm4
 7ayBtlBpyt3zUqQwq7D0GGR5Cry3V25l0dYLy3olzJKAWNaDWCiVpLjCMg9zNIog6VzktjGyi
 0HFdFlxl7XguIjvdXVMHFhiQ4HxiRZ8bCAX0WzbAMIB5EW9GPAVlMYRiGuIOnRfVKqKQ7tbsh
 eAYj333tOOEJHWf2LudLbk4fTulJipHAwFlbn0GltN+O1NNsGVXV1+VaUw1JkBg9YNXlnEdEe
 qB70iAhHtYs4Dy4twQqlVwlpjgG9SGWJsw9bmV7k93H1E2KL/bz/TFraaFA34DTp21CG6wdha
 MXPywBaLWE6gC0Ar2miXpIY6gM6ahm+ynLE6k+UAjfAU6SuXRd1eZ3h1gfPs5hPICDSO6aIeW
 18qnhgMm9tbpvxBaXASRc5InD6XZ00muIzFvwr7Kbs6vwD2QAHVKUfw7Je+ovnitHCw8a4wIK
 Eko862XeWMSN72bCMofMs/clMJceyRD3FZMNr6eIo6dhDGIloGry+ODnS8HQEaKSWeazlTJu/
 HJwoTE6doVy7ToRVxM6CUBGs46NiWLHEq5dHp/MM6r0A6pXXcrFBx3KLsM/tApbxUelMyPljR
 Le2e5fVKR1w8KZjCQ3YqZ65xhNiQABkiMZ/EJM4bFfHKFlhVeFaFUttLecSFfdehKxcE5yMON
 FPmzlkB4BMM4aw6061YcPD50sl3TuDPABVoaU2q5YU9hesWDxYG45c85qiH0Q6YVNWs1ODyp3
 BsSq1aOSUxizf/E9Ui38mdKQUu56/rRtJg/y5P5kCE3xTwoal6c1GDzHFfnwXSgJ4RAPoq+3D
 IVHB4oNHAZ89zswvAnL9R92uSQwWxgyA9ONMM7PvgeG/OzrF+Oso9TDmL8p2G+tH5oZzcpsO5
 0qyQ3u+VtUCZ3ZmFYGsyKrj/j90f8yC1erixTt1whtlz+wpzfp+WX/Y8tnNhN8RFRBamVw6hE
 n+fbUZkNISKv653CBAvqajru12qAptTcHZidUCM7p6ELWEQcJpaD9aAtSwpN5IYlz500NPtJr
 qGJh+j+yFzDQwpygOrcKhoFHmdqOCQz95mwoZJgKG4chY33j408QSSN+hhsit7BwlR16imRKN
 pCcPEYMOYAPR2h32wd4xVysyYKZJyKkyaVLiSGZFHsVcadhz1GVptzkrerYMX70g1KRuKhzdG
 8/5I7QcCB8XlN7XqAZtP/chx8P/XQ2g6oQYqYye23l0oEotTQIU5zMjJIARlFIHhHJ2QZVPhj
 pRc1SI/0vXbVCdDd6kpBdDbz9o2GyaFqDhe4PkutZt5Uyd8W9XeWrm/yYxCwy/CtqO8nME+bw
 q64SM/zHtD6aZZOcoVTK7YdpzM7OnIdvcWDkZCe6i/1gSYQpnYijFDg388xRJqOGxZTieqyf6
 /6isv44Hgg94CIXS+KhUBpk104WyZKPBNFgXsy3lQkP7YjwvQy/IHgqaNGSHy9E+gtq4i6pX8
 jbfYYye+HKoEHztOChdCjdpZQlQYGxgbAYCYx+zcokbMdWFm4NSXkZgb/sHei5fkUazF/KEaE
 Wr0y5ifkwajPMbKoF0QzawaQxVXzsWUPAb1elgk2zw/pLnvAH23XQTDwkg+VnHXHlwyPudG+x
 41+6ZqsLyDffQnebwGAWMiPEvoM/6Yyk9ZTIKRPAIGzksYGLtIJl8yUgv5Zhx/hs8h63XsKk3
 J0WBwqVu6YGhsjzB3nYqrX1jgwwcr6BmW1x7jtNHAy74FmIAkyqErx5UIlPhX+vTEz1rSvX81
 V/iKgGkas8jK+KePQrFWymHc4QwfaSZF+ueFd7mH6e8+Lfv3cCE1APREc+Up8bye29rd9jSRP
 2F3u0fCdyjLxwS7801eFjaqtyHsuXqcp5gxL0t/w0TIqBCoA8o848MK1HiWhFEvX5n7wHMaU7
 Wz6HA+yukQvOfFeYzKVQ42KMZoe40eGxzTk5Z0RAUJaJchQM05oGAkWZoXYUGPU4+XpeFA2GD
 zS6TDLeOM66UndEbbZiyxLRqoBlD3gYXQplWJyT9uReYJnPLKzYGQgyQEVyAD/vyKZlu5+uPL
 eGZBa/bfFdrcnugGV7yxq+rzZhFT8Q0CS6QwRbVjqA09ZTAB6RNEs4FmBNqmKTKLXqdQ2JF9k
 BSOawR8QrPtYeInIPbqFo/dLPtUK8ybP3jXHqtPcaArvy4mnRem0PeIJwXv6q7VIBvTGgGeoT
 lSJNZB4RmCulVmEtpter9azA21w8aOHYHgVdHHRYUEP+WrVkomM3vxVTRuU5CG8mRFaqdlq6W
 2lOQKMAR0IlDQOL2yd02UhW32Q7JInYUwA5j7pNpBfIzbJdeemmUbva726Tqo0B0gS6k2qe8U
 WiSg4lv0kpQUCcX/5OaywtnRhI7w6ybSjXaEf+V2gFXbe19wLXbtTh6WjgzG8Tn1oUS6i3wrc
 wLQBzLBUn4xBzTQSHPKTKdh3qkOr8cdTjJB4UTNBdCOwzNmny4XWsQ+ykrJU1J5fiOjHHB0CL
 24VPAME5zl4Zh6giggFaPhOqgiqMqhLmbFWHqcS40tXOnus+UmXSV2G6B7QUGiSWag1SmcCwe
 hqkuhx1rioVDVlz5tsKCJEWB63bJXjUG0bbJYApj/iCRZVFFA6JbUmRCzFw4fLPAEMV/oyxFP
 LYlF+5bu8wdpmUF/T1WGRzSiOO+9xGOLuaOziPO5fxV3bL52SDEK1d++9JU0yjtR6doZCISZz
 /WlLSV5Rh/9edmQgsGH81BjbBQh7Nqlvgt7ln1cS7BNzkIZT0xI/L+uHYkOSGvkJf6oDWfNM3
 6yaghbUZi0PMUO5vO5lnE9pxQgnCcaCxpCsjwJZRqUj6OwuOYFuStV2zZu9I0gPC9ZIrqJDme
 ZTzxbgxJCY5lplLMLg4/K8k0OVezdkqXjkJbnxLwcAb5zwqE4OIcywzVfUfL+98atFgmGAptD
 NkDd8z/25TQQINVi2oDJn9f6J9QRgK8Si5kuZ4r86blQTeZol7dZQs5H0OELLTPZwBFTWLmKI
 lmZwGGPVujpXfg0A7jQhwi9x4BJXoUe2kBCMNT6rYxTEJ0av6ykCgJr6nvc1QO2n2ALvIFqgk
 t3Gzdja7/InhBMsACW7WlwSiiRNd6HcSpLZVEh/eHyEOWt7942SaoDgDWkfd9UzOQ7oDiUZFa
 jit5mf5quRDuLeGYQFYiSzZYGLEpkWdX54kB93Nx4bfI+Y3Jtl1ih3utWhdoQJf6kA4JY4u9u
 ItUD+VsR2au52+IXokJN89heY3d07F0ICMAv5EmrsTePTNHrvl45K/xELnVggGRR4sfd6DoYj
 SQc33wEjT/etTFWuR15FV83QOoGtBCs0VFMkuJj0leJ/AdgMjy4Jni/ExqU/IxuTLItmJObye
 BkMsFuW/lO7ZBgfXAsnCKdYTXB6Lql32b71ndtxHTRqL+E2VPobxXySQEZFpYPKiTdw/xL5lh
 JMoRqeHcT6dN50bxrj7tyxvUMuAONfVqmBZjyQmm7Qt3NqL+Dfw0MHVk6HYE1WOZxx32Yi/gn
 ss02V4kAR+/sQD7CcU/WfNRxZ7y8Si48fc2qAvFg+z2TZ9Y6QFyX6Rr/XSjBC9TuebiFGiN3B
 rdXA8xarJm23GEjKznP7Qy88nDU+ENxdRMM/0mu/LmgXqZn43OB1yMyNYyWhsr34Csc1ItOrL
 1CQEI/ajYOq+D45YtBy7RuYzmVBk/ZlTJTLJGB9MQ3WpC1ZvQeDnF93MzzYxKVFMXAmJtX4yr
 rwR90UZXFwjn5tycaXtyvgJRQUu+rN2hpgy1aoL/SH3qZ+Ol+EMx7H8LpWvzFMqe5h2+V49IL
 KOYqQlyn5pvlsDxbjIeUFxE+YRN7RocqaTb/1cxpe33xrmi2oxj+EPMiI/QUaQ2qPPb/8L7it
 qTPDtfl3E2mvwMT8i71fYplgrmAWOpSi4S4Rp0iGMLTHucNOAP7GmNxZNs+Q3wCWUgvLBHVS3
 jH4DTgpBXkYbfCwkCIFLcJ/xta/Gxn1X/z5qgy8+QhA+GYoWKzPvpbEJcjhBSSt4TlvmMlG2+
 PwQFHBlCqIuih0CUpNED2Al4cPPSGoApl+KDdomJA/y9kHyfefBgOtInPcoKDklcZr+S+HsEo
 wB4WJ0jRml0ArSjQalU2gL5Oyc0gmmKtbpQbIbt3GdlV/QzR/n48MJyFNdOlAuykHIAkvsWHO
 4tbM84Bs5TF5q5lmdgvT704vD0dnksPKI7jc8FwlFZbyGxTN9yLMlJ5Lpw7tcKDlIrjEcjzcZ
 QJf9aKbytzPEQxtSRXI6p//H9tzllfZ7RbRf9axlNJsrz5mP129DmCsR59wLplnkPyp7hG7ai
 /6LPRJCdAUTZhVHsh8OPNugCmqVQrtMhwgaaVLK8fWS2M1ysJczeEFQGzN2j+49zCUqoKtFDP
 OEO/CLO4qcKiLxiR2YHMCe3t5SlFs1XmKwEpuAzT9g8bC7mAmPP7hSBsrvG8JthpcfBrNj1+w
 ykw17FL3tCysmXQzn3FDSJFwM7YKOOzKJPiZqKt0hCggQ3RKZRkCCginEXtrYqa6cKIT91MFU
 6d7qc/qR7CKlN1v3Yb8vLWFAZEMDuCKeGUrbbpZPUWXrWZcWWUsaRjwQZpWdP1J5NbPI/dFd2
 Zrh4zLxJLuADQb8CSiAbiqsxgFWYBQpfJD1Itk9toFbUxsnNyz5UCiKSIWxFecyBHP7G+M/ZN
 nwBlyaCC5tGEjKkgQcuhBWaMt6k6EIs0yhU+knqvEezWtPeYhJHNyAf2vu4vX14l6CvrQ7VNo
 dhp4MbZuGJCFY4PXMP+4UCU28m8qMcACnJRDnyxOlgQrISjSWCOhjPg4omeuV5WA293kCcT16
 jR4qO28lOeW77tT7fso94+WEhr/5czvhbb8t6VCGD7EvctLobFhZhJ43YI+5W/9DmdJ1FCmtl
 mJ/m/TsUMVgksH8hbkkmm9qk6u7xfhpSMkGN+nQFG5Fk5i6VfSm28YZqMLTWLY5rAB6kvZeuz
 5P44ORxwMza9yBdoa4vL8DuK8BDz0ppbnhcaACyEBobXOyzu1U+LwB8o03hORqfDpReHqiO0B
 cPnEhuSJbmhIKsZtflCelgsZ6Oy0sgYkzgnd2pG7NyTztWFw1Jji5iiHN87FtMcqsHJIu36hW
 xcvzkVdNRwJVsXcXM0MGVR13gx9YwfiR1SLCq+I1EU17vPNtVqrpmtiIwu2a7CFphYJdaSwv+
 7wOWTgfXKSFnQ/C/bWFxG64LNMnq5IB9ABMFT/7EcFfOuI+UJAQn12F0fTa8Rty4gS059Rgg1
 cnWpYUl2A4aAoKHV0n8+RTynH1zDisu0rNPEwmOVP/1JfR+ttTvipE6VWIkQy4yiQjgoxYpkx
 fjtvQiBSAWCHxW3DA2oFnIV7kIRdj1qTiw5m+t7tdN/5VSuLcEnBz2+2N7GhZqaGITZhDkvaN
 3RpJqjA3cCichZ1Ie1vsTTHn2fngBb1RtAfdMuL54wmzgNPlmKpYkIaK8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 06:08:48AM -0700, Junio C Hamano wrote:
>it will make it harder to make
>fixes that can apply both to 2.55 and before and newer codebase.
>
which is why i would recommend applying this _before_ the release. it=20
affects only the build, which ci checks rather thoroughly, so the risk=20
of doing it late in the cycle is low.
this obviously won't help with backporting further back, nor will it=20
avoid having to rebase many pending branches, but see patrick's response=
=20
for that.

fwiw, i'm totally in favor of the change. i've always found the current=20
tree messy and confusing.
