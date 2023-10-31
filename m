Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F016418
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MjXKQ/mO"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EBBBD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:57:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C3CE61F15E;
	Tue, 31 Oct 2023 19:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IodSjOX40osyQ9fSirtlqAQsr+bcPvl3NhC5c8
	jzpcY=; b=MjXKQ/mOqxK1WuQYG0WXU00S3w4iaDwyZMZoaQDe8D8+e8xrllBG4W
	v7TdpkdLiI14SgCSzOBMa5MlDa+7n62tr8KFpPq4/039ZBPFd4ooNkzmWm1AbRFK
	E2HU2EHpmZ///ZM9ilAOsFaGHI1Lm6l3g81TTCK/sz/975FzwiE4E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BBEE91F15D;
	Tue, 31 Oct 2023 19:57:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B8A31F15C;
	Tue, 31 Oct 2023 19:57:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
In-Reply-To: <ZUFSqRYXhwsWC+EA@nand.local> (Taylor Blau's message of "Tue, 31
	Oct 2023 15:16:57 -0400")
References: <cover.1698060036.git.ps@pks.im> <cover.1698736363.git.ps@pks.im>
	<ZUFSqRYXhwsWC+EA@nand.local>
Date: Wed, 01 Nov 2023 08:57:01 +0900
Message-ID: <xmqqh6m6z6pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 305559A6-7849-11EE-8AFC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 31, 2023 at 08:16:09AM +0100, Patrick Steinhardt wrote:
>> Patrick Steinhardt (2):
>>   commit-graph: introduce envvar to disable commit existence checks
>>   commit: detect commits that exist in commit-graph but not in the ODB
>>
>>  Documentation/git.txt   | 10 +++++++++
>>  commit-graph.c          |  6 +++++-
>>  commit-graph.h          |  6 ++++++
>>  commit.c                | 16 +++++++++++++-
>>  t/t5318-commit-graph.sh | 48 +++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 84 insertions(+), 2 deletions(-)
>>
>> Range-diff against v2:
>
> Thanks, the range-diff here looks exactly as expected. Thanks for
> working on this, this version LGTM.

OK, I'd like a version as incremental to v2 (since it already is in
'next') that results in the same tree state as v3 then.

Thanks for working on it, and reviewing it.

