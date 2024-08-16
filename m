Received: from sonic322-28.consmr.mail.bf2.yahoo.com (sonic322-28.consmr.mail.bf2.yahoo.com [74.6.132.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E036C
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802290; cv=none; b=rtKxPDRVugRdpK13c4mv0fNidrMncj8izj/HAt49bXzzeYB/vR4x5rsy37lb2C4CLsPKwM2g+1Wq1vI8szdzEdmmUqyDPAuRBJPROUIVJB4l1WXV/lBkUK2Djwjuz50Im00w8pAWnlmTMojqA+PC8NlVMZ46pTdchiN3Bj2CaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802290; c=relaxed/simple;
	bh=ClpzK+VjrllUtCdM4fXseTO6byqMS2wvbMfdjZsFz74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MKoAxYj3UhbiWKTgXUSgO/eX/U6kQCNieVckX79zOYAorYSBHm38Sg1BYMrvb+xDI03abl2AjCnJeSOEaT8RPFqMLklRZDAVnHivKYn1iXpqwjbIZDHslCMhMtL89RcG849YSjYp4uiTOLXYddTlhKtIK7kXFSCmGLR/TT3KUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fNBp1LtO; arc=none smtp.client-ip=74.6.132.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fNBp1LtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723802287; bh=ClpzK+VjrllUtCdM4fXseTO6byqMS2wvbMfdjZsFz74=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=fNBp1LtOhvUmk2qD2PHQZXa/053u8AnRxYo0fC0LmMcWHWIlIlMF/6hod+HRJF6KX5GwFca1r0QjFJBcwGV38nioCJxj3HcaQM9WZSW0/FHpT5gZclcwslfD8J2JV7EYzhVZOAaI3FZqKkv8Vt+opM+SaKDVM8L6yjQx/XfgzH76LhepGx0HHSmMhlCpHDosTzqMU/h6knwt0HC9iHGL/UhXgFk1w9fRgpcVQVmq8f+Pg9GxXlVJI4d1C8QHmt6z8g5mt9bdJ+EXfoR2R/WBiMdJXx1Fa9jHGTO0H0K5XDc6QiApw8KYZSncbN1ilvYlIBYFIY2ecXAD3ST49bZESQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723802287; bh=AFSXyvDH2vOq8lSIRJzry80KomLFJzZnytgjfWyVKXF=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ZwK3KgjDHc+EN7xd1cdPjJhfn+FJ8n5v9NpcaGiw3FCDKpPHVzCuZbQILkZW3KtBrjCRd6kgv6KNMW/6dUcSV6l5KlA0D64gOcoscdmjwe8oKW2g0Teo6TctNKCVnRcSARV/ilSaxENzcBzUXe5IPrFAaIgiMfsS2coXxCrZg3VfONVWt79rOAuG6D1f56lyNXkaSSCWVZI9zSmD+Xdz5+lQVX1uddiWE1T+D7alUdWXvjuV7IpZobLpHwbYArf5Jn8kqWATlM9l3Pl9iW1isQNgDeviadOE1iWPJbU4Qb/UhoaA63hg1FfyT7R6W71DdZpOF/O86F81z4W6Dv14OQ==
X-YMail-OSG: 4Ws1G2cVM1l67socgmk8Oemj5ovlDjj_srUB3qcd4zspzADtY4XgaScbINj6_cJ
 1yE69qbIpMP8iMYWzOQVw_c1.z0kVwoCdAcpqLxKHT0pt2KoKWbY.K91vx.YBn6otud64W8Fto7N
 d3EP3DM7mjTPiq4gxdro6udAuO3EGTeFA9fT2XmXWBfHL.j3EWOE3WRokTvStzCmK1mpwuBYt.vt
 XrsmD4zvzGnB_P2NZBmYteZVrq9qdXqyM92oRLzN43nIlpXzudp0mum2eJSsEN62.en63NgkA7dA
 HxEGyfHxGOUdU.5HAY9eDTPii9G64O1VfI4m3QO4vTUdJrQoukjASPwQgq65Hl4exKiuuAePEGvg
 PvEfdzOHdd.gvvJsIS9wY_DS0LcqZ.G9eGxAonF2sX5mJS9GXvghnYpMCOVsPMJGwllAzHkfnGzt
 I8bc83ozndH7CfTK9O4iX2fuQEwh88z2.JBdxgadxYpVNVLjte3r1QcuHd8XQcXVd4MGgNauli2l
 qbLGltXyApoKCNjl..o2EX5rRS20mNtSS81mzD1oa7cD1jDiq4G9TGYmDPO455LlNeySe2.KfsEu
 JuG5V_C7yEfyxbiXGbpejUm1RBfbhprpHdb986NMDfIjUJUxbfK52LPiRQR2GEpp1Z3ee4Gttt30
 BWHlXQA4.D5MAYpYO4zwJkgVhx5ikOQuTA2TH2ewXQ2R2K2p1FvezsP7niEBaefblx4k6upgQuLv
 KL9G_AcKQs24sazC7ihUZzqO_gBcJ5qgWAJ4zkFBFHMQzMJXRR1.ajGnvKSz3VDL8veqBBSDCMtg
 ZnkzXgs.w0eZ1aaFuOWi_yWSCHBWhxo70qHvMkJClCSpiwaixFwDVVcFdVlZBblnTwg8Q4sjL9lz
 uR0iaEubbU7t56DD7tG0peCObud5nSO7gwLHgKUnOOgA8zNxbVr9LONbihkc3rcnFb5UyxE887zH
 lo1.tbgYkZHcvq4J7Kj793wNJTCMYgQo4I4McE5JLL030lx_qu0.c7Qo.xyXfVM9aUkobgSjU0t6
 NLXgbrzQj2k7owvAwXYdEyav7yROjjFW2rEVsq_cekdo.0FdzYkw9qJ3wLTjKEqIObieO9NrOhkb
 ID2S5namV4VJCTULu8YGxGWdbL8VoYuKWC9UYB9BqhaPpqc.h6iSJy7fG8rMrH1WeHrQXYsjeIrb
 U9SQwfIXPB7KPVVrPqp2jY4Nxhc946iR0c19bN704ptEjcqrweYhamXRYnbcwc7O8pEYh8NuicO_
 JPjm73BC4DFoAvfmOpBczePoF67S5h_KH_vhukq2zXoqUtm0_7UzcqywQrafqd7q4IXDREDdmPj8
 flmLcg_HEwREw4ekbPf19M2MYPmMbsKGkSh3_9vcu18y4ojm_NDuH7.o5HfRrj6tr.xcyWG5wCMn
 WJ83zZXLHsGgydMVoJqvlRG8VbF1Sz8oyOk8xS9uniUCauYJP5fCWnFemC6ENY2vthBYLEr6aLjF
 bWwy.TnSMpB5pSepgyEFwCYOn96uHvNskoSa4AIQETyqIXOFx6OGgtrKyY1nxeedB9ZxguWc7MzL
 cCZSbK8J_uXhLouSh_1MK50O4CufFW0SD39FxMSUVdB5saZsC1uPAyCcM3QebDRTQV_XFIRBk5HN
 hFow8Tww68jvk5vVIsAaIWwCRqnzV19xQ9SfJXcpE46VPJorC2IIPuTVG3ECaHa4gn42vj7aEhs9
 rftdkuIeaz7DRAwQn65Q3HEtZEyUdBaeDFkwfV12aMbgC3VB5j897vdJJmryBLK77iu221b60sDs
 DrKMMW3x2IIUuXXL54N6tzXaGg3QvzDFj3sWpAa6IsuqZ8ldEPBKtbhqrMuDoMOm447xhPMA.qeJ
 0wY6sd26RyyxGtWXQFegCDNIkd9dnRIPFvhqtpXkHwS0TlOjaBWLbV8IyQu_WqAuBg4w.UG_miiP
 rOKB29TRcT72lPULqmhDRRTnB5uP2sgdVtCmLkWfV2Dm.ztijDCR8340jL3g0P6Kzl5uDF5Dg02_
 KbFmSBE0upUTgxSTJGJLuCl39d.opW0FsRs2PWiuEF9uou9C31fhU_Fkd0YfXqDVU32jb8VNB6sz
 uOo0GlkuPqASgpTSYQksuLGG8R3gQNShdQGNz2F82Br17kj1EYw23YMYUHmcZgy15uaG7Ygd63Dc
 9gwkXzrhsXPbdGiPMj.xQoMpLCV.dfNzHKupxsJZYapuIrYITuWl0OvyyM9EAohTIhMf7eHj7GDH
 nuJ4cKCXeK2OzRAjpIloFrN5OZ6c4KUzrsEY-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 9a1e5df1-da8e-44a2-b378-e4827109a51a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Fri, 16 Aug 2024 09:58:07 +0000
Date: Fri, 16 Aug 2024 09:37:15 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <1407516636.4490130.1723801035574@mail.yahoo.com>
In-Reply-To: <Zr8Sv9xZrdf6rHgg@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <9ce5ddadf0bb13229461d67451094a373348771e.1723727653.git.gitgitgadget@gmail.com> <Zr8Sv9xZrdf6rHgg@tanuki>
Subject: Re: [PATCH v2 1/8] git-prompt: use here-doc instead of here-string
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Friday, August 16, 2024 at 11:50:12 AM GMT+3, Patrick Steinhardt <ps@pk=
s.im> wrote:
> On Thu, Aug 15, 2024 at 01:14:06PM +0000, Avi Halachmi (:avih) via GitGit=
Gadget wrote:
>> -=C2=A0=C2=A0=C2=A0 done <<< "$output"
>> +=C2=A0=C2=A0=C2=A0 done <<-OUTPUT
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $output
>> +=C2=A0=C2=A0=C2=A0 OUTPUT
>
> I was a bit sceptical at first whether this produces the correct output,
> because I wasn't sure whether the first line might be indented while the
> others wouldn't be. And that would only happen if we indented with
> spaces, but when indenting with a tab it seems to work as expected.

That's what the "-" does in "<<-". It strips leading input tab chars
at the content and the last line, and was specified as such since the
first POSIX release in 1994:

=C2=A0 If the redirection symbol is <<=E2=88=92, all leading tab characters=
 will
=C2=A0 be stripped from input lines and the line containing the trailing
=C2=A0 delimiter.
