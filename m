Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C74F5E0
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883352; cv=none; b=hEqR1LTmfHB/L+4rWaY79z8hFPwame/qe8DAeuYpJtUj4uq9KexRPp+SrGO81VuKAWNuZohX5mGdVRwyguK5Qxh2L/sRNKbBB8q+CJvT5Qtp2FsIr9umZPtmHH9Mn7mMJdVk+jwcXnMsDCbcmqO3PlHm5C7otlZvnD57/s5KFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883352; c=relaxed/simple;
	bh=GUJa+XbQcHciIdYRdA1itoTrkF7HtrrkXJ3AM8x4c4w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fmND9obW2ybf4h0sgyCnrCiX8X/mYePEN1lnszHedEHDhu6TR+S5/3hzlM8ys5Q1eQbLffePlsODjrL9D8epD9TUO/Oo4sDGy4hy/Smib2KO7SoydXNS90OL3T2GYUa3UOgk/E+hIoBo1HJycu7LcPzSUwBP7DLmz1AOZALengo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YltN3+kk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbs3T4XP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YltN3+kk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbs3T4XP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFBF314003E3;
	Wed,  3 Sep 2025 03:09:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 03:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756883348;
	 x=1756969748; bh=rdv9ac+4ExmD8AJ0PeX8CqRs7SpEnvWhCZtdXdvzcnQ=; b=
	YltN3+kk0KX/NApOFvM4t30WvuIYzDJQHvYEwBocCSMmKFXrVM0XgyVHkZa2YwYt
	o3Ei8RKsajA+zsSwvt4lHykHIV0OLTS3R/la4hz+yH7lM+zYUz7ssiMz/kJXfYn8
	qkdTfjVp9diFQrf34JQ+ZYEKX7Y+ThaIsqyvt0Up50O7JjcGMdusSsrpyfwHwVNv
	qYy8BjXqWju1qhNLguG+QV0BjdfJcUqh+z8Ua0lzVfAZ0e28deKFEJS1vUtGt8Jt
	kg/f1f5K0sSBtlY6dKVnyGWzYtLZt5fi2Tue4T//GbN6hq/+pk3HI+ImKUxsRqGH
	rYiHAz7d8NHxPtb0SUmpIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756883348; x=
	1756969748; bh=rdv9ac+4ExmD8AJ0PeX8CqRs7SpEnvWhCZtdXdvzcnQ=; b=b
	bs3T4XPlud1J9oRer+cbGL5fzpLMHju+8gkNj3K/KUUNUZpJLOMXvW43BWeXZqdU
	AAeL+usIjRaD20krAFmq2SAi6t7YOF6lHgXSvXQYs0soUmBnO9Ce8teZuBrHGIPE
	RU2U8QXISC2266ciP5hRrf3G+SbwMskcoBI9c3bhe2SgFuU5KK5tFQ56hjlSJpiy
	bXN9L18AfssymrK69fZScMUjNHesRRA5fDvA6gZ1V4qYRHSoAPHK06NZ2ZisqgQ5
	7qLMoTrZJhEIRkI6n6fecUb3F4VNTM8QW84nCsmccWp1iTXM540wpeyooOvGJiNb
	19XwAsPkxHLiiqWDgnADw==
X-ME-Sender: <xms:lOm3aJV5Iav7UDeUtbnC26nr0InJ1gIo9__8Zx21fYi4l_4RCvfV7lc>
    <xme:lOm3aJm-zoMgZdtjmY34PYnwFR9AlPp3CRHcI-fW6kO5ocgZIX88GD1B8yLVEchDV
    AHP3-M9mUVN-v5Gew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpefhtdekgeduudelueelhfffleekfeeifeetjeehveefudeggeeltdel
    ieevudehfeenucffohhmrghinhepghhithdqshgtmhdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorhhgsehmlhdurdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lOm3aG8jTp-8aOGooWQMx1mbcsEeH872KAZNBSLdY1aW_6Ge0LqX0g>
    <xmx:lOm3aNlL0F4NAlQgUHh2QntyTIaDkqBiFYkfDS-j0LwJ7AjTJqksfQ>
    <xmx:lOm3aI_CcqeJmodOJlpx4WAUR8j_xzIpSajgq8IRf4XPVnP9ab39Aw>
    <xmx:lOm3aLlaUDJNzjzNTCZjmoMXkoWgo6MD7jeJTuBcxjvPSlHbkuKMTg>
    <xmx:lOm3aEmHD1Q5EkFZyB78_KX_HHztb-YNG8Qz8QnfqPKHxlkQjzi2enlT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F99E1EA0068; Wed,  3 Sep 2025 03:09:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzDH4QElPoFJ
Date: Wed, 03 Sep 2025 09:08:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: jorg@ml1.net, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <049579fb-6e42-4c3c-ba5c-71c5f843a66e@app.fastmail.com>
In-Reply-To: <decdbc61-6273-4173-8044-31658f33e207@app.fastmail.com>
References: <74c5f07d-6376-4787-a5e2-bb09abc58ce1@app.fastmail.com>
 <xmqqcy88lsw3.fsf@gitster.g>
 <6597b201-8087-462e-adc0-0ddaa8a7402e@app.fastmail.com>
 <xmqqa53cioh5.fsf@gitster.g>
 <decdbc61-6273-4173-8044-31658f33e207@app.fastmail.com>
Subject: Re: Still using "git whatchanged"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 3, 2025, at 08:11, jorg@ml1.net wrote:
> On Tue, Sep 2, 2025, at 23:33, Junio C Hamano wrote:
>>[snip]
>> But not here and not now.
>
> See below:
>
>>> I'm not sure if this is the right forum for this discussion, but if
>>> I were asked...
>
>
> Given the circumstances, I vote for keeping "git whatchanged".

You can see the discussion around the whatchanged deprecation as well as
other things in this document:

https://git-scm.com/docs/BreakingChanges.html

> Given the circumstances,

What circumstances?

-- 
Kristoffer Haugsbakk
