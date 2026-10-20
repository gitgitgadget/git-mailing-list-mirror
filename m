Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538566;
	b=lrUNRHQ9+Yc+ZssdjYHVJu3Rj8WsmkG2FBSCGyGUsG8TMa9+zWvIhNhaQQ7k6xO2typB
	 PsOdvUcXpMPSH+j3Y1AZ/A6IaOgz3lN2Sz7+wk1E6kEx9/ZvUPVU/vReTCFE8JBZ0XBV7
	 x59lh7W45DifsoiqWjpdMbfYhkp5pN2fA3qrNtbFBZykVkRjdaw7d63qbLigzf3Vg+lKH
	 RkG+7hvJ2Gmc+buQCj3wMH75/2pM5VnLpFrfmUmnJCzmzCBMzipZYJ8H/7Rjt4hXxwhQP
	 M6yia7oLIqTka2h6ji1lPRNdvYBgzNI3EuthddJKIRJD4X2BUJZFQBrFW3YHN4IRnLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538566;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q1HoTV5uHvF/9OMkT9sZpAJ5VhY/7RCQfeI1nfysM70=;
	b=Ox3wttqTH5qkJlK7Thep8RAnpFKv1Fs2IabNKdGrA0rd6dtuIZMmbN93lM4rnsRcvaK3
	 qIctp6N3EVIKIMarFjpU8CtGx9wApSzzNilPOjAkGCkTcH9TFwL6EjW/jF1W9iBz6oWaO
	 SM8E2tFVBfII/A2jTtu1OLcvzStPdwUVZy7QTGxE8MWfh8qupEHBYbwDH1H5BTCon3PZX
	 nEKA7V7Ze8HOYlybCaVldY8mwekWDH2/7YlzEW2DAYKo4tZbADYexJkbXjg7AZ4J/l3bc
	 rrW1HGlf0RcFO4ALlRyGNkhjFyuPRu9mbJPVv2byyc2SrGLXbOGKJ3j359ryetl6kVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NBwOvSV3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tQr6osaR;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9C606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F9C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NBwOvSV3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tQr6osaR
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2F0514000EB
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:22:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 20 Oct 2026 19:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792538564; x=
	1792624964; bh=q1HoTV5uHvF/9OMkT9sZpAJ5VhY/7RCQfeI1nfysM70=; b=N
	BwOvSV3I8cMD262AeMAk1jZsHGORgahrPmeRi24RBKPWzRXb43rOBJW6xnlGyv1o
	KDd54ZCzkE3tCAvGDkhKezGgJiOkey26NynceeE9QKdm26AQ2REXJ4Dyh6w8rIc/
	1P8gsKnUPNO+Jsv9daE04YkpUh5UEniSXplWOaVqKpH2rZ0nN5LCmkc8A4ZmqaTd
	AfD2XhAzYdl8RCEl1bABXdrd4sUyEqH2dOBVPU6FfwyqSEP/3UiajfeL52Fv2FW2
	fbnBmUeDy5IK6jpldSherNyzuY74ls0hbwAQf804/t0kpLOfRq+ycVE99spgyO+2
	iO3e5KzW7MPnghzOXRKXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792538564; x=1792624964; bh=q1HoTV5uHvF/9OMkT9sZpAJ5VhY/
	7RCQfeI1nfysM70=; b=tQr6osaR0UWfWgfKoj10RgcZ6fMdgOLZsbEqE0TaLsgo
	H1HUEXCQTQbNNr5BQCuDMb84LOqvE9hl0N41yfPxGlEq0CSqp1kDsCfAjcGGtQq+
	RPEdWs744+sbgxMY2f1m42JBprMFz86I49TQMxODzU/UwrS93iLxGq2SmCH9+pqr
	C+Jg7VZFf+xHzMZ2e0+049wFhYjtJ7rM2dRckjU43+CR1q/lt4m1fGfozlpLeh+B
	FLUfxK/lqz8Z/RQfFllDeMkhtCXCzYyaxpOem8rZqH2Sip494dJomaekGEy1191J
	vsvaUBuYr/L5PgIIgaa0w7wYS3Wdn6abS/UkSdp5/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792538564; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FsZrffisbn50JQaKOd/HoR90V9uKVzFiCZgOa7HJjyaXQel
	Ugj9M79iajG5QaRCrSnDYTADkIi1V2LlAF3KtGd0HAR/QNGJ5Gnhl0m6vJd4VvHL
	XV8u7tWHkKqRoIrLr3j74s3u4EQTiFFvsvesjqHhWAxAIWH0uOuby4NqCPN6YiEj
	p7T5K4yKG3wHzaY4RSDR1ebQmhnMeqroJqZNR33IqvjzcGgEEgl5Kh6aM8ygjHeA
	AE4IgZ9W3JFkW3O2ZXtO95b7pi9R0mqKhaSVj5cxYW67fhq9TTnHpRu1ehGWsHgs
	k+P6GHx3QUqUqpcLd55SNZL5NxERdDL2PFUa7xA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:y48/W19KUJm7UjVRkI2RLDYSQl0s4uRPOnqEVXPe5fQ=:fbq7usR/n7/zHjmTpGj/xvZE/7LLu1oVGSW2Ll5eXmg=;
X-ME-Sender: <xms:xPfXaqNWMRCrYe5fG0oLihRm-C-C_gLamLI-BHqCqhNV9Hmf3Vob_g>
    <xme:xPfXau_0r0mQGWb5G-Ms3d9DOpbiXrxrIEOBGReNxDApDQccksaRXEhBBXdd7LdAI
    53usMUk424b8WVIK9PbPmvuNVk3zsCRsbbRYsiOntWkpFa3sNMYgqs>
X-ME-Received: <xmr:xPfXau75lrgoOoUr1Miy4TavpqlaEd-CF84FrkkH1htMb_VB4DwWSxoXhJ92coqdgKMOD_tDDfUlpqrf78nZIgN7zh-mDDZZ7Vry>
X-ME-Proxy-Cause: dmFkZTGao8WGSOzDaLgEhFteBrgjRjPVn6ZLsBoYCsQqBqiBVO/Lcgdx8qG3V7Bwm7jwJP
    MeKx2/feBkBs8QlwLvPmLrwoe/WSIkHXbYEJ900RDUF2KTnKFYMhpweg3JwwaeMk3LmHLO
    kr3aTiBh/3m3F1o7cBgLfLRZDNVDeTCYkUkeJRtpbVx4QwgcVoIcS79RwnNZQoHaYvjukx
    PW/x0mx62B63/NYmV8zlmxFo4Ko3FBR2o15PMkLghOzXyXdwjgRqJ2k7v0luBoIICGtmwl
    89kKKaDKHTQW9K6G4rW/rCm2DnUm1gGjZTUbTwqTFfdTAzG0t19czWoWqec7qg0FS5sQlG
    RANf/5DarSyEe6fnNsuuKiOFgronvRVIjtKLy2vFfJeE5e2RmMDPMkq02mQANLNEmQVXkV
    dnnvIjQH7TtArV7DAZQ3JCeUVbeyMuIcHjM5SYNJA5McDiUFoNg4IAoI5Qit+HiyJs0igW
    9GDceNKPEl+qzTOLYY5BiMcpa+bbtLhRZV7HAfS6oyTGYc1PcqZT/khIhrtzrct0Xb2J8Z
    udA9N2n2LmMQmDnnWN19C0jSPE/tPnLHTekE6Pam4Skkb3CS3q5dozgAF2ITgTNTTqvbna
    judc8qfp3KkPi5wOWzSBJ9lKW8kqAxYdAQs2gZSPtUnYHcO/fDW1dEJY6njA
X-ME-Proxy: <xmx:xPfXal2HFjAo0rmOrb2gVRasXC71eP1kFY4oqzF_uf6gE-9tjKHCWQ>
    <xmx:xPfXalCutxDVP-0JRTtCdhhyVDDv1r7Z-2kQR9BcTQByxsBxNsBVRw>
    <xmx:xPfXan0DKdTKAs2pvLec7QidjA0bMXUaT9BBnp55FDUJdRVwm7X_YA>
    <xmx:xPfXavt8aaduayhk-knB7-0QvgyQEfSKrNR8_rrQk7qvGd1-bTtwnw>
    <xmx:xPfXally3XxSVpn8OcN-8h9Mc4jX-ZyWbDTzsgumf6vuGiCiS2heV78Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 19:22:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/2] MyFirstContribution: discuss then reroll
Date: Tue, 20 Oct 2026 16:22:40 -0700
Message-ID: <20261020232242.2217109-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-321-g29a826976d
In-Reply-To: <xmqqa4o94e0r.fsf@gitster.g>
References: <xmqqa4o94e0r.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So here is a rerolled version of

    https://lore.kernel.org/git/xmqqa4o94e0r.fsf@gitster.g/

Two major differences are:

 * The shuffling of the order of descriptions, so that we discuss
   reviewing process before we talk about v2, is split out into a
   separate patch and has become [1/2].

 * Redundant caution against sending updates too quickly/often has
   been consolidated into one description, mixed with the new text
   I wrote for v1 and copyedited.  This is now [2/2].

The diff with v1 and the end image of this series is not really
worth showing, as the delta is large enough.

 1/2: MyFirstContribution: move "how to send v2" after discussing reviews
 2/2: MyFirstContribution: clarify that "reviewing" is a discussion

 Documentation/MyFirstContribution.adoc | 287 ++++++++++++-------------
 1 file changed, 139 insertions(+), 148 deletions(-)

-- 
2.56.0-321-g29a826976d
