Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF731B7F4
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813447; cv=none; b=NlPvFOA81wmV4g1I7A8lCDX8Fci7rFtQYYwOwA2CQLvSjZAr5bk84f8kzw/B3yfz+6+sGqKs0L75nQS4hGWCB6qS4T303t4JTCf2HqUhx0lgLDy14oFoQqWmnoisAeebTieltShvDzcyLLsXh8aanE/XAgfFxt6+Hyq6vAyqSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813447; c=relaxed/simple;
	bh=BQlzIwkarYnts1m24tXFhJzLG3veKqo1+jP1N090QJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n/F6XtxbEI4guqwumrgEdpAPUtKIgIby+Hek5KxiJnXd/VaomMh1hrsLs4gkvl9tOFDTABAG9bOIQIKnlcl8IfJFtXCwlBlm2wAmX8LgUohGNf9gEPArSKYoW4WXx1e4QdPngP/MAxK/lafnwJKfW4djbJaFOnpmvYI6e7FnHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=OIsAMlfq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="OIsAMlfq"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUEYQ-00CRWL-BQ; Wed, 25 Jun 2025 03:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=FfuORQhCJaa1CETTao5hYCFds6BY+5LHXNrMmcrX1tg=; b=OIsAMlfqpGh7sF3LdHagGItuq8
	VM1PH30TVdDkZ4pH9lwOc6c6dWT2s+ofPbTdojUcaSe+FQmT/hh1Tak5TYsg2gNeO8JuIPsCx9j39
	7lGWPRMLWeq/skO39NM0FwqL2eVnYEV2OUbZeN6BdR4nuWBVO/81p/xIRcFMf/Jp0JZa4cslcto0P
	2fUcX6TPUNUL8YilpKhhSOqUWRg1AB7wUI3JEA+QfvoEb7wrBLbKdKno37DUrPTbhZp1+LZGvTjXo
	D1ZnOlv1AsheALFevjrghi1uvckevIw9lEpLuM+u++8AryGKx1LcCpREtUcsxYwjkQiS5uYRWdVTg
	8B2/3FdA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUEYP-0006Gz-PQ; Wed, 25 Jun 2025 03:03:57 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUEYF-001kOR-Ht; Wed, 25 Jun 2025 03:03:48 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,   Andreas Schwab <schwab@linux-m68k.org>,   "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/3] git-credential-netrc: better symbolic port names
 support
In-Reply-To: <xmqqikkkzmzr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Jun 2025 17:24:56 -0700")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250624014857.3748-1-maxim@guixotic.coop>
	<xmqqecv915y7.fsf@gitster.g>
	<87ikkkk84f.fsf@terra.mail-host-address-is-not-set>
	<xmqqikkkzmzr.fsf@gitster.g>
Date: Wed, 25 Jun 2025 10:03:42 +0900
Message-ID: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

[...]

>>> v2 and this iteration both have all messages set as replies to a
>>> single message in the old thread.
>>>
>>> Please make sure in your future submissions:
>>>
>>>  - [0/n] is a reply to [0/m] of the previous iteration.
>>>
>>>  - [1/n], [2/n], ... and [n/n] are all replies to [0/n] of the same
>>>    iteration.
>>
>> OK. This means I need to submit with 'git send-email' in two steps,
>> right?
>
> I do not think so.  Find description of the "--in-reply-to" option
> in the documentation, and read about interactions with "--thread"
> and "--no-chain-reply-to" there?
>
>     So for example when `--thread` and `--no-chain-reply-to` are specified, the
>     second and subsequent patches will be replies to the first one like in the
>     illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
>
>       [PATCH 0/2] Here is what I did...
>         [PATCH 1/2] Clean up and tests
>         [PATCH 2/2] Implementation
>         [PATCH v2 0/3] Here is a reroll
>           [PATCH v2 1/3] Clean up
>           [PATCH v2 2/3] New tests
>           [PATCH v2 3/3] Implementation

OK, so as a self-note; this is the default behavior (--thread and
--no-chain-reply-to) and the thing I got wrong was that --in-reply-to
should be set to the Message-ID of the previous revision's cover letter
(in my recent submissions I had kept the message ID of the original cover
letter instead). That's also explained in
documentation/myfirstcontribution.adoc.

I'll now send a v4 fixing the white space issue, making sure to
--in-reply-to=$message-id-of-v3-cover-letter.

-- 
Thanks,
Maxim
