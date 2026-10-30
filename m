Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349962;
	b=n/XaKviMa7S0PEYEbDAgvtddphOcOSBapPFI+l94XBZZaFdsIoRIgYz1yvPtP7dYAX6g
	 /9kuVhnzMCsHxEOe0qS/TrdGDKu73Bqq35oEkI+l1SDXUcg2ZoBO5v7qxz/GGAr6KlViT
	 EEu4wkljWAg+8y67xZK+2aJ0w8/bYxQzaERs68JN7VO3LXAj8ybJwFpedmHwFzgOn/4L5
	 IPluUZ+CoaPpKtwBcuq8OLHOD7+VXg9fIwfjciWXOG7Jwlx9mAX7PnZ6N0w7dJce4PXJg
	 k2vTlFMZkpYk4nChePiZBOQX0rH4BQqyox3ct9mp4TLis3ATz+GqGmJwAnV3831uu5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349962;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=YwAj3bPn3BImy1uMUUYT869uHKcd5Liihe9Gx4UffYw=;
	b=YrWCXgLPxoYLUszfinJlfmQsgfsaReT0ZO9CvPSpZPyBDS7IHiDNEqZN39Xrz2+7eCsC
	 1CrmqmEYzXZTn8N7ugwzsHnya7/v9b9xDoRuvdl9Kb5pWwlUBD3+rvxYknKxD/F6jYOwi
	 pNzMPJjQjwSLTjxC7h6JCWpex2lMjzMdaoGN8AzdNtbXrXkXrT49JgQ/jsUurjlxDK4n9
	 DU/m1CvOaU7FcyfbTynslO7XC2HURAx9OLGwGZhK2XNopKnrslj3jmWEb2CwkoqWlleWj
	 u9gsG9+leszSqwAyiPlC63F+mAOsE6pDm6hooq0BhX3o6L3YgopZphqJDJVdKoNMFZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HbfrvZoT;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CD606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A63CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HbfrvZoT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793349943; x=1793954743;
	i=oswald.buddenhagen@gmx.de;
	bh=YwAj3bPn3BImy1uMUUYT869uHKcd5Liihe9Gx4UffYw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HbfrvZoTVW4vvfBhvljL7POD94AjWVqQ0ZmZdpyAlIHF+fY5tCWiCXxCUtWIXZpt
	 yUVWk1fuLnUOBh7gQxF+5YHhvzEKNDXwJnc3NzG2SKemfCC348IhhRe4orQ2HyuNX
	 4MMlI5i2YyDVzoNYKZ3gJhPlZBeDxSEn82q3GVqka7Sm0ikefnHDEMJ26RkDvkbkV
	 DjHtiAIPK17jSLBCqQ49jWWU+RnH7P64zSE87SJroNHNcVaKyPQrZa/sYlyJtQ8B+
	 16eNaiP4Xtdc91i4OmcwCScbY3t7kmg2Pm/52jY1P4X2GIPqtlkAnulazz+XHCGJr
	 DRCaQQSnDy27lgMGFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1xJhQQ2jhl-0013qO; Fri, 30
 Oct 2026 09:45:43 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1xMiF4-LFb-00; Fri, 30 Oct 2026 09:45:42 +0100
Date: Fri, 30 Oct 2026 09:45:42 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: phillip.wood@dunelm.org.uk
Cc: ian4hu <hu2008yinxiang@163.com>, git@vger.kernel.org, gitster@pobox.com,
	peff@peff.net
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the
 same signal
Message-ID: <auRZNlHezwALJOD5@ugly.lan>
References: <20261029141521.164544-1-hu2008yinxiang@163.com>
 <4c2728ca-5511-4c30-a2ef-6c32fe7a3e9e@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4c2728ca-5511-4c30-a2ef-6c32fe7a3e9e@gmail.com>
X-Provags-ID: V03:K1:PC6Ql0HpcfxFphmcva70mhcow3QyD5iSE+AGz6fLi4c2CkZcV8w
 P2xjM6VL/ut8z3+qt5Dvu3u8mCrl3AczYKRU1Ad9Mfp3J1wqJGTk1/mdVHIwNrKNiKMYn0q
 JqqoAwAVEYRKfqTWyKPrF9Tf8FmQe2pVP+PiSiAr0OtqriHvZbT8L1u4Fq4ttFRJt2G7fSQ
 39T+cWyakrYmPVg5beCcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SMs6skNyzhA=;GMLAhe9d1dkzSNrgGLLImAcf6bJ
 SJrjC0HE3YOKz2rFb8lh4cVBtPzYeuac4bNluOe6AQkqQabvhr5DTuYc2tnG69zeSmhon4iQE
 t/EO4q8UqacGAfNiZzzaXjHqlqFTvNHmqSgomXaPUAX3wvQw3hzOKLIt5+FzgoWCyS4lRAJG4
 OFthL11zlfI8vCAclYJ5cC3bDv6cIO3hTdCxLNMISVkS1WMUmMG94iFGg5MsUaGWg+ElxdnKr
 ivEupMtR+6+l1G56ySB6FUxm4Ymxuqbmq30o570nz67pMCQ6mPtoYexeOefhhLK/+hNX8KVFY
 4aJBtmO7EEWcP3TYS66NhKmN1qXoEg4FEkhf2eP/c/M3nDb3vCONJY4uVj4qxwrxLoUY+d1+k
 XjL54sYKS0tnDABhGIPcIiBwu33gvQfqmO0nH5Wd6ANsc6+XtqRAenQxZzrGVfcTVCxqw9vhb
 3vblnGFpYqPIHMj8UIwFgxKya4ekR8zWG7CUk7Kh1em1EkFyhK3vXqzOVGweb2lTzve8tHX3p
 xOIAFA2L1Eb/rFCIduS/XOiE4+7BFZUcjF2piXkoboRJvuhB1l65VbenirPFUv769CLhwlkk1
 2FTgj2vLtGoZU4rmP3Cg1HEXCMXMyCou/tZl0WlNtoBZoGZcsgPgv6l0ARnEMGEWOhXtpp+M7
 +yJnloXPM4HNsXV6sEy5NNoOCEric9UUc1fe21/jho5nNlOUsLkS4dWxziKfSATSsPAvWr3vX
 SnCm8OUZnk7PR+XTK8B3BUYSPgjTkyNTxDzK27lne2mCN0k6bKFm8Li0kN92NmOf577unN3HV
 cCbKraNnLUEc8ZWyuduQQpZRH0cTBzI50fLo49LOBhywblMAkvxzVop5ltLT1ipao1gu96/Tt
 uBsHW96Lm7t9olZGGZLbsiMestc1dqq0CIu+q0kCKoLf0euVLubpHIsLzaSug+2LKWx3aQBp1
 IjFxLC/ako+Js0fTOHPgCQl40msWqIwAkywSlZbazq0eOyrfnwg+a3LDI9oAiKv83XwGGjn/y
 H9KaT2JP3Q/dZfk4GcqoCy1JJGeu5Cg3OHabgGlVhUfUmPaPXmsNR/etVygKx6vfEpahASuCS
 QOHw+ZNz7pUoD9zHYy2qMdW59OA3jzJs6RGCsiGF6Suy2oQj8t5OVY/FwnKG9AUKORxzZsqem
 +ZPapHiTjEsS1DODIImHvgrxldY0yuNKCmWUSx2Hh49NmjFmHeI/GCta9xMaaI3nFi+koSSK2
 orK/pkrqK6K6llqkwlGW63nzXvuw5TE+jGL9J9pFJAYXxGa9ndFKuYTG++IRPG+/RyKt2lFw4
 ZYLf7MY+aFRER0WzgUHvXSDZlvemhKjMRUp7iLpJ2WMlCB/NrivVhgLFdkogylMnJSgoNMxtG
 7lK6DXSZSgNYU4yUd/wp23YirdptI5FFS+x/Owa5ygjxTxtE+iKHFaqX32NOTz/H1Nkwo60sx
 i43uXd4RGamI4h6wRfIqZep7G+MyVQvqUIfIFd2UFu/YWVfl+NEWptqNbf46fgfSXcXhg1kh1
 OTjBJbv9M1uQ/nZTmLqH1tNL6+o+tO5w7mx/TJWr8nX4vVmxn0zAARFWTJ1grZAD/EWo2Z55j
 XMzOLXhmsvUZOFB0F6cnB09BX1edP9sSc54v9RXLQdzzfAm4/iTeUPW8xu3Px+hpDyN5fKP0S
 oJAQjnA7OjwQpDaQRCSxhxUK1t0wt8QER0Wsguh5eDs+buOpbeD8VJA3tAq3bpQLc/ka9DB7+
 sYFESztoDoEw+WIiUVOTL7wxtsgz+0PGP4ivRDF2ZRgbwgl6/U7gjYJmzLO1y7jmLcMNyuFSf
 fQ4sO8BFjqrxT/GnX8iePNZ9HxfsBVg+AJhu5e5CVLv1JVJl10FuTCa4Oo1WHbUIuBquw/yIF
 IJoKpgxZE2uFxvv1e0rvyTPV2dvNgViD3oKxw3hw/kcTlGuCCeKwQCLCHJ99IxF128O685buU
 t3zuloLizJPSF6QkBpSjpMS+puE+2xOPdObhHtqbzxaq+xJ7NfQraCZZd9pxJcd/WnUoEHNBE
 +GClB44e9z3gtZLe6QYq+n9ERueFfUx1BpvTXYAKhDe3J3xfvAhtwFRE8/vyDBlM2/INdc0E+
 2XQPgvdVFSq83jGJyq8dZIzq/ScuVemlL1PTVX4mrzhBtyECHXhFvOCxF7YqICxoRkNu08jef
 FuMRs1yo7kODU934lMR9/IV4TDPu0sVq8jKbr02C181bYedSgeN+g7VvvkrMotX4axjmt1/P+
 xRoO53yC2vSmmROfe8yFAg4jwEx9ENkcb/xQFWFmrAojjgq4Yfd5RgzQPqR0CZYezK+wGaFfr
 5DoIXL3bW6l2zalzJCUwTnja2vmsYJW086+2tKuUyqCgmATWcRyfBxgbkX5pnR90mfYdPf7uh
 gCcdFARaB2ph1xUO4LXn1FkAwxLIxd871wL0fh0EqnZgM3jPGDPingQ1Odifc42wKRq1Y1YWO
 gGYy1Att+aOYfgtng3cRbyIoCK7uoLVuJZok3D6Res5VKw2+oAhuJgG8PVti1gn/eKJQttV6d
 tieKB6fiSikiU7INDnU5E6dMFEktB3nO54bM/tTXQ3tiK4nCiwJ+ryuO/twYrG6vAa6oJjkeF
 wYylGC7ySSlq+NiJ5z4zffJuVUvyF6AqiB3rIvUNn6H1rYYWZP5oiBfJafbrcxWRYlU4gYlUx
 xRx3F+5OozUcF3Gk3OPiE2MOluCZCn9coTXK0nsf6ss76JMEuunwEBowIHjPbNY6PtYsbyqfP
 oZ6g02kcFtC4FjEYRTit988t3pYCs578hbuT0E2dMvvljZaURgXiMrKfrpZuEfI7b6OvNjDUh
 UnBy2G8sN/g42RqF1WLeWpLjtY+hSORWbdY744XwB46tGCR3RQhEiJ52oqV4nSg+vbXZND+CS
 q92B99CZ1CneH/xS6MWuSPf19RG8kCj5ubJNuatcuN3t5wQRebemBYKUQukDNkOfz8Qx5n5AL
 Q9oIi3ite1frUg+impBCJJZJTJaHy/Z0OTuEKbAAPjm/P9PJLJYiEMEZM4DF9QGOShW1XLpli
 IgBEwYRNIzLEu+Z4iiGfxTBggrPx9pqcCtARDRG82Z47ma8Z/8mFhjhyvkIwvacQjQVz6IcdH
 vhgZ8brXguy5sErX0YWuxUjsOzOxtUH/t7KB3tWCNjdMd8gGI/GXqY/ec6dxiEFS9r8MGQPqw
 5nunRW9y8SZmoAiI8cqA1yJq+m/muGHRWh0W0xE7Fded6ozB+7F5+ZCeVNJvMYPptbww8z7ma
 6mxeFFy8ixufBiec++jqFQrLym98vUyrlvq5g05N+dVv6+w4vv+JIvSMmbduanPafHb6QzH2N
 GqGnOTPWvqSnT4/sZYRUroeknrF+oXnMGeJ1TcSag5hdULUydwRIv0bMB1hTF2W+Z1xKiMHTz
 esp8p2XEVTruFTNJvJkkd8JT1lx8wGfAiaxfOpGSIs8RlWWMdu2OcchXFOuxXnXudxcQ7Nsx3
 olvUi4u23ufyXOLFD13T9EDZwQ33j07/zFvi0EP/GFJ3BdcQOFYKVWCZ5Pd57MT8tXlYj4Asv
 3fUAyKtbEKT2tYYhOBoOj5V7T8y20+8MZeMAPvBJzNmuRS4ng/XN3hMFjIiXBp3XLrWX25wQA
 bCUSem0rsAnmMBjztdiBqUg+s0Yc8Kz39YhgJuxpGrKome0WGgHNEyqrkOfDIIurCuafIbKji
 47ra8t/BgrJ4Hzi4LFMj5R0mG/UhLPc6k7iDaLb7Po4hTbonuLmd94Nuo4VbFe3Th+4l4FSGo
 3VUdtUbbOQsq+flewM+McAnnD4Rgb56CENJy4IL/zxOwZk0xGt87Dne/lBDIod9H+gcL8mzgW
 7UOHvU2sVwVEIOSG5CUI5cVDBCYTJJjN+dVFG/tz1Q+hbWMdnEvyY5+sOr4FsSUtAf7js1QXU
 rAF0zLB4NrNGccYrGgwr4eKYdUVRcFjcnXnQMdOyIjSFjjOUaw9TP9tu8qb3GSC7LHQ/l0L3a
 U0CMipnpIOEWGy+asDMMzs9AOiL0hAeNYXcK1/QVGDI9pdGCZwk/ZxwVMpDGD4AQi7GGKO6vS
 3KOapOs6OePUnmQaczqLuBrPt0d7WvivNb99OZ+8Ddjhqo14Uz/dsmck7ZiG7MV4DRydBgmSu
 I6mC7KTAr2PSkkeiWVtTfqZd03En1Xd4Sh7k2Hbk0Ph4na2Z1jjacPdYHv/hcoHClosMcRzMy
 BLuvynNvKVCb+eX+ntV2IhneENT5/H9YEc5NsvMG/fm5ISBAQnKgTWHawYtGkkLt4ZjwJVEwl
 bRoh/hcxzyxLe8YVgue92UWYEVikIlz7QkN1oU1p4LHBBRbv0gWoo3EB7FWzqwlMqjqvVpYPR
 5ff52CvLYV3qH4zJndoOhnmJ9AcunaGkc4WDAOXUKVmgZ/5yV3hvPnL69iHb0/tVDemDpLvLi
 jpe4P5WelQvwUzGU9RIlJ5ZAcZ9OgkcDF7poFKbLAw7Ji8n6p7POhmhsJnaMSTdGnvOuS9eRH
 C3l4OCQDx7DM4JSh0QfFgO2IVQlOBQPhwV+D6tkqygAwVLXz9Q4N0MSSXLe7n/HCcn/bGoHu4
 70DkHgZo8qGluH+G8ZZl0TWL1AQIdLVA7Poa1oUvPwUNjiLIWTf4HpmQjBvP3cbGO/q3Elio+
 I/GIPjudYWTBaCtx6DucXYeAayCNMR4zB/E9mmQYbeZ6V8ZDfZVWQqXztn2J77Hesi70Jl6Af
 lJCfHFSE9CrfkPkygqPKTqfl1YjshM2z671Iyj9qWFGtOn+es9JyVnn3JjljbMoSoSVYLju6A
 cjXDzNZvLZ26nx/L5IipbGPQtpdvIpf27JCoVykWqw6KgsSkPr4MOZXEAaqUGAh7Aq0DKFQS7
 R65o7MetRPLpr+XTG1mhgx23cw/PSaBWb+pVf/jxld3IQS3OhduGXGtOsd7USAlW1Bf8UVbFE
 UqY57bacd9X5i6s/RKQLM1f06/aw8aAyT6q/KCT8pHH0EtOLZ1wqJPSKGOH078OznB9jvZkdL
 wBMo1gtYmuvTaSE9u4Iep1788pbfliiQNcOXNwEmvh2Ij25z+Ym4lZhqe9RUQyvMORY2Px1qM
 43JgxQU28b1sO7deBZ1GydTNbrtAo6Z1Er5RTPxT2vuntGmuxWYw76O58gW+xSufMLXXAD7rJ
 gPKIE4qMedcV7+eKtivb1pIaeMItFhq19w23QnYoDPf3JLuXRDpq3RjcodyzvcjYP4tHxpX4a
 vGmcTSZRr3erFCDmjSDsv6YmkrgRFHYXZBPuHXLF0864Fuv9nU6QWjBd5Ood/LOCGwcZSGE9+
 tdzlScf1yinRthdi0C/Ogzoi8y6sxzc3Pa4j5xZjZgCn8HLW0ENdnvvuf0aiP2h3TFvQiDdF0
 BLq1Lo7D/6KSlY28vMmbygr8yZGI8F96+dTGyyCxHDV63pd3IP4gnZcLot/DMWnMmffNWL4+n
 J58A3kTFuEKaz9c9aJNZQOCkPFd9uaZYvrLqnL4Jt7zx6IOPLJi7SYSqGNdAynke8BD3Mkai/
 IDtBm8jjxDBXs+7fovzLinCpoaK87c2W4Ahh+9SyglmmFi2MZB4/TZdjjPNTyHG9r8KNZLcbD
 zHUvvBJcTu5/cR7Y3A7hScNjtSgUwBQ5OPp27PzVUT1mzKxuoghPuivWE0+vstptKz/GY7BJG
 cnZ9lHZmSCQehj5NJK4J99USQmZpctz6RSitkCpmDc0GA7xlHVQxBtFmUC0snp3MqCA7QzB2a
 pBPeNbtRS183kClduQdUl7oAf9oD+PLc4Ottd/JawRdo6Zf6a+c/HsQOtZsW7s60UiLPV3eTW
 cyfPgdq8f+bpLQUDniHxLgRssEcB6pmD/lU/J4wqa6esfatwa4lX0nnWEHEMEoLDj+/12372U
 9SKgoYg87bRxciSxl7IR3Uoxh93pNQUm8BGEUmnNiuQVvx2ZAtXuJ6QATkQ0dQ+FZP5sHBUzS
 /y44AHlePrdmnSrkK8hcXQYKMPrxaeVvpw5ZIKPUs1M7+Y4pgVVASdpGJX223A2Ohym2luBre
 3mHk8ZQAnMj7FZosMmN6gYk2At3vdwtfwD4HVY7OiFdJbp8VtKeefmvI6HyixRIQU3H2rivb8
 298WMrtDxemr7In5jIUPYbPsmfZDuX7JZTKiYHnTfU0ll1B80K14o0/uNwb5ngwXGe1Zs8Vgy
 MI8b0cM6uf2YceFNNNtqdjHFfWIUSnI4w1d35W+wIrwK+D1QJE6wDTS7DQ/bwX5fh2UwmkjWY
 j+AhARCSX9n4zh/8wDQZpBPmHD/foiP07wun1oN8tO07QcTvm49cZoCidyvqLOOOfsyc5J2nj
 8DFAPo8Ff8ubB6FIsbYfOlQEXOKfh36tvrBt74E8oRSSMIO/1gANCG3G8pdzqNPuNQWmMgLEV
 fZOvAT3thXDcpLkIyvpfUKfBTAHusHbc03kvn/hnTloM+ZwTRDvCOcd/g2BMG2gIyl3DGATAK
 TZopB13CLoCUcEfotcm6+OqIF7bL0YFitWZn5Pjog1uK5Sx8TnhCdpwxVySf3Ct3IHQxeQumN
 UFTATF4zoAgawCHr96iu771FY5I0/w0Uga/ddjZuTXPtP6TscKrW7xvj+VObkMO6eb5veGZka
 ePfItnPn/lMTA53T8sa8bYVYVpqH/xlJZGylUgMQTEW0eTBPyiIikaCc0klhI3d6m14xsaio7
 XVIsUBM7MpgKqB1AXYVhMnVI28aXmB4jmFZRHYsyvm1ERQk8w8J9A2IcIDahDHXyOEkikzcg1
 woAERKuzFgLta1+qk+ItqO5kca0lzTCFbhMc8/VxQVUGrWZ7jHsjA/TuA5/I/KaUwv6vl+1s1
 CJHHn/q80pRa8LKRHo/wTzgiMS9s8HmHv4GeFV2kPmr1m5gXAKGLXKsfelhknqymBA8Z7+oss
 LsxFdmI8Oo2QHY7telN56Ht7P2WU76Qhfaj1K5p4y//yUKFBiF75LvEV8yag/GFPfnXB7CY09
 KJbs0IRZpLC/2/fBIPM+WWtPj8TQCEppxmcUr9XUb1gZaA7KH9eSrCo4GwaLbTP0G9DvbQWJJ
 14h2X4iWfgFRDTf9aknoOTIi0Enffx654sZ7mJeHQuEZpxn7pTgDUkplAAMg91WL1F3qJ2i4B
 MRJyaNVSw8NxL3ENplWptNbDYPcw/jATrjh01vT8jjSLGejIPeT9b/Llpssc3uwZPgcpFideZ
 qi7yEhj2gKabxbI/WdzGTYd2Iu3j9ptuR2HEZdREqPbRwVCfnYDOmPukvxafGAt0/JpumBN4a
 cMrQ3jmwhZW0NNUZr0iQR61PxMzpZLEE9
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 04:03:18PM +0000, Phillip Wood wrote:
>On 29/10/2026 14:15, ian4hu wrote:
>> I left SIGPIPE out precisely to keep the "upstream of a pipe
>> dies of SIGPIPE" behaviour that common-init.c restores.  The set I
>> plan to block is SIGINT, SIGHUP, SIGTERM and SIGQUIT.  If you
>> think SIGPIPE belongs in it too, I will add it.
>
>I think we want to block all signals when we create a thread, so that=20
>all signals are handled by the main (initial) thread.
>
that wording again does not address the fact that sigpipe is different=20
due to being thread-directed [1]. even if the outcome is identical, it=20
needs to be reasoned about separately.

[1] https://stackoverflow.com/questions/21718311/when-multi-thread-program=
-receive-a-sigpipe-signal-because-send-which-thread-wo

