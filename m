Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083122B645
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801433; cv=none; b=YDSTMY+MVsYDpgsRfTj/LUttZD9Tj5JR0omw9Ah6fiRLJLJk7xmzIT9nOP5lG51J+B683+r74Qik4ccwNfCIM/dL3ElJ2rzeV8NqOWYhLjP+VluRvl3xSWRBCapzaBARdTbB7AInHoNiEh81FlcEioUo1S+wqvZmQz9eam/pe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801433; c=relaxed/simple;
	bh=NeLxt1CgtjM69LXWzOOVGQ/70aS4inMNyqrATo1sYPY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kue6/aHxa5SSWefKTrYHrWNm6TUhkdHjAL77EuTB8MdkF74kFME1z3hW4/rDe8Pwyg2JgP5FEEzoF8N/9iT/WtjoxVHonjQg2JR69XgjFXKNDXlhFsiVOzhin79cjIYM667TH7iZ0pqIUfVTEMMKRIBsVkZCp02d2I25oM4uNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DeQf3+7h; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DeQf3+7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729801429; bh=NeLxt1CgtjM69LXWzOOVGQ/70aS4inMNyqrATo1sYPY=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=DeQf3+7hyUFr8LC6SZrv+wpogYIczXKblTuZHuFTLWQaKN/hGy/wRpiqzpltX/3K6rWY9voHa5NUDLGnHI5GAC0Vvg1PT9o9+VrC97EohPU5eilW4/EWtoI7ROuz0DoL6Pi/8mwMk0qquCw/ThB1hIW8eW9oPw66rqybbhbdA8WGYnUi2HIEZDaJTOZJidOgzdptb+CLPNrd1euelKRx5Ka9kKhQocvXbYQVGBt+URVWhgW6rX8hHiIruXaN1RO6QXwyL/eSj88WsK+blOTiYiL3JGaWxGiswCoVYyY7oPnNYqI/6E6tRG9AiY6M/qM8OLVQHYMudpWw8sXhAq9fXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729801429; bh=YTSshoSeY6PH/khaf6PWHBTN1/mUoS4dVB73nsjSQv1=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=QL27Ad08SxkJhih3VRqD9Jspcx2U9LdUs2tv/wKRZQTI3ifFk00trUUqAus4ImP0pWUF6oiD4fbjvjFjpib3W8ybpMi4fYg3uJNvT3t7kv7m9/qT3ryXAR+xCs4gQRHcFmpYuIwlTybOtSr6azAaGhJBrqbyxWdQQlEDDW1qSh0TsdR8FcGDcYeQBWd3+E4Q2mzXfwV8sm1t5XnYhyawM+NZPh9MC3ZGQazU8Af9KtHq/ozzU3TFAyJIgMPuAl737cAi3YbMDi7CQ5kg5kzSrNAZm+xg5D1jaBWBXMxjLdH5GI/dXU11BJcRLQmV3PT8CuLnepqW0trw2pYUfKbBmA==
X-YMail-OSG: sldXz_sVM1m.ZF.W3Rlq9zcir0QbP43ayGxUjEwUTIIY3q10p2V5dJUvhBsl9Y6
 sRDfa.PiAFSEHCsbiC6CBxifa.uPUS2UWbAA5It24fK7EB87ykwaca4gdMM9mVhrwljJFSUUUPLM
 oj2dNUU_YFuDfeul72DbpbjB1sBaiDkZz_GtBgsbm5qYKRNjcuG019oHt5uJjboKaMQ5r8ylfyhn
 xNgKojggJUaLgRStT7cE1AIIDAe8akhP.ljszsYWE37zBWZGDeHbSbcNxw05sWGcfvUCx1PiRUWw
 t5vpZYz5J3DnlCxDcGKT8rkHUjzP_tcQwLwouv4g86fXfguK8vEa.s.CJvjf29ovnuTKtgy3cdc5
 HswWKLapK_19KA.1CGGhu_ZmeSa38YWgdSqbGUohH0MdfZS4NQovMCwutRp_ly3FI79hKbTmNTnW
 EfOF.emqPqGo.EdjG2Sq6OMVIcgzwxymXdEX1bXEg45ZhS5DaqpMv0DY_mf4cp98coTz9Ui5B9Hj
 uy5R6HY2YABrkjuz3Ag8p4HoNdA5Sh1OJ4ccHQHjLRBgC26XBKRNXdN12SqDtMRyT5ntxMjRwyAl
 L0RPQq.ZjjAmnZfofXQBcDowrQLMr24ElHO1_hq1Qr2wajksGPxnIf6m1cGvZQFXQ1KmV9yfwBZp
 F5Cppv0sHQIahm1BtZOTIoNDrUA1vDud8voqzC945mIZtxd_AWCxXmNTzOxoYhYP6RIBKOGi809N
 g16Gpb3xAni85akDsGBExv9QnfyejOABSY58Yy5Sdr_MKS.DbATHXK5ErlB8Ns.ukO6bLClOtRHG
 cR4i7PUTqi4nPXY7b4vCpuna95LAh6Rsgh4QpFwPyCn6yv3s8ZTk6AzJo0QIGydgy1ShetRra8gh
 XykIlK66L3R.i5xEVNcTNabkc7Uizuk5PvuCAd519WSlfqXXNcr.enlK.Q8enbAZxHhJNVxseG7F
 Xhl0BZtvUybTFm_qgltujhpDrOtUb08xMSctPl22xtCa6_q7SJt.J9fHFpgyGCCdMBHNSsTob9RG
 UiFQtCJdrvXcTLbMthftGloqK_1Vb9M8VhBQMGT6qxnjZSQ1SkaeXG66pcd3duoM_ho9j2jGGUTk
 4e8.qHo35jWAQCfyuqbfbvmZlCbxdzjc0kTMeon2BowB899GK4mD5VxAPmmGakFKweuqVSy0OSSp
 c_fvEMuQX4NKKAw6TqHhDfY0Fe9ex.aCOuRzcSOUynfh3IQ8ba3oeCNgNp466sCMd0faC45GYyS2
 Xg4WgKA9IdP75cB3cqLPKmI3qCCAXFi.uIzEkwI5WFFmmnC_Mv.ktlR.YrsLcMmL.v3s6UE0jjR5
 qeuoNXgTGmdXwCIu.QxQc5y_JucSSObAyATtQE.ZHpmJbY_z2w19Uf9hIYxjOzgR9O_2zKpykSvo
 pcdswyUsTUtTU3jcgrOLKXuVvM.22gJCbeKvYqdcahnqN8NejLehp6JmnlW6TaH8y5MyGbtnayd2
 FTpeJw84y9BbrvcimgC7lMuMNACp.KLzBl57I0aGE_AOHDZCRfV8CdfsIJfsHrFQPdZpQMHMcQvX
 sfSckXCKH6k_8ypoeAA.dX8emUDvsankGg83hWqATBhPE_SoQ0fLzrD0A3DAPQgmTOu5gpQvzOFF
 rE86qNtscUIBKWtUNrjGjeg7cEyjAGSz5J1TuVCMF2OXfBTukS3hPH0yUzb5UMPzvnmB2j87v..m
 TtNp5vNNDS8683X64eDOCBlvBJsHvHvgioX3LhEtQPAFAPTKMyAw9UVAs._hE9hVfmM9aZFwZ5ML
 r6cs1KOiwq3hS8FFIX23rwO1fdFPTGJHkoHr4GiWVlVCstdGUpYTzZcGRdSdISN499vGVPKV2G8H
 HxMegfNss9utm5OTlv4zvoCvayzIlKie9MXfQ8DtgR7NfB0NS0K.JMo.p6VmmwXtBpsYTUqnhvIN
 h_SQ85PJGfDAs9V.aEXJCLAdTs6wksgNC_PvN0hZos3BSXSbZyqMFsygOvUA98Cy90VXBuJDOCSm
 grOSZZb5ELGcUC4tA.iLWlNommSG8WWa9YixowjX7iF67hRQf.G37O_DQbR80s7csvAGvCoq3p46
 DagrrVDGkggv1sgIn7w0W7yFLt1d.w2QBgJ2cvb3NaZdVreOU83deruQqU05My2ryDUiouJi2q57
 k1zDO27JvZar6PmYviSg34jxQ2bbpxL5tDlfyOstG_ugVlZdLJsKCVXFYUJFcprUoocdBMhLQi3e
 EawPwqO6o_tgvhXDCLHDgnyTUyS8-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 9cd580f5-d990-400f-8739-d8ea3b80c477
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2024 20:23:49 +0000
Date: Thu, 24 Oct 2024 20:03:31 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <901612009.3278712.1729800211571@mail.yahoo.com>
In-Reply-To: <D543UAO2CPHI.RQIN1V1IC85A@cepl.eu>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu> <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu> <1101848017.3146876.1729770380522@mail.yahoo.com> <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu> <D543UAO2CPHI.RQIN1V1IC85A@cepl.eu>
Subject: Re: RESOLVED [Was: Re: bash prompt evaporates in subdirectories]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22806 YMailNorrin

 On Thursday, October 24, 2024 at 05:19:46 PM GMT+3, avih <avihpit@yahoo.co=
m> wrote:

> So I'm guessing things go wrong somewhere between __osc_prompt
> and __git_ps1 invocation, but I can't tell where.


On Thursday, October 24, 2024 at 05:27:02 PM GMT+3, Mat=C4=9Bj Cepl <mcepl@=
cepl.eu> wrote:

> It was a bug in one of my scripts, https://github.com/openSUSE/osc/pull/1=
632/commits/294001c46ea2


Good catch. That's literally an issue in the one line which exists
between __osc_prompt and the __git_ps1 invocation !

Do let us know if you encounter an actual issue in the future.

avih
