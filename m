Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251145;
	b=HSPxugd+np/9lhhbOjg18FIkBPximlhwBPtKMmIBSIcRUq3V97xwEmoExWg5oZnt7db0
	 CsLD4ANM8rsQVNgZsRsiTo5qpIQqFhFexSoz8hTycVmf+t1d/XVlCEbb+vbtRYRECoA2i
	 n3ziCRjxAwsKXC+nSKOi+HOTXa8PgT/O2f9KdGEsrttSOjJCuZk+ZVgor1Unnbkw8LKNf
	 PRMPUcsmbC7sRPNkpoxABpSw2sR8qDDV8qD5hx43iIkb1cMzcYB2i+o0G9RN51sEWhhQ9
	 nNS7hPkZCm66VTJN524Oz3b2lGaU3RgYbzFb68OCXy8+McS6cd4Mi81F14iKnRwqIIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251145;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8VqBOhOGWFBtHoGZwzxpsa2HSrP4iRYxwfMUEOK8d0Y=;
	b=xDZeUF1ufBjKj3gp9H1uYaUT1OSzEgkUKKziaDk2nT1JOMDZx9aJjthZ6RfPUMi3kaub
	 5kwYBJ7lhtqA1LhrM0TDLUg+8NYQ77Vt3w/gWkvkOfKKtdGnq8UxKnQB6mn1zJu4oE8PE
	 VgFe9SBadmZEzMap1u3uKqAoP2JmaL3hlVd7Z122kR//Z81/cVN2zRyRD/smSgACHNqy1
	 h7gOrd/Jtu7+hQdNdQwHoCqfRWOUcvN9goSynGZOQBtnFTpJc7xGB8TEiOnFPN+Q+jeb6
	 +mWGO0vmB7Jo/gb9JU9KbrNv8R2TwYVsFtSWj+pjzJL3zK9OtJWZrODMQFB40V3V8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JE0r6Kdr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IsqQUX18;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95F606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B95F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JE0r6Kdr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IsqQUX18
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B1C4DEC0637
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:05:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 14:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794251144;
	 x=1794337544; bh=8VqBOhOGWFBtHoGZwzxpsa2HSrP4iRYxwfMUEOK8d0Y=; b=
	JE0r6KdraqL4lzTTx/7hTW5tLI7KTkRyUGyhCstTuv9ozYVKolyL9Ja+i+YfNNzR
	jjZUfpoqv8cGbxnENSNjMlXeiCXUpyicuYn+hX1DZR7IPKHtVrF7P47fGH2cRupV
	RxYGuF5OnRtZ8bAbCKs3OT1AunENn8DlHMy1SdJsR1Eg21l7ldr9dRdR9AJsw0cU
	gLpEg543XZHFlwfvzCdMxigvVydE4U1K+Nts1q2P4fxk8qqpJgVhZhZXD+6yXH3h
	2dk5wseyAaY6zitLbdboB3awHsuCiDencphPLT7Py/vZwqSZPgQGqpuR2JtbmAan
	egpjDyGSm2Q6ZK94f5oyIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794251144; x=
	1794337544; bh=8VqBOhOGWFBtHoGZwzxpsa2HSrP4iRYxwfMUEOK8d0Y=; b=I
	sqQUX18H+VY9F3v+2o4ZxzFzjVwwsrIsMDzRt4A8iR9EJEaB61oA/f9RVxrItJ98
	yjUq1+29HSJ1sz6OImnBLruDVgrsk7v+xO4QCuqBfV2Tw3uHvkw7ZXa5X+hJW3cb
	nZsrCtYqMoin9hKJ8eMN7t0Rgjx+8Awctb0NXCmE+/x2hdlQWD9bFuqAM9l7uJs7
	BTtUS5sNlSlYErU920aqDnQlcKZMMdrfbY6TDCFhmcb5Ydh8ZgQR85TnFWGmCfNz
	UaCace+n4yEWwYYPzo7eF9Ad5ivBs41H0byQqM+D9q641bqVA3HuCeEEFtBc8XIj
	bPZcLb8JA9Yi+lwzQtTUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794251144; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AVs2Wb+QZtGF92b68L0zLVmGpJ4ACfFpAyodAL8Imsp5D92
	pmUtUDDwv75dgDQn2oMjVVXBf61OtYO4DMcAleRcPrFrHKkrL8rX5Jaz3bPNFQyJ
	Dv+2NYIlr7DbZ7g+yHi6/LHh6il7H1yxwb5yIGeCjUt+EDKIEe5o8AFANKW2jekb
	hM1AQma7E/UpOsWE9k0FcqnULEN+FkzWrtq0Tl2DEKIzaIhwQ3xzt0PP4zVP8xHn
	igAQ1diMqD4Y3nos6cKFo4EjTvnfY95w+nt+0iRvdosUT1B4hNRUolvp1Vk3F7rr
	AnGi8UFgpVcAX0Bv8jHK90qcbdVf7NiD9LGwbww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Gv0UeDQM0eZC5u5O9SUTsHW6xLhhSPzmeds9n2sj6iU=:x8xDYt5/EDnUx3UA4+kmwFf7VgrmmSOKBvAbCHe0000=;
X-ME-Sender: <xms:iBnyaukBtETyRaB5XwhrcbqgtR5ZuJxa7wGeJBpcgK4YEsSIys-haQ>
    <xme:iBnyaoEq9skpdcDYk3enxvlLBJwEoZzGlQF-3qiGPul0wYTBzsnXOMtti95pRjmoL
    P7zMmwZMo7lACEibC8JeLw7vWN6dixgJEUH2Jd3hdXKLzUx893OnL_D>
X-ME-Received: <xmr:iBnyau7aLyB8ZWPFkCN3M2jCVief8thV9kjkjJo4Jw1492eR7CxCTDnSL6UIVh7gmq2qJCNVCS5wKKo83jGVnpkhQi3wW_-6g-5n>
X-ME-Proxy-Cause: dmFkZTEynL3Tp42xc/5NdYnLuqborpm4nnGSQHxS/NDtRqR7P+d9aSGfA/0DSvUEHZD8MK
    L87D4raqHyrMyY+y0YElk6Gq2ZKTV+6J1reVx6KjRVWAE9XVBkREnESacDdsru3KeOwZJO
    3UrMzYT9lPWNzyIL2oRyFsTXd4/zTZU9Go1C4BE4+OOgM8jjMFeBuZU2bc2c64EJerGRYy
    X8UcKVQ2CBPAPJfs4yH8k7sof5yO399sVaYmlIBsZL3lhpC9B0F7mXmPFHyLcXKzWGlARg
    sq3AGI1jCNrxU6OY1541WV6ib9RiOQvnA3MMgYyO8gZ+UdXSugtarDu0XdwCqNZgdGO7dt
    sr1ViCEb92A8wdWnKovDk8q49hSAZuC7O3sNxLdc6OFNcE08+z/ooHoP/TWnog8+WmRI14
    +8D1tZ5GTypzqExCbDOYj/00hhB8JC6FAQm6jMBvjPOSBrGJvr6afCvuJVO0+Ya6vjAdfg
    CL8jv2OBhHCaqjo7prh7RngPZ6u2+qBy5UKthE8+ZYX82W5forcLnbfy0rqbLiTtN/B28e
    mPSu02w7RAUvuPHEbTxBGSrPoWjwx40xdyyt3hr9h6qY5r1ZSlH1aqJ/tOXp1MVQTN95Db
    y6LBMrdto5f0+sxhZEWtmaoVG0ICLJgR0tgcWsb/1477C3uygheXks0GVLJA
X-ME-Proxy: <xmx:iBnyaol5KXmkAi0OSIZzOtXn7OlkTukOzzEY0iZHSF3pzAgXnLavVQ>
    <xmx:iBnyarqp2vlWOmO_1lB1JJ2U8dpfuetzlcAMYhoHq1W6kMrbfms35Q>
    <xmx:iBnyavu_XOx8WUlknBfCqNEM3hm9b1Y5IVJY5xt1BepFc2EQC0j99A>
    <xmx:iBnyaoGbNxHcOGGeI0ik_EMSbltqKqQAPthewTZxG6e1aiBX-ygzvg>
    <xmx:iBnyav4bPoFXSJKdhLWA4LBm6N05ncKwwvbG-QszjSvGbF5vIYlseyTL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 14:05:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Joie Joie <soniqjjj@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
  christian.couder@gmail.com,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  Tanga Joris <tangajoris@gmail.com>
Subject: Re: [PATCH] repo: zero-initialize configuration values
In-Reply-To: <CAH=d44fX-LN10TU0ZsuJ_RcxE=6QnKsHrLS4dJorAj3T55TZzA@mail.gmail.com>
	(Joie Joie's message of "Mon, 9 Nov 2026 15:26:22 +0100")
References: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>
	<au3hVGPuDyGVwOw8@pks.im> <xmqq7bipiwgt.fsf@gitster.g>
	<CAH=d44fX-LN10TU0ZsuJ_RcxE=6QnKsHrLS4dJorAj3T55TZzA@mail.gmail.com>
Date: Mon, 09 Nov 2026 11:05:43 -0800
Message-ID: <xmqqo6bxzuyg.fsf@gitster.g>
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

Joie Joie <soniqjjj@gmail.com> writes:

> Thanks, Junio.
>
> I hadn't considered using a compound literal here. I was following the
> existing initialization approach, but your suggestion makes sense,
> especially given the update to the CodingGuidelines.
>
> I'll look into changing the initialization to use a compound literal
> while preserving the existing defaults and behavior.

Sounds good, but do not top post ;-)

>
> On Fri, Nov 6, 2026 at 8:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > In any case, the patch is obviously correct and is a good improvement in
>> > my opinion. So this looks good to me, thanks.
>>
>> It however does not look good to me.  I would prefer to see
>>
>>         struct foo foo = {0};
>>
>> if everything is zero initialized, or if there are some members
>> initialized to specific values, C99 designated initializers to be
>> used:
>>
>>         struct foo foo = {
>>                 /* Comment on this stuff */
>>                 .object_creation_mode = OBJECT_CREATION_MODE,
>>
>>                 /* Comment on this other stuff */
>>                 .branch_track = BRANCH_TRACK_REMOTE,
>>         };
>>
>> Now this is overwriting the passed in structure members, so how we
>> write the initialization is not the whole story.
>>
>> Since we have avoided assuming the universal availability of the
>> more recent "compound literals" syntax, which is:
>>
>>         *cfg = (struct foo) {
>>                 ... an initialization with designated initializers ...
>>         };
>>
>> we seem to (ab)use struct assignment, e.g.,
>>
>>         static struct foo foo_template = {
>>                 ... an initialization with designated initializers ...
>>         };
>>
>>         *cfg = foo_template;
>>
>> in a few places as a fallback in the existing code (DI is C99,
>> struct assignment is C89, so it has been a safer assumption than
>> assuming compound literals).
>>
>> But I do recall we made this update to our CodingGuidelines document.
>>
>>    . since late 2024 with v2.48.0-rc0~20, we have been using compound
>>      literals, e.g., (struct foo){ .member = value };
>>
>> So perhaps it is time to switch this to assign a compound literal?
