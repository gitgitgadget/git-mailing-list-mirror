Received: from mta201a-ord.mtasv.net (mta201a-ord.mtasv.net [104.245.209.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1773F39F1
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809872; cv=none; b=o/2mcvsFrIRy3cqEn4yj4lcihfMlMh5jDTa6XAEOq+/9QmQmnDa22z93fOZfSSWMVGrDHyLdQyEu/tag/ScoeXxgaScojqZwPY5NmrjRXebCw5l04Y2w6yH+eB+EKsM3oU/ekavy1wwVFNlKEk+cBcP/CzJZB+Rgh0zxP/wtREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809872; c=relaxed/simple;
	bh=LXmgXApQC5mcBhUDA40z6fgpfscd8Bg/CwjfH2fInXU=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puDDwuiv/zmJ7KwOR7MgVxC8nC33PHOmFgaUi4QWnIbX8+ZB7BuyBAXCzei+V2cYMberZ0G+HQd6nhbK5CrMHOLorkvrynCjWmsOWxqswxMHkmgQuX+qg7V7yIs8YmItq1LWQaXjI/hGhK70GcHDNDhohOqZLMsVHsF4ndVTTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=MFeMCRnZ; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=EykwUrLW; arc=none smtp.client-ip=104.245.209.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="MFeMCRnZ";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="EykwUrLW"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=LXmgXApQC5mcBhUDA40z6fgpfscd8Bg/CwjfH2fInXU=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1788809683; x=1789414483;
	b=MFeMCRnZCo2a6bKIcRH7uy/ANGL675ID5X23x4es7F/ZVjjETa2T4/lzRbhS1kdsAaF0yqbYa
	Yl6fFyBtcz1YTutBOH6Tmhc3atauUqWrzlz+OvaxlextkLk3EdaxkxSOXjmFSpnJIS0j8jL2/2V
	195GtVpELeXtx911Kpju+dm2dW97bgj6GHNvma12SAp8Lxd8vvLPLsUyF0wo4iJ+I1pejFgqSZS
	0EHei8lz4+Z19UBL4r3Vng9VATn5bg8CJaOZofRtMgHdr3+5OU84nlJGaX8jG+jsP0Aq6ooaQFw
	YpA8Pc0a58ytoxrkZ8QcEWH2oRDfSA5KMoUCyCr+BPSQ==;
Received: from ip-172-26-13-173.us-east-2.compute.internal (172.26.13.173)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.243.94) 
  with ESMTP id 2cf7e5f6aaf311f19a72022ee233d1cd for <git@vger.kernel.org>;
  Mon, 7 Sep 2026 19:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1788809683; x=1788982483;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=LXmgXApQC5mcBhUDA40z6fgpfscd8Bg/CwjfH2fInXU=;
	b=EykwUrLWwJUQudg8rKbe0QamXohBIb6jfgvYEMNgyRVt+BYc8E+Ls1Mz6wK7UkTmFaoWHWx092j
	KhYrofz5Yihga7mXLZaECdfrQEhg/7eFSi929sx+55fiz9OE2CMXXKqbT+Kwg6SfBJyUpfmngufzP
	I+DeI/MNh1JBVtN8haM=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Mon, 07 Sep 2026 19:34:43 +0000
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Message-Id: <8fda00ab-a7ac-4ccb-95bb-9d2e28163bb7@mtasv.net>
Reply-To: domen@cachix.org
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, Junio C Hamano
	<gitster@pobox.com>, git@vger.kernel.org, Caleb White <cdwhite3@pm.me>,
 Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine
	<sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, avarab@gmail.com,
 "Alexander G . Riccio" <test35965@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <de83b791-92ae-41a1-8ecf-5abce7893998@app.fastmail.com>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net> <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> <xmqqtsp9tyu0.fsf@gitster.g> <8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net> <b10f2706-67bb-4657-8d7c-819a29dff890@mtasv.net> <de83b791-92ae-41a1-8ecf-5abce7893998@app.fastmail.com>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 8fda00ab-a7ac-4ccb-95bb-9d2e28163bb7
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.B6D8E9kSo6qbOB1BFWDIYw.XNTRxIs7FWivyWUjA62rYvpyzcpBiPYzwrriVv-p8axiHSlsrbuJ6DBs3pZ7TYwWCqAkooMAunnKiIo4WEVJDN-cGo93EldKbIl2GZQKyryUt7cJSfK9BM2DXSGvAzNKQn1v1FNf4GWQ-akpow9w-r5CTXfqQ18xF_0w-R6PMoXGAHpVT2u44ZqfiK7iPty8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-201
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

Thanks for the suggestion. An ownership ID could help tools avoid
interfering with each other's worktrees.

The case I'm trying to support has two separate participants: an IDE
or agent creates and removes worktrees, while devenv provisions and
cleans up the development environment associated with each one.

devenv doesn't own those worktrees or control the commands that create
them. It needs to observe their lifecycle regardless of which tool
invokes Git. Even if the creator supplies an ownership ID, how would
devenv learn that a worktree was added or removed?

Requiring the creator to explicitly notify devenv would bring back the
per-tool integration requirement that motivates the hook. The same
applies to worktrees created or removed directly by the user.

Pruning is another useful case: Git knows which administrative entries
it actually removes, including entries whose directories are already
gone. A hook could report each removal directly to interested tooling.

Would ownership IDs and lifecycle notifications serve complementary
purposes here?

Thanks,
Domen
