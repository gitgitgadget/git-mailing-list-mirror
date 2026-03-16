Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEA3E0220
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685901; cv=none; b=eEnKRKRYX3d7wBRYxOHeQZ0nUgWF2DRfIfG5IFI486+u8So1EXaKXDwbddpoktF8EtMP05B3LUCxk93bC3wlhaVQ14EejDTMZ25oxcCkslOJ7GNIX1gRKX5PerDlVsSEuSIOLuEKEaVA485KoFqTZs+4in0LP8MnzeLb+CsO2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685901; c=relaxed/simple;
	bh=FSGdELpSfzlEDmUTYEN3GMkr1FW7mD5TrgTyDi3xRZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=XbMeSdXDqRW3wt1copiOFKNTe4beLLiA6inLrnT34djyn/O06FCyJa/+k0lVvm7wiUbX2Zs6kiv0QmBnakJ8DRqdVI5C0otPStN4JbroXzqF+RKLHbQSqwIjgKthhoTsKDCa33pApfPI8rXAVV93AmhulnZRGzobDhzetfSbG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hMj5iv71; arc=none smtp.client-ip=74.6.134.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hMj5iv71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773685895; bh=FSGdELpSfzlEDmUTYEN3GMkr1FW7mD5TrgTyDi3xRZE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hMj5iv711fifNczXuKq1O+Qii2qfUxIJgDe8+2VFiWLZ6t1gBnAI8iP644yTAXJ1UXHIxVlsUZWU77NxMwBctCGl/Na+/6cRcx9xCLc0BJs33j+Zs3wJeBcd6uNMwBcCi+zBCToyD199r9uMzax/M3phj7zc/7lbz0Lcz6tM6p+0HpeEX3vu7PxJ7kR0hkZhbROw1oM0UUMvgvjE5rIg9I2uV00w83BB1RQAQavNtRF+uhgjNMp6+gX3OR1Gzn/EzbQCYALEpSof0HRbXarndEyZqPza7l8KhN8OwdwFWV1bwEt/sG+rHYU7ggj+CW3iDwhe5KsaWHyuzhmRS4gH7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773685895; bh=h5ZJaoN4Sm5227dZWDNhX75YR+xSPBArYO9Xk7q9tDH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hYnHM6UQv5Vw/dIK/NtLyCNx89NsoTY6O5CmR6WqeDPcjJGLL3iMEl9J8Ct/1Tenrjx51uaE5h1ANKCnwUFAMiIY1vP0qpMFo9K59zFy/hVJjvzIHle3p2QBTf50XzB3iMDZuTqAflxnDhuzs6Jnq4/U9g0eUtEsUZkqHuY5FwZYicQTu0NIYBDy6XAVm9wYPC/qcZwcdinLGnCoVlKfRJ/nAx6fxQpWzduucRcBmcMao7BkUX81B9/ARXoJW1f6Ra7gZW03JCjJCqZT/brfo3lfpjjurA8StvWXDI/LOANGV+6HhTibK8bmSiMfPzI5VQnjYpdXr0cYyRzvasP0tQ==
X-YMail-OSG: uo9IztUVM1ltoUVc3gHAbtZtbxsXKufNb2O4yolyjJs6f8p3u2qf8AsFBxpcHzL
 ur.3UrkEhE_W6AiaI2pkMoIhBdyzqjQ_0hxZwlOCizgE4KbwhtgQCy.1eh8gtMb2HZTEVPfdOvkb
 cUE9nKhl0pw0jrZetMqQHPstL1F3I5AiPHkRJNRF32ClFfrCnsU7nRonTqE0uU293xt8K5FY49aU
 vsfCoUZSuQlPWSV2xV_lI9bY4_9zS45V7tLR75qSy_8n_DgaMVPAHCrBiaq0pLwCWdf.fxV7vUbw
 jGsCtEuBz1Hv9D7ZvRy6ryDiI_5ufo2TAgdx.P0egYTNr7.pbrmwY7tHWVi7oq.uw1EMj5yJxVeG
 hySqJYYZnkiBmwAjP8nXIcjneXXm.UMCP8egNRzwvP6KEKvfNtKMGbkMVqwOoC8q77ALyLKXs1GT
 JOfBgOBLNulk0owkwatWSasMWZUp6K5HkwxSXuqlCR44qOx1DuH4Q74oRWayOgygtPtYKDePywcF
 lyaYo8681Pwr_HDRvOtOgQvC5tGiNUbCwnb1Iwp3BlvtywO5EJy2Lk.GfNyJpJN4bE6VepKYxQN8
 KK_HmND0Hxb3.6xbJyOBudKnEVmiwILXwcsj_xUDQto6zipT3xgoi.G0hEdSCBjWZ1T59ozxyWEu
 ziN32bPHsvSYdRi8kZ6HTviBJWn61MHUf.oJGNLcCVj9XXk.8v3BbxhhKWgt2Px9FkF.ynycts0G
 BD9inqL.dwNOPCwHq38BY9TLINe5DQ8Cl6Q8djjJso10h87KcNG_O.TWX2hWExaR9pWRjt89x9PD
 EqIGIDkVHsxFyVD_vQfnjwpHS1OVQzmTvlYtSygWiZ20EMvV1KARUkboAa.wkJuft4AFR07_lUQk
 oBLDrneR00RTuxQ3qQBfPJFlhKujSpBaRSXzky8rtnMtrzIivsKgOzkW9W03_dlrWpyC3G3mKX7j
 VVFe8OJVUnbyM6UD6VcXMdrTD__Wtd0oCqVhALvYhZvdS_dByYkb22U.XmwsC8_JahXjQhBzwr6W
 B296kdBeAI4mPgr0rR5x3Myxnuyx3tDEfgRPVh.gPY3XKE5ue.5O3RiKDw.TE1.64hdRMXMvU0MT
 a96KvO_daz_SIT671qUCcZjj.RrtFe.g4K9NqQcKDYhEUgZpBgjwgF79WyhuKY.i8wcsdB_Wk78Q
 M9cLRUg5ugrU4v_j5U80b9ZMD.cDERq_sNKzXEUpWEU0fSh3oge_XCQwCFBPJAHPIaPzHh1Q1P3T
 5ELtdlqOsXnyE.jEsLCL2WcDqDG2REY0mFqBgB83jvbULjSo2ClF53Nx_Jbnv.TaJ4p71.C1GyVJ
 0JSoHN9nimDjxWeT2tQZOIvP1KpLfsUC2_ouoqvqjiqxCwR.eZdPplgjOhb.N9fIRlZ.JDrZ5_8b
 aCMJU30HYhw0eMYvp8B9_BgRXnxl.AmYtTEqUYbRYBLbliKI9f5f7adkUAV4fXwaetsBcLNvJv15
 MrRt7lw2JbE0TfSDjBmM3vLEgFS5lUuyMX3q0BdSQs.zlHp0mcpCJ5_nA1.puouORQDCgIcGa9Ak
 nsNHSj_3pVjMJe2pwsiiX.UsLYod14f4FqYxrPhzAHuTTIjphGuV1Y4ArdJSpPkUCsRauk_E9sh7
 W..88hMFtBOJlMOyzJdlnSdRuH2j8P8wKo7vDqfxLHd0M1JTNQkd1qkDdPAcCSZqLqGj3MIqDAML
 R8ZZbAlRFLEuPYUH4Hi9NIqJd7_uHbjrUFeIXxyIMBE4DlI7ODETTsIzVL9CYdbIbj8ceQpLwqr0
 U3_k3lk3Nk0XsHpPzd04_VnQ9dyVTpMsRZ4in2n_VGEYeOeTc_X0NVHuuZILZwZ_mGKHPtBg4xPy
 GPQC347Fg64jvmFJKIsj8j60DbbCDHoZTiRcVtVFs8.betp4LffNgkGg5qBEEqi.R48gpC2uogGz
 9euz3WMJZc.Le41zfa5ApuHz0N3TZDKPPetRD56xBKDcQXpYzru.pWfQN1.ZLMLnpgh3il082hxJ
 0l5mRQPPk6HYBsnHm.2nOXcbXtZxAyrROxWSWCxjsWZZgjLJzdUwEcA8ql4gUQGHo9oYhuouhhLx
 CiF_PiNUAq6EjPn3vAzMEgelHYy4HaUMCG9J1Nn8evc5y.ouOFWMsG2wkGF86vCRqzp_9IdMSJYZ
 2z3lHIhDiJPsrA2kYAGLLgPEM1tA3T3emIByeDjb6f4shnSFgsijJjuRHUPdSsWbLlNina9khGPR
 tXdAx5vTvkAn0oAbAPu4DIu5QL2xPobU._8kx23TddOHRgIoj1bAv_D9WEsFMX7uIFABgpWcJ6Mz
 2D8NBeKawvjabcGpYB9Zh5RTew2HBWROM_NSk337_8.9bEj3hZ5balL_.cohyosOb9ECNiebVSBM
 ckrTU4voFR_n_IDHsXqi7P12fIgPt
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: a01ee121-56a4-4f1e-a70f-ed0ad8c2a50e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 18:31:35 +0000
Received: by hermes--production-bf1-697f88457-lpg96 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4104e80941d36c33a77a06fd9d7cd50b;
          Mon, 16 Mar 2026 18:31:34 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com, jerrywang183@yahoo.com
Subject: Re: [GSoC PATCH v2] apply: report the location of corrupt patches
Date: Mon, 16 Mar 2026 14:31:33 -0400
In-Reply-To: <xmqq8qq6y4ql.fsf@gitster.g>
References: <20260315231538.68586-1-jerrywang183@yahoo.com> <xmqq8qq6y4ql.fsf@gitster.g>
Message-ID: <177368589341.86550.13587211475575359717.git-reply-v2-queue@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.25297 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks for the review.

I sent a v3 after CI exposed two existing tests that still expected the
old error format; v3 only updates those tests and does not change the
main logic further.

The other line-number-only error sites you pointed out, such as
find_header() and parse_git_diff_header(), make sense to address in a
follow-up patch.

Thanks,
Jialong
