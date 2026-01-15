Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880A3ACF16
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492245; cv=none; b=JlT8hmigt5HrRIjdV4Z2po8wQg0eS/Hu38ZliEBJU57Z3BbXfNlBPZLYIi06J2knCa83PWf4rOR7k/NER6XYhobuMJzgnoDlX4RtDhpAG1S1JWu8Zm/S/hH9XKrVAx2zzTkmLOj+6nRVYv1olGe6Yx5KPkdEv8dYF1soEUJ3dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492245; c=relaxed/simple;
	bh=DdTgggm0mpNG/JdlbZi3M4TSyGNZ9mV5Oj2/UdbTnqw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fxKc4JqjBHRXi/ULoYvh2SjdHf9lICivKMZiJSy75M/VLXtuxCb3+axv69cR7C7vBCJDT87dpDqLC06RMe+XSh7EL9iJdbl48pxomZIBPXTgYYbQ2i7/E7zrFNcWwkKFBe4ld/sBnkVRWFAy6qY8Z6iBADEHJNrt+4IZF6G5UIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CYkvBMDU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSvPxZSv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CYkvBMDU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSvPxZSv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2785D14001D1;
	Thu, 15 Jan 2026 10:50:39 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 10:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768492239;
	 x=1768578639; bh=xdc6JimAEfpj/Vh3fk3Igq2ttH/I6HKi332zK5uFW9Q=; b=
	CYkvBMDUHU7N3jMoqOFfacJqDyR9S+T+rNqNPos2wA6xjGrYVSIcABoP4YF8+cAp
	kPwOUtiB6G6VpsSxAvzRg4988rcO5k6KSgk+LUBb4qrzgeqFo0lIAH3Wo0pHSdfP
	zyEMGuXXfEbEjXVDNB47Nm4JPhcPvr7xCCUVLeYmI/T4i3oOWLF+GCVBGZpcwMdD
	Kg8mwX5YoQPlR+TlV6NNChxfARENXGaG8dDNGg2W5tC8nE0fErHtwMyHnmZKOHeA
	KWWRyAPeXeMpb+j4VOTtDrK34Lk3H7unhGXeFP7cekw6B310yf6Gp275FRtMkibn
	XAe+pBrYFvcBtSYr7NZqxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768492239; x=
	1768578639; bh=xdc6JimAEfpj/Vh3fk3Igq2ttH/I6HKi332zK5uFW9Q=; b=H
	SvPxZSvMP0udgtsbLZE34Y+fczAgfEBlR1+1FTyeR4rMhXrLWJHDfY83eGVw2rv7
	LrkwPBKIDAnhW1KXumbMUNQ7ERRHu4DLbJ4djxtUBu7qwBp8E8vMXvXZznKBTMOG
	+YFZ7kg81O9fANS9D76OoCc4zINxdGwLHkYrQybXFR2cTm3GGHQhpeWkYyV6R9CR
	v6KJQspNqQQMJZqC0+wbLzxWcqsRM+V0ozhzys+/eaW6nCMivwH0+KDpcL1K2wjg
	ibJVRJPRrsnwhoXExhkAO4jrW1lJzsa/Gu4E+frhVEzgfHG8JNGLbPb9YSlhMjO9
	idhoF2cj9WkZ9C2GFhR5w==
X-ME-Sender: <xms:zgxpaTrBFV06qm1H9X_77jm6Se9EGDzPe7WvmSDBUmzqm2-vMyer4-0>
    <xme:zgxpaYc15HbvQwywtxYGaaO_yJI_BCkjY5TrPLr_Wn1iUJrU6tsOXmRSL2o9DjQUF
    ttW00bsdRg5fvbcDQiSW0I4uKpA0jeavWPcFQxmccPYR1Cs01zQIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrmhhopg
    hpohhgrggtnhhikhesthdqvddrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zgxpaUQsJExK8W9aApavjkJMegkcmqZ1WK-jiBTpQPpgHc4GpmZmkA>
    <xmx:zgxpafn--4pxvMMwsqGmyqLpJJTO2yZJn80ZZ9gDn_2wDDlTOVF_ZA>
    <xmx:zgxpacR7LD0n7hFKXVxe0JTPSCBp9xPurdZzKqLzW3mmd1oJtacqHw>
    <xmx:zgxpaVMYaWKbvsTM6OgGRJHRFQkqH5q9JCBojKlI-2xVxwZMGOs9pA>
    <xmx:zwxpabGs1C20A91ACPtpzni6XbPjIefrJ6T8xW0VdAGVvrdDiVsysNtg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A9D51EA006B; Thu, 15 Jan 2026 10:50:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-CTF6ntJZYN
Date: Thu, 15 Jan 2026 16:50:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Samo_Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
Message-Id: <11b951ab-b624-4ab8-b7b1-fe41a40c9d0e@app.fastmail.com>
In-Reply-To: 
 <e79ab6b7406e3472ed8816131d4e33f7d8e696f2.1768022018.git.gitgitgadget@gmail.com>
References: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
 <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
 <e79ab6b7406e3472ed8816131d4e33f7d8e696f2.1768022018.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 2/2] shallow: handling fetch relative-deepen
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026, at 06:13, Samo Poga=C4=8Dnik via GitGitGadget wrot=
e:
> When a shallowed repository gets deepened beyond the beginning of a
> merged branch, we may end up with some shallows that are hidden behind
> the reachable shallow commits. Added test 'fetching deepen beyond
> merged branch' exposes that behaviour.
>
> An example showing the problem based on added test:
>[snip]
>    ---
>    Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15=
fcdae
>    is not reachable.
>
> On the other hand, it seems that equivalent absolute depth driven
> fetches result in all the correct shallows. That led to this proposal,
> which unifies absolute and relative deepening in a way that the same
> get_shallow_commits() call is used in both cases. The difference is
> only that depth is adapted for relative deepening by measuring
> equivalent depth of current local shallow commits in the current remote
> repo. Thus a new function get_shallows_depth() has been added and the
> function get_reachable_list() became redundant / removed.
>
> Same example showing the corrected second step:
>[snip]
>
> The get_shallows_depth() function also shares the logic of the
> get_shallow_commits() function, but it focuses on counting depth of
> each existing shallow commit. The minimum result is stored as
> 'data->deepen_relative', which is set not to be zero for relative
> deepening anyway. That way we can allways summ 'data->deepen_relative'

s/allways summ/always sum/ ?

> and 'depth' values, because 'data->deepen_relative' is always 0 in
> absolute deepening.
>
> Signed-off-by: Samo Poga=C4=8Dnik <samo_pogacnik@t-2.net>
> ---
>[snip]
