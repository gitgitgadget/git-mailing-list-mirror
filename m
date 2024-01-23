Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE91C8FD
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045705; cv=none; b=De91qDn4VouBZqfaFXNxo0iNsmhdfWzSsQV4U8z79nScuHxl5cb5IGlUXdiuZGsNfNHuzbrg3WI22IGRgZ2TqUWXlibQgL7wYub7frUAjJPioJ06a2YaoeIhsWfLLrUkDw69alHrPEhTqYSFGOSpxJQurzp3I7dXQ35CNh2AYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045705; c=relaxed/simple;
	bh=Hr9tJ4BfCl8yP8mUYGLv6ifvoae+sXaLbC0OWWiXMQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHjpg60IM+dM2N9yoQ17fVD5065WQFEWRfuOI2mDp4nH/+bozhqiS6eALB+2UdZLggVHWdTPrA6fLH+n5uQqTjvyIep2mcrQlyW0wFKIviIySlVWnit/RIpKXJ6/fYMafL+HdgoaQrzVvOONFrQneUVkTQ78BexAb0ZcTM7EUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KbMsLzI4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KbMsLzI4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33D131D23DD;
	Tue, 23 Jan 2024 16:35:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hr9tJ4BfCl8yP8mUYGLv6ifvoae+sXaLbC0OWW
	iXMQk=; b=KbMsLzI4gR8F0rVhYOyPNAAToElmv84UzG95G0Ig0MxPGBOMbY5OxA
	mSN7x+dUuJ1RhX8rKhBvrBEwWHVvXXhj9wKXEy82+Yd/5KpdSQxGSoAqTDt7fR/F
	M1HZ6lFEsIPotmlVDq/OzWiVCxspbogrLsezigPkebS53y2AZUmG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B363C1D23DA;
	Tue, 23 Jan 2024 16:35:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7D101D23D8;
	Tue, 23 Jan 2024 16:34:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  delmerico@google.com
Subject: Re: sd/negotiate-trace-fix
In-Reply-To: <ZbAu49xkxEzJ3ZkX@google.com> (Josh Steadmon's message of "Tue,
	23 Jan 2024 13:25:55 -0800")
References: <xmqqbk9ghio5.fsf@gitster.g> <ZbAu49xkxEzJ3ZkX@google.com>
Date: Tue, 23 Jan 2024 13:34:58 -0800
Message-ID: <xmqqy1cflon1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42A2CB18-BA37-11EE-A5E4-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.19 17:56, Junio C Hamano wrote:
> [snip]
>> * sd/negotiate-trace-fix (2024-01-03) 1 commit
>>  - push: region_leave trace for negotiate_using_fetch
>> 
>>  Tracing fix.
>> 
>>  Waiting for a review response.
>>  cf. <xmqqbka27zu9.fsf@gitster.g>
>>  source: <20240103224054.1940209-1-delmerico@google.com>
>
> Hi Junio,
>
> Were there other open questions you had on this series? It looks like
> Sam answered all the questions in your xmqqbka27zu9.fsf@gitster.g reply.

Thanks for a reminder.

> In your other followup you mentioned running CI with tracing enabled for
> all tests. This is something that we suggested before [1] but it was
> pretty thoroughly rejected for runtime reasons. Perhaps a more efficient
> check for region_enter/leave pairs could be an option, though.

Yeah, perhaps.  It does not sound like an issue that must block this
patch in either case.

Thanks.
