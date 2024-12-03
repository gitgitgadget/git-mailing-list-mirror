Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7A15E8B
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189707; cv=none; b=R5LTgv7VblVT+uKxhGde1+pVydCa3Fs8ESnok714wr/uf7DqYj4oisZl2DVkYZJTXtvwPXUGwiilrtQ1gnUsnNB+vIm6TNrQlmImHf0S2qVrIY2PiW43wRf51pDEGod9smpZPASs1y5bGiSOacQBfmnGnkEWVs6iwrU8XXrWsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189707; c=relaxed/simple;
	bh=leXiIq7zxLwMwL3xfZP5+hObHN53isoyYPtLWszQnRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ONpB3LVxagcvmkqpPlkKMLD2Xalvfd3nJ00zwrvz0F9oQgCc9J2e5jzeFHUWG5dX6uXrLFGYJ5QA7zTl7zVygYiWW8XXBtUR5cPDLrGBzdIoSB40TAfD6Td6eMLgHOULPQfgP3w/7o5hn3moll/2OsAKpc8BQwFLWZ7RJNef4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=id1HFKLx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="id1HFKLx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 056992540213;
	Mon,  2 Dec 2024 20:35:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 20:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733189703; x=
	1733276103; bh=USbeRa4D/PgLx1G6ZW82Mdfjj9IfAKlQT1/Zy+DscF4=; b=i
	d1HFKLxlClGGmn/SwNjivr6ZSUl54eqCeF3jCtjV0S+5QkWdAyjeTUl9+gkYBUzr
	LJd7561G2WLH0ZdYxiCvowXHot94wsyradLyL35DMPwUGq0KayXKYBY+nH2YZYmF
	R6DPv36v2rVsCiDb+0ejel9+8QeHP7e25lMM2phT/2sVnNxrSDE07BIuOooaDgpH
	gXTs2U9xBwsp0J8zHyTBkPu30lFytuK2nPUYrtHZKW1NGx/CSpdoEoU6gHfYI8oi
	usoQABPPRam4iujoGY95er1F4jZezs5AaPlWgJRNvfJSf7jtYolVUzNts6emr0Se
	RDpXsYm07XAy3LGaUFR2Q==
X-ME-Sender: <xms:R2BOZ1eeOA1cK8J4iwh4vQt7q1I-wn8WSUHikwthHlDSkW3SWSFAYg>
    <xme:R2BOZzOxhzF5b_BSg_R6WxKgjlYsT2zlopIKqyqL2wIhNaDmPjC1Pn_yKdGkYzDAN
    1pG9fVB3yupjgFfTQ>
X-ME-Received: <xmr:R2BOZ-icXowhBa7AsAPqp3_qJF8QyPW8H6bbhBQpHLuNED7Aldnxdk3xwrINyRsJW6gTUVrhgBJCIiq_lstR4uhOjUjsroTbLFXgbJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtsehjohifihhlrdguvgdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:R2BOZ--qBOBgepblT0PJINd2uEVJ8uaISdkWdUw-dlYKytLfiaAu2A>
    <xmx:R2BOZxtGJ6b4gPXHxQbeePWUlxJZaiJ-Tyh-YNy2NyW_NBg2NqpNog>
    <xmx:R2BOZ9G3f5M131-CD6wnURmOZBq7lluNYKOjtmimf2PuBjAI9A2viQ>
    <xmx:R2BOZ4Ob0LGLbCwRzi1y1OvnzgF3V5bbV1k5xEjsMHzd_C35u6HRIg>
    <xmx:R2BOZ_VYplFVthRzhUmzhHa8GzNREQI4l7BY4-6T3OaSwiaE8vbb8U52>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:35:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org,  git@jowil.de,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
In-Reply-To: <ee2af264-8d4f-401d-893c-e08c30f5a9b6@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 2 Dec 2024 21:42:56 +0100")
References: <20241202070714.3028549-1-gitster@pobox.com>
	<20241202070714.3028549-5-gitster@pobox.com>
	<ee2af264-8d4f-401d-893c-e08c30f5a9b6@gmail.com>
Date: Tue, 03 Dec 2024 10:35:01 +0900
Message-ID: <xmqqser5ft16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Rubén Justo <rjusto@gmail.com> writes:

> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -97,6 +97,11 @@ test_expect_success 'HEAD is forbidden as a tagname' '
>  	test_must_fail git tag -a -m "useless" HEAD
>  '
>  
> +test_expect_success 'allow deleting a tag named HEAD' '
> +	git update-ref refs/tags/HEAD HEAD &&
> +	git tag -d HEAD
> +'

This concisely captures exactly what we want to see.  The plumbing
is still allowed to create something that the worldview given by the
Git Porcelain UI may not like (so that people can create different UI)
and our tool can still be usable to recover from a mistake of using
HEAD as the name of a tag, which we more strongly discourage.

Good idea.

>> +test_expect_success 'HEAD is forbidden as a tagname' '
>> +	test_when_finished "git tag -d HEAD || :" &&
>
> I'm not considering this as a test for it :-)

It is not.  If "git tag HEAD" get broken in the future, the
must-fail steps below may create such a tag, and we want to remove
it before moving along.
