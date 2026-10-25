Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946829;
	b=vkvJ2YpUlxppvJ/PfKgAhMRmhA5lkCtLOHwVPNhZGOKlniEGi/kVunu6vyEIIDsPWpRB
	 VqtVgYREGjbhavGuryrV22CNKjUXRhRnuRGoMuszx0tY65BT7p1XpoLE6Y3rdpOTqh63f
	 Hut0x8ut2Pvx5XBefwnxl/n/opIBTdIC8yJ8El+3H0Eq32rlzWyRjVzLf3RvWdIkBLemT
	 vEm/dp4SMCO63kcFW1h0oDgGdvB9qr4YH+Tb8gePbtMJBzwTbvz4+eDEmXjF/imFqrTwm
	 WC1rCfjLzFZFkv25EP2KFPc2sJELvF3b0Xnptg/GUipX/TT+mtt9zuNZENq0KFvwTfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946829;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=djT2j0O16usFjd8MoVmUaxAaGcsoSb5ZXRjJliVp9YM=;
	b=UKBXR58FgB8VgOU1yfOppkjNMT4hTyciYNBEfmrfROrx4u5Gcoxrn25kKEnyRLMIJeDj
	 ZKe2waeZTyczuw0BqNsrbjEfQbTwC3iZJ+xeoIXyY/VlHPFUnQex2MzA3XCusTiXPcl1J
	 M4tzayZXe0bjm8kbMl8bbxiBRSMMdcOZ56Si5NISRs++tm4v9qVB6AUCzHWI3LBuFMgKV
	 NoxJTFuPlyIvSLSfd+opQKtwgyxl2aOtNuaCUKSqiXHg3k0WPYfG3I7cgucfmIrgafveh
	 G/O6J/YkEUv5Qmmy5QRk7NC9BfpxQRB2hGoySGY+PBbjph7Nk2UGTF2WjSzi+/qoTcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E35606A327
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 16:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E35606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38D8514000E1
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 12:47:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 25 Oct 2026 12:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792946825;
	 x=1793033225; bh=djT2j0O16usFjd8MoVmUaxAaGcsoSb5ZXRjJliVp9YM=; b=
	i7h1qNf4iu09x0HyfoilihLsrrHASIF54FSlwY/pIDlXL7F+5ZfTU46ifh8dJts+
	FlrQM5+6BGJXKd2Vb6SXCCGtt8ZdbFwr0085+XiO0DWEDTg0YMaO0lTuYOC8Yrzw
	AFe/Fxu0XIjsOeK8OVZTjCXsfwPmtYho5xHR02VygBctnG5pAqfoRfj5id7L26VH
	3J1eSp1JjM7mgEfsHXfMCDMJY5PsPX5Ih5a/XBhfs1ckdB3yH50SWUhea1nyzsp+
	XYYxT2ZwnGFCyAJRc/wP+JtP2BIvIAogjMqNsxV6i7wALeYa4wKhY/vAgri48U7y
	DnApdx5PD1Iu90G0pcE5xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792946825; x=
	1793033225; bh=djT2j0O16usFjd8MoVmUaxAaGcsoSb5ZXRjJliVp9YM=; b=U
	bUT5ABfY8arP1C/cNsAQNbpBoJb6mo0bc2FvyGWB0OW5NkCFUr/j3PoWS6xP+/Mk
	LLWXRLHJ8nIO9QHiGnMwLzoXOwQz12H5WHmEeDvunL+5NEVa65JQOXoyFZc6oUHg
	CAV+W4ORqLw+AvhFDXPRPpjf16lXLib9mIdNxUb5vqcHoYcTmLFD6Ufc52nGS2j9
	uZ9cI31DHZk1DCPjK+TYq8Miu5keiv0dzsPS5InQYsUVE7lonaWMdY10eTiDx34C
	VbUJftrA1/WpH4YxNBiUp509mFQsrRrZpsNUdWIsOI9hkNrjwdhmyRGP7E2BMwq9
	LcP/XPKf+GboiDLITZEmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792946825; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:d0Tv4F/zQ/KFM5GpiDh1i4eSBoYjNO0vaANm3r4ycTKT/Mx
	tZfNuqTONgyp+IUwvBjaska2wTHfGk+dBOzXHFMykfLmjizukKb+Jws92NRqXSb1
	nT3/qz7JKvoj7dvqE5gGTjJrAM2iQXdIUYZ/4HTqpVqctWJVy5DIscLy9dOqFAab
	9YNSx3uca0wfsLyquFIf51xGpOlQxlcN9fNPOeYfB+FKzxZkgT17c/r6RP5K+OqN
	5ROpreON3OfLmPTZvZZXZ3B0zOxPuY3FrdDKMXxnIFPNuLNeklvrjS9AboFbBTel
	kQ6tA2fzdhu+JgZH+9mdWEASw3M3hV2rXQfleJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:r//O2rjJ0/sRJE4l4i7aNL17QM13sckrGgnjByPeVkA=:RueQtUt+ImQ5DFK6wqBU2/n3sCI8xwWC7LIMpen0jwA=;
X-ME-Sender: <xms:iDLeaux2oO3bMcG3-rBMX3b_zYe1vXDgzXVIjqifzATXJXN7n04h-w>
    <xme:iDLeat_rK5lwWC8kwcsukXueSCsM9T4GvP8bhnipuSbxAMGIlOEXNBvmUOZOyjKiW
    Gqkn-koQKFscJ5Qnb9WfMoHMvOe8rAT7kxXYqjv-eFoOUE89xkxr6Al>
X-ME-Received: <xmr:iDLeaqIi9clSWdYE-RQhOnnrQxXBl1x0THU1PwTjvpsKhH51h5dRmeSaxXuW1WdPMCcAMCChv0SVgzuSVOoiGlWvSL7Nk_kFYCSh>
X-ME-Proxy-Cause: dmFkZTFJ6xSctEPQNN7dB8b8QyoZKGGOi2XmDMlPDzVVl5f7ivLtOduuQ1fZ+L3IPNkmeK
    cyCGvOCgJ/W8F5oz21l1bdiWbG4r1KIZv/8W/MiXTlm1dbmUCu3WtOrSARqb/teVNkXKJM
    /iYvNZOewXwQBY9EcUL6+xm5ouU0gxBCLwGVaRVve0IizuQ1Oy8eNilrLPhiMTfd4iwPgJ
    vUOBs6POm9T1zF3NBa1huuiZg17vANiITO02A8TsO3W6kBtoFAHkweiIMpZd/qipIIvDjE
    4GBiBOO5MXVy8I6HZgZTmEqsikvkfYUDndofo+sBAhTRdQVX3X8MAVhsOPmJGzoFq7wrZ9
    opgMmUxf3SPmMUayK200q+svuoM+tBjglqtNaLj5s08XyZm7l69DbgXMZwYYbbjwNBfKXs
    FjtN02Ox5Ys8S9NPz53iyHlfStthPtzPIJYp2g2/R5qu6rsMzcQ56PT8qHn7+tWYapJtPO
    Kkl7hPY495gYDSvQ73V7k6jDqka80iS0fRdOEAnoAHci4HM1i+SR2JpgKsanoBJtMo0Vod
    ZwTqwBIFmZx4pPNGnElC80Pze3QHClxHBB628sZ22pUQx5B9d8z2cVF7RYPRpdYdhh/7Lr
    It0vuPFaJHpi7XIxMu9CDZyDjBUZolfpa5UGz+bFyV26GdwEcv2aqFUWftMg
X-ME-Proxy: <xmx:iDLeare6wod56VUpcZNPhiS-bFS8zO9YXdBkqPlDFXSo4LyiVTI0DA>
    <xmx:iDLeah-50_pdmcbXQacN64UQi6GxWhUDv_xQcMlpFczvMNLFxgf_cw>
    <xmx:iDLeagrLOx5MrM7Vl9DMuJ6jOUwAw5eZGs3p-p5-uYdQgWffqjqxIg>
    <xmx:iDLeauDlIH8o-E7cZJlE7f5Is5zedvKtMQXPB1VjyYRpBUuKOgXmQA>
    <xmx:iTLeaoYh0hJlMNL8FHxt4PM1OziBVDg5NdKLshRATdduh8sBTY_GfxmZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 12:47:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Tuomas Ahola <taahol@utu.fi>,  git@vger.kernel.org,  ps@pks.im,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] t1450: use mv -f when overwriting a read only file
In-Reply-To: <20261025090242.GA25750@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 25 Oct 2026 10:02:42 +0100")
References: <atmvASAoaCIpc_ca@pks.im> <20261025043322.1766-1-tboegi@web.de>
	<20261025070641.GW33j%taahol@utu.fi>
	<20261025090242.GA25750@tb-raspi4>
Date: Sun, 25 Oct 2026 09:47:03 -0700
Message-ID: <xmqqv76pybg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> Thanks as well from my side - I will wait a little while before
> sending out v3

Besides typofixes, I wonder if we should tighten the explanation
while keeping only the more important bits, perhaps like

    t1450: use 'mv -f' when overwriting a read-only file

    Test case 38 in t/t1450-fsck.sh ("rev-list --verify-objects with
    truncated loose blob") replaces a loose blob with a truncated
    version using `mv obj.tmp "$obj"`.

    Because Git creates loose objects as read-only files, this step
    attempts to overwrite a read-only file. When running the test
    interactively, older versions of macOS `mv(1)` (prior to 12.3)
    will prompt the user for confirmation, causing the test to hang
    or fail.

    Use `mv -f` to force the overwrite and avoid the interactive
    prompt.

which captures that this is the interactive support of "mv" kicking
in, why the files we replace are read-only, and the fact that 
mv has been fixed since macOS 12.3 (taken from Tuomas's reply).

Thanks.
