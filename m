Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A634889F
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554741; cv=none; b=e+ct18GrrF5GvcLPvas8WoCNf549a38WDc2Jfrf5YGhzFJ8dqPCEDQRfWVw6NEOM42zUGosOfUhjLxpJx84QXBJvHBj6tYfQm5upRgBZzvWrO/gnjemJDo22qdmFHi3B5QJz+H6zqpHmqZ3GjV/A0uQeAQbMq48bUH1V4LwAE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554741; c=relaxed/simple;
	bh=O3rSZM3RhvFUFPT9Z4OOUTIbookJ2kofhOjDitW7q18=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uLOOVq9DnZ26wRK83PJ4MgCJRCFhQZd3nxK3wqC1cyiavqPz17yxF4opu1AsiouPohBSaJWmXKikFuSHXBDU03dnWnhWU+nhxlnOhh4IAHQKvCVGV4z3y9c4LCdaDFEkPL/INpTJzToxK+sFrvRoq32c7obc02itTBL1hFm/u9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=seXfMmsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Evnzov2+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="seXfMmsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Evnzov2+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88CCF7A0077;
	Thu,  4 Jun 2026 02:32:18 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 02:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780554738;
	 x=1780641138; bh=Z/3ALumsopkmWhh24UNeHpOpVj3yhPUbVNiEIpl+bBw=; b=
	seXfMmsx8i5xjwNCYSuPtz2oEXoVKTeGc0s43rLW+V6QOaWujj0r+zahFz2Z27As
	ISZ0LNbZYusuHQ2fsVLM6HbEwuTBKSzP9dlGvQrrcY5PN6/C9k5WFhXLodsJFI48
	BX3GLI1G1X6m2YU6hJdORUlyD6Fl5rkllDy0ykiopYh14UFP3wlIp407+7pNN7C2
	yZtjRcEI/7Y7LEP84ewCn2hVt0pePLmljy0Hj3IxMBYA85WGY6NFD3GJBXy2q32G
	DQJ6mUXXD9uRDOJndoF+hYOH+Gb1d9FjvIx1p4tAAohUuU6FMte+wKEL1cqpPZgF
	T3YIZj4e2MXt38iV8aHgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780554738; x=
	1780641138; bh=Z/3ALumsopkmWhh24UNeHpOpVj3yhPUbVNiEIpl+bBw=; b=E
	vnzov2+3teUWOHf82juIrJgxTl3pWkFwWJPArxU1D8TmhHT8yohDVae770HBaXeg
	U0e7eXzKzKy+JTkItmf8BsSp7In+SeRtLU96dbinyFilgoobXMVSVmQQJvRJkM8y
	bU4z3Zc0cSjV/cnWbpJjYpHa1mb/BTn/5GQYUq75LJqAqQf27cyIVEnUKLLlUdKL
	N4H3ccRIzbtbhnKgL7nCbUhxlgLJpjNiA6xZcgXyvnH7L31YSmF8yAIXoUrokw9Y
	vosjr06oDRqi3knMar2ZySrZlgzEaNKQADdbgfmLgR0FJuvnbdBPSFQELFpIgiQR
	Bh1VxvDQDfdcet9PemuNA==
X-ME-Sender: <xms:8hshaltgl4fCkv17DYd65mpMMPtXEiM8a2Ejwzz4a8g8y5mvWVT_qzU>
    <xme:8hshapSceFXLVzMAVO7ntEYaIPIxuLlzVc3P5NDlB8HhyXaEpq7BNtaCMGfZUMaAr
    _URXcs880qfcaBPEd4g187M1IzgXfMlwUBRszWxrx_bux2qLbh_FA>
X-ME-Proxy-Cause: dmFkZTESSM9Z8CuoMFj9JKndNkyVv6WlHMyKtx5Si+Nj7nc4aaBuZdPwKFSMShOh5NdOll
    YWMXqRsAyp3U/cXU0ozNgP7dIiST1fNIjO7IFy6cB2GCppmt0kavSngqZFj6xEdOaLx7IA
    jcAWjUvgIHW8v6b+84e/EZebxgu3tJn+MlepswC/440mlYFoJX2AJ5vWHAVrTz586BmogJ
    ywE+mkF7xj5uwTzgbg1AQrCp1lpVZjyITNT+T0SSt3gBbnrXeHuRnrqIR1dGfHW4cFGpgg
    ACrrZYrtLxo/giCieCgvDK96RBGl2JTYCoTB/jbqh0JSFeb2qAVwm8lShTzlVySe5mIlD2
    O6gAE0LkO6YdSqj8o7RB4YbBtI/TA31O17QDBrq6DuAh9oSGDmRi5ZY4lbcJGqq/gcYwhu
    ssIrWHUo7vgTQSByNLPvVypuDq49Wt4Jh+0okagQt7g4sGmJkTmZRRBIJU650BhJfhjzbb
    dC8/cO3VIAMG2J7osTrD25ldRyIspkOFE4Gmzlxd+1OZhF5+RiGu+f7eFgy+7N0Wp6JCt0
    JFtVBNsdOf0yvEBCmh+jeTOia78gqEcRQmbGd+LtVMyd8lS6UX7MpkSdj2zGvTj6KBnyOv
    EuO68em/O9GDPS7mzAhAcQKxfDX8m09ofONXAGNTt3kyp265o2o6kUD8wg2Q
X-ME-Proxy: <xmx:8hshatVnRgmqDTVr243Bx_kK1QvyuEZPB0MrwSjAHvVFqKqvznz0WQ>
    <xmx:8hsharahv3tAM9oYE_q_7vANOvLZ2VHAfH1g_CuvtL6MLa6B--DGcg>
    <xmx:8hshaj2U6nBCJzVlO3ImsvtXuLSc67Bs4YksL0nW8nb7vf7DYl8HsA>
    <xmx:8hshatg54rFGdUQ-LDG3qcXdTc71nEqYwFrJpYlPY79ZED48DyZaaw>
    <xmx:8hshak3KFH4DuYmMOfKMa2dxXE0NeTY3lrTR0fOioCcPwKH06yl-w9kp>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4163D302008E; Thu,  4 Jun 2026 02:32:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQZrh2uv-G2V
Date: Thu, 04 Jun 2026 08:31:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org
Message-Id: <fcc2cf52-cb10-4799-a4c9-eb5916187075@app.fastmail.com>
In-Reply-To: <aiEa5EWeAaaMsqRR@pks.im>
References: <CV_doc_replay_config.709@msgid.xyz>
 <V2_CV_doc_replay_config.767@msgid.xyz>
 <V2_doc_replay_improve_config.769@msgid.xyz> <aiEa5EWeAaaMsqRR@pks.im>
Subject: Re: [PATCH v2 2/4] doc: replay: improve config description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026, at 08:27, Patrick Steinhardt wrote:
> On Wed, Jun 03, 2026 at 06:04:23PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> First of all, this bullet list for `--ref-action` introduces a term w=
ith
>> a colon.  This is exactly what a description list is, structurally. L=
et=E2=80=99s
>> be sylistically consistent and use the description list markup
>
> s/sylistically/stylistically/

Thanks, I=E2=80=99ll make the correction.

>
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay=
.adoc
>> index f9ca2db2833..4de85088d6c 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>>
>>  CONFIGURATION
>>  -------------
>> +:git-replay: 1
>>  include::config/replay.adoc[]
>
> Not quite sure, but was this change supposed to be part of the precedi=
ng
> commit, where you also added the include?

No, because the conditional is only being put to use now. That was the
intention anyway. Maybe there is some reason to put it in the first
commit?

Thanks!
