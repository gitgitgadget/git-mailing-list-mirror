Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB037F8AE
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231667; cv=none; b=TzDcLtvnR5i066LQminDaYVohsmS/n//jKoygGAtFl36vB7VaUSvxly2dSqXsGqAw01N/2gxv5c3i4K8qHOX3tC6TyNHIp1VG0GP0ilvXJzacPdrNDpqC/JeKs1ypF1IgiWtQgdxnWD42pr/hoz9GsSMpel0hoC9EmcxoT1lx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231667; c=relaxed/simple;
	bh=mmXy3yeOJLiVx4bqaADPAZyRJ0s4nHotMbw8/UNdvUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1ssZ7A0KROfqdtQfklRZIpR6CPzktIchIYUMZh9JNB/VY/+5pehX5NrdgKwvuRxqMTAqqssY/Mag3V1u6MPnFAugLc9yNBCwaW2mH5TZ+OziQocnPI25JxLAJ9DkXmV96RLidSCsaL51fDgbu1ssMVwCY9gNwb0VD0U3X21v24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=KR7fq7O0; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="KR7fq7O0"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 54E423F4E4;
	Sun, 26 Apr 2026 21:21:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W1rwT2l7ZRYI; Sun, 26 Apr 2026 21:21:58 +0200 (CEST)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B407C3F3DA;
	Sun, 26 Apr 2026 21:21:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DFAFB0A4E;
	Sun, 26 Apr 2026 21:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1777231145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mmXy3yeOJLiVx4bqaADPAZyRJ0s4nHotMbw8/UNdvUg=;
	b=KR7fq7O0DKchKBIXsijmRHC6GxjxQ1aHNgi5lcHNNNoCXK3ouoTEku1HBpUNArdDM5iaMu
	M2XyKMQ3UT2J0tdJRyWRYCbNC8XrrsVJTVVY1R8O7n7M6UKA/p05leOJQ2eU3bRZSc6B8J
	2S3ABOmDXmEuLkuWKqfJ1qHRWMu3zOxoo1Z0c2W3f3Le0nOZgd0vgWz68NaH0nB8vjy3pB
	5RjWzvj5h5+LvD/gQv+nyZmlCorZtHuEijlf1u30Sy8VWLuTcUOEIAQo5TP2XxC9PHSHVp
	HnVx5x61Phm+yGXWyl8oXLdHj+4FULLniwQiZ9N48RuSl+zgtakVO0uI39qqpg==
Message-ID: <4a130a23-fa32-460b-a338-409d85d18166@jontes.page>
Date: Sun, 26 Apr 2026 21:21:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsch@web.de,
 michael.grossfeld@amd.com
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page> <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
 <20260425232916.GA29816@coredump.intra.peff.net>
Content-Language: en-US
From: Jonatan Holmgren <jonatan@jontes.page>
In-Reply-To: <20260425232916.GA29816@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

I see the appeal of the overlapping-namespace approach for maximum compat.

My hesitation is that it introduces a config model where a single key
(`alias.foo.bar`) no longer has a clear interpretation, but instead is
implicitly treated as both a historical alias and structured data. That
feels harder to reason about and document.

For the regression, I would lean toward a narrower compatibility rule:
restore dotted aliases except where they collide with explicitly
recognized structured keys (currently `command`). That keeps behavior
predictable while still fixing the breakage.

If we want to grow metadata in the future, it might be better to make
that expansion explicit at that point rather than baking in ambiguity
now.

I think the worst outcome from this thread would be moving the
new alias syntax into a different namespace entirely (e.g., `nalias`).
If namespace cleanliness is the priority, reserving `command` and
`alias-*` still seems like the best path forward to me.

One question: do we consider the historical dotted aliases something we
want to preserve indefinitely, or just something to transition away from?
My assumption has been that they were an accidental side-effect of the
config parsing rather than a designed feature, but I agree they are now
part of existing workflows and need to be handled carefully.
