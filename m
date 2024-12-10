Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174C230D24
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822464; cv=none; b=qWPHgnRMdDIdr+E6prHNTSESc/KHCGjN1vxYfRvC7PAoYypCoeO5oNkY7usKlBjMjymbs3oyuEg2hSBxJMJOxG1AhTCO7V9Ec6a2Nr0Q0r7NlJTLXcmp/iyKmBjVPpDBxCkxPqxM3+XDDpWhh2Lubd1I1VM0mKvWJy4h0TqxRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822464; c=relaxed/simple;
	bh=5DFjL1FIO+DVANxF8lqizJi/3o9/1GrEL7KS6EKaymU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HGDB8ri+OHmk7iDe9ZH2EVjiBrSFQQFzR25XOXrMK1zN3jWv+UbyI7J5acdT4l94hGbiSnI2LcCWV49r6W6auWfFqCem+/v4CQV+9l5CvixzEsp5d9AgEpCMIEN/qfDRZuwyoBOUGMLRcT+vjJVmmH3B/mW94JMm505r5Zklq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ryrxsUqS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ryrxsUqS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A0F19138416E;
	Tue, 10 Dec 2024 04:21:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Dec 2024 04:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733822460; x=1733908860; bh=n4gMWFPu+TtTLagiR0WXGdRqMTXlWYaIArx
	lsrsIhHw=; b=ryrxsUqSgZS1ogv4bt9nndMLVm/QhZTIpgGhdJhWmWE/nXnTYxc
	p8d1Rz0W8mygtwJJ/HfemmN6L/Xsdo6qEdhkYOLmgcBj74UHYdOk2ZmBTx8KzGrJ
	h48PY/dGe2P4JHs5l4QgLU72TACJ9Xa/mHarZRDmsEb+wXA5sJkX3i+1moGG3H6R
	Xe0RaLifIuSFcNslVUJmPYZj12eWWusU/2EpEXfjzulMgappGMfijuNyZ3o8i68h
	m60h7z5DC9kngPLb8DAQc1b891rCM+cyBdOMs2s/IG5TsvHD+ST35nVNs/TDcxmj
	uIMb1m/wheDF3pDacxNSGq7heolP/Em2NrA==
X-ME-Sender: <xms:_AdYZ4MYg3jpZXM8G5a-X1K2dpNqdhRX4JGXUcN02I0mlLWPYYqbTQ>
    <xme:_AdYZ-89kZLyUJ9TN97c64Z16UdBzXQ2RmYBq4T7A7AJ3jBYcbVKrRSn88V3QLih1
    PMgA6wlo5IMPDZleQ>
X-ME-Received: <xmr:_AdYZ_RwMDcV34xAjELysw2a-hHHaflMp2TPXjmybjk_y1h2dKK5R21f7SKYRS8ePWi4_DbkntDrnrvL0BqMUbWsSMrVDtkU-1m1dFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    hlvghjrghnughrohdrsggrrhhrvghtohesnhhirdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:_AdYZwu87gKmFeExqvGtxiY8O4Vo6IAfvj4yIGla7p11upL1NNpNxg>
    <xmx:_AdYZwe3_9xxxHC1BwOGIcHDx3nUs2X8Lm38aXVnn48_LlBagZL3Xw>
    <xmx:_AdYZ03UqySO7r8me4C8B3r_KGd2zVl3e2Y1RvlLJwGR0BvGeIWH0Q>
    <xmx:_AdYZ08kgO0OunVTZwEKIxEgo9AmKPm2U8ik1NTNE4MntRb1TjyzrA>
    <xmx:_AdYZ4SkQ4akd3OnBvIl_W2ThTRs6n3-BoB13d90Y61BDGrDWO5Hiba3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 04:21:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Alejandro
 Barreto <alejandro.barreto@ni.com>,  M Hickford via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH] Document HOME environment variable
In-Reply-To: <a337ef76-096b-4995-ac06-d1be3b34750d@kdbg.org> (Johannes Sixt's
	message of "Tue, 10 Dec 2024 09:01:57 +0100")
References: <pull.1834.git.1733771894867.gitgitgadget@gmail.com>
	<xmqqwmg8mnab.fsf@gitster.g>
	<a337ef76-096b-4995-ac06-d1be3b34750d@kdbg.org>
Date: Tue, 10 Dec 2024 18:20:58 +0900
Message-ID: <xmqqv7vrlwqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> Just out of curiousity, is Git the only thing that uses $HOME on
>> Windows?  Or among may other programs on Windows that use $HOME, is
>> the way Git gives a fall-back value out of these three variables
>> unusual and deserves documentation?
>
> No Windows native program uses $HOME. Only POSIX-derived tools would
> consider doing so. So, I would answer your question: yes, Git is the
> "only" one insisting in HOME being set. We are free to choose how we set
> it, and the way we do it makes the most sense for Git's purpose. It is
> certainly useful to document how we do it.

That's perfect.  I've marked the topic for 'next' already.

Thanks, all.


