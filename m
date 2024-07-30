Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1EE1AA3FF
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374679; cv=none; b=FvdV5FlefVn+EKenPeunSQIkca5EN4n5yuJUiZ9A1jZd0khUICX0FgkUdw2M4LSdHjw6Fvc4iuQxNmP2pe1iMtKNqRwAIJS62SCAWKKkmev0G1pQMtFlexUOcgloCfgGxsT2Vu/0OXqtlIYpQC0RaTFhmYyiY4j+s4a5JkCIkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374679; c=relaxed/simple;
	bh=Ws26fgUGx4I4Zehu1eod133VvUUC1a05JlekYJLX1TQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ozdi+x6rFtqsiLiYhaldyNFucY1RtWk1jB9owG6bgKEWFRTn0OdBLDh9Qh3b+kBRXLJOTIFGlShsuSv42fmaOk2SW+1Zcw2om/bbnX4tOiPniaGqFueyJI+UaDM1K5kXMvwSE6BL3LdQlNW9wg03cbLXzWxHYx14WXT2L1LQdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cvfHdviL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvfHdviL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B1B301C14A;
	Tue, 30 Jul 2024 17:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ws26fgUGx4I4Zehu1eod133VvUUC1a05JlekYJ
	LX1TQ=; b=cvfHdviLnD+unXYo+z9spfq+O8hb2J0F+zI4eVxQpgF7Lsa6xdAUWG
	43ffWczrZWYYx3wPs/QA9bEZas1jHHU2lY21bdLgWm0xLjx2P91Aad8ZJDExd8as
	mBmk8T7KTNFm6Mw8879w6wdhV46iXuLoxUlSLeVbMGTwplU+1AktE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AA6791C149;
	Tue, 30 Jul 2024 17:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEE7D1C148;
	Tue, 30 Jul 2024 17:24:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v4] Documentation: add platform support policy
In-Reply-To: <CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com>
	(Emily Shaffer's message of "Tue, 30 Jul 2024 13:41:30 -0700")
References: <20240730175448.1727373-1-emilyshaffer@google.com>
	<xmqq7cd2bs0q.fsf@gitster.g>
	<CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com>
Date: Tue, 30 Jul 2024 14:24:32 -0700
Message-ID: <xmqqttg6a7zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D85F43C-4EBA-11EF-8A3B-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

>> > +Note that this document is about maintaining existing support for a platform
>> > +that has generally worked in the past; for adding support to a platform which
>> > +doesn't generally work with Git, the stakeholders for that platform are expected
>> > +to do the bulk of that work themselves. We will consider such patches if they
>> > +don't make life harder for other supported platforms, and you may well find a
>> > +contributor interested in working on that support, but the Git community as a
>> > +whole doesn't feel an obligation to perform such work.
>>
>> The part after "... and you may well find" reads a bit muddy.  I
>> couldn't tell if it is talking about the initial port, or continued
>> support, or both.
>> ...
> I like that message, but what I was trying to say with that sentence
> was "if you get lucky, some volunteer might want to help you with the
> initial port".

FWIW, I do not quite like that message; I agree that it would be
good to tell them that they may not entirely be on their own, if
they ask nicely, but no promises ;-).

> It seems worth at least pointing out that that would be
> the exception, not the rule, but I probably already do that well
> enough with the previous sentence ("the platform stakeholders are
> expected to do the bulk of the work"). Let me reword the last
> sentence, then:
>
> "We will consider patches that port a new platform if they don't make
> life harder for other support platforms or for Git contributors. Some
> Git contributors may volunteer to help with the initial or continued
> support, but that is not a given. Support work which is too intrusive
> or difficult for the project to maintain may still not be accepted."

OK, at least that clarifies the point I was puzzled about.
