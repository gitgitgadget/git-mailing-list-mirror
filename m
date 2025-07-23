Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CA1DDC1B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291033; cv=none; b=NFb7oAitLADbzDI1eQC2p3ptRawGE/pDD0xUKCyT8vmbz7cn7D5enp9NBmbos+0Nj393zFc9JQrWLLe0/kTOs+4W2o0NXTshjU9qijgzHSdRrRgGS6vFCO9m7OVX714QGoseBf4Ogqvq/D2/jsvwE8Qk2X3XBy++nzbWq+SFxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291033; c=relaxed/simple;
	bh=+O7awCKLhetZ4xnNtjaKpnw+el12XYJlOh2SK81fQbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N74s3tSKrqjPQMSJg1KKWIQcFme5CkRbI42fxxbOnDCfLjzNpdX2NBgmV4MVkAOj5HtTU6s/SQaSbFH7bcqXqe/REdzUUcohzT0pzYbiTUdeqSJFD4oBGi1ZKLM+brirUoZZFbpYQDaIeI4tjO2m+51negAoGXZgbBkJclwb6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IatWMswn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXqg/ngN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IatWMswn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXqg/ngN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 57073EC02F2;
	Wed, 23 Jul 2025 13:17:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 13:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753291030; x=1753377430; bh=UqtyO5rfKZ
	KMv32+Yh8ZCUmPC2QCXCljC9ZnKOyV1xI=; b=IatWMswnDqbeLlPVSxMKBMHZwb
	GOB7m1L8x9liO4SYm8nmwXnWkxnVvVv47vvtyX3o8cdy2DrXT3gZTY8+QwjawTUp
	OJkQFT2vPgt/+7PWUQZ5js+M44lwLB6tYw4H3QhO9YENlsv+yqv2RiLYdXNxg1Ud
	pnPdV0eV9JhOJGjkLPxDGU/dK8/NSHo1yr/dlkNiHhma8nCv8IDBd/iIebmEDRs6
	xsZByDIByN1snvqUtz5pS+YaPl1JCmMUDqLzqbZ9hxvZhOZPTKC/K/DLFyyyPgsM
	LzdgAGlt+gqyUyGtLfm9US3oGsWmksv++r+qYT2Oq+8QIzAjZv7/MwuiZJlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753291030; x=1753377430; bh=UqtyO5rfKZKMv32+Yh8ZCUmPC2QCXCljC9Z
	nKOyV1xI=; b=QXqg/ngNUrYIGrdtBRO6RdvgCf7YiKvfGlDB9XhGF5lJ2NVrnnC
	OAIxM+QuycjS3X+gHMRbzxHcjLNP0i2SwmPjUvNddo7BTjM3/39CngOJv5mzC+yk
	MxYq1x6i7QFb0cHfVB5c1odVGQjpF7+ZnmsP1dLAIkOpvlQ59rpJ14hRTA+WdaeB
	p9lVa+8V0IqCpXXvVunn0mYdqUWuxR17Q3bodYoQePvohTmlToGA4J/xDGkk78el
	Xao7vPOZGZZp7c90sSUignlepyfvRBoW6uEhY8LYffeDIo5x6B6SfxsOdE8P6fdt
	QvPCZD7Ckqsg6qC3tbJFTu+W94OYDdKBJCQ==
X-ME-Sender: <xms:FhmBaOgCVoyfRiiZ3lSKMhlvWYRCn6xwO6qgxYhKno5hlTrE7XmnwQ>
    <xme:FhmBaJm6BVOHu7Pc8iaBvy_4jJBfqbNnwcJHqrHiB-GX2n8d3JvM6tAmiP9xscLI5
    nPAiQ6Lq7oPc6vVPw>
X-ME-Received: <xmr:FhmBaCr3QQsVSGzvJ8RNsw9YpTsyU8WpLx9LaSuapyPcFyplA1ZevfyKtbiizv4NRVscwduh0Nu2HJMhxTMpe_iULRwTEDc5iWOAFJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:FhmBaKEuHwNY8XazGMUoQ9ojpQ1u824DJBtXQgjBDyNUlnk-R-MrPg>
    <xmx:FhmBaGzOLUHXgDMsRqiJujjRpdV4gp8NSbfa4LUp3F9ZJ8nBf461zQ>
    <xmx:FhmBaHr_cGMnMd9Q7eBrLyXt_LUPVOI2nCyGVrlfsroTQ7iavsS-Og>
    <xmx:FhmBaIhJSUg89gjKxG3N6wZcJ7I45VfP4yxGQ349XSU30U-HVQrh9A>
    <xmx:FhmBaHT9k-Fzx0XIp03Zc6inCdgDw2rgqYRQL1soWjXRE0x2AQ28EK7x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:17:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
In-Reply-To: <f1d3c903-b7c6-46b2-b911-0ec8c2708c8c@gmail.com> (Phillip Wood's
	message of "Wed, 23 Jul 2025 10:40:23 +0100")
References: <xmqqwm7zpxzc.fsf@gitster.g> <aIB0lUS8OTq-oPw7@pks.im>
	<f1d3c903-b7c6-46b2-b911-0ec8c2708c8c@gmail.com>
Date: Wed, 23 Jul 2025 10:17:08 -0700
Message-ID: <xmqqikjiomi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I think the only commit that really needs review is the last one
>> that
>> fixes the sign comparison warnings. As long as people are fine with that
>> commit I'm happy to have it merged.
>
> I think that commit needs a re-roll
> c.f. <2b914b60-3417-4a49-b545-3109c9a05257@gmail.com>. I haven't
> looked at the rest of the patches but I like the general idea behind
> this series.

Thanks.  I looked at the rest before marking it with the "next?" label
and they looked OK.

