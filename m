Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AA13D604
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490794; cv=none; b=NWLjjqVeFLjiX6/iVwGO0UwHE3+P0R37I12ns0l4hSrzmQDIlunhcsGmHY87pkddCnCkNBGW1+9MEIm+cJ2WkLRFNtZ9nijqo2HDcUV1lpRHKuOQTYn1AvIslT3NVD6Johv1lopqY16JWw5U4bBWjjf2QEKAxiNQ0UX0cSe7i5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490794; c=relaxed/simple;
	bh=iGRsrlnRfjitoNnn+xgPHm1h1haoh2fBBl5SrvMorsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wh1A6S0OPNcs1Wbk4ZpqsfETa+O5LpUQeshlpz/ZEtVCYdjN0rzSlT2oDIBhexMAM9LAmTSzFVI3ZYTuIqfU05sbCpfangqXS2bGZfCiWZDItrOZJ740YEvnXlFPkSqG/eDxDsnYWhhWQuf+iVfnLSMvORPhdvOUOC3JQUo8frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gKmIHZEy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gKmIHZEy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF4691F3095;
	Tue, 26 Mar 2024 18:06:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iGRsrlnRfjitoNnn+xgPHm1h1haoh2fBBl5Srv
	MorsU=; b=gKmIHZEyNz1I+tanq99N+IOqHHCcBXRbMVuuXYLnwdiowPO5gqUKMr
	etErk4a2zlDfzKhv6X4RMxb6fvbTkRzvJZhXKJywpZvGnLVPI+MBrtGI3NHubIKW
	fFcZSgXHzzrKyZGVrn8fJf7kRONBNpT5R35YaGZ0P/0ug7jzEVBvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5FFC1F3094;
	Tue, 26 Mar 2024 18:06:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 177AA1F3091;
	Tue, 26 Mar 2024 18:06:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <github@seichter.de>
Cc: rsbecker@nexbridge.com,  Dragan Simic <dsimic@manjaro.org>,  Chris Torek
 <chris.torek@gmail.com>,  git@vger.kernel.org,  "Ralph Seichter via
 GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <xmqq4jd7p1wf.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Fri, 15 Mar 2024 15:26:40 -0700")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
Date: Tue, 26 Mar 2024 15:06:29 -0700
Message-ID: <xmqqcyrg7imy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19E9B918-EBBD-11EE-B355-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Extending the previous step, this allows ...

If I am not mistaken, this topic, originating at

https://lore.kernel.org/git/pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com/

is expecting responses from you.  Can you unblock it to let us move
forward?

Thanks.
