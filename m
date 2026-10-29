Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284170;
	b=gwX46xOBveLzvichttvNArfeBaIs4XfuJrSa7KsZ4Oqm+gJGBVo7ZqQY7IQkhEAFlGni
	 Aoop7qK6CY8vgXmH7nI4XWnUnH+qiWTrowDAGtORQ8rz72zqPHNRXUQZgGZEjclDpS/ho
	 SHf7ZkZc2PhWIzuvnYzhObz48i2f2Z8QwCIYPMgHUiyAfmm4vaQyCNehdXXOgFEMoxhYR
	 V9lq28s++ZhWcoTwUuq8mtbvBRLzvQM9QGkegty7b3tkIYOdnIDdNkFmMgI3elqXo+qNG
	 y5V+QBjFZONhFEO22llxJtcFAcXGAyyUucEV3X4p2OkXgTvqWwNk1Tr2M1aKzVr8LJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284170;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7qysSHeRDhH+jfiAwYycpohw39jFwjV1sB0mkDxrOIY=;
	b=Ug7V90FofA8X1CUC0PXvCGUqWp7IA/qxlngj9ZNLndY18sshsULk9R42wA0pTxA87JBq
	 Cxb41Aa1pxlyDae5cITu1QhzLdM90Sb6S5z5Pr6Ln3Rzge7LUTHVnePbVDmE3B2nik8Ej
	 q9/KX+meTxUTPcMMNiJVZ/dRYbIQSIs2e95r5WHyZwqQ7RdSsandMYfV2Svg70OR6oEAu
	 8fKA+J7/Xufr8BQliCtNrHXymF/hFyCa3FUL1CoIeFQGC+geCP4elwCoZE8WqKcQs5yeG
	 sfg0ZFNkSCuYc2ZLQy53JkbOsJG8QFwM3TpAk/TOmtzW/dKeTVa6uq+OM5NBUJCpvug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ExnBWCO3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EkFpPZ7I;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91034606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91034606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ExnBWCO3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EkFpPZ7I
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06E8A7A00A1
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:29:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 10:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793284168; x=1793370568; bh=7qysSHeRDh
	H+jfiAwYycpohw39jFwjV1sB0mkDxrOIY=; b=ExnBWCO3hERAnkVMmnkFbKxEmQ
	5pvXCh5lUisMhhzZ/Idk/K3Ol/MI/W+P4JwWGO/tpRpnBNIf4/2RTd6+Fx9vfzrv
	7D72PQFBURnHBcFaMTS34dRcOLA6cOSGs694OicURtxM81W8Ni38ipKyY4OafrkJ
	QWhRnE54/ISAgyy3UPMyoxwZ7kk1GPPH8aKD6QmMBL7jZzu9dZd+6rcqij8gBzqM
	eIg840tyEp05j6ZBmnGFIcwX8OsONyjKTVbIi9lOfplm+Y3LnRZanR6Lc44zUBjt
	u/+zEhnDt43iSsDUyDbYpdb/O7kdOiN46vrr4zHCbwnQl7dDF22hgM4rzEzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793284168; x=1793370568; bh=7qysSHeRDhH+jfiAwYycpohw39jFwjV1sB0
	mkDxrOIY=; b=EkFpPZ7IwuGnAgMUIVhx6M06yiZiP5JzNndtH6GscKbwheyb5Is
	BYcqdbFxnR2PerF5vUT/P39CCZAH71/iMcUDTxrovdrEnMcPcIDljCSTDocq+Lmj
	U9TaUec5LVhxZhKfoH4Oyjwbn762ChNewoF+wZ46NA21L/QLGatbFEKaHkP2du3x
	qPLmExgLNge4V1+Gt21T0I9oRWcnMBG2iqcPww+rscFO0KmIEifMh/uXX4Q7SRvj
	aTn+wI//h3edzr/1XaQER23wdQVMG+He5e9tY7nP8UxWGh+34MBAuMHlMZxRbFtp
	/VeuAQ9yLW5cuv+5w3G/qYVoMoFG44n+OsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793284168; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fD6t5p3Nh7GPUfDtzjc06mQxTRCmTor0Btwq5tXFjFR/xkz
	03JxZOxMzQm51Czr3Y6vqiKMgHuJOvkWeo12jDN/20SPm/oocoIqLbhaLAk/Jzji
	xB6LvAleLtdfzt9OqIjNd4z8Vj28O1gKvQsBM4iJRrnELJtNMX85rq93ec8Yf+gB
	U50hcbCbRBo0Y1DtD7VuZAkWoY/7Z/IFC13X9GzamGpT6QfvmoMoexVOyCoEEq/d
	L08lshBpaS7B+O9gbJtMKzmdY/CpzTULpnsg/MbLLiapgfWys3UdWGSGqPhw+M+y
	DKKbzggIzj0NnKNrfYC9M9WuZI5HI++34TzzIqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0isDfHf3A3IdQ+/ryDUXsUzbEaZG1W5mjYWmLiylBEI=:t8wRkK+xzIROc1MiSeiu7YJP1PsPBLuMo6BI9oYjSjk=;
X-ME-Sender: <xms:SFjjagV11Doqak4mey9TAY-IAqzHw5zFduItYQ7c4DecMU3CTRDdwg>
    <xme:SFjjasBIBta2H43gyyqNk721sph_8BkVDgzG4IwuIVRjEZHeKq505uuHQhL2LFbrj
    rE22_g8cD6-6CNwJvDV-OGy0MFF74Fjon589bMaZzIfpyMgrqB0Uqw>
X-ME-Received: <xmr:SFjjahyCh4t7332AJgPVqry5SNWPwHXOlOdpbXNy2JpE0SSX2Q8YOS-ovC0nH3uhbRs6qjYzSnFpyiMEB6rKjNJBm3B1Rf1qErwJ>
X-ME-Proxy-Cause: dmFkZTGB3BOc1jCCcycPmHaOlZHjgOL4WXgeIUjfC3gthB7BSJXT12kNePG9PNrGfx3gas
    LKXOMgIAy1w/pl9p+KO9+T9SvaEcmRA4+e/1evnFFjPcss6UdRQFz9vkpd4p4uEPXPEo17
    faKXALf2PLPOX1SDb1CpToHIHY6ymWgyOOrinH+A14+KpaaYDN3nui49S7noqwMF6YJk2T
    CKWcuMbqofCyf+rT1Tg2WQ4IzWvlmBCPR3tOy4+y5TLZPGLPCX1n3/kp4dBWqQ7cANBr6f
    7fF+UJbv2SKIBnMBK5NCPGacdR1EuyRkk+WpnjmISZG6ePuaAO+W36a0x3undldMP4/zfc
    dL8xI2I0QFUwB35IsiO6uF2kA0I0+RcoK/DBVeRhEXxGGf+XiD5mToTdENdfnjEPa5hDgy
    savrxWWd1K0XkAGz4o4MO8vDapepJuZTkMvyjz6hNTqXI32wqcECQXrsjAfoBeWZhZskic
    HU6MtCZPNc9GaMgQ7taQvnnt/HSZKXKKSecDlGzDaRVAuAfL+jdoO7KKIdlp7zFTrQf0sn
    pje2nHaFhcI1R6ZEqcRb3UGDFFoHkoN5Kiz52KqYt755MZ2bSEzRi3wDBLNvcDkHx+ySlH
    gnMIRW6ED+KEZuevoRe/fG5A2xC0Ddpj5h4dhYcsnTwjbb2NmNSLyUBWLENA
X-ME-Proxy: <xmx:SFjjapARMkp8jagh-gLsKP_M36xnkR04BNzE_7-qEMYqFb4llU2C7w>
    <xmx:SFjjauZVOg6wzO3nc12-DyRtAyutfdxySAuhe1oe1NFhPFZNc5d1rA>
    <xmx:SFjjahi4nCYQrQTvr_Oox_HQvAGrnOawKIFAu6OTOvljOQOyewmG6Q>
    <xmx:SFjjag78EjKG0qLQV2PMPDVy16NGW8tuGmtnpGnW_BvscbaqckKE8Q>
    <xmx:SFjjagBj3tKUafRRtEl-jstf9UWKGOOZ52o6w-Zcx4y8fkBw0TVWLjXl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:29:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #10)
In-Reply-To: <CAHwyqnWZh03MH5i4da+8h90kGnth7o3=Ea5mwQc4bx3Vk_yzRg@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 29 Oct 2026 10:38:51 +0200")
References: <xmqqo6cd5hnt.fsf@gitster.g>
	<CAHwyqnWZh03MH5i4da+8h90kGnth7o3=Ea5mwQc4bx3Vk_yzRg@mail.gmail.com>
Date: Thu, 29 Oct 2026 07:29:26 -0700
Message-ID: <xmqqjyn060mx.fsf@gitster.g>
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
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> * hn/imap-send-header-fix (2026-10-27) 4 commits
>>  - imap-send: match header names case insensitively
>>  - imap-send: check git send-email copies like other messages
>>  - imap-send: accept messages with Subject before Date
>>  - imap-send: wait for the tunnel command to finish
>>
>>  The 'git imap-send' command has been updated to accept message
>>  headers in any order and to match header names case-insensitively,
>>  allowing it to properly process messages saved by 'git send-email'.
>>  A memory leak in the IMAP tunnel initialization has also been
>>  plugged.
>>
>>  Needs review.
>>  cf. <auCEKSc60ZnLKjBE@pks.im>
>>  source: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
>
> This was already reviewed by Patrick, maybe that's enough?

Yeah, I am happy with this iteration, too.  Thanks.
