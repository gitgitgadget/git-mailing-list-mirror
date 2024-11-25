Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550E63D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495197; cv=none; b=Y4JiOO/VPwY46adM2/fUE27jVhsNS1RrI8eTNy/9WSdhVvNs1vfu6nH6hG/6gFX9DTxbP2KFCcW9Hr1nvj+w/z7E/SDa38IFiLfMdaMqXwHx612zEsQdCpKCF2va4+JDVPO4pctxt4QexxLBCMhHa5M3f0C18yGWuFSok9FE9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495197; c=relaxed/simple;
	bh=qadNTea8eJKGqpzf50F6e6TWxMcb8AWLDOklxxAgJWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bm5SUlCSwO8ryvFxPU38W8HXxZhLp0QCDmFh5r3/EYIcwlSpnreAC2r+8VCHI1LijleR9sSfYhcaoZzwVEbk8vz5s7thyHSimEg3zTlKIzeu/J4bNtqMlbKp4+6ldyf75kRdopkYAhS8XeYYTQ8GKRB992LNbSzh5U3jCE/jjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hsa/74f6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hsa/74f6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E8081140134;
	Sun, 24 Nov 2024 19:39:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 24 Nov 2024 19:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732495193; x=1732581593; bh=u9ezfYOLgUw+UsTXJ1HaAmbiRSbITyuAn41
	6TmMM9VM=; b=Hsa/74f6D/+minwuW3ARfgcw2k2XZOM0Fy7+qUVeQOoWClGq2GH
	JBi4dHCGCRobUnCflKHNfZyyIUFVm4K5ph9Lo566PKCdafHTl6pvL0H87gIHmQ8D
	btH9T0FM9gE3Pm1XjvxKj+m9fMMS46m9nfFsiD/CoWDLPuFMgoEPsjVaQEV60CpC
	51v2FGIiBoZqMQrsLNlRIUUwlWKneoHDy88GiAdCr4zQyyT2vKE3b0dw25a41ez4
	byZOLqVxEbVIhgVd9iBHDL6ZKroel5e0nyBjYCydd1tG6snrsOWAY8+3YELKNAoi
	qpuAylbslQ6Zyqu9uqBnLywOrCILwltTYlA==
X-ME-Sender: <xms:WcdDZ1W-0lIe6LfISqbGcawG3EjrxPY7YR0OYqkk2JDtfIx4QMav0Q>
    <xme:WcdDZ1mEDQ-NAKs_a0UG11aNosI5ybATcShQiL1UsD0ytbAEh8c7-7QFe7wf5S1nS
    mj2FHpQ8lYVIdyZAQ>
X-ME-Received: <xmr:WcdDZxaoFbXmrq9AKMHpaUH9ST1jDLRln1P87m2gnIqmptoX-KtnxDBZieGprp5qL14vFtmXjQYveabCzEWqlfrdiCYJx-IYWNnCyr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:WcdDZ4XBZ9xxsS6P8d5yUXuziwnUtKCH6ibZyetP0GA62--XHPBObg>
    <xmx:WcdDZ_mn6ghg8ecB_Fxm6p-RRT1Mlf91lZOnILO3VzUWFVHQZAo-HA>
    <xmx:WcdDZ1fXRecQZfutgAKANAvgmxygklg8Enrzcb7jI8F9Rg-KWezYig>
    <xmx:WcdDZ5FrBqEAov3qcHbmJbgbPHCntF_69j6txUpt-_QPzogjrhWvZQ>
    <xmx:WcdDZ9dtbLZIASymxlypk7PI3qDOfx0xHQqC8VqTVeb5JdVi7-eXKzdC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 19:39:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
In-Reply-To: <20241122180144.523048-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Fri, 22 Nov 2024 10:01:44 -0800")
References: <20241122180144.523048-1-jonathantanmy@google.com>
Date: Mon, 25 Nov 2024 09:39:51 +0900
Message-ID: <xmqqjzcs87u0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> It is sad that it is a (probably unfixable) flaw in the "promisor
>> object" concept that the "promisor object"-ness of blobA depends on
>> the lazy-fetch status of treeA.  This is not merely a test failure,
>> but it would cause blobA pruned if such a lazy fetch happens in the
>> wild and then "git gc" triggers, no?  
>
> Right now, it won't be pruned since we never prune promisor objects
> (we just concatenate all of them into one file).

Sorry, but I am lost.  In the scenario discussed, you have two
commits A and B with their trees and blobs.  You initially only have
commit A because the partial clone is done with "tree:0".  Then you
fetch commit B (A's child), tree B in non-delta form, and blob B
contained within tree B.  Due to the tweak in the name hash
function, we do not know of tree A (we used to learn about it
because tree B was sent as a delta against it with the old name
hash).  If blob B was sent as a delta against blob A, lazy fetch
would later materialize blob A even if you do not still have tree A,
no?

I thought the story was that we would not know who refers to blobA
when treeA hasn't been lazily fetched, hence we cannot tell if blobA
is a "promisor object" to begin with, no?

The blob in such a scenario may be reclaimed by GC and we may still
be able to refetch from the promisor, so it may not be the end of
the world, but feels suboptimal.

