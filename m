Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207593;
	b=yQtmSE8q8v5StiRCvAnile+rh5ytB/agoO2xyPQbW8Zn0exSI5GkfBwXdg4rDGcJcgKe
	 9R4w7yXG9/Wsq7RGcLnwNWfTO5Pv7wg9UME1tFQC51ZXf3hZEg9KTIXRhszn0HOvfFbA2
	 HgcE57E1rQ+Br5BRM0uYd6X04mA75x4sallvE77WmBmCSgN+GKvoe/DMX8qQOR6/xeCer
	 sAltyLGs2SrD3tQ0ICdOK68JrkY2gVM3AaqOnH2/dj6xelJaopRH/4iKIMVsr+idxQl4N
	 lclK/AICyN9sy0cYS0aax7bh5QtppmKH1m74HdGl9DQ8djPSQdCMvS/iBIJhO/YfGoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=5qaZwWwVL+uFqtxF3P3wrEZKJ/O87ESUuySeVFPPzgU=;
	b=4R0O5r7dbrK2/dW2LC/GHNmNGaVhgQl5q5O7Lwaaw9rcLH37yBDi4Qgyl7eUn73cqfCK
	 63YGKtEBbnYRgpXvvKWyVAbgxl3VSlmI9ZwXgFtudaPgNcUUs1IvpPJqnnYugfGWP6aHg
	 5rh1yiKRtzDcyLHsBiv1YDSlBZbmj6gbakF8peggltzWI/RMDGN91DjMBNZlVrlpGa9az
	 qTUcAOOHNTBxinW94FDoyR0YkpTWs5Ia8PUqo3NzhNNA1wUlOn99GfYHOEUF8cxm2vHks
	 EpaLxuojjXurqXSCHXVXOswNnCnkVn3I56lk2WTXjhJi7PjoQYymiEByDYCu0+5Gvrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jFVtljoe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qXm4IHGk;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC9606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BC9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jFVtljoe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qXm4IHGk
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DA7B91D0019A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:13:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 13:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793207591;
	 x=1793293991; bh=5qaZwWwVL+uFqtxF3P3wrEZKJ/O87ESUuySeVFPPzgU=; b=
	jFVtljoeFfYnfqJKxUCwfxFR2ErfqZMoPH+xwyEDs3SID0J2AnsYdeGgjZ3dBZw7
	tWbpu7C9YKOHzEyfjD4hnM1w4ZxLfE+G6F9PhAXGd9hPNATk4X6uDWMnxdviEBSO
	aLaXKOF/MXGLw+cEzKVfQULw+f7gvqjZUwkJPzTBeqEGPQxvf55vFH7tLpOKnWsi
	a4Ew5iCkBiduDzyOBkPqjtbQ5ySo/mtD0gBlwd74jvwQKuVwmXTEtYVNzJhZAlQI
	FCgzxFpMx4Gyerp/c5F0wtduWJ19knZD8h8A5xM3kk+YSm8nsCQ51cH8mYTIA/Eb
	GFY6jz5dALaKOGr2Dys6uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793207591; x=1793293991; bh=5
	qaZwWwVL+uFqtxF3P3wrEZKJ/O87ESUuySeVFPPzgU=; b=qXm4IHGkdbeI8VuZ0
	gfgTc11JCITXfaB2NL3FKp903BDxhD8IuWuZ5+DRID3EmEcrXbTxa1vV6S/PaV8q
	p8D+vv6Y9CXlYku0XQJT9kAsDDmp2Bi+0aYVtTv4ZGhBNaMfEKwpGlN/vQS/ZdQI
	xRB+TGEC9YudljoV1h+VQWHv8CFjaLuUC5hdC3HrGpQurtgRmIeIkwRUEXRNMHmc
	+Ptd3oEaHv6rUDkldzBuU+kHAWjIxmMcTX0uEnI/F0UE4XbiKWTkXvfZUjlN7jnw
	oy4+wpbplaWyyfG8RH671M81qRZFkZSY5ZySqDCnnflUYz9xaa2bTDUt4GF0hV3s
	gN8Lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793207591; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EOanYBEE2fEhXWTFlm/zcRUnieh+gmkGreiDjuhM1ud31aX
	kdXcEAb7K1Rw+cQYeYv1AVaUyGFob8d7vbp9eJAUC/8L3ybu/D9XAIGva8psCDP8
	Xc8z1G+/6iES2eQZfT4uid2zo3sl0FzptrUwHvGqjYmUtaTzidtrPQIpXdxnHpTU
	ObPyxTAPxvLp3S+JGT+XfXnIMbZX1ZzIhMeBd/zSgAo0zbBwKwvJfSr5RJ0kkbvS
	WfgxQlLzgedXsoX0aP8/dViNVnbLDoJRwev1ei3Dd//2TiK7B8pTCazSkYKxjJLL
	OuX7ep1x/UG74aS0Aqwdp68XP9HSJqf5h8oSC8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9luXN4J5/eXlr1iuxSSdH5N31f3fu+QF4UIKTAoUNyQ=:B59efuAHXkFBKusN7+guS/V/FUe0mIQYBhsnUhyHirY=;
X-ME-Sender: <xms:Jy3iar_tCntViDIld35IRYKI5uElKsrOeddgrj7d-C7Gq7hWZndK9g>
    <xme:Jy3iattz6NuAIfXO73AAVsO29tgtlOiHAq7DCILsPVaVoH66Zp7_PInOoBJEEQqbm
    _uKRFt0tfq7HR_HS49z2ZS52np45N-rLif836gOITjQzydu6FUBV2zk>
X-ME-Received: <xmr:Jy3iamoMPWbRDb3IqlfnT2gBijj13pp_8kp6yADmRPhCu64S-e_KCQ5B5zbtRZmqM691lUDOxk9XqO9kzHFi22K4Y3bkMuAOKT5OUiij26k_oiIDpgQQHIUjNA>
X-ME-Proxy-Cause: dmFkZTGXIPjUQ37ZB51f6FvcnKpOsouUd9wofHzTFudIwgAOghMdadJSFILrVyzZ6BISQr
    C24PiVpg+1yA2arqBvu0FjMW2iLV91mfLY5gG+o8C1X+ul/j/oURw5cTQrHtwXpHp4TmsO
    AMn4BZwuFSLFfsEnvRZHsUC6XOG46kDqVd8DXRgLqbMBbYDkTvHqRWHWCeNXhgJminYoq6
    f/LAcyP/dryCFugxmEzHaNtE1jNqIg7L8npP2MY8UuggTzeifJFoSkUe2eR9bQl4md0/IO
    8jZuAsqzQ/nQo/nftoALDX5JLEN1fvmmeC+ah2Cy7TQJCDIZusuvRmlCi+h26Q/xtFc2Ov
    URl2JNM2mC8di9AkApLv/ABSTeYRGP4XAXmAudXvpEl6ahqlBwLz8DmAyFfNLpHeVYKZG9
    7BqrnvS4+OI+lb/FRhf1x69kxpEEvA+K/Os5xcE/d6L/7EYcjpztHe85RSFHQQWkcvLa4I
    FVyMBKZoM8tY7fO9CSRXpVPTggiyWxDTVupeqz/movdh74HbJOLuKizIC7CHo/ZzRBI+4+
    GuDZMPuqWyC5jW8nZ5R9yqSCl7MqxjMOEf5lLHKtrDbY/+u4f+1QuKiFs5XeFiNIJ2UQFJ
    sHAJdwHqPm01SzWM6pb5ICE9IAYiALIy6/ABZzxu+NHtNbmeYORq+hDogyRQ
X-ME-Proxy: <xmx:Jy3iainOt-b6kwsLUwkvWMmCIdq2N1hD8jPtazJJ28yy7ia1g5uCtw>
    <xmx:Jy3iaiwbDuVDMOS9RA1aNY2zrKpBlJP8VVIDAlE8lZkpKJb6YtHu9w>
    <xmx:Jy3iaikFkwXWwwM1eP1c3_fSPysQENgmgYLq7CV16gWQhhhcFTWCvg>
    <xmx:Jy3iaje7nKHeI58rNH4i3mGcxUOBChmkpnTlHx5EJYRrLh_XgUTdKg>
    <xmx:Jy3ianXHPFFvrsuSdqtJoKgPkY8xPaaXX54-LdQrU6uiJBKE82D7cPdU>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 13:13:11 -0400 (EDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 13:13:10 -0400
Message-Id: <DMGN1ERLYCYY.2L8R1V3K7G9TZ@fastmail.com>
Subject: Re: [PATCH 7/7] builtin/commit-graph: de-globalize options handling
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
 <20261028-pks-commit-graph-cleanups-v1-7-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-7-c549344c363f@pks.im>


This all looks correct and unobjectionable to me.

    -Mark


--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

