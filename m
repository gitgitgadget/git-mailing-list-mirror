Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684604;
	b=XxeS+PvNqEu31TVgLjNoJ6noyNegEIqV3XJn3NhRYGIq4AcInAlMRTsbOhQUDeQwyjrJ
	 mBgpj4TRqJxz64su3CgzUmRaTyE9gPDq1WWFtAPyXvsJIFubQvc4NvsJjvIxLCy9XzUif
	 zBNLmnGNxUALBnOvu2RynXSD1Fe10rqyv7G/WzArDDKfn22kdfYe+UdWEj4ORmhcKA0Qc
	 NbR3B5z1pGYRO3LM1jWs7OGA9Dqu0XbONnoLXVmYd6g4oDimuHU5vYSdZrSxrCOoWk7Zr
	 OPneqcDp2iUVknJs7DRO3NwNdTCi1EDAj3pOnhuN8/jDEjnNUXskXaFlBD5MqGwcWWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684604;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XMQL4RvIQPIV4EbPsQKBedzBwR4pIx44ibA1bKUzA44=;
	b=m+MxdKggGeACUToxklIUHNjrEzIi7NLBamMRCXFHY9T08XD7vwzazeDIm3W8TYMAbD1R
	 xyPonRMC63HOStZUPqBIlNHIfpDopYxcE5NzSeL+ewi9YRjUd6h7hfVyhYruADiLIA9rL
	 7AuJyWHqbkv13xPw0REwY1QIK2ElmMLXv5uytJ5p1lxDCujNXITHSpHvFR+yZMRdbDwgw
	 IBoUOQeOJpDrbDR9yqCxcIxd6p+cg6VOLSd9GefK8m4cHV52r/RA+FHPagaAxK2yDEPSl
	 3tMtqAGsGsVo5CCuzRBqjxwSTbRekS6li/Eri2+KKjtjGyBLyIfBnV5xrSdLZD6RUiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="o+uG/ez0";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GsdKHgYn;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD58606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD58606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=o+uG/ez0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GsdKHgYn
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A34F7A0145
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:56:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 11:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792684602;
	 x=1792771002; bh=XMQL4RvIQPIV4EbPsQKBedzBwR4pIx44ibA1bKUzA44=; b=
	o+uG/ez0Ekch4tL9+zZZiPNudPkzt/K/9b5S52tQBNJZixl63Wps3T7Tx/y2UAOW
	FGh/swzYLhJ6MMMmeEHFMZEBX1FCNa/WeycGI2mDeoHXcZQWUAMoqL622rbaVFba
	usBesy2CX4sjb3RcYrL4wXlHo8O3oU85IcQSlxoAPxC+ovSLCxLy/yFpGDP2u05p
	d9znDh7IcclzuwWSmZKIUzZj6cQ+WJkdzNtG99KyXUWEVr56AbHYb0JKaNIWtCtZ
	m7Tkg312eTdZFuEZ/2TY37YxeovMc1VFEwBmzNpuRFtlX6tYBh6nX12oNKH/FnKW
	Xt2w6nKknP6b97k0wqwJ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792684602; x=
	1792771002; bh=XMQL4RvIQPIV4EbPsQKBedzBwR4pIx44ibA1bKUzA44=; b=G
	sdKHgYnhRzoyE5TYyec5eBDqi4WypFaUtMfFUER43QvXKsMxDdH58OKYpca0tHJV
	pXrhO8EkgeSLig7NXLnw9iZgBsDaV4S0wxFrQ0hNtzYOWplKnHxFfteuEwhzkrtx
	gyjcxTbaTDzIFiq+vjA/gJ7zSgCsRxqzphVsUdtYLYdnDtv3yZcID4oS24c+Qf49
	3yPcQCrtV0QD054dfqKkbIXYWOTvli9xOdMM6TiONMkgh2bVt1MehB116UJVPU7s
	91F789Ccx+Lgc5V5yMXEBPhjRUV1e3wiZnSPEGUrzWGsFU//LJMgkyu8sTEwSBr5
	hW2ImQw153Fv7j6n7jhsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792684602; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DUQYXjV1fQj4S4NuJottbXx0V4nrKguQx1UbpRdT+y/kyvk
	pL59DE+cWBP4pKnhGGfqCVRAn9MY/tBys/Q/KnnD9MBJl6pySz0AhucQiY98baju
	xJZFEpfJ0JLhCrKQmZ23Jic80bXZCLv8bBNgrHV2SxXVkFO+4yD+OiHmSOZ0H5Oe
	iA7I+0nER1DcjkB3XDCYYqfIvpMZpCVTROahNVXvk/Oxz6G8/gweYvE14jYbS/Kg
	RJBb9pqocmauhabDF+4RUxg7/gPt2279G0kYlRp7Fxbj2B/I/xHoAqVcLeFz8GIk
	o9aRLcN8vOkzOF1TH3DaTl3iW/DPX81ddN+iGQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:aMo3GcWRSWatyhJ4IOiEVRZm60k3z5bGEnd3yNpUqx0=:Bjoba6aBMNa1yeTIoCXrHkPhHvyPS6V5DbmlIEO1kOI=;
X-ME-Sender: <xms:OTLaamEvVd4CLstZ24Jcsx47zIhXBtImz-mJDXsy01uATdXHGLBtAQ>
    <xme:OTLaao1844P6DuxJvWBzMuhmVDQjSlcrpoL4XxE74HhtzZF2MfAgorEEMxP_jfxa5
    xCEbxCaiKdODXA_mHrJYoaGcDWnsiuhCNYS5ua0ZbPD4boRI9gcsHo>
X-ME-Received: <xmr:OTLaagNz1NbVgkaWuoTKLPva2ro8bE-9HmW84BaKFkvC5928tAKW4RV_B6Cx1qCUmKP7Vvq_th_G1tWWHdhTmG7qtpTtJ7GhX5Nw>
X-ME-Proxy-Cause: dmFkZTECaEB884wY68UbCf0TyGiMGR0n1QMDaGWAX5FxhZczo3PbDwj9OBNHvTCrRe0iIN
    rM3CZU3+ocp6LQEKXi4/b9Nn3choQu4rErHRRsmnmjvNYGJ4YTrKETliGYsicMSQNom/xr
    x9QIkSY4gjySBPZN8YVZjMIkss/rHjMx8zmIg3eiLTnvOSQ/byE1Uu1DSssvOdLZVcXiVU
    w4g/20ihx+yxmz65363FAz2UE1nvBfY8amwcFwMKmE8zxqFLu0vNQYiKa/INNXw8OtOWlQ
    G21xLrbLu7sfDbLsGPVFaXnfeYgNUG5rtD9uhKp05MLdEJH9lKhOLA899Afeex2j5QS3lZ
    s2w2fl3AE16D7RPdtHGOV/O+I5ZTTigUAH3R4r1/RUF6XxQmTjcyYap2aowDwZRFAWyCiO
    YF6ta80GRiJFO79AwuzHFcDbn1ObcE9Oq5hwsFjCR+kPAW0QjUph5WlMP1EWx/fQv7lWl6
    cHx3Y3CVkqawNsPnCu9ojcrlechcA9oNjKdKSUMQKmzh1HTxpITdhZk/heV0+eS5VsVI5f
    ONlC5PV787dxLgKTuesgdgYigeZWYFJgPM497M++6p8KAlp3CffEu8WygijuCRkwx9WMNU
    8rDk9UqN5wmVbP5PW30TPyplpKEaZOLmSmMbYADkKvGLXhEwl6h+LWbTi89A
X-ME-Proxy: <xmx:OTLaav4DivyKvI784Njkq9M41M_XXOgYARIeAKbUCMAsxuovRiHlIA>
    <xmx:OTLaai0vu87AoZwqbv973lFYqgmdZY1wzX9pGMs0U4kuB6j7TThz4A>
    <xmx:OTLaaozFAq33l6hlkk7zlhf6_HYRFovVWiyzFyPBJalhhMGgGy4LbA>
    <xmx:OTLaaks_ffVni78L8zzpZvo3GS2IApCKXKysET3qwJOKfiSBquE89g>
    <xmx:OjLaatLW8YwXei6vYwJyrDL-RkulUpZP632DAbcpTTXmrOULEn5MXdu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 11:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian =?utf-8?Q?No=C3=A9?= Ramos =?utf-8?Q?L=C3=B3pez?=
 <chris@nortesoftware.dev>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] gpg-interface: fail when the ssh revocation file is
 missing
In-Reply-To: <20261022054607.766255-1-chris@nortesoftware.dev> ("Christian
 =?utf-8?Q?No=C3=A9?=
	Ramos =?utf-8?Q?L=C3=B3pez=22's?= message of "Thu, 22 Oct 2026 01:46:07
 -0400")
References: <xmqqa4o6oq1y.fsf@gitster.g>
	<20261022054607.766255-1-chris@nortesoftware.dev>
Date: Thu, 22 Oct 2026 08:56:39 -0700
Message-ID: <xmqqh5idiv9k.fsf@gitster.g>
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

Christian Noé Ramos López <chris@nortesoftware.dev> writes:

> When gpg.ssh.revocationFile names a file that does not exist, Git
> warns and runs ssh-keygen without it, so a signature made with a key
> listed in the intended revocation file verifies as good. A revocation
> ...
> gpg.ssh.revocationFile had no tests. Add tests for a revoked key, with
> and without ":(optional)", and for a missing file, with and without
> the prefix.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
> ---

Can you stick to the expected flow: (1) send v1 (2) get review
comments on v1 (3) respond to these review messages and then (4)
send v2 AS A DIRECT REPLY TO v1?

Sending the reroll as a response to v1 is important for automation
on the receiving end.  Thanks.
