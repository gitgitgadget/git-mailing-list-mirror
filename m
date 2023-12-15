Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96F2574
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2XgpLY8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E7B61D4E16;
	Thu, 14 Dec 2023 19:40:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0DrktMvhqyu3qclK/I14rYn1ObXfMhQHaafExr
	jfFYk=; b=s2XgpLY8z7cUs6vqv8L8JIlqwMsmDKuu8LDg/5TNPmHp+hv4V+cVzg
	mY56fRNRwOgVnpEmT5LBQIjS9gTBVfRzxXuVkeXPoHwPkOBlqLfv0kq/9PdzrcjR
	9u78zK9gRXNV5P05BosYz7Y6flCKzulOi4nERKG9m5xoalPFWGBI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 487E41D4E14;
	Thu, 14 Dec 2023 19:40:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5C7E1D4E13;
	Thu, 14 Dec 2023 19:40:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
In-Reply-To: <xmqqbkasnxba.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	14 Dec 2023 16:06:49 -0800")
References: <cover.1701198172.git.me@ttaylorr.com>
	<cover.1702592603.git.me@ttaylorr.com> <xmqqbkasnxba.fsf@gitster.g>
Date: Thu, 14 Dec 2023 16:40:40 -0800
Message-ID: <xmqq7clgnvqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9323D9AC-9AE2-11EE-8CA2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked into the details yet, but it seems that
> t5309-pack-delta-cycles.sh fails under
>
>     $ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true make -j16 test

Hmph, this seems to be elusive.  I tried it again and then it did
not fail this time.
