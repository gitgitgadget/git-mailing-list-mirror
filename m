Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFE145B03
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295648; cv=none; b=bpHLqUQtlPM1ay9Q0WY89WUAerJPUFuUk9g1SfZDL7K4xx8boi1K5hFmMehaiwvs7Lh/m81vbzPAclWWP4DZwzhNCgQEQhwVwcPxEcYc7kMMsWUgY7fHRF0pmByf3RRubfqCFBckNVhH/qSEZ58NKcDmGLk/9xS3Yv9LiVJ+Yw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295648; c=relaxed/simple;
	bh=3LdlgachQJMW4Kao3sSjcWjlm+171wI0nYu4WSXcDX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/M/M8tpZFXoB+O2ehi6x9qiJYpj49xXyQ4l6/w3PEdwDk/LFODQnMBOKzkxKDYFro9C9n7+E1my2zSYDEASZP8tqMxxzDHDx7PVNxR4RZDpdWHMGWCoXmhsiR0qSbOQPqR2aHcTpbePUCFQlAx8oai6BeC+SuU8ndZmb/GF6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X60rahj1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X60rahj1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BEF4F1A421;
	Thu, 13 Jun 2024 12:20:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3LdlgachQJMW4Kao3sSjcWjlm+171wI0nYu4WS
	XcDX8=; b=X60rahj1NIiwIW9W2CYv7tXc/SJVTk7QSxsJd06v2HlvJ+DLe6FFhs
	eLJy0sPmC8033BJTdjCh9VkxGfSESSVOic9QPDSvhBagPszkWq7wBT4/zqrjXY5G
	+NwR97RbCaRuKfGpm7aOqBlG1FlRX7wd+F+Ji6AHASiV1RIgrGYq8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B78411A420;
	Thu, 13 Jun 2024 12:20:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 305741A41F;
	Thu, 13 Jun 2024 12:20:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #04; Wed, 12)
In-Reply-To: <9f4aa9cc-fa63-4137-acba-14e41ea8fe78@gmail.com> (Phillip Wood's
	message of "Thu, 13 Jun 2024 14:35:08 +0100")
References: <xmqqcyolofar.fsf@gitster.g>
	<9f4aa9cc-fa63-4137-acba-14e41ea8fe78@gmail.com>
Date: Thu, 13 Jun 2024 09:20:41 -0700
Message-ID: <xmqqh6dwn7ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E13C86E6-29A0-11EF-98D0-965B910A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think this comment is out of date. c.f. <xmqq7cfbp6pb.fsf@gitster.g>
> where you said
>
>     Thanks, will replace.  Let's see if we see comments from
>     others and then mark it for 'next' soonish.
>
> It has been a while and no one has commented so maybe it is time to
> merge this to 'next'?

Yup, my mistake that this fell through the cracks.

Will mark it for 'next'.

Thanks.
