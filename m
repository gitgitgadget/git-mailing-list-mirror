Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077021DD0D9
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789662; cv=none; b=pcnCuVljlbVHTGb21aDTVY6ZLIoIS5iXGRnJCWv2CX96oXpyFJFMz1eDSxqgj/1v3DWxGjd3wUctQSUmEMgw6PiBFdrKDtnPuSOCuugDtJXoyeMS5BGp1x2L9ehIRPfW51gvTc67QkK2HqLxHVbcPexysg9T8nnxuSg5BZOdLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789662; c=relaxed/simple;
	bh=JpXC34IaopANW2OT3E4GLyCYQwJ2Qlhb1I2nGeuFCVI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DTcgeVVY1IPFJLNisEp5SSjqLHTHvuSs39ceAuM82WFRtSFI4klw56oi1HtTGmEjp0zNeb3qge9GCcqRhSQohq5Bj0a6X4gZGXQ+/X7J+LCSFzjD4bnhA6kxeM9Eh8EXCS9IHXG3qJyZ7MAQZnvPe2q1xZJyJkcn8KxzoJFgNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rDytNow9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Owkfigxg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rDytNow9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Owkfigxg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0056D13802B8;
	Thu, 24 Oct 2024 13:07:39 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 24 Oct 2024 13:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729789658;
	 x=1729876058; bh=hUaYiw/jfCX4qSVOvY8POt1tcMXDAwLlRLKGiRhMJNY=; b=
	rDytNow9Va/DbLVPU8YAc0bJ3kv0Wrsk8FwXlHcx3nAtCqhDb0Hq6PKBhV8g8qcW
	4t+botlvOA5PEGeXIkzTa3QfxUOY8uSye2kYy3uzCQ/xZkiWOrqnmiY78EvZTzC2
	lHnQPJX+dMm5jqMOJqffhUmGHfSb4P3234Ly0t0qlnuulmHEcZrHOtO1UAR+ouic
	1X7+DKGMhEC4jAHXRmQ7MrzX+nnURLn5KNVekTAVytyXEbFJMxqSr5UQwXiKcYVl
	Cd/DY9aZzMQfppfORl8PRkundcM2CnZBItQLhx8Lxpjivo3o1kPl/az7u4y1ZHw4
	9VmdIsDQrKXLT/Qg8Hv92g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729789658; x=
	1729876058; bh=hUaYiw/jfCX4qSVOvY8POt1tcMXDAwLlRLKGiRhMJNY=; b=O
	wkfigxgumEFUTIDfJBnuIf8Y1RucPYgutVCfd5LXOgVBzh2/FO5tluo9RbvsSzXa
	BwE5UNWheLUiewt2HDCgPfrJjHtbVXShd4zI3QwydgxHv+hT4rwoX1NS6m2bRJ/t
	kjs7xTAIUk7Satk9IaEvn+C7tBbFi5jJbTOdNpL/ZTWcpsjKIYNhEOpQvV3R9wD2
	ceL68YfA9ni4QFLrrXmDGVAvfUSJbkUAARsOVWhXiWtURfM91etr1ukwZwUK6uCR
	pTY2B2R2k5VIxnbnZWFdQbVuMVVKUQEhKDjpr+ouIt+UhLbdFMV3g2+Vw5X5UqMb
	NYGt3A5U9nBFXXBXW+Zbw==
X-ME-Sender: <xms:2n4aZ5_hliudw4NhataY12DKVv040IV--JfLBPuY4-HbRN1lzhywRAU>
    <xme:2n4aZ9sGfUbMHq_eE-1yc9YUfLqcZ26x_coGbuL0T3RKXgRltny0FHzCQANl75UuU
    OIS0LgWWIi5Qmr2zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfeg
    feejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2n4aZ3AFqYqENy3CK_ZXUalP9ZAZp7ulympBgBc4XJDFIYNEiTbmjg>
    <xmx:2n4aZ9dc_Uxk0HZGXqaBRQMDqAQvrMzZH4jJvdGzpAdyFNReYSguig>
    <xmx:2n4aZ-N1wa2f8vBWK26R9aLt4euSt3zkFxAhrahHRrAhz5xfy7PhPw>
    <xmx:2n4aZ_m_c9Og1xmR5B5K2gV-ebzeJMF-7CdRQnnTrnwk0Nmv-5rejw>
    <xmx:2n4aZw2MvFiiO6xQWuG5I5L8EUG1RCyBWGlAw_B8DNyDSen-s3YiSTON>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ADFCF780068; Thu, 24 Oct 2024 13:07:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 19:07:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <35e4259a-d442-4b8f-a986-412e04a64770@app.fastmail.com>
In-Reply-To: <20241024114721.14270-1-algonell@gmail.com>
References: <20241023170111.6638-1-algonell@gmail.com>
 <20241024114721.14270-1-algonell@gmail.com>
Subject: Re: [PATCH v2] t: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024, at 13:47, Andrew Kreimer wrote:
> Fix typos and grammar in documentation, comments, etc.
>
> Via codespell.

Nice work here

> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Just for future series, I think crediting people in the commit message
for minor review work is overkill.  =E2=80=9CReported-by=E2=80=9D in par=
ticular is often
used for something more substantial like finding a bug.

That=E2=80=99s my impression anyway, mainly from reading this list.

--=20
Kristoffer Haugsbakk

