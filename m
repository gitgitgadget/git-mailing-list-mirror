Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1E10E3
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193040; cv=none; b=RiJZ6RwDQB3lN92sruKOaMIKuSMlmAD8Pj79yspd2PhF7+aKLSV1bGaXAnlYmk+hvs6xO5JIEz6X+iJcMMy7yImcmaxirWuNc+fBTawBPmkD2lmQMFABLQ1VxiYd6G+isbWFCHGq/ULq7Omlb6LC18q0FZi+QrqAMZNXJA5tbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193040; c=relaxed/simple;
	bh=OpJ5D4P5o9gbjXsKm56aJbDhjPcOHdL65g63okofL9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twFiIHOx4D8ckzaARTGbeckeOSkvcLK91yM6BbwXqpVsAbDSdeCUd2LnhqVTC8Cz0+JaP7aLUy9aogYJeOSPm+e2TvSNQQqOBSi76wdg8V9HSMLfyOSLa+XUDetG2L+vvzEHcpkKnfaPpG6nzKgLLV5bszND/FnmUe8+TeLlRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+qNy6wi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+qNy6wi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C57EC11401FB;
	Mon,  2 Dec 2024 21:30:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 21:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733193036; x=1733279436; bh=LFtDwQ1XJpVLZuyXZ4j0oISLf0SsDfH5DNT
	PDALquDc=; b=a+qNy6wiZ+AXVs4oEgkEE+JRQo/IbmTYBv60/ztUUODAqf3/ZmY
	ycLrNX+lqVy9mYU/CambE4FS8MFwKlWgFSbccRiyKUqnCdUJ4KWUYIKrQUQ2Jyps
	DN34xHKzw0TTdOQ6spf26dn2IZdrP3y+wbj8SOOt1e3y5OD92WC8+fwk7eZEPt5r
	pcIhX460jQ0pMpYJz+idnyqvgX8XGPol7NWupNPSVLJj10x/sMdDtpyBdEI9KFzX
	mCvLuoMkADnpE6qCG5P0nZmsqIXKEH7+SnWdU0wLafb6DK7H/xTuEwVBC/9S6oi8
	lf9GuVNN4N1qws3+30+3pbwftxC2T/uTBaw==
X-ME-Sender: <xms:TG1OZxtNwqAByN-R3WExYGCZXnK_bZmHIRf3JwzNO_wCBGRzhuHXYg>
    <xme:TG1OZ6cy28qUlRYlIYU-GH8nS4bsWHfAwl_NX0rM386gv7PlrvCPA_3wPNvQ9-f-R
    YywiadDS2YIOvdzxQ>
X-ME-Received: <xmr:TG1OZ0zzKsqd3-vHBPF7YkbpGJoVWF3sXodvUEQzkYrt5OK1De0-MyUU2xO-nLigX6RHtHBhJBqhvQWodEd84iRP6FqRre4rzJ1twZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnh
    gvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:TG1OZ4NL0yEdUkSztWeymxaz0FHoDqz_8fNYBDu4yrH7556Ly7a1OQ>
    <xmx:TG1OZx-d1q--9qK-0FVzAAS-Gx2R8R4DtEPebN6Eg14_FfhsJVDcXQ>
    <xmx:TG1OZ4VcBeu2DUCkkrfR2iBY-M7eWIpqWYeIVVFKsp4BLYdeYP2grg>
    <xmx:TG1OZyd0ofX05xsWIyW4dI-yyuHgXy-Nha3BgLaNP9ceRFvbJ1gEdQ>
    <xmx:TG1OZxwvmRGQhn_OP21tyOhSR7aoX3HZG8q-nfPXGoeTJ8Ov5OcANKV1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 21:30:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Eric Sunshine'" <sunshine@sunshineco.com>,  "'shejialuo'"
 <shejialuo@gmail.com>,  "'Caleb White'" <cdwhite3@pm.me>,
  <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
In-Reply-To: <025b01db4526$3b05ef00$b111cd00$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 2 Dec 2024 20:53:57 -0500")
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
	<xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux>
	<xmqqed2pioff.fsf@gitster.g>
	<CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com>
	<xmqqo71tfsif.fsf@gitster.g>
	<025b01db4526$3b05ef00$b111cd00$@nexbridge.com>
Date: Tue, 03 Dec 2024 11:30:34 +0900
Message-ID: <xmqqiks1fqgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

>>Ah, yes, that exposes (and has to expose) the worktree ID.  It still does
> not have to
>>be unique across repositories (only has to unique among the worktrees that
> share
>>the same single repository).
>
> I might be mistaken, but I think the intent of the worktree series being
> discussed
> deliberately wanted the worktree ID to be globally unique on a specific
> machine.

That is my understanding, but I do not understand why such a
uniqueness is needed.  Repositories are not even aware of other
repositories, in any sense to make it matter to know worktree IDs
other repositories are using.  Until there is an attempt to link a
worktree that used to belong to a repository to a different
repository, that is.  At that time, names must be made unique among
worktrees that belong to the adopting repository, of course, but the
names used in the original repository for its worktrees would not
matter at that point, I would think.

> I might be wrong (hoping I am). The original author should comment on this.

Sure.  Thanks for commenting.
