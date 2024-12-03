Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0E1F95A
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200751; cv=none; b=CpTgEfFLo3cnM7UNsPRN95cXunFX2VZElIvzsvNifawYlj78tgnIJg+sNBLIaq6iYAF2oh5+6XC7EBK2VYo1b0Bq2U/SD6Msy548S7xDCGr37ubiV2GC7k416n1y+voScGxaZPl5vQpw9DMekgzWpx6KiGl6yKLRA+zgiv7t6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200751; c=relaxed/simple;
	bh=Gr6yWHZnRm0fgx1ilu6JhWInmgUASJoLVBXi78djugs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHp1XqX0nwvf6Fl4vWKik8+mNTCvdcWrzAjrBO+f5563jlaIjswCJwjU3eUdCIQP8Z5lPd0R2kh3S0Ksa13x+Z4DTZSfYwKCtHStGw7XOgTIJpjS7vJGqkdpOB3xsXkiIfiU4ib3GBIPCEnvY+/Nl1PiCLoibxQaS2A10QXd7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPglLlEH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPglLlEH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 95407114010B;
	Mon,  2 Dec 2024 23:39:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 23:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733200748; x=1733287148; bh=uKYEukEJbLYpUSejxIbDV+4/tfUoC/mceGc
	65+T8B2g=; b=JPglLlEHTgzjvDvHEaDxHv++qhjOGNyV2PBubeKU0p7IgeN3DM3
	jISO4jMsmRsxmvWa6gjTAuR4yE5k+r1vPq+L6MlSTYcr1Et2doDUUml+zG+BKOgn
	gHX9FC1rSCLKp/LDSpTr3v09Eu97BIQqoOFPMca8fWulIFSreUPdx6gHEKLnV9kR
	grjZ7Qvwk+CjuMs5JsGVl7u5UZaNA1kWv/6Od6Z21JgE8FHwtD3z8diewHjDQzXN
	3DL+X/ARtVMMLQ0MVMGaYDmay40qhwvsQHcq00fQ4OFZcKGR3Fe0H1gk+M+h3JK1
	ia2kaiIYcljRXdRuMdTQByAJdgG4K/+fU5w==
X-ME-Sender: <xms:bItOZ7pXPfn9H2_YVmKhnlpnuAnQFEUzOte1FRFRW_1ZL-eFnHscxA>
    <xme:bItOZ1qSXa-V3phACXwioWtEpvD6efmnDxkR-FLycL7GL0datam8pjU20Q3Em7GeI
    mM0ZJvERs2DfTVdGQ>
X-ME-Received: <xmr:bItOZ4OErKoDYekaUTAA_5KZt7g2_18OM7CVfvciZ095tc91-JgiT_46kr526149t25WYqg5XD4UhKzo3a0huoK9RF2x834BYw6KPL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bItOZ-6JKbIPfzE_z8HkBTcmLbzeLuZxuY3qlpCMBgDqBa2bS2ONUw>
    <xmx:bItOZ65SR_Vs9wu2EerokF7EBqDfplvg7fV61wgCjyjNMIeR4UCbGA>
    <xmx:bItOZ2gk9SBFoVEGH7LGj0xjPnOBHZ1UJc2ZUrAwkf5aHmc-ig3GRg>
    <xmx:bItOZ86Bk3mJ5o6-YMfLy2m-UIBnvh2egl1t2VLq1URbJ_LfGYaMcg>
    <xmx:bItOZ108WlPFg5_TWV-lHIP7P-Cu-cRmmcv9_ZrJMsLmOUfBJM_eAJ59>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:39:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 0/3] Performance improvements for repacking non-promisor
 objects
In-Reply-To: <xmqqmshde6sl.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	03 Dec 2024 13:20:42 +0900")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<xmqqr06pe6vj.fsf@gitster.g> <xmqqmshde6sl.fsf@gitster.g>
Date: Tue, 03 Dec 2024 13:39:06 +0900
Message-ID: <xmqqed2pe5xx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When merged to 'seen', this seems to break quite a many tests, all
>> related to "pack".
>>
>> I haven't tried running tests on the topic stand-alone.
>
> Ah, sorry for a false alarm.  The breakage may be coming from some
> other topic.  Haven't figured out which one yet.

Sorry for a double false alarm.  The breakages are due to this
topic.  These do not break without this topic in 'seen', and do
break with this topic in 'seen'.
