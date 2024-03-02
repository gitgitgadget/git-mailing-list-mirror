Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26C1E87C
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413706; cv=none; b=t2UKzE7vu9vMcawOwMBwpx+r0lgQuU+wJrG8YAoA9kaTFLzQTecX8T1ocaWDSEDS9cAEm5UENVX6UMCr5oSuTgwNOea1FIsDNSQ1f7/bbzv6wolRJrHVKsX6AYLmb+YSB/CNKv3YMxfaFOJCgKkf0a8OaxoLbL2G8Y+lypzs43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413706; c=relaxed/simple;
	bh=qnZciaG2opRHxmXKctSc1HGOoDgorKNxzWZuoReufEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqpoReOXKfPGcFckjY1HKGihBXZtVrSO5p2WJYvurdkmDy6tmvjA5MrisHeyats9hAxm8Fs7qpMiQ287eVY7Bp+caDGMNFk7K9YyZtTIge/piGwN09MGArkSVvBATzmNVSXbamqTxnt0V6QEtRxIRL5OPUZe0PjSGLWycIyDu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iCRITBLO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCRITBLO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 924F31E3026;
	Sat,  2 Mar 2024 16:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qnZciaG2opRHxmXKctSc1HGOoDgorKNxzWZuoR
	eufEE=; b=iCRITBLOzjD03KPQ60NSyRL8BeVaXS45js1Zk1eOmlDGP9MbYlFBpL
	A1v6ORRtVprqnWiYzGLSSiDav4hwlkfZcjhRlSNX+3/D88/Bey45+DDZhCcr4J0m
	/KeIrUvYxez3k3KMR0JteLVb0aUpDLwpGHtotCO4xDx2E+FF1Byo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89CC61E3025;
	Sat,  2 Mar 2024 16:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFF841E3024;
	Sat,  2 Mar 2024 16:08:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: admin@inferencium.net
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Modernise .gitconfig Signing Block Name
In-Reply-To: <KfyeAjLLXySd6IEKwEmOvrDqtBIhoCRPon7r8IuUIwPbUhlf8XR0CCmqP3Y5D-8hur57_SFQPqwk0xOA7p0h6xqw48ZMdNbzTBPN2hh9Ph4=@inferencium.net>
	(admin@inferencium.net's message of "Sat, 02 Mar 2024 20:01:26 +0000")
References: <KfyeAjLLXySd6IEKwEmOvrDqtBIhoCRPon7r8IuUIwPbUhlf8XR0CCmqP3Y5D-8hur57_SFQPqwk0xOA7p0h6xqw48ZMdNbzTBPN2hh9Ph4=@inferencium.net>
Date: Sat, 02 Mar 2024 13:08:21 -0800
Message-ID: <xmqqsf18wddm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00EB1D36-D8D9-11EE-BBB2-25B3960A682E-77302942!pb-smtp2.pobox.com

admin@inferencium.net writes:

> For backwards compatibility, `[gpg]` can also be allowed as an
> alias for the new name. The default could also be `format = gpg`,
> as it's still the most widely-used signing method.

Sounds good.  Patches welcome.

Thanks.
