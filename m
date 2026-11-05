Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906892;
	b=H9/sc4kGH+7AjG+IGEH0GEr8PuZEj/PCD/knte6svRUkvuKWNY/9t/3mJ1uE+QsbruUV
	 ebZOZXLpPFYm4fNeGdOXF5PdpagpLJkoxqwqOPLz8nxsxtNGqmZHhA90ImEJsyxvSn78e
	 a26MFLg2mG+iZuUl9HDPPksgVRTlpy+xnxmv0Gnw307zM+rIDndaJsah0ufERzAa2cNim
	 Yegvk8SgtjR11o+JGr65zmuK9ZPLlFbtH/JNzkMCXszXoDpnmQgP1SwSO9MH/KK3+6mrk
	 2dA8+3yOAtMOrrQUDywHYIiBd3IQA+7liv9H9jq1nJ3mLi7MLzd4yjMlqEtjqiVN41g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906892;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Byug/OvBNt7B26vIJRDX/LPkQrCsTaB9+An2jEY3/AY=;
	b=sqTgs51yCLjvQ/3ULT1z3GE406mDQYWJroHAV+gqA74iQ3i8OVvx98pKmP0d6aesG+wv
	 Iu1x1tH/aLnw3zbrHRgYjtx/VLtC5iTWuBx5RTrfQBwIIfTsWIbVTxkkEY1HdHMSfHt1X
	 S7jjtR/uP1mYeZpvVTNVJIL8aZucrDpGQ/Sla26D5DNDibbQ5sOuEV1x0MfOewYd3DeB/
	 /YoG49HOrOstbgJ15L6tH2FVHyfA4MmFoEtFLKueJHw6mpaN8vqmynFrQ6ZXa9rwHnf2q
	 D68xbjKpAFflCqOE04eSgTCbr3LdDFPaRAAleI6m5CFnh7rH352ywawskISPzqFhdrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=I93HuvRu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h++7KUdW;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C302606A330
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C302606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=I93HuvRu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=h++7KUdW
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A521414000B4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:28:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 14:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793906891; x=1793993291; bh=Byug/OvBNt
	7B26vIJRDX/LPkQrCsTaB9+An2jEY3/AY=; b=I93HuvRuHyWNhxyswXor0KG2rF
	qyGK01UsnUewSI+SrIKZCYm5RgehW6RNHaPT/ThjbT1EGKZuh10BiGzchZADPrbN
	W26x8/9TPuLl5/Q1O1oMha5uk2y1MYTHrXJW4naY81jd+CSFcYcaWJRKxLiSyCJy
	2ySdrma6+xCNiRhoRlR1Budx02Bd00v/adQ/5MQ30nrEPZdsIykIJbrajTgb4Ye2
	iq/z4Id1mWsRDqv8abz55dzzfAllPY4Dd/hpB18BHV6WJ0GcdHMPB1vc++B/lfBH
	PAcjA6nSGdpSWUsCyCch3yMQMZ/J0e5llpsw4kl4JdeI/04f4uArBox/6Png==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793906891; x=1793993291; bh=Byug/OvBNt7B26vIJRDX/LPkQrCsTaB9+An
	2jEY3/AY=; b=h++7KUdWGnUeRsKU8y8xoXr2C0ZCqgrjUQdJW4kRwelqFPy1eaL
	FYikv/Gzn44wTzyIy8mwyg66zAOZxecZia3tqfVDDrS6HV0nU4G1n15QTk3u0CCB
	ZkfQtdgaVyh4xRWusGP7J91FhFh/EwWWWlxq4pUXky/IVJYUFQer2xtOEldk0Pyl
	yhO89ZZrJ85sbWyT6kNStwH1h7+xPimZ7EkLxz+GORcttr3rhEPx2m6srEtTFO0H
	d3gEOJQHDsrnlP1pqpt014xswR6Z9lz9Ud/+ZQH3jA6Of952QCc4dofXwCNN2WBs
	yqICY91+WejHsdmyU+FX2FLeih0ZsPO3tjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793906891; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jCyRs7tLfDHwGTFXzRxZwsuU0BGefr2YpgR3HbE13KcvwAS
	eyRmwwcLuzh+f+Pa6nlQJwmHgMYAqvDViwzanZtASmil7yzuPxvFt4z+elN/D9iX
	3N2fqw+1CAXh+dndvA1f+bbNMhywmfpKNHVjMWMm8HCwTtj3f+JiTigL9CLBZaXZ
	vDGYsb1WY/9zls6c+t9MUvLbwv9NY9+khtkJa4BdnvXAVbui7bLunyzHllGZaXB+
	odlxLhFd5jN+xv3PrFMj/HKH5bYbgq3tPxqjtdTOmEAkFwE4N9NuZTwL4VVhMZFx
	VFRVH4IeYMeVYQgIXl9pu0k0O4Sxr9HpeED5LbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UmgfgI94t6dxPGsFzq9UPIecvz4Eagw+slXb0jaVrZU=:KC6ev2e6wgSgwiZvu/2dUZiYDPiqIrV2P1xGW/Bt+VM=;
X-ME-Sender: <xms:y9jsapqDQ1OrYtJDIpJAbW5z_CG4L-EQCuv4DyVbxrMjoUi68JfGiQ>
    <xme:y9jsavWlZPFoGbwLuHjJ0OWKyvYUjWde001MdylK9hiHIosvPy2G8uMaDW5Zv17fD
    EwL_71j2g2W4PB6EHJd1KDESDoBeZagwMbDkdHl0MY6qwjmg9s5SOQ>
X-ME-Received: <xmr:y9jsagAilPGiWQdDx048edzaHvzcsy3fp6LLo6rVWJMtoogmYPqNaY9X42TD8D0meGHbDGMP8cBaib4zoG9zfXsbUkBt7Y0RvR-v>
X-ME-Proxy-Cause: dmFkZTGuzPnOAP4cS63K06xZfqwXifYmKuDkHWhaUzaICuI3HB3OKTvXFkhEWOajlUzJqr
    i9jJZKRvvqPQwpHdGiwYtLnr2M7aj1gJ3O3T4hgGHlWZpp+RDyt6I3UqNHhCcdtbfZBAgf
    PcCvRfW10j3zVi20nsCVTMwTsw1Y1TjvsTZaipGbRGvQBvy7Ved7dKrO7V7xxZmDtbkG5N
    nhByraOxWULE6A4jCQRqnPxl1ESzSqe1fSiOYze7h/KwZb5MoOvUMsLcVqmY4JleOMOH6p
    2DjAA3iS/ttGjpm1mERXwvMcf+5dinQPB3JxoY52pITw+NlprIEPr5g+n8yGxzwD7PVpnC
    RSNvRPpSmY2U2Lb6/h4xoGizOSs48xL34WTMx8O9p3TJXGAzahR9YaLVX0pbgY/LiVISVu
    4s8N1gNY40lrLz4STBPGUT9ii6X5xGNpy12vANsXIUN8HtXNX7FQKrnsAuzXhuXjgaB75s
    HS5IYImOcxcIawwjcpZHSpj+rqUYprQ4ZJUcXh9fl+ElYorkDwwqbel9BpyQHPl7zko9fZ
    psKJ/JDem+VGVeSJ9+wudRHlJ1COiJgOu4vmL6cqfKlkxymRjsMFuOA2wjGAR/f28H0suS
    +Z9z+K9CVoFCA/l+66jA4ZagR4RzMhB+LbAd2tiu2ehYo73UXs8TlsiM83fw
X-ME-Proxy: <xmx:y9jsar3piy5kcYT9Q7NIuDXAMrqod4hLPsfznsYg-gKa5i2Hc-rIQA>
    <xmx:y9jsaq0iREw16GqLTEaKJnOxrvZ2O6H17ktXhrmkBkeKM5gOTO0NzA>
    <xmx:y9jsaoBQ1jwIi7F-Bpwu1li4SjQcq2Q39MoIezzO_lGRzg-otwr3UQ>
    <xmx:y9jsah69m7clvDu-r2m1MsVkGta83POurzCYLEwZ1HA1XIzYG1jPKQ>
    <xmx:y9jsaj0EVM6bMR1hxa2741rUvy8NqSxKLrE2KobxnYN1uaXWwm7q7blw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:28:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <20261105180747.P-kMC%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 5 Nov 2026 20:07:47 +0200")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
	<20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
	<20261105065723.Q3ED0%taahol@utu.fi> <xmqq5wybw4gg.fsf@gitster.g>
	<20261105180747.P-kMC%taahol@utu.fi>
Date: Thu, 05 Nov 2026 11:28:09 -0800
Message-ID: <xmqqld77t6wm.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

>> > This topic has graduated to 'master', so we should be more than ready for the
>> > last bullet point.  Please pick up the rerolled ta/command-list-guides-sync-lint
>> > at <20261029184834.2273-1-taahol@utu.fi>.
>> >
>> > $ git cherry -v origin/seen ta/command-list-guides-sync-lint
>> > + 9a1ba61ac0e4491a4f028250be478cfcf05c9ef4 command-list.txt: add gitformat-loose(5) and gitpacking(7)
>> > + 5d36d7585956d17172012c8e42d77597524708e8 lint-docs: check the guide list in command-list.txt
>> 
>> Sorry, I have no idea what you are trying to say with that "git
>> cherry" output.
>> 
>
> Just double-checked that the topic is not in 'seen' (the lines are
> plus-marked).
>
>> Earlier you said "I can rebase mine on top".  Is the patch
>> <20261029184834.2273-1-taahol@utu.fi> the result of such rebasing?
>
> Yes it is.

Thanks.  From a cursory read, it seems that the thread has a review
comment by Julia which wasn't really answered yet.  Is it ready to
be picked up?
