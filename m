Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B813D885
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679110; cv=none; b=fszYKdX/vEKypY0VTlLEjZJZ1b3GXiKCKbRkRUfrC1kehHKt5ctRh5SBWNmRVwmW0o9EZ4sDiwrJygnN/F52UK3ordE7o/wsq0nmwfglx7TVYIolaQFsFyZ7B8j+JekyZsszh/kaeml2ubFSBWkP2U1kwkP2C9213pBFGNoSAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679110; c=relaxed/simple;
	bh=DrMC9JDSqFHGloXGHP98sMNv0Y3tZSBlHOXOcfp0W4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EL71eLs9ViSjvMngRXviE+4mVE5dZ7pczHEB5vwN91s3s7WGnUKR/U2sFaQddzJCIIU505bmCf5LkXz0FeR+fPyhIbG6TPosCh5KeW5baBIL0bFy9sUr8dWFhFzzDTaDb+SsWU3vGXKPubZhPXecfSMuA8CaarOXTHRfmzr6j18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eYpnZBBI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eYpnZBBI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EBC51E41AF;
	Tue,  9 Apr 2024 12:11:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DrMC9JDSqFHGloXGHP98sMNv0Y3tZSBlHOXOcf
	p0W4Y=; b=eYpnZBBI/elRzSpZo5XGeWsA81Z9WOu92KeS+uONbVTUdCvochT/OZ
	Td4Xjk8vXmJGw2/hxN20Jptb9jA3mfiMkC/BQ2HJtgz5wFoyn+0+CxD95W+yUZs7
	evXPYlC4PlRJ3N9mrQD+n6/cigEjkQcJhxPaC55w0aEYZMuVvRl4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 368401E41AE;
	Tue,  9 Apr 2024 12:11:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB471E41AD;
	Tue,  9 Apr 2024 12:11:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Benji Fisher <benji@fisherfam.org>
Cc: git@vger.kernel.org,  nasamuffin@google.com
Subject: Re: [PATCH] MyFirstContribution: use switch for changing branches
In-Reply-To: <CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com>
	(Benji Fisher's message of "Tue, 9 Apr 2024 08:26:58 -0400")
References: <20240407212109.35131-1-benji@FisherFam.org>
	<xmqqr0ffbvjq.fsf@gitster.g>
	<CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com>
Date: Tue, 09 Apr 2024 09:11:40 -0700
Message-ID: <xmqqwmp61poj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA2FDA3A-F68B-11EE-855D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Benji Fisher <benji@fisherfam.org> writes:

> I was under the impression that the new "git switch" and "git restore"
> commands were recommended in most cases instead of "git checkout".

These two were added so that eventually we have something we can
recommend to new users, but as a pair of experimental commands, we
reserve the rights to update their UI in backward incompatible ways
(meaning: those who use them may need to retrain their fingers and
update their scripts if they used them---not that using these
Porcelain commands in scripts is a good idea to begin with).

So your justification could be

    We want to evantually be able to recommend restore/switch to new
    users, and want to take advantage of every opportunity to polish
    them.

    Because this document is not exactly for totally new users, and
    the readers are expected to be knowledgeable enough and highly
    motivated in improving git, let's have them use these
    experimental commands and report newbie-issues they found using
    them, so that we can gain more experience and chances to polish
    the command and eventually make them recommendable to new users.

Note that the "WHY?" in my response was not "I see no reason to do
this", but "You need to say why you think this is a good idea here
in the proposed commit log message".  Without your version of
reasoning, my conclusion was "I do not see a point", but with a
justification like this (there could be others---it is contributor's
job to explain why a proposed change is a good idea, not mine), I
can understand the reasoning why this change may be a good one.

Thanks.
