Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692846672
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fDjO0TNV"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42D0FA
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:56:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D061C328B;
	Wed, 18 Oct 2023 19:56:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fZc2QNqnniSPC1RPAQIFrWt4pEPGryiLo7UL+9
	uB9i8=; b=fDjO0TNV8DCWdbonlbF3DCjTfA/7ELQnA0TLIxYrLfMI+O6n+GILfj
	qmFv0A2y9tDx3AeKg1vtpg7pM0rRYmJtx7o2kpKSgAiG95rzRMkxG9+BQbLyFJqO
	8jQZUZWWyFzx69xGfY2KNy+QTd9jMN1dXhMvzIgmGDSxyGqq6P7b0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C6B01C328A;
	Wed, 18 Oct 2023 19:56:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D44E71C3289;
	Wed, 18 Oct 2023 19:56:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  Jeff King <peff@peff.net>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
In-Reply-To: <ZTAXyMWeQLRWcpuu@nand.local> (Taylor Blau's message of "Wed, 18
	Oct 2023 13:37:12 -0400")
References: <cover.1692654233.git.me@ttaylorr.com>
	<cover.1696969994.git.me@ttaylorr.com>
	<94552abf455c6d341a0811333ae4edb4a8cea259.1696969994.git.me@ttaylorr.com>
	<ZS5JnkybxvetTUzu@tanuki> <ZTAXyMWeQLRWcpuu@nand.local>
Date: Wed, 18 Oct 2023 16:56:08 -0700
Message-ID: <xmqqh6mnzdrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9129338-6E11-11EE-910C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 17, 2023 at 10:45:18AM +0200, Patrick Steinhardt wrote:
>> On Tue, Oct 10, 2023 at 04:33:33PM -0400, Taylor Blau wrote:
>> > Prepare for the 'read-graph' test helper to perform other tasks besides
>> > dumping high-level information about the commit-graph by extracting its
>> > main routine into a separate function.
>> >
>> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>>
>> Nit: your signoff is duplicated here. This is also still the case for
>> some of the other commits.
>
> Yeah, this is an artifact of having tossed these patches back and forth
> (originally Jonathan sent some of these, then I sent another round, then
> Jonathan, now me again). It's a little verbose, but accurately tracks
> the DCO across multiple rounds.

Well, between you and Jonathan Tan, that might be true, but my
involvement in the chain is only that I happened to have looked at
an earlier round and without doing anything else.  Even if you
refetched from my tree and based the new round on that version, it
would have been the same if you started from what you sent out
earlier without even looking at my tree.  So I do not think that
chain of DCO adds very little value by recording my sign-off there.


