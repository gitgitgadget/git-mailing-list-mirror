Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB821A17
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sfcLb41t"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B5B10C0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:06:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF5831BF9E9;
	Mon, 23 Oct 2023 15:06:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gtJau6510144nuZKMPpHWcSVGeAIoKH/Hud4Qi
	FTFDY=; b=sfcLb41tNeHgqO9j0Y+9Q32IWqv3FKff4HMqjvXJZbCXLn0DQWApWn
	Zua+n/uKla5Zerbh0TWbT2Sk3s8qrt34D53kc+31R9oQwW6b2cGxMEg5knDe9Kav
	oHXWC+6oTydj3S/EsW82w9L/5fENMKZ1ObnI2QAEeT49ZDd7072xs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B795B1BF9E8;
	Mon, 23 Oct 2023 15:06:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A3831BF9E7;
	Mon, 23 Oct 2023 15:06:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 02/11] t: allow skipping expected object ID in
 `ref-store update-ref`
In-Reply-To: <ZTZ7-oMqek8kQqhJ@tanuki> (Patrick Steinhardt's message of "Mon,
	23 Oct 2023 15:58:18 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<1f615d62f99e9ab47d37500f05b29615bafffba2.1697607222.git.ps@pks.im>
	<xmqqil73ud5j.fsf@gitster.g> <ZTZ7-oMqek8kQqhJ@tanuki>
Date: Mon, 23 Oct 2023 12:06:14 -0700
Message-ID: <xmqq7cndnopl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D0D8C36-71D7-11EE-A0D3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Good.
>> 
>> Even better would be to make the old one optional, though.
>
> I was also a bit torn when writing this. We could of course make the
> behaviour conditional on whether `argc` is 4 or 5. But I wasn't quite
> sure how important it is to provide a nice UI for this test helper, and
> we don't have `argc` readily available. It's not hard to count them
> manually, but until now I was under the impression that the test helpers
> only need to be "good enough".

Yup, good enough would probably be good enough in this case, I agree
;-)
