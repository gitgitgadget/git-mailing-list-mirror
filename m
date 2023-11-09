Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0830CE4
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZuH7wzZ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939B4220
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:56:16 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF08D1CC832;
	Thu,  9 Nov 2023 17:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ceUdJoD0MDAg1vVXJYXczUavGlt9BX93XIfH6G
	fzmRM=; b=QZuH7wzZgRMWKwlPEJRXJZqKVNEOx78zIeVOKXl5t9xicLGZFAqjSS
	/e9zXZxj/VMr+dnFBxstpZqOSQasZwaPR7HQxHDV/UWnl2OphTUrYkAAconSglhx
	e9ef2bA0Ow9lXA1dCMcelR9McXWzgAExavP31yhXgQCusy3raMzGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3F301CC831;
	Thu,  9 Nov 2023 17:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 251811CC82E;
	Thu,  9 Nov 2023 17:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
In-Reply-To: <20231109184843.GC2711684@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Nov 2023 13:48:43 -0500")
References: <cover.1699526999.git.ps@pks.im>
	<c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
	<xmqqpm0jyx02.fsf@gitster.g>
	<20231109184843.GC2711684@coredump.intra.peff.net>
Date: Fri, 10 Nov 2023 07:56:14 +0900
Message-ID: <xmqqh6luzgc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2F8B4D9E-7F53-11EE-802D-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> But IMHO it is worth getting rid of all -o/-a regardless. Even
> non-ambiguous cases make reasoning about the code harder, and we don't
> want to encourage people to think they're OK to use.

You're 100% correct.  "We do not have to worry about it" is a very
strong incentive to go after.
>
>> I do not need a subshell for grouping, either.  Plain {} should do
>> (but you may need a LF or semicolon after the statement)..
>
> This I definitely agree with. :)

;-).
