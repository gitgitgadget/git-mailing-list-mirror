Received: from sonic314-14.consmr.mail.bf2.yahoo.com (sonic314-14.consmr.mail.bf2.yahoo.com [74.6.132.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58933B966
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775537; cv=none; b=PUMv4Eyw5kRw9wOYi/0Z2yQwqRc1HS5mGHJnttkXXRE4rg1qEwLySpfTkPSQgdby9DWA7oHBi/q2b90TECPLD1PgIfg73Po7p7USUZOEIjuPNlw7l1jumSpokbOXt+CRjthlOzcuAi7EvgaNy3SoeaTPO4t7v0mBXDNiJSSnXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775537; c=relaxed/simple;
	bh=q2cSVPKt3XFDRIfoMqKIm3dEVDyRWpXyvrv3fcUMCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MH801HQ6xayVSQWU6ibDEj2ngkJYxEsxZdVpMlUcBInJLX1ZaRSqqHYZQqCiwsX4IG6f/eh70xZf20cMYop8tF5Dmo1Ek2rwiju5PS2efSJI1+n536zMeVKyz2XpLba9b1TG0tGsvhBYchN46kkAryKfFo4RkUhx0tFDX615lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Fzpxi2Dn; arc=none smtp.client-ip=74.6.132.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Fzpxi2Dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773775534; bh=q2cSVPKt3XFDRIfoMqKIm3dEVDyRWpXyvrv3fcUMCjA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Fzpxi2DncjmtUne7RVx3fmQoBMhBGibLo/yQ9uWNugXG0Eq6IQjg4t/f/HibPHqrUPEI4Thk07X7yIXx5MDbcUInCwq5fOaS+VPe5nAvAi85fwgINjAUxJD5c+hHGkJU0ZiG+sXPv3iBVraLEAAyuT7L6H/YJ8AtvAGwY8+8m/PV01bpkH0QauO4/MGtV8RqWHaNJGR6puYxKGVWxcbRly8SF5N5VIecGkjoC7zEgf3srhXfAMl6B4dXI7Qs4dsIV3phYaFGvX9ruU5LJrR+ijTvoqSGSOaJxYst+7RrCDbJU+W7iA4vCGyf2LrI0FsPqv+JTElBU2KIdm/ISeNU0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773775534; bh=UYKiD+EkUG+qNBeqMAyT6KHsF/hH7bQdxQPE9dXi7xP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gbkKLyXpzaOCf9MJ4CeD8cIk4m/nk/L1J1jGxENDF00sekUf5o14oZ+mGocdAqS0qwrp5gnj2qarayySLh4DgIxpS86o5IFa8MFuRB4kxnc78dTd3g2dWDZIpPcIT/zusPYhIJyLsHthd74EyimuzUdALXxsUGNO5hcPGf4rjIztKA1t+9BuF4SjLt8FEifF1OVlaEUL1wEx6eIOoJRISqlCgS8+DBm8folwmnqgXWQyacifUyYIhasJzxi0wPFHa27+eDE1/98Q1TFKtWZVONRpBVFfo49GfAXPbH45JRz1CfNvDvOZ5B4XUQHTQNQy6YzNpukEVwN3a4e7d215WA==
X-YMail-OSG: W5J9wjAVM1niHjwKc5Up6Ixd3_bExnlcPurpnpaxq40_X62y9n6Z5mduVcR6USq
 WxIkJhsValxoAdg.eU9SF.HOeJYB7pbfTv63HZSvYhIOiCa6fSYzmgjYx1hQvj1I4l4o2f3PiSdf
 H.cqshuRHBohPViZx8ee.a2vxruNWEwvqJHl4h8lXmEcHBwxE5ReiKahhCUhOtG4bLnNKneeE8MH
 3fvvCXLBbkehB3YasPMHwVJRgJb_oznLIIG.Xo_Il_RcfjVU3EAVJvpLPAvgYG3HG15_QpYRYNqP
 5aF1B0tNROBZZXq6t0pvnfBYFU8zRr6OvGtZ4WHstSQdIv0zdHsTS_26opAmAMlr.jfPU1OvCbXN
 8bQPrs_83WexB5X_LQUDFqiqDLhie1IVqfH8hD01QATj25VyQ5_wmcxVq59BzaTrdzpMunY3GdsW
 xsTlVWNoM8awb_nV.2iNz4DZDLv4HWZSsaZYwO8WJ7oRe_nMameoh4c8kA9WvLD9YjoDM.ks3.Bd
 S8ctOdQCBQ8aSPxFuHjKZlfM3Pr6pjQ85kWLUbCFG5wL20H79vDb2i_Qc_DY6PWrtk2hCffnSkzg
 SiXmA4oM7SWcNsr3g2KtlYZBqOi5EmLmGfoKovSDMtv6Z9pqkZcflg2B1Rmtd3dUf47tySSxrfRs
 BCTH8zAQv7yOnjds0kjOI4vPrPEWA0ZdU6KCmx1CaYe5Tp3P6v88N9rN4kYGRdE5uFR6UCiTlaQF
 zYnJlogYb2DqC5DuHUB2EXpu7sM4DQT9wpjx0hN1gN9vjaA2vZbtg3NX8dmjeNDY7St2UCYdLSf9
 tXRvfdzixjM6jf1LTznpimBsP.F1AkjiZ65Wnsfv_JWJFLpJDYXDGtmZLB_gbCddQ2mF2GW89k89
 3VZyrpPEqe.QVEzw3YaTENoo5wbHz2wC_1c1_6bQ2imqPZqROxG24GFAIjRkp8kfKEY7I8DTdeoW
 V.Krz6jIkg1ChEK9a5V8NwGAPx2hDBG2v_xYXT37ygeE.Nl65sqZVR69lQUN4QZeqvsHYCMB97K2
 5BLFfCqNuOvZ1DBiqGogHi0MfkjImSSoX5vwDKBQku1ae2llVwOlAqAVoT3_hSX_UUDs4q1EYOOH
 2TgDeIIuQvOTsAGoc7BrLLL_E5lpQ3ZtPKtkuPmAChbYAyCnKQfJujjEKuA7VuLt7sqzIek7iCNi
 wnqVoyCvSn_iRM1sCpmKp.qcWORX1ZMZm3yur2IJpf.e2ICJfOKwSs2YGD07Gj_p7lSiGv7WetE_
 NilCIdBXwLyKCMTO.UZmQEoroVwCF62w_dVsEXebP82SjGiffRSRDhzh_yZQWrvAxhsCOKAl3ptI
 wVtN_4aeCBZGgb48WggrrGCl4dQJ3WRLTLmdbXmvw3Xh_gGJBsu6E5CAj1W6kkY0mwrFiFoY2flv
 R7LWvuLREpKA_oWXnPDLKafIRIy.bvmfsWhKUpMjGjG1mfUWOBkMgW.mQaYYDSTAXlIsBxe4FF0n
 c2rstNRPiAOYppdMly8_bDg3XSk3c4HNeIPZMz0SpnmHfHKp9ELyvuVmvMd6tWncjP8pt32_m.mQ
 cJhPiLU0VCGQEPEkTGtv.Mv5r3kOD8.knHiVAoFNygvrHfTUYsEdpnO3YTm_s7ZbieGt4I7u8LCw
 Sfz02qMtnDuTlbK9yYBy.qP7MxUzEYGYTJ5UhE57g.cA2ChGaufTPB4VeNxOqlWjb2hCaDFhbfRX
 nY6_lb_FBySeMEW_.BL4FKn73MR5K6IFh7lDu_cnVyxiSLEw1KiqMVADQJDiTJuX_wtkDdz8euU0
 sBpUxPMZ6S9GWSIXQzmKcObvH_hvtwftRlOhCPxl1kRPWBQApnktp.fsZbuXFIW42pi0vUlud_B7
 lh8gs75tlw0oHJQdxE0ZyCZUJPQOIhu9YyRCx5B2uvXLpJRX2aOOPHf_zBdW4U6w7yLYGx4qh2Tk
 VgLnLiHQ0a.pO1CD0ktU_mYzNr19tR9Xv0Mh03eaFPUpdvvqDJFXDSRHVa95pddUcPxIdX5dsJfh
 aemHgQMmQGaUkrbtJHLBkjgRfdlclD9tNJJS1cDCwEgnI.dHn8zXmAaKHOdjBeGMST5uq.v2equN
 HPrn_j5M2MvwZsPowYdq7JxRJPWFwDJ.YluxC1DaCsgtxWw6W8WI7swvzpjVebB_YaR7V0AxUYno
 y.iTaRatbQXhKpc6p6k_pRIw.ldUXCiLA36vONtgqhR5MxSVH4tz4XQxLyPQtmRbAwAtDXZ5vN7v
 G_rfEOC3dj8D5.FUaHSygUKLlvvV9k1mgXB4MeLIOfeSwzanyR.qzbF4mpnezvhwGpmoDBjqUu8I
 MxBB.XKk.QKNn.fbbC8WXEL4PZNcMoypMV590MbUFqak-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 0849311f-e0cb-4c10-a126-3035278fa204
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 19:25:34 +0000
Received: by hermes--production-bf1-697f88457-skc68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee9fc0a3694e886fe10a053fb06430a0;
          Tue, 17 Mar 2026 19:25:29 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t2203: avoid suppressing git status exit code
Date: Tue, 17 Mar 2026 15:25:25 -0400
Message-ID: <177377552540.75212.11758229294443511273@yahoo.com>
In-Reply-To: <xmqqmse3fsvw.fsf@gitster.g>
References: <20260317185414.65952-1-jerrywang183@yahoo.com> <xmqqmse3fsvw.fsf@gitster.g>
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

Thanks, that was my mistake.

I resent it with the GSoC subject prefix, but I should have treated it
as a new version of the earlier patch, sent as [GSoC PATCH v2] in
reply to the original thread, with a short note about what changed.

I'll do that for future rerolls.

Thanks,
Jialong
