Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA831BD017
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733107; cv=none; b=glm9aVeCTNEw94U1queUngK/miNwQvouY6hHQS+IF2uIt71hjcZXlzXNyffZoMZ1X6dXwTqtydg12AxMbikuJWBjSE+/wd2QfXz11HLmFR+O9FRlNQo2LUjA4cI+jDYVP+eKLbzr+4qT+/tl7CAAtaPS4iKY49h7YG/D3vfLkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733107; c=relaxed/simple;
	bh=E7tmPHbU+sl5jbt4pg1Df5aNNM/lH6V64mRIoGuDttE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=omsZgoem5xQO+zIFcbbifgoZ6qRQkoVJHM/Dj/PCJbHtP56Owk0K5zTY+v9HlqMEuIwJGwqIoUPPkDZA8DKqnqdgFNzSqnm1ICQSI1BeCgpt2P+peFyNhxPgdUb1ArJbzXMfplZTDXtP/1ilkZ8CLzVv5vaXm2464K4dBVy0iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bX2vojud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUOCRM7w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bX2vojud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUOCRM7w"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 72B2013801A0
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 Nov 2024 10:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1730733103; x=1730819503; bh=Wa/CgC1ZD7riLbrzjfRbxtGGbMLdBXd/
	agueGgynREE=; b=bX2vojudjYDZBjIai7OOhKG45+FgUFSY+8w5zbWllvPRgoZc
	yHWCidexDridGvMhqHB4/8fa5Jk+aU/MlNpTHD33b1CyBoNYAos3e6u+0rycQjIw
	5VokFcMMaMe3GUUtjWTdROunmE9GGBkZxui3RLb1JqYtM1QaMDySg0m1czwmZevs
	L+ggpCB0pZlS0MYcwMD7ArivCXTsNvatFj6VKnr3ekPcKAcvPXpd7kNBWeckQRvZ
	XA/oqtZ1eXUxegQo6JrwSg69qZLWJ5VXzFPmDeIe/r4BFY7epvgO1hPKQKn65rT+
	Lk31hxZP8gwJ1LEy22VjWk/GWBK9Jp4+t4bGqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730733103; x=
	1730819503; bh=Wa/CgC1ZD7riLbrzjfRbxtGGbMLdBXd/agueGgynREE=; b=W
	UOCRM7wXO2d7M3oCeeaTf+SRKQFcADHZSXvaGfMq1XbIm3XzXtB2JBETn4sMyc0O
	CGxPPuYg/DQzxcODlYiYyzGQgLn62/nfUXQ84EIqbyl3KwbGVuBqnozzzg+Jgkm1
	vYs7ExXYr07830TkTIkbD8+bSYMUmbW1sbCiKWcYxkpHxC8oXtaPuBPU/Hg/0p9w
	csYN6E8+Rxh5hcFDCURjrntZvwi4lxlgPftH7ZNIrR6PaxDi2Pb5Uqi4wMD1jFgE
	0ObsbtrvSaYORcCV90GFHl2YJCd0/oq2dJnJFiOd1y+Sr199y01QqewNEWFJczLj
	XOvRsbSc+CCMfTDrPFcUg==
X-ME-Sender: <xms:L-QoZzj5OJ4wI8vncpyOfAKgPjDwN1fBoP-4wMNXve2yVUCEZ69hBw>
    <xme:L-QoZwCJwCUM3q-8N_qk2eSkn1erIoJ19Hj5Jbn82L0VrUiXEZiE0UNe3qHTtY6zr
    IEAUgkfkGrBsNA_jg>
X-ME-Received: <xmr:L-QoZzGtcFGu1MX9zNA3d3HAisZsl4IUUlh_Y3hMDw_72rjs11lkh2Cz43ihbkplWO2d7Zz9o_2IqyXIpWoH433phVTGuZ6fs9j-Lzbb0ERlLtrHZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleejgeevgeffudejhf
    evhefhjeegkedvvdelteektdduffeijeduieduffevleefnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L-QoZwQwo1SAFBb96TdK6KdlCwIt3FS2xFctFIniauFs5x2CznthqA>
    <xmx:L-QoZwzOkp5XvU5TIZVXRKzKcZtvympQFYamN2Ho3z4QJMd8zRlF7A>
    <xmx:L-QoZ24fl0WRzNf1ehbvnIEKARn2AwhG031_-Aik8s0Uv9wo8TWweQ>
    <xmx:L-QoZ1zHmjfkWfesZBLUOaIsgfFmmUFWNzc8yVC7KfJBp17Lpv1tfQ>
    <xmx:L-QoZ9q3xssT7UpVaeJfCfZFppqjI-lEx_tjQA1noo9NRKDzaLgqU469>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c56f786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:18 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/8] refs/reftable: reuse iterators when reading refs
Message-ID: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series refactors the reftable backend to reuse reftable
iterators when reading random references. This removes the overhead of
having to recreate the iterator on every read and thus leads to better
performance and less allocation churn. It also gives us the ability to
further optimize reads by optimizing re-seeking iterators in the future.

Overall this leads to a 7% speedup when creating many refs in a
transaction, which performs many random reads. But this change also
positively impacts other usecases.

Thanks!

Patrick

Patrick Steinhardt (8):
  refs/reftable: encapsulate reftable stack
  refs/reftable: handle reloading stacks in the reftable backend
  refs/reftable: read references via `struct reftable_backend`
  refs/reftable: refactor reading symbolic refs to use reftable backend
  refs/reftable: refactor reflog expiry to use reftable backend
  reftable/stack: add mechanism to notify callers on reload
  reftable/merged: drain priority queue on reseek
  refs/reftable: reuse iterators when reading refs

 refs/reftable-backend.c          | 356 ++++++++++++++++++-------------
 reftable/merged.c                |   2 +
 reftable/reftable-stack.h        |   3 +
 reftable/reftable-writer.h       |   9 +
 reftable/stack.c                 |   9 +
 t/unit-tests/t-reftable-merged.c |  73 +++++++
 6 files changed, 308 insertions(+), 144 deletions(-)

-- 
2.47.0.229.g8f8d6eee53.dirty

