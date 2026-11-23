Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462446;
	b=SqkT3WZ4B1WW7nls3M1wAvAEOcZxyvL7oIPrEgsQCzbvsSb8xtRmylbqwKIlLYvWnZxi
	 aG1yASOBciz5sD3ab7KH//2uMXcqvIgWFv5QIna9aHyX5WbPDVXgjx4WzLQ9w082w0D4D
	 JclD88kLbLyn+vngXCSG27nM5STKU/KtsKN4DW2v8YFT9pUBNk7hwLWfVfCt938cGOS7D
	 HXmIOOR8LeUhR6qkzi0XxCjnPOjUG9TwsriwksCPqIuJQmJWIAI6at/Z/wFSeyydDO5LU
	 /Y/hZtAflEvlKME95pAEfxddlWAEjPUIrD04irobp91jmPGsLuOfximXjY08yPXExkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=d0lvDdQQNpVw8lItCl80hfXez0kPq/iHc9xTHw4XxDc=;
	b=zLydeDntroeb7ZfFxmDzjJnqI/6+QOf2viShyLJRK31fo+PuxKYcz7+fj+iFhIriE08w
	 J/cTBlwZWohaO056eFd9/C3REomInsS0Gmff6QUiN9fD5q2cAS5OB/L9blDzlSafCeZLm
	 lpHY0hQugeahHfcSfgYM55h/UE6Y2gmCt3TTu5OiIIp0QccB3ZNoEK3rsmn2UKIHR+rdx
	 +ODlJsS29NFXdKDiyHwCBz58cppXlTxMMJE7m4Ar7HzccEWfIzFlGvFViiOkBwRqwiD3W
	 YCGVP1NNX5ab1nupsPt7evb3jsbJXdAxVdYtjIyBwi80YBVSCbptMOG6dM0ZxFujxcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MCDEeAkM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PBdILlYd;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A62606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16A62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MCDEeAkM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PBdILlYd
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CCE97A0627
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:34:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 23 Nov 2026 14:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795462444; x=1795548844; bh=d0lvDdQQNp
	Vw8lItCl80hfXez0kPq/iHc9xTHw4XxDc=; b=MCDEeAkMYNYRhemlItpNld13D/
	3p7r9Cya8tbHCp7leyFC5DNB7LfBJ3GjxRrAWK1c9YawGwadaAhCpB+X8WnWNYqk
	48aaHLyAfASTxsvW+5NckEAp14Z3ufabvrn2/6Rm8izShKHc1XtPzJ+G97B2rho3
	7rF8bbsFU0yazSfsmKmdBCnHuLBSqBL2MDId+bwhRTnqH+aQ8s1N1FztZ/m+W4ol
	WuNons3OoBQ+/AytFEKc05NBQBn0zZuH69ZQ5nXepmUqVXgOSIbw4L2zLRqoBrr0
	GwT0rXWdnB4zo9d5yoCkspKBHTOytrFvJgAbApX9YaLkV4YhB2EBW+dFar4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795462444; x=1795548844; bh=d0lvDdQQNpVw8lItCl80hfXez0kPq/iHc9x
	THw4XxDc=; b=PBdILlYdxBmZQFeabJN6z5SqcOGhVxmfDz0j+2ncbudTfsjBh9B
	KKxDv59iac35jPZvTSRNXbbBjky0MTESRxRefZFeptsatldwC0MeFwGOGwhCg6Lr
	qWbHfr96kZeRB9wTAeijbr2Cmk4DIK79WRwSdrWzGi6jWsd2+XGtrDtcMvBQkqfN
	cL5tLCCKSp7KbNbziPvCK02d7b4FETrYJK2h8fgArUKfL38DuxPBrjY26wHpl6du
	bCntr1aPbvg3CfLqUP17+1HKZvJ0R5w3RfXlHeCz6Gy07rATRlkzuq5KLzx8PAIB
	LgJLrjoYszcvNnwN6PDhu7yM54fv80MdiKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795462444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lMmYf+NLl64wpndvukZcvezlUj1hw2BJ9Zp2rfmLzQdevYn
	eCKrmYZBe1x30dblmPXw/wVgwPsbDFcGVObKwxRBLLv/jdOrvoN1Ycu6IOajjNo5
	ksYkQtGh868zbNYgJFatkEHDzFsCQvvbYa+F7EB1ZkIMHsV3eGIJ0J6QZsiAMgNM
	lco0rycAaj23aQa2AHJF07QZ1tJCgH1eqnExVPZv4i2nefXjByvC/LUYIjWQ9Ofl
	oNTC3dbC+l2Do/YMZqnDs+LhtFTKFXnRpO/t268W/ex5DeGg7QEm0Gk3CaZqKU46
	OSBS7Rw0uPBbYh4MzSQ15bPOg9s+Afmk7Oc6q0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QYUWJpWdZwZyA2ldYA9ixNHx0YKpsuO9IgSJOL42Hio=:0A0KAkEjRKPxbp6QWF5sPdmHSjwtn7PdLf/oWi13PCo=;
X-ME-Sender: <xms:LJUEa6iO2juKwI_x6oEgEVxyQwv2Iag4Q2KoPt-aINq9azdvha4FrQ>
    <xme:LJUEazO-i82eVrJAPe4LJ-l1681IZdzujagM3R_Yum0C3BoQ7ttpTQZHjQEDmdwyB
    -SgR9HepTHNXpzAbMdVGZPsoxJbLZ2BW3Eh_ic-QRE6g2lJMyT-XVLf>
X-ME-Received: <xmr:LJUEa9qP4CsoPZeq3MsRYb0gq1Dwjkadk-_DZ3QQCp6q8KC3WmVVeZwiQOGwSHdmnhqCL6L63kukhYrnQ9wkaCzZcp_woylDczV_SzY>
X-ME-Proxy-Cause: dmFkZTGX8+b4rT+huXRf1+7DJoDCMuJf2nMJpST9E1n849cIM/2F2hTEHKBlENEmuco69R
    2Xckbzszmh57v2zViiAiX++pS1nMYPctwIjvZa5YWx5Y3DZJ382A4KcxWgeznbnnmu9Hud
    6UVoBTS8CS3V3lDzbovSv39cU/I4KqEPR1OGRvMpYQIT9FQeI60VI5ykTJPUyLTGVsH7Q0
    91vrY0e4br2hK6cjXQGMofdRzjEg/I5j/947ZfdbvSPSB4voTZPrSv615jTL+NxdsKvCWj
    jx1I9SEXnXDbgUXNiII416xVGg4CnQgdy3/o6FFSJFRYmi6lkv0UT7FXzvlJ6vNhd5XstG
    8oAOLw1KrKMUvBdT8kt+58sycFaYTuarmvh57gkUl9peg26rOsCg6hm6qwnSE0A3zDETH4
    qFJANww5R5H1t4plWEz6rQwDZGlM/NUkBKgg3AaeEmxqxi8R3taSh7oW/SGM40F+33CmG1
    bpSLP38OH3jQT69sSnIcHGi3juoqrTBo9iGzR3yThden7F+M+e2KnP3cReRkOqiiMRrpFB
    TXLW6kEADmKLtE7S1eJQ4oOzzynxg5Wct6yRJqzDSjePcucQKjGXV7T6P4eiF5q8UfAtBU
    CKijYdeaVn4ceP6041bH24e/KAIs9HAC+/zX+ZNLgDVHJQR9RuD4tyxuOm/Q
X-ME-Proxy: <xmx:LJUEa96hS3tB5s8pEjtrwGGgKZlvhWUicqekXyEXrzDgYgTqC1O38Q>
    <xmx:LJUEazijlya1UOhp9TupqaJgISdEbzJT12X0JP2E-3__37QytMNfKw>
    <xmx:LJUEa76hualyLnEFoNny7OfWe2QLSxAp4oaYATdYAqHTm0iC3oUKhg>
    <xmx:LJUEawGtTbrsbQNGfJKr6cI7jFcelSduXU0v54wB4W3Uc_LuNW17Ug>
    <xmx:LJUEa25B_15VKEUm7k_RAGXe7IiXvwo9LgAkqdCMnRJ6yZN-1ADUTI2E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 14:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jeff King <peff@peff.net>,  Toon Claes <toon@iotcl.com>,  Shuqi Liang
 <cheskaqiqi@gmail.com>,  Karthik Nayak <karthik.188@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] use size_t for a few more object and buffer sizes
In-Reply-To: <CAP8UFD2aRMn0CiPNXo24QPrmaWykQ3GuNLfOD_KVjkBmFS+q1A@mail.gmail.com>
	(Christian Couder's message of "Mon, 23 Nov 2026 12:48:35 +0100")
References: <cover.1793439137.git.gitter.spiros@gmail.com>
	<20261119071217.828481-1-gitter.spiros@gmail.com>
	<CAP8UFD2aRMn0CiPNXo24QPrmaWykQ3GuNLfOD_KVjkBmFS+q1A@mail.gmail.com>
Date: Mon, 23 Nov 2026 11:34:03 -0800
Message-ID: <xmqqeccb5olw.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

> I just reviewed it and it looks almost there to me.
>
> The code looks good. I suggested some small commit message
> improvements, and possibly adding a few tests if we are fine with
> accumulating EXPENSIVE tests (which I am not sure about).
>
>> Two other series of mine are waiting for it:
>>
>>     https://lore.kernel.org/git/cover.1794984184.git.gitter.spiros@gmail.com/
>>     https://lore.kernel.org/git/cover.1793524457.git.gitter.spiros@gmail.com/
>
> Yeah, a small series of mine also depends on this (and duplicated one
> of your patches), so I think we should just merge this one after a few
> more polishing rounds.

Thanks for reviewing.  Good to see contributors working together to help
topics moving.

