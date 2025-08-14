Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C42FF64E
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132122; cv=none; b=CcLLNenDfs8Uj1yPrHhf+C4yp0wsyB/zNVISLIZt+plKxY0NtVLWZZJNAYEoUczadn6n3woCrJAUul+DSKexqugVesrCE3SInYOVs7VjYb6sGnwcb1OamAryqljAc/x5EhQFzgltKiRcsFdNcW/1xkPZDL3EeQSK+IlRjRjSl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132122; c=relaxed/simple;
	bh=gbmC4dXunlsu0lfcXDwP27y+woA4EXaanGS7qCjUzz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXhPavRYfvhfeq7cqVtFIqB+rNZdXuLfID/52LLOAr3ywsoCxD0S5Sl+QzdC+P6gz9jZwKU1QihLIwusT38ll0RJhkILGBx5KihVd7JVyqCvAryXutNWUPljum3teymZ3KASGwSXVqByErZvsh+drldkPEWSdgmWvpmVjuevoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKaxSnh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpNjzLg2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKaxSnh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpNjzLg2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 45AE91D000AC;
	Wed, 13 Aug 2025 20:41:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 20:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755132118; x=1755218518; bh=ZLBH/w+hDn
	lnDTHynf/Y5KRjjSFP8OjB9gvcLq1LHAY=; b=GKaxSnh58T8qnMsbIfUwNt3Lox
	dukKdpbD+DFQA/X0Tt4PJjs5A/m+ZF/iFRLqyfZiS1epWzQO7rYJBLceCboE2cqA
	/2lfK4NhO2idogXd+C+UtT5VFgbkZ4EP4eqygLGbhcrTbqZIPkGzbwOinFqTEG0O
	HXDxX5rqA7F7jGK1saTKjM07+DdVP3uRZNvAjhR3HhJ1PVCHrv/jJLBtebDo8HuG
	MOFSvpbuVVJHSdqq6OserG7psm1ny+BClJNof0OXcQCk/DD0JNCnv4oEu3WsIl0f
	WpUFuq5droBqRY4hCSnQQo+BL/7kUdH9v4UcOISlkDBnPJ/HeAejUazjmO5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755132118; x=1755218518; bh=ZLBH/w+hDnlnDTHynf/Y5KRjjSFP8OjB9gv
	cLq1LHAY=; b=HpNjzLg2NCeP7JMNNEisTnTPA+aM9qDMC4wUNXLpPnj2eBNl2Gh
	4OjtEj8JEcg+nWJ/X/s5zeJ6sso5iu0dZoieU9C3qckvuc/4Po1w0uAtxnj+sfaF
	x+mHU2Dv4MTsDVMT4Uh90JUTn5A26p9lPiYWW/71E6JBu6+HCAgreFgN6my4VtYv
	o+WkciV/g7/iie0vqxsACU7TcVF9KNnrjCQPIONiLA/MF+9I22WDehU9lxI8Zbpu
	Hij66PF2uEWNptNaqZ/unp9Io5EgNbGDYulrQnFrkfCmO8vqC++gupTX69w/PxPB
	NY4oMOnYwoRSzUtChMDkAU4VbbzhT6dY6gA==
X-ME-Sender: <xms:1TCdaDCTPBduiP3FbbAYsPiFJsiJg8Wj9jaywTwbatQplQfXTcPhpg>
    <xme:1TCdaEHZMQ_xzg6y86AjECXlRrkSImjbbKHrN58THrz1dSovheuhw99I7iSJGghNe
    IpiVBHZx1PbEeGEPA>
X-ME-Received: <xmr:1TCdaLL0dcDGUVA2F2jPRPWOj3tNXx4zA1lqoJW4khOzMz4sManpgKhZJ1i_jfviJDLO2NxaYdWuok_t-tXuZmHbpmlsdCa_vLtoWSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:1TCdaIlRaonCFeoCzswYJKPsKna4uPxTLJaRaCEmapmlviI88c7ziw>
    <xmx:1TCdaDQbaE7ex9G5JqrmwoC8MByP6B_fqnSZpttbNcfWoHNbnqHvkg>
    <xmx:1TCdaKJgn54AaVlIh63NmDcg4ELWtIS6OdfEYn-BS7_OMdRyGpX1Mw>
    <xmx:1TCdaJCXMmf31uKhBrAw5X8AOaR__IjiVNjLuW-L8n3KVaANrvpyug>
    <xmx:1jCdaPw0ER6idW2GsNye_qo0OV87rASzzDVEOxGgfcFWAITPvuXY_GCJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 20:41:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
In-Reply-To: <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com> (Julia
	Evans's message of "Tue, 12 Aug 2025 17:40:19 -0400")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
	<xmqqbjoks19f.fsf@gitster.g>
	<152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
Date: Wed, 13 Aug 2025 17:41:56 -0700
Message-ID: <xmqq4iuabup7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> an accurate description. I'm always especially interested in the practical
> consequences of having misconceptions about Git: for example (and maybe I'm
> convincing myself to change my position here!) with `git mv` I think it can
> become relevant pretty quickly that commits are snapshots, because if
> you move a file and edit it then Git can't always accurately guess that you
> intended to "move" the file rather than delete the file and create a new one.

There is an easier-to-understand example.  If you pretend that you
"add" series of "diff/patch" to the index as you repeat "edit &&
add" three times, in the mental model of the users, there would be
three set of patches stored in the index somehow.  It would be a
fair wish for the users to have to be able to revert only the change
you added with your second "git add" while keeping the first one and
the third (latest) one.  You cannot explain why you fundamentally
cannot give them such a new "feature", until you admit that what is
recorded is the latest snapshot and earlier snapshots are discarded.

Another thing that the "collection of diff/patch" view probably
harms understanding of users is merge, which is not a set of diffs,
one for each parent and the merge result.  Of course, as a merge is
symmetric across the parents, it is not diff between the first
parent and the merge result, either.
