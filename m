Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C71C6F5B
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412713; cv=none; b=g2gGsa8P8WNSIYLVQHEAvN+5Z9imcPBQCf62xdNlj52zsZebv6fNR+8/YQGMmIk19WRuqCEzUHwPycxIbDInhHeWE6dAN1nRObLwfCgLRAjgB4AlAO8AILPbRRTMef97OnSIz+AL2lRdKzhOCdaGuzcz1eR2ZvQDyglLmW2A+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412713; c=relaxed/simple;
	bh=lL0E/xwbi26wch4V/Oe5nbMYWG8YHz+o2Ymqdtv5x8o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=GhVndxa9CojVyOIELInsUU8wPMFgFqUtlpu7/PgqQHqrEx2PiWOloZ5IQr1X89mQtvM+MCv4LtPZZTWLcVR3A5HbvNX/waHlrDjqqOyy/eBY1WJ1Wk9Dp6BCFw8SCEe2ULp3Dgz9N7+ihYZwFUMa3Nq3umNhBWkhDwt3unUIh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com.mx; spf=pass smtp.mailfrom=yahoo.com.mx; dkim=pass (2048-bit key) header.d=yahoo.com.mx header.i=@yahoo.com.mx header.b=pFt6Ip2x; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com.mx header.i=@yahoo.com.mx header.b="pFt6Ip2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.mx; s=s2048; t=1726412705; bh=Va4P9iG6xEjqio92wJ/Hirovxnkg98hvRvr5A+U6m9M=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=pFt6Ip2xyiYNJeTiTWzQCguj+5k/HM0P1Vys+Mf01UBm1pi4aSYAhLTIWS+z1JQertqg3Mn3+0aZ/8PO8QPpPTJ+a4W5saypc+ZW7904i1vsQzkIdF0A4vU3j72o90diETqC17owFHiT2qL0ZQisQrQn8CBr9BLC0aorVkbVZ8tmUsBtGpNT8aLOQ9k/mKlubCNZPDVSFZLRO6SWVNWZ6rIsgAEtACNuKCnJ/8zeoOhydn9/AsO+jvBv9Nbyj4qUofNGvd0DXA13NVSXX12ViqPwT6nm2nrkOHdiid10wQA5udn65cI39p9bOVoQf+ttXV048oqsGKVrMizZ9c9Ijg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726412705; bh=HL3GjzdAV/b/I/OoBt99mQhtt+964u9FkrP6YG7WdQH=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=aD/vet83SQrGfop+vKr6TrBEbpbLgF1vy9Tk0dXyx5EvPJfaJyWKBT/9kcOs0OcEhwjAw/vC6ToU+41WHAsOqQ8XHDg/sLAT1YF1c6Tbed8EkJ0YAkdE/aBw8tIQdYovYcHyx24RqnNntinHy2oIA1b8sARIBJLKlEAoknpXU9fH6TKEsigR+v+uoyXHDB5g2NnE8KYSjdYRtPf8iBgbthTCazePN1lJN2epNr41IFjuGXVdoB58LBGqP7syM4LTFJJqzSViCquiNs4F5pfgt0yH4gCcNzy7tSsJcpHgIbRYlKhoUwM4+uFDXWz6OTvCLfm+rq/LzXSvUkN8L3oNvQ==
X-YMail-OSG: mmcg71wVM1kE9gdiOW1oCZMpQM4eBjoBYw6iJBw3FKBIhPTDXs42woi8mzwQc3D
 6lHxLiVEpXtlwXXiFk1fDhOGbghJA_IuQ1jWmcAhzFrvuxGbovFjpfXmiEUST.FDY0PofdAUaFGp
 nRC0pb0S770RXbg6FgIKRP_dSOl0jSujNp8YzLdQ9gGhyn5WXDByup_8QcnS0Me62Cq_eWGrJvR.
 DlLrAN9qntG2.LIAwpYvqGH6OvXSST9KmAr6eru7fjTF9LqqevknqqZsEU7rXfyTYS2khs6kXZax
 kwx7nMGITqzngDIezqQZQu9N5yTEinZCR2B2iTEJKOj5cCrswd_feeQEIEIZusQEz8m4DONv8TlL
 r8i9co__iUk2uduILWc9L2nJldovXtBgICrL2ziwf.dKzNn2nYT20QZo7fIyP2Fkt1H_NOXWPqnY
 tYQiriqbIoMkEuDZu827qEIKR7Ea6Z96G5TjWVLUTQH0c9sqCRHPNh45hUE1rlwYPhd6Jolxo1QB
 JVViUWPpEUtIVdNtAqCHg3qtdOWSS74RxS1Khad_D.SvrKak7Xx.uNWFVQ8kgeWdCUfEJwo7uplq
 z7YNvK5fHAirVmyDf3Psi7e5EAjsdDzNKuTDz8Cje3tKOQYO3o7l4vU8TAkyDaCQXIMvcTYD8coa
 81UG7HOlO1ng.J005juKV.0XUm3zwp0qJYYgaM3Ugjzc8AqqgFuR1og4.lMFRfp3RkFj.ekVFsOK
 PLPNk4.Jel6k1F38hJ3CIsWr8d.7zPoig4usVK9VWkctfT9TWVH8E2C3VhZ0Ua.g0ycE6UsMax7L
 vEr30tqZ7gTaZ1QG5N3_0fX0lMXKnV.bZAkQ7qy60OZGo9wbi01tz.rGy6iPDo4xIHI5eUGcTMrB
 x_GrTkRCls2llVIX_I6siV6fCgKw.NrHI8vbItixbbxGZdCqoAiHlfznMbaRqUeF3Ym3zPKZRPwc
 NxiWjJL1Ev3VSfn6T0Etl852YLGcnNyv3Gr8WrJXXWJqlufCb5CvPbACyLfhs4K0UmNS8ZS44H3b
 jIFpuEYrBJd6UwscILYUwytR3D6cYaGBh0cBCZ_n46r9vfzKHxorLOjBPivou4JQpDM0BGXVwujS
 ymL.CTK.35WgpSlQFIBf9ziKOgif9TGA1iuSTHfwVCQn_rPKjq2caOoxcyUlhJvls8Tj5xU.REMR
 ET4ywQeGCFbSDgIFfTgBCHfvf4ZnjyXezeog8Cxq6Q1XaA.Vf2LH1csji.320WY2PQ6K2kshmxCJ
 PbzqTCjRxFylILnGexxjPeTHzTBFEN6Taw6ygg93VNxMHfYEvCsfAhcN8hZOlS0yec58sSJjgI19
 0H9w4N49hgWMsmj2AnJgK3sqrEI2kCiiAWMYpV.owZDHHNfpbDr1Z.J_D9DmP3Cw6KwOWwR6zU4v
 E2mZ1aIFX5oPmz9oobHLIakz58RuATAUH0enrb4PP1V_65YhlI24Koyy8M3varrgviwMcYsqc3eI
 _GC8YekC4G0PP3axxLxbfr.lGlk9LDNXPLvLZCaN0fu4gFczk9ZbTas1NjC9.PTU644Datc6R2W3
 2qEa90ahArEwnAutoGWUYjX7UJN4utgsWn60FZpFMHFSiw_hFODnJPVJtDxocxe4TwMzjblNLUfM
 TAmOZmzP9MJpANp_1UsCVE6UVMeXvNv5ZyQ6ezc5AVyqq_jTCl1Z_0jL0IYOVTPFtxcwixnhe0tM
 YeOEB47T.zx8DgdXq9jEOY8PKd00I7vmV1JDp5aTd_Io_VkSl8PS_UeZLs3so.gnRdvhxkol4YuR
 DDKO_dvk9rgXGVhlkDIp37isPGu8740qLcjKJ0u7whaH7UnkE98YY6hFb4xKgSAPm0fWYSjx_KxN
 ZIuVJfPadBvqpmyE7wTIQm6kj5pFQ4rG0cFMWY8WY0sMktZ2xH14kPk2LVTuVRMfjzWtedn1SU3M
 o_sFnd6tBC39FunrzAEt0SAHUrHEayD0m0fAN4JXDNrgenbK_QfmE6T6KrpZYfMpvkFR1T.eqXUt
 5IAC8E4HMMK2yMimkqiSRy3kKgfXzW3zY4wuWsM.h8RZ_89CEboEgzb0361utIirlg2L.kOaLsis
 sdGQDHZMqo4cRrLXi21NFhl0NP3k0F0FZPuTqoF2qRscyi8HDOR7m7FZ_QqTv_7A9RKmzwkK6Iwe
 sAXr3a.DVg5EDO2mhu4ea0wbGLIW3L2DOfMIeJnROwWXMaEu43bCZLCzIwhMe4ga7rSPCV_aoqA9
 zgwJ56vN7PyS6o3t4ZgCVsZnKDPBXttQOYMy9CVbN8ybhtG8-
X-Sonic-MF: <lgvazdela@yahoo.com.mx>
X-Sonic-ID: c78a704d-3922-4722-a875-1796b66af48c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sun, 15 Sep 2024 15:05:05 +0000
Received: by hermes--production-gq1-5d95dc458-vkwd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 528d6f2168c8e6f8f19f5981c9890fbc;
          Sun, 15 Sep 2024 14:44:47 +0000 (UTC)
Message-ID: <ec8a1a28-2e16-4e4d-8329-eae6fabd22ab@yahoo.com.mx>
Date: Sun, 15 Sep 2024 08:44:44 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: =?UTF-8?Q?Luis_Guillermo_V=C3=A1zquez_de_Lara_Cisneros?=
 <lgvazdela@yahoo.com.mx>
Subject: error ubuntu 22.04
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <ec8a1a28-2e16-4e4d-8329-eae6fabd22ab.ref@yahoo.com.mx>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Dear Sirs:

When updating my system (ubuntu 22.04), I recently started to receive 
the following message:

Fallo al obtener https://cli.github.com/packages/dists/stable/InRelease  
Las siguientes firmas no fueron válidas: EXPKEYSIG 23F3D4EA75716059 
GitHub CLI <opensource+cli@github.com>

How can I solve this?

Thanks

Luis

