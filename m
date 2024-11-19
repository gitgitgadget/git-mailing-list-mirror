Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2695139E
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976425; cv=none; b=mkFAyZ0y4rGV+g8/Kon8ZWXwAXLfvuBrcm8Dxxg49ooo5qGrnOheUDpuIeKhS8QUdynOByHQi9S1OffQtI7T8/6LvdkJODs5ef+dlS1nxvQ/hE1zcBJzAAstAw0aXG7zQI7baJ3T7W3r6I1BQrOW+7cGeYaGXL9qbGrfc04Hvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976425; c=relaxed/simple;
	bh=pDMV0exPG+Ks5RenSE9N4GGs1Lwxvg+qb2xxr/7OTnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fk8udRUzX0ZvbmwB7qFvifxFrU+2FdCBfom0Mjxy43PG5y6trdE1XpE8tmQWQFn6XlwrrIeCJa3MDEEA5MlnG9i1VKc70pTLfyMSRIEzdJx6gGpCWGAPYFS42IAtE9TZV/hWLGtWruoes2vnxjqUur0kw75ZXviaU8vMXFkfaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YuUsLeQY; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YuUsLeQY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9181C2540158;
	Mon, 18 Nov 2024 19:33:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 18 Nov 2024 19:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731976422; x=
	1732062822; bh=ap2h3I5pJr+ttfV43PAnInwxBPq86KexIRlcKlaapM0=; b=Y
	uUsLeQY4NJTr+CtZYXn4pSzvM0oQXOZAhWpvIaHWC7Gq/DYGLWEb6TDZ0NungclY
	MJxhpmi6zJ+vqeefcq0u8duka7/1a5ZqX39F0G3+pKw9fnPReA+e9pyL7yKzxZMA
	SHZvbbeznHFwAfwiZRTboYBFPShEX9s2VxPP7di7kIyDrCZkIv7tPIkBQ/D2XDHX
	ekIcTXLIJK438blanjAC7RYqzqD+JV2sOg+MZI778EC+9ZWtNQJM9ad8nbTLCUur
	G18fAmSgFDhDS+A5U+I+yAdHWDz1fx99co4wBC79qkrhhmomCMjrAVB8/o1+N4ov
	LA4Yz7+m68TJUPCgKLHJQ==
X-ME-Sender: <xms:5tw7Z1VW1nVt1ZM5IbZ3MgOFnLlrsSJotQPzwn_PXTfzUfyc7IKgrg>
    <xme:5tw7Z1k8JVJ7L7r-pi6rZ6FkgpJ3zjS74JZDQAK3UfuiZZ8G5Q7a0B1ey0kExwH66
    _AsVxKiMKFUi7iT5A>
X-ME-Received: <xmr:5tw7ZxYAfzUalo9hWpxx9ZVUGxbiCOo4jEcvi20ErAIrghjDIrRj7bjgY5oNhAfVNM7d0jvC4_iliIDbNrpt-HG-4Zh-qiIgJnUS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiphhhih
    hlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5tw7Z4U5Uk4V2LyKZlB0ldmZ0k02phdQT6i_2TSPQ-1MzdATmbdUgQ>
    <xmx:5tw7Z_m_j9G_v5M19fIUTwF-f-oyW8a_y_RKlPeHahM5x973KDUbhA>
    <xmx:5tw7Z1cPIcnAaeqVZl0gyU8l3_SsbwBfd-1w2cxnyP9_fGr45QTVgQ>
    <xmx:5tw7Z5FDrV89pz5jjV0H78miFYFD7p5pRk8YUyeDDEe6DWCW87VHfA>
    <xmx:5tw7Z4BTMxqqj6w_XZ4b8UG0XTQDm55qlHah_FIVKrE5thC_u1s9KvSL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 19:33:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
In-Reply-To: <b09b16f5-4fa1-c802-86ac-9f0b1bcc9f53@gmail.com> (Philippe
	Blain's message of "Mon, 18 Nov 2024 14:28:41 -0500")
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
	<4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
	<xmqq34js1kd2.fsf@gitster.g> <Zzr4cgk_5MJNcHm1@pks.im>
	<xmqqjzd0k92c.fsf@gitster.g>
	<b09b16f5-4fa1-c802-86ac-9f0b1bcc9f53@gmail.com>
Date: Tue, 19 Nov 2024 09:33:40 +0900
Message-ID: <xmqqh684hxjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2024-11-18 à 07:42, Junio C Hamano a écrit :
>> 
>>>     pb/clar-build-fix
>> 
>> Not all that urgent (it is not end-user facing).
>
> I'm not sure what you mean by "not end-user facing".
> I ran into this issue while running 'make -j -l 2.5', 

Anything that needs to run "make" is by definition end-user facing
in my book ;-)

As I said in my reply to Patrick, I am primarily following the
decision made by the interim maintainer when the fix was queued.

Thanks.
