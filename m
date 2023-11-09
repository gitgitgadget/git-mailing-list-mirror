Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2DEC0
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAQZs64F"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BD2680
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:22:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1F7D1C7FF5;
	Wed,  8 Nov 2023 20:22:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5tLZeyI6t37Py316Y3mwtk+SwGkx80eM9afoDC
	yZTc8=; b=iAQZs64FI1ytzo+tQlByZo4NsinK3bH3npcNaHLZv8KtSF/2cnOQsR
	L63AzYrsXtmC36y0sGww/ugdXz8n0av3A9g1QeCru/ePFD2IFzc8Bh2kKGPniPY/
	KYXoyvh1ISPfUr4v24SDalge+BLzZ/ZwwLnvIZVbXYWvnSRccgs/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B82121C7FF4;
	Wed,  8 Nov 2023 20:22:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 200E81C7FF1;
	Wed,  8 Nov 2023 20:22:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
In-Reply-To: <898d3850-b0ca-485e-9489-320eee3121e4@github.com> (Victoria Dye's
	message of "Wed, 8 Nov 2023 10:02:55 -0800")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
	<ZUoWWo7IEKsiSx-C@tanuki>
	<cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
	<xmqq4jhx7x8l.fsf@gitster.g>
	<898d3850-b0ca-485e-9489-320eee3121e4@github.com>
Date: Thu, 09 Nov 2023 10:22:47 +0900
Message-ID: <xmqqleb73el4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7EBFFF96-7E9E-11EE-AB0E-25B3960A682E-77302942!pb-smtp2.pobox.com

Victoria Dye <vdye@github.com> writes:

> I can (and would like to) deprecate the "peel once" behavior and replace it
> with "peel all", but with how long it's been around and the potential
> performance impact, such a change should probably be clearly communicated.

I've written a fairly detailed response on this about the reason why
I think that "leave a mention in the backward compatibility notes
section of the release notes" (your #1) is sufficient, but it seems
to have been lost in the ether.  I'll wait a bit and if the previous
response does not materialize, I may type it again.

But in addition to what I wrote there, there is this thread [*] from
2019 that indicates that our position is to mildly discourage
tag-to-tag in the first place.


[Reference]

* https://lore.kernel.org/git/20190404020226.GG4409@sigill.intra.peff.net/
