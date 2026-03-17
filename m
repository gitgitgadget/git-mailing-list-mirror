Received: from sonic305-2.consmr.mail.bf2.yahoo.com (sonic305-2.consmr.mail.bf2.yahoo.com [74.6.133.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88420DD52
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764491; cv=none; b=iIgQJBrnuOlBkAPIKUYZqzfwoVOd5BSTeQh4okH8C3cSblHBHAxFCfzpqz9aIDdMRoV6v/RprQM3Ls2n7Cw29K2ZVeVacemx6uOnfsMrW0py1D7NcpfQI/XEMgZuhNlCvaqJjWCPhHL6EKWtefKJyYwUAsz0md0+qmejMxuOukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764491; c=relaxed/simple;
	bh=8YBQXfbjISP+Tv9Q+j98UhDBNoMp82HVAXpH8DKin9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTMJRqZHUbVRTAHQS/iuPDk1RYsjB40CtbRP0TfjOmVT6ezKszzfvlunGybYH8f3Ww9HgFB/NQQlwSe/yj/wOV3urczVNUta2ap9boD7PljfaB1f5kGx6gCH3SZLr8LiiXaJDq5Y+ODWawDnOZBwBunRjDQ9q0sQsMNZl5AWLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AkQbFNeE; arc=none smtp.client-ip=74.6.133.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AkQbFNeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764489; bh=8YBQXfbjISP+Tv9Q+j98UhDBNoMp82HVAXpH8DKin9w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AkQbFNeERkt9dWWOLnovWN2h3HolZ+VfChau2WuoHWak6u95RbUAXgTRcqNFqDoMhdZToqJKkIDCTHpMrjCHyyN3zijf3qQFkHFOjdgS7EbQdvzbuRu8Qn6965WTVYEpq97G1T9gV4Z2MFakzRnpvY65xUerkZVDKunnHX4ZJDS5t8OqwUvBLgEDJWC1cQ6rVZ5rcXDYVqH/8GzBdbSo6MguPe8LTO76M7U3s62x1iradA05dl+BiOrac2tsDya9wUrPIHWeJIQokIVV0Y4QngGEHiuRGGUY2flGMJ3oLNHzcONmtakYU4GJF+KSFZWKr5yrdcxeIfNfoDB9gDpxjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764489; bh=3PNZVJ4pRBvdxYBtCDj1AnxZlf1kvhu9RO4wMi8EzPk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oD9v73ZMrBxzAHfhfcjDsXvbYOJF/L0W5zYAizNZ2ayn5XDjN7J16Oz0FG4avWk7G8tpJvsavGznGaJxDDI1DoJ2jPjSXTv3mt71x7z3edIvmFMiJYEQZ/yDlFt+Ef2lDin5mpethh0ue0fWd5gXVuQvJz/4bf78Y8eQxjWvBjQ821xx8srFboSaDZUOi2QzoP9FyRsO30Z1/E9JI6SJ3mag8RmA1AX1FJPbtKXbkUYEyyQl2YZSVmutlHbeEo6DRFB0JzijXFPSQbkYneBJsYlUofUcoRJj9nOQvmhfqHY0U+HR/BjEAFwhRal4b3aR3SGTQ23viTF4g5uSobMvvA==
X-YMail-OSG: zDzHdiUVM1mKCfG.Y7tsvXe_HXsJMA3VwdMw66dc1rKG..drp24MaCv4tXgV5r4
 MJ.vdw3MH77bjhlXp3ZVj_XMnR5ISF5nUi_pAVtP9Y6qBv32aST5_KvCs5Ivs21goerWh380zTYE
 kL0vPBbsMbOulVLurISAHoB_MqUumMtbRmh76LWBB1MCOfHqE9e9wN.6OrCIiiJy22f8Jvj26Ovp
 BzTqT350PDMFHQA_8KgGUboWe5Z3WJPYsEt1nxTEbFM.65Hjv6wBXGAIBHEO0mVwZL_1KYzS3efU
 TDUiQgMvPDprVzf_d2tw_oOG1OjVxir1GQA3LL8MOKrtAU.GYAvcTZWp3wdoq1QGwK0GNRKm10TV
 78lDyLGrHAHdMFAz3goa0yb0VUswYIG14Qp4dk5IVdGOa8Fw5dFzbIhwzpNZSluOPLEGjMVv9ha4
 hSq3AXMlyKPfZSQ2JRFgyRYtwlqR.SnmWY3u5v1bsf4tCZnChAZ0GoyDXqVOAMbK6Vi_QA91_Ab2
 6w9MsVVM9QpBNL1jMdG5TlMT.eRSyEb4Ehca8DKNOGjcMlB3luje8BdLbQ0S4iblA0f2cN0QqXhQ
 V5QlTZ2sbTXCBA38mdR2z3CBcO3ZzLD88ALQoX0gpbvcCtvDY_wn9156slrn9gldtMqOw7CqoC5W
 BWm3STMdK_VYc6ev12_3SZjILiZCes1msiDWUK.iSdw5mPH2.KBWO2ypoGzQPgkHf.fqdMJgOFJZ
 fJyiWYs9RKqc3llWoP7qe_Sy1P5YT_YTcSm_dj7LD.p4XhuAWUDgKRItyq9sz9HlFfj.7n67qhxA
 5O1DGYZM86uhtKnX8raqg1B.0zJTpTzLzLMPvV7SgTyBUsQhMIW1CR6WYO7XW_rD_f.IA5CXQr9j
 g4sT7ibXXy1Vn8iW0aM98vnNcyuhWGBsWhL55ua4QYT8AW1apST2t1H0w_MOl6GrNtQPkmyK2L75
 MslBt0LEcfxQZSqcrxv6r_PHeY0ZKK3rojT93FuFjSjAVXi64nFVrm35furIcxkzhAs4dzcxC.qH
 suS3Untu1hgRAa494WQFKM2r5UoxjqLPISLpIa5zLW3SKUjJ.1SQ0t95.3F9mFQ1WfYm8O_OBss9
 bNVwYgT6e3sPu8L_2V4_C380ivlm6qRFjA5xNTIE6gQeE40IY09yPd0ol3Hkggi87XclVvzr.RYX
 9PK8ROdz.wRRXkkf49b8sybUDb9OTetaBQWACWJal5NsP_5eOIjSlhhwaCX5aB.waD8bCrvjenUP
 tH57nsJ5uPQWornOf7eBTFsCfWRbtGWIehKs.5jLLkkzTOJNemntJMH3R01rLDJTzNq6MPDXs.aJ
 X_D7aOqUDtBIHM31ANQpYSwxoRHX2JNFJZnAO8x.w7k2tp3iHq6xDsY6IEBF7wMXjHhHAcfML4ov
 eP5ilMbTG_71w68EoPEXZCW79ZBAyhlw1Vr55SduGXOZeMQvE_oFJPj1e9B0r8aEWKakydJ65kw_
 liBA9xRbg9CvzRxDpqA4AUiiQAwnTIH5LpxIqZRulNc4C94KCLlza.OLx5bpF_9dGikkNUVoefEI
 2ZqmcxHJy50ZdOSES1xHs173PES7OX3BBpDUKQ1vi9lxvZkTL7wae57Eg1tCLeE6QM0vTVXmUEbq
 qw5ady3E5E4Zr0aWc0OYb2Ht_c4BQr.rAJ51nlyt8MqDL1mNcWcJJQRDAU6ApzntPSRsgmcICAvm
 TwSuFRlQ2RfsXiksE.s3JwJcSh8AzSvfUGqOo67RZ7OK2ggbz.9qUiips3U.6mclH5YYczbszGdM
 AmIosF5Sha8XbLdDAcLGr9AAWwyyEWH10STEFlmzh9QOiH_XcBheWWPw8_HaIAaCPOftNjUo61to
 fzo4h_XdwkmlCz_ppn6x2AMYw2Q55v4ueTkMIVpYpUAed_CfdG5Oy4PYKpJrD44YZiC9Yp1xIVOD
 clrm.JAIiyA8ydidafPgAIQvg1.DEmhRxC1VdH4525VaFtbqMvXRt_1y.tFIemlW_ce78VaVXDXa
 RVOLWVughqENQTVvi_d0Ah5W.OqX9l2sEPLTHyVoIEGVvOVkt1Y6wGPRk2I5NrGvp5dDPyCXVPsy
 jj2PRsLtJCREettZxc_lsFhwksqZ9RI3Zvx2f0p5KL3Ag7VgP5gNrmDsLLGvPOBnw7U8VezRued9
 bfY71lpEV0PYmuaI_ykoyfdb4gfOiOqNaymwg58kqChv2nD.MioAKbgBX0YKEfR6xSXxA7HlgExq
 hkY9_QfDVMaaxol5QL70AbQNEukIffOLUNtCsODIOIbU2f61sC3gp_0NUfkIwcc2ofRvYvItKP3c
 bHbymv3STUBqLlaK5VSWAs4uANci9m6TH10.pIzjEkiWrtUA-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 93efe5f9-1d18-4066-b8f1-d64997e898ee
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 16:21:29 +0000
Received: by hermes--production-bf1-697f88457-2kvct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a24bf5c187cf7073a1bd2531a9be220f;
          Tue, 17 Mar 2026 16:21:24 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] apply: report input location in binary and garbage
 patch errors
Date: Tue, 17 Mar 2026 12:21:20 -0400
Message-ID: <177376448032.71580.9145093498181847563@yahoo.com>
In-Reply-To: <xmqq5x6umobb.fsf@gitster.g>
References: <20260317002235.6121-1-jerrywang183@yahoo.com> <xmqq5x6umobb.fsf@gitster.g>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.25297 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Junio,

Yes, these follow-up patches are based on my earlier input-location
reporting change in apply.c.

I split the remaining error sites while working through them, but I
agree they are better presented as a single topic. I'll reroll them as
a small series on top of the original patch.

Thanks,
Jialong
