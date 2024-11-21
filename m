Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161E2309A2
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732149861; cv=none; b=ZOzwxDhj14bLoq8JUhOxKoB7lEoYVCcifdbZPa/Mai8cKokj9NBEVhlCmJAKfjAdVFr2680gOW0BpGXp4OK4ArXgukqOW9yZ+BcvpIrVMwhkQe4IQWPzzL0toap05J9pHJ1Y2puCMGpDiEnzqgECQllFr8nHdajw+JYZvpien2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732149861; c=relaxed/simple;
	bh=uV4oamSk8soq62TLpuUBm+t0jclwDnpQNqMABTz5mgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hd1RvLPXJF1u9IH4ASJnXzmtLoB0eFW6JwKCwmpHWX+uopp7WeDOYIUKPPlQhOKST8yOHIT1YT8l2S8haTx/QCqMEH3umVCA6AtgCGH5zpm3jlgFet8/FWhLje+M+Kx6s7jo9oRpUwbnIKMcFw75zHlPI3N62OQMrokwrMRcVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yc0sFiaV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yc0sFiaV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED1C425400E6;
	Wed, 20 Nov 2024 19:44:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 19:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732149857; x=1732236257; bh=SjIAygpHkWwv2/dCcupzQQiXA4tZjBQ+bL6
	ugjKF3vE=; b=yc0sFiaVBysn9ytWUFcQcB2fFh1ScMtxPzo+IvDrAS9CyNgrnSI
	f+oyUEhC9XE2GeFA+YcXnX4LW9tBnv4IAef1t2mDeVRhF8FtTE9AuGT7FRYCxZL8
	5SJYmG9Mouj7Xcy+AfKIi3t2MwdDz6IPD0OOfYWmyEGV3EdRYy59rJydCScBlF5D
	ext6CnpmtXEvJFXEDeUhmhhZKKTsqoPLJXE7EuKFHSft5bc+YlujHOmV3iZcNXtK
	7ww00m33GOAAeXJWrg5ayQEDPzVT5VeIGOcPqH7e2SxXBiHppIgRm0E+kZNvMRiL
	4WT+PSV6SRFdBTKkaZ1S3RqxtwaGak6v81w==
X-ME-Sender: <xms:YYI-Z0W_-JiuMbzZBs-5j3OfKV5dea6-YnydmvroZWvz66A597w9cg>
    <xme:YYI-Z4mKUw9x_OyIjR_YfWgUjrOV8qvPAG4PxWUGN14PgXdVHgFVNmO_Y5RpLfvcB
    J5BX4xZ3kxzLzLqGg>
X-ME-Received: <xmr:YYI-Z4ZqtRB600JWhP7BqsEe9dmESLOC5JSjffZ8RxYBnxhBpCCNEPq5tCOZqv3oKvnsLOBOFX1_t8Q1XBJIcszvN2iprdEvExCy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttd
    evffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YYI-ZzUrXscOK7PfY6UBQL14xDaDoohBEMUw04ygU34R6VwP7bHgcw>
    <xmx:YYI-Z-nHCYXcaYsrUkLATvJwEjU_mKhx3IDmU-m39d1ZUNbIbekDTg>
    <xmx:YYI-Z4cQeEjeNkpMv-5clw_qxWd8pNAYsHMz8Z7s7uFCXc4BPs4xUw>
    <xmx:YYI-ZwHlCXvWjBDqqA9c5dvw2tpxphyF6jrtWkbsZKm8PD3GFVTloQ>
    <xmx:YYI-Zwhg6QtarbZg9ezCO0ULPK67D-RXU54nSPeJwguKXT2GY1ZkLk4q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 19:44:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
In-Reply-To: <Zz4Q+2X3wXhLO6FE@nand.local> (Taylor Blau's message of "Wed, 20
	Nov 2024 11:40:27 -0500")
References: <xmqqo72ai929.fsf@gitster.g> <Zz4Q+2X3wXhLO6FE@nand.local>
Date: Thu, 21 Nov 2024 09:44:15 +0900
Message-ID: <xmqq5xohh0v4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 20, 2024 at 05:49:34PM +0900, Junio C Hamano wrote:
>> * tb/incremental-midx-part-2 (2024-11-20) 15 commits
>>  - midx: implement writing incremental MIDX bitmaps
>>  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>>  - pack-bitmap.c: keep track of each layer's type bitmaps
>>  - ewah: implement `struct ewah_or_iterator`
>>  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>>  - pack-bitmap.c: compute disk-usage with incremental MIDXs
>>  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>>  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>>  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>>  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>>  - pack-bitmap.c: open and store incremental bitmap layers
>>  - pack-revindex: prepare for incremental MIDX bitmaps
>>  - Documentation: describe incremental MIDX bitmaps
>>  - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
>>  - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
>>
>>  Incrementally updating multi-pack index files.
>>
>>  Needs review.
>>  source: <cover.1732054032.git.me@ttaylorr.com>
>
> Sorry for not making clearer that I had changed the base to current
> 'master' for this topic, so these two merges should no longer be
> necessary.

Yeah, I know (see my other message on the topic). I just didn't see
a reason to rebase and keeping the same base is slighly easier to
compare the two iterations, with and without range-diff.

> One topic I did not see is [1], which appeared not to be picked up in
> this or the last cycle. That topic has been reviewed and should be in
> good shape. I think the thread died down after agreeing on some
> potentially interesting future improvements we could make, but I don't
> think there were any outstanding issues with the current patches.
> ...
> [1]: https://lore.kernel.org/git/cover.1730833506.git.me@ttaylorr.com/

