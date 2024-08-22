Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37E1CC17A
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364633; cv=none; b=fKK1nl2fVqpfXhVQQuSw0vGnamW83yQeUi/RjqwyOIwaFACakbghnVhikA/RY2r6XRxSofpHLrjJyCkVKqHrLF0FLI/5iMhN8mwXM74OMMt6My9RvF358dtNTP5MzSSl3/ITqrIFy2MnP8p6GacauWq/wL20o0gwLbQcrHWc59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364633; c=relaxed/simple;
	bh=4m2CAKx1ZzjhgrGmbrtT5RUQlHCGe2pLM8hEr+m6elM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n/l4dmDyaJLlST6kn4iEAakf80fb5pINOe0bZCb/L+0Z4xGVvsjMDCwOjMlkOfBfJm8EHJj8ihoD38BL31ooKTC28vy1VJAe47x9cEgfF4YcmoElOV32GyT2e+VPSieYRNsB4i+X77bYakkqOQvXurmMsISRJ5414jMQ2HJYXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B/ar/X0n; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B/ar/X0n"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0982C31136;
	Thu, 22 Aug 2024 18:10:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4m2CAKx1ZzjhgrGmbrtT5RUQlHCGe2pLM8hEr+
	m6elM=; b=B/ar/X0nbwxOo0GVtryO85sn/WWO4x1QNUcFBh2OJZmg/iv72OtIOG
	5M8DAdIGpof3yrSMUqxeMuzgweXthDWtWf+sLZYT7HB9Vje4wdhTR9ffIWG7x13C
	hctmFu9hxbDk6cp6dy03VzXY5TL0zxcmO/NNQz6F+kG+pg1M/RPbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 00CFB31135;
	Thu, 22 Aug 2024 18:10:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57D1C31134;
	Thu, 22 Aug 2024 18:10:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add additional trace2 regions for fetch and push
In-Reply-To: <cover.1724363615.git.steadmon@google.com> (Josh Steadmon's
	message of "Thu, 22 Aug 2024 14:57:44 -0700")
References: <cover.1723747832.git.steadmon@google.com>
	<cover.1724363615.git.steadmon@google.com>
Date: Thu, 22 Aug 2024 15:10:28 -0700
Message-ID: <xmqq1q2gqkdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 577A02F2-60D3-11EF-9168-9B0F950A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Last year at $DAYJOB we were having issues with slow
> fetches/pulls/pushes. We added some additional trace2 regions which
> helped us narrow down the issue to some server-side negotiation
> problems. We've been carrying these patches downstream ever since, but
> they might be useful to others as well.

Thanks, will queue.

